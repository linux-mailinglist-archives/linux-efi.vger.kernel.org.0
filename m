Return-Path: <linux-efi+bounces-4634-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F0DB399A3
	for <lists+linux-efi@lfdr.de>; Thu, 28 Aug 2025 12:24:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6AEF77B1346
	for <lists+linux-efi@lfdr.de>; Thu, 28 Aug 2025 10:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDF6930DD38;
	Thu, 28 Aug 2025 10:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eHOrFUXX"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8AD330DD07
	for <linux-efi@vger.kernel.org>; Thu, 28 Aug 2025 10:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756376568; cv=none; b=Ydxb9cRA/P/32aXrjxtc7zcsIFUgv6KBzgPfKBHzercURASLGxP4h26RIr3R18JWucCASzAHh9rkk3xgRcRJ9IeG9VlSCnK2uufiRgXni9DJeYBCa7ywlHnpq0K03eHbgPsVoaZwe5wqt7PMc8hKUQoZiMoxHZq1YIxBv8qez1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756376568; c=relaxed/simple;
	bh=kbRhLjsFsfQOfcNbfvEEZZaC8ogzs16ItYPudW2bum4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=f17k3DwN4gdW27XjwSowJHTjMfLpJ6QE7t8AQg4y3FdF04hS8C49EOCemNa3BCadMPSbteH+MzWYBZGgwd3u94LiMpwFFc7U5uFE7ZWw7W5x6iDPD+Ku1ik2mQe74eRN/SoWAU/klhV4W33Wa3d+zOMSyJt4Hi+b5o0kUmk/MYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eHOrFUXX; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-afe6216085aso60289666b.1
        for <linux-efi@vger.kernel.org>; Thu, 28 Aug 2025 03:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756376565; x=1756981365; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dNkCiWgoJXF1ru1y9bEItu48j6Mp/Zxq2OanWUzF0Jg=;
        b=eHOrFUXXV21Q6VifwZTz99mrbIomB7ihyp5s7KpYcHstyfYyGXdXFg/llYnqtmgXl6
         vOGqs1I11o7ElbMGCKq0j1V6Cog0nlaKsuQ8Ft4xaUQJDDvLFTHg2JzvKJIoUixt01QG
         UvZ8ISv2svYK0BMvXs09hahW23PlcvWJY0Er/lSmnnq5GB77c/qunH4yLGXoBULqo5ps
         RRwLjIHWpJjBDReXuwdSsTumWpfhMZXe9toxEzw1CCK1noEtQj22zvraQCNYJvyRR5bz
         CQV0jVnMhTdGXYubAytoqkJpVGRXbpFeSIgr5X0j/0r32G0ZAzzGVt+DH0DeMvVDTAjJ
         TYew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756376565; x=1756981365;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dNkCiWgoJXF1ru1y9bEItu48j6Mp/Zxq2OanWUzF0Jg=;
        b=lKy2I+y2iw625CD+U25c0FI9XrNgKRZ87PXMhKJEse4CZ7yCsHHIva69eikaPZ4K1f
         00Bt4m4ZbArKWG0G6L/kdkyP88ytgJ+otpiKOZ8V6gDyeVhrFbMJEEP0ABfiYgilDmz8
         oJxEWdKRW7zbML2Ll+8jcAnRquQ2GtR/cLyX3/zL5UGkERviVwwAnyIlYeKiG+Af8vSz
         nDC/WXWsZvKBT04UgHch7EJ4qDEiR43DAjm4LXWEEtfTLfMVxRwPANq7UWuTPdyB0hp9
         sBOgyFsxWJgtk2vKpxGRnWHkQpRUvc9ogzPMClDsGVWVnnCOa7B7yHaPwY7gRB9FLV0j
         FqPw==
X-Gm-Message-State: AOJu0Ywt7gwNvBpoZfqkrlVA/vp+OUQbSobtgtGTOkBLU5DVW3LuYyGa
	UHF7QjLa4aKwzEMRZ2pptmK4923mfdJOxKzB71u2eRwfn1dfdfYWu53h8VqXmISHuWCHn64ZnA=
	=
X-Google-Smtp-Source: AGHT+IEdv7mMg3gEVKaKZBtRemKkta4byG9MVxV52sHDkTP7r/nh6czwtsItRFYYNoPF1QZ7iWCCsV7a
X-Received: from ejcug4.prod.google.com ([2002:a17:907:c8c4:b0:afe:96ea:180d])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a17:907:97cb:b0:afd:d9e3:953f
 with SMTP id a640c23a62f3a-afe296b14edmr2262708566b.63.1756376565039; Thu, 28
 Aug 2025 03:22:45 -0700 (PDT)
Date: Thu, 28 Aug 2025 12:22:12 +0200
In-Reply-To: <20250828102202.1849035-24-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250828102202.1849035-24-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=5360; i=ardb@kernel.org;
 h=from:subject; bh=C0q1ad84KjlSQtQ9LCyoiSGw3tyN88QelZe45Gf2aZQ=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIWOD7tWZ1t0um3+FGXO27vN0sQywvJAWl7qi+tFvpc5a7
 q3N7R4dpSwMYlwMsmKKLAKz/77beXqiVK3zLFmYOaxMIEMYuDgFYCKaqgz/Ey9vmrmW99ze48sS
 4++9m1k4bffn+S8XNbkd27ks/+5UzWsM/+sf6Rhf05EUTWdzD5p3P9tE8Y5RWuK58zdmMvy+8YF RnB0A
X-Mailer: git-send-email 2.51.0.268.g9569e192d0-goog
Message-ID: <20250828102202.1849035-33-ardb+git@google.com>
Subject: [PATCH v7 09/22] x86/sev: Use boot SVSM CA for all startup and init code
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
 arch/x86/boot/startup/sev-startup.c | 11 ++---
 arch/x86/coco/sev/core.c            | 47 +++++++++-----------
 arch/x86/include/asm/sev-internal.h | 16 -------
 4 files changed, 28 insertions(+), 59 deletions(-)

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index dffe607e6d8b..de73da526577 100644
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
index 8009a37d53c1..b0fc63f8dee1 100644
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
@@ -153,7 +150,9 @@ void __head early_snp_set_memory_private(unsigned long vaddr, unsigned long padd
 					 unsigned long npages)
 {
 	struct psc_desc d = {
-		SNP_PAGE_STATE_PRIVATE, svsm_get_caa(), svsm_get_caa_pa()
+		SNP_PAGE_STATE_PRIVATE,
+		rip_rel_ptr(&boot_svsm_ca_page),
+		boot_svsm_caa_pa
 	};
 
 	/*
@@ -176,7 +175,9 @@ void __head early_snp_set_memory_shared(unsigned long vaddr, unsigned long paddr
 					unsigned long npages)
 {
 	struct psc_desc d = {
-		SNP_PAGE_STATE_SHARED, svsm_get_caa(), svsm_get_caa_pa()
+		SNP_PAGE_STATE_SHARED,
+		rip_rel_ptr(&boot_svsm_ca_page),
+		boot_svsm_caa_pa
 	};
 
 	/*
diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index a833b2b31d3d..9782ebe30675 100644
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
@@ -1312,7 +1331,8 @@ static void __init alloc_runtime_data(int cpu)
 		struct svsm_ca *caa;
 
 		/* Allocate the SVSM CA page if an SVSM is present */
-		caa = memblock_alloc_or_panic(sizeof(*caa), PAGE_SIZE);
+		caa = cpu ? memblock_alloc_or_panic(sizeof(*caa), PAGE_SIZE)
+			  : &boot_svsm_ca_page;
 
 		per_cpu(svsm_caa, cpu) = caa;
 		per_cpu(svsm_caa_pa, cpu) = __pa(caa);
@@ -1366,32 +1386,9 @@ void __init sev_es_init_vc_handling(void)
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
index 9ff824540b48..f98f080410ad 100644
--- a/arch/x86/include/asm/sev-internal.h
+++ b/arch/x86/include/asm/sev-internal.h
@@ -62,22 +62,6 @@ DECLARE_PER_CPU(u64, svsm_caa_pa);
 
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
2.51.0.268.g9569e192d0-goog


