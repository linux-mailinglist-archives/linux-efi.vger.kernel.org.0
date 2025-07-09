Return-Path: <linux-efi+bounces-4226-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDC79AFE229
	for <lists+linux-efi@lfdr.de>; Wed,  9 Jul 2025 10:15:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B1417B8A7D
	for <lists+linux-efi@lfdr.de>; Wed,  9 Jul 2025 08:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D280E28369A;
	Wed,  9 Jul 2025 08:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IuexBqWS"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98DD2820BA
	for <linux-efi@vger.kernel.org>; Wed,  9 Jul 2025 08:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752048709; cv=none; b=S3xFGXshTry8bA/s8YEpQmoqi7iuVf1INBd2ays+qRuiAKqFu0jx6Esvx+Cf8gw5mxkIWckPE/fKD90WNhnfDT+hOytFFPRfPWv4/Nf9ynHImB8itswzD0/DOH+P9DaptnTsk77co/ZrUZYQQz8NJsEKHIdrRgNZ6trqTjbamlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752048709; c=relaxed/simple;
	bh=LEYOztMn5rjTBYuGcJlOC0cNKm0OwLFwapdlWk2Wg2c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MPQUX36//Nn+6g24y1eeDHwlZxxIOw05ahJwudgEYu/5nrS3MzwzKlmG8WnK7f8ArPmlUilg0Pa+JOQnibotc9Z19RuPI6KuDaiXPjoq42LR/ps0fg4VwsCV38U1VtDxkVi06uCKNcN2JPj0YxMGzG4OjIdIqCt9NZHNl4dBiAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IuexBqWS; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4536962204aso22335275e9.3
        for <linux-efi@vger.kernel.org>; Wed, 09 Jul 2025 01:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752048706; x=1752653506; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hIvLiJ3LEx5MrxcJRef/JzAT5WlSZ9Iu8kKRbhtDQM8=;
        b=IuexBqWS0bWk8mFV43d9S3TcOPWd272BcOsB9UJ+FT3453Gh9B6meCA24nJ+7jbTJZ
         GHVaPQuQrV2oGqOyLFLRzDcU4ep/gllt9hNp3OlMZB8ctpbrBAHhb+E8YMHTqrr0G/Iq
         wk9Zk8hXcA/l/EEGZiPt+v6igwtIJz9NZNESk8PuMJU0/JJAaB2gvsPW5EOm6zr4bR2n
         PyIJXSQ+Mv1x649FsfbhzPKa50QiN/Sfa7W+QI/U3RAOuMjaLLp/IIVPGH9awPE0Q1r5
         nxNqlp1lWN+7hHs5yWIeDRmr1v66OhWhN7MdH0zYUjl3wHXl+On7YKkFP56If7DNGNXn
         gHNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752048706; x=1752653506;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hIvLiJ3LEx5MrxcJRef/JzAT5WlSZ9Iu8kKRbhtDQM8=;
        b=SMJkAUL2nEtUe9tLIkzz3BdMfsRBtJGF5HIGY9xlJzABPZJ/tG8PS32CPnS6s0DW1U
         ha2Xkqt33kjPAJzT+AZaYof1MHwofKo/98RDcLLMcKq1JXzSZKqbsJoPF2tf/HKRuH0m
         rfyo7W9elfSmpUWitSPy6NIYJyUQyCGTtCjJJ7rygkBhpflfqALL5ipwOVxM4sWO7sK3
         GURY/FDYlywykpAqMFiXxiokLtUDQcc7PhS4euBN8HWDunJmWuVqti5oNd1sDJfHZK6X
         KYI2j4HqaE62hLlLrmi7yBI+SAy2zCOUuNlxcaJgY6ukvUElwjGcBbnI1KvnonM7AeUd
         dJUw==
X-Gm-Message-State: AOJu0YxA//ad1mtvIRZZ3hS6HQAjiHEuZvDz1nXpsQeuS8wlcUByacZ+
	8cL+nm0vyLac0g5oo+vBL6MTvJtZydC276txy4qSI4Q5t0dYx8TnxrEGghUbDvkFdDPu46ArVA=
	=
X-Google-Smtp-Source: AGHT+IFDw2inQIrVxyeqsdLnBw/rnK6gmnGpAqm9OhpKV9RKqeDpSF5xajlB2OZZ9vMusICp86ENB7nE
X-Received: from wmbha11.prod.google.com ([2002:a05:600c:860b:b0:453:b96:8ef9])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:3b17:b0:453:8042:ba47
 with SMTP id 5b1f17b1804b1-454d53eef80mr10771405e9.19.1752048706216; Wed, 09
 Jul 2025 01:11:46 -0700 (PDT)
Date: Wed,  9 Jul 2025 10:09:02 +0200
In-Reply-To: <20250709080840.2233208-26-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250709080840.2233208-26-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=7464; i=ardb@kernel.org;
 h=from:subject; bh=j6wXIngHyHrlAPTskD54bLUCjXFuDU0Aadgaba9ZznI=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JISNP+euZLOX5Gw5H6D8yfdV64N0LtaMvjlhYsFfc3Kofd
 vfqLVGNjlIWBjEuBlkxRRaB2X/f7Tw9UarWeZYszBxWJpAhDFycAjCRTDZGht9zy9Ndb1/PmbbJ
 qYZl/b863grjhIPNj0o+LtG63Rf9dj7D/4xHZ7/ay8pHiiu6fj7dbi++fqtAZNHBCdkL725w+zr FjgUA
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250709080840.2233208-47-ardb+git@google.com>
Subject: [PATCH v4 21/24] x86/boot: Create a confined code area for startup code
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: linux-efi@vger.kernel.org, x86@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>, 
	Dionna Amalie Glaze <dionnaglaze@google.com>, Kevin Loughlin <kevinloughlin@google.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>
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
index 042eef7b3a2a..223eafa56d9d 100644
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
index 529090e20d2a..56dde8c53139 100644
--- a/arch/x86/boot/startup/sme.c
+++ b/arch/x86/boot/startup/sme.c
@@ -569,7 +569,6 @@ void __head sme_enable(struct boot_params *bp)
 
 #ifdef CONFIG_MITIGATION_PAGE_TABLE_ISOLATION
 /* Local version for startup code, which never operates on user page tables */
-__weak
 pgd_t __pti_set_user_pgtbl(pgd_t *pgdp, pgd_t pgd)
 {
 	return pgd;
diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index 71a76fde3102..c5d70dd835c7 100644
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
index f20860187fe9..e50736d15e02 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -553,6 +553,7 @@ struct cpuid_leaf {
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


