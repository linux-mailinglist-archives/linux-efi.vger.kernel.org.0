Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E66B446051
	for <lists+linux-efi@lfdr.de>; Fri,  5 Nov 2021 08:54:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232068AbhKEH4j (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 5 Nov 2021 03:56:39 -0400
Received: from isilmar-4.linta.de ([136.243.71.142]:37664 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230395AbhKEH4i (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 5 Nov 2021 03:56:38 -0400
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from light.dominikbrodowski.net (brodo.linta [10.2.0.102])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id C0941201332;
        Fri,  5 Nov 2021 07:53:57 +0000 (UTC)
Received: by light.dominikbrodowski.net (Postfix, from userid 1000)
        id 5AD76204B5; Fri,  5 Nov 2021 07:04:36 +0100 (CET)
Date:   Fri, 5 Nov 2021 07:04:36 +0100
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     tytso@mit.edu
Cc:     "Ivan T. Ivanov" <iivanov@suse.de>,
        Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] random: fix crash on multiple early calls to
 add_bootloader_randomness()
Message-ID: <YYTJdLuuFAShnblb@light.dominikbrodowski.net>
References: <20211012082708.121931-1-iivanov@suse.de>
 <YWVKAk4h5bsUA3b6@light.dominikbrodowski.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YWVKAk4h5bsUA3b6@light.dominikbrodowski.net>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

If add_bootloader_randomness() or add_hwgenerator_randomness() is
called for the first time during early boot, crng_init equals 0. Then,
crng_fast_load() gets called -- which is safe to do even if the input
pool is not yet properly set up.

If the added entropy suffices to increase crng_init to 1, future calls
to add_bootloader_randomness() or add_hwgenerator_randomness() used to
progress to credit_entropy_bits(). However, if the input pool is not yet
properly set up, the cmpxchg call within that function can lead to an
infinite recursion. This is not only a hypothetical problem, as qemu
on arm64 may provide bootloader entropy via EFI and via devicetree.

As crng_global_init_time is set to != 0 once the input pool is properly
set up, check (also) for this condition to determine which branch to take.

Calls to crng_fast_load() do not modify the input pool; therefore, the
entropy_count for the input pool must not be modified at that early
stage.

Reported-by: Ivan T. Ivanov <iivanov@suse.de>
Fixes: 18b915ac6b0a ("efi/random: Treat EFI_RNG_PROTOCOL output as bootloader randomness")
Tested-by: Ivan T. Ivanov <iivanov@suse.de>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
v2->v3: onle one unlikely (Ard Biesheuvel)
v1->v2: fix commit message; unmerge Reported-and-tested-by-tag (Ard Biesheuvel)

 drivers/char/random.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 605969ed0f96..18fe804c1bf8 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -1763,8 +1763,8 @@ static void __init init_std_data(struct entropy_store *r)
 }
 
 /*
- * Note that setup_arch() may call add_device_randomness()
- * long before we get here. This allows seeding of the pools
+ * add_device_randomness() or add_bootloader_randomness() may be
+ * called long before we get here. This allows seeding of the pools
  * with some platform dependent data very early in the boot
  * process. But it limits our options here. We must use
  * statically allocated structures that already have all
@@ -2274,7 +2274,12 @@ void add_hwgenerator_randomness(const char *buffer, size_t count,
 {
 	struct entropy_store *poolp = &input_pool;
 
-	if (unlikely(crng_init == 0)) {
+	/* We cannot do much with the input pool until it is set up in
+	 * rand_initalize(); therefore just mix into the crng state.
+	 * As this does not affect the input pool, we cannot credit
+	 * entropy for this.
+	 */
+	if (unlikely(crng_init == 0 || crng_global_init_time == 0)) {
 		crng_fast_load(buffer, count);
 		return;
 	}
