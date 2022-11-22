Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5CFE6332AD
	for <lists+linux-efi@lfdr.de>; Tue, 22 Nov 2022 03:04:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232506AbiKVCEl (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 21 Nov 2022 21:04:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232459AbiKVCEc (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 21 Nov 2022 21:04:32 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F26DE14D7;
        Mon, 21 Nov 2022 18:04:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2403BB818E7;
        Tue, 22 Nov 2022 02:04:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4042BC433B5;
        Tue, 22 Nov 2022 02:04:22 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Dp148rop"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1669082661;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CQp5Xt1b1pHaswbZ86gvO2c+Ls0o4Gj7yCvAYqghZs4=;
        b=Dp148ropguWfBS6U4rGunOxWu3O9SFddDB/Y0n7mciWLwD8rlXvuG2ujfQZvGZvlIqvs/e
        sqP6W2u3zp8d3lf/WsFe95jZ34Fyue6k6vMbgXrgaRdcAAguucHbIVpgRD3pu6f835hTtB
        wc/KbEFVHfZLX3ytWRL6oT1/oPa1qFM=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 8231b6b4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 22 Nov 2022 02:04:21 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-efi@vger.kernel.org, linux-crypto@vger.kernel.org,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        ardb@kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Petr Mladek <pmladek@suse.com>
Subject: [PATCH v3 4/5] vsprintf: initialize siphash key using notifier
Date:   Tue, 22 Nov 2022 03:04:03 +0100
Message-Id: <20221122020404.3476063-5-Jason@zx2c4.com>
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

Rather than polling every second, use the new notifier to do this at
exactly the right moment.

Reviewed-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 lib/vsprintf.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 24f37bab8bc1..2d11541ee561 100644
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
+	return NOTIFY_DONE;
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

