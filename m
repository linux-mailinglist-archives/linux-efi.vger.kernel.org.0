Return-Path: <linux-efi+bounces-4213-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 55BB0AFE212
	for <lists+linux-efi@lfdr.de>; Wed,  9 Jul 2025 10:12:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94ADE1C2827D
	for <lists+linux-efi@lfdr.de>; Wed,  9 Jul 2025 08:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3574275B1F;
	Wed,  9 Jul 2025 08:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1KzNF86S"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4A7238D56
	for <linux-efi@vger.kernel.org>; Wed,  9 Jul 2025 08:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752048681; cv=none; b=S5cdc30TssUxVf/PLkZWcd77kVrWHnkNoow3zwFMJ8kYCrJ1OCI0vlAl+Q2jOhkw7SFs43uzumE9tc+/zWGGb7RLpkntuJO/bXycd0JmZwULJrDT2kWgbSiF1IS9bmX9S+vIwqsDw1KLExzJut+3TL5O6JLEw9IpHekTk8863k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752048681; c=relaxed/simple;
	bh=c1eiYHsm0Tz2KsIxpnLYcXF0bpFmOusA3a2I4V8AsTk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aTVDXjrDoiaMZqbiY1DZTUuLJRROFR2mvgc2EAqV+qAbN/Lk6C4o4BiDeZvI26McbwsnafRYzQbgaW+FPaiAfqkFwxnruRpVuyMoPSoflSsPE085jTYZ/sswcEmp+2Soq0Axu0Xy3G42oe1IR5sSsqY3wAoEgMvI5xkjAQJ9KYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1KzNF86S; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-453817323afso30639965e9.1
        for <linux-efi@vger.kernel.org>; Wed, 09 Jul 2025 01:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752048678; x=1752653478; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YAh1Kx5HKDyBIKAfUbucXkz5QPRhQgnRRNO4/Xv3I7k=;
        b=1KzNF86SAilBZi3JzqXcG6sdJsxqGfPNwaG+3M95I2Rs6OO3aPqKOP703UqhhegqwM
         Rsr7xZ3RUmiHu3E1gNuCzorbbQnSUi68AxRko2pmgcW02x78wm4z9WalpelmLE/6leDz
         ni7ZVcObs4Y1BF7XCUFbScHmQF0UTok2706upcDWgCoytrZOrIHpMhgz92FPqNuH8mIg
         ZcPgw9i6qX+DQG//uesxJftOkLVjXCy0DUp+sBblp19JJzseiZFPQJl0l7G2Zi7/r7BZ
         IlJ0kfo3tlR5Lp2tycHvjxfqUwDMMq03vXBIqkccvDH8dcvrVb8k1qgjek6Z/lS49N1c
         lZ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752048678; x=1752653478;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YAh1Kx5HKDyBIKAfUbucXkz5QPRhQgnRRNO4/Xv3I7k=;
        b=KSDf25KUe6DeGd2B9XB9Lgn8CdkHaLz9wLNEwnZavT/+mJTZl71RWwEopES+9v9sFI
         CDwQxtkdA/kLxlYWKhenVeU3jwmqeBuAtl79mkIj0BRxwy6lj+5+gCIWuYN1DHO5140J
         DAKp/MVi/jRSSykPQjQHgorOmmtg0nFkFKoWRSXut72kucZUl/V2mTIETbOgBgmfmPLu
         wQqIeiITwqP91BoJ0lg8JTNrdGRf/Y3FOGX2ijE7Q05RzxQI6fTUy4qW1jMxz+2gQIQ5
         lcb73RKmgV4I2rkoMUeLALcRVIBsCjnDF0NRbMw+mDIEIV+ggdi/Vf+cGh1R3w4TbcN5
         tojg==
X-Gm-Message-State: AOJu0Yws4FqP4mMdykrFKJV+ZbGBpQPoiLuzZjAcouw/3G0B3KeANUgi
	qJFti6KZbnuad0NlBEq0qL9gBSSPDLqowYlZbGWek1hmX1Thdl0WI8+I1ijxuyPdhLTEfaKqRQ=
	=
X-Google-Smtp-Source: AGHT+IHC0JXXysIvQHbb2SUNgXZ9Hrv0qtnMBwhcRBmVGp1+NlBDdQFDdb6rcLjLm8dBmzsGr2fQnkrJ
X-Received: from wmbbi21.prod.google.com ([2002:a05:600c:3d95:b0:453:5a6:408d])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:470e:b0:3a8:6260:142c
 with SMTP id ffacd0b85a97d-3b5e4522753mr1118297f8f.59.1752048678178; Wed, 09
 Jul 2025 01:11:18 -0700 (PDT)
Date: Wed,  9 Jul 2025 10:08:49 +0200
In-Reply-To: <20250709080840.2233208-26-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250709080840.2233208-26-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=5666; i=ardb@kernel.org;
 h=from:subject; bh=pprdQAqCpx32HnISI4w8qM66RBXLsKFTiE22x4mWR5w=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JISNPecuP0nfZXy1czMRrwuw2Oluv/PdG7ZRTjbvrFjHP7
 OowtrqOUhYGMS4GWTFFFoHZf9/tPD1RqtZ5lizMHFYmkCEMXJwCMBFBFoa/YvVZKy4Hl+1L2m92
 2+h4d4ByhOA/N71dYbvjpa6LRweWMPxk/Pz/WODL9iP3GNZatJ1f8mty1c3LT2+wcHOsYJHaGHm PAwA=
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250709080840.2233208-34-ardb+git@google.com>
Subject: [PATCH v4 08/24] x86/sev: Share implementation of MSR-based page
 state change
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: linux-efi@vger.kernel.org, x86@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>, 
	Dionna Amalie Glaze <dionnaglaze@google.com>, Kevin Loughlin <kevinloughlin@google.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Both the decompressor and the SEV startup code implement the exact same
sequence for invoking the MSR based communication protocol to effectuate
a page state change.

Before tweaking the internal APIs used in both versions, merge them and
share them so those tweaks are only needed in a single place.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/sev.c      | 34 ++------------------
 arch/x86/boot/startup/sev-shared.c  | 29 +++++++++++++++++
 arch/x86/boot/startup/sev-startup.c | 29 +----------------
 3 files changed, 33 insertions(+), 59 deletions(-)

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index f00f68175f14..6d3ed7ed03a4 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -60,34 +60,6 @@ static bool sev_snp_enabled(void)
 	return sev_status & MSR_AMD64_SEV_SNP_ENABLED;
 }
 
-static void __page_state_change(unsigned long paddr, enum psc_op op)
-{
-	u64 val, msr;
-
-	/*
-	 * If private -> shared then invalidate the page before requesting the
-	 * state change in the RMP table.
-	 */
-	if (op == SNP_PAGE_STATE_SHARED)
-		pvalidate_4k_page(paddr, paddr, false);
-
-	/* Issue VMGEXIT to change the page state in RMP table. */
-	sev_es_wr_ghcb_msr(GHCB_MSR_PSC_REQ_GFN(paddr >> PAGE_SHIFT, op));
-	VMGEXIT();
-
-	/* Read the response of the VMGEXIT. */
-	val = sev_es_rd_ghcb_msr();
-	if ((GHCB_RESP_CODE(val) != GHCB_MSR_PSC_RESP) || GHCB_MSR_PSC_RESP_VAL(val))
-		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_PSC);
-
-	/*
-	 * Now that page state is changed in the RMP table, validate it so that it is
-	 * consistent with the RMP entry.
-	 */
-	if (op == SNP_PAGE_STATE_PRIVATE)
-		pvalidate_4k_page(paddr, paddr, true);
-}
-
 void snp_set_page_private(unsigned long paddr)
 {
 	u64 msr;
@@ -96,7 +68,7 @@ void snp_set_page_private(unsigned long paddr)
 		return;
 
 	msr = sev_es_rd_ghcb_msr();
-	__page_state_change(paddr, SNP_PAGE_STATE_PRIVATE);
+	__page_state_change(paddr, paddr, SNP_PAGE_STATE_PRIVATE);
 	sev_es_wr_ghcb_msr(msr);
 }
 
@@ -108,7 +80,7 @@ void snp_set_page_shared(unsigned long paddr)
 		return;
 
 	msr = sev_es_rd_ghcb_msr();
-	__page_state_change(paddr, SNP_PAGE_STATE_SHARED);
+	__page_state_change(paddr, paddr, SNP_PAGE_STATE_SHARED);
 	sev_es_wr_ghcb_msr(msr);
 }
 
@@ -137,7 +109,7 @@ void snp_accept_memory(phys_addr_t start, phys_addr_t end)
 	u64 msr = sev_es_rd_ghcb_msr();
 
 	for (phys_addr_t pa = start; pa < end; pa += PAGE_SIZE)
-		__page_state_change(pa, SNP_PAGE_STATE_PRIVATE);
+		__page_state_change(pa, pa, SNP_PAGE_STATE_PRIVATE);
 	sev_es_wr_ghcb_msr(msr);
 }
 
diff --git a/arch/x86/boot/startup/sev-shared.c b/arch/x86/boot/startup/sev-shared.c
index 7ca59038269f..f553268d31d7 100644
--- a/arch/x86/boot/startup/sev-shared.c
+++ b/arch/x86/boot/startup/sev-shared.c
@@ -640,6 +640,35 @@ static void __head pvalidate_4k_page(unsigned long vaddr, unsigned long paddr,
 	}
 }
 
+static void __head __page_state_change(unsigned long vaddr, unsigned long paddr,
+				       enum psc_op op)
+{
+	u64 val;
+
+	/*
+	 * If private -> shared then invalidate the page before requesting the
+	 * state change in the RMP table.
+	 */
+	if (op == SNP_PAGE_STATE_SHARED)
+		pvalidate_4k_page(vaddr, paddr, false);
+
+	/* Issue VMGEXIT to change the page state in RMP table. */
+	sev_es_wr_ghcb_msr(GHCB_MSR_PSC_REQ_GFN(paddr >> PAGE_SHIFT, op));
+	VMGEXIT();
+
+	/* Read the response of the VMGEXIT. */
+	val = sev_es_rd_ghcb_msr();
+	if ((GHCB_RESP_CODE(val) != GHCB_MSR_PSC_RESP) || GHCB_MSR_PSC_RESP_VAL(val))
+		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_PSC);
+
+	/*
+	 * Now that page state is changed in the RMP table, validate it so that it is
+	 * consistent with the RMP entry.
+	 */
+	if (op == SNP_PAGE_STATE_PRIVATE)
+		pvalidate_4k_page(vaddr, paddr, true);
+}
+
 /*
  * Maintain the GPA of the SVSM Calling Area (CA) in order to utilize the SVSM
  * services needed when not running in VMPL0.
diff --git a/arch/x86/boot/startup/sev-startup.c b/arch/x86/boot/startup/sev-startup.c
index 8edf1ba78a48..2ffd8bf09357 100644
--- a/arch/x86/boot/startup/sev-startup.c
+++ b/arch/x86/boot/startup/sev-startup.c
@@ -135,7 +135,6 @@ early_set_pages_state(unsigned long vaddr, unsigned long paddr,
 		      unsigned long npages, enum psc_op op)
 {
 	unsigned long paddr_end;
-	u64 val;
 
 	vaddr = vaddr & PAGE_MASK;
 
@@ -143,37 +142,11 @@ early_set_pages_state(unsigned long vaddr, unsigned long paddr,
 	paddr_end = paddr + (npages << PAGE_SHIFT);
 
 	while (paddr < paddr_end) {
-		/* Page validation must be rescinded before changing to shared */
-		if (op == SNP_PAGE_STATE_SHARED)
-			pvalidate_4k_page(vaddr, paddr, false);
-
-		/*
-		 * Use the MSR protocol because this function can be called before
-		 * the GHCB is established.
-		 */
-		sev_es_wr_ghcb_msr(GHCB_MSR_PSC_REQ_GFN(paddr >> PAGE_SHIFT, op));
-		VMGEXIT();
-
-		val = sev_es_rd_ghcb_msr();
-
-		if (GHCB_RESP_CODE(val) != GHCB_MSR_PSC_RESP)
-			goto e_term;
-
-		if (GHCB_MSR_PSC_RESP_VAL(val))
-			goto e_term;
-
-		/* Page validation must be performed after changing to private */
-		if (op == SNP_PAGE_STATE_PRIVATE)
-			pvalidate_4k_page(vaddr, paddr, true);
+		__page_state_change(vaddr, paddr, op);
 
 		vaddr += PAGE_SIZE;
 		paddr += PAGE_SIZE;
 	}
-
-	return;
-
-e_term:
-	sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_PSC);
 }
 
 void __head early_snp_set_memory_private(unsigned long vaddr, unsigned long paddr,
-- 
2.50.0.727.gbf7dc18ff4-goog


