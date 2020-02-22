Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34956168FF0
	for <lists+linux-efi@lfdr.de>; Sat, 22 Feb 2020 16:56:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbgBVP4j (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 22 Feb 2020 10:56:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:38284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727230AbgBVP4j (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sat, 22 Feb 2020 10:56:39 -0500
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 021B92071E;
        Sat, 22 Feb 2020 15:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582386999;
        bh=b3QA5Fq14FDeuD2eCpur2e56WUI8cA6yX9c12b5NbVI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zCzuDzs8Cu+dVW6NFInz3xPsCbUh8YfrWKwKg5DiP2ldJCPXjG9pPICAB6TU8UhUY
         GECQXJJszCwNnEacmWIVgK7W/J4m8wqJuhrRdmsHoUUFQqRLhplWqxDN4hM3RTGMpi
         kVpUrhbj02Z2qmexFiQnh/rzbbaI+/jZjgzXbbss=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>, hdegoede@redhat.com,
        nivedita@alum.mit.edu, x86@kernel.org
Subject: [PATCH v3 2/6] efi/x86: Drop redundant .bss section
Date:   Sat, 22 Feb 2020 16:55:15 +0100
Message-Id: <20200222155519.23550-3-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200222155519.23550-1-ardb@kernel.org>
References: <20200222155519.23550-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

In commit

  c7fb93ec51d462ec ("x86/efi: Include a .bss section within the PE/COFF headers")

we added a separate .bss section to the PE/COFF header of the compressed
kernel describing the static memory footprint of the decompressor, to
ensure that it has enough headroom to decompress itself.

We can achieve the exact same result by increasing the virtual size of
the .text section, without changing the raw size, which, as per the
PE/COFF specification, requires the loader to zero initialize the delta.

Doing so frees up a slot in the section table, which we will use later
to describe the mixed mode entrypoint.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/header.S      | 21 +-----------
 arch/x86/boot/tools/build.c | 36 +++++++-------------
 2 files changed, 13 insertions(+), 44 deletions(-)

diff --git a/arch/x86/boot/header.S b/arch/x86/boot/header.S
index 97d9b6d6c1af..d59f6604bb42 100644
--- a/arch/x86/boot/header.S
+++ b/arch/x86/boot/header.S
@@ -106,7 +106,7 @@ coff_header:
 #else
 	.word	0x8664				# x86-64
 #endif
-	.word	4				# nr_sections
+	.word	3				# nr_sections
 	.long	0 				# TimeDateStamp
 	.long	0				# PointerToSymbolTable
 	.long	1				# NumberOfSymbols
@@ -248,25 +248,6 @@ section_table:
 	.word	0				# NumberOfLineNumbers
 	.long	0x60500020			# Characteristics (section flags)
 
-	#
-	# The offset & size fields are filled in by build.c.
-	#
-	.ascii	".bss"
-	.byte	0
-	.byte	0
-	.byte	0
-	.byte	0
-	.long	0
-	.long	0x0
-	.long	0				# Size of initialized data
-						# on disk
-	.long	0x0
-	.long	0				# PointerToRelocations
-	.long	0				# PointerToLineNumbers
-	.word	0				# NumberOfRelocations
-	.word	0				# NumberOfLineNumbers
-	.long	0xc8000080			# Characteristics (section flags)
-
 #endif /* CONFIG_EFI_STUB */
 
 	# Kernel attributes; used by setup.  This is part 1 of the
diff --git a/arch/x86/boot/tools/build.c b/arch/x86/boot/tools/build.c
index c08db2ee4ba2..f9f5761c5d05 100644
--- a/arch/x86/boot/tools/build.c
+++ b/arch/x86/boot/tools/build.c
@@ -203,10 +203,12 @@ static void update_pecoff_setup_and_reloc(unsigned int size)
 	put_unaligned_le32(10, &buf[reloc_offset + 4]);
 }
 
-static void update_pecoff_text(unsigned int text_start, unsigned int file_sz)
+static void update_pecoff_text(unsigned int text_start, unsigned int file_sz,
+			       unsigned int init_sz)
 {
 	unsigned int pe_header;
 	unsigned int text_sz = file_sz - text_start;
+	unsigned int bss_sz = init_sz + text_start - file_sz;
 
 	pe_header = get_unaligned_le32(&buf[0x3c]);
 
@@ -214,30 +216,18 @@ static void update_pecoff_text(unsigned int text_start, unsigned int file_sz)
 	 * Size of code: Subtract the size of the first sector (512 bytes)
 	 * which includes the header.
 	 */
-	put_unaligned_le32(file_sz - 512, &buf[pe_header + 0x1c]);
+	put_unaligned_le32(file_sz - 512 + bss_sz, &buf[pe_header + 0x1c]);
+
+	/* Size of image */
+	put_unaligned_le32(init_sz + text_start, &buf[pe_header + 0x50]);
 
 	/*
 	 * Address of entry point for PE/COFF executable
 	 */
 	put_unaligned_le32(text_start + efi_pe_entry, &buf[pe_header + 0x28]);
 
-	update_pecoff_section_header(".text", text_start, text_sz);
-}
-
-static void update_pecoff_bss(unsigned int file_sz, unsigned int init_sz)
-{
-	unsigned int pe_header;
-	unsigned int bss_sz = init_sz - file_sz;
-
-	pe_header = get_unaligned_le32(&buf[0x3c]);
-
-	/* Size of uninitialized data */
-	put_unaligned_le32(bss_sz, &buf[pe_header + 0x24]);
-
-	/* Size of image */
-	put_unaligned_le32(init_sz, &buf[pe_header + 0x50]);
-
-	update_pecoff_section_header_fields(".bss", file_sz, bss_sz, 0, 0);
+	update_pecoff_section_header_fields(".text", text_start, text_sz + bss_sz,
+					    text_sz, text_start);
 }
 
 static int reserve_pecoff_reloc_section(int c)
@@ -278,9 +268,8 @@ static void efi_stub_entry_update(void)
 
 static inline void update_pecoff_setup_and_reloc(unsigned int size) {}
 static inline void update_pecoff_text(unsigned int text_start,
-				      unsigned int file_sz) {}
-static inline void update_pecoff_bss(unsigned int file_sz,
-				     unsigned int init_sz) {}
+				      unsigned int file_sz,
+				      unsigned int init_sz) {}
 static inline void efi_stub_defaults(void) {}
 static inline void efi_stub_entry_update(void) {}
 
@@ -406,9 +395,8 @@ int main(int argc, char ** argv)
 	buf[0x1f1] = setup_sectors-1;
 	put_unaligned_le32(sys_size, &buf[0x1f4]);
 
-	update_pecoff_text(setup_sectors * 512, i + (sys_size * 16));
 	init_sz = get_unaligned_le32(&buf[0x260]);
-	update_pecoff_bss(i + (sys_size * 16), init_sz + setup_sectors * 512);
+	update_pecoff_text(setup_sectors * 512, i + (sys_size * 16), init_sz);
 
 	efi_stub_entry_update();
 
-- 
2.17.1

