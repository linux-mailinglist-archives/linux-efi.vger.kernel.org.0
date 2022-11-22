Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF1A16332B0
	for <lists+linux-efi@lfdr.de>; Tue, 22 Nov 2022 03:04:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232500AbiKVCEk (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 21 Nov 2022 21:04:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232473AbiKVCEb (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 21 Nov 2022 21:04:31 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C8B2E1BCE;
        Mon, 21 Nov 2022 18:04:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3C358B818E6;
        Tue, 22 Nov 2022 02:04:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44F00C433C1;
        Tue, 22 Nov 2022 02:04:20 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="qCLPoFdy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1669082658;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rLuiywXwOgU0DdSYb71cMF5DgQZCiOi2DUhSONxrrpQ=;
        b=qCLPoFdyiL30pd5i2LoFPnWyG4IxdR757HLvFRbXRAiy8dJvLUYt2D0ReGS23P1/GCV/M8
        WltWsnBs3mlvmKCmsFE9+Ivsj9OvD1S/DnJXeK5yU25MzQ4lSOt75rUyUYDS3A8Z+X15Zr
        VnVJf/4iWsUnDI2eNZsxD9/hf/zKy08=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id c4c33475 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 22 Nov 2022 02:04:18 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-efi@vger.kernel.org, linux-crypto@vger.kernel.org,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        ardb@kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH v3 3/5] random: add back async readiness notifier
Date:   Tue, 22 Nov 2022 03:04:02 +0100
Message-Id: <20221122020404.3476063-4-Jason@zx2c4.com>
In-Reply-To: <20221122020404.3476063-1-Jason@zx2c4.com>
References: <20221122020404.3476063-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

This is required by vsprint, because it can't do things synchronously
from hardirq context, and it will be useful for an EFI notifier as well.
I didn't initially want to do this, but with two potential consumers
now, it seems worth it.

Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/char/random.c  | 22 ++++++++++++++++++++++
 include/linux/random.h |  1 +
 2 files changed, 23 insertions(+)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 65ee69896967..a2a18bd3d7d7 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -84,6 +84,7 @@ static DEFINE_STATIC_KEY_FALSE(crng_is_ready);
 /* Various types of waiters for crng_init->CRNG_READY transition. */
 static DECLARE_WAIT_QUEUE_HEAD(crng_init_wait);
 static struct fasync_struct *fasync;
+static ATOMIC_NOTIFIER_HEAD(random_ready_notifier);
 
 /* Control how we warn userspace. */
 static struct ratelimit_state urandom_warning =
@@ -140,6 +141,26 @@ int wait_for_random_bytes(void)
 }
 EXPORT_SYMBOL(wait_for_random_bytes);
 
+/*
+ * Add a callback function that will be invoked when the crng is initialised,
+ * or immediately if it already has been. Only use this is you are absolutely
+ * sure it is required. Most users should instead be able to test
+ * `rng_is_initialized()` on demand, or make use of `get_random_bytes_wait()`.
+ */
+int __cold execute_with_initialized_rng(struct notifier_block *nb)
+{
+	unsigned long flags;
+	int ret = 0;
+
+	spin_lock_irqsave(&random_ready_notifier.lock, flags);
+	if (crng_ready())
+		nb->notifier_call(nb, 0, NULL);
+	else
+		ret = raw_notifier_chain_register((struct raw_notifier_head *)&random_ready_notifier.head, nb);
+	spin_unlock_irqrestore(&random_ready_notifier.lock, flags);
+	return ret;
+}
+
 #define warn_unseeded_randomness() \
 	if (IS_ENABLED(CONFIG_WARN_ALL_UNSEEDED_RANDOM) && !crng_ready()) \
 		printk_deferred(KERN_NOTICE "random: %s called from %pS with crng_init=%d\n", \
@@ -697,6 +718,7 @@ static void __cold _credit_init_bits(size_t bits)
 		crng_reseed(NULL); /* Sets crng_init to CRNG_READY under base_crng.lock. */
 		if (static_key_initialized)
 			execute_in_process_context(crng_set_ready, &set_ready);
+		atomic_notifier_call_chain(&random_ready_notifier, 0, NULL);
 		wake_up_interruptible(&crng_init_wait);
 		kill_fasync(&fasync, SIGIO, POLL_IN);
 		pr_notice("crng init done\n");
diff --git a/include/linux/random.h b/include/linux/random.h
index 579117d83eb8..b1a34181eed6 100644
--- a/include/linux/random.h
+++ b/include/linux/random.h
@@ -120,6 +120,7 @@ void __init random_init_early(const char *command_line);
 void __init random_init(void);
 bool rng_is_initialized(void);
 int wait_for_random_bytes(void);
+int execute_with_initialized_rng(struct notifier_block *nb);
 
 /* Calls wait_for_random_bytes() and then calls get_random_bytes(buf, nbytes).
  * Returns the result of the call to wait_for_random_bytes. */
-- 
2.38.1

