Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC530622D48
	for <lists+linux-efi@lfdr.de>; Wed,  9 Nov 2022 15:16:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbiKIOQW (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 9 Nov 2022 09:16:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiKIOQV (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 9 Nov 2022 09:16:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44009C18
        for <linux-efi@vger.kernel.org>; Wed,  9 Nov 2022 06:16:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DF429B81F00
        for <linux-efi@vger.kernel.org>; Wed,  9 Nov 2022 14:16:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB2DCC433C1;
        Wed,  9 Nov 2022 14:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668003377;
        bh=v64yuFWFeFea3oGTCeciSzpRwhqc7uOuuSTBlkzmr3M=;
        h=From:To:Cc:Subject:Date:From;
        b=ceMAdKnl8v8VKBmHmicL/3fPGgds0eZrGEvg1TUp1SYgkEWMI52Y/+Is1cy7HPFY8
         6r1L9e+GXJrw0CQgqO2QgnesdOYOJFBGFgfspwwkA9f8QDLMdGY7YpeSWpvqyf39L1
         fUm1ZZMX+bZx6PbqbXLPe5z6ksqK80G8zjm3f628rZtWfqDNqCgZ7ytsF+JTrLP883
         3mKeSVTAHzpnUUmwPWO00KBM+sQ+4NB7yJf9l3dIv91aKX8D7MCfVfQWHJdqpxMKIH
         hpu7dE6Ktt2x1G2YJ8qUGnIOMJy3HW834/iNXSnjdCKxmwYCz7XKeQDsaiTuEbw4K3
         e6D6CzvsA4JGA==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     grub-devel@gnu.org, Ard Biesheuvel <ardb@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        Atish Patra <atishp@rivosinc.com>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Daniel Kiper <daniel.kiper@oracle.com>,
        Leif Lindholm <quic_llindhol@quicinc.com>
Subject: [RFC PATCH] efi: Put Linux specific magic number in the DOS header
Date:   Wed,  9 Nov 2022 15:16:11 +0100
Message-Id: <20221109141611.2788009-1-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4819; i=ardb@kernel.org; h=from:subject; bh=v64yuFWFeFea3oGTCeciSzpRwhqc7uOuuSTBlkzmr3M=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBja7YqxUKXUEedQ1tytKUfzP+/ES/yTYBRX2QwUO5l LNrJYgOJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCY2u2KgAKCRDDTyI5ktmPJNlVDA CB3sVoF2WMb3lkvHf4QPLopbIuvCMhIStoEUJoQLCWoTLP5prfE2RD/RMsfVmFpKRhzZ6T/cdFnerg pMMRcI1g6HMGXEcxz4yIrq36YFsd+8BpfeiMOwW+LukXDe0LNRUBxkYuka5UmIFKjMEF2Hp4BbgG15 0Q26xgsW2bUk1OK5BYypON5xP/XkpESrqHC7VwrXz5SNSZSeNK4QZnLiHj6+nBIs/auInW6QzRC0ya OQgO7o9xda8RDk7Lyke9DzZ64kU932Dhh4f5WM66np/f4Y0yPscY+QcuSbptxITEca2ocXD9q1kXTr falRa76houi9Rhbs3NpQQoovLkn/b+RurFkea4cswdjlYthQpaZy8C8ZZcqx6/BPCooec+1cScQT1c vAenJiz4psWs8YrZdqP0M6o4WVHiix3rw0KvLW9flBSIYGMmM8bAMnJl4l3etEmMnl3N9HoMG4fY7L axKostuUqM9OOK0lv9QazJOppy7CvHz+4uP9bwgKMkcEk=
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
metal boot protocol in the same binary.

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
The idea is that, with this in place, the existing arm64 support in GRUB
can be made generic, with the arm64 variant of the arch image header
typedef being made generic as well.

Any code that attempts to identify EFI images as kernel images should
check for the arm64, RISC-V and generic values, and if the latter, look
at the PE machine type if it wants to know the architecture.

 arch/loongarch/kernel/head.S                | 3 ++-
 arch/x86/boot/header.S                      | 3 ++-
 drivers/firmware/efi/libstub/zboot-header.S | 3 ++-
 include/linux/pe.h                          | 7 +++++++
 4 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/arch/loongarch/kernel/head.S b/arch/loongarch/kernel/head.S
index 97425779ce9f3499..e1deea93aaafa069 100644
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
index d31982509654dcb1..9338c68e7413d6e6 100644
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
index 9e6fe061ab07a008..97c2637337d79913 100644
--- a/drivers/firmware/efi/libstub/zboot-header.S
+++ b/drivers/firmware/efi/libstub/zboot-header.S
@@ -20,7 +20,8 @@ __efistub_efi_zboot_header:
 	.long		__efistub__gzdata_size - ZBOOT_SIZE_LEN	// payload size
 	.long		0, 0					// reserved
 	.asciz		COMP_TYPE				// compression type
-	.org		.Ldoshdr + 0x3c
+	.org		.Ldoshdr + 0x38
+	.long		LINUX_PE_MAGIC
 	.long		.Lpehdr - .Ldoshdr			// PE header offset
 
 .Lpehdr:
diff --git a/include/linux/pe.h b/include/linux/pe.h
index 1d3836ef9d92dcd8..fa176c24167c301c 100644
--- a/include/linux/pe.h
+++ b/include/linux/pe.h
@@ -31,6 +31,13 @@
 #define LINUX_EFISTUB_MAJOR_VERSION		0x1
 #define LINUX_EFISTUB_MINOR_VERSION		0x0
 
+/*
+ * LINUX_PE_MAGIC appears at offset 0x30 into the MSDOS header of EFI bootable
+ * Linux kernel images that target the architecture as specified by the PE/COFF
+ * header machine type field.
+ */
+#define LINUX_PE_MAGIC	0x818223cd
+
 #define MZ_MAGIC	0x5a4d	/* "MZ" */
 
 #define PE_MAGIC		0x00004550	/* "PE\0\0" */
-- 
2.35.1

