Return-Path: <linux-efi+bounces-3225-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA6B0A7F8BD
	for <lists+linux-efi@lfdr.de>; Tue,  8 Apr 2025 10:59:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E7591891CA2
	for <lists+linux-efi@lfdr.de>; Tue,  8 Apr 2025 08:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19BCD266B5C;
	Tue,  8 Apr 2025 08:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JC41q92o"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1062626659C
	for <linux-efi@vger.kernel.org>; Tue,  8 Apr 2025 08:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744102409; cv=none; b=P3MTeiDhUVn6xrVljRBphZelTRdVVRwad11Jq0HgNPBtMaJR+t0ti/sEvgAYOj+b/wm/6lcWFwU+GF/aW5i7Fog/teDanOmFM06ykg+dcsL4SLX1lB/NL3TRPneKm0P2EKsWOC2dXCataqSxePSiMNTrCf8f0vsIfDHjeZtbCJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744102409; c=relaxed/simple;
	bh=N4MtpQRBVB+U9+XwdsBV8OoaO5bJmSMiovkcXVy1Y8M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ULX7F2eg2ofx6ha1UFXqyxAfQuhVsiPELGvG9DV+ohpt56kexCXtbpA0ZnDZP44SK/926VWrjsq8AyR2HKvqsKpWCF8Fqv0njSZyqHHMaW+d7GlXoWEXT6FT4Z34N1LReV/dn5IZQi76sQf5pOydyXIGdi/Odvd3pgWC4ydll7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JC41q92o; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-43ea256f039so44448695e9.0
        for <linux-efi@vger.kernel.org>; Tue, 08 Apr 2025 01:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744102405; x=1744707205; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pfhvtPh90PyQrqwseeYAemYLSGq1dbH+1FaY8eo5bSo=;
        b=JC41q92oFk6Vtj3L6BZ63eAuC392Llq0DAw4AI/k25YAgx57la3TjEFkNn6050akDz
         2wCBr9YOrx8ajmr6yxzTMMOEMJWFowUuFXNqO+47nV0ZqYKnqc38DAYwOiaeiY4+qpUt
         P0CaoUqCgC5FaseaTV7xt7ZgTcW7/L7Pr9WkdPVESo4YQAm2XyUf++QZ5e3PBGQ138d2
         IVSPlDMk6JoPoRYqWsNV6gEhQOD7y/w1YRhrw8U6WueODlQB5v+voE0qoTBYiaJSIbdX
         rZQD5X8HnMGKc8U+fqpiu+JIk240ZavOY25N12MusvMWoijcB/bZ65G+Wc/upO8/hefp
         VoUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744102405; x=1744707205;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pfhvtPh90PyQrqwseeYAemYLSGq1dbH+1FaY8eo5bSo=;
        b=I5pzg2CG+BFz6B+/IHw6T6pENBzARnYDSl1G0si2duB0MWBow1zWmC9kZdk1DzNZEp
         aSOCdCoYTCXB2+CbqggcCJcVclerTHhZG8Hhy9ZjkwnJirhTCaUKHS38YQB43aek0vOO
         xW8c8d7eKBKGKERNdASEIKwTZcHg6Q+EhYG065Zls2G8QQ9pzcUVk/WSRN2TZToExPQ+
         1Npk2ViaGdKo6+bwMuLiLMFeGlBEOVY+Mhi48rSTY6UWS64fTuvacd3o8FgsRyVmi531
         3hOY1vXT35j2l2vRkxyeVOiZDsmahs/ufl4V6io786P62uca0AINMFXvH9Xj0uKQmxqS
         OncA==
X-Gm-Message-State: AOJu0YyWWgqkR37+t8HCrJm9MkY/mm62I21B2v2tq45ovaCrLa+FX3xX
	bNSSK/SV83imfN1cBJjO5pVLyxWCI/+Ve/yoDajBNnaIkvYulq0FO/mtijOsLrAKO6GfWrvoT1C
	45g8L/W8oqXNjbvwhApdCJZfsKIoOFvJjoJlUxlsCJ08n2ihIcWlKhwiMX7WRw6cbq3T8ATGbuk
	3bwdP2O2DqqOVlMOI+1da1F1lFzg==
X-Google-Smtp-Source: AGHT+IEhPrPgdJzj906H7sww6L5Y+LDSIWu5QMVJjoFQGwSmapUF2HDvtaGfxN7pP2fW7nAn0X+DTnzO
X-Received: from wmcq28.prod.google.com ([2002:a05:600c:c11c:b0:43b:c336:7b29])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:1819:b0:43c:f895:cb4e
 with SMTP id 5b1f17b1804b1-43ed0c6b9famr109080695e9.17.1744102405529; Tue, 08
 Apr 2025 01:53:25 -0700 (PDT)
Date: Tue,  8 Apr 2025 10:53:00 +0200
In-Reply-To: <20250408085254.836788-9-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250408085254.836788-9-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=4518; i=ardb@kernel.org;
 h=from:subject; bh=vBaHbEMhT1iu9JGCBB53txIntdweeE+e86SJD43lhWg=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIf3L4/dvZgu86r2/v6vpVuiJjY+q5M2m5qqX3i/fWClvz
 Z3ke/dYRykLgxgHg6yYIovA7L/vdp6eKFXrPEsWZg4rE8gQBi5OAZjIlHiG/5nvZa1PPyiWC7xp
 F2G7OSNG4aT2xO0qd60Es20/fzstVsTwT6tH4fTHmaqpkxz07Zf7r60JXlvBOvVvaUmnud6M5Uo XGAE=
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250408085254.836788-14-ardb+git@google.com>
Subject: [PATCH v3 5/7] x86/boot: Drop RIP_REL_REF() uses from early mapping code
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: x86@kernel.org, mingo@kernel.org, linux-kernel@vger.kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Dionna Amalie Glaze <dionnaglaze@google.com>, Kevin Loughlin <kevinloughlin@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Now that __startup_64() is built using -fPIC, RIP_REL_REF() has become a
NOP and can be removed. Only some occurrences of rip_rel_ptr() will
remain, to explicitly take the address of certain global structures in
the 1:1 mapping of memory.

While at it, update the code comment to describe why this is needed.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/startup/map_kernel.c | 41 ++++++++++----------
 1 file changed, 21 insertions(+), 20 deletions(-)

diff --git a/arch/x86/boot/startup/map_kernel.c b/arch/x86/boot/startup/map_kernel.c
index 5f1b7e0ba26e..0eac3f17dbd3 100644
--- a/arch/x86/boot/startup/map_kernel.c
+++ b/arch/x86/boot/startup/map_kernel.c
@@ -26,12 +26,12 @@ static inline bool check_la57_support(void)
 	if (!(native_read_cr4() & X86_CR4_LA57))
 		return false;
 
-	RIP_REL_REF(__pgtable_l5_enabled)	= 1;
-	RIP_REL_REF(pgdir_shift)		= 48;
-	RIP_REL_REF(ptrs_per_p4d)		= 512;
-	RIP_REL_REF(page_offset_base)		= __PAGE_OFFSET_BASE_L5;
-	RIP_REL_REF(vmalloc_base)		= __VMALLOC_BASE_L5;
-	RIP_REL_REF(vmemmap_base)		= __VMEMMAP_BASE_L5;
+	__pgtable_l5_enabled	= 1;
+	pgdir_shift		= 48;
+	ptrs_per_p4d		= 512;
+	page_offset_base	= __PAGE_OFFSET_BASE_L5;
+	vmalloc_base		= __VMALLOC_BASE_L5;
+	vmemmap_base		= __VMEMMAP_BASE_L5;
 
 	return true;
 }
@@ -81,12 +81,14 @@ static unsigned long __head sme_postprocess_startup(struct boot_params *bp,
 	return sme_get_me_mask();
 }
 
-/* Code in __startup_64() can be relocated during execution, but the compiler
- * doesn't have to generate PC-relative relocations when accessing globals from
- * that function. Clang actually does not generate them, which leads to
- * boot-time crashes. To work around this problem, every global pointer must
- * be accessed using RIP_REL_REF(). Kernel virtual addresses can be determined
- * by subtracting p2v_offset from the RIP-relative address.
+/*
+ * This code is compiled using PIC codegen because it will execute from the
+ * early 1:1 mapping of memory, which deviates from the mapping expected by the
+ * linker. Due to this deviation, taking the address of a global variable will
+ * produce an ambiguous result when using the plain & operator.  Instead,
+ * rip_rel_ptr() must be used, which will return the RIP-relative address in
+ * the 1:1 mapping of memory. Kernel virtual addresses can be determined by
+ * subtracting p2v_offset from the RIP-relative address.
  */
 unsigned long __head __startup_64(unsigned long p2v_offset,
 				  struct boot_params *bp)
@@ -113,8 +115,7 @@ unsigned long __head __startup_64(unsigned long p2v_offset,
 	 * Compute the delta between the address I am compiled to run at
 	 * and the address I am actually running at.
 	 */
-	load_delta = __START_KERNEL_map + p2v_offset;
-	RIP_REL_REF(phys_base) = load_delta;
+	phys_base = load_delta = __START_KERNEL_map + p2v_offset;
 
 	/* Is the address not 2M aligned? */
 	if (load_delta & ~PMD_MASK)
@@ -138,11 +139,11 @@ unsigned long __head __startup_64(unsigned long p2v_offset,
 		pgd[pgd_index(__START_KERNEL_map)] = (pgdval_t)p4d | _PAGE_TABLE;
 	}
 
-	RIP_REL_REF(level3_kernel_pgt)[PTRS_PER_PUD - 2].pud += load_delta;
-	RIP_REL_REF(level3_kernel_pgt)[PTRS_PER_PUD - 1].pud += load_delta;
+	level3_kernel_pgt[PTRS_PER_PUD - 2].pud += load_delta;
+	level3_kernel_pgt[PTRS_PER_PUD - 1].pud += load_delta;
 
 	for (i = FIXMAP_PMD_TOP; i > FIXMAP_PMD_TOP - FIXMAP_PMD_NUM; i--)
-		RIP_REL_REF(level2_fixmap_pgt)[i].pmd += load_delta;
+		level2_fixmap_pgt[i].pmd += load_delta;
 
 	/*
 	 * Set up the identity mapping for the switchover.  These
@@ -153,12 +154,12 @@ unsigned long __head __startup_64(unsigned long p2v_offset,
 
 	pud = &early_pgts[0]->pmd;
 	pmd = &early_pgts[1]->pmd;
-	RIP_REL_REF(next_early_pgt) = 2;
+	next_early_pgt = 2;
 
 	pgtable_flags = _KERNPG_TABLE_NOENC + sme_get_me_mask();
 
 	if (la57) {
-		p4d = &early_pgts[RIP_REL_REF(next_early_pgt)++]->pmd;
+		p4d = &early_pgts[next_early_pgt++]->pmd;
 
 		i = (physaddr >> PGDIR_SHIFT) % PTRS_PER_PGD;
 		pgd[i + 0] = (pgdval_t)p4d + pgtable_flags;
@@ -179,7 +180,7 @@ unsigned long __head __startup_64(unsigned long p2v_offset,
 
 	pmd_entry = __PAGE_KERNEL_LARGE_EXEC & ~_PAGE_GLOBAL;
 	/* Filter out unsupported __PAGE_KERNEL_* bits: */
-	pmd_entry &= RIP_REL_REF(__supported_pte_mask);
+	pmd_entry &= __supported_pte_mask;
 	pmd_entry += sme_get_me_mask();
 	pmd_entry +=  physaddr;
 
-- 
2.49.0.504.g3bcea36a83-goog


