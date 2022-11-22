Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96ABE634115
	for <lists+linux-efi@lfdr.de>; Tue, 22 Nov 2022 17:12:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233120AbiKVQMS (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 22 Nov 2022 11:12:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233774AbiKVQLn (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 22 Nov 2022 11:11:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A07374ABB;
        Tue, 22 Nov 2022 08:11:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3379D61792;
        Tue, 22 Nov 2022 16:11:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF4A0C433D6;
        Tue, 22 Nov 2022 16:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669133470;
        bh=del+B43pK6TaccphvXJ28jvfSBKGUxy0I/ywjkZvIh4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ghf5qSEjhCwO8mImCexfclPr2cgk8g7ybZwCCDfsU2JnXT9uDwY22pj+sXZVrItjy
         gO3ZiYewO5cehMYcpk6b0fJKtmYzUEXYmxTYNvtceezVHPzFCTV3w7heQyfqAGs7RL
         aPPm5fYdZV4dKcAgWbWoqnukRCpcK0pgxjTk9GfbnCwmHD2O+yD1lx52n5Tl5F+lfb
         ox+ylrMMBqTPNwOMsjdjN3MgGT+7JLW7ncndCFDn2AZ0IOB34mZkIqd3ZlVqbIQcaw
         ag6ZvVY269JHRuHj7dhFSvA2XLV8BzG915R8giWuoegS/Qv1s5sCsKDvSxWMUvLv5v
         hzIpjPQTRIr/g==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michael Roth <michael.roth@amd.com>
Subject: [PATCH v3 17/17] efi: x86: Make the deprecated EFI handover protocol optional
Date:   Tue, 22 Nov 2022 17:10:17 +0100
Message-Id: <20221122161017.2426828-18-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221122161017.2426828-1-ardb@kernel.org>
References: <20221122161017.2426828-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5730; i=ardb@kernel.org; h=from:subject; bh=del+B43pK6TaccphvXJ28jvfSBKGUxy0I/ywjkZvIh4=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjfPRoPMfnVKZwz5TVDvfM40lKX97xivaJebCGV9yg 0jObB5uJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCY3z0aAAKCRDDTyI5ktmPJAiEC/ 0WnKjV6l38MPlBU5LQOa2epZox5wXjIBSu8wF6UL6c4k/Zx24rnjzt3ZHyakoT5fqvVxFlRiSiLXSd oGqf7/kd+/rzlJTZkpFiXXU8Lvy0uFQNY+MDCWkEavdh9cr5KcR8+WMbYnlZVXE+LMBo77h5Wg8J5F /kwUsYxFROg31iCQ6bKEOFSS4qvH9uGApGyY9+Mzci45PfrmgN6N3JAffKBnePjQAE6inOvojvRdc8 uDzX7Qf0yofJuJXlxze2kNQC4JXQfbF45oz9N88sboM4xy1D/kpN1mHP0nWtbyaVBDUBtUmPItOU2G OR1Mu8QCYSM3EpharKpESrb9J/A2YDiV3S/MN+pfz8SoNEZbamfulQs8+ojdcIE+OA/uz5rnwy6+aU 6E693wigxKwYEsEPsPgxBtd6N1SlirYo0sLqrJzH3hHPK2vGx3dlJlqt2QGDj7ofJXRW+yN9gTMpzQ pV6cOaIHtCL/RGw310nCHzrSTUtyg42DV2CLmijs7xt9E=
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
 arch/x86/Kconfig                   | 17 +++++++++++++++++
 arch/x86/boot/compressed/head_64.S |  4 +++-
 arch/x86/boot/header.S             |  2 +-
 arch/x86/boot/tools/build.c        |  2 ++
 4 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 8c6da5e42d5a6c25..121f1fdca3145fd2 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1981,6 +1981,23 @@ config EFI_STUB
 
 	  See Documentation/admin-guide/efi-stub.rst for more information.
 
+config EFI_HANDOVER_PROTOCOL
+	bool "EFI handover protocol (DEPRECATED)"
+	depends on EFI_STUB
+	default y
+	help
+	  Select this in order to include support for the deprecated EFI
+	  handover protocol, which defines alternative entry points into the
+	  EFI stub.  This is a practice that has no basis in the UEFI
+	  specification, and requires a priori knowledge on the part of the
+	  bootloader about Linux/x86 specific ways of passing the command line
+	  and initrd, and where in memory those assets may be loaded.
+
+	  If in doubt, say Y. Even though he corresponding support is not
+	  present in upstream GRUB or other bootloaders, most distros build
+	  GRUB with numerous downstream patches applied, and may rely on the
+	  handover protocol as as result.
+
 config EFI_MIXED
 	bool "EFI mixed-mode support"
 	depends on EFI_STUB && X86_64
diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index dd18216cff5c37e0..a75712991df3e936 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -294,7 +294,7 @@ SYM_FUNC_START(startup_32)
 	lret
 SYM_FUNC_END(startup_32)
 
-#ifdef CONFIG_EFI_MIXED
+#if IS_ENABLED(CONFIG_EFI_MIXED) && IS_ENABLED(CONFIG_EFI_HANDOVER_PROTOCOL)
 	.org 0x190
 SYM_FUNC_START(efi32_stub_entry)
 	add	$0x4, %esp		/* Discard return address */
@@ -524,7 +524,9 @@ trampoline_return:
 SYM_CODE_END(startup_64)
 
 #ifdef CONFIG_EFI_STUB
+#ifdef CONFIG_EFI_HANDOVER_PROTOCOL
 	.org 0x390
+#endif
 SYM_FUNC_START(efi64_stub_entry)
 	and	$~0xf, %rsp			/* realign the stack */
 	movq	%rdx, %rbx			/* save boot_params pointer */
diff --git a/arch/x86/boot/header.S b/arch/x86/boot/header.S
index f912d777013052ea..d31982509654dcb1 100644
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
index a3725ad46c5a0b49..bd247692b70174f0 100644
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

