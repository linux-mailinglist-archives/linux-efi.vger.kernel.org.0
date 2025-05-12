Return-Path: <linux-efi+bounces-3662-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FF75AB4491
	for <lists+linux-efi@lfdr.de>; Mon, 12 May 2025 21:13:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BAFA47AE083
	for <lists+linux-efi@lfdr.de>; Mon, 12 May 2025 19:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F86E2989B7;
	Mon, 12 May 2025 19:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m0CPwE33"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF72298CD0
	for <linux-efi@vger.kernel.org>; Mon, 12 May 2025 19:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747077110; cv=none; b=MKJ3VsuFvDhXqs/3EfdsIATAaTXmrcCZ3h+6pv6SvH7BllUpv4MhJzNnGGYbWi6QRhUEJWCbS2r3kGHR4zVFmARP6gphYJAwvQMK6TgUYXUNmv/sbNWMhnyXY80skNhc6RYtSrl9ZpYNy7+QcgnN+9hcPeAJQK7CMVwiRiDOwms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747077110; c=relaxed/simple;
	bh=gQ8lgJlMYZZ+fT7GZ7D62t7EJjJ4IWqxiM5r2SVc5Lg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rw9R3rLt7ukn9GtajmXfARTNLX3pfcmO+Q7CbmrEaUe1XZMK1vGq7t5UpnyffzuIoazZ53LnEbycSqYS+qwqOo9Cg+ziDmFL3tmrjMDj/vTy2GuKgP3cyCNhvuFl68fxV2ood7x+aoIT0ZTzKjYfwVL/cHQxQz1Z6gZqD8aHnUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m0CPwE33; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-43cf172ffe1so33688475e9.3
        for <linux-efi@vger.kernel.org>; Mon, 12 May 2025 12:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747077107; x=1747681907; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=etUdhENjKmpns5z45eOeD8S5YfrxjLnIgRLkkUi4X3I=;
        b=m0CPwE33zkGT89EbMTN9J/H24IUwLikbxLxceOmSwW9+DWv0eKmEe7IviUG3tp/HzZ
         DTYfHaLL+ktlMQQ3UqSK1A+9dfVr2t620NKsyRUJQkdO4FZuwJYbAcxaxuxo/psyGCE+
         Bov1uZFPOojqglbyaYdWRN3UmeWmjA/bPxXich9rxaNyhrtS5/Rn6XefPLjkkWxgO0rJ
         ZHvqT9SlVwWj7zU07IqjgGp6KeFdXZggXBTfVS5BfqU/kICV+dC042sF3TfHGzYTX+JO
         E4yAh9wGfeLKB06Bb/xPjzUGPbACCL/x+CzrlnLLFG/8rR4cx9PDja3m4GnEQhR96Zo+
         JNBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747077107; x=1747681907;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=etUdhENjKmpns5z45eOeD8S5YfrxjLnIgRLkkUi4X3I=;
        b=EZnX+RqrfUUTx/E1iQwoASfQd8ymYcCNIIdYyt7suL3QEpgUA6QeK7eHv+QKMS3yoX
         JTL6FR1IZGAxgQYt3G03QBAyMmk0LTdyaBEXhwgffvukrmNZJl/UEqSthM+voTWFxYgb
         VT70WJch0TVwERs0a3k9Y7/jG1H/JQ6k8Sz1oo6AstXsEUZ89OfrB1oT7X2z/EIEv+E5
         lBdinEeQyhV/KAWK8rqjHGg02aKTMvnOfUuwI6g6EuPPExedrJyOwEdAoXdt/CZCqVzf
         qa60kxD/5OYfvLFBJuUoGTIEa3+NJSNwABbsDIYg+NOEQ7s9Z+ANtTl5plfQDDMc93jj
         3Z1g==
X-Gm-Message-State: AOJu0YxYXegMtEux+boBlcbpS5gjSnQ3mcBZhpT5YCkltv+l/1Hcxs/o
	cXB5SXAwoVOQyLwBmoniqcyyy6z4AXWXu5OlP8vX+5KK0iacLF4B/J9McWFWc1E3zTX5Qg==
X-Google-Smtp-Source: AGHT+IGVPx+7Fn6h2Kmc96sbuWH07igYL+IWA+ogqiWd98w5hhU54EATJ0tFD0vuB5SNKFalP+NdojpD
X-Received: from wmbay28.prod.google.com ([2002:a05:600c:1e1c:b0:442:cd39:5ca4])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:37cd:b0:43d:fa59:be38
 with SMTP id 5b1f17b1804b1-442d6ddf676mr106827995e9.32.1747077107046; Mon, 12
 May 2025 12:11:47 -0700 (PDT)
Date: Mon, 12 May 2025 21:08:42 +0200
In-Reply-To: <20250512190834.332684-23-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250512190834.332684-23-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2569; i=ardb@kernel.org;
 h=from:subject; bh=TjnRuEtXbnPmDvCBZD7Rs00effSPeHNgL50qf3H7vXI=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIUPJ3XFGUO5TgWOLZhR6aPQyhfgsDeWYxrRDy/nU3Tv3f
 PfczTjVUcrCIMbBICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACbStZ6RYXXRz6CTE/fOKpy4
 +lbv75U88hMe1S/44ls74+DqLJaLZlcZGfoVqtZwLgpNOfraaGp4oedir1TWS09489boiBtx9Xx dyAcA
X-Mailer: git-send-email 2.49.0.1045.g170613ef41-goog
Message-ID: <20250512190834.332684-30-ardb+git@google.com>
Subject: [RFT PATCH v3 07/21] x86/sev: Move MSR save/restore out of early page
 state change helper
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: linux-efi@vger.kernel.org, x86@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>, 
	Dionna Amalie Glaze <dionnaglaze@google.com>, Kevin Loughlin <kevinloughlin@google.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

The function __page_state_change() in the decompressor is very similar
to the loop in early_set_pages_state(), and they can share this code
once the MSR save/restore is moved out.

This also avoids doing the preserve/restore for each page in a longer
sequence unnecessarily.

This simplifies subsequent changes, where the APIs used by
__page_state_change() are modified for better separation between startup
code and ordinary code.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/sev.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index 70c3f4fc4349..bdedf4bd23ec 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -71,9 +71,6 @@ static void __page_state_change(unsigned long paddr, enum psc_op op)
 	if (op == SNP_PAGE_STATE_SHARED)
 		pvalidate_4k_page(paddr, paddr, false);
 
-	/* Save the current GHCB MSR value */
-	msr = sev_es_rd_ghcb_msr();
-
 	/* Issue VMGEXIT to change the page state in RMP table. */
 	sev_es_wr_ghcb_msr(GHCB_MSR_PSC_REQ_GFN(paddr >> PAGE_SHIFT, op));
 	VMGEXIT();
@@ -83,9 +80,6 @@ static void __page_state_change(unsigned long paddr, enum psc_op op)
 	if ((GHCB_RESP_CODE(val) != GHCB_MSR_PSC_RESP) || GHCB_MSR_PSC_RESP_VAL(val))
 		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_PSC);
 
-	/* Restore the GHCB MSR value */
-	sev_es_wr_ghcb_msr(msr);
-
 	/*
 	 * Now that page state is changed in the RMP table, validate it so that it is
 	 * consistent with the RMP entry.
@@ -96,18 +90,26 @@ static void __page_state_change(unsigned long paddr, enum psc_op op)
 
 void snp_set_page_private(unsigned long paddr)
 {
+	u64 msr;
+
 	if (!sev_snp_enabled())
 		return;
 
+	msr = sev_es_rd_ghcb_msr();
 	__page_state_change(paddr, SNP_PAGE_STATE_PRIVATE);
+	sev_es_wr_ghcb_msr(msr);
 }
 
 void snp_set_page_shared(unsigned long paddr)
 {
+	u64 msr;
+
 	if (!sev_snp_enabled())
 		return;
 
+	msr = sev_es_rd_ghcb_msr();
 	__page_state_change(paddr, SNP_PAGE_STATE_SHARED);
+	sev_es_wr_ghcb_msr(msr);
 }
 
 bool early_setup_ghcb(void)
@@ -132,8 +134,11 @@ bool early_setup_ghcb(void)
 
 void snp_accept_memory(phys_addr_t start, phys_addr_t end)
 {
+	u64 msr = sev_es_rd_ghcb_msr();
+
 	for (phys_addr_t pa = start; pa < end; pa += PAGE_SIZE)
 		__page_state_change(pa, SNP_PAGE_STATE_PRIVATE);
+	sev_es_wr_ghcb_msr(msr);
 }
 
 void sev_es_shutdown_ghcb(void)
-- 
2.49.0.1045.g170613ef41-goog


