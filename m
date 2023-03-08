Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F34ED6B12F8
	for <lists+linux-efi@lfdr.de>; Wed,  8 Mar 2023 21:22:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbjCHUWy (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 8 Mar 2023 15:22:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbjCHUWm (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 8 Mar 2023 15:22:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 047F0CB06B
        for <linux-efi@vger.kernel.org>; Wed,  8 Mar 2023 12:22:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7E23E6195C
        for <linux-efi@vger.kernel.org>; Wed,  8 Mar 2023 20:22:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76478C4339B;
        Wed,  8 Mar 2023 20:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678306946;
        bh=PrVVBT07eZXpClfbYlHd8W1/CUo1d0fwxXxXfwLJDDo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QpUUFLKXf95qkxMfwNgp5ckFjtz2fa5n9cYlVHjm92xdEBGu445NzUy/uGodbeL4N
         5EIThLWYw03SIW0/coRpAMiZ3J86bGbRsfYCSYRauwoaQUCDGA42pG9Jjx2spjRKS2
         jciN9deZZ1bF0hePna36nS+cIXRVNnC8uGQBai4ZDfTnv/6YUAs1gPnunOBIOLbz5B
         XHr7mck5tDUjPlCT1T/FenYavrMyOeNbLfe5limaL2H0P47Z12m2a3Y+gXtcIEgDUd
         Wp8K++EOPCFZk2kmtL9QBQ7N+8gZU/5qjcyFCnYdPvOGGwoR7t3E7cESeH2Iepz0B3
         pNMjzIymRsxpw==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Evgeniy Baskov <baskov@ispras.ru>,
        Borislav Petkov <bp@alien8.de>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Peter Jones <pjones@redhat.com>,
        "Limonciello, Mario" <mario.limonciello@amd.com>
Subject: [RFC PATCH 4/4] efi: x86: Split PE/COFF .text section into .text and .data
Date:   Wed,  8 Mar 2023 21:22:09 +0100
Message-Id: <20230308202209.2980947-5-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230308202209.2980947-1-ardb@kernel.org>
References: <20230308202209.2980947-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3259; i=ardb@kernel.org; h=from:subject; bh=PrVVBT07eZXpClfbYlHd8W1/CUo1d0fwxXxXfwLJDDo=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIYXjXeFO/nUikmcmOry4eXbLgeNz7nnPWr6Qx6DT4fy69 6JvDvzM6ChlYRDjYJAVU2QRmP333c7TE6VqnWfJwsxhZQIZwsDFKQATubabkWF/pwyfhKN3ntEU 920pKxNeBuXLT+lY9EM0Y0WQ1ifb1nCG/077vZQCZD+0PNwifGOfbkN7EgPvPt5Jt4s+yPQUF// bxAgA
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

Modern PE loader implementations used by EFI will honour the PE section
permission attributes, and so we can use them to avoid mappings that are
writable and executable at the same time.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/header.S      | 17 ++++++++++++++++
 arch/x86/boot/tools/build.c | 21 +++++++++++++++-----
 2 files changed, 33 insertions(+), 5 deletions(-)

diff --git a/arch/x86/boot/header.S b/arch/x86/boot/header.S
index 4f1e1791cda4d316..a8ff8bbb17bca7d7 100644
--- a/arch/x86/boot/header.S
+++ b/arch/x86/boot/header.S
@@ -253,6 +253,23 @@ section_table:
 		IMAGE_SCN_MEM_READ		| \
 		IMAGE_SCN_MEM_EXECUTE		# Characteristics
 
+	.ascii	".data"
+	.byte	0
+	.byte	0
+	.byte	0
+	.long	0
+	.long	0x0				# startup_{32,64}
+	.long	0				# Size of initialized data
+						# on disk
+	.long	0x0				# startup_{32,64}
+	.long	0				# PointerToRelocations
+	.long	0				# PointerToLineNumbers
+	.word	0				# NumberOfRelocations
+	.word	0				# NumberOfLineNumbers
+	.long	IMAGE_SCN_CNT_INITIALIZED_DATA	| \
+		IMAGE_SCN_MEM_READ		| \
+		IMAGE_SCN_MEM_WRITE		# Characteristics
+
 	.set	section_count, (. - section_table) / 40
 #endif /* CONFIG_EFI_STUB */
 
diff --git a/arch/x86/boot/tools/build.c b/arch/x86/boot/tools/build.c
index 883e6359221cd588..b449c82feaadf2b8 100644
--- a/arch/x86/boot/tools/build.c
+++ b/arch/x86/boot/tools/build.c
@@ -119,6 +119,7 @@ static unsigned long efi_boot_params;
 static unsigned long kernel_info;
 static unsigned long startup_64;
 static unsigned long _ehead;
+static unsigned long _data;
 static unsigned long _end;
 
 /*----------------------------------------------------------------------*/
@@ -347,10 +348,15 @@ static unsigned int update_pecoff_sections(unsigned int text_start, unsigned int
 	init_sz	+= CONFIG_PHYSICAL_ALIGN;
 
 	/*
-	 * Size of code: Subtract the size of the first sector (512 bytes)
-	 * which includes the header.
+	 * Size of code: the size of the combined .text/.rodata section, which
+	 * ends at the _data marker symbol.
 	 */
-	put_unaligned_le32(text_sz + bss_sz, &hdr->text_size);
+	put_unaligned_le32(_data, &hdr->text_size);
+
+	/*
+	 * Size of data: the size of the combined .data/.bss section.
+	 */
+	put_unaligned_le32(text_sz - _data + bss_sz, &hdr->data_size);
 
 	/* Size of image */
 	put_unaligned_le32(init_sz, &hdr->image_size);
@@ -360,9 +366,13 @@ static unsigned int update_pecoff_sections(unsigned int text_start, unsigned int
 	 */
 	put_unaligned_le32(text_start + efi_pe_entry, &hdr->entry_point);
 
-	update_pecoff_section_header_fields(".text", text_start, text_sz + bss_sz,
-					    text_sz, text_start);
+	update_pecoff_section_header_fields(".text", text_start, _data,
+					    _data, text_start);
 
+	update_pecoff_section_header_fields(".data", text_start + _data,
+					    text_sz - _data + bss_sz,
+					    text_sz - _data,
+					    text_start + _data);
 	return text_start + file_sz;
 }
 
@@ -455,6 +465,7 @@ static void parse_zoffset(char *fname)
 		PARSE_ZOFS(p, kernel_info);
 		PARSE_ZOFS(p, startup_64);
 		PARSE_ZOFS(p, _ehead);
+		PARSE_ZOFS(p, _data);
 		PARSE_ZOFS(p, _end);
 
 		p = strchr(p, '\n');
-- 
2.39.2

