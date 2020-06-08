Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85AA01F171C
	for <lists+linux-efi@lfdr.de>; Mon,  8 Jun 2020 13:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729482AbgFHLAS (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 8 Jun 2020 07:00:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:51664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729426AbgFHLAK (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 8 Jun 2020 07:00:10 -0400
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E32C2078D
        for <linux-efi@vger.kernel.org>; Mon,  8 Jun 2020 11:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591614009;
        bh=n0uGReeUVgGTksapKV4CSuI+/1oRQ81FuBzBSanvME8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=wcOQaLSLGPaPnBcNTAt5HH0/Op6nNAcyvrioNHosMDmcNKwnJD8O50xmuzPgqIvEx
         GVpk8Q26yC+MM4wxsGnNnaVcrzL7Ji527WUfRyFMyw0B7OO35z708mDTPTuB1j+4lK
         DDryVwj+NqtnZwR1URpK2xAE+Nhx0Xyvi31Unq5E=
Received: by mail-oi1-f169.google.com with SMTP id 25so13935310oiy.13
        for <linux-efi@vger.kernel.org>; Mon, 08 Jun 2020 04:00:09 -0700 (PDT)
X-Gm-Message-State: AOAM530fUhWGFs0Z03L36yxtOGHRUWdePoaKnWUSIzq1NeFNJLGbbabp
        Z3GLfiVswEi2PGWWaGHKrAJoP3jgV4DAnEYKa6E=
X-Google-Smtp-Source: ABdhPJwgeMA7jgemk9F+bIo+nzOEBBVoAbpEymCCNNV1+nwb1i8kfL3mjChPiUYNCS5Ch/w6uIdbj9Ef7vm6RIBGJ2s=
X-Received: by 2002:aca:6144:: with SMTP id v65mr10081483oib.33.1591614008386;
 Mon, 08 Jun 2020 04:00:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200607135834.898294-1-ardb@kernel.org> <20200607135834.898294-2-ardb@kernel.org>
 <96a36110-68e1-89e3-2d59-b16f01abae21@gmx.de> <CAMj1kXG9XTtsyLQ=njM8LPCYCE2tOrrYQtctU_acNAxLfe=5oQ@mail.gmail.com>
 <f8a485d2-1e00-1d02-58a4-2e1684bfbfb4@gmx.de>
In-Reply-To: <f8a485d2-1e00-1d02-58a4-2e1684bfbfb4@gmx.de>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 8 Jun 2020 12:59:57 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEu2F_rACM00Dv2dicPPNqWVQxBD4-vKZoBdqHaJL5YYA@mail.gmail.com>
Message-ID: <CAMj1kXEu2F_rACM00Dv2dicPPNqWVQxBD4-vKZoBdqHaJL5YYA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] efi/arm: decompressor: deal with HYP mode boot gracefully
To:     Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <maz@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Chen-Yu Tsai <wens@csie.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, 8 Jun 2020 at 12:46, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 6/8/20 1:08 AM, Ard Biesheuvel wrote:
> > On Sun, 7 Jun 2020 at 19:24, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> >>
> >> On 6/7/20 3:58 PM, Ard Biesheuvel wrote:
> >>> EFI on ARM only supports short descriptors, and given that it mandates
> >>> that the MMU and caches are on, it is implied that booting in HYP mode
> >>> is not supported.
> >>>
> >>> However, implementations of EFI exist (i.e., U-Boot) that ignore this
> >>> requirement, which is not entirely unreasonable, given that it makes
> >>> HYP mode inaccessible to the operating system.
> >>>
> >>> So let's make sure that we can deal with this condition gracefully.
> >>> We already tolerate booting the EFI stub with the caches off (even
> >>> though this violates the EFI spec as well), and so we should deal
> >>> with HYP mode boot with MMU and caches either on or off.
> >>>
> >>> - When the MMU and caches are on, we can ignore the HYP stub altogether,
> >>>   since we can carry on executing at HYP. We do need to ensure that we
> >>>   disable the MMU at HYP before entering the kernel proper.
> >>>
> >>> - When the MMU and caches are off, we have to drop to SVC mode so that
> >>>   we can set up the page tables using short descriptors. In this case,
> >>>   we need to install the HYP stub as usual, so that we can return to HYP
> >>>   mode before handing over to the kernel proper.
> >>
> >> To me it is still unclear why you need this patch. Please, describe the
> >> problem this patch fixes.
> >>
> >> Is there any device that you cannot boot without the patch?
> >>
> >
> > The code as it is today is broken, and if it works, it only does so by accident.
> >
> > (There were some recent changes but the old code is broken in a similar way)
> >
> > When we enter via the stub, we used to call cache_off() to disable the
> > caches before calling the decompressor entry point. However, that
> > disables the SVC mode caches, not the HYP mode caches, and so if we
> > enter via EFI at HYP, we will call __hyp_stub_install() with the HYP
> > mod MMU and caches enabled, which is explicitly forbidden (see
> > hyp-stub.S)
> >
> > With the recent change, the EFI entry code doesn't call cache_off()
> > anymore, but that does not remove the problem, it just moves it to the
> > point where we hand over to the kernel proper.
> >
> > The problem is really on the u-boot side, and so we either have to
> > follow the letter of the EFI spec and ban the practice of booting in
> > HYP mode or with the caches off, or we work around this like I do in
> > this patch. Doing nothing is not really an option.
> >
> > If we want EBBR and U-boot as EFI firmware to succeed, we should
> > really fix issues such as these, and not pretend everything is fine
> > when we know it is broken but happens to work on the few boards that
> > we test. This is the reason we have architecture and firmware specs in
> > the first place, and it is really quite unfortunate that we did not
> > catch these u-boot issues before.
> >
> > As I said, I think booting at HYP can be tolerated, since the OS loses
> > access to it otherwise (and maybe we should even update the EFI spec
> > to allow this). But fiddling with the caches like we do should really
> > be avoided (and the GRUB hack really needs to go as well)
> >
> >
> >
> >>>
> >>> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> >>> ---
> >>>  arch/arm/boot/compressed/head.S | 61 ++++++++++++++++++++
> >>>  1 file changed, 61 insertions(+)
> >>>
> >>> diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
> >>> index c79db44ba128..3476e85c31e7 100644
> >>> --- a/arch/arm/boot/compressed/head.S
> >>> +++ b/arch/arm/boot/compressed/head.S
> >>> @@ -1410,7 +1410,11 @@ memdump:       mov     r12, r0
> >>>  __hyp_reentry_vectors:
> >>>               W(b)    .                       @ reset
> >>>               W(b)    .                       @ undef
> >>> +#ifdef CONFIG_EFI_STUB
> >>> +             W(b)    __enter_kernel_from_hyp @ hvc from HYP
> >>> +#else
> >>>               W(b)    .                       @ svc
> >>> +#endif
> >>>               W(b)    .                       @ pabort
> >>>               W(b)    .                       @ dabort
> >>>               W(b)    __enter_kernel          @ hyp
> >>> @@ -1429,14 +1433,71 @@ __enter_kernel:
> >>>  reloc_code_end:
> >>>
> >>>  #ifdef CONFIG_EFI_STUB
> >>> +__enter_kernel_from_hyp:
> >>> +             mrc     p15, 4, r0, c1, c0, 0   @ read HSCTLR
> >>> +             bic     r0, r0, #0x5            @ disable MMU and caches
> >>> +             mcr     p15, 4, r0, c1, c0, 0   @ write HSCTLR
> >>> +             isb
> >>> +             b       __enter_kernel
> >>> +
> >>>  ENTRY(efi_enter_kernel)
> >>>               mov     r4, r0                  @ preserve image base
> >>>               mov     r8, r1                  @ preserve DT pointer
> >>>
> >>> + ARM(                adrl    r0, call_cache_fn       )
> >>> + THUMB(              adr     r0, call_cache_fn       )
> >>> +             adr     r1, 0f                  @ clean the region of code we
> >>> +             bl      cache_clean_flush       @ may run with the MMU off
> >>> +
> >>> +#ifdef CONFIG_ARM_VIRT_EXT
> >>> +             @
> >>> +             @ The EFI spec does not support booting on ARM in HYP mode,
> >>> +             @ since it mandates that the MMU and caches are on, with all
> >>> +             @ 32-bit addressable DRAM mapped 1:1 using short descriptors.
> >>> +             @
> >>> +             @ While the EDK2 reference implementation adheres to this,
> >>> +             @ U-Boot might decide to enter the EFI stub in HYP mode
> >>> +             @ anyway, with the MMU and caches either on or off.
> >>> +             @
> >>> +             mrs     r0, cpsr                @ get the current mode
> >>> +             msr     spsr_cxsf, r0           @ record boot mode
> >>> +             and     r0, r0, #MODE_MASK      @ are we running in HYP mode?
> >>> +             cmp     r0, #HYP_MODE
> >>> +             bne     .Lefi_svc
> >>> +
> >>> +             mrc     p15, 4, r1, c1, c0, 0   @ read HSCTLR
> >>> +             tst     r1, #0x1                @ MMU enabled at HYP?
> >>> +             beq     1f
> >>> +
> >>> +             @
> >>> +             @ When running in HYP mode with the caches on, we're better
> >>> +             @ off just carrying on using the cached 1:1 mapping that the
> >>> +             @ firmware provided. Set up the HYP vectors so HVC instructions
> >>> +             @ issued from HYP mode take us to the correct handler code. We
> >>> +             @ will disable the MMU before jumping to the kernel proper.
> >>> +             @
> >>> +             adr     r0, __hyp_reentry_vectors
> >>> +             mcr     p15, 4, r0, c12, c0, 0  @ set HYP vector base (HVBAR)
> >>> +             isb
> >>> +             b       .Lefi_hyp
> >>> +
> >>> +             @
> >>> +             @ When running in HYP mode with the caches off, we need to drop
> >>> +             @ into SVC mode now, and let the decompressor set up its cached
> >>> +             @ 1:1 mapping as usual.
> >>> +             @
> >>> +1:           mov     r9, r4                  @ preserve image base
> >>> +             bl      __hyp_stub_install      @ install HYP stub vectors
> >>> +             safe_svcmode_maskall    r1      @ drop to SVC mode
> >>
> >> Are you returning to HYP mode somewhere?
> >>
> >
> > Yes.
> >
> >> What is the effect on PSCI?
> >>
> >
> > If you boot Linux in HYP then you cannot have PSCI in HYP as well.
> > Linux will take ownership of HYP mode, and remove whatever was there.
> > If you want to run PSCI at HYP, then the OS needs to boot in SVC mode.
> >
> >> The Allwinner/Sunxi boards must be booted in HYP mode to have PSCI
> >> according to https://linux-sunxi.org/PSCI
> >>
> >
> > See above. If PSCI runs in HYP, the OS needs to run at SVC
> >
> >> Did you test that you still can reboot those boards?
> >>
> >
> > No, I don't have such a board.
>
> Hello Ard,
>
> thanks for supplying a branch for testing:
> https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/log/?h=efi-arm-hyp-mode
>
> The OrangePi PC boots fine with this branch. PSCI is enabled. Rebooting
> the system works fine. See log below.
>

Thanks for testing!

> With the patch 2/2 you add an output line for the exceptions level and
> the MMU status. Above you state "We already tolerate booting the EFI
> stub with the caches off."

Indeed.

> This relates to a workaround in U-Boot
> accomodating old GRUB versions (CONFIG_EFI_GRUB_ARM32_WORKAROUND=y).
>

Not entirely. The GRUB hack disables the caches during
ExitBootServices() while the rest of the EFI stub runs with the caches
on. This is actually worse than simply never enabling the caches in
the first place. But we currently deal with both cases, by running the
decompressor's cache_on() routine in SVC mode.

> Would a further diagnostic line showing if D-cache and I-cache is
> enabled make sense?
>

Enabling the I-cache can be done independently, so it does not really
matter (you cannot have dirty cachelines in the I-cache, and
instruction fetches are special memory accesses that can be identified
as cacheable accesses to normal memory regardless of whether the MMU
is enabled and whether a mapping exists)

Enabling the D-cache only has an effect if you enable the MMU, as
otherwise, all data accesses will be implicitly qualified as
non-cacheable device accesses. Since EFI requires a 1:1 mapping, the
only reason for enabling the MMU in the first place is the ability to
enable the D-cache.

So in summary, the M bit is the interesting bit.

> Tested-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
>

Thanks.

> Loading Linux 5.7.0-armmp-lpae+ ...
> Loading initial ramdisk ...
> EFI stub: Running in HYP mode with MMU enabled
> EFI stub: Booting Linux Kernel...
> EFI stub: ERROR: Could not determine UEFI Secure Boot status.
> EFI stub: Using DTB from configuration table
> EFI stub: Exiting boot services and installing virtual address map...
> EHCI failed to shut down host controller.
> [    0.000000] Booting Linux on physical CPU 0x0
> [    0.000000] Linux version 5.7.0-armmp-lpae+ (user@node)
> (arm-linux-gnueabihf-gcc (Debian 9.3.0-13) 9.3.0, GNU ld (GNU Binutils
> for Debian) 2.34) #10 SMP Mon Jun 8 03:44:37 CEST 2020
> [    0.000000] CPU: ARMv7 Processor [410fc075] revision 5 (ARMv7),
> cr=30c5387d
> [    0.000000] CPU: div instructions available: patching division code
> [    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing
> instruction cache
> [    0.000000] OF: fdt: Machine model: Xunlong Orange Pi PC
> [    0.000000] Memory policy: Data cache writealloc
> [    0.000000] efi: EFI v2.80 by Das U-Boot
> [    0.000000] efi: RTPROP=0x78f30040 SMBIOS=0x78f2a000
> MEMRESERVE=0x6a1fa040
> [    0.000000] cma: Reserved 16 MiB at 0x000000007f000000
> [    0.000000] Zone ranges:
> [    0.000000]   DMA      [mem 0x0000000040000000-0x000000006fffffff]
> [    0.000000]   Normal   empty
> [    0.000000]   HighMem  [mem 0x0000000070000000-0x000000007fffffff]
> [    0.000000] Movable zone start for each node
> [    0.000000] Early memory node ranges
> [    0.000000]   node   0: [mem 0x0000000040000000-0x0000000078f07fff]
> [    0.000000]   node   0: [mem 0x0000000078f08000-0x0000000078f09fff]
> [    0.000000]   node   0: [mem 0x0000000078f0a000-0x0000000078f24fff]
> [    0.000000]   node   0: [mem 0x0000000078f25000-0x0000000078f28fff]
> [    0.000000]   node   0: [mem 0x0000000078f29000-0x0000000078f29fff]
> [    0.000000]   node   0: [mem 0x0000000078f2a000-0x0000000078f2afff]
> [    0.000000]   node   0: [mem 0x0000000078f2b000-0x0000000078f2cfff]
> [    0.000000]   node   0: [mem 0x0000000078f2d000-0x0000000078f2dfff]
> [    0.000000]   node   0: [mem 0x0000000078f2e000-0x0000000078f2ffff]
> [    0.000000]   node   0: [mem 0x0000000078f30000-0x0000000078f32fff]
> [    0.000000]   node   0: [mem 0x0000000078f33000-0x0000000078f33fff]
> [    0.000000]   node   0: [mem 0x0000000078f34000-0x0000000078f34fff]
> [    0.000000]   node   0: [mem 0x0000000078f35000-0x0000000078f35fff]
> [    0.000000]   node   0: [mem 0x0000000078f36000-0x0000000078f36fff]
> [    0.000000]   node   0: [mem 0x0000000078f37000-0x0000000078f38fff]
> [    0.000000]   node   0: [mem 0x0000000078f39000-0x0000000078f3efff]
> [    0.000000]   node   0: [mem 0x0000000078f3f000-0x000000007df65fff]
> [    0.000000]   node   0: [mem 0x000000007df66000-0x000000007df66fff]
> [    0.000000]   node   0: [mem 0x000000007df67000-0x000000007dfb9fff]
> [    0.000000]   node   0: [mem 0x000000007dfba000-0x000000007dfbcfff]
> [    0.000000]   node   0: [mem 0x000000007dfbd000-0x000000007fffffff]
> [    0.000000] Initmem setup node 0 [mem
> 0x0000000040000000-0x000000007fffffff]
> [    0.000000] psci: probing for conduit method from DT.
> [    0.000000] psci: Using PSCI v0.1 Function IDs from DT
