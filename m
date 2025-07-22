Return-Path: <linux-efi+bounces-4438-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC5E5B0D30F
	for <lists+linux-efi@lfdr.de>; Tue, 22 Jul 2025 09:31:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3953D18944A8
	for <lists+linux-efi@lfdr.de>; Tue, 22 Jul 2025 07:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6315D2D321A;
	Tue, 22 Jul 2025 07:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CxxPdHVr"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA292C325B
	for <linux-efi@vger.kernel.org>; Tue, 22 Jul 2025 07:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753169395; cv=none; b=E8CGjOJrp0CFOjVkSEkfZ5GIyreZ+7w8V1vp3zV3ME8MxHUF3qxutjK1vJSyPXcuFtL98UsdSwtp1S6yXqItLURFJLZgHFg+xfF9KIJfTyATomVl1Wif3BLTNyuDiJMD57UV8FNUuxZSIcb4KN9YRJA2OF/1g8QbcX+hWj0zwnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753169395; c=relaxed/simple;
	bh=JUHAkipg3EAWRigg95o0oDZv/aTDkXQTohagQF+Jgqw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EH11eB5uiyyGVOs5ZBYhZw1LlPnwj31Sr7prOisqUHFXpFQPVM2btD7baMWP5cvi5q4+q3MrrKLNPsiIH3CRcHn/E8b2EvWjaJIhQfOeVN3zlOjp5K5bFJgkLbARuzK3Y+XItT6SEETte3uoozgyLDc1rrXfGON6V4BNhTLVMTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CxxPdHVr; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3a4eeed54c2so3313258f8f.3
        for <linux-efi@vger.kernel.org>; Tue, 22 Jul 2025 00:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753169392; x=1753774192; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z3StoCFGTVKHcmu3it2Teel6mdHgsbdfG3fJy5aNQEI=;
        b=CxxPdHVrrqxBk9L2KutKAFrv6poY818kv4s0/pG9FYMo7bhbd/up62tk2tR8fKIoIl
         G+G81Eza+eLMUJRdbZcaOywLSI4Snp0JE/wvnCBBsvzjY+HM+QtbUntEN+ep/i7QCziD
         4ULY9CFWMilV3A3fEYkjYuAeO+N5vqRT4ixytUcEwCNSmJv21UYm1P4C9/LwepUPE099
         I7auX07tbZY4hrTruTV6oroVrODDZddPF64lVNHvXbJH54ntGoTgC2GuDESz8ZEBeKDe
         j9M08DRjR6x1PPIpdfWbrO5pMDQdY4tl895WpO3QUmqRaWH12QSx8gBR9JaSnSpiZFcO
         PzqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753169392; x=1753774192;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z3StoCFGTVKHcmu3it2Teel6mdHgsbdfG3fJy5aNQEI=;
        b=LK9xlWCbfWA3UB/J3KFeYZI92blO+rsOhdXQOxrz8RGsVYxdrig4KckycdYG2FFpK8
         6F02BpG3rZT5QK/FX0CDiSVTEVQr8FWt+cJKpBmaTX+SaTWPUanIZ4BiaVAqfkmOfHc8
         kcokNY2G70M9XSEc6HGdQRx7dq9vQdv8qGJb8DB9XOmK72XQUAV5e4HvZ23Lur0ua1gD
         dOvwAOImdFKpO7LFo2P93F1ld5SJKqrbXdJHR34wjJ1Nu/bQFJF47UylNjFDdx7CWoBW
         GVjjqORSTQvYFcwBD0gMIY0eW/Id4de650yNVx6n9glWXd/iYDiw+7J1p/1czcXLgeh+
         ehkQ==
X-Gm-Message-State: AOJu0YwKEJyjRJkvzbx8Q+ESXspSVKb72mC5bPcB3gMnmulJkQEzzvcK
	yZ1QSKZOokqo+MV2i0luu4uvNyQrvA0Nj/BBITJGNXMt/Jfb42+D/uQFcmojWbkSRDD+z+zj4A=
	=
X-Google-Smtp-Source: AGHT+IEA8ROGNkNmSHtQT4zFRMHm9eM6qEUhvSlk0z+MCALyHBYlA2/EZonoCvsLaHf3lJAKRK7RcgfX
X-Received: from wrnl8.prod.google.com ([2002:adf:e9c8:0:b0:3a5:75f:1fb7])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a5d:5d0c:0:b0:3b6:463:d886
 with SMTP id ffacd0b85a97d-3b60e4ccea6mr20386959f8f.20.1753169391932; Tue, 22
 Jul 2025 00:29:51 -0700 (PDT)
Date: Tue, 22 Jul 2025 09:27:11 +0200
In-Reply-To: <20250722072708.2079165-24-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250722072708.2079165-24-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2215; i=ardb@kernel.org;
 h=from:subject; bh=cO87Xko990PxM0uCuqTN+gjd/OGjzTrbKtnIRx9uufk=;
 b=kA0DAAoWMG4JVi59LVwByyZiAGh/PVmhjv/xfnUVNnQmz3R4nT1oRIf0snLyTiTfh9k8oGqx4
 Yh1BAAWCgAdFiEEEJv97rnLkRp9Q5odMG4JVi59LVwFAmh/PVkACgkQMG4JVi59LVzEggEAxPdz
 v4I5KJTZA1I8yjO2+ZZHz07pRMqeDB7XZCcFJM0A/0qLymr+h8gmCBl/Ei3vA7pZ3aAhdS0XQ2X DPTO9RSkF
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250722072708.2079165-26-ardb+git@google.com>
Subject: [PATCH v6 02/22] x86/sev: Use MSR protocol for remapping SVSM calling area
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
index a1e211e0000c..4b958d03834b 100644
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
2.50.0.727.gbf7dc18ff4-goog


