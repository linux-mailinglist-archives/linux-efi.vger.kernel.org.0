Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FE464FB85F
	for <lists+linux-efi@lfdr.de>; Mon, 11 Apr 2022 11:52:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237264AbiDKJx6 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 11 Apr 2022 05:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344885AbiDKJwI (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 11 Apr 2022 05:52:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11B9D40E73
        for <linux-efi@vger.kernel.org>; Mon, 11 Apr 2022 02:49:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8608DB8119A
        for <linux-efi@vger.kernel.org>; Mon, 11 Apr 2022 09:49:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68059C385A3;
        Mon, 11 Apr 2022 09:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649670580;
        bh=fQzD5d1wsl8OGJspoUQEe2SoyfGFGbRsvl6hPA5/Iv0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eOSs2ZnwLgLDlLLHUukJd/pE6GFa/wru9bPmC/9iLcCjNGvGDCAlriRy0955hl9HS
         BydPVarwG3DbqQ0HLYaA1J95Ma4nKT7W6cje5MH/ymZW0Or/EauTe74gFlWvX6ELpU
         t6A3jmimcaIk188WGeqpx9p/6AH2B46Jcp+/l/E5TdVqarY/ayJ0GebN91bMclV0G0
         Yl8OsIRKwlfEXDrnL1fZdaCye07bT5zqbZSSuLBAvrGs5VWnutfoqF5qzmchCP0opl
         8TFJCHVuZQGOI5i+WuZa87bbjxEPZr+xxfSVpLKaFNTZMrd7rFhdSWBrXNn+I4Tj+Q
         xfypiD7yUc93g==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v3 24/30] arm64: mm: add support for WXN memory translation attribute
Date:   Mon, 11 Apr 2022 11:48:18 +0200
Message-Id: <20220411094824.4176877-25-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220411094824.4176877-1-ardb@kernel.org>
References: <20220411094824.4176877-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6148; h=from:subject; bh=fQzD5d1wsl8OGJspoUQEe2SoyfGFGbRsvl6hPA5/Iv0=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBiU/ldH8cqdt12fKqmCKvL6mqYMhTkVih595gbZWse 8kWxiOmJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYlP5XQAKCRDDTyI5ktmPJICuDA CyIe6MJmRpZBYpybmRcNonB6f/6IiT3iMVUXFeeN5nPk/23nwfYeA5hkr9q6HTE+Nc9L7QfXLQHj1b JsHQDtmcAwfs5sDKhGrw5hPDPWnIsVe+WGKa8Gher0XM0vPNEclAaj4nhxmNx3/d7JP3KYMnCaRo7x KAGq9W91UMB87Lq6Tc7dNwhyCOKR2WCmmrOZC0LzUEv6tcwL1L34uszNYarDd3ZjesdA37CtVhUKvC GCge/PShx+ntyPl2PHIDUdhMKPMd7CX2GyJRmA0CGOHb4AUA5S56EyjtJJP2OXKuGNfLv37KZ+irVw +Ais61GPtzmMRu/pDx/wJDlM/IlleYBT7Xvpxlyi5yrvWuUKD7E53XB6dnFMFa780TmQMajyqNueTB GnokHOzxE4Y3IK67ex0kaw1ZY8/+ittfVQBJgDHgxfJYVbpg/FCGswSgj5c2lOLvjhhsXiAkTqs67/ TH4xE3GpoCHs28jl/muocOMUNC0z9KRXDUjkMKhN0LV4c=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The AArch64 virtual memory system supports the WXN attribute, which can
be set to make all writable mappings implicitly no-exec. This attribute
applies to both EL0 and EL1 if enabled at EL1, making it problematic in
the general case, as user space may rely on mmap() or mprotect() to
return executable writable memory when asked for it. However, in
specific cases where user space is known not to rely on this, the WXN
can now be enabled, ensuring that inadvertent mistakes in managing
memory permissions do not result in real vulnerabilities.

If enabled at compile time, the feature can still be disabled at boot,
by passing arm64.nowxn on the kernel command line.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/Kconfig                   | 11 +++++++
 arch/arm64/include/asm/mmu_context.h | 31 +++++++++++++++++++-
 arch/arm64/kernel/head.S             | 28 +++++++++++++++++-
 arch/arm64/kernel/idreg-override.c   | 16 ++++++++++
 arch/arm64/mm/proc.S                 |  6 ++++
 5 files changed, 90 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 57c4c995965f..c3f94c94d535 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1411,6 +1411,17 @@ config RODATA_FULL_DEFAULT_ENABLED
 	  This requires the linear region to be mapped down to pages,
 	  which may adversely affect performance in some cases.
 
+config ARM64_WXN
+	bool "Enable WXN attribute so all writable mappings are non-exec"
+	help
+	  Set the WXN bit in the SCTLR system register so that all writable
+	  mappings are treated as if the PXN/UXN bit is set as well.
+	  If this is set to Y, it can still be disabled at runtime by
+	  passing 'arm64.nowxn' on the kernel command line.
+
+	  This should only be set if no software needs to be supported that
+	  relies on being able to execute from writable mappings.
+
 config ARM64_SW_TTBR0_PAN
 	bool "Emulate Privileged Access Never using TTBR0_EL1 switching"
 	help
diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/asm/mmu_context.h
index c7ccd82db1d2..01cb78e153c1 100644
--- a/arch/arm64/include/asm/mmu_context.h
+++ b/arch/arm64/include/asm/mmu_context.h
@@ -19,13 +19,42 @@
 #include <asm/cacheflush.h>
 #include <asm/cpufeature.h>
 #include <asm/proc-fns.h>
-#include <asm-generic/mm_hooks.h>
 #include <asm/cputype.h>
 #include <asm/sysreg.h>
 #include <asm/tlbflush.h>
 
 extern bool rodata_full;
 
+static inline int arch_dup_mmap(struct mm_struct *oldmm,
+				struct mm_struct *mm)
+{
+	return 0;
+}
+
+static inline void arch_exit_mmap(struct mm_struct *mm)
+{
+}
+
+static inline void arch_unmap(struct mm_struct *mm,
+			unsigned long start, unsigned long end)
+{
+}
+
+static inline bool arch_vma_access_permitted(struct vm_area_struct *vma,
+		bool write, bool execute, bool foreign)
+{
+	if (IS_ENABLED(CONFIG_ARM64_WXN) && execute &&
+	    (vma->vm_flags & (VM_WRITE | VM_EXEC)) == (VM_WRITE | VM_EXEC)) {
+		extern struct arm64_ftr_override sctlr_override;
+		pr_warn_ratelimited(
+			"process %s (%d) attempted to execute from writable memory\n",
+			current->comm, current->pid);
+		/* disallow unless the nowxn override is set */
+		return sctlr_override.val & sctlr_override.mask & 0xf;
+	}
+	return true;
+}
+
 static inline void contextidr_thread_switch(struct task_struct *next)
 {
 	if (!IS_ENABLED(CONFIG_PID_IN_CONTEXTIDR))
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 54886c4b6347..cba9a5e8abb8 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -494,6 +494,12 @@ SYM_FUNC_START_LOCAL(__primary_switched)
 	bl	init_feature_override		// Parse cpu feature overrides
 	bl	switch_to_vhe			// Prefer VHE if possible
 	ldp	x29, x30, [sp], #16
+#ifdef CONFIG_ARM64_WXN
+	ldr_l	x1, sctlr_override + FTR_OVR_VAL_OFFSET
+	tbz	x1, #0, 0f
+	blr	lr
+0:
+#endif
 	bl	start_kernel
 	ASM_BUG()
 SYM_FUNC_END(__primary_switched)
@@ -878,5 +884,25 @@ SYM_FUNC_START_LOCAL(__primary_switch)
 
 	ldr	x8, =__primary_switched
 	adrp	x0, __PHYS_OFFSET
-	br	x8
+	blr	x8
+#ifdef CONFIG_ARM64_WXN
+	/*
+	 * If we return here, we need to disable WXN before we proceed. This
+	 * requires the MMU to be disabled, so it needs to occur while running
+	 * from the ID map.
+	 */
+	mrs	x0, sctlr_el1
+	bic	x1, x0, #SCTLR_ELx_M
+	msr	sctlr_el1, x1
+	isb
+
+	tlbi	vmalle1
+	dsb	nsh
+	isb
+
+	bic	x0, x0, #SCTLR_ELx_WXN
+	msr	sctlr_el1, x0
+	isb
+	ret
+#endif
 SYM_FUNC_END(__primary_switch)
diff --git a/arch/arm64/kernel/idreg-override.c b/arch/arm64/kernel/idreg-override.c
index f92836e196e5..85d8fa47d196 100644
--- a/arch/arm64/kernel/idreg-override.c
+++ b/arch/arm64/kernel/idreg-override.c
@@ -94,12 +94,27 @@ static const struct ftr_set_desc kaslr __initconst = {
 	},
 };
 
+#ifdef CONFIG_ARM64_WXN
+asmlinkage struct arm64_ftr_override sctlr_override __ro_after_init;
+static const struct ftr_set_desc sctlr __initconst = {
+	.name		= "sctlr",
+	.override	= &sctlr_override,
+	.fields		= {
+		{ "nowxn", 0 },
+		{}
+	},
+};
+#endif
+
 static const struct ftr_set_desc * const regs[] __initconst = {
 	&mmfr1,
 	&pfr1,
 	&isar1,
 	&isar2,
 	&kaslr,
+#ifdef CONFIG_ARM64_WXN
+	&sctlr,
+#endif
 };
 
 static const struct {
@@ -115,6 +130,7 @@ static const struct {
 	  "id_aa64isar2.gpa3=0 id_aa64isar2.apa3=0"	   },
 	{ "arm64.nomte",		"id_aa64pfr1.mte=0" },
 	{ "nokaslr",			"kaslr.disabled=1" },
+	{ "arm64.nowxn",		"sctlr.nowxn=1" },
 };
 
 static int __init find_field(const char *cmdline,
diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index e802badf9ac0..abc3696bd601 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -495,6 +495,12 @@ SYM_FUNC_START(__cpu_setup)
 	 * Prepare SCTLR
 	 */
 	mov_q	x0, INIT_SCTLR_EL1_MMU_ON
+#ifdef CONFIG_ARM64_WXN
+	ldr_l	x1, sctlr_override + FTR_OVR_VAL_OFFSET
+	tst	x1, #0x1			// WXN disabled on command line?
+	orr	x1, x0, #SCTLR_ELx_WXN
+	csel	x0, x0, x1, ne
+#endif
 	ret					// return to head.S
 
 	.unreq	mair
-- 
2.30.2

