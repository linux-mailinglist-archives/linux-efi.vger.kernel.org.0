Return-Path: <linux-efi+bounces-4444-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41FB1B0D30C
	for <lists+linux-efi@lfdr.de>; Tue, 22 Jul 2025 09:31:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 359DA7A88C8
	for <lists+linux-efi@lfdr.de>; Tue, 22 Jul 2025 07:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C131B2DC347;
	Tue, 22 Jul 2025 07:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jmfAN8GL"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7312DA749
	for <linux-efi@vger.kernel.org>; Tue, 22 Jul 2025 07:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753169401; cv=none; b=eHOyndCQ3zNX1+rzz7h5gENLZZKIRa5aSKBTvVKDT0evyhnHUhbfBR6Xn9Ep7Mrs8M/WVAMweQIOm9lW5bcl+edmwJt5kmg/9nhLDZiHiiId00JAvf8RBcIyc0nvN5MH+MaQrCJm+ZP9GFHVIOXcawdbiwkbRrWxIKokYH6ePhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753169401; c=relaxed/simple;
	bh=4fA/3jUJ6zj7k5uvYOOJQ0pRZCt2PaXp+jR/8krEmo8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WKq1GG4PvtifBNlIDirtzbTgbFqeEQCW+KJvQptcFMXnUSzF4xKOREwNc0/2il3TRKEVgJB6gu5fy4tEz8oj+3FLJVBK6xwFUF2NXkoVWalkgcmf15hyfiUH8e3F3vQnS7Ak5hnpGBUTSgWusK0CeX8zvkuq/k6/hJtQe+b2vcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jmfAN8GL; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-3a579058758so2011572f8f.1
        for <linux-efi@vger.kernel.org>; Tue, 22 Jul 2025 00:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753169398; x=1753774198; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QL6EcrfjzsGpyxx4RdNqdRqQCUuAPIThcF8MuxlBsx8=;
        b=jmfAN8GLSTQG7TrsPGq8hh3PGgUUgRftSIohmEwUyWKNTkvhW8yrFHHR2BrqUgzXEa
         fCXAZrQx1yDhm23SqpOvWM/ZtPaMhwownsq2e2eW3ionojbJDeTTMdxcziNEKGXZEkbu
         1AVT0/GHpUgR87Np4gdvr97Wd+QPXiuvk1One4R2jDhUcPfDPnPF/Kx+kDywPhhkBfLZ
         wxYp7WqUwgI5rcF5l95LoSinU6o7fHUpoOBXRemxt1AyNadQIo3hcraNJSDvSdC2OuGT
         oGxmV+ZhDur4+GNquiw5cWAbIjQJqm+gLO5szYitV1g4ec7PYSSpegx2Y6vJvJEagLBB
         1vmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753169398; x=1753774198;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QL6EcrfjzsGpyxx4RdNqdRqQCUuAPIThcF8MuxlBsx8=;
        b=FYxdWCXaLoiKQoZjH0y0oZip4ZrJ1FRze7xeO5T48z+RLlLrU1EMQfVK5igAT3cp7w
         CpunoQ9GJv3nsd25V7hcaARtPHEuOJzwYkYnS9VxGJzSKeZJntTMqKpCCDkGh9TLuZMa
         rJNMutMewrqn+Br58u99ZacHV0znX7i4tQHxGnL6FmOGDMlimIQO1HSqaUTWBV48HB+Q
         RbQzTy6rDVr8pRzMUVbBG6NtcRfR2vqOIKq56wvFuCK+M9UN0xg9Zv+RAExy3s/9nAqs
         XyhS84k6BCL9kDHFCCaSWW0YxnFb1Jp+JofnW2q9dOd3d9Fd+83S6PXLPPcTMyUQ0w66
         h3lg==
X-Gm-Message-State: AOJu0YwbYCJVU242nUepGBoQx4iM9el23FCGK94iT1NMe7GhvYNpKaco
	kBdh8ovvouGTPboFJ/vzzgHM/Hlrr91qzX0CIvysTxWD12P6uusey8GlqIOJYbSTAhWvqXOI9g=
	=
X-Google-Smtp-Source: AGHT+IE0baTcNVeiZy4pavD88v4Cu6Po7vw8UnqpAdLO4ZzSpg+xDJKOEammOnC2ugQTcaUAaNo1vUlE
X-Received: from wroi16.prod.google.com ([2002:adf:f310:0:b0:3b3:9c56:9547])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:230e:b0:3b3:9cb4:43f9
 with SMTP id ffacd0b85a97d-3b60e4d0135mr18273497f8f.16.1753169397888; Tue, 22
 Jul 2025 00:29:57 -0700 (PDT)
Date: Tue, 22 Jul 2025 09:27:17 +0200
In-Reply-To: <20250722072708.2079165-24-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250722072708.2079165-24-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=7692; i=ardb@kernel.org;
 h=from:subject; bh=pJz4SrafHjQuXPeBtx71UqIsmXAoLC/0qFiDEMr9UIA=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIaPetnSqV5CO2qf/5+/8ejDfaV73RW/d/ZsNXHn31RbkP
 d2wXHZnRykLgxgXg6yYIovA7L/vdp6eKFXrPEsWZg4rE8gQBi5OAZhIZiUjw03HyrBbjG+nLi/8
 vnLm1vOf9jEJSDy6cnZh4ZmXqe4sd4QYGSZ0RhRsORsckMqYlF5//cxlRj1f8xmfHiVHGOt8mNv mxQQA
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250722072708.2079165-32-ardb+git@google.com>
Subject: [PATCH v6 08/22] x86/sev: Pass SVSM calling area down to early page
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
index 1da1afa8677a..5992c82572d1 100644
--- a/arch/x86/boot/startup/sev-shared.c
+++ b/arch/x86/boot/startup/sev-shared.c
@@ -599,7 +599,8 @@ static int __head svsm_call_msr_protocol(struct svsm_call *call)
 	return ret;
 }
 
-static void __head svsm_pval_4k_page(unsigned long paddr, bool validate)
+static void __head svsm_pval_4k_page(unsigned long paddr, bool validate,
+				     struct svsm_ca *caa, u64 caa_pa)
 {
 	struct svsm_pvalidate_call *pc;
 	struct svsm_call call = {};
@@ -612,10 +613,10 @@ static void __head svsm_pval_4k_page(unsigned long paddr, bool validate)
 	 */
 	flags = native_local_irq_save();
 
-	call.caa = svsm_get_caa();
+	call.caa = caa;
 
 	pc = (struct svsm_pvalidate_call *)call.caa->svsm_buffer;
-	pc_pa = svsm_get_caa_pa() + offsetof(struct svsm_ca, svsm_buffer);
+	pc_pa = caa_pa + offsetof(struct svsm_ca, svsm_buffer);
 
 	pc->num_entries = 1;
 	pc->cur_index   = 0;
@@ -640,12 +641,12 @@ static void __head svsm_pval_4k_page(unsigned long paddr, bool validate)
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
@@ -654,7 +655,7 @@ static void __head pvalidate_4k_page(unsigned long vaddr, unsigned long paddr,
 }
 
 static void __head __page_state_change(unsigned long vaddr, unsigned long paddr,
-				       enum psc_op op)
+				       enum psc_op op, struct svsm_ca *caa, u64 caa_pa)
 {
 	u64 val, msr;
 
@@ -663,7 +664,7 @@ static void __head __page_state_change(unsigned long vaddr, unsigned long paddr,
 	 * state change in the RMP table.
 	 */
 	if (op == SNP_PAGE_STATE_SHARED)
-		pvalidate_4k_page(vaddr, paddr, false);
+		pvalidate_4k_page(vaddr, paddr, false, caa, caa_pa);
 
 	/* Save the current GHCB MSR value */
 	msr = sev_es_rd_ghcb_msr();
@@ -685,7 +686,7 @@ static void __head __page_state_change(unsigned long vaddr, unsigned long paddr,
 	 * consistent with the RMP entry.
 	 */
 	if (op == SNP_PAGE_STATE_PRIVATE)
-		pvalidate_4k_page(vaddr, paddr, true);
+		pvalidate_4k_page(vaddr, paddr, true, caa, caa_pa);
 }
 
 /*
diff --git a/arch/x86/boot/startup/sev-startup.c b/arch/x86/boot/startup/sev-startup.c
index 5eb7d939ebd3..22b8667310d5 100644
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


