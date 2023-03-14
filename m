Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FAF66B90A2
	for <lists+linux-efi@lfdr.de>; Tue, 14 Mar 2023 11:53:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbjCNKxB (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 14 Mar 2023 06:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjCNKw7 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 14 Mar 2023 06:52:59 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82DB596C3C;
        Tue, 14 Mar 2023 03:52:19 -0700 (PDT)
Received: from localhost.localdomain (unknown [83.149.199.65])
        by mail.ispras.ru (Postfix) with ESMTPSA id 9EAAA4076277;
        Tue, 14 Mar 2023 10:23:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 9EAAA4076277
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1678789405;
        bh=iM6+1GubGICW+ynFVh8QqywTvTWifPcVcp3P5j6FJpM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gqtGjPUYblDK7Mwr0J79nYn755VtnvIJ/78nbNkbUr5QNci/0QqC7ELZrPs+1boj+
         69zO0fAbhASTf1lyGvUOO2iUES74UHtNMjYLUzYjsm1s7qMu4PFUQx69E2Bf72chCa
         GKNS1WqwnzdCsTC2Bx0Ne4uyQ9vENGd/uERWa4fo=
From:   Evgeniy Baskov <baskov@ispras.ru>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Evgeniy Baskov <baskov@ispras.ru>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Peter Jones <pjones@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        "Limonciello, Mario" <mario.limonciello@amd.com>,
        joeyli <jlee@suse.com>, lvc-project@linuxtesting.org,
        x86@kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH v5 24/27] x86/build: Make generated PE more spec compliant
Date:   Tue, 14 Mar 2023 13:13:51 +0300
Message-Id: <ea323fb2078f56434ec1d2ac8c5ebbf4f68c7a6d.1678785672.git.baskov@ispras.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1678785672.git.baskov@ispras.ru>
References: <cover.1678785672.git.baskov@ispras.ru>
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
Align the state of generated PE image with loaders expectations and
the PE documentation [1] referenced by the UEFI specification [2].

Set minimal alignments and sizes according to the spec. Align data
structures to their natural alignments to prevent unaligned data
accesses.

Stop generating '.setup' section, as it is no longer used.
It was needed before to read the boot_params from the kernel image.
EFISTUB was switch to use local copy of the boot_params, to this section
is no longer necessary.

Don't reserve init_size (a buffer size required for the extracted
kernel) of memory for the PE image, since in-place extraction is no
longer used when using UEFI to boot.

Split '.text' into '.data' and '.text' to apply proper memory
protection attributes. Make '.data' non-executable and '.text'
non-writable implement W^X.

Fill SizeOfCode, SizeOfInitializedData, SizeOfUninitializedData,
AddressOfEntryPoint, BaseOfCode and reloc data directory with
appropriate values in tools/build.c.

Remove alignment flags on sections, since they are only allowed
on object files.

This patch and several previous one incorporates some ideas from the
RFC at [3].

[1] https://download.microsoft.com/download/9/c/5/9c5b2167-8017-4bae-9fde-d599bac8184a/pecoff_v83.docx
[2] https://uefi.org/sites/default/files/resources/UEFI_Spec_2_9_2021_03_18.pdf
[3] https://lore.kernel.org/linux-efi/20230308202209.2980947-1-ardb@kernel.org/

Signed-off-by: Evgeniy Baskov <baskov@ispras.ru>
---
 arch/x86/boot/Makefile      |   2 +-
 arch/x86/boot/header.S      |  62 +++++++-------
 arch/x86/boot/tools/build.c | 156 ++++++++++++++++++------------------
 3 files changed, 106 insertions(+), 114 deletions(-)

diff --git a/arch/x86/boot/Makefile b/arch/x86/boot/Makefile
index 8203f1a23f7a..0c61fbb082bb 100644
--- a/arch/x86/boot/Makefile
+++ b/arch/x86/boot/Makefile
@@ -91,7 +91,7 @@ $(obj)/vmlinux.bin: $(obj)/compressed/vmlinux FORCE
 
 SETUP_OBJS = $(addprefix $(obj)/,$(setup-y))
 
-sed-zoffset := -e 's/^\([0-9a-fA-F]*\) [a-zA-Z] \(startup_32\|startup_64\|efi32_stub_entry\|efi64_stub_entry\|efi_pe_entry\|efi32_pe_entry\|efi_boot_params\|input_data\|kernel_info\|_end\|_ehead\|_text\|z_.*\)$$/\#define ZO_\2 0x\1/p'
+sed-zoffset := -e 's/^\([0-9a-fA-F]*\) [a-zA-Z] \(startup_32\|startup_64\|efi32_stub_entry\|efi64_stub_entry\|efi_pe_entry\|efi32_pe_entry\|efi_boot_params\|input_data\|kernel_info\|_end\|_data\|z_.*\)$$/\#define ZO_\2 0x\1/p'
 
 quiet_cmd_zoffset = ZOFFSET $@
       cmd_zoffset = $(NM) $< | sed -n $(sed-zoffset) > $@
diff --git a/arch/x86/boot/header.S b/arch/x86/boot/header.S
index d4e16edf1198..0e96dcac91c0 100644
--- a/arch/x86/boot/header.S
+++ b/arch/x86/boot/header.S
@@ -47,6 +47,8 @@ SYSSEG		= 0x1000		/* historical load address >> 4 */
 	#
 	.long	LINUX_PE_MAGIC
 	.long	pe_header
+
+	.align 8
 pe_header:
 	.long	PE_MAGIC
 
@@ -75,16 +77,13 @@ optional_header:
 	.byte	0x02				# MajorLinkerVersion
 	.byte	0x14				# MinorLinkerVersion
 
-	# Filled in by build.c
+	# All of these are filled in by build.c
 	.long	0				# SizeOfCode
-
 	.long	0				# SizeOfInitializedData
 	.long	0				# SizeOfUninitializedData
-
-	# Filled in by build.c
 	.long	0x0000				# AddressOfEntryPoint
+	.long	0x0000				# BaseOfCode
 
-	.long	0x0200				# BaseOfCode
 #ifdef CONFIG_X86_32
 	.long	0				# data
 #endif
@@ -97,8 +96,8 @@ extra_header_fields:
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
@@ -143,26 +142,6 @@ extra_header_fields:
 
 	# Section table
 section_table:
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
 	#
 	# The EFI application loader requires a relocation section
 	# because EFI applications must be relocatable. The .reloc
@@ -181,8 +160,7 @@ section_table:
 	.word	0				# NumberOfLineNumbers
 	.long	IMAGE_SCN_CNT_INITIALIZED_DATA	| \
 		IMAGE_SCN_MEM_READ		| \
-		IMAGE_SCN_MEM_DISCARDABLE	| \
-		IMAGE_SCN_ALIGN_1BYTES		# Characteristics
+		IMAGE_SCN_MEM_DISCARDABLE	# Characteristics
 
 #ifdef CONFIG_EFI_MIXED
 	#
@@ -200,8 +178,7 @@ section_table:
 	.word	0				# NumberOfLineNumbers
 	.long	IMAGE_SCN_CNT_INITIALIZED_DATA	| \
 		IMAGE_SCN_MEM_READ		| \
-		IMAGE_SCN_MEM_DISCARDABLE	| \
-		IMAGE_SCN_ALIGN_1BYTES		# Characteristics
+		IMAGE_SCN_MEM_DISCARDABLE	# Characteristics
 #endif
 
 	#
@@ -222,8 +199,27 @@ section_table:
 	.word	0				# NumberOfLineNumbers
 	.long	IMAGE_SCN_CNT_CODE		| \
 		IMAGE_SCN_MEM_READ		| \
-		IMAGE_SCN_MEM_EXECUTE		| \
-		IMAGE_SCN_ALIGN_16BYTES		# Characteristics
+		IMAGE_SCN_MEM_EXECUTE		# Characteristics
+
+	#
+	# The offset & size fields are filled in by build.c.
+	#
+	.ascii	".data"
+	.byte	0
+	.byte	0
+	.byte	0
+	.long	0
+	.long	0x0				# startup_{32,64}
+	.long	0				# Size of initialized data
+						# on disk
+	.long	0x0				# startup_{32,64}
+	.long	0				# PointerToRelocations
+	.long	0				# PointerToLineNumbers
+	.word	0				# NumberOfRelocations
+	.word	0				# NumberOfLineNumbers
+	.long	IMAGE_SCN_CNT_INITIALIZED_DATA	| \
+		IMAGE_SCN_MEM_READ		| \
+		IMAGE_SCN_MEM_WRITE		# Characteristics
 
 	.set	section_count, (. - section_table) / 40
 #endif /* CONFIG_EFI_STUB */
diff --git a/arch/x86/boot/tools/build.c b/arch/x86/boot/tools/build.c
index 5ac4f08ed923..92a3d4a8ed6b 100644
--- a/arch/x86/boot/tools/build.c
+++ b/arch/x86/boot/tools/build.c
@@ -57,19 +57,20 @@ typedef unsigned int   u32;
 #define SECTOR_SIZE 512
 #define FILE_ALIGNMENT 512
 #define SECTION_ALIGNMENT 4096
+#define BASE_RVA 0x1000
 
 /* This must be large enough to hold the entire setup */
 u8 buf[SETUP_SECT_MAX*SECTOR_SIZE];
 
-#define PECOFF_RELOC_RESERVE 0x20
+#define PECOFF_RELOC_RESERVE round_up(0x20, FILE_ALIGNMENT)
 
 #ifdef CONFIG_EFI_MIXED
-#define PECOFF_COMPAT_RESERVE 0x20
+#define PECOFF_COMPAT_RESERVE round_up(0x20, FILE_ALIGNMENT)
 #else
 #define PECOFF_COMPAT_RESERVE 0x0
 #endif
 
-#define RELOC_SECTION_SIZE 10
+#define RELOC_SECTION_SIZE 12
 
 /* PE header has different format depending on the architecture */
 #ifdef CONFIG_X86_64
@@ -110,7 +111,7 @@ static unsigned long efi32_pe_entry;
 static unsigned long efi_boot_params;
 static unsigned long kernel_info;
 static unsigned long startup_64;
-static unsigned long _ehead;
+static unsigned long _data;
 static unsigned long _end;
 
 /*----------------------------------------------------------------------*/
@@ -251,7 +252,7 @@ static void *map_output_file(const char *path, size_t size)
 
 #ifdef CONFIG_EFI_STUB
 
-static void update_pecoff_section_header_fields(char *section_name, u32 vma, u32 size, u32 datasz, u32 offset)
+static void update_pecoff_section_header(char *section_name, u32 vma, u32 size, u32 datasz, u32 offset)
 {
 	unsigned short num_sections;
 	struct section_header *section;
@@ -281,32 +282,44 @@ static void update_pecoff_section_header_fields(char *section_name, u32 vma, u32
 	}
 }
 
-static void update_pecoff_section_header(char *section_name, u32 offset, u32 size)
-{
-	update_pecoff_section_header_fields(section_name, offset, size, size, offset);
-}
 
-static void update_pecoff_setup_and_reloc(unsigned int size)
+static unsigned int update_pecoff_reloc_and_compat(unsigned int setup_size)
 {
-	u32 setup_offset = SECTOR_SIZE;
-	u32 reloc_offset = size - PECOFF_RELOC_RESERVE - PECOFF_COMPAT_RESERVE;
+	unsigned int current_rva = BASE_RVA;
+	struct data_directory *dir;
+	u32 reloc_offset = setup_size - PECOFF_RELOC_RESERVE - PECOFF_COMPAT_RESERVE;
+	u32 reloc_memsz = round_up(PECOFF_RELOC_RESERVE, SECTION_ALIGNMENT);
+
 #ifdef CONFIG_EFI_MIXED
 	u32 compat_offset = reloc_offset + PECOFF_RELOC_RESERVE;
+	u32 compat_memsz = round_up(PECOFF_COMPAT_RESERVE, SECTION_ALIGNMENT);
 #endif
-	u32 setup_size = reloc_offset - setup_offset;
 
-	update_pecoff_section_header(".setup", setup_offset, setup_size);
-	update_pecoff_section_header(".reloc", reloc_offset, PECOFF_RELOC_RESERVE);
+	update_pecoff_section_header(".reloc", current_rva, reloc_memsz,
+				     PECOFF_RELOC_RESERVE, reloc_offset);
+
+	/* Update PE data directory to point to '.reloc' section */
+	dir = (struct data_directory *)(get_pe_opt_header(buf) + 1);
+	put_unaligned_le32(current_rva, &dir->base_relocations.virtual_address);
+	put_unaligned_le32(RELOC_SECTION_SIZE, &dir->base_relocations.size);
 
 	/*
-	 * Modify .reloc section contents with a single entry. The
-	 * relocation is applied to offset 10 of the relocation section.
+	 * Modify .reloc section contents with two no-op entries. The
+	 * relocation is applied to offset 12 of the relocation section.
+	 * There are two entries since, according to the PE documentation,
+	 * every base relocation block should start on 32-bit boundary.
+	 * There is only one block, but some loaders incorrectly check
+	 * the size to always be 32-bit aligned even on the last block.
 	 */
-	put_unaligned_le32(reloc_offset + RELOC_SECTION_SIZE, &buf[reloc_offset]);
+	put_unaligned_le32(current_rva + RELOC_SECTION_SIZE, &buf[reloc_offset]);
 	put_unaligned_le32(RELOC_SECTION_SIZE, &buf[reloc_offset + 4]);
 
+	current_rva += reloc_memsz;
+
 #ifdef CONFIG_EFI_MIXED
-	update_pecoff_section_header(".compat", compat_offset, PECOFF_COMPAT_RESERVE);
+	update_pecoff_section_header(".compat", current_rva, compat_memsz,
+				     PECOFF_COMPAT_RESERVE, compat_offset);
+	current_rva += compat_memsz;
 
 	/*
 	 * Put the IA-32 machine type (0x14c) and the associated entry point
@@ -316,47 +329,56 @@ static void update_pecoff_setup_and_reloc(unsigned int size)
 	buf[compat_offset] = 0x1;
 	buf[compat_offset + 1] = 0x8;
 	put_unaligned_le16(IMAGE_FILE_MACHINE_I386, &buf[compat_offset + 2]);
-	put_unaligned_le32(efi32_pe_entry + size, &buf[compat_offset + 4]);
+	put_unaligned_le32(efi32_pe_entry + setup_size, &buf[compat_offset + 4]);
 #endif
+	return current_rva;
 }
 
-static unsigned int update_pecoff_sections(unsigned int text_start, unsigned int text_sz,
-			       unsigned int init_sz)
+static void update_pecoff_sections(unsigned int setup_sz,
+				   unsigned int text_sz,
+				   unsigned int file_sz,
+				   unsigned int image_sz)
 {
-	unsigned int file_sz = text_start + text_sz;
-	unsigned int bss_sz = init_sz - file_sz;
+	unsigned int current_rva;
 	pe_opt_hdr *hdr = get_pe_opt_header(buf);
 
-	/*
-	 * The PE/COFF loader may load the image at an address which is
-	 * misaligned with respect to the kernel_alignment field in the setup
-	 * header.
-	 *
-	 * In order to avoid relocating the kernel to correct the misalignment,
-	 * add slack to allow the buffer to be aligned within the declared size
-	 * of the image.
-	 */
-	bss_sz	+= CONFIG_PHYSICAL_ALIGN;
-	init_sz	+= CONFIG_PHYSICAL_ALIGN;
+	current_rva = update_pecoff_reloc_and_compat(setup_sz);
 
-	/*
-	 * Size of code: Subtract the size of the first sector (512 bytes)
-	 * which includes the header.
-	 */
-	put_unaligned_le32(file_sz - SECTOR_SIZE + bss_sz, &hdr->text_size);
+	/* Update sizes inside PE header: */
 
-	/* Size of image */
-	put_unaligned_le32(init_sz, &hdr->image_size);
+	/* Text size*/
+	put_unaligned_le32(text_sz, &hdr->text_size);
 
 	/*
-	 * Address of entry point for PE/COFF executable
+	 * Initialized data size.
+	 * Consider .compat, .reloc and .data sections as data
 	 */
-	put_unaligned_le32(text_start + efi_pe_entry, &hdr->entry_point);
+	put_unaligned_le32(current_rva - BASE_RVA + file_sz - text_sz,
+			   &hdr->data_size);
+
+	/* Uninialized data size */
+	put_unaligned_le32(image_sz - file_sz, &hdr->bss_size);
+
+	/* Total image size. Consider all rections and headers. */
+	put_unaligned_le32(current_rva + image_sz, &hdr->image_size);
+
+	/* Address of entry point for PE/COFF executable */
+	put_unaligned_le32(current_rva + efi_pe_entry, &hdr->entry_point);
+
+	/* Base of the text section */
+	put_unaligned_le32(current_rva, &hdr->code_base);
 
-	update_pecoff_section_header_fields(".text", text_start, text_sz + bss_sz,
-					    text_sz, text_start);
+	/* Update PE sections offsets: */
+
+	/* Text section */
+	update_pecoff_section_header(".text", current_rva, text_sz,
+				     text_sz, setup_sz);
+	current_rva += text_sz;
+
+	/* Text section */
+	update_pecoff_section_header(".data", current_rva, image_sz - text_sz,
+				     file_sz - text_sz, setup_sz + text_sz);
 
-	return text_start + file_sz;
 }
 
 static int reserve_pecoff_reloc_section(int c)
@@ -397,10 +419,10 @@ static void efi_stub_entry_update(void)
 
 #else
 
-static inline void update_pecoff_setup_and_reloc(unsigned int size) {}
-static inline void update_pecoff_text(unsigned int text_start,
-				      unsigned int file_sz,
-				      unsigned int init_sz) {}
+static unsigned int update_pecoff_sections(unsigned int setup_sz,
+					   unsigned int text_sz,
+					   unsigned int file_sz,
+					   unsigned int image_sz) {}
 static inline void efi_stub_update_defaults(void) {}
 static inline void efi_stub_entry_update(void) {}
 
@@ -447,7 +469,7 @@ static void parse_zoffset(char *fname)
 		PARSE_ZOFS(p, efi_boot_params);
 		PARSE_ZOFS(p, kernel_info);
 		PARSE_ZOFS(p, startup_64);
-		PARSE_ZOFS(p, _ehead);
+		PARSE_ZOFS(p, _data);
 		PARSE_ZOFS(p, _end);
 
 		p = strchr(p, '\n');
@@ -506,7 +528,6 @@ int main(int argc, char **argv)
 	size_t kern_file_size;
 	unsigned int setup_size;
 	unsigned int setup_sectors;
-	unsigned int init_size;
 	unsigned int total_size;
 	unsigned int kern_size;
 	void *kernel;
@@ -534,7 +555,6 @@ int main(int argc, char **argv)
 #ifdef CONFIG_EFI_STUB
 	/* PE specification require 512-byte minimum section file alignment */
 	kern_size = round_up(kern_file_size + 4, FILE_ALIGNMENT);
-	update_pecoff_setup_and_reloc(setup_size);
 #else
 	/* Number of 16-byte paragraphs, including space for a 4-byte CRC */
 	kern_size = round_up(kern_file_size + 4, PARAGRAPH_SIZE);
@@ -547,36 +567,12 @@ int main(int argc, char **argv)
 	/* Update kernel_info_offset. */
 	put_unaligned_le32(kernel_info, &setup_header[0x77]);
 
-	init_size = get_unaligned_le32(&setup_header[0x6F]);
-
 #ifdef CONFIG_EFI_STUB
-	/*
-	 * The decompression buffer will start at ImageBase. When relocating
-	 * the compressed kernel to its end, we must ensure that the head
-	 * section does not get overwritten.  The head section occupies
-	 * [i, i + _ehead), and the destination is [init_sz - _end, init_sz).
-	 *
-	 * At present these should never overlap, because 'i' is at most 32k
-	 * because of SETUP_SECT_MAX, '_ehead' is less than 1k, and the
-	 * calculation of INIT_SIZE in boot/header.S ensures that
-	 * 'init_sz - _end' is at least 64k.
-	 *
-	 * For future-proofing, increase init_sz if necessary.
-	 */
-
-	if (init_size - _end < setup_size + _ehead) {
-		init_size = round_up(setup_size + _ehead + _end, SECTION_ALIGNMENT);
-		put_unaligned_le32(init_size, &setup_header[0x6F]);
-	}
-
-	total_size = update_pecoff_sections(setup_size, kern_size, init_size);
-
+	update_pecoff_sections(setup_size, _data, kern_size, _end);
 	efi_stub_entry_update();
-#else
-	(void)init_size;
-	total_size = setup_size + kern_size;
 #endif
 
+	total_size = setup_size + kern_size;
 	output = map_output_file(argv[4], total_size);
 
 	memcpy(output, buf, setup_size);
-- 
2.39.2

