Return-Path: <linux-efi+bounces-3659-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9442DAB448B
	for <lists+linux-efi@lfdr.de>; Mon, 12 May 2025 21:12:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15286463488
	for <lists+linux-efi@lfdr.de>; Mon, 12 May 2025 19:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54105298CA5;
	Mon, 12 May 2025 19:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I0N/ARzg"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70033298C37
	for <linux-efi@vger.kernel.org>; Mon, 12 May 2025 19:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747077104; cv=none; b=LYn4NK15mFm1E4Pg12Brf7pk5qx+1CchTRi4e5Rc4Fbn44UQl0eMzCmhYbLwz5VacpRaR+RykrT3Slw2JIaZVsCHBfn8N/Kw7QYHhvurkjxlmgVWX9yQzn6vGXkNIp2H92s1c0tesXq+TpGD5noZxeJURJZ6KM/q12W4ZvyIkZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747077104; c=relaxed/simple;
	bh=N8lIrN6QnYWQRxj3loyK87tJKBDaO7dJNOxuR7UZwmY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NHzc+dUkgarwqyde1ffuZjQvqMf+BN1HqSlHi0DjGwsl8ZQQdMG/3+IegZNfoCXi3pQyJYGnDWYRwPFt0qJ0TtIUz8tiF2AYBHQYO8otIFig8EDa3VTCJxhrONffkaNeK84DFOjSsqDRAmazvGv58nb+kMw3sgaezQfZKcarlfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I0N/ARzg; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-3a205227595so677542f8f.3
        for <linux-efi@vger.kernel.org>; Mon, 12 May 2025 12:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747077100; x=1747681900; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yAKS3akGBR/9SddxoYh5t/3Kaeg1HbH4Cc4GvmNf7kc=;
        b=I0N/ARzgFmJo5sYj1560nlfVzrEzIBfXyY5rjLnS6wWfmQtOruXC17dt09kxIC3B/A
         UkMBVqDDUDCigiJ+Db2S7QyJQ4Ps5mCngvPjEBPYR8sEXC7eTgs6L5VvH3cLFeSCt5g3
         RmIIMaiqjEAoHes9NeZLTaA7+D8Y3iBNB73JQG/5YlHsVt+9yzb0weVrLo/9VV783dSR
         vHrzF2YffoFuaeqh1LrJKPRo6RdyYF4LXbk3Ed5gI4u/L7k/jknlIXCVbLmhvfv2uMoC
         zRiTcJOy7bRzaJ7/WM3gaKPaXKF2kgRmtYfP7HvHOAt8wALZI4YlrCbDmppurioeC6LS
         z0sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747077100; x=1747681900;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yAKS3akGBR/9SddxoYh5t/3Kaeg1HbH4Cc4GvmNf7kc=;
        b=TXL+fl2W54iBXziJMHpWx9lRfim2fgr11YvZTIoN4hZbg6ggU4ZHsVdTRqQAX2Nch0
         waHYkGludyCqSBDeBuJUDqvc/MQ7628N8CTvT40LqNoplSMaMBjFIls4zx5O7/Z+dt8A
         H9vFkTlDIa2Doh7rbahRlcGI5u6YhXRfWD9Jco2h+myfFRZKAuDoOFxu2wCH9zVS1nnP
         /o0I5QROhx6/hjdoC5bZf5p5tRa7FgkK5iRuQ8o4qBp2Krky1WNx51g8ew+zGrVh6D4C
         CWp1NlP6qA3Elx3phy9EsgwiSoZW9Y028wArYdbx/pjTecZP4BvA6NfiWAa3l1RivTTh
         Ng0Q==
X-Gm-Message-State: AOJu0Yyb3JALjstWK1OOS1ZZYj0jRD/u5uMV9tdZ9OWYsTdpkC0JrgTr
	iS8K2Tyle/j9o1M8Bpd4SjbgKNQTmPPUEIfLqNmeWLmprJ4+tMAjmb/ZY5tsiR/9LXn8lw==
X-Google-Smtp-Source: AGHT+IGX1Wukqh3EK0YfLcD9ed759VITS0iUHJbGg2BkqMIQpCmp8NgTxMLsY1cSzdbBmJab7Amumzsu
X-Received: from wmbhh12.prod.google.com ([2002:a05:600c:530c:b0:440:626b:cdc])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:3103:b0:39e:e217:28c0
 with SMTP id ffacd0b85a97d-3a1f642217dmr11281761f8f.10.1747077100813; Mon, 12
 May 2025 12:11:40 -0700 (PDT)
Date: Mon, 12 May 2025 21:08:39 +0200
In-Reply-To: <20250512190834.332684-23-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250512190834.332684-23-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2831; i=ardb@kernel.org;
 h=from:subject; bh=gyvK1vVt7xT2yPdX1EeqNZBgIdQd81Ru1FpgpHIYf3o=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIUPJ3UbMLaG9Z8ePSUG7V/zZ0Gt39cOFEv7j8hw9drPiU
 6MfbdvSUcrCIMbBICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACZy+R4jw8Iq14cHUy47Hbwz
 /Rz3Uw7zD7whh9wn1m5f/oA/IbNv80WG36y1Ghd9X/WmWtx/u+rrCY73Ykmx/t9O7yz0eWXFs7L 7CC8A
X-Mailer: git-send-email 2.49.0.1045.g170613ef41-goog
Message-ID: <20250512190834.332684-27-ardb+git@google.com>
Subject: [RFT PATCH v3 04/21] x86/sev: Run RMPADJUST on SVSM calling area page
 to test VMPL
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: linux-efi@vger.kernel.org, x86@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>, 
	Dionna Amalie Glaze <dionnaglaze@google.com>, Kevin Loughlin <kevinloughlin@google.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Determining the VMPL at which the kernel runs involves performing a
RMPADJUST operation on an arbitary page of memory, and observing whether
it succeeds.

The use of boot_ghcb_page in the core kernel in this case is completely
arbitary, but results in the need to provide a PIC alias for it. So use
boot_svsm_ca_page instead, which already needs this alias for other
reasons.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/sev.c      | 2 +-
 arch/x86/boot/startup/sev-shared.c  | 5 +++--
 arch/x86/boot/startup/sev-startup.c | 2 +-
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index bc4ec45d9935..2141936daba7 100644
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
index 297d2abe8e3d..9c8dd6bfe833 100644
--- a/arch/x86/boot/startup/sev-shared.c
+++ b/arch/x86/boot/startup/sev-shared.c
@@ -782,7 +782,8 @@ static void __head pvalidate_4k_page(unsigned long vaddr, unsigned long paddr,
  * Maintain the GPA of the SVSM Calling Area (CA) in order to utilize the SVSM
  * services needed when not running in VMPL0.
  */
-static bool __head svsm_setup_ca(const struct cc_blob_sev_info *cc_info)
+static bool __head svsm_setup_ca(const struct cc_blob_sev_info *cc_info,
+				 void *page)
 {
 	struct snp_secrets_page *secrets_page;
 	struct snp_cpuid_table *cpuid_table;
@@ -805,7 +806,7 @@ static bool __head svsm_setup_ca(const struct cc_blob_sev_info *cc_info)
 	 * routine is running identity mapped when called, both by the decompressor
 	 * code and the early kernel code.
 	 */
-	if (!rmpadjust((unsigned long)rip_rel_ptr(&boot_ghcb_page), RMP_PG_SIZE_4K, 1))
+	if (!rmpadjust((unsigned long)page, RMP_PG_SIZE_4K, 1))
 		return false;
 
 	/*
diff --git a/arch/x86/boot/startup/sev-startup.c b/arch/x86/boot/startup/sev-startup.c
index a1d5a5632d58..1f928e8264bb 100644
--- a/arch/x86/boot/startup/sev-startup.c
+++ b/arch/x86/boot/startup/sev-startup.c
@@ -303,7 +303,7 @@ static __head void svsm_setup(struct cc_blob_sev_info *cc_info)
 	 * running at VMPL0. The CA will be used to communicate with the
 	 * SVSM to perform the SVSM services.
 	 */
-	if (!svsm_setup_ca(cc_info))
+	if (!svsm_setup_ca(cc_info, rip_rel_ptr(&boot_svsm_ca_page)))
 		return;
 
 	/*
-- 
2.49.0.1045.g170613ef41-goog


