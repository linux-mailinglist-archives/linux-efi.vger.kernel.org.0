Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A20A780CD9
	for <lists+linux-efi@lfdr.de>; Fri, 18 Aug 2023 15:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354862AbjHRNqA (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 18 Aug 2023 09:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377349AbjHRNpf (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 18 Aug 2023 09:45:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F45D4229;
        Fri, 18 Aug 2023 06:45:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 372BE60F45;
        Fri, 18 Aug 2023 13:45:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4782C433C7;
        Fri, 18 Aug 2023 13:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692366327;
        bh=qP277qhLgzUM7xLfNEHA2KtyZSQajU/8gNGhoczKCNU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y5jQQ1r0XnlB1X+scrqBdqKpUVl7fIgolmkGJKwh9Vr+kzEzOj3NHAH1TDZa+FcfC
         12JV7ea5LOUVn3irW9PuVQhsz5e0wvxXhznwmhey5RmoO6Bk6JgjH6yc8KibA92uwf
         HWTZLzSLNFO6pDp1KESRlYhXWO6BRWDXHYCam/Bp7wrXvfHqPQrZHEKEPjzDb2M60C
         qn7q6nHcJD/PP9jhv7Iw/aNx9rJRsK2YMYMkVrojW66EwOOq9eKctShnwk/OHDjUyM
         iuLDp17XxNboxY+6NHxvSdFzmzCFjsuDAkrHIN3sMuOTJpthN9TUHVpUTqUjSn8U9n
         031aI9YS89KPQ==
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
Subject: [PATCH 14/17] x86/boot: Drop PE/COFF .reloc section
Date:   Fri, 18 Aug 2023 15:44:19 +0200
Message-Id: <20230818134422.380032-15-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230818134422.380032-1-ardb@kernel.org>
References: <20230818134422.380032-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4068; i=ardb@kernel.org; h=from:subject; bh=qP277qhLgzUM7xLfNEHA2KtyZSQajU/8gNGhoczKCNU=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIeV+6Vr+peb/F52Qf3dWb15c1Tx2/r/n19vX1r44fOvwQ dVv/ziUOkpZGMQ4GGTFFFkEZv99t/P0RKla51myMHNYmUCGMHBxCsBE8iQY/so5fv1f3BmivW5y kHFCzH+b1qDzfOUpjdWsrSddWSLuvWT4Xxq+LcYg8/Kttgvy12P6C2e+jpwhm8LyLvhzTHD/irs h7AA=
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

Ancient buggy EFI loaders may have required a .reloc section to be
present at some point in time, but this has not been true for a long
time so the .reloc section can just be dropped.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/header.S      | 20 -----------
 arch/x86/boot/tools/build.c | 35 +++-----------------
 2 files changed, 5 insertions(+), 50 deletions(-)

diff --git a/arch/x86/boot/header.S b/arch/x86/boot/header.S
index c23c5feef37e55ed..ccfb7a7d8c29275e 100644
--- a/arch/x86/boot/header.S
+++ b/arch/x86/boot/header.S
@@ -159,26 +159,6 @@ section_table:
 		IMAGE_SCN_MEM_READ		| \
 		IMAGE_SCN_MEM_EXECUTE		# Characteristics
 
-	#
-	# The EFI application loader requires a relocation section
-	# because EFI applications must be relocatable. The .reloc
-	# offset & size fields are filled in by build.c.
-	#
-	.ascii	".reloc"
-	.byte	0
-	.byte	0
-	.long	0
-	.long	0
-	.long	0				# SizeOfRawData
-	.long	0				# PointerToRawData
-	.long	0				# PointerToRelocations
-	.long	0				# PointerToLineNumbers
-	.word	0				# NumberOfRelocations
-	.word	0				# NumberOfLineNumbers
-	.long	IMAGE_SCN_CNT_INITIALIZED_DATA	| \
-		IMAGE_SCN_MEM_READ		| \
-		IMAGE_SCN_MEM_DISCARDABLE	# Characteristics
-
 #ifdef CONFIG_EFI_MIXED
 	#
 	# The offset & size fields are filled in by build.c.
diff --git a/arch/x86/boot/tools/build.c b/arch/x86/boot/tools/build.c
index 6b6282a96c6ab24d..08065c333b482174 100644
--- a/arch/x86/boot/tools/build.c
+++ b/arch/x86/boot/tools/build.c
@@ -45,8 +45,6 @@ typedef unsigned int   u32;
 /* This must be large enough to hold the entire setup */
 u8 buf[(SETUP_SECT_NUM+1)*512];
 
-#define PECOFF_RELOC_RESERVE 0x20
-
 #ifdef CONFIG_EFI_MIXED
 #define PECOFF_COMPAT_RESERVE 0x20
 #else
@@ -183,24 +181,13 @@ static void update_pecoff_section_header(char *section_name, u32 offset, u32 siz
 	update_pecoff_section_header_fields(section_name, offset, size, size, offset);
 }
 
-static void update_pecoff_setup_and_reloc(unsigned int size)
+static void update_pecoff_setup(unsigned int size)
 {
 	u32 setup_offset = 0x200;
-	u32 reloc_offset = size - PECOFF_RELOC_RESERVE - PECOFF_COMPAT_RESERVE;
-#ifdef CONFIG_EFI_MIXED
-	u32 compat_offset = reloc_offset + PECOFF_RELOC_RESERVE;
-#endif
-	u32 setup_size = reloc_offset - setup_offset;
+	u32 compat_offset = size - PECOFF_COMPAT_RESERVE;
+	u32 setup_size = compat_offset - setup_offset;
 
 	update_pecoff_section_header(".setup", setup_offset, setup_size);
-	update_pecoff_section_header(".reloc", reloc_offset, PECOFF_RELOC_RESERVE);
-
-	/*
-	 * Modify .reloc section contents with a single entry. The
-	 * relocation is applied to offset 10 of the relocation section.
-	 */
-	put_unaligned_le32(reloc_offset + 10, &buf[reloc_offset]);
-	put_unaligned_le32(10, &buf[reloc_offset + 4]);
 
 #ifdef CONFIG_EFI_MIXED
 	update_pecoff_section_header(".compat", compat_offset, PECOFF_COMPAT_RESERVE);
@@ -217,21 +204,10 @@ static void update_pecoff_setup_and_reloc(unsigned int size)
 #endif
 }
 
-static int reserve_pecoff_reloc_section(int c)
-{
-	/* Reserve 0x20 bytes for .reloc section */
-	memset(buf+c, 0, PECOFF_RELOC_RESERVE);
-	return PECOFF_RELOC_RESERVE;
-}
-
 #else
 
-static inline void update_pecoff_setup_and_reloc(unsigned int size) {}
+static inline void update_pecoff_setup(unsigned int size) {}
 
-static inline int reserve_pecoff_reloc_section(int c)
-{
-	return 0;
-}
 #endif /* CONFIG_EFI_STUB */
 
 static int reserve_pecoff_compat_section(int c)
@@ -310,7 +286,6 @@ int main(int argc, char ** argv)
 	fclose(file);
 
 	c += reserve_pecoff_compat_section(c);
-	c += reserve_pecoff_reloc_section(c);
 
 	/* Pad unused space with zeros */
 	setup_sectors = (c + 511) / 512;
@@ -320,7 +295,7 @@ int main(int argc, char ** argv)
 	i = setup_sectors*512;
 	memset(buf+c, 0, i-c);
 
-	update_pecoff_setup_and_reloc(i);
+	update_pecoff_setup(i);
 
 	/* Open and stat the kernel file */
 	fd = open(argv[2], O_RDONLY);
-- 
2.39.2

