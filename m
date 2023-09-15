Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FED37A2479
	for <lists+linux-efi@lfdr.de>; Fri, 15 Sep 2023 19:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235522AbjIORR1 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 15 Sep 2023 13:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235563AbjIORRQ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 15 Sep 2023 13:17:16 -0400
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 124BB10C7
        for <linux-efi@vger.kernel.org>; Fri, 15 Sep 2023 10:17:11 -0700 (PDT)
Received: by mail-wr1-x44a.google.com with SMTP id ffacd0b85a97d-2f2981b8364so1518064f8f.1
        for <linux-efi@vger.kernel.org>; Fri, 15 Sep 2023 10:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694798229; x=1695403029; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=L1gO2kCdMVaucAMeTOT10qYv1tzC+9yo5OSZCzbyFtM=;
        b=M66l5U2BNn5RHUJuZh6SrEaxx8dhmAs3CpkTfMy6RiTwcPxFiiAS8J04y4LHJ2m2tO
         AZVwUHnmT7fjjiCxNJm36zLU+dMA1Bf4xrSVZrJrGzcU4SkSMDCHQQItWJWhM+sMK/p/
         gSG3FzN8695yp199Qfqeahi4S+zPaJfG3tKsYN0AmPshzHOfROK8gIftmi7rHuHkHs1A
         NYM3czidgZDZTWprxjdq5khUSB0aGb1vL9nS4qB03o3fqJxgUTvu73l9j2D+kgiwEf1P
         iSXUjHX0n5kwozYJDZBXOE/WCeQVFE5fPCNFwcRMEqjagMa+7m/JMYFmYNocwQAlzGyG
         JY5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694798229; x=1695403029;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L1gO2kCdMVaucAMeTOT10qYv1tzC+9yo5OSZCzbyFtM=;
        b=XJI6uG0CweLZPADzjpBTvMeUdBSabRFZ4TUzXFwhpcLqd28lohZ0AvBnFzV0f4cOAe
         L09BFfn6jkuscC+qb/+qtZVepNZhmwJitNP47+TJ30l+tAd6+AX5mIx3IZmk09Zy5Y0m
         kCwlt2AsvEEfzMR5tmqYaf/VoCy4Xib24VFyeAeS0sIKcVm+aptv+XBRvn9V7kEMW3eS
         1BnbKpc28ochmR2Q0MrT2HUdweVmgGS/G5Gz4cq04hsWGQaZw+EkVxWvg+0yoNAwlZAV
         Bhw5uv+DbavizA4dEw+W4JhYWxlhUuEWrAq48fXSuTL+1TBEWE3Y7DATEZQ2bNCYExIN
         7rJg==
X-Gm-Message-State: AOJu0YzCxvzZ1LyTBRavypc9mAg33Xrovv+hfJJnNaHEgy2oZ2KvAlue
        m2XBHmnm9vn5ETbM+bquD10WozGWNmtP18QJCANeSPunD70E2CBPbjwJyGtbEDqxsslIIIzi9WD
        hPv8Xuds59sBNUay9VEW8yTBU1hdvp8W5W2b4kLsyUdgLZQbtaDvGO1tT1u5p
X-Google-Smtp-Source: AGHT+IG2RDfNh3Fjx2YGgCw0Md9EbqHP0+PcgjAT/yS+Bz5MOrJPmvAiyEg8aCxQs/1MCbu9JJ9Xx4J+
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:adf:e18b:0:b0:31f:fa4a:b6e1 with SMTP id
 az11-20020adfe18b000000b0031ffa4ab6e1mr16121wrb.2.1694798229564; Fri, 15 Sep
 2023 10:17:09 -0700 (PDT)
Date:   Fri, 15 Sep 2023 17:16:29 +0000
In-Reply-To: <20230915171623.655440-10-ardb@google.com>
Mime-Version: 1.0
References: <20230915171623.655440-10-ardb@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=5078; i=ardb@kernel.org;
 h=from:subject; bh=DU0r2iy2nqtNsHxloC1WgGeN+dGK1P7AGRjmhDsQHb4=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIZVlYo5LuJn99qmbJqitX17E1zKrX+DXJ3mJed7nOYJEM
 uUylr3rKGVhEONgkBVTZBGY/ffdztMTpWqdZ8nCzGFlAhnCwMUpABNZzsXI8LPOU6K/RnTuzeZm
 c9aDu68Wbsmtqox4LJLvvXjrz/0HJjMyXJ+dzWokltHcPLNWXSk/2OvRlpD7OzrmHLvIXXBS+vU UJgA=
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Message-ID: <20230915171623.655440-15-ardb@google.com>
Subject: [PATCH v3 5/8] x86/boot: Construct PE/COFF .text section from assembler
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
2.42.0.459.ge4e396fd5e-goog

