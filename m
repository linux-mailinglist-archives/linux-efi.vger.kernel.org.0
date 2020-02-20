Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18EA6165C6B
	for <lists+linux-efi@lfdr.de>; Thu, 20 Feb 2020 12:07:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbgBTLHH (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 20 Feb 2020 06:07:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:48178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726859AbgBTLHH (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 20 Feb 2020 06:07:07 -0500
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B27924672;
        Thu, 20 Feb 2020 11:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582196826;
        bh=FRMTHo7T349DVdMwUokPuEPsZ76xwOKyQynxYcIHiSA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o0kYhdXvy6JbWud+sa70aB53LbpW60+lnj2r2j5sOfW7uTLYr8EOAidCc8gNSUQ5J
         59+iDtG5WhGoaHqWwjx+LFkl2eSNlKa4g0tAdv8toebHitdmxBCC2RHEwgQQPu3fyr
         RNNmTCBJY6PbK3OdE3EWzfe68Xou/pKJ282TmFO0=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>, lersek@redhat.com,
        leif@nuviainc.com, pjones@redhat.com, mjg59@google.com,
        agraf@csgraf.de, ilias.apalodimas@linaro.org, xypron.glpk@gmx.de,
        daniel.kiper@oracle.com, nivedita@alum.mit.edu,
        James.Bottomley@hansenpartnership.com
Subject: [RFC PATCH 1/3] efi/x86: Use symbolic constants in PE header instead of bare numbers
Date:   Thu, 20 Feb 2020 12:06:47 +0100
Message-Id: <20200220110649.1303-2-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200220110649.1303-1-ardb@kernel.org>
References: <20200220110649.1303-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Replace bare numbers in the PE/COFF header structure with symbolic
constants so they become self documenting.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/header.S | 60 ++++++++++----------
 1 file changed, 31 insertions(+), 29 deletions(-)

diff --git a/arch/x86/boot/header.S b/arch/x86/boot/header.S
index 44aeb63ca6ae..9110b58aa2ec 100644
--- a/arch/x86/boot/header.S
+++ b/arch/x86/boot/header.S
@@ -15,7 +15,7 @@
  * hex while segment addresses are written as segment:offset.
  *
  */
-
+#include <linux/pe.h>
 #include <asm/segment.h>
 #include <asm/boot.h>
 #include <asm/page_types.h>
@@ -43,8 +43,7 @@ SYSSEG		= 0x1000		/* historical load address >> 4 */
 bootsect_start:
 #ifdef CONFIG_EFI_STUB
 	# "MZ", MS-DOS header
-	.byte 0x4d
-	.byte 0x5a
+	.word	MZ_MAGIC
 #endif
 
 	# Normalize the start address
@@ -97,39 +96,30 @@ bugger_off_msg:
 
 #ifdef CONFIG_EFI_STUB
 pe_header:
-	.ascii	"PE"
-	.word 	0
+	.long	PE_MAGIC
 
 coff_header:
 #ifdef CONFIG_X86_32
-	.word	0x14c				# i386
+	.set	image_file_add_flags, IMAGE_FILE_32BIT_MACHINE
+	.set	pe_opt_magic, PE_OPT_MAGIC_PE32
+	.word	IMAGE_FILE_MACHINE_I386
 #else
-	.word	0x8664				# x86-64
+	.set	image_file_add_flags, 0
+	.set	pe_opt_magic, PE_OPT_MAGIC_PE32PLUS
+	.word	IMAGE_FILE_MACHINE_AMD64
 #endif
 	.word	section_count			# nr_sections
 	.long	0 				# TimeDateStamp
 	.long	0				# PointerToSymbolTable
 	.long	1				# NumberOfSymbols
 	.word	section_table - optional_header	# SizeOfOptionalHeader
-#ifdef CONFIG_X86_32
-	.word	0x306				# Characteristics.
-						# IMAGE_FILE_32BIT_MACHINE |
-						# IMAGE_FILE_DEBUG_STRIPPED |
-						# IMAGE_FILE_EXECUTABLE_IMAGE |
-						# IMAGE_FILE_LINE_NUMS_STRIPPED
-#else
-	.word	0x206				# Characteristics
-						# IMAGE_FILE_DEBUG_STRIPPED |
-						# IMAGE_FILE_EXECUTABLE_IMAGE |
-						# IMAGE_FILE_LINE_NUMS_STRIPPED
-#endif
+	.word	IMAGE_FILE_EXECUTABLE_IMAGE	| \
+		image_file_add_flags		| \
+		IMAGE_FILE_DEBUG_STRIPPED	| \
+		IMAGE_FILE_LINE_NUMS_STRIPPED	# Characteristics
 
 optional_header:
-#ifdef CONFIG_X86_32
-	.word	0x10b				# PE32 format
-#else
-	.word	0x20b 				# PE32+ format
-#endif
+	.word	pe_opt_magic
 	.byte	0x02				# MajorLinkerVersion
 	.byte	0x14				# MinorLinkerVersion
 
@@ -170,7 +160,7 @@ extra_header_fields:
 
 	.long	0x200				# SizeOfHeaders
 	.long	0				# CheckSum
-	.word	0xa				# Subsystem (EFI application)
+	.word	IMAGE_SUBSYSTEM_EFI_APPLICATION	# Subsystem (EFI application)
 	.word	0				# DllCharacteristics
 #ifdef CONFIG_X86_32
 	.long	0				# SizeOfStackReserve
@@ -210,7 +200,10 @@ section_table:
 	.long	0				# PointerToLineNumbers
 	.word	0				# NumberOfRelocations
 	.word	0				# NumberOfLineNumbers
-	.long	0x60500020			# Characteristics (section flags)
+	.long	IMAGE_SCN_CNT_CODE		| \
+		IMAGE_SCN_MEM_READ		| \
+		IMAGE_SCN_MEM_EXECUTE		| \
+		IMAGE_SCN_ALIGN_16BYTES		# Characteristics
 
 	#
 	# The EFI application loader requires a relocation section
@@ -228,7 +221,10 @@ section_table:
 	.long	0				# PointerToLineNumbers
 	.word	0				# NumberOfRelocations
 	.word	0				# NumberOfLineNumbers
-	.long	0x42100040			# Characteristics (section flags)
+	.long	IMAGE_SCN_CNT_INITIALIZED_DATA	| \
+		IMAGE_SCN_MEM_READ		| \
+		IMAGE_SCN_MEM_DISCARDABLE	| \
+		IMAGE_SCN_ALIGN_1BYTES		# Characteristics
 
 #ifdef CONFIG_EFI_MIXED
 	#
@@ -244,7 +240,10 @@ section_table:
 	.long	0				# PointerToLineNumbers
 	.word	0				# NumberOfRelocations
 	.word	0				# NumberOfLineNumbers
-	.long	0x42100040			# Characteristics (section flags)
+	.long	IMAGE_SCN_CNT_INITIALIZED_DATA	| \
+		IMAGE_SCN_MEM_READ		| \
+		IMAGE_SCN_MEM_DISCARDABLE	| \
+		IMAGE_SCN_ALIGN_1BYTES		# Characteristics
 #endif
 
 	#
@@ -263,7 +262,10 @@ section_table:
 	.long	0				# PointerToLineNumbers
 	.word	0				# NumberOfRelocations
 	.word	0				# NumberOfLineNumbers
-	.long	0x60500020			# Characteristics (section flags)
+	.long	IMAGE_SCN_CNT_CODE		| \
+		IMAGE_SCN_MEM_READ		| \
+		IMAGE_SCN_MEM_EXECUTE		| \
+		IMAGE_SCN_ALIGN_16BYTES		# Characteristics
 
 	.set	section_count, (. - section_table) / 40
 #endif /* CONFIG_EFI_STUB */
-- 
2.17.1

