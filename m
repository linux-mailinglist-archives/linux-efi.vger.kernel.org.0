Return-Path: <linux-efi+bounces-4635-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8E91B399B4
	for <lists+linux-efi@lfdr.de>; Thu, 28 Aug 2025 12:26:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C46E7BB6CC
	for <lists+linux-efi@lfdr.de>; Thu, 28 Aug 2025 10:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1CC030DEC0;
	Thu, 28 Aug 2025 10:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xlzlPU67"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F6CD30BB80
	for <linux-efi@vger.kernel.org>; Thu, 28 Aug 2025 10:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756376569; cv=none; b=oQbX6pLnstTIDbV6vkBdjpugql5oA2mLfPgfCTzrSb892Qsj+bPbOwuVpVbEJmY1c5s+pyq5ndvB6aOCziWh8gdcbAIVUgL+gs5dmFGymfPAWNe9LdBZeFJKCMB1bTFo2AfWGxebeFQsmkUyPkaOZfn62vRBitwiInNZ0S4WyOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756376569; c=relaxed/simple;
	bh=OLU5QcbyyNINYElAKiJwayIsMLpwXtfz6ndB7XVk9/4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PGEuh+TdW/dMxJl6rpV7XoVIDOhYfDYeRtorkkpAqObL9QzERGhA3j9s4Jvs2NtVaAWu+LGMlJEqoQI4fMPSKK4tux7sYKo9JcG32OTg/h2hv7xG92ph1j95zaWB8QoXzVYtXOexWfpANE8McEapu1nPKfKgm4+8yk/R+rsb7yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xlzlPU67; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3cba0146f7aso376233f8f.3
        for <linux-efi@vger.kernel.org>; Thu, 28 Aug 2025 03:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756376566; x=1756981366; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=L4ke4XWWJRSjh2bYfLQGWCSa7ibZe++P2mcK281T5xw=;
        b=xlzlPU67fI8N82Cz+EQ34XM1rZBi0PvBonNE7tH9iuRYdzN8+l/WsgWw51ZszLz/1R
         90///DohZ2ejMFV2/Z7m4MHm921QVMkWA2rIJUigPRCL44qEgiLkH9KqxVrNMUn5uC+A
         m+H4yYidaDvkGbX/20hlexAMhAzjOSSAHCHKxCgn2w8LqgYWvygqLW14+NBw0HeDly+w
         kUPKm9sVXxefe2h4lgIdB7aNo7T4DldBVD2lu+Ax05RvqHhp+4QJRzcms7bQuwemd9DO
         HDuANYxPowwvxmhJ4+JDcjm0dPE3XFurpAri+7xNsnDsjuXg/BihiZo8zif7klxto9rL
         9SZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756376566; x=1756981366;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L4ke4XWWJRSjh2bYfLQGWCSa7ibZe++P2mcK281T5xw=;
        b=QJ1KBq5Vnd48q+15tgumucBX5He0Gs1sROlBpeFvKnw7NLBxY9j3SaYs5ryX43M/Pr
         FHAkgthm8zRzKGzw5VLourq4d68Mpnsraw1HK9j4HkTuyyLXHHY7nkQrzNKBmMMqQ5oU
         MbTKt1SjGWtzauKHd0ZWGjXSZEbZ+Xscb18Wt5ByLcSUtMiX+Eo967lfTzA5SIdLZU+k
         UQzxQDwcoBeZWsMuz/RaY82sIeZr1Vws0ihwxFTQA7NSOacijUScm0af4QfER/ROME8C
         14uSI5PPO4Gv8wFYRWExViS9ToQt4wcUXj0dNP4FNc8wgq2Mx2JuKAU/BMMDRjoZgMf3
         ENdg==
X-Gm-Message-State: AOJu0YzYyHrXIBEbHTD7Xjy9Dc20AgYVezS02fUbzRw9WiyODV1DGEfl
	IhoRPXuzU+kAKK9jl9QnXtYLZM/Mx7KG6RlozTVGu4DIgs7/3YZNfOmRJG9u8EzXy52bKQRWqA=
	=
X-Google-Smtp-Source: AGHT+IEErDdrpoDOnJGXWeVgfX/xMF9TWYEvvktoGqnlAr5ACLDelnBYJhmTLS01WM4ffzgxGgkvWsZG
X-Received: from wrbee12.prod.google.com ([2002:a05:6000:210c:b0:3cd:3377:ba8f])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:200e:b0:3c8:5b40:deb0
 with SMTP id ffacd0b85a97d-3c85b40e862mr10214800f8f.7.1756376566328; Thu, 28
 Aug 2025 03:22:46 -0700 (PDT)
Date: Thu, 28 Aug 2025 12:22:13 +0200
In-Reply-To: <20250828102202.1849035-24-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250828102202.1849035-24-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2029; i=ardb@kernel.org;
 h=from:subject; bh=z5/KQ3GBPkmGwtg267k/7sBxf/zNQ61LbpifmGbtIgM=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIWOD7jWbjWw3ahvcdu4OVZ6xNo6fo8V+8t53uwxeL1y9w
 YXf60laRykLgxgXg6yYIovA7L/vdp6eKFXrPEsWZg4rE8gQBi5OAZgI30dGhst57stlgi0iHC/G
 PGK52nyyYJH/gg17uL66m4rcvzj1/gaGf6prb/1zE/wpHCzAV6+wOr510Qd/ecGzKzVMXUt2rZE V4QMA
X-Mailer: git-send-email 2.51.0.268.g9569e192d0-goog
Message-ID: <20250828102202.1849035-34-ardb+git@google.com>
Subject: [PATCH v7 10/22] x86/boot: Drop redundant RMPADJUST in SEV SVSM
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
index de73da526577..d650a314143b 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -404,30 +404,16 @@ void sev_enable(struct boot_params *bp)
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
2.51.0.268.g9569e192d0-goog


