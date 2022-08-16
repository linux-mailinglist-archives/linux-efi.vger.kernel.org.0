Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A10C595EEE
	for <lists+linux-efi@lfdr.de>; Tue, 16 Aug 2022 17:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236123AbiHPPX4 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 16 Aug 2022 11:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235831AbiHPPXj (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 16 Aug 2022 11:23:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF2D4625F;
        Tue, 16 Aug 2022 08:23:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 894B5611A1;
        Tue, 16 Aug 2022 15:23:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D59D9C433B5;
        Tue, 16 Aug 2022 15:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660663406;
        bh=g1DTIvctjcRUBjkx79Rdx7vQx/nTWAvlLimDO9KeW5o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pWSSLkY7ypQNpXhhvq5gn0D0wG5XqGIBQN8IdySxULCmiEol3xe3AftZ0eLJYbZWf
         ZmZrwKFF3QW+lJVwoOp2QPackgpKukpFfVM2efJN4wvGkF/sZVOyZgCrhm4xsz7OQS
         IKVpjtiYE6k99HwOzeiTwXJBkthkaqR4P9cEoyxP2GafM6nSZc0IGitwR5iIHdtqgF
         2JhU9u3+O7Q6SSAanjy+nRh+0mmcv8xVBy5FxGFrE6Y1JtOpr0N4sJ1wOlGXu0It3L
         2nAmQDkVb0I/NDKEIRTHs5WeKuPSqIcigDtBX1fEEM7xznb5bXikxtOmVIWD+abOJ0
         T6jOuXLnu4F/A==
Received: by mail-ua1-f47.google.com with SMTP id f15so4138906uao.12;
        Tue, 16 Aug 2022 08:23:26 -0700 (PDT)
X-Gm-Message-State: ACgBeo3qaksLyET3lxRC316uRZq7e50SxIB170E1pZsiyC7bmLQ3EFE3
        Xt6PTUqfNjjgPRvquQSvivMRRtYV5EfQfxiSqdU=
X-Google-Smtp-Source: AA6agR6rYt6G7/FiKbWZbKJl+MRLJhkhxRjnUuKlfybcLHLonbt74c8vcRW7283Rxj+p9JXqjHNC01QmzHNdto9DZZY=
X-Received: by 2002:ab0:385:0:b0:393:1cee:aad9 with SMTP id
 5-20020ab00385000000b003931ceeaad9mr837546uau.104.1660663405581; Tue, 16 Aug
 2022 08:23:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220617145754.582056-1-chenhuacai@loongson.cn> <CAMj1kXERN209b7dbVs_hy4BeUwrmk2p9_vF+Wq2W8PUeHOQTkg@mail.gmail.com>
In-Reply-To: <CAMj1kXERN209b7dbVs_hy4BeUwrmk2p9_vF+Wq2W8PUeHOQTkg@mail.gmail.com>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Tue, 16 Aug 2022 23:23:12 +0800
X-Gmail-Original-Message-ID: <CAAhV-H60CJDRY4c+Eu+L=rNgHsXQqx=HK9nNSqg69WVV+Bm3SQ@mail.gmail.com>
Message-ID: <CAAhV-H60CJDRY4c+Eu+L=rNgHsXQqx=HK9nNSqg69WVV+Bm3SQ@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: Add efistub booting support
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>, loongarch@lists.linux.dev,
        linux-arch <linux-arch@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi, Ard,

On Tue, Aug 16, 2022 at 9:27 PM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Fri, 17 Jun 2022 at 16:56, Huacai Chen <chenhuacai@loongson.cn> wrote:
> >
> > This patch adds efistub booting support, which is the standard UEFI boot
> > protocol for us to use.
> >
> > We use generic efistub, which means we can pass boot information (i.e.,
> > system table, memory map, kernel command line, initrd) via a light FDT
> > and drop a lot of non-standard code.
> >
> > We use a flat mapping to map the efi runtime in the kernel's address
> > space. In efi, VA = PA; in kernel, VA = PA + PAGE_OFFSET. As a result,
> > flat mapping is not identity mapping, SetVirtualAddressMap() is still
> > needed for the efi runtime.
> >
> > Currently, generic efistub doesn't support mapping efi runtime in the
> > kernel. So we set efi_novamap to not call SetVirtualAddressMap() in the
> > stub. Instead, we call it in the core kernel. This also makes the raw
> > elf kernel booting be possible, which is needed by non-UEFI firmware
> > (e.g., PMON which is widely used by Loongson for historic reasons).
> >
> > Then how the elf kernel and the efi kernel co-exist? When building, the
> > raw vmlinux is naturally in elf format, the efi kernel is generated from
> > vmlinux by objcopy via removing the elf header.
> >
> > Note: The magic number in MSDOS header is used by Grub [1], which is the
> > same as RISC-V and ARM64.
> >
> > [1] https://lists.gnu.org/archive/html/grub-devel/2021-10/msg00215.html
> >
>
> That patch was never merged. Today, arm64 is the only arch in GRUB
> that uses EFI boot exclusively, and requires an additional magic
> number in the PE/COFF header. This is a mistake, which makes it
> difficult, e.g., to implement a generic EFI decompressor.
>
> The magic number signifies that the image implements the bare metal
> boot protocol, which GRUB does not implement. So it should not check
> for the magic number. I sent a patch for that here:
> https://lists.gnu.org/archive/html/grub-devel/2022-08/msg00113.html
>
> Please don't copy the same mistake in your GRUB port.
OK, thanks.

>
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > ---
> >  arch/loongarch/Kconfig                        |   9 ++
> >  arch/loongarch/Makefile                       |   5 +
> >  arch/loongarch/boot/Makefile                  |   4 +
> >  arch/loongarch/kernel/efi-header.S            | 101 ++++++++++++++
> >  arch/loongarch/kernel/efi.c                   | 126 +++++++++++++++++-
> >  arch/loongarch/kernel/head.S                  |  26 ++++
> >  arch/loongarch/kernel/image-vars.h            |  29 ++++
> >  arch/loongarch/kernel/vmlinux.lds.S           |   1 +
> >  drivers/firmware/efi/Kconfig                  |   2 +-
> >  drivers/firmware/efi/libstub/Makefile         |  10 ++
> >  .../firmware/efi/libstub/efi-stub-helper.c    |   2 +-
> >  drivers/firmware/efi/libstub/efi-stub.c       |   4 +-
> >  drivers/firmware/efi/libstub/loongarch-stub.c |  88 ++++++++++++
> >  include/linux/efi.h                           |   1 +
> >  include/linux/pe.h                            |   2 +
> >  15 files changed, 405 insertions(+), 5 deletions(-)
> >  create mode 100644 arch/loongarch/kernel/efi-header.S
> >  create mode 100644 arch/loongarch/kernel/image-vars.h
> >  create mode 100644 drivers/firmware/efi/libstub/loongarch-stub.c
> >
> > diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> > index 1ec220df751d..faee7fa4c004 100644
> > --- a/arch/loongarch/Kconfig
> > +++ b/arch/loongarch/Kconfig
> > @@ -305,6 +305,15 @@ config EFI
> >           This enables the kernel to use EFI runtime services that are
> >           available (such as the EFI variable services).
> >
> > +config EFI_STUB
> > +       bool "EFI boot stub support"
> > +       default y
> > +       depends on EFI
> > +       select EFI_GENERIC_STUB
> > +       help
> > +         This kernel feature allows the kernel to be loaded directly by
> > +         EFI firmware without the use of a bootloader.
> > +
> >  config SMP
> >         bool "Multi-Processing support"
> >         help
> > diff --git a/arch/loongarch/Makefile b/arch/loongarch/Makefile
> > index fbe4277e6404..c1bda54893ec 100644
> > --- a/arch/loongarch/Makefile
> > +++ b/arch/loongarch/Makefile
> > @@ -7,7 +7,11 @@ boot   := arch/loongarch/boot
> >
> >  KBUILD_DEFCONFIG := loongson3_defconfig
> >
> > +ifndef CONFIG_EFI_STUB
> >  KBUILD_IMAGE   = $(boot)/vmlinux
> > +else
> > +KBUILD_IMAGE   = $(boot)/vmlinux.efi
> > +endif
> >
>
> I think this needs to be cleaned up. Calling your abstract non-EFI
> build target 'vmlinux' is going to clash with the actual file called
> vmlinux. So I suggest to rename this to vmlinux.elf and vmlinux.efi.
OK, thanks.

>
> >  #
> >  # Select the object file format to substitute into the linker script.
> > @@ -73,6 +77,7 @@ endif
> >  head-y := arch/loongarch/kernel/head.o
> >
> >  libs-y += arch/loongarch/lib/
> > +libs-$(CONFIG_EFI_STUB) += $(objtree)/drivers/firmware/efi/libstub/lib.a
> >
> >  ifeq ($(KBUILD_EXTMOD),)
> >  prepare: vdso_prepare
> > diff --git a/arch/loongarch/boot/Makefile b/arch/loongarch/boot/Makefile
> > index 0125b17edc98..b39d50a7a3df 100644
> > --- a/arch/loongarch/boot/Makefile
> > +++ b/arch/loongarch/boot/Makefile
> > @@ -14,3 +14,7 @@ quiet_cmd_strip = STRIP         $@
> >
> >  $(obj)/vmlinux: vmlinux FORCE
> >         $(call if_changed,strip)
> > +
> > +targets += vmlinux.efi
> > +$(obj)/vmlinux.efi: $(obj)/vmlinux FORCE
> > +       $(call if_changed,objcopy)
>
> Same here (.elf vs .efi)
OK, thanks.

>
> > diff --git a/arch/loongarch/kernel/efi-header.S b/arch/loongarch/kernel/efi-header.S
> > new file mode 100644
> > index 000000000000..ef48dc72455b
> > --- /dev/null
> > +++ b/arch/loongarch/kernel/efi-header.S
> > @@ -0,0 +1,101 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
> > + */
> > +
> > +#include <linux/pe.h>
> > +#include <linux/sizes.h>
> > +
> > +       .macro  __EFI_PE_HEADER
> > +       .long   PE_MAGIC
> > +.Lcoff_header:
> > +#ifdef CONFIG_32BIT
> > +       .short  IMAGE_FILE_MACHINE_LOONGARCH32          /* Machine */
> > +#else
> > +       .short  IMAGE_FILE_MACHINE_LOONGARCH64          /* Machine */
> > +#endif
>
> Please drop the 32-bit version here. 32-bit binaries use PE32 not
> PE32+ so this header is not 32-bit compatible anway
OK, thanks.

>
> > +       .short  .Lsection_count                         /* NumberOfSections */
> > +       .long   0                                       /* TimeDateStamp */
> > +       .long   0                                       /* PointerToSymbolTable */
> > +       .long   0                                       /* NumberOfSymbols */
> > +       .short  .Lsection_table - .Loptional_header     /* SizeOfOptionalHeader */
> > +       .short  IMAGE_FILE_DEBUG_STRIPPED | \
> > +               IMAGE_FILE_EXECUTABLE_IMAGE | \
> > +               IMAGE_FILE_LINE_NUMS_STRIPPED           /* Characteristics */
> > +
> > +.Loptional_header:
> > +       .short  PE_OPT_MAGIC_PE32PLUS                   /* PE32+ format */
> > +       .byte   0x02                                    /* MajorLinkerVersion */
> > +       .byte   0x14                                    /* MinorLinkerVersion */
> > +       .long   __inittext_end - .Lefi_header_end       /* SizeOfCode */
> > +       .long   _end - __initdata_begin                 /* SizeOfInitializedData */
> > +       .long   0                                       /* SizeOfUninitializedData */
> > +       .long   __efistub_efi_pe_entry - _head          /* AddressOfEntryPoint */
> > +       .long   .Lefi_header_end - _head                /* BaseOfCode */
> > +
> > +.Lextra_header_fields:
> > +       .quad   0                                       /* ImageBase */
> > +       .long   PECOFF_SEGMENT_ALIGN                    /* SectionAlignment */
> > +       .long   PECOFF_FILE_ALIGN                       /* FileAlignment */
> > +       .short  0                                       /* MajorOperatingSystemVersion */
> > +       .short  0                                       /* MinorOperatingSystemVersion */
> > +       .short  LINUX_EFISTUB_MAJOR_VERSION             /* MajorImageVersion */
> > +       .short  LINUX_EFISTUB_MINOR_VERSION             /* MinorImageVersion */
> > +       .short  0                                       /* MajorSubsystemVersion */
> > +       .short  0                                       /* MinorSubsystemVersion */
> > +       .long   0                                       /* Win32VersionValue */
> > +
> > +       .long   _end - _head                            /* SizeOfImage */
> > +
> > +       /* Everything before the kernel image is considered part of the header */
> > +       .long   .Lefi_header_end - _head                /* SizeOfHeaders */
> > +       .long   0                                       /* CheckSum */
> > +       .short  IMAGE_SUBSYSTEM_EFI_APPLICATION         /* Subsystem */
> > +       .short  0                                       /* DllCharacteristics */
> > +       .quad   0                                       /* SizeOfStackReserve */
> > +       .quad   0                                       /* SizeOfStackCommit */
> > +       .quad   0                                       /* SizeOfHeapReserve */
> > +       .quad   0                                       /* SizeOfHeapCommit */
> > +       .long   0                                       /* LoaderFlags */
> > +       .long   (.Lsection_table - .) / 8               /* NumberOfRvaAndSizes */
> > +
> > +       .quad   0                                       /* ExportTable */
> > +       .quad   0                                       /* ImportTable */
> > +       .quad   0                                       /* ResourceTable */
> > +       .quad   0                                       /* ExceptionTable */
> > +       .quad   0                                       /* CertificationTable */
> > +       .quad   0                                       /* BaseRelocationTable */
> > +
> > +       /* Section table */
> > +.Lsection_table:
> > +       .ascii  ".text\0\0\0"
> > +       .long   __inittext_end - .Lefi_header_end       /* VirtualSize */
> > +       .long   .Lefi_header_end - _head                /* VirtualAddress */
> > +       .long   __inittext_end - .Lefi_header_end       /* SizeOfRawData */
> > +       .long   .Lefi_header_end - _head                /* PointerToRawData */
> > +
> > +       .long   0                                       /* PointerToRelocations */
> > +       .long   0                                       /* PointerToLineNumbers */
> > +       .short  0                                       /* NumberOfRelocations */
> > +       .short  0                                       /* NumberOfLineNumbers */
> > +       .long   IMAGE_SCN_CNT_CODE | \
> > +               IMAGE_SCN_MEM_READ | \
> > +               IMAGE_SCN_MEM_EXECUTE                   /* Characteristics */
> > +
> > +       .ascii  ".data\0\0\0"
> > +       .long   _end - __initdata_begin                 /* VirtualSize */
> > +       .long   __initdata_begin - _head                /* VirtualAddress */
> > +       .long   _edata - __initdata_begin               /* SizeOfRawData */
> > +       .long   __initdata_begin - _head                /* PointerToRawData */
> > +
> > +       .long   0                                       /* PointerToRelocations */
> > +       .long   0                                       /* PointerToLineNumbers */
> > +       .short  0                                       /* NumberOfRelocations */
> > +       .short  0                                       /* NumberOfLineNumbers */
> > +       .long   IMAGE_SCN_CNT_INITIALIZED_DATA | \
> > +               IMAGE_SCN_MEM_READ | \
> > +               IMAGE_SCN_MEM_WRITE                     /* Characteristics */
> > +
> > +       .set    .Lsection_count, (. - .Lsection_table) / 40
> > +.Lefi_header_end:
>
> This symbol needs to be section aligned, or the section header fields
> will be off. Even if it works today, the PE/COFF spec requires the
> section's VirtualSize and VirtualAddress fields to be section aligned.
OK, thanks.

>
> > +       .endm
> > diff --git a/arch/loongarch/kernel/efi.c b/arch/loongarch/kernel/efi.c
> > index a50b60c587fa..42f7cfe9ab03 100644
> > --- a/arch/loongarch/kernel/efi.c
> > +++ b/arch/loongarch/kernel/efi.c
> > @@ -22,19 +22,141 @@
> >
> >  #include <asm/early_ioremap.h>
> >  #include <asm/efi.h>
> > +#include <asm/tlb.h>
> >  #include <asm/loongson.h>
> >
> >  static unsigned long efi_nr_tables;
> >  static unsigned long efi_config_table;
> > +static unsigned long screen_info_table __initdata = EFI_INVALID_TABLE_ADDR;
> >
> >  static efi_system_table_t *efi_systab;
> > -static efi_config_table_type_t arch_tables[] __initdata = {{},};
> > +static efi_config_table_type_t arch_tables[] __initdata = {
> > +       {LINUX_EFI_LARCH_SCREEN_INFO_TABLE_GUID, &screen_info_table, "SINFO"},
> > +       {},
> > +};
> > +
> > +static void __init init_screen_info(void)
> > +{
> > +       struct screen_info *si;
> > +
> > +       if (screen_info_table == EFI_INVALID_TABLE_ADDR)
> > +               return;
> > +
> > +       si = early_memremap_ro(screen_info_table, sizeof(*si));
> > +       if (!si) {
> > +               pr_err("Could not map screen_info config table\n");
> > +               return;
> > +       }
> > +       screen_info = *si;
> > +       early_memunmap(si, sizeof(*si));
> > +
> > +       if (screen_info.orig_video_isVGA == VIDEO_TYPE_EFI)
> > +               memblock_reserve(screen_info.lfb_base, screen_info.lfb_size);
> > +}
> > +
>
> The above may be unnecessary - the EFI stub is part of the core kernel
> image, so you can access screen_info directly (please refer to the
> arm64 port for an example)
Though we haven't supported zboot yet, but you are proposing for that.
I think in that case we should use dynamic allocation?

>
> > +static void __init create_tlb(u32 index, u64 vppn, u32 ps, u32 mat)
> > +{
> > +       unsigned long tlblo0, tlblo1;
> > +
> > +       write_csr_pagesize(ps);
> > +
> > +       tlblo0 = vppn | CSR_TLBLO0_V | CSR_TLBLO0_WE |
> > +               CSR_TLBLO0_GLOBAL | (mat << CSR_TLBLO0_CCA_SHIFT);
> > +       tlblo1 = tlblo0 + (1 << ps);
> > +
> > +       csr_write64(vppn, LOONGARCH_CSR_TLBEHI);
> > +       csr_write64(tlblo0, LOONGARCH_CSR_TLBELO0);
> > +       csr_write64(tlblo1, LOONGARCH_CSR_TLBELO1);
> > +       csr_xchg32(0, CSR_TLBIDX_EHINV, LOONGARCH_CSR_TLBIDX);
> > +       csr_xchg32(index, CSR_TLBIDX_IDX, LOONGARCH_CSR_TLBIDX);
> > +
> > +       tlb_write_indexed();
> > +}
> > +
> > +#define MTLB_ENTRY_INDEX       0x800
> > +
> > +/* Create VA == PA mapping as UEFI */
> > +static void __init fix_efi_mapping(void)
> > +{
> > +       unsigned int index = MTLB_ENTRY_INDEX;
> > +       unsigned int tlbnr = boot_cpu_data.tlbsizemtlb - 2;
> > +       unsigned long i, vppn;
> > +
> > +       /* Low Memory, Cached */
> > +       create_tlb(index++, 0x00000000, PS_128M, 1);
> > +       /* MMIO Registers, Uncached */
> > +       create_tlb(index++, 0x10000000, PS_128M, 0);
> > +
> > +       /* High Memory, Cached */
> > +       for (i = 0; i < tlbnr; i++) {
> > +               vppn = 0x80000000ULL + (i * SZ_2G);
> > +               create_tlb(index++, vppn, PS_1G, 1);
> > +       }
> > +}
> > +
> > +/*
> > + * set_virtual_map() - create a virtual mapping for the EFI memory map and call
> > + * efi_set_virtual_address_map enter virtual for runtime service
> > + *
> > + * This function populates the virt_addr fields of all memory region descriptors
> > + * in @memory_map whose EFI_MEMORY_RUNTIME attribute is set. Those descriptors
> > + * are also copied to @runtime_map, and their total count is returned in @count.
> > + */
>
> You mentioned before that this must be done in the core kernel and not
> in the EFI stub, but I don't remember the reason.
>
> Can you add a comment here why the below conversions cannot be done by
> the EFI stub? Doing this in the stub removes the need to set up a 1:1
> mapping just for a single invocation of SetVirtualAddressMap(), so if
> there is any way to move this into the stub, I would strongly prefer
> it.
In the current implementation of generic efistub, efi runtime is in a
separate address space, but we want to map efi runtime in the kernel
address space. So, even if we do SVAM in stub, we still need to modify
some code. And if we do SVAM in the core kernel, we don't need to
modify generic stub (as a side effect, this makes the non-EFI kernel
be also able to use efi runtime).

If use efi runtime in non-EFI kernel is unacceptable, and if we are
free to modify the generic stub, then we can move SVAM to the stub.

>
> > +static int __init set_virtual_map(void)
> > +{
> > +       int count = 0;
> > +       unsigned int size;
> > +       unsigned long attr;
> > +       efi_status_t status;
> > +       efi_runtime_services_t *rt;
> > +       efi_set_virtual_address_map_t *svam;
> > +       efi_memory_desc_t *in, runtime_map[32];
> > +
> > +       size = sizeof(efi_memory_desc_t);
> > +
> > +       for_each_efi_memory_desc(in) {
> > +               attr = in->attribute;
> > +               if (!(attr & EFI_MEMORY_RUNTIME))
> > +                       continue;
> > +
> > +               if (attr & (EFI_MEMORY_WB | EFI_MEMORY_WT))
> > +                       in->virt_addr = TO_CACHE(in->phys_addr);
> > +               else
> > +                       in->virt_addr = TO_UNCACHE(in->phys_addr);
> > +
> > +               memcpy(&runtime_map[count++], in, size);
> > +       }
> > +
> > +       rt = early_memremap_ro((unsigned long)efi_systab->runtime, sizeof(*rt));
> > +
> > +       /* Install the new virtual address map */
> > +       svam = rt->set_virtual_address_map;
> > +
> > +       fix_efi_mapping();
> > +
> > +       status = svam(size * count, size, efi.memmap.desc_version,
> > +                       (efi_memory_desc_t *)TO_PHYS((unsigned long)runtime_map));
> > +
> > +       local_flush_tlb_all();
> > +       write_csr_pagesize(PS_DEFAULT_SIZE);
> > +
> > +       return 0;
> > +}
> >
> >  void __init efi_runtime_init(void)
> >  {
> > +       int status;
> > +
> >         if (!efi_enabled(EFI_BOOT))
> >                 return;
> >
> > +       if (!efi_systab->runtime)
> > +               return;
> > +
> > +       status = set_virtual_map();
> > +       if (status < 0)
> > +               return;
> > +
> >         if (efi_runtime_disabled()) {
> >                 pr_info("EFI runtime services will be disabled.\n");
> >                 return;
> > @@ -69,4 +191,6 @@ void __init efi_init(void)
> >         config_tables = early_memremap(efi_config_table, efi_nr_tables * size);
> >         efi_config_parse_tables(config_tables, efi_systab->nr_tables, arch_tables);
> >         early_memunmap(config_tables, efi_nr_tables * size);
> > +
> > +       init_screen_info();
> >  }
> > diff --git a/arch/loongarch/kernel/head.S b/arch/loongarch/kernel/head.S
> > index e596dfcd924b..ccc425027553 100644
> > --- a/arch/loongarch/kernel/head.S
> > +++ b/arch/loongarch/kernel/head.S
> > @@ -12,6 +12,32 @@
> >  #include <asm/loongarch.h>
> >  #include <asm/stackframe.h>
> >
> > +#ifdef CONFIG_EFI_STUB
> > +
> > +#include "efi-header.S"
> > +
> > +       __HEAD
> > +
> > +_head:
> > +       .word   MZ_MAGIC                /* "MZ", MS-DOS header */
> > +       .org    0x38
> > +#ifdef CONFIG_32BIT
> > +       .ascii  "LA32"                  /* Magic number for BootLoader */
> > +#else
> > +       .ascii  "LA64"                  /* Magic number for BootLoader */
> > +#endif
>
> As explained above, please remove these.
OK, thanks.

>
> > +       .org    0x3c
> > +       .long   pe_header - _head       /* Offset to the PE header */
> > +
> > +pe_header:
> > +       __EFI_PE_HEADER
> > +
> > +SYM_DATA(kernel_asize, .long _end - _text);
> > +SYM_DATA(kernel_fsize, .long _edata - _text);
> > +SYM_DATA(kernel_offset, .long kernel_offset - _text);
> > +
> > +#endif
> > +
> >         __REF
> >
> >  SYM_ENTRY(_stext, SYM_L_GLOBAL, SYM_A_NONE)
> > diff --git a/arch/loongarch/kernel/image-vars.h b/arch/loongarch/kernel/image-vars.h
> > new file mode 100644
> > index 000000000000..104e9f0e97fe
> > --- /dev/null
> > +++ b/arch/loongarch/kernel/image-vars.h
> > @@ -0,0 +1,29 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +/*
> > + * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
> > + */
> > +#ifndef __LOONGARCH_KERNEL_IMAGE_VARS_H
> > +#define __LOONGARCH_KERNEL_IMAGE_VARS_H
> > +
> > +#ifdef CONFIG_EFI_STUB
> > +
> > +__efistub_memcmp               = memcmp;
> > +__efistub_memchr               = memchr;
> > +__efistub_memcpy               = memcpy;
> > +__efistub_memmove              = memmove;
> > +__efistub_memset               = memset;
> > +__efistub_strcat               = strcat;
> > +__efistub_strcmp               = strcmp;
> > +__efistub_strlen               = strlen;
> > +__efistub_strncat              = strncat;
> > +__efistub_strnstr              = strnstr;
> > +__efistub_strnlen              = strnlen;
> > +__efistub_strrchr              = strrchr;
> > +__efistub_kernel_entry         = kernel_entry;
> > +__efistub_kernel_asize         = kernel_asize;
> > +__efistub_kernel_fsize         = kernel_fsize;
> > +__efistub_kernel_offset                = kernel_offset;
> > +
> > +#endif
> > +
> > +#endif /* __LOONGARCH_KERNEL_IMAGE_VARS_H */
> > diff --git a/arch/loongarch/kernel/vmlinux.lds.S b/arch/loongarch/kernel/vmlinux.lds.S
> > index 78311a6101a3..9dfa5b886c09 100644
> > --- a/arch/loongarch/kernel/vmlinux.lds.S
> > +++ b/arch/loongarch/kernel/vmlinux.lds.S
> > @@ -12,6 +12,7 @@
> >  #define BSS_FIRST_SECTIONS *(.bss..swapper_pg_dir)
> >
> >  #include <asm-generic/vmlinux.lds.h>
> > +#include "image-vars.h"
> >
> >  /*
> >   * Max avaliable Page Size is 64K, so we set SectionAlignment
> > diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
> > index 7aa4717cdcac..9e4645e5a5c0 100644
> > --- a/drivers/firmware/efi/Kconfig
> > +++ b/drivers/firmware/efi/Kconfig
> > @@ -118,7 +118,7 @@ config EFI_GENERIC_STUB
> >
> >  config EFI_ARMSTUB_DTB_LOADER
> >         bool "Enable the DTB loader"
> > -       depends on EFI_GENERIC_STUB && !RISCV
> > +       depends on EFI_GENERIC_STUB && !RISCV && !LOONGARCH
> >         default y
> >         help
> >           Select this config option to add support for the dtb= command
>
> Please make the initrd command line loader depend on !LOONGARCH.
> systemd-boot already supports this, and GRUB patches are on the list
> (the one you quoted above is part of the series that adds support for
> it). Your QEMU/edk2 firmware port also implements support for the
> LoadFile2 based method.
I agree to not select "initrd command line loader" by default, but can
we have a chance to select it even just for debugging? Because
sometimes we want to load the kernel and initrd via the command line
in the EFI shell.

>
> > diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
> > index d0537573501e..1588c61939e7 100644
> > --- a/drivers/firmware/efi/libstub/Makefile
> > +++ b/drivers/firmware/efi/libstub/Makefile
> > @@ -26,6 +26,8 @@ cflags-$(CONFIG_ARM)          := $(subst $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)) \
> >                                    $(call cc-option,-mno-single-pic-base)
> >  cflags-$(CONFIG_RISCV)         := $(subst $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)) \
> >                                    -fpic
> > +cflags-$(CONFIG_LOONGARCH)     := $(subst $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)) \
> > +                                  -fpic
> >
> >  cflags-$(CONFIG_EFI_GENERIC_STUB) += -I$(srctree)/scripts/dtc/libfdt
> >
> > @@ -70,6 +72,8 @@ lib-$(CONFIG_ARM)             += arm32-stub.o
> >  lib-$(CONFIG_ARM64)            += arm64-stub.o
> >  lib-$(CONFIG_X86)              += x86-stub.o
> >  lib-$(CONFIG_RISCV)            += riscv-stub.o
> > +lib-$(CONFIG_LOONGARCH)                += loongarch-stub.o
> > +
> >  CFLAGS_arm32-stub.o            := -DTEXT_OFFSET=$(TEXT_OFFSET)
> >
> >  # Even when -mbranch-protection=none is set, Clang will generate a
> > @@ -125,6 +129,12 @@ STUBCOPY_FLAGS-$(CONFIG_RISCV)     += --prefix-alloc-sections=.init \
> >                                    --prefix-symbols=__efistub_
> >  STUBCOPY_RELOC-$(CONFIG_RISCV) := R_RISCV_HI20
> >
> > +# For LoongArch, keep all the symbols in .init section and make sure that no
> > +# absolute symbols references doesn't exist.
> > +STUBCOPY_FLAGS-$(CONFIG_LOONGARCH)     += --prefix-alloc-sections=.init \
> > +                                          --prefix-symbols=__efistub_
> > +STUBCOPY_RELOC-$(CONFIG_LOONGARCH)     := R_LARCH_MARK_LA
> > +
> >  $(obj)/%.stub.o: $(obj)/%.o FORCE
> >         $(call if_changed,stubcopy)
> >
> > diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
> > index 3d972061c1b0..f612cfceda22 100644
> > --- a/drivers/firmware/efi/libstub/efi-stub-helper.c
> > +++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
> > @@ -21,7 +21,7 @@
> >  bool efi_nochunk;
> >  bool efi_nokaslr = !IS_ENABLED(CONFIG_RANDOMIZE_BASE);
> >  int efi_loglevel = CONSOLE_LOGLEVEL_DEFAULT;
> > -bool efi_novamap;
> > +bool efi_novamap = IS_ENABLED(CONFIG_LOONGARCH); /* LoongArch call svam() in kernel */
> >
> >  static bool efi_noinitrd;
> >  static bool efi_nosoftreserve;
> > diff --git a/drivers/firmware/efi/libstub/efi-stub.c b/drivers/firmware/efi/libstub/efi-stub.c
> > index f515394cce6e..730b7bd21776 100644
> > --- a/drivers/firmware/efi/libstub/efi-stub.c
> > +++ b/drivers/firmware/efi/libstub/efi-stub.c
> > @@ -40,9 +40,9 @@
> >
> >  #ifdef CONFIG_ARM64
> >  # define EFI_RT_VIRTUAL_LIMIT  DEFAULT_MAP_WINDOW_64
> > -#elif defined(CONFIG_RISCV)
> > +#elif defined(CONFIG_RISCV) || defined(CONFIG_LOONGARCH)
> >  # define EFI_RT_VIRTUAL_LIMIT  TASK_SIZE_MIN
> > -#else
> > +#else /* Only if TASK_SIZE is a constant */
> >  # define EFI_RT_VIRTUAL_LIMIT  TASK_SIZE
> >  #endif
> >
> > diff --git a/drivers/firmware/efi/libstub/loongarch-stub.c b/drivers/firmware/efi/libstub/loongarch-stub.c
> > new file mode 100644
> > index 000000000000..beee086d9950
> > --- /dev/null
> > +++ b/drivers/firmware/efi/libstub/loongarch-stub.c
> > @@ -0,0 +1,88 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Author: Yun Liu <liuyun@loongson.cn>
> > + *         Huacai Chen <chenhuacai@loongson.cn>
> > + * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
> > + */
> > +
> > +#include <linux/efi.h>
> > +#include <asm/efi.h>
> > +#include <asm/addrspace.h>
> > +#include "efistub.h"
> > +
> > +typedef void __noreturn (*kernel_entry_t)(bool efi, unsigned long fdt);
> > +
> > +extern int kernel_asize;
> > +extern int kernel_fsize;
> > +extern int kernel_offset;
> > +extern kernel_entry_t kernel_entry;
> > +
> > +static efi_guid_t screen_info_guid = LINUX_EFI_LARCH_SCREEN_INFO_TABLE_GUID;
> > +
> > +struct screen_info *alloc_screen_info(void)
> > +{
> > +       efi_status_t status;
> > +       struct screen_info *si;
> > +
> > +       status = efi_bs_call(allocate_pool,
> > +                       EFI_RUNTIME_SERVICES_DATA, sizeof(*si), (void **)&si);
> > +       if (status != EFI_SUCCESS)
> > +               return NULL;
> > +
> > +       status = efi_bs_call(install_configuration_table, &screen_info_guid, si);
> > +       if (status == EFI_SUCCESS)
> > +               return si;
> > +
> > +       efi_bs_call(free_pool, si);
> > +
> > +       return NULL;
> > +}
> > +
> > +void free_screen_info(struct screen_info *si)
> > +{
> > +       if (!si)
> > +               return;
> > +
> > +       efi_bs_call(install_configuration_table, &screen_info_guid, NULL);
> > +       efi_bs_call(free_pool, si);
> > +}
> > +
>
> As indicated above, I think you can adopt the arm64 approach here instead.
>
> > +efi_status_t check_platform_features(void)
> > +{
> > +       /* Config Direct Mapping */
> > +       csr_write64(CSR_DMW0_INIT, LOONGARCH_CSR_DMWIN0);
> > +       csr_write64(CSR_DMW1_INIT, LOONGARCH_CSR_DMWIN1);
> > +
> > +       return EFI_SUCCESS;
> > +}
> > +
>
> This code is not checking a platform feature so it does not belong here.
>
> The EFI stub code is an ordinary EFI app, and it runs in the execution
> context provided by EFI. So why is this needed so early? Can you move
> it into the kernel entry routine instead?
This is useful once we use our own zboot implementation, maybe we
don't need it with the new method you are proposing.

Huacai
>
> > +efi_status_t handle_kernel_image(unsigned long *image_addr,
> > +                                unsigned long *image_size,
> > +                                unsigned long *reserve_addr,
> > +                                unsigned long *reserve_size,
> > +                                efi_loaded_image_t *image,
> > +                                efi_handle_t image_handle)
> > +{
> > +       efi_status_t status;
> > +       unsigned long kernel_addr = 0;
> > +
> > +       kernel_addr = (unsigned long)&kernel_offset - kernel_offset;
> > +
> > +       status = efi_relocate_kernel(&kernel_addr, kernel_fsize, kernel_asize,
> > +                                    PHYSADDR(VMLINUX_LOAD_ADDRESS), SZ_2M, 0x0);
> > +
> > +       *image_addr = kernel_addr;
> > +       *image_size = kernel_asize;
> > +
> > +       return status;
> > +}
> > +
> > +void __noreturn efi_enter_kernel(unsigned long entrypoint, unsigned long fdt, unsigned long fdt_size)
> > +{
> > +       kernel_entry_t real_kernel_entry;
> > +
> > +       real_kernel_entry = (kernel_entry_t)
> > +               ((unsigned long)&kernel_entry - entrypoint + VMLINUX_LOAD_ADDRESS);
> > +
> > +       real_kernel_entry(true, fdt);
> > +}
> > diff --git a/include/linux/efi.h b/include/linux/efi.h
> > index 7d9b0bb47eb3..adc43641ef8c 100644
> > --- a/include/linux/efi.h
> > +++ b/include/linux/efi.h
> > @@ -401,6 +401,7 @@ void efi_native_runtime_setup(void);
> >   * associated with ConOut
> >   */
> >  #define LINUX_EFI_ARM_SCREEN_INFO_TABLE_GUID   EFI_GUID(0xe03fc20a, 0x85dc, 0x406e,  0xb9, 0x0e, 0x4a, 0xb5, 0x02, 0x37, 0x1d, 0x95)
> > +#define LINUX_EFI_LARCH_SCREEN_INFO_TABLE_GUID EFI_GUID(0x07fd51a6, 0x9532, 0x926f,  0x51, 0xdc, 0x6a, 0x63, 0x60, 0x2f, 0x84, 0xb4)
> >  #define LINUX_EFI_ARM_CPU_STATE_TABLE_GUID     EFI_GUID(0xef79e4aa, 0x3c3d, 0x4989,  0xb9, 0x02, 0x07, 0xa9, 0x43, 0xe5, 0x50, 0xd2)
> >  #define LINUX_EFI_LOADER_ENTRY_GUID            EFI_GUID(0x4a67b082, 0x0a4c, 0x41cf,  0xb6, 0xc7, 0x44, 0x0b, 0x29, 0xbb, 0x8c, 0x4f)
> >  #define LINUX_EFI_RANDOM_SEED_TABLE_GUID       EFI_GUID(0x1ce1e5bc, 0x7ceb, 0x42f2,  0x81, 0xe5, 0x8a, 0xad, 0xf1, 0x80, 0xf5, 0x7b)
> > diff --git a/include/linux/pe.h b/include/linux/pe.h
> > index daf09ffffe38..1d3836ef9d92 100644
> > --- a/include/linux/pe.h
> > +++ b/include/linux/pe.h
> > @@ -65,6 +65,8 @@
> >  #define        IMAGE_FILE_MACHINE_SH5          0x01a8
> >  #define        IMAGE_FILE_MACHINE_THUMB        0x01c2
> >  #define        IMAGE_FILE_MACHINE_WCEMIPSV2    0x0169
> > +#define        IMAGE_FILE_MACHINE_LOONGARCH32  0x6232
> > +#define        IMAGE_FILE_MACHINE_LOONGARCH64  0x6264
> >
> >  /* flags */
> >  #define IMAGE_FILE_RELOCS_STRIPPED           0x0001
> > --
> > 2.27.0
> >
