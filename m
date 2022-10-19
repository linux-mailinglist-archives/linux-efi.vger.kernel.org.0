Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2779604A6F
	for <lists+linux-efi@lfdr.de>; Wed, 19 Oct 2022 17:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231463AbiJSPFD (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 19 Oct 2022 11:05:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232112AbiJSPEF (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 19 Oct 2022 11:04:05 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ACCBACF55;
        Wed, 19 Oct 2022 07:58:34 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666191366;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ANsy39dTo+95E1TXTBS5kbs28UVGSNMF6vh3Au875fs=;
        b=wBedELtUaj0zJeFDpwmo+Eyrsj3vhnslVQMMnOkfh/q28nnuprj+u3It6GYfDmuHkyH1Z0
        jNvgvw0kZdalO6FFSXJu2mqO47j5IZHrSszNINkfYz08dHv/g24BIipbzVvvkCUtwUEd6c
        /G5ZUEi7k1R4vBBcPi0q5lAPBZi73IxF0DRlGFYb+7B7MuBL8SZrA8ne0tSMtqkeo+Yjiz
        U1qZfnDQPMOveo2W5xC7mJmp6jwh2VhohUHK7OWYalPnB+MT+EKUDwMWLhHz3pybmY9YEy
        vCFG/SnEVbJb9yxV5uYCeNZTI0ekEncYcgbhvVRO+iKofY2lSZVNpoCyiHCTQw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666191366;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ANsy39dTo+95E1TXTBS5kbs28UVGSNMF6vh3Au875fs=;
        b=H1yntJDtD/aMwcZTAmUYG8IvP4HBmdfAyCl/OBYwZYBB8EKsYSv3K4Ea8bOP1qKbt6ZJ1i
        mxTyv7pllOslw7AQ==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        linux-efi@vger.kernel.org
Subject: [PATCH printk v2 08/38] efi: earlycon: use console_is_enabled()
Date:   Wed, 19 Oct 2022 17:01:30 +0206
Message-Id: <20221019145600.1282823-9-john.ogness@linutronix.de>
In-Reply-To: <20221019145600.1282823-1-john.ogness@linutronix.de>
References: <20221019145600.1282823-1-john.ogness@linutronix.de>
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

Replace (console->flags & CON_ENABLED) usage with console_is_enabled().

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 drivers/firmware/efi/earlycon.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/efi/earlycon.c b/drivers/firmware/efi/earlycon.c
index a52236e11e5f..8c27eb941d8e 100644
--- a/drivers/firmware/efi/earlycon.c
+++ b/drivers/firmware/efi/earlycon.c
@@ -30,7 +30,7 @@ static void *efi_fb;
 static int __init efi_earlycon_remap_fb(void)
 {
 	/* bail if there is no bootconsole or it has been disabled already */
-	if (!earlycon_console || !(earlycon_console->flags & CON_ENABLED))
+	if (!earlycon_console || !console_is_enabled(earlycon_console))
 		return 0;
 
 	efi_fb = memremap(fb_base, screen_info.lfb_size,
@@ -43,7 +43,7 @@ early_initcall(efi_earlycon_remap_fb);
 static int __init efi_earlycon_unmap_fb(void)
 {
 	/* unmap the bootconsole fb unless keep_bootcon has left it enabled */
-	if (efi_fb && !(earlycon_console->flags & CON_ENABLED))
+	if (efi_fb && !console_is_enabled(earlycon_console))
 		memunmap(efi_fb);
 	return 0;
 }
-- 
2.30.2

