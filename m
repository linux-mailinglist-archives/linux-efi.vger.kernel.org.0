Return-Path: <linux-efi+bounces-3308-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5A3AA86DC2
	for <lists+linux-efi@lfdr.de>; Sat, 12 Apr 2025 16:34:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA2324440BE
	for <lists+linux-efi@lfdr.de>; Sat, 12 Apr 2025 14:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DA831F03E0;
	Sat, 12 Apr 2025 14:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GjgSnZ9o";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LFK6GeIZ"
X-Original-To: linux-efi@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5929F1EE7D3;
	Sat, 12 Apr 2025 14:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744468429; cv=none; b=atkhV0ZvYQPVzDhRQHv5RVNfuWGC21tmPxokzgS3VcA8mi/bJpbS+SecVyGFvMT6wCMgs7yWm5wsX/8r1isCgfLf7lIPEgXpFCnJxzkZqj0OpO2VpkuNs4PuR+0JrbJdhJSm4CmYGEJlzADY/zpAMee0HNvsPiuE/vPZFX/Kro8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744468429; c=relaxed/simple;
	bh=D8H6qQTfQJxE/3XdZ2MVjcHocwNVG98rmXjnnwFRmzc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=OxMkxWJZ54k5rhWl0gSdTqV9R/SpirOsIS77B4GCEh6WA6usHy5Mj2X0S9AucnEHCRx8HEhn21Tqsqq5bLXw7LZd+ajw6QVtHiTGJ7pED3oy02l7BHYZZCAx6K1qzpeis3QA0r/6V7cudPamo1pkkvx/bu0VyLihKH9rQwKUwpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GjgSnZ9o; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LFK6GeIZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 12 Apr 2025 14:33:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744468420;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V2itsVul/BKjQ21rj6JGyKU7b4KsVX33+4IkgRUp6VE=;
	b=GjgSnZ9ocNUiUURZPl1jgMFbdV/C+Wd5ji6iq4d3mAYrhYCiMyk9uL9ssbDjb34S6TAH1F
	4RDSa3EurgMn2hlR+/LPO3PniIz0LIPs1HpzKbGMyr4wB0kFUZ00aDTD8WtDwc2pWPa314
	8lWEGQ4PYLLUhu+60wqBv7qFSoc5tNIOmK8IrHh921nCddtrpY2AK0WAyUE2E6kXHctaBB
	gQDUpWTzPCEqGJYpfe4hseVw9IA5hFezc1WOfER3EASifmCCg46tUZI96DLV2OMcqK7C78
	QUtRxAvR8Tcnr8EbM/JVB+mTUcY1VGINLPONNIXihM7Ydx+MXfcIHX1azHpQKg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744468420;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V2itsVul/BKjQ21rj6JGyKU7b4KsVX33+4IkgRUp6VE=;
	b=LFK6GeIZjwPABGdx2PGz33gSY/fZw1HxUzp08eLp9i4dpn61ZHoffmzwBql1TmcCco2q6z
	pfrL1y5boIvFKmBg==
From: "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/asm: Make rip_rel_ptr() usable from fPIC code
Cc: Ard Biesheuvel <ardb@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Dionna Amalie Glaze <dionnaglaze@google.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Kees Cook <keescook@chromium.org>,
 Kevin Loughlin <kevinloughlin@google.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Tom Lendacky <thomas.lendacky@amd.com>, linux-efi@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250410134117.3713574-14-ardb+git@google.com>
References: <20250410134117.3713574-14-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174446841928.31282.6253523068552611395.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     bcceba3c72c0cf06dfbae77f5aec70fb6187e8df
Gitweb:        https://git.kernel.org/tip/bcceba3c72c0cf06dfbae77f5aec70fb6187e8df
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Thu, 10 Apr 2025 15:41:19 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 12 Apr 2025 11:13:04 +02:00

x86/asm: Make rip_rel_ptr() usable from fPIC code

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
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Dionna Amalie Glaze <dionnaglaze@google.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Kevin Loughlin <kevinloughlin@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-efi@vger.kernel.org
Link: https://lore.kernel.org/r/20250410134117.3713574-14-ardb+git@google.com
---
 arch/x86/coco/sev/core.c           |  2 +-
 arch/x86/coco/sev/shared.c         |  4 ++--
 arch/x86/include/asm/asm.h         |  2 +-
 arch/x86/kernel/head64.c           | 24 ++++++++++++------------
 arch/x86/mm/mem_encrypt_identity.c |  6 +++---
 5 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index b0c1a7a..832f7a7 100644
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
index 2e4122f..04982d3 100644
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
index cc28815..a9f0779 100644
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
index fa9b633..954d093 100644
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
index 5eecdd9..e7fb377 100644
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
 

