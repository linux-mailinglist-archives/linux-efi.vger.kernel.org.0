Return-Path: <linux-efi+bounces-4629-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E5DB8B39999
	for <lists+linux-efi@lfdr.de>; Thu, 28 Aug 2025 12:23:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF8C07BB0A8
	for <lists+linux-efi@lfdr.de>; Thu, 28 Aug 2025 10:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E26A230C358;
	Thu, 28 Aug 2025 10:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DHVV3M7o"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADDAE30BBAB
	for <linux-efi@vger.kernel.org>; Thu, 28 Aug 2025 10:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756376562; cv=none; b=Cy6xVvDlECVLv7YG5zGAbB0sZBWiDHwxydyz/UJ/Ld8+QJL4+Az2aqH7/CXnAmagL4zRrKtOtz0FrXHI9ieQRTrFrHOT7TTQtMU82YsgZLsTJJboir1SgygVVdceAdTSKxBmPd1115KYbb+COEjveYZ39VXQOViF0Wpy+8uDXHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756376562; c=relaxed/simple;
	bh=XG4iFPQ7dXm9EawAtfRXbf+NOLZ/2VSBVsOoLZQRg/Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aMfEjThp2X+elkGLxFfsaD+dMzMU00jLYTpf6ecQYQjHYwwB4A9FLTu9TbgBbIUdDra6t3Taf2YePpZzfUVzNTUc/JtraTBA/S6u9lNAuESw3ntzM5O//IoNWx20JfqfcljUUehi741pK7nuL2eS3dwuHp+rJgT7SnKJlHem6vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DHVV3M7o; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-45b51baec92so1618795e9.1
        for <linux-efi@vger.kernel.org>; Thu, 28 Aug 2025 03:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756376559; x=1756981359; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=n+Ex4M3lYhbOdmTgl2VVZUUMMctjvi43SPBt0Zir0yQ=;
        b=DHVV3M7oQeS6qHogfdPYdrKMnXzLrxswpF/YHjnUW+Qy6oB3CfezOxgL+HhtQpVRaw
         JvmfLtAWU9g44ATIeF+47BmLK+pom7l87DYAw2wzdRtCC2OgirLkmAG3HqFbH/sZx6pv
         9eZ1x3nP1PVhLPRvOeo5cTHFHf27PxDyJfsWGaR5hSsoqBS3J/WwvsKs/5jrG9L+evdu
         jvnvwxm0DILbiy04V6orOoEmHhcbTP1JdO981NRGJBFve49ZPJK9VVJAm79fpNq1gCqE
         J6GJ9F1JlnFCDQLIijZGHXj4xGTJ0goyb3MFQJBuoyyPiLOc3zkERlY8591VLPW0lAhO
         tF8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756376559; x=1756981359;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n+Ex4M3lYhbOdmTgl2VVZUUMMctjvi43SPBt0Zir0yQ=;
        b=E9CduP8HPQcArVD/J6cDPHqZFRttZigBeb5O0o/Yyuwz/wpdGsdHypLhhjfVZC2Jes
         y8MB8/TF4WzlJTxgaNawZ9ZIlOUXOkHn6cU8xXAD2E9v4XFObj6D5tN8K7yV22w5epxG
         XPXG2IxBeNeufTR7nYqMjSyjrfrdmo2zAdXNXlmQcvHuJXRqbEkLjday66lg19ZdTa07
         vSk6/1aqwmBtIeN1Sh+87chK4ksoiDH3WDIi6F5q4IOO/9SS6E73pRW3d6cp8FwMtTzH
         HE/FVO2IYjqSsoZsuiMnOaPBh5fOEsG8WmcgoUJav+RwC4Frosflq1EPvxYffnx3Kv8C
         IH8Q==
X-Gm-Message-State: AOJu0YxSgdX3p8OF3+UjC6vYcEFRaSQar6fFicIYn6y6aOd3cxJjJ/FW
	5S1NeHW7Jptdes93AW2gf1x1f7XalrmuRlrusz3z51fhq1OHrV9KThTM6kQXxlW2OwYq+rXwIA=
	=
X-Google-Smtp-Source: AGHT+IGNzEO84yuvx51wyyUqZ5IgdRemtZpso/SXozOIRmH2QEl8i4IgDhNAbJ8hB7wf//PXXEVqHe/I
X-Received: from wmsz14.prod.google.com ([2002:a05:600c:c16e:b0:459:de2a:4d58])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:c0d1:20b0:459:d8c2:80b2
 with SMTP id 5b1f17b1804b1-45b5190ff43mr118500785e9.7.1756376559293; Thu, 28
 Aug 2025 03:22:39 -0700 (PDT)
Date: Thu, 28 Aug 2025 12:22:07 +0200
In-Reply-To: <20250828102202.1849035-24-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250828102202.1849035-24-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2885; i=ardb@kernel.org;
 h=from:subject; bh=c3RqFILGYSYwN8rYDyGtCPSFDiKCSaKQd37/kSOjjY8=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIWOD7nnxU+XS3UwWWdyvmbYVyF6/N+v/YdcnW2yX8E7e/
 eRBtYtsRykLgxgXg6yYIovA7L/vdp6eKFXrPEsWZg4rE8gQBi5OAZhIoisjw6StK04wCSx5Ij9p
 yfy+npNrr+sapJfvYXiUJN134rLsoieMDF8/iRwWOLLrs16+bWBncuiaRjXb3p9B7mrn5zOvS99 axQQA
X-Mailer: git-send-email 2.51.0.268.g9569e192d0-goog
Message-ID: <20250828102202.1849035-28-ardb+git@google.com>
Subject: [PATCH v7 04/22] x86/sev: Run RMPADJUST on SVSM calling area page to
 test VMPL
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: linux-efi@vger.kernel.org, x86@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>, 
	Kevin Loughlin <kevinloughlin@google.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Nikunj A Dadhania <nikunj@amd.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Determining the VMPL at which the kernel runs involves performing a
RMPADJUST operation on an arbitrary page of memory, and observing whether
it succeeds.

The use of boot_ghcb_page in the core kernel in this case is completely
arbitrary, but results in the need to provide a PIC alias for it. So use
boot_svsm_ca_page instead, which already needs this alias for other
reasons.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/x86/boot/compressed/sev.c      | 2 +-
 arch/x86/boot/startup/sev-shared.c  | 5 +++--
 arch/x86/boot/startup/sev-startup.c | 2 +-
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index b71c1ab6a282..3628e9bddc6a 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -327,7 +327,7 @@ static bool early_snp_init(struct boot_params *bp)
 	 * running at VMPL0. The CA will be used to communicate with the
 	 * SVSM and request its services.
 	 */
-	svsm_setup_ca(cc_info);
+	svsm_setup_ca(cc_info, rip_rel_ptr(&boot_ghcb_page));
 
 	/*
 	 * Pass run-time kernel a pointer to CC info via boot_params so EFI
diff --git a/arch/x86/boot/startup/sev-shared.c b/arch/x86/boot/startup/sev-shared.c
index 7bd73462c11e..83c222a4f1fa 100644
--- a/arch/x86/boot/startup/sev-shared.c
+++ b/arch/x86/boot/startup/sev-shared.c
@@ -801,7 +801,8 @@ static void __head pvalidate_4k_page(unsigned long vaddr, unsigned long paddr,
  * Maintain the GPA of the SVSM Calling Area (CA) in order to utilize the SVSM
  * services needed when not running in VMPL0.
  */
-static bool __head svsm_setup_ca(const struct cc_blob_sev_info *cc_info)
+static bool __head svsm_setup_ca(const struct cc_blob_sev_info *cc_info,
+				 void *page)
 {
 	struct snp_secrets_page *secrets_page;
 	struct snp_cpuid_table *cpuid_table;
@@ -824,7 +825,7 @@ static bool __head svsm_setup_ca(const struct cc_blob_sev_info *cc_info)
 	 * routine is running identity mapped when called, both by the decompressor
 	 * code and the early kernel code.
 	 */
-	if (!rmpadjust((unsigned long)rip_rel_ptr(&boot_ghcb_page), RMP_PG_SIZE_4K, 1))
+	if (!rmpadjust((unsigned long)page, RMP_PG_SIZE_4K, 1))
 		return false;
 
 	/*
diff --git a/arch/x86/boot/startup/sev-startup.c b/arch/x86/boot/startup/sev-startup.c
index 8412807a865c..3da04a715831 100644
--- a/arch/x86/boot/startup/sev-startup.c
+++ b/arch/x86/boot/startup/sev-startup.c
@@ -302,7 +302,7 @@ static __head void svsm_setup(struct cc_blob_sev_info *cc_info)
 	 * running at VMPL0. The CA will be used to communicate with the
 	 * SVSM to perform the SVSM services.
 	 */
-	if (!svsm_setup_ca(cc_info))
+	if (!svsm_setup_ca(cc_info, rip_rel_ptr(&boot_svsm_ca_page)))
 		return;
 
 	/*
-- 
2.51.0.268.g9569e192d0-goog


