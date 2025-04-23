Return-Path: <linux-efi+bounces-3432-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E27EA9910E
	for <lists+linux-efi@lfdr.de>; Wed, 23 Apr 2025 17:26:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA51A1BA149B
	for <lists+linux-efi@lfdr.de>; Wed, 23 Apr 2025 15:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0696A293B53;
	Wed, 23 Apr 2025 15:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="I0fx1tax"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C1C2641EA;
	Wed, 23 Apr 2025 15:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745421183; cv=none; b=uxOFyus61boX7kL/cMcMH7CPtjL258R23jFwqSyUyFAF6vBzp5WQdcEsocPaieDHJ8ELdVlJ56vht8nxJRUOYu08VjjscR1pW7H6o1+qY4llk++UDyAv3//frDXamWpeR9idqi4J8H5koO+0ipecIj4TxJDZCftneDWG5CxIs38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745421183; c=relaxed/simple;
	bh=HC0MYwYV0YFtr87RBblIqOtWJoq6NR83UHidBGoSxNE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KBye78CYg25O1MKh1+WQdctnW7/AYNZsbHrYb33MkaqQvC5gRUuIpcrghuwFg5t4d0cIw2+5iOm1d7c2lZQ2apP0BMTzk6D+QgWrZxnt0sfKIk/CifUuatJTngHbVv2OD1Q8QPol2U8fcM2Sa5BTsCYB6DCc0g25Dlt95G7wOv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=I0fx1tax; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6404EC4CEE2;
	Wed, 23 Apr 2025 15:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745421183;
	bh=HC0MYwYV0YFtr87RBblIqOtWJoq6NR83UHidBGoSxNE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I0fx1taxnFnWc0DU6yP8xK2APQKCKL6mqskGcsVw0L4suV/5joY339rV6BNh4moWR
	 J114qRgeZZZ/9n4UKnfxD7VGgingUEFKPyRpVq1odgd1KxeX8rrUQzNkdggrK+NOol
	 V/Gv0T/aOvyBDHoqaTY6gom0lC9/ZJHFCVabsXAk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Dionna Amalie Glaze <dionnaglaze@google.com>,
	Kevin Loughlin <kevinloughlin@google.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-efi@vger.kernel.org
Subject: [PATCH 6.14 159/241] x86/boot/sev: Avoid shared GHCB page for early memory acceptance
Date: Wed, 23 Apr 2025 16:43:43 +0200
Message-ID: <20250423142627.037630527@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250423142620.525425242@linuxfoundation.org>
References: <20250423142620.525425242@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ard Biesheuvel <ardb@kernel.org>

commit d54d610243a4508183978871e5faff5502786cd4 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/boot/compressed/mem.c |    5 ++-
 arch/x86/boot/compressed/sev.c |   67 +++++++++--------------------------------
 arch/x86/boot/compressed/sev.h |    2 +
 3 files changed, 21 insertions(+), 53 deletions(-)

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
@@ -176,6 +173,9 @@ static void __page_state_change(unsigned
 	if (op == SNP_PAGE_STATE_SHARED)
 		pvalidate_4k_page(paddr, paddr, false);
 
+	/* Save the current GHCB MSR value */
+	msr = sev_es_rd_ghcb_msr();
+
 	/* Issue VMGEXIT to change the page state in RMP table. */
 	sev_es_wr_ghcb_msr(GHCB_MSR_PSC_REQ_GFN(paddr >> PAGE_SHIFT, op));
 	VMGEXIT();
@@ -185,6 +185,9 @@ static void __page_state_change(unsigned
 	if ((GHCB_RESP_CODE(val) != GHCB_MSR_PSC_RESP) || GHCB_MSR_PSC_RESP_VAL(val))
 		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_PSC);
 
+	/* Restore the GHCB MSR value */
+	sev_es_wr_ghcb_msr(msr);
+
 	/*
 	 * Now that page state is changed in the RMP table, validate it so that it is
 	 * consistent with the RMP entry.
@@ -195,11 +198,17 @@ static void __page_state_change(unsigned
 
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
 



