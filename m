Return-Path: <linux-efi+bounces-3264-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 492AEA84541
	for <lists+linux-efi@lfdr.de>; Thu, 10 Apr 2025 15:46:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC5638A1B69
	for <lists+linux-efi@lfdr.de>; Thu, 10 Apr 2025 13:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F55028CF47;
	Thu, 10 Apr 2025 13:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HSvtvoze"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28ABE78F4E
	for <linux-efi@vger.kernel.org>; Thu, 10 Apr 2025 13:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744292512; cv=none; b=mOFia3WIEuFdsG/lCqUfiF6axMgK1bZ0OzLsAY1wCLhN9656Oah/Iz80WZaL0HedUYTNoH1F8jk/rUyZtGyQ07Bot6qKGtl5eo89YWDMEDOC6wugZr0dOwBvBlDv1bVnxsgDsEpDE0K1tQ6/uzH1IlJjfzVpAjKTpJT8CVn25cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744292512; c=relaxed/simple;
	bh=N4MtpQRBVB+U9+XwdsBV8OoaO5bJmSMiovkcXVy1Y8M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CFZKT4c8LsCJaLZhRwHdo7L2gk34DPn4VI6Ie49uc2VgFsLLNjLP4hEp4LK7jyLUPuWqyhcYN7vGPX5zV738wGGncvNJ0+kT7lWl8HW0qszIaXaj0AoM3OLsKBB6ebPm2pvD/FnTzi4ofsWHAJ7GwNJZfDi3GqfwNLK19Tj2PaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HSvtvoze; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-43d22c304adso8764645e9.0
        for <linux-efi@vger.kernel.org>; Thu, 10 Apr 2025 06:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744292508; x=1744897308; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pfhvtPh90PyQrqwseeYAemYLSGq1dbH+1FaY8eo5bSo=;
        b=HSvtvozeMV8Z3dDkb4TLnuueFSa8Vo3ZzejIjdBL1yJxpUf80cOeolUF56jFKzMsyv
         3B2z3lkRGTXcZ63ayEWeHgV7UKh9R2XhEjShzqOWmVwVl9+er25QizVR1gxuBkBQqKyU
         RXqLq4aP3VyTBms210t9FhMVWxLK+PiNaqVtcPaFGyzFyYqo7+65FSRrgBV/SV9KKoUp
         DBSDghi1RYkWAddfcCy8dK1QJ3Prlcg+8Ux7mHK94/kjx0BYQ3WAo7kZk1fX7SQGLOm5
         voTOgD8rjwUv7xFBJqsx+x1waCSO7HTBWodFOwT25xwoBE32EeR8U9gkwOywcPg/mX6t
         EPRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744292508; x=1744897308;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pfhvtPh90PyQrqwseeYAemYLSGq1dbH+1FaY8eo5bSo=;
        b=u3w1H8k142uWnTnXgcSHEuYVCEprXZfWGhndg1Nwden6QMhNxXxoY+rbmStTVT3lN6
         wbsJUP3ghvxHy8gFw2qVLVm44EblX6aR13JfaHC03sY7KxF9MIS4rmNFLtbu7DWAwj0m
         XOyGkbeDLsSKxo2VFgrvCkoNW/Q4Q/smDlnE8f+l1W+kEWiIdg4L4uc4HJhx6kn4QmaM
         6Cr/Pfes2e7N+JeyrZJ6MY6LggP6G9JW9oe0FhJxy0+2wNallJYXvMJvD+nhQzaJuFh2
         fq23zaedL6NAboVtUfDTFKeBxKVGlWF9Y57odJot7gPcw1jVy+IbvfxuwsGNIFBKF9r0
         C+1w==
X-Gm-Message-State: AOJu0YxkwZLYTMNifc4cfFZJSCLfKBpFab1+qq3Cj7QJFBWSClAyzIny
	j7rrm3CDhLpbw6hXBnV1WhYG99b9fJyYaeUF4FyHdSw8sFzow+9+Zy7XzZhTuo/mhsE0G0j3jtZ
	6Jyxhux8ny8M+YqP0nBatjYgv0w/1KLKXwflUUBYOg4DiVYT6PujqynJssc5fKjRTtSHtILXkh3
	HcxUIv4aJmitNWAo7RxuI9j6IdNQ==
X-Google-Smtp-Source: AGHT+IEHgsALtbsBtlCh5VUUbOKjAbYRqEioBxZdA2XTwAKO+rsn9gwbhSvj8B86/s9ydc4ad/YnzBYc
X-Received: from wmbh13.prod.google.com ([2002:a05:600c:a10d:b0:43d:9f1:31a9])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:14b:b0:43d:174:2668
 with SMTP id 5b1f17b1804b1-43f3630500dmr3554455e9.0.1744292508427; Thu, 10
 Apr 2025 06:41:48 -0700 (PDT)
Date: Thu, 10 Apr 2025 15:41:22 +0200
In-Reply-To: <20250410134117.3713574-13-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250410134117.3713574-13-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=4518; i=ardb@kernel.org;
 h=from:subject; bh=vBaHbEMhT1iu9JGCBB53txIntdweeE+e86SJD43lhWg=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIf37qZY3swVe9d7f39V0K/TExkdV8mZTc9VL75dvrJS35
 k7yvXuso5SFQYyDQVZMkUVg9t93O09PlKp1niULM4eVCWQIAxenAEyE+wkjw7vHDXxpKdeStydN
 q1gV6xifuuJoEMctwQ8r8hmzWedEejD84dhQPq3Is2pH4/15LBJ8DRdux156liTt+2L2Tf9q7b3 x7AA=
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250410134117.3713574-17-ardb+git@google.com>
Subject: [PATCH v4 04/11] x86/boot: Drop RIP_REL_REF() uses from early mapping code
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


