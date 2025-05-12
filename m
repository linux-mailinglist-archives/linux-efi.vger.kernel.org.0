Return-Path: <linux-efi+bounces-3664-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92357AB4497
	for <lists+linux-efi@lfdr.de>; Mon, 12 May 2025 21:13:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6F5A8C2BB1
	for <lists+linux-efi@lfdr.de>; Mon, 12 May 2025 19:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BCAA29994E;
	Mon, 12 May 2025 19:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qpGNIYkK"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B443299940
	for <linux-efi@vger.kernel.org>; Mon, 12 May 2025 19:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747077114; cv=none; b=rBEJZ9JWsdUc59Ik2fwrXCHcX6UUrsGid7KhJD227OM6zPESUWW79WWVC9usDjtm7SAEbBcZWagjGSsQQXlZxiv2TAJNw6Va8Ygw9aboUZ/tcfiB/hme15ywLQZkOTVBuTgG+sAMFJdik+6Ns+Kqi8Vko7f5OqEs22yuXlnaask=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747077114; c=relaxed/simple;
	bh=4PRMUsF3/4G7hA2q4hjeIR+JdxZK6wTZjWGcyi+aY1U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BNnHjqEwSkA1jYRVmkt2B+MWJHhDpknxf5qfNCzYXpbUe++PAypa064tRUuJg77zRZCLi4Q5MLyp8L4pV/RCn1G7aqYPILv0YnUYU8n2FRD4H6weaCQuETBi70BaK1yRfIqzQns/y7P6D2RdonDbjqKvFfZN7OgyOuPCERUFyRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qpGNIYkK; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-3a0b5c28f05so2560211f8f.2
        for <linux-efi@vger.kernel.org>; Mon, 12 May 2025 12:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747077111; x=1747681911; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VT9UVC5WaYQlU9gYbZ4bwLAzMBxTTt0hC6BCcLJpAOM=;
        b=qpGNIYkKjSxkXjV6X7yKbx0IqamhISs7CcDqyl7Dahmp3WnmxjIekJpVYjaUaecmZ9
         9DpcsTJWxtF2sdIiBAFRE9YBiwn+c+uHtGUYuRePUVj/7sYu2ItYqnua+nIT9hoc27GO
         Tv6cQWZMYlHai+bjXSEF+0Ln4qrJalCzbC4IoVZNmnMuncfkpr101QCHFCwvudFi0Qa8
         KCUH31iqCpi0kwgxVUfmdbXgkHVy/SWet4nrhm0fy6dzolDQ4vN2PaWS2Uer9qVs3i1a
         /YWzsScECv6mOiVO4Wb3F/spY8MuBfFLkwB2RokoqSiEAqImDnvyROsQB+bNSGhlgVHl
         5NIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747077111; x=1747681911;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VT9UVC5WaYQlU9gYbZ4bwLAzMBxTTt0hC6BCcLJpAOM=;
        b=atWfaAYL4gzrwb0TSwUygGZTkdR43QL4eq58chIlgvFR6UiEoShTU12YTYRoIGCWPg
         x2Unp88rH7vUVCuDFR/UvCYq4g6QGbeWmzGOBcUat1PMUwjR5h0AtRaRmmAZP6NzFQOI
         ErUTKeLT7/QsRilXnAFhDc3FIfz/GsG92QrRgSulpEY+Jh+Lo06vU/uoT1U989S+EwcA
         1ZAH0xBoDtSez/BKQbDywnjUKdt64G50RrvzbsAskczPmjttrGMv5Nja4VGK/g4coq0P
         t1w7MmEuOb5qnOtQd2dLb87mTL4WnC9eTkXJ4no1X1pLADFBO6SZeI0e1bjry2328UCE
         RiMw==
X-Gm-Message-State: AOJu0Yy9F5XRYUNQgaMc8nkmoN0KnVPri2fZlU2OtibVQHM/pwnM82Yb
	f7CmUMvVzrTKn02KtCR0qIUnf5eP7muZR8ZSXxMa/4CFdSjUeYiMWfnXWJZC48M3htDwjg==
X-Google-Smtp-Source: AGHT+IHzd4RlyfLXOODAOZP0BRMlZsBxFntsPH1oq9ob7Ye5rGtrjBHCSJaGDnfwVynWIoCZwe59kvFZ
X-Received: from wmbbd9.prod.google.com ([2002:a05:600c:1f09:b0:442:e9ed:dccc])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:2289:b0:3a0:6c62:8169
 with SMTP id ffacd0b85a97d-3a1f646a66amr11099907f8f.25.1747077111021; Mon, 12
 May 2025 12:11:51 -0700 (PDT)
Date: Mon, 12 May 2025 21:08:44 +0200
In-Reply-To: <20250512190834.332684-23-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250512190834.332684-23-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=7709; i=ardb@kernel.org;
 h=from:subject; bh=nKTaGIifaijNW5UnObPbBk/6m3hva4eEIq5cHT0Ct3Y=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIUPJ3W3+khBF5gqd6w1p79xlVv+PvvkhUu3E+gu71jBN4
 9muefJBRykLgxgHg6yYIovA7L/vdp6eKFXrPEsWZg4rE8gQBi5OAZiI6RuG/1WP689v9vqsKZ2f
 u2TpgfPZPdM01z5gffTWKmf+tDdfVVYyMjx72Zvy9hgf0w/uxfrb1/oGmphMPHneYSm/N8+LSMb tzXwA
X-Mailer: git-send-email 2.49.0.1045.g170613ef41-goog
Message-ID: <20250512190834.332684-32-ardb+git@google.com>
Subject: [RFT PATCH v3 09/21] x86/sev: Pass SVSM calling area down to early
 page state change API
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: linux-efi@vger.kernel.org, x86@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>, 
	Dionna Amalie Glaze <dionnaglaze@google.com>, Kevin Loughlin <kevinloughlin@google.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

The early page state change API is mostly only used very early, when
only the boot time SVSM calling area is in use. However, this API is
also called by the kexec finishing code, which runs very late, and
potentially from a different CPU (which uses a different calling area).

To avoid pulling the per-CPU SVSM calling area pointers and related SEV
state into the startup code, refactor the page state change API so the
SVSM calling area virtual and physical addresses can be provided by the
caller.

No functional change intended.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/sev.c      | 12 +++++++++---
 arch/x86/boot/startup/sev-shared.c  | 18 ++++++++++--------
 arch/x86/boot/startup/sev-startup.c | 11 +++++++----
 arch/x86/coco/sev/core.c            |  3 ++-
 arch/x86/include/asm/sev-internal.h |  3 ++-
 5 files changed, 30 insertions(+), 17 deletions(-)

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index 7a01eef9ae01..04bc39d065ff 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -68,7 +68,9 @@ void snp_set_page_private(unsigned long paddr)
 		return;
 
 	msr = sev_es_rd_ghcb_msr();
-	__page_state_change(paddr, SNP_PAGE_STATE_PRIVATE);
+	__page_state_change(paddr, SNP_PAGE_STATE_PRIVATE,
+			    (struct svsm_ca *)boot_svsm_caa_pa,
+			    boot_svsm_caa_pa);
 	sev_es_wr_ghcb_msr(msr);
 }
 
@@ -80,7 +82,9 @@ void snp_set_page_shared(unsigned long paddr)
 		return;
 
 	msr = sev_es_rd_ghcb_msr();
-	__page_state_change(paddr, SNP_PAGE_STATE_SHARED);
+	__page_state_change(paddr, SNP_PAGE_STATE_SHARED,
+			    (struct svsm_ca *)boot_svsm_caa_pa,
+			    boot_svsm_caa_pa);
 	sev_es_wr_ghcb_msr(msr);
 }
 
@@ -109,7 +113,9 @@ void snp_accept_memory(phys_addr_t start, phys_addr_t end)
 	u64 msr = sev_es_rd_ghcb_msr();
 
 	for (phys_addr_t pa = start; pa < end; pa += PAGE_SIZE)
-		__page_state_change(pa, SNP_PAGE_STATE_PRIVATE);
+		__page_state_change(pa, SNP_PAGE_STATE_PRIVATE,
+				    (struct svsm_ca *)boot_svsm_caa_pa,
+				    boot_svsm_caa_pa);
 	sev_es_wr_ghcb_msr(msr);
 }
 
diff --git a/arch/x86/boot/startup/sev-shared.c b/arch/x86/boot/startup/sev-shared.c
index dae770327b50..70ad9a0aa023 100644
--- a/arch/x86/boot/startup/sev-shared.c
+++ b/arch/x86/boot/startup/sev-shared.c
@@ -538,7 +538,8 @@ static void __head setup_cpuid_table(const struct cc_blob_sev_info *cc_info)
 	}
 }
 
-static void __head svsm_pval_4k_page(unsigned long paddr, bool validate)
+static void __head svsm_pval_4k_page(unsigned long paddr, bool validate,
+				     struct svsm_ca *caa, u64 caa_pa)
 {
 	struct svsm_pvalidate_call *pc;
 	struct svsm_call call = {};
@@ -552,10 +553,10 @@ static void __head svsm_pval_4k_page(unsigned long paddr, bool validate)
 	 */
 	flags = native_local_irq_save();
 
-	call.caa = svsm_get_caa();
+	call.caa = caa;
 
 	pc = (struct svsm_pvalidate_call *)call.caa->svsm_buffer;
-	pc_pa = svsm_get_caa_pa() + offsetof(struct svsm_ca, svsm_buffer);
+	pc_pa = caa_pa + offsetof(struct svsm_ca, svsm_buffer);
 
 	pc->num_entries = 1;
 	pc->cur_index   = 0;
@@ -578,12 +579,12 @@ static void __head svsm_pval_4k_page(unsigned long paddr, bool validate)
 }
 
 static void __head pvalidate_4k_page(unsigned long vaddr, unsigned long paddr,
-				     bool validate)
+				     bool validate, struct svsm_ca *caa, u64 caa_pa)
 {
 	int ret;
 
 	if (snp_vmpl) {
-		svsm_pval_4k_page(paddr, validate);
+		svsm_pval_4k_page(paddr, validate, caa, caa_pa);
 	} else {
 		ret = pvalidate(vaddr, RMP_PG_SIZE_4K, validate);
 		if (ret)
@@ -591,7 +592,8 @@ static void __head pvalidate_4k_page(unsigned long vaddr, unsigned long paddr,
 	}
 }
 
-static void __head __page_state_change(unsigned long paddr, enum psc_op op)
+static void __head __page_state_change(unsigned long paddr, enum psc_op op,
+				       struct svsm_ca *caa, u64 caa_pa)
 {
 	u64 val;
 
@@ -600,7 +602,7 @@ static void __head __page_state_change(unsigned long paddr, enum psc_op op)
 	 * state change in the RMP table.
 	 */
 	if (op == SNP_PAGE_STATE_SHARED)
-		pvalidate_4k_page(paddr, paddr, false);
+		pvalidate_4k_page(paddr, paddr, false, caa, caa_pa);
 
 	/* Issue VMGEXIT to change the page state in RMP table. */
 	sev_es_wr_ghcb_msr(GHCB_MSR_PSC_REQ_GFN(paddr >> PAGE_SHIFT, op));
@@ -616,7 +618,7 @@ static void __head __page_state_change(unsigned long paddr, enum psc_op op)
 	 * consistent with the RMP entry.
 	 */
 	if (op == SNP_PAGE_STATE_PRIVATE)
-		pvalidate_4k_page(paddr, paddr, true);
+		pvalidate_4k_page(paddr, paddr, true, caa, caa_pa);
 }
 
 /*
diff --git a/arch/x86/boot/startup/sev-startup.c b/arch/x86/boot/startup/sev-startup.c
index 28bf68753580..7a3ad17d06f6 100644
--- a/arch/x86/boot/startup/sev-startup.c
+++ b/arch/x86/boot/startup/sev-startup.c
@@ -132,7 +132,8 @@ noinstr void __sev_put_ghcb(struct ghcb_state *state)
 
 void __head
 early_set_pages_state(unsigned long vaddr, unsigned long paddr,
-		      unsigned long npages, enum psc_op op)
+		      unsigned long npages, enum psc_op op,
+		      struct svsm_ca *caa, u64 caa_pa)
 {
 	unsigned long paddr_end;
 
@@ -142,7 +143,7 @@ early_set_pages_state(unsigned long vaddr, unsigned long paddr,
 	paddr_end = paddr + (npages << PAGE_SHIFT);
 
 	while (paddr < paddr_end) {
-		__page_state_change(paddr, op);
+		__page_state_change(paddr, op, caa, caa_pa);
 
 		vaddr += PAGE_SIZE;
 		paddr += PAGE_SIZE;
@@ -165,7 +166,8 @@ void __head early_snp_set_memory_private(unsigned long vaddr, unsigned long padd
 	  * Ask the hypervisor to mark the memory pages as private in the RMP
 	  * table.
 	  */
-	early_set_pages_state(vaddr, paddr, npages, SNP_PAGE_STATE_PRIVATE);
+	early_set_pages_state(vaddr, paddr, npages, SNP_PAGE_STATE_PRIVATE,
+			      svsm_get_caa(), svsm_get_caa_pa());
 }
 
 void __head early_snp_set_memory_shared(unsigned long vaddr, unsigned long paddr,
@@ -181,7 +183,8 @@ void __head early_snp_set_memory_shared(unsigned long vaddr, unsigned long paddr
 		return;
 
 	 /* Ask hypervisor to mark the memory pages shared in the RMP table. */
-	early_set_pages_state(vaddr, paddr, npages, SNP_PAGE_STATE_SHARED);
+	early_set_pages_state(vaddr, paddr, npages, SNP_PAGE_STATE_SHARED,
+			      svsm_get_caa(), svsm_get_caa_pa());
 }
 
 /*
diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index 0e0ddf4c92aa..39bbbea09c24 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -584,7 +584,8 @@ static void set_pages_state(unsigned long vaddr, unsigned long npages, int op)
 
 	/* Use the MSR protocol when a GHCB is not available. */
 	if (!boot_ghcb)
-		return early_set_pages_state(vaddr, __pa(vaddr), npages, op);
+		return early_set_pages_state(vaddr, __pa(vaddr), npages, op,
+					     svsm_get_caa(), svsm_get_caa_pa());
 
 	vaddr = vaddr & PAGE_MASK;
 	vaddr_end = vaddr + (npages << PAGE_SHIFT);
diff --git a/arch/x86/include/asm/sev-internal.h b/arch/x86/include/asm/sev-internal.h
index e3b203c280aa..08e2cfdef512 100644
--- a/arch/x86/include/asm/sev-internal.h
+++ b/arch/x86/include/asm/sev-internal.h
@@ -55,7 +55,8 @@ DECLARE_PER_CPU(struct sev_es_runtime_data*, runtime_data);
 DECLARE_PER_CPU(struct sev_es_save_area *, sev_vmsa);
 
 void early_set_pages_state(unsigned long vaddr, unsigned long paddr,
-			   unsigned long npages, enum psc_op op);
+			   unsigned long npages, enum psc_op op,
+			   struct svsm_ca *ca, u64 caa_pa);
 
 DECLARE_PER_CPU(struct svsm_ca *, svsm_caa);
 DECLARE_PER_CPU(u64, svsm_caa_pa);
-- 
2.49.0.1045.g170613ef41-goog


