Return-Path: <linux-efi+bounces-4362-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 143D6B06C27
	for <lists+linux-efi@lfdr.de>; Wed, 16 Jul 2025 05:23:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 358AF5603B8
	for <lists+linux-efi@lfdr.de>; Wed, 16 Jul 2025 03:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B14782874F1;
	Wed, 16 Jul 2025 03:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MPNNShgM"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BF828689B
	for <linux-efi@vger.kernel.org>; Wed, 16 Jul 2025 03:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752636159; cv=none; b=ikfggeyqOy2bx2/uahHpYKTnZJzk/oSfuaAj1WYSz4mpbGzjoRAZgsO0ZPj4o89dbo6dgcnON1kJZEyhqk3iiy8HC1MFitjfKeZuFm9+C+lQ57XKvjZ2uap+Ytp7QXDtJoMqi2Ws1lQJ2tt7M1AiZh3TSWtSWUQqxmIaSUVjcdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752636159; c=relaxed/simple;
	bh=hyOCEHD2BP/BHB/wXZzexTCfs17VdhN8Xct7u6Z/6TQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SW3OTdCKO7DJi7ToT/a+JL6HQshuaUxX7ebGLTQtV7FJs1styx3lymc06VhdBvOWc8rK116Q+/wKIIgEEQINns8s6YPCogWS1WxHVPlJYDj0SAsy7E3esGov4tPGQlZuBLNCcEhEv256IIx9GR7sFeyjDKUKHf/lPgWs+UgRzuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MPNNShgM; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-456013b59c1so22526705e9.3
        for <linux-efi@vger.kernel.org>; Tue, 15 Jul 2025 20:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752636156; x=1753240956; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ie7ghjTAXJ1RjJATnR0+RLls6HNvil6BXsqkKY03oqo=;
        b=MPNNShgMVzBAwX8hvo0Vyr1Z/3QCpWPW101KdoziurF/I06Lf0CKjEUhYx3Rr8FuLq
         b1cu05ngGtymzeCRH55On40MJ3dgxbPS8/t1TXhXeoOnbmvjIy5nKfGFu8G+BGO3P2wb
         Lwh17do0CiT125c11GyMKbZaurMICS/HWYsXYBTbT3kQMtM+/WEokBz7oitcjD4HOZun
         EWyHbk6uGXUEamLk9Bvm/5kDnW69pZdWdF8Qb+aCxj8yPSj97Nnx4Rgae/qvLLrSdk6Y
         egp7RLCF1OJF/04TEtgbzX9mN8iXgxxr9TDuEk5tk/dLwk6E54wnaGXVPqeI0BoTQQPc
         JZRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752636156; x=1753240956;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ie7ghjTAXJ1RjJATnR0+RLls6HNvil6BXsqkKY03oqo=;
        b=VM25H80CKriWhKBr5XtMYCBqr+aYNhjCQD9+CBRrCYl8fYxo01dJQPKZB4hqzi7igr
         xWHd4G2KYfEyn4mjSTUMjXgzfmm7O8pPheeS+rXj4sCWZwpz0+Q+ASonmDU8nPvf6uEN
         YrSe+AZP3hHwB0vgWs/4XyTJlwbUQ/2JRgJCnOZ7AU9GRio4UT0rVxZMgTu1EhHJK8tQ
         xbeWLw4NkPZQkmCobvxtjXYdxlPPbMUM9o0lhzB4NT1ovTr+EnCAo59ilNHMbQTNVbM0
         NxEQQbqoQdHFB1SRSukkCO1c7KvzF6EKllsFeJ+f5dEPx9C+UYGTfo8rkuZfOREatIO4
         xk2Q==
X-Gm-Message-State: AOJu0Yw2xSkFtaZncs37HjX4Xy50oPzeCb8OWO3lB5PeH3Upzpiz3j6u
	WnUClH9sftkwCUVQyY4mYVHbAAWCCAcbUU50gzYhcX2A3F3h+h5O2tkkvTZsZ1m8tfVWIBngtg=
	=
X-Google-Smtp-Source: AGHT+IFWEjTGKJC0P+l/6U1ojJjIwXduaOUN+ZHQZNlS4h1A3hUnAS0bLiY0kzHEFrxpEU9mloI1sYNT
X-Received: from wmsr5.prod.google.com ([2002:a05:600c:8b05:b0:456:15bd:a297])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:1d20:b0:43c:e70d:44f0
 with SMTP id 5b1f17b1804b1-4562e36c6d3mr7961485e9.19.1752636156038; Tue, 15
 Jul 2025 20:22:36 -0700 (PDT)
Date: Wed, 16 Jul 2025 05:18:23 +0200
In-Reply-To: <20250716031814.2096113-24-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250716031814.2096113-24-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=7692; i=ardb@kernel.org;
 h=from:subject; bh=Dgsh787GUJSIpiPFllr2H7qbaHO4zGl5ERrfzXk+iCw=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIaNcSq26R/SC4a5fzd5rHNdKcs52YuM+4layV+nWcbeDr
 31WtKt3lLIwiHExyIopsgjM/vtu5+mJUrXOs2Rh5rAygQxh4OIUgIls/sXwz/Ki78XyI6FvFkvu
 ULS+nP12H2PjfI0jL944fQw8+VeKW5Lhr3xO+dlShp1cwvkFkob//WZ8kNoc5xMlI2KQaFDyYNl rDgA=
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250716031814.2096113-32-ardb+git@google.com>
Subject: [PATCH v5 08/22] x86/sev: Pass SVSM calling area down to early page
 state change API
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: linux-efi@vger.kernel.org, x86@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>, 
	Kevin Loughlin <kevinloughlin@google.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Nikunj A Dadhania <nikunj@amd.com>
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
 arch/x86/boot/startup/sev-shared.c  | 17 +++++++++--------
 arch/x86/boot/startup/sev-startup.c | 11 +++++++----
 arch/x86/coco/sev/core.c            |  3 ++-
 arch/x86/include/asm/sev-internal.h |  3 ++-
 5 files changed, 29 insertions(+), 17 deletions(-)

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index f714235d3222..18b0ccf517eb 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -65,7 +65,9 @@ void snp_set_page_private(unsigned long paddr)
 	if (!sev_snp_enabled())
 		return;
 
-	__page_state_change(paddr, paddr, SNP_PAGE_STATE_PRIVATE);
+	__page_state_change(paddr, paddr, SNP_PAGE_STATE_PRIVATE,
+			    (struct svsm_ca *)boot_svsm_caa_pa,
+			    boot_svsm_caa_pa);
 }
 
 void snp_set_page_shared(unsigned long paddr)
@@ -73,7 +75,9 @@ void snp_set_page_shared(unsigned long paddr)
 	if (!sev_snp_enabled())
 		return;
 
-	__page_state_change(paddr, paddr, SNP_PAGE_STATE_SHARED);
+	__page_state_change(paddr, paddr, SNP_PAGE_STATE_SHARED,
+			    (struct svsm_ca *)boot_svsm_caa_pa,
+			    boot_svsm_caa_pa);
 }
 
 bool early_setup_ghcb(void)
@@ -99,7 +103,9 @@ bool early_setup_ghcb(void)
 void snp_accept_memory(phys_addr_t start, phys_addr_t end)
 {
 	for (phys_addr_t pa = start; pa < end; pa += PAGE_SIZE)
-		__page_state_change(pa, pa, SNP_PAGE_STATE_PRIVATE);
+		__page_state_change(pa, pa, SNP_PAGE_STATE_PRIVATE,
+				    (struct svsm_ca *)boot_svsm_caa_pa,
+				    boot_svsm_caa_pa);
 }
 
 void sev_es_shutdown_ghcb(void)
diff --git a/arch/x86/boot/startup/sev-shared.c b/arch/x86/boot/startup/sev-shared.c
index eb241ff1156d..83ca97df0808 100644
--- a/arch/x86/boot/startup/sev-shared.c
+++ b/arch/x86/boot/startup/sev-shared.c
@@ -598,7 +598,8 @@ static int __head svsm_call_msr_protocol(struct svsm_call *call)
 	return ret;
 }
 
-static void __head svsm_pval_4k_page(unsigned long paddr, bool validate)
+static void __head svsm_pval_4k_page(unsigned long paddr, bool validate,
+				     struct svsm_ca *caa, u64 caa_pa)
 {
 	struct svsm_pvalidate_call *pc;
 	struct svsm_call call = {};
@@ -611,10 +612,10 @@ static void __head svsm_pval_4k_page(unsigned long paddr, bool validate)
 	 */
 	flags = native_local_irq_save();
 
-	call.caa = svsm_get_caa();
+	call.caa = caa;
 
 	pc = (struct svsm_pvalidate_call *)call.caa->svsm_buffer;
-	pc_pa = svsm_get_caa_pa() + offsetof(struct svsm_ca, svsm_buffer);
+	pc_pa = caa_pa + offsetof(struct svsm_ca, svsm_buffer);
 
 	pc->num_entries = 1;
 	pc->cur_index   = 0;
@@ -639,12 +640,12 @@ static void __head svsm_pval_4k_page(unsigned long paddr, bool validate)
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
@@ -653,7 +654,7 @@ static void __head pvalidate_4k_page(unsigned long vaddr, unsigned long paddr,
 }
 
 static void __head __page_state_change(unsigned long vaddr, unsigned long paddr,
-				       enum psc_op op)
+				       enum psc_op op, struct svsm_ca *caa, u64 caa_pa)
 {
 	u64 val, msr;
 
@@ -662,7 +663,7 @@ static void __head __page_state_change(unsigned long vaddr, unsigned long paddr,
 	 * state change in the RMP table.
 	 */
 	if (op == SNP_PAGE_STATE_SHARED)
-		pvalidate_4k_page(vaddr, paddr, false);
+		pvalidate_4k_page(vaddr, paddr, false, caa, caa_pa);
 
 	/* Save the current GHCB MSR value */
 	msr = sev_es_rd_ghcb_msr();
@@ -684,7 +685,7 @@ static void __head __page_state_change(unsigned long vaddr, unsigned long paddr,
 	 * consistent with the RMP entry.
 	 */
 	if (op == SNP_PAGE_STATE_PRIVATE)
-		pvalidate_4k_page(vaddr, paddr, true);
+		pvalidate_4k_page(vaddr, paddr, true, caa, caa_pa);
 }
 
 /*
diff --git a/arch/x86/boot/startup/sev-startup.c b/arch/x86/boot/startup/sev-startup.c
index b4e2cb7bc44a..7aabda0b378e 100644
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
-		__page_state_change(vaddr, paddr, op);
+		__page_state_change(vaddr, paddr, op, caa, caa_pa);
 
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
index bea67d017bf0..7a86a2fe494d 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -585,7 +585,8 @@ static void set_pages_state(unsigned long vaddr, unsigned long npages, int op)
 
 	/* Use the MSR protocol when a GHCB is not available. */
 	if (!boot_ghcb)
-		return early_set_pages_state(vaddr, __pa(vaddr), npages, op);
+		return early_set_pages_state(vaddr, __pa(vaddr), npages, op,
+					     svsm_get_caa(), svsm_get_caa_pa());
 
 	vaddr = vaddr & PAGE_MASK;
 	vaddr_end = vaddr + (npages << PAGE_SHIFT);
diff --git a/arch/x86/include/asm/sev-internal.h b/arch/x86/include/asm/sev-internal.h
index ffe4755962fe..3b72d8217827 100644
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
2.50.0.727.gbf7dc18ff4-goog


