Return-Path: <linux-efi+bounces-4443-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79304B0D328
	for <lists+linux-efi@lfdr.de>; Tue, 22 Jul 2025 09:33:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD9643B0016
	for <lists+linux-efi@lfdr.de>; Tue, 22 Jul 2025 07:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88CCE288D2;
	Tue, 22 Jul 2025 07:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SyTSAmiH"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833C72D9489
	for <linux-efi@vger.kernel.org>; Tue, 22 Jul 2025 07:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753169400; cv=none; b=KXUerTFZSA/9d7bAaCFV/oRQ2EZ4wlrExY7lhPB4Swpl0UaZsQGkX3oyCQHLmD7aA9YpoEQM67fOnjXXLXApMZ9rUY+lm2ZkKEQ/bLckV3DlOhwmbqWhPN68Sdt5rVsRzd7xZNo1g+iVe1CdhaKcAeHw6bi+76FixI0/MyCpZNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753169400; c=relaxed/simple;
	bh=ldtqyx89ZKOrYRSSDmGEqyM2yCsaGPrtjSFBO5qwqQ4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HOPoAuT220N7Mduu01bcrFGf4PkYfKvuZg4tlSYF1ZsdkPvcsUbBM3KWglwEa+k/QpvjkcMeOsU/5AB/N5Tua+RX/Lg4vyVNofIHQjksZ99O+v9+C0tI5E+x4t+h7lGN1wEPl3Rks/HyOwtUJ07ybKBN77SkxJW7fBfz3dndK8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SyTSAmiH; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3b6162a7abdso1458865f8f.2
        for <linux-efi@vger.kernel.org>; Tue, 22 Jul 2025 00:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753169397; x=1753774197; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AnIyIP+8xABAcHb3glWQZIu3Z146M5cuD0atVAZd87Y=;
        b=SyTSAmiHws6dulDU5gTLNNGWlZbUxBzynJu8243bRURfi8pl1CMzVPrbR2EcXl6fIN
         mNcnh9dz7DxGEpn/N2XKTmlnTQlogRfSzknIQp31LUW21EqxEbDCyNdn1myWzBp9udsj
         z2ITFcd6FBCtIER2HX4QwKKRB4LI6anylippsUeJsLkYKU+yjgxYr0fubT31BdkHLZt0
         YGoBttnlm/uvu6njjdrsXb8R2bDEdfvUa59qc69SDDwTFhgph9QHT6q/SoGEmW1OYCdN
         BVCR6+xU+5RdKqZ2xlhDjqUoIeuGbtqsyYo+XB/HlPAfQIf2547Emhz0uzzXGzCR5Yrn
         L4dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753169397; x=1753774197;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AnIyIP+8xABAcHb3glWQZIu3Z146M5cuD0atVAZd87Y=;
        b=WrJOqZy3U4qc1WBDecQR3fMFhH6YeX3au1ddez9oqon7PFrKbZUJzwiQ7RYZ4j28wq
         MqNvqs0JXbfxQtp8ZgRmwt9mSc1mvnG4/yKs5Vgf4wjq6CxaHRTl2s8ggTBvLyMQefcG
         7wm0wGiQ9WI4qOrhyu8cMelMDu7YGMAZzaIyB4Nbb53HYUyE/ks48irrntQV0/A3tRMC
         JkN1JLMaqeD6Vn8l17WJSSD3ZyB5rHrrgaIJ5inMkkufMAlPO2Qv8pv4EJ9Qd15vCtHL
         ax8mgBIA1tvwvUbFgZbQ4x1gwrp/WwpcPbs21QbTb/JDjdjb4h+9LfxEvfUTJ1Gl42Uu
         GEZQ==
X-Gm-Message-State: AOJu0Yztl++HqEicwEj8GcXMkO1z9J0oExCoxtXMCjUgquJCCFkTYGyK
	dmr514DoClmqDoP9+yMAYUzbFBf7eMEtsh0YwEj/bYWujSa+Mt6E6xEY43UQSwoelCASGdLGSg=
	=
X-Google-Smtp-Source: AGHT+IEQ6PzJYCYSF1PTyhHuT7n5DPmk0+BNDw8KvvW3YZpez5kUzMtjspN7IAXcd29BHkrYgi+N5IG0
X-Received: from wmcq4.prod.google.com ([2002:a05:600c:c104:b0:456:1ba0:c8ac])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:2dc6:b0:3a6:e6c3:6d95
 with SMTP id ffacd0b85a97d-3b60e523e58mr16260822f8f.41.1753169396852; Tue, 22
 Jul 2025 00:29:56 -0700 (PDT)
Date: Tue, 22 Jul 2025 09:27:16 +0200
In-Reply-To: <20250722072708.2079165-24-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250722072708.2079165-24-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=5890; i=ardb@kernel.org;
 h=from:subject; bh=Xu3nJVJSBr+OOcY1i2lptxUFYocnqV8hTyJhBKvJwXs=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIaPetjA88pCy2hqGazLZv19LJifOt1JIfcj+esHStjJd/
 ZuXN07tKGVhEONikBVTZBGY/ffdztMTpWqdZ8nCzGFlAhnCwMUpABOZvIyR4UTHPKWmLSJfj9+K
 XDQ79jPL/hdrp815ZS+Y/eNM9PxIBmFGhubz+ZdWLXRvvMI+K0z7/H7BCPsbQvcfTWT3NKu9rto cyw0A
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250722072708.2079165-31-ardb+git@google.com>
Subject: [PATCH v6 07/22] x86/sev: Share implementation of MSR-based page
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
index 852c8443ed1a..1da1afa8677a 100644
--- a/arch/x86/boot/startup/sev-shared.c
+++ b/arch/x86/boot/startup/sev-shared.c
@@ -653,6 +653,41 @@ static void __head pvalidate_4k_page(unsigned long vaddr, unsigned long paddr,
 	}
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
2.50.0.727.gbf7dc18ff4-goog


