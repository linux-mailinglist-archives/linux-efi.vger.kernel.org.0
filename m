Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50E4268BD49
	for <lists+linux-efi@lfdr.de>; Mon,  6 Feb 2023 13:50:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbjBFMt7 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 6 Feb 2023 07:49:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbjBFMt6 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 6 Feb 2023 07:49:58 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3543B1114F
        for <linux-efi@vger.kernel.org>; Mon,  6 Feb 2023 04:49:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BC3AE60EC8
        for <linux-efi@vger.kernel.org>; Mon,  6 Feb 2023 12:49:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBA93C433D2;
        Mon,  6 Feb 2023 12:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675687795;
        bh=ypWkLVzNr8Pt3z1+YR2rB/b3lXmmDLV8gRNYhHND/+o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=alfOiNDKwAXNsakfgOeYLLtyjcwJwmDp9BGPONtdAJM1aLl4LcNoxAI9d3tl02p5p
         h05uZeCJReoMDVatWkVqHXAYnpOvqqQp3T+GVms+/R3fkbCvUa/XRuYu2dpE0qn3kA
         9bKMgjDfw5mHr4EkmrPyrF9NthsBiVuog1S3SIhV0qO0TXIMuSMP9vXdDPENsf2hDO
         UEgsL3Jlz8jyfXKduASizMDMlHebaCfH9NtWTbe4b3YTapUaD/T37oQP75DDsfLn72
         usk1VKBhfCCYprfgzsQNM3EId8tV7tnVaHjKEBUZWaUIXx26FYkvle4FLESBmHtQu9
         6a+m7ArcS+V+A==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH v2 3/3] efi: x86: Wire up IBT annotation in memory attributes table
Date:   Mon,  6 Feb 2023 13:49:38 +0100
Message-Id: <20230206124938.272988-4-ardb@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230206124938.272988-1-ardb@kernel.org>
References: <20230206124938.272988-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4596; i=ardb@kernel.org; h=from:subject; bh=ypWkLVzNr8Pt3z1+YR2rB/b3lXmmDLV8gRNYhHND/+o=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBj4PdhVcTfOpIVV8X2vNSNsb13vySymXSVFSYcv QyOqWci2hWJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCY+D3YQAKCRDDTyI5ktmP JILPC/9qBm9Q868geNW3M21t+QA+Nefqh3mUkRi/GGVKHKnRe/u+ztAF7NuHYGseaoCzhrfbXl3 yF7wgScExa8nrygYNyBuSLEg9nwhBOtLdqj+18br9bW0J/1H5D430FzUGV0vUNsXnMFN9CvhfCV kh1JpIA4Abco9WFJhG6D8AtYr8qtQqiDvDuID4S2wd0ur83ZqG5jjoTiM71QgsfhnbL6CS42zuV eng+uo1GqyWYVT8teKWEDLzEpaDlqCbVl7cVMXxf0gaT9FHffPDr6dFVDPiA83FJnxakQPB1t0S WW1qzxlUsSG+rpMfSo3e1E1s6Byuc3mwPcZKzq1KPo/VaFUjRC69dWVb2fkDaQoSF/K3bT57EMo ThEUC4rz7svj/+PXURpGZ4LJUEcfFvB28L8zV3KgVNgWHZUehqMg1nzh3jzyNaS4X1ueFzChOFv 6RU+HI/TxSEuJjue7TDoad8mgERffLIMb2OFFWQebL/TT1wZ7SZARLQkRZ5Tn/eouYj7U=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

UEFI v2.10 extends the EFI memory attributes table with a flag that
indicates whether or not all RuntimeServicesCode regions were
constructed with ENDBR landing pads, permitting the OS to map these
regions with IBT restrictions enabled.

So let's take this into account on x86 as well.

Suggested-by: Peter Zijlstra <peterz@infradead.org> # ibt_save() changes
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/include/asm/efi.h     | 4 +++-
 arch/x86/include/asm/ibt.h     | 4 ++--
 arch/x86/kernel/apm_32.c       | 4 ++--
 arch/x86/kernel/cpu/common.c   | 5 +++--
 arch/x86/platform/efi/efi_64.c | 5 +++++
 5 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
index cd19b9eca3f63cbd..9f8ded3de0381973 100644
--- a/arch/x86/include/asm/efi.h
+++ b/arch/x86/include/asm/efi.h
@@ -106,6 +106,8 @@ static inline void efi_fpu_end(void)
 
 extern asmlinkage u64 __efi_call(void *fp, ...);
 
+extern bool efi_disable_ibt_for_runtime;
+
 #define efi_call(...) ({						\
 	__efi_nargs_check(efi_call, 7, __VA_ARGS__);			\
 	__efi_call(__VA_ARGS__);					\
@@ -121,7 +123,7 @@ extern asmlinkage u64 __efi_call(void *fp, ...);
 
 #undef arch_efi_call_virt
 #define arch_efi_call_virt(p, f, args...) ({				\
-	u64 ret, ibt = ibt_save();					\
+	u64 ret, ibt = ibt_save(efi_disable_ibt_for_runtime);		\
 	ret = efi_call((void *)p->f, args);				\
 	ibt_restore(ibt);						\
 	ret;								\
diff --git a/arch/x86/include/asm/ibt.h b/arch/x86/include/asm/ibt.h
index 9b08082a5d9f564b..ab427fdab4115357 100644
--- a/arch/x86/include/asm/ibt.h
+++ b/arch/x86/include/asm/ibt.h
@@ -74,7 +74,7 @@ static inline bool is_endbr(u32 val)
 	return val == gen_endbr();
 }
 
-extern __noendbr u64 ibt_save(void);
+extern __noendbr u64 ibt_save(bool);
 extern __noendbr void ibt_restore(u64 save);
 
 #else /* __ASSEMBLY__ */
@@ -100,7 +100,7 @@ extern __noendbr void ibt_restore(u64 save);
 
 static inline bool is_endbr(u32 val) { return false; }
 
-static inline u64 ibt_save(void) { return 0; }
+static inline u64 ibt_save(bool) { return 0; }
 static inline void ibt_restore(u64 save) { }
 
 #else /* __ASSEMBLY__ */
diff --git a/arch/x86/kernel/apm_32.c b/arch/x86/kernel/apm_32.c
index 60e330cdbd175648..c6c15ce1952fb62e 100644
--- a/arch/x86/kernel/apm_32.c
+++ b/arch/x86/kernel/apm_32.c
@@ -609,7 +609,7 @@ static long __apm_bios_call(void *_call)
 
 	apm_irq_save(flags);
 	firmware_restrict_branch_speculation_start();
-	ibt = ibt_save();
+	ibt = ibt_save(true);
 	APM_DO_SAVE_SEGS;
 	apm_bios_call_asm(call->func, call->ebx, call->ecx,
 			  &call->eax, &call->ebx, &call->ecx, &call->edx,
@@ -690,7 +690,7 @@ static long __apm_bios_call_simple(void *_call)
 
 	apm_irq_save(flags);
 	firmware_restrict_branch_speculation_start();
-	ibt = ibt_save();
+	ibt = ibt_save(true);
 	APM_DO_SAVE_SEGS;
 	error = apm_bios_call_simple_asm(call->func, call->ebx, call->ecx,
 					 &call->eax);
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 9cfca3d7d0e207c5..54b246414eebb7b9 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -571,13 +571,14 @@ __setup("nopku", setup_disable_pku);
 
 #ifdef CONFIG_X86_KERNEL_IBT
 
-__noendbr u64 ibt_save(void)
+__noendbr u64 ibt_save(bool disable)
 {
 	u64 msr = 0;
 
 	if (cpu_feature_enabled(X86_FEATURE_IBT)) {
 		rdmsrl(MSR_IA32_S_CET, msr);
-		wrmsrl(MSR_IA32_S_CET, msr & ~CET_ENDBR_EN);
+		if (disable)
+			wrmsrl(MSR_IA32_S_CET, msr & ~CET_ENDBR_EN);
 	}
 
 	return msr;
diff --git a/arch/x86/platform/efi/efi_64.c b/arch/x86/platform/efi/efi_64.c
index 2e6fe430cb07bbbc..232acf418cfbe625 100644
--- a/arch/x86/platform/efi/efi_64.c
+++ b/arch/x86/platform/efi/efi_64.c
@@ -389,11 +389,15 @@ static int __init efi_update_mappings(efi_memory_desc_t *md, unsigned long pf)
 	return err1 || err2;
 }
 
+bool efi_disable_ibt_for_runtime __ro_after_init = true;
+
 static int __init efi_update_mem_attr(struct mm_struct *mm, efi_memory_desc_t *md,
 				      bool has_ibt)
 {
 	unsigned long pf = 0;
 
+	efi_disable_ibt_for_runtime |= !has_ibt;
+
 	if (md->attribute & EFI_MEMORY_XP)
 		pf |= _PAGE_NX;
 
@@ -415,6 +419,7 @@ void __init efi_runtime_update_mappings(void)
 	 * exists, since it is intended to supersede EFI_PROPERTIES_TABLE.
 	 */
 	if (efi_enabled(EFI_MEM_ATTR)) {
+		efi_disable_ibt_for_runtime = false;
 		efi_memattr_apply_permissions(NULL, efi_update_mem_attr);
 		return;
 	}
-- 
2.39.1

