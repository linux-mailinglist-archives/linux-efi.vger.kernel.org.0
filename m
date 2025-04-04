Return-Path: <linux-efi+bounces-3197-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BC9AA7B8E1
	for <lists+linux-efi@lfdr.de>; Fri,  4 Apr 2025 10:30:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34BC53B75B2
	for <lists+linux-efi@lfdr.de>; Fri,  4 Apr 2025 08:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63E6719F13F;
	Fri,  4 Apr 2025 08:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cLBGcfR8"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B7219DF48
	for <linux-efi@vger.kernel.org>; Fri,  4 Apr 2025 08:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743755379; cv=none; b=uv5CdgxuGayO2kd9HV1bT+nX6jRVf4x2Ghq4xlisZUCZJGLx4sJ4NL/BAxB1Bg3svthyhFxGyEi9qMfAfEEZ+Z2Ogrfm7o5KSsxggqQS+eAupV0imeglCF3EHxlLaLmv8JUkpD49f66+Xhejo/HQlv7q0HtAIcDXM/vSnyWtxlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743755379; c=relaxed/simple;
	bh=8JlQN5R7UYSavnitZVOOcgUDOcx5suieJDCNQGuz1vc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eapl+A4umPIG9YOkLdSrLMteOdmtoYFhEBVC5ZhTGIVI2dpxVQEhLbGx5z/hap5otYFHr/x5a6bKnbsviArJsXgi6mxMXKYdZRuH2TkF+WOzaAZIy9tNXV2yv5RVSXSpZKT5PX/IzLgNkXHCkLLBPkNIkDZHJSrKRzAvamJD6eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cLBGcfR8; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-43d51bd9b41so14960985e9.3
        for <linux-efi@vger.kernel.org>; Fri, 04 Apr 2025 01:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743755376; x=1744360176; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=77wmnRXZYKcuVinOOTSCjtNgLEdtAQ/ze2YYLzREikQ=;
        b=cLBGcfR8arwLMFIEMO5g0/HErnJC/qST6fqoENYP6Q2XmB20g5ZVqmMbiEQbQVJm8r
         rYeQ5EwrqF8YbsiQdaXNLJ/GVL8WE6WkjBYGVQTrJz6X3pHPnqrNI3IN3r1qnPq5GPy6
         zz+v8e07KNlMQXZmKEPyJeSE/nNHyFrhBxpQiAl42yBkc9KNgHXufno9wx8i2bNANUlv
         pFLVdN7+rQCo/Uf8Qqx5lHv7ouSV3uE9kyEaKPvMtU/qWMCiXCxZiutrqB/MhM4aU/j4
         26eyc+MPczcn9e7aY5uaF15t/y8iB8ED4lC0/V6sz5miJJt94ejSKKCewXjbsYcygPWT
         Or3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743755376; x=1744360176;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=77wmnRXZYKcuVinOOTSCjtNgLEdtAQ/ze2YYLzREikQ=;
        b=g8G1zz5SBoMObnCCv30ryoxBCnvICyUuso3WxXgFu1fCqPxBf5ybp3LrZ2Niu8/543
         uSHbFgkHvtt96mQj83K0jmwz17Dex6rZFFAVYTtPr3LfJdZ1Zqlnmdp+CyssUKBB4LS9
         ggNIwiJq9KYzU90xaF8cyu7ub7c44Aw4bhyLNOabPNQdmw2kmEquf1ZcHu5EHX5IK0jp
         XzvBJ8rmSwMney0ehM330RAwqilTttI6ODjijp6DjlfaL0vBSfdDJsR40jDkPPaCmtg2
         Wc3oBdufX2umXAFgWoVx0y3/LSKPyoMu5hsHM7dYlo77Jh6eKcBPxhqh6+XHZV4DkNys
         qORw==
X-Gm-Message-State: AOJu0Yyi68/92grnUF18/0FvQYWHNWK0fmMqQGsXC+zUK4BKUcwlxEQj
	5H/BjViiUolDlfCnfbTs9eH/qT5vOEvmPTcLgyEQNJtU5BSJGvtVOiwG9nj/By3m4Un06zBwtmo
	G4jLlGGxt4cvoNuLGK/OQjKHSBESMJq2CENAqIxAdrXf2tmpW4hlQhqdYwymsj2wWtPmkFGLQX4
	I0nkcLZ5Cegxp38twKogj4VmSzeQ==
X-Google-Smtp-Source: AGHT+IE9Q44fWXDppms3q+uLZeZYVT9euOorhNGORhTF/Ogtb8hSb3mlIok0T+7OJIHJE7VCdiIMFWmF
X-Received: from wmco7.prod.google.com ([2002:a05:600c:a307:b0:43c:fd99:1b7e])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:1912:b0:43c:fcbc:9680
 with SMTP id 5b1f17b1804b1-43ed0d98e11mr10813175e9.25.1743755375791; Fri, 04
 Apr 2025 01:29:35 -0700 (PDT)
Date: Fri,  4 Apr 2025 10:29:25 +0200
In-Reply-To: <20250404082921.2767593-5-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250404082921.2767593-5-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=4109; i=ardb@kernel.org;
 h=from:subject; bh=gU6xURlLYFEx9EzfjM9uVyI6mnhjSldn1tb1ZweMrPM=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIf39jNT1l+JaZF+l6cw8cmpZjmNTX6fNpFntT4UObMzSe
 Wa06GxfRykLgxgHg6yYIovA7L/vdp6eKFXrPEsWZg4rE8gQBi5OAZhIuAjD/8TFqiu2b/WaNXHK
 90+Lm5Ne/FSrZut7m/DJ1ni+goDObQmG/76NtlWZJe/SGB9fTO440NU4Vepe8ZoDxRuF3sziCDh zjAUA
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250404082921.2767593-8-ardb+git@google.com>
Subject: [PATCH v2 3/3] x86/boot: Implement early memory acceptance for SEV-SNP
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Borislav Petkov <bp@alien8.de>, 
	Dionna Amalie Glaze <dionnaglaze@google.com>, Kevin Loughlin <kevinloughlin@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Switch to a different API for accepting memory in SEV-SNP guests, one
which is actually supported at the point during boot where the EFI stub
may need to accept memory, but the SEV-SNP init code has not executed
yet.

Co-developed-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/sev.c          | 34 +++++++++++++++++---
 drivers/firmware/efi/libstub/x86-stub.c |  4 ++-
 2 files changed, 33 insertions(+), 5 deletions(-)

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index bb55934c1cee..88100bf83ded 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -164,10 +164,7 @@ bool sev_snp_enabled(void)
 
 static void __page_state_change(unsigned long paddr, enum psc_op op)
 {
-	u64 val;
-
-	if (!sev_snp_enabled())
-		return;
+	u64 val, msr;
 
 	/*
 	 * If private -> shared then invalidate the page before requesting the
@@ -176,6 +173,9 @@ static void __page_state_change(unsigned long paddr, enum psc_op op)
 	if (op == SNP_PAGE_STATE_SHARED)
 		pvalidate_4k_page(paddr, paddr, false);
 
+	/* Save the current GHCB MSR value */
+	msr = sev_es_rd_ghcb_msr();
+
 	/* Issue VMGEXIT to change the page state in RMP table. */
 	sev_es_wr_ghcb_msr(GHCB_MSR_PSC_REQ_GFN(paddr >> PAGE_SHIFT, op));
 	VMGEXIT();
@@ -185,6 +185,9 @@ static void __page_state_change(unsigned long paddr, enum psc_op op)
 	if ((GHCB_RESP_CODE(val) != GHCB_MSR_PSC_RESP) || GHCB_MSR_PSC_RESP_VAL(val))
 		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_PSC);
 
+	/* Restore the GHCB MSR value */
+	sev_es_wr_ghcb_msr(msr);
+
 	/*
 	 * Now that page state is changed in the RMP table, validate it so that it is
 	 * consistent with the RMP entry.
@@ -195,11 +198,17 @@ static void __page_state_change(unsigned long paddr, enum psc_op op)
 
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
 
@@ -261,6 +270,11 @@ static phys_addr_t __snp_accept_memory(struct snp_psc_desc *desc,
 	return pa;
 }
 
+/*
+ * The memory acceptance support uses the boot GHCB page to perform
+ * the required page state change operation before validating the
+ * pages.
+ */
 void snp_accept_memory(phys_addr_t start, phys_addr_t end)
 {
 	struct snp_psc_desc desc = {};
@@ -275,6 +289,18 @@ void snp_accept_memory(phys_addr_t start, phys_addr_t end)
 		pa = __snp_accept_memory(&desc, pa, end);
 }
 
+/*
+ * The early version of memory acceptance is needed when being called
+ * from the EFI stub driver. The pagetable manipulation to mark the
+ * boot GHCB page as shared can't be performed at this stage, so use
+ * the GHCB page state change MSR protocol instead.
+ */
+void snp_accept_memory_early(phys_addr_t start, phys_addr_t end)
+{
+	for (phys_addr_t pa = start; pa < end; pa += PAGE_SIZE)
+		__page_state_change(pa, SNP_PAGE_STATE_PRIVATE);
+}
+
 void sev_es_shutdown_ghcb(void)
 {
 	if (!boot_ghcb)
diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index 7d9cf473f4d0..dcf436dea99e 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -383,6 +383,8 @@ static bool efistub_is_sevsnp_guest(void)
 	return sev_get_status() & MSR_AMD64_SEV_SNP_ENABLED;
 }
 
+void snp_accept_memory_early(phys_addr_t start, phys_addr_t end);
+
 void efistub_accept_memory(phys_addr_t start, phys_addr_t end)
 {
 	static bool once, is_tdx, is_sevsnp;
@@ -398,7 +400,7 @@ void efistub_accept_memory(phys_addr_t start, phys_addr_t end)
 	if (is_tdx)
 		tdx_accept_memory(start, end);
 	else if (is_sevsnp)
-		snp_accept_memory(start, end);
+		snp_accept_memory_early(start, end);
 }
 
 #endif
-- 
2.49.0.504.g3bcea36a83-goog


