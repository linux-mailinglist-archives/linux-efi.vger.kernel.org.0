Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D85A4816F8
	for <lists+linux-efi@lfdr.de>; Wed, 29 Dec 2021 22:13:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230488AbhL2VNv (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 29 Dec 2021 16:13:51 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:33318 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231130AbhL2VNu (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 29 Dec 2021 16:13:50 -0500
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from owl.dominikbrodowski.net (owl.brodo.linta [10.2.0.111])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id 2471E201340;
        Wed, 29 Dec 2021 21:13:48 +0000 (UTC)
Received: by owl.dominikbrodowski.net (Postfix, from userid 1000)
        id 1B25F808F2; Wed, 29 Dec 2021 22:10:17 +0100 (CET)
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     "Jason A . Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        "Ivan T . Ivanov" <iivanov@suse.de>,
        Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org,
        linux@dominikbrodowski.net
Subject: [PATCH v8 2/7] random: do not re-init if crng_reseed completes before primary init
Date:   Wed, 29 Dec 2021 22:10:04 +0100
Message-Id: <20211229211009.108091-2-linux@dominikbrodowski.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211229211009.108091-1-linux@dominikbrodowski.net>
References: <20211228153826.448805-1-Jason@zx2c4.com>
 <20211229211009.108091-1-linux@dominikbrodowski.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: "Jason A. Donenfeld" <Jason@zx2c4.com>

If the bootloader supplies sufficient material and crng_reseed() is called
very early on, but not too early that wqs aren't available yet, then we
might transition to crng_init==2 before rand_initialize()'s call to
crng_initialize_primary() made. Then, when crng_initialize_primary() is
called, if we're trusting the CPU's RDRAND instructions, we'll
needlessly reinitialize the RNG and emit a message about it. This is
mostly harmless, as numa_crng_init() will allocate and then free what it
just allocated, and excessive calls to invalidate_batched_entropy()
aren't so harmful. But it is funky and the extra message is confusing,
so avoid the re-initialization all together by checking for crng_init <
2 in crng_initialize_primary(), just as we already do in crng_reseed().

Reviewed-by: Dominik Brodowski <linux@dominikbrodowski.net>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/char/random.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 144e8841bff4..916cf791ed0e 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -827,7 +827,7 @@ static void __init crng_initialize_primary(struct crng_state *crng)
 {
 	chacha_init_consts(crng->state);
 	_extract_entropy(&input_pool, &crng->state[4], sizeof(__u32) * 12, 0);
-	if (crng_init_try_arch_early(crng) && trust_cpu) {
+	if (crng_init_try_arch_early(crng) && trust_cpu && crng_init < 2) {
 		invalidate_batched_entropy();
 		numa_crng_init();
 		crng_init = 2;
-- 
2.34.1

