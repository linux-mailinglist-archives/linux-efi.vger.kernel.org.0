Return-Path: <linux-efi+bounces-3561-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3CC2AA85AD
	for <lists+linux-efi@lfdr.de>; Sun,  4 May 2025 11:54:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CBA13BC03D
	for <lists+linux-efi@lfdr.de>; Sun,  4 May 2025 09:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA8241C8621;
	Sun,  4 May 2025 09:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BuSWy7FD"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF6F1C6FF6
	for <linux-efi@vger.kernel.org>; Sun,  4 May 2025 09:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746352408; cv=none; b=KPwzBmrLNZv35bXvSdNqU/QfdiO+iWxE3ORzs619f6Krjo/jppyL8c57uIP2FG1+AAjLB2ZJmkRJqG/cBxF8h6yFjBdBlzA57cFL6EFly5WParwTbz8ZEVzXq9hWgKkdkjrrUVitniBOfyKXM2E03oLEAzuDV1vVgW4xyRuB5YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746352408; c=relaxed/simple;
	bh=Da8gefPc/MkvKcwMBiYhIH1VS9MQxWYpqqsM/kBWj2k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rHZnQdmm0QAKDEfyJeTvrKdPk5rBGQnBd3eKqXrQgESaROGG0OzzUPQ+L4Ib7WDJG1AyIfrlW5AACVTFD5v9hWv/omoaTaiSF8rDl0loJHR6uyLjwzPo+4kqWY6BLBQIWeNZYPL8sAFkGvtYw9yxk2AbJcRO5dXNeMH26I3Xb/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BuSWy7FD; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-43d4d15058dso25195625e9.0
        for <linux-efi@vger.kernel.org>; Sun, 04 May 2025 02:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746352405; x=1746957205; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wX4/+1PkJw6Jnyy4g/DPm+Tnx+UM3RROZEvunHorr8w=;
        b=BuSWy7FDncgofHjWoRwDC6CE6TfX0rM0sSqhhTgOWasCHGF5vfUpoW2keBrQhAk54I
         LIAGVpTK6agyN/80oP+5NaC7KJWKg2/LEoUHZaHQU7c7x0I2mYTUjBwGHfKX68ujlGvN
         1tAs3IAXg7+O/jr7NXS2bcq/izZ0xrF8NicJGKj1mY2QyAoHzAAlXB1CWhGhSD5AEEWx
         oYv/5xQCmGpwJzUqte7IIMWoAvFBN6vKuDczp04Uf40TABhm5qjaHbVlEdvC+5VOtjD2
         uhSRR35gEB238FUeR1iG7xK5zPN0QYkHGa61lD4MwfucKHQrpCz7gdpXqqVir8XnvhiY
         +xXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746352405; x=1746957205;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wX4/+1PkJw6Jnyy4g/DPm+Tnx+UM3RROZEvunHorr8w=;
        b=gtq1siQwfUstXgWIkeJgRt08fB/CbG16dHDGBShrh9ZtiVKyA5UBoeoYqmQMgjyU1X
         071bwfe59V3oBmHwSOc+Omdzr5Pkr6ruNDg8YFkZrqz7LtPKhpeCcNQiTvL04FvdrvOz
         MuzFQ5HCdU6LXaEUMlZxUT4Er6W/UBdee+K01UxhsMh4mv3qukOGkSsWV47aijRDmdJI
         iIV9jNNSpwFmJncLZnox5gyvvkojCDMGUX6ytTpCGIx59gWnDHEWWiY2kQvfsjzq+t5/
         WBYQ4VvG2Fa6SHMuEaJXNMP/90UqdHhqzQqZa7NFzIsUk4SoQCrdko4B6ekBIAazREkz
         fN0w==
X-Gm-Message-State: AOJu0YzhVHt6HJKSpjtU2/9ZeZlMifurGCC4tReRoTi4xtSXka1vinyJ
	a5mqlZODetXdx2SW30nJMqTpxrcByJuEEpu8FTgULDRfAEJwgGjewQhdgsz6mKbjs38CgA==
X-Google-Smtp-Source: AGHT+IFjslrWfCH+uAS9ty2elKHdVUzc19rUudtpTn5fWKEmJz4qLk7mVsC2Sil+38bd4AnXTSXFQj40
X-Received: from wmbfl15.prod.google.com ([2002:a05:600c:b8f:b0:441:b38b:9cc3])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:1d8d:b0:440:66a4:8d1a
 with SMTP id 5b1f17b1804b1-441c48aa302mr27049065e9.7.1746352405226; Sun, 04
 May 2025 02:53:25 -0700 (PDT)
Date: Sun,  4 May 2025 11:52:40 +0200
In-Reply-To: <20250504095230.2932860-25-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250504095230.2932860-25-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=6031; i=ardb@kernel.org;
 h=from:subject; bh=xk86JG/R04sMdF0/gJrtMthpOxFG4UyGc1tpigbLlgU=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIUPc4nXQ9wjJM+pm/4+6GIS8y/m44eIDBXutlHcub7IXH
 l8sKfOxo5SFQYyDQVZMkUVg9t93O09PlKp1niULM4eVCWQIAxenAEzkeCkjwxPBGXFRQZWr93Ou
 K6rOal3zYdcLX4buK8Vc0ywtby55YMbIMLM5YiYPz5uIVVcC3mlr3HloMslq0/TtAZ777abPy8m /wwwA
X-Mailer: git-send-email 2.49.0.906.g1f30a19c02-goog
Message-ID: <20250504095230.2932860-35-ardb+git@google.com>
Subject: [RFT PATCH v2 10/23] x86/sev: Use boot SVSM CA for all startup and
 init code
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: linux-efi@vger.kernel.org, x86@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>, 
	Dionna Amalie Glaze <dionnaglaze@google.com>, Kevin Loughlin <kevinloughlin@google.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

To avoid having to reason about whether or not to use the per-CPU SVSM
calling area when running startup and init code on the boot CPU, reuse
the boot SVSM calling area as the per-CPU area for CPU #0.

This removes the need to make the per-CPU variables and associated state
in sev_cfg accessible to the startup code once confined.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/sev.c      | 13 ------
 arch/x86/boot/startup/sev-shared.c  |  4 +-
 arch/x86/boot/startup/sev-startup.c |  6 +--
 arch/x86/coco/sev/core.c            | 47 +++++++++-----------
 arch/x86/include/asm/sev-internal.h | 16 -------
 5 files changed, 26 insertions(+), 60 deletions(-)

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index 9b6eebc24e78..91e8140250f6 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -37,19 +37,6 @@ struct ghcb *boot_ghcb;
 
 #define __BOOT_COMPRESSED
 
-extern struct svsm_ca *boot_svsm_caa;
-extern u64 boot_svsm_caa_pa;
-
-struct svsm_ca *svsm_get_caa(void)
-{
-	return boot_svsm_caa;
-}
-
-u64 svsm_get_caa_pa(void)
-{
-	return boot_svsm_caa_pa;
-}
-
 u8 snp_vmpl;
 
 /* Include code for early handlers */
diff --git a/arch/x86/boot/startup/sev-shared.c b/arch/x86/boot/startup/sev-shared.c
index 0709c8a8655a..b1f4b9b15045 100644
--- a/arch/x86/boot/startup/sev-shared.c
+++ b/arch/x86/boot/startup/sev-shared.c
@@ -585,10 +585,10 @@ static void __head svsm_pval_4k_page(unsigned long paddr, bool validate)
 	 */
 	flags = native_local_irq_save();
 
-	call.caa = svsm_get_caa();
+	call.caa = boot_svsm_caa;
 
 	pc = (struct svsm_pvalidate_call *)call.caa->svsm_buffer;
-	pc_pa = svsm_get_caa_pa() + offsetof(struct svsm_ca, svsm_buffer);
+	pc_pa = boot_svsm_caa_pa + offsetof(struct svsm_ca, svsm_buffer);
 
 	pc->num_entries = 1;
 	pc->cur_index   = 0;
diff --git a/arch/x86/boot/startup/sev-startup.c b/arch/x86/boot/startup/sev-startup.c
index 797ca3e29b12..ca6a9863ffab 100644
--- a/arch/x86/boot/startup/sev-startup.c
+++ b/arch/x86/boot/startup/sev-startup.c
@@ -59,9 +59,6 @@ u64 sev_secrets_pa __ro_after_init;
 /* For early boot SVSM communication */
 struct svsm_ca boot_svsm_ca_page __aligned(PAGE_SIZE);
 
-DEFINE_PER_CPU(struct svsm_ca *, svsm_caa);
-DEFINE_PER_CPU(u64, svsm_caa_pa);
-
 /*
  * Nothing shall interrupt this code path while holding the per-CPU
  * GHCB. The backup GHCB is only for NMIs interrupting this path.
@@ -261,6 +258,7 @@ static __head struct cc_blob_sev_info *find_cc_blob(struct boot_params *bp)
 
 static __head void svsm_setup(struct cc_blob_sev_info *cc_info)
 {
+	struct snp_secrets_page *secrets = (void *)cc_info->secrets_phys;
 	struct svsm_call call = {};
 	int ret;
 	u64 pa;
@@ -289,7 +287,7 @@ static __head void svsm_setup(struct cc_blob_sev_info *cc_info)
 	 *   RAX = 0 (Protocol=0, CallID=0)
 	 *   RCX = New CA GPA
 	 */
-	call.caa = svsm_get_caa();
+	call.caa = (struct svsm_ca *)secrets->svsm_caa;
 	call.rax = SVSM_CORE_CALL(SVSM_CORE_REMAP_CA);
 	call.rcx = pa;
 	ret = svsm_perform_msr_protocol(&call);
diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index 883b2719986d..36edf670ff19 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -45,6 +45,25 @@
 #include <asm/cpuid.h>
 #include <asm/cmdline.h>
 
+DEFINE_PER_CPU(struct svsm_ca *, svsm_caa);
+DEFINE_PER_CPU(u64, svsm_caa_pa);
+
+static inline struct svsm_ca *svsm_get_caa(void)
+{
+	if (sev_cfg.use_cas)
+		return this_cpu_read(svsm_caa);
+	else
+		return boot_svsm_caa;
+}
+
+static inline u64 svsm_get_caa_pa(void)
+{
+	if (sev_cfg.use_cas)
+		return this_cpu_read(svsm_caa_pa);
+	else
+		return boot_svsm_caa_pa;
+}
+
 /* AP INIT values as documented in the APM2  section "Processor Initialization State" */
 #define AP_INIT_CS_LIMIT		0xffff
 #define AP_INIT_DS_LIMIT		0xffff
@@ -1207,7 +1226,8 @@ static void __init alloc_runtime_data(int cpu)
 		struct svsm_ca *caa;
 
 		/* Allocate the SVSM CA page if an SVSM is present */
-		caa = memblock_alloc_or_panic(sizeof(*caa), PAGE_SIZE);
+		caa = cpu ? memblock_alloc_or_panic(sizeof(*caa), PAGE_SIZE)
+			  : boot_svsm_caa;
 
 		per_cpu(svsm_caa, cpu) = caa;
 		per_cpu(svsm_caa_pa, cpu) = __pa(caa);
@@ -1261,32 +1281,9 @@ void __init sev_es_init_vc_handling(void)
 		init_ghcb(cpu);
 	}
 
-	/* If running under an SVSM, switch to the per-cpu CA */
-	if (snp_vmpl) {
-		struct svsm_call call = {};
-		unsigned long flags;
-		int ret;
-
-		local_irq_save(flags);
-
-		/*
-		 * SVSM_CORE_REMAP_CA call:
-		 *   RAX = 0 (Protocol=0, CallID=0)
-		 *   RCX = New CA GPA
-		 */
-		call.caa = svsm_get_caa();
-		call.rax = SVSM_CORE_CALL(SVSM_CORE_REMAP_CA);
-		call.rcx = this_cpu_read(svsm_caa_pa);
-		ret = svsm_perform_call_protocol(&call);
-		if (ret)
-			panic("Can't remap the SVSM CA, ret=%d, rax_out=0x%llx\n",
-			      ret, call.rax_out);
-
+	if (snp_vmpl)
 		sev_cfg.use_cas = true;
 
-		local_irq_restore(flags);
-	}
-
 	sev_es_setup_play_dead();
 
 	/* Secondary CPUs use the runtime #VC handler */
diff --git a/arch/x86/include/asm/sev-internal.h b/arch/x86/include/asm/sev-internal.h
index 0d02e780beb3..4335711274e3 100644
--- a/arch/x86/include/asm/sev-internal.h
+++ b/arch/x86/include/asm/sev-internal.h
@@ -64,22 +64,6 @@ DECLARE_PER_CPU(u64, svsm_caa_pa);
 extern struct svsm_ca *boot_svsm_caa;
 extern u64 boot_svsm_caa_pa;
 
-static __always_inline struct svsm_ca *svsm_get_caa(void)
-{
-	if (sev_cfg.use_cas)
-		return this_cpu_read(svsm_caa);
-	else
-		return boot_svsm_caa;
-}
-
-static __always_inline u64 svsm_get_caa_pa(void)
-{
-	if (sev_cfg.use_cas)
-		return this_cpu_read(svsm_caa_pa);
-	else
-		return boot_svsm_caa_pa;
-}
-
 enum es_result verify_exception_info(struct ghcb *ghcb, struct es_em_ctxt *ctxt);
 void vc_forward_exception(struct es_em_ctxt *ctxt);
 
-- 
2.49.0.906.g1f30a19c02-goog


