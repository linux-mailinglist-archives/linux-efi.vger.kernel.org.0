Return-Path: <linux-efi+bounces-3304-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3E20A86DBB
	for <lists+linux-efi@lfdr.de>; Sat, 12 Apr 2025 16:34:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6848A1B645E8
	for <lists+linux-efi@lfdr.de>; Sat, 12 Apr 2025 14:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 104451EE7C0;
	Sat, 12 Apr 2025 14:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZkqJGgwP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NHNHUboF"
X-Original-To: linux-efi@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21261EBA0D;
	Sat, 12 Apr 2025 14:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744468426; cv=none; b=KpHcQ8HT+tjtRB7qfw2s+q3PjUn3F7mYnhv4d0b+OeO201EV2fiduuTlw3mWu4DNL1EhGkuHgpj7MF21maC2NPIQdGSwPaE5eqNMk/HitT2KYK1QQM2sWX3T+K9t+0WCf1HFLjdEfi1k5AkVMVTgsrOnLHxnEd0rryq5HeQzFAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744468426; c=relaxed/simple;
	bh=yDIG5w4leIboy5enAqg6d/rAmPG67l1fGT2+ENjGKDY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=h1R+v28MELxIqihdouoZON/ILcxHDC1d5gjFgSTn54tgWtj9fB4iUr56zcTs/kjIr+0PL0PUkohMwqzpBZBfzL1GD51GtyL7Tij+uC2wk54L4Hl6854x8MDC7UNG/Nl49Xjd4CGlq0PQFm/4YOoL9bloikn3gxK1uBYnimcZZCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZkqJGgwP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NHNHUboF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 12 Apr 2025 14:33:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744468417;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nFrKfWCwCndvyiDN3ZxxHu4GHDOnq9R9xFvgU74knoY=;
	b=ZkqJGgwPD517m5USDcER1qHrmcwVutJ+VQgblOx9OAAVcnmbjwfIFtsztctvXGHn4VYyLv
	aJuOZ7iERI7nZ7lGp4SCM5Bh20888czYGIP6dJjvREjOixLrEK8dlc+wMSrRETosoLNgIV
	QPF46edrpwB7uqIdQX1mWSum4h/uTBTuoaA2+1NMdZFyglZ3zRPsBDSJw6AXY54gQ2US83
	X8tD0VbdTgZw+Xs5HT6LmUWSwgjPd9E/gYGghSN0QPbJe8ellIYE0prukzS25TAQ8h6QdM
	mphIA4eSTDG5Av4NB4/NPnR7SHw8dklqVXBPy/mL6cFOol6I4YfiBWkCyfq/oQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744468417;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nFrKfWCwCndvyiDN3ZxxHu4GHDOnq9R9xFvgU74knoY=;
	b=NHNHUboFHNb9JBK4pim547HGh7uGAfsigWH+mH6LNTvHyvIUAxdQtgl0CrDMIZZtyefz+0
	Gx6V4bTgZ+Go26AQ==
From: "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/boot] x86/boot: Drop RIP_REL_REF() uses from early mapping code
Cc: Ard Biesheuvel <ardb@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Dionna Amalie Glaze <dionnaglaze@google.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Kees Cook <keescook@chromium.org>,
 Kevin Loughlin <kevinloughlin@google.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Tom Lendacky <thomas.lendacky@amd.com>, linux-efi@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250410134117.3713574-17-ardb+git@google.com>
References: <20250410134117.3713574-17-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174446841639.31282.17436694406609905553.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     dafb26f4271b9cc9cad07d9abf3c71c492e14f4c
Gitweb:        https://git.kernel.org/tip/dafb26f4271b9cc9cad07d9abf3c71c492e14f4c
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Thu, 10 Apr 2025 15:41:22 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 12 Apr 2025 11:13:05 +02:00

x86/boot: Drop RIP_REL_REF() uses from early mapping code

Now that __startup_64() is built using -fPIC, RIP_REL_REF() has become a
NOP and can be removed. Only some occurrences of rip_rel_ptr() will
remain, to explicitly take the address of certain global structures in
the 1:1 mapping of memory.

While at it, update the code comment to describe why this is needed.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Dionna Amalie Glaze <dionnaglaze@google.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Kevin Loughlin <kevinloughlin@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-efi@vger.kernel.org
Link: https://lore.kernel.org/r/20250410134117.3713574-17-ardb+git@google.com
---
 arch/x86/boot/startup/map_kernel.c | 41 ++++++++++++++---------------
 1 file changed, 21 insertions(+), 20 deletions(-)

diff --git a/arch/x86/boot/startup/map_kernel.c b/arch/x86/boot/startup/map_kernel.c
index 5f1b7e0..0eac3f1 100644
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
 

