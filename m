Return-Path: <linux-efi+bounces-4219-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F6F5AFE222
	for <lists+linux-efi@lfdr.de>; Wed,  9 Jul 2025 10:14:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E107B3B9B72
	for <lists+linux-efi@lfdr.de>; Wed,  9 Jul 2025 08:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A551227D77B;
	Wed,  9 Jul 2025 08:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y1pDunto"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E059B27C172
	for <linux-efi@vger.kernel.org>; Wed,  9 Jul 2025 08:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752048694; cv=none; b=GUpzUvJ0t2UwEu3G9Eb/3m4z/78E7ehH+TM5uMQ0zbi+HpMfyEc8vA/4uyuCsOqBbNnBKe7aEMrt6OXXta31b2RuLIOPjyKTIwLXH/I4MdOs5FoT83eiE+8GhbD8qIWzGkdfJCPlKICPJdPWf15jybvGu9RUQW8oXYBDM/ElhjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752048694; c=relaxed/simple;
	bh=jvdJzaCEv0k/GcxYI/bLqbb+kNCSjp0cy3X3jI0kiIU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HdOqpm6GWJSjmHDsiZCciIvpoRLKSWgv4VTI0kZyU5T3N3Y4ShxVwA+wm0uMTjrwwn+KbsoOIa3Bhsl8xlT8ItUerha/KJ5FZoe6rTdOctTyVFyt9vggbMnfUOblV9Z5wTID0UZc34/63Y3QCP10atBmiS+t9wmCDzggwuv0w6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y1pDunto; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4537f56ab74so33233485e9.3
        for <linux-efi@vger.kernel.org>; Wed, 09 Jul 2025 01:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752048691; x=1752653491; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=C8zEEV0k0V04hhlMfC1WwEc4eqVxDysgmOU00FHLTTo=;
        b=Y1pDuntoOc34H91LbwnI3A32faFc4wdrP6cGoKzFPctOgJVvGtCw7aNvdQ0BLRL8Nt
         2OPmFBTcbAcjnhmDCeyldEwrA6JE5NJjXyfceadZ4i1r3n+8FGFtro6/GiPXp3vQd1aw
         v7LGVBuF88ptT5rOr6jo/IkvMrVCkTNWMxqVxKfKYgJsxnfPlqpcVweq5p58v269IURz
         MDOTlKlH95GbYxigVNY7KOOU9DSBVrO9KWGw7b8JC9XyTFaxlbE5BUhcqI4LnBSqEb98
         ouJY977ED/h2KKba4nZOeWWqnh2bwZxQcLcladBAAVl2qAHT7ec/ITdf8qziTF3AxEep
         DYIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752048691; x=1752653491;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C8zEEV0k0V04hhlMfC1WwEc4eqVxDysgmOU00FHLTTo=;
        b=vZb1mBU23i9qOtX/TCiJsKtpr1yyUpJy3jxSxzxi3H8VFNhYMnoFShUqtqCLlKEq+X
         ERs4mQAeNQzJVUgMt++Led80K325S/xyZfz4H+rG98njuPkT4dLWL7ujmHrnKYpRBcOD
         na3AjFGcvI3Z5Y03XdWP8nl2bSmrtlLw3HOuRw3ymklQigjtqaieXow55C/A+8Z3hcDO
         tLrWrfsuv92LmdVpXy95YsyYe2PUvvn+XFjenZbJCI3ffnPVPc3nBdTTWxXAMvCZZjxv
         QuwxpHk/nL+hoMuIMj2bxx3daqvFDkupuab4Ecfl8DMDTXwjsn6JBJoHni403X2wtQQO
         hqwQ==
X-Gm-Message-State: AOJu0Yz9/wAhVruGopCBP+ufAoQ3FrwJN4E5OUVztTVw8pDp3luM3OVi
	f8BFmKnuftn7ZdczFxDwfAdf7f/+utT32KI1Rh9DR67C3ywBJauklRvEgRyRWzdpQs1DST9mrQ=
	=
X-Google-Smtp-Source: AGHT+IEdZORNPphu+mvo+KEMZneLj4yaAV2b0INhZrtb4dCFEIZhRclR5jpzQvG4KiAoT8kk4rgHJSlc
X-Received: from wmbh3.prod.google.com ([2002:a05:600c:a103:b0:442:dc75:51ef])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:6989:b0:43c:f629:66f4
 with SMTP id 5b1f17b1804b1-454d523bbd6mr13706085e9.0.1752048691396; Wed, 09
 Jul 2025 01:11:31 -0700 (PDT)
Date: Wed,  9 Jul 2025 10:08:55 +0200
In-Reply-To: <20250709080840.2233208-26-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250709080840.2233208-26-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=5030; i=ardb@kernel.org;
 h=from:subject; bh=tvzBcQkTV7J9OoV2SLp4+keidchj+zYgpljjyN1cVzA=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JISNP+VLWxAtFc/9nVagFNAsvvJFimJCVktfebPsxJKzgj
 LXjxd8dpSwMYlwMsmKKLAKz/77beXqiVK3zLFmYOaxMIEMYuDgFYCK3TzH8L96Z8XXuloVPmczV
 jH64OWgaKPTOPndifaqQ3MrMpv42EYb/CTZnFJiq4rQ4rgtIh221bqx4aCgwV3PzbPXlF17GlmY yAQA=
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250709080840.2233208-40-ardb+git@google.com>
Subject: [PATCH v4 14/24] x86/sev: Provide PIC aliases for SEV related data objects
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: linux-efi@vger.kernel.org, x86@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>, 
	Dionna Amalie Glaze <dionnaglaze@google.com>, Kevin Loughlin <kevinloughlin@google.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>
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
index 4bd7b45562ed..5e0fa165e10b 100644
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
index a1d27a418421..042eef7b3a2a 100644
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
index cba4fb4cace0..0eb31bf81899 100644
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
index f73dea313f55..71a76fde3102 100644
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
2.50.0.727.gbf7dc18ff4-goog


