Return-Path: <linux-efi+bounces-3570-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF80EAA85BF
	for <lists+linux-efi@lfdr.de>; Sun,  4 May 2025 11:57:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A1D7179A96
	for <lists+linux-efi@lfdr.de>; Sun,  4 May 2025 09:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D110A1F30A4;
	Sun,  4 May 2025 09:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TrrLupAG"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E951F1506
	for <linux-efi@vger.kernel.org>; Sun,  4 May 2025 09:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746352427; cv=none; b=JT665GtAHvA9uI18b9nCGpgwlEqtxZVDwwfIyF5mNN4uNgXBpANDerJweUoWIK/gtHD1VlzzFdwXu8sTxSuFi1X8mO1SVk3KBSJ/OEBV21/SjHjw+ABTSrmfJsZG8e4Pa9a4K7kZ94oCdm3j3Jr8jmo2+itJSHjgdXTAC25z2/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746352427; c=relaxed/simple;
	bh=0kv5PyQQgZGwr5MoEfydVYsoz61xoJGS3+ClS7AvY1E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BgbdUlGlNO01r2semuT4DS99FmWjOnRP4NOClsp7lVjW1aQ5eavj0oNNm94ilSSVoJj9j45fBKpxoIdjtTOHsyWgyiXv9tl9AICxo0XzcVZtJ1SEB0hq0SE36jBzeYQzF7p41ZmGDv8S1F6CK6f/FFnkYEhNTGUGa3TfbGeVPTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TrrLupAG; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-43f405810b4so17121155e9.1
        for <linux-efi@vger.kernel.org>; Sun, 04 May 2025 02:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746352424; x=1746957224; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=am/u+C2vtdImB5wlXl0RNWC/asTWgVRv3T2s5E1iSBI=;
        b=TrrLupAGHm29o9oo5PByFCFqQe2m7KZWndQJp84IEmHvk01oxz9WjbkBzHr4+rg2i+
         yUTFvS5m7kStAdtaRne4NWO0wl7SiJe+E0JYGjY50GokKlPgrrpfvo+T2kFKxiZVvxEX
         qNmELI1uVdZfUaQSOabKkCOOh3oz8qGzEo2mkEkdflLTnCjJcU3GCwX8AUUchSYErNcR
         Li3uRlb6xll1s6y9WSB/TyGobxPXBKbMrmBgh2d+Ikt3wixreurIdwpWzkkqSztvDP4b
         9ENK9Bg8hfclZgCihiWo8PUOPDTQE/PH2X0Y9sFTpAGwWTLK2Ohv/2LL+Tnz+EwDuLKv
         frwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746352424; x=1746957224;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=am/u+C2vtdImB5wlXl0RNWC/asTWgVRv3T2s5E1iSBI=;
        b=u+tDcjaLJLgMIcbdkF3hnDmYQLLSrUdCP3L5Nzwgz7EForCpnJ0ot48I/11f4eKky1
         9/JBR4bif/I9EPVtklFMWYLXEQSW3q+vkNfWsS0N4SfEmPEjeyD2uEvzpNJJ7rDmdIOE
         wUAUbIolIQmyo4Dp+g9A++n3uvXvi43/OyjpueBE88CRLDeBbe3B90xqUpwhRC7urb+G
         aI646OEoGC6Ul7+gu3nC9ZuUNDSLTZ3c5pQ2z90Z2jN/F52pPZzKUB8wLFcMF/E0Hiok
         jnPjCWl1huEWxR6YAwey/fP+7S02t6laMjcp49W3Cb+Omui9UGoxfcztVIAwgJuZ1qdz
         q19Q==
X-Gm-Message-State: AOJu0Ywee74bafJLskgvee43AonR3MFTjdELXT5vHVlV5Fr2rPb5oV5+
	670yYEOa2O55QVv72wfjVevjWmDdvUaidgXW5xNBKPzBySw/9l0cRLEGnfkaejdEEhOU6A==
X-Google-Smtp-Source: AGHT+IE5qTd3zmGwdZAGiec0nXHYb95d5lMEBRus8RIXHken0LirX+y0hfAo2/LHIhLvc8/uIRrFEs+P
X-Received: from wmrm10.prod.google.com ([2002:a05:600c:37ca:b0:43b:bd03:5d2])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:8012:b0:43d:26e3:f2f6
 with SMTP id 5b1f17b1804b1-441c48b069emr30474665e9.5.1746352424068; Sun, 04
 May 2025 02:53:44 -0700 (PDT)
Date: Sun,  4 May 2025 11:52:49 +0200
In-Reply-To: <20250504095230.2932860-25-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250504095230.2932860-25-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=6615; i=ardb@kernel.org;
 h=from:subject; bh=K7Qy6HmBAvo+4sm++BxtoNxO67AhO3gRrFNSlDBcNSA=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIUPc4vthZ5ZDkhcDJp/6u9JMJeeCBa84r2XCsa43/9S2v
 itZ49bQUcrCIMbBICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACbyU5fhr+SE8pKJTWn9d5QY
 F92anPf45ucHDdL753887TbXV7PzeAwjQ3vGOt1Tq5n3eJmaKeyUOLBus22qz4n7r/mXXpDNu6y yjQkA
X-Mailer: git-send-email 2.49.0.906.g1f30a19c02-goog
Message-ID: <20250504095230.2932860-44-ardb+git@google.com>
Subject: [RFT PATCH v2 19/23] x86/boot: Created a confined code area for
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
 arch/x86/boot/startup/sev-shared.c |  2 +-
 arch/x86/boot/startup/sme.c        |  1 -
 arch/x86/coco/sev/core.c           |  2 +-
 arch/x86/coco/sev/vc-handle.c      |  1 -
 arch/x86/include/asm/setup.h       |  1 +
 arch/x86/include/asm/sev.h         |  1 +
 arch/x86/kernel/head64.c           |  2 +-
 arch/x86/kernel/head_64.S          |  8 ++++----
 arch/x86/mm/mem_encrypt_boot.S     |  6 +++---
 10 files changed, 25 insertions(+), 12 deletions(-)

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
index 9ab132bed77b..0215f2355dfa 100644
--- a/arch/x86/boot/startup/sev-shared.c
+++ b/arch/x86/boot/startup/sev-shared.c
@@ -12,7 +12,7 @@
 #include <asm/setup_data.h>
 
 #ifndef __BOOT_COMPRESSED
-#define error(v)			pr_err(v)
+#define error(v)
 #define has_cpuflag(f)			boot_cpu_has(f)
 #else
 #undef WARN
diff --git a/arch/x86/boot/startup/sme.c b/arch/x86/boot/startup/sme.c
index 1e9f1f5a753c..19dce2304636 100644
--- a/arch/x86/boot/startup/sme.c
+++ b/arch/x86/boot/startup/sme.c
@@ -560,7 +560,6 @@ void __head sme_enable(struct boot_params *bp)
 
 #ifdef CONFIG_MITIGATION_PAGE_TABLE_ISOLATION
 /* Local version for startup code, which never operates on user page tables */
-__weak
 pgd_t __pti_set_user_pgtbl(pgd_t *pgdp, pgd_t pgd)
 {
 	return pgd;
diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index 33332c4299b9..98921cde217e 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -276,7 +276,7 @@ static int svsm_perform_call_protocol(struct svsm_call *call)
 
 	do {
 		ret = ghcb ? svsm_perform_ghcb_protocol(ghcb, call)
-			   : svsm_perform_msr_protocol(call);
+			   : __pi_svsm_perform_msr_protocol(call);
 	} while (ret == -EAGAIN);
 
 	if (sev_cfg.ghcbs_initialized)
diff --git a/arch/x86/coco/sev/vc-handle.c b/arch/x86/coco/sev/vc-handle.c
index b4895c648024..0820accb9e80 100644
--- a/arch/x86/coco/sev/vc-handle.c
+++ b/arch/x86/coco/sev/vc-handle.c
@@ -1058,4 +1058,3 @@ bool __init handle_vc_boot_ghcb(struct pt_regs *regs)
 
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
index ca914f7384c6..cfec803a9b6c 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -535,6 +535,7 @@ struct cpuid_leaf {
 };
 
 int svsm_perform_msr_protocol(struct svsm_call *call);
+int __pi_svsm_perform_msr_protocol(struct svsm_call *call);
 int snp_cpuid(void (*cpuid_hv)(void *ctx, struct cpuid_leaf *),
 	      void *ctx, struct cpuid_leaf *leaf);
 
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index b7da8b45b6d8..23dc505bf609 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -306,5 +306,5 @@ void early_setup_idt(void)
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
2.49.0.906.g1f30a19c02-goog


