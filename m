Return-Path: <linux-efi+bounces-4638-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48346B399B8
	for <lists+linux-efi@lfdr.de>; Thu, 28 Aug 2025 12:26:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B950B7A897C
	for <lists+linux-efi@lfdr.de>; Thu, 28 Aug 2025 10:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 493E630EF9A;
	Thu, 28 Aug 2025 10:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sUuYbLNi"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9775D30DED1
	for <linux-efi@vger.kernel.org>; Thu, 28 Aug 2025 10:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756376574; cv=none; b=Qv5fCCk24QZJk5ukpr4G77L6cnOFcBOKfdBXMHMRTfRESGg9w3S5FVOLjRObuztHKs33MatDeP3GOaJ4c2CB6ZppAbNW1h49Z/TKvktwrjOGZX8+00jGpq8AXrIB25n5YB1HbqWSfLZd2qpfcsVzNHiRxDMR61ek1hoS7wLXyF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756376574; c=relaxed/simple;
	bh=G2zufqLCQn7+KfD8fnQ9mx11YDR18l1Dlw5GsKNscZY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bxB77q1pp2xIqu+/1KwxXLaHHBfnqrPrl5xhb2IZmGfbg1mqpP2r/sQFsmaSknD8A0ZLRRsKecJ8UNE7j6mgiHsScxGCnjsbDpwUDtr1cyCadVKgDCP5laqO/A2q35TuBo2FJJNOJrFD8oFx2yPk8EnAaP0trhWSaD3wZpysUas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sUuYbLNi; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-45b7a0d1a71so3865915e9.2
        for <linux-efi@vger.kernel.org>; Thu, 28 Aug 2025 03:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756376569; x=1756981369; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ujXKSc+zgno0OOMX6c7Rga5ycdtxsGZotgyzuX1fels=;
        b=sUuYbLNiUlc3YoWE5WBJpCKXQ59MeVVgXFIz8sk6iD1150VCDtP5NZcMAk4iiEeK1K
         I231yYrMAu+e15EbafiSQSXzpjGC0DiMsfSUzK5m5+fJ0yR+xn7fnITbLw9ICtQAv8m/
         Bg6+y4WU0sJK0fn3fFBJTQ7RpESnsa7FfxqgikC5jbEp4CSwRKMUxxN2B+1dze5XxPVx
         ocoPHQYqc8HvibZYhJGo8y6JuJJov/huQKuXSPclOA/CXjJNUwSjC5+CRGTWK7fO2gqN
         Bkf+idHQiHkU3hui3uwk/QcCMmQEBQfP6yr2P5NXQg1drVbHSVEyN+nb1xQw7XEmwGWF
         +D2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756376569; x=1756981369;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ujXKSc+zgno0OOMX6c7Rga5ycdtxsGZotgyzuX1fels=;
        b=aBOePaZSjh57Nf7sp056JYwl/oBC/nxRYmtki6nq0qoMziH1EJNkh62M5wBua6E0I5
         CHpZK8IuxSm18bElUgJ4Q4WX9kRYClv3gvGOSmlB12eDAUqbsi/uMkhQhVsqxuh2ttYW
         ofPS7NaI5tSWuQGjfOXeJtuTStJTn+XUkMkT2/YuVX0cZM/aivQrFQa/rW/9KzYdD0v8
         W+avH2ngb6Plte9I2w0Uk9xzUWdHoe3TipzCObbqFZPO2DGTSbFOd7+7jgZ07bzXUNZj
         /6d1MhXdLhwrBXR6+dEACeRsFocOKkFax598KWM1ax9m75BDW4tpMyrZDBBlV74x4j1d
         UopA==
X-Gm-Message-State: AOJu0Yzdvhdlt6SCTlXSkmowFdRwvDh3oc7Lg5nmvrdiPs1Wqky5wOMy
	f4FOtYZqDL4sJ8KwkwlD8qNiuIbumZ9YSAg1ETpFV8jCHmhEzj3r7KdQgK0GitAiYBYyr2m+5g=
	=
X-Google-Smtp-Source: AGHT+IELwBKJ1UROeUm4ICPfKLRu9iKkB4nXcVpVpcr3BHxSyVYVCTcIRJFBmrQ1Gj31W7uvHssJ33ov
X-Received: from wrui11.prod.google.com ([2002:a5d:630b:0:b0:3c5:97f8:7ce7])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:2306:b0:3c8:ffcf:e01d
 with SMTP id ffacd0b85a97d-3c8ffcfe6bbmr11059839f8f.55.1756376568911; Thu, 28
 Aug 2025 03:22:48 -0700 (PDT)
Date: Thu, 28 Aug 2025 12:22:15 +0200
In-Reply-To: <20250828102202.1849035-24-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250828102202.1849035-24-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=5030; i=ardb@kernel.org;
 h=from:subject; bh=NkmNKRuvJHRR3ewqik/hXwp4Dka2MgHQ5hAg1woLvBM=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIWOD7s0DeteO7X2zc4WWmFyiTKH1/9enOu62X0ibyCk2s
 SrRTyaso5SFQYyLQVZMkUVg9t93O09PlKp1niULM4eVCWQIAxenAEzE5SbD/zDvgyxb8jzY+HMD
 rHyXHfP05fw7Idhn1fXYI2bKy58sYmVkuM74L+1Y21uf/05/ngUUJn3vfCrWF/7p+Tqh05lsj6K 2sAAA
X-Mailer: git-send-email 2.51.0.268.g9569e192d0-goog
Message-ID: <20250828102202.1849035-36-ardb+git@google.com>
Subject: [PATCH v7 12/22] x86/sev: Provide PIC aliases for SEV related data objects
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: linux-efi@vger.kernel.org, x86@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>, 
	Kevin Loughlin <kevinloughlin@google.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Nikunj A Dadhania <nikunj@amd.com>
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
 arch/x86/coco/sev/core.c            | 34 ++++++++++++++++++++
 4 files changed, 37 insertions(+), 28 deletions(-)

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index d650a314143b..6822eb4b9152 100644
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
index b86027d9a968..180f54570022 100644
--- a/arch/x86/boot/startup/sev-shared.c
+++ b/arch/x86/boot/startup/sev-shared.c
@@ -19,25 +19,6 @@
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
index b0fc63f8dee1..138b26f14ff1 100644
--- a/arch/x86/boot/startup/sev-startup.c
+++ b/arch/x86/boot/startup/sev-startup.c
@@ -41,15 +41,6 @@
 #include <asm/cpuid/api.h>
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
index 9782ebe30675..b9133c825f90 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -46,6 +46,29 @@
 #include <asm/cmdline.h>
 #include <asm/msr.h>
 
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
 
@@ -119,6 +142,17 @@ DEFINE_PER_CPU(struct sev_es_save_area *, sev_vmsa);
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
+SYM_PIC_ALIAS(ghcb_version);
 
 /* For early boot hypervisor communication in SEV-ES enabled guests */
 static struct ghcb boot_ghcb_page __bss_decrypted __aligned(PAGE_SIZE);
-- 
2.51.0.268.g9569e192d0-goog


