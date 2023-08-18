Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63F00780CDA
	for <lists+linux-efi@lfdr.de>; Fri, 18 Aug 2023 15:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377324AbjHRNqD (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 18 Aug 2023 09:46:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377405AbjHRNpo (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 18 Aug 2023 09:45:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 586A24217;
        Fri, 18 Aug 2023 06:45:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C207F616E0;
        Fri, 18 Aug 2023 13:45:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EDDCC433C8;
        Fri, 18 Aug 2023 13:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692366334;
        bh=EJx0d6hkMvf7DTB/18tohg9RjVBeeiAwdn4lnoe+9vU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qfTuC2lgbbebu7X5PLd9wg3ChTBLD4D4SxwbP7cG3W69ZLFrOnqTtGRQBFcisGqeS
         im9i3pzU19p0F/N+YLGROGgTyd07znixgLCxVO93sd7zLfA4hh0w1q4udSsLQKOXx9
         cnJxROBOblqrP16kP2/cUaNMei+m5B53euzOCxx9YzaGINNQEkOCV/BYSsLts++YeW
         KswmyLM0aJ7sYjGTDtz04z1bEHXL5HHO54LK+3wfiiqbpaWp2wbO3f2r/v/yzksHce
         sQsjX+MonIfCP4GXekE4zSFiieFm/FYbegydfPJ2y9TdaNbzgfizaD+dagGXMrE0+w
         L0Cc7rpZsm5SQ==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Evgeniy Baskov <baskov@ispras.ru>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Jones <pjones@redhat.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        =?UTF-8?q?Marvin=20H=C3=A4user?= <mhaeuser@posteo.de>
Subject: [PATCH 16/17] x86/boot: Increase section and file alignment to 4k/512
Date:   Fri, 18 Aug 2023 15:44:21 +0200
Message-Id: <20230818134422.380032-17-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230818134422.380032-1-ardb@kernel.org>
References: <20230818134422.380032-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10918; i=ardb@kernel.org; h=from:subject; bh=EJx0d6hkMvf7DTB/18tohg9RjVBeeiAwdn4lnoe+9vU=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIeV+6cbAdauqvzz80XdHxpV/Tk2JmXsD/6ms4qwPzgtKV Ho2zF/QUcrCIMbBICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACZyeCIjw3Lxuyzi18qqe/kj tCTUv66VendjGXsswwr2U6s4Cyx1mhkZjh3L+PJm8tmft3lEf5941FCV+eb3xA33jdpt0hcK/J7 oxAAA
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Align x86 with other EFI architectures, and increase the section
alignment to the EFI page size (4k), so that firmware is able to honour
the section permission attributes and map code read-only and data
non-executable.

There are a number of requirements that have to be taken into account:
- the sign tools get cranky when there are gaps between sections in the
  file view of the image
- the virtual offset of each section must be aligned to the image's
  section alignment
- the file offset *and size* of each section must be aligned to the
  image's file alignment
- the image size must be aligned to the section alignment
- each section's virtual offset must be greater than or equal to the
  size of the headers.

In order to meet all these requirements, while avoiding the need for
lots of padding the accommodate the .pecompat section, the latter is
placed at an arbitrary offset >= 4k in the image, but aligned to
the minimum file alignment (512 bytes). The space before the .text
section is therefore distributed between the PE header, the .setup
section and the .pecompat section, leaving no gaps in the file coverage,
making the signing tools happy.

The virtual placement of the .pecompat section is at the end of the
image. Whether or not the data gets loaded there depends on how the PE
loader interprets the EFI_IMAGE_SCN_MEM_DISCARDABLE section attribute,
but this doesn't really matter as the contents are only relevant to
mixed mode capable PE loaders anyway.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/Makefile                 |  1 +
 arch/x86/boot/compressed/vmlinux.lds.S |  4 +-
 arch/x86/boot/header.S                 | 81 +++++++++--------
 arch/x86/boot/setup.ld                 |  3 +-
 arch/x86/boot/tools/build.c            | 91 --------------------
 5 files changed, 51 insertions(+), 129 deletions(-)

diff --git a/arch/x86/boot/Makefile b/arch/x86/boot/Makefile
index 50c50fce646e2417..18548e351ffb4867 100644
--- a/arch/x86/boot/Makefile
+++ b/arch/x86/boot/Makefile
@@ -68,6 +68,7 @@ targets += cpustr.h
 KBUILD_CFLAGS	:= $(REALMODE_CFLAGS) -D_SETUP
 KBUILD_AFLAGS	:= $(KBUILD_CFLAGS) -D__ASSEMBLY__
 KBUILD_CFLAGS	+= $(call cc-option,-fmacro-prefix-map=$(srctree)/=)
+KBUILD_CFLAGS	+= $(call cc-option,-Oz)
 KBUILD_CFLAGS	+= -fno-asynchronous-unwind-tables
 KBUILD_CFLAGS	+= $(call cc-option,-Oz)
 GCOV_PROFILE := n
diff --git a/arch/x86/boot/compressed/vmlinux.lds.S b/arch/x86/boot/compressed/vmlinux.lds.S
index 5326f3b441948c5d..3df57cdf500375f2 100644
--- a/arch/x86/boot/compressed/vmlinux.lds.S
+++ b/arch/x86/boot/compressed/vmlinux.lds.S
@@ -43,13 +43,13 @@ SECTIONS
 		*(.rodata.*)
 		_erodata = . ;
 	}
-	.data :	{
+	.data :	ALIGN(0x1000) {
 		_data = . ;
 		*(.data)
 		*(.data.*)
 
 		/* add 4 bytes of extra space for a CRC-32 checksum */
-		. = ALIGN(. + 4, 0x20);
+		. = ALIGN(. + 4, 0x200);
 		_edata = . ;
 	}
 	. = ALIGN(L1_CACHE_BYTES);
diff --git a/arch/x86/boot/header.S b/arch/x86/boot/header.S
index 25dda40dacb52292..695ce5344350a4db 100644
--- a/arch/x86/boot/header.S
+++ b/arch/x86/boot/header.S
@@ -40,6 +40,9 @@ SYSSEG		= 0x1000		/* historical load address >> 4 */
 	.globl	setup_size
 	.set	setup_size, 0x4000
 
+	.set	salign, 0x1000
+	.set	falign, 0x200
+
 	.code16
 	.section ".bstext", "ax"
 #ifdef CONFIG_EFI_STUB
@@ -86,7 +89,7 @@ optional_header:
 
 	.long	setup_size + ZO_efi_pe_entry	# AddressOfEntryPoint
 
-	.long	0x0200				# BaseOfCode
+	.long	setup_size			# BaseOfCode
 #ifdef CONFIG_X86_32
 	.long	0				# data
 #endif
@@ -97,8 +100,8 @@ extra_header_fields:
 #else
 	.quad	0				# ImageBase
 #endif
-	.long	0x20				# SectionAlignment
-	.long	0x20				# FileAlignment
+	.long	salign				# SectionAlignment
+	.long	falign				# FileAlignment
 	.word	0				# MajorOperatingSystemVersion
 	.word	0				# MinorOperatingSystemVersion
 	.word	LINUX_EFISTUB_MAJOR_VERSION	# MajorImageVersion
@@ -107,9 +110,10 @@ extra_header_fields:
 	.word	0				# MinorSubsystemVersion
 	.long	0				# Win32VersionValue
 
-	.long	setup_size + ZO__end 		# SizeOfImage
+	.long	setup_size + ZO__end + pecompat_vsize
+						# SizeOfImage
 
-	.long	0x200				# SizeOfHeaders
+	.long	salign				# SizeOfHeaders
 	.long	0				# CheckSum
 	.word	IMAGE_SUBSYSTEM_EFI_APPLICATION	# Subsystem (EFI application)
 #ifdef CONFIG_EFI_DXE_MEM_ATTRIBUTES
@@ -140,44 +144,51 @@ extra_header_fields:
 
 	# Section table
 section_table:
-	#
-	# The offset & size fields are filled in by build.c.
-	#
 	.ascii	".setup"
 	.byte	0
 	.byte	0
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
-		IMAGE_SCN_MEM_EXECUTE		# Characteristics
+	.long	setup_size - salign 		# VirtualSize
+	.long	salign				# VirtualAddress
+	.long	pecompat_fstart - salign	# SizeOfRawData
+	.long	salign				# PointerToRawData
 
-#ifdef CONFIG_EFI_MIXED
-	#
-	# The offset & size fields are filled in by build.c.
-	#
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
+	.long	0, 0, 0
 	.long	IMAGE_SCN_CNT_INITIALIZED_DATA	| \
 		IMAGE_SCN_MEM_READ		| \
 		IMAGE_SCN_MEM_DISCARDABLE	# Characteristics
-#endif
 
+#ifdef CONFIG_EFI_MIXED
+	.asciz	".compat"
+
+	.long	8				# VirtualSize
+	.long	setup_size + ZO__end		# VirtualAddress
+	.long	pecompat_fsize			# SizeOfRawData
+	.long	pecompat_fstart			# PointerToRawData
+
+	.long	0, 0, 0
+	.long	IMAGE_SCN_CNT_INITIALIZED_DATA	| \
+		IMAGE_SCN_MEM_READ		| \
+		IMAGE_SCN_MEM_DISCARDABLE	# Characteristics
+
+	/*
+	 * Put the IA-32 machine type and the associated entry point address in
+	 * the .compat section, so loaders can figure out which other execution
+	 * modes this image supports.
+	 */
+	.pushsection ".pecompat", "a", @progbits
+	.balign	falign
+	.set	pecompat_vsize, salign
+	.globl	pecompat_fstart
+pecompat_fstart:
+	.byte	0x1				# version
+	.byte	8				# size
+	.word	IMAGE_FILE_MACHINE_I386		# PE machine type
+	.long	setup_size + ZO_efi32_pe_entry	# entrypoint
+	.popsection
+#else
+	.set	pecompat_vsize, 0
+	.set	pecompat_fstart, setup_size
+#endif
 	.ascii	".text"
 	.byte	0
 	.byte	0
diff --git a/arch/x86/boot/setup.ld b/arch/x86/boot/setup.ld
index f1c14616cd80390d..e44750db4b1f2e55 100644
--- a/arch/x86/boot/setup.ld
+++ b/arch/x86/boot/setup.ld
@@ -25,7 +25,8 @@ SECTIONS
 	.text32		: { *(.text32) }
 
 	. = ALIGN(16);
-	.rodata		: { *(.rodata*) }
+	.rodata		: { *(.pecompat) *(.rodata*) }
+	PROVIDE(pecompat_fsize = setup_size - pecompat_fstart);
 
 	.videocards	: {
 		video_cards = .;
diff --git a/arch/x86/boot/tools/build.c b/arch/x86/boot/tools/build.c
index 08065c333b482174..bc2585df100572bc 100644
--- a/arch/x86/boot/tools/build.c
+++ b/arch/x86/boot/tools/build.c
@@ -45,13 +45,6 @@ typedef unsigned int   u32;
 /* This must be large enough to hold the entire setup */
 u8 buf[(SETUP_SECT_NUM+1)*512];
 
-#ifdef CONFIG_EFI_MIXED
-#define PECOFF_COMPAT_RESERVE 0x20
-#else
-#define PECOFF_COMPAT_RESERVE 0x0
-#endif
-
-static unsigned long efi32_pe_entry;
 static unsigned long _edata;
 
 /*----------------------------------------------------------------------*/
@@ -138,85 +131,6 @@ static void usage(void)
 	die("Usage: build setup system zoffset.h image");
 }
 
-#ifdef CONFIG_EFI_STUB
-
-static void update_pecoff_section_header_fields(char *section_name, u32 vma, u32 size, u32 datasz, u32 offset)
-{
-	unsigned int pe_header;
-	unsigned short num_sections;
-	u8 *section;
-
-	pe_header = get_unaligned_le32(&buf[0x3c]);
-	num_sections = get_unaligned_le16(&buf[pe_header + 6]);
-
-#ifdef CONFIG_X86_32
-	section = &buf[pe_header + 0xa8];
-#else
-	section = &buf[pe_header + 0xb8];
-#endif
-
-	while (num_sections > 0) {
-		if (strncmp((char*)section, section_name, 8) == 0) {
-			/* section header size field */
-			put_unaligned_le32(size, section + 0x8);
-
-			/* section header vma field */
-			put_unaligned_le32(vma, section + 0xc);
-
-			/* section header 'size of initialised data' field */
-			put_unaligned_le32(datasz, section + 0x10);
-
-			/* section header 'file offset' field */
-			put_unaligned_le32(offset, section + 0x14);
-
-			break;
-		}
-		section += 0x28;
-		num_sections--;
-	}
-}
-
-static void update_pecoff_section_header(char *section_name, u32 offset, u32 size)
-{
-	update_pecoff_section_header_fields(section_name, offset, size, size, offset);
-}
-
-static void update_pecoff_setup(unsigned int size)
-{
-	u32 setup_offset = 0x200;
-	u32 compat_offset = size - PECOFF_COMPAT_RESERVE;
-	u32 setup_size = compat_offset - setup_offset;
-
-	update_pecoff_section_header(".setup", setup_offset, setup_size);
-
-#ifdef CONFIG_EFI_MIXED
-	update_pecoff_section_header(".compat", compat_offset, PECOFF_COMPAT_RESERVE);
-
-	/*
-	 * Put the IA-32 machine type (0x14c) and the associated entry point
-	 * address in the .compat section, so loaders can figure out which other
-	 * execution modes this image supports.
-	 */
-	buf[compat_offset] = 0x1;
-	buf[compat_offset + 1] = 0x8;
-	put_unaligned_le16(0x14c, &buf[compat_offset + 2]);
-	put_unaligned_le32(efi32_pe_entry + size, &buf[compat_offset + 4]);
-#endif
-}
-
-#else
-
-static inline void update_pecoff_setup(unsigned int size) {}
-
-#endif /* CONFIG_EFI_STUB */
-
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
@@ -245,7 +159,6 @@ static void parse_zoffset(char *fname)
 	p = (char *)buf;
 
 	while (p && *p) {
-		PARSE_ZOFS(p, efi32_pe_entry);
 		PARSE_ZOFS(p, _edata);
 
 		p = strchr(p, '\n');
@@ -285,8 +198,6 @@ int main(int argc, char ** argv)
 		die("Boot block hasn't got boot flag (0xAA55)");
 	fclose(file);
 
-	c += reserve_pecoff_compat_section(c);
-
 	/* Pad unused space with zeros */
 	setup_sectors = (c + 511) / 512;
 	if (setup_sectors > SETUP_SECT_NUM)
@@ -295,8 +206,6 @@ int main(int argc, char ** argv)
 	i = setup_sectors*512;
 	memset(buf+c, 0, i-c);
 
-	update_pecoff_setup(i);
-
 	/* Open and stat the kernel file */
 	fd = open(argv[2], O_RDONLY);
 	if (fd < 0)
-- 
2.39.2

