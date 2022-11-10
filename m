Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 228E4623D71
	for <lists+linux-efi@lfdr.de>; Thu, 10 Nov 2022 09:24:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232800AbiKJIYV (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 10 Nov 2022 03:24:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232713AbiKJIYU (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 10 Nov 2022 03:24:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62C0A1EAC4
        for <linux-efi@vger.kernel.org>; Thu, 10 Nov 2022 00:24:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1711AB820FD
        for <linux-efi@vger.kernel.org>; Thu, 10 Nov 2022 08:24:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABBF4C43143
        for <linux-efi@vger.kernel.org>; Thu, 10 Nov 2022 08:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668068656;
        bh=Cwkjq2VZ8zTIMZzeHbPo11qbpFy2lRXLeXteFliKi0E=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fpZ5XrdbRYGI7f/XDN3YFkg+WUlGJobTZ14yNrp7XuhLFtV3QNFph7kHTH2toeglX
         DrkhgN4lK2jSb03o/6t3BNk4UVOQ5k/gXsip9iROH7wbx2nk6HOO/rXyQgwP/pKkm+
         OqALmeLXIdmn99/Arp8/NhKjbDXdKHgKwKNJu/KCNWmIqPifejqHlQgGwBhY4dk7U9
         XisObzMwqp15lhgOyAh7NSPwHHQi9zWhVkweBW3GqdZ0GaBqiSRrfO920EWvvzAjwV
         PY4pRjK8csmTTw8LK/NMRLcr27d1bxu5AfG75nSLc8lgjkNt/SzhnW4qeWcykeX//x
         lbiVru1oJ4bxw==
Received: by mail-lf1-f48.google.com with SMTP id g7so1790468lfv.5
        for <linux-efi@vger.kernel.org>; Thu, 10 Nov 2022 00:24:16 -0800 (PST)
X-Gm-Message-State: ACrzQf2BxuTSd/MtHFol1ahwj6UAF4rPH134qgQ+R3zLnR/vTAHIz1j4
        m9Klyim1BaxWnjMkYrzmUxwJl2j2zxed2UyO9I8=
X-Google-Smtp-Source: AMsMyM5GIkz94hp35ikK+5HDZw+ijltehxryeHoDUQAQmF1tHkKfftSuPEJsM4MuA7eqdpHW/JgqPmh51A3+Kq7oPOA=
X-Received: by 2002:a19:4f53:0:b0:4b1:1f35:279b with SMTP id
 a19-20020a194f53000000b004b11f35279bmr15764015lfk.637.1668068654435; Thu, 10
 Nov 2022 00:24:14 -0800 (PST)
MIME-Version: 1.0
References: <20221109141611.2788009-1-ardb@kernel.org> <594e304d-38f0-ed37-a2a8-7479ff850c8c@canonical.com>
 <Y2wkGmGEja5hUpZR@tomti.i.net-space.pl>
In-Reply-To: <Y2wkGmGEja5hUpZR@tomti.i.net-space.pl>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 10 Nov 2022 09:24:02 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFvSXMC34gGaRWjzK4-98wAaUoM8qQ2AWkk4_6QXUHfVw@mail.gmail.com>
Message-ID: <CAMj1kXFvSXMC34gGaRWjzK4-98wAaUoM8qQ2AWkk4_6QXUHfVw@mail.gmail.com>
Subject: Re: [RFC PATCH] efi: Put Linux specific magic number in the DOS header
To:     Daniel Kiper <daniel.kiper@oracle.com>
Cc:     Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        grub-devel@gnu.org, Huacai Chen <chenhuacai@kernel.org>,
        Atish Patra <atishp@rivosinc.com>,
        Leif Lindholm <quic_llindhol@quicinc.com>,
        linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 10 Nov 2022 at 00:27, Daniel Kiper <daniel.kiper@oracle.com> wrote:
>
> On Wed, Nov 09, 2022 at 04:01:27PM +0100, Heinrich Schuchardt wrote:
> > On 11/9/22 15:16, Ard Biesheuvel wrote:
> > > GRUB currently relies on the magic number in the image header of ARM and
> > > arm64 EFI kernel images to decide whether or not the image in question
> > > is a bootable kernel.
> > >
> > > However, the purpose of the magic number is to identify the image as one
> > > that implements the bare metal boot protocol, and so GRUB, which only
> > > does EFI boot, can only boot images that could potentially be booted in
> > > a non-EFI manner as well.
> > >
> > > This is problematic for the new zboot decompressor image format, as it
> > > can only boot in EFI mode, and must therefore not use the bare metal
> > > boot magic number in its header.
> > >
> > > For this reason, the strict magic number was dropped from GRUB, to
> > > permit essentially any kind of EFI executable to be booted via the
> > > 'linux' command, blurring the line between the linux loader and the
> > > chainloader.
> > >
> > > So let's use the same field in the DOS header that RISC-V and arm64
> > > already use for their 'bare metal' magic numbers to store a 'generic
> > > Linux kernel' magic number, which can be used to identify bootable
> > > kernel images in PE format which don't necessarily implement a bare
> > > metal boot protocol in the same binary.
> > >
> > > Let's set the generic magic number for x86 images as well: existing
> > > bootloaders already have their own methods to identify x86 Linux images
> > > that can be booted in a non-EFI manner, and having the magic number in
> > > place there will ease any future transitions in loader implementations
> > > to merge the x86 and non-x86 EFI boot paths.
> > >
> > > Note that 32-bit ARM already uses the same location in the header for a
> > > different purpose, but the ARM support is already widely implemented and
> > > the EFI zboot decompressor is not available on ARM anyway, so we just
> > > disregard it here.
> > >
> > > Cc: Huacai Chen <chenhuacai@kernel.org>
> > > Cc: Atish Patra <atishp@rivosinc.com>
> > > Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> > > Cc: Daniel Kiper <daniel.kiper@oracle.com>
> > > Cc: Leif Lindholm <quic_llindhol@quicinc.com>
> > > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > > ---
> > > The idea is that, with this in place, the existing arm64 support in GRUB
> > > can be made generic, with the arm64 variant of the arch image header
> > > typedef being made generic as well.
> > >
> > > Any code that attempts to identify EFI images as kernel images should
> > > check for the arm64, RISC-V and generic values, and if the latter, look
> > > at the PE machine type if it wants to know the architecture.
> > >
> > >   arch/loongarch/kernel/head.S                | 3 ++-
> > >   arch/x86/boot/header.S                      | 3 ++-
> > >   drivers/firmware/efi/libstub/zboot-header.S | 3 ++-
> > >   include/linux/pe.h                          | 7 +++++++
> > >   4 files changed, 13 insertions(+), 3 deletions(-)
> >
> > We need files in Documentation/ that describes the meaning and value of the
> > field per architecture.
> >
> > We already have:
> >
> > riscv: Documentation/riscv/boot-image-header.rst
> > arm64: Documentation/arm64/booting.rst
>
> I think we should add something to the Documentation/x86/boot.rst too.
> Probably in or after "EFI Handover Protocol (deprecated)" section.
>

Point taken. I'll add some mention of this to the appropriate places
under Documentation/

> > But other UEFI architectures are missing.
> >
> > Otherwise I am fine with the change.
> >
> > Best regards
> >
> > Heinrich
> >
> > >
> > > diff --git a/arch/loongarch/kernel/head.S b/arch/loongarch/kernel/head.S
> > > index 97425779ce9f3499..e1deea93aaafa069 100644
> > > --- a/arch/loongarch/kernel/head.S
> > > +++ b/arch/loongarch/kernel/head.S
> > > @@ -25,7 +25,8 @@ _head:
> > >     .dword  kernel_entry            /* Kernel entry point */
> > >     .dword  _end - _text            /* Kernel image effective size */
> > >     .quad   0                       /* Kernel image load offset from start of RAM */
> > > -   .org    0x3c                    /* 0x20 ~ 0x3b reserved */
> > > +   .org    0x38                    /* 0x20 ~ 0x38 reserved */
> > > +   .long   LINUX_PE_MAGIC
> > >     .long   pe_header - _head       /* Offset to the PE header */
> > >   pe_header:
> > > diff --git a/arch/x86/boot/header.S b/arch/x86/boot/header.S
> > > index d31982509654dcb1..9338c68e7413d6e6 100644
> > > --- a/arch/x86/boot/header.S
> > > +++ b/arch/x86/boot/header.S
> > > @@ -80,10 +80,11 @@ bs_die:
> > >     ljmp    $0xf000,$0xfff0
> > >   #ifdef CONFIG_EFI_STUB
> > > -   .org    0x3c
> > > +   .org    0x38
> > >     #
> > >     # Offset to the PE header.
> > >     #
> > > +   .long   LINUX_PE_MAGIC
> > >     .long   pe_header
> > >   #endif /* CONFIG_EFI_STUB */
> > > diff --git a/drivers/firmware/efi/libstub/zboot-header.S b/drivers/firmware/efi/libstub/zboot-header.S
> > > index 9e6fe061ab07a008..97c2637337d79913 100644
> > > --- a/drivers/firmware/efi/libstub/zboot-header.S
> > > +++ b/drivers/firmware/efi/libstub/zboot-header.S
> > > @@ -20,7 +20,8 @@ __efistub_efi_zboot_header:
> > >     .long           __efistub__gzdata_size - ZBOOT_SIZE_LEN // payload size
> > >     .long           0, 0                                    // reserved
> > >     .asciz          COMP_TYPE                               // compression type
> > > -   .org            .Ldoshdr + 0x3c
> > > +   .org            .Ldoshdr + 0x38
> > > +   .long           LINUX_PE_MAGIC
> > >     .long           .Lpehdr - .Ldoshdr                      // PE header offset
> > >   .Lpehdr:
> > > diff --git a/include/linux/pe.h b/include/linux/pe.h
> > > index 1d3836ef9d92dcd8..fa176c24167c301c 100644
> > > --- a/include/linux/pe.h
> > > +++ b/include/linux/pe.h
> > > @@ -31,6 +31,13 @@
> > >   #define LINUX_EFISTUB_MAJOR_VERSION               0x1
> > >   #define LINUX_EFISTUB_MINOR_VERSION               0x0
> > > +/*
> > > + * LINUX_PE_MAGIC appears at offset 0x30 into the MSDOS header of EFI bootable
>
> s/0x30/0x38/?
>

Indeed.

> However, it means you go into reserved part of MS-DOS header [1]. This
> should be safe here. Though I think it should be mentioned in the commit
> message and/or documentation.
>

EFI != MS-DOS, and so we don't care about hybrid DOS+PE images, we
only care about PE/COFF which doesn't cover these fields, it only
covers the MZ at the start and the PE header offset at offset 0x3c.

I will add a mention of that as well.


> Another question which bothers me is: why do not use "OEM identifier"
> [1] and "OEM info" [1] to achieve what we want? IMO this would be more
> natural but on the other hand both fields are not well defined...
>

The magic number at offset 0x38 is already implemented by arm64 and
RISC-V, so at least for arm64, we will need to check that anyway,
since existing kernels won't have it.

0x38 is also the only place we can use on x86 as well.


> Finally, current approach do not allow us easily encode info about
> images which support more than one boot protocol. Maybe not big deal at
> this point but I would ponder on it at least a bit...
>

arm64 and RISC-V already encode information about the image into other
header fields, but this mostly affects the bare metal boot protocol
only. E.g., on arm64 it encodes the used page size, which in EFI mode,
we do in the code (and return to the loader with an error if the
image's page size is not implemented by the CPU)

For EFI images, I currently don't have an idea what we would encode
there. We are already using the image version fields in the PE header
to encode support for LF2 and mixed mode using .compat but this is
based on a version level check, not individual bits of information.
