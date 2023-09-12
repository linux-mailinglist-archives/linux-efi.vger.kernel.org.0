Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 084F279CAFC
	for <lists+linux-efi@lfdr.de>; Tue, 12 Sep 2023 11:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233517AbjILJDI (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 12 Sep 2023 05:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233319AbjILJCC (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 12 Sep 2023 05:02:02 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D1C21727
        for <linux-efi@vger.kernel.org>; Tue, 12 Sep 2023 02:01:58 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-58d9e327d3aso58774377b3.3
        for <linux-efi@vger.kernel.org>; Tue, 12 Sep 2023 02:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694509317; x=1695114117; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0+YGLs65HuKDkoyCmUsNA1LK7hzYTmA6aBZzUDWZlAQ=;
        b=1ew42M7Y55Jzlomdu2tuD/2ewqPkwxAMNOoQpsOdPHJ1IAfI2IizCZ4MwNs65U0G0a
         euHdTFQVuZoknWTunmQTNqjNm1FyFzXfvq0gcCULp/KGbo5JXSTZzGLp8kimbLcPn3PO
         SdDas49TIxERE1IE+DSTBLUgJwcHvzWE9pu6XIPEGUv3CrejSVm4+/9ES+YL4YTTHynS
         oovGXadHuxb/6lEC6BRRGz9gNzWDGywPFwunNeNu1Q8r0eyCKgAB/YBpH4WZNwr+hFV4
         rF400fXCZuRF+k3cfK6kMIXuJmrvpJnwBemjrGpsLD/VeyW+lZerYcONrhaZCi+PmSOg
         F0HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694509317; x=1695114117;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0+YGLs65HuKDkoyCmUsNA1LK7hzYTmA6aBZzUDWZlAQ=;
        b=Qci0FWhfyOVw5vCuGouJWoLZZ2C9Z02gki9lMe9IWK2i5kG3CBSPEtoFJdx2tg7l9Z
         uEYzvuidhKRKW7PErNJkkh0lGLA56SlZ4UGoR8WI8CAbuF8ialpsI7z/PSYmt7e6yvfh
         52apKWPI1bWE6k8th7N58Ap3+okjS0kTPF+CxpOJgIpq4IHwLFUBJWcP6+SOf0A4fwo0
         3j+Jz3CMfFA+JF4aLe2omyxlkAD7lC9MGslxnxX0tqpHyP8dfhW18XIkph7P8ITwp+R8
         NmZ/FIou1eNDMico2bc4eDJ3g4blhGSyq1HdLismuiRsoBRK9hd+gCMSmEGjX5YEDpwp
         Alhg==
X-Gm-Message-State: AOJu0YwQHSgB378FdJuNpodFFOmZWCbp0U6mhtVQ3Dgt21D07ynFHd5E
        JVFL6F2sE2DJ2QYkTK7DnXDwF2h3cF/MrlcfKa3UOhHGuMI5tIILW/CvyFdQ7gBH+InQLcP6a+l
        OKsqMHDquWGUQpEKKEytAJH+rTKHVFMcrr1LSeqJVsHBcDWWZzmL9lpbCHWRu
X-Google-Smtp-Source: AGHT+IF4bojh0hjbNVDzV3nRBLrqzHwOlTccZruY0QAAQsm7RjDQhtfFTvdP590phB7L2bYQboFOgW+U
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:6902:161a:b0:d74:93a1:70a2 with SMTP id
 bw26-20020a056902161a00b00d7493a170a2mr284754ybb.5.1694509317520; Tue, 12 Sep
 2023 02:01:57 -0700 (PDT)
Date:   Tue, 12 Sep 2023 09:01:04 +0000
In-Reply-To: <20230912090051.4014114-17-ardb@google.com>
Mime-Version: 1.0
References: <20230912090051.4014114-17-ardb@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=4623; i=ardb@kernel.org;
 h=from:subject; bh=F2Ts1gQ01OlqtgoyrXYKml6Q50qRYLzdjfB2PktVYD4=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIZVB4/JMvnNrVq0+eXDr4ZcGP7fv32BjycH+2Y4jrsq0s
 D5y35SLHaUsDGIcDLJiiiwCs/++23l6olSt8yxZmDmsTCBDGLg4BWAiYgyMDO+2tJknaVnHucjE
 53/Se+hczvePt1UmeUJegf8j7V4ZdYb/mVJvjgR+cpcIf9e7bu6147U+miKnXl05YLHp4rP5O2d mMgAA
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230912090051.4014114-30-ardb@google.com>
Subject: [PATCH v2 13/15] x86/boot: Drop PE/COFF .reloc section
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
index ae2b5046a0db..9b551eacffa8 100644
--- a/arch/x86/boot/setup.ld
+++ b/arch/x86/boot/setup.ld
@@ -40,8 +40,8 @@ SECTIONS
 		setup_sig = .;
 		LONG(0x5a5aaa55)
 
-		/* reserve some extra space for the reloc and compat sections */
-		setup_size = ABSOLUTE(ALIGN(. + 64, 512));
+		/* reserve some extra space for the compat section */
+		setup_size = ABSOLUTE(ALIGN(. + 32, 512));
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
2.42.0.283.g2d96d420d3-goog

