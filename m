Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F153E4816F5
	for <lists+linux-efi@lfdr.de>; Wed, 29 Dec 2021 22:13:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231372AbhL2VNu (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 29 Dec 2021 16:13:50 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:33264 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230488AbhL2VNt (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 29 Dec 2021 16:13:49 -0500
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from owl.dominikbrodowski.net (owl.brodo.linta [10.2.0.111])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id 22BD6201306;
        Wed, 29 Dec 2021 21:13:48 +0000 (UTC)
Received: by owl.dominikbrodowski.net (Postfix, from userid 1000)
        id D0BF580F4B; Wed, 29 Dec 2021 22:10:17 +0100 (CET)
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     "Jason A . Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        "Ivan T . Ivanov" <iivanov@suse.de>,
        Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org,
        linux@dominikbrodowski.net
Subject: [PATCH v8 3/7] random: do not throw away excess input to crng_fast_load
Date:   Wed, 29 Dec 2021 22:10:05 +0100
Message-Id: <20211229211009.108091-3-linux@dominikbrodowski.net>
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

When crng_fast_load() is called by add_hwgenerator_randomness(), we
currently will advance to crng_init==1 once we've acquired 64 bytes, and
then throw away the rest of the buffer. Usually, that is not a problem:
When add_hwgenerator_randomness() gets called via EFI or DT during
setup_arch(), there won't be any IRQ randomness. Therefore, the 64 bytes
passed by EFI exactly matches what is needed to advance to crng_init==1.
Usually, DT seems to pass 64 bytes as well -- with one notable exception
being kexec, which hands over 128 bytes of entropy to the kexec'd kernel.
In that case, we'll advance to crng_init==1 once 64 of those bytes are
consumed by crng_fast_load(), but won't continue onward feeding in bytes
to progress to crng_init==2. This commit fixes the issue by feeding
any leftover bytes into the next phase in add_hwgenerator_randomness().

Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
[linux@dominikbrodowski.net: rewrite commit message]
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 drivers/char/random.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 916cf791ed0e..21166188b7e1 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -919,12 +919,14 @@ static struct crng_state *select_crng(void)
 
 /*
  * crng_fast_load() can be called by code in the interrupt service
- * path.  So we can't afford to dilly-dally.
+ * path.  So we can't afford to dilly-dally. Returns the number of
+ * bytes processed from cp.
  */
-static int crng_fast_load(const char *cp, size_t len)
+static size_t crng_fast_load(const char *cp, size_t len)
 {
 	unsigned long flags;
 	char *p;
+	size_t ret = 0;
 
 	if (!spin_trylock_irqsave(&primary_crng.lock, flags))
 		return 0;
@@ -935,7 +937,7 @@ static int crng_fast_load(const char *cp, size_t len)
 	p = (unsigned char *) &primary_crng.state[4];
 	while (len > 0 && crng_init_cnt < CRNG_INIT_CNT_THRESH) {
 		p[crng_init_cnt % CHACHA_KEY_SIZE] ^= *cp;
-		cp++; crng_init_cnt++; len--;
+		cp++; crng_init_cnt++; len--; ret++;
 	}
 	spin_unlock_irqrestore(&primary_crng.lock, flags);
 	if (crng_init_cnt >= CRNG_INIT_CNT_THRESH) {
@@ -943,7 +945,7 @@ static int crng_fast_load(const char *cp, size_t len)
 		crng_init = 1;
 		pr_notice("fast init done\n");
 	}
-	return 1;
+	return ret;
 }
 
 /*
@@ -1294,7 +1296,7 @@ void add_interrupt_randomness(int irq)
 	if (unlikely(crng_init == 0)) {
 		if ((fast_pool->count >= 64) &&
 		    crng_fast_load((char *) fast_pool->pool,
-				   sizeof(fast_pool->pool))) {
+				   sizeof(fast_pool->pool)) > 0) {
 			fast_pool->count = 0;
 			fast_pool->last = now;
 		}
@@ -2295,8 +2297,11 @@ void add_hwgenerator_randomness(const char *buffer, size_t count,
 	struct entropy_store *poolp = &input_pool;
 
 	if (unlikely(crng_init == 0)) {
-		crng_fast_load(buffer, count);
-		return;
+		size_t ret = crng_fast_load(buffer, count);
+		count -= ret;
+		buffer += ret;
+		if (!count || crng_init == 0)
+			return;
 	}
 
 	/* Suspend writing if we're above the trickle threshold.
-- 
2.34.1

