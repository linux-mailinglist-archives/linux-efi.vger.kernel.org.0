Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3238A639652
	for <lists+linux-efi@lfdr.de>; Sat, 26 Nov 2022 15:17:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbiKZORb (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 26 Nov 2022 09:17:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbiKZORa (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 26 Nov 2022 09:17:30 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A8B810DA
        for <linux-efi@vger.kernel.org>; Sat, 26 Nov 2022 06:17:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 363DB604AD
        for <linux-efi@vger.kernel.org>; Sat, 26 Nov 2022 14:17:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98EDFC433D6
        for <linux-efi@vger.kernel.org>; Sat, 26 Nov 2022 14:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669472248;
        bh=DJK8fNeHfQxPHhzQPXs0XsZYEE+qp1g4/Pf81zviOUo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=N3ge7Y4d9O6G3mq3/mZgwElOeiFs9ZyvNUG8YbZLkpOBMLPyPsFgTjqCtNsicMeCD
         3SomGNC6mpDfiNrHVwITB5UEJ4Bp/OgzHl8iPaZVHRWQgdP3WkkIXFztHn8TqZ4Gpa
         9zETuUN9jqOg2kg5v6U1nYcsUD58bE+DdHU4JK/dlaI0UsfW+Ilf49PA5TnrJ4YiJz
         bRS9T93AO6to/GvhBEU9Bkns3pATapsn5s3OwbVITkCz08XDY3AiKCUmE+uosYtHQr
         yGHMeMWmnwEXMo4jVhvAQcxoZygXfjqCF/vqQgr2ePux2wBDDZJQeiEBRn0tDJnB61
         QsF5zKqqduUXw==
Received: by mail-lf1-f44.google.com with SMTP id a29so10846351lfj.9
        for <linux-efi@vger.kernel.org>; Sat, 26 Nov 2022 06:17:28 -0800 (PST)
X-Gm-Message-State: ANoB5pkMbDB6QfPgsvx0Xd1uPejYbSL4vcDbZBb3xO++kVIEQMSXhYfL
        U33dr4qVzY/iat5Pdo5jdbVFwTKzwo66IA6inMc=
X-Google-Smtp-Source: AA0mqf59qp2MotPQ6XEsC9PfjqNx7SNJ86aTwjY4Th7qIsXWtx33pjkJHLv/YvXTPK7kmcPh5umWuLui3G//NWuCSdk=
X-Received: by 2002:a19:6b19:0:b0:4a2:740b:5b02 with SMTP id
 d25-20020a196b19000000b004a2740b5b02mr13860920lfa.122.1669472246516; Sat, 26
 Nov 2022 06:17:26 -0800 (PST)
MIME-Version: 1.0
References: <20221108182204.2447664-1-ardb@kernel.org> <Y26IE5NEVhyId4KH@FVFF77S0Q05N.cambridge.arm.com>
 <20221115111658.GA32523@willie-the-truck> <CAMj1kXFGakOpTyUqDrFGDRoRsSzG2bYQ=iZA86DahbjL_zvE7w@mail.gmail.com>
 <20221115113134.GC32523@willie-the-truck> <CAMj1kXFdJHvT-XKaEC0tXpxM_RMfCic_sS-JkMkVYfKZCYkZuA@mail.gmail.com>
In-Reply-To: <CAMj1kXFdJHvT-XKaEC0tXpxM_RMfCic_sS-JkMkVYfKZCYkZuA@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sat, 26 Nov 2022 15:17:15 +0100
X-Gmail-Original-Message-ID: <CAMj1kXH+B3vKkrkMg_NcZNsP4zSULuUgQ-xJwiq60UJs2wLP3A@mail.gmail.com>
Message-ID: <CAMj1kXH+B3vKkrkMg_NcZNsP4zSULuUgQ-xJwiq60UJs2wLP3A@mail.gmail.com>
Subject: Re: [PATCH v5 0/7] arm64: efi: leave MMU and caches on at boot
To:     Will Deacon <will@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-efi@vger.kernel.org,
        keescook@chromium.org, Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sat, 26 Nov 2022 at 15:16, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Tue, 15 Nov 2022 at 12:31, Will Deacon <will@kernel.org> wrote:
> >
> > On Tue, Nov 15, 2022 at 12:21:55PM +0100, Ard Biesheuvel wrote:
> > > On Tue, 15 Nov 2022 at 12:17, Will Deacon <will@kernel.org> wrote:
> > > >
> > > > On Fri, Nov 11, 2022 at 05:36:19PM +0000, Mark Rutland wrote:
> > > > > On Tue, Nov 08, 2022 at 07:21:57PM +0100, Ard Biesheuvel wrote:
> > > > > > The purpose of this series is to remove any explicit cache maintenance
> > > > > > for coherency during early boot that becomes unnecessary if we simply
> > > > > > retain the cacheable 1:1 mapping of all of system RAM provided by EFI,
> > > > > > and use it to populate the ID map page tables. After setting up this
> > > > > > preliminary ID map, we disable the MMU, drop to EL1, reprogram the MAIR,
> > > > > > TCR and SCTLR registers as before, and proceed as usual, avoiding the
> > > > > > need for any manipulations of memory while the MMU and caches are off.
> > > > > >
> > > > > > The only properties of the firmware provided 1:1 map we rely on is that
> > > > > > it does not require any explicit cache maintenance for coherency, and
> > > > > > that it covers the entire memory footprint of the image, including the
> > > > > > BSS and padding at the end - all else is under control of the kernel
> > > > > > itself, as before.
> > > > >
> > > > > As a high-level thing, I'm still very much not keen on entering the kernel with
> > > > > the MMU on. Given that we have to support booting with the MMU off for !EFI
> > > > > boot (including kexec when EFI is in use), I think this makes it harder to
> > > > > reason about the boot code overall (e.g. due to the conditional maintenance
> > > > > added to head.S), and adds more scope for error, even if it simplifies the EFI
> > > > > stub itself.
> > > >
> > > > As discussed offline, two things that would help the current series are:
> > > >
> > > >   (1) Some performance numbers comparing MMU off vs MMU on boot
> > > >
>
> Finally got around to measuring this - I lost access to my TX2 machine
> for a couple of days during the past week,
>
> With the patch below applied to mainline, I measure ~6 ms spent
> cleaning the entire image to the PoC (which is the bulk of it) and
> subsequently populating the initial ID map and activating it.
>
> This drops to about 0.6 ms with my changes applied. This is unlikely
> to ever matter in practice, perhaps, but I will note that booting a VM
> in EFI mode using Tianocore/EDK2 from the point where KVM clears the
> counter to the point where we start user space can be done (on the
> same machine) in 500-700 ms so it is not entirely insignificant
> either.
>
> I could try and measure it on bare metal as well, but I suppose that
> launch times are even less relevant there so I didn't bother.

diff --git a/arch/arm64/kernel/efi-entry.S b/arch/arm64/kernel/efi-entry.S
index 61a87fa1c3055e26..27f59784a1c0be2c 100644
--- a/arch/arm64/kernel/efi-entry.S
+++ b/arch/arm64/kernel/efi-entry.S
@@ -22,6 +22,7 @@ SYM_CODE_START(efi_enter_kernel)
        ldr     w2, =primary_entry_offset
        add     x19, x0, x2             // relocated Image entrypoint
        mov     x20, x1                 // DTB address
+       mrs     x27, cntvct_el0

        /*
         * Clean the copied Image to the PoC, and ensure it is not shadowed by
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 2196aad7b55bcef0..068a7d111836382b 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -430,6 +430,8 @@ SYM_FUNC_START_LOCAL(__primary_switched)

        str_l   x21, __fdt_pointer, x5          // Save FDT pointer

+       str_l   x27, boot_args + 8, x5
+
        ldr_l   x4, kimage_vaddr                // Save the offset between
        sub     x4, x4, x0                      // the kernel virtual and
        str_l   x4, kimage_voffset, x5          // physical mappings
@@ -797,6 +799,10 @@ SYM_FUNC_START_LOCAL(__primary_switch)
        adrp    x1, reserved_pg_dir
        adrp    x2, init_idmap_pg_dir
        bl      __enable_mmu
+
+       mrs     x0, cntvct_el0
+       sub     x27, x0, x27
+
 #ifdef CONFIG_RELOCATABLE
        adrp    x23, KERNEL_START
        and     x23, x23, MIN_KIMG_ALIGN - 1
