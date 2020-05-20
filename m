Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E18211DBA76
	for <lists+linux-efi@lfdr.de>; Wed, 20 May 2020 19:02:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbgETRC2 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 20 May 2020 13:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbgETRC2 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 20 May 2020 13:02:28 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37148C061A0E
        for <linux-efi@vger.kernel.org>; Wed, 20 May 2020 10:02:27 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id dh1so1644114qvb.13
        for <linux-efi@vger.kernel.org>; Wed, 20 May 2020 10:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KwYDd0RPr8fTAUdyTD7TC3tEDsaHADXkHL6WsGulx4E=;
        b=MakO2KwrKm8c0fEP/FagqsWInQJfGKh3HzztujM09Fg1rVCH8MdeL+Y9PhQnv2NESA
         8CaNjx3gFo71HCtW8ryeNjjsdhOPmvgPYaNS0lknDvmYaux39cv7tMW/rI9vqYeyG6Rr
         rQn5yO2tLGOsClhgqH3DjGfc1Bp3uzUHMDz7vKrxmbfMm9QAYpTQpPGEROzIM+bDq6nt
         4OFGso/ah3ojXpOn6b7MbxnjM87HPnzl8KS7CILDFaeFPT+85ewLnD2G9SWmaLs0yHWf
         fXIgL/vFXkS3EkbI/Z8N+xxi+E75U5HVogxir9UecYTiRwoob3ACkDyycIgjeckVGD76
         LWng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=KwYDd0RPr8fTAUdyTD7TC3tEDsaHADXkHL6WsGulx4E=;
        b=e5DZKCBkreUcPbbBRM1p8/X2IifNVDoYhDuRt4w/HrVBAL0Zkl++1vrezQ9/0jlGX/
         VyvhnZkOMPyo3rnPVEiO6rwlF9BhijE1QOQ9b5etyBKGr+bfp4KF/ibrliAFWz6RnOj0
         ueUKT8t3vicSU+ZV0rfPKWorhFzT7L4DscY9iRoYSYeOygKxg45vRKbzKY1ByrvI5HQ0
         Pmst0Mh3OfU1rAXeiA55U/gH5g2nGy3fR8w8BeLdiC3hRIErK7Ffq6hXEGngnMitsXvY
         eex091YjNe7yyHLerhQqEpURkMOfdJTnTt3QPA+GIwIR7KEYm6pxiVtGyXXEsw8SRWxy
         yL3g==
X-Gm-Message-State: AOAM532FPOjEV/UetFsyKCGGWsZiTyyLWH6QLK+MeKYGn85KhAwKBSuf
        vLUeAb+eAlp4keQEAi9FcE0=
X-Google-Smtp-Source: ABdhPJxtM401PpHngBNHnYwmg23XACWDfsA5JAbTiY3ZajlzvKhaN1opcT/QmjvTepQ+Z+hg6qX+JQ==
X-Received: by 2002:ad4:5629:: with SMTP id cb9mr5885391qvb.181.1589994146146;
        Wed, 20 May 2020 10:02:26 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id w21sm3038518qtj.78.2020.05.20.10.02.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 10:02:25 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Wed, 20 May 2020 13:02:23 -0400
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        linux-efi <linux-efi@vger.kernel.org>
Subject: Re: [PATCH 17/24] efi/libstub: Implement printk-style logging
Message-ID: <20200520170223.GA3333632@rani.riverdale.lan>
References: <20200518190716.751506-1-nivedita@alum.mit.edu>
 <20200518190716.751506-18-nivedita@alum.mit.edu>
 <CAMj1kXE=YowWg2CbqXVhPcXoq3eZdowzTnGxLkpD5xcf29fHhw@mail.gmail.com>
 <20200519150755.GC1526900@rani.riverdale.lan>
 <20200520163808.GA3274869@rani.riverdale.lan>
 <CAMj1kXG2h=x9sfu0ELyUyveu_1hU5qiuRkQXf8Y4dnRPErb3Xw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXG2h=x9sfu0ELyUyveu_1hU5qiuRkQXf8Y4dnRPErb3Xw@mail.gmail.com>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, May 20, 2020 at 06:38:53PM +0200, Ard Biesheuvel wrote:
> On Wed, 20 May 2020 at 18:38, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> >
> > On Tue, May 19, 2020 at 11:07:55AM -0400, Arvind Sankar wrote:
> > > On Tue, May 19, 2020 at 10:22:40AM +0200, Ard Biesheuvel wrote:
> > > > On Mon, 18 May 2020 at 21:07, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> > > > > @@ -100,7 +123,9 @@ efi_status_t efi_parse_options(char const *cmdline)
> > > > >                 if (!strcmp(param, "nokaslr")) {
> > > > >                         efi_nokaslr = true;
> > > > >                 } else if (!strcmp(param, "quiet")) {
> > > > > -                       efi_quiet = true;
> > > > > +                       efi_loglevel = CONSOLE_LOGLEVEL_QUIET;
> > > > > +               } else if (!strcmp(param, "debug")) {
> > > > > +                       efi_loglevel = CONSOLE_LOGLEVEL_DEBUG;
> > > >
> > > > Should we wire this to 'efi=debug' instead?
> > > >
> > >
> > > Sure.
> >
> > Do you prefer it wired up to both or just efi=debug?
> >
> 
> Let's stick with efi=debug, that is what all other EFI code uses.

Ok -- you can replace the patch with the attached version. Only change
is in efi_parse_options.

Author: Arvind Sankar <nivedita@alum.mit.edu>
Date:   Thu May 14 19:33:39 2020 -0400

    efi/libstub: Implement printk-style logging
    
    Use the efi_printk function in efi_info/efi_err, and add efi_debug. This
    allows formatted output at different log levels.
    
    Add the notion of a loglevel instead of just quiet/not-quiet, and
    parse the efi=debug kernel parameter in addition to quiet.
    
    Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>

diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
index 5ecafc57619a..1f5a00b4f201 100644
--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -11,6 +11,7 @@
 
 #include <linux/efi.h>
 #include <linux/kernel.h>
+#include <linux/printk.h> /* For CONSOLE_LOGLEVEL_* */
 #include <asm/efi.h>
 
 #include "efistub.h"
@@ -18,7 +19,7 @@
 bool efi_nochunk;
 bool efi_nokaslr;
 bool efi_noinitrd;
-bool efi_quiet;
+int efi_loglevel = CONSOLE_LOGLEVEL_DEFAULT;
 bool efi_novamap;
 
 static bool efi_nosoftreserve;
@@ -58,6 +59,28 @@ int efi_printk(const char *fmt, ...)
 	char printf_buf[256];
 	va_list args;
 	int printed;
+	int loglevel = printk_get_level(fmt);
+
+	switch (loglevel) {
+	case '0' ... '9':
+		loglevel -= '0';
+		break;
+	default:
+		/*
+		 * Use loglevel -1 for cases where we just want to print to
+		 * the screen.
+		 */
+		loglevel = -1;
+		break;
+	}
+
+	if (loglevel >= efi_loglevel)
+		return 0;
+
+	if (loglevel >= 0)
+		efi_puts("EFI stub: ");
+
+	fmt = printk_skip_level(fmt);
 
 	va_start(args, fmt);
 	printed = vsnprintf(printf_buf, sizeof(printf_buf), fmt, args);
@@ -100,7 +123,7 @@ efi_status_t efi_parse_options(char const *cmdline)
 		if (!strcmp(param, "nokaslr")) {
 			efi_nokaslr = true;
 		} else if (!strcmp(param, "quiet")) {
-			efi_quiet = true;
+			efi_loglevel = CONSOLE_LOGLEVEL_QUIET;
 		} else if (!strcmp(param, "noinitrd")) {
 			efi_noinitrd = true;
 		} else if (!strcmp(param, "efi") && val) {
@@ -114,6 +137,8 @@ efi_status_t efi_parse_options(char const *cmdline)
 				efi_disable_pci_dma = true;
 			if (parse_option_str(val, "no_disable_early_pci_dma"))
 				efi_disable_pci_dma = false;
+			if (parse_option_str(val, "debug"))
+				efi_loglevel = CONSOLE_LOGLEVEL_DEBUG;
 		} else if (!strcmp(param, "video") &&
 			   val && strstarts(val, "efifb:")) {
 			efi_parse_option_graphics(val + strlen("efifb:"));
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index caa7dcc71c69..3a323a009836 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -6,6 +6,7 @@
 #include <linux/compiler.h>
 #include <linux/efi.h>
 #include <linux/kernel.h>
+#include <linux/kern_levels.h>
 #include <linux/types.h>
 #include <asm/efi.h>
 
@@ -34,7 +35,7 @@
 extern bool efi_nochunk;
 extern bool efi_nokaslr;
 extern bool efi_noinitrd;
-extern bool efi_quiet;
+extern int efi_loglevel;
 extern bool efi_novamap;
 
 extern const efi_system_table_t *efi_system_table;
@@ -49,11 +50,12 @@ extern const efi_system_table_t *efi_system_table;
 
 #endif
 
-#define efi_info(msg)		do {			\
-	if (!efi_quiet) efi_puts("EFI stub: "msg);	\
-} while (0)
-
-#define efi_err(msg) efi_puts("EFI stub: ERROR: "msg)
+#define efi_info(fmt, ...) \
+	efi_printk(KERN_INFO fmt, ##__VA_ARGS__)
+#define efi_err(fmt, ...) \
+	efi_printk(KERN_ERR "ERROR: " fmt, ##__VA_ARGS__)
+#define efi_debug(fmt, ...) \
+	efi_printk(KERN_DEBUG "DEBUG: " fmt, ##__VA_ARGS__)
 
 /* Helper macros for the usual case of using simple C variables: */
 #ifndef fdt_setprop_inplace_var
