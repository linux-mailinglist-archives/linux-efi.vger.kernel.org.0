Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9D0962C422
	for <lists+linux-efi@lfdr.de>; Wed, 16 Nov 2022 17:23:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238416AbiKPQXK (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 16 Nov 2022 11:23:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234873AbiKPQWi (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 16 Nov 2022 11:22:38 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A837B4AF0F;
        Wed, 16 Nov 2022 08:22:09 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668615728;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pnYsucPfrpcazGqKeRJP+E7nPSCgbYv1OZ+fSFJF3FE=;
        b=Mij3VvRC/6EFTcGjMoRfMHKmgufFADNOVvPxUDDVOOSOrPddxUf/MjL2jIte04n+xoT2hr
        91sUQeFxNGfr+TLQTWsfBfqspOt9n255fq7uCyNxCtf0H/QmixcO5zuiecKTJ3HQk8EGPB
        unRmNVM+bEFHt6BoKHxnkKeoU7Etnpubat9VOidw3dLcm2+nPy7+2Cr+fSr0huD9IC4zh+
        8Otv988TZ1oHvi2a69DyX5RNZMMV2/uuj2Lf0QofQOj5pJKVcTjQOkAZvEIcREllQs2jcf
        P12Ld2nSBgsjL9MKh+b3ogWx23jDl8wStPXMiAee30DgS5qWmgh+dzU9u8vmjA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668615728;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pnYsucPfrpcazGqKeRJP+E7nPSCgbYv1OZ+fSFJF3FE=;
        b=rPN9XGHVg2e7lvGMMTXZazg1MjVG50yjAsBuQPQhCpeWSPiuq/4enuNAqKmPa7UzDRTB0I
        9YoMKvyB5Px6vWCQ==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        linux-efi@vger.kernel.org
Subject: [PATCH printk v5 24/40] efi: earlycon: use console_is_registered()
Date:   Wed, 16 Nov 2022 17:27:36 +0106
Message-Id: <20221116162152.193147-25-john.ogness@linutronix.de>
In-Reply-To: <20221116162152.193147-1-john.ogness@linutronix.de>
References: <20221116162152.193147-1-john.ogness@linutronix.de>
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

