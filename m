Return-Path: <linux-efi+bounces-4214-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A377AFE213
	for <lists+linux-efi@lfdr.de>; Wed,  9 Jul 2025 10:12:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E361580A96
	for <lists+linux-efi@lfdr.de>; Wed,  9 Jul 2025 08:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFB64278153;
	Wed,  9 Jul 2025 08:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A6BDt1Kn"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0A1273D84
	for <linux-efi@vger.kernel.org>; Wed,  9 Jul 2025 08:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752048683; cv=none; b=er4dIKEZQBXjkKE1GwYGOQ7iIl88oANVSOWZ6yzsywDzvh0nTAX3PTS9IT+rKO4piHN7sQ6hzetI3Eib1Z7XTvev3nxVxH8bzsMF6MOr9IX8mreUn5fFZDUBXoomCkW0Ba8X1mKzvqJVNY4Vae4D/sO4RZrxp2W4Ltg78swgtOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752048683; c=relaxed/simple;
	bh=QlJDUa/wmHPCr0L6KQzGEoGR1dDsmu3WJkfxcuEn20g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TtmUrL0ZUy1d+LjQarmxaG+sGeQOZ/X/cD632OkgqZ68m8U8ZCRNJV2B+oB/In1RBde6CHmT6xjmQB6yA8T28Wh/J1mGhXgaKWTYJqGSK1+oRn/vUsVHbqB0zE2j5YDGQjHhbt2EWKdGdmKqs03F5DoX7bPH+mwUWtXOaUAz0oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A6BDt1Kn; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4538f375e86so43217825e9.3
        for <linux-efi@vger.kernel.org>; Wed, 09 Jul 2025 01:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752048680; x=1752653480; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=p27Yr94wFvVuXSOGu0p6o917P9zN6E8aHq6FENQPHR4=;
        b=A6BDt1KnbeT0ttpJoikDb1JC36cCteMz6BBOK9dg2BcVG/3TrI5B9qO63V01Si9M/C
         w+kuU0vtjzZfbd+4znUoFSUPJMMadvlNCn9357KcfTkS7p5taa6N1gOEIJP9y680rptv
         Nra5AzEatBTNCdfNeM8L4GzKElWeMdoyM9JiheMyqR761m0X60SOux/6wL77lGR6D68i
         XBKGT2J+YuCv6NT02vVbbdzulefV6id5fagxRvB6uXHF+BmmHwcw6AZYlJYjnWuSIfO9
         3vszIYXr5IS63KamcVDuz/r1IcMuZ0zjlktX0uHFx74PdnYor/WuBwFFb7XUIZGdw7ta
         SUMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752048680; x=1752653480;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p27Yr94wFvVuXSOGu0p6o917P9zN6E8aHq6FENQPHR4=;
        b=gFylNsvDrMHJ0Q1WbwO3CzlpxozLWl8DcLhq4scDFrW99swChIQcZwDi+U2bkGAagA
         0y9+qODFQ9A0P7q3/Ik0X+8rpaO0zYHPE64XZkG2OyfOFqJ59tZ4I1azL/D2uMyfZEC1
         9JZ7cfi4dZD3HmeqdayFD1zrnO0ybwgCsK0Dw5z5XrERvjicFdzZdLlsSwrBl0sSccNn
         44Wadv33Gc2ZNivr6OvoHVtMLHkBIZrBrg9dRJyPMu1taJpVTx4AQwKxVzBzm0EyWI46
         TeI5WAqe9srdT2gq8lQFxqjd3i3AvYilS8IShRUpPYmohQMw/L4KyZj4cXSe+gx2f0x0
         4PCg==
X-Gm-Message-State: AOJu0YykDiNLcmKa8h8TwG22HwRwVRMEZYfIAvFe+Zs9Zi7CbRsrQNmp
	vQ4LqDJmGk+LGTZp+AfBZZEPAUuHT/vgZMcWUzBm+m50pEQifXa34xR6onrPIpxkFf5onBFTVw=
	=
X-Google-Smtp-Source: AGHT+IFJKWMf9tSZIxp4IEeq/DNBtQqR89TnbRaz3qEWoh/M+Z1ovU9uB+aXGn+qCSIHdhezwgFHV2UV
X-Received: from wmsp42.prod.google.com ([2002:a05:600c:1daa:b0:453:65ee:17c9])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:c092:b0:43d:4686:5cfb
 with SMTP id 5b1f17b1804b1-454d68d5f3cmr6837705e9.27.1752048680298; Wed, 09
 Jul 2025 01:11:20 -0700 (PDT)
Date: Wed,  9 Jul 2025 10:08:50 +0200
In-Reply-To: <20250709080840.2233208-26-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250709080840.2233208-26-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=7734; i=ardb@kernel.org;
 h=from:subject; bh=ukg2ikRncZZRH8xxxbNI9IFxpsDcpeTVpwIsEAToVtc=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JISNPeadawJY/DBJCx69MiFnZsjXD0TVw7tL237duH7xom
 ed4K5Ono5SFQYyLQVZMkUVg9t93O09PlKp1niULM4eVCWQIAxenAEzkaijDP/XTOg0njmQl1st0
 R6rP2eDHre5/fa+2WuDxn7lF1oJsdQz/4/d1VJ6Q/Zb8clXmuqBZcj+7N4eUFLJZNs4/wH89Pf8 JAwA=
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250709080840.2233208-35-ardb+git@google.com>
Subject: [PATCH v4 09/24] x86/sev: Pass SVSM calling area down to early page
 state change API
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: linux-efi@vger.kernel.org, x86@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>, 
	Dionna Amalie Glaze <dionnaglaze@google.com>, Kevin Loughlin <kevinloughlin@google.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>
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
index 6d3ed7ed03a4..bc23b3dabf1b 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -68,7 +68,9 @@ void snp_set_page_private(unsigned long paddr)
 		return;
 
 	msr = sev_es_rd_ghcb_msr();
-	__page_state_change(paddr, paddr, SNP_PAGE_STATE_PRIVATE);
+	__page_state_change(paddr, paddr, SNP_PAGE_STATE_PRIVATE,
+			    (struct svsm_ca *)boot_svsm_caa_pa,
+			    boot_svsm_caa_pa);
 	sev_es_wr_ghcb_msr(msr);
 }
 
@@ -80,7 +82,9 @@ void snp_set_page_shared(unsigned long paddr)
 		return;
 
 	msr = sev_es_rd_ghcb_msr();
-	__page_state_change(paddr, paddr, SNP_PAGE_STATE_SHARED);
+	__page_state_change(paddr, paddr, SNP_PAGE_STATE_SHARED,
+			    (struct svsm_ca *)boot_svsm_caa_pa,
+			    boot_svsm_caa_pa);
 	sev_es_wr_ghcb_msr(msr);
 }
 
@@ -109,7 +113,9 @@ void snp_accept_memory(phys_addr_t start, phys_addr_t end)
 	u64 msr = sev_es_rd_ghcb_msr();
 
 	for (phys_addr_t pa = start; pa < end; pa += PAGE_SIZE)
-		__page_state_change(pa, pa, SNP_PAGE_STATE_PRIVATE);
+		__page_state_change(pa, pa, SNP_PAGE_STATE_PRIVATE,
+				    (struct svsm_ca *)boot_svsm_caa_pa,
+				    boot_svsm_caa_pa);
 	sev_es_wr_ghcb_msr(msr);
 }
 
diff --git a/arch/x86/boot/startup/sev-shared.c b/arch/x86/boot/startup/sev-shared.c
index f553268d31d7..1f2c4feeafce 100644
--- a/arch/x86/boot/startup/sev-shared.c
+++ b/arch/x86/boot/startup/sev-shared.c
@@ -587,7 +587,8 @@ static void __head setup_cpuid_table(const struct cc_blob_sev_info *cc_info)
 	}
 }
 
-static void __head svsm_pval_4k_page(unsigned long paddr, bool validate)
+static void __head svsm_pval_4k_page(unsigned long paddr, bool validate,
+				     struct svsm_ca *caa, u64 caa_pa)
 {
 	struct svsm_pvalidate_call *pc;
 	struct svsm_call call = {};
@@ -601,10 +602,10 @@ static void __head svsm_pval_4k_page(unsigned long paddr, bool validate)
 	 */
 	flags = native_local_irq_save();
 
-	call.caa = svsm_get_caa();
+	call.caa = caa;
 
 	pc = (struct svsm_pvalidate_call *)call.caa->svsm_buffer;
-	pc_pa = svsm_get_caa_pa() + offsetof(struct svsm_ca, svsm_buffer);
+	pc_pa = caa_pa + offsetof(struct svsm_ca, svsm_buffer);
 
 	pc->num_entries = 1;
 	pc->cur_index   = 0;
@@ -627,12 +628,12 @@ static void __head svsm_pval_4k_page(unsigned long paddr, bool validate)
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
@@ -641,7 +642,7 @@ static void __head pvalidate_4k_page(unsigned long vaddr, unsigned long paddr,
 }
 
 static void __head __page_state_change(unsigned long vaddr, unsigned long paddr,
-				       enum psc_op op)
+				       enum psc_op op, struct svsm_ca *caa, u64 caa_pa)
 {
 	u64 val;
 
@@ -650,7 +651,7 @@ static void __head __page_state_change(unsigned long vaddr, unsigned long paddr,
 	 * state change in the RMP table.
 	 */
 	if (op == SNP_PAGE_STATE_SHARED)
-		pvalidate_4k_page(vaddr, paddr, false);
+		pvalidate_4k_page(vaddr, paddr, false, caa, caa_pa);
 
 	/* Issue VMGEXIT to change the page state in RMP table. */
 	sev_es_wr_ghcb_msr(GHCB_MSR_PSC_REQ_GFN(paddr >> PAGE_SHIFT, op));
@@ -666,7 +667,7 @@ static void __head __page_state_change(unsigned long vaddr, unsigned long paddr,
 	 * consistent with the RMP entry.
 	 */
 	if (op == SNP_PAGE_STATE_PRIVATE)
-		pvalidate_4k_page(vaddr, paddr, true);
+		pvalidate_4k_page(vaddr, paddr, true, caa, caa_pa);
 }
 
 /*
diff --git a/arch/x86/boot/startup/sev-startup.c b/arch/x86/boot/startup/sev-startup.c
index 2ffd8bf09357..e253783f6aa5 100644
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


