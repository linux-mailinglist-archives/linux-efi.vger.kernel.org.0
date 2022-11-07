Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44F1861F531
	for <lists+linux-efi@lfdr.de>; Mon,  7 Nov 2022 15:17:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232237AbiKGOQ5 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 7 Nov 2022 09:16:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232208AbiKGOQx (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 7 Nov 2022 09:16:53 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE9541D0DC;
        Mon,  7 Nov 2022 06:16:52 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1667830611;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LyZS5uMfYU/cffNHBb1twOFg15bMKL8z2VkdH4RqLnI=;
        b=GnMxuG19cPyqFuF8fXFkyp6BckB8w0fTGzzoUGJW8OTZHW07pe6cy3yQ25K6+xuc6WJkZa
        B0OrWffeC4/SJIQIT9xZt/HoXDv4h4MxdvAwssBmQqJM24HIhAIsPhBzkzGE9zvU33IcQT
        D2P3bTLx/IkzIFXS4KfIrlsBroeIvcJKo2YMSTI23KfFDdpTkFxT1gU7vbNMUyG3iHI6+h
        uN7ALdebM9zPKMj3un1XnXnedrgbRFVNUxpMdtNWUryG53Q34bInxDwv86YnyZ6srrhERh
        /7nrPnXmTf9zKKAlkUi4DAVF7yXXGyC6fbqRe/BupROVIvSHYPn7TPVztHThzA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1667830611;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LyZS5uMfYU/cffNHBb1twOFg15bMKL8z2VkdH4RqLnI=;
        b=BXFh3bD41IX3Cmqunb4gjOg4lZQztyE321oMZc+jZMFZefEKXR4aE/imyimsbONLhG0A9F
        H3tEdsW+XTu/0VCA==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        linux-efi@vger.kernel.org
Subject: [PATCH printk v3 25/40] efi: earlycon: use console_is_registered()
Date:   Mon,  7 Nov 2022 15:22:23 +0106
Message-Id: <20221107141638.3790965-26-john.ogness@linutronix.de>
In-Reply-To: <20221107141638.3790965-1-john.ogness@linutronix.de>
References: <20221107141638.3790965-1-john.ogness@linutronix.de>
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

