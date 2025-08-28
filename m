Return-Path: <linux-efi+bounces-4632-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 803ECB3999E
	for <lists+linux-efi@lfdr.de>; Thu, 28 Aug 2025 12:24:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F2C14667E3
	for <lists+linux-efi@lfdr.de>; Thu, 28 Aug 2025 10:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA10830DD20;
	Thu, 28 Aug 2025 10:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bRBeQUbV"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687C030AD0E
	for <linux-efi@vger.kernel.org>; Thu, 28 Aug 2025 10:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756376567; cv=none; b=Bl+Js8rxZf2y6BrH80Lw/5T9TtBxle1IjMYCqsStff5eQi6EdDyfmQcIAsxBaSkr7Y+A9r8oRb/aahHkJpXn4PBr6URvMhSVmnQT6gmwEgGc9tbrpZXHgRFJzewXP9dx9BY0NPyZ4/53//JJprWIZrM7ITny1XRD22OpVAM19CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756376567; c=relaxed/simple;
	bh=fOUbgDPfEUmMxePLgMhIgcjUhn4DDpLQ1ei/0F4NSiI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=e/5m3XHln85SLDAIajEcud+kFVUZmqA64GWNqU6r782BE33OjyHM8dB6x2mTOP2BwN6pUUmi8N0zYaKGYLtnaDt5WrxHidNxSbODbcz7o3nCKL/akI5Q26rbeiatrnuBX4UsfasVEkb4BjiMPZND5uScP9HcxggX7YwxLR2w2Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bRBeQUbV; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-45b71fe31ffso4577875e9.2
        for <linux-efi@vger.kernel.org>; Thu, 28 Aug 2025 03:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756376563; x=1756981363; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CTbuxh7eJTWljsDMXoTjLRxQFMI8xKvDnT16BYdzj+g=;
        b=bRBeQUbV5RVmMzv4zwn0KWvtn8cc5ZdZFoSTecqudhUVHM6rJqCi2mIFFbScYYdehS
         VxecWOPiKfpyW0TkZNyLMT09GePoVW3kXogyqo3v0IPRKZAwE9WAQvBx5dsxlpoVposc
         l7LQ7wa1eOYqXt0tFqP3bByn+HYNMXDISmuAvMjYWDQb98yZFigyBO1PxLNo5FayCwtE
         MA3vS42LVrofmG1Y2SJoOV/N8dBGkb3Wv6Iyxm90TwXlhAYsYrPSFYxUyVxItAdKQDb+
         JVgtIiw+EueD4W9+doiBzLVC4HrVdNu9NbgKTPBEAf/eC8swGQw+r1ufMIoZgtfruMcl
         WF6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756376563; x=1756981363;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CTbuxh7eJTWljsDMXoTjLRxQFMI8xKvDnT16BYdzj+g=;
        b=MxdIhaDHY4mkvCO2vC/GkuqtwKMAfHkVlzuKUMBFoX416tobxmm5CFx+lmi9CVh7ZH
         tynRKxUIvnYql3TM7eth+xKMyZTYbLi4jPOjtZ2gu1mZchIYHValDetv1ZaIRIwvcZdj
         +3FldyAdwz3rL+R8uXwnRIJAYWsxE793vJ6hIbqaGclFikE/vip5IncwJpWyjeUN3ZGY
         atDs2rgIYGo5S608nl6NbizlBQHAtJ1bz/3lQR9DWeXdtBVSGFGOC0mBK0a0R280h/BO
         BSvuXloRV32HHexYX95PVriVwbCZVAiMFokgqtVcgoqfomnTtH9GYAG/D5F1bxowKanA
         60rw==
X-Gm-Message-State: AOJu0Yxsjz9jkUIjyoKzo+vvWWar8KXgX425QOX/U74cH5ocXWWm2/h4
	RxhsNSqyDeW1LQ2fn4SLn1JOHRjuOlsuHZ7cb8tbtQFK2E1LFm0yQ454zle75M2EcFwy7LtZog=
	=
X-Google-Smtp-Source: AGHT+IGuBS1recQYqVOziZ50rTraSRaAGKtdc+RbWE6bpJM80s4AJn5voCySBTmexCXq8s/+s519sDz+
X-Received: from wmbed10.prod.google.com ([2002:a05:600c:614a:b0:45b:72dc:5715])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:1c98:b0:459:ea5d:418b
 with SMTP id 5b1f17b1804b1-45b5179f3dcmr194541465e9.9.1756376562652; Thu, 28
 Aug 2025 03:22:42 -0700 (PDT)
Date: Thu, 28 Aug 2025 12:22:10 +0200
In-Reply-To: <20250828102202.1849035-24-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250828102202.1849035-24-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=5924; i=ardb@kernel.org;
 h=from:subject; bh=Nux9cVSIr+CSNp9JeU1YADSUjJDp6xCOlW6q6zxAI40=;
 b=kA0DAAoWMG4JVi59LVwByyZiAGiwLdOiUSdTE/OYZzZYBzROcK/IfiQ+7TnQWF5wS/oP4MYNQ
 Yh1BAAWCgAdFiEEEJv97rnLkRp9Q5odMG4JVi59LVwFAmiwLdMACgkQMG4JVi59LVzTTQEAnxRH
 0+uoQIzAvcN5dhUTI1A71XPQlfIU5EMuK4zhuTIBAI4wiawDpJ+hUAYqhPn6M1A6kknhbARABON 7v1tUCaYL
X-Mailer: git-send-email 2.51.0.268.g9569e192d0-goog
Message-ID: <20250828102202.1849035-31-ardb+git@google.com>
Subject: [PATCH v7 07/22] x86/sev: Share implementation of MSR-based page
 state change
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: linux-efi@vger.kernel.org, x86@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>, 
	Kevin Loughlin <kevinloughlin@google.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Nikunj A Dadhania <nikunj@amd.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Both the decompressor and the SEV startup code implement the exact same
sequence for invoking the MSR based communication protocol to effectuate
a page state change.

Before tweaking the internal APIs used in both versions, merge them and
share them so those tweaks are only needed in a single place.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/sev.c      | 40 ++------------------
 arch/x86/boot/startup/sev-shared.c  | 35 +++++++++++++++++
 arch/x86/boot/startup/sev-startup.c | 29 +-------------
 3 files changed, 39 insertions(+), 65 deletions(-)

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index 6c0f91d38595..f714235d3222 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -60,46 +60,12 @@ static bool sev_snp_enabled(void)
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
-	/* Save the current GHCB MSR value */
-	msr = sev_es_rd_ghcb_msr();
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
-	/* Restore the GHCB MSR value */
-	sev_es_wr_ghcb_msr(msr);
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
 	if (!sev_snp_enabled())
 		return;
 
-	__page_state_change(paddr, SNP_PAGE_STATE_PRIVATE);
+	__page_state_change(paddr, paddr, SNP_PAGE_STATE_PRIVATE);
 }
 
 void snp_set_page_shared(unsigned long paddr)
@@ -107,7 +73,7 @@ void snp_set_page_shared(unsigned long paddr)
 	if (!sev_snp_enabled())
 		return;
 
-	__page_state_change(paddr, SNP_PAGE_STATE_SHARED);
+	__page_state_change(paddr, paddr, SNP_PAGE_STATE_SHARED);
 }
 
 bool early_setup_ghcb(void)
@@ -133,7 +99,7 @@ bool early_setup_ghcb(void)
 void snp_accept_memory(phys_addr_t start, phys_addr_t end)
 {
 	for (phys_addr_t pa = start; pa < end; pa += PAGE_SIZE)
-		__page_state_change(pa, SNP_PAGE_STATE_PRIVATE);
+		__page_state_change(pa, pa, SNP_PAGE_STATE_PRIVATE);
 }
 
 void sev_es_shutdown_ghcb(void)
diff --git a/arch/x86/boot/startup/sev-shared.c b/arch/x86/boot/startup/sev-shared.c
index 68044c11524c..4c94d88f5ac8 100644
--- a/arch/x86/boot/startup/sev-shared.c
+++ b/arch/x86/boot/startup/sev-shared.c
@@ -662,6 +662,41 @@ static void __head pvalidate_4k_page(unsigned long vaddr, unsigned long paddr,
 		sev_evict_cache((void *)vaddr, 1);
 }
 
+static void __head __page_state_change(unsigned long vaddr, unsigned long paddr,
+				       enum psc_op op)
+{
+	u64 val, msr;
+
+	/*
+	 * If private -> shared then invalidate the page before requesting the
+	 * state change in the RMP table.
+	 */
+	if (op == SNP_PAGE_STATE_SHARED)
+		pvalidate_4k_page(vaddr, paddr, false);
+
+	/* Save the current GHCB MSR value */
+	msr = sev_es_rd_ghcb_msr();
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
+	/* Restore the GHCB MSR value */
+	sev_es_wr_ghcb_msr(msr);
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
index 8a06f6026101..5eb7d939ebd3 100644
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
2.51.0.268.g9569e192d0-goog


