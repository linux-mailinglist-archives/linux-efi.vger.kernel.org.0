Return-Path: <linux-efi+bounces-3222-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AAC2A7F8B5
	for <lists+linux-efi@lfdr.de>; Tue,  8 Apr 2025 10:58:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27293188DC6A
	for <lists+linux-efi@lfdr.de>; Tue,  8 Apr 2025 08:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07F28266573;
	Tue,  8 Apr 2025 08:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="18ZzQDCo"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF215264F96
	for <linux-efi@vger.kernel.org>; Tue,  8 Apr 2025 08:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744102402; cv=none; b=WARdABw70XvBECLJTqEjXE2gw3rtmsdnyx0M8KpfakkGTcQqdcVhEjFxaJbH63GIk94kNNHesNNWGf75OjUpWn7SBeErTt8XVQB77Ain//EXtOE+mUJh6xs7uLfedv+17yaOTqtSkUksCFgWASP58r3btI6ZTVPdogmKIwn+HJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744102402; c=relaxed/simple;
	bh=MfWGiN6WSi/Zk+tmGbO8szMKG53sTuUflJC9o3lgens=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ah0ncPERkXcMdXn/uKTcPmZX6JyHs/bQPxlxonYKboPcp1jB8WAc+D+kcqwKY8oR4jyeIGZ0J0l7Wf0p3xtwOeBsApDRJ9+7LCdyUUJ3Xk6YxOjwaTpnkwtS4a9vvebaNMKBSrGSG5WQid0mYhNglIgzuILA5PD5iWivkmJVrKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=18ZzQDCo; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-3913b2d355fso2104993f8f.1
        for <linux-efi@vger.kernel.org>; Tue, 08 Apr 2025 01:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744102399; x=1744707199; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HO2l3tWFFummWZwJE2HnD5inCchClwn1ne9w9FdWdWQ=;
        b=18ZzQDCoC0wGUHH5Rfe0wOHs8bQwfdgUmereJK3zVUigtB+SMxbmZbqJUQNPdDSlJN
         DmrLmst85ewdYFSB4i8bhqvg1puQO69rwKjyXgY4oPXUvXzXddgtdVeZHqRNiwWu68ky
         LH6hQGdcgn3GZcGV0WMQVL6/i+LhwC0dXhO/tJfEVDPECQSibmin7uTy0SFBWJnsKQxv
         ZQkGU17ph7i/68eACsmIHNZSLsj7amYGcCD/qWUOD1P3dD5xt6R2NnO+SY8eWIj4a23y
         TjOZDT3m5WwyX0EWWLaD5myeuhWWco8UniY36/EBYT1WUV/EN3LrEtP9nmJ0uQIkX2TU
         3XOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744102399; x=1744707199;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HO2l3tWFFummWZwJE2HnD5inCchClwn1ne9w9FdWdWQ=;
        b=aqTuxDVyxOiZdv+zoxwoxszX12Suno17XtHjwEUhGwZV/pCmsNI1fTVBRxpPzbNlNB
         LxgRHT2ClxKx7aJU88GVg6eVB2ximIH04YsV8cGAmIZ9o2NljMEhXi+Gobwcyku1WIZl
         7adWyDxOKf7+cFZ3f+UAFNTqBv5QGqrFUk9TpPsAq2bU7qi/1/jHDbM+UKrQNQ+dR426
         yR0ExHlgFFic/iOpZR9GXSYxRzUAJ21crv3UTrq3hy+mGtP+tVmJgsgI5/ircTd2bPiZ
         m8gEpjgsrTU8Jx8A3xB/vWBr0ZK5iz3L6xrbSovy77K6sz7K3aDZiJqcocEzHA59S/8r
         jtJQ==
X-Gm-Message-State: AOJu0YyRDJg2KcY5Pac05eLnEOYhLLE31jT6ocpyuhrhkOq+qnNv3fB2
	43SMOxzQ96jz59hWFqSRNfGNwKtdZbK3IZsej65iJPT7qb8hGMPZDjko7Tzk+UNOoVj+r7dAd/7
	NOSHHKsmnw9KAcm4NZ9AGHIFeP+B3CAbxTr+rkbCJTqYlHRS8JY0ZDMrJBe5jWYhHD4CAONJJYD
	ECO9bOtz0g7JjYb6psqYraECRVew==
X-Google-Smtp-Source: AGHT+IE5P19L2OxaCweIeN6QclTC3ENhDs8OX+Js27sfELdEnOiFqRnym6vFy4VvA/lxRLhOmmoibUWT
X-Received: from wmgg3.prod.google.com ([2002:a05:600d:3:b0:43c:ef1f:48d3])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a5d:5c84:0:b0:391:4559:8761
 with SMTP id ffacd0b85a97d-39cba9333a6mr13125653f8f.36.1744102399199; Tue, 08
 Apr 2025 01:53:19 -0700 (PDT)
Date: Tue,  8 Apr 2025 10:52:57 +0200
In-Reply-To: <20250408085254.836788-9-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250408085254.836788-9-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=8317; i=ardb@kernel.org;
 h=from:subject; bh=WeI9HuNMCdrTRyg+4/YKtxdJNSRFVjQXqhbM5pjqyAw=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIf3L41dTXcr+r9zKFiulL+537CGfb86uxw81V2r1pWw4n
 vOuPlm2o5SFQYyDQVZMkUVg9t93O09PlKp1niULM4eVCWQIAxenAEzk9yOG/+VrH89bd+b83VeT
 D7bLr/v4W3a32Sezuz+1QzW9mTlervVl+B9n8bxEt19tueD0k+d+XW+aEbfr5IXuJxsW/jn5T/B yyBxmAA==
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250408085254.836788-11-ardb+git@google.com>
Subject: [PATCH v3 2/7] x86/asm: Make rip_rel_ptr() usable from fPIC code
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
 arch/x86/kernel/head64.c           | 23 ++++++++++----------
 arch/x86/mm/mem_encrypt_identity.c |  6 ++---
 5 files changed, 18 insertions(+), 19 deletions(-)

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
index fa9b6339975f..3fb23d805cef 100644
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
@@ -565,11 +565,10 @@ void early_setup_idt(void)
  */
 void __head startup_64_setup_gdt_idt(void)
 {
-	struct desc_struct *gdt = (void *)(__force unsigned long)gdt_page.gdt;
 	void *handler = NULL;
 
 	struct desc_ptr startup_gdt_descr = {
-		.address = (unsigned long)&RIP_REL_REF(*gdt),
+		.address = (unsigned long)rip_rel_ptr((__force void *)&gdt_page),
 		.size    = GDT_SIZE - 1,
 	};
 
@@ -582,7 +581,7 @@ void __head startup_64_setup_gdt_idt(void)
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


