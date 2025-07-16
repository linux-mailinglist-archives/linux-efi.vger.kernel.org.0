Return-Path: <linux-efi+bounces-4366-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71720B06C31
	for <lists+linux-efi@lfdr.de>; Wed, 16 Jul 2025 05:24:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE4D35605BD
	for <lists+linux-efi@lfdr.de>; Wed, 16 Jul 2025 03:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54BF1289E2D;
	Wed, 16 Jul 2025 03:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1Dle8e/v"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F96288C26
	for <linux-efi@vger.kernel.org>; Wed, 16 Jul 2025 03:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752636164; cv=none; b=XWKTLTmeFvP2HMnwmX2JI8OZF0aeOJ/Oxk4wTUlPxBfjn8rtGIEfZjIOJODqj7iovcEybLH1f8knpa/STJfLHraIHSeTJyB82PTbBtDB+B0bJW4daKWfIVqiD8adYG6vajuC1dsg7A69FSOQpKPBjAhvlvNAcLhzuA1/b3uReHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752636164; c=relaxed/simple;
	bh=VEmHl5eiHKjwgdYjJ41tk7HeKba97yajAex44kETR3w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EIKM3eGkocW6JR+SZ8XEgvk4rM41o/dpJi0S4GgS/lSVnVhihlUfqLgi4IxxIGgqS+3swZ7BcVm0so3V+QELNiDUAmK8Q4aKTbsvvL12v7XMySquv9Tz0lhkVs81P/L6RXmi6P2BWaQI1beW5YMbIHhyVh8c3PIBV2UTjsh8Wm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1Dle8e/v; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4560a30a793so15717475e9.3
        for <linux-efi@vger.kernel.org>; Tue, 15 Jul 2025 20:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752636161; x=1753240961; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7boTv+di5Ys4QdIKdCT0u82t02k9U3NlxmHSylt/GQM=;
        b=1Dle8e/vafGySLS0GVnlCsesX6lXi3yjUM7lxUJ9ocIapW5Vp12xBOvc6fYJCPgSUK
         oiAsUDCBD4rci4IQxma/nPqr6c42EizYsaft0/Sw12GlFCVlxepKSglG9piNCI33+J0+
         3cj3ohTPy6jDlc1ktuNj9slQgI2gBwzG+mq6af6SsX/cYk7REPDeG+nWab/LnUNOg1Bu
         Mv/cUUEk6Y6qgboCSYAfS45jl59ONNW1f2HrSqrWmvZnHJoCZvmqrwMw++Uns+aSEjpC
         LCOtMFpre2Mo3Xye8A6cPKgw7OemVuwWABQq+7yoNekRVSFV5u3e22YAXw9Mt5+v98YC
         0HDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752636161; x=1753240961;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7boTv+di5Ys4QdIKdCT0u82t02k9U3NlxmHSylt/GQM=;
        b=nOQ+rmzZlVjpF7+YTGxS/ACr3CgTOr7IhqMUsSOOXgcnShjqo/EbtRdxxG7k5TCEVl
         X+LRQZHny3Kcrz4jS9m/iKlzGrwFJXYChBjWqBocfzUeMsedzf/iU/NyKpbFvAVSNgTz
         3hBgadf7j3WmkQfajHjmA/BsG4U0JZlPzKk/ubaGluaK946ElNGy9odqLGCmtCDvjR41
         ftkE6M6MZbJ+DucFGQcD/CRaskynAskG52VcshG+IFiZNnMJVQ0zQgE3P0qSvr2sx/58
         gtN7SilbOgEfN4eRHwei8LJs/gsdEQ4c4AcyZpn1TrXhAC6TNYQlpPmvQRk8cHZvdaqx
         I1lA==
X-Gm-Message-State: AOJu0Yyc41QVqXOQATMVSi2I0+IHwxhDnXzjLujJWdcVRyCWkQrgnqgx
	/tbVzFrzko5cc89Dw8bBz5G12jPqG3TpOrNe2JTeN6DTkoyNPR+zpowHN90HObghS8O+vqCJDg=
	=
X-Google-Smtp-Source: AGHT+IH77E+ebL2o5oHmwxdvizom2S9q1B2UD3+cGjn1cupv6iIWwMw6UXkcZvT1rxmNQEZ8YngR9wJI
X-Received: from wmbgz1.prod.google.com ([2002:a05:600c:8881:b0:456:506:259c])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:8b2f:b0:456:27a4:50ad
 with SMTP id 5b1f17b1804b1-4562e3a222cmr6986065e9.33.1752636160825; Tue, 15
 Jul 2025 20:22:40 -0700 (PDT)
Date: Wed, 16 Jul 2025 05:18:27 +0200
In-Reply-To: <20250716031814.2096113-24-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250716031814.2096113-24-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=5030; i=ardb@kernel.org;
 h=from:subject; bh=5/30+kFJeHe02LNM3vgGQ9Nc+FkodkG4zNIUYg/FT98=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIaNcyorVfn2neu8KznZ2e6vVm+WEs02NtU/wvb8XeNWWK
 233pJKOUhYGMS4GWTFFFoHZf9/tPD1RqtZ5lizMHFYmkCEMXJwCMBGRJwz/NNza1/godJxaXf36
 +MzMpAA3tQdfSg49l1FibD4m76fXysiwTJCrgqeCye7cCtk6txTFrT0ccf99FMPnzD/Kn3Kp0YI BAA==
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250716031814.2096113-36-ardb+git@google.com>
Subject: [PATCH v5 12/22] x86/sev: Provide PIC aliases for SEV related data objects
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
index d62722dd2de1..faa6cc2f9990 100644
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
index 83ca97df0808..cc14daf816e8 100644
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
index 8e804369cc60..733491482cbb 100644
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
index 4fe0928bc0ad..be89f0a4a28f 100644
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


