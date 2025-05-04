Return-Path: <linux-efi+bounces-3568-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A38ECAA85C0
	for <lists+linux-efi@lfdr.de>; Sun,  4 May 2025 11:57:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DE523B8AE0
	for <lists+linux-efi@lfdr.de>; Sun,  4 May 2025 09:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 857161EBFF0;
	Sun,  4 May 2025 09:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="daSkEe+U"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970541EDA34
	for <linux-efi@vger.kernel.org>; Sun,  4 May 2025 09:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746352423; cv=none; b=MguHqO2h1jExqtjBe9zJJAbwavncB5Fdr+xtHSgp5tFB+9AFPxY86Ls37ij1IuCoWsV0panfnpQsIbFkRxPNV2UeyKEr2etIJMNOfmLRMtWw1yyDpxY/DZ7Mjo5HvaC3xh59jI1JjgV3U188yQA6CoIRseKHFmDIVEUZeYnoV0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746352423; c=relaxed/simple;
	bh=ySFC3DvBrtMkqxLkZqKoMPHnxZg5PFYGfuyRwinvm3I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AOevtIEeVZ04zjdixdckpxOQxlM5KfcDMZTltcADUaPYQwd1TT0MK4lIoaeDTCNiDEScnk47rO2dGnfL0Ra9Rsnul/YRHQOV6Qf0688C5vH2syZJT/YhgvPZVc94DBiEMoEZw7yCJV/POaC2qaQM3Um74QbYl/X7AUfp2w7TWog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=daSkEe+U; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-43cfda30a3cso15895605e9.3
        for <linux-efi@vger.kernel.org>; Sun, 04 May 2025 02:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746352420; x=1746957220; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gVvnJaxsL7lB6x7Rus/Rk5JP6sPC9wQuUZ5nrdcRGng=;
        b=daSkEe+UPwmo3f+BhS/Zck+4+efV8sJ4XlteVDHF+Cke1oS5xN2sTi+qmBdhid0c8T
         v5e8rp9qgUvo+fD0G4xRtjNxuRiz/ieMv5yMIujdhJIFlfYLDci48Bo/rM7rd2pUkfOC
         rRz5snQzn/N6pZA84Nj6wuvvoitcO3pVhKuLaEjtdti52utDZZP8bdORwSMWnm0pS2xC
         uGwc+AYjLHyltkA8oMkrmqQKDXn3pk5EbceCwkv3UZRfmvoUKuGMSksiwHWrMa760Ni2
         chB51zO8/1HmN/PG9YN5TgriK3FyyeUBWqWXqCyBlvMxg5quD6YgTmZCsrjxkMcH0vRJ
         sj0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746352420; x=1746957220;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gVvnJaxsL7lB6x7Rus/Rk5JP6sPC9wQuUZ5nrdcRGng=;
        b=iIo+vWDctMwMbxsJPAKU92D9z4nVSTJ6WMYmj4w4lWLriJxAgZhjgvFTqubUaubv6l
         T8Q5JCKcjYKncrxr/0NyI0Die/doqAsYYPE90RvqVivW9MlTPOBZ99Ud907tAvBxHHO0
         CmToUFjHMoYf6ADBLFRSjii4a6laI8bqensK5Y9j2QwRkWpxJ+NXx2KNJ4LdqOGLr2jb
         6LJ6008nRZrb7OZnqja5+47ikGwl+b84wICcqD78xIXxW6huvgICrlX/Os62Mrh5uMfc
         4UY24i3asPbwfzYMftqCYFl/iskjwaBREcrSACoaj5u6/UvcFHz+uGWdqjuq+mPrLsLK
         4oyg==
X-Gm-Message-State: AOJu0YyCStjDegj/awAZ69OhIyDkNd90NRC9r4AEHhmYwiG3ZXdayPvH
	Wm2xhhw0+pRblyuFtf4no7Pf7/qU0z8aauftSZMxXHE7PfmjvfUbm1JAjcy8FbS/JIT30g==
X-Google-Smtp-Source: AGHT+IGC9HB79SjiFADEJMdvUMIsjyiGMqsclow0OUbWPcWQeEIwslxVQavWgsvcq85J+GxQSaX3XDDt
X-Received: from wmbhj22.prod.google.com ([2002:a05:600c:5296:b0:43d:5828:13ee])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:1914:b0:43d:47e:3205
 with SMTP id 5b1f17b1804b1-441c48bca55mr21296145e9.11.1746352420214; Sun, 04
 May 2025 02:53:40 -0700 (PDT)
Date: Sun,  4 May 2025 11:52:47 +0200
In-Reply-To: <20250504095230.2932860-25-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250504095230.2932860-25-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=5759; i=ardb@kernel.org;
 h=from:subject; bh=S+tSbPFyOP+LxITxmH/ySCnhoV8I/NLanALIjXIGmXk=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIUPc4quoq/sMs6Mtz/qY7tUtbbg4ZcsiiY4jLe68EaHfp
 rzkbP7QUcrCIMbBICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACZisoXhf+aCD3M6nzT+k6yu
 OCdeXHLm9DLVW6xX/DKDMpfbbHyQOImR4dqmV7XnlnWxPNgiNOtpWY1WqsCaU0G/ZmzS2/x+la6 ALC8A
X-Mailer: git-send-email 2.49.0.906.g1f30a19c02-goog
Message-ID: <20250504095230.2932860-42-ardb+git@google.com>
Subject: [RFT PATCH v2 17/23] x86/sev: Move __sev_[get|put]_ghcb() into
 separate noinstr object
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: linux-efi@vger.kernel.org, x86@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>, 
	Dionna Amalie Glaze <dionnaglaze@google.com>, Kevin Loughlin <kevinloughlin@google.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Rename sev-nmi.c to sev-noinstr.c, and move the get/put GHCB routines
into it too.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/startup/sev-startup.c            | 75 --------------------
 arch/x86/coco/sev/Makefile                     |  6 +-
 arch/x86/coco/sev/{sev-nmi.c => sev-noinstr.c} | 74 +++++++++++++++++++
 3 files changed, 77 insertions(+), 78 deletions(-)

diff --git a/arch/x86/boot/startup/sev-startup.c b/arch/x86/boot/startup/sev-startup.c
index 2c2a5a043f18..6ba50723d546 100644
--- a/arch/x86/boot/startup/sev-startup.c
+++ b/arch/x86/boot/startup/sev-startup.c
@@ -41,84 +41,9 @@
 #include <asm/cpuid.h>
 #include <asm/cmdline.h>
 
-
-/*
- * Nothing shall interrupt this code path while holding the per-CPU
- * GHCB. The backup GHCB is only for NMIs interrupting this path.
- *
- * Callers must disable local interrupts around it.
- */
-noinstr struct ghcb *__sev_get_ghcb(struct ghcb_state *state)
-{
-	struct sev_es_runtime_data *data;
-	struct ghcb *ghcb;
-
-	WARN_ON(!irqs_disabled());
-
-	data = this_cpu_read(runtime_data);
-	ghcb = &data->ghcb_page;
-
-	if (unlikely(data->ghcb_active)) {
-		/* GHCB is already in use - save its contents */
-
-		if (unlikely(data->backup_ghcb_active)) {
-			/*
-			 * Backup-GHCB is also already in use. There is no way
-			 * to continue here so just kill the machine. To make
-			 * panic() work, mark GHCBs inactive so that messages
-			 * can be printed out.
-			 */
-			data->ghcb_active        = false;
-			data->backup_ghcb_active = false;
-
-			instrumentation_begin();
-			panic("Unable to handle #VC exception! GHCB and Backup GHCB are already in use");
-			instrumentation_end();
-		}
-
-		/* Mark backup_ghcb active before writing to it */
-		data->backup_ghcb_active = true;
-
-		state->ghcb = &data->backup_ghcb;
-
-		/* Backup GHCB content */
-		*state->ghcb = *ghcb;
-	} else {
-		state->ghcb = NULL;
-		data->ghcb_active = true;
-	}
-
-	return ghcb;
-}
-
 /* Include code shared with pre-decompression boot stage */
 #include "sev-shared.c"
 
-noinstr void __sev_put_ghcb(struct ghcb_state *state)
-{
-	struct sev_es_runtime_data *data;
-	struct ghcb *ghcb;
-
-	WARN_ON(!irqs_disabled());
-
-	data = this_cpu_read(runtime_data);
-	ghcb = &data->ghcb_page;
-
-	if (state->ghcb) {
-		/* Restore GHCB from Backup */
-		*ghcb = *state->ghcb;
-		data->backup_ghcb_active = false;
-		state->ghcb = NULL;
-	} else {
-		/*
-		 * Invalidate the GHCB so a VMGEXIT instruction issued
-		 * from userspace won't appear to be valid.
-		 */
-		vc_ghcb_invalidate(ghcb);
-		data->ghcb_active = false;
-	}
-}
-
 void __head
 early_set_pages_state(unsigned long vaddr, unsigned long paddr,
 		      unsigned long npages, enum psc_op op)
diff --git a/arch/x86/coco/sev/Makefile b/arch/x86/coco/sev/Makefile
index db3255b979bd..b348c9486315 100644
--- a/arch/x86/coco/sev/Makefile
+++ b/arch/x86/coco/sev/Makefile
@@ -1,9 +1,9 @@
 # SPDX-License-Identifier: GPL-2.0
 
-obj-y += core.o sev-nmi.o vc-handle.o
+obj-y += core.o sev-noinstr.o vc-handle.o
 
 # Clang 14 and older may fail to respect __no_sanitize_undefined when inlining
-UBSAN_SANITIZE_sev-nmi.o	:= n
+UBSAN_SANITIZE_sev-noinstr.o	:= n
 
 # GCC may fail to respect __no_sanitize_address when inlining
-KASAN_SANITIZE_sev-nmi.o	:= n
+KASAN_SANITIZE_sev-noinstr.o	:= n
diff --git a/arch/x86/coco/sev/sev-nmi.c b/arch/x86/coco/sev/sev-noinstr.c
similarity index 61%
rename from arch/x86/coco/sev/sev-nmi.c
rename to arch/x86/coco/sev/sev-noinstr.c
index d8dfaddfb367..b527eafb6312 100644
--- a/arch/x86/coco/sev/sev-nmi.c
+++ b/arch/x86/coco/sev/sev-noinstr.c
@@ -106,3 +106,77 @@ void noinstr __sev_es_nmi_complete(void)
 
 	__sev_put_ghcb(&state);
 }
+
+/*
+ * Nothing shall interrupt this code path while holding the per-CPU
+ * GHCB. The backup GHCB is only for NMIs interrupting this path.
+ *
+ * Callers must disable local interrupts around it.
+ */
+noinstr struct ghcb *__sev_get_ghcb(struct ghcb_state *state)
+{
+	struct sev_es_runtime_data *data;
+	struct ghcb *ghcb;
+
+	WARN_ON(!irqs_disabled());
+
+	data = this_cpu_read(runtime_data);
+	ghcb = &data->ghcb_page;
+
+	if (unlikely(data->ghcb_active)) {
+		/* GHCB is already in use - save its contents */
+
+		if (unlikely(data->backup_ghcb_active)) {
+			/*
+			 * Backup-GHCB is also already in use. There is no way
+			 * to continue here so just kill the machine. To make
+			 * panic() work, mark GHCBs inactive so that messages
+			 * can be printed out.
+			 */
+			data->ghcb_active        = false;
+			data->backup_ghcb_active = false;
+
+			instrumentation_begin();
+			panic("Unable to handle #VC exception! GHCB and Backup GHCB are already in use");
+			instrumentation_end();
+		}
+
+		/* Mark backup_ghcb active before writing to it */
+		data->backup_ghcb_active = true;
+
+		state->ghcb = &data->backup_ghcb;
+
+		/* Backup GHCB content */
+		*state->ghcb = *ghcb;
+	} else {
+		state->ghcb = NULL;
+		data->ghcb_active = true;
+	}
+
+	return ghcb;
+}
+
+noinstr void __sev_put_ghcb(struct ghcb_state *state)
+{
+	struct sev_es_runtime_data *data;
+	struct ghcb *ghcb;
+
+	WARN_ON(!irqs_disabled());
+
+	data = this_cpu_read(runtime_data);
+	ghcb = &data->ghcb_page;
+
+	if (state->ghcb) {
+		/* Restore GHCB from Backup */
+		*ghcb = *state->ghcb;
+		data->backup_ghcb_active = false;
+		state->ghcb = NULL;
+	} else {
+		/*
+		 * Invalidate the GHCB so a VMGEXIT instruction issued
+		 * from userspace won't appear to be valid.
+		 */
+		vc_ghcb_invalidate(ghcb);
+		data->ghcb_active = false;
+	}
+}
-- 
2.49.0.906.g1f30a19c02-goog


