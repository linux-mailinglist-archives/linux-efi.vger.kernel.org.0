Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F325621BC9
	for <lists+linux-efi@lfdr.de>; Tue,  8 Nov 2022 19:22:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234769AbiKHSWc (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 8 Nov 2022 13:22:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234755AbiKHSWb (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 8 Nov 2022 13:22:31 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 685052CB
        for <linux-efi@vger.kernel.org>; Tue,  8 Nov 2022 10:22:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 22E7AB81BED
        for <linux-efi@vger.kernel.org>; Tue,  8 Nov 2022 18:22:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20910C433C1;
        Tue,  8 Nov 2022 18:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667931747;
        bh=BEcl9lZv2MCbvNBgvkLCzZ96Z78+ncsINGTKsTvpgMw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KB4gM8NmX7zJG9+E6V2OzY1MeUN4qetsIfYhpSv/miKS2VbyFjT2HFPWZV9Kq5xB7
         c1IJyG1wCNAMAdLHlo2QZSG7SH1r0KXj7hATHHxrfSknI43n0IlMn6yY/UIhCa2B5i
         LVN+8cO77s4ayqmkgajXRLJH7rWbRIYqxVyqiS/r5rG5BUYs9l8qxpiloC43HjRsQG
         fkc3oPL7eOMptKwui0a4lM8L66bWWw6VkEVeLuLLclll3O7verejEZE3m46g47WveV
         AKlODUyDbEvDQr9uYfF65NCLNKOdmRRooQUlQT2EtYefkm03OhSmmTBweqzYIk4SfW
         Dh57DC8BdIRCQ==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-efi@vger.kernel.org, keescook@chromium.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v5 2/7] arm64: kernel: move identity map out of .text mapping
Date:   Tue,  8 Nov 2022 19:21:59 +0100
Message-Id: <20221108182204.2447664-3-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221108182204.2447664-1-ardb@kernel.org>
References: <20221108182204.2447664-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3476; i=ardb@kernel.org; h=from:subject; bh=BEcl9lZv2MCbvNBgvkLCzZ96Z78+ncsINGTKsTvpgMw=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjap5Dd8EYeR6GPhjFwyg/KNACzmWEOF5bzxZkzYKz aUnOLPqJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCY2qeQwAKCRDDTyI5ktmPJB3BC/ 4wRy6sI/iHMYRj/AUBA3eRP5xko6VseCTtEEqLbvGEXOwv1cnYH3S7+dhT+qSz1+nC46AJ5/2JzVKo Ii4fkOxAS+NGPu/BFpiBx3Jb479p5SEtp5Llbuud17a+pFRDbQ6l7LcY5O/o77/zePMHy5afwnruH/ ONdpVcvRY4DC2tckEGiWnYs5JmPN7v/GlfM2md36PAZMJJZ07cvDcpIa/AJSvoUZP+pLs5D3tlfwg2 OnygY8zWRGLUX3CD4odNiQ8RyCC2ulfDj5VyHa0r5e6W41WknLi6ngTtlVFNpsZ9FxOIjJQwpWkxIS V00So6bYMWfwPR4iVxlDcqV8/tJ5pHRbCXE3INdKZp4ntBWtMoVkxI0cmeF2xRh7Io9s9KOxs2aA19 LIlkGNOZt4eP9cd44UzkutkSu8yBrJgz6YbWNmpgVD0qLxGQtHBApFXO2bEE029+fbR86/5+Ozw2O7 De/x1rjw8TXpF0JzU9cZEIUo+H+rPUbSt2Ol6lkvUQzKk=
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

Reorganize the ID map slightly so that only code that is executed with
the MMU off or via the 1:1 mapping remains. This allows us to move the
identity map out of the .text segment, as it will no longer need
executable permissions via the kernel mapping.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/kernel/head.S        | 28 +++++++++++---------
 arch/arm64/kernel/vmlinux.lds.S |  2 +-
 arch/arm64/mm/proc.S            |  2 --
 3 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index c59e0d95b44d0901..272877c5b4fa1203 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -540,19 +540,6 @@ SYM_INNER_LABEL(init_el2, SYM_L_LOCAL)
 	eret
 SYM_FUNC_END(init_kernel_el)
 
-/*
- * Sets the __boot_cpu_mode flag depending on the CPU boot mode passed
- * in w0. See arch/arm64/include/asm/virt.h for more info.
- */
-SYM_FUNC_START_LOCAL(set_cpu_boot_mode_flag)
-	adr_l	x1, __boot_cpu_mode
-	cmp	w0, #BOOT_CPU_MODE_EL2
-	b.ne	1f
-	add	x1, x1, #4
-1:	str	w0, [x1]			// Save CPU boot mode
-	ret
-SYM_FUNC_END(set_cpu_boot_mode_flag)
-
 	/*
 	 * This provides a "holding pen" for platforms to hold all secondary
 	 * cores are held until we're ready for them to initialise.
@@ -596,6 +583,7 @@ SYM_FUNC_START_LOCAL(secondary_startup)
 	br	x8
 SYM_FUNC_END(secondary_startup)
 
+	.text
 SYM_FUNC_START_LOCAL(__secondary_switched)
 	mov	x0, x20
 	bl	set_cpu_boot_mode_flag
@@ -628,6 +616,19 @@ SYM_FUNC_START_LOCAL(__secondary_too_slow)
 	b	__secondary_too_slow
 SYM_FUNC_END(__secondary_too_slow)
 
+/*
+ * Sets the __boot_cpu_mode flag depending on the CPU boot mode passed
+ * in w0. See arch/arm64/include/asm/virt.h for more info.
+ */
+SYM_FUNC_START_LOCAL(set_cpu_boot_mode_flag)
+	adr_l	x1, __boot_cpu_mode
+	cmp	w0, #BOOT_CPU_MODE_EL2
+	b.ne	1f
+	add	x1, x1, #4
+1:	str	w0, [x1]			// Save CPU boot mode
+	ret
+SYM_FUNC_END(set_cpu_boot_mode_flag)
+
 /*
  * The booting CPU updates the failed status @__early_cpu_boot_status,
  * with MMU turned off.
@@ -659,6 +660,7 @@ SYM_FUNC_END(__secondary_too_slow)
  * Checks if the selected granule size is supported by the CPU.
  * If it isn't, park the CPU
  */
+	.section ".idmap.text","awx"
 SYM_FUNC_START(__enable_mmu)
 	mrs	x3, ID_AA64MMFR0_EL1
 	ubfx	x3, x3, #ID_AA64MMFR0_EL1_TGRAN_SHIFT, 4
diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index 45131e354e27f1f8..c7727a1740ce11f5 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -168,7 +168,6 @@ SECTIONS
 			LOCK_TEXT
 			KPROBES_TEXT
 			HYPERVISOR_TEXT
-			IDMAP_TEXT
 			*(.gnu.warning)
 		. = ALIGN(16);
 		*(.got)			/* Global offset table		*/
@@ -195,6 +194,7 @@ SECTIONS
 		TRAMP_TEXT
 		HIBERNATE_TEXT
 		KEXEC_TEXT
+		IDMAP_TEXT
 		. = ALIGN(PAGE_SIZE);
 	}
 
diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index b9ecbbae1e1abca1..d7ca6f23fb0d1334 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -110,7 +110,6 @@ SYM_FUNC_END(cpu_do_suspend)
  *
  * x0: Address of context pointer
  */
-	.pushsection ".idmap.text", "awx"
 SYM_FUNC_START(cpu_do_resume)
 	ldp	x2, x3, [x0]
 	ldp	x4, x5, [x0, #16]
@@ -166,7 +165,6 @@ alternative_else_nop_endif
 	isb
 	ret
 SYM_FUNC_END(cpu_do_resume)
-	.popsection
 #endif
 
 	.pushsection ".idmap.text", "awx"
-- 
2.35.1

