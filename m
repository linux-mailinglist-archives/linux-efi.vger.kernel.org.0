Return-Path: <linux-efi+bounces-4628-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0308B39993
	for <lists+linux-efi@lfdr.de>; Thu, 28 Aug 2025 12:23:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79FBB368401
	for <lists+linux-efi@lfdr.de>; Thu, 28 Aug 2025 10:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8DAD30BBBF;
	Thu, 28 Aug 2025 10:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tOXsvV7Q"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A953830BB82
	for <linux-efi@vger.kernel.org>; Thu, 28 Aug 2025 10:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756376561; cv=none; b=XCkkcge8bnRXznC8Zrv4U2u6RNHVpYsj4oUmSXnGMdnndb4plg6+SMdBfS1P8A/lh4ZyBZh755JFOLHJeDR2Z5PVg02Bz3/HAOxu+vHEJYsd1yXWIVJ8fYrIIXwxiPLaswZsYMqgeWMaWwcEHRe9viFDP8EaicykoXxFGfNoyug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756376561; c=relaxed/simple;
	bh=Wupn8/+jH4ehbUGTnycniS0JbTKV7i2I/hx50kmtTmg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gSSsQTBf7zYDqqI6gEglh/1XOego9TCk7bXRm9PpmOBbn70ZVht1rRHLUsatfaYAdj+Be7WmwdypyP8GO4E4fheiX8uR6/c+VfPGzC2rnhuXG7LXeocgP3uMyIm6g8w9K957fFiS0Wik764Fx2XbFMVb/vFtInaYwlOUz8jWL4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tOXsvV7Q; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-45b645707f1so3404085e9.0
        for <linux-efi@vger.kernel.org>; Thu, 28 Aug 2025 03:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756376558; x=1756981358; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XHA7B2dxRx1gFNHgqhk1zivIqtg1FKdAaUdN5SpURY8=;
        b=tOXsvV7Q/jr29zAXGGlJZReVROr3RNW1R2B+buAe54yDzKfrdcb/UdYXABK/LFNM0D
         ez8ptIleJY9pa1GCFOhbWcUkIfSUW+7wCXKYyxoiB82TNQfQ6E/plZLOm3LS67FoOx6a
         5KowlvN0SfTl55+IK4WQ6IZNq4A5NCaAIRGhV8w5hBV8v9s+r1gM63REf/ZvIC+FvY3w
         zIcgx4agCsjNdqN9R3xSJqecX28H13YJkp8I58LuIf9kqrdMFDKcC5dUNtu2o1tCDPjm
         I6BMhvwlwliVQfMKk4JR+LiQ1MmQikQohZBQ0CRHrRWx11c1FEMqaZkmfk/v1NNipm7M
         Z+jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756376558; x=1756981358;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XHA7B2dxRx1gFNHgqhk1zivIqtg1FKdAaUdN5SpURY8=;
        b=uTRWDBRZ7UHGvxzDokozFpMLYjGtlWsXvsaWauroKjdEu1lCjUi9X0QkNjVbzcDzN2
         6Nztvxie7iJ1ySe6i3FviMiqZrTL6L1uu4bwEJgY+bMWLtx8TOOkckNhYS7+PB25tqBP
         Z+beur2oK6Z2dWPXtEVqhYwjDCZDnoCAWiB7Zp8jMsU44tT/amc0PTb11uZc4SC669Hd
         Jva1O/b1Eaqs7T8crsg6Ds+odYeBaXKqAsk4X+vPWkGDciBOmsjA7iZ645nq6RpHiy2A
         lu72z3vkacY0jRYIdFGVeKiXSea/x+hofgjtRkFsf8VrCNUFuCqjInrIjSCaMs9pMOnn
         qlbQ==
X-Gm-Message-State: AOJu0YzKgmHCGwjw3u0O6UoCpP/yq9kRSn1ytdEDfgVhHkFmBlcO/5uZ
	I8pj6NWsxYrsrN0gxe1rPV637PS4Ldxw0kzpa63mL8pWyeBZA1U1WPnvv5ylTjq8gqrQ37p3eQ=
	=
X-Google-Smtp-Source: AGHT+IEk3hBf93LRYqSHeKwyXZ4JBY2S2O4NXvMQfmCXYG7fatoBNKva0DHLZa0NRAGk6sSpdmCjV3lo
X-Received: from wmbhj23.prod.google.com ([2002:a05:600c:5297:b0:458:c02c:3ccd])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:2ad3:b0:45b:79fd:cb45
 with SMTP id 5b1f17b1804b1-45b79fdcc32mr11826105e9.29.1756376557923; Thu, 28
 Aug 2025 03:22:37 -0700 (PDT)
Date: Thu, 28 Aug 2025 12:22:06 +0200
In-Reply-To: <20250828102202.1849035-24-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250828102202.1849035-24-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2838; i=ardb@kernel.org;
 h=from:subject; bh=TcdYcykAR9cLEM27p6kO98NKAl+g8NWrqQB4rNoCokc=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIWOD7rlS1eUu599PVi5+e11pvbXSo4ebZ973df811/uxd
 leHC6dYRykLgxgXg6yYIovA7L/vdp6eKFXrPEsWZg4rE8gQBi5OAZhIUQAjw+PeiXrOMdZfriVl
 CC9K+Zf90+3TT/WzJg+ZJtclbd0bNYnhv98+QwON8lsFeyvOLJKYY/svr/DpOb1zSibr/v67nHx pGhsA
X-Mailer: git-send-email 2.51.0.268.g9569e192d0-goog
Message-ID: <20250828102202.1849035-27-ardb+git@google.com>
Subject: [PATCH v7 03/22] x86/sev: Use MSR protocol only for early SVSM
 PVALIDATE call
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: linux-efi@vger.kernel.org, x86@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>, 
	Kevin Loughlin <kevinloughlin@google.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Nikunj A Dadhania <nikunj@amd.com>
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
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/x86/boot/compressed/sev.c     | 20 --------------------
 arch/x86/boot/startup/sev-shared.c |  9 ++++++---
 2 files changed, 6 insertions(+), 23 deletions(-)

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
index 975d2b02926a..7bd73462c11e 100644
--- a/arch/x86/boot/startup/sev-shared.c
+++ b/arch/x86/boot/startup/sev-shared.c
@@ -741,7 +741,6 @@ static void __head svsm_pval_4k_page(unsigned long paddr, bool validate)
 	struct svsm_call call = {};
 	unsigned long flags;
 	u64 pc_pa;
-	int ret;
 
 	/*
 	 * This can be called very early in the boot, use native functions in
@@ -766,8 +765,12 @@ static void __head svsm_pval_4k_page(unsigned long paddr, bool validate)
 	call.rax = SVSM_CORE_CALL(SVSM_CORE_PVALIDATE);
 	call.rcx = pc_pa;
 
-	ret = svsm_perform_call_protocol(&call);
-	if (ret)
+	/*
+	 * Use the MSR protocol exclusively, so that this code is usable in
+	 * startup code where VA/PA translations of the GHCB page's address may
+	 * be problematic.
+	 */
+	if (svsm_call_msr_protocol(&call))
 		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_PVALIDATE);
 
 	native_local_irq_restore(flags);
-- 
2.51.0.268.g9569e192d0-goog


