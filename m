Return-Path: <linux-efi+bounces-3207-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CC96A7D3DE
	for <lists+linux-efi@lfdr.de>; Mon,  7 Apr 2025 08:12:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F98F3ACC6C
	for <lists+linux-efi@lfdr.de>; Mon,  7 Apr 2025 06:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71091224AE0;
	Mon,  7 Apr 2025 06:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YNfNlIkm"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5834122538F
	for <linux-efi@vger.kernel.org>; Mon,  7 Apr 2025 06:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744006308; cv=none; b=WsiPotx5PMCEyuvABL6LL9520PMk4hImTNfsu9cCDqjDH4lcV9B0hUXPlIyzqkFQbXdeazxSyWUBFaj7mkr+8IJtcGWQ5V2CjfLn8dO92BE6+7TYJ8FRl4bpogxvFXAHR+o5iXYzRuFJOelEdI4SJzfcreVG61rVA+fvfo+tHfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744006308; c=relaxed/simple;
	bh=a4UOxoM75WIQaqNEDX2cAYA7eHrzdSLznlT5GRnSf4E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XJBw9q7E9uLgZMb5BQ8BP8xAzg1C6Tcnq1VhIYtkn29KYRXz1cBbBvjJiifa1AftoSTfTVGws+0lF9PzuhFMPa2xZsZFWfMsLVObwYcgBF7yvYEoMezjZDLpOkhe1scZ/4zYr2ZVKPZ+OPnUeYEje802Gs71BJ4wCFwoKE/inAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YNfNlIkm; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-391492acb59so2306332f8f.3
        for <linux-efi@vger.kernel.org>; Sun, 06 Apr 2025 23:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744006304; x=1744611104; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pbfnJnCDmQrrChz5QAx7ox2nJHFPzvTjb5gL5epTEnc=;
        b=YNfNlIkmvHJdd6QgTmmX1EtX2Otd7iLf66SpmKMBmTNsh+dorMixFXRS6sZ0VuQlsa
         Ik09F1gLAF3pKXF57AEBXSHfWSDdGIayzt4KHIj7PW205d5AsHpEVRb3HfsUuPwJfipc
         901Z3jUAKCobXz0brKae7/oqbREuBbumZK15Ws4EC8k28ttaY2zh0KdaHmFMQulS+Lo/
         QSzo8NcdXqHgx7ECaJFb+lTPnkRiLoeTNb1ydKcns+b8SKsa0GF3x61A3z3zwPhI0cAd
         RIrsNfIaBrJwnBsRt1ri9VfHzN/6Pzykwk3Xjny8246tWnitePq63vzDZaeQbSQyVSpn
         htUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744006304; x=1744611104;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pbfnJnCDmQrrChz5QAx7ox2nJHFPzvTjb5gL5epTEnc=;
        b=nfxDGTuANP8/kvMRSqyrq5t1O/ez7Lp/jMDAsTc3jEHvR6cusa6CK4kOyWImXRn7Hn
         v8h2eFcf+BtNuV6k/6HzXFUtgM8T+3TWR1KbsejGvNKgs9ech8qzPRR6v1IcokXtbkHT
         dr2lFFoIwjtln7REXpyBpD6GEX1amwbbNK96kqt3yBylYHcfAZwsRWtEiojR+rfhvxkC
         eZq1pJ49BrzmcQKyDizYdkngrczQ76sLBv0lTAuvtIlRyEQSHSU+elQGxCFVv+DUqdqH
         70VD3clyPxbpdOwpdOvnpgBkJtPWeyGnjH6mCMEDcPyOJUZKDGSp2qh77AiuOyZAWxdQ
         SOsQ==
X-Forwarded-Encrypted: i=1; AJvYcCXENXfbqUVO/H0sAokbodoWA+AbKlkBdhV/iUYT8RGBI8O62Elgty4OAD2rDRfV9JQT/LmAOPVzdvM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywdu6yTHW2gBv7TuAZx5EGjLeGywasUOULD59TkdCoPGFcoNtP6
	tk6yQyGnqUUGKRdboGl3c/iRNz4fKFYJAPxI2czoXU4zFusS+QP5R4cun9YjAG8uR8PGeQ==
X-Google-Smtp-Source: AGHT+IH0iTHKoSnExWD38wMno/X063/6ygT8RIzLClPsv9h9+b1uVjMhb1uquURy2RnxO8O0FC8QoAQi
X-Received: from wmsp14.prod.google.com ([2002:a05:600c:1d8e:b0:43d:b71:a576])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a5d:5f96:0:b0:39c:cc7:3c62
 with SMTP id ffacd0b85a97d-39d147577famr8969577f8f.51.1744006304822; Sun, 06
 Apr 2025 23:11:44 -0700 (PDT)
Date: Mon,  7 Apr 2025 08:11:35 +0200
In-Reply-To: <20250407061132.69315-4-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250407061132.69315-4-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=9644; i=ardb@kernel.org;
 h=from:subject; bh=rLLOUVelgqK5VOtLrSMJgnsMJeUEIBCp5YJLNfqkZe8=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIf1zzgyGh6aevt9TThfd95I22LzC+W9FWXbBjpSLrzwLf
 MUD5TQ6SlkYxDgYZMUUWQRm/3238/REqVrnWbIwc1iZwIZwcQrAREpbGBnWhGRWf3/of0v7Br/A
 bkmtE5eDrupM7Ju2ftICe+kHDTpyDP+zRdL5Tl6ZYCVQ+73RaIUzy5f527j2rNPe3lfBeW/byZV sAA==
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250407061132.69315-6-ardb+git@google.com>
Subject: [PATCH v2 2/2] x86/boot: Move early SME init code into startup/
From: Ard Biesheuvel <ardb+git@google.com>
To: mingo@kernel.org
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>
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
index 32035d5be5a0..3faa60f13a61 100644
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
 
@@ -63,5 +58,4 @@ obj-$(CONFIG_MITIGATION_PAGE_TABLE_ISOLATION)	+= pti.o
 obj-$(CONFIG_X86_MEM_ENCRYPT)	+= mem_encrypt.o
 obj-$(CONFIG_AMD_MEM_ENCRYPT)	+= mem_encrypt_amd.o
 
-obj-$(CONFIG_AMD_MEM_ENCRYPT)	+= mem_encrypt_identity.o
 obj-$(CONFIG_AMD_MEM_ENCRYPT)	+= mem_encrypt_boot.o
-- 
2.49.0.504.g3bcea36a83-goog


