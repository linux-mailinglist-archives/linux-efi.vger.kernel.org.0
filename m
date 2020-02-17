Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9288161504
	for <lists+linux-efi@lfdr.de>; Mon, 17 Feb 2020 15:48:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728862AbgBQOsk (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 17 Feb 2020 09:48:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:58252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728723AbgBQOsk (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 17 Feb 2020 09:48:40 -0500
Received: from cam-smtp0.cambridge.arm.com (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B530820801;
        Mon, 17 Feb 2020 14:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581950919;
        bh=e6ZG+E976AIhWjAK1TIlokoW6bwBMK6XlYeJMhOh7Ds=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZOLTPU5KKQi1DP0HbQUf/DAbHo5bC24rT2C+IotZ9lr7BrxvvcIE9+GVeSxMNd0Pd
         niFXhbx3UIpldVxWeJFFV10gJvCnIHDuVBxEbjEaqcQJgwnCGUtli8eccOaf0Qvr9F
         2RMGKsNHpgtixp67Kolt3TmOwrkWcYrV+SUpb/Z0=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>, lersek@redhat.com,
        leif@nuviainc.com, pjones@redhat.com, mjg59@google.com,
        agraf@csgraf.de, daniel.kiper@oracle.com, hdegoede@redhat.com,
        nivedita@alum.mit.edu, mingo@kernel.org
Subject: [PATCH v2 1/5] efi/x86: Drop redundant .bss section
Date:   Mon, 17 Feb 2020 15:48:18 +0100
Message-Id: <20200217144822.24616-2-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200217144822.24616-1-ardb@kernel.org>
References: <20200217144822.24616-1-ardb@kernel.org>
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
 arch/x86/boot/tools/build.c | 35 ++++++++------------
 2 files changed, 14 insertions(+), 42 deletions(-)

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
index 55e669d29e54..0c8c5a52f1f0 100644
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
+	unsigned int bss_sz = init_sz - file_sz;
 
 	pe_header = get_unaligned_le32(&buf[0x3c]);
 
@@ -216,28 +218,19 @@ static void update_pecoff_text(unsigned int text_start, unsigned int file_sz)
 	 */
 	put_unaligned_le32(file_sz - 512, &buf[pe_header + 0x1c]);
 
-	/*
-	 * Address of entry point for PE/COFF executable
-	 */
-	put_unaligned_le32(text_start + efi_pe_entry, &buf[pe_header + 0x28]);
-
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
 	/* Size of uninitialized data */
 	put_unaligned_le32(bss_sz, &buf[pe_header + 0x24]);
 
 	/* Size of image */
 	put_unaligned_le32(init_sz, &buf[pe_header + 0x50]);
 
-	update_pecoff_section_header_fields(".bss", file_sz, bss_sz, 0, 0);
+	/*
+	 * Address of entry point for PE/COFF executable
+	 */
+	put_unaligned_le32(text_start + efi_pe_entry, &buf[pe_header + 0x28]);
+
+	update_pecoff_section_header_fields(".text", text_start, text_sz + bss_sz,
+					    text_sz, text_start);
 }
 
 static int reserve_pecoff_reloc_section(int c)
@@ -278,9 +271,8 @@ static void efi_stub_entry_update(void)
 
 static inline void update_pecoff_setup_and_reloc(unsigned int size) {}
 static inline void update_pecoff_text(unsigned int text_start,
-				      unsigned int file_sz) {}
-static inline void update_pecoff_bss(unsigned int file_sz,
-				     unsigned int init_sz) {}
+				      unsigned int file_sz,
+				      unsigned int init_sz) {}
 static inline void efi_stub_defaults(void) {}
 static inline void efi_stub_entry_update(void) {}
 
@@ -406,9 +398,8 @@ int main(int argc, char ** argv)
 	buf[0x1f1] = setup_sectors-1;
 	put_unaligned_le32(sys_size, &buf[0x1f4]);
 
-	update_pecoff_text(setup_sectors * 512, i + (sys_size * 16));
 	init_sz = get_unaligned_le32(&buf[0x260]);
-	update_pecoff_bss(i + (sys_size * 16), init_sz);
+	update_pecoff_text(setup_sectors * 512, i + (sys_size * 16), init_sz);
 
 	efi_stub_entry_update();
 
-- 
2.17.1

