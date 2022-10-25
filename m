Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F4DD60CEB7
	for <lists+linux-efi@lfdr.de>; Tue, 25 Oct 2022 16:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233302AbiJYOPW (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 25 Oct 2022 10:15:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233146AbiJYOOX (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 25 Oct 2022 10:14:23 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E57EB14D4;
        Tue, 25 Oct 2022 07:14:21 -0700 (PDT)
Received: from localhost.localdomain (unknown [83.149.199.65])
        by mail.ispras.ru (Postfix) with ESMTPSA id EE5F440737BB;
        Tue, 25 Oct 2022 14:14:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru EE5F440737BB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1666707260;
        bh=QX2DpD231MFEliyX/X3/J+86gjec8p624mEwynhLUpk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JjwwaEO69cOk3nAbkBvjhcH2rzK+AhHegyFxK86wka8+tR748Ncq+zM5x0PHmd0xW
         bBl+Keo4+1U9lUIaEwraqt4Ore3vnwZGBGSujXZhmmhe7kSogcIQWkj7Dlt39YOx5D
         9cZCsc4c48oEXjMpCDquOQhPVvyfxl6dnE3UNcn0=
From:   Evgeniy Baskov <baskov@ispras.ru>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Evgeniy Baskov <baskov@ispras.ru>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Peter Jones <pjones@redhat.com>, lvc-project@linuxtesting.org,
        x86@kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH v2 20/23] x86/build: Make generated PE more spec compliant
Date:   Tue, 25 Oct 2022 17:12:58 +0300
Message-Id: <8001c760e5f0ef19b00897ade1a42b8eb5b92650.1666705333.git.baskov@ispras.ru>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <cover.1666705333.git.baskov@ispras.ru>
References: <cover.1666705333.git.baskov@ispras.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Currently kernel image is not fully compliant PE image, so it may
fail to boot with stricter implementations of UEFI PE loaders.

Set minimal alignments and sizes specified by PE documentation [1]
referenced by UEFI specification [2]. Align PE header to 8 bytes.

Generate PE sections dynamically. This simplifies code, since with
current implementation all of the sections needs to be defined in
header.S, where most section header fields do not hold valid values,
except for their names. Before the change, it also held flags,
but now flags depend on kernel configuration and it is simpler
to set them from build.c too.

Setup sections protection. Since we cannot fit every needed section,
set a part of protection flags dynamically during initialization.
This step is omitted if CONFIG_EFI_DXE_MEM_ATTRIBUTES is not set.

[1] https://download.microsoft.com/download/9/c/5/9c5b2167-8017-4bae-9fde-d599bac8184a/pecoff_v83.docx
[2] https://uefi.org/sites/default/files/resources/UEFI_Spec_2_9_2021_03_18.pdf

Signed-off-by: Evgeniy Baskov <baskov@ispras.ru>
---
 arch/x86/boot/Makefile                  |   2 +-
 arch/x86/boot/header.S                  |  96 +--------
 arch/x86/boot/tools/build.c             | 258 +++++++++++++++---------
 drivers/firmware/efi/libstub/x86-stub.c |   7 +-
 4 files changed, 175 insertions(+), 188 deletions(-)

diff --git a/arch/x86/boot/Makefile b/arch/x86/boot/Makefile
index 9860ca5979f8..7b4bdd926b10 100644
--- a/arch/x86/boot/Makefile
+++ b/arch/x86/boot/Makefile
@@ -91,7 +91,7 @@ $(obj)/vmlinux.bin: $(obj)/compressed/vmlinux FORCE
 
 SETUP_OBJS = $(addprefix $(obj)/,$(setup-y))
 
-sed-zoffset := -e 's/^\([0-9a-fA-F]*\) [a-zA-Z] \(startup_32\|startup_64\|efi32_stub_entry\|efi64_stub_entry\|efi_pe_entry\|efi32_pe_entry\|input_data\|kernel_info\|_end\|_ehead\|_text\|z_.*\)$$/\#define ZO_\2 0x\1/p'
+sed-zoffset := -e 's/^\([0-9a-fA-F]*\) [a-zA-Z] \(startup_32\|startup_64\|efi32_stub_entry\|efi64_stub_entry\|efi_pe_entry\|efi32_pe_entry\|input_data\|kernel_info\|_end\|_ehead\|_text\|_rodata\|z_.*\)$$/\#define ZO_\2 0x\1/p'
 
 quiet_cmd_zoffset = ZOFFSET $@
       cmd_zoffset = $(NM) $< | sed -n $(sed-zoffset) > $@
diff --git a/arch/x86/boot/header.S b/arch/x86/boot/header.S
index e4de831b2f64..0d2f97607c86 100644
--- a/arch/x86/boot/header.S
+++ b/arch/x86/boot/header.S
@@ -93,6 +93,7 @@ bugger_off_msg:
 	.set	bugger_off_msg_size, . - bugger_off_msg
 
 #ifdef CONFIG_EFI_STUB
+	.align 8
 pe_header:
 	.long	PE_MAGIC
 
@@ -106,7 +107,7 @@ coff_header:
 	.set	pe_opt_magic, PE_OPT_MAGIC_PE32PLUS
 	.word	IMAGE_FILE_MACHINE_AMD64
 #endif
-	.word	section_count			# nr_sections
+	.word	0				# nr_sections
 	.long	0 				# TimeDateStamp
 	.long	0				# PointerToSymbolTable
 	.long	1				# NumberOfSymbols
@@ -130,7 +131,7 @@ optional_header:
 	# Filled in by build.c
 	.long	0x0000				# AddressOfEntryPoint
 
-	.long	0x0200				# BaseOfCode
+	.long	0x1000				# BaseOfCode
 #ifdef CONFIG_X86_32
 	.long	0				# data
 #endif
@@ -143,8 +144,8 @@ extra_header_fields:
 #else
 	.quad	image_base			# ImageBase
 #endif
-	.long	0x20				# SectionAlignment
-	.long	0x20				# FileAlignment
+	.long	0x1000				# SectionAlignment
+	.long	0x200				# FileAlignment
 	.word	0				# MajorOperatingSystemVersion
 	.word	0				# MinorOperatingSystemVersion
 	.word	LINUX_EFISTUB_MAJOR_VERSION	# MajorImageVersion
@@ -187,91 +188,14 @@ extra_header_fields:
 	.quad	0				# CertificationTable
 	.quad	0				# BaseRelocationTable
 
-	# Section table
-section_table:
-	#
-	# The offset & size fields are filled in by build.c.
-	#
-	.ascii	".setup"
-	.byte	0
-	.byte	0
-	.long	0
-	.long	0x0				# startup_{32,64}
-	.long	0				# Size of initialized data
-						# on disk
-	.long	0x0				# startup_{32,64}
-	.long	0				# PointerToRelocations
-	.long	0				# PointerToLineNumbers
-	.word	0				# NumberOfRelocations
-	.word	0				# NumberOfLineNumbers
-	.long	IMAGE_SCN_CNT_CODE		| \
-		IMAGE_SCN_MEM_READ		| \
-		IMAGE_SCN_MEM_EXECUTE		| \
-		IMAGE_SCN_ALIGN_16BYTES		# Characteristics
-
-	#
-	# The EFI application loader requires a relocation section
-	# because EFI applications must be relocatable. The .reloc
-	# offset & size fields are filled in by build.c.
 	#
-	.ascii	".reloc"
-	.byte	0
-	.byte	0
-	.long	0
-	.long	0
-	.long	0				# SizeOfRawData
-	.long	0				# PointerToRawData
-	.long	0				# PointerToRelocations
-	.long	0				# PointerToLineNumbers
-	.word	0				# NumberOfRelocations
-	.word	0				# NumberOfLineNumbers
-	.long	IMAGE_SCN_CNT_INITIALIZED_DATA	| \
-		IMAGE_SCN_MEM_READ		| \
-		IMAGE_SCN_MEM_DISCARDABLE	| \
-		IMAGE_SCN_ALIGN_1BYTES		# Characteristics
-
-#ifdef CONFIG_EFI_MIXED
-	#
-	# The offset & size fields are filled in by build.c.
+	# Section table
+	# It is generated by build.c and here we just need
+	# to reserve some space for sections
 	#
-	.asciz	".compat"
-	.long	0
-	.long	0x0
-	.long	0				# Size of initialized data
-						# on disk
-	.long	0x0
-	.long	0				# PointerToRelocations
-	.long	0				# PointerToLineNumbers
-	.word	0				# NumberOfRelocations
-	.word	0				# NumberOfLineNumbers
-	.long	IMAGE_SCN_CNT_INITIALIZED_DATA	| \
-		IMAGE_SCN_MEM_READ		| \
-		IMAGE_SCN_MEM_DISCARDABLE	| \
-		IMAGE_SCN_ALIGN_1BYTES		# Characteristics
-#endif
+section_table:
+	.fill 40*5, 1, 0
 
-	#
-	# The offset & size fields are filled in by build.c.
-	#
-	.ascii	".text"
-	.byte	0
-	.byte	0
-	.byte	0
-	.long	0
-	.long	0x0				# startup_{32,64}
-	.long	0				# Size of initialized data
-						# on disk
-	.long	0x0				# startup_{32,64}
-	.long	0				# PointerToRelocations
-	.long	0				# PointerToLineNumbers
-	.word	0				# NumberOfRelocations
-	.word	0				# NumberOfLineNumbers
-	.long	IMAGE_SCN_CNT_CODE		| \
-		IMAGE_SCN_MEM_READ		| \
-		IMAGE_SCN_MEM_EXECUTE		| \
-		IMAGE_SCN_ALIGN_16BYTES		# Characteristics
-
-	.set	section_count, (. - section_table) / 40
 #endif /* CONFIG_EFI_STUB */
 
 	# Kernel attributes; used by setup.  This is part 1 of the
diff --git a/arch/x86/boot/tools/build.c b/arch/x86/boot/tools/build.c
index 9202645fec72..cd957a4f9d4e 100644
--- a/arch/x86/boot/tools/build.c
+++ b/arch/x86/boot/tools/build.c
@@ -61,8 +61,10 @@ uint8_t buf[SETUP_SECT_MAX*SECTOR_SIZE];
 
 #ifdef CONFIG_EFI_MIXED
 #define PECOFF_COMPAT_RESERVE 0x20
+#define COMPAT_SECTION_SIZE 0x8
 #else
 #define PECOFF_COMPAT_RESERVE 0x0
+#define COMPAT_SECTION_SIZE 0x0
 #endif
 
 #define RELOC_SECTION_SIZE 10
@@ -117,6 +119,7 @@ static unsigned long efi_pe_entry;
 static unsigned long efi32_pe_entry;
 static unsigned long kernel_info;
 static unsigned long startup_64;
+static unsigned long _rodata;
 static unsigned long _ehead;
 static unsigned long _end;
 
@@ -258,84 +261,69 @@ static void *map_output_file(const char *path, size_t size)
 
 #ifdef CONFIG_EFI_STUB
 
-static void update_pecoff_section_header_fields(char *section_name, uint32_t vma,
-						uint32_t size, uint32_t datasz,
-						uint32_t offset)
+static unsigned int reloc_offset;
+static unsigned int compat_offset;
+
+#define MAX_SECTIONS 5
+
+static void emit_pecoff_section(const char *section_name, unsigned int size,
+				unsigned int bss, unsigned int *file_offset,
+				unsigned int *mem_offset, uint32_t flags)
 {
-	unsigned int pe_header;
+	unsigned int section_memsz, section_filesz;
 	unsigned short num_sections;
+	struct pe_hdr *hdr = get_pe_header(buf);
 	struct section_header *section;
 
-	struct pe_hdr *hdr = get_pe_header(buf);
 	num_sections = get_unaligned_le16(&hdr->sections);
-	section = get_sections(buf);
+	if (num_sections >= MAX_SECTIONS)
+		die("Not enough space to generate all sections");
 
-	while (num_sections > 0) {
-		if (strncmp(section->name, section_name, 8) == 0) {
-			/* section header size field */
-			put_unaligned_le32(size, &section->virtual_size);
+	section = get_sections(buf) + num_sections;
 
-			/* section header vma field */
-			put_unaligned_le32(vma, &section->virtual_address);
+	if ((size & (FILE_ALIGNMENT - 1)) || (bss & (FILE_ALIGNMENT - 1)))
+		die("Section '%s' is improperly aligned", section_name);
 
-			/* section header 'size of initialised data' field */
-			put_unaligned_le32(datasz, &section->raw_data_size);
+	section_memsz = round_up(size + bss, SECTION_ALIGNMENT);
+	section_filesz = round_up(size, FILE_ALIGNMENT);
 
-			/* section header 'file offset' field */
-			put_unaligned_le32(offset, &section->data_addr);
+	/* Zero out all section fields */
+	memset(section, 0, sizeof(*section));
 
-			break;
-		}
-		section++;
-		num_sections--;
-	}
-}
-
-static void update_pecoff_section_header(char *section_name, uint32_t offset, uint32_t size)
-{
-	update_pecoff_section_header_fields(section_name, offset, size, size, offset);
-}
+	/* Section header size field */
+	memcpy(section->name, section_name, sizeof(section->name));
 
-static void update_pecoff_setup_and_reloc(unsigned int size)
-{
-	uint32_t setup_offset = SECTOR_SIZE;
-	uint32_t reloc_offset = size - PECOFF_RELOC_RESERVE - PECOFF_COMPAT_RESERVE;
-#ifdef CONFIG_EFI_MIXED
-	uint32_t compat_offset = reloc_offset + PECOFF_RELOC_RESERVE;
-#endif
-	uint32_t setup_size = reloc_offset - setup_offset;
+	put_unaligned_le32(section_memsz, &section->virtual_size);
+	put_unaligned_le32(*mem_offset, &section->virtual_address);
+	put_unaligned_le32(section_filesz, &section->raw_data_size);
+	put_unaligned_le32(*file_offset, &section->data_addr);
+	put_unaligned_le32(flags, &section->flags);
 
-	update_pecoff_section_header(".setup", setup_offset, setup_size);
-	update_pecoff_section_header(".reloc", reloc_offset, PECOFF_RELOC_RESERVE);
+	put_unaligned_le16(num_sections + 1, &hdr->sections);
 
-	/*
-	 * Modify .reloc section contents with a single entry. The
-	 * relocation is applied to offset 10 of the relocation section.
-	 */
-	put_unaligned_le32(reloc_offset + RELOC_SECTION_SIZE, &buf[reloc_offset]);
-	put_unaligned_le32(RELOC_SECTION_SIZE, &buf[reloc_offset + 4]);
+	*mem_offset += section_memsz;
+	*file_offset += section_filesz;
+}
 
-#ifdef CONFIG_EFI_MIXED
-	update_pecoff_section_header(".compat", compat_offset, PECOFF_COMPAT_RESERVE);
+#define BASE_RVA 0x1000
 
-	/*
-	 * Put the IA-32 machine type (0x14c) and the associated entry point
-	 * address in the .compat section, so loaders can figure out which other
-	 * execution modes this image supports.
-	 */
-	buf[compat_offset] = 0x1;
-	buf[compat_offset + 1] = 0x8;
-	put_unaligned_le16(IMAGE_FILE_MACHINE_I386, &buf[compat_offset + 2]);
-	put_unaligned_le32(efi32_pe_entry + size, &buf[compat_offset + 4]);
-#endif
-}
+static unsigned int text_rva;
 
-static unsigned int update_pecoff_sections(unsigned int text_start, unsigned int text_sz,
-			       unsigned int init_sz)
+static unsigned int update_pecoff_sections(unsigned int setup_size,
+					   unsigned int file_size,
+					   unsigned int init_size,
+					   unsigned int text_size)
 {
-	unsigned int file_sz = text_start + text_sz;
-	unsigned int bss_sz = init_sz - file_sz;
-	pe_opt_hdr *hdr = get_pe_opt_header(buf);
+	/* First section starts at 512 byes, after PE header */
+	unsigned int mem_offset = BASE_RVA, file_offset = SECTOR_SIZE;
+	unsigned int compat_size, reloc_size, image_size;
+	unsigned int bss_size, text_rva_diff, reloc_rva;
+	pe_opt_hdr  *opt_hdr = get_pe_opt_header(buf);
+	struct pe_hdr *hdr = get_pe_header(buf);
+	struct data_dirent *base_reloc;
+
+	if (get_unaligned_le32(&hdr->sections))
+		die("Some sections present in PE file");
 
 	/*
 	 * The PE/COFF loader may load the image at an address which is
@@ -346,34 +334,122 @@ static unsigned int update_pecoff_sections(unsigned int text_start, unsigned int
 	 * add slack to allow the buffer to be aligned within the declared size
 	 * of the image.
 	 */
-	bss_sz	+= CONFIG_PHYSICAL_ALIGN;
-	init_sz	+= CONFIG_PHYSICAL_ALIGN;
+	init_size += CONFIG_PHYSICAL_ALIGN;
+	image_size = init_size;
+
+	reloc_size = round_up(RELOC_SECTION_SIZE, FILE_ALIGNMENT);
+	compat_size = round_up(COMPAT_SECTION_SIZE, FILE_ALIGNMENT);
+
+	/*
+	 * Let's remove extra memory used by special sections
+	 * and use it as a part of bss.
+	 */
+	init_size -= round_up(reloc_size, SECTION_ALIGNMENT);
+	init_size -= round_up(compat_size, SECTION_ALIGNMENT);
+	if (init_size < file_size + setup_size) {
+		init_size = file_size + setup_size;
+		image_size += round_up(reloc_size, SECTION_ALIGNMENT);
+		image_size += round_up(compat_size, SECTION_ALIGNMENT);
+	}
 
 	/*
-	 * Size of code: Subtract the size of the first sector (512 bytes)
-	 * which includes the header.
+	 * Update sections offsets.
+	 * NOTE: Order is important
 	 */
-	put_unaligned_le32(file_sz - SECTOR_SIZE + bss_sz, &hdr->text_size);
 
-	/* Size of image */
-	put_unaligned_le32(init_sz, &hdr->image_size);
+	bss_size = init_size - file_size - setup_size;
+
+	emit_pecoff_section(".setup", setup_size - SECTOR_SIZE, 0,
+			    &file_offset, &mem_offset, SCN_RO |
+			    IMAGE_SCN_CNT_INITIALIZED_DATA);
+
+	text_rva_diff = mem_offset - file_offset;
+	text_rva = mem_offset;
+	emit_pecoff_section(".text", text_size, 0,
+			    &file_offset, &mem_offset, SCN_RX |
+			    IMAGE_SCN_CNT_CODE);
+
+	/* Check that kernel sections mapping is contiguous */
+	if (text_rva_diff != mem_offset - file_offset)
+		die("Kernel sections mapping is wrong: %#x != %#x",
+		    mem_offset - file_offset, text_rva_diff);
+
+	emit_pecoff_section(".data", file_size - text_size, bss_size,
+			    &file_offset, &mem_offset, SCN_RW |
+			    IMAGE_SCN_CNT_INITIALIZED_DATA);
+
+	reloc_offset = file_offset;
+	reloc_rva = mem_offset;
+	emit_pecoff_section(".reloc", reloc_size, 0,
+			    &file_offset, &mem_offset, SCN_RW |
+			    IMAGE_SCN_CNT_INITIALIZED_DATA |
+			    IMAGE_SCN_MEM_DISCARDABLE);
+
+	compat_offset = file_offset;
+#ifdef CONFIG_EFI_MIXED
+	emit_pecoff_section(".comat", compat_size, 0,
+			    &file_offset, &mem_offset, SCN_RW |
+			    IMAGE_SCN_CNT_INITIALIZED_DATA |
+			    IMAGE_SCN_MEM_DISCARDABLE);
+#endif
+
+	if (file_size + setup_size + reloc_size + compat_size != file_offset)
+		die("file_size(%#x) != filesz(%#x)",
+		    file_size + setup_size + reloc_size + compat_size, file_offset);
+
+	/* Size of code. */
+	put_unaligned_le32(round_up(text_size, SECTION_ALIGNMENT), &opt_hdr->text_size);
+	/*
+	 * Size of data.
+	 * Exclude text size and first sector, which contains PE header.
+	 */
+	put_unaligned_le32(mem_offset - round_up(text_size, SECTION_ALIGNMENT),
+			   &opt_hdr->data_size);
+
+	/* Size of image. */
+	put_unaligned_le32(mem_offset, &opt_hdr->image_size);
 
 	/*
 	 * Address of entry point for PE/COFF executable
 	 */
-	put_unaligned_le32(text_start + efi_pe_entry, &hdr->entry_point);
+	put_unaligned_le32(text_rva + efi_pe_entry, &opt_hdr->entry_point);
 
-	update_pecoff_section_header_fields(".text", text_start, text_sz + bss_sz,
-					    text_sz, text_start);
+	/*
+	 * BaseOfCode for PE/COFF executable
+	 */
+	put_unaligned_le32(text_rva, &opt_hdr->code_base);
+
+	/*
+	 * Since we have generated .reloc section, we need to
+	 * fill-in Reloc directory
+	 */
+	base_reloc = &get_data_dirs(buf)->base_relocations;
+	put_unaligned_le32(reloc_rva, &base_reloc->virtual_address);
+	put_unaligned_le32(RELOC_SECTION_SIZE, &base_reloc->size);
 
-	return text_start + file_sz;
+	return file_offset;
 }
 
-static int reserve_pecoff_reloc_section(int c)
+static void generate_pecoff_section_data(uint8_t *output)
 {
-	/* Reserve 0x20 bytes for .reloc section */
-	memset(buf+c, 0, PECOFF_RELOC_RESERVE);
-	return PECOFF_RELOC_RESERVE;
+	/*
+	 * Modify .reloc section contents with a two entries. The
+	 * relocation is applied to offset 10 of the relocation section.
+	 */
+	put_unaligned_le32(reloc_offset + RELOC_SECTION_SIZE, &output[reloc_offset]);
+	put_unaligned_le32(RELOC_SECTION_SIZE, &output[reloc_offset + 4]);
+
+#ifdef CONFIG_EFI_MIXED
+	/*
+	 * Put the IA-32 machine type (0x14c) and the associated entry point
+	 * address in the .compat section, so loaders can figure out which other
+	 * execution modes this image supports.
+	 */
+	output[compat_offset] = 0x1;
+	output[compat_offset + 1] = 0x8;
+	put_unaligned_le16(IMAGE_FILE_MACHINE_I386, &output[compat_offset + 2]);
+	put_unaligned_le32(efi32_pe_entry + text_rva, &output[compat_offset + 4]);
+#endif
 }
 
 static void efi_stub_update_defaults(void)
@@ -405,26 +481,10 @@ static void efi_stub_entry_update(void)
 
 #else
 
-static inline void update_pecoff_setup_and_reloc(unsigned int size) {}
-static inline void update_pecoff_text(unsigned int text_start,
-				      unsigned int file_sz,
-				      unsigned int init_sz) {}
-static inline void efi_stub_update_defaults(void) {}
-static inline void efi_stub_entry_update(void) {}
+static void efi_stub_update_defaults(void) {}
 
-static inline int reserve_pecoff_reloc_section(int c)
-{
-	return 0;
-}
 #endif /* CONFIG_EFI_STUB */
 
-static int reserve_pecoff_compat_section(int c)
-{
-	/* Reserve 0x20 bytes for .compat section */
-	memset(buf+c, 0, PECOFF_COMPAT_RESERVE);
-	return PECOFF_COMPAT_RESERVE;
-}
-
 /*
  * Parse zoffset.h and find the entry points. We could just #include zoffset.h
  * but that would mean tools/build would have to be rebuilt every time. It's
@@ -454,6 +514,7 @@ static void parse_zoffset(char *fname)
 		PARSE_ZOFS(p, efi32_pe_entry);
 		PARSE_ZOFS(p, kernel_info);
 		PARSE_ZOFS(p, startup_64);
+		PARSE_ZOFS(p, _rodata);
 		PARSE_ZOFS(p, _ehead);
 		PARSE_ZOFS(p, _end);
 
@@ -487,10 +548,6 @@ static unsigned int read_setup(char *path)
 
 	fclose(file);
 
-	/* Reserve space for PE sections */
-	file_size += reserve_pecoff_compat_section(file_size);
-	file_size += reserve_pecoff_reloc_section(file_size);
-
 	/* Pad unused space with zeros */
 
 	setup_size = round_up(file_size, SECTOR_SIZE);
@@ -539,7 +596,6 @@ int main(int argc, char **argv)
 #ifdef CONFIG_EFI_STUB
 	/* PE specification require 512-byte minimum section file alignment */
 	kern_size = round_up(kern_file_size + 4, SECTOR_SIZE);
-	update_pecoff_setup_and_reloc(setup_size);
 #else
 	/* Number of 16-byte paragraphs, including space for a 4-byte CRC */
 	kern_size = round_up(kern_file_size + 4, PARAGRAPH_SIZE);
@@ -574,7 +630,7 @@ int main(int argc, char **argv)
 		put_unaligned_le32(init_size, &buf[0x260]);
 	}
 
-	total_size = update_pecoff_sections(setup_size, kern_size, init_size);
+	total_size = update_pecoff_sections(setup_size, kern_size, init_size, _rodata);
 
 	efi_stub_entry_update();
 #else
@@ -588,6 +644,10 @@ int main(int argc, char **argv)
 	memcpy(output + setup_size, kernel, kern_file_size);
 	memset(output + setup_size + kern_file_size, 0, kern_size - kern_file_size);
 
+#ifdef CONFIG_EFI_STUB
+	generate_pecoff_section_data(output);
+#endif
+
 	/* Calculate and write kernel checksum. */
 	crc = partial_crc32(output, total_size - 4, crc);
 	put_unaligned_le32(crc, &output[total_size - 4]);
diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index 8f172b688b0c..4d9588d33479 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -389,8 +389,11 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 
 	hdr = &boot_params->hdr;
 
-	/* Copy the setup header from the second sector to boot_params */
-	memcpy(&hdr->jump, image_base + 512,
+	/*
+	 * Copy the setup header from the second sector
+	 * (mapped to image_base + 0x1000) to boot_params
+	 */
+	memcpy(&hdr->jump, image_base + 0x1000,
 	       sizeof(struct setup_header) - offsetof(struct setup_header, jump));
 
 	/*
-- 
2.37.4

