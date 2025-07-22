Return-Path: <linux-efi+bounces-4447-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE2B7B0D33C
	for <lists+linux-efi@lfdr.de>; Tue, 22 Jul 2025 09:36:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D08C1165EE7
	for <lists+linux-efi@lfdr.de>; Tue, 22 Jul 2025 07:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3B0E2DECCC;
	Tue, 22 Jul 2025 07:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0D92re6O"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55EDE2DD60E
	for <linux-efi@vger.kernel.org>; Tue, 22 Jul 2025 07:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753169405; cv=none; b=XUTIiBCvVhaw5lusGtD4JY6RaeWZefmoClp/ul5+9QZjkHr9Q+GhhEk7++ZToKoKkGmyiZFF0+i8jGqbekwh7/zkB0t/iD6l/k/A6KyGI+zkRw366t0ib/GrUSkFuAtdq6Br/y6jmU9FRqK7CoxV5qQRLTwntHAF2E1APQTVr1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753169405; c=relaxed/simple;
	bh=vVDlZJWB8lTREumuuuCk8x8cUtPXtifS8mSDN5W3fHw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MLx7rgb8Pm90N2yBgBy7RYi6NtgoQeVWpgACxckbiC+jA5ZbM8CLYuayLt7xSZ32ayFED1UQBS268EB9MO5orviEJxGgEJ7nr6uOoEl3ykhGP9V6TyQn3Yple6D/qE1XDGLdPhSkhj7lJkjGqhgnq/s2QPDymf2HO2NQ5sw6RBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0D92re6O; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4562985ac6aso52631185e9.3
        for <linux-efi@vger.kernel.org>; Tue, 22 Jul 2025 00:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753169402; x=1753774202; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/ssokY+T+YDq1a+CqfE2fX/+m7rLK9V2q5R+I/D2Aug=;
        b=0D92re6Om1ftgb/KOEPnAAddvgg0XwQm7xOeq7D2Y9DCbiTF+PgYF6hBjFANyD+gaA
         WCPNYYukmqyX0f4yAoXLqPP8n1RiSx84FT4uZ6io5GHBVJrkqOBQMn2iLrqhO7/sEjfj
         srKpfNtIDMI5sXFbcIDuWhz3NsixITzwtbcmvJo+qXZa2S2jmJHM7ALV4JlnPir7791F
         zotpl9taX1K+Px4S9MmaqIFHDrQ1jcyiLbehe9bqo8geG1vx8kVEDvIlSG4OfcD7tqB+
         wy/IO9giIcDfulbGY0I9kv0ZMtzXx3vj0N1sydLZdPISozXnQP+6nULFY0Nq669j+NXI
         4mvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753169402; x=1753774202;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/ssokY+T+YDq1a+CqfE2fX/+m7rLK9V2q5R+I/D2Aug=;
        b=oEgvpHNmTtyopriVceQXezxU3q1bcwe52C1tQGmDpp7SZryar5dfD5bl6Xs36q2FYT
         9Tk/VpTspwk7IfkNDdmcqThcBjwdcys7YFRBPBgVq8p49WSj4BksLgATNJFoQpBeNRuP
         TudiUHYiEogwst3m1RLcdYjjac4ktBIHhuE/wmjRkQfawjokjoTxhSY7FOuZcQ0N63GF
         QYnR2C/pJXDNarRgbI0OE2eODBHeTUzpRDFR5D5dgbFUEMcA9gqCi6u+bax7WYJq5I/K
         6Nwc0WhtDEjbLO9NFt25Gx3aMqm9iQxAcvs/RMZ6W6N73jaJx8YnfkELVhMZBLuf8DDU
         M1yA==
X-Gm-Message-State: AOJu0YwA/6giPjTrDyUDzQZniA0bkUenVBEjFVf6FqYB8GajnD270ZFU
	l8FVc5rbn9hLzOduJhsxFe1LR6cbHWZB7m9s6NG6WaOe8mwGuwHM5UOIsZRiH1AtXw5sp2OAqw=
	=
X-Google-Smtp-Source: AGHT+IG/4zN7M//CwPnYk92e0p11tFN35Cq/WJ/jnNU/sDvvsIT38SSaLPcmjgAttXwOZXMOQ4OgAm/y
X-Received: from wmbej14.prod.google.com ([2002:a05:600c:3e8e:b0:456:1bf2:2be2])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:6097:b0:43c:fdbe:4398
 with SMTP id 5b1f17b1804b1-4562e37a142mr200900425e9.6.1753169401971; Tue, 22
 Jul 2025 00:30:01 -0700 (PDT)
Date: Tue, 22 Jul 2025 09:27:21 +0200
In-Reply-To: <20250722072708.2079165-24-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250722072708.2079165-24-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=5030; i=ardb@kernel.org;
 h=from:subject; bh=h5zR543qP1ICC4eRdLkDvBg4EKO+Wsvsmo2bjjjiAxc=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIaPetuMm75QkdtZC/uq/PyoL/WZNS1fZsuDS9hkXzolPz
 CycbPK3o5SFQYyLQVZMkUVg9t93O09PlKp1niULM4eVCWQIAxenAEzk7jRGhgOlTZmbUj63mnxT
 WaB1YTFLeabhSjs1RZMwgbOrErNmJjP8s7IKs/2j/X+D2Rmn34lZWapvnRU5ZeOZOa4YpT3w5FV jAQA=
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250722072708.2079165-36-ardb+git@google.com>
Subject: [PATCH v6 12/22] x86/sev: Provide PIC aliases for SEV related data objects
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
index 5992c82572d1..1044a50ac3d3 100644
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
index 55fc6d0641d3..76d40e381d41 100644
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


