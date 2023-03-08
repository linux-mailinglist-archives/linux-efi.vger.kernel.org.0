Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC4406B12F7
	for <lists+linux-efi@lfdr.de>; Wed,  8 Mar 2023 21:22:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbjCHUWw (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 8 Mar 2023 15:22:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbjCHUWg (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 8 Mar 2023 15:22:36 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FC8ABA872
        for <linux-efi@vger.kernel.org>; Wed,  8 Mar 2023 12:22:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BFB7561950
        for <linux-efi@vger.kernel.org>; Wed,  8 Mar 2023 20:22:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD344C4339C;
        Wed,  8 Mar 2023 20:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678306943;
        bh=0juUXy0df482JH4lIEAY7gEdDq8jVmiq8d7bK9CqF/A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PfHUHuzOWL6lVGf/cAwOnusDACBgDiiiYuhuOPWOJXgtprKiGghQ31wjtKFlEaJqF
         qUxqC8PclAzsNRpkl31DF8ZxztXlN1/XvIzGP4e02H8dDYOQO2LaJfshEJyhSMhSCb
         GTdiwVo829PLeGOCTz+WUZJ073UHo63dln8SODkttugEpcTW9ade75fD9Xf/vrTODJ
         xUzg6ULJL6aG5sXeSa+OFHGGHoa/RpO4rnE4/CcgGCETlNdcEMYuVev/BkkNO8QKcO
         uNPyb4l1EJJVDQZW0pCJ6LqtNl0vhonBTRAUHVoil2QZ6FMrJ/uD6/PdztUQKGwMpA
         fjTmAJHn2Y24A==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Evgeniy Baskov <baskov@ispras.ru>,
        Borislav Petkov <bp@alien8.de>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Peter Jones <pjones@redhat.com>,
        "Limonciello, Mario" <mario.limonciello@amd.com>
Subject: [RFC PATCH 2/4] efi: x86: Move PE header after setup header
Date:   Wed,  8 Mar 2023 21:22:07 +0100
Message-Id: <20230308202209.2980947-3-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230308202209.2980947-1-ardb@kernel.org>
References: <20230308202209.2980947-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5016; i=ardb@kernel.org; h=from:subject; bh=0juUXy0df482JH4lIEAY7gEdDq8jVmiq8d7bK9CqF/A=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIYXjXf7vzSwPJcs639hfCBN3lTpzd/kr4+Ms86z+dXneW F99IvxPRykLgxgHg6yYIovA7L/vdp6eKFXrPEsWZg4rE8gQBi5OAZjIJGmG/zVcLyMcD23Yktu4 /Jhlp+akqmerhIumFe2dG+OsVCjxyo+RoS/+9WF3VpV3smZfVnedvxdw7724nYTMN1mrx2KJgjK 3WAA=
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

We are currently limited in the number of PE/COFF sections we can
describe in the PE header, due to lack of space. This is caused by the
presence of the setup header at offset 0x1f1, leaving only the space
before it for PE metadata.

However, now that we no longer copy the setup_header from this part of
the image for use by the EFI stub, we no longer have to describe it as
part of the loadable image. This means we can put the PE header *after*
the setup header, and use as much space as we like. It also means we
don't have to describe this part of the image in PE/COFF, and simply
treat it as part of the header. This means we can drop the ".setup"
section as well.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/header.S      | 26 +++-----------------
 arch/x86/boot/setup.ld      |  1 +
 arch/x86/boot/tools/build.c | 11 +++------
 3 files changed, 9 insertions(+), 29 deletions(-)

diff --git a/arch/x86/boot/header.S b/arch/x86/boot/header.S
index 9338c68e7413d6e6..aba499404d8b870e 100644
--- a/arch/x86/boot/header.S
+++ b/arch/x86/boot/header.S
@@ -85,7 +85,7 @@ bs_die:
 	# Offset to the PE header.
 	#
 	.long	LINUX_PE_MAGIC
-	.long	pe_header
+	.long	pe_header - bootsect_start
 #endif /* CONFIG_EFI_STUB */
 
 	.section ".bsdata", "a"
@@ -96,6 +96,8 @@ bugger_off_msg:
 	.byte	0
 
 #ifdef CONFIG_EFI_STUB
+	.section ".peheader", "a"
+	.align 8
 pe_header:
 	.long	PE_MAGIC
 
@@ -161,7 +163,7 @@ extra_header_fields:
 	#
 	.long	0				# SizeOfImage
 
-	.long	0x200				# SizeOfHeaders
+	.long	0x800				# SizeOfHeaders
 	.long	0				# CheckSum
 	.word	IMAGE_SUBSYSTEM_EFI_APPLICATION	# Subsystem (EFI application)
 #ifdef CONFIG_EFI_DXE_MEM_ATTRIBUTES
@@ -192,26 +194,6 @@ extra_header_fields:
 
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
diff --git a/arch/x86/boot/setup.ld b/arch/x86/boot/setup.ld
index 49546c247ae25e97..5981287bbcb7f439 100644
--- a/arch/x86/boot/setup.ld
+++ b/arch/x86/boot/setup.ld
@@ -16,6 +16,7 @@ SECTIONS
 	. = 495;
 	.header		: { *(.header) }
 	.entrytext	: { *(.entrytext) }
+	.peheader	: { *(.peheader) }
 	.inittext	: { *(.inittext) }
 	.initdata	: { *(.initdata) }
 	__end_init = .;
diff --git a/arch/x86/boot/tools/build.c b/arch/x86/boot/tools/build.c
index e6fd09789482ed04..883e6359221cd588 100644
--- a/arch/x86/boot/tools/build.c
+++ b/arch/x86/boot/tools/build.c
@@ -296,16 +296,13 @@ static void update_pecoff_section_header(char *section_name, uint32_t offset, ui
 	update_pecoff_section_header_fields(section_name, offset, size, size, offset);
 }
 
-static void update_pecoff_setup_and_reloc(unsigned int size)
+static void update_pecoff_reloc(unsigned int size)
 {
-	uint32_t setup_offset = SECTOR_SIZE;
 	uint32_t reloc_offset = size - PECOFF_RELOC_RESERVE - PECOFF_COMPAT_RESERVE;
 #ifdef CONFIG_EFI_MIXED
 	uint32_t compat_offset = reloc_offset + PECOFF_RELOC_RESERVE;
 #endif
-	uint32_t setup_size = reloc_offset - setup_offset;
 
-	update_pecoff_section_header(".setup", setup_offset, setup_size);
 	update_pecoff_section_header(".reloc", reloc_offset, PECOFF_RELOC_RESERVE);
 
 	/*
@@ -353,7 +350,7 @@ static unsigned int update_pecoff_sections(unsigned int text_start, unsigned int
 	 * Size of code: Subtract the size of the first sector (512 bytes)
 	 * which includes the header.
 	 */
-	put_unaligned_le32(file_sz - SECTOR_SIZE + bss_sz, &hdr->text_size);
+	put_unaligned_le32(text_sz + bss_sz, &hdr->text_size);
 
 	/* Size of image */
 	put_unaligned_le32(init_sz, &hdr->image_size);
@@ -407,7 +404,7 @@ static void efi_stub_entry_update(void)
 
 #else
 
-static inline void update_pecoff_setup_and_reloc(unsigned int size) {}
+static inline void update_pecoff_reloc(unsigned int size) {}
 static inline void update_pecoff_text(unsigned int text_start,
 				      unsigned int file_sz,
 				      unsigned int init_sz) {}
@@ -542,7 +539,7 @@ int main(int argc, char **argv)
 #ifdef CONFIG_EFI_STUB
 	/* PE specification require 512-byte minimum section file alignment */
 	kern_size = round_up(kern_file_size + 4, SECTOR_SIZE);
-	update_pecoff_setup_and_reloc(setup_size);
+	update_pecoff_reloc(setup_size);
 #else
 	/* Number of 16-byte paragraphs, including space for a 4-byte CRC */
 	kern_size = round_up(kern_file_size + 4, PARAGRAPH_SIZE);
-- 
2.39.2

