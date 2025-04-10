Return-Path: <linux-efi+bounces-3261-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4371EA84533
	for <lists+linux-efi@lfdr.de>; Thu, 10 Apr 2025 15:45:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 259294A1C6F
	for <lists+linux-efi@lfdr.de>; Thu, 10 Apr 2025 13:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2267628A40D;
	Thu, 10 Apr 2025 13:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EwLhVq5u"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238BE2857FA
	for <linux-efi@vger.kernel.org>; Thu, 10 Apr 2025 13:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744292506; cv=none; b=GBRG+Nq44BpIgaz4Y9mZaZVgtDRtFJOwdfY3YT2XxsegmeuD+xQ7nhwyH5iVKJR5hIesxIeiFOE2yvLJ/ICMbK100aHc4yNMhKTkAmLdDZWazaBPjVwHnFp5Y4jNeCGbdszbZ1mEENYafaEkTyv3WYOg1An2MqBfGCCTQxPMRAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744292506; c=relaxed/simple;
	bh=t76Wg9mCJpGbQFO226Opa35P1ZmW8qq3cQ+2zwr1lR0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=D6OGoRvkzzZsd9ykLVltDsv0ZEheJNIMtSyRr/7MgNvaB0m7e7LLHiZhkt5eAehH92gyqTi0EDN8nlj6CoYvZf5VLRuBZwfb5m0XX6dy4C1OgLttRuD+ZgC+qMNRfBl+NQbPkMI73SItB1ftQigfjNeNdTNQCBIRAWkOkxl4MTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EwLhVq5u; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-43947a0919aso6420235e9.0
        for <linux-efi@vger.kernel.org>; Thu, 10 Apr 2025 06:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744292502; x=1744897302; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gXw/UaNA/8PDNEKLJNHvZMJeXVXKbmGygtg1CpsGD6E=;
        b=EwLhVq5u/iw0xHCjxn5XexRQscw4vllX0kVfja2j2xe66Wt4Li4SPcMybLhk8YlW2P
         KW2raYoQzJaCDXzS4FIJpFrboen6d/u3DcrYWrvzcT4FiPIKV2XVkR4/Q94hf7PP23h9
         AgjaIN0CFUpJhzxwRQbuXzIzRvJi5tjZmiAkfVXpOpcGaBeRtV7UYAfbxi+GD+MUGHfK
         9fKdbsk6jZuxwdYMns8XGO3fVwytMAjasA5SctevO7nNA7GKCxOylVIwRrra5OBJIR4i
         cfLKoG/cvLFAvGo/ZzEaxtCPM2w7KTXeZMdc/ywyRVch5iNbrTcQ9QjUWLo/hiubWgLa
         dkeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744292502; x=1744897302;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gXw/UaNA/8PDNEKLJNHvZMJeXVXKbmGygtg1CpsGD6E=;
        b=nkdZIHle68oCVzN8+PMTAcnDulyEbxtdgy0QgbT5K3ww9RQwRJTnEJ7FX/MvNmZeSa
         4pqzqDU0FVHVUJ21i6IgFaI/5APR/O2UxqaByR1VaH9SfCe/fVM/iMFIegSisMPE3Kph
         Qi2bXkNOas5UOt7grs8quMN1qckPJF1GwD0rOBqQ3rBugqY4P875lTTlzYv6xvVRyBuL
         P0gNgh1lZaWP65jCHFkTbX1q19EX3bFuf7/IRzPPP/2wRZsY46a0xNzyIXItobvYMpOH
         cXEn5WBDm6jyjpuocJ0OapwIP1AL2CR58nMlSaXvtRG/kCXj9Zh414OTarBSIFx2MNHM
         3CGQ==
X-Gm-Message-State: AOJu0YwhH+88i11XITTk1m1Q3SqPUgIl4uatpeQb+gsxiWuCn/tHN6Ni
	wtHZ17e4Iuy8iMfY6aAdfpoVVqxWKe855nUpbUylXNfme1G9LWpS2IkgTIQI7lbOBB2D1zM4OO3
	5ssbTSi88dG0ylFLp/jbOrSHidatBeiTSgMcchO7uowzOXhvWpPEjaNTAw1IK7y7v4ts7HUSNE4
	yyzzO0DLiPeQQ9Mz/2KLv1iWJeqA==
X-Google-Smtp-Source: AGHT+IEbBK7uSrQvOLZ1dSP0sU6X384GpC8H66VqBJri1LGrN5IkBkYGIS0pLmbALgbYAMDD1f3a53yZ
X-Received: from wmcn12.prod.google.com ([2002:a05:600c:c0cc:b0:43c:f60a:4c59])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:3b97:b0:43c:fc00:f94f
 with SMTP id 5b1f17b1804b1-43f2d95ebf4mr26942655e9.23.1744292502500; Thu, 10
 Apr 2025 06:41:42 -0700 (PDT)
Date: Thu, 10 Apr 2025 15:41:19 +0200
In-Reply-To: <20250410134117.3713574-13-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250410134117.3713574-13-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=8366; i=ardb@kernel.org;
 h=from:subject; bh=niWmrBdmld5Ut46NlyltJZwh2miFi8PLlQF/GqLQX1A=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIf37qYatm4Sv1eo+PbiM8x+Hz899TWpBtxJTlwfO02qcm
 nniq4hkRykLgxgHg6yYIovA7L/vdp6eKFXrPEsWZg4rE8gQBi5OAZhITSLDf0frAGdhzqwPLl3O
 bz2UZl6IfSoYcNauXPHgRPPWiDW7nzEynLQ+b2t0N/gIjwu37MuLH4QPxJgfffp/l61F3vMnlks 2swIA
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250410134117.3713574-14-ardb+git@google.com>
Subject: [PATCH v4 01/11] x86/asm: Make rip_rel_ptr() usable from fPIC code
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: x86@kernel.org, mingo@kernel.org, linux-kernel@vger.kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Dionna Amalie Glaze <dionnaglaze@google.com>, Kevin Loughlin <kevinloughlin@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

RIP_REL_REF() is used in non-PIC C code that is called very early,
before the kernel virtual mapping is up, which is the mapping that the
linker expects. It is currently used in two different ways:
- to refer to the value of a global variable, including as an lvalue in
  assignments;
- to take the address of a global variable via the mapping that the code
  currently executes at.

The former case is only needed in non-PIC code, as PIC code will never
use absolute symbol references when the address of the symbol is not
being used. But taking the address of a variable in PIC code may still
require extra care, as a stack allocated struct assignment may be
emitted as a memcpy() from a statically allocated copy in .rodata.

For instance, this

  void startup_64_setup_gdt_idt(void)
  {
        struct desc_ptr startup_gdt_descr = {
                .address = (__force unsigned long)gdt_page.gdt,
                .size    = GDT_SIZE - 1,
        };

may result in an absolute symbol reference in PIC code, even though the
struct is allocated on the stack and populated at runtime.

To address this case, make rip_rel_ptr() accessible in PIC code, and
update any existing uses where the address of a global variable is
taken using RIP_REL_REF.

Once all code of this nature has been moved into arch/x86/boot/startup
and built with -fPIC, RIP_REL_REF() can be retired, and only
rip_rel_ptr() will remain.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/coco/sev/core.c           |  2 +-
 arch/x86/coco/sev/shared.c         |  4 ++--
 arch/x86/include/asm/asm.h         |  2 +-
 arch/x86/kernel/head64.c           | 24 ++++++++++----------
 arch/x86/mm/mem_encrypt_identity.c |  6 ++---
 5 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index b0c1a7a57497..832f7a7b10b2 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -2400,7 +2400,7 @@ static __head void svsm_setup(struct cc_blob_sev_info *cc_info)
 	 * kernel was loaded (physbase), so the get the CA address using
 	 * RIP-relative addressing.
 	 */
-	pa = (u64)&RIP_REL_REF(boot_svsm_ca_page);
+	pa = (u64)rip_rel_ptr(&boot_svsm_ca_page);
 
 	/*
 	 * Switch over to the boot SVSM CA while the current CA is still
diff --git a/arch/x86/coco/sev/shared.c b/arch/x86/coco/sev/shared.c
index 2e4122f8aa6b..04982d356803 100644
--- a/arch/x86/coco/sev/shared.c
+++ b/arch/x86/coco/sev/shared.c
@@ -475,7 +475,7 @@ static int sev_cpuid_hv(struct ghcb *ghcb, struct es_em_ctxt *ctxt, struct cpuid
  */
 static const struct snp_cpuid_table *snp_cpuid_get_table(void)
 {
-	return &RIP_REL_REF(cpuid_table_copy);
+	return rip_rel_ptr(&cpuid_table_copy);
 }
 
 /*
@@ -1681,7 +1681,7 @@ static bool __head svsm_setup_ca(const struct cc_blob_sev_info *cc_info)
 	 * routine is running identity mapped when called, both by the decompressor
 	 * code and the early kernel code.
 	 */
-	if (!rmpadjust((unsigned long)&RIP_REL_REF(boot_ghcb_page), RMP_PG_SIZE_4K, 1))
+	if (!rmpadjust((unsigned long)rip_rel_ptr(&boot_ghcb_page), RMP_PG_SIZE_4K, 1))
 		return false;
 
 	/*
diff --git a/arch/x86/include/asm/asm.h b/arch/x86/include/asm/asm.h
index cc2881576c2c..a9f07799e337 100644
--- a/arch/x86/include/asm/asm.h
+++ b/arch/x86/include/asm/asm.h
@@ -114,13 +114,13 @@
 #endif
 
 #ifndef __ASSEMBLER__
-#ifndef __pic__
 static __always_inline __pure void *rip_rel_ptr(void *p)
 {
 	asm("leaq %c1(%%rip), %0" : "=r"(p) : "i"(p));
 
 	return p;
 }
+#ifndef __pic__
 #define RIP_REL_REF(var)	(*(typeof(&(var)))rip_rel_ptr(&(var)))
 #else
 #define RIP_REL_REF(var)	(var)
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index fa9b6339975f..954d093f187b 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -106,8 +106,8 @@ static unsigned long __head sme_postprocess_startup(struct boot_params *bp,
 	 * attribute.
 	 */
 	if (sme_get_me_mask()) {
-		paddr = (unsigned long)&RIP_REL_REF(__start_bss_decrypted);
-		paddr_end = (unsigned long)&RIP_REL_REF(__end_bss_decrypted);
+		paddr = (unsigned long)rip_rel_ptr(__start_bss_decrypted);
+		paddr_end = (unsigned long)rip_rel_ptr(__end_bss_decrypted);
 
 		for (; paddr < paddr_end; paddr += PMD_SIZE) {
 			/*
@@ -144,8 +144,8 @@ static unsigned long __head sme_postprocess_startup(struct boot_params *bp,
 unsigned long __head __startup_64(unsigned long p2v_offset,
 				  struct boot_params *bp)
 {
-	pmd_t (*early_pgts)[PTRS_PER_PMD] = RIP_REL_REF(early_dynamic_pgts);
-	unsigned long physaddr = (unsigned long)&RIP_REL_REF(_text);
+	pmd_t (*early_pgts)[PTRS_PER_PMD] = rip_rel_ptr(early_dynamic_pgts);
+	unsigned long physaddr = (unsigned long)rip_rel_ptr(_text);
 	unsigned long va_text, va_end;
 	unsigned long pgtable_flags;
 	unsigned long load_delta;
@@ -174,18 +174,18 @@ unsigned long __head __startup_64(unsigned long p2v_offset,
 		for (;;);
 
 	va_text = physaddr - p2v_offset;
-	va_end  = (unsigned long)&RIP_REL_REF(_end) - p2v_offset;
+	va_end  = (unsigned long)rip_rel_ptr(_end) - p2v_offset;
 
 	/* Include the SME encryption mask in the fixup value */
 	load_delta += sme_get_me_mask();
 
 	/* Fixup the physical addresses in the page table */
 
-	pgd = &RIP_REL_REF(early_top_pgt)->pgd;
+	pgd = rip_rel_ptr(early_top_pgt);
 	pgd[pgd_index(__START_KERNEL_map)] += load_delta;
 
 	if (IS_ENABLED(CONFIG_X86_5LEVEL) && la57) {
-		p4d = (p4dval_t *)&RIP_REL_REF(level4_kernel_pgt);
+		p4d = (p4dval_t *)rip_rel_ptr(level4_kernel_pgt);
 		p4d[MAX_PTRS_PER_P4D - 1] += load_delta;
 
 		pgd[pgd_index(__START_KERNEL_map)] = (pgdval_t)p4d | _PAGE_TABLE;
@@ -258,7 +258,7 @@ unsigned long __head __startup_64(unsigned long p2v_offset,
 	 * error, causing the BIOS to halt the system.
 	 */
 
-	pmd = &RIP_REL_REF(level2_kernel_pgt)->pmd;
+	pmd = rip_rel_ptr(level2_kernel_pgt);
 
 	/* invalidate pages before the kernel image */
 	for (i = 0; i < pmd_index(va_text); i++)
@@ -531,7 +531,7 @@ static gate_desc bringup_idt_table[NUM_EXCEPTION_VECTORS] __page_aligned_data;
 static void __head startup_64_load_idt(void *vc_handler)
 {
 	struct desc_ptr desc = {
-		.address = (unsigned long)&RIP_REL_REF(bringup_idt_table),
+		.address = (unsigned long)rip_rel_ptr(bringup_idt_table),
 		.size    = sizeof(bringup_idt_table) - 1,
 	};
 	struct idt_data data;
@@ -565,11 +565,11 @@ void early_setup_idt(void)
  */
 void __head startup_64_setup_gdt_idt(void)
 {
-	struct desc_struct *gdt = (void *)(__force unsigned long)gdt_page.gdt;
+	struct gdt_page *gp = rip_rel_ptr((void *)(__force unsigned long)&gdt_page);
 	void *handler = NULL;
 
 	struct desc_ptr startup_gdt_descr = {
-		.address = (unsigned long)&RIP_REL_REF(*gdt),
+		.address = (unsigned long)gp->gdt,
 		.size    = GDT_SIZE - 1,
 	};
 
@@ -582,7 +582,7 @@ void __head startup_64_setup_gdt_idt(void)
 		     "movl %%eax, %%es\n" : : "a"(__KERNEL_DS) : "memory");
 
 	if (IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT))
-		handler = &RIP_REL_REF(vc_no_ghcb);
+		handler = rip_rel_ptr(vc_no_ghcb);
 
 	startup_64_load_idt(handler);
 }
diff --git a/arch/x86/mm/mem_encrypt_identity.c b/arch/x86/mm/mem_encrypt_identity.c
index 5eecdd92da10..e7fb3779b35f 100644
--- a/arch/x86/mm/mem_encrypt_identity.c
+++ b/arch/x86/mm/mem_encrypt_identity.c
@@ -318,8 +318,8 @@ void __head sme_encrypt_kernel(struct boot_params *bp)
 	 *     memory from being cached.
 	 */
 
-	kernel_start = (unsigned long)RIP_REL_REF(_text);
-	kernel_end = ALIGN((unsigned long)RIP_REL_REF(_end), PMD_SIZE);
+	kernel_start = (unsigned long)rip_rel_ptr(_text);
+	kernel_end = ALIGN((unsigned long)rip_rel_ptr(_end), PMD_SIZE);
 	kernel_len = kernel_end - kernel_start;
 
 	initrd_start = 0;
@@ -345,7 +345,7 @@ void __head sme_encrypt_kernel(struct boot_params *bp)
 	 *   pagetable structures for the encryption of the kernel
 	 *   pagetable structures for workarea (in case not currently mapped)
 	 */
-	execute_start = workarea_start = (unsigned long)RIP_REL_REF(sme_workarea);
+	execute_start = workarea_start = (unsigned long)rip_rel_ptr(sme_workarea);
 	execute_end = execute_start + (PAGE_SIZE * 2) + PMD_SIZE;
 	execute_len = execute_end - execute_start;
 
-- 
2.49.0.504.g3bcea36a83-goog


