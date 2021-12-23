Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84DA647E7EA
	for <lists+linux-efi@lfdr.de>; Thu, 23 Dec 2021 20:05:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349929AbhLWTFM (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 23 Dec 2021 14:05:12 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:53876 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244871AbhLWTFM (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 23 Dec 2021 14:05:12 -0500
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from light.dominikbrodowski.net (brodo.linta [10.2.0.102])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id C31492013F8;
        Thu, 23 Dec 2021 19:05:09 +0000 (UTC)
Received: by light.dominikbrodowski.net (Postfix, from userid 1000)
        id 6BBC820D73; Thu, 23 Dec 2021 20:04:19 +0100 (CET)
Date:   Thu, 23 Dec 2021 20:04:19 +0100
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     "Jason A. Donenfeld" <jason@zx2c4.com>,
        Theodore Ts'o <tytso@mit.edu>
Cc:     Hsin-Yi Wang <hsinyi@chromium.org>,
        "Ivan T. Ivanov" <iivanov@suse.de>,
        Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v6] random: fix crash on multiple early calls to
 add_bootloader_randomness()
Message-ID: <YcTIM+MWEbMGLpRa@light.dominikbrodowski.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Currently, if CONFIG_RANDOM_TRUST_BOOTLOADER is enabled, multiple calls
to add_bootloader_randomness() are broken and can cause a NULL pointer
dereference, as noted by Ivan T. Ivanov. This is not only a hypothetical
problem, as qemu on arm64 may provide bootloader entropy via EFI and via
devicetree.

On the first call to add_hwgenerator_randomness(), crng_fast_load() is
executed, and if the seed is long enough, crng_init will be set to 1.
On subsequent calls to add_bootloader_randomness() and then to
add_hwgenerator_randomness(), crng_fast_load() will be skipped. Instead,
wait_event_interruptible() and then credit_entropy_bits() will be called.
If the entropy count for that second seed is large enough, that proceeds
to crng_reseed().

However, both wait_event_interruptible() and crng_reseed() depends
(at least in numa_crng_init()) on workqueues. Therefore, test whether
system_wq is already initialized, which is a sufficient indicator that
workqueue_init_early() has progressed far enough.

Reported-by: Ivan T. Ivanov <iivanov@suse.de>
Fixes: 18b915ac6b0a ("efi/random: Treat EFI_RNG_PROTOCOL output as bootloader randomness")
Cc: stable@vger.kernel.org
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>

---

 drivers/char/random.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

---

This is now a truly minimalist approach which tests for system_wq != NULL,
as suggested by Jason.

Another issue remains, though, but should be addressed separately: If one
trusts the randnomness provided by the bootloader, and if the primary_crng
is then seeded with 512 bits of entropy, warnings will still be emited that
unseeded randomness is used with crng_init=1.


diff --git a/drivers/char/random.c b/drivers/char/random.c
index 13c968b950c5..3c44f5ff6cc4 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -993,7 +993,10 @@ static void crng_reseed(struct crng_state *crng, struct entropy_store *r)
 	memzero_explicit(&buf, sizeof(buf));
 	WRITE_ONCE(crng->init_time, jiffies);
 	spin_unlock_irqrestore(&crng->lock, flags);
-	if (crng == &primary_crng && crng_init < 2) {
+	/* Only finalize initialization if workqueues are ready; otherwise
+	 * numa_crng_init() and other things may go wrong.
+	 */
+	if (crng == &primary_crng && crng_init < 2 && system_wq) {
 		invalidate_batched_entropy();
 		numa_crng_init();
 		crng_init = 2;
@@ -2299,7 +2302,8 @@ void add_hwgenerator_randomness(const char *buffer, size_t count,
 	 * We'll be woken up again once below random_write_wakeup_thresh,
 	 * or when the calling thread is about to terminate.
 	 */
-	wait_event_interruptible(random_write_wait, kthread_should_stop() ||
+	wait_event_interruptible(random_write_wait,
+			!system_wq || kthread_should_stop() ||
 			ENTROPY_BITS(&input_pool) <= random_write_wakeup_bits);
 	mix_pool_bytes(poolp, buffer, count);
 	credit_entropy_bits(poolp, entropy);
