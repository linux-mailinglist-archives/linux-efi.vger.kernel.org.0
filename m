Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D0F51AC712
	for <lists+linux-efi@lfdr.de>; Thu, 16 Apr 2020 16:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394715AbgDPOsY (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 16 Apr 2020 10:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2394595AbgDPOsS (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 16 Apr 2020 10:48:18 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5409BC061A0C;
        Thu, 16 Apr 2020 07:48:18 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id o10so16537703qtr.6;
        Thu, 16 Apr 2020 07:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hqU3RukC+Wcy1beI5mHwFrne2ji8Zyuh2QqLhWnxtHQ=;
        b=fTo8UcmsXD7A4NEtK3NfBs49RNNLGi8bxg8SWycx2D/czAgWIQTTGo/VvyAmQ+0fYs
         kx+EfbJ7RyO56KbIZfrC5aCoJdh6TyLnlrfjp0NCPwAw6S57AU11ThPuH9nJQCdmG3H5
         dno7C3cer5UF4qIRAtg6tbFzFUPOZW7qfQntg6Cfe8S44N+OOUjhpylckOpPTPsxmKlX
         jiFwa3EbZgVlr/ngN8+zDaANiyc3pwcm5y4QmI055bj8g5IB7mHGaE7B09V3keALJFfJ
         7pUq8YICJvXL4P4/T4M2D19LkyOmkaPtzLHVqgwuqOB3dNezlTF8uWqEf/cJy+97EaNa
         xG9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=hqU3RukC+Wcy1beI5mHwFrne2ji8Zyuh2QqLhWnxtHQ=;
        b=MrWrKXKIj0jt2d83c9a7t8vMOBCjbUnDzk3VnrGXzaGlbI5+ZAi7lVr5zRvSlqQXZk
         /V6LswMkUjbWaRxk82wyQv2AwvgcZF8XZMd5lc3eTDjTVSbHe11ji9UgbLzYpsiOh4Ma
         o73aWBKuLJZm1x37V2Jz087ZwtxJMdABEhy5nnneGexdlXsufKz1BkpSmvHlTiYTnx9l
         96hWlTGUSBQNyEtWifRBl5MKB5PyDbRn33YvPk9hvjj1/gu3+RFlbyx8WmEM+AaZ7ZnQ
         bqGAt4tIvKMVxvOpzCsf9mjtQOP6LY6B+yDFD5QsilRyq/YOgMZnifb4wYG0dM28Jes+
         GWNw==
X-Gm-Message-State: AGi0PuZhqkMBoHLujRx4R3rOAs34zbzzymbwyVt5mqd4k1KLHbWhoZav
        pgIb0ahtKcyVWAP0xwa8T0g=
X-Google-Smtp-Source: APiQypJ9bGDSqwPsZ0XN/Iu2gtQIYZ2l4vmi9YmWye0Bcsk+dfXSmqg2MkX3IQZo0l71xMCmebXclg==
X-Received: by 2002:aed:3bf2:: with SMTP id s47mr15097558qte.126.1587048497317;
        Thu, 16 Apr 2020 07:48:17 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id o7sm2584717qkh.76.2020.04.16.07.48.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 07:48:16 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Thu, 16 Apr 2020 10:48:15 -0400
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        X86 ML <x86@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/5] efi/x86: Check for bad relocations
Message-ID: <20200416144815.GA3267283@rani.riverdale.lan>
References: <20200415221520.2692512-1-nivedita@alum.mit.edu>
 <20200415221520.2692512-6-nivedita@alum.mit.edu>
 <CAMj1kXFMMeYUPirY10JJfs31Z5GnHvUe=gLgG6SUJY9uWj588g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXFMMeYUPirY10JJfs31Z5GnHvUe=gLgG6SUJY9uWj588g@mail.gmail.com>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Apr 16, 2020 at 09:38:36AM +0200, Ard Biesheuvel wrote:
> On Thu, 16 Apr 2020 at 00:15, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> >
> > Add relocation checking for x86 as well to catch non-PC-relative
> > relocations that require runtime processing, since the EFI stub does not
> > do any runtime relocation processing.
> >
> > This will catch, for example, data relocations created by static
> > initializers of pointers.
> >
> > Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> > ---
> >  drivers/firmware/efi/libstub/Makefile | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
> > index 0bb2916eb12b..2aff59812a54 100644
> > --- a/drivers/firmware/efi/libstub/Makefile
> > +++ b/drivers/firmware/efi/libstub/Makefile
> > @@ -96,6 +96,8 @@ STUBCOPY_RELOC-$(CONFIG_ARM)  := R_ARM_ABS
> >  # .bss section here so it's easy to pick out in the linker script.
> >  #
> >  STUBCOPY_FLAGS-$(CONFIG_X86)   += --rename-section .bss=.bss.efistub,load,alloc
> > +STUBCOPY_RELOC-$(CONFIG_X86_32) := 'R_X86_32_(8|16|32)'
> 
> This should be R_386_xxx

Oops. I tested 64-bit but not 32-bit. I'll fix.

> 
> > +STUBCOPY_RELOC-$(CONFIG_X86_64) := 'R_X86_64_(8|16|32|32S|64)'
> >
> 
> ... and in general, I think we only need the native pointer sized ones, so
> 
> R_386_32
> R_X86_64_64

Ok.

> 
> >  $(obj)/%.stub.o: $(obj)/%.o FORCE
> >         $(call if_changed,stubcopy)
> > @@ -107,16 +109,14 @@ $(obj)/%.stub.o: $(obj)/%.o FORCE
> >  # this time, use objcopy and leave all sections in place.
> >  #
> >
> > -cmd_stubrelocs_check-y = /bin/true
> > -
> > -cmd_stubrelocs_check-$(CONFIG_EFI_ARMSTUB) =                           \
> > +cmd_stubrelocs_check =                                                 \
> >         $(STRIP) --strip-debug -o $@ $<;                                \
> > -       if $(OBJDUMP) -r $@ | grep $(STUBCOPY_RELOC-y); then            \
> > +       if $(OBJDUMP) -r $@ | grep -E $(STUBCOPY_RELOC-y); then         \
> 
> ... which means we don't need to -E either
> 
> >                 echo "$@: absolute symbol references not allowed in the EFI stub" >&2; \
> >                 /bin/false;                                             \
> >         fi
> >
> >  quiet_cmd_stubcopy = STUBCPY $@
> >        cmd_stubcopy =                                                   \
> > -       $(cmd_stubrelocs_check-y);                                      \
> > +       $(cmd_stubrelocs_check);                                        \
> >         $(OBJCOPY) $(STUBCOPY_FLAGS-y) $< $@
> > --
> > 2.24.1
> >
> 
> Could we fold this into the previous x86 patch, and drop the one that
> splits off the relocation check from stubcpy?

Will do.
