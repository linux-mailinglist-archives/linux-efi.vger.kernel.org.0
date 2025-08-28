Return-Path: <linux-efi+bounces-4637-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D5D7B399AC
	for <lists+linux-efi@lfdr.de>; Thu, 28 Aug 2025 12:25:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06A0F1BA156B
	for <lists+linux-efi@lfdr.de>; Thu, 28 Aug 2025 10:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E56A530EF98;
	Thu, 28 Aug 2025 10:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HhaSUBBm"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D6630E0DD
	for <linux-efi@vger.kernel.org>; Thu, 28 Aug 2025 10:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756376573; cv=none; b=QLlAX8j6aWAdMzxNhSblkN91+W8Hw64Z2kR/YZUABsR8iLIvvsNnOxyIufVVXg9gfe0GjLhWdlPW2REwMtfB1gk+tAxZsjk2uYgw2rn7jSD9p7OdtFPsagrNy1RFOggMHs2tpeSYMoEK41YM/O9dOm/VAKoqscCiAz27LsG+mWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756376573; c=relaxed/simple;
	bh=95eytKerMntb0xoZ2LLXP2V9tAvxXcbUbLq2gM3XUuc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SUTLIyZDkCj/dDbaujMRuM8cwYaQMm7eAhMcXrsDmK/NP3c1xgAJnLhiyCVjSxKIDvKt26PKLUUrE27mLHwKgPJETn/ssPTegJQI81qJMzTYox9HHbHpRnhxmORhV2+LwhcgV2FznUrR+Yjb7q/Dr/EKynh1JhlfcmIsfjPmUHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HhaSUBBm; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-45b71fe31ffso4578895e9.2
        for <linux-efi@vger.kernel.org>; Thu, 28 Aug 2025 03:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756376570; x=1756981370; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=U+ZCCxTQoTCPao1KGzvcRQdS6JKcYVTRlRuQtQ6ys2Q=;
        b=HhaSUBBmLWoWraRmf6CncdPxwK31ibvWtNfQbPzWOUoQXsWHczlxTuoDdH3Gunhuw0
         2ADgxc3uuE8RUjSjy6gE0gG4UOe4wpKwBnVddxjxfFhMfSUnFc0OFAmihpmJibt5N/OZ
         wZTBg7uEokvEv15fGrW65WohkD+KlrV8AKB4OGD2RNziHghvTXcfqslJki2wBTrOhGhZ
         hP/yzbXJY4SH37td+4atrPlT0V8R2/Xo8ryibrBP0BbEJMA+DLyjzMVDCDLSMi+5QBft
         GXtnRaiYqkIX1UCMo7CYPMmqibpS+WQAzBpggidLzBtpkxdUsLNaIxihbXc4qkBiwGeU
         9M+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756376570; x=1756981370;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U+ZCCxTQoTCPao1KGzvcRQdS6JKcYVTRlRuQtQ6ys2Q=;
        b=iyYi8KxHNDm0lXGqYuN7c3oFotmCBxQgOfi9QrN1PJXJoGQLAQZOyNYaQa9tFp+AsX
         lNGSPJ9G6KDrZXu/xo3q3MBpIgbLG5hgtlZLszpJlLV1TtaXRytgJFFy1dWRg19aLKOs
         1utcotkHQrtaTXq29reU77QL1TD/VxwBLJ2624ww0wqeCXFceUI4PTgkRHTSnBS+EF58
         sak2unXkYqPIUPk0xuFXH78ImYhISmrVLukilwuDqHNiBYEncLVPa23+pj7d+GSfR5eN
         SN1QzTUkHJS91n3px4TsL1is1nIHNcIRSqp7r7DZlvmKCNqQHxB2FasRGKsCkxsCmqqX
         IvBQ==
X-Gm-Message-State: AOJu0Yxa5juWtEZJR5iDtMVPYkOsMwPi5ULbG3GHVMvF2QFHf0GKtXKI
	ldkFG5cZYyoKBD12imlQ3Z29UmMDcglIscAx2cNhz9uYzAH8uhLdxzRBzpEADUeNagj418TkjA=
	=
X-Google-Smtp-Source: AGHT+IGvnR4G+9YkF+RVoXJvYh+q2PmQd3U9b7j4Ed7TzaWCj7E2ufT3qSlSKlyNol5Bm/iKq6hNJiYY
X-Received: from wmbel18.prod.google.com ([2002:a05:600c:3e12:b0:45b:732e:5a16])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:1c04:b0:45b:772b:12b9
 with SMTP id 5b1f17b1804b1-45b772b146emr18870715e9.15.1756376570076; Thu, 28
 Aug 2025 03:22:50 -0700 (PDT)
Date: Thu, 28 Aug 2025 12:22:16 +0200
In-Reply-To: <20250828102202.1849035-24-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250828102202.1849035-24-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=6041; i=ardb@kernel.org;
 h=from:subject; bh=ZJUXkLzG6HR7JSAtBmXd60VbGlAeVNlhB/oKEMBDNYE=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIWOD7q2vTz8YzM1b/dwtzmMv81rGOX22R/5uLrue1Nymv
 np1gOfEjlIWBjEuBlkxRRaB2X/f7Tw9UarWeZYszBxWJpAhDFycAjARoUmMDA86ldxEMjmMMr4X
 dcebWFTr18ezr5p3veidZlRq4eTk14wMHxeW/f92RVzxZbrI6bDjz1rX7WMMKvVUTNh4ev4cByU ObgA=
X-Mailer: git-send-email 2.51.0.268.g9569e192d0-goog
Message-ID: <20250828102202.1849035-37-ardb+git@google.com>
Subject: [PATCH v7 13/22] x86/sev: Move __sev_[get|put]_ghcb() into separate
 noinstr object
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: linux-efi@vger.kernel.org, x86@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>, 
	Kevin Loughlin <kevinloughlin@google.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Nikunj A Dadhania <nikunj@amd.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Rename sev-nmi.c to noinstr.c, and move the get/put GHCB routines
into it too, which are also annotated as 'noinstr' and suffer from the
same problem as the NMI code, i.e., that GCC may ignore the
__no_sanitize_address__ function attribute implied by 'noinstr' and
insert KASAN instrumentation anyway.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/startup/sev-startup.c        | 74 --------------------
 arch/x86/coco/sev/Makefile                 |  8 +--
 arch/x86/coco/sev/{sev-nmi.c => noinstr.c} | 74 ++++++++++++++++++++
 3 files changed, 78 insertions(+), 78 deletions(-)

diff --git a/arch/x86/boot/startup/sev-startup.c b/arch/x86/boot/startup/sev-startup.c
index 138b26f14ff1..9f4b4ca7deaa 100644
--- a/arch/x86/boot/startup/sev-startup.c
+++ b/arch/x86/boot/startup/sev-startup.c
@@ -41,83 +41,9 @@
 #include <asm/cpuid/api.h>
 #include <asm/cmdline.h>
 
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
 		      unsigned long npages, const struct psc_desc *desc)
diff --git a/arch/x86/coco/sev/Makefile b/arch/x86/coco/sev/Makefile
index 342d79f0ab6a..3b8ae214a6a6 100644
--- a/arch/x86/coco/sev/Makefile
+++ b/arch/x86/coco/sev/Makefile
@@ -1,10 +1,10 @@
 # SPDX-License-Identifier: GPL-2.0
 
-obj-y += core.o sev-nmi.o vc-handle.o
+obj-y += core.o noinstr.o vc-handle.o
 
 # Clang 14 and older may fail to respect __no_sanitize_undefined when inlining
-UBSAN_SANITIZE_sev-nmi.o	:= n
+UBSAN_SANITIZE_noinstr.o	:= n
 
 # GCC may fail to respect __no_sanitize_address or __no_kcsan when inlining
-KASAN_SANITIZE_sev-nmi.o	:= n
-KCSAN_SANITIZE_sev-nmi.o	:= n
+KASAN_SANITIZE_noinstr.o	:= n
+KCSAN_SANITIZE_noinstr.o	:= n
diff --git a/arch/x86/coco/sev/sev-nmi.c b/arch/x86/coco/sev/noinstr.c
similarity index 61%
rename from arch/x86/coco/sev/sev-nmi.c
rename to arch/x86/coco/sev/noinstr.c
index d8dfaddfb367..b527eafb6312 100644
--- a/arch/x86/coco/sev/sev-nmi.c
+++ b/arch/x86/coco/sev/noinstr.c
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
2.51.0.268.g9569e192d0-goog


