Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8608E603AC3
	for <lists+linux-efi@lfdr.de>; Wed, 19 Oct 2022 09:39:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbiJSHjh (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 19 Oct 2022 03:39:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbiJSHjd (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 19 Oct 2022 03:39:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05D8226E6;
        Wed, 19 Oct 2022 00:39:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C6D93B8224C;
        Wed, 19 Oct 2022 07:39:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EBA8C433C1;
        Wed, 19 Oct 2022 07:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666165165;
        bh=AyhN8w29cy3V0alJ6oIoEE0jWfJKgc8HGelNgJ+W6rI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jzwt3S8o6NZQLmQvG2KMfWIVh39ojxxd19u5+k9AeRQocY6cQV46sSvZ2KfApbSfC
         jFDgtu32JcD+MaGn+hBnnc8xgxNZ5d0Sxvm06tmOpQvlYMMfncJguy4i+NyuFFGHaI
         ii0HQXeXHfbt1XZToD++1IauxWQUNFtI1jdMkt+N5kja58KVbN57GvKia3hog0/Lwj
         +znCyLMxBHD3v1z44VTFgVQqzJJPePP929kaugr1PhNsY/nElG6HtuW/lUIeSqSHgj
         lrFphc/Fh1/R2yfdlW8aKEF/tDsW3EYADpuc/wrxz4oM102fnjHi8BmkHs7lGFzAPp
         yg+FI74bPphIw==
Received: by mail-lf1-f46.google.com with SMTP id be13so11058105lfb.4;
        Wed, 19 Oct 2022 00:39:25 -0700 (PDT)
X-Gm-Message-State: ACrzQf1x3Mps0OKG7kPWUsvGUMO0FyPls3eWoW43z1ODV9Nr52cTKiAd
        +7TU1FP2RV3vkkhlU03MUiI5S8/H52l3cLDrSA4=
X-Google-Smtp-Source: AMsMyM69JZdkYJlSJOKmLpgFm7d5DXHLyUZzQDylivNVc80ZF8H9Xb53d8TKc9rjDr2aY0Gt1BNqeq+JtYg4B9ZCAd0=
X-Received: by 2002:ac2:4c47:0:b0:4a2:c07b:4b62 with SMTP id
 o7-20020ac24c47000000b004a2c07b4b62mr2222970lfk.426.1666165162935; Wed, 19
 Oct 2022 00:39:22 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1662459668.git.baskov@ispras.ru> <f417e037d2967d9c1b387c63c66a7c050763a48c.1662459668.git.baskov@ispras.ru>
In-Reply-To: <f417e037d2967d9c1b387c63c66a7c050763a48c.1662459668.git.baskov@ispras.ru>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 19 Oct 2022 09:39:11 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHeirfD07He4TDZepZr2HSXqwvDcuFG=iT8sgRA3t5-SQ@mail.gmail.com>
Message-ID: <CAMj1kXHeirfD07He4TDZepZr2HSXqwvDcuFG=iT8sgRA3t5-SQ@mail.gmail.com>
Subject: Re: [PATCH 14/16] x86/build: Make generated PE more spec compliant
To:     Evgeniy Baskov <baskov@ispras.ru>
Cc:     Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        lvc-project@linuxtesting.org, x86@kernel.org,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 6 Sept 2022 at 12:42, Evgeniy Baskov <baskov@ispras.ru> wrote:
>
> Currently kernel image is not fully compliant PE image, so it may
> fail to boot with stricter implementations of UEFI PE loaders.
>
> Set minimal alignments and sizes specified by PE documentation [1]
> referenced by UEFI specification [2]. Align PE header to 8 bytes.


> Generate '.reloc' section with 2 entries and set reloc data directory.

Why?


>
> To make code more readable refactor tools/build.c:
>         - Use mmap() to access kernel image.
>         - Generate sections dynamically.
>         - Setup sections protection. Since we cannot fit every
>           needed section, set a part of protection flags
>           dynamically during initialization. This step is omitted
>           if CONFIG_EFI_DXE_MEM_ATTRIBUTES is not set.
>

If the commit log of a patch contains a bulleted list of the changes
that it implements, it is a very strong indicator that it needs to be
split up. Presenting this as a big ball of changes makes the life of a
reviewed unnecessarily hard.

> Reduce boot sector error message size since the space for the PE header
> before the zero page beginning is constrained.
>
> Explicitly change sections permissions in efi_pe_entry in case
> of incorrect EFI implementations and to reduce access rights to
> compressed kernel blob. By default it is set executable due to
> restriction in maximum number of sections that can fit before zero
> page.
>
> [1] https://download.microsoft.com/download/9/c/5/9c5b2167-8017-4bae-9fde-d599bac8184a/pecoff_v83.docx
> [2] https://uefi.org/sites/default/files/resources/UEFI_Spec_2_9_2021_03_18.pdf
>
> Signed-off-by: Evgeniy Baskov <baskov@ispras.ru>
> ---
>  arch/x86/boot/Makefile                  |   2 +-
>  arch/x86/boot/header.S                  | 110 +----
>  arch/x86/boot/tools/build.c             | 575 +++++++++++++++---------
>  drivers/firmware/efi/libstub/x86-stub.c |  63 ++-
>  4 files changed, 452 insertions(+), 298 deletions(-)
>
> diff --git a/arch/x86/boot/Makefile b/arch/x86/boot/Makefile
> index ffec8bb01ba8..828eb41c2603 100644
> --- a/arch/x86/boot/Makefile
> +++ b/arch/x86/boot/Makefile
> @@ -90,7 +90,7 @@ $(obj)/vmlinux.bin: $(obj)/compressed/vmlinux FORCE
>
>  SETUP_OBJS = $(addprefix $(obj)/,$(setup-y))
>
> -sed-zoffset := -e 's/^\([0-9a-fA-F]*\) [a-zA-Z] \(startup_32\|startup_64\|efi32_stub_entry\|efi64_stub_entry\|efi_pe_entry\|efi32_pe_entry\|input_data\|kernel_info\|_end\|_ehead\|_text\|z_.*\)$$/\#define ZO_\2 0x\1/p'
> +sed-zoffset := -e 's/^\([0-9a-fA-F]*\) [a-zA-Z] \(startup_32\|startup_64\|efi32_stub_entry\|efi64_stub_entry\|efi_pe_entry\|efi32_pe_entry\|input_data\|kernel_info\|_end\|_ehead\|_text\|_rodata\|z_.*\)$$/\#define ZO_\2 0x\1/p'
>
>  quiet_cmd_zoffset = ZOFFSET $@
>        cmd_zoffset = $(NM) $< | sed -n $(sed-zoffset) > $@
> diff --git a/arch/x86/boot/header.S b/arch/x86/boot/header.S
> index f912d7770130..05a75f0a1876 100644
> --- a/arch/x86/boot/header.S
> +++ b/arch/x86/boot/header.S
> @@ -59,17 +59,16 @@ start2:
>         cld
>
>         movw    $bugger_off_msg, %si
> +       movw    $bugger_off_msg_size, %cx
>
>  msg_loop:
>         lodsb
> -       andb    %al, %al
> -       jz      bs_die
>         movb    $0xe, %ah
>         movw    $7, %bx
>         int     $0x10
> -       jmp     msg_loop
> +       decw    %cx
> +       jnz     msg_loop
>
> -bs_die:
>         # Allow the user to press a key, then reboot
>         xorw    %ax, %ax
>         int     $0x16
> @@ -89,12 +88,12 @@ bs_die:
>
>         .section ".bsdata", "a"
>  bugger_off_msg:
> -       .ascii  "Use a boot loader.\r\n"
> -       .ascii  "\n"
> -       .ascii  "Remove disk and press any key to reboot...\r\n"
> -       .byte   0
> +       .ascii  "Use a boot loader. "
> +       .ascii  "Press a key to reboot"
> +       .set bugger_off_msg_size, . - bugger_off_msg
>
>  #ifdef CONFIG_EFI_STUB
> +       .align 8
>  pe_header:
>         .long   PE_MAGIC
>
> @@ -108,7 +107,7 @@ coff_header:
>         .set    pe_opt_magic, PE_OPT_MAGIC_PE32PLUS
>         .word   IMAGE_FILE_MACHINE_AMD64
>  #endif
> -       .word   section_count                   # nr_sections
> +       .word   0                               # nr_sections
>         .long   0                               # TimeDateStamp
>         .long   0                               # PointerToSymbolTable
>         .long   1                               # NumberOfSymbols
> @@ -132,7 +131,7 @@ optional_header:
>         # Filled in by build.c
>         .long   0x0000                          # AddressOfEntryPoint
>
> -       .long   0x0200                          # BaseOfCode
> +       .long   0x1000                          # BaseOfCode
>  #ifdef CONFIG_X86_32
>         .long   0                               # data
>  #endif
> @@ -145,8 +144,8 @@ extra_header_fields:
>  #else
>         .quad   image_base                      # ImageBase
>  #endif
> -       .long   0x20                            # SectionAlignment
> -       .long   0x20                            # FileAlignment
> +       .long   0x1000                          # SectionAlignment
> +       .long   0x200                           # FileAlignment
>         .word   0                               # MajorOperatingSystemVersion
>         .word   0                               # MinorOperatingSystemVersion
>         .word   LINUX_EFISTUB_MAJOR_VERSION     # MajorImageVersion
> @@ -189,91 +188,14 @@ extra_header_fields:
>         .quad   0                               # CertificationTable
>         .quad   0                               # BaseRelocationTable
>
> -       # Section table
> -section_table:
> -       #
> -       # The offset & size fields are filled in by build.c.
> -       #
> -       .ascii  ".setup"
> -       .byte   0
> -       .byte   0
> -       .long   0
> -       .long   0x0                             # startup_{32,64}
> -       .long   0                               # Size of initialized data
> -                                               # on disk
> -       .long   0x0                             # startup_{32,64}
> -       .long   0                               # PointerToRelocations
> -       .long   0                               # PointerToLineNumbers
> -       .word   0                               # NumberOfRelocations
> -       .word   0                               # NumberOfLineNumbers
> -       .long   IMAGE_SCN_CNT_CODE              | \
> -               IMAGE_SCN_MEM_READ              | \
> -               IMAGE_SCN_MEM_EXECUTE           | \
> -               IMAGE_SCN_ALIGN_16BYTES         # Characteristics
> -
> -       #
> -       # The EFI application loader requires a relocation section
> -       # because EFI applications must be relocatable. The .reloc
> -       # offset & size fields are filled in by build.c.
>         #
> -       .ascii  ".reloc"
> -       .byte   0
> -       .byte   0
> -       .long   0
> -       .long   0
> -       .long   0                               # SizeOfRawData
> -       .long   0                               # PointerToRawData
> -       .long   0                               # PointerToRelocations
> -       .long   0                               # PointerToLineNumbers
> -       .word   0                               # NumberOfRelocations
> -       .word   0                               # NumberOfLineNumbers
> -       .long   IMAGE_SCN_CNT_INITIALIZED_DATA  | \
> -               IMAGE_SCN_MEM_READ              | \
> -               IMAGE_SCN_MEM_DISCARDABLE       | \
> -               IMAGE_SCN_ALIGN_1BYTES          # Characteristics
> -
> -#ifdef CONFIG_EFI_MIXED
> -       #
> -       # The offset & size fields are filled in by build.c.
> +       # Section table
> +       # It is generated by build.c and here we just need
> +       # to reserve some space for sections
>         #
> -       .asciz  ".compat"
> -       .long   0
> -       .long   0x0
> -       .long   0                               # Size of initialized data
> -                                               # on disk
> -       .long   0x0
> -       .long   0                               # PointerToRelocations
> -       .long   0                               # PointerToLineNumbers
> -       .word   0                               # NumberOfRelocations
> -       .word   0                               # NumberOfLineNumbers
> -       .long   IMAGE_SCN_CNT_INITIALIZED_DATA  | \
> -               IMAGE_SCN_MEM_READ              | \
> -               IMAGE_SCN_MEM_DISCARDABLE       | \
> -               IMAGE_SCN_ALIGN_1BYTES          # Characteristics
> -#endif
> +section_table:
> +       .fill 40*5, 1, 0
>
> -       #
> -       # The offset & size fields are filled in by build.c.
> -       #
> -       .ascii  ".text"
> -       .byte   0
> -       .byte   0
> -       .byte   0
> -       .long   0
> -       .long   0x0                             # startup_{32,64}
> -       .long   0                               # Size of initialized data
> -                                               # on disk
> -       .long   0x0                             # startup_{32,64}
> -       .long   0                               # PointerToRelocations
> -       .long   0                               # PointerToLineNumbers
> -       .word   0                               # NumberOfRelocations
> -       .word   0                               # NumberOfLineNumbers
> -       .long   IMAGE_SCN_CNT_CODE              | \
> -               IMAGE_SCN_MEM_READ              | \
> -               IMAGE_SCN_MEM_EXECUTE           | \
> -               IMAGE_SCN_ALIGN_16BYTES         # Characteristics
> -
> -       .set    section_count, (. - section_table) / 40
>  #endif /* CONFIG_EFI_STUB */
>
>         # Kernel attributes; used by setup.  This is part 1 of the
> diff --git a/arch/x86/boot/tools/build.c b/arch/x86/boot/tools/build.c
> index a3725ad46c5a..dc3a1efb290e 100644
> --- a/arch/x86/boot/tools/build.c
> +++ b/arch/x86/boot/tools/build.c
> @@ -40,6 +40,8 @@ typedef unsigned char  u8;
>  typedef unsigned short u16;
>  typedef unsigned int   u32;
>
> +#define round_up(x, n) (((x) + (n) - 1) & ~((n) - 1))
> +
>  #define DEFAULT_MAJOR_ROOT 0
>  #define DEFAULT_MINOR_ROOT 0
>  #define DEFAULT_ROOT_DEV (DEFAULT_MAJOR_ROOT << 8 | DEFAULT_MINOR_ROOT)
> @@ -59,12 +61,74 @@ u8 buf[SETUP_SECT_MAX*512];
>  #define PECOFF_COMPAT_RESERVE 0x0
>  #endif
>
> +#define PARAGRAPH_SIZE 16
> +#define SECTOR_SIZE 512
> +#define FILE_ALIGNMENT 512
> +#define SECTION_ALIGNMENT 4096
> +
> +#define RELOC_SECTION_SIZE 12
> +
> +#ifdef CONFIG_EFI_MIXED
> +#define COMPAT_SECTION_SIZE 8
> +#else
> +#define COMPAT_SECTION_SIZE 0
> +#endif
> +
> +#define DOS_PECOFF_HEADER_OFFSET 0x3c
> +
> +#define PECOFF_CODE_SIZE_OFFSET 0x1c
> +#define PECOFF_DATA_SIZE_OFFSET 0x20
> +#define PECOFF_IMAGE_SIZE_OFFSET 0x50
> +#define PECOFF_ENTRY_POINT_OFFSET 0x28
> +#define PECOFF_SECTIONS_COUNT_OFFSET 0x6
> +#define PECOFF_BASE_OF_CODE_OFFSET 0x2c
> +
> +#ifdef CONFIG_X86_32
> +#define PECOFF_SECTION_TABLE_OFFSET 0xa8
> +#define PECOFF_RELOC_DIR_OFFSET 0xa0
> +#else
> +#define PECOFF_SECTION_TABLE_OFFSET 0xb8
> +#define PECOFF_RELOC_DIR_OFFSET 0xb0
> +#endif
> +
> +#define PECOFF_SECTION_SIZE 0x28
> +
> +#define PECOFF_SCN_NAME_OFFSET 0x0
> +#define PECOFF_SCN_NAME_SIZE 8
> +#define PECOFF_SCN_MEMSZ_OFFSET 0x8
> +#define PECOFF_SCN_VADDR_OFFSET 0xc
> +#define PECOFF_SCN_FILESZ_OFFSET 0x10
> +#define PECOFF_SCN_OFFSET_OFFSET 0x14
> +#define PECOFF_SCN_FLAGS_OFFSET 0x24
> +
> +#define IMAGE_SCN_CNT_CODE     0x00000020 /* .text */
> +#define IMAGE_SCN_CNT_INITIALIZED_DATA 0x00000040 /* .data */
> +#define IMAGE_SCN_ALIGN_512BYTES 0x00a00000
> +#define IMAGE_SCN_ALIGN_4096BYTES 0x00d00000
> +#define IMAGE_SCN_MEM_DISCARDABLE 0x02000000 /* scn can be discarded */
> +#define IMAGE_SCN_MEM_EXECUTE  0x20000000 /* can be executed as code */
> +#define IMAGE_SCN_MEM_READ     0x40000000 /* readable */
> +#define IMAGE_SCN_MEM_WRITE    0x80000000 /* writeable */
> +

All of those defines need to go into a header file, probably include/linux/pe.h

> +#ifdef CONFIG_EFI_DXE_MEM_ATTRIBUTES
> +#define SCN_RW (IMAGE_SCN_MEM_READ | IMAGE_SCN_MEM_WRITE | IMAGE_SCN_ALIGN_4096BYTES)
> +#define SCN_RX (IMAGE_SCN_MEM_READ | IMAGE_SCN_MEM_EXECUTE | IMAGE_SCN_ALIGN_4096BYTES)
> +#define SCN_RO (IMAGE_SCN_MEM_READ | IMAGE_SCN_ALIGN_4096BYTES)
> +#else
> +/* With memory protection disabled all sections are RWX */
> +#define SCN_RW (IMAGE_SCN_MEM_READ | IMAGE_SCN_MEM_WRITE | \
> +               IMAGE_SCN_MEM_EXECUTE | IMAGE_SCN_ALIGN_4096BYTES)
> +#define SCN_RX SCN_RW
> +#define SCN_RO SCN_RW
> +#endif
> +
>  static unsigned long efi32_stub_entry;
>  static unsigned long efi64_stub_entry;
>  static unsigned long efi_pe_entry;
>  static unsigned long efi32_pe_entry;
>  static unsigned long kernel_info;
>  static unsigned long startup_64;
> +static unsigned long _rodata;
>  static unsigned long _ehead;
>  static unsigned long _end;
>
> @@ -152,91 +216,126 @@ static void usage(void)
>         die("Usage: build setup system zoffset.h image");
>  }
>
> -#ifdef CONFIG_EFI_STUB
> -
> -static void update_pecoff_section_header_fields(char *section_name, u32 vma, u32 size, u32 datasz, u32 offset)
> +static void *map_file(const char *path, size_t *psize)
>  {
> -       unsigned int pe_header;
> -       unsigned short num_sections;
> -       u8 *section;
> -
> -       pe_header = get_unaligned_le32(&buf[0x3c]);
> -       num_sections = get_unaligned_le16(&buf[pe_header + 6]);
> -
> -#ifdef CONFIG_X86_32
> -       section = &buf[pe_header + 0xa8];
> -#else
> -       section = &buf[pe_header + 0xb8];
> -#endif
> -
> -       while (num_sections > 0) {
> -               if (strncmp((char*)section, section_name, 8) == 0) {
> -                       /* section header size field */
> -                       put_unaligned_le32(size, section + 0x8);
> +       struct stat statbuf;
> +       size_t size;
> +       void *addr;
> +       int fd;
>
> -                       /* section header vma field */
> -                       put_unaligned_le32(vma, section + 0xc);
> +       fd = open(path, O_RDONLY);
> +       if (fd < 0)
> +               die("Unable to open `%s': %m", path);
> +       if (fstat(fd, &statbuf))
> +               die("Unable to stat `%s': %m", path);
>
> -                       /* section header 'size of initialised data' field */
> -                       put_unaligned_le32(datasz, section + 0x10);
> +       size = statbuf.st_size;
> +       /*
> +        * Map one byte more, to allow adding null-terminator
> +        * for text files.
> +        */
> +       addr = mmap(NULL, size + 1, PROT_READ | PROT_WRITE, MAP_PRIVATE, fd, 0);
> +       if (addr == MAP_FAILED)
> +               die("Unable to mmap '%s': %m", path);
>
> -                       /* section header 'file offset' field */
> -                       put_unaligned_le32(offset, section + 0x14);
> +       close(fd);
>
> -                       break;
> -               }
> -               section += 0x28;
> -               num_sections--;
> -       }
> +       *psize = size;
> +       return addr;
>  }
>
> -static void update_pecoff_section_header(char *section_name, u32 offset, u32 size)
> +static void unmap_file(void *addr, size_t size)
>  {
> -       update_pecoff_section_header_fields(section_name, offset, size, size, offset);
> +       munmap(addr, size + 1);
>  }
>
> -static void update_pecoff_setup_and_reloc(unsigned int size)
> +static void *map_output_file(const char *path, size_t size)
>  {
> -       u32 setup_offset = 0x200;
> -       u32 reloc_offset = size - PECOFF_RELOC_RESERVE - PECOFF_COMPAT_RESERVE;
> -#ifdef CONFIG_EFI_MIXED
> -       u32 compat_offset = reloc_offset + PECOFF_RELOC_RESERVE;
> -#endif
> -       u32 setup_size = reloc_offset - setup_offset;
> +       void *addr;
> +       int fd;
>
> -       update_pecoff_section_header(".setup", setup_offset, setup_size);
> -       update_pecoff_section_header(".reloc", reloc_offset, PECOFF_RELOC_RESERVE);
> +       fd = open(path, O_RDWR | O_CREAT, 0660);
> +       if (fd < 0)
> +               die("Unable to create `%s': %m", path);
>
> -       /*
> -        * Modify .reloc section contents with a single entry. The
> -        * relocation is applied to offset 10 of the relocation section.
> -        */
> -       put_unaligned_le32(reloc_offset + 10, &buf[reloc_offset]);
> -       put_unaligned_le32(10, &buf[reloc_offset + 4]);
> +       if (ftruncate(fd, size))
> +               die("Unable to resize `%s': %m", path);
>
> -#ifdef CONFIG_EFI_MIXED
> -       update_pecoff_section_header(".compat", compat_offset, PECOFF_COMPAT_RESERVE);
> +       addr = mmap(NULL, size, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
> +       if (addr == MAP_FAILED)
> +               die("Unable to mmap '%s': %m", path);
>
> -       /*
> -        * Put the IA-32 machine type (0x14c) and the associated entry point
> -        * address in the .compat section, so loaders can figure out which other
> -        * execution modes this image supports.
> -        */
> -       buf[compat_offset] = 0x1;
> -       buf[compat_offset + 1] = 0x8;
> -       put_unaligned_le16(0x14c, &buf[compat_offset + 2]);
> -       put_unaligned_le32(efi32_pe_entry + size, &buf[compat_offset + 4]);
> -#endif
> +       return addr;
>  }
>
> -static void update_pecoff_text(unsigned int text_start, unsigned int file_sz,
> -                              unsigned int init_sz)
> +#ifdef CONFIG_EFI_STUB
> +
> +static unsigned int reloc_offset;
> +static unsigned int compat_offset;
> +
> +#define MAX_SECTIONS 5
> +
> +static void emit_pecoff_section(const char *section_name, unsigned int size,
> +                               unsigned int bss, unsigned int *file_offset,
> +                               unsigned int *mem_offset, u32 flags)
>  {
> +       unsigned int section_memsz, section_filesz;
>         unsigned int pe_header;
> -       unsigned int text_sz = file_sz - text_start;
> -       unsigned int bss_sz = init_sz - file_sz;
> +       unsigned short num_sections;
> +       u8 *pnum_sections;
> +       u8 *section;
> +
> +       pe_header = get_unaligned_le32(&buf[DOS_PECOFF_HEADER_OFFSET]);
> +       pnum_sections = &buf[pe_header + PECOFF_SECTIONS_COUNT_OFFSET];
> +       num_sections = get_unaligned_le16(pnum_sections);
> +       if (num_sections >= MAX_SECTIONS)
> +               die("Not enough space to generate all sections");
> +
> +       section = &buf[pe_header + PECOFF_SECTION_TABLE_OFFSET];
> +       section += PECOFF_SECTION_SIZE * num_sections;
> +
> +       if ((size & (FILE_ALIGNMENT - 1)) || (bss & (FILE_ALIGNMENT - 1)))
> +               die("Section '%s' is improperly aligned", section_name);
> +
> +       section_memsz = round_up(size + bss, SECTION_ALIGNMENT);
> +       section_filesz = round_up(size, FILE_ALIGNMENT);
> +
> +       /* Zero out all section fields */
> +       memset(section, 0, PECOFF_SECTION_SIZE);
> +
> +       /* Section header size field */
> +       strncpy((char *)(section + PECOFF_SCN_NAME_OFFSET),
> +               section_name, PECOFF_SCN_NAME_SIZE);
>
> -       pe_header = get_unaligned_le32(&buf[0x3c]);
> +       put_unaligned_le32(section_memsz, section + PECOFF_SCN_MEMSZ_OFFSET);
> +       put_unaligned_le32(*mem_offset, section + PECOFF_SCN_VADDR_OFFSET);
> +       put_unaligned_le32(section_filesz, section + PECOFF_SCN_FILESZ_OFFSET);
> +       put_unaligned_le32(*file_offset, section + PECOFF_SCN_OFFSET_OFFSET);
> +       put_unaligned_le32(flags, section + PECOFF_SCN_FLAGS_OFFSET);
> +
> +       put_unaligned_le16(num_sections + 1, pnum_sections);
> +
> +       *mem_offset += section_memsz;
> +       *file_offset += section_filesz;
> +
> +}
> +
> +#define BASE_RVA 0x1000
> +
> +static unsigned int update_pecoff_sections(unsigned int setup_size,
> +                                          unsigned int file_size,
> +                                          unsigned int init_size,
> +                                          unsigned int text_size)
> +{
> +       /* First section starts at 512 byes, after PE header */
> +       unsigned int mem_offset = BASE_RVA, file_offset = SECTOR_SIZE;
> +       unsigned int compat_size, reloc_size, image_size, text_rva;
> +       unsigned int pe_header, bss_size, text_rva_diff, reloc_rva;
> +
> +       pe_header = get_unaligned_le32(&buf[DOS_PECOFF_HEADER_OFFSET]);
> +
> +       if (get_unaligned_le32(&buf[pe_header + PECOFF_SECTIONS_COUNT_OFFSET]))
> +               die("Some sections present in PE file");
>
>         /*
>          * The PE/COFF loader may load the image at an address which is
> @@ -247,42 +346,121 @@ static void update_pecoff_text(unsigned int text_start, unsigned int file_sz,
>          * add slack to allow the buffer to be aligned within the declared size
>          * of the image.
>          */
> -       bss_sz  += CONFIG_PHYSICAL_ALIGN;
> -       init_sz += CONFIG_PHYSICAL_ALIGN;
> +       init_size += CONFIG_PHYSICAL_ALIGN;
> +       image_size = init_size;
> +
> +       reloc_size = round_up(RELOC_SECTION_SIZE, FILE_ALIGNMENT);
> +       compat_size = round_up(COMPAT_SECTION_SIZE, FILE_ALIGNMENT);
> +
> +       /*
> +        * Let's remove extra memory used by special sections
> +        * and use it as a part of bss.
> +        */
> +       init_size -= round_up(reloc_size, SECTION_ALIGNMENT);
> +       init_size -= round_up(compat_size, SECTION_ALIGNMENT);
> +       if (init_size < file_size + setup_size) {
> +               init_size = file_size + setup_size;
> +               image_size += round_up(reloc_size, SECTION_ALIGNMENT);
> +               image_size += round_up(compat_size, SECTION_ALIGNMENT);
> +       }
>
>         /*
> -        * Size of code: Subtract the size of the first sector (512 bytes)
> -        * which includes the header.
> +        * Update sections offsets.
> +        * NOTE: Order is important
>          */
> -       put_unaligned_le32(file_sz - 512 + bss_sz, &buf[pe_header + 0x1c]);
>
> -       /* Size of image */
> -       put_unaligned_le32(init_sz, &buf[pe_header + 0x50]);
> +       bss_size = init_size - file_size - setup_size;
> +
> +       emit_pecoff_section(".setup", setup_size - SECTOR_SIZE, 0,
> +                           &file_offset, &mem_offset, SCN_RO |
> +                           IMAGE_SCN_CNT_INITIALIZED_DATA);
> +
> +       text_rva_diff = mem_offset - file_offset;
> +       text_rva = mem_offset;
> +       emit_pecoff_section(".text", text_size, 0,
> +                           &file_offset, &mem_offset, SCN_RX |
> +                           IMAGE_SCN_CNT_CODE);
> +
> +       /* Check that kernel sections mapping is contiguous */
> +       if (text_rva_diff != mem_offset - file_offset)
> +               die("Kernel sections mapping is wrong: %#x != %#x",
> +                   mem_offset - file_offset, text_rva_diff);
> +
> +       emit_pecoff_section(".data", file_size - text_size, bss_size,
> +                           &file_offset, &mem_offset, SCN_RW |
> +                           IMAGE_SCN_CNT_INITIALIZED_DATA);
> +
> +       reloc_offset = file_offset;
> +       reloc_rva = mem_offset;
> +       emit_pecoff_section(".reloc", reloc_size, 0,
> +                           &file_offset, &mem_offset, SCN_RW |
> +                           IMAGE_SCN_CNT_INITIALIZED_DATA |
> +                           IMAGE_SCN_MEM_DISCARDABLE);
> +
> +       compat_offset = file_offset;
> +#ifdef CONFIG_EFI_MIXED
> +       emit_pecoff_section(".comat", compat_size, 0,
> +                           &file_offset, &mem_offset, SCN_RW |
> +                           IMAGE_SCN_CNT_INITIALIZED_DATA |
> +                           IMAGE_SCN_MEM_DISCARDABLE);
> +#endif
> +
> +       if (file_size + setup_size + reloc_size + compat_size != file_offset)
> +               die("file_size(%#x) != filesz(%#x)",
> +                   file_size + setup_size + reloc_size + compat_size, file_offset);
> +
> +       /* Size of code. */
> +       put_unaligned_le32(round_up(text_size, SECTION_ALIGNMENT),
> +                          &buf[pe_header + PECOFF_CODE_SIZE_OFFSET]);
> +       /*
> +        * Size of data.
> +        * Exclude text size and first sector, which contains PE header.
> +        */
> +       put_unaligned_le32(mem_offset - round_up(text_size, SECTION_ALIGNMENT),
> +                          &buf[pe_header + PECOFF_DATA_SIZE_OFFSET]);
> +
> +       /* Size of image. */
> +       put_unaligned_le32(mem_offset, &buf[pe_header + PECOFF_IMAGE_SIZE_OFFSET]);
>
>         /*
>          * Address of entry point for PE/COFF executable
>          */
> -       put_unaligned_le32(text_start + efi_pe_entry, &buf[pe_header + 0x28]);
> +       put_unaligned_le32(text_rva + efi_pe_entry, &buf[pe_header + PECOFF_ENTRY_POINT_OFFSET]);
>
> -       update_pecoff_section_header_fields(".text", text_start, text_sz + bss_sz,
> -                                           text_sz, text_start);
> -}
> +       /*
> +        * BaseOfCode for PE/COFF executable
> +        */
> +       put_unaligned_le32(text_rva, &buf[pe_header + PECOFF_BASE_OF_CODE_OFFSET]);
>
> -static int reserve_pecoff_reloc_section(int c)
> -{
> -       /* Reserve 0x20 bytes for .reloc section */
> -       memset(buf+c, 0, PECOFF_RELOC_RESERVE);
> -       return PECOFF_RELOC_RESERVE;
> +       /*
> +        * Since we have generated .reloc section, we need to
> +        * fill-in Reloc directory
> +        */
> +       put_unaligned_le32(reloc_rva, &buf[pe_header + PECOFF_RELOC_DIR_OFFSET]);
> +       put_unaligned_le32(RELOC_SECTION_SIZE, &buf[pe_header + PECOFF_RELOC_DIR_OFFSET + 4]);
> +
> +       return file_offset;
>  }
>
> -static void efi_stub_defaults(void)
> +static void generate_pecoff_section_data(u8 *output, unsigned int setup_size)
>  {
> -       /* Defaults for old kernel */
> -#ifdef CONFIG_X86_32
> -       efi_pe_entry = 0x10;
> -#else
> -       efi_pe_entry = 0x210;
> -       startup_64 = 0x200;
> +       /*
> +        * Modify .reloc section contents with a two entries. The
> +        * relocation is applied to offset 10 of the relocation section.
> +        */
> +       put_unaligned_le32(reloc_offset + RELOC_SECTION_SIZE, &output[reloc_offset]);
> +       put_unaligned_le32(RELOC_SECTION_SIZE, &output[reloc_offset + 4]);
> +
> +#ifdef CONFIG_EFI_MIXED
> +       /*
> +        * Put the IA-32 machine type (0x14c) and the associated entry point
> +        * address in the .compat section, so loaders can figure out which other
> +        * execution modes this image supports.
> +        */
> +       output[compat_offset] = 0x1;
> +       output[compat_offset + 1] = 0x8;
> +       put_unaligned_le16(0x14c, &output[compat_offset + 2]);
> +       put_unaligned_le32(efi32_pe_entry + setup_size, &output[compat_offset + 4]);
>  #endif
>  }
>
> @@ -297,33 +475,27 @@ static void efi_stub_entry_update(void)
>
>  #ifdef CONFIG_EFI_MIXED
>         if (efi32_stub_entry != addr)
> -               die("32-bit and 64-bit EFI entry points do not match\n");
> +               die("32-bit and 64-bit EFI entry points do not match");
>  #endif
>         put_unaligned_le32(addr, &buf[0x264]);
>  }
>
> +static void efi_stub_update_defaults(void)
> +{
> +       /* Defaults for old kernel */
> +#ifdef CONFIG_X86_32
> +       efi_pe_entry = 0x10;
> +#else
> +       efi_pe_entry = 0x210;
> +       startup_64 = 0x200;
> +#endif
> +}
>  #else
>
> -static inline void update_pecoff_setup_and_reloc(unsigned int size) {}
> -static inline void update_pecoff_text(unsigned int text_start,
> -                                     unsigned int file_sz,
> -                                     unsigned int init_sz) {}
> -static inline void efi_stub_defaults(void) {}
> -static inline void efi_stub_entry_update(void) {}
> +static void efi_stub_update_defaults(void) {}
>
> -static inline int reserve_pecoff_reloc_section(int c)
> -{
> -       return 0;
> -}
>  #endif /* CONFIG_EFI_STUB */
>
> -static int reserve_pecoff_compat_section(int c)
> -{
> -       /* Reserve 0x20 bytes for .compat section */
> -       memset(buf+c, 0, PECOFF_COMPAT_RESERVE);
> -       return PECOFF_COMPAT_RESERVE;
> -}
> -
>  /*
>   * Parse zoffset.h and find the entry points. We could just #include zoffset.h
>   * but that would mean tools/build would have to be rebuilt every time. It's
> @@ -336,20 +508,15 @@ static int reserve_pecoff_compat_section(int c)
>
>  static void parse_zoffset(char *fname)
>  {
> -       FILE *file;
> -       char *p;
> -       int c;
> +       size_t size;
> +       char *data, *p;
>
> -       file = fopen(fname, "r");
> -       if (!file)
> -               die("Unable to open `%s': %m", fname);
> -       c = fread(buf, 1, sizeof(buf) - 1, file);
> -       if (ferror(file))
> -               die("read-error on `zoffset.h'");
> -       fclose(file);
> -       buf[c] = 0;
> +       data = map_file(fname, &size);
> +
> +       /* We can do that, since we mapped one byte more */
> +       data[size] = 0;
>
> -       p = (char *)buf;
> +       p = (char *)data;
>
>         while (p && *p) {
>                 PARSE_ZOFS(p, efi32_stub_entry);
> @@ -358,6 +525,7 @@ static void parse_zoffset(char *fname)
>                 PARSE_ZOFS(p, efi32_pe_entry);
>                 PARSE_ZOFS(p, kernel_info);
>                 PARSE_ZOFS(p, startup_64);
> +               PARSE_ZOFS(p, _rodata);
>                 PARSE_ZOFS(p, _ehead);
>                 PARSE_ZOFS(p, _end);
>
> @@ -365,82 +533,93 @@ static void parse_zoffset(char *fname)
>                 while (p && (*p == '\r' || *p == '\n'))
>                         p++;
>         }
> +
> +       unmap_file(data, size);
>  }
>
> -int main(int argc, char ** argv)
> +static unsigned int read_setup(char *path)
>  {
> -       unsigned int i, sz, setup_sectors, init_sz;
> -       int c;
> -       u32 sys_size;
> -       struct stat sb;
> -       FILE *file, *dest;
> -       int fd;
> -       void *kernel;
> -       u32 crc = 0xffffffffUL;
> -
> -       efi_stub_defaults();
> -
> -       if (argc != 5)
> -               usage();
> -       parse_zoffset(argv[3]);
> -
> -       dest = fopen(argv[4], "w");
> -       if (!dest)
> -               die("Unable to write `%s': %m", argv[4]);
> +       FILE *file;
> +       unsigned int setup_size, file_size;
>
>         /* Copy the setup code */
> -       file = fopen(argv[1], "r");
> +       file = fopen(path, "r");
>         if (!file)
> -               die("Unable to open `%s': %m", argv[1]);
> -       c = fread(buf, 1, sizeof(buf), file);
> +               die("Unable to open `%s': %m", path);
> +
> +       file_size = fread(buf, 1, sizeof(buf), file);
>         if (ferror(file))
>                 die("read-error on `setup'");
> -       if (c < 1024)
> +
> +       if (file_size < 2 * SECTOR_SIZE)
>                 die("The setup must be at least 1024 bytes");
> -       if (get_unaligned_le16(&buf[510]) != 0xAA55)
> +
> +       if (get_unaligned_le16(&buf[SECTOR_SIZE - 2]) != 0xAA55)
>                 die("Boot block hasn't got boot flag (0xAA55)");
> -       fclose(file);
>
> -       c += reserve_pecoff_compat_section(c);
> -       c += reserve_pecoff_reloc_section(c);
> +       fclose(file);
>
>         /* Pad unused space with zeros */
> -       setup_sectors = (c + 511) / 512;
> -       if (setup_sectors < SETUP_SECT_MIN)
> -               setup_sectors = SETUP_SECT_MIN;
> -       i = setup_sectors*512;
> -       memset(buf+c, 0, i-c);
> +       setup_size = round_up(file_size, SECTOR_SIZE);
> +
> +       if (setup_size < SETUP_SECT_MIN * SECTOR_SIZE)
> +               setup_size = SETUP_SECT_MIN * SECTOR_SIZE;
>
> -       update_pecoff_setup_and_reloc(i);
> +       /*
> +        * Global buffer is already initialised
> +        * to 0, but just in case, zero out padding.
> +        */
> +
> +       memset(buf + file_size, 0, setup_size - file_size);
> +
> +       return setup_size;
> +}
> +
> +int main(int argc, char **argv)
> +{
> +       size_t kern_file_size;
> +       unsigned int setup_size;
> +       unsigned int setup_sectors;
> +       unsigned int init_size;
> +       unsigned int total_size;
> +       unsigned int kern_size;
> +       void *kernel;
> +       u32 crc = 0xffffffffUL;
> +       u8 *output;
> +
> +       if (argc != 5)
> +               usage();
> +
> +       efi_stub_update_defaults();
> +       parse_zoffset(argv[3]);
> +
> +       setup_size = read_setup(argv[1]);
> +
> +       setup_sectors = setup_size/SECTOR_SIZE;
>
>         /* Set the default root device */
>         put_unaligned_le16(DEFAULT_ROOT_DEV, &buf[508]);
>
> -       /* Open and stat the kernel file */
> -       fd = open(argv[2], O_RDONLY);
> -       if (fd < 0)
> -               die("Unable to open `%s': %m", argv[2]);
> -       if (fstat(fd, &sb))
> -               die("Unable to stat `%s': %m", argv[2]);
> -       sz = sb.st_size;
> -       kernel = mmap(NULL, sz, PROT_READ, MAP_SHARED, fd, 0);
> -       if (kernel == MAP_FAILED)
> -               die("Unable to mmap '%s': %m", argv[2]);
> -       /* Number of 16-byte paragraphs, including space for a 4-byte CRC */
> -       sys_size = (sz + 15 + 4) / 16;
> +       /* Map kernel file to memory */
> +       kernel = map_file(argv[2], &kern_file_size);
> +
>  #ifdef CONFIG_EFI_STUB
> -       /*
> -        * COFF requires minimum 32-byte alignment of sections, and
> -        * adding a signature is problematic without that alignment.
> -        */
> -       sys_size = (sys_size + 1) & ~1;
> +       /* PE specification require 512-byte minimum section file alignment */
> +       kern_size = round_up(kern_file_size + 4, SECTOR_SIZE);
> +#else
> +       /* Number of 16-byte paragraphs, including space for a 4-byte CRC */
> +       kern_size = round_up(kern_file_size + 4, PARAGRAPH_SIZE);
>  #endif
>
>         /* Patch the setup code with the appropriate size parameters */
> -       buf[0x1f1] = setup_sectors-1;
> -       put_unaligned_le32(sys_size, &buf[0x1f4]);
> +       buf[0x1f1] = setup_sectors - 1;
> +       put_unaligned_le32(kern_size/PARAGRAPH_SIZE, &buf[0x1f4]);
> +
> +       /* Update kernel_info offset. */
> +       put_unaligned_le32(kernel_info, &buf[0x268]);
> +
> +       init_size = get_unaligned_le32(&buf[0x260]);
>
> -       init_sz = get_unaligned_le32(&buf[0x260]);
>  #ifdef CONFIG_EFI_STUB
>         /*
>          * The decompression buffer will start at ImageBase. When relocating
> @@ -456,45 +635,39 @@ int main(int argc, char ** argv)
>          * For future-proofing, increase init_sz if necessary.
>          */
>
> -       if (init_sz - _end < i + _ehead) {
> -               init_sz = (i + _ehead + _end + 4095) & ~4095;
> -               put_unaligned_le32(init_sz, &buf[0x260]);
> +       if (init_size - _end < setup_size + _ehead) {
> +               init_size = round_up(setup_size + _ehead + _end, SECTION_ALIGNMENT);
> +               put_unaligned_le32(init_size, &buf[0x260]);
>         }
> -#endif
> -       update_pecoff_text(setup_sectors * 512, i + (sys_size * 16), init_sz);
>
> -       efi_stub_entry_update();
> +       total_size = update_pecoff_sections(setup_size, kern_size, init_size, _rodata);
>
> -       /* Update kernel_info offset. */
> -       put_unaligned_le32(kernel_info, &buf[0x268]);
> +       efi_stub_entry_update();
> +#else
> +       (void)init_size;
> +       total_size = setup_size + kern_size;
> +#endif
>
> -       crc = partial_crc32(buf, i, crc);
> -       if (fwrite(buf, 1, i, dest) != i)
> -               die("Writing setup failed");
> +       output = map_output_file(argv[4], total_size);
>
> -       /* Copy the kernel code */
> -       crc = partial_crc32(kernel, sz, crc);
> -       if (fwrite(kernel, 1, sz, dest) != sz)
> -               die("Writing kernel failed");
> +       memcpy(output, buf, setup_size);
> +       memcpy(output + setup_size, kernel, kern_file_size);
> +       memset(output + setup_size + kern_file_size, 0, kern_size - kern_file_size);
>
> -       /* Add padding leaving 4 bytes for the checksum */
> -       while (sz++ < (sys_size*16) - 4) {
> -               crc = partial_crc32_one('\0', crc);
> -               if (fwrite("\0", 1, 1, dest) != 1)
> -                       die("Writing padding failed");
> -       }
> +#ifdef CONFIG_EFI_STUB
> +       generate_pecoff_section_data(output, setup_size);
> +#endif
>
> -       /* Write the CRC */
> -       put_unaligned_le32(crc, buf);
> -       if (fwrite(buf, 1, 4, dest) != 4)
> -               die("Writing CRC failed");
> +       /* Calculate and write kernel checksum. */
> +       crc = partial_crc32(output, total_size - 4, crc);
> +       put_unaligned_le32(crc, &output[total_size - 4]);
>
> -       /* Catch any delayed write failures */
> -       if (fclose(dest))
> -               die("Writing image failed");
> +       /* Catch any delayed write failures. */
> +       if (munmap(output, total_size) < 0)
> +               die("Writing kernel failed");
>
> -       close(fd);
> +       unmap_file(kernel, kern_file_size);
>
> -       /* Everything is OK */
> +       /* Everything is OK. */
>         return 0;
>  }
> diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
> index 680184034cb7..914106d547a6 100644
> --- a/drivers/firmware/efi/libstub/x86-stub.c
> +++ b/drivers/firmware/efi/libstub/x86-stub.c
> @@ -392,6 +392,60 @@ static void __noreturn efi_exit(efi_handle_t handle, efi_status_t status)
>                 asm("hlt");
>  }
>
> +
> +/*
> + * Manually setup memory protection attributes for each ELF section
> + * since we cannot do it properly by using PE sections.
> + */
> +static void setup_sections_memory_protection(void *image_base,
> +                                            unsigned long init_size)
> +{
> +#ifdef CONFIG_EFI_DXE_MEM_ATTRIBUTES
> +       efi_dxe_table = get_efi_config_table(EFI_DXE_SERVICES_TABLE_GUID);
> +
> +       if (!efi_dxe_table ||
> +           efi_dxe_table->hdr.signature != EFI_DXE_SERVICES_TABLE_SIGNATURE) {
> +               efi_warn("Unable to locate EFI DXE services table\n");
> +               efi_dxe_table = NULL;
> +               return;
> +       }
> +
> +       extern char _head[], _ehead[];
> +       extern char _compressed[], _ecompressed[];
> +       extern char _text[], _etext[];
> +       extern char _rodata[], _erodata[];
> +       extern char _data[];
> +
> +       /* .setup [image_base, _head] */
> +       efi_adjust_memory_range_protection((unsigned long)image_base,
> +                                          (unsigned long)_head - (unsigned long)image_base,
> +                                          EFI_MEMORY_RO | EFI_MEMORY_XP);
> +       /* .head.text [_head, _ehead] */
> +       efi_adjust_memory_range_protection((unsigned long)_head,
> +                                          (unsigned long)_ehead - (unsigned long)_head,
> +                                          EFI_MEMORY_RO);
> +       /* .rodata..compressed [_compressed, _ecompressed] */
> +       efi_adjust_memory_range_protection((unsigned long)_compressed,
> +                                          (unsigned long)_ecompressed - (unsigned long)_compressed,
> +                                          EFI_MEMORY_RO | EFI_MEMORY_XP);
> +       /* .text [_text, _etext] */
> +       efi_adjust_memory_range_protection((unsigned long)_text,
> +                                          (unsigned long)_etext - (unsigned long)_text,
> +                                          EFI_MEMORY_RO);
> +       /* .rodata [_rodata, _erodata] */
> +       efi_adjust_memory_range_protection((unsigned long)_rodata,
> +                                          (unsigned long)_erodata - (unsigned long)_rodata,
> +                                          EFI_MEMORY_RO | EFI_MEMORY_XP);
> +       /* .data, .bss [_data, image_base + init_size] */
> +       efi_adjust_memory_range_protection((unsigned long)_data,
> +                                          (unsigned long)image_base + init_size - (unsigned long)_rodata,
> +                                          EFI_MEMORY_XP);
> +#else
> +       (void)image_base;
> +       (void)init_size;
> +#endif
> +}
> +
>  void __noreturn efi_stub_entry(efi_handle_t handle,
>                                efi_system_table_t *sys_table_arg,
>                                struct boot_params *boot_params);
> @@ -438,10 +492,15 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
>
>         hdr = &boot_params->hdr;
>
> -       /* Copy the setup header from the second sector to boot_params */
> -       memcpy(&hdr->jump, image_base + 512,
> +       /*
> +        * Copy the setup header from the second sector
> +        * (mapped to image_base + 0x1000) to boot_params
> +        */
> +       memcpy(&hdr->jump, image_base + 0x1000,
>                sizeof(struct setup_header) - offsetof(struct setup_header, jump));
>
> +       setup_sections_memory_protection(image_base, hdr->init_size);
> +
>         /*
>          * Fill out some of the header fields ourselves because the
>          * EFI firmware loader doesn't load the first sector.
> --
> 2.35.1
>
