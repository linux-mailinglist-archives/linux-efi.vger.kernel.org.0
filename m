Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B4A06B5D1E
	for <lists+linux-efi@lfdr.de>; Sat, 11 Mar 2023 16:02:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbjCKPCW (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 11 Mar 2023 10:02:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjCKPCU (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 11 Mar 2023 10:02:20 -0500
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95547AD02;
        Sat, 11 Mar 2023 07:02:17 -0800 (PST)
Received: from mail.ispras.ru (unknown [83.149.199.84])
        by mail.ispras.ru (Postfix) with ESMTPSA id D625140737C7;
        Sat, 11 Mar 2023 15:02:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru D625140737C7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1678546935;
        bh=iPj/S9Kv+cFp+SHdDMQkgfCBXpZNtIkTcHDE/clNXwA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BvIlWGutuBTvVZ8eGSWUx1WzXH3QHGSTU7CHoykI60Bk0o0agoNyr0422Np8KO/5K
         ck04ooxekJ3T9EjDMn7puHyHaSjlEBkoSPMUXSYrXJ5npY4BPTTONBX+Sw1k0wKRmm
         uo2d8ejCfzeEhT9O0gux13MAANukOuQydODdZFjI=
MIME-Version: 1.0
Date:   Sat, 11 Mar 2023 18:02:15 +0300
From:   Evgeniy Baskov <baskov@ispras.ru>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Peter Jones <pjones@redhat.com>,
        "Limonciello, Mario" <mario.limonciello@amd.com>,
        joeyli <jlee@suse.com>, lvc-project@linuxtesting.org,
        x86@kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v4 20/26] x86/build: Make generated PE more spec compliant
In-Reply-To: <CAMj1kXGu0uFynyt=MostXo58A4f4Zu6cFFiSShFZChU5LWt1ZQ@mail.gmail.com>
References: <cover.1671098103.git.baskov@ispras.ru>
 <2dd706f95dd4fbb24de534b5fdedf7b740d1bac0.1671098103.git.baskov@ispras.ru>
 <CAMj1kXGu0uFynyt=MostXo58A4f4Zu6cFFiSShFZChU5LWt1ZQ@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.4
Message-ID: <f5aaddbe13211c3a3d6d879675ebcaf8@ispras.ru>
X-Sender: baskov@ispras.ru
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 2023-03-10 18:17, Ard Biesheuvel wrote:
> On Thu, 15 Dec 2022 at 13:42, Evgeniy Baskov <baskov@ispras.ru> wrote:
>> 
>> Currently kernel image is not fully compliant PE image, so it may
>> fail to boot with stricter implementations of UEFI PE loaders.
>> 
>> Set minimal alignments and sizes specified by PE documentation [1]
>> referenced by UEFI specification [2]. Align PE header to 8 bytes.
>> 
>> Generate PE sections dynamically. This simplifies code, since with
>> current implementation all of the sections needs to be defined in
>> header.S, where most section header fields do not hold valid values,
>> except for their names. Before the change, it also held flags,
>> but now flags depend on kernel configuration and it is simpler
>> to set them from build.c too.
>> 
>> Setup sections protection. Since we cannot fit every needed section,
>> set a part of protection flags dynamically during initialization.
>> This step is omitted if CONFIG_EFI_DXE_MEM_ATTRIBUTES is not set.
>> 
>> [1] 
>> https://download.microsoft.com/download/9/c/5/9c5b2167-8017-4bae-9fde-d599bac8184a/pecoff_v83.docx
>> [2] 
>> https://uefi.org/sites/default/files/resources/UEFI_Spec_2_9_2021_03_18.pdf
>> 
>> Tested-by: Peter Jones <pjones@redhat.com>
>> Signed-off-by: Evgeniy Baskov <baskov@ispras.ru>
> 
> I would prefer it if we didn't rewrite the build tool this way.
> 
> Having the sections in header.S in the order they appear in the binary
> is rather useful, and I don't think we should manipulate the section
> flags based on whether CONFIG_DXE_MEM_ATTRIBUTES is set. I also don't
> think we need more than .text / .,data (as discussed in the other
> thread on linux-efi@)
> 
> Furthermore, I had a look at the audk PE loader [0], and I think it is
> being overly pedantic.
> 
> The PE/COFF spec does not require that all sections are virtually
> contiguous, and it does not require that the file content is
> completely covered by either the header or by a section.
> 
> So what I would prefer to do is the following:
> 
> Sections:
> Idx Name          Size     VMA              Type
>   0 .reloc        00000200 0000000000002000 DATA
>   1 .compat       00000200 0000000000003000 DATA
>   2 .text         00bee000 0000000000004000 TEXT
>   3 .data         00002200 0000000000bf2000 DATA
> 
> using 4k section alignment and 512 byte file alignment, and a header
> size of 0x200 as before (This requires my patch that allows the setup
> header to remain unmapped when running the stub [1])
> 
> The reloc and compat payloads are placed at the end of the setup data
> as before, but increased in size to 512 bytes each, and then mapped
> non-1:1 into the RVA space.
> 
> This works happily with both the existing PE loader as well as the
> audk one, but with the pedantic flags disabled.
> 

This makes sense. I'll change this patch to use this layout and
to keep sections in headers.S before sending v5. (and I guess I'll
make the compressed kernel a part of .text). I have a few questions
though:

This layout assumes having the local copy of the bootparams as
in your RFC patches, right?

Can I keep the .rodata -- 5th section fits in the section table
without much work?

Also, why .reloc is at offset 0x2000 and not just 0x1000, is there
anything important I am missing? I understand that is cannot be 0
and should be aligned on page size, but nothing else comes to my
mind...

Thanks!
> 
> 
> [0] https://github.com/acidanthera/audk
> [1] 
> https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/commit/?id=84412899c16c65af13dac305aa01a5a85e08c69e
> 
>> ---
>>  arch/x86/boot/Makefile                  |   2 +-
>>  arch/x86/boot/header.S                  |  96 +--------
>>  arch/x86/boot/tools/build.c             | 270 
>> +++++++++++++-----------
>>  drivers/firmware/efi/libstub/x86-stub.c |   7 +-
>>  4 files changed, 161 insertions(+), 214 deletions(-)
>> 
>> diff --git a/arch/x86/boot/Makefile b/arch/x86/boot/Makefile
>> index 9e38ffaadb5d..bed78c82238e 100644
>> --- a/arch/x86/boot/Makefile
>> +++ b/arch/x86/boot/Makefile
>> @@ -91,7 +91,7 @@ $(obj)/vmlinux.bin: $(obj)/compressed/vmlinux FORCE
>> 
>>  SETUP_OBJS = $(addprefix $(obj)/,$(setup-y))
>> 
>> -sed-zoffset := -e 's/^\([0-9a-fA-F]*\) [a-zA-Z] 
>> \(startup_32\|startup_64\|efi32_stub_entry\|efi64_stub_entry\|efi_pe_entry\|efi32_pe_entry\|input_data\|kernel_info\|_end\|_ehead\|_text\|z_.*\)$$/\#define 
>> ZO_\2 0x\1/p'
>> +sed-zoffset := -e 's/^\([0-9a-fA-F]*\) [a-zA-Z] 
>> \(startup_32\|startup_64\|efi32_stub_entry\|efi64_stub_entry\|efi_pe_entry\|efi32_pe_entry\|input_data\|kernel_info\|_end\|_ehead\|_text\|_rodata\|z_.*\)$$/\#define 
>> ZO_\2 0x\1/p'
>> 
>>  quiet_cmd_zoffset = ZOFFSET $@
>>        cmd_zoffset = $(NM) $< | sed -n $(sed-zoffset) > $@
>> diff --git a/arch/x86/boot/header.S b/arch/x86/boot/header.S
>> index 9fec80bc504b..07e31ddb074f 100644
>> --- a/arch/x86/boot/header.S
>> +++ b/arch/x86/boot/header.S
>> @@ -94,6 +94,7 @@ bugger_off_msg:
>>         .set    bugger_off_msg_size, . - bugger_off_msg
>> 
>>  #ifdef CONFIG_EFI_STUB
>> +       .align 8
>>  pe_header:
>>         .long   PE_MAGIC
>> 
>> @@ -107,7 +108,7 @@ coff_header:
>>         .set    pe_opt_magic, PE_OPT_MAGIC_PE32PLUS
>>         .word   IMAGE_FILE_MACHINE_AMD64
>>  #endif
>> -       .word   section_count                   # nr_sections
>> +       .word   0                               # nr_sections
>>         .long   0                               # TimeDateStamp
>>         .long   0                               # PointerToSymbolTable
>>         .long   1                               # NumberOfSymbols
>> @@ -131,7 +132,7 @@ optional_header:
>>         # Filled in by build.c
>>         .long   0x0000                          # AddressOfEntryPoint
>> 
>> -       .long   0x0200                          # BaseOfCode
>> +       .long   0x1000                          # BaseOfCode
>>  #ifdef CONFIG_X86_32
>>         .long   0                               # data
>>  #endif
>> @@ -144,8 +145,8 @@ extra_header_fields:
>>  #else
>>         .quad   image_base                      # ImageBase
>>  #endif
>> -       .long   0x20                            # SectionAlignment
>> -       .long   0x20                            # FileAlignment
>> +       .long   0x1000                          # SectionAlignment
>> +       .long   0x200                           # FileAlignment
>>         .word   0                               # 
>> MajorOperatingSystemVersion
>>         .word   0                               # 
>> MinorOperatingSystemVersion
>>         .word   LINUX_EFISTUB_MAJOR_VERSION     # MajorImageVersion
>> @@ -188,91 +189,14 @@ extra_header_fields:
>>         .quad   0                               # CertificationTable
>>         .quad   0                               # BaseRelocationTable
>> 
>> -       # Section table
>> -section_table:
>> -       #
>> -       # The offset & size fields are filled in by build.c.
>> -       #
>> -       .ascii  ".setup"
>> -       .byte   0
>> -       .byte   0
>> -       .long   0
>> -       .long   0x0                             # startup_{32,64}
>> -       .long   0                               # Size of initialized 
>> data
>> -                                               # on disk
>> -       .long   0x0                             # startup_{32,64}
>> -       .long   0                               # PointerToRelocations
>> -       .long   0                               # PointerToLineNumbers
>> -       .word   0                               # NumberOfRelocations
>> -       .word   0                               # NumberOfLineNumbers
>> -       .long   IMAGE_SCN_CNT_CODE              | \
>> -               IMAGE_SCN_MEM_READ              | \
>> -               IMAGE_SCN_MEM_EXECUTE           | \
>> -               IMAGE_SCN_ALIGN_16BYTES         # Characteristics
>> -
>> -       #
>> -       # The EFI application loader requires a relocation section
>> -       # because EFI applications must be relocatable. The .reloc
>> -       # offset & size fields are filled in by build.c.
>>         #
>> -       .ascii  ".reloc"
>> -       .byte   0
>> -       .byte   0
>> -       .long   0
>> -       .long   0
>> -       .long   0                               # SizeOfRawData
>> -       .long   0                               # PointerToRawData
>> -       .long   0                               # PointerToRelocations
>> -       .long   0                               # PointerToLineNumbers
>> -       .word   0                               # NumberOfRelocations
>> -       .word   0                               # NumberOfLineNumbers
>> -       .long   IMAGE_SCN_CNT_INITIALIZED_DATA  | \
>> -               IMAGE_SCN_MEM_READ              | \
>> -               IMAGE_SCN_MEM_DISCARDABLE       | \
>> -               IMAGE_SCN_ALIGN_1BYTES          # Characteristics
>> -
>> -#ifdef CONFIG_EFI_MIXED
>> -       #
>> -       # The offset & size fields are filled in by build.c.
>> +       # Section table
>> +       # It is generated by build.c and here we just need
>> +       # to reserve some space for sections
>>         #
>> -       .asciz  ".compat"
>> -       .long   0
>> -       .long   0x0
>> -       .long   0                               # Size of initialized 
>> data
>> -                                               # on disk
>> -       .long   0x0
>> -       .long   0                               # PointerToRelocations
>> -       .long   0                               # PointerToLineNumbers
>> -       .word   0                               # NumberOfRelocations
>> -       .word   0                               # NumberOfLineNumbers
>> -       .long   IMAGE_SCN_CNT_INITIALIZED_DATA  | \
>> -               IMAGE_SCN_MEM_READ              | \
>> -               IMAGE_SCN_MEM_DISCARDABLE       | \
>> -               IMAGE_SCN_ALIGN_1BYTES          # Characteristics
>> -#endif
>> +section_table:
>> +       .fill 40*5, 1, 0
>> 
>> -       #
>> -       # The offset & size fields are filled in by build.c.
>> -       #
>> -       .ascii  ".text"
>> -       .byte   0
>> -       .byte   0
>> -       .byte   0
>> -       .long   0
>> -       .long   0x0                             # startup_{32,64}
>> -       .long   0                               # Size of initialized 
>> data
>> -                                               # on disk
>> -       .long   0x0                             # startup_{32,64}
>> -       .long   0                               # PointerToRelocations
>> -       .long   0                               # PointerToLineNumbers
>> -       .word   0                               # NumberOfRelocations
>> -       .word   0                               # NumberOfLineNumbers
>> -       .long   IMAGE_SCN_CNT_CODE              | \
>> -               IMAGE_SCN_MEM_READ              | \
>> -               IMAGE_SCN_MEM_EXECUTE           | \
>> -               IMAGE_SCN_ALIGN_16BYTES         # Characteristics
>> -
>> -       .set    section_count, (. - section_table) / 40
>>  #endif /* CONFIG_EFI_STUB */
>> 
>>         # Kernel attributes; used by setup.  This is part 1 of the
>> diff --git a/arch/x86/boot/tools/build.c b/arch/x86/boot/tools/build.c
>> index fbc5315af032..ac6159b76a13 100644
>> --- a/arch/x86/boot/tools/build.c
>> +++ b/arch/x86/boot/tools/build.c
>> @@ -61,8 +61,10 @@ uint8_t buf[SETUP_SECT_MAX*SECTOR_SIZE];
>> 
>>  #ifdef CONFIG_EFI_MIXED
>>  #define PECOFF_COMPAT_RESERVE 0x20
>> +#define COMPAT_SECTION_SIZE 0x8
>>  #else
>>  #define PECOFF_COMPAT_RESERVE 0x0
>> +#define COMPAT_SECTION_SIZE 0x0
>>  #endif
>> 
>>  #define RELOC_SECTION_SIZE 10
>> @@ -117,6 +119,7 @@ static unsigned long efi_pe_entry;
>>  static unsigned long efi32_pe_entry;
>>  static unsigned long kernel_info;
>>  static unsigned long startup_64;
>> +static unsigned long _rodata;
>>  static unsigned long _ehead;
>>  static unsigned long _end;
>> 
>> @@ -258,122 +261,177 @@ static void *map_output_file(const char *path, 
>> size_t size)
>> 
>>  #ifdef CONFIG_EFI_STUB
>> 
>> -static void update_pecoff_section_header_fields(char *section_name, 
>> uint32_t vma,
>> -                                               uint32_t size, 
>> uint32_t datasz,
>> -                                               uint32_t offset)
>> +static unsigned int reloc_offset;
>> +static unsigned int compat_offset;
>> +
>> +#define MAX_SECTIONS 5
>> +
>> +static void emit_pecoff_section(const char *section_name, unsigned 
>> int size,
>> +                               unsigned int bss, unsigned int 
>> *file_offset,
>> +                               unsigned int *mem_offset, uint32_t 
>> flags)
>>  {
>> -       unsigned int pe_header;
>> +       unsigned int section_memsz, section_filesz;
>> +       unsigned int name_len;
>>         unsigned short num_sections;
>> +       struct pe_hdr *hdr = get_pe_header(buf);
>>         struct section_header *section;
>> 
>> -       struct pe_hdr *hdr = get_pe_header(buf);
>>         num_sections = get_unaligned_le16(&hdr->sections);
>> -       section = get_sections(buf);
>> +       if (num_sections >= MAX_SECTIONS)
>> +               die("Not enough space to generate all sections");
>> 
>> -       while (num_sections > 0) {
>> -               if (strncmp(section->name, section_name, 8) == 0) {
>> -                       /* section header size field */
>> -                       put_unaligned_le32(size, 
>> &section->virtual_size);
>> +       section = get_sections(buf) + num_sections;
>> 
>> -                       /* section header vma field */
>> -                       put_unaligned_le32(vma, 
>> &section->virtual_address);
>> +       if ((size & (FILE_ALIGNMENT - 1)) || (bss & (FILE_ALIGNMENT - 
>> 1)))
>> +               die("Section '%s' is improperly aligned", 
>> section_name);
>> 
>> -                       /* section header 'size of initialised data' 
>> field */
>> -                       put_unaligned_le32(datasz, 
>> &section->raw_data_size);
>> +       section_memsz = round_up(size + bss, SECTION_ALIGNMENT);
>> +       section_filesz = round_up(size, FILE_ALIGNMENT);
>> 
>> -                       /* section header 'file offset' field */
>> -                       put_unaligned_le32(offset, 
>> &section->data_addr);
>> +       /* Zero out all section fields */
>> +       memset(section, 0, sizeof(*section));
>> 
>> -                       break;
>> -               }
>> -               section++;
>> -               num_sections--;
>> -       }
>> -}
>> +       name_len = strlen(section_name);
>> +       if (name_len > sizeof(section->name))
>> +               name_len = sizeof(section_name);
>> 
>> -static void update_pecoff_section_header(char *section_name, uint32_t 
>> offset, uint32_t size)
>> -{
>> -       update_pecoff_section_header_fields(section_name, offset, 
>> size, size, offset);
>> +       /* Section header size field */
>> +       memcpy(section->name, section_name, name_len);
>> +
>> +       put_unaligned_le32(section_memsz, &section->virtual_size);
>> +       put_unaligned_le32(*mem_offset, &section->virtual_address);
>> +       put_unaligned_le32(section_filesz, &section->raw_data_size);
>> +       put_unaligned_le32(*file_offset, &section->data_addr);
>> +       put_unaligned_le32(flags, &section->flags);
>> +
>> +       put_unaligned_le16(num_sections + 1, &hdr->sections);
>> +
>> +       *mem_offset += section_memsz;
>> +       *file_offset += section_filesz;
>>  }
>> 
>> -static void update_pecoff_setup_and_reloc(unsigned int size)
>> +#define BASE_RVA 0x1000
>> +
>> +static unsigned int text_rva;
>> +
>> +static unsigned int update_pecoff_sections(unsigned int setup_size,
>> +                                          unsigned int file_size,
>> +                                          unsigned int virt_size,
>> +                                          unsigned int text_size)
>>  {
>> -       uint32_t setup_offset = SECTOR_SIZE;
>> -       uint32_t reloc_offset = size - PECOFF_RELOC_RESERVE - 
>> PECOFF_COMPAT_RESERVE;
>> -#ifdef CONFIG_EFI_MIXED
>> -       uint32_t compat_offset = reloc_offset + PECOFF_RELOC_RESERVE;
>> -#endif
>> -       uint32_t setup_size = reloc_offset - setup_offset;
>> +       /* First section starts at 512 byes, after PE header */
>> +       unsigned int mem_offset = BASE_RVA, file_offset = SECTOR_SIZE;
>> +       unsigned int compat_size, reloc_size;
>> +       unsigned int bss_size, text_rva_diff, reloc_rva;
>> +       pe_opt_hdr  *opt_hdr = get_pe_opt_header(buf);
>> +       struct pe_hdr *hdr = get_pe_header(buf);
>> +       struct data_dirent *base_reloc;
>> +
>> +       if (get_unaligned_le32(&hdr->sections))
>> +               die("Some sections present in PE file");
>> 
>> -       update_pecoff_section_header(".setup", setup_offset, 
>> setup_size);
>> -       update_pecoff_section_header(".reloc", reloc_offset, 
>> PECOFF_RELOC_RESERVE);
>> +       reloc_size = round_up(RELOC_SECTION_SIZE, FILE_ALIGNMENT);
>> +       compat_size = round_up(COMPAT_SECTION_SIZE, FILE_ALIGNMENT);
>> +       virt_size = round_up(virt_size, SECTION_ALIGNMENT);
>> 
>>         /*
>> -        * Modify .reloc section contents with a single entry. The
>> -        * relocation is applied to offset 10 of the relocation 
>> section.
>> +        * Update sections offsets.
>> +        * NOTE: Order is important
>>          */
>> -       put_unaligned_le32(reloc_offset + RELOC_SECTION_SIZE, 
>> &buf[reloc_offset]);
>> -       put_unaligned_le32(RELOC_SECTION_SIZE, &buf[reloc_offset + 
>> 4]);
>> 
>> +       bss_size = virt_size - file_size;
>> +
>> +       emit_pecoff_section(".setup", setup_size - SECTOR_SIZE, 0,
>> +                           &file_offset, &mem_offset, SCN_RO |
>> +                           IMAGE_SCN_CNT_INITIALIZED_DATA);
>> +
>> +       text_rva_diff = mem_offset - file_offset;
>> +       text_rva = mem_offset;
>> +       emit_pecoff_section(".text", text_size, 0,
>> +                           &file_offset, &mem_offset, SCN_RX |
>> +                           IMAGE_SCN_CNT_CODE);
>> +
>> +       /* Check that kernel sections mapping is contiguous */
>> +       if (text_rva_diff != mem_offset - file_offset)
>> +               die("Kernel sections mapping is wrong: %#x != %#x",
>> +                   mem_offset - file_offset, text_rva_diff);
>> +
>> +       emit_pecoff_section(".data", file_size - text_size, bss_size,
>> +                           &file_offset, &mem_offset, SCN_RW |
>> +                           IMAGE_SCN_CNT_INITIALIZED_DATA);
>> +
>> +       reloc_offset = file_offset;
>> +       reloc_rva = mem_offset;
>> +       emit_pecoff_section(".reloc", reloc_size, 0,
>> +                           &file_offset, &mem_offset, SCN_RW |
>> +                           IMAGE_SCN_CNT_INITIALIZED_DATA |
>> +                           IMAGE_SCN_MEM_DISCARDABLE);
>> +
>> +       compat_offset = file_offset;
>>  #ifdef CONFIG_EFI_MIXED
>> -       update_pecoff_section_header(".compat", compat_offset, 
>> PECOFF_COMPAT_RESERVE);
>> +       emit_pecoff_section(".comat", compat_size, 0,
>> +                           &file_offset, &mem_offset, SCN_RW |
>> +                           IMAGE_SCN_CNT_INITIALIZED_DATA |
>> +                           IMAGE_SCN_MEM_DISCARDABLE);
>> +#endif
>> 
>> +       if (file_size + setup_size + reloc_size + compat_size != 
>> file_offset)
>> +               die("file_size(%#x) != filesz(%#x)",
>> +                   file_size + setup_size + reloc_size + compat_size, 
>> file_offset);
>> +
>> +       /* Size of code. */
>> +       put_unaligned_le32(round_up(text_size, SECTION_ALIGNMENT), 
>> &opt_hdr->text_size);
>>         /*
>> -        * Put the IA-32 machine type (0x14c) and the associated entry 
>> point
>> -        * address in the .compat section, so loaders can figure out 
>> which other
>> -        * execution modes this image supports.
>> +        * Size of data.
>> +        * Exclude text size and first sector, which contains PE 
>> header.
>>          */
>> -       buf[compat_offset] = 0x1;
>> -       buf[compat_offset + 1] = 0x8;
>> -       put_unaligned_le16(IMAGE_FILE_MACHINE_I386, &buf[compat_offset 
>> + 2]);
>> -       put_unaligned_le32(efi32_pe_entry + size, &buf[compat_offset + 
>> 4]);
>> -#endif
>> -}
>> +       put_unaligned_le32(mem_offset - round_up(text_size, 
>> SECTION_ALIGNMENT),
>> +                          &opt_hdr->data_size);
>> 
>> -static unsigned int update_pecoff_sections(unsigned int text_start, 
>> unsigned int text_sz,
>> -                              unsigned int init_sz)
>> -{
>> -       unsigned int file_sz = text_start + text_sz;
>> -       unsigned int bss_sz = init_sz - file_sz;
>> -       pe_opt_hdr *hdr = get_pe_opt_header(buf);
>> +       /* Size of image. */
>> +       put_unaligned_le32(mem_offset, &opt_hdr->image_size);
>> 
>>         /*
>> -        * The PE/COFF loader may load the image at an address which 
>> is
>> -        * misaligned with respect to the kernel_alignment field in 
>> the setup
>> -        * header.
>> -        *
>> -        * In order to avoid relocating the kernel to correct the 
>> misalignment,
>> -        * add slack to allow the buffer to be aligned within the 
>> declared size
>> -        * of the image.
>> +        * Address of entry point for PE/COFF executable
>>          */
>> -       bss_sz  += CONFIG_PHYSICAL_ALIGN;
>> -       init_sz += CONFIG_PHYSICAL_ALIGN;
>> +       put_unaligned_le32(text_rva + efi_pe_entry, 
>> &opt_hdr->entry_point);
>> 
>>         /*
>> -        * Size of code: Subtract the size of the first sector (512 
>> bytes)
>> -        * which includes the header.
>> +        * BaseOfCode for PE/COFF executable
>>          */
>> -       put_unaligned_le32(file_sz - SECTOR_SIZE + bss_sz, 
>> &hdr->text_size);
>> -
>> -       /* Size of image */
>> -       put_unaligned_le32(init_sz, &hdr->image_size);
>> +       put_unaligned_le32(text_rva, &opt_hdr->code_base);
>> 
>>         /*
>> -        * Address of entry point for PE/COFF executable
>> +        * Since we have generated .reloc section, we need to
>> +        * fill-in Reloc directory
>>          */
>> -       put_unaligned_le32(text_start + efi_pe_entry, 
>> &hdr->entry_point);
>> +       base_reloc = &get_data_dirs(buf)->base_relocations;
>> +       put_unaligned_le32(reloc_rva, &base_reloc->virtual_address);
>> +       put_unaligned_le32(RELOC_SECTION_SIZE, &base_reloc->size);
>> 
>> -       update_pecoff_section_header_fields(".text", text_start, 
>> text_sz + bss_sz,
>> -                                           text_sz, text_start);
>> -
>> -       return text_start + file_sz;
>> +       return file_offset;
>>  }
>> 
>> -static int reserve_pecoff_reloc_section(int c)
>> +static void generate_pecoff_section_data(uint8_t *output)
>>  {
>> -       /* Reserve 0x20 bytes for .reloc section */
>> -       memset(buf+c, 0, PECOFF_RELOC_RESERVE);
>> -       return PECOFF_RELOC_RESERVE;
>> +       /*
>> +        * Modify .reloc section contents with a two entries. The
>> +        * relocation is applied to offset 10 of the relocation 
>> section.
>> +        */
>> +       put_unaligned_le32(reloc_offset + RELOC_SECTION_SIZE, 
>> &output[reloc_offset]);
>> +       put_unaligned_le32(RELOC_SECTION_SIZE, &output[reloc_offset + 
>> 4]);
>> +
>> +#ifdef CONFIG_EFI_MIXED
>> +       /*
>> +        * Put the IA-32 machine type (0x14c) and the associated entry 
>> point
>> +        * address in the .compat section, so loaders can figure out 
>> which other
>> +        * execution modes this image supports.
>> +        */
>> +       output[compat_offset] = 0x1;
>> +       output[compat_offset + 1] = 0x8;
>> +       put_unaligned_le16(IMAGE_FILE_MACHINE_I386, 
>> &output[compat_offset + 2]);
>> +       put_unaligned_le32(efi32_pe_entry + text_rva, 
>> &output[compat_offset + 4]);
>> +#endif
>>  }
>> 
>>  static void efi_stub_update_defaults(void)
>> @@ -407,26 +465,10 @@ static void efi_stub_entry_update(void)
>> 
>>  #else
>> 
>> -static inline void update_pecoff_setup_and_reloc(unsigned int size) 
>> {}
>> -static inline void update_pecoff_text(unsigned int text_start,
>> -                                     unsigned int file_sz,
>> -                                     unsigned int init_sz) {}
>> -static inline void efi_stub_update_defaults(void) {}
>> -static inline void efi_stub_entry_update(void) {}
>> +static void efi_stub_update_defaults(void) {}
>> 
>> -static inline int reserve_pecoff_reloc_section(int c)
>> -{
>> -       return 0;
>> -}
>>  #endif /* CONFIG_EFI_STUB */
>> 
>> -static int reserve_pecoff_compat_section(int c)
>> -{
>> -       /* Reserve 0x20 bytes for .compat section */
>> -       memset(buf+c, 0, PECOFF_COMPAT_RESERVE);
>> -       return PECOFF_COMPAT_RESERVE;
>> -}
>> -
>>  /*
>>   * Parse zoffset.h and find the entry points. We could just #include 
>> zoffset.h
>>   * but that would mean tools/build would have to be rebuilt every 
>> time. It's
>> @@ -456,6 +498,7 @@ static void parse_zoffset(char *fname)
>>                 PARSE_ZOFS(p, efi32_pe_entry);
>>                 PARSE_ZOFS(p, kernel_info);
>>                 PARSE_ZOFS(p, startup_64);
>> +               PARSE_ZOFS(p, _rodata);
>>                 PARSE_ZOFS(p, _ehead);
>>                 PARSE_ZOFS(p, _end);
>> 
>> @@ -489,10 +532,6 @@ static unsigned int read_setup(char *path)
>> 
>>         fclose(file);
>> 
>> -       /* Reserve space for PE sections */
>> -       file_size += reserve_pecoff_compat_section(file_size);
>> -       file_size += reserve_pecoff_reloc_section(file_size);
>> -
>>         /* Pad unused space with zeros */
>> 
>>         setup_size = round_up(file_size, SECTOR_SIZE);
>> @@ -515,7 +554,6 @@ int main(int argc, char **argv)
>>         size_t kern_file_size;
>>         unsigned int setup_size;
>>         unsigned int setup_sectors;
>> -       unsigned int init_size;
>>         unsigned int total_size;
>>         unsigned int kern_size;
>>         void *kernel;
>> @@ -540,8 +578,7 @@ int main(int argc, char **argv)
>> 
>>  #ifdef CONFIG_EFI_STUB
>>         /* PE specification require 512-byte minimum section file 
>> alignment */
>> -       kern_size = round_up(kern_file_size + 4, SECTOR_SIZE);
>> -       update_pecoff_setup_and_reloc(setup_size);
>> +       kern_size = round_up(kern_file_size + 4, FILE_ALIGNMENT);
>>  #else
>>         /* Number of 16-byte paragraphs, including space for a 4-byte 
>> CRC */
>>         kern_size = round_up(kern_file_size + 4, PARAGRAPH_SIZE);
>> @@ -554,33 +591,12 @@ int main(int argc, char **argv)
>>         /* Update kernel_info offset. */
>>         put_unaligned_le32(kernel_info, &buf[0x268]);
>> 
>> -       init_size = get_unaligned_le32(&buf[0x260]);
>> -
>>  #ifdef CONFIG_EFI_STUB
>> -       /*
>> -        * The decompression buffer will start at ImageBase. When 
>> relocating
>> -        * the compressed kernel to its end, we must ensure that the 
>> head
>> -        * section does not get overwritten.  The head section 
>> occupies
>> -        * [i, i + _ehead), and the destination is [init_sz - _end, 
>> init_sz).
>> -        *
>> -        * At present these should never overlap, because 'i' is at 
>> most 32k
>> -        * because of SETUP_SECT_MAX, '_ehead' is less than 1k, and 
>> the
>> -        * calculation of INIT_SIZE in boot/header.S ensures that
>> -        * 'init_sz - _end' is at least 64k.
>> -        *
>> -        * For future-proofing, increase init_sz if necessary.
>> -        */
>> -
>> -       if (init_size - _end < setup_size + _ehead) {
>> -               init_size = round_up(setup_size + _ehead + _end, 
>> SECTION_ALIGNMENT);
>> -               put_unaligned_le32(init_size, &buf[0x260]);
>> -       }
>> 
>> -       total_size = update_pecoff_sections(setup_size, kern_size, 
>> init_size);
>> +       total_size = update_pecoff_sections(setup_size, kern_size, 
>> _end, _rodata);
>> 
>>         efi_stub_entry_update();
>>  #else
>> -       (void)init_size;
>>         total_size = setup_size + kern_size;
>>  #endif
>> 
>> @@ -590,6 +606,10 @@ int main(int argc, char **argv)
>>         memcpy(output + setup_size, kernel, kern_file_size);
>>         memset(output + setup_size + kern_file_size, 0, kern_size - 
>> kern_file_size);
>> 
>> +#ifdef CONFIG_EFI_STUB
>> +       generate_pecoff_section_data(output);
>> +#endif
>> +
>>         /* Calculate and write kernel checksum. */
>>         crc = partial_crc32(output, total_size - 4, crc);
>>         put_unaligned_le32(crc, &output[total_size - 4]);
>> diff --git a/drivers/firmware/efi/libstub/x86-stub.c 
>> b/drivers/firmware/efi/libstub/x86-stub.c
>> index 1d1ab1911fd3..1f0a2e7075c3 100644
>> --- a/drivers/firmware/efi/libstub/x86-stub.c
>> +++ b/drivers/firmware/efi/libstub/x86-stub.c
>> @@ -389,8 +389,11 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t 
>> handle,
>> 
>>         hdr = &boot_params->hdr;
>> 
>> -       /* Copy the setup header from the second sector to boot_params 
>> */
>> -       memcpy(&hdr->jump, image_base + 512,
>> +       /*
>> +        * Copy the setup header from the second sector
>> +        * (mapped to image_base + 0x1000) to boot_params
>> +        */
>> +       memcpy(&hdr->jump, image_base + 0x1000,
>>                sizeof(struct setup_header) - offsetof(struct 
>> setup_header, jump));
>> 
>>         /*
>> --
>> 2.37.4
>> 
