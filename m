Return-Path: <linux-efi+bounces-3365-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA6FA9373B
	for <lists+linux-efi@lfdr.de>; Fri, 18 Apr 2025 14:37:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 638F51885F0D
	for <lists+linux-efi@lfdr.de>; Fri, 18 Apr 2025 12:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63E59275119;
	Fri, 18 Apr 2025 12:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lEAS3BL0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uZOhnxd5"
X-Original-To: linux-efi@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B455274FDA;
	Fri, 18 Apr 2025 12:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744979830; cv=none; b=mSWEyIzlcPdq0FXA5Rq1QSVxIKD2r5YwZoYPwmPXbT2X3Ct27tX/1R2G0U7G2uzhlMzwieJuULaWT0jzkAqatLGtHntgQ0/rgNYU2p6JH/V/LhY3lKVxx7JYGKqzqoB8pgLybgBzkbCHwdg8s15ppEJ5zm1wlj7bkP/yuVwCVK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744979830; c=relaxed/simple;
	bh=KDcib2jwnUhNtMFXljhPQQvcrmbcThDs56Rkk7ZDnrM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=R8qRjHBEfO7TW0KQXdh5qO0u3MRrXnWbZUeqK9oV5rEqzzvW5JWIDxClFESquMRHvejZPATQCe0D6VCpunyO7a2IBYHGzOuqkuJLvs3OEKBUOL4UKxI37BBm8uBKPQSjlSerhfC+uxpYfHbXbu/N1GH5ndvpzm9NWYK48f8z5Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lEAS3BL0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uZOhnxd5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 18 Apr 2025 12:36:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744979826;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L0LXxWB86fT19PiwD5mZUmtXb/bcgOurcHBNW1jFCUs=;
	b=lEAS3BL04a70BfmhlBZ9/F/5NoCJgiX29we0RbtT2/6LyN6v5P6ivpBsDpA5df5ugGmvmp
	UvDV2Yzu6SoMiDRXjX7DjZpGE2vCB7JtuqMldsfWEVD9pfFLE1eGI4waEbZvfz0n8JY+sk
	GNrQX7MjE7dtPq6b1UAHY6Cks6xul8AfZnkQvFEug0sOMOV1M5KqYJWiCAjNU+0RBv1ADe
	HeZugKTJiBCqwkpNSXeWTV9OkGzbwL6pSiQ1cAMLVppf9s5IN+NGbviq996RtPZ+YD4IGz
	25EE7WUKzq1YLjHfrqwdFV2PWqVD7248xtL/V7UyfNDJtI8/e2mBfOPfPYS7yQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744979826;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L0LXxWB86fT19PiwD5mZUmtXb/bcgOurcHBNW1jFCUs=;
	b=uZOhnxd5NOtgP0xrASOQKsFiwh9q4eX0iuwFH2NrhY80wD8iDldZ+bl5Cmu8LLmQn7oqF3
	5erFEWVN2g4G5DCQ==
From: "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/boot/sev: Avoid shared GHCB page for early
 memory acceptance
Cc: Tom Lendacky <thomas.lendacky@amd.com>, Ard Biesheuvel <ardb@kernel.org>,
 Ingo Molnar <mingo@kernel.org>,  <stable@vger.kernel.org>,
 Dionna Amalie Glaze <dionnaglaze@google.com>,
 Kevin Loughlin <kevinloughlin@google.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, linux-efi@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250417202120.1002102-2-ardb+git@google.com # final submission>
References: <20250417202120.1002102-2-ardb+git@google.com # final submission>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174497981597.31282.11132510777107932698.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     d54d610243a4508183978871e5faff5502786cd4
Gitweb:        https://git.kernel.org/tip/d54d610243a4508183978871e5faff5502786cd4
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Thu, 17 Apr 2025 22:21:21 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 18 Apr 2025 14:30:30 +02:00

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

Fixes: 6c3211796326 ("x86/sev: Add SNP-specific unaccepted memory support")
Tested-by: Tom Lendacky <thomas.lendacky@amd.com>
Co-developed-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: <stable@vger.kernel.org>
Cc: Dionna Amalie Glaze <dionnaglaze@google.com>
Cc: Kevin Loughlin <kevinloughlin@google.com>
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-efi@vger.kernel.org
Link: https://lore.kernel.org/r/20250404082921.2767593-8-ardb+git@google.com # discussion thread #1
Link: https://lore.kernel.org/r/20250410132850.3708703-2-ardb+git@google.com # discussion thread #2
Link: https://lore.kernel.org/r/20250417202120.1002102-2-ardb+git@google.com # final submission
---
 arch/x86/boot/compressed/mem.c |  5 +-
 arch/x86/boot/compressed/sev.c | 67 +++++++--------------------------
 arch/x86/boot/compressed/sev.h |  2 +-
 3 files changed, 21 insertions(+), 53 deletions(-)

diff --git a/arch/x86/boot/compressed/mem.c b/arch/x86/boot/compressed/mem.c
index dbba332..f676156 100644
--- a/arch/x86/boot/compressed/mem.c
+++ b/arch/x86/boot/compressed/mem.c
@@ -34,11 +34,14 @@ static bool early_is_tdx_guest(void)
 
 void arch_accept_memory(phys_addr_t start, phys_addr_t end)
 {
+	static bool sevsnp;
+
 	/* Platform-specific memory-acceptance call goes here */
 	if (early_is_tdx_guest()) {
 		if (!tdx_accept_memory(start, end))
 			panic("TDX: Failed to accept memory\n");
-	} else if (sev_snp_enabled()) {
+	} else if (sevsnp || (sev_get_status() & MSR_AMD64_SEV_SNP_ENABLED)) {
+		sevsnp = true;
 		snp_accept_memory(start, end);
 	} else {
 		error("Cannot accept memory: unknown platform\n");
diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index bb55934..89ba168 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -164,10 +164,7 @@ bool sev_snp_enabled(void)
 
 static void __page_state_change(unsigned long paddr, enum psc_op op)
 {
-	u64 val;
-
-	if (!sev_snp_enabled())
-		return;
+	u64 val, msr;
 
 	/*
 	 * If private -> shared then invalidate the page before requesting the
@@ -176,6 +173,9 @@ static void __page_state_change(unsigned long paddr, enum psc_op op)
 	if (op == SNP_PAGE_STATE_SHARED)
 		pvalidate_4k_page(paddr, paddr, false);
 
+	/* Save the current GHCB MSR value */
+	msr = sev_es_rd_ghcb_msr();
+
 	/* Issue VMGEXIT to change the page state in RMP table. */
 	sev_es_wr_ghcb_msr(GHCB_MSR_PSC_REQ_GFN(paddr >> PAGE_SHIFT, op));
 	VMGEXIT();
@@ -185,6 +185,9 @@ static void __page_state_change(unsigned long paddr, enum psc_op op)
 	if ((GHCB_RESP_CODE(val) != GHCB_MSR_PSC_RESP) || GHCB_MSR_PSC_RESP_VAL(val))
 		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_PSC);
 
+	/* Restore the GHCB MSR value */
+	sev_es_wr_ghcb_msr(msr);
+
 	/*
 	 * Now that page state is changed in the RMP table, validate it so that it is
 	 * consistent with the RMP entry.
@@ -195,11 +198,17 @@ static void __page_state_change(unsigned long paddr, enum psc_op op)
 
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
 
@@ -223,56 +232,10 @@ static bool early_setup_ghcb(void)
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
diff --git a/arch/x86/boot/compressed/sev.h b/arch/x86/boot/compressed/sev.h
index fc725a9..4e463f3 100644
--- a/arch/x86/boot/compressed/sev.h
+++ b/arch/x86/boot/compressed/sev.h
@@ -12,11 +12,13 @@
 
 bool sev_snp_enabled(void);
 void snp_accept_memory(phys_addr_t start, phys_addr_t end);
+u64 sev_get_status(void);
 
 #else
 
 static inline bool sev_snp_enabled(void) { return false; }
 static inline void snp_accept_memory(phys_addr_t start, phys_addr_t end) { }
+static inline u64 sev_get_status(void) { return 0; }
 
 #endif
 

