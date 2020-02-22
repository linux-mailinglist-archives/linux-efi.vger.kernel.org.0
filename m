Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3DA5168FF4
	for <lists+linux-efi@lfdr.de>; Sat, 22 Feb 2020 16:56:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727834AbgBVP4q (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 22 Feb 2020 10:56:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:38396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727681AbgBVP4p (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sat, 22 Feb 2020 10:56:45 -0500
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF60520702;
        Sat, 22 Feb 2020 15:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582387005;
        bh=S/adx8ss8yYRmxdZJn+OYeBxFBzzhcJY6BQWelF0N2Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KuII7ZtHCXauBraW1Jv42y4K/jUALtI6D8WRzuprFU6a4old0U5buizLw+ZULynh8
         dm1wkdzVNTT3OiByYNJXR/+KdscBJ70lVyyDUnKJohXYxcQvCv8Tm4WOIOS/ESrfU2
         cx5RZ9WDZUEfJw+Qse24M7SLb877J9dCJOCgofeQ=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>, hdegoede@redhat.com,
        nivedita@alum.mit.edu, x86@kernel.org
Subject: [PATCH v3 6/6] efi/x86: Add true mixed mode entry point into .compat section
Date:   Sat, 22 Feb 2020 16:55:19 +0100
Message-Id: <20200222155519.23550-7-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200222155519.23550-1-ardb@kernel.org>
References: <20200222155519.23550-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Currently, mixed mode is closely tied to the EFI handover protocol
and relies on intimate knowledge of the bootparams structure, setup
header etc, all of which are rather byzantine and entirely specific
to x86.

Even though no other EFI supported architectures are currently known
that could support something like mixed mode, it still makes sense to
abstract a bit from this, and make it part of a generic Linux on EFI
boot protocol.

To that end, add a .compat section to the mixed mode binary, and populate
it with the PE machine type and entry point address, allowing firmware
implementations to match it to their native machine type, and invoke
non-native binaries using a secondary entry point.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/Makefile      |  2 +-
 arch/x86/boot/header.S      | 20 +++++++-
 arch/x86/boot/tools/build.c | 50 +++++++++++++++++++-
 3 files changed, 69 insertions(+), 3 deletions(-)

diff --git a/arch/x86/boot/Makefile b/arch/x86/boot/Makefile
index 012b82fc8617..ef9e1f2c836c 100644
--- a/arch/x86/boot/Makefile
+++ b/arch/x86/boot/Makefile
@@ -88,7 +88,7 @@ $(obj)/vmlinux.bin: $(obj)/compressed/vmlinux FORCE
 
 SETUP_OBJS = $(addprefix $(obj)/,$(setup-y))
 
-sed-zoffset := -e 's/^\([0-9a-fA-F]*\) [a-zA-Z] \(startup_32\|startup_64\|efi32_stub_entry\|efi64_stub_entry\|efi_pe_entry\|input_data\|kernel_info\|_end\|_ehead\|_text\|z_.*\)$$/\#define ZO_\2 0x\1/p'
+sed-zoffset := -e 's/^\([0-9a-fA-F]*\) [a-zA-Z] \(startup_32\|startup_64\|efi32_stub_entry\|efi64_stub_entry\|efi_pe_entry\|efi32_pe_entry\|input_data\|kernel_info\|_end\|_ehead\|_text\|z_.*\)$$/\#define ZO_\2 0x\1/p'
 
 quiet_cmd_zoffset = ZOFFSET $@
       cmd_zoffset = $(NM) $< | sed -n $(sed-zoffset) > $@
diff --git a/arch/x86/boot/header.S b/arch/x86/boot/header.S
index d59f6604bb42..44aeb63ca6ae 100644
--- a/arch/x86/boot/header.S
+++ b/arch/x86/boot/header.S
@@ -106,7 +106,7 @@ coff_header:
 #else
 	.word	0x8664				# x86-64
 #endif
-	.word	3				# nr_sections
+	.word	section_count			# nr_sections
 	.long	0 				# TimeDateStamp
 	.long	0				# PointerToSymbolTable
 	.long	1				# NumberOfSymbols
@@ -230,6 +230,23 @@ section_table:
 	.word	0				# NumberOfLineNumbers
 	.long	0x42100040			# Characteristics (section flags)
 
+#ifdef CONFIG_EFI_MIXED
+	#
+	# The offset & size fields are filled in by build.c.
+	#
+	.asciz	".compat"
+	.long	0
+	.long	0x0
+	.long	0				# Size of initialized data
+						# on disk
+	.long	0x0
+	.long	0				# PointerToRelocations
+	.long	0				# PointerToLineNumbers
+	.word	0				# NumberOfRelocations
+	.word	0				# NumberOfLineNumbers
+	.long	0x42100040			# Characteristics (section flags)
+#endif
+
 	#
 	# The offset & size fields are filled in by build.c.
 	#
@@ -248,6 +265,7 @@ section_table:
 	.word	0				# NumberOfLineNumbers
 	.long	0x60500020			# Characteristics (section flags)
 
+	.set	section_count, (. - section_table) / 40
 #endif /* CONFIG_EFI_STUB */
 
 	# Kernel attributes; used by setup.  This is part 1 of the
diff --git a/arch/x86/boot/tools/build.c b/arch/x86/boot/tools/build.c
index f9f5761c5d05..90d403dfec80 100644
--- a/arch/x86/boot/tools/build.c
+++ b/arch/x86/boot/tools/build.c
@@ -53,9 +53,16 @@ u8 buf[SETUP_SECT_MAX*512];
 
 #define PECOFF_RELOC_RESERVE 0x20
 
+#ifdef CONFIG_EFI_MIXED
+#define PECOFF_COMPAT_RESERVE 0x20
+#else
+#define PECOFF_COMPAT_RESERVE 0x0
+#endif
+
 unsigned long efi32_stub_entry;
 unsigned long efi64_stub_entry;
 unsigned long efi_pe_entry;
+unsigned long efi32_pe_entry;
 unsigned long kernel_info;
 unsigned long startup_64;
 
@@ -189,7 +196,10 @@ static void update_pecoff_section_header(char *section_name, u32 offset, u32 siz
 static void update_pecoff_setup_and_reloc(unsigned int size)
 {
 	u32 setup_offset = 0x200;
-	u32 reloc_offset = size - PECOFF_RELOC_RESERVE;
+	u32 reloc_offset = size - PECOFF_RELOC_RESERVE - PECOFF_COMPAT_RESERVE;
+#ifdef CONFIG_EFI_MIXED
+	u32 compat_offset = reloc_offset + PECOFF_RELOC_RESERVE;
+#endif
 	u32 setup_size = reloc_offset - setup_offset;
 
 	update_pecoff_section_header(".setup", setup_offset, setup_size);
@@ -201,6 +211,20 @@ static void update_pecoff_setup_and_reloc(unsigned int size)
 	 */
 	put_unaligned_le32(reloc_offset + 10, &buf[reloc_offset]);
 	put_unaligned_le32(10, &buf[reloc_offset + 4]);
+
+#ifdef CONFIG_EFI_MIXED
+	update_pecoff_section_header(".compat", compat_offset, PECOFF_COMPAT_RESERVE);
+
+	/*
+	 * Put the IA-32 machine type (0x14c) and the associated entry point
+	 * address in the .compat section, so loaders can figure out which other
+	 * execution modes this image supports.
+	 */
+	buf[compat_offset] = 0x1;
+	buf[compat_offset + 1] = 0x8;
+	put_unaligned_le16(0x14c, &buf[compat_offset + 2]);
+	put_unaligned_le32(efi32_pe_entry + size, &buf[compat_offset + 4]);
+#endif
 }
 
 static void update_pecoff_text(unsigned int text_start, unsigned int file_sz,
@@ -212,6 +236,22 @@ static void update_pecoff_text(unsigned int text_start, unsigned int file_sz,
 
 	pe_header = get_unaligned_le32(&buf[0x3c]);
 
+#ifdef CONFIG_EFI_MIXED
+	/*
+	 * In mixed mode, we will execute startup_32() at whichever offset in
+	 * memory it happened to land when the PE/COFF loader loaded the image,
+	 * which may be misaligned with respect to the kernel_alignment field
+	 * in the setup header.
+	 *
+	 * In order for startup_32 to safely execute in place at this offset,
+	 * we need to ensure that the CONFIG_PHYSICAL_ALIGN aligned allocation
+	 * it creates for the page tables does not extend beyond the declared
+	 * size of the image in the PE/COFF header. So add the required slack.
+	 */
+	bss_sz	+= CONFIG_PHYSICAL_ALIGN;
+	init_sz	+= CONFIG_PHYSICAL_ALIGN;
+#endif
+
 	/*
 	 * Size of code: Subtract the size of the first sector (512 bytes)
 	 * which includes the header.
@@ -279,6 +319,12 @@ static inline int reserve_pecoff_reloc_section(int c)
 }
 #endif /* CONFIG_EFI_STUB */
 
+static int reserve_pecoff_compat_section(int c)
+{
+	/* Reserve 0x20 bytes for .compat section */
+	memset(buf+c, 0, PECOFF_COMPAT_RESERVE);
+	return PECOFF_COMPAT_RESERVE;
+}
 
 /*
  * Parse zoffset.h and find the entry points. We could just #include zoffset.h
@@ -311,6 +357,7 @@ static void parse_zoffset(char *fname)
 		PARSE_ZOFS(p, efi32_stub_entry);
 		PARSE_ZOFS(p, efi64_stub_entry);
 		PARSE_ZOFS(p, efi_pe_entry);
+		PARSE_ZOFS(p, efi32_pe_entry);
 		PARSE_ZOFS(p, kernel_info);
 		PARSE_ZOFS(p, startup_64);
 
@@ -354,6 +401,7 @@ int main(int argc, char ** argv)
 		die("Boot block hasn't got boot flag (0xAA55)");
 	fclose(file);
 
+	c += reserve_pecoff_compat_section(c);
 	c += reserve_pecoff_reloc_section(c);
 
 	/* Pad unused space with zeros */
-- 
2.17.1

