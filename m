Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5A7C63F318
	for <lists+linux-efi@lfdr.de>; Thu,  1 Dec 2022 15:48:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbiLAOsb (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 1 Dec 2022 09:48:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbiLAOsa (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 1 Dec 2022 09:48:30 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED50847309
        for <linux-efi@vger.kernel.org>; Thu,  1 Dec 2022 06:48:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9FEB2B81F60
        for <linux-efi@vger.kernel.org>; Thu,  1 Dec 2022 14:48:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 567A6C433B5
        for <linux-efi@vger.kernel.org>; Thu,  1 Dec 2022 14:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669906105;
        bh=uCs08h8U+7w8FpwP951lOVWlkLlZZXe6yIm62BNRSWc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZDUSAR+ciUroznWh5SuczXHRbOfArVc7MtsLPXQ4KxLYC+Xq7p02zAje14eLDyEzo
         OeZAQvZAuaVxmW1E4D2tZWV0K5tdOLJ17EffqDWMwrbq809lCZH0Fu3HHj2fP4rSZD
         kNLcEYJnJEMzYxmTGSWIGDCmjfca7ru+OSqWI3EMkfL4m51A0Liv7S7SeqW5kTGMJw
         fBKAG8LCF3TPbZ7GYBzBk/7r87yCM0JDRb6tftmZkIu6uJRj1llI/F0lTqt/uBfVdH
         nu7yvqvhjM7NkoruK04LpPCmqWsQLfXnJVAGf7Thv8YyfjjDRIM8nMvYbLJuz/LlT7
         M/aJ4OZXm4eJQ==
Received: by mail-lf1-f50.google.com with SMTP id p8so2806491lfu.11
        for <linux-efi@vger.kernel.org>; Thu, 01 Dec 2022 06:48:25 -0800 (PST)
X-Gm-Message-State: ANoB5pmmisMN8yAHfE6PWjLLpj58dWcg0F1Ou5BO89sXSc+dvsNhtjWo
        PLskF5lNYEh+Zm5kdbE+iQGN+hHtI0MbNEHt5FQ=
X-Google-Smtp-Source: AA0mqf4NhA2n4/0vJgOUqiQ80dAXhsn2fcTf9kzcdUk7HpIP7mykv+oYWJQq3Ow6qxEWj2+p53KyIJfKSyKIJ2d6m0g=
X-Received: by 2002:a19:6b19:0:b0:4a2:740b:5b02 with SMTP id
 d25-20020a196b19000000b004a2740b5b02mr21166346lfa.122.1669906103322; Thu, 01
 Dec 2022 06:48:23 -0800 (PST)
MIME-Version: 1.0
References: <20221129175616.2089294-1-ardb@kernel.org> <20221129175616.2089294-3-ardb@kernel.org>
 <Y4i6YExOV80rxdhq@tomti.i.net-space.pl>
In-Reply-To: <Y4i6YExOV80rxdhq@tomti.i.net-space.pl>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 1 Dec 2022 15:48:12 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEzzicO_V=ZKBgvWWFAoa1XNSO5KRZaCPYO1boT9s+Vig@mail.gmail.com>
Message-ID: <CAMj1kXEzzicO_V=ZKBgvWWFAoa1XNSO5KRZaCPYO1boT9s+Vig@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] efi: Put Linux specific magic number in the DOS header
To:     Daniel Kiper <daniel.kiper@oracle.com>
Cc:     linux-efi@vger.kernel.org, grub-devel@gnu.org,
        Huacai Chen <chenhuacai@kernel.org>,
        Atish Patra <atishp@rivosinc.com>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Leif Lindholm <quic_llindhol@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 1 Dec 2022 at 15:30, Daniel Kiper <daniel.kiper@oracle.com> wrote:
>
> On Tue, Nov 29, 2022 at 06:56:16PM +0100, Ard Biesheuvel wrote:
> > GRUB currently relies on the magic number in the image header of ARM and
> > arm64 EFI kernel images to decide whether or not the image in question
> > is a bootable kernel.
> >
> > However, the purpose of the magic number is to identify the image as one
> > that implements the bare metal boot protocol, and so GRUB, which only
> > does EFI boot, can only boot images that could potentially be booted in
> > a non-EFI manner as well.
> >
> > This is problematic for the new zboot decompressor image format, as it
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
> > EFI, the MSDOS header is only described in terms of the fields that it
>
> s/MSDOS/MS-DOS/ to be consistent with other places in the patch...
>
> > shares with the hybrid PE/COFF image format, (i.e., the magic number at
> > offset #0 and the PE header offset at byte offset #0x3c). Since we aim
>
> s/the magic number at offset #0/MS-DOS EXE magic number at offset #0/?
>
> "the magic number at offset #0" itself is confusing in the context of
> number of "magic number" phrases in the patch... :-)
>
> > for compatibility with EFI only, and not with MS-DOS or MS-Windows, we
> > can use the remaining space in the MS-DOS header however we want.
> >
> > Let's set the generic magic number for x86 images as well: existing
> > bootloaders already have their own methods to identify x86 Linux images
> > that can be booted in a non-EFI manner, and having the magic number in
> > place there will ease any future transitions in loader implementations
> > to merge the x86 and non-x86 EFI boot paths.
> >
> > Note that 32-bit ARM already uses the same location in the header for a
> > different purpose, but the ARM support is already widely implemented and
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
> > diff --git a/arch/loongarch/kernel/head.S b/arch/loongarch/kernel/head.S
> > index 84970e2666588963..caa74439700eee93 100644
> > --- a/arch/loongarch/kernel/head.S
> > +++ b/arch/loongarch/kernel/head.S
> > @@ -25,7 +25,8 @@ _head:
> >       .dword  kernel_entry            /* Kernel entry point */
> >       .dword  _end - _text            /* Kernel image effective size */
> >       .quad   0                       /* Kernel image load offset from start of RAM */
> > -     .org    0x3c                    /* 0x20 ~ 0x3b reserved */
> > +     .org    0x38                    /* 0x20 ~ 0x38 reserved */
> > +     .long   LINUX_PE_MAGIC
> >       .long   pe_header - _head       /* Offset to the PE header */
> >
> >  pe_header:
> > diff --git a/arch/x86/boot/header.S b/arch/x86/boot/header.S
> > index f912d777013052ea..be8f78a7ee325475 100644
> > --- a/arch/x86/boot/header.S
> > +++ b/arch/x86/boot/header.S
> > @@ -80,10 +80,11 @@ bs_die:
> >       ljmp    $0xf000,$0xfff0
> >
> >  #ifdef CONFIG_EFI_STUB
> > -     .org    0x3c
> > +     .org    0x38
> >       #
> >       # Offset to the PE header.
> >       #
> > +     .long   LINUX_PE_MAGIC
> >       .long   pe_header
> >  #endif /* CONFIG_EFI_STUB */
> >
> > diff --git a/drivers/firmware/efi/libstub/zboot-header.S b/drivers/firmware/efi/libstub/zboot-header.S
> > index bc2d7750d7f14174..ec4525d40e0cf6d6 100644
> > --- a/drivers/firmware/efi/libstub/zboot-header.S
> > +++ b/drivers/firmware/efi/libstub/zboot-header.S
> > @@ -20,7 +20,8 @@ __efistub_efi_zboot_header:
> >       .long           __efistub__gzdata_size - 12             // payload size
> >       .long           0, 0                                    // reserved
> >       .asciz          COMP_TYPE                               // compression type
> > -     .org            .Ldoshdr + 0x3c
> > +     .org            .Ldoshdr + 0x38
> > +     .long           LINUX_PE_MAGIC
> >       .long           .Lpehdr - .Ldoshdr                      // PE header offset
> >
> >  .Lpehdr:
> > diff --git a/include/linux/pe.h b/include/linux/pe.h
> > index 056a1762de904fc1..1db4c944efd78f51 100644
> > --- a/include/linux/pe.h
> > +++ b/include/linux/pe.h
> > @@ -31,6 +31,13 @@
> >  #define LINUX_EFISTUB_MAJOR_VERSION          0x1
> >  #define LINUX_EFISTUB_MINOR_VERSION          0x1
> >
> > +/*
> > + * LINUX_PE_MAGIC appears at offset 0x38 into the MSDOS header of EFI bootable
>
> s/MSDOS/MS-DOS/
>
> > + * Linux kernel images that target the architecture as specified by the PE/COFF
> > + * header machine type field.
> > + */
> > +#define LINUX_PE_MAGIC       0x818223cd
> > +
> >  #define MZ_MAGIC     0x5a4d  /* "MZ" */
> >
> >  #define PE_MAGIC             0x00004550      /* "PE\0\0" */
>
> If you take into account these minor things mentioned above you can add
> Reviewed-by: Daniel Kiper <daniel.kiper@oracle.com> to your both patches.
>

Thanks

> Atish, could you respin your GRUB "Unify ARM64 & RISC-V Linux Loader"
> patch set when both Ard's patches are in at least "efi" Linux kernel
> branch? Hmmm... I am not sure it will go through "efi" branch. Ard?
>

Yes, I already pushed a version, but I will update the patch to take
your feedback into account.

The patch is queued up for v6.2, so it should be in mainline by the
end of the year.
