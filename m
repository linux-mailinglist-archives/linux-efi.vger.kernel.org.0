Return-Path: <linux-efi+bounces-4627-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9A65B3998E
	for <lists+linux-efi@lfdr.de>; Thu, 28 Aug 2025 12:22:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 873B23683DB
	for <lists+linux-efi@lfdr.de>; Thu, 28 Aug 2025 10:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6147130BB9F;
	Thu, 28 Aug 2025 10:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1K9cFEOP"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769B4273D6F
	for <linux-efi@vger.kernel.org>; Thu, 28 Aug 2025 10:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756376560; cv=none; b=pUi6VHFCIDGNbeR6khLk4zg2fLa6K9ZEhY7mLNShZL7dnmGj4DW2/J5bbYl03FhtUBsW7KoSoI48Q016NMhyQcRn/wvzp7YcWDtvmLCy8rBb4m8vjHbrXQe/c6RGiDJc2koxE8gkMYhlySiDbMjQzZPxLp6HwkBm9UzMXMVd3io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756376560; c=relaxed/simple;
	bh=9FMrFz4yFws9nSQBzYDGUzVsmgC0frORowbaBDaRe+w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UcM4iCf861dEbwYZWu8hIEG2DnSRpSA5LpTFN+dgM2VPYGP8mT348/wQJAOM2IineB71TBQVaAZXdpZrzQqo/tfeYxtvle9dSL/V+YypgJdH3cnbkhxcJwHHtvBGwy6TscFP7cgay9PDQx606LswzcVgchJBSXzKfnYQW8z9NlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1K9cFEOP; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-45b71eef08eso4273265e9.0
        for <linux-efi@vger.kernel.org>; Thu, 28 Aug 2025 03:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756376557; x=1756981357; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3nwQAXQR3Sl4Tq4m168ErEqZbqg4yCIflfJGhXYIiQE=;
        b=1K9cFEOPrKQ/rMNV0GQMgD63326XAsyVK/B1joDHy/CPySR9PFm+L2M4zuc0WvZhch
         9JD+5jvxRrnV+GJnxSsK9XTSZR7roqgAZKeEY3ZPguYjhqBQqIg/nc/sXC79Fp4q7k1G
         46im4Y059XSS+e+bU5dCbxFA9qYqjnA+SOUyFdsQpCZQTIwZaA88remQBGvSdVcGYM6l
         NfHt+/rfZp9ATcB86p8PdZkYY5t1ZxJdZc/otl035tcllcN+MaJb1d/5xksy/ozvWSHg
         feQL0ji4l2oxpECd16bPsPu4tMfmZ9EOgPaUdmx/OImrjgrRNQ1/fCI6dQJ600CK9kqg
         SUKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756376557; x=1756981357;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3nwQAXQR3Sl4Tq4m168ErEqZbqg4yCIflfJGhXYIiQE=;
        b=pHbl3ZeEnwAaGaPrZJjSIc7zU7ggWUXZuHZfMtqAiqcImIAsw3USsts/xe4gc2Whcu
         mfFOaHAbIdzmnwYvICCEwk/J4S7Lg1IMFTdXnTVhMzRaLdyG+O3hTcX4Xa0y96HvYG1W
         WCDS+PCc/YBivqkLeM6UaJqDbMZuRGDxzSkuCg6FmJjwfOpFG5ebPUmTA46y7HYif4zG
         hGm3YAUQQJELqoVbNTFhjKA+EDl1Qwx0j+gCGCutZ08jCKmr+OEdKZUy7+7GkZgjdzfz
         W7xnoVMkSqTVTI91muVrv/SxQzIXzxhHeYcWZXaGoCqqBdTVyKES8hBHYYU5i2qiL6uC
         zOZw==
X-Gm-Message-State: AOJu0YwjgPJjwhaevVfXtLRYwdGzWMECNSREBy59FWOhQjyrdtkHhwjr
	aNcyhrcETuK5vA7OfMAZwSPDF0CGnXKrPGA2TLMremr9KuCWKe1k8lJ2ERv2cfYX8U+Yogumqg=
	=
X-Google-Smtp-Source: AGHT+IFez/08MYxA9v+9mjiybP8x5VNsKwGdGi6kiKjqmcS81v+Op5yujYj106yzaLaRso2zU6X6EeFg
X-Received: from wmbel18.prod.google.com ([2002:a05:600c:3e12:b0:45b:732e:5a16])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a5d:5d0a:0:b0:3c4:c15e:d08c
 with SMTP id ffacd0b85a97d-3c5dcdf92c2mr20718922f8f.42.1756376556806; Thu, 28
 Aug 2025 03:22:36 -0700 (PDT)
Date: Thu, 28 Aug 2025 12:22:05 +0200
In-Reply-To: <20250828102202.1849035-24-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250828102202.1849035-24-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2215; i=ardb@kernel.org;
 h=from:subject; bh=mTyGVbIeyFyq7WTQ0GeVQAG9AK2IHXM5K/3hy8ql8SQ=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIWOD7tk25YrgQxekrwRt83cQXds/1W3G5N+bVQ46vCnTy
 eTjzd/XUcrCIMbFICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACbyxJXhn/XxeddDPz3tqs+7
 6Mv8v9/y0b8QmQ1zt32zFTTk+xYY0MTI8CFm+d1pbgxyXl8eaifl7UhXUNnb/l4wal/ekWWCDzq vcAEA
X-Mailer: git-send-email 2.51.0.268.g9569e192d0-goog
Message-ID: <20250828102202.1849035-26-ardb+git@google.com>
Subject: [PATCH v7 02/22] x86/sev: Use MSR protocol for remapping SVSM calling area
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: linux-efi@vger.kernel.org, x86@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>, 
	Kevin Loughlin <kevinloughlin@google.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Nikunj A Dadhania <nikunj@amd.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

As the preceding code comment already indicates, remapping the SVSM
calling area occurs long before the GHCB page is configured, and so
calling svsm_perform_call_protocol() is guaranteed to result in a call
to svsm_perform_msr_protocol().

So just call the latter directly. This allows most of the GHCB based API
infrastructure to be moved out of the startup code in a subsequent
patch.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Reviewed-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/x86/boot/startup/sev-shared.c  | 11 +++++++++++
 arch/x86/boot/startup/sev-startup.c |  5 ++---
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/arch/x86/boot/startup/sev-shared.c b/arch/x86/boot/startup/sev-shared.c
index ed88dfe7605e..975d2b02926a 100644
--- a/arch/x86/boot/startup/sev-shared.c
+++ b/arch/x86/boot/startup/sev-shared.c
@@ -724,6 +724,17 @@ static void __head setup_cpuid_table(const struct cc_blob_sev_info *cc_info)
 	}
 }
 
+static int __head svsm_call_msr_protocol(struct svsm_call *call)
+{
+	int ret;
+
+	do {
+		ret = svsm_perform_msr_protocol(call);
+	} while (ret == -EAGAIN);
+
+	return ret;
+}
+
 static void __head svsm_pval_4k_page(unsigned long paddr, bool validate)
 {
 	struct svsm_pvalidate_call *pc;
diff --git a/arch/x86/boot/startup/sev-startup.c b/arch/x86/boot/startup/sev-startup.c
index 0b7e3b950183..8412807a865c 100644
--- a/arch/x86/boot/startup/sev-startup.c
+++ b/arch/x86/boot/startup/sev-startup.c
@@ -295,7 +295,6 @@ static __head struct cc_blob_sev_info *find_cc_blob(struct boot_params *bp)
 static __head void svsm_setup(struct cc_blob_sev_info *cc_info)
 {
 	struct svsm_call call = {};
-	int ret;
 	u64 pa;
 
 	/*
@@ -325,8 +324,8 @@ static __head void svsm_setup(struct cc_blob_sev_info *cc_info)
 	call.caa = svsm_get_caa();
 	call.rax = SVSM_CORE_CALL(SVSM_CORE_REMAP_CA);
 	call.rcx = pa;
-	ret = svsm_perform_call_protocol(&call);
-	if (ret)
+
+	if (svsm_call_msr_protocol(&call))
 		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_SVSM_CA_REMAP_FAIL);
 
 	boot_svsm_caa = (struct svsm_ca *)pa;
-- 
2.51.0.268.g9569e192d0-goog


