Return-Path: <linux-efi+bounces-4440-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCB9CB0D321
	for <lists+linux-efi@lfdr.de>; Tue, 22 Jul 2025 09:33:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE5C76C235B
	for <lists+linux-efi@lfdr.de>; Tue, 22 Jul 2025 07:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99BB72D6619;
	Tue, 22 Jul 2025 07:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ctAkEImU"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2552D372F
	for <linux-efi@vger.kernel.org>; Tue, 22 Jul 2025 07:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753169397; cv=none; b=eYMolk2seAwwUL3QiBFQd//R+RF5QelIHzCSga/M3f8RNJ1TlwyA+Xuv395SC7MEa6gO0MqTHvXW8pN5aiY4SH/l+g1DPc0MYuWgE+9YvPT5z3iDjuF+FOdLtnUETmcu+r2ms3UV8CQytkR9IqtKoPupjmZI/bw8R97+uQ+ZfcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753169397; c=relaxed/simple;
	bh=EWWd5cHpjrNbMBSNP1ciIHw/g0kHLDH9rKssUQ1iAoQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=a4VTVHbLw5iupQux07XmwPAlAC9h+eWr7+ld3Ld6UVthUjxePelHuqHoC2qf3rYHSYBmNt5H7MYbqvQuciqX5Iq61Zimp1cEOmVt5sAHN4nF4BirCkypTs2lI0QRGqoMr/EY9oWzNp+jJYhMTPbrrUO+GgijZ9kMJ0NTQ97Tqdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ctAkEImU; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-45639e6a320so25328345e9.3
        for <linux-efi@vger.kernel.org>; Tue, 22 Jul 2025 00:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753169393; x=1753774193; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1chRYU4FzgQvRn+5SDUrYs6JkTXrZgQrTSya3WLFvLA=;
        b=ctAkEImUNZP0jK/6+ABmXR5EkfRc2cohw9kG3GvnIP27zrnwf0QIhv8iXZFJWRvp89
         bgjwVj053AzeGmA8yEe0B1o3QAR4CkM2AXel7QBrc1nJg0A4FCY8VcTUQiXUb18FZol2
         oIKMrcUrBvDcsKe2i4xqMozHwV2R495RJqegs9qEgGxPdaHWqAPg1rP0G2qkuTVy7Mef
         J+P/187cAK6Zn+yWz9TlDGk1f7ckOxj5S1lSHlb1hmeeKOIQXP+TWBkD8kVLsHsbEj/V
         hhbN8aqoKXnGCPb3FTAE/TNCSjTJ4s62lCXQCtzi/22l1JYzs/XWecOiJUmsaU8U0L8J
         m/zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753169393; x=1753774193;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1chRYU4FzgQvRn+5SDUrYs6JkTXrZgQrTSya3WLFvLA=;
        b=OKR+59hGN4djl2fGvw7/jikMM2kaEt6XkeydRwYUSD5h4KJC0u45ZOOtjzRbhFpKUn
         GRj7b6MbR2YSTdHf/Dc7t6oIumUqlei7KrZLxhLqNqJLNabztgVWPObQnUgbOSY3C2Gc
         FUYBCEp3CVJ9zctvXSVNCezmZpi4x/CG/s8ZHXzFJt/VXmW1Uw5EPzqqMX5f3+TqX8cL
         KVJE7I9AW5bW8sCx7JuSGgQunke6NiQWHoy0q6MmS8DVOzt8t+rf2jOwqtvnI/3yoK4Q
         NJGvl4LMNNBonyT1cbexCRKURWuNjrFtpg4xkTz7868nL7W96boGWGlgD9eILrC+9rEe
         XqkQ==
X-Gm-Message-State: AOJu0Yx7YLmz4dacNzuMCUNg2w9uxLi4UGhx2Dy8i8cqhG68bDPUqpUa
	pcIZC+hBLdQsM8yFqsM0aFl6wGGJJVFTVCE/cku8BrymYwOYIMluNenwX2eH2B/EGryIaOlkqA=
	=
X-Google-Smtp-Source: AGHT+IELfZOomDJMkNnSn4FhZMs27VHLSAvBqMJeqptoxBknSUKVJkwBRLuzEaxbIMum6F1Q6VbUs2h8
X-Received: from wmbdr7.prod.google.com ([2002:a05:600c:6087:b0:455:fdc1:e6])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:190e:b0:456:173c:8a53
 with SMTP id 5b1f17b1804b1-4562e330eb7mr272404165e9.2.1753169392961; Tue, 22
 Jul 2025 00:29:52 -0700 (PDT)
Date: Tue, 22 Jul 2025 09:27:12 +0200
In-Reply-To: <20250722072708.2079165-24-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250722072708.2079165-24-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2785; i=ardb@kernel.org;
 h=from:subject; bh=5QW2Sku5zKlevp2pwL0Rqd9e3Xe6wKAp+z+ISnuyQ60=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIaPeNs7tk/XepHt3fVZK7Tj+u+PViwKrKXc0Z79oD9R4u
 n47Q51URykLgxgXg6yYIovA7L/vdp6eKFXrPEsWZg4rE8gQBi5OAZjIZk+G/0WcqlU3j5ydd8dj
 Y1DroePbuOcdSvC/GPZFUvmtv0J8kSIjw0nz+pD3sZqhWVZL3Lv3LD/V/08+wv9pjtYPD4NZ1Se 0+QE=
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250722072708.2079165-27-ardb+git@google.com>
Subject: [PATCH v6 03/22] x86/sev: Use MSR protocol only for early SVSM
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
index 4b958d03834b..9a5fd194101b 100644
--- a/arch/x86/boot/startup/sev-shared.c
+++ b/arch/x86/boot/startup/sev-shared.c
@@ -741,7 +741,6 @@ static void __head svsm_pval_4k_page(unsigned long paddr, bool validate)
 	struct svsm_call call = {};
 	unsigned long flags;
 	u64 pc_pa;
-	int ret;
 
 	/*
 	 * This can be called very early in the boot, use native functions in
@@ -765,8 +764,12 @@ static void __head svsm_pval_4k_page(unsigned long paddr, bool validate)
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
2.50.0.727.gbf7dc18ff4-goog


