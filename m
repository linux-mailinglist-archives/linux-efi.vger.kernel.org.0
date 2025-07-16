Return-Path: <linux-efi+bounces-4357-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A2E7B06C1D
	for <lists+linux-efi@lfdr.de>; Wed, 16 Jul 2025 05:22:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 610701AA710C
	for <lists+linux-efi@lfdr.de>; Wed, 16 Jul 2025 03:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF25227A900;
	Wed, 16 Jul 2025 03:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WTuR8Lya"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0B81E766F
	for <linux-efi@vger.kernel.org>; Wed, 16 Jul 2025 03:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752636153; cv=none; b=gmGOJOLDdK10Vrg0nRKJBVtHLePLg0vkwGl+YbabgsvTFfcKwBD1A0WeBXM8UQA+pschkfh6vezfCrQRiGxmX8D0IyjjPzwlCOjRGHJGLSJqxGTdvoyUhAUenYoDj0tDe/AvXJH3EqRQmzeFsmdGNarFLtmcjLS0K9xBZxjC6F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752636153; c=relaxed/simple;
	bh=v49A8oJS6XIvuwuTx1VFy54/JzeUn5KIraycKxlteqs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Db3/wz/cgGFsfdaJIYinVQrVKmODI2xOmlmvfH7YGX/9Pe2tPow7yKTRDDVpnW7ttseV5zopWpYhvnzClNhrecWOQIJkXBFmAGIm0DvJbpcsLEW+SDH8ruJnmXdlkf+VIjXBDb30FTYFDKNxKmYACZZ73eYCjXGkSIq5y9bxjHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WTuR8Lya; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3a4eec544c6so2750927f8f.0
        for <linux-efi@vger.kernel.org>; Tue, 15 Jul 2025 20:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752636150; x=1753240950; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Mi64TGEjZdXwCQTgfas3h0zEj8AJDhCG3MKZkP4tXPw=;
        b=WTuR8LyaEUuWQw1nIrAX9f/q+NvaSlLGFU/D54Epxf3AgDow0pHNs/ijgiTMg45B8/
         DEolqd+jx0HEWC4JGDURI6WMQuywAriCtF6/w3sPkHaT9rMOL8UOGJZL2ale9EgrpcHC
         CWeAhcAYVTqEmptqNZSiwuqE2KIB3Iz6LvpmkRMlyf46IiAZVr1TRevg4m1Emq/FZbmc
         AsZSOlSS1w+cvUn8xqX+oprtyy/vx+aTwc39XRY9Y60AW3omdvmclpazyEA1asZTeiNQ
         1zMkTy4vqif2/rHT6SfwLmHNOr7BCmnUaT4zvARwe5dTkv5+uLxbEGinvTYIlYnhLdJt
         XQfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752636150; x=1753240950;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mi64TGEjZdXwCQTgfas3h0zEj8AJDhCG3MKZkP4tXPw=;
        b=UadI0Oz8Iezg/oiSl0veWDeDJ3ZOxlEwKKur/1NH4dz7O5vTccsGD+TcAzazp1OME5
         va5rQulJ8yxf29OX8kWapWHIql5fmE3xx74si2AURJRYtqur4NYXh7s3QvL9KEWN9C5F
         ICXqF+6ujB/Xez+y4u+MH8xnREAFqeydHDQW6B3wZIFFYVJKixp2igzQHkToOzyfFxSL
         iWqOqKr7HiQjOvOvRWk7671HC4o1l6XB1xUwl0FK8oLJhvRJLVykR6j75ZFY//JKS/TQ
         2ROIspiHCUZm+APauFWrn0mcHXh0mGH31PH6KtqcmTeSvctdVLEtkLLVc9KAqqU+beqY
         RrcA==
X-Gm-Message-State: AOJu0Yw6U50Z0ZMov4ycu36LILqtpG1HWmgfrVUbNMV4bazu1t0QYcFR
	dZWeGTbO6WlZpUv5otY0l0SQ5yTl/0WJKeY1HjHm3EFBxybhRtZvVnj0wTCmZezzFYGrJMKL8w=
	=
X-Google-Smtp-Source: AGHT+IFvD4STBOnkjJYNd4Id+yAHrRPbfs07BpcSGB5HyjYmjd9G5CHucDREwE65rbGFj24wuyPeA5D0
X-Received: from wmsr24.prod.google.com ([2002:a05:600c:8b18:b0:456:1194:a7e7])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:2d81:b0:3a3:63d3:369a
 with SMTP id ffacd0b85a97d-3b60dd5644bmr605053f8f.25.1752636150405; Tue, 15
 Jul 2025 20:22:30 -0700 (PDT)
Date: Wed, 16 Jul 2025 05:18:18 +0200
In-Reply-To: <20250716031814.2096113-24-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250716031814.2096113-24-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2785; i=ardb@kernel.org;
 h=from:subject; bh=ITSBnwqgCdNtJ0pcaAFCwSDtx+3Mc2gbtLjwRHRy5Ig=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIaNcivdTPWeG2tS5vf3JJh1plUu1YqZccrjmWvHD3lTnt
 /yb+487SlkYxLgYZMUUWQRm/3238/REqVrnWbIwc1iZQIYwcHEKwETsNzL8M3qzacMNx+snTxQc
 3+/EvFny1Ra+orYXczivLhV/UfVz1keG3yxXtv6ZdE2I+/HpM6fsVl17KqxQYjO/QPTts1qf8Mb Qh2wA
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250716031814.2096113-27-ardb+git@google.com>
Subject: [PATCH v5 03/22] x86/sev: Use MSR protocol only for early SVSM
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
index 60ab09b3149d..d9c0c64d80fe 100644
--- a/arch/x86/boot/startup/sev-shared.c
+++ b/arch/x86/boot/startup/sev-shared.c
@@ -740,7 +740,6 @@ static void __head svsm_pval_4k_page(unsigned long paddr, bool validate)
 	struct svsm_call call = {};
 	unsigned long flags;
 	u64 pc_pa;
-	int ret;
 
 	/*
 	 * This can be called very early in the boot, use native functions in
@@ -764,8 +763,12 @@ static void __head svsm_pval_4k_page(unsigned long paddr, bool validate)
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


