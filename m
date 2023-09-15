Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A4D47A2481
	for <lists+linux-efi@lfdr.de>; Fri, 15 Sep 2023 19:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236087AbjIORRz (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 15 Sep 2023 13:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235493AbjIORRZ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 15 Sep 2023 13:17:25 -0400
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B363CC1
        for <linux-efi@vger.kernel.org>; Fri, 15 Sep 2023 10:17:19 -0700 (PDT)
Received: by mail-wm1-x34a.google.com with SMTP id 5b1f17b1804b1-3f5df65f9f4so18085135e9.2
        for <linux-efi@vger.kernel.org>; Fri, 15 Sep 2023 10:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694798238; x=1695403038; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Igp2u3iCFoQ+ul8/EKEO/kGXUxIcMMS01YyM7SofEY0=;
        b=O8uyAvKGCTfCWdzRz3XxIGrk5FYYV3Qq7oL3CtgkWF+zj2FZDEOH0YmlJCXqkqlLWW
         R2ZD3fwA6qgwTCm5+GssvEdk0Sj2Yixu12TXYJILC954pvBKx5W1GUB+0+o9Fu+OD9d/
         wNYOWOKGnggedJtzokO6pmvhiBB56bEgUDGwkDxeZxCu7mxti0IwumxXF0iUqyVi4UC6
         AURKtAjoa7jxAe34jHOzi2d39zGXm/snPwwDTyj2UKJ2N+aA6u57vWzxd6EHoq8+4jeM
         rVCmjlerbhAfg27rv7VKvlcDIPiTk+aqOPIxR2+ZAgwBzzfHKMB70unP0mXVjrOxVqaE
         DfSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694798238; x=1695403038;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Igp2u3iCFoQ+ul8/EKEO/kGXUxIcMMS01YyM7SofEY0=;
        b=wC7Vbt9poCywUHErlqyD7sGiBrack4tKj9w7xpnmavuWWsVfTifgByZ9uyVNWTzHGG
         lVbt8d/d3knoiGR+8unE2k4NYiaVR60yW4lAaQZ251S6WDYccMyTuDmx8UufsDR/3SI4
         +ADmTiQlbUsAN+ItpqVe7OmI13mXDgUwP9Tsd+blg0uSsyIm9G7u0prtWFXmnzexR2FI
         qUwmWO9tmF3MNG3VWrTY5QG882v9Sn0UIGBA0q6/m7VrFICYJXJpjzTEjr8J+zlNkWw0
         JFrydbYDVbE62eM9sD32Fk4syW44r5zqA9LqxeAiGpYa+QRQlrty0CRnBaFaqF2gRxqV
         ecog==
X-Gm-Message-State: AOJu0Yy2PPNocozciIz5g4gp0zXAHfgPlhG9EsFAa1auTdMrIAt92x4N
        56cM7y38IzVYQlTwTErhiDlc8TfsSCxvKbw0KW4w1Pt0ZMVqqRMSKe9RvFSVxO588ttmeei4kik
        9STy4lLykYrg2/5Dtj6gvb+eOAMFYMoKGklWG7ymT99e/7wu0yRMQkJV4nXoz
X-Google-Smtp-Source: AGHT+IE1C8LRh03kp7q3I3bgmzh5lk1ENd2pPVZGx5Wm7Yd6SAKZ5uPzqzi4kQTvMaGF05RfRv2bD10P
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:adf:cf0f:0:b0:314:1ac7:2763 with SMTP id
 o15-20020adfcf0f000000b003141ac72763mr31953wrj.0.1694798237748; Fri, 15 Sep
 2023 10:17:17 -0700 (PDT)
Date:   Fri, 15 Sep 2023 17:16:32 +0000
In-Reply-To: <20230915171623.655440-10-ardb@google.com>
Mime-Version: 1.0
References: <20230915171623.655440-10-ardb@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=10099; i=ardb@kernel.org;
 h=from:subject; bh=t1Y7fjR3ASci9QCQAmL7fizNw19QbZQQvciLm9pIPVE=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIZVlYn7XblUzDVXnzdfWimTMnHi15evGmuyfa/0Yu5kmK
 GuKzknsKGVhEONgkBVTZBGY/ffdztMTpWqdZ8nCzGFlAhnCwMUpABPxnMTI0KL53nbuOpOIZ+YG
 E9kWLTnSXq3tqRvwYEb1tTzbeaKP3zIynFb6uK+UMfZe8LcK7d8rPyc25AU/P1zdIhaeI858afc MDgA=
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Message-ID: <20230915171623.655440-18-ardb@google.com>
Subject: [PATCH v3 8/8] x86/boot: Increase section and file alignment to 4k/512
From:   Ard Biesheuvel <ardb@google.com>
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
        "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Ard Biesheuvel <ardb@kernel.org>

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
lots of padding to accommodate the .compat section, the latter is placed
at an arbitrary offset towards the end of the image, but aligned to the
minimum file alignment (512 bytes). The space before the .text section
is therefore distributed between the PE header, the .setup section and
the .compat section, leaving no gaps in the file coverage, making the
signing tools happy.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/vmlinux.lds.S |  4 +-
 arch/x86/boot/header.S                 | 75 +++++++++-------
 arch/x86/boot/setup.ld                 |  7 +-
 arch/x86/boot/tools/build.c            | 90 +-------------------
 4 files changed, 51 insertions(+), 125 deletions(-)

diff --git a/arch/x86/boot/compressed/vmlinux.lds.S b/arch/x86/boot/compressed/vmlinux.lds.S
index b688598db28e..083ec6d7722a 100644
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
 
 		/* Add 4 bytes of extra space for a CRC-32 checksum */
-		. = ALIGN(. + 4, 0x20);
+		. = ALIGN(. + 4, 0x200);
 		_edata = . ;
 	}
 	. = ALIGN(L1_CACHE_BYTES);
diff --git a/arch/x86/boot/header.S b/arch/x86/boot/header.S
index a1f986105f00..b2771710ed98 100644
--- a/arch/x86/boot/header.S
+++ b/arch/x86/boot/header.S
@@ -36,6 +36,9 @@ SYSSEG		= 0x1000		/* historical load address >> 4 */
 #define ROOT_RDONLY 1
 #endif
 
+	.set	salign, 0x1000
+	.set	falign, 0x200
+
 	.code16
 	.section ".bstext", "ax"
 #ifdef CONFIG_EFI_STUB
@@ -82,7 +85,7 @@ optional_header:
 
 	.long	setup_size + ZO_efi_pe_entry	# AddressOfEntryPoint
 
-	.long	0x0200				# BaseOfCode
+	.long	setup_size			# BaseOfCode
 #ifdef CONFIG_X86_32
 	.long	0				# data
 #endif
@@ -93,8 +96,8 @@ extra_header_fields:
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
@@ -103,9 +106,10 @@ extra_header_fields:
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
@@ -136,44 +140,51 @@ extra_header_fields:
 
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
+	.long	setup_size - salign 		# VirtualSize
+	.long	salign				# VirtualAddress
+	.long	pecompat_fstart - salign	# SizeOfRawData
+	.long	salign				# PointerToRawData
+
+	.long	0, 0, 0
+	.long	IMAGE_SCN_CNT_INITIALIZED_DATA	| \
 		IMAGE_SCN_MEM_READ		| \
-		IMAGE_SCN_MEM_EXECUTE		# Characteristics
+		IMAGE_SCN_MEM_DISCARDABLE	# Characteristics
 
 #ifdef CONFIG_EFI_MIXED
-	#
-	# The offset & size fields are filled in by build.c.
-	#
 	.asciz	".compat"
-	.long	0
-	.long	0x0
-	.long	0				# Size of initialized data
-						# on disk
-	.long	0x0
-	.long	0				# PointerToRelocations
-	.long	0				# PointerToLineNumbers
-	.word	0				# NumberOfRelocations
-	.word	0				# NumberOfLineNumbers
+
+	.long	8				# VirtualSize
+	.long	setup_size + ZO__end		# VirtualAddress
+	.long	pecompat_fsize			# SizeOfRawData
+	.long	pecompat_fstart			# PointerToRawData
+
+	.long	0, 0, 0
 	.long	IMAGE_SCN_CNT_INITIALIZED_DATA	| \
 		IMAGE_SCN_MEM_READ		| \
 		IMAGE_SCN_MEM_DISCARDABLE	# Characteristics
-#endif
 
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
+	.byte	0x1				# Version
+	.byte	8				# Size
+	.word	IMAGE_FILE_MACHINE_I386		# PE machine type
+	.long	setup_size + ZO_efi32_pe_entry	# Entrypoint
+	.popsection
+#else
+	.set	pecompat_vsize, 0
+	.set	pecompat_fstart, setup_size
+#endif
 	.ascii	".text"
 	.byte	0
 	.byte	0
diff --git a/arch/x86/boot/setup.ld b/arch/x86/boot/setup.ld
index 6d389499565c..83bb7efad8ae 100644
--- a/arch/x86/boot/setup.ld
+++ b/arch/x86/boot/setup.ld
@@ -36,16 +36,17 @@ SECTIONS
 	. = ALIGN(16);
 	.data		: { *(.data*) }
 
+	.pecompat	: { *(.pecompat) }
+	PROVIDE(pecompat_fsize = setup_size - pecompat_fstart);
+
 	.signature	: {
 		setup_sig = .;
 		LONG(0x5a5aaa55)
 
-		/* Reserve some extra space for the compat section */
-		setup_size = ALIGN(ABSOLUTE(.) + 32, 512);
+		setup_size = ALIGN(ABSOLUTE(.), 4096);
 		setup_sects = ABSOLUTE(setup_size / 512);
 	}
 
-
 	. = ALIGN(16);
 	.bss		:
 	{
diff --git a/arch/x86/boot/tools/build.c b/arch/x86/boot/tools/build.c
index faccff9743a3..10311d77c67f 100644
--- a/arch/x86/boot/tools/build.c
+++ b/arch/x86/boot/tools/build.c
@@ -47,9 +47,6 @@ typedef unsigned int   u32;
 /* This must be large enough to hold the entire setup */
 u8 buf[SETUP_SECT_MAX*512];
 
-#define PECOFF_COMPAT_RESERVE 0x20
-
-static unsigned long efi32_pe_entry;
 static unsigned long _edata;
 
 /*----------------------------------------------------------------------*/
@@ -136,85 +133,6 @@ static void usage(void)
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
@@ -243,7 +161,6 @@ static void parse_zoffset(char *fname)
 	p = (char *)buf;
 
 	while (p && *p) {
-		PARSE_ZOFS(p, efi32_pe_entry);
 		PARSE_ZOFS(p, _edata);
 
 		p = strchr(p, '\n');
@@ -283,17 +200,14 @@ int main(int argc, char ** argv)
 		die("Boot block hasn't got boot flag (0xAA55)");
 	fclose(file);
 
-	c += reserve_pecoff_compat_section(c);
-
 	/* Pad unused space with zeros */
-	setup_sectors = (c + 511) / 512;
+	setup_sectors = (c + 4095) / 4096;
+	setup_sectors *= 8;
 	if (setup_sectors < SETUP_SECT_MIN)
 		setup_sectors = SETUP_SECT_MIN;
 	i = setup_sectors*512;
 	memset(buf+c, 0, i-c);
 
-	update_pecoff_setup(i);
-
 	/* Open and stat the kernel file */
 	fd = open(argv[2], O_RDONLY);
 	if (fd < 0)
-- 
2.42.0.459.ge4e396fd5e-goog

