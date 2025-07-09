Return-Path: <linux-efi+bounces-4208-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE85AAFE207
	for <lists+linux-efi@lfdr.de>; Wed,  9 Jul 2025 10:11:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C868168B93
	for <lists+linux-efi@lfdr.de>; Wed,  9 Jul 2025 08:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F6C523C50B;
	Wed,  9 Jul 2025 08:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bLAC5IlE"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2C823B62C
	for <linux-efi@vger.kernel.org>; Wed,  9 Jul 2025 08:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752048671; cv=none; b=cLdgytB3kdAflwG0GD0paN7bgCc83MczNGctTOrMyg01fr7eNKALANuQqS4iSmePuMXJRb040p9hznwiWma1MmTPdgjM8LIZ4vusK3L94DR+Wm2pxyRCWgtjVuAQsnxXbTaxxGb6oDC5G85SCNOvzcYyMXpvIXlYO2HraVrKmyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752048671; c=relaxed/simple;
	bh=FlsTo1Na0gqk7JnqppoQ3g3pClSByxD+GJ2YmQqbeYY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QtQFP6r1gNvTXXRXuUdsOhGakUnlRLPHraF3bo4hZFWADdTQwVEYdh9OlU62PEa7ltp4/dT2XpuESw8oveoUVuxi04WXunRMVr1AZBOnXpusGVxeJeECSzqPJHg9DAYHI4vUDAYxjpWimxjbF8i+TQO5TZLm88QEKt+AB+7APx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bLAC5IlE; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3a4eee2398bso2298961f8f.1
        for <linux-efi@vger.kernel.org>; Wed, 09 Jul 2025 01:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752048668; x=1752653468; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=irDKxIOWN/GYN8fC55Fb2miL4MwwqCl9Ulz8cQYfbDQ=;
        b=bLAC5IlELHKog+SXBybIT/vrIozHAjQj7X6TApxXKKIWIwR5ZN3iCMFC2mJEwQp6Q6
         Cyk+ajW+5H/aurSPIRWQxqHFmtcqTTOynymmSEkGwXitlYT6AXOV+dILT+TEaMrY/8fj
         KfOyycNJAfU51ocEmXeSkxpuf5Z/fQ25vPxcVjgWsNE48KRXHWP2uyD0bDevDR/Fnypl
         QaFaMB8E2pjki+HLxD3+SeDWYW9NpdEOLrcYXkPZYaQRvPlltJUB9C2KJwinCNJ3WIt5
         r3JEY2ewkc9/1CA6wGdifoSHLk6BAqH72dUJvS7KPHvqHv6e4YE49K6ymS9/ERWvoFKm
         U0aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752048668; x=1752653468;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=irDKxIOWN/GYN8fC55Fb2miL4MwwqCl9Ulz8cQYfbDQ=;
        b=PMBZbPiB2Q/4b7+eb+5hluG8u75ujVZYRnmn26kueEeAAOve7pcZx1S8ipi4vZ0wnD
         p/Dx9GZ/mOAJrMj/S2XEscJDxsnqLoTi+JLR66wUjYbW7NxKr1ZbyqaHMyjQZknczLPt
         vh4fzPKcyivmxgNDnMMEshxkDbHh1QRqJswqDfnb1cPbIz/UV1q4XkcbEIkHWAfXRXqy
         z8WudG/7bCU9+x9VuWKBQDA22Mog75/qXsrOxZfQ+dnNOZUL5rK1cAtADsKo13MKoTME
         Y0k1YNG/QCfFl+K8N1VCc/ep+zupNQgtc49ZI7bz9gZ/OZx9Ol8M0k9GTWHPY9dj3OrL
         Yg5A==
X-Gm-Message-State: AOJu0YxdzK4SlW9WJt4DbM/zqD40ksr8qOsetyVXJUExFbLRSc/ypAUH
	sQRgaex4RfCYRu5a0o+Z8rwit8oyqBjeNlMDK0FsYCqo9GTFSjPnJfdZWYPdISL9fUxKRhnGew=
	=
X-Google-Smtp-Source: AGHT+IE1AbDthtPc79Q4E0+CvLr8kELSkSM5FvPu0zAUmfA29qg7a1zdyotu1oFbfwjeOF/rM/GFqFy7
X-Received: from wrbm15.prod.google.com ([2002:adf:a3cf:0:b0:3a5:75f:1fb7])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:220d:b0:3a4:ed10:c14
 with SMTP id ffacd0b85a97d-3b5e44e94damr1081339f8f.14.1752048668183; Wed, 09
 Jul 2025 01:11:08 -0700 (PDT)
Date: Wed,  9 Jul 2025 10:08:44 +0200
In-Reply-To: <20250709080840.2233208-26-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250709080840.2233208-26-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2348; i=ardb@kernel.org;
 h=from:subject; bh=hoadtf7g9eDjkIht+Y1Um5UwMCQL5oJbisXGKydMrJs=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JISNPefZbmfcRZ8Q1E5bYqb9oSIwxqfC2qXjpLuV6wXzfg
 d0WHyo7SlkYxLgYZMUUWQRm/3238/REqVrnWbIwc1iZQIYwcHEKwERO/mf47yT97PChmISm9GOG
 cbz1uWbPH85PTU2ZYGjpe3H3d6arFxn+x64wLXoeoOy3KmFlSb7rxbitbtFNf9feuSBZ3lm/xLW QDQA=
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250709080840.2233208-29-ardb+git@google.com>
Subject: [PATCH v4 03/24] x86/sev: Use MSR protocol only for early SVSM
 PVALIDATE call
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: linux-efi@vger.kernel.org, x86@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>, 
	Dionna Amalie Glaze <dionnaglaze@google.com>, Kevin Loughlin <kevinloughlin@google.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

The early page state change API performs an SVSM call to PVALIDATE each
page when running under a SVSM, and this involves either a GHCB page
based call or a call based on the MSR protocol.

The GHCB page based variant involves VA to PA translation of the GHCB
address, and this is best avoided in the startup code, where virtual
addresses are ambiguous (1:1 or kernel virtual).

As this is the last remaining occurrence of svsm_perform_call_protocol()
in the startup code, switch to the MSR protocol exclusively in this
particular case, so that the GHCB based plumbing can be moved out of the
startup code entirely in a subsequent patch.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/sev.c     | 20 --------------------
 arch/x86/boot/startup/sev-shared.c |  4 +++-
 2 files changed, 3 insertions(+), 21 deletions(-)

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index fd1b67dfea22..b71c1ab6a282 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -50,31 +50,11 @@ u64 svsm_get_caa_pa(void)
 	return boot_svsm_caa_pa;
 }
 
-int svsm_perform_call_protocol(struct svsm_call *call);
-
 u8 snp_vmpl;
 
 /* Include code for early handlers */
 #include "../../boot/startup/sev-shared.c"
 
-int svsm_perform_call_protocol(struct svsm_call *call)
-{
-	struct ghcb *ghcb;
-	int ret;
-
-	if (boot_ghcb)
-		ghcb = boot_ghcb;
-	else
-		ghcb = NULL;
-
-	do {
-		ret = ghcb ? svsm_perform_ghcb_protocol(ghcb, call)
-			   : svsm_perform_msr_protocol(call);
-	} while (ret == -EAGAIN);
-
-	return ret;
-}
-
 static bool sev_snp_enabled(void)
 {
 	return sev_status & MSR_AMD64_SEV_SNP_ENABLED;
diff --git a/arch/x86/boot/startup/sev-shared.c b/arch/x86/boot/startup/sev-shared.c
index 992abfa50508..1bb4b522dfaa 100644
--- a/arch/x86/boot/startup/sev-shared.c
+++ b/arch/x86/boot/startup/sev-shared.c
@@ -753,7 +753,9 @@ static void __head svsm_pval_4k_page(unsigned long paddr, bool validate)
 	call.rax = SVSM_CORE_CALL(SVSM_CORE_PVALIDATE);
 	call.rcx = pc_pa;
 
-	ret = svsm_perform_call_protocol(&call);
+	do {
+		ret = svsm_perform_msr_protocol(&call);
+	} while (ret == -EAGAIN);
 	if (ret)
 		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_PVALIDATE);
 
-- 
2.50.0.727.gbf7dc18ff4-goog


