Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 384DC6658F1
	for <lists+linux-efi@lfdr.de>; Wed, 11 Jan 2023 11:23:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232155AbjAKKXq (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 11 Jan 2023 05:23:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238851AbjAKKXV (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 11 Jan 2023 05:23:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 824D917428
        for <linux-efi@vger.kernel.org>; Wed, 11 Jan 2023 02:23:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2E99CB81B82
        for <linux-efi@vger.kernel.org>; Wed, 11 Jan 2023 10:23:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 504E9C433D2;
        Wed, 11 Jan 2023 10:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673432590;
        bh=vxndewG4Tj6a3zoR49hNOFsyaNKddlGPUkIlzPtr5LI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iy21w4MqXjpOqGNqTDxKLxdLYdU8JAtDtXaLVO1faa7tlafLz65oSMP9fEbDIjo5W
         wWbxSoInWS/F3u3shz3lMRqu1ybFuSe0JcwEhYCyW+Y2tNNEbOV7DwxswEWKpkgZNe
         F60r7U9byMQEZX2IxR2XUj/Ka3jO/dgVqNkKNo9XMkQwU27NM4dWSOFr/Bs+zIhvMR
         BeodmFVnOW69ObFUTX8fGbSAXecUK1GqCtaxNhiqp+u6eWzgvRBJOXQiiusZgRx9Vr
         FHsJyNCEtxQBF2xdhUa8T3JNEbadG84gGuq3FppGsGzmgtE0YZBpDI3vCwQ5Gw2Hp3
         g0gWxrM9ZGpFQ==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v7 5/6] arm64: head: Clean the ID map and the HYP text to the PoC if needed
Date:   Wed, 11 Jan 2023 11:22:35 +0100
Message-Id: <20230111102236.1430401-6-ardb@kernel.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230111102236.1430401-1-ardb@kernel.org>
References: <20230111102236.1430401-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3821; i=ardb@kernel.org; h=from:subject; bh=vxndewG4Tj6a3zoR49hNOFsyaNKddlGPUkIlzPtr5LI=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjvo3qIy2fiLcaNpqhBs7kgzKB2WYiFltraxihFsv6 FdVp6BOJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCY76N6gAKCRDDTyI5ktmPJDiiC/ 9S0Kc1jNy0PH5tcHm7abyJsI2FaRGTRrV8+FZAsvQVgFojXLiQ1NtRui1kbjIVp4zqx3K2oLn8Z9RJ z6RDR+O87Dgftrjb+0xkSSHEHJAWumdlYzTo4ROMMUi2SqIYuez1OF7dHsNYg6Nh+6cRY7UCIY+Uj/ R/VDRKbo03P2tlR8Omyso8RhK0myDqpjHbqaC+DLZycw2rq/nhdppgw34YkXH8mvmdMBY7K4nqMCFx 6TH3UQpxwFHzSnhV+NdEY9w8aqlSpq/MUbjh2WfAOa1RI8XEwowvrUlPZjgb0hROgsd9fu9j1rOH3m V74srNzSYrZrAAkgaM5koDIiZCZbcn4h+Z1YGtgenEPvxbOetgimLsHEMcBYIu0nSPklQTuyww6/PC utNOLB2puVBiRI5W5Gxhmcii7zUOcZx9QngZ5b6w/XuQ8WB0y8aOjHRpFo7cePK1uOu5QZOBq3KiXA z1MHoSzjDWlCPzJS1A5Lqmw+fozkDPx/XNyXwzW66VcIU=
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

If we enter with the MMU and caches enabled, the bootloader may not have
performed any cache maintenance to the PoC. So clean the ID mapped page
to the PoC, to ensure that instruction and data accesses with the MMU
off see the correct data. For similar reasons, clean all the HYP text to
the PoC as well when entering at EL2 with the MMU and caches enabled.

Note that this means primary_entry() itself needs to be moved into the
ID map as well, as we will return from init_kernel_el() with the MMU and
caches off.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/kernel/head.S  | 31 +++++++++++++++++---
 arch/arm64/kernel/sleep.S |  1 +
 2 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index d75f419206451d07..dc56e1d8f36eb387 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -70,7 +70,7 @@
 
 	__EFI_PE_HEADER
 
-	__INIT
+	.section ".idmap.text","awx"
 
 	/*
 	 * The following callee saved general purpose registers are used on the
@@ -90,6 +90,17 @@ SYM_CODE_START(primary_entry)
 	bl	record_mmu_state
 	bl	preserve_boot_args
 	bl	create_idmap
+
+	/*
+	 * If we entered with the MMU and caches on, clean the ID mapped part
+	 * of the primary boot code to the PoC so we can safely execute it with
+	 * the MMU off.
+	 */
+	cbz	x19, 0f
+	adrp	x0, __idmap_text_start
+	adr_l	x1, __idmap_text_end
+	bl	dcache_clean_poc
+0:	mov	x0, x19
 	bl	init_kernel_el			// w0=cpu_boot_mode
 	mov	x20, x0
 
@@ -111,6 +122,7 @@ SYM_CODE_START(primary_entry)
 	b	__primary_switch
 SYM_CODE_END(primary_entry)
 
+	__INIT
 SYM_CODE_START_LOCAL(record_mmu_state)
 	mrs	x19, CurrentEL
 	cmp	x19, #CurrentEL_EL2
@@ -507,10 +519,12 @@ SYM_FUNC_END(__primary_switched)
  * Returns either BOOT_CPU_MODE_EL1 or BOOT_CPU_MODE_EL2 in x0 if
  * booted in EL1 or EL2 respectively, with the top 32 bits containing
  * potential context flags. These flags are *not* stored in __boot_cpu_mode.
+ *
+ * x0: whether we are being called from the primary boot path with the MMU on
  */
 SYM_FUNC_START(init_kernel_el)
-	mrs	x0, CurrentEL
-	cmp	x0, #CurrentEL_EL2
+	mrs	x1, CurrentEL
+	cmp	x1, #CurrentEL_EL2
 	b.eq	init_el2
 
 SYM_INNER_LABEL(init_el1, SYM_L_LOCAL)
@@ -525,6 +539,14 @@ SYM_INNER_LABEL(init_el1, SYM_L_LOCAL)
 	eret
 
 SYM_INNER_LABEL(init_el2, SYM_L_LOCAL)
+	msr	elr_el2, lr
+
+	// clean all HYP code to the PoC if we booted at EL2 with the MMU on
+	cbz	x0, 0f
+	adrp	x0, __hyp_idmap_text_start
+	adr_l	x1, __hyp_text_end
+	bl	dcache_clean_poc
+0:
 	mov_q	x0, HCR_HOST_NVHE_FLAGS
 	msr	hcr_el2, x0
 	isb
@@ -558,7 +580,6 @@ SYM_INNER_LABEL(init_el2, SYM_L_LOCAL)
 	msr	sctlr_el1, x1
 	mov	x2, xzr
 2:
-	msr	elr_el2, lr
 	mov	w0, #BOOT_CPU_MODE_EL2
 	orr	x0, x0, x2
 	eret
@@ -569,6 +590,7 @@ SYM_FUNC_END(init_kernel_el)
 	 * cores are held until we're ready for them to initialise.
 	 */
 SYM_FUNC_START(secondary_holding_pen)
+	mov	x0, xzr
 	bl	init_kernel_el			// w0=cpu_boot_mode
 	mrs	x2, mpidr_el1
 	mov_q	x1, MPIDR_HWID_BITMASK
@@ -586,6 +608,7 @@ SYM_FUNC_END(secondary_holding_pen)
 	 * be used where CPUs are brought online dynamically by the kernel.
 	 */
 SYM_FUNC_START(secondary_entry)
+	mov	x0, xzr
 	bl	init_kernel_el			// w0=cpu_boot_mode
 	b	secondary_startup
 SYM_FUNC_END(secondary_entry)
diff --git a/arch/arm64/kernel/sleep.S b/arch/arm64/kernel/sleep.S
index 7b7c56e048346e97..2ae7cff1953aaf87 100644
--- a/arch/arm64/kernel/sleep.S
+++ b/arch/arm64/kernel/sleep.S
@@ -99,6 +99,7 @@ SYM_FUNC_END(__cpu_suspend_enter)
 
 	.pushsection ".idmap.text", "awx"
 SYM_CODE_START(cpu_resume)
+	mov	x0, xzr
 	bl	init_kernel_el
 	mov	x19, x0			// preserve boot mode
 #if VA_BITS > 48
-- 
2.39.0

