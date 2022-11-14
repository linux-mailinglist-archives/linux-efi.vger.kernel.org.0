Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F0AC628559
	for <lists+linux-efi@lfdr.de>; Mon, 14 Nov 2022 17:30:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237702AbiKNQav (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 14 Nov 2022 11:30:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237626AbiKNQaY (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 14 Nov 2022 11:30:24 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7183E1BE94;
        Mon, 14 Nov 2022 08:29:45 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668443384;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pnYsucPfrpcazGqKeRJP+E7nPSCgbYv1OZ+fSFJF3FE=;
        b=DHNjpiJLfHYPeBnKTTnM+gqdzzWvIqlmYY5kVw08d8BBUu2Rc0IsZfsni/Y4eZWl6DhYSF
        wfzBYXjsKpfAKL1z8bCxWk+nOkF+g97HnDSOYTdg5PwUjLeTriyS/8m9ACW8zNburxIzBt
        6IAHB//+/zv3X1PZY9LDWcFwelqOscIXUYxfLbCRLz9HKSwuwmWwKWP0F3Cw1jO6gDSAL2
        Rr9W5F/iqapUTqry+clh3Yarx/hndpzUNg2dfuHX0wkCwWl9EauSNiJ4auh+GAxG2rN6hq
        zjPQq6yDqVPiz9lCq17+Wg99Ec5MGzCsaoYVW6WvfWIvCP+Hhse24ox5lQMnlA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668443384;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pnYsucPfrpcazGqKeRJP+E7nPSCgbYv1OZ+fSFJF3FE=;
        b=vEj+hs9ErdPijVo5crxMPO+17ysamncYBpFmUafWoOgXAcwaih7nynvEsz+28Upwhxx02B
        htoS4IAose+ZTBBQ==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        linux-efi@vger.kernel.org
Subject: [PATCH printk v4 23/39] efi: earlycon: use console_is_registered()
Date:   Mon, 14 Nov 2022 17:35:16 +0106
Message-Id: <20221114162932.141883-24-john.ogness@linutronix.de>
In-Reply-To: <20221114162932.141883-1-john.ogness@linutronix.de>
References: <20221114162932.141883-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The CON_ENABLED status of a console is a runtime setting that does not
involve the console driver. Drivers must not assume that if the console
is disabled then proper hardware management is not needed. For the EFI
earlycon case, it is about remapping/unmapping memory for the
framebuffer.

Use console_is_registered() instead of checking CON_ENABLED.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 drivers/firmware/efi/earlycon.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/efi/earlycon.c b/drivers/firmware/efi/earlycon.c
index a52236e11e5f..4d6c5327471a 100644
--- a/drivers/firmware/efi/earlycon.c
+++ b/drivers/firmware/efi/earlycon.c
@@ -29,8 +29,8 @@ static void *efi_fb;
  */
 static int __init efi_earlycon_remap_fb(void)
 {
-	/* bail if there is no bootconsole or it has been disabled already */
-	if (!earlycon_console || !(earlycon_console->flags & CON_ENABLED))
+	/* bail if there is no bootconsole or it was unregistered already */
+	if (!earlycon_console || !console_is_registered(earlycon_console))
 		return 0;
 
 	efi_fb = memremap(fb_base, screen_info.lfb_size,
@@ -42,8 +42,8 @@ early_initcall(efi_earlycon_remap_fb);
 
 static int __init efi_earlycon_unmap_fb(void)
 {
-	/* unmap the bootconsole fb unless keep_bootcon has left it enabled */
-	if (efi_fb && !(earlycon_console->flags & CON_ENABLED))
+	/* unmap the bootconsole fb unless keep_bootcon left it registered */
+	if (efi_fb && !console_is_registered(earlycon_console))
 		memunmap(efi_fb);
 	return 0;
 }
-- 
2.30.2

