Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 568FB162B2B
	for <lists+linux-efi@lfdr.de>; Tue, 18 Feb 2020 17:57:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbgBRQ5G (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 18 Feb 2020 11:57:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:34826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726402AbgBRQ5G (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 18 Feb 2020 11:57:06 -0500
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B2B2D2176D
        for <linux-efi@vger.kernel.org>; Tue, 18 Feb 2020 16:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582045025;
        bh=EanJAAvEgSiOHCaZxZbqDaGusElgxY/8RtPFrcnuP9c=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UEJZy2BwPtNBWEqEtSGNPWI2+rWEcxYJKg6jpNKszoXMO1bQ+ynlDXrhtzIROFVpQ
         X3DmUMBRBrXcKDYeLSBGRWYoQd7A6CynE4wdiX8qtlZ5kVbMD37NEAanFEXRULJFjm
         UzDq+VkucS5cPCjipGreIESkaObMaHXmdxbsHviQ=
Received: by mail-wr1-f51.google.com with SMTP id w12so24837103wrt.2
        for <linux-efi@vger.kernel.org>; Tue, 18 Feb 2020 08:57:04 -0800 (PST)
X-Gm-Message-State: APjAAAXZrN9LMO8xk9NCEoM31ohz4DX/4tSVBQQ4IXerMLs0bxFxqv5Y
        hszi2TZitVLq9LAaajtkK5wJCmWmBr/FJeeWL4UghQ==
X-Google-Smtp-Source: APXvYqwDyOZAFZTz+otYgJPGv989NxmoXRxXRTBrfdZ613hi2pStNCnZ1OKHqfXjImiPtyTv3/WWMWQkUYm8E7LWHdQ=
X-Received: by 2002:a5d:65cf:: with SMTP id e15mr29549257wrw.126.1582045023057;
 Tue, 18 Feb 2020 08:57:03 -0800 (PST)
MIME-Version: 1.0
References: <20200218164430.32671-1-ardb@kernel.org> <20200218164430.32671-2-ardb@kernel.org>
 <20200218165149.GK25745@shell.armlinux.org.uk>
In-Reply-To: <20200218165149.GK25745@shell.armlinux.org.uk>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 18 Feb 2020 17:56:52 +0100
X-Gmail-Original-Message-ID: <CAKv+Gu_90hPPupcPCkURqBe2xFO0Zv96egytOPcqLF5XLf-rbQ@mail.gmail.com>
Message-ID: <CAKv+Gu_90hPPupcPCkURqBe2xFO0Zv96egytOPcqLF5XLf-rbQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] ARM: decompressor: prepare cache_clean_flush for
 doing by-VA maintenance
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <maz@kernel.org>,
        Nicolas Pitre <nico@fluxnic.net>,
        Catalin Marinas <catalin.marinas@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 18 Feb 2020 at 17:52, Russell King - ARM Linux admin
<linux@armlinux.org.uk> wrote:
>
> On Tue, Feb 18, 2020 at 05:44:29PM +0100, Ard Biesheuvel wrote:
> > In preparation of turning the decompressor's cache clean/flush
> > operations into proper by-VA maintenance for v7 cores, pass the
> > start and end addresses of the regions that need cache maintenance
> > into cache_clean_flush in registers r0 and r1.
>
> Where's the documentation of the new calling convention?  This is
> assembly code, it needs such things documented as there's no
> function prototypes to give that information.
>

Would something like

diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
index df93c9f0a19a..e4c779a89db1 100644
--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -1207,6 +1207,9 @@ __armv7_mmu_cache_off:
 /*
  * Clean and flush the cache to maintain consistency.
  *
+ * On entry,
+ *  r0 = start address
+ *  r1 = end address (exclusive)
  * On exit,
  *  r1, r2, r3, r9, r10, r11, r12 corrupted
  * This routine must preserve:

work for you?

> >
> > Currently, all implementations of cache_clean_flush ignore these
> > values, so no functional change is expected as a result of this
> > patch.
> >
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
> >  arch/arm/boot/compressed/head.S | 28 +++++++++++++++++---
> >  1 file changed, 25 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
> > index 7b86a2e1acce..935799b92198 100644
> > --- a/arch/arm/boot/compressed/head.S
> > +++ b/arch/arm/boot/compressed/head.S
> > @@ -525,12 +525,15 @@ dtb_check_done:
> >               /* cache_clean_flush may use the stack, so relocate it */
> >               add     sp, sp, r6
> >  #endif
> > -
> > +             mov     r0, r9
> > +             ldr     r1, 0f
> > +             add     r1, r1, r0
> >               bl      cache_clean_flush
> >
> >               badr    r0, restart
> >               add     r0, r0, r6
> >               mov     pc, r0
> > +0:           .long   _edata - restart
> >
> >  wont_overwrite:
> >  /*
> > @@ -622,6 +625,21 @@ not_relocated:   mov     r0, #0
> >               add     r2, sp, #0x10000        @ 64k max
> >               mov     r3, r7
> >               bl      decompress_kernel
> > +
> > +             mov     r0, r4                  @ base of inflated image
> > +             adr     r1, LC0                 @ actual LC0
> > +             ldr     r2, [r1]                @ linktime LC0
> > +             sub     r2, r1, r2              @ LC0 delta
> > +             ldr     r1, [r1, #16]           @ link time inflated size offset
> > +             ldr     r1, [r1, r2]            @ actual inflated size (LE)
> > +#ifdef __ARMEB__
> > +             /* convert to big endian */
> > +             eor     r2, r1, r1, ror #16
> > +             bic     r2, r2, #0x00ff0000
> > +             mov     r1, r1, ror #8
> > +             eor     r1, r1, r2, lsr #8
> > +#endif
> > +             add     r1, r1, r0              @ end of inflated image
> >               bl      cache_clean_flush
> >               bl      cache_off
> >
> > @@ -1439,6 +1457,7 @@ reloc_code_end:
> >  #ifdef CONFIG_EFI_STUB
> >               .align  2
> >  _start:              .long   start - .
> > +__edata:     .long   _edata - .
> >
> >  ENTRY(efi_stub_entry)
> >               @ allocate space on stack for passing current zImage address
> > @@ -1470,8 +1489,11 @@ ENTRY(efi_stub_entry)
> >               .align  2
> >  0:           .long   start - (. + 4)
> >
> > -             @ Preserve return value of efi_entry() in r4
> > -             mov     r4, r0
> > +             mov     r4, r0                          @ preserve DTB pointer
> > +             mov     r0, r1                          @ start of image
> > +             adr     r2, __edata
> > +             ldr     r1, [r2]
> > +             add     r1, r1, r2                      @ end of image
> >               bl      cache_clean_flush
> >               bl      cache_off
> >
> > --
> > 2.17.1
> >
> >
>
> --
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
> According to speedtest.net: 11.9Mbps down 500kbps up
