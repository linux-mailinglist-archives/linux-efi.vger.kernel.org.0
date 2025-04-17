Return-Path: <linux-efi+bounces-3358-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 18462A92C3B
	for <lists+linux-efi@lfdr.de>; Thu, 17 Apr 2025 22:22:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3B297B0D98
	for <lists+linux-efi@lfdr.de>; Thu, 17 Apr 2025 20:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7519B35948;
	Thu, 17 Apr 2025 20:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xW6S3/5w"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F6B20C00C
	for <linux-efi@vger.kernel.org>; Thu, 17 Apr 2025 20:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744921289; cv=none; b=dR9U0haQ3UO7tmMvQcNzTw6oDDhwJ7XOGVSPqH1iXQ+fnudep8H9AxB3dKr8qEiEuqKqoAHljAXth8Kgaa14xucVkSbYWH3vi1gf75ACzJGH/9Sl5oV0g9k5vS5w8GXBT+2yny4MdL4Bp+27M8OXrO8m7R3nHl1pu+67dQyVdqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744921289; c=relaxed/simple;
	bh=66tsWBjNz+zh8eLqwu33nyvpM7vLKA/wolnUy6WBQfY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=O5iAyzb1/jwIz8Kz5wwtXiNto7JRb4V4+mBtn/UDUE6llsDwp9ys1t/2ir66bbFN5ITVV9PbnlSvTdH1eK0lFvKPTc0VuZ4fdPtORaS5JNOVUNwaLzGa2aaxE1nrg6mFx/jZXXEHQ/5XHuymOdMvYsugXOKiLDhwu+CcJ514Vps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xW6S3/5w; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-43cfda30a3cso5873235e9.3
        for <linux-efi@vger.kernel.org>; Thu, 17 Apr 2025 13:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744921284; x=1745526084; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ycmcvdno8cbwQvOBXiBeKxD5ah0Oq2an+ma35xNxgcw=;
        b=xW6S3/5wvTFUSRKGTujNkRVmz+9m1DSX4KN/HxumituPkzDUcwNwHP/kgPeDKXMV34
         0ldSin48QaDMMzLy0FkZfAwOqYo7cC9m23x3fKH4PwieE1a8WHXma5Eik7uhQHBbGvN6
         v9aANn46WJMf/FgQwwBAjhdcfC8ex96EE26i0JdCC/1ytYJyksoz6UEK7J4QiXa7k2B4
         TkodXMyHJrInVzebvidyIjEtCkgMD+tQiTMG830Bf3anFgOiz0CSaO7KSHBHk3H4OMgz
         k771io1Qk0sayMsAYaZ0yqKRrotjIoTZDLJSjYvYpErQ8KDXWQKWo5wPRbQzHhOj2YDd
         Ckrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744921284; x=1745526084;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ycmcvdno8cbwQvOBXiBeKxD5ah0Oq2an+ma35xNxgcw=;
        b=uQ9PzYpSAIVNList9DiRTlHvlgJSQq25DcThAwd3xtnAkAmV4dfQZHILVWxuYew2wv
         DV9ov31MA16yD198dYWi4k1uIwe1xiM7Ph0Tkhl63hTQamuj+JAwy/WgoMKU2LrBH9Xw
         c+Ug9UguCqte+r9yN3PJHUCqkdtLQ1mrEHsa7EyJLUU773FUHUpP1xJyyESkaVuQIvKC
         008BZ3C8ulRKQkcH021OWoUb1ZDmd+x1ra92CcQRjV51oAr3z8pgfo07RK7m7o1RikON
         noW+KutsTPqLzKKLKA99ZitC51rKcdA/LQFDLVeRLXrEEU7xzn8+JzTBKMiXZDJZp9Xq
         0NPw==
X-Gm-Message-State: AOJu0YxM7ax+u7bKD3aauuq3+04bHWrhyxM+EXO/nxOEPG9Ak7bQePTQ
	eLpN9Hmtk00ZPkNjvU5ESynk3VijDAMb2DoaS0Ihkl+Oe7cnsYA/ySbcSuCRn3T4rHQMDmRYNpH
	hS6gIiPZWTkyyrq3A0jw00cDG+73rVuHtsD+qy4DkHP3epZ0OagJWRMD6RL+jv4MJ9oOlVV9X7h
	XJEY1O4HqE6Ra1QFEcTJrN9HsBxQ==
X-Google-Smtp-Source: AGHT+IG8+unzD76nH5G9KkFEMP2nIMDfAJ/43N26yu/0Q7N5fHf28RA+aXrlAyEOBcXUjtUkdzlCqOsp
X-Received: from wmbfl16.prod.google.com ([2002:a05:600c:b90:b0:43b:c336:7b29])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:34cb:b0:43c:fabf:9146
 with SMTP id 5b1f17b1804b1-4406abb3a80mr2721585e9.17.1744921284535; Thu, 17
 Apr 2025 13:21:24 -0700 (PDT)
Date: Thu, 17 Apr 2025 22:21:21 +0200
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=6395; i=ardb@kernel.org;
 h=from:subject; bh=o9bsI1ur2w/CAIs/5tUfsltgM6OvITQ4xcKeWO0v2Ss=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIYMx6aDz8cZMw97K3cVbrRuf5sZvMmvv+RDPHXgzLNqq6
 nrjFI2OUhYGMQ4GWTFFFoHZf9/tPD1RqtZ5lizMHFYmkCEMXJwCMJHP5owMv2snMxSvCm/4s5Rp
 w4/0Ex+Dlz4VfLVti9nRre/2LNLtP8LIcMx50XSO3jSFHMuI2MUi38oev/mQcc3zKKfr1d8KJ+b l8AEA
X-Mailer: git-send-email 2.49.0.805.g082f7c87e0-goog
Message-ID: <20250417202120.1002102-2-ardb+git@google.com>
Subject: [PATCH v4] x86/boot/sev: Avoid shared GHCB page for early memory acceptance
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: x86@kernel.org, mingo@kernel.org, linux-kernel@vger.kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Borislav Petkov <bp@alien8.de>, 
	Dionna Amalie Glaze <dionnaglaze@google.com>, Kevin Loughlin <kevinloughlin@google.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

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

Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dionna Amalie Glaze <dionnaglaze@google.com>
Cc: Kevin Loughlin <kevinloughlin@google.com>
Cc: <stable@vger.kernel.org>
Fixes: 6c3211796326 ("x86/sev: Add SNP-specific unaccepted memory support")
Co-developed-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
Changes since v3 [0]:
- work around the fact that sev_snp_enabled() does not work yet when the
  EFI stub accepts misaligned chunks of memory while populating the E820
  table

Changes since v2 [1]:
- avoid two separate acceptance APIs; instead, use MSR based page-by-page
  acceptance for the decompressor as well

[0] https://lore.kernel.org/all/20250410132850.3708703-2-ardb+git@google.com/T/#u
[1] https://lore.kernel.org/all/20250404082921.2767593-8-ardb+git@google.com/T/#u

 arch/x86/boot/compressed/mem.c |  5 +-
 arch/x86/boot/compressed/sev.c | 67 +++++---------------
 arch/x86/boot/compressed/sev.h |  2 +
 3 files changed, 21 insertions(+), 53 deletions(-)

diff --git a/arch/x86/boot/compressed/mem.c b/arch/x86/boot/compressed/mem.c
index dbba332e4a12..f676156d9f3d 100644
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
index 6eadd790f4e5..478eca4f7180 100644
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
diff --git a/arch/x86/boot/compressed/sev.h b/arch/x86/boot/compressed/sev.h
index fc725a981b09..4e463f33186d 100644
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
 
-- 
2.49.0.805.g082f7c87e0-goog


