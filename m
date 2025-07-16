Return-Path: <linux-efi+bounces-4363-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB9D6B06C2A
	for <lists+linux-efi@lfdr.de>; Wed, 16 Jul 2025 05:24:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18987560306
	for <lists+linux-efi@lfdr.de>; Wed, 16 Jul 2025 03:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71F6B2882BD;
	Wed, 16 Jul 2025 03:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j1yuh360"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F243287254
	for <linux-efi@vger.kernel.org>; Wed, 16 Jul 2025 03:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752636160; cv=none; b=t1z1Zbh+37ZUQW1uhQbStNYWAf7LX15toOLWppOuuxockIHhfVdkxQj9IQAgfvp+C00IOCwtp2k5z0J5mx4i9ry6/mrGmId6IM02Wy/xG4IQUAQHOvT+/j6JXArbbY9Or/XgpbTu603wlRqVHsb8cyBnFrEQGkrtfavwb8vtzR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752636160; c=relaxed/simple;
	bh=c6F8U57CNwQO9LBMP2pJv8Ns/R2toG/98czmofLbweE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aCiVs/U6Fk2LKZsqZfdxykA8raOXExzuCSAUV1Ay72q+M2KWAIB31w20I2eAxRf6O+y3ZYbyzcumbXYxjQWJybsK30vaOUxoDx4bjwWEwmrHFnpEyw59ZLX+TNwyBZCW8qUebRiUGkNyRhSGjemFtDhgn3IChUOsEIOrVyv7k4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j1yuh360; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-45600d19a2aso31706885e9.1
        for <linux-efi@vger.kernel.org>; Tue, 15 Jul 2025 20:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752636157; x=1753240957; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=my9gyPV7GpUhZ0j1D85su1Gd7h1qi/PaVo/yjWf1hSg=;
        b=j1yuh360uLJkLKerY0MTIVLVui4kUsnlJmu6oVFwHrwbkPtsrr4SyIo+HpbyluBG1D
         1g6TjwxUBMDevQGRrjQVWMIhl3YLEYyUFnHmCr3t7y1qDHC6wytA1qYUgwTwQdTSIUx3
         tKzrpc65HyqvkWyARsbwr+QdWxntw9n3tc/1bThJmjr5BeGLmCRq6CmOSMQIda2j9NsK
         EeHV9WbXwBcht9MkBXU3W8PduI8NGGr1MHm9Fp9Z4a2Dn1zBf2g6hHxI1EG527BT6pFx
         DCv2NCnlx1lVjv9AOEMLDw8tXJktFJ+8ITwA361dnsMwwKtlNJ9jygDCLaiifY9xWz8s
         JH0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752636157; x=1753240957;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=my9gyPV7GpUhZ0j1D85su1Gd7h1qi/PaVo/yjWf1hSg=;
        b=AoSWHyI7BKXBB8KW6jQ9PqEVV4xEQP0d+NDDrlh/J26QNTxZGCLsagek1O/uV/0voy
         JvyHalVReMO6L5SBrOEUWId5DIJJSASrpIRKryhldB6ox+Li6Vg6XZnEcYHFS3/Tde/T
         terWcBuHo5LGgEUGGZjcA7EnMirg/LYSjRQObOJd2B6/CPTa5vm3Kjw2mzoH68etDvv5
         8gpCkCL+SSE5f/nr6dTsL0PfLuFwQReZ1RKBlaXJlU4D8V2aIkrmVBGzAFPV47Bc/3X0
         vjwIRQEciZZAmuifAb8DQU2po/98/szz0cXCMVtVIS9z2M/qe10yyRqJ+L7m6okSVZbw
         833A==
X-Gm-Message-State: AOJu0YwqUDXAchuUCBKMcc3eU1aieSvzVitqlV+KmcIKXeXZ9PaiNNB7
	vTKoyhsmZlx1ySt094D2ZSmi0mjUYwm8/+SIFL8mATPyWPT/R/3A3hHN8sZffi3eeqeWeFNaMw=
	=
X-Google-Smtp-Source: AGHT+IGslqQ23Wi8fxCMq+Pc6u3PM8vlZFV0M8FN7RcONMrupNbWvmshZEZh+3xpbkolkKhaXNe4Bgof
X-Received: from wmrn13.prod.google.com ([2002:a05:600c:500d:b0:456:1d9b:2a5d])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:64ce:b0:455:f59e:fd79
 with SMTP id 5b1f17b1804b1-4562e33d64emr8756805e9.11.1752636157081; Tue, 15
 Jul 2025 20:22:37 -0700 (PDT)
Date: Wed, 16 Jul 2025 05:18:24 +0200
In-Reply-To: <20250716031814.2096113-24-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250716031814.2096113-24-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=5481; i=ardb@kernel.org;
 h=from:subject; bh=CWmGYplgo2z5qlfvc2ln3Mz6KFj9XYcKFlTVXqEMNjg=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIaNcSvs7Z4JTaMLj76+4J5wQy3utepUlOVFfQd1hT0PJU
 TdXI/eOUhYGMS4GWTFFFoHZf9/tPD1RqtZ5lizMHFYmkCEMXJwCMBGHSob/Uc8XmW3JXa40wZrl
 +ZQfpcJ8V2vXJ4u7L7SN/dCclDEzmJHh2gnnOx87JV/wNnH23LO00O02y/rDc79moqX0kh8pF9R 4AA==
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250716031814.2096113-33-ardb+git@google.com>
Subject: [PATCH v5 09/22] x86/sev: Use boot SVSM CA for all startup and init code
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: linux-efi@vger.kernel.org, x86@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>, 
	Kevin Loughlin <kevinloughlin@google.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Nikunj A Dadhania <nikunj@amd.com>
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
 arch/x86/boot/startup/sev-startup.c |  7 +--
 arch/x86/coco/sev/core.c            | 47 +++++++++-----------
 arch/x86/include/asm/sev-internal.h | 16 -------
 4 files changed, 24 insertions(+), 59 deletions(-)

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index 18b0ccf517eb..4bdf5595ed96 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -37,19 +37,6 @@ struct ghcb *boot_ghcb;
 
 #define __BOOT_COMPRESSED
 
-extern u64 boot_svsm_caa_pa;
-
-struct svsm_ca *svsm_get_caa(void)
-{
-	/* The decompressor is mapped 1:1 so VA == PA */
-	return (struct svsm_ca *)boot_svsm_caa_pa;
-}
-
-u64 svsm_get_caa_pa(void)
-{
-	return boot_svsm_caa_pa;
-}
-
 u8 snp_vmpl;
 
 /* Include code for early handlers */
diff --git a/arch/x86/boot/startup/sev-startup.c b/arch/x86/boot/startup/sev-startup.c
index 7aabda0b378e..8e804369cc60 100644
--- a/arch/x86/boot/startup/sev-startup.c
+++ b/arch/x86/boot/startup/sev-startup.c
@@ -50,9 +50,6 @@ u64 sev_secrets_pa __ro_after_init;
 /* For early boot SVSM communication */
 struct svsm_ca boot_svsm_ca_page __aligned(PAGE_SIZE);
 
-DEFINE_PER_CPU(struct svsm_ca *, svsm_caa);
-DEFINE_PER_CPU(u64, svsm_caa_pa);
-
 /*
  * Nothing shall interrupt this code path while holding the per-CPU
  * GHCB. The backup GHCB is only for NMIs interrupting this path.
@@ -167,7 +164,7 @@ void __head early_snp_set_memory_private(unsigned long vaddr, unsigned long padd
 	  * table.
 	  */
 	early_set_pages_state(vaddr, paddr, npages, SNP_PAGE_STATE_PRIVATE,
-			      svsm_get_caa(), svsm_get_caa_pa());
+			      rip_rel_ptr(&boot_svsm_ca_page), boot_svsm_caa_pa);
 }
 
 void __head early_snp_set_memory_shared(unsigned long vaddr, unsigned long paddr,
@@ -184,7 +181,7 @@ void __head early_snp_set_memory_shared(unsigned long vaddr, unsigned long paddr
 
 	 /* Ask hypervisor to mark the memory pages shared in the RMP table. */
 	early_set_pages_state(vaddr, paddr, npages, SNP_PAGE_STATE_SHARED,
-			      svsm_get_caa(), svsm_get_caa_pa());
+			      rip_rel_ptr(&boot_svsm_ca_page), boot_svsm_caa_pa);
 }
 
 /*
diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index 7a86a2fe494d..4fe0928bc0ad 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -46,6 +46,25 @@
 #include <asm/cmdline.h>
 #include <asm/msr.h>
 
+DEFINE_PER_CPU(struct svsm_ca *, svsm_caa);
+DEFINE_PER_CPU(u64, svsm_caa_pa);
+
+static inline struct svsm_ca *svsm_get_caa(void)
+{
+	if (sev_cfg.use_cas)
+		return this_cpu_read(svsm_caa);
+	else
+		return rip_rel_ptr(&boot_svsm_ca_page);
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
@@ -1287,7 +1306,8 @@ static void __init alloc_runtime_data(int cpu)
 		struct svsm_ca *caa;
 
 		/* Allocate the SVSM CA page if an SVSM is present */
-		caa = memblock_alloc_or_panic(sizeof(*caa), PAGE_SIZE);
+		caa = cpu ? memblock_alloc_or_panic(sizeof(*caa), PAGE_SIZE)
+			  : &boot_svsm_ca_page;
 
 		per_cpu(svsm_caa, cpu) = caa;
 		per_cpu(svsm_caa_pa, cpu) = __pa(caa);
@@ -1341,32 +1361,9 @@ void __init sev_es_init_vc_handling(void)
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
index 3b72d8217827..bdfe008120f3 100644
--- a/arch/x86/include/asm/sev-internal.h
+++ b/arch/x86/include/asm/sev-internal.h
@@ -63,22 +63,6 @@ DECLARE_PER_CPU(u64, svsm_caa_pa);
 
 extern u64 boot_svsm_caa_pa;
 
-static __always_inline struct svsm_ca *svsm_get_caa(void)
-{
-	if (sev_cfg.use_cas)
-		return this_cpu_read(svsm_caa);
-	else
-		return rip_rel_ptr(&boot_svsm_ca_page);
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
2.50.0.727.gbf7dc18ff4-goog


