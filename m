Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 021AE1EF813
	for <lists+linux-efi@lfdr.de>; Fri,  5 Jun 2020 14:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbgFEMje (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 5 Jun 2020 08:39:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:42432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726409AbgFEMjd (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 5 Jun 2020 08:39:33 -0400
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B133A206DC
        for <linux-efi@vger.kernel.org>; Fri,  5 Jun 2020 12:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591360772;
        bh=lrmwQwigYJIHtwdWmFVstgehot+bX/c2F/U0hfdY/IM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QG6M0yEUgO4zU7IpPttDpOynCE2wjfhTe5m6uXWYYLkgVKV47L7YOTE7Aux/bOfIZ
         bBStMpH2yel06iOylz9WVsgYnWbSjWJEIUgDQSb5+8NTm1kjsrE3DnhbijpzKYmTAb
         SzBA8UmhRYGuOUqY3nraqxj2DSivxZP4pUtVJ4AE=
Received: by mail-ot1-f51.google.com with SMTP id e5so7444677ote.11
        for <linux-efi@vger.kernel.org>; Fri, 05 Jun 2020 05:39:32 -0700 (PDT)
X-Gm-Message-State: AOAM533+j+/yBn9vHV+4gKnmXopvHCwpmnudQjpN9YyOZE5A60smn1cO
        mjxW+T2s7GdzyMtBA+3TyoMCoMS1jVH83jsIbUA=
X-Google-Smtp-Source: ABdhPJxL1vpTKa4SiVHNF4jxlFEr/kwtXV7kNMCaO7IcFlH+CQxPRNa0YigyJ10hiIsizeJtJfVdoSbTavgA+E0IP80=
X-Received: by 2002:a9d:476:: with SMTP id 109mr7998548otc.77.1591360771988;
 Fri, 05 Jun 2020 05:39:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200605115200.413921-1-ardb@kernel.org> <4498d910-f5cb-8559-afba-34710e9ca730@gmx.de>
In-Reply-To: <4498d910-f5cb-8559-afba-34710e9ca730@gmx.de>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 5 Jun 2020 14:39:20 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHS8AVczRPzySgzkkztD0yT1MXnCyMwmOt=ihZ9Bvo0vQ@mail.gmail.com>
Message-ID: <CAMj1kXHS8AVczRPzySgzkkztD0yT1MXnCyMwmOt=ihZ9Bvo0vQ@mail.gmail.com>
Subject: Re: [PATCH] efi/arm: decompressor: deal with HYP mode boot gracefully
To:     Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <maz@kernel.org>,
        Russell King <linux@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 5 Jun 2020 at 14:20, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 05.06.20 13:52, Ard Biesheuvel wrote:
> > EFI on ARM only supports short descriptors, and given that it mandates
> > that the MMU and caches are on, it is implied that booting in HYP mode
> > is not supported.
> >
> > However, implementations of EFI exist (i.e., U-Boot) that ignore this
> > requirement, which is not entirely unreasonable, given that it does
> > not make a lot of sense to begin with.
>
> Hello Ard,
>
> thanks for investigating the differences between EDK2 and U-Boot.
>
> What I still do not understand is if there is a bug in U-Boot where
> U-Boot does not conform to the UEFI specification? In this case I would
> expect a fix in U-Boot.
>

U-Boot violates the EFI spec, yes. The spec is very clear on how the
MMU is configured, and this rules out booting with the caches off, or
booting in HYP mode.

However, given that this is the situation today, we still need to deal
with it on the Linux side.
In parallel, fixing it in U-boot may be appropriate. However, I think
the EFI spec is too detailed here - instead of 'booting at the highest
non-secure privilege mode', it tells you which exact bits to set in
SCTLR, which seems overzealous to me. In other words, even though it
violates the letter of the spec, I don't mind dealing with this
exception in the Linux side, since the requirement is somewhat
unreasonable to begin with.

> Or is it simply a deficiency of Linux that it does not properly support
> HYP/EL2 mode on 32-bit ARM?
>

No, this is definitely not the fault of Linux.

> Up to now I never experience a problem booting a 32bit board via U-Boot
> -> GRUB-EFI -> Linux. Where did you have a problem when booting via
> U-Boot's UEFI implementation and the current Linux kernel?
>

I haven't managed to make it fail, but my only 32-bit HYP capable
platform is QEMU. I am not 100% convinced that the EFI+HYP+U-Boot case
is rock solid, and I may have gotten lucky with QEMU (which uses
emulation not virtualization when running at HYP)

Do you have any A7/A15 based boards that don't print 'WARNING: Caches
not enabled' at boot?

> Does this patch relate to the retirement of KVM on 32 ARM in Linux 5.7
> 541ad0150ca4 ("arm: Remove 32bit KVM host support")? Without that patch
> I would have expected Linux to work fine in HYP mode.
>

Not really. The code still has to deal with booting at HYP mode,
regardless of whether it is used in a useful way.

I suppose simply dropping to SVC in the decompressor might make sense
as well, given that booting the kernel at HYP doesn't buy you anything
anymore in the first place. Marc may have some thoughts on that, but
it is really a separate discussion.


>
> >
> > So let's make sure that we can deal with this condition gracefully.
> > We already tolerate booting the EFI stub with the caches off (even
> > though this violates the EFI spec as well), and so we should deal
> > with HYP mode boot with MMU and caches either on or off.
> >
> > - When the MMU and caches are on, we can ignore the HYP stub altogether,
> >   since we can just use the existing mappings, and just branch into
> >   the decompressed kernel as usual after disabling MMU and caches.
> >
> > - When the MMU and caches are off, we have to drop to SVC mode so that
> >   we can set up the page tables using short descriptors. In this case,
> >   we need to install the HYP stub so that we can return to HYP mode
> >   when handing over to the kernel proper.
> >
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
> >  arch/arm/boot/compressed/head.S | 29 +++++++++++++++++++++++++++++
> >  1 file changed, 29 insertions(+)
> >
> > diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
> > index c79db44ba128..986db86ba334 100644
> > --- a/arch/arm/boot/compressed/head.S
> > +++ b/arch/arm/boot/compressed/head.S
> > @@ -1436,6 +1436,35 @@ ENTRY(efi_enter_kernel)
> >               mrc     p15, 0, r0, c1, c0, 0   @ read SCTLR
> >               tst     r0, #0x1                @ MMU enabled?
> >               orreq   r4, r4, #1              @ set LSB if not
> > +#ifdef CONFIG_ARM_VIRT_EXT
> > +             @
> > +             @ The EFI spec does not support booting on ARM in HYP mode,
> > +             @ since it mandates that the MMU and caches are on, with all
> > +             @ 32-bit addressable DRAM mapped 1:1 using short descriptors.
> > +             @ While the EDK2 reference implementation adheres to this,
> > +             @ U-Boot might decide to enter the EFI stub in HYP mode anyway,
> > +             @ with the MMU and caches either on or off.
> > +             @ In the former case, we're better off just carrying on using
> > +             @ the cached 1:1 mapping that the firmware provided, and pretend
> > +             @ that we are in SVC mode as far as the decompressor is
> > +             @ concerned. However, if the caches are off, we need to drop
> > +             @ into SVC mode now, and let the decompressor set up its cached
> > +             @ 1:1 mapping as usual.
> > +             @
> > +             mov     r0, #SVC_MODE
> > +             msr     spsr_cxsf, r0           @ record that we are in SVC mode
> > +             bne     1f                      @ skip HYP stub install if MMU is on
> > +
> > +             mov     r9, r4                  @ preserve image base
> > +             bl      __hyp_stub_install      @ returns boot mode in r4
> > +             cmp     r4, #HYP_MODE           @ did we boot in HYP?
> > +             bne     1f                      @ skip drop to SVC if we did not
> > +
> > +             safe_svcmode_maskall    r0
> > +             msr     spsr_cxsf, r4           @ record boot mode
> > +             mov     r4, r9                  @ restore image base
> > +1:
> > +#endif
> >
> >               mov     r0, r8                  @ DT start
> >               add     r1, r8, r2              @ DT end
> >
>
