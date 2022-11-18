Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 879B862F642
	for <lists+linux-efi@lfdr.de>; Fri, 18 Nov 2022 14:34:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242127AbiKRNeg (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 18 Nov 2022 08:34:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242123AbiKRNdu (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 18 Nov 2022 08:33:50 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E65C91504;
        Fri, 18 Nov 2022 05:33:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 808616240E;
        Fri, 18 Nov 2022 13:33:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C125C433D6;
        Fri, 18 Nov 2022 13:33:00 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="G0A2QFa0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1668778380;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KRI7c0jyO81WH8LhGQd5yn6JLdZ1nNbkFYrsF+JdkxI=;
        b=G0A2QFa06c2vme6/Qitw8okO4LXJIpDqVFWKn18clZ4r0m65OFEa++PJHAysuO7ER5MDL/
        +H5MFBVuYrRRwGioQrCsQ8br1z40XM2Xl849jbejS9wGUI7DP01Vl185aUDJGBKYSx2CVK
        6+e/5l2w/Oiza9h74/G0nyz/tPQSi4w=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id e8982513 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 18 Nov 2022 13:32:59 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-efi@vger.kernel.org, linux-crypto@vger.kernel.org,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Mike Galbraith <efault@gmx.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Petr Mladek <pmladek@suse.com>
Subject: [PATCH v2 4/5] vsprintf: initialize siphash key using notifier
Date:   Fri, 18 Nov 2022 14:32:38 +0100
Message-Id: <20221118133239.2515648-5-Jason@zx2c4.com>
In-Reply-To: <20221118133239.2515648-1-Jason@zx2c4.com>
References: <20221118133239.2515648-1-Jason@zx2c4.com>
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

Rather than polling every second, use the new notifier to do this at
exactly the right moment.

Cc: Mike Galbraith <efault@gmx.de>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Petr Mladek <pmladek@suse.com>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 lib/vsprintf.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 24f37bab8bc1..890607b32235 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -41,6 +41,7 @@
 #include <linux/siphash.h>
 #include <linux/compiler.h>
 #include <linux/property.h>
+#include <linux/notifier.h>
 #ifdef CONFIG_BLOCK
 #include <linux/blkdev.h>
 #endif
@@ -752,26 +753,21 @@ early_param("debug_boot_weak_hash", debug_boot_weak_hash_enable);
 
 static bool filled_random_ptr_key __read_mostly;
 static siphash_key_t ptr_key __read_mostly;
-static void fill_ptr_key_workfn(struct work_struct *work);
-static DECLARE_DELAYED_WORK(fill_ptr_key_work, fill_ptr_key_workfn);
 
-static void fill_ptr_key_workfn(struct work_struct *work)
+static int fill_ptr_key(struct notifier_block *nb, unsigned long action, void *data)
 {
-	if (!rng_is_initialized()) {
-		queue_delayed_work(system_unbound_wq, &fill_ptr_key_work, HZ  * 2);
-		return;
-	}
-
 	get_random_bytes(&ptr_key, sizeof(ptr_key));
 
 	/* Pairs with smp_rmb() before reading ptr_key. */
 	smp_wmb();
 	WRITE_ONCE(filled_random_ptr_key, true);
+	return 0;
 }
 
 static int __init vsprintf_init_hashval(void)
 {
-	fill_ptr_key_workfn(NULL);
+	static struct notifier_block fill_ptr_key_nb = { .notifier_call = fill_ptr_key };
+	execute_with_initialized_rng(&fill_ptr_key_nb);
 	return 0;
 }
 subsys_initcall(vsprintf_init_hashval)
-- 
2.38.1

