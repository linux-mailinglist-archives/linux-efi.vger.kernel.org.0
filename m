Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 438A163C6E2
	for <lists+linux-efi@lfdr.de>; Tue, 29 Nov 2022 18:56:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235506AbiK2R4g (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 29 Nov 2022 12:56:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233673AbiK2R4b (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 29 Nov 2022 12:56:31 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 580B942F70
        for <linux-efi@vger.kernel.org>; Tue, 29 Nov 2022 09:56:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DAC57B817C0
        for <linux-efi@vger.kernel.org>; Tue, 29 Nov 2022 17:56:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED93EC43470;
        Tue, 29 Nov 2022 17:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669744587;
        bh=UX93Xl8KiBVbp6MazX5tzLKdEIA++jV0RAYgrrZ5i2M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OBac+tSVeFqBfQB+2X2sWffQraGRVsXOIsJWPNIEYbLpwFjL1ssaWlMAqitscl/X8
         5LHdtDozX95JodfIi6YU0MFb5XqlVec647PEWHhFWi48Gq/zC7c6xiwlgR612JyG2h
         U8vGf1lRNYaNFZwoXk+1px0ZPTW3A3x/OykxyNhQ3QEa0/1O7FEteNbMidg1Htwpe3
         Y0REgcjaKRXuBe27mr5YHTG6cjp9x67Se77yeO6Ro6MR9oocz75b7EiTm1Sr9S0wCh
         mRj5l/pAx0XMftJPqIZGyuG2a4hPOyBOu2eQqm0/IeNTvLqM3d+pd3tU0dJVSMqkR+
         xPW1/cg8JKQpg==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     grub-devel@gnu.org, Ard Biesheuvel <ardb@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        Atish Patra <atishp@rivosinc.com>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Daniel Kiper <daniel.kiper@oracle.com>,
        Leif Lindholm <quic_llindhol@quicinc.com>
Subject: [PATCH v2 2/2] efi: Put Linux specific magic number in the DOS header
Date:   Tue, 29 Nov 2022 18:56:16 +0100
Message-Id: <20221129175616.2089294-3-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221129175616.2089294-1-ardb@kernel.org>
References: <20221129175616.2089294-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4801; i=ardb@kernel.org; h=from:subject; bh=UX93Xl8KiBVbp6MazX5tzLKdEIA++jV0RAYgrrZ5i2M=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjhke/31BoxRvtCpCKP6kv/TAGn3cFwzp0iDpBEqkL oY4sT8+JAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCY4ZHvwAKCRDDTyI5ktmPJCxTC/ 0U7ixjpXqIqJ7gPITFYfkKCvZ9C4nWPxVUK3nN02pMkWmYpTXd9NgPFlvtIr7+lLkF8BunhBzvejM/ s/J/zztSFSAe4o8CCELsbY7Ivhostrwcd5UHI/BNu5j31Hq0cI5X49LkdCC6FRpPaycu40q7Dor7qS vsszvG7bV/A/0ZVYI44YKzA71j6+cVZXmAh6i+xJTBAAw2yPbmdqZiHJudsUxJxsVs9uttwHNLXmv6 /U02+6jG9uOiGisQfWJWxLLJ7bwxOiqCv5rO8cQyi3IM6x3T4Yt5zVikz13pk5bQNm7zQF6D+5hEiW 52EKK3CLZjfsJCid8XgjLSXqjUAOujkyozuQcdjZYSGo/vxoaifAaX0x8SdNzUfvIHcNp8AeuMuc8T l/w19gEpyjTI5pVV43Di0LquoaOhZLRWaFj1xUkzDuLFBVe0i+bivheYVYMfP4R3svLKI+MaCcEVNx WAysVIxpgq10TyuvRVFXw43UiLSOVDEpLBfv2r7EHwaIM=
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

GRUB currently relies on the magic number in the image header of ARM and
arm64 EFI kernel images to decide whether or not the image in question
is a bootable kernel.

However, the purpose of the magic number is to identify the image as one
that implements the bare metal boot protocol, and so GRUB, which only
does EFI boot, can only boot images that could potentially be booted in
a non-EFI manner as well.

This is problematic for the new zboot decompressor image format, as it
can only boot in EFI mode, and must therefore not use the bare metal
boot magic number in its header.

For this reason, the strict magic number was dropped from GRUB, to
permit essentially any kind of EFI executable to be booted via the
'linux' command, blurring the line between the linux loader and the
chainloader.

So let's use the same field in the DOS header that RISC-V and arm64
already use for their 'bare metal' magic numbers to store a 'generic
Linux kernel' magic number, which can be used to identify bootable
kernel images in PE format which don't necessarily implement a bare
metal boot protocol in the same binary. Note that, in the context of
EFI, the MSDOS header is only described in terms of the fields that it
shares with the hybrid PE/COFF image format, (i.e., the magic number at
offset #0 and the PE header offset at byte offset #0x3c). Since we aim
for compatibility with EFI only, and not with MS-DOS or MS-Windows, we
can use the remaining space in the MS-DOS header however we want.

Let's set the generic magic number for x86 images as well: existing
bootloaders already have their own methods to identify x86 Linux images
that can be booted in a non-EFI manner, and having the magic number in
place there will ease any future transitions in loader implementations
to merge the x86 and non-x86 EFI boot paths.

Note that 32-bit ARM already uses the same location in the header for a
different purpose, but the ARM support is already widely implemented and
the EFI zboot decompressor is not available on ARM anyway, so we just
disregard it here.

Cc: Huacai Chen <chenhuacai@kernel.org>
Cc: Atish Patra <atishp@rivosinc.com>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Daniel Kiper <daniel.kiper@oracle.com>
Cc: Leif Lindholm <quic_llindhol@quicinc.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/loongarch/kernel/head.S                | 3 ++-
 arch/x86/boot/header.S                      | 3 ++-
 drivers/firmware/efi/libstub/zboot-header.S | 3 ++-
 include/linux/pe.h                          | 7 +++++++
 4 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/arch/loongarch/kernel/head.S b/arch/loongarch/kernel/head.S
index 84970e2666588963..caa74439700eee93 100644
--- a/arch/loongarch/kernel/head.S
+++ b/arch/loongarch/kernel/head.S
@@ -25,7 +25,8 @@ _head:
 	.dword	kernel_entry		/* Kernel entry point */
 	.dword	_end - _text		/* Kernel image effective size */
 	.quad	0			/* Kernel image load offset from start of RAM */
-	.org	0x3c			/* 0x20 ~ 0x3b reserved */
+	.org	0x38			/* 0x20 ~ 0x38 reserved */
+	.long	LINUX_PE_MAGIC
 	.long	pe_header - _head	/* Offset to the PE header */
 
 pe_header:
diff --git a/arch/x86/boot/header.S b/arch/x86/boot/header.S
index f912d777013052ea..be8f78a7ee325475 100644
--- a/arch/x86/boot/header.S
+++ b/arch/x86/boot/header.S
@@ -80,10 +80,11 @@ bs_die:
 	ljmp	$0xf000,$0xfff0
 
 #ifdef CONFIG_EFI_STUB
-	.org	0x3c
+	.org	0x38
 	#
 	# Offset to the PE header.
 	#
+	.long	LINUX_PE_MAGIC
 	.long	pe_header
 #endif /* CONFIG_EFI_STUB */
 
diff --git a/drivers/firmware/efi/libstub/zboot-header.S b/drivers/firmware/efi/libstub/zboot-header.S
index bc2d7750d7f14174..ec4525d40e0cf6d6 100644
--- a/drivers/firmware/efi/libstub/zboot-header.S
+++ b/drivers/firmware/efi/libstub/zboot-header.S
@@ -20,7 +20,8 @@ __efistub_efi_zboot_header:
 	.long		__efistub__gzdata_size - 12		// payload size
 	.long		0, 0					// reserved
 	.asciz		COMP_TYPE				// compression type
-	.org		.Ldoshdr + 0x3c
+	.org		.Ldoshdr + 0x38
+	.long		LINUX_PE_MAGIC
 	.long		.Lpehdr - .Ldoshdr			// PE header offset
 
 .Lpehdr:
diff --git a/include/linux/pe.h b/include/linux/pe.h
index 056a1762de904fc1..1db4c944efd78f51 100644
--- a/include/linux/pe.h
+++ b/include/linux/pe.h
@@ -31,6 +31,13 @@
 #define LINUX_EFISTUB_MAJOR_VERSION		0x1
 #define LINUX_EFISTUB_MINOR_VERSION		0x1
 
+/*
+ * LINUX_PE_MAGIC appears at offset 0x38 into the MSDOS header of EFI bootable
+ * Linux kernel images that target the architecture as specified by the PE/COFF
+ * header machine type field.
+ */
+#define LINUX_PE_MAGIC	0x818223cd
+
 #define MZ_MAGIC	0x5a4d	/* "MZ" */
 
 #define PE_MAGIC		0x00004550	/* "PE\0\0" */
-- 
2.35.1

