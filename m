Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03A281C3CF7
	for <lists+linux-efi@lfdr.de>; Mon,  4 May 2020 16:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729008AbgEDO1p (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 4 May 2020 10:27:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728706AbgEDO1p (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 4 May 2020 10:27:45 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41A9FC061A0E
        for <linux-efi@vger.kernel.org>; Mon,  4 May 2020 07:27:45 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id g16so10104146qtp.11
        for <linux-efi@vger.kernel.org>; Mon, 04 May 2020 07:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mkCio/dqAIxjQkhKCPx26U+/cqpqT818QmAgDYAPEbw=;
        b=AXPdFijlmSV6nWMwZGDdbWZnebX68JEGW6Y7G0sicr4PeFXt/lZ64YFo7XTB7V0SG9
         F5ZjEVq35BdG3KDkyaYpOcQOimhNav9JqP5Gw7BQxUCfFyc83n3BHkiq8DDpba3vmnYX
         egioi/R/D+ty1OvdjGVMuLeFpcGQVwcWkZRTcrthkFnl6tWfuaaY/lV/psX5YojrcMRk
         4OzBIvJRSwsPPX7cY0/vv8QLXtitraTrndgwtCeW4vJTVF8i93Z6L+sZEd3OrbUifaAf
         Iu9OPrwmmknGj2TKbIs0B0EORnj6jDh2zytolWm8SjY1ya9KsHwA7KHhZLOESjaOjGmJ
         mAbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=mkCio/dqAIxjQkhKCPx26U+/cqpqT818QmAgDYAPEbw=;
        b=sa7nra52B7O46ATpWXPK7cfAdjx4fhKOaCqT+ZfZnL0nFrb++SoY9OwX7y/j+YWk/0
         pJy9etpQGRrFArsmdUBBtk/XAPYMCXyQR6B8StB5ggOUnTO9fRjcy09mhfA4iWAdAjBX
         4BytdHhoem2uZH0LzXvvL5TySgCJG76wvFk0PEf+WSBR8dIYCjOkw6BT38qv2a5Sqg18
         36BmYde5+y0je+1ES9fhhM9Qn+fh/vNdzEA7cy1lHKW/AidwlSyb58VM5/cGrQUewqly
         Llqs4Z//JKaEjK9PqTMvMA9Om2owxFKdXpJKpPPmyp7RR/NoqI1SWDvYiqRpAwUECKG8
         lXSA==
X-Gm-Message-State: AGi0PuYby+RrqleUac/g/hUVcfrqorjCWgtP7oc9Su+y78dWw3Fvxkj1
        aqycoXDOmVvUxISbunS4pq+j5l6d4og=
X-Google-Smtp-Source: APiQypLIuaNXg4dRzhsVG0aj6U93pw29W9c1CE+IzLm+0Mq5PRxa00ARJq5plBUZURCN5zelEIeHhQ==
X-Received: by 2002:ac8:44d6:: with SMTP id b22mr17686549qto.366.1588602464263;
        Mon, 04 May 2020 07:27:44 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id j8sm11304798qtk.85.2020.05.04.07.27.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 07:27:43 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Mon, 4 May 2020 10:27:41 -0400
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        linux-efi <linux-efi@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 1/1] efi/libstub: Fix mixed mode boot issue after macro
 refactor
Message-ID: <20200504142741.GA21142@rani.riverdale.lan>
References: <20200503154507.82880-1-ardb@kernel.org>
 <20200504003852.1096018-1-nivedita@alum.mit.edu>
 <20200504003852.1096018-2-nivedita@alum.mit.edu>
 <CAMj1kXHqt2h+6EUoQ4qquX5zUJDKpg5MhXaGQcdVguNcOHrZ+A@mail.gmail.com>
 <20200504140234.GA2943621@rani.riverdale.lan>
 <CAMj1kXEjvRkcZ7_J9zVbqFoZsRfbDA8c_xyHRM+je2njHeDEMQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXEjvRkcZ7_J9zVbqFoZsRfbDA8c_xyHRM+je2njHeDEMQ@mail.gmail.com>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, May 04, 2020 at 04:15:59PM +0200, Ard Biesheuvel wrote:
> On Mon, 4 May 2020 at 16:02, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> >
> > On Mon, May 04, 2020 at 10:05:23AM +0200, Ard Biesheuvel wrote:
> > > On Mon, 4 May 2020 at 02:38, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> > > >
> > > > Commit
> > > >   22090f84bc3f ("efi/libstub: unify EFI call wrappers for non-x86")
> > > >
> > > > refactored the macros that are used to provide wrappers for mixed-mode
> > > > calls on x86, allowing us to boot a 64-bit kernel on 32-bit firmware.
> > > >
> > > > Unfortunately, this broke mixed mode boot due to the fact that
> > > > efi_is_native() is not a macro on x86.
> > > >
> > > > Fix this by conditioning the generic macro definitions on
> > > > CONFIG_EFI_MIXED, and removing the wrapper definitions on x86 if
> > > > CONFIG_EFI_MIXED is not enabled.
> > > >
> > > > Reported-by: Guenter Roeck <linux@roeck-us.net>
> > > > Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> > >
> > > Thanks Arvind.
> > >
> > > Currently, CONFIG_EFI_MIXED is never referenced outside of arch/x86,
> > > and I prefer to keep it that way.
> >
> > All these macros go together though -- they should either all be defined
> > or none, so it makes sense to put them under a single #if.
> 
> True.
> 
> > If you think
> > it's possible that a future architecture might need the wrappers but not
> > be mixed, we could maybe add an ARCH_NEEDS_EFISTUB_WRAPPERS?
> >
> 
> Well, remember that x86 used wrappers for native invocations only two
> releases ago, but that was mainly because of the SysV vs MS ABI issue,
> so the issue could emerge again, but it is unlikely.
> 

Yep.

Would the below be more palatable?

diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
index cd0c3fbf6156..6b9ab0d8b2a7 100644
--- a/arch/x86/include/asm/efi.h
+++ b/arch/x86/include/asm/efi.h
@@ -225,13 +225,15 @@ efi_status_t efi_set_virtual_address_map(unsigned long memory_map_size,
 
 /* arch specific definitions used by the stub code */
 
-extern const bool efi_is64;
+#ifdef CONFIG_EFI_MIXED
+
+#define ARCH_HAS_EFISTUB_WRAPPERS
 
 static inline bool efi_is_64bit(void)
 {
-	if (IS_ENABLED(CONFIG_EFI_MIXED))
-		return efi_is64;
-	return IS_ENABLED(CONFIG_X86_64);
+	extern const bool efi_is64;
+
+	return efi_is64;
 }
 
 static inline bool efi_is_native(void)
@@ -356,6 +358,15 @@ static inline u32 efi64_convert_status(efi_status_t status)
 						   runtime),		\
 				    func, __VA_ARGS__))
 
+#else /* CONFIG_EFI_MIXED */
+
+static inline bool efi_is_64bit(void)
+{
+	return IS_ENABLED(CONFIG_X86_64);
+}
+
+#endif /* CONFIG_EFI_MIXED */
+
 extern bool efi_reboot_required(void);
 extern bool efi_is_table_address(unsigned long phys_addr);
 
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index 874233cf8820..4f10a09563f3 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -33,20 +33,14 @@ extern bool efi_novamap;
 
 extern const efi_system_table_t *efi_system_table;
 
-#ifndef efi_bs_call
+#ifndef ARCH_HAS_EFISTUB_WRAPPERS
+
+#define efi_is_native()		(true)
 #define efi_bs_call(func, ...)	efi_system_table->boottime->func(__VA_ARGS__)
-#endif
-#ifndef efi_rt_call
 #define efi_rt_call(func, ...)	efi_system_table->runtime->func(__VA_ARGS__)
-#endif
-#ifndef efi_is_native
-#define efi_is_native()		(true)
-#endif
-#ifndef efi_table_attr
 #define efi_table_attr(inst, attr)	(inst->attr)
-#endif
-#ifndef efi_call_proto
 #define efi_call_proto(inst, func, ...) inst->func(inst, ##__VA_ARGS__)
+
 #endif
 
 #define efi_info(msg)		do {			\
