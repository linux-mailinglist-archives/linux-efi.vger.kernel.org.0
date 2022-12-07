Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 348736457F6
	for <lists+linux-efi@lfdr.de>; Wed,  7 Dec 2022 11:36:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbiLGKgG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-efi@lfdr.de>); Wed, 7 Dec 2022 05:36:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbiLGKgE (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 7 Dec 2022 05:36:04 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 550F02C676
        for <linux-efi@vger.kernel.org>; Wed,  7 Dec 2022 02:35:59 -0800 (PST)
Received: from loongson.cn (unknown [192.168.200.1])
        by gateway (Coremail) with SMTP id _____8AxxvCObJBjHswDAA--.8742S3;
        Wed, 07 Dec 2022 18:35:58 +0800 (CST)
Received: from [10.40.24.8] (unknown [192.168.200.1])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8AxkOKKbJBjxy4nAA--.17019S2;
        Wed, 07 Dec 2022 18:35:54 +0800 (CST)
Message-ID: <235c218774e535a3b620294b7f817ff74a59f39d.camel@loongson.cn>
Subject: Re: [PATCH v2 2/2] efi: Put Linux specific magic number in the DOS
 header
From:   Xiaotian Wu <wuxiaotian@loongson.cn>
To:     The development of GNU GRUB <grub-devel@gnu.org>
Cc:     linux-efi@vger.kernel.org, Huacai Chen <chenhuacai@kernel.org>,
        Atish Patra <atishp@rivosinc.com>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Daniel Kiper <daniel.kiper@oracle.com>,
        Leif Lindholm <quic_llindhol@quicinc.com>
Date:   Wed, 07 Dec 2022 18:35:54 +0800
In-Reply-To: <CAMj1kXGQdYxAMvDZWMbXzo-yMP_1+0BLZSrVnz3XqMg+hJ_u6g@mail.gmail.com>
References: <20221129175616.2089294-1-ardb@kernel.org>
         <20221129175616.2089294-3-ardb@kernel.org>
         <2c6ef81cda85345585cafbbbf9214e38fd7ca369.camel@loongson.cn>
         <CAMj1kXGQdYxAMvDZWMbXzo-yMP_1+0BLZSrVnz3XqMg+hJ_u6g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.1 
MIME-Version: 1.0
X-CM-TRANSID: AQAAf8AxkOKKbJBjxy4nAA--.17019S2
X-CM-SenderInfo: 5zx0xtprwlt0o6or00hjvr0hdfq/1tbiAQANCGOPMOcZIwAAsF
X-Coremail-Antispam: 1Uk129KBjvJXoWxuFWDKry5ZFW5Wr4DZFyrZwb_yoW3CF17pF
        ykJFyUGryDJr1rJw1Utr1UuFyUZr4UJ3WUXr15JFy8Jryqgr1jqr1UXr1YgFyUJr4rJr1j
        qr15JFy7ZF1UJrJanT9S1TB71UUUUjDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        b2xFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4
        AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF
        7I0E14v26r1j6r4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x
        0267AKxVWxJr0_GcWln4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF
        6xkI12xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6x8ErcxFaVAv8V
        WrMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCY1x0262kKe7AKxVWUAVWUtwCF
        04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26rWl4I8I3I0E4IkC6x0Yz7v_Jr0_Gr
        1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AK
        xVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcV
        AFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8I
        cIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r
        4j6r4UJbIYCTnIWIevJa73UjIFyTuYvj4RKpBTUUUUU
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,RCVD_IN_SBL_CSS,
        SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

在 2022-12-07星期三的 09:06 +0100，Ard Biesheuvel写道：
> On Wed, 7 Dec 2022 at 08:51, Xiaotian Wu <wuxiaotian@loongson.cn>
> wrote:
> > 
> > 在 2022-11-29星期二的 18:56 +0100，Ard Biesheuvel写道：
> > > GRUB currently relies on the magic number in the image header of
> > > ARM
> > > and
> > > arm64 EFI kernel images to decide whether or not the image in
> > > question
> > > is a bootable kernel.
> > > 
> > > However, the purpose of the magic number is to identify the image
> > > as
> > > one
> > > that implements the bare metal boot protocol, and so GRUB, which
> > > only
> > > does EFI boot, can only boot images that could potentially be
> > > booted
> > > in
> > > a non-EFI manner as well.
> > > 
> > > This is problematic for the new zboot decompressor image format,
> > > as
> > > it
> > > can only boot in EFI mode, and must therefore not use the bare
> > > metal
> > > boot magic number in its header.
> > > 
> > > For this reason, the strict magic number was dropped from GRUB,
> > > to
> > > permit essentially any kind of EFI executable to be booted via
> > > the
> > > 'linux' command, blurring the line between the linux loader and
> > > the
> > > chainloader.
> > > 
> > > So let's use the same field in the DOS header that RISC-V and
> > > arm64
> > > already use for their 'bare metal' magic numbers to store a
> > > 'generic
> > > Linux kernel' magic number, which can be used to identify
> > > bootable
> > > kernel images in PE format which don't necessarily implement a
> > > bare
> > > metal boot protocol in the same binary. Note that, in the context
> > > of
> > > EFI, the MSDOS header is only described in terms of the fields
> > > that
> > > it
> > > shares with the hybrid PE/COFF image format, (i.e., the magic
> > > number
> > > at
> > > offset #0 and the PE header offset at byte offset #0x3c). Since
> > > we
> > > aim
> > > for compatibility with EFI only, and not with MS-DOS or MS-
> > > Windows,
> > > we
> > > can use the remaining space in the MS-DOS header however we want.
> > > 
> > > Let's set the generic magic number for x86 images as well:
> > > existing
> > > bootloaders already have their own methods to identify x86 Linux
> > > images
> > > that can be booted in a non-EFI manner, and having the magic
> > > number
> > > in
> > > place there will ease any future transitions in loader
> > > implementations
> > > to merge the x86 and non-x86 EFI boot paths.
> > > 
> > > Note that 32-bit ARM already uses the same location in the header
> > > for
> > > a
> > > different purpose, but the ARM support is already widely
> > > implemented
> > > and
> > > the EFI zboot decompressor is not available on ARM anyway, so we
> > > just
> > > disregard it here.
> > > 
> > > Cc: Huacai Chen <chenhuacai@kernel.org>
> > > Cc: Atish Patra <atishp@rivosinc.com>
> > > Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> > > Cc: Daniel Kiper <daniel.kiper@oracle.com>
> > > Cc: Leif Lindholm <quic_llindhol@quicinc.com>
> > > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > > ---
> > >  arch/loongarch/kernel/head.S                | 3 ++-
> > >  arch/x86/boot/header.S                      | 3 ++-
> > >  drivers/firmware/efi/libstub/zboot-header.S | 3 ++-
> > >  include/linux/pe.h                          | 7 +++++++
> > >  4 files changed, 13 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/arch/loongarch/kernel/head.S
> > > b/arch/loongarch/kernel/head.S
> > > index 84970e2666588963..caa74439700eee93 100644
> > > --- a/arch/loongarch/kernel/head.S
> > > +++ b/arch/loongarch/kernel/head.S
> > > @@ -25,7 +25,8 @@ _head:
> > >         .dword  kernel_entry            /* Kernel entry point */
> > >         .dword  _end - _text            /* Kernel image effective
> > > size */
> > >         .quad   0                       /* Kernel image load
> > > offset
> > > from start of RAM */
> > > -       .org    0x3c                    /* 0x20 ~ 0x3b reserved
> > > */
> > > +       .org    0x38                    /* 0x20 ~ 0x38 reserved
> > > */
> > > +       .long   LINUX_PE_MAGIC
> > >         .long   pe_header - _head       /* Offset to the PE
> > > header */
> > > 
> > >  pe_header:
> > > diff --git a/arch/x86/boot/header.S b/arch/x86/boot/header.S
> > > index f912d777013052ea..be8f78a7ee325475 100644
> > > --- a/arch/x86/boot/header.S
> > > +++ b/arch/x86/boot/header.S
> > > @@ -80,10 +80,11 @@ bs_die:
> > >         ljmp    $0xf000,$0xfff0
> > > 
> > >  #ifdef CONFIG_EFI_STUB
> > > -       .org    0x3c
> > > +       .org    0x38
> > >         #
> > >         # Offset to the PE header.
> > >         #
> > > +       .long   LINUX_PE_MAGIC
> > >         .long   pe_header
> > >  #endif /* CONFIG_EFI_STUB */
> > > 
> > > diff --git a/drivers/firmware/efi/libstub/zboot-header.S
> > > b/drivers/firmware/efi/libstub/zboot-header.S
> > > index bc2d7750d7f14174..ec4525d40e0cf6d6 100644
> > > --- a/drivers/firmware/efi/libstub/zboot-header.S
> > > +++ b/drivers/firmware/efi/libstub/zboot-header.S
> > > @@ -20,7 +20,8 @@ __efistub_efi_zboot_header:
> > >         .long           __efistub__gzdata_size - 12            
> > > //
> > > payload size
> > >         .long           0, 0                                   
> > > //
> > > reserved
> > >         .asciz          COMP_TYPE                              
> > > //
> > > compression type
> > > -       .org            .Ldoshdr + 0x3c
> > > +       .org            .Ldoshdr + 0x38
> > > +       .long           LINUX_PE_MAGIC
> > >         .long           .Lpehdr - .Ldoshdr                     
> > > // PE
> > > header offset
> > > 
> > >  .Lpehdr:
> > > diff --git a/include/linux/pe.h b/include/linux/pe.h
> > > index 056a1762de904fc1..1db4c944efd78f51 100644
> > > --- a/include/linux/pe.h
> > > +++ b/include/linux/pe.h
> > > @@ -31,6 +31,13 @@
> > >  #define LINUX_EFISTUB_MAJOR_VERSION            0x1
> > >  #define LINUX_EFISTUB_MINOR_VERSION            0x1
> > > 
> > > +/*
> > > + * LINUX_PE_MAGIC appears at offset 0x38 into the MSDOS header
> > > of
> > > EFI bootable
> > > + * Linux kernel images that target the architecture as specified
> > > by
> > > the PE/COFF
> > > + * header machine type field.
> > > + */
> > > +#define LINUX_PE_MAGIC 0x818223cd
> > > +
> > >  #define MZ_MAGIC       0x5a4d  /* "MZ" */
> > > 
> > >  #define PE_MAGIC               0x00004550      /* "PE\0\0" */
> > 
> > 
> > As far as I know, Archlinux automatically generates initramfs
> > according
> > to the version number in the kernel file. The latest generic
> > compressed
> > EFI designs do not seem to provide kernel version number
> > information.
> 
> No, but nor do the gzip'ed images arm64 uses today, and the script
> seems take care of that.
> 
> The EFI zboot image has metadata in the header, so the script can
> decompress it and grep for the version number it it needs to.

I tested it, and the decompression can be completed, thank you.
> 
> > This may change the usage habits of Archlinux users. Is it possible
> > to
> > add the kernel version number to vmlinuz.efi?
> > 
> > https://gitlab.archlinux.org/archlinux/mkinitcpio/mkinitcpio/-/blob/master/functions#L209
> > 
> 
> The current header doesn't have that so I don't think EFI zboot
> should
> be adding it either.
> 
> _______________________________________________
> Grub-devel mailing list
> Grub-devel@gnu.org
> https://lists.gnu.org/mailman/listinfo/grub-devel

-- 
Best Regards
Xiaotian Wu

