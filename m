Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91FCC62C3D1
	for <lists+linux-efi@lfdr.de>; Wed, 16 Nov 2022 17:17:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232671AbiKPQRY (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 16 Nov 2022 11:17:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234848AbiKPQRE (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 16 Nov 2022 11:17:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DAD057B4F;
        Wed, 16 Nov 2022 08:17:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 507A5B81DD9;
        Wed, 16 Nov 2022 16:17:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59EDDC433C1;
        Wed, 16 Nov 2022 16:16:59 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="mHUvawIZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1668615418;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W1wAtKaY05W2lIvCkJNGSoOGC/DQ2aQIlUV6cSqpewY=;
        b=mHUvawIZManIDNWJYkDAZ1LyUU64eJuoithPe85vkWTE8glRz2J/80l6AjIgn+rpBYe/dW
        VOFfazhVy5argg5xGDFuAYRISePB5qvxVEFpQgS5cmA6mwErH/Jp9kSSlhm8WpsZv8GEC7
        jesrA94tBbgHa+1qpqrzQ0zEQElW6DM=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id b05e0581 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 16 Nov 2022 16:16:57 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-efi@vger.kernel.org, linux-crypto@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Lennart Poettering <lennart@poettering.net>
Subject: [PATCH RFC v1 1/6] random: add back async readiness notifier
Date:   Wed, 16 Nov 2022 17:16:37 +0100
Message-Id: <20221116161642.1670235-2-Jason@zx2c4.com>
In-Reply-To: <20221116161642.1670235-1-Jason@zx2c4.com>
References: <20221116161642.1670235-1-Jason@zx2c4.com>
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

Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/char/random.c  | 30 ++++++++++++++++++++++++++++++
 include/linux/random.h |  1 +
 2 files changed, 31 insertions(+)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 6b7aca683b81..b3cad16ec567 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -84,6 +84,8 @@ static DEFINE_STATIC_KEY_FALSE(crng_is_ready);
 /* Various types of waiters for crng_init->CRNG_READY transition. */
 static DECLARE_WAIT_QUEUE_HEAD(crng_init_wait);
 static struct fasync_struct *fasync;
+static DEFINE_SPINLOCK(random_ready_chain_lock);
+static RAW_NOTIFIER_HEAD(random_ready_chain);
 
 /* Control how we warn userspace. */
 static struct ratelimit_state urandom_warning =
@@ -140,6 +142,33 @@ int wait_for_random_bytes(void)
 }
 EXPORT_SYMBOL(wait_for_random_bytes);
 
+/*
+ * Add a callback function that will be invoked when the crng is initialised,
+ * or immediately if it already has been.
+ */
+int __cold notify_on_rng_initialized(struct notifier_block *nb)
+{
+	unsigned long flags;
+	int ret = 0;
+
+	spin_lock_irqsave(&random_ready_chain_lock, flags);
+	if (crng_ready())
+		nb->notifier_call(nb, 0, NULL);
+	else
+		ret = raw_notifier_chain_register(&random_ready_chain, nb);
+	spin_unlock_irqrestore(&random_ready_chain_lock, flags);
+	return ret;
+}
+
+static void __cold process_random_ready_list(void)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&random_ready_chain_lock, flags);
+	raw_notifier_call_chain(&random_ready_chain, 0, NULL);
+	spin_unlock_irqrestore(&random_ready_chain_lock, flags);
+}
+
 #define warn_unseeded_randomness() \
 	if (IS_ENABLED(CONFIG_WARN_ALL_UNSEEDED_RANDOM) && !crng_ready()) \
 		printk_deferred(KERN_NOTICE "random: %s called from %pS with crng_init=%d\n", \
@@ -685,6 +714,7 @@ static void __cold _credit_init_bits(size_t bits)
 		crng_reseed(); /* Sets crng_init to CRNG_READY under base_crng.lock. */
 		if (static_key_initialized)
 			execute_in_process_context(crng_set_ready, &set_ready);
+		process_random_ready_list();
 		wake_up_interruptible(&crng_init_wait);
 		kill_fasync(&fasync, SIGIO, POLL_IN);
 		pr_notice("crng init done\n");
diff --git a/include/linux/random.h b/include/linux/random.h
index acaa328fb34d..566ffc3ab80d 100644
--- a/include/linux/random.h
+++ b/include/linux/random.h
@@ -119,6 +119,7 @@ void __init random_init_early(const char *command_line);
 void __init random_init(void);
 bool rng_is_initialized(void);
 int wait_for_random_bytes(void);
+int notify_on_rng_initialized(struct notifier_block *nb);
 
 /* Calls wait_for_random_bytes() and then calls get_random_bytes(buf, nbytes).
  * Returns the result of the call to wait_for_random_bytes. */
-- 
2.38.1

