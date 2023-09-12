Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8644879CAF9
	for <lists+linux-efi@lfdr.de>; Tue, 12 Sep 2023 11:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233562AbjILJC6 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 12 Sep 2023 05:02:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233299AbjILJCA (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 12 Sep 2023 05:02:00 -0400
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA5D11710
        for <linux-efi@vger.kernel.org>; Tue, 12 Sep 2023 02:01:56 -0700 (PDT)
Received: by mail-wr1-x44a.google.com with SMTP id ffacd0b85a97d-31aca0c0d63so3580325f8f.0
        for <linux-efi@vger.kernel.org>; Tue, 12 Sep 2023 02:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694509315; x=1695114115; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PtE5rJOnAPC0rkk2NBlL+eg4snrrU6qshhDNM5ERzdo=;
        b=vBLiqDaJISkPvj2XpU16QrhqSHYzJwxmryLwn6yGrJrAxjfa+uRJgnKPsbwXukkt0+
         eVcoceSbZpxXcwzJtuVZpmNt5urVqxxvIfC1iE246ExB9wLeLAMaBBhtAhlEBJ2+us9p
         dCmf5yrBq5/bTCFMrLNdLtrfaMc+wl/9Obs/twO6X77sKmgEfEatDQZ/u8fBC9NW0D1D
         BlTndLZ4E/c/Y76MRmbin2jWexM5QfgqFyNDeeYEvTC8gzD/TkGAlRs8vt2wxNh3VcUc
         cdvtOtPIokOS5tPE60OP7dJ2Hp5qwbbu1b2DKCcUhTIwU4pZEnLnFve6TVJB/DBRyHko
         OEZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694509315; x=1695114115;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PtE5rJOnAPC0rkk2NBlL+eg4snrrU6qshhDNM5ERzdo=;
        b=tCMmyYeT56QT4k7lNt55jeDqmd3mqUyhLW0BPDoGliS00fwGPLChwxSje7q8JHEzLO
         DqAon/TRWXhgtWpY6EPfpOLB5cQ4VEsBu5fzYwL+85wl/fCsuq6QAQPBRwyXvKnSjC3H
         OllIHqnNKepZgVOKarhcnmG2zMq2t4HAYu9zIdRP1Vu1VA8JS+AxcNAAyj63omxK8Nfp
         qjoAJjKIr+f0h8RHcmQTJYE76I7M/YGOgE7LN568NZloAqEu41luBdYr7EiXuzIOBzdw
         IyKOvsHHjhUlgsLnj5IAO38N5DP/4vDhbFfl9K2F2IlnNrDRkm06H0GLdlHhP769sGQA
         Ta7A==
X-Gm-Message-State: AOJu0Yy3DCw+K1Z/BBSSbIGt8IThQe/PEGN1JUIzggobcN90myVfc80O
        EOVVQ2+4SBY9FBh9Wjs0N7LhP2xJjkdPqc4hMrW9oZvJRSGPK32yQwA68Spq9/D5HS0Q7FyUgW1
        wubVL/hQAnuDd5qW1FjnbuWs+fpmJfoPw0wX7b2H0MR14qUuedyTrj1dr9e1I
X-Google-Smtp-Source: AGHT+IEURST6QRBzJI9/oGDc1gCn7rnnbGe1hkTAe5fwiHeGgoO1rLaZsxQh53sDSYvjBdXxZr+xVgJe
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a5d:5a0a:0:b0:31f:888b:9a4 with SMTP id
 bq10-20020a5d5a0a000000b0031f888b09a4mr115285wrb.12.1694509315333; Tue, 12
 Sep 2023 02:01:55 -0700 (PDT)
Date:   Tue, 12 Sep 2023 09:01:03 +0000
In-Reply-To: <20230912090051.4014114-17-ardb@google.com>
Mime-Version: 1.0
References: <20230912090051.4014114-17-ardb@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=5078; i=ardb@kernel.org;
 h=from:subject; bh=F2oADtM1aETnRbMMK7i5jv6x3L4FFvbX8aYXoDbnzJ0=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIZVB49LhMkm7TM3czCzWv7fNJr6Zw5IQl756udUrySuqj
 k6a19s7SlkYxDgYZMUUWQRm/3238/REqVrnWbIwc1iZQIYwcHEKwEQk/jP8d30kPjf/2FPf3u5H
 kfoiG4qTlQ9ffZjZve5hm7TaFdZkO0aGfUxHmxsyS4QiovdoudXLfXn0bLlu0uR1LP8lrmVdWsv HBwA=
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230912090051.4014114-29-ardb@google.com>
Subject: [PATCH v2 12/15] x86/boot: Construct PE/COFF .text section from assembler
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
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Ard Biesheuvel <ardb@kernel.org>

Now that the size of the setup block is visible to the assembler, it is
possible to populate the PE/COFF header fields from the asm code
directly, instead of poking the values into the binary using the build
tool. This will make it easier to reorganize the section layout without
having to tweak the build tool in lockstep.

This change has no impact on the resulting bzImage binary.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/header.S      | 22 +++------
 arch/x86/boot/tools/build.c | 47 --------------------
 2 files changed, 7 insertions(+), 62 deletions(-)

diff --git a/arch/x86/boot/header.S b/arch/x86/boot/header.S
index 34e9b35b827c..2b07bc596c39 100644
--- a/arch/x86/boot/header.S
+++ b/arch/x86/boot/header.S
@@ -75,14 +75,12 @@ optional_header:
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
@@ -105,10 +103,7 @@ extra_header_fields:
 	.word	0				# MinorSubsystemVersion
 	.long	0				# Win32VersionValue
 
-	#
-	# The size of the bzImage is written in tools/build.c
-	#
-	.long	0				# SizeOfImage
+	.long	setup_size + ZO__end 		# SizeOfImage
 
 	.long	0x200				# SizeOfHeaders
 	.long	0				# CheckSum
@@ -199,18 +194,15 @@ section_table:
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
index e792c6c5a634..9712f27e32c1 100644
--- a/arch/x86/boot/tools/build.c
+++ b/arch/x86/boot/tools/build.c
@@ -50,10 +50,8 @@ u8 buf[SETUP_SECT_MAX*512];
 #define PECOFF_RELOC_RESERVE 0x20
 #define PECOFF_COMPAT_RESERVE 0x20
 
-static unsigned long efi_pe_entry;
 static unsigned long efi32_pe_entry;
 static unsigned long _edata;
-static unsigned long _end;
 
 /*----------------------------------------------------------------------*/
 
@@ -216,32 +214,6 @@ static void update_pecoff_setup_and_reloc(unsigned int size)
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
@@ -249,22 +221,9 @@ static int reserve_pecoff_reloc_section(int c)
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
@@ -307,10 +266,8 @@ static void parse_zoffset(char *fname)
 	p = (char *)buf;
 
 	while (p && *p) {
-		PARSE_ZOFS(p, efi_pe_entry);
 		PARSE_ZOFS(p, efi32_pe_entry);
 		PARSE_ZOFS(p, _edata);
-		PARSE_ZOFS(p, _end);
 
 		p = strchr(p, '\n');
 		while (p && (*p == '\r' || *p == '\n'))
@@ -328,8 +285,6 @@ int main(int argc, char ** argv)
 	void *kernel;
 	u32 crc = 0xffffffffUL;
 
-	efi_stub_defaults();
-
 	if (argc != 5)
 		usage();
 	parse_zoffset(argv[3]);
@@ -376,8 +331,6 @@ int main(int argc, char ** argv)
 	kernel = mmap(NULL, sz, PROT_READ, MAP_SHARED, fd, 0);
 	if (kernel == MAP_FAILED)
 		die("Unable to mmap '%s': %m", argv[2]);
-	update_pecoff_text(setup_sectors * 512, i + _edata);
-
 
 	crc = partial_crc32(buf, i, crc);
 	if (fwrite(buf, 1, i, dest) != i)
-- 
2.42.0.283.g2d96d420d3-goog

