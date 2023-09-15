Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C99A77A2478
	for <lists+linux-efi@lfdr.de>; Fri, 15 Sep 2023 19:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235563AbjIORR2 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 15 Sep 2023 13:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235602AbjIORRS (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 15 Sep 2023 13:17:18 -0400
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB3D2C1
        for <linux-efi@vger.kernel.org>; Fri, 15 Sep 2023 10:17:13 -0700 (PDT)
Received: by mail-wr1-x44a.google.com with SMTP id ffacd0b85a97d-31c470305cfso1576440f8f.3
        for <linux-efi@vger.kernel.org>; Fri, 15 Sep 2023 10:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694798232; x=1695403032; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hNDDZ79AxT4g2TPKcz16ks6CPU320NZDmUakc4ak4Sc=;
        b=VSjumqBUcNt3M/IG45mRDWdyccph651YDhWniHXvXKIHpC3qSDr+Zdo7MU48lP2x8j
         Qo5/5G4y0ONTAh+uOI07T8zf9LqnaFg6pSKaWQMmCxsIyc1+No/HRMLgqnZ8w3izdkwS
         KGNgDK3Q9PEk/bS37xhg6N+Z2q626PncKsuHZ1WpasVV0ZMWzctOK2ngxMtxaRnQLnao
         j6qGuS0N82lHSMXT9WffvXA+Msro8nnpuAzZip3yc3ToAz4chXCSVtmfIbH2Wt7t0+zV
         EzZOsb06lPV8bSjefgOiisHz2oxa4LaNqRb4e4dNm0+s7Zz0WM+sRyieq/gVCWMVFMRg
         21og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694798232; x=1695403032;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hNDDZ79AxT4g2TPKcz16ks6CPU320NZDmUakc4ak4Sc=;
        b=E/cLBw/QzkJtgRIZAtWgcb8EGgXxzuerDwt/toKoUTZCkYvUk4HDuOpW+P4/3PDbIF
         5deWvBYMyp8KmneJ3nQKsfj05I6zKRA1UM0mSp4UFCoFwlmfDDhRMhIo62AfhcnGS/8+
         mnHKJ8vnt5JmqjnTaoSnpWhHr/AZz3dI8vdHVLf02jkjlm6g4vQOBNf5moPJUHGaIfRW
         08tQ6NbJCufahqhQZw4r0DEtRaFMI337X5L13gXWXXQ/3H98KT6Nz+VlmvQVe0/XQ+AF
         DyGD4DnT9wwYJFJhq6swFM9tq9vnr+VxElQw39ALY7oPtz6t/ExopK5FZCXmOtFf+QCB
         FU6g==
X-Gm-Message-State: AOJu0YxoCJPpK8upsWcwBGTG7gd5Iecdj6v3al/vCUM5X0REjzkpTvFQ
        b13jZtgMjBULBWnOH5nLuf3Rs+TiI2gU3oFl3Yyd/4+8d9/a37EVo7Y6Hf2ZKw4xE1EMNyxaP5n
        RROIkbr+dML5N0vATiX/rjRci6IjBDqJ4p5ZzYr9FZjmAtDvH9MUHYU0VgsOS
X-Google-Smtp-Source: AGHT+IG6QAy9Fdi0JUJcZIYN2wXGYZH5SR8kKa0FCnK3gziKYK1Gn5/+E/zqQG+/Tj8rDderEnn5/Wsp
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:adf:fa0c:0:b0:314:182c:1a2b with SMTP id
 m12-20020adffa0c000000b00314182c1a2bmr26528wrr.4.1694798231874; Fri, 15 Sep
 2023 10:17:11 -0700 (PDT)
Date:   Fri, 15 Sep 2023 17:16:30 +0000
In-Reply-To: <20230915171623.655440-10-ardb@google.com>
Mime-Version: 1.0
References: <20230915171623.655440-10-ardb@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=4623; i=ardb@kernel.org;
 h=from:subject; bh=hPsLZEg3qTJM8NI0DEH7io0JT9O+qGRluAaJd+WveNE=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIZVlYm5V34V9qbWSHlf8ErRU5s5zncgZN3FX4Cy/1h3/j
 931nnCto5SFQYyDQVZMkUVg9t93O09PlKp1niULM4eVCWQIAxenAExEYzYjw5Tu3LitlwL+bzfa
 vaXxh4T5z8Viq8qep3Q1B37m0z/1mZmR4fm0b715vfw/Jtu9/XJeSXFKeRv3LoWpU2W+yOkd136 bwgUA
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Message-ID: <20230915171623.655440-16-ardb@google.com>
Subject: [PATCH v3 6/8] x86/boot: Drop PE/COFF .reloc section
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

Ancient buggy EFI loaders may have required a .reloc section to be
present at some point in time, but this has not been true for a long
time so the .reloc section can just be dropped.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/header.S      | 20 ------------
 arch/x86/boot/setup.ld      |  4 +--
 arch/x86/boot/tools/build.c | 34 +++-----------------
 3 files changed, 7 insertions(+), 51 deletions(-)

diff --git a/arch/x86/boot/header.S b/arch/x86/boot/header.S
index 2b07bc596c39..9e9641e220a7 100644
--- a/arch/x86/boot/header.S
+++ b/arch/x86/boot/header.S
@@ -155,26 +155,6 @@ section_table:
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
diff --git a/arch/x86/boot/setup.ld b/arch/x86/boot/setup.ld
index 9bd5c1ada599..6d389499565c 100644
--- a/arch/x86/boot/setup.ld
+++ b/arch/x86/boot/setup.ld
@@ -40,8 +40,8 @@ SECTIONS
 		setup_sig = .;
 		LONG(0x5a5aaa55)
 
-		/* Reserve some extra space for the reloc and compat sections */
-		setup_size = ALIGN(ABSOLUTE(.) + 64, 512);
+		/* Reserve some extra space for the compat section */
+		setup_size = ALIGN(ABSOLUTE(.) + 32, 512);
 		setup_sects = ABSOLUTE(setup_size / 512);
 	}
 
diff --git a/arch/x86/boot/tools/build.c b/arch/x86/boot/tools/build.c
index 9712f27e32c1..faccff9743a3 100644
--- a/arch/x86/boot/tools/build.c
+++ b/arch/x86/boot/tools/build.c
@@ -47,7 +47,6 @@ typedef unsigned int   u32;
 /* This must be large enough to hold the entire setup */
 u8 buf[SETUP_SECT_MAX*512];
 
-#define PECOFF_RELOC_RESERVE 0x20
 #define PECOFF_COMPAT_RESERVE 0x20
 
 static unsigned long efi32_pe_entry;
@@ -180,24 +179,13 @@ static void update_pecoff_section_header(char *section_name, u32 offset, u32 siz
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
@@ -214,21 +202,10 @@ static void update_pecoff_setup_and_reloc(unsigned int size)
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
@@ -307,7 +284,6 @@ int main(int argc, char ** argv)
 	fclose(file);
 
 	c += reserve_pecoff_compat_section(c);
-	c += reserve_pecoff_reloc_section(c);
 
 	/* Pad unused space with zeros */
 	setup_sectors = (c + 511) / 512;
@@ -316,7 +292,7 @@ int main(int argc, char ** argv)
 	i = setup_sectors*512;
 	memset(buf+c, 0, i-c);
 
-	update_pecoff_setup_and_reloc(i);
+	update_pecoff_setup(i);
 
 	/* Open and stat the kernel file */
 	fd = open(argv[2], O_RDONLY);
-- 
2.42.0.459.ge4e396fd5e-goog

