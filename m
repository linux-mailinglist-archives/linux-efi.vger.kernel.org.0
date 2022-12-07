Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 122D3645513
	for <lists+linux-efi@lfdr.de>; Wed,  7 Dec 2022 09:06:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbiLGIGv (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 7 Dec 2022 03:06:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiLGIGu (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 7 Dec 2022 03:06:50 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A695286D7
        for <linux-efi@vger.kernel.org>; Wed,  7 Dec 2022 00:06:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 281FE60B90
        for <linux-efi@vger.kernel.org>; Wed,  7 Dec 2022 08:06:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89AF2C43149
        for <linux-efi@vger.kernel.org>; Wed,  7 Dec 2022 08:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670400408;
        bh=dKvZhLD0Ds0iSbthLpxzEQsvpQ30YYwlUCgmh1r1Npw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dSD3FS8fmRuQkT1npIgiHgTBhw6Nnd229uLvOiAuaDlyy6PdUWnY8jtYMnx7LmWj3
         XDMfHolp3K9ZOm8XZaHAz5hL1oN6kLyiKlnhgdAXayPIXtV8VgQlrvrjUb2DngbyM3
         cbHsv4c3Uyn4MsValRSbFiv7mK9EhI7RizQFo39S08yz8YlbiXP0alpJqRwsJiq/yH
         Yq27QhDKzbpRuQStWd/TGAS4m4XgDnek+c4ESaeZXFMTiJS/Uc8lgDKmbpJ8KXvYnI
         07rrOmuqSOrJBwLR/GEeKdAcSSlhNFYVlKclw8wRfvbHQzuBdtUGrz79VNkzhtnTXT
         /E7ctTz1Kk8hA==
Received: by mail-lj1-f174.google.com with SMTP id q7so19974905ljp.9
        for <linux-efi@vger.kernel.org>; Wed, 07 Dec 2022 00:06:48 -0800 (PST)
X-Gm-Message-State: ANoB5plSDvh1d3e8jtlxTI8OiqtKmihxa3xrLszj9iNfrdL6J8y5bDlk
        nlU6CzbWRSIJl9bJMvM9lLDtajW3GxYinUprElQ=
X-Google-Smtp-Source: AA0mqf4+7QjabOOjJo9k+o596eBJrJGj6AWAEMbOvLrHZhVDKOAoqaKVQtXW4/rQHjo2cKImxo30aLQnJhpLQLz+TrY=
X-Received: by 2002:a05:651c:153:b0:279:bbff:a928 with SMTP id
 c19-20020a05651c015300b00279bbffa928mr9990984ljd.415.1670400406467; Wed, 07
 Dec 2022 00:06:46 -0800 (PST)
MIME-Version: 1.0
References: <20221129175616.2089294-1-ardb@kernel.org> <20221129175616.2089294-3-ardb@kernel.org>
 <2c6ef81cda85345585cafbbbf9214e38fd7ca369.camel@loongson.cn>
In-Reply-To: <2c6ef81cda85345585cafbbbf9214e38fd7ca369.camel@loongson.cn>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 7 Dec 2022 09:06:35 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGQdYxAMvDZWMbXzo-yMP_1+0BLZSrVnz3XqMg+hJ_u6g@mail.gmail.com>
Message-ID: <CAMj1kXGQdYxAMvDZWMbXzo-yMP_1+0BLZSrVnz3XqMg+hJ_u6g@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] efi: Put Linux specific magic number in the DOS header
To:     Xiaotian Wu <wuxiaotian@loongson.cn>
Cc:     The development of GNU GRUB <grub-devel@gnu.org>,
        linux-efi@vger.kernel.org, Huacai Chen <chenhuacai@kernel.org>,
        Atish Patra <atishp@rivosinc.com>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Daniel Kiper <daniel.kiper@oracle.com>,
        Leif Lindholm <quic_llindhol@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 7 Dec 2022 at 08:51, Xiaotian Wu <wuxiaotian@loongson.cn> wrote:
>
> =E5=9C=A8 2022-11-29=E6=98=9F=E6=9C=9F=E4=BA=8C=E7=9A=84 18:56 +0100=EF=
=BC=8CArd Biesheuvel=E5=86=99=E9=81=93=EF=BC=9A
> > GRUB currently relies on the magic number in the image header of ARM
> > and
> > arm64 EFI kernel images to decide whether or not the image in
> > question
> > is a bootable kernel.
> >
> > However, the purpose of the magic number is to identify the image as
> > one
> > that implements the bare metal boot protocol, and so GRUB, which only
> > does EFI boot, can only boot images that could potentially be booted
> > in
> > a non-EFI manner as well.
> >
> > This is problematic for the new zboot decompressor image format, as
> > it
> > can only boot in EFI mode, and must therefore not use the bare metal
> > boot magic number in its header.
> >
> > For this reason, the strict magic number was dropped from GRUB, to
> > permit essentially any kind of EFI executable to be booted via the
> > 'linux' command, blurring the line between the linux loader and the
> > chainloader.
> >
> > So let's use the same field in the DOS header that RISC-V and arm64
> > already use for their 'bare metal' magic numbers to store a 'generic
> > Linux kernel' magic number, which can be used to identify bootable
> > kernel images in PE format which don't necessarily implement a bare
> > metal boot protocol in the same binary. Note that, in the context of
> > EFI, the MSDOS header is only described in terms of the fields that
> > it
> > shares with the hybrid PE/COFF image format, (i.e., the magic number
> > at
> > offset #0 and the PE header offset at byte offset #0x3c). Since we
> > aim
> > for compatibility with EFI only, and not with MS-DOS or MS-Windows,
> > we
> > can use the remaining space in the MS-DOS header however we want.
> >
> > Let's set the generic magic number for x86 images as well: existing
> > bootloaders already have their own methods to identify x86 Linux
> > images
> > that can be booted in a non-EFI manner, and having the magic number
> > in
> > place there will ease any future transitions in loader
> > implementations
> > to merge the x86 and non-x86 EFI boot paths.
> >
> > Note that 32-bit ARM already uses the same location in the header for
> > a
> > different purpose, but the ARM support is already widely implemented
> > and
> > the EFI zboot decompressor is not available on ARM anyway, so we just
> > disregard it here.
> >
> > Cc: Huacai Chen <chenhuacai@kernel.org>
> > Cc: Atish Patra <atishp@rivosinc.com>
> > Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> > Cc: Daniel Kiper <daniel.kiper@oracle.com>
> > Cc: Leif Lindholm <quic_llindhol@quicinc.com>
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
> >  arch/loongarch/kernel/head.S                | 3 ++-
> >  arch/x86/boot/header.S                      | 3 ++-
> >  drivers/firmware/efi/libstub/zboot-header.S | 3 ++-
> >  include/linux/pe.h                          | 7 +++++++
> >  4 files changed, 13 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/loongarch/kernel/head.S
> > b/arch/loongarch/kernel/head.S
> > index 84970e2666588963..caa74439700eee93 100644
> > --- a/arch/loongarch/kernel/head.S
> > +++ b/arch/loongarch/kernel/head.S
> > @@ -25,7 +25,8 @@ _head:
> >         .dword  kernel_entry            /* Kernel entry point */
> >         .dword  _end - _text            /* Kernel image effective
> > size */
> >         .quad   0                       /* Kernel image load offset
> > from start of RAM */
> > -       .org    0x3c                    /* 0x20 ~ 0x3b reserved */
> > +       .org    0x38                    /* 0x20 ~ 0x38 reserved */
> > +       .long   LINUX_PE_MAGIC
> >         .long   pe_header - _head       /* Offset to the PE header */
> >
> >  pe_header:
> > diff --git a/arch/x86/boot/header.S b/arch/x86/boot/header.S
> > index f912d777013052ea..be8f78a7ee325475 100644
> > --- a/arch/x86/boot/header.S
> > +++ b/arch/x86/boot/header.S
> > @@ -80,10 +80,11 @@ bs_die:
> >         ljmp    $0xf000,$0xfff0
> >
> >  #ifdef CONFIG_EFI_STUB
> > -       .org    0x3c
> > +       .org    0x38
> >         #
> >         # Offset to the PE header.
> >         #
> > +       .long   LINUX_PE_MAGIC
> >         .long   pe_header
> >  #endif /* CONFIG_EFI_STUB */
> >
> > diff --git a/drivers/firmware/efi/libstub/zboot-header.S
> > b/drivers/firmware/efi/libstub/zboot-header.S
> > index bc2d7750d7f14174..ec4525d40e0cf6d6 100644
> > --- a/drivers/firmware/efi/libstub/zboot-header.S
> > +++ b/drivers/firmware/efi/libstub/zboot-header.S
> > @@ -20,7 +20,8 @@ __efistub_efi_zboot_header:
> >         .long           __efistub__gzdata_size - 12             //
> > payload size
> >         .long           0, 0                                    //
> > reserved
> >         .asciz          COMP_TYPE                               //
> > compression type
> > -       .org            .Ldoshdr + 0x3c
> > +       .org            .Ldoshdr + 0x38
> > +       .long           LINUX_PE_MAGIC
> >         .long           .Lpehdr - .Ldoshdr                      // PE
> > header offset
> >
> >  .Lpehdr:
> > diff --git a/include/linux/pe.h b/include/linux/pe.h
> > index 056a1762de904fc1..1db4c944efd78f51 100644
> > --- a/include/linux/pe.h
> > +++ b/include/linux/pe.h
> > @@ -31,6 +31,13 @@
> >  #define LINUX_EFISTUB_MAJOR_VERSION            0x1
> >  #define LINUX_EFISTUB_MINOR_VERSION            0x1
> >
> > +/*
> > + * LINUX_PE_MAGIC appears at offset 0x38 into the MSDOS header of
> > EFI bootable
> > + * Linux kernel images that target the architecture as specified by
> > the PE/COFF
> > + * header machine type field.
> > + */
> > +#define LINUX_PE_MAGIC 0x818223cd
> > +
> >  #define MZ_MAGIC       0x5a4d  /* "MZ" */
> >
> >  #define PE_MAGIC               0x00004550      /* "PE\0\0" */
>
>
> As far as I know, Archlinux automatically generates initramfs according
> to the version number in the kernel file. The latest generic compressed
> EFI designs do not seem to provide kernel version number information.

No, but nor do the gzip'ed images arm64 uses today, and the script
seems take care of that.

The EFI zboot image has metadata in the header, so the script can
decompress it and grep for the version number it it needs to.

> This may change the usage habits of Archlinux users. Is it possible to
> add the kernel version number to vmlinuz.efi?
>
> https://gitlab.archlinux.org/archlinux/mkinitcpio/mkinitcpio/-/blob/maste=
r/functions#L209
>

The current header doesn't have that so I don't think EFI zboot should
be adding it either.
