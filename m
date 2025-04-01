Return-Path: <linux-efi+bounces-3169-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DAEB5A77C38
	for <lists+linux-efi@lfdr.de>; Tue,  1 Apr 2025 15:36:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DBC9D7A3BF3
	for <lists+linux-efi@lfdr.de>; Tue,  1 Apr 2025 13:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 419672040B7;
	Tue,  1 Apr 2025 13:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4ybXhcBI"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A38B204C29
	for <linux-efi@vger.kernel.org>; Tue,  1 Apr 2025 13:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743514488; cv=none; b=FhZtjetAUtz6b+wEytJSpsNvAxk/mEWQfmi0YDKlrDJqB0cbLBWDe/cl6FZQFHacUgPzpyLGND5TQSBtHmfWJa5R2B0Zc4fWyf9Rvq2/neq/HaUaXhB2yKyeoqYA8h8D4w3exM2AO58PkcD3/Yt2YrseB6YyAH/LMuSl/O5iQOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743514488; c=relaxed/simple;
	bh=gdyI7unVAqelFcsV1oQkRb/FpEZooiabpLxxOvJoVAE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=W2CI5dbukMgRDen4touK8EtU6XZB0urcx30LtM6LaBJYKlUungfEWKXvnAZCzmraXqOfoicJoDCWZwKqOCYlCg4wdGq4ol7cBYjnF82UmitiAqm39mV5GJ4pgniYHph5gKpqPXanF3jphv0FQQxQCgPVlHcUrdUP7aKSSWbCFVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4ybXhcBI; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-43d51bd9b41so49798345e9.3
        for <linux-efi@vger.kernel.org>; Tue, 01 Apr 2025 06:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743514483; x=1744119283; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y3WkZ4oiyNOu5L0IFpzb/JlaH4U0a2GEGnk/9vyxvlk=;
        b=4ybXhcBI2lzRiLirF7OjgcBj9nTZcUvui/+PZuDa/JwnK+Kb5+UetuyN9rj92jYCrv
         Oka1+Ls5x5DRH+kjYhKH8oTGuqiTE1J+PdnS38mU6Hm9nSq/Gq4oDhV0U+a61iurFTaR
         5yX7+1spqhXoqyo+ApJxBzRt3mioZ60Q3fnC3Nu4+As1PfJnx9Qr+dbh4QYX2rcFMRRp
         v8m8v9Qi1KcVbhfj6VQoPUJHj5mFStitTJBfMzemBmiZn7qpwBn69ln8jZfj189SZAk+
         1mp6t93hVubCSH9wlbhfHg7Bc9U/Oj976tiu8IYJuI1VxcJQj3WVVw54gmxocqT3k4BI
         cvHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743514483; x=1744119283;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y3WkZ4oiyNOu5L0IFpzb/JlaH4U0a2GEGnk/9vyxvlk=;
        b=uzgF6YRFc03ZsN/usOOkvmOF8ePigteqi8r2zwbgcT+hT1xweoKZIaHTNm1mbGB6xp
         b2SuHEMFEORqUymRLtnV2T8C3mMvagoXcD5USICMaAp2+u6va/v2pxsWr6co/DAqWzvZ
         Dv0cKEVxDOuQeLqvm0CaYiOcl3LDwXOPDS2/+rRtQGnFc/Nnrs4IprxIOw4NGzzFmr6y
         Zj9lzZlpXU+4ZtTCInCb8yJphH1NRCJ2XjiPuHS6bCGPZZY5E5QIO23RGdp7tLCu6q2i
         HhBaT6JfiIp0cKCGe29IiUIkqcitxVQG/0085lhS23ufiFmCF/7bwPHfRWS9L4U3sMyx
         Z2qQ==
X-Gm-Message-State: AOJu0YxSLDruWlLQy/mgWXwA2UOobmm1ti8UBabFviR/nHZoDnn2uOPc
	VndXHIDlOHDHNtaI2fnPZF3XAEZ4KsLolbEjsWZdxQuL+NNhp+cLrRQH5h264ZDZlU86Z1M/Lhl
	2xLEE4/TXgBp1b8rwE1WXyT1+Mh0cxaM/hwwwum9wpdgpCA/on9m7poD9W7ZFd4zCrm/bHGRX8i
	s9ywYOHBxfHBN4HLcm+P2nBnrvrw==
X-Google-Smtp-Source: AGHT+IGfPceNrKT6p4eafCCaO1Kg9NonHtCGA618XGANB6G80nVMJDaWbJqhrfqxJGWoYDWeOBLuDcQp
X-Received: from wmqd10.prod.google.com ([2002:a05:600c:34ca:b0:43d:b71:a576])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:1388:b0:43c:ec97:75db
 with SMTP id 5b1f17b1804b1-43db622a2a1mr87997065e9.11.1743514483360; Tue, 01
 Apr 2025 06:34:43 -0700 (PDT)
Date: Tue,  1 Apr 2025 15:34:23 +0200
In-Reply-To: <20250401133416.1436741-8-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250401133416.1436741-8-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=9644; i=ardb@kernel.org;
 h=from:subject; bh=Xn0NZVRSKnkBVNa4JliVxJ2z0L0pTwu/uZobfB4mEXk=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIf3164R5kqHHDzveeVQe+XVynVvWji9qr+o55RJ1zQJ69
 dN+G7V0lLIwiHEwyIopsgjM/vtu5+mJUrXOs2Rh5rAygQxh4OIUgIlcvc3w31f52p/7ddNjX0c8
 598R/Vry3Ktb03bGXC/mK/XhmMvHdZjhN5vJjohou+cFcRfEFB8UNASdl/fcn3tR0WGNWdcz+1c LmAA=
X-Mailer: git-send-email 2.49.0.472.ge94155a9ec-goog
Message-ID: <20250401133416.1436741-14-ardb+git@google.com>
Subject: [RFC PATCH 6/6] x86/boot: Move early SME init code into startup/
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Dionna Amalie Glaze <dionnaglaze@google.com>, Kevin Loughlin <kevinloughlin@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Move the SME initialization code, which runs from the 1:1 mapping of
memory as it operates on the kernel virtual mapping, into the new
sub-directory arch/x86/boot/startup/ where all startup code will reside
that needs to tolerate executing from the 1:1 mapping.

This allows RIP_REL_REF() macro invocations and __head annotations to be
dropped.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/startup/Makefile                             |  1 +
 arch/x86/{mm/mem_encrypt_identity.c => boot/startup/sme.c} | 45 +++++++++-----------
 arch/x86/include/asm/mem_encrypt.h                         |  2 +-
 arch/x86/mm/Makefile                                       |  6 ---
 4 files changed, 23 insertions(+), 31 deletions(-)

diff --git a/arch/x86/boot/startup/Makefile b/arch/x86/boot/startup/Makefile
index 01423063fec2..480c2d2063a0 100644
--- a/arch/x86/boot/startup/Makefile
+++ b/arch/x86/boot/startup/Makefile
@@ -16,6 +16,7 @@ UBSAN_SANITIZE	:= n
 KCOV_INSTRUMENT	:= n
 
 obj-$(CONFIG_X86_64)		+= gdt_idt.o map_kernel.o
+obj-$(CONFIG_AMD_MEM_ENCRYPT)	+= sme.o
 
 lib-$(CONFIG_X86_64)		+= la57toggle.o
 lib-$(CONFIG_EFI_MIXED)		+= efi-mixed.o
diff --git a/arch/x86/mm/mem_encrypt_identity.c b/arch/x86/boot/startup/sme.c
similarity index 92%
rename from arch/x86/mm/mem_encrypt_identity.c
rename to arch/x86/boot/startup/sme.c
index 5eecdd92da10..85bd39652535 100644
--- a/arch/x86/mm/mem_encrypt_identity.c
+++ b/arch/x86/boot/startup/sme.c
@@ -45,8 +45,6 @@
 #include <asm/coco.h>
 #include <asm/sev.h>
 
-#include "mm_internal.h"
-
 #define PGD_FLAGS		_KERNPG_TABLE_NOENC
 #define P4D_FLAGS		_KERNPG_TABLE_NOENC
 #define PUD_FLAGS		_KERNPG_TABLE_NOENC
@@ -93,7 +91,7 @@ struct sme_populate_pgd_data {
  */
 static char sme_workarea[2 * PMD_SIZE] __section(".init.scratch");
 
-static void __head sme_clear_pgd(struct sme_populate_pgd_data *ppd)
+static void __init sme_clear_pgd(struct sme_populate_pgd_data *ppd)
 {
 	unsigned long pgd_start, pgd_end, pgd_size;
 	pgd_t *pgd_p;
@@ -108,7 +106,7 @@ static void __head sme_clear_pgd(struct sme_populate_pgd_data *ppd)
 	memset(pgd_p, 0, pgd_size);
 }
 
-static pud_t __head *sme_prepare_pgd(struct sme_populate_pgd_data *ppd)
+static pud_t __init *sme_prepare_pgd(struct sme_populate_pgd_data *ppd)
 {
 	pgd_t *pgd;
 	p4d_t *p4d;
@@ -145,7 +143,7 @@ static pud_t __head *sme_prepare_pgd(struct sme_populate_pgd_data *ppd)
 	return pud;
 }
 
-static void __head sme_populate_pgd_large(struct sme_populate_pgd_data *ppd)
+static void __init sme_populate_pgd_large(struct sme_populate_pgd_data *ppd)
 {
 	pud_t *pud;
 	pmd_t *pmd;
@@ -161,7 +159,7 @@ static void __head sme_populate_pgd_large(struct sme_populate_pgd_data *ppd)
 	set_pmd(pmd, __pmd(ppd->paddr | ppd->pmd_flags));
 }
 
-static void __head sme_populate_pgd(struct sme_populate_pgd_data *ppd)
+static void __init sme_populate_pgd(struct sme_populate_pgd_data *ppd)
 {
 	pud_t *pud;
 	pmd_t *pmd;
@@ -187,7 +185,7 @@ static void __head sme_populate_pgd(struct sme_populate_pgd_data *ppd)
 		set_pte(pte, __pte(ppd->paddr | ppd->pte_flags));
 }
 
-static void __head __sme_map_range_pmd(struct sme_populate_pgd_data *ppd)
+static void __init __sme_map_range_pmd(struct sme_populate_pgd_data *ppd)
 {
 	while (ppd->vaddr < ppd->vaddr_end) {
 		sme_populate_pgd_large(ppd);
@@ -197,7 +195,7 @@ static void __head __sme_map_range_pmd(struct sme_populate_pgd_data *ppd)
 	}
 }
 
-static void __head __sme_map_range_pte(struct sme_populate_pgd_data *ppd)
+static void __init __sme_map_range_pte(struct sme_populate_pgd_data *ppd)
 {
 	while (ppd->vaddr < ppd->vaddr_end) {
 		sme_populate_pgd(ppd);
@@ -207,7 +205,7 @@ static void __head __sme_map_range_pte(struct sme_populate_pgd_data *ppd)
 	}
 }
 
-static void __head __sme_map_range(struct sme_populate_pgd_data *ppd,
+static void __init __sme_map_range(struct sme_populate_pgd_data *ppd,
 				   pmdval_t pmd_flags, pteval_t pte_flags)
 {
 	unsigned long vaddr_end;
@@ -231,22 +229,22 @@ static void __head __sme_map_range(struct sme_populate_pgd_data *ppd,
 	__sme_map_range_pte(ppd);
 }
 
-static void __head sme_map_range_encrypted(struct sme_populate_pgd_data *ppd)
+static void __init sme_map_range_encrypted(struct sme_populate_pgd_data *ppd)
 {
 	__sme_map_range(ppd, PMD_FLAGS_ENC, PTE_FLAGS_ENC);
 }
 
-static void __head sme_map_range_decrypted(struct sme_populate_pgd_data *ppd)
+static void __init sme_map_range_decrypted(struct sme_populate_pgd_data *ppd)
 {
 	__sme_map_range(ppd, PMD_FLAGS_DEC, PTE_FLAGS_DEC);
 }
 
-static void __head sme_map_range_decrypted_wp(struct sme_populate_pgd_data *ppd)
+static void __init sme_map_range_decrypted_wp(struct sme_populate_pgd_data *ppd)
 {
 	__sme_map_range(ppd, PMD_FLAGS_DEC_WP, PTE_FLAGS_DEC_WP);
 }
 
-static unsigned long __head sme_pgtable_calc(unsigned long len)
+static unsigned long __init sme_pgtable_calc(unsigned long len)
 {
 	unsigned long entries = 0, tables = 0;
 
@@ -283,7 +281,7 @@ static unsigned long __head sme_pgtable_calc(unsigned long len)
 	return entries + tables;
 }
 
-void __head sme_encrypt_kernel(struct boot_params *bp)
+void __init sme_encrypt_kernel(struct boot_params *bp)
 {
 	unsigned long workarea_start, workarea_end, workarea_len;
 	unsigned long execute_start, execute_end, execute_len;
@@ -299,8 +297,7 @@ void __head sme_encrypt_kernel(struct boot_params *bp)
 	 * instrumentation or checking boot_cpu_data in the cc_platform_has()
 	 * function.
 	 */
-	if (!sme_get_me_mask() ||
-	    RIP_REL_REF(sev_status) & MSR_AMD64_SEV_ENABLED)
+	if (!sme_get_me_mask() || sev_status & MSR_AMD64_SEV_ENABLED)
 		return;
 
 	/*
@@ -318,8 +315,8 @@ void __head sme_encrypt_kernel(struct boot_params *bp)
 	 *     memory from being cached.
 	 */
 
-	kernel_start = (unsigned long)RIP_REL_REF(_text);
-	kernel_end = ALIGN((unsigned long)RIP_REL_REF(_end), PMD_SIZE);
+	kernel_start = (unsigned long)_text;
+	kernel_end = ALIGN((unsigned long)_end, PMD_SIZE);
 	kernel_len = kernel_end - kernel_start;
 
 	initrd_start = 0;
@@ -345,7 +342,7 @@ void __head sme_encrypt_kernel(struct boot_params *bp)
 	 *   pagetable structures for the encryption of the kernel
 	 *   pagetable structures for workarea (in case not currently mapped)
 	 */
-	execute_start = workarea_start = (unsigned long)RIP_REL_REF(sme_workarea);
+	execute_start = workarea_start = (unsigned long)sme_workarea;
 	execute_end = execute_start + (PAGE_SIZE * 2) + PMD_SIZE;
 	execute_len = execute_end - execute_start;
 
@@ -488,7 +485,7 @@ void __head sme_encrypt_kernel(struct boot_params *bp)
 	native_write_cr3(__native_read_cr3());
 }
 
-void __head sme_enable(struct boot_params *bp)
+void __init sme_enable(struct boot_params *bp)
 {
 	unsigned int eax, ebx, ecx, edx;
 	unsigned long feature_mask;
@@ -526,7 +523,7 @@ void __head sme_enable(struct boot_params *bp)
 	me_mask = 1UL << (ebx & 0x3f);
 
 	/* Check the SEV MSR whether SEV or SME is enabled */
-	RIP_REL_REF(sev_status) = msr = __rdmsr(MSR_AMD64_SEV);
+	sev_status = msr = __rdmsr(MSR_AMD64_SEV);
 	feature_mask = (msr & MSR_AMD64_SEV_ENABLED) ? AMD_SEV_BIT : AMD_SME_BIT;
 
 	/*
@@ -562,8 +559,8 @@ void __head sme_enable(struct boot_params *bp)
 			return;
 	}
 
-	RIP_REL_REF(sme_me_mask) = me_mask;
-	RIP_REL_REF(physical_mask) &= ~me_mask;
-	RIP_REL_REF(cc_vendor) = CC_VENDOR_AMD;
+	sme_me_mask	= me_mask;
+	physical_mask	&= ~me_mask;
+	cc_vendor	= CC_VENDOR_AMD;
 	cc_set_mask(me_mask);
 }
diff --git a/arch/x86/include/asm/mem_encrypt.h b/arch/x86/include/asm/mem_encrypt.h
index 1530ee301dfe..ea6494628cb0 100644
--- a/arch/x86/include/asm/mem_encrypt.h
+++ b/arch/x86/include/asm/mem_encrypt.h
@@ -61,7 +61,7 @@ void __init sev_es_init_vc_handling(void);
 
 static inline u64 sme_get_me_mask(void)
 {
-	return RIP_REL_REF(sme_me_mask);
+	return sme_me_mask;
 }
 
 #define __bss_decrypted __section(".bss..decrypted")
diff --git a/arch/x86/mm/Makefile b/arch/x86/mm/Makefile
index 690fbf48e853..9cbb18c99adb 100644
--- a/arch/x86/mm/Makefile
+++ b/arch/x86/mm/Makefile
@@ -3,12 +3,10 @@
 KCOV_INSTRUMENT_tlb.o			:= n
 KCOV_INSTRUMENT_mem_encrypt.o		:= n
 KCOV_INSTRUMENT_mem_encrypt_amd.o	:= n
-KCOV_INSTRUMENT_mem_encrypt_identity.o	:= n
 KCOV_INSTRUMENT_pgprot.o		:= n
 
 KASAN_SANITIZE_mem_encrypt.o		:= n
 KASAN_SANITIZE_mem_encrypt_amd.o	:= n
-KASAN_SANITIZE_mem_encrypt_identity.o	:= n
 KASAN_SANITIZE_pgprot.o		:= n
 
 # Disable KCSAN entirely, because otherwise we get warnings that some functions
@@ -16,12 +14,10 @@ KASAN_SANITIZE_pgprot.o		:= n
 KCSAN_SANITIZE := n
 # Avoid recursion by not calling KMSAN hooks for CEA code.
 KMSAN_SANITIZE_cpu_entry_area.o := n
-KMSAN_SANITIZE_mem_encrypt_identity.o := n
 
 ifdef CONFIG_FUNCTION_TRACER
 CFLAGS_REMOVE_mem_encrypt.o		= -pg
 CFLAGS_REMOVE_mem_encrypt_amd.o		= -pg
-CFLAGS_REMOVE_mem_encrypt_identity.o	= -pg
 CFLAGS_REMOVE_pgprot.o			= -pg
 endif
 
@@ -32,7 +28,6 @@ obj-y				+= pat/
 
 # Make sure __phys_addr has no stackprotector
 CFLAGS_physaddr.o		:= -fno-stack-protector
-CFLAGS_mem_encrypt_identity.o	:= -fno-stack-protector
 
 CFLAGS_fault.o := -I $(src)/../include/asm/trace
 
@@ -65,5 +60,4 @@ obj-$(CONFIG_MITIGATION_PAGE_TABLE_ISOLATION)	+= pti.o
 obj-$(CONFIG_X86_MEM_ENCRYPT)	+= mem_encrypt.o
 obj-$(CONFIG_AMD_MEM_ENCRYPT)	+= mem_encrypt_amd.o
 
-obj-$(CONFIG_AMD_MEM_ENCRYPT)	+= mem_encrypt_identity.o
 obj-$(CONFIG_AMD_MEM_ENCRYPT)	+= mem_encrypt_boot.o
-- 
2.49.0.472.ge94155a9ec-goog


