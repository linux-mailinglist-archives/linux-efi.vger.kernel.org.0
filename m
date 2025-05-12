Return-Path: <linux-efi+bounces-3672-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9B28AB44A6
	for <lists+linux-efi@lfdr.de>; Mon, 12 May 2025 21:15:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9301189385C
	for <lists+linux-efi@lfdr.de>; Mon, 12 May 2025 19:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCBDA29AAED;
	Mon, 12 May 2025 19:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Mvgqp9Xi"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCFB429A9EB
	for <linux-efi@vger.kernel.org>; Mon, 12 May 2025 19:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747077130; cv=none; b=eH4uFrGMNo7q3XsbgXYC4gXwgplDEHWoVJDX8w1zyYZSMtdW1YGLv8Ww3//yp/kxZTVTvNPC+nZVcENUMn5aE8Gu8ggaZIJC7PiYRjpAXhSCiAujruR1Lt0uxL+jXCEOlqX+9a2MjUG+z2HsTUD0CEkGT56LuFoyoHxW7WCtx4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747077130; c=relaxed/simple;
	bh=nLb2GoSZtpR9hRgQX3nthR4XTwB1sz8GyTZR/BbvSnQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hUE2wlLR4UDx0GAwDWOvHjgZyFpUIExh188s7ZDwHdr6fY2VovL1oRdSUGdJCU+eljUJxuRH5F/WW1g7ErLG5u1r8Ii1qsvlmDGSJOXqHhrdqJbUbbCeDvfx3fOdyqvBxlY8I/h6gBiV9/aIc1WmKF1vH8SYgzRj8h4Fkw7nsIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Mvgqp9Xi; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-43cf44b66f7so27260295e9.1
        for <linux-efi@vger.kernel.org>; Mon, 12 May 2025 12:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747077127; x=1747681927; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vFU+uik5okcrdv3ul/dUZXSrsejBmmKKD8RELhV6UJc=;
        b=Mvgqp9Xid2EADhyGqudy5f2MLol+bCd1p86HHUJfJmZHqwRHrvcumQ+uauxQYCYHzw
         cqieRMaaurDhtpFkV1QcUqgl5k5y3uDru54L5Y4cTC0fVaW3ZvBCquHsy8nhbl8RNfOm
         4c//Vf7IO5eUcsc2MyawmqHawTPz2AagVi1R/Euo3DHsCl/dvIlsVYLsMtNDNVUrWCHY
         BEbbm1XUazHbPwFW6zH+/eEcbXNaZA//zTBG9sXPbgUN1QMgTOTLA7Xu6V3fUK0Snl8D
         s7ywNOTmmKQJjXLEFhNdgFOiAg9opy7GH9N7ZdDPfdW99Z+rEvxCsAV0ZXAcMseAiIIG
         f1Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747077127; x=1747681927;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vFU+uik5okcrdv3ul/dUZXSrsejBmmKKD8RELhV6UJc=;
        b=P1O9oBVgd/aUkHKuDtoQEYhgP/JL/8Y+2JrpYOMrLkZ8onc57biHwDSFByEVnbogTP
         uB0noAt0YWgQpsG5ltZoD/fXzBpF6P+/xVxA7X5rNVc+ydz0m9j7L4Z1OzvNSq3H1oyt
         OMKWbWRjPLKiYYny6HambQoMMv6zOU795O3bEQgyOWv63u4tSna5pRWtEAuIka/22RuF
         fiDE1Vq3Qj+ess/MRh2wtT56PPbyLehiGNcDrU08/XDYNm+ZfkoipDMBu7wuZMDGPjwO
         jjD2MLkDseUkVYTkNCoDSAKuYJloXJP3bHBcNVNqMVrVbJNXiUT5kc/mxlk7uVWM2qqu
         dRQg==
X-Gm-Message-State: AOJu0Yy7i3AD2mhYqBPUl8h0vXrSYJAYVb9ULRHpGIyGGOqSRm8z+d1Z
	bwY/iaQJbQ9Hh0MZPzdbIu7yGHafTYedkyu5Ulk0CaPJg4CkTAkuoUYHaQkGluYsQ6+6IQ==
X-Google-Smtp-Source: AGHT+IFybPyhyrcEBjpO37gwnwgXTtDsnJdH4bS+eC4d+9j6zaoTSzgKUGkHPgCQtnhvUn5/T9aSXF/c
X-Received: from wmcn15.prod.google.com ([2002:a05:600c:c0cf:b0:43c:fe64:2de3])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:444c:b0:43d:5ec:b2f4
 with SMTP id 5b1f17b1804b1-442d6d3dcc8mr143032595e9.10.1747077127331; Mon, 12
 May 2025 12:12:07 -0700 (PDT)
Date: Mon, 12 May 2025 21:08:52 +0200
In-Reply-To: <20250512190834.332684-23-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250512190834.332684-23-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=6648; i=ardb@kernel.org;
 h=from:subject; bh=lGtSFbvVrAVzLAbdlbUiAAy8+kIIY7JokVKTdVcZ8QI=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIUPJPcQntNHz3tRgn1q9ozmePBv/lftd4zSdybx+f9Vyl
 1OFZrM7SlkYxDgYZMUUWQRm/3238/REqVrnWbIwc1iZQIYwcHEKwES0khkZfknpMJj8beH1njp7
 8f4I3i+z72941BWou0z7pLQX12YOJoZ/Ogp8i6dtfr9zUWtlSs3h24371nj8y7rXzsZatev24eJ gXgA=
X-Mailer: git-send-email 2.49.0.1045.g170613ef41-goog
Message-ID: <20250512190834.332684-40-ardb+git@google.com>
Subject: [RFT PATCH v3 17/21] x86/boot: Create a confined code area for
 startup code
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: linux-efi@vger.kernel.org, x86@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>, 
	Dionna Amalie Glaze <dionnaglaze@google.com>, Kevin Loughlin <kevinloughlin@google.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

In order to be able to have tight control over which code may execute
from the early 1:1 mapping of memory, but still link vmlinux as a single
executable, prefix all symbol references in startup code with __pi_, and
invoke it from outside using the __pi_ prefix.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/startup/Makefile     | 13 +++++++++++++
 arch/x86/boot/startup/sev-shared.c |  4 +---
 arch/x86/boot/startup/sme.c        |  1 -
 arch/x86/coco/sev/core.c           |  2 +-
 arch/x86/coco/sev/vc-handle.c      |  1 -
 arch/x86/include/asm/setup.h       |  1 +
 arch/x86/include/asm/sev.h         |  1 +
 arch/x86/kernel/head64.c           |  2 +-
 arch/x86/kernel/head_64.S          |  8 ++++----
 arch/x86/mm/mem_encrypt_boot.S     |  6 +++---
 10 files changed, 25 insertions(+), 14 deletions(-)

diff --git a/arch/x86/boot/startup/Makefile b/arch/x86/boot/startup/Makefile
index b514f7e81332..c7e690091f81 100644
--- a/arch/x86/boot/startup/Makefile
+++ b/arch/x86/boot/startup/Makefile
@@ -28,3 +28,16 @@ lib-$(CONFIG_EFI_MIXED)		+= efi-mixed.o
 # to be linked into the decompressor or the EFI stub but not vmlinux
 #
 $(patsubst %.o,$(obj)/%.o,$(lib-y)): OBJECT_FILES_NON_STANDARD := y
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
+extra-y		:= $(obj-y)
+obj-y		:= $(patsubst %.o,%.pi.o,$(obj-y))
diff --git a/arch/x86/boot/startup/sev-shared.c b/arch/x86/boot/startup/sev-shared.c
index 21d5a0e33145..49440955885a 100644
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
index 0ae04e333f51..ffd0185aaa9d 100644
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
index ebf1f5ee8386..8e316b09a646 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -270,7 +270,7 @@ static int svsm_perform_call_protocol(struct svsm_call *call)
 
 	do {
 		ret = ghcb ? svsm_perform_ghcb_protocol(ghcb, call)
-			   : svsm_perform_msr_protocol(call);
+			   : __pi_svsm_perform_msr_protocol(call);
 	} while (ret == -EAGAIN);
 
 	if (sev_cfg.ghcbs_initialized)
diff --git a/arch/x86/coco/sev/vc-handle.c b/arch/x86/coco/sev/vc-handle.c
index 3cadaa46b9d7..47991807b231 100644
--- a/arch/x86/coco/sev/vc-handle.c
+++ b/arch/x86/coco/sev/vc-handle.c
@@ -1060,4 +1060,3 @@ bool __init handle_vc_boot_ghcb(struct pt_regs *regs)
 
 	sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SEV_ES_GEN_REQ);
 }
-
diff --git a/arch/x86/include/asm/setup.h b/arch/x86/include/asm/setup.h
index 6324f4c6c545..895d09faaf83 100644
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
index 17b03a1f5694..4ebdffdc5856 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -534,6 +534,7 @@ struct cpuid_leaf {
 };
 
 int svsm_perform_msr_protocol(struct svsm_call *call);
+int __pi_svsm_perform_msr_protocol(struct svsm_call *call);
 int snp_cpuid(void (*cpuid_hv)(void *ctx, struct cpuid_leaf *),
 	      void *ctx, struct cpuid_leaf *leaf);
 
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 8c69cea84297..1d038ba07f29 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -320,5 +320,5 @@ void early_setup_idt(void)
 		handler = vc_boot_ghcb;
 	}
 
-	startup_64_load_idt(handler);
+	__pi_startup_64_load_idt(handler);
 }
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index 069420853304..88cbf932f7c2 100644
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
-- 
2.49.0.1045.g170613ef41-goog


