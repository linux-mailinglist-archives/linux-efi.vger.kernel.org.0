Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA0E56658F7
	for <lists+linux-efi@lfdr.de>; Wed, 11 Jan 2023 11:24:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbjAKKYZ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 11 Jan 2023 05:24:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238744AbjAKKXK (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 11 Jan 2023 05:23:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCDA82724
        for <linux-efi@vger.kernel.org>; Wed, 11 Jan 2023 02:23:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6ED82B81B83
        for <linux-efi@vger.kernel.org>; Wed, 11 Jan 2023 10:23:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACE6BC433F0;
        Wed, 11 Jan 2023 10:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673432585;
        bh=QAVUXxCDRWuwV7aGOrjBVI8sIeEhBbQo1rRgIWpqV0k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZYHWcxhvU7sxe8UWttKhZhadO4zQNcpu/tFm+SOZgWMBVhsLHlxHQSqjSayvIMyve
         o4fpj9iW6PL86nwgU3R93p0PxoEZcCritnhtnK3W0j0099csusmshRpS2DqEwqzshj
         qeyB/qmWi92ddFOmyzxLGcxIOR6jhw5orBaCtVPHWV1CW571Q3l/p3cOBuJ/OxQhOn
         jCptFYks35PQr1Wp5G7dIkvpdNH5cLsreCH6HLy7ygvT6PSIKHq4OCPJ6xZ6VpuO96
         NEcX3Ii7QjK7y2RaO852CuYlgOp7qcZXb+zDVyu/yT5t0XGK9ODH8LwY/VIzLhZ3ui
         o2l8AYE2UynJQ==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v7 2/6] arm64: kernel: move identity map out of .text mapping
Date:   Wed, 11 Jan 2023 11:22:32 +0100
Message-Id: <20230111102236.1430401-3-ardb@kernel.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230111102236.1430401-1-ardb@kernel.org>
References: <20230111102236.1430401-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3476; i=ardb@kernel.org; h=from:subject; bh=QAVUXxCDRWuwV7aGOrjBVI8sIeEhBbQo1rRgIWpqV0k=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjvo3l8neFjDYIs7zkDrrSseoYfHhj0YQ3bQELDGjh b6gHl6aJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCY76N5QAKCRDDTyI5ktmPJLyeC/ 0bbksN5WN95KA8vJUU9UMI8V8LkF3KYuCEuGcFOZRy09yG9Oe8htDCi+kzZXVdDnWY8NBFCkfQlI7e oErhMDIfQr+yLHrPJzveJ9vgAiTkxB57oo1Z1D1n7BDraRSJ1Lr4tvZIUxhqWkem0ANyWa83auWpnj SUGfwkSy1kWlBeEQeBXt1jiHCJcdWyBx/K9oFv/u7rycX1B3LP4kqd6nYt735M7aSLDR2wKDb0QETL e3RLXv39lfwcG0YRWtmIOWXJTrRn3sxpKNrXPPFSQq3beOYEsxL1MtBFarZhdKIxI59ZywsbEgvhbI paw8tKBzhRzEVvuv0trSAW0LrVILad7x4HITvRuDGf5NpPKItS9mTAMKaJR7RePL3mKg/CMsCu1xc6 bX9EEcqROeRltuEK65haSm+5E597XV1Xv/d7FSamfi6lwln2c3dNPZT5vDwww+xZ5zQq0OhylRoW0/ ufuUlzIQFsJYXribFsu12TLBCsoETTJ4xkncV44yvXdFg=
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
index c4e12d466a5f35f0..bec97aad092c2b43 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -543,19 +543,6 @@ SYM_INNER_LABEL(init_el2, SYM_L_LOCAL)
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
@@ -599,6 +586,7 @@ SYM_FUNC_START_LOCAL(secondary_startup)
 	br	x8
 SYM_FUNC_END(secondary_startup)
 
+	.text
 SYM_FUNC_START_LOCAL(__secondary_switched)
 	mov	x0, x20
 	bl	set_cpu_boot_mode_flag
@@ -631,6 +619,19 @@ SYM_FUNC_START_LOCAL(__secondary_too_slow)
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
@@ -662,6 +663,7 @@ SYM_FUNC_END(__secondary_too_slow)
  * Checks if the selected granule size is supported by the CPU.
  * If it isn't, park the CPU
  */
+	.section ".idmap.text","awx"
 SYM_FUNC_START(__enable_mmu)
 	mrs	x3, ID_AA64MMFR0_EL1
 	ubfx	x3, x3, #ID_AA64MMFR0_EL1_TGRAN_SHIFT, 4
diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index 4c13dafc98b8400f..407415a5163ab62f 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -179,7 +179,6 @@ SECTIONS
 			LOCK_TEXT
 			KPROBES_TEXT
 			HYPERVISOR_TEXT
-			IDMAP_TEXT
 			*(.gnu.warning)
 		. = ALIGN(16);
 		*(.got)			/* Global offset table		*/
@@ -206,6 +205,7 @@ SECTIONS
 		TRAMP_TEXT
 		HIBERNATE_TEXT
 		KEXEC_TEXT
+		IDMAP_TEXT
 		. = ALIGN(PAGE_SIZE);
 	}
 
diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index 066fa60b93d24827..91410f48809000a0 100644
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
2.39.0

