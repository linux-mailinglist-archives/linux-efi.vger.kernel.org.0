Return-Path: <linux-efi+bounces-3348-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F0BA90979
	for <lists+linux-efi@lfdr.de>; Wed, 16 Apr 2025 18:58:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A90B2447A10
	for <lists+linux-efi@lfdr.de>; Wed, 16 Apr 2025 16:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B147D2135B7;
	Wed, 16 Apr 2025 16:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bhVv7x/C"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA55E2153CB
	for <linux-efi@vger.kernel.org>; Wed, 16 Apr 2025 16:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744822687; cv=none; b=SIjWLLKjFWuDgvtN6lzi7qkm16MSvmScLumY33G1ut2EfpuQLL1yIa2801bPPbkr6Vqbwjv/QfOQXSuLzauCO3IIir61A0Q4cPUaV1DLjkH70ogdU9gbbF4xnx0b0ph9KoTLxC638bNot2NdiVY7N1lKIPZOtuYOtMx0uUIJYEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744822687; c=relaxed/simple;
	bh=lRe9hLNbP/OaX7MwertBxcNmClmRysFfc7d6hRijpLE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZzvrKuQ1qFvAcIVrzJ+74vNKbhszB8Sbb+yo14LJG+RM/minsHh0Bm431I3DccCUIkimn07+fs21zjf/8QyVz9QL7VRBjGs/mc40VQtJJhhTUYJHD6gegC5END1NPzYrIvuve5GJAqCIkdBtAnoxSWa7KRd93w46vhJHePsUu+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bhVv7x/C; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3912d5f6689so3910387f8f.1
        for <linux-efi@vger.kernel.org>; Wed, 16 Apr 2025 09:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744822684; x=1745427484; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tTCjlI4jRJCYXW8u75vTgWDWUcDqLf34EMngrdWGbjQ=;
        b=bhVv7x/CKWnip8gzLTXFXVbMDBHkBKO+3wvFYzFi9uM7cEyLO7pzPo71Ys6Dff28OG
         flXBbV6lKJ9puiotuxVpBaW+d0oIknxoqFN0fuJydB97FxYwlGsl1S6gKwy5Llggmpdf
         p6GKI4/wcBBOvWpZa8yx6X6S/G6ADpHoHE96pEH2A/0WrkBVlO3YdjYbMSq+UHpeTu8v
         FBS3XAGHcAVTc9yI7cMByemb/U9OUblELetW16LCm6gZOIuaIdfeRiyCTM6WHi1d9jsP
         phHpRXSN9/7Y8O1kAqnXMSg39ocGwv/mpFS/ETjco7UDcIm++nO47vxZ36WRQOmWzLSP
         L0Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744822684; x=1745427484;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tTCjlI4jRJCYXW8u75vTgWDWUcDqLf34EMngrdWGbjQ=;
        b=MZlSRP+yQGvQjP4wB+IhuF1emWPJFyzxb7TwxkFTBlidBcbA9ytnU4NPcuB0wVAVbt
         h+lCraxy5KyEcwGudP9jXXwDcJlsUaGPczoeR0aT2WKbnNXP7EeIQ6F/If4xtoTstEt5
         PLqphD3RZHpwraqSpEq2JVSiBlhTve6r+8NVhFBOQgMmm0xsmUjpamZ0b1dFbA9MWp23
         sbLz4H3r7WrhFQekGQKabJAbbO3EfW84gruU45ujcS1/SmuRXI/nOfe0WshphiSUUusz
         vCYYJLJt8wqfC79AWgDyFcLsrETPovXQoesNk1IdPhgbvFCs/uduqNmcH7VCfJI0c8BG
         JQOg==
X-Gm-Message-State: AOJu0Yx5HZpkeiqGdV759tCmoOLrjx1H+bCFT3979Y75Ss7faukXDthj
	N47r5JD41OM+/xAjgTWyMTFyzzA5WtaZ3ATXZej++TLprWMuiaj972De6KJ/dyu6K2JJa/G4i+q
	YaREOkAc6jR8Mg9jZz7u/ZKZnnOq16KM7Yea1S/TFftpa+j/TpS8BY+f7SsNIPwtgKjZVxPPq1G
	sndcOZvHoRcBh+6JSOt2lLZph9Vg==
X-Google-Smtp-Source: AGHT+IFjJecSiikc6rQEhoneDuSkFJVjN+/qGiEBByEyYjO0q6UyVDW7J9WRNaZ2JfT+PQvbqLm0Nn/D
X-Received: from wmqd11.prod.google.com ([2002:a05:600c:34cb:b0:43d:58c9:bb51])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:4308:b0:391:45e9:face
 with SMTP id ffacd0b85a97d-39ee5bafdf9mr2248386f8f.54.1744822684335; Wed, 16
 Apr 2025 09:58:04 -0700 (PDT)
Date: Wed, 16 Apr 2025 18:57:46 +0200
In-Reply-To: <20250416165743.4080995-6-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250416165743.4080995-6-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2029; i=ardb@kernel.org;
 h=from:subject; bh=10Qa3f8wkjUVpqoovejQoxb1J4k9EmK+vNsm5yY59B0=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIf3/w66LT23T1O/2bvrhs2baJ5v3zy792NWsNPVOYMiss
 EU3/TPCOkpZGMQ4GGTFFFkEZv99t/P0RKla51myMHNYmUCGMHBxCsBE5PQZGd6nL8+J2Hy3tj3D
 bPL2xxKn7T54+YdKrZmrZc95k3tbvx4jw8atcg277qvr7nvT8fb7DlYp54xtVVarzBg85B1O1LU 9ZQQA
X-Mailer: git-send-email 2.49.0.777.g153de2bbd5-goog
Message-ID: <20250416165743.4080995-8-ardb+git@google.com>
Subject: [PATCH v2 2/4] x86/boot: Drop redundant RMPADJUST in SEV SVSM
 presence check
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, mingo@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Borislav Petkov <bp@alien8.de>, Dionna Amalie Glaze <dionnaglaze@google.com>, 
	Kevin Loughlin <kevinloughlin@google.com>
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
index 6eadd790f4e5..26ba997c45fa 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -617,30 +617,16 @@ void sev_enable(struct boot_params *bp)
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
2.49.0.805.g082f7c87e0-goog


