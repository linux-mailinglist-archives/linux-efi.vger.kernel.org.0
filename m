Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08A315F7C40
	for <lists+linux-efi@lfdr.de>; Fri,  7 Oct 2022 19:29:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbiJGR3m (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 7 Oct 2022 13:29:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiJGR3Z (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 7 Oct 2022 13:29:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02DD7103270
        for <linux-efi@vger.kernel.org>; Fri,  7 Oct 2022 10:29:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9CBD2614D2
        for <linux-efi@vger.kernel.org>; Fri,  7 Oct 2022 17:29:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E533AC433D6;
        Fri,  7 Oct 2022 17:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665163763;
        bh=N5ltRs5q7X3VPb+lVuSQnQLZpa5WDuDMUJkjuBZI4mg=;
        h=From:To:Cc:Subject:Date:From;
        b=qdDOuSVe1PCN32kwEWyMPtEVzyLqD2LcDxhHchEjoDTYE/fUam3QtUAOYnXISHjN4
         h1hNcVMiwaXK3Wh1NBLePlAXPRW5d/acqU9qa7lPjIYdwDsv6gn8RTqYG4vGucSDax
         uwMIMKxdOfBPYhXeoszXvmuDtfPlXc95JKHVx6to20a9KEzbeeVBokqOv7IF2lEVQo
         GdsLuKUqLFovzOdbHqqs06Tfb3cFdApPRYEVnYpDGDbhT/X27m+l3JgSG7pBKb7PUk
         /sOwRgPugCFKHDBsIA348bnUt/wWwXBPDf0V+rOPnoAIzsDx3+JZbFrH0Kqr+WFmAo
         pZIvwgfnNtBnA==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     x86@kernel.org, bp@alien8.de, Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH] efi: x86: Make the deprecated EFI handover protocol optional
Date:   Fri,  7 Oct 2022 19:29:18 +0200
Message-Id: <20221007172918.3131811-1-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5421; i=ardb@kernel.org; h=from:subject; bh=N5ltRs5q7X3VPb+lVuSQnQLZpa5WDuDMUJkjuBZI4mg=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjQGHtHeB29eg1NerPlfqcjAt6zl4JKWqQ0WXx1xCi Ch3to9iJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCY0Bh7QAKCRDDTyI5ktmPJOcpC/ 0X+xyvbDnZk9+whwFa32dnurxKowKMe3Fwn/5JM0c+1tpRF+dIpQHqH+Kfi41qYXWvB4di6yKTtA6y dGXCecYHWFqq+FnOQbHfSTwb1Oa0Fyneyjdyxr1sV4z+Y1+VY0S7WydT0uSEe//FM++QX29xPV7fh5 UEY8ohH2z3Vs8TbXL940EQXXybg+91AwpLY66ZrMXatQ5uPghm0y8omPbX60NTwjXjteYRaaDzx9bi wO/eA6T97Z68TJidAMSIo4+1dWcq9nLv05iydu0bOY01t/SIhGakWME76+IBTdKY1CRylZ2TGFLd03 8du4TeAT/4vf27BTg8WCp4R3CC0AHbvpAqFZ8qmgimt6wORXTcROpH9q2oecBzpQ0FsXcINMRCBCdE koEfRBXeMdNZglbwWQxVJZebOVDoFNkvRtjr4ffX4W4TSbkf4GLmCwVfromHcNLMmzJGo8JpXFksIV P1/Rb0VJuvcmji4JNi14LUAQUn/futgtq/94WHwy2M0h8=
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

The EFI handover protocol permits a bootloader to invoke the kernel as a
EFI PE/COFF application, while passing a bootparams struct as a third
argument to the entrypoint function call.

This has no basis in the UEFI specification, and there are better ways
to pass additional data to a UEFI application (UEFI configuration
tables, UEFI variables, UEFI protocols) than going around the
StartImage() boot service and jumping to a fixed offset in the loaded
image, just to call a different function that takes a third parameter.

The reason for handling struct bootparams in the bootloader was that the
EFI stub could only load initrd images from the EFI system partition,
and so passing it via struct bootparams was needed for loaders like
GRUB, which pass the initrd in memory, and may load it from anywhere,
including from the network. Another motivation was EFI mixed mode, which
could not use the initrd loader in the EFI stub at all due to 32/64 bit
incompatibilities (which will be fixed shortly [0]), and could not
invoke the ordinary PE/COFF entry point either, for the same reasons.

Given that loaders such as GRUB already carried the bootparams handling
in order to implement non-EFI boot, retaining that code and just passing
bootparams to the EFI stub was a reasonable choice (although defining an
alternate entrypoint could have been avoided.) However, the GRUB side
changes never made it upstream, and are only shipped by some of the
distros in their downstream versions.

In the meantime, EFI support has been added to other Linux architecture
ports, as well as to U-boot and systemd, including arch-agnostic methods
for passing initrd images in memory [1], and for doing mixed mode boot
[2], none of them requiring anything like the EFI handover protocol. So
given that only out-of-tree distro GRUB relies on this, let's permit it
to be omitted from the build, in preparation for retiring it completely
at a later date. (Note that systemd-boot does have an implementation as
well, but only uses it as a fallback for booting images that do not
implement the LoadFile2 based initrd loading method, i.e., v5.8 or older)

[0] https://lore.kernel.org/all/20220927085842.2860715-1-ardb@kernel.org/
[1] ec93fc371f01 ("efi/libstub: Add support for loading the initrd ...")
[2] 97aa276579b2 ("efi/x86: Add true mixed mode entry point into ...")

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/Kconfig                   | 12 ++++++++++++
 arch/x86/boot/compressed/head_64.S |  4 +++-
 arch/x86/boot/header.S             |  2 +-
 arch/x86/boot/tools/build.c        |  2 ++
 4 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index f9920f1341c8..0c8fcb090232 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1964,6 +1964,18 @@ config EFI_STUB
 
 	  See Documentation/admin-guide/efi-stub.rst for more information.
 
+config EFI_HANDOVER_PROTOCOL
+	bool "EFI handover protocol (DEPRECATED)"
+	depends on EFI_STUB
+	default y
+	help
+	  Whether to include support for the deprecated EFI handover protocol,
+	  which defines alternative entry points into the EFI stub. This is a
+	  practice that has no basis in the UEFI specification, and requires
+	  a priori knowledge on the part of the bootloader about Linux/x86
+	  specific ways of passing the command line and initrd, and where in
+	  memory those assets may be loaded.
+
 config EFI_MIXED
 	bool "EFI mixed-mode support"
 	depends on EFI_STUB && X86_64
diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index 6ba2c2142c33..7bcc50c6cdcc 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -286,7 +286,7 @@ SYM_FUNC_START(startup_32)
 	lret
 SYM_FUNC_END(startup_32)
 
-#ifdef CONFIG_EFI_MIXED
+#if defined(CONFIG_EFI_MIXED) && defined(CONFIG_EFI_HANDOVER_PROTOCOL)
 	.org 0x190
 SYM_FUNC_START(efi32_stub_entry)
 	add	$0x4, %esp		/* Discard return address */
@@ -516,7 +516,9 @@ trampoline_return:
 SYM_CODE_END(startup_64)
 
 #ifdef CONFIG_EFI_STUB
+#ifdef CONFIG_EFI_HANDOVER_PROTOCOL
 	.org 0x390
+#endif
 SYM_FUNC_START(efi64_stub_entry)
 	and	$~0xf, %rsp			/* realign the stack */
 	movq	%rdx, %rbx			/* save boot_params pointer */
diff --git a/arch/x86/boot/header.S b/arch/x86/boot/header.S
index f912d7770130..d31982509654 100644
--- a/arch/x86/boot/header.S
+++ b/arch/x86/boot/header.S
@@ -406,7 +406,7 @@ xloadflags:
 # define XLF1 0
 #endif
 
-#ifdef CONFIG_EFI_STUB
+#ifdef CONFIG_EFI_HANDOVER_PROTOCOL
 # ifdef CONFIG_EFI_MIXED
 #  define XLF23 (XLF_EFI_HANDOVER_32|XLF_EFI_HANDOVER_64)
 # else
diff --git a/arch/x86/boot/tools/build.c b/arch/x86/boot/tools/build.c
index a3725ad46c5a..bd247692b701 100644
--- a/arch/x86/boot/tools/build.c
+++ b/arch/x86/boot/tools/build.c
@@ -290,6 +290,7 @@ static void efi_stub_entry_update(void)
 {
 	unsigned long addr = efi32_stub_entry;
 
+#ifdef CONFIG_EFI_HANDOVER_PROTOCOL
 #ifdef CONFIG_X86_64
 	/* Yes, this is really how we defined it :( */
 	addr = efi64_stub_entry - 0x200;
@@ -298,6 +299,7 @@ static void efi_stub_entry_update(void)
 #ifdef CONFIG_EFI_MIXED
 	if (efi32_stub_entry != addr)
 		die("32-bit and 64-bit EFI entry points do not match\n");
+#endif
 #endif
 	put_unaligned_le32(addr, &buf[0x264]);
 }
-- 
2.35.1

