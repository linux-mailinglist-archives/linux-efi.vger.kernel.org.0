Return-Path: <linux-efi+bounces-4361-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADCCEB06C25
	for <lists+linux-efi@lfdr.de>; Wed, 16 Jul 2025 05:23:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91FF7502845
	for <lists+linux-efi@lfdr.de>; Wed, 16 Jul 2025 03:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FAA9287241;
	Wed, 16 Jul 2025 03:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ACxZgdeF"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569AB285CAC
	for <linux-efi@vger.kernel.org>; Wed, 16 Jul 2025 03:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752636158; cv=none; b=EUhNdszrt3FrIt4gkUGihk5HPo1n4S0GmLMbRWvS76ZDfhLuKR+n3M3EpwQKqvgZwCiWpE7bWjnttlLyE5+PiqdoaVnNkOhLLko7PshbohNuoQrCw1qj9ciifd0Kx3TiN3kuKv4wlYrSNgk7weHtGFkdsD2s9ZdQjw1v9YBNypE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752636158; c=relaxed/simple;
	bh=i67cWVaRAQ4eZncAXRCO/Umn964BhuZwxdzxTjLCZn0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SnDql9722GQTnvqrTlA5iBbvwsEfBXQQt7a8VZgQ7uhuGJsDCqzayeyCWDUGDa3DFJJB+mY3VH2pD+q0D+QRKE9tJUPqgRcFxDYbD3TtOCvKTmw39WxvzjuQuL53mARCZqtjuKtXDF4T39jOZj+fDwOC7ilK8OTV0E+8CtTpWIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ACxZgdeF; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-455f7b86aeeso22743015e9.0
        for <linux-efi@vger.kernel.org>; Tue, 15 Jul 2025 20:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752636154; x=1753240954; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=seVu/hlbGGJBqxPsPWxmSZOLbCHmT574aFbdl34TIuA=;
        b=ACxZgdeFGR7/i5D+1AX29E5SlvO5Ss7NRlxXx/4fkowPe0wjrcwsOOpKoqvn7Q7Qp4
         MvcEH0neK1CIPG41svZWwnTVGQK5fl///69w12bPoVKHEZqqW2bGMvxIJXVqosWOdpdv
         MLbSsyMCwtyfouNCFar2Hq/vYKNW6J877gLoQwKvaEdIkx/2OIdJN+U+NCNAyA59tft6
         SepPwsJMEPwBGeLbsFlG7SXeEaZxpw3grhpVhl9v+oK0kUct6g93e18hbS0BFEgKCxsc
         2B06THbNBAgQ84cvlnguXuWvVNvPYP43G4eLQPqipqVj1nj/pjGD6DXSPyo4oTpYo4e5
         Evrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752636154; x=1753240954;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=seVu/hlbGGJBqxPsPWxmSZOLbCHmT574aFbdl34TIuA=;
        b=a35gJvE9Zagy6v1d7HJtEFTSY9aX0FBf1rSsHuE2XnkeOtONZSuIEwk1jHfXuXBhaK
         GKct/WD9k0b8LH62F7wSfVyR/u2HYMvdeux/xZ2ZelXZbMc6dWRnLiUX4xqllUPcyWUu
         +AkUW1SF4Phfm6VgKmmETGjORAnbFG0YMo3OirUTiRXAUjPbu8Zgm6Yop5H+4gBZF+YS
         O7rgqddKkfta7lYlvjfa8AJNC/k3aimrSNY5DJr+pOf0ES2hZI2G6x3GyXsDG9qWPR5w
         wmrk6Y0LxARCXVirSmprR+2bsKNlievTl5fZs9h6b1LvXlSdnD30WUYgyKYnYc9Aqg6Y
         qgtw==
X-Gm-Message-State: AOJu0YxtWv74JORr0hAI1vzzRJb3IQWm4FnYa7xLX7RUh30qucpK7v/A
	iznO5f6ptDGLuNFsHS2sWh13jUz5jBvCN6nMU7kEMl0IXBgxB8zo2lUBNjeJsAj2XczDWRolDQ=
	=
X-Google-Smtp-Source: AGHT+IEEAn03r+iGo9sigkqWkvIUH1Lj6tDW+jx257/yXet6x8gb1hLrJBMp58icz2d+qcCpiwuD3bQS
X-Received: from wmte15.prod.google.com ([2002:a05:600c:8b2f:b0:453:ec2:c7bd])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:5025:b0:441:b698:3431
 with SMTP id 5b1f17b1804b1-4562ee4428amr3525365e9.28.1752636154796; Tue, 15
 Jul 2025 20:22:34 -0700 (PDT)
Date: Wed, 16 Jul 2025 05:18:22 +0200
In-Reply-To: <20250716031814.2096113-24-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250716031814.2096113-24-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=5890; i=ardb@kernel.org;
 h=from:subject; bh=llU6Zxgjbah9Zu77ptLCMjXMIAerw/AmqN3d/AjoSzs=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIaNcSnHDWcU0Aa8rOwyc7D49Vbg2bduhedcbsu+YPhfim
 /6ltbW7o5SFQYyLQVZMkUVg9t93O09PlKp1niULM4eVCWQIAxenAEzk1WOG/yHPGwviIs8W3lLp
 Fw/3YI882tfAH3fzp0Si8o8Onsua8YwM64QyWFc8TPl992HphYRjZ439zPjrX1QdiP5aFxc054s JOwA=
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250716031814.2096113-31-ardb+git@google.com>
Subject: [PATCH v5 07/22] x86/sev: Share implementation of MSR-based page
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
index 51f2110bc509..eb241ff1156d 100644
--- a/arch/x86/boot/startup/sev-shared.c
+++ b/arch/x86/boot/startup/sev-shared.c
@@ -652,6 +652,41 @@ static void __head pvalidate_4k_page(unsigned long vaddr, unsigned long paddr,
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
index f3e247d205b7..b4e2cb7bc44a 100644
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


