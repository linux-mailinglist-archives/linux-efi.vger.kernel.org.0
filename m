Return-Path: <linux-efi+bounces-4374-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 60C5EB06C41
	for <lists+linux-efi@lfdr.de>; Wed, 16 Jul 2025 05:26:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D41557B62F2
	for <lists+linux-efi@lfdr.de>; Wed, 16 Jul 2025 03:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72CFE28FA93;
	Wed, 16 Jul 2025 03:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YAneP/Vu"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2582828C85A
	for <linux-efi@vger.kernel.org>; Wed, 16 Jul 2025 03:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752636173; cv=none; b=bNPDzW8856lrGFanbP3/e3S4pFaTQCsgAe9qsbFMNDMRO7euz6Bt7pAgd7WOdcy5n1m1dJr4bTWA3mGvHx2mAv0Y2+yDt8yfAVcj9fid/Dbmi6qhtr8uCAvlaitU8cG7izKkDlNJ+E4/TgYpLM7VPWAK29cQHQ26VJO/GYod+CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752636173; c=relaxed/simple;
	bh=9948CqycW08/1LlGrpW7zJgLemHnsuajVZQX/8gge3w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=O6wKdY1/2OkxqagvWm6aoRMkfbSTJwNiqG1qEf25BdxQdNQBCf12FYOIz6mVyqhTL4Yy3lZ9GD4Qlome+E2WN2SBOX+cuLPSumMs0jEI/6jEogL44z0HTfTR2b8FUtZyGX6LOEwZdb/+l64z7mJoAH3b0gQ1S4fM0XpKYusI+hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YAneP/Vu; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-456013b59c1so22527185e9.3
        for <linux-efi@vger.kernel.org>; Tue, 15 Jul 2025 20:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752636168; x=1753240968; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=luT+danWgmjD728mlL9Ydkk3VcCYSX3YxUKwDAOLS70=;
        b=YAneP/Vu77V1pyiKJi0gAxDOT1CKK/92PhihS6eIHxKFXbERO5nMocp2sv77YKJ+0n
         ITqIThLtuveYRMJYC4NPhgq333SN+tkJbQbgmByGnOqhxX6fJSaYPTwz1MKfTm9L4jxL
         6CzekvHDxqdBzk4mM/jjrH2VXYlWFRzubQLmUsIyy3dtJC6/kSyXWgqvDysFiHPmQcd7
         r4tiqi/vdxbxVtzXOUwWqFdSSU5Bt+q339mpU7ag9jTQQXDG34bU5OOW6FUfQCaNQa5v
         GvUc2S/QldpNhsNrHBK1ZLDvmQafojetqbnhRKoQVKDE2d4cNqSlGZb7AMOdk3XOS3OD
         1+yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752636168; x=1753240968;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=luT+danWgmjD728mlL9Ydkk3VcCYSX3YxUKwDAOLS70=;
        b=h5oqIZOdRZysqBpiUhScYKGaURnrgNADcQi2xP7Pqga6jQk25HTR6Oqa7TXFP8s/Y3
         OBV2tibcA1g42irUqMYOjt/+uH1L+eOqt59+yvA8LhwcoQBGs3sT+v9vXoeGVdiMvuaV
         /iOw6xvMn/UUM/zXGGUi4F4PrMzlhlUIzO4DwgCxLUyimeWRjBRRKuwh5mDQhuor9xCR
         4uVnkQqzUkP0VsWSEVieje4YlZOLfWjF4RexKyPbPvzU42Im5ftS+q6ty18Vf6D75tE2
         ZyJxHXICqz20a7+SwvSrRV+0FqmpJVFocB7LesK4Jy1d9fCaz2NSIp/ZH/FSjyYT6Hk/
         kH+g==
X-Gm-Message-State: AOJu0YwrzSGsq6+vr8q5M+XAIXRE84/2WbP0v1Ghj6pekPzgm1pFEuXo
	+f6FJHyZjy4tREvlDxN0TTNbSjK8Eboy/gkDtz2I3cvHkTQ0mwYkNm0ZjNaRoHB2nAnDhhLtXw=
	=
X-Google-Smtp-Source: AGHT+IGg5fGpxb/IAAuVi73fIBB0LLaod9y7ICEuuTUkovm5avI5N2SMbFLeq3Yk5lDgY8NCrdpzGHjv
X-Received: from wmbev18.prod.google.com ([2002:a05:600c:8012:b0:456:1a6f:801a])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:8b69:b0:456:28d4:ef1
 with SMTP id 5b1f17b1804b1-4562e377982mr7314315e9.29.1752636168547; Tue, 15
 Jul 2025 20:22:48 -0700 (PDT)
Date: Wed, 16 Jul 2025 05:18:34 +0200
In-Reply-To: <20250716031814.2096113-24-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250716031814.2096113-24-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=7464; i=ardb@kernel.org;
 h=from:subject; bh=O4h+hR00Lbkm8G1bCRBIftlCyN3nxgHxGnDkh/lR8iw=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIaNcKnaKx8bdz56ZXW94ED9hgvXsnzsmPbv46pG59IErf
 NGr65IndpSyMIhxMciKKbIIzP77bufpiVK1zrNkYeawMoEMYeDiFICJtJkz/OHILd6wtfagWuaE
 Fv62CexCrcZ7pp2pmhH/7Lyn6gkGTS+Gfya6LqqxHw+I75rwt+nHJ6NFs+fs+OaeV8+csS+yyKd rDSsA
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250716031814.2096113-43-ardb+git@google.com>
Subject: [PATCH v5 19/22] x86/boot: Create a confined code area for startup code
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: linux-efi@vger.kernel.org, x86@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>, 
	Kevin Loughlin <kevinloughlin@google.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Nikunj A Dadhania <nikunj@amd.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

In order to be able to have tight control over which code may execute
from the early 1:1 mapping of memory, but still link vmlinux as a single
executable, prefix all symbol references in startup code with __pi_, and
invoke it from outside using the __pi_ prefix.

Use objtool to check that no absolute symbol references are present in
the startup code, as these cannot be used from code running from the 1:1
mapping.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/startup/Makefile     | 14 ++++++++++++++
 arch/x86/boot/startup/sev-shared.c |  4 +---
 arch/x86/boot/startup/sme.c        |  1 -
 arch/x86/coco/sev/core.c           |  2 +-
 arch/x86/include/asm/setup.h       |  1 +
 arch/x86/include/asm/sev.h         |  1 +
 arch/x86/kernel/head64.c           |  2 +-
 arch/x86/kernel/head_64.S          |  8 ++++----
 arch/x86/mm/mem_encrypt_boot.S     |  6 +++---
 tools/objtool/check.c              |  3 ++-
 10 files changed, 28 insertions(+), 14 deletions(-)

diff --git a/arch/x86/boot/startup/Makefile b/arch/x86/boot/startup/Makefile
index 32737f4ab5a8..e8fdf020b422 100644
--- a/arch/x86/boot/startup/Makefile
+++ b/arch/x86/boot/startup/Makefile
@@ -4,6 +4,7 @@ KBUILD_AFLAGS		+= -D__DISABLE_EXPORTS
 KBUILD_CFLAGS		+= -D__DISABLE_EXPORTS -mcmodel=small -fPIC \
 			   -Os -DDISABLE_BRANCH_PROFILING \
 			   $(DISABLE_STACKLEAK_PLUGIN) \
+			   $(DISABLE_LATENT_ENTROPY_PLUGIN) \
 			   -fno-stack-protector -D__NO_FORTIFY \
 			   -fno-jump-tables \
 			   -include $(srctree)/include/linux/hidden.h
@@ -36,3 +37,16 @@ $(patsubst %.o,$(obj)/%.o,$(lib-y)): OBJECT_FILES_NON_STANDARD := y
 #
 $(pi-objs): objtool-enabled	= 1
 $(pi-objs): objtool-args	= $(if $(delay-objtool),,$(objtool-args-y)) --noabs
+
+#
+# Confine the startup code by prefixing all symbols with __pi_ (for position
+# independent). This ensures that startup code can only call other startup
+# code, or code that has explicitly been made accessible to it via a symbol
+# alias.
+#
+$(obj)/%.pi.o: OBJCOPYFLAGS := --prefix-symbols=__pi_
+$(obj)/%.pi.o: $(obj)/%.o FORCE
+	$(call if_changed,objcopy)
+
+targets	+= $(obj-y)
+obj-y	:= $(patsubst %.o,%.pi.o,$(obj-y))
diff --git a/arch/x86/boot/startup/sev-shared.c b/arch/x86/boot/startup/sev-shared.c
index cc14daf816e8..b60d546e74a7 100644
--- a/arch/x86/boot/startup/sev-shared.c
+++ b/arch/x86/boot/startup/sev-shared.c
@@ -11,9 +11,7 @@
 
 #include <asm/setup_data.h>
 
-#ifndef __BOOT_COMPRESSED
-#define error(v)			pr_err(v)
-#else
+#ifdef __BOOT_COMPRESSED
 #undef WARN
 #define WARN(condition, format...) (!!(condition))
 #endif
diff --git a/arch/x86/boot/startup/sme.c b/arch/x86/boot/startup/sme.c
index 70ea1748c0a7..eb6a758ba660 100644
--- a/arch/x86/boot/startup/sme.c
+++ b/arch/x86/boot/startup/sme.c
@@ -567,7 +567,6 @@ void __head sme_enable(struct boot_params *bp)
 
 #ifdef CONFIG_MITIGATION_PAGE_TABLE_ISOLATION
 /* Local version for startup code, which never operates on user page tables */
-__weak
 pgd_t __pti_set_user_pgtbl(pgd_t *pgdp, pgd_t pgd)
 {
 	return pgd;
diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index be89f0a4a28f..fbed1651f6d8 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -272,7 +272,7 @@ static int svsm_perform_call_protocol(struct svsm_call *call)
 
 	do {
 		ret = ghcb ? svsm_perform_ghcb_protocol(ghcb, call)
-			   : svsm_perform_msr_protocol(call);
+			   : __pi_svsm_perform_msr_protocol(call);
 	} while (ret == -EAGAIN);
 
 	if (sev_cfg.ghcbs_initialized)
diff --git a/arch/x86/include/asm/setup.h b/arch/x86/include/asm/setup.h
index 692af46603a1..914eb32581c7 100644
--- a/arch/x86/include/asm/setup.h
+++ b/arch/x86/include/asm/setup.h
@@ -53,6 +53,7 @@ extern void i386_reserve_resources(void);
 extern unsigned long __startup_64(unsigned long p2v_offset, struct boot_params *bp);
 extern void startup_64_setup_gdt_idt(void);
 extern void startup_64_load_idt(void *vc_handler);
+extern void __pi_startup_64_load_idt(void *vc_handler);
 extern void early_setup_idt(void);
 extern void __init do_early_exception(struct pt_regs *regs, int trapnr);
 
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index f3acbfcdca9a..2d61b13e1810 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -551,6 +551,7 @@ struct cpuid_leaf {
 };
 
 int svsm_perform_msr_protocol(struct svsm_call *call);
+int __pi_svsm_perform_msr_protocol(struct svsm_call *call);
 int snp_cpuid(void (*cpuid_hv)(void *ctx, struct cpuid_leaf *),
 	      void *ctx, struct cpuid_leaf *leaf);
 
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 1bc40d0785ee..fd28b53dbac5 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -319,5 +319,5 @@ void early_setup_idt(void)
 		handler = vc_boot_ghcb;
 	}
 
-	startup_64_load_idt(handler);
+	__pi_startup_64_load_idt(handler);
 }
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index 3e9b3a3bd039..d219963ecb60 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -71,7 +71,7 @@ SYM_CODE_START_NOALIGN(startup_64)
 	xorl	%edx, %edx
 	wrmsr
 
-	call	startup_64_setup_gdt_idt
+	call	__pi_startup_64_setup_gdt_idt
 
 	/* Now switch to __KERNEL_CS so IRET works reliably */
 	pushq	$__KERNEL_CS
@@ -91,7 +91,7 @@ SYM_CODE_START_NOALIGN(startup_64)
 	 * subsequent code. Pass the boot_params pointer as the first argument.
 	 */
 	movq	%r15, %rdi
-	call	sme_enable
+	call	__pi_sme_enable
 #endif
 
 	/* Sanitize CPU configuration */
@@ -111,7 +111,7 @@ SYM_CODE_START_NOALIGN(startup_64)
 	 * programmed into CR3.
 	 */
 	movq	%r15, %rsi
-	call	__startup_64
+	call	__pi___startup_64
 
 	/* Form the CR3 value being sure to include the CR3 modifier */
 	leaq	early_top_pgt(%rip), %rcx
@@ -562,7 +562,7 @@ SYM_CODE_START_NOALIGN(vc_no_ghcb)
 	/* Call C handler */
 	movq    %rsp, %rdi
 	movq	ORIG_RAX(%rsp), %rsi
-	call    do_vc_no_ghcb
+	call    __pi_do_vc_no_ghcb
 
 	/* Unwind pt_regs */
 	POP_REGS
diff --git a/arch/x86/mm/mem_encrypt_boot.S b/arch/x86/mm/mem_encrypt_boot.S
index f8a33b25ae86..edbf9c998848 100644
--- a/arch/x86/mm/mem_encrypt_boot.S
+++ b/arch/x86/mm/mem_encrypt_boot.S
@@ -16,7 +16,7 @@
 
 	.text
 	.code64
-SYM_FUNC_START(sme_encrypt_execute)
+SYM_FUNC_START(__pi_sme_encrypt_execute)
 
 	/*
 	 * Entry parameters:
@@ -69,9 +69,9 @@ SYM_FUNC_START(sme_encrypt_execute)
 	ANNOTATE_UNRET_SAFE
 	ret
 	int3
-SYM_FUNC_END(sme_encrypt_execute)
+SYM_FUNC_END(__pi_sme_encrypt_execute)
 
-SYM_FUNC_START(__enc_copy)
+SYM_FUNC_START_LOCAL(__enc_copy)
 	ANNOTATE_NOENDBR
 /*
  * Routine used to encrypt memory in place.
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 5d1d38404892..f43bd598d928 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -3563,7 +3563,8 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 		if (func && insn_func(insn) && func != insn_func(insn)->pfunc) {
 			/* Ignore KCFI type preambles, which always fall through */
 			if (!strncmp(func->name, "__cfi_", 6) ||
-			    !strncmp(func->name, "__pfx_", 6))
+			    !strncmp(func->name, "__pfx_", 6) ||
+			    !strncmp(func->name, "__pi___pfx_", 11))
 				return 0;
 
 			if (file->ignore_unreachables)
-- 
2.50.0.727.gbf7dc18ff4-goog


