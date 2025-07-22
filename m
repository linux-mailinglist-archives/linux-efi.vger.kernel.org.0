Return-Path: <linux-efi+bounces-4439-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E68BAB0D306
	for <lists+linux-efi@lfdr.de>; Tue, 22 Jul 2025 09:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5C297ACF59
	for <lists+linux-efi@lfdr.de>; Tue, 22 Jul 2025 07:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EE032D5A0C;
	Tue, 22 Jul 2025 07:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xLzC4cmK"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7772D321F
	for <linux-efi@vger.kernel.org>; Tue, 22 Jul 2025 07:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753169397; cv=none; b=NIaVwoi5yG7oZLzVLzk1Usrr7G1Tvf7zT3X57NeRPFtjOJqMo5TD5Y2R28csQT0nFpFMf2vlud6p91EQuQ4r+L3x+K/0oQyMc89xnv5xSyJHFYxuUTOLHXN2i9TOzacQrz0+N/Fpuw6dDvFVzGDhS9dIrowlV+v3N4IElNHiTIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753169397; c=relaxed/simple;
	bh=7vCshM9AqcDcWchmk6oN0McNjx72mT2fiuTk/2btq/0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GVgkO4AaviJ59pErH0cSdtzo01yOVAalsNnJa0GyYsidvxBi2Mi6duh6uhmnfJCFzwhtrW7xdjjV3zR40n1l0X7kKGsv0Oc10ptIDzNlN9BXY0DbTKxCX2G9kuv4l8OvLlfbVHTGwg1Sp0sOcxR7BMW06FTSoZJsJbLbadEU6Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xLzC4cmK; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-455e918d690so36441105e9.1
        for <linux-efi@vger.kernel.org>; Tue, 22 Jul 2025 00:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753169394; x=1753774194; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bLRM8tJZNrwYw9h12oKwz7c3JnI0avSh0N6ERG9kJB4=;
        b=xLzC4cmKYhv9LOaQY1QIuLhdtYiLYUlocbcASIDeZkpDE/2/zkLBrmTyMJ/R+pL1FW
         FW5xelJnDzX7BX6+eNHU4mV6nbB3hwkQeK1SzSUYml79sw1akITzxpP32zoinEAm6SfV
         hl2mjr+XwseJy3cQmB+ajcGCXqzNuOSWayXLNa8idBvi8Fgf36Ucfr2Z3pCoUjitNUiZ
         DNF7zIcqt6PC9XiyhOAK5z+rD34XpGjbwzU1mOUoHAPVitIkv16uR58J1ZGW9cs+DYD7
         SnQyAqE3lrKdayJkM1IlYAtprdu2gL1qU37MzHu/dd/yPDdOFmcoJPiIsdsV+R8bK5jC
         33mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753169394; x=1753774194;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bLRM8tJZNrwYw9h12oKwz7c3JnI0avSh0N6ERG9kJB4=;
        b=jvSmRIBWoxvZw7oN+do99sLojs0r0297Pq6FuXJ7Kri5F3U6D6zIgp/cMHiYIK9WR5
         J4PH0bsux6YppC4uZWLRCKX5JOx2cG/59wAV7fYkdH0jX6UdKLOCRwZfgYdsT4zGyUTL
         a0IWoFkw/jZuI9pGkbSukP94G1qgtOMpmQRMstxDc6fwqggtbSOoA8WhfnWMYf+yGTCO
         w7puc3+4XjiiXU0UG9jmoCwSXAC2wFevOojI24lKObBC1uYFAw1e+aRV6f/JBL3kMBPf
         /UrUZmDVoDvO5dwp9IkZbU2bg35jNb40clQHDIqBV9zVd+bNq4hGY2AgbeK8Dls+n9sd
         VbkA==
X-Gm-Message-State: AOJu0YweeMEhOVd6LmEiRC1ACTaZTx+06MNS5FmaiQzcAhYXJEt8oJgr
	UGbdgYDFH9evJXzfk23rjNlQnxg/zJkP6I0llweRYTy8Ld3WZiNjuC92dIGJlaTj7fxoredWUA=
	=
X-Google-Smtp-Source: AGHT+IEeL7axw2yiEjJd6+64L7kFT1vmPPUh4ItpiPQmLRhOlCBN4tHEyhfcoBECNf7D7yljPBxv3shZ
X-Received: from wmdd25.prod.google.com ([2002:a05:600c:a219:b0:456:ddf:4040])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:590c:b0:456:e8c:325
 with SMTP id 5b1f17b1804b1-458627137c7mr15268145e9.6.1753169393892; Tue, 22
 Jul 2025 00:29:53 -0700 (PDT)
Date: Tue, 22 Jul 2025 09:27:13 +0200
In-Reply-To: <20250722072708.2079165-24-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250722072708.2079165-24-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2885; i=ardb@kernel.org;
 h=from:subject; bh=gOSEACH7m/GcABV6nTbfH8lpEkMKzjPOqp9AyQqVxME=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIaPeNqn0QoHmnFxtuUQb/qeJFmtsnSLS3nul8uQyMB7bH
 ZDo7ttRysIgxsUgK6bIIjD777udpydK1TrPkoWZw8oEMoSBi1MAJhKexMhwJjbD7M8h3sMuU/r8
 Or6s/pLvMqkv+d6R42U5+26wWZTvYmT4JrJmSq7wlQ2fFrzc1lXxPIwnXUf244aXtsdqZu1fEmn HAwA=
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250722072708.2079165-28-ardb+git@google.com>
Subject: [PATCH v6 04/22] x86/sev: Run RMPADJUST on SVSM calling area page to
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
index 9a5fd194101b..7ac5c50722b4 100644
--- a/arch/x86/boot/startup/sev-shared.c
+++ b/arch/x86/boot/startup/sev-shared.c
@@ -793,7 +793,8 @@ static void __head pvalidate_4k_page(unsigned long vaddr, unsigned long paddr,
  * Maintain the GPA of the SVSM Calling Area (CA) in order to utilize the SVSM
  * services needed when not running in VMPL0.
  */
-static bool __head svsm_setup_ca(const struct cc_blob_sev_info *cc_info)
+static bool __head svsm_setup_ca(const struct cc_blob_sev_info *cc_info,
+				 void *page)
 {
 	struct snp_secrets_page *secrets_page;
 	struct snp_cpuid_table *cpuid_table;
@@ -816,7 +817,7 @@ static bool __head svsm_setup_ca(const struct cc_blob_sev_info *cc_info)
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
2.50.0.727.gbf7dc18ff4-goog


