Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FEA9780CD0
	for <lists+linux-efi@lfdr.de>; Fri, 18 Aug 2023 15:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348447AbjHRNp7 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 18 Aug 2023 09:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377337AbjHRNpe (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 18 Aug 2023 09:45:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51B404220;
        Fri, 18 Aug 2023 06:45:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E3C9A61B66;
        Fri, 18 Aug 2023 13:45:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80A1FC433CB;
        Fri, 18 Aug 2023 13:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692366324;
        bh=2tNYvCTQETnYKJxzTWyBNXcGaf0lQQ9jGnUVDVr3vNI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f+aJPIvqFwCwaewVyyYQRfsdJYX4ak8lcaMhVlpT35Xer857YFF4dsXSH57MS+kje
         nt7umP7spkcxjXMyggtRV3HCV+grUyogv3D+rEJRA65Wmixyc6RfE0b9EPcA9pjLZE
         yGZ0/u2mk6zvFF28oNpyxDF98A5V221w4wRFOBnCSUX+JsKHtIrwcEYqKrA1Sh2QHB
         ImvGma7PDDOAERURNTcSnke+HRgn82bQDmNhgh2vhP+lxhc8bvzKLjteXJyk4xiY5T
         B8Yw/qwFCSU1X/SZVfQY3VJpcsfvKUStluPvDKJ4qPjsiWvgFYASX0H94B7NL9JSl5
         vMBXUqNsbMQ5A==
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
Subject: [PATCH 13/17] x86/boot: Construct PE/COFF .text section from assembler
Date:   Fri, 18 Aug 2023 15:44:18 +0200
Message-Id: <20230818134422.380032-14-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230818134422.380032-1-ardb@kernel.org>
References: <20230818134422.380032-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5082; i=ardb@kernel.org; h=from:subject; bh=2tNYvCTQETnYKJxzTWyBNXcGaf0lQQ9jGnUVDVr3vNI=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIeV+6RqH2xp9W+Z3zdk8uVjXpV4z84p8intW/Ovje/suT fP9J3Oyo5SFQYyDQVZMkUVg9t93O09PlKp1niULM4eVCWQIAxenAEyk+jjDf/8DhTOTX1mWr1m/ ulr6YPtUH4l1diY94TdVznnOLH0R+oORYdUOxV1/T/++cUBZpPTDGuuUi0krVv5e7vvfWGXhlY+ TD3IAAA==
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

Now that the size of the setup block is fixed and visible to the
assembler, it is possible to populate the PE/COFF header fields from the
asm code directly, instead of poking the values into the binary using
the build tool. This will make it easier to reorganize the section
layout without having to tweak the build tool in lockstep.

Note that this change results in no differences in the resulting bzImage
binary.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/header.S      | 22 +++------
 arch/x86/boot/tools/build.c | 47 --------------------
 2 files changed, 7 insertions(+), 62 deletions(-)

diff --git a/arch/x86/boot/header.S b/arch/x86/boot/header.S
index f1fdffc9d2ca984b..c23c5feef37e55ed 100644
--- a/arch/x86/boot/header.S
+++ b/arch/x86/boot/header.S
@@ -79,14 +79,12 @@ optional_header:
 	.byte	0x02				# MajorLinkerVersion
 	.byte	0x14				# MinorLinkerVersion
 
-	# Filled in by build.c
-	.long	0				# SizeOfCode
+	.long	setup_size + ZO__end - 0x200	# SizeOfCode
 
 	.long	0				# SizeOfInitializedData
 	.long	0				# SizeOfUninitializedData
 
-	# Filled in by build.c
-	.long	0x0000				# AddressOfEntryPoint
+	.long	setup_size + ZO_efi_pe_entry	# AddressOfEntryPoint
 
 	.long	0x0200				# BaseOfCode
 #ifdef CONFIG_X86_32
@@ -109,10 +107,7 @@ extra_header_fields:
 	.word	0				# MinorSubsystemVersion
 	.long	0				# Win32VersionValue
 
-	#
-	# The size of the bzImage is written in tools/build.c
-	#
-	.long	0				# SizeOfImage
+	.long	setup_size + ZO__end 		# SizeOfImage
 
 	.long	0x200				# SizeOfHeaders
 	.long	0				# CheckSum
@@ -203,18 +198,15 @@ section_table:
 		IMAGE_SCN_MEM_DISCARDABLE	# Characteristics
 #endif
 
-	#
-	# The offset & size fields are filled in by build.c.
-	#
 	.ascii	".text"
 	.byte	0
 	.byte	0
 	.byte	0
-	.long	0
-	.long	0x0				# startup_{32,64}
-	.long	0				# Size of initialized data
+	.long	ZO__end
+	.long	setup_size
+	.long	ZO__edata			# Size of initialized data
 						# on disk
-	.long	0x0				# startup_{32,64}
+	.long	setup_size
 	.long	0				# PointerToRelocations
 	.long	0				# PointerToLineNumbers
 	.word	0				# NumberOfRelocations
diff --git a/arch/x86/boot/tools/build.c b/arch/x86/boot/tools/build.c
index 082c38a097713a2d..6b6282a96c6ab24d 100644
--- a/arch/x86/boot/tools/build.c
+++ b/arch/x86/boot/tools/build.c
@@ -53,10 +53,8 @@ u8 buf[(SETUP_SECT_NUM+1)*512];
 #define PECOFF_COMPAT_RESERVE 0x0
 #endif
 
-static unsigned long efi_pe_entry;
 static unsigned long efi32_pe_entry;
 static unsigned long _edata;
-static unsigned long _end;
 
 /*----------------------------------------------------------------------*/
 
@@ -219,32 +217,6 @@ static void update_pecoff_setup_and_reloc(unsigned int size)
 #endif
 }
 
-static void update_pecoff_text(unsigned int text_start, unsigned int file_sz)
-{
-	unsigned int pe_header;
-	unsigned int text_sz = file_sz - text_start;
-	unsigned int bss_sz = _end - text_sz;
-
-	pe_header = get_unaligned_le32(&buf[0x3c]);
-
-	/*
-	 * Size of code: Subtract the size of the first sector (512 bytes)
-	 * which includes the header.
-	 */
-	put_unaligned_le32(file_sz - 512 + bss_sz, &buf[pe_header + 0x1c]);
-
-	/* Size of image */
-	put_unaligned_le32(file_sz + bss_sz, &buf[pe_header + 0x50]);
-
-	/*
-	 * Address of entry point for PE/COFF executable
-	 */
-	put_unaligned_le32(text_start + efi_pe_entry, &buf[pe_header + 0x28]);
-
-	update_pecoff_section_header_fields(".text", text_start, text_sz + bss_sz,
-					    text_sz, text_start);
-}
-
 static int reserve_pecoff_reloc_section(int c)
 {
 	/* Reserve 0x20 bytes for .reloc section */
@@ -252,22 +224,9 @@ static int reserve_pecoff_reloc_section(int c)
 	return PECOFF_RELOC_RESERVE;
 }
 
-static void efi_stub_defaults(void)
-{
-	/* Defaults for old kernel */
-#ifdef CONFIG_X86_32
-	efi_pe_entry = 0x10;
-#else
-	efi_pe_entry = 0x210;
-#endif
-}
-
 #else
 
 static inline void update_pecoff_setup_and_reloc(unsigned int size) {}
-static inline void update_pecoff_text(unsigned int text_start,
-				      unsigned int file_sz) {}
-static inline void efi_stub_defaults(void) {}
 
 static inline int reserve_pecoff_reloc_section(int c)
 {
@@ -310,10 +269,8 @@ static void parse_zoffset(char *fname)
 	p = (char *)buf;
 
 	while (p && *p) {
-		PARSE_ZOFS(p, efi_pe_entry);
 		PARSE_ZOFS(p, efi32_pe_entry);
 		PARSE_ZOFS(p, _edata);
-		PARSE_ZOFS(p, _end);
 
 		p = strchr(p, '\n');
 		while (p && (*p == '\r' || *p == '\n'))
@@ -331,8 +288,6 @@ int main(int argc, char ** argv)
 	void *kernel;
 	u32 crc = 0xffffffffUL;
 
-	efi_stub_defaults();
-
 	if (argc != 5)
 		usage();
 	parse_zoffset(argv[3]);
@@ -380,8 +335,6 @@ int main(int argc, char ** argv)
 	kernel = mmap(NULL, sz, PROT_READ, MAP_SHARED, fd, 0);
 	if (kernel == MAP_FAILED)
 		die("Unable to mmap '%s': %m", argv[2]);
-	update_pecoff_text(setup_sectors * 512, i + _edata);
-
 
 	crc = partial_crc32(buf, i, crc);
 	if (fwrite(buf, 1, i, dest) != i)
-- 
2.39.2

