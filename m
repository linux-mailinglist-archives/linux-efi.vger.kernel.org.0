Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11BB36440E0
	for <lists+linux-efi@lfdr.de>; Tue,  6 Dec 2022 10:57:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232060AbiLFJ54 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 6 Dec 2022 04:57:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235510AbiLFJ4p (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 6 Dec 2022 04:56:45 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF1C123BE3
        for <linux-efi@vger.kernel.org>; Tue,  6 Dec 2022 01:52:27 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id m4so6475749pls.4
        for <linux-efi@vger.kernel.org>; Tue, 06 Dec 2022 01:52:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uKFNU1drlDzzo2Glt7CSqF/E/XUOsjXB/mbXpcJbYZg=;
        b=Kj9ZIu5jdhO4savvug0c131uDt7Yg8oeemgdn7fAwN/LzS1iEJeWF9KFffDhh/WN8K
         zESG0d/jgsZ0jwby9Vy9iHrhqeiTsjDUQyc6qM3+a/wRisO3T0g1CEfEBjuDSFeXAQPt
         M7JS7ZQmIelfoIlHbQSO8fZC/k60lexQRnppc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uKFNU1drlDzzo2Glt7CSqF/E/XUOsjXB/mbXpcJbYZg=;
        b=ZtVfcPBDv3w9v8O2dzNAR8eadxUCfcfWDWbKGH9kSCTsVCDVSvz7jiCZldG392b/oK
         YPLSc9FZYWFp6N9KApyiDddWFIDlDAyxbKDBh9yoijX/oVl0tWSxLYllfsYv/C0kXGum
         EnG72oiSCXS1piUFHeFSc5juyQG5sqMRUB0DdwqxkbToxfmDQRdvpXT7g3vXqmk8nnTV
         E/PkoBC2QUilctThVhbNZq/HjPwwbcEKmozf9ypXtTpf55z9WtGKGgKU+VxAsmiehnN5
         z0Fa5hmOy3QI1jDS3781njL11DujvZw4jb5oq4NbGWOXJsTyXBug1oqAdr9ECXqGzAlZ
         w+YQ==
X-Gm-Message-State: ANoB5pnk0Sdi7iXnNmSQOBUDLHFu6h5/sIq6geQVdiV8FErzEl7Oh4Qy
        5xJWVHZNJ7fORae9HBIAtR3Mxp0OV3SbfBXNt9K0
X-Google-Smtp-Source: AA0mqf56FPnQWEpJiz3fb/KMOjPdaC0n8tthqYCC49KfoSKV9onZy2okjB4/ksNhYSIUSOmoUfnLEi2NI/7ggUDxzts=
X-Received: by 2002:a17:902:6b85:b0:187:3c62:582c with SMTP id
 p5-20020a1709026b8500b001873c62582cmr68702749plk.114.1670320336759; Tue, 06
 Dec 2022 01:52:16 -0800 (PST)
MIME-Version: 1.0
References: <20221129175616.2089294-1-ardb@kernel.org> <20221129175616.2089294-3-ardb@kernel.org>
 <Y4i6YExOV80rxdhq@tomti.i.net-space.pl>
In-Reply-To: <Y4i6YExOV80rxdhq@tomti.i.net-space.pl>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Tue, 6 Dec 2022 01:52:04 -0800
Message-ID: <CAOnJCUJ-oPeuRPHFZOkMMYAt=wnnspNnHaQMpa1Fa1odiazbBA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] efi: Put Linux specific magic number in the DOS header
To:     Daniel Kiper <daniel.kiper@oracle.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org,
        grub-devel@gnu.org, Huacai Chen <chenhuacai@kernel.org>,
        Atish Patra <atishp@rivosinc.com>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Leif Lindholm <quic_llindhol@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Dec 1, 2022 at 6:30 AM Daniel Kiper <daniel.kiper@oracle.com> wrote:
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
> Atish, could you respin your GRUB "Unify ARM64 & RISC-V Linux Loader"
> patch set when both Ard's patches are in at least "efi" Linux kernel
> branch? Hmmm... I am not sure it will go through "efi" branch. Ard?
>

Sure. We need to remove the arch specific header files in the next
version as well.
I am planning to revise the series before/during the holidays. Hope
that's fine w.r.t Grub release.
Otherwise, please let me know.

> Daniel



-- 
Regards,
Atish
