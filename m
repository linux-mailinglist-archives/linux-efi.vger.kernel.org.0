Return-Path: <linux-efi+bounces-4446-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ED2CB0D33E
	for <lists+linux-efi@lfdr.de>; Tue, 22 Jul 2025 09:36:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CD6A3B1A7E
	for <lists+linux-efi@lfdr.de>; Tue, 22 Jul 2025 07:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5D402DE6EF;
	Tue, 22 Jul 2025 07:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4OUR1yOh"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967B12DC321
	for <linux-efi@vger.kernel.org>; Tue, 22 Jul 2025 07:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753169403; cv=none; b=srqKoJsQ/vhVih8DFrczFppZtJliy0OHxWMFeU2VtCLhI7T71jpNEXVN6vqFBvmdZ0I4cjDXrjpmakP1RvUEr4G5UmgqDfXhYs786W7VoZctHHqVRIP5j37+fWH0O+N4HBbKLyF8CeO0rn+7ZxFcjDBsqKD1UGRbch0Xyh13JOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753169403; c=relaxed/simple;
	bh=P+SavC1Q4loaZ05B2JeU5aX7Yb4NSzAVm0w85qvgUIE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UIEMo/t4bdPXgK68+7S2YS9z6bMz52MhXMEC/S0JCxzTJ/6bMR8oqObZq0rucbwfQKjGU0OVApk30VhW0KzYXSQ4GgHNhByLbliAjIxP6Q9eLAN2kWPevgnQAuHOjN1qqvGbXWGrZP0KjNRpsFVodWebQsK034CuDUp8FDh3gQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4OUR1yOh; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-3a4f7f1b932so3449488f8f.2
        for <linux-efi@vger.kernel.org>; Tue, 22 Jul 2025 00:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753169400; x=1753774200; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=STRKiSzXX1+CE+9MYrQYA3rHLqTvbwqnLZ3WYtaLrpw=;
        b=4OUR1yOh3/wD3XSreFRbdSaDyvChojjHCb311ZXilj3/qqLBupRicDL3EhEiyGcbDg
         4gTIQY1f1MlmrzxBWAk+qECYjazLzaJiV6qqjA6MtIcMowIqWFXediYrCNvmSTvOPnC4
         nHa5on2sP08+sI0ghmomzL6mBtBS1pe7UuX+Z4zRu+SB1bzUD1+7AJjaWoclIBo/EM1U
         118OoMmWO9cTqZIe70s/NO++D204x5vDZ1RgAwJbBKmMDpLPn5FKeV2irZ5DJe/+oWV9
         9eXcaG4JTV6ErVUX8txrcqv5EPLuaBmD45M9cwBJESYzeQ4+0Z7v/aJ3mwM8ZzpbnFmt
         NPSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753169400; x=1753774200;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=STRKiSzXX1+CE+9MYrQYA3rHLqTvbwqnLZ3WYtaLrpw=;
        b=xOXDdvnb97b7KfJxyMahO93enjlJf1n+USBTpSGB7cRwhs9B5VJGf03Vt7VoZ5/Yr5
         55pWdxn48guu7Da6A228kK/f+HMAru8IOqeQI9q5Sv8XZwXqEPzSBLFTTpd2QrOjDoJZ
         41lNZ2FKhE2Fzhtd4DZd0dl/5iE4IbHDp+L5AXmvdgJdRL9nKJHPVSiycY/UGVJPbpLI
         7d1avzF+7QcQja7HXophidugUptZ1AcwZhczEwMN4tnEp5nPvjE06ufo20SoJyCf2ftu
         OU0xGZzZJn2JOhksJ7Jdpqgm2dt9B1z4srsE0WsBrwc+mIJfSYzo91a8qhpZxns0pjS8
         7Srg==
X-Gm-Message-State: AOJu0Yye4MB/N3/Db/rShBiwbfSbyypZHCnW2DP9h0zFgTBPRvKrTY4+
	b9L1D8eILQ+9B+7319eYKsFkqXdev8IpIv6w2ben9O7EWQ7hVRx7xqhljoUAwNRJhTK8KYQOMg=
	=
X-Google-Smtp-Source: AGHT+IGjz6zhqXhqlc8/UMaZoyjJAPocp5Myl5vQjjn+usgxw8N6Vu5vkkJMW2RGVHNzNJPvtrKIkNgw
X-Received: from wrwa2.prod.google.com ([2002:a5d:53c2:0:b0:3a5:7de1:2a54])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:460b:b0:3a5:21c8:af31
 with SMTP id ffacd0b85a97d-3b60e4c237emr16602272f8f.16.1753169399893; Tue, 22
 Jul 2025 00:29:59 -0700 (PDT)
Date: Tue, 22 Jul 2025 09:27:19 +0200
In-Reply-To: <20250722072708.2079165-24-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250722072708.2079165-24-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2029; i=ardb@kernel.org;
 h=from:subject; bh=G4tJuVGhrB+QDvBjEiKr0P/IsteAttDK9B09Q2K0XSU=;
 b=kA0DAAoWMG4JVi59LVwByyZiAGh/PX+g/nam2Ohsxh3Tt6drdPM2tZgpWjGEl6V6qivK94zT3
 Ih1BAAWCgAdFiEEEJv97rnLkRp9Q5odMG4JVi59LVwFAmh/PX8ACgkQMG4JVi59LVywNAD/fiT/
 WKYz9vWu3ZIIQeaOQ1//uhmkD9Mpfe0o6UvTuRoBAJ5MGLCyLPw+XvuhmhT0hySKPIRJvMRkiKS XdbYejOAG
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250722072708.2079165-34-ardb+git@google.com>
Subject: [PATCH v6 10/22] x86/boot: Drop redundant RMPADJUST in SEV SVSM
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


