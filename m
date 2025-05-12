Return-Path: <linux-efi+bounces-3663-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC13FAB4493
	for <lists+linux-efi@lfdr.de>; Mon, 12 May 2025 21:13:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 135E78C2CA9
	for <lists+linux-efi@lfdr.de>; Mon, 12 May 2025 19:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 982D8299946;
	Mon, 12 May 2025 19:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sJXloRfR"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A83299924
	for <linux-efi@vger.kernel.org>; Mon, 12 May 2025 19:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747077112; cv=none; b=bihd01hqyC5TVjWMMOz4O37zkdXqe+SKGeSl0C8hEQ0251J/2IofkUXwxeGjF1fk4C2ZNuqundcd+xgFWkJCN8nppHsqdkfrhzkers8IsKr5AbxhyHRfO4+TWH1C8mFJIv6z52CbnDgDNYmKQBOaGun0DyFoYVrB1nPCWp9o+VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747077112; c=relaxed/simple;
	bh=CEDHPADBrtfM/ieGiln94YohPo2UkLSRjqpr/xNAnb8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mCq5Bz50xmYJQshq/fuJlu5foeSCIZO00mm22RxuzCzevhDu06l2/33H2j1n+6FPcf2/JlEKeo/UrV6pikMGhnJSvYtzqAMTAzYW+90McrAhL7ydzv2GyO29X96v75o3k9MjAXO2yXshlcGsz36CV/KLGQbyCxfuUD+DvxvrNCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sJXloRfR; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-442d472cf84so21959885e9.2
        for <linux-efi@vger.kernel.org>; Mon, 12 May 2025 12:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747077109; x=1747681909; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nhvFVJIiQ0vT+i/sKXNm0DR7xFRSNY+vN9L5egobjeA=;
        b=sJXloRfRoEvAYUdrjRFvj05n7CWyWPuIxB5VhJnrEzQg6zKARNYNfQgr1x5VtnimC5
         KiVCL1FdWyiw+A2LwRNXKfq9dpNuG8wWf349LBzCucc9Azz3WMDzdyLSwPLX52EM5+ky
         PzigqPQPUE947fkLthmeauGpPG5Wv8Yy/rvxuElMpJBbIOchAK9jPjbackzdOlhmZqqc
         vuBMPxCUtYAQuZC0XdWyvmzWtdb1APQyo4WL9DBKZhwJQ/wedzm5dHaIU83TnomzIuG7
         mCEaCzRbQo3O8U+pPodu5o4+R/ncFA1FPyrsITLrOB6SdpKzJIUGArhza6zEFIWEP0ke
         B67A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747077109; x=1747681909;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nhvFVJIiQ0vT+i/sKXNm0DR7xFRSNY+vN9L5egobjeA=;
        b=s8XVVNlug8cId1zylUt+ebFgnv01gkAmxSmilfR1L1f65ITWewYuAHZ4t7umuJL6vw
         hma6E8rrVkGYtU+JYgOuC7owyiEs6Pw44eLoYKdSCOPaAu2eTJM5mZBp5e7+Fe0B5kZQ
         NwLWP5cpRvD1fMplD04U7Xun6Zl5THV4N+y3p5l2HElVDz9T3csHv8sU7zQBiPrMP50I
         v68cgBjjQKw/bKUVci4fd59jmDnlGLt8NJhLERCpxccK9UZd0MZZlwu9bUwyhkaXmla3
         Yl7glQNB2l3xfbVav/h5XsiQgEtm0NDcyJNsIvjOIzLnVIuRMOpe05rH3vy34+gr5hOc
         5cdw==
X-Gm-Message-State: AOJu0YwSG5ImVWOTrnGPODbKgAQCPSM7rm7hcyRCSzfyfew8d/segJuy
	JuCuvQQ4aLpK6SqREeY7QcDEgth6fwWyk6YKmc65yNnzOi3YjvztJZcxUSLSgdC3SVJC6w==
X-Google-Smtp-Source: AGHT+IE9c4d8hXCnsFdSoEnEljzaBiKUHnHJAmVQhNhaHMh0SWW33pmdhIS4P2KN4rpcXJGV8HvHUh01
X-Received: from wmbet7.prod.google.com ([2002:a05:600c:8187:b0:442:e9fd:359])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:1c8f:b0:434:fa55:eb56
 with SMTP id 5b1f17b1804b1-442d6d18a76mr112034265e9.7.1747077109001; Mon, 12
 May 2025 12:11:49 -0700 (PDT)
Date: Mon, 12 May 2025 21:08:43 +0200
In-Reply-To: <20250512190834.332684-23-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250512190834.332684-23-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=4782; i=ardb@kernel.org;
 h=from:subject; bh=3yIuqQM7nuI1sJOHAR/DsDxVbgNKhocAaK2M0PWLoso=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIUPJ3cWL/cSpfVwTXj8qlz9TMX/py8/xZ3kU+W6nromZq
 XbYN9+2o5SFQYyDQVZMkUVg9t93O09PlKp1niULM4eVCWQIAxenAEyEu5iR4aLurx8vAkyu61zk
 3bWWTaPztsi0acHLcy3PL9DwY+aeUsTI8OPKVNlNb73OP9/BEp/qrrWwUpnjgZDSXiGBhuuhupm WHAA=
X-Mailer: git-send-email 2.49.0.1045.g170613ef41-goog
Message-ID: <20250512190834.332684-31-ardb+git@google.com>
Subject: [RFT PATCH v3 08/21] x86/sev: Share implementation of MSR-based page
 state change
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: linux-efi@vger.kernel.org, x86@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>, 
	Dionna Amalie Glaze <dionnaglaze@google.com>, Kevin Loughlin <kevinloughlin@google.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Both the decompressor and the SEV startup code implement the exact same
sequence for invoking the MSR based communication protocol to effectuate
a page state change.

Before tweaking the internal APIs used in both versions, merge them and
share them so those tweaks are only needed in a single place.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/sev.c      | 28 -------------------
 arch/x86/boot/startup/sev-shared.c  | 28 +++++++++++++++++++
 arch/x86/boot/startup/sev-startup.c | 29 +-------------------
 3 files changed, 29 insertions(+), 56 deletions(-)

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index bdedf4bd23ec..7a01eef9ae01 100644
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
diff --git a/arch/x86/boot/startup/sev-shared.c b/arch/x86/boot/startup/sev-shared.c
index 9e0573aa29c1..dae770327b50 100644
--- a/arch/x86/boot/startup/sev-shared.c
+++ b/arch/x86/boot/startup/sev-shared.c
@@ -591,6 +591,34 @@ static void __head pvalidate_4k_page(unsigned long vaddr, unsigned long paddr,
 	}
 }
 
+static void __head __page_state_change(unsigned long paddr, enum psc_op op)
+{
+	u64 val;
+
+	/*
+	 * If private -> shared then invalidate the page before requesting the
+	 * state change in the RMP table.
+	 */
+	if (op == SNP_PAGE_STATE_SHARED)
+		pvalidate_4k_page(paddr, paddr, false);
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
+		pvalidate_4k_page(paddr, paddr, true);
+}
+
 /*
  * Maintain the GPA of the SVSM Calling Area (CA) in order to utilize the SVSM
  * services needed when not running in VMPL0.
diff --git a/arch/x86/boot/startup/sev-startup.c b/arch/x86/boot/startup/sev-startup.c
index 24e7082e1a50..28bf68753580 100644
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
+		__page_state_change(paddr, op);
 
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
2.49.0.1045.g170613ef41-goog


