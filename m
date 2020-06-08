Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 406E81F11E0
	for <lists+linux-efi@lfdr.de>; Mon,  8 Jun 2020 05:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728922AbgFHDtT (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 7 Jun 2020 23:49:19 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38807 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728916AbgFHDtS (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 7 Jun 2020 23:49:18 -0400
Received: by mail-lj1-f193.google.com with SMTP id 9so8991045ljv.5
        for <linux-efi@vger.kernel.org>; Sun, 07 Jun 2020 20:49:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=99royjoNyDZtdwPmO0MM6XK8PvsJuyMl1pHTzirSgjc=;
        b=Bgq72F+tFPzbE0qtNyvJexFo+UEfxE8nNUAEQfFXFZ6xTIlUqTK34pa+DTNYrtq4rN
         fQ7qVJGM05XLOu59HG6UoByp31yj1agPH1kwHUZfL4Nf7gtsQFuHHOhchPYlQwcDtWbM
         s8NU9xiyt+FiOcltlVMC/3gy6YOD548J/SOiUj999LIww26M9C1TqJ1EfhgFLs5CiYX1
         csHBZK7bfN9MMAGLxEnvrxCX18S8kb4vA8DDGHaDEx6dy8UeKWI/V1lFMJmpnzpNL9Vr
         xu0KrFF1qYWIdtwekNifq9E5wuoJ2UMGDJPcyDFCoblyhnvk8jvNplV1Ki8298JgyHNd
         jTSg==
X-Gm-Message-State: AOAM532wAuqUvX48hkyEpurKJSaxoBZEipkLOMt5WLCgOtAnHtfp3feg
        iHFnCJEw2p8WW8SkWZ70lqBu645ZVwU=
X-Google-Smtp-Source: ABdhPJzoKcNLJMnBCwAF9or8JS1o45HTDa7kO+4eTY9chiTGXpI1yf4K7Qo4xac88OYqd1Ski+WUgA==
X-Received: by 2002:a2e:9d98:: with SMTP id c24mr9204494ljj.17.1591588154995;
        Sun, 07 Jun 2020 20:49:14 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id o4sm4102159lfb.75.2020.06.07.20.49.14
        for <linux-efi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Jun 2020 20:49:14 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id z206so9326014lfc.6
        for <linux-efi@vger.kernel.org>; Sun, 07 Jun 2020 20:49:14 -0700 (PDT)
X-Received: by 2002:ac2:5cd1:: with SMTP id f17mr10772045lfq.4.1591588154162;
 Sun, 07 Jun 2020 20:49:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200607135834.898294-1-ardb@kernel.org> <20200607135834.898294-2-ardb@kernel.org>
 <96a36110-68e1-89e3-2d59-b16f01abae21@gmx.de> <CAMj1kXG9XTtsyLQ=njM8LPCYCE2tOrrYQtctU_acNAxLfe=5oQ@mail.gmail.com>
In-Reply-To: <CAMj1kXG9XTtsyLQ=njM8LPCYCE2tOrrYQtctU_acNAxLfe=5oQ@mail.gmail.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Mon, 8 Jun 2020 11:49:02 +0800
X-Gmail-Original-Message-ID: <CAGb2v67m7AgM4A4Jc00Da95ovCyfircPO8vEgtCGpfPcF7jSLQ@mail.gmail.com>
Message-ID: <CAGb2v67m7AgM4A4Jc00Da95ovCyfircPO8vEgtCGpfPcF7jSLQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] efi/arm: decompressor: deal with HYP mode boot gracefully
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Heinrich Schuchardt <xypron.glpk@gmx.de>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <maz@kernel.org>,
        Russell King <linux@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Jun 8, 2020 at 7:09 AM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Sun, 7 Jun 2020 at 19:24, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> >
> > On 6/7/20 3:58 PM, Ard Biesheuvel wrote:
> > > EFI on ARM only supports short descriptors, and given that it mandates
> > > that the MMU and caches are on, it is implied that booting in HYP mode
> > > is not supported.
> > >
> > > However, implementations of EFI exist (i.e., U-Boot) that ignore this
> > > requirement, which is not entirely unreasonable, given that it makes
> > > HYP mode inaccessible to the operating system.
> > >
> > > So let's make sure that we can deal with this condition gracefully.
> > > We already tolerate booting the EFI stub with the caches off (even
> > > though this violates the EFI spec as well), and so we should deal
> > > with HYP mode boot with MMU and caches either on or off.
> > >
> > > - When the MMU and caches are on, we can ignore the HYP stub altogether,
> > >   since we can carry on executing at HYP. We do need to ensure that we
> > >   disable the MMU at HYP before entering the kernel proper.
> > >
> > > - When the MMU and caches are off, we have to drop to SVC mode so that
> > >   we can set up the page tables using short descriptors. In this case,
> > >   we need to install the HYP stub as usual, so that we can return to HYP
> > >   mode before handing over to the kernel proper.
> >
> > To me it is still unclear why you need this patch. Please, describe the
> > problem this patch fixes.
> >
> > Is there any device that you cannot boot without the patch?
> >
>
> The code as it is today is broken, and if it works, it only does so by accident.
>
> (There were some recent changes but the old code is broken in a similar way)
>
> When we enter via the stub, we used to call cache_off() to disable the
> caches before calling the decompressor entry point. However, that
> disables the SVC mode caches, not the HYP mode caches, and so if we
> enter via EFI at HYP, we will call __hyp_stub_install() with the HYP
> mod MMU and caches enabled, which is explicitly forbidden (see
> hyp-stub.S)
>
> With the recent change, the EFI entry code doesn't call cache_off()
> anymore, but that does not remove the problem, it just moves it to the
> point where we hand over to the kernel proper.
>
> The problem is really on the u-boot side, and so we either have to
> follow the letter of the EFI spec and ban the practice of booting in
> HYP mode or with the caches off, or we work around this like I do in
> this patch. Doing nothing is not really an option.
>
> If we want EBBR and U-boot as EFI firmware to succeed, we should
> really fix issues such as these, and not pretend everything is fine
> when we know it is broken but happens to work on the few boards that
> we test. This is the reason we have architecture and firmware specs in
> the first place, and it is really quite unfortunate that we did not
> catch these u-boot issues before.
>
> As I said, I think booting at HYP can be tolerated, since the OS loses
> access to it otherwise (and maybe we should even update the EFI spec
> to allow this). But fiddling with the caches like we do should really
> be avoided (and the GRUB hack really needs to go as well)
>
>
>
> > >
> > > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > > ---
> > >  arch/arm/boot/compressed/head.S | 61 ++++++++++++++++++++
> > >  1 file changed, 61 insertions(+)
> > >
> > > diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
> > > index c79db44ba128..3476e85c31e7 100644
> > > --- a/arch/arm/boot/compressed/head.S
> > > +++ b/arch/arm/boot/compressed/head.S
> > > @@ -1410,7 +1410,11 @@ memdump:       mov     r12, r0
> > >  __hyp_reentry_vectors:
> > >               W(b)    .                       @ reset
> > >               W(b)    .                       @ undef
> > > +#ifdef CONFIG_EFI_STUB
> > > +             W(b)    __enter_kernel_from_hyp @ hvc from HYP
> > > +#else
> > >               W(b)    .                       @ svc
> > > +#endif
> > >               W(b)    .                       @ pabort
> > >               W(b)    .                       @ dabort
> > >               W(b)    __enter_kernel          @ hyp
> > > @@ -1429,14 +1433,71 @@ __enter_kernel:
> > >  reloc_code_end:
> > >
> > >  #ifdef CONFIG_EFI_STUB
> > > +__enter_kernel_from_hyp:
> > > +             mrc     p15, 4, r0, c1, c0, 0   @ read HSCTLR
> > > +             bic     r0, r0, #0x5            @ disable MMU and caches
> > > +             mcr     p15, 4, r0, c1, c0, 0   @ write HSCTLR
> > > +             isb
> > > +             b       __enter_kernel
> > > +
> > >  ENTRY(efi_enter_kernel)
> > >               mov     r4, r0                  @ preserve image base
> > >               mov     r8, r1                  @ preserve DT pointer
> > >
> > > + ARM(                adrl    r0, call_cache_fn       )
> > > + THUMB(              adr     r0, call_cache_fn       )
> > > +             adr     r1, 0f                  @ clean the region of code we
> > > +             bl      cache_clean_flush       @ may run with the MMU off
> > > +
> > > +#ifdef CONFIG_ARM_VIRT_EXT
> > > +             @
> > > +             @ The EFI spec does not support booting on ARM in HYP mode,
> > > +             @ since it mandates that the MMU and caches are on, with all
> > > +             @ 32-bit addressable DRAM mapped 1:1 using short descriptors.
> > > +             @
> > > +             @ While the EDK2 reference implementation adheres to this,
> > > +             @ U-Boot might decide to enter the EFI stub in HYP mode
> > > +             @ anyway, with the MMU and caches either on or off.
> > > +             @
> > > +             mrs     r0, cpsr                @ get the current mode
> > > +             msr     spsr_cxsf, r0           @ record boot mode
> > > +             and     r0, r0, #MODE_MASK      @ are we running in HYP mode?
> > > +             cmp     r0, #HYP_MODE
> > > +             bne     .Lefi_svc
> > > +
> > > +             mrc     p15, 4, r1, c1, c0, 0   @ read HSCTLR
> > > +             tst     r1, #0x1                @ MMU enabled at HYP?
> > > +             beq     1f
> > > +
> > > +             @
> > > +             @ When running in HYP mode with the caches on, we're better
> > > +             @ off just carrying on using the cached 1:1 mapping that the
> > > +             @ firmware provided. Set up the HYP vectors so HVC instructions
> > > +             @ issued from HYP mode take us to the correct handler code. We
> > > +             @ will disable the MMU before jumping to the kernel proper.
> > > +             @
> > > +             adr     r0, __hyp_reentry_vectors
> > > +             mcr     p15, 4, r0, c12, c0, 0  @ set HYP vector base (HVBAR)
> > > +             isb
> > > +             b       .Lefi_hyp
> > > +
> > > +             @
> > > +             @ When running in HYP mode with the caches off, we need to drop
> > > +             @ into SVC mode now, and let the decompressor set up its cached
> > > +             @ 1:1 mapping as usual.
> > > +             @
> > > +1:           mov     r9, r4                  @ preserve image base
> > > +             bl      __hyp_stub_install      @ install HYP stub vectors
> > > +             safe_svcmode_maskall    r1      @ drop to SVC mode
> >
> > Are you returning to HYP mode somewhere?
> >
>
> Yes.
>
> > What is the effect on PSCI?
> >
>
> If you boot Linux in HYP then you cannot have PSCI in HYP as well.
> Linux will take ownership of HYP mode, and remove whatever was there.
> If you want to run PSCI at HYP, then the OS needs to boot in SVC mode.
>
> > The Allwinner/Sunxi boards must be booted in HYP mode to have PSCI
> > according to https://linux-sunxi.org/PSCI
> >
>
> See above. If PSCI runs in HYP, the OS needs to run at SVC

Heinrich probably misunderstood this. That page is saying that for PSCI
to be available to Linux, U-boot must be booting Linux in non-secure mode.
That is because the PSCI implementation runs in secure monitor mode under
Linux. Linux can boot in HYP or SVC as it so chooses.

> > Did you test that you still can reboot those boards?
> >
>
> No, I don't have such a board.

I'm not sure what reboot has to do with this, since the U-boot PSCI
implementation for sunxi does not support reboot or power-off. It only
supports CPU power on and off. The whole reason for this is to support
SMP in a way that HYP mode can be used.

Hope this clears things up. I'm not familiar with the specifics of
EFI nor do I use it in my setup.


Regards
ChenYu

> > Cc: Chen-Yu Tsai <wens@csie.org>
> >     (maintainer ARM/Allwinner sunXi SoC support)
> >
> > Best regards
> >
> > Heinrich
> >
> > > +             orr     r4, r9, #1              @ restore image base and set LSB
> > > +             b       .Lefi_hyp
> > > +.Lefi_svc:
> > > +#endif
> > >               mrc     p15, 0, r0, c1, c0, 0   @ read SCTLR
> > >               tst     r0, #0x1                @ MMU enabled?
> > >               orreq   r4, r4, #1              @ set LSB if not
> > >
> > > +.Lefi_hyp:
> > >               mov     r0, r8                  @ DT start
> > >               add     r1, r8, r2              @ DT end
> > >               bl      cache_clean_flush
> > >
> >
