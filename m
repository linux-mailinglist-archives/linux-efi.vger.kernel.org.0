Return-Path: <linux-efi+bounces-3666-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 50D03AB449C
	for <lists+linux-efi@lfdr.de>; Mon, 12 May 2025 21:14:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BF42188E204
	for <lists+linux-efi@lfdr.de>; Mon, 12 May 2025 19:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E6D5299AAF;
	Mon, 12 May 2025 19:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PRsqtBFr"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6276A299A9C
	for <linux-efi@vger.kernel.org>; Mon, 12 May 2025 19:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747077118; cv=none; b=s/taVS17ukhDQmG4Nnc525WWofUzAMMMOindGugj1sn0bdpmkJXS9zyRSSdtfb1uNYo4byUXDfpL4JSRWDdaxiOHS5hElBjvN3cmKMJJiC6VF3chPy68SXJJZp/zJ51KwNst81KE8kjHBn4JDq0uD53QT9AwkbqbAB8uCAao7dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747077118; c=relaxed/simple;
	bh=aDKXddBmfA7RTqjn2IVQf1JJqM5fseVSyiUbPLA7/2U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Gjy6tz3zgjaftnwPIW4G2L0Ic1nsIiu2qAY3945TPZrLk0gGz+vVgBJIQexgg6bKKyT2zYevHgxfoUR7kaF3WadQ04l4vi4UaHstSWscvbnGfpZP3w1FQOslgViYN3LPcUYPOVN6e6lkhQ0f2YLO/QkqHexpcYuc1w156Mvxmas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PRsqtBFr; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-441c122fa56so19034895e9.2
        for <linux-efi@vger.kernel.org>; Mon, 12 May 2025 12:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747077115; x=1747681915; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IkqYSPwglKGsOQATio9iDSPAoMiQZFICU2YOedJQt4I=;
        b=PRsqtBFr8bJruAHNjFNqofk3z33T7WwZh2f1xG+mBpHnLw+DfBgKxc6NIVMI+1aH1e
         jtJYCcfAgepFhoJQb9ebz8qV4pCvFnYH9tvlKhG/o5vd4Amrl/3cmdmjMsIoAnZN3xGe
         1+F11CfWNYWRPFHmm35kL8H+5ADNrkYZjZsDn782LQYhpyM7jqk9YjUUBWZ77e7gzpGj
         vsSlGfhUEvqLXgs6O7z+2MMBh7iFkYvImrsrS0HdfaWF3Agt4nsipGux2ydAQzSOvWpM
         sBrqzZKQtBn4Me9H/E9qriScdG0tj+tYig1sWfBAkMAoQJC/E7R9NlhkEzIsfFHzPhpq
         oCjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747077115; x=1747681915;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IkqYSPwglKGsOQATio9iDSPAoMiQZFICU2YOedJQt4I=;
        b=gFKe5pEkZ1vaVpW4beEqIqRCF7nFVx5fCTNgMPYrdRpdxSQOGAf8cGYMwSzY2zMYaC
         g8EokRHxIYMnRSjJaxPnzywEEzQ6pGTIHDgbaRoPvJw/r1+sQEGC9EF6+sg0JuADGWjU
         bjkyw3hF2jh8l8TBwE3S08/OF1rqEx2Dp+JM9Wl4pym8GYghZpxIx3jZh/oHHjMxuFwe
         yGFQYZP8Yy4hErKNzr2qFkUll4CRGVpuJVU/1uNCaN8PXyv3MG3RA0/r4Lrnd4FmkXZ8
         8cQAUGeQIvAmQzqX5BdUj8XAoO/QYAvbFW4Y3bhxAg3dNEA9aCBLYVaOyiQ3ng9kFPC+
         xUnw==
X-Gm-Message-State: AOJu0YzMcXfYqjsh8BNA/5b0ygdtS0a16OLz8JtsqYd8Lk1cgiMi7T4E
	Sbk/1rfmzZebCnbMEZnf9VX2qeRoOOYARhBMNPByJVnL59vYemtxcOjaRy6r/N/5/BEyNg==
X-Google-Smtp-Source: AGHT+IEaaHhwrXfd/Wzouxv8CS+dY6uNWRlhAgaStz1xy0fKpo+oVpgJ/U/jRB1OuOMvYFuzaKBDVsRR
X-Received: from wmbej13.prod.google.com ([2002:a05:600c:3e8d:b0:43d:1f28:b8bf])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:348e:b0:43d:79:ae1b
 with SMTP id 5b1f17b1804b1-442d6d3db06mr128986795e9.14.1747077115165; Mon, 12
 May 2025 12:11:55 -0700 (PDT)
Date: Mon, 12 May 2025 21:08:46 +0200
In-Reply-To: <20250512190834.332684-23-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250512190834.332684-23-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2030; i=ardb@kernel.org;
 h=from:subject; bh=qYeNzewJfU+/ilrF/EECZk7hASJcT/OB77Eaj+puqno=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIUPJ3bO89LCQuM93j1JZ379X39WqK134fljETN2vQvegX
 5js5HUdpSwMYhwMsmKKLAKz/77beXqiVK3zLFmYOaxMIEMYuDgFYCJLjzP8D867JiCx7F79VzXN
 rZ9embRJJ8SVX9j3SmGO5XflsL5GIUaGDi4/g8i6fRu7X99UnneS623eoQs9k59tT/o467Ti7ax IbgA=
X-Mailer: git-send-email 2.49.0.1045.g170613ef41-goog
Message-ID: <20250512190834.332684-34-ardb+git@google.com>
Subject: [RFT PATCH v3 11/21] x86/boot: Drop redundant RMPADJUST in SEV SVSM
 presence check
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: linux-efi@vger.kernel.org, x86@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>, 
	Dionna Amalie Glaze <dionnaglaze@google.com>, Kevin Loughlin <kevinloughlin@google.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

snp_vmpl will be assigned a non-zero value when executing at a VMPL
other than 0, and this is inferred from a call to RMPADJUST, which only
works when running at VMPL0.

This means that testing snp_vmpl is sufficient, and there is no need to
perform the same check again.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/sev.c | 20 +++-----------------
 1 file changed, 3 insertions(+), 17 deletions(-)

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index fc0119bdc878..68fc3d179bbe 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -403,30 +403,16 @@ void sev_enable(struct boot_params *bp)
 	 */
 	if (sev_status & MSR_AMD64_SEV_SNP_ENABLED) {
 		u64 hv_features;
-		int ret;
 
 		hv_features = get_hv_features();
 		if (!(hv_features & GHCB_HV_FT_SNP))
 			sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SNP_UNSUPPORTED);
 
 		/*
-		 * Enforce running at VMPL0 or with an SVSM.
-		 *
-		 * Use RMPADJUST (see the rmpadjust() function for a description of
-		 * what the instruction does) to update the VMPL1 permissions of a
-		 * page. If the guest is running at VMPL0, this will succeed. If the
-		 * guest is running at any other VMPL, this will fail. Linux SNP guests
-		 * only ever run at a single VMPL level so permission mask changes of a
-		 * lesser-privileged VMPL are a don't-care.
+		 * Running at VMPL0 is required unless an SVSM is present and
+		 * the hypervisor supports the required SVSM GHCB events.
 		 */
-		ret = rmpadjust((unsigned long)&boot_ghcb_page, RMP_PG_SIZE_4K, 1);
-
-		/*
-		 * Running at VMPL0 is not required if an SVSM is present and the hypervisor
-		 * supports the required SVSM GHCB events.
-		 */
-		if (ret &&
-		    !(snp_vmpl && (hv_features & GHCB_HV_FT_SNP_MULTI_VMPL)))
+		if (snp_vmpl > 0 && !(hv_features & GHCB_HV_FT_SNP_MULTI_VMPL))
 			sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_NOT_VMPL0);
 	}
 
-- 
2.49.0.1045.g170613ef41-goog


