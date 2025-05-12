Return-Path: <linux-efi+bounces-3668-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8C14AB44A4
	for <lists+linux-efi@lfdr.de>; Mon, 12 May 2025 21:14:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE13D7AF2F2
	for <lists+linux-efi@lfdr.de>; Mon, 12 May 2025 19:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BF2629A323;
	Mon, 12 May 2025 19:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1nKDckbd"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41BB29A30B
	for <linux-efi@vger.kernel.org>; Mon, 12 May 2025 19:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747077122; cv=none; b=SExh4DJArOtOAWBrqsepu1YAb0HUtrkopR1LpswP9ygI0Chty3xAOVWkhpC4Fg9hthm+VI2fv+7yS8Cj5n2yHe8pJsJAu/HeVnTPZCT4Co1cMm9G82T7T58dGE7vgLwegev0mz/qXY4Uzhd4qHmWKmG7dsXodE2ZbhqvNf6ugJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747077122; c=relaxed/simple;
	bh=vZC/lvuXnvs/3ILzP3Sss1MDVjBUvH2peEOGAMozm/k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QGJ0ath3fUr/Gf9B9pt/DMorBTMR4G0uapmnlSmfD4S7OMYLc3mf5Yb3rbebsqBxSQYui+QqYR5/sNWapy0oMJ7aOSPMOzJ5tKA1mWdfvEhGc4lSws6IGcWwuSCVasz6DuifnX7fbkw2dZDDM5OyHnLre80YDMUrM0Ltrs4PAK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1nKDckbd; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-43d4d15058dso33710335e9.0
        for <linux-efi@vger.kernel.org>; Mon, 12 May 2025 12:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747077119; x=1747681919; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rzI9Rhhz6VtpWzTUQUiGCDtgPAAyeJ3jVJn+Xj3MKJo=;
        b=1nKDckbdA6V76/DYg8SgcvcgaBL6z6J/jsXpMv/lCbMrFCmx1SipxO1zvsCm4nK7wi
         YsF0IgUbOJGL/MnpIEd+2Q97iwb+xg9uevXeXWfXGYTIZKYVnEr97OTvEfHZxn0SKnE7
         OLok5G1+r5PSGGMuMZ5oSQgma7sFBjXsi3W+6YVXzDW4m+hs3+LHG0Rm1WBT3PjslfLm
         /O5plnLnvJtF4F2tRawU9p9jjgve7rhco2j8Xd3jl38tfvSscXDMRhgiG0GbGekutRnx
         atL8ofu1YODAuEdeo5BnmW5Z2C34YI0AiQQrohSg1hxreb6HQd8+ViPaIwnBtDd086Ig
         sLEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747077119; x=1747681919;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rzI9Rhhz6VtpWzTUQUiGCDtgPAAyeJ3jVJn+Xj3MKJo=;
        b=SEIi77WSkoA1hA86nrhawDqWwMSAWg/Y6WcN7BIZDlwwC/buF3A2os+8bdGR6U1qnJ
         WOevwrzR7vIKjeiqedBurWhVGNQmntJoNK5/rq0KGHEai0GeFs03ifYvKNd9rf48bC5Z
         285eRWJaaBoGuqZDlibSz5vzneSoVUq49bkIiLMqZo/E/Sqzm+yGvzGvrc98j8Qcs20e
         fu/FatzWcVWlxhjbdq5AiV0kdBlFS3UfMpsPctctQSq8tYkTWviUC/IMPHVnkqBC9pul
         9j8q1OfyO+AFHD3awv8rLBtnWTBDCSFoPsun+5/Hi6vCToQGObWNYlX0sE74BYQhUjyn
         GI5g==
X-Gm-Message-State: AOJu0Yx7DY7i6fJ3X/+7kzXzqq37B+E3f0yO/0stTtpBmMSfTAqd6+oS
	pFLhO9zC20RFbtPk1Fl0vKMJ+3ni3ZGwapI5tYRUNBGK7SKoBeuR4EV6/TnYkNln2nYX4Q==
X-Google-Smtp-Source: AGHT+IEyRKCMjROgwRNMYsTnB0oB57qSWvIJs2wXwqzTUCe9KiyD/LGh/ym0XBUJQTN0ZcEAk63kOyNw
X-Received: from wmrm7.prod.google.com ([2002:a05:600c:37c7:b0:440:5f8a:667c])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:82c3:b0:43d:160:cd9e
 with SMTP id 5b1f17b1804b1-442e9f4a297mr21324885e9.17.1747077119148; Mon, 12
 May 2025 12:11:59 -0700 (PDT)
Date: Mon, 12 May 2025 21:08:48 +0200
In-Reply-To: <20250512190834.332684-23-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250512190834.332684-23-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=4998; i=ardb@kernel.org;
 h=from:subject; bh=L1iwoqc7okjVK978IuWgIFWvuGDLtTUNFEDU369cp3U=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIUPJ3beSa0muTuXD1E17bXmtfedcN+Ba/rrt8IXdayz1T
 qX3dc/uKGVhEONgkBVTZBGY/ffdztMTpWqdZ8nCzGFlAhnCwMUpABP5Movhf8EnpQuKPo3Lk+S4
 9ggdtNlXOGtbRUJr5lWJrOId//acvM7IcMP974/nq0Q/5J/9O8k3SWT2tNQLqd1tUysNvyZZaRV +ZwMA
X-Mailer: git-send-email 2.49.0.1045.g170613ef41-goog
Message-ID: <20250512190834.332684-36-ardb+git@google.com>
Subject: [RFT PATCH v3 13/21] x86/sev: Provide PIC aliases for SEV related
 data objects
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: linux-efi@vger.kernel.org, x86@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>, 
	Dionna Amalie Glaze <dionnaglaze@google.com>, Kevin Loughlin <kevinloughlin@google.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Provide PIC aliases for data objects that are shared between the SEV
startup code and the SEV code that executes later. This is needed so
that the confined startup code is permitted to access them.

This requires some of these variables to be moved into a source file
that is not part of the startup code, as the PIC alias is already
implied, and exporting variables in the opposite direction is not
supported.

Move ghcb_version as well, but don't provide a PIC alias as it is not
actually needed.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/sev.c      |  3 ++
 arch/x86/boot/startup/sev-shared.c  | 19 -----------
 arch/x86/boot/startup/sev-startup.c |  9 ------
 arch/x86/coco/sev/core.c            | 33 ++++++++++++++++++++
 4 files changed, 36 insertions(+), 28 deletions(-)

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index 4b7a99b2f822..750f08d1c7a1 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -38,6 +38,9 @@ struct ghcb *boot_ghcb;
 #define __BOOT_COMPRESSED
 
 u8 snp_vmpl;
+u16 ghcb_version;
+
+u64 boot_svsm_caa_pa;
 
 /* Include code for early handlers */
 #include "../../boot/startup/sev-shared.c"
diff --git a/arch/x86/boot/startup/sev-shared.c b/arch/x86/boot/startup/sev-shared.c
index 560985ef8df6..21d5a0e33145 100644
--- a/arch/x86/boot/startup/sev-shared.c
+++ b/arch/x86/boot/startup/sev-shared.c
@@ -18,25 +18,6 @@
 #define WARN(condition, format...) (!!(condition))
 #endif
 
-/*
- * SVSM related information:
- *   During boot, the page tables are set up as identity mapped and later
- *   changed to use kernel virtual addresses. Maintain separate virtual and
- *   physical addresses for the CAA to allow SVSM functions to be used during
- *   early boot, both with identity mapped virtual addresses and proper kernel
- *   virtual addresses.
- */
-u64 boot_svsm_caa_pa __ro_after_init;
-
-/*
- * Since feature negotiation related variables are set early in the boot
- * process they must reside in the .data section so as not to be zeroed
- * out when the .bss section is later cleared.
- *
- * GHCB protocol version negotiated with the hypervisor.
- */
-u16 ghcb_version __ro_after_init;
-
 /* Copy of the SNP firmware's CPUID page. */
 static struct snp_cpuid_table cpuid_table_copy __ro_after_init;
 
diff --git a/arch/x86/boot/startup/sev-startup.c b/arch/x86/boot/startup/sev-startup.c
index 2e946dab036c..9dc0e64ef040 100644
--- a/arch/x86/boot/startup/sev-startup.c
+++ b/arch/x86/boot/startup/sev-startup.c
@@ -41,15 +41,6 @@
 #include <asm/cpuid.h>
 #include <asm/cmdline.h>
 
-/* Bitmap of SEV features supported by the hypervisor */
-u64 sev_hv_features __ro_after_init;
-
-/* Secrets page physical address from the CC blob */
-u64 sev_secrets_pa __ro_after_init;
-
-/* For early boot SVSM communication */
-struct svsm_ca boot_svsm_ca_page __aligned(PAGE_SIZE);
-
 /*
  * Nothing shall interrupt this code path while holding the per-CPU
  * GHCB. The backup GHCB is only for NMIs interrupting this path.
diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index fc4f6f188d42..ebf1f5ee8386 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -45,6 +45,29 @@
 #include <asm/cpuid.h>
 #include <asm/cmdline.h>
 
+/* Bitmap of SEV features supported by the hypervisor */
+u64 sev_hv_features __ro_after_init;
+SYM_PIC_ALIAS(sev_hv_features);
+
+/* Secrets page physical address from the CC blob */
+u64 sev_secrets_pa __ro_after_init;
+SYM_PIC_ALIAS(sev_secrets_pa);
+
+/* For early boot SVSM communication */
+struct svsm_ca boot_svsm_ca_page __aligned(PAGE_SIZE);
+SYM_PIC_ALIAS(boot_svsm_ca_page);
+
+/*
+ * SVSM related information:
+ *   During boot, the page tables are set up as identity mapped and later
+ *   changed to use kernel virtual addresses. Maintain separate virtual and
+ *   physical addresses for the CAA to allow SVSM functions to be used during
+ *   early boot, both with identity mapped virtual addresses and proper kernel
+ *   virtual addresses.
+ */
+u64 boot_svsm_caa_pa __ro_after_init;
+SYM_PIC_ALIAS(boot_svsm_caa_pa);
+
 DEFINE_PER_CPU(struct svsm_ca *, svsm_caa);
 DEFINE_PER_CPU(u64, svsm_caa_pa);
 
@@ -118,6 +141,16 @@ DEFINE_PER_CPU(struct sev_es_save_area *, sev_vmsa);
  */
 u8 snp_vmpl __ro_after_init;
 EXPORT_SYMBOL_GPL(snp_vmpl);
+SYM_PIC_ALIAS(snp_vmpl);
+
+/*
+ * Since feature negotiation related variables are set early in the boot
+ * process they must reside in the .data section so as not to be zeroed
+ * out when the .bss section is later cleared.
+ *
+ * GHCB protocol version negotiated with the hypervisor.
+ */
+u16 ghcb_version __ro_after_init;
 
 /* For early boot hypervisor communication in SEV-ES enabled guests */
 static struct ghcb boot_ghcb_page __bss_decrypted __aligned(PAGE_SIZE);
-- 
2.49.0.1045.g170613ef41-goog


