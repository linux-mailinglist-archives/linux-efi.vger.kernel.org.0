Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8658968A645
	for <lists+linux-efi@lfdr.de>; Fri,  3 Feb 2023 23:42:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232375AbjBCWmS (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 3 Feb 2023 17:42:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231176AbjBCWmR (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 3 Feb 2023 17:42:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 474C420D00
        for <linux-efi@vger.kernel.org>; Fri,  3 Feb 2023 14:42:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E5367B82C2A
        for <linux-efi@vger.kernel.org>; Fri,  3 Feb 2023 22:42:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C519C4339C
        for <linux-efi@vger.kernel.org>; Fri,  3 Feb 2023 22:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675464133;
        bh=JF9Wewg3wNKjzA+CEwhwbU/2GyLw7MCyQYy76vcX99c=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OygSy3+heO1d7IWEn3BLzQmuPly60Hf7OUCh43VMWn7gT9U2yTSDVh9tVDeWW2O2V
         7Mb1iczLS+ekTt/rhCp4LPlVU8m7p+eLdkYPK3kNOWG8JYOMOgdYENqpv7FUyWMmkY
         QW5p/JasXw4Upkkyj2JPVKyCYWmC6nGfFzzLCywuKRqxF9Ro8UT0vIuchllvuAPadN
         iFWYQcq7WlYZqlvPoR9Hh3Zh3v4TqVDtAK3fSGUxleZClhdfj3nBioH6+RM1mFbWN8
         mJVcXm3J6hFpa//z9ROcgBldxcisxZdEXtpL3ugvmFhN1QVGbEPE0w6Kk7uXE9kfT7
         nl0v17Jo1b/ZA==
Received: by mail-lf1-f54.google.com with SMTP id u12so9939256lfq.0
        for <linux-efi@vger.kernel.org>; Fri, 03 Feb 2023 14:42:13 -0800 (PST)
X-Gm-Message-State: AO0yUKVHUCwh3TGQMbmkuV3d5NLiPTZvUdTF7V1IHwgTeo+K4wGlPdaJ
        OU2ktse91qsopqVIzOtzAdFOLD3nZ1Epmh5TQxY=
X-Google-Smtp-Source: AK7set831XXTKWx2S1vI2EbTC2gEKPSmaQypResTfD3j+H/BbMoSb9bTM4XtAJZU/9Tqi/z9Lf9qK52yJ+lnBu8AG+0=
X-Received: by 2002:a19:500b:0:b0:4cc:789a:dac8 with SMTP id
 e11-20020a19500b000000b004cc789adac8mr2180119lfb.198.1675464131484; Fri, 03
 Feb 2023 14:42:11 -0800 (PST)
MIME-Version: 1.0
References: <20230111102236.1430401-1-ardb@kernel.org> <20230111102236.1430401-3-ardb@kernel.org>
 <Y91NmZUEZWUCNXWz@dev-arch.thelio-3990X>
In-Reply-To: <Y91NmZUEZWUCNXWz@dev-arch.thelio-3990X>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 3 Feb 2023 23:41:59 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEbZuCs3VyEqAmTKp0L+ybOVj1Dh9JmNfG5y5oZYBcMHQ@mail.gmail.com>
Message-ID: <CAMj1kXEbZuCs3VyEqAmTKp0L+ybOVj1Dh9JmNfG5y5oZYBcMHQ@mail.gmail.com>
Subject: Re: [PATCH v7 2/6] arm64: kernel: move identity map out of .text mapping
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 3 Feb 2023 at 19:08, Nathan Chancellor <nathan@kernel.org> wrote:
>
> Hi Ard,
>
> On Wed, Jan 11, 2023 at 11:22:32AM +0100, Ard Biesheuvel wrote:
> > Reorganize the ID map slightly so that only code that is executed with
> > the MMU off or via the 1:1 mapping remains. This allows us to move the
> > identity map out of the .text segment, as it will no longer need
> > executable permissions via the kernel mapping.
> >
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
> >  arch/arm64/kernel/head.S        | 28 +++++++++++---------
> >  arch/arm64/kernel/vmlinux.lds.S |  2 +-
> >  arch/arm64/mm/proc.S            |  2 --
> >  3 files changed, 16 insertions(+), 16 deletions(-)
> >
> > diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
> > index c4e12d466a5f35f0..bec97aad092c2b43 100644
> > --- a/arch/arm64/kernel/head.S
> > +++ b/arch/arm64/kernel/head.S
> > @@ -543,19 +543,6 @@ SYM_INNER_LABEL(init_el2, SYM_L_LOCAL)
> >       eret
> >  SYM_FUNC_END(init_kernel_el)
> >
> > -/*
> > - * Sets the __boot_cpu_mode flag depending on the CPU boot mode passed
> > - * in w0. See arch/arm64/include/asm/virt.h for more info.
> > - */
> > -SYM_FUNC_START_LOCAL(set_cpu_boot_mode_flag)
> > -     adr_l   x1, __boot_cpu_mode
> > -     cmp     w0, #BOOT_CPU_MODE_EL2
> > -     b.ne    1f
> > -     add     x1, x1, #4
> > -1:   str     w0, [x1]                        // Save CPU boot mode
> > -     ret
> > -SYM_FUNC_END(set_cpu_boot_mode_flag)
> > -
> >       /*
> >        * This provides a "holding pen" for platforms to hold all secondary
> >        * cores are held until we're ready for them to initialise.
> > @@ -599,6 +586,7 @@ SYM_FUNC_START_LOCAL(secondary_startup)
> >       br      x8
> >  SYM_FUNC_END(secondary_startup)
> >
> > +     .text
> >  SYM_FUNC_START_LOCAL(__secondary_switched)
> >       mov     x0, x20
> >       bl      set_cpu_boot_mode_flag
> > @@ -631,6 +619,19 @@ SYM_FUNC_START_LOCAL(__secondary_too_slow)
> >       b       __secondary_too_slow
> >  SYM_FUNC_END(__secondary_too_slow)
> >
> > +/*
> > + * Sets the __boot_cpu_mode flag depending on the CPU boot mode passed
> > + * in w0. See arch/arm64/include/asm/virt.h for more info.
> > + */
> > +SYM_FUNC_START_LOCAL(set_cpu_boot_mode_flag)
> > +     adr_l   x1, __boot_cpu_mode
> > +     cmp     w0, #BOOT_CPU_MODE_EL2
> > +     b.ne    1f
> > +     add     x1, x1, #4
> > +1:   str     w0, [x1]                        // Save CPU boot mode
> > +     ret
> > +SYM_FUNC_END(set_cpu_boot_mode_flag)
> > +
> >  /*
> >   * The booting CPU updates the failed status @__early_cpu_boot_status,
> >   * with MMU turned off.
> > @@ -662,6 +663,7 @@ SYM_FUNC_END(__secondary_too_slow)
> >   * Checks if the selected granule size is supported by the CPU.
> >   * If it isn't, park the CPU
> >   */
> > +     .section ".idmap.text","awx"
> >  SYM_FUNC_START(__enable_mmu)
> >       mrs     x3, ID_AA64MMFR0_EL1
> >       ubfx    x3, x3, #ID_AA64MMFR0_EL1_TGRAN_SHIFT, 4
> > diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
> > index 4c13dafc98b8400f..407415a5163ab62f 100644
> > --- a/arch/arm64/kernel/vmlinux.lds.S
> > +++ b/arch/arm64/kernel/vmlinux.lds.S
> > @@ -179,7 +179,6 @@ SECTIONS
> >                       LOCK_TEXT
> >                       KPROBES_TEXT
> >                       HYPERVISOR_TEXT
> > -                     IDMAP_TEXT
> >                       *(.gnu.warning)
> >               . = ALIGN(16);
> >               *(.got)                 /* Global offset table          */
> > @@ -206,6 +205,7 @@ SECTIONS
> >               TRAMP_TEXT
> >               HIBERNATE_TEXT
> >               KEXEC_TEXT
> > +             IDMAP_TEXT
> >               . = ALIGN(PAGE_SIZE);
> >       }
> >
> > diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
> > index 066fa60b93d24827..91410f48809000a0 100644
> > --- a/arch/arm64/mm/proc.S
> > +++ b/arch/arm64/mm/proc.S
> > @@ -110,7 +110,6 @@ SYM_FUNC_END(cpu_do_suspend)
> >   *
> >   * x0: Address of context pointer
> >   */
> > -     .pushsection ".idmap.text", "awx"
> >  SYM_FUNC_START(cpu_do_resume)
> >       ldp     x2, x3, [x0]
> >       ldp     x4, x5, [x0, #16]
> > @@ -166,7 +165,6 @@ alternative_else_nop_endif
> >       isb
> >       ret
> >  SYM_FUNC_END(cpu_do_resume)
> > -     .popsection
> >  #endif
> >
> >       .pushsection ".idmap.text", "awx"
> > --
> > 2.39.0
> >
>
> Sorry you have to keep hearing from me, I am starting to feel like a
> nuisance :) apologies if this is already been reported, I did a search
> of lore and did not find anything.
>

Don't be silly. If my patch broke something, it is my responsibility
to fix it, and I'd rather hear about it from you (with a high quality
report, as usual) than from someone who dumps a log on me but cannot
be bothered to follow up, or doesn't have the chops to help narrow it
down.

> I have noticed the following message on my arm64 machines recently and I
> had some time to bisect it down to this change in -next (log below):
>
>   [    0.029481] kprobes: Failed to populate blacklist (error -22), kprobes not restricted, be careful using them!
>
> I can trivially reproduce it with defconfig + CONFIG_KPROBES=y in QEMU.
> If there is any other information I can provide or patches I can test, I
> am more than happy to do so.
>

I had noticed this diagnostic a couple of times as well, but tbh, I
did not realize that it was my own patch that caused it.

I think the below should fix it: we no longer have to blacklist the ID
map for kprobes now that it is no longer part of the .text section to
begin with, and kprobes will disregard it by default

diff --git a/arch/arm64/kernel/probes/kprobes.c
b/arch/arm64/kernel/probes/kprobes.c
index f35d059a9a366fa6..70b91a8c6bb3f358 100644
--- a/arch/arm64/kernel/probes/kprobes.c
+++ b/arch/arm64/kernel/probes/kprobes.c
@@ -387,10 +387,6 @@ int __init arch_populate_kprobe_blacklist(void)
                                        (unsigned long)__irqentry_text_end);
        if (ret)
                return ret;
-       ret = kprobe_add_area_blacklist((unsigned long)__idmap_text_start,
-                                       (unsigned long)__idmap_text_end);
-       if (ret)
-               return ret;
        ret = kprobe_add_area_blacklist((unsigned long)__hyp_text_start,
                                        (unsigned long)__hyp_text_end);
        if (ret || is_kernel_in_hyp_mode())

Feel free to turn this into a patch and send it out. (The day has
already ended here :-))
