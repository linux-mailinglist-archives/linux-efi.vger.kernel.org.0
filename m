Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63D89480AF2
	for <lists+linux-efi@lfdr.de>; Tue, 28 Dec 2021 16:39:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235356AbhL1PjI (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 28 Dec 2021 10:39:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235383AbhL1PjH (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 28 Dec 2021 10:39:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 275D7C061574;
        Tue, 28 Dec 2021 07:39:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E45EEB81235;
        Tue, 28 Dec 2021 15:39:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B7D7C36AE8;
        Tue, 28 Dec 2021 15:39:03 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="XG4T8d2y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1640705942;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tkFDONjyW3jsTjHetcn/h7eGUvaH+cQm2fdxUe6PskQ=;
        b=XG4T8d2yqDJDgtfWvK1Ds3jUhW5mUi6chmlxsG7nGXgqz8mzcDxJ/Lk4Kk1YFYbrPH0eEU
        kQaMJQlJnm/9TuM8BrPL5LSGkiRbhzwlaVEk1rtOwiMFFpGR6YJw6UK5ZfAHijYzBtT0DI
        DUjR4XpjlnLoj/0dEVGsEBz3NhPMrqc=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id f5901aa7 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Tue, 28 Dec 2021 15:39:02 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        "Ivan T. Ivanov" <iivanov@suse.de>,
        Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH v7 3/4] random: do not throw away excess input to crng_fast_load
Date:   Tue, 28 Dec 2021 16:38:25 +0100
Message-Id: <20211228153826.448805-3-Jason@zx2c4.com>
In-Reply-To: <20211228153826.448805-1-Jason@zx2c4.com>
References: <CAHmME9qC2iX5EvDLj5YBZBdDJ_n8xTUYZT73qonsEhbKCwizFw@mail.gmail.com>
 <20211228153826.448805-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

When crng_fast_load() is called by add_hwgenerator_randomness(), we
currently will advance to crng_init==1 if we've acquired 64 bytes, and
then throw away the rest of the buffer. This is a problem if irq
randomness creates one call to crng_fast_load(), and then
add_hwgenerator_randomness() gets called via EFI with 64 bytes. In that
case, we'll advance to crng_init==1, but won't continue onward feeding
in bytes to progress to crng_init==2. This commit fixes the issue by
feeding leftover bytes into the next phase in
add_hwgenerator_randomness().

Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/char/random.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 95aac486177e..020443e34603 100644
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

