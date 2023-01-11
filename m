Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FFAC6658F0
	for <lists+linux-efi@lfdr.de>; Wed, 11 Jan 2023 11:23:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231635AbjAKKXp (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 11 Jan 2023 05:23:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238775AbjAKKXT (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 11 Jan 2023 05:23:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B229C1086
        for <linux-efi@vger.kernel.org>; Wed, 11 Jan 2023 02:23:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4B490B81AD7
        for <linux-efi@vger.kernel.org>; Wed, 11 Jan 2023 10:23:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B8B7C433D2;
        Wed, 11 Jan 2023 10:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673432587;
        bh=BOt6c+2RF+84vPxtyGYUj3cIVhtd3pC3TsOWFZyZWWM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oEVmFygHLf2zDgGohb5tjUkZJVs1u3d62/BF3cawnzKYk4Q3SJ3fYetC0JUQjz3mf
         8HD4MYV7+uKlAsQnNd9Kd3n1qogryWyJ2+z9yryIh9pfffHqD2jjEU3lRKfPlxewPt
         vMVcwFK8L59fkFfzu0lOL7mu9gqlVpMdhthechh8wC6WfJQLMtmdu82bc/oALkkUvw
         0BftcXO5o0VMs8viQtSm6Paux5jrv8Gm9LbxMJ6lwnAZ+wbaJ096Xgy8Sr9m3JLSE7
         BueLYXkUE8BkVfPjmFRlEzuHnkDGW9CJ4SZSNR5AjOGAAxOb+ZVFq40lTYFJcuuShX
         rTvb1OaoFC8JA==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v7 3/6] arm64: head: record the MMU state at primary entry
Date:   Wed, 11 Jan 2023 11:22:33 +0100
Message-Id: <20230111102236.1430401-4-ardb@kernel.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230111102236.1430401-1-ardb@kernel.org>
References: <20230111102236.1430401-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5007; i=ardb@kernel.org; h=from:subject; bh=BOt6c+2RF+84vPxtyGYUj3cIVhtd3pC3TsOWFZyZWWM=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjvo3ntYaSlD+pKyfs1qnjPSt2PzDsxSuPbWQBDYry lNrDEK6JAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCY76N5wAKCRDDTyI5ktmPJPHCDA Cu9HzgHD2ViP4G9cBd7wVsqRKp2doAbT/XdkBTViBD37152aTkcy31c64hmc69yPaQ+g0EQqgG1ylf r93s5kPamXDvPoLORdorZe+LTF8hNiaIdA0xR0jNVIBciZGg2Frndx5iQE+NsxJEcDEbGGa1drQyaM XfC5WJNaemnzVlYyNb01Cj/9fkkByoJ25MlwpTrl4Zofh8oQAWqbbH+eOjVYAS2+/y9eYj0fJYzUW2 tSzqwEvW/S7QXEEiKtZMiebLYuT/mHn0W9SwSXhE7dZGUlRf4ncnFohYRqoYJhLiDhKk2zbkyHNf10 i+wVsVUeIFeC4ADd2Pb2tyhda5W+D1pka1ucGT2UDahaqpeA+a1UK/bcRwT+wFdHljg07EPIS2pR4K 0f45sZlj/8Y73GpYXk6sIb0vtY+eiDoWH/oP3sB+XrVasm7UDQukaS6nVqI8md7DLJe/1nhhOKgsS3 qSpBZuFE17EEA4jGUvAhACL/RE6Ma48yHLR0Wn3APzZ4o=
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

Prepare for being able to deal with primary entry with the MMU and
caches enabled, by recording whether or not we entered with the MMU on
in register x19 and in a global variable. (Note that setting this
variable to '1' does not require cache invalidation, nor is it required
for storing the bootargs in that case, so omit the cache maintenance).

Since boot with the MMU and caches enabled is not permitted by the bare
metal boot protocol, ensure that a diagnostic is emitted and a taint bit
set if the MMU was found to be enabled on a non-EFI boot, and panic()
once the console is likely to be up. We will make an exception for EFI
boot later, which has strict requirements for the mapping of system
memory, permitting us to relax the boot protocol and hand over from the
EFI stub to the core kernel with MMU and caches left enabled.

While at it, add 'pre_disable_mmu_workaround' macro invocations to
init_kernel_el, as its manipulation of SCTLR_ELx may amount to disabling
of the MMU after subsequent patches.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/kernel/head.S  | 20 ++++++++++++++++++++
 arch/arm64/kernel/setup.c | 17 +++++++++++++++--
 2 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index bec97aad092c2b43..c3b898efd3b5288d 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -77,6 +77,7 @@
 	 * primary lowlevel boot path:
 	 *
 	 *  Register   Scope                      Purpose
+	 *  x19        primary_entry() .. start_kernel()        whether we entered with the MMU on
 	 *  x20        primary_entry() .. __primary_switch()    CPU boot mode
 	 *  x21        primary_entry() .. start_kernel()        FDT pointer passed at boot in x0
 	 *  x22        create_idmap() .. start_kernel()         ID map VA of the DT blob
@@ -86,6 +87,7 @@
 	 *  x28        create_idmap()                           callee preserved temp register
 	 */
 SYM_CODE_START(primary_entry)
+	bl	record_mmu_state
 	bl	preserve_boot_args
 	bl	init_kernel_el			// w0=cpu_boot_mode
 	mov	x20, x0
@@ -109,6 +111,18 @@ SYM_CODE_START(primary_entry)
 	b	__primary_switch
 SYM_CODE_END(primary_entry)
 
+SYM_CODE_START_LOCAL(record_mmu_state)
+	mrs	x19, CurrentEL
+	cmp	x19, #CurrentEL_EL2
+	mrs	x19, sctlr_el1
+	b.ne	0f
+	mrs	x19, sctlr_el2
+0:	tst	x19, #SCTLR_ELx_C		// Z := (C == 0)
+	and	x19, x19, #SCTLR_ELx_M		// isolate M bit
+	csel	x19, xzr, x19, eq		// clear x19 if Z
+	ret
+SYM_CODE_END(record_mmu_state)
+
 /*
  * Preserve the arguments passed by the bootloader in x0 .. x3
  */
@@ -119,11 +133,14 @@ SYM_CODE_START_LOCAL(preserve_boot_args)
 	stp	x21, x1, [x0]			// x0 .. x3 at kernel entry
 	stp	x2, x3, [x0, #16]
 
+	cbnz	x19, 0f				// skip cache invalidation if MMU is on
 	dmb	sy				// needed before dc ivac with
 						// MMU off
 
 	add	x1, x0, #0x20			// 4 x 8 bytes
 	b	dcache_inval_poc		// tail call
+0:	str_l   x19, mmu_enabled_at_boot, x0
+	ret
 SYM_CODE_END(preserve_boot_args)
 
 SYM_FUNC_START_LOCAL(clear_page_tables)
@@ -497,6 +514,7 @@ SYM_FUNC_START(init_kernel_el)
 
 SYM_INNER_LABEL(init_el1, SYM_L_LOCAL)
 	mov_q	x0, INIT_SCTLR_EL1_MMU_OFF
+	pre_disable_mmu_workaround
 	msr	sctlr_el1, x0
 	isb
 	mov_q	x0, INIT_PSTATE_EL1
@@ -529,11 +547,13 @@ SYM_INNER_LABEL(init_el2, SYM_L_LOCAL)
 	cbz	x0, 1f
 
 	/* Set a sane SCTLR_EL1, the VHE way */
+	pre_disable_mmu_workaround
 	msr_s	SYS_SCTLR_EL12, x1
 	mov	x2, #BOOT_CPU_FLAG_E2H
 	b	2f
 
 1:
+	pre_disable_mmu_workaround
 	msr	sctlr_el1, x1
 	mov	x2, xzr
 2:
diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index 12cfe9d0d3fac10d..b8ec7b3ac9cbe8a8 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -58,6 +58,7 @@ static int num_standard_resources;
 static struct resource *standard_resources;
 
 phys_addr_t __fdt_pointer __initdata;
+u64 mmu_enabled_at_boot __initdata;
 
 /*
  * Standard memory resources
@@ -332,8 +333,12 @@ void __init __no_sanitize_address setup_arch(char **cmdline_p)
 	xen_early_init();
 	efi_init();
 
-	if (!efi_enabled(EFI_BOOT) && ((u64)_text % MIN_KIMG_ALIGN) != 0)
-	     pr_warn(FW_BUG "Kernel image misaligned at boot, please fix your bootloader!");
+	if (!efi_enabled(EFI_BOOT)) {
+		if ((u64)_text % MIN_KIMG_ALIGN)
+			pr_warn(FW_BUG "Kernel image misaligned at boot, please fix your bootloader!");
+		WARN_TAINT(mmu_enabled_at_boot, TAINT_FIRMWARE_WORKAROUND,
+			   FW_BUG "Booted with MMU enabled!");
+	}
 
 	arm64_memblock_init();
 
@@ -442,3 +447,11 @@ static int __init register_arm64_panic_block(void)
 	return 0;
 }
 device_initcall(register_arm64_panic_block);
+
+static int __init check_mmu_enabled_at_boot(void)
+{
+	if (!efi_enabled(EFI_BOOT) && mmu_enabled_at_boot)
+		panic("Non-EFI boot detected with MMU and caches enabled");
+	return 0;
+}
+device_initcall_sync(check_mmu_enabled_at_boot);
-- 
2.39.0

