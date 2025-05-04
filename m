Return-Path: <linux-efi+bounces-3562-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CA57AA85B1
	for <lists+linux-efi@lfdr.de>; Sun,  4 May 2025 11:55:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76A6D3BC1A2
	for <lists+linux-efi@lfdr.de>; Sun,  4 May 2025 09:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AABA71A2C25;
	Sun,  4 May 2025 09:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2Nt1fAkw"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4EAD1C863D
	for <linux-efi@vger.kernel.org>; Sun,  4 May 2025 09:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746352410; cv=none; b=ZmQr11kJX+lwazDL4eBDEihMofwUNllbjSuwTYj9tGlGSWapA0lFaIiLys5YjppP5LJgmZVABoXN2GYewmk95JjTL8fOc+pX/Jd9DXJ41vvpgJZHxWQS7Z5LGcDWgJTOGYvEqHVvjsiYGl2n47Obp3OribyiTmffr/4EC959iVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746352410; c=relaxed/simple;
	bh=+Z8FJSCGbwwgj1awTIcuTLRAEXnP5VkhJvt9KubUTbs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=g9Gmnv5dvescas12QMuSF3ZD2xwcyPguCwMjrX1a7u51mLSTfYUWIJG15I4HO/u1YZvUWiDsvDtkSbSp+qQjuOjHM6ShqA+rIMZQizM68VxNnQrV5WdbAnR1XzcTBpi8pD2YVRyb8p439kmAtMttiLFXK8yP3oP79sPrnAq+rAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2Nt1fAkw; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-39135d31ca4so1325524f8f.1
        for <linux-efi@vger.kernel.org>; Sun, 04 May 2025 02:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746352407; x=1746957207; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3lTLYqTHmduCIUn2kSdkAOOr4P+q4Sd3ebjwsj9/7+o=;
        b=2Nt1fAkwLotd/TygoNrhN9CYIAZ9gAuAOMNt7CzRNvZrijR/OldO1YCxbO9lpGXcnn
         1OPQOTuHiWnUa/YKolhz0tj6jByimdOVVPJ3gDPAJKaj9v96kuTnC90JkhUCwcSyLnUz
         A6EUkVgpseorWlB8+96W3FEochud3u36+4lBlXy+P3QLucsDoZYA4yrt2qBjoYChRbZ3
         4Z/f2zDaiIVz8KZjl5pTZeSrYhEGVKvlQd/+4fyDwSYg6viDCeyxueoijQyRK6gWdB6C
         ZPbLT0qbln9/QuAf5Pu+uCvRVKH7cK/t9aQTZWjZdx/26o/jkCXRzAuz7MbVwbr35oUZ
         5O9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746352407; x=1746957207;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3lTLYqTHmduCIUn2kSdkAOOr4P+q4Sd3ebjwsj9/7+o=;
        b=Q/BfOzitM1k4+3v0xtGS2Lv5+xoka/7SdLjz7oppepn2AtzU3pziBksadfl/gmNw9X
         vQ7DAEX0+DOfVIzDNp5PBcVv7zxBKMncSDPAvWFl8TK92OSXIG06b6rseW6v9MQezcgZ
         y3XW5aijt7MvWqvrnr3Hqjv6XIca1yTVp+dAmmWU/tDq3zkgNyf/N3mcgT9xkZlNMEzz
         rZYxFys55Kc/bNPiv8psWu5Zl/t3YFcko8le9gd2hMrE3e8DMowIMwKeR1oZLYknWPUI
         qEk4ERy4bDAlXtBAAuFBeD2i0Vr+5ONL/Xr7Io3D7Wex0uGZUPcfM8yaPD50JO9pLuT3
         45vg==
X-Gm-Message-State: AOJu0YzP1k4rHtfrU+yA21TXqka5T0Yl6nyJ90auUZRHmRwkT1XugNDA
	bIJ3FgJAh23WiWF8gBQIuBPbSK3WSIJnIsUbJHbENT07rkmILOOswaGzo57xsV5087t4aA==
X-Google-Smtp-Source: AGHT+IFJ8HW78R93DSDeWNBG9slWAdIJ5rmrSaYG1wr1R/vQNOIhV5y3ZcE3vwvhBOseCVNt759f3z8K
X-Received: from wmbel14.prod.google.com ([2002:a05:600c:3e0e:b0:440:5f8a:667c])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:240c:b0:3a0:8a19:db31
 with SMTP id ffacd0b85a97d-3a094034de9mr10207309f8f.9.1746352407154; Sun, 04
 May 2025 02:53:27 -0700 (PDT)
Date: Sun,  4 May 2025 11:52:41 +0200
In-Reply-To: <20250504095230.2932860-25-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250504095230.2932860-25-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2029; i=ardb@kernel.org;
 h=from:subject; bh=xt5xyfXf/gi2XPcOGjFts1TusoE6wHjvuVonSZNWdN4=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIUPc4u3Kl/0b1vi2eN46zx2nanNmi+LnTQLLDft/pb32m
 ii3zG1bRykLgxgHg6yYIovA7L/vdp6eKFXrPEsWZg4rE8gQBi5OAZjIIm1Ghg9G13Vf7Pr248Bu
 86bQz6t/5jILP0q/PktS9F5j2KEX6tcYGXrkBAqtJzKqds7ZsL5z56OnqYLV8zb5L3F9o9J+SqO jlwMA
X-Mailer: git-send-email 2.49.0.906.g1f30a19c02-goog
Message-ID: <20250504095230.2932860-36-ardb+git@google.com>
Subject: [RFT PATCH v2 11/23] x86/boot: Drop redundant RMPADJUST in SEV SVSM
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
index 91e8140250f6..18ba81c0b0ed 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -420,30 +420,16 @@ void sev_enable(struct boot_params *bp)
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
2.49.0.906.g1f30a19c02-goog


