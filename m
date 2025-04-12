Return-Path: <linux-efi+bounces-3315-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 093A1A86F8A
	for <lists+linux-efi@lfdr.de>; Sat, 12 Apr 2025 22:31:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6F7D440059
	for <lists+linux-efi@lfdr.de>; Sat, 12 Apr 2025 20:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F41D7223716;
	Sat, 12 Apr 2025 20:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uoM/fF33";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lZdw4TIv"
X-Original-To: linux-efi@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006EF222595;
	Sat, 12 Apr 2025 20:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744489769; cv=none; b=o4HTAhQ/+gQSazDXpOD0hAQXFsQL/EIqU3znEQUSJFuOA0znB1dwqA0uJnEpR4J/dX8ECdXOJR7R0HkaTeksNdemq0bZNhol3ioh6c/Ay3VSc1rPnLFPJgxtflpOoLtPYG5NefYOHzUx4Zl1KkY2dzqr8hpNE9cmdYDjC1oQUtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744489769; c=relaxed/simple;
	bh=rMjHkX1xfLgtFkjjLJsJ2Ui12pBlWEUwS8mvm4oVilc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Pnl5XDOjT7x4YJulHed4hIXcDOWbb3tuWIdScfKQmYLYqJAkLop4x2cR1VK5ciSK0TraVb6jA8P0AKxPX0NVi1alV/yCZcGvzIyhZEgGSCRkWbwHe2uTWP1TiLv12m6G1MIHVK0/OtKuMxFUlET+j4GHtdd3KEhpKExrVQRzHcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uoM/fF33; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lZdw4TIv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 12 Apr 2025 20:29:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744489766;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wXQxm0WsK9sAkxd1EDS0C9rqpJ+5cF3wXbUnbVYbhxw=;
	b=uoM/fF33C4Flek14j4qujhvuNxy1VbqLRY+3zr8jOT7irIgwD6BE0piawhoC3Iic4jZNQu
	kOrN5o3b4s+cHjAMtNlvclRB2oqQSh0+Yziw0yX+3zTzrnLJNzjKdBu5L7jXqM5weufXO/
	tFrIOwSHCdCGkZQjYDHx2tx4qmvyhOvmGVwbKfRaugL9Rbiq8g0G5yxfZIpGUKcJ1NH5Ok
	UQ9mFabkThkrkp0/LCwQjl7A7sL7UZZ79Pipif1ijjpM2G3Y25S7RToVCEQt7pYKAQ9lpJ
	hUwnAHbMx8gTkmO4OttDyCilFXVgauLG/dyEG/cWCvJzCZurbCxcejiO7oHFPA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744489766;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wXQxm0WsK9sAkxd1EDS0C9rqpJ+5cF3wXbUnbVYbhxw=;
	b=lZdw4TIvSmG2DkjYm2VQWCqMrywIa4ByDjy62sVfqiDLTgMkS72GK0Q3kZt7cqkl0j+Eu8
	IV0/mTfLirHOPAAQ==
From: "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/boot/sev: Avoid shared GHCB page for early memory
 acceptance
Cc: Tom Lendacky <thomas.lendacky@amd.com>, Ard Biesheuvel <ardb@kernel.org>,
 Ingo Molnar <mingo@kernel.org>, Dionna Amalie Glaze <dionnaglaze@google.com>,
 Kevin Loughlin <kevinloughlin@google.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 linux-efi@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250410132850.3708703-2-ardb+git@google.com>
References: <20250410132850.3708703-2-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174448976513.31282.4012948519562214371.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     5871c9d650bc0ccb16ed8444f16045808ba936bf
Gitweb:        https://git.kernel.org/tip/5871c9d650bc0ccb16ed8444f16045808ba936bf
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Thu, 10 Apr 2025 15:28:51 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 12 Apr 2025 20:43:41 +02:00

x86/boot/sev: Avoid shared GHCB page for early memory acceptance

Communicating with the hypervisor using the shared GHCB page requires
clearing the C bit in the mapping of that page. When executing in the
context of the EFI boot services, the page tables are owned by the
firmware, and this manipulation is not possible.

So switch to a different API for accepting memory in SEV-SNP guests, one
which is actually supported at the point during boot where the EFI stub
may need to accept memory, but the SEV-SNP init code has not executed
yet.

For simplicity, also switch the memory acceptance carried out by the
decompressor when not booting via EFI - this only involves the
allocation for the decompressed kernel, and is generally only called
after kexec, as normal boot will jump straight into the kernel from the
EFI stub.

Non-EFI stub boot will become slower if the memory that is used to
decompress the kernel has not been accepted yet. But given how heavily
SEV-SNP depends on EFI boot, this typically only happens on kexec, as
that is the only boot path that goes through the traditional
decompressor.

The GHCB shared page method never worked for accepting memory from the
EFI stub, but this is rarely needed in practice: when using the higher
level page allocation APIs, the firmware will make sure that memory is
accepted before it is returned. The only use case for explicit memory
acceptance by the EFI stub is when populating the 'unaccepted memory'
bitmap, which tracks unaccepted memory at a 2MB granularity, and so
chunks of unaccepted memory that are misaligned wrt that are accepted
without being allocated or used.

AFAICS this never worked correctly for SEV-SNP, we're just lucky
the firmware appears to accept memory in 2+ MB batches and so
these misaligned chunks are rare in practice. Tom did manage to
trigger it IIUC by giving a VM an amount of memory that is not a
multiple of 2M.

Co-developed-by: Tom Lendacky <thomas.lendacky@amd.com>

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Dionna Amalie Glaze <dionnaglaze@google.com>
Cc: Kevin Loughlin <kevinloughlin@google.com>
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: linux-efi@vger.kernel.org
Link: https://lore.kernel.org/r/20250410132850.3708703-2-ardb+git@google.com
---
 arch/x86/boot/compressed/sev.c | 67 +++++++--------------------------
 1 file changed, 15 insertions(+), 52 deletions(-)

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index 6eadd79..478eca4 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -169,10 +169,7 @@ bool sev_snp_enabled(void)
 
 static void __page_state_change(unsigned long paddr, enum psc_op op)
 {
-	u64 val;
-
-	if (!sev_snp_enabled())
-		return;
+	u64 val, msr;
 
 	/*
 	 * If private -> shared then invalidate the page before requesting the
@@ -181,6 +178,9 @@ static void __page_state_change(unsigned long paddr, enum psc_op op)
 	if (op == SNP_PAGE_STATE_SHARED)
 		pvalidate_4k_page(paddr, paddr, false);
 
+	/* Save the current GHCB MSR value */
+	msr = sev_es_rd_ghcb_msr();
+
 	/* Issue VMGEXIT to change the page state in RMP table. */
 	sev_es_wr_ghcb_msr(GHCB_MSR_PSC_REQ_GFN(paddr >> PAGE_SHIFT, op));
 	VMGEXIT();
@@ -190,6 +190,9 @@ static void __page_state_change(unsigned long paddr, enum psc_op op)
 	if ((GHCB_RESP_CODE(val) != GHCB_MSR_PSC_RESP) || GHCB_MSR_PSC_RESP_VAL(val))
 		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_PSC);
 
+	/* Restore the GHCB MSR value */
+	sev_es_wr_ghcb_msr(msr);
+
 	/*
 	 * Now that page state is changed in the RMP table, validate it so that it is
 	 * consistent with the RMP entry.
@@ -200,11 +203,17 @@ static void __page_state_change(unsigned long paddr, enum psc_op op)
 
 void snp_set_page_private(unsigned long paddr)
 {
+	if (!sev_snp_enabled())
+		return;
+
 	__page_state_change(paddr, SNP_PAGE_STATE_PRIVATE);
 }
 
 void snp_set_page_shared(unsigned long paddr)
 {
+	if (!sev_snp_enabled())
+		return;
+
 	__page_state_change(paddr, SNP_PAGE_STATE_SHARED);
 }
 
@@ -228,56 +237,10 @@ static bool early_setup_ghcb(void)
 	return true;
 }
 
-static phys_addr_t __snp_accept_memory(struct snp_psc_desc *desc,
-				       phys_addr_t pa, phys_addr_t pa_end)
-{
-	struct psc_hdr *hdr;
-	struct psc_entry *e;
-	unsigned int i;
-
-	hdr = &desc->hdr;
-	memset(hdr, 0, sizeof(*hdr));
-
-	e = desc->entries;
-
-	i = 0;
-	while (pa < pa_end && i < VMGEXIT_PSC_MAX_ENTRY) {
-		hdr->end_entry = i;
-
-		e->gfn = pa >> PAGE_SHIFT;
-		e->operation = SNP_PAGE_STATE_PRIVATE;
-		if (IS_ALIGNED(pa, PMD_SIZE) && (pa_end - pa) >= PMD_SIZE) {
-			e->pagesize = RMP_PG_SIZE_2M;
-			pa += PMD_SIZE;
-		} else {
-			e->pagesize = RMP_PG_SIZE_4K;
-			pa += PAGE_SIZE;
-		}
-
-		e++;
-		i++;
-	}
-
-	if (vmgexit_psc(boot_ghcb, desc))
-		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_PSC);
-
-	pvalidate_pages(desc);
-
-	return pa;
-}
-
 void snp_accept_memory(phys_addr_t start, phys_addr_t end)
 {
-	struct snp_psc_desc desc = {};
-	unsigned int i;
-	phys_addr_t pa;
-
-	if (!boot_ghcb && !early_setup_ghcb())
-		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_PSC);
-
-	pa = start;
-	while (pa < end)
-		pa = __snp_accept_memory(&desc, pa, end);
+	for (phys_addr_t pa = start; pa < end; pa += PAGE_SIZE)
+		__page_state_change(pa, SNP_PAGE_STATE_PRIVATE);
 }
 
 void sev_es_shutdown_ghcb(void)

