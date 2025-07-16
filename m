Return-Path: <linux-efi+bounces-4364-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ABC5BB06C2D
	for <lists+linux-efi@lfdr.de>; Wed, 16 Jul 2025 05:24:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 197AE189E3F6
	for <lists+linux-efi@lfdr.de>; Wed, 16 Jul 2025 03:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 430FB288C82;
	Wed, 16 Jul 2025 03:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KGD4YYrR"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45726278E47
	for <linux-efi@vger.kernel.org>; Wed, 16 Jul 2025 03:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752636162; cv=none; b=lN11bBO1imiVhbXjNXs3miz1OTifS4dgyI0j3hHJE9Un9t0pqTVvKEhQmoSoIDCFgsMHk5RezeBPb+ETD7gv7RGIcnnZzARCm8xeNPpYJZgkDqeO7Qs4kH61yo1oFFq5UV1D2u/Z984gD5M0qsJpYHpup2e/dksg7gz+gEPKF2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752636162; c=relaxed/simple;
	bh=P+SavC1Q4loaZ05B2JeU5aX7Yb4NSzAVm0w85qvgUIE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZbeBRJQb8YI/p4I5InjVGkf/ii2St5yehfM8IvaIHG8LYxbY35ZH/BEKbz1aCgH1VQR8zQXYoW+TwHpnsyCMl4chqSUAsnce9tuRS7wj0k4o3Ig/VZL3lcYH5lCcQsqudQhGCxPXciTvhKgrhivkGFQ+VUJpfJUDbOTC2yJnqNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KGD4YYrR; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4538f375e86so51833385e9.3
        for <linux-efi@vger.kernel.org>; Tue, 15 Jul 2025 20:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752636158; x=1753240958; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=STRKiSzXX1+CE+9MYrQYA3rHLqTvbwqnLZ3WYtaLrpw=;
        b=KGD4YYrRe+RhjINa4f8sTjMtnhp4VgSR+J2pEzFDQGLqcSB2o0wKqCBdkAlpzu0AHU
         X43VmZ2943vFQHLV64LIC1d68d6z4pmfOnC8vew6sYy2uhVjyr71BXJi3sToXAgktxiA
         8QvZJnEqe1na3dltd7iA/OyY9Pao9S+4SH3zvFs6HZM/UJ1+07ISw2oEQZcNaNQHQgtg
         iANFBTI+Ao5SRAfkkpJFIpnDAopunBmIjRRWc8Mhcsf9mwGZIBMO9A5DnxrTj9Kmdibr
         hTQykUGGH9emWttWJZHxjT5okwm7mUku9+vufIHqM4KJK/RupemCkR4kUXndalWaOR1S
         LzIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752636158; x=1753240958;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=STRKiSzXX1+CE+9MYrQYA3rHLqTvbwqnLZ3WYtaLrpw=;
        b=JsvZrzrxPVHtVN4VRa54/pXth3Cdg0DQ2e9A/Ex9hoiFTyr845iSGERtNST38Bozok
         ukFCnXLKP3BKSmeSuIVe7/kFYpIAnn7kD6hOBYUYLBiZqdkz5Zf/zdnc9Yx8LZgc3AjJ
         JjU58EArwGnTaYSFDDd7gZaGxmpJeLJR3iTk9IJqTUJeWV3Z8F+32fec6pIz9IQ62IU+
         Ftiljgvci2P9VTkaC+3TCMwUxMgm+zi1yyIBKEMzWh218FuXzC3fUr/uZGP2KXToD2fh
         /v1avaO6Kh1UTrqYsjSMhfHaZn69M+rTrUJ0kkjMBZOpNfWyQ4ky/XzlV/17V1qEgVSe
         043A==
X-Gm-Message-State: AOJu0YykXZ0FdE54W+Sn+14sEt+MF99JaLPnsKWYuBgZhmWzSp0+ps0Q
	VELKT+zAQVm/Jd5I/7IhlZ/TFuyujJcVl4+XWur9EOUO9OW4Frf108REbcA2Bov5LwNwULjtXQ=
	=
X-Google-Smtp-Source: AGHT+IFPtHqFsyPB7SnHo472sOiQwDH0pE144RfQ4GvbZtbdPdxGjdDEtCZ71M3K619iO+uMevP/SLF9
X-Received: from wmtk5.prod.google.com ([2002:a05:600c:c4a5:b0:456:d19:9bcb])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:1ca9:b0:450:b240:aaab
 with SMTP id 5b1f17b1804b1-4562e044fd0mr9185345e9.8.1752636158484; Tue, 15
 Jul 2025 20:22:38 -0700 (PDT)
Date: Wed, 16 Jul 2025 05:18:25 +0200
In-Reply-To: <20250716031814.2096113-24-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250716031814.2096113-24-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2029; i=ardb@kernel.org;
 h=from:subject; bh=G4tJuVGhrB+QDvBjEiKr0P/IsteAttDK9B09Q2K0XSU=;
 b=kA0DAAoWMG4JVi59LVwByyZiAGh3GjCg/nam2Ohsxh3Tt6drdPM2tZgpWjGEl6V6qivK94zT3
 Ih1BAAWCgAdFiEEEJv97rnLkRp9Q5odMG4JVi59LVwFAmh3GjAACgkQMG4JVi59LVyHoAEA6iK5
 UO/aCvOhfd9kAeE02HOQzJgQZDBAZCiVfYviihgA/Rz/7V1bSNvHBkDwxzr2+effXbJmef11q4I NJ5syU7sE
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250716031814.2096113-34-ardb+git@google.com>
Subject: [PATCH v5 10/22] x86/boot: Drop redundant RMPADJUST in SEV SVSM
 presence check
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: linux-efi@vger.kernel.org, x86@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>, 
	Kevin Loughlin <kevinloughlin@google.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Nikunj A Dadhania <nikunj@amd.com>
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
index 4bdf5595ed96..d62722dd2de1 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -392,30 +392,16 @@ void sev_enable(struct boot_params *bp)
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
2.50.0.727.gbf7dc18ff4-goog


