Return-Path: <linux-efi+bounces-4455-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08EF4B0D34C
	for <lists+linux-efi@lfdr.de>; Tue, 22 Jul 2025 09:36:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25BCE169E31
	for <lists+linux-efi@lfdr.de>; Tue, 22 Jul 2025 07:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2C112E3385;
	Tue, 22 Jul 2025 07:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AJd73Xwb"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0822E1722
	for <linux-efi@vger.kernel.org>; Tue, 22 Jul 2025 07:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753169413; cv=none; b=WVCg9DeGKRTnmV7wA9D58vhzQaGyWN+DyavLToIpWyS898TaZgJVDAiXFJbWh3lJMrjqVtdG0girMiw2G5NAr/LtaCROvbGqZqAQXKO5K35HyIhEr0jzLQ+kJ/6ZLKmhfudObaUnJowc9Nkx4i+l45GRj9DMidEPj2zVy8azVAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753169413; c=relaxed/simple;
	bh=0FS7MLD0aawoqK43saTKFtpB7pewnLMeRWFtQgwClKE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FYobV4M2tOfPy53HLuuB0iT63jwhO/klWLWzMGa00UZSv0x0hVolMENPgUZuLWI6L7Zmcm5b0YcOufVQjqP0GMqgrqZ/1UkvoMHkh9rFLuHofCavjRmCEh9mFft8ArPu3h5zZv5wiwjZaPWUMl/rgJLSSlA6Xwgs1TNNfCG0QiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AJd73Xwb; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-60728151592so4443514a12.1
        for <linux-efi@vger.kernel.org>; Tue, 22 Jul 2025 00:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753169409; x=1753774209; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KTbS3XaJJn2gG4CFImDKsTK73tqCPQGtne6y7vzBEfY=;
        b=AJd73Xwb+BjTkk27h+8r3HZvUisHrp0ZxjbKM2WoNMc3btQWaFC0k2n4xQ79f+sLic
         yXdVPTKCxEUQ1S8R5/zBWPnJob9mG7dC2/zPAqsLmhNPYcqTGiQtkingdpslWHYTvPJp
         8jV+aGQxp30aGrIonapscqgVRnEyoek/WB9M0fCQg8d/yfCVKC7oazjjOFACqpaHbn+X
         kM1m7yE2L+hGp0s8xTpHo9hcgmlLJwMyIOfwKmqMgcN3YnJuMV1HY+1P6Axusi9Shmxe
         v8Z6L5Ki9i2cRuMzbJFhVCMDiXmg0qcahxhtAE+E/9eX5G8L1ZUNdyzBmqMxhG18YJhk
         FOGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753169409; x=1753774209;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KTbS3XaJJn2gG4CFImDKsTK73tqCPQGtne6y7vzBEfY=;
        b=wnVThvpTXc2d2Ol9nupt5WiN8e0nxaBlahr67AHuZpcE2qNWiG4q6H2Uf7bBVUVHbl
         OHYS/DBI7cjierB1RxPtoxuys2U6grdTgtU5+kqJCTv2ovHUEiZZw0tltajeNKTlVVCA
         1oJKA5GsXt0U+h/RDsltBAEwTLWPqNlqEDtoG5yN+vtADNpmZEUQXQywtVOtnOsxGTnw
         kflrrA4MXLJq2EW7zXAkZhZFEtaZgRMvReAESgy8YEZL9ofdFTgY+O1qLM5Vp2VwQvhi
         4ZK9dNtdDDXMWEg+naUFICa5Fn+Hu1x//OyqAHA3z5lwjmHDwVtvpsYvqFIqCcwO63cw
         PqwQ==
X-Gm-Message-State: AOJu0Yx8rwiuSnKM9U2MiEiDRrsLY787C/Wv+idJ2UeMUzwV8hvKsfxy
	IZVSDaphtajPGzoA3J8DNKAUkvactvWaNmXtH1uvjS1t7b9mxvdHCx6kIToPJa5udcxbWtkNdQ=
	=
X-Google-Smtp-Source: AGHT+IHSHrQLpePc1GBh93t7fQ62I7U75LBLDkgvjv9qIidLFOIho5xmm5kiy8Xz0Lg1/uxysv7Tr1tW
X-Received: from edbcy10.prod.google.com ([2002:a05:6402:1c8a:b0:611:f9c0:1914])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:50cc:b0:611:f4b2:379a
 with SMTP id 4fb4d7f45d1cf-61285be2463mr22030047a12.27.1753169409269; Tue, 22
 Jul 2025 00:30:09 -0700 (PDT)
Date: Tue, 22 Jul 2025 09:27:28 +0200
In-Reply-To: <20250722072708.2079165-24-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250722072708.2079165-24-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=7468; i=ardb@kernel.org;
 h=from:subject; bh=Lr8Ks0uf2ivgorJCA6iP5JcTFwh3mU0lfyYiaD5vVK8=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIaPedqXLoy7D+l+av15ZLvo3te6Ljmqt94dPwXN+V5soH
 47TP1TQUcrCIMbFICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACbC68PI8P79UlPmtT0NVf6L
 nigV7bLa9fTHJsWsXdIORh0zRbSPzWJkuCF2WI8h+nBg+OaaiE/7m8WjWUN5Py2PZAsv//ku7kU oFwA=
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250722072708.2079165-43-ardb+git@google.com>
Subject: [PATCH v6 19/22] x86/boot: Create a confined code area for startup code
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
index 1044a50ac3d3..98c2fcb43279 100644
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
index bc1d7b32e4f4..2b8a779f1477 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -551,6 +551,7 @@ struct cpuid_leaf {
 };
 
 int svsm_perform_msr_protocol(struct svsm_call *call);
+int __pi_svsm_perform_msr_protocol(struct svsm_call *call);
 int snp_cpuid(void (*cpuid_fn)(void *ctx, struct cpuid_leaf *leaf),
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
index c34331ec1d71..33e2fd8a97a3 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -3564,7 +3564,8 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
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


