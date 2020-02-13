Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F2E715C0D5
	for <lists+linux-efi@lfdr.de>; Thu, 13 Feb 2020 15:59:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727347AbgBMO7z (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 13 Feb 2020 09:59:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:41538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726968AbgBMO7z (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 13 Feb 2020 09:59:55 -0500
Received: from cam-smtp0.cambridge.arm.com (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B4AE2082F;
        Thu, 13 Feb 2020 14:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581605994;
        bh=tP/nrC7vqmTYk59YGXGbjbDeHTY+3bz/+I3O4muIg1Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jmCmL6S+RZ4t0UJu/CDPzcpFn1jwmsGuhH6HHICJm8ZHRPFEunNaSXg0GWXeJDrg3
         CrnMEkDW1H/XZvkaI4ZdIxIfnGfmdIQz9rEo5UClNBLsqpSjyEfFd2iUjqjYVBOP6f
         PEu1N2G3zp+KDbUwcqNAtzuGr5slHjzqi4pRHNtw=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Ard Biesheuvel <ardb@kernel.org>, lersek@redhat.com,
        leif@nuviainc.com, pjones@redhat.com, mjg59@google.com,
        agraf@csgraf.de, daniel.kiper@oracle.com, hdegoede@redhat.com,
        nivedita@alum.mit.edu, mbrown@fensystems.co.uk, mingo@kernel.org
Subject: [RFC PATCH 2/3] efi/x86: add true mixed mode entry point into .compat section
Date:   Thu, 13 Feb 2020 15:59:27 +0100
Message-Id: <20200213145928.7047-3-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200213145928.7047-1-ardb@kernel.org>
References: <20200213145928.7047-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Currently, mixed mode is closely tied to the EFI handover protocol
and relies on intimate knowledge of the bootparams structure, setup
header etc, all of which are rather byzantine and entirely specific
to x86.

Even though no other EFI supported architectures are currently known
that could support something like mixed mode, it makes sense to
abstract a bit from this, and make it part of a generic Linux on EFI
boot protocol.

To that end, add a .compat section to the mixed mode binary, and populate
it with the PE machine type and entry point address, allowing firmware
implementations to match it to their native machine type, and invoke
non-native binaries using a secondary entry point.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/Makefile      |  2 +-
 arch/x86/boot/header.S      | 20 +++++++++++-
 arch/x86/boot/tools/build.c | 32 +++++++++++++++++++-
 3 files changed, 51 insertions(+), 3 deletions(-)

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
index d59f6604bb42..76a485013771 100644
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
+	.long	0x60500020			# Characteristics (section flags)
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
index 0c8c5a52f1f0..707b979566ca 100644
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
 
@@ -189,7 +196,8 @@ static void update_pecoff_section_header(char *section_name, u32 offset, u32 siz
 static void update_pecoff_setup_and_reloc(unsigned int size)
 {
 	u32 setup_offset = 0x200;
-	u32 reloc_offset = size - PECOFF_RELOC_RESERVE;
+	u32 reloc_offset = size - PECOFF_RELOC_RESERVE - PECOFF_COMPAT_RESERVE;
+	u32 compat_offset = reloc_offset + PECOFF_RELOC_RESERVE;
 	u32 setup_size = reloc_offset - setup_offset;
 
 	update_pecoff_section_header(".setup", setup_offset, setup_size);
@@ -201,6 +209,20 @@ static void update_pecoff_setup_and_reloc(unsigned int size)
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
@@ -282,6 +304,12 @@ static inline int reserve_pecoff_reloc_section(int c)
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
@@ -314,6 +342,7 @@ static void parse_zoffset(char *fname)
 		PARSE_ZOFS(p, efi32_stub_entry);
 		PARSE_ZOFS(p, efi64_stub_entry);
 		PARSE_ZOFS(p, efi_pe_entry);
+		PARSE_ZOFS(p, efi32_pe_entry);
 		PARSE_ZOFS(p, kernel_info);
 		PARSE_ZOFS(p, startup_64);
 
@@ -357,6 +386,7 @@ int main(int argc, char ** argv)
 		die("Boot block hasn't got boot flag (0xAA55)");
 	fclose(file);
 
+	c += reserve_pecoff_compat_section(c);
 	c += reserve_pecoff_reloc_section(c);
 
 	/* Pad unused space with zeros */
-- 
2.17.1

