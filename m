Return-Path: <linux-efi+bounces-4445-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3050B0D323
	for <lists+linux-efi@lfdr.de>; Tue, 22 Jul 2025 09:33:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4056918937A0
	for <lists+linux-efi@lfdr.de>; Tue, 22 Jul 2025 07:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B319C2DCF4A;
	Tue, 22 Jul 2025 07:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q6I5RBFL"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D602DAFA3
	for <linux-efi@vger.kernel.org>; Tue, 22 Jul 2025 07:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753169402; cv=none; b=ZZJO+b2/nS8XHGjYVq6gR+pjUrOvvB3wG1HVADcjqbeknTtnZHo6HMqsyGEsEh8R1XM90eZadt7AhEyYsZrk2ndBUINz26Fh3Taqbo72c1c84lKVFOlDVYjKzBF43aRRF5zb+uSCL9b4HzhlURCe4Lq9ssSHlrq+1G7VRIx1o7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753169402; c=relaxed/simple;
	bh=F4GGrXQWJpn+IE4X0hI0Q7l6iGGha3gkPT7tK9TWOE0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NRVLYon/qm8yVo2PeS/7ydtU/Q3jvHXhbQg/uRe2LIyeHPYjYcNQzVNEqN7STpvwXVL++pLk4wVVUq9UiMSvzfyFhIcqjl+cQvIfl0PVQeC/6DHL72marHfXNVSymct3GfZAhtm1WYDXx44p9h0jDRlNfFb3Cs6qWrUwOnEpWmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q6I5RBFL; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-ae708b158f2so484622966b.3
        for <linux-efi@vger.kernel.org>; Tue, 22 Jul 2025 00:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753169399; x=1753774199; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Dc7ioZTDG8dak/c8Dymf0TAZzxDxWJ7AYZQNsj1jaTY=;
        b=q6I5RBFLPMQPMCxVROf/WEGCYLEg6F0YH+TViUGUwGgea15+DB5qCj/IO7vISSCImw
         L1UdjQu5WH5iVQ9jyCZP07MvE9t5taf1lJZlsWh/ESLw0nQJLIHnEd2gyFU1lTllttSK
         N0xFrgkNob6goZTsTdkhX2/XgNYRs7kTGOrgZzIL6Yydfz6e1ahJZSk407WRhiQurm6H
         exVa3bWKOYtue9pcze89Q0ZkLWC7WdroOgsIiS2rbr6RpCJpa8LbxH3zQ+kONfVcCKEu
         JWQFuPlAVzoIyV4ejW0dz2KYEM+Oyp5LxoKouV3fA6smALK3nO9za+3yZQz74jVh2R0a
         tE8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753169399; x=1753774199;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dc7ioZTDG8dak/c8Dymf0TAZzxDxWJ7AYZQNsj1jaTY=;
        b=j6vAihX6vD4DPVotOa6/Djhn4sFEE9aATvciimcNiinlujqPGk8TetLAiLeP8I6MPx
         fep2tXXaT7pnKzoctxAx8YLFt2t1PtMSsCcz5gwIHanau5F7klVjqqn0zWi4LQcPk15z
         igKeAEEYDZs9+kDYON4pAcqg4AlSd5jCmutaSVmYntzg0wZRqrgCVwwdKTQY45F1Ox8S
         2ty4V1x7ClMBjbY1k5qJ8eggNjUrao5n4KWwcpP9jBIznUsoanx/pQfXLYwvI3X+xLhb
         wIJjXK+yybyUhiCSTiyJ/yfpqtzS/OlFc9hdLPr+49Xf/fPULEawLXUS7ItBVuiW3fPP
         glXg==
X-Gm-Message-State: AOJu0YwJm51tR8HPZ5gaNv6EbkQCV+hvLdVOdCCKURwYzDlnnackRF+q
	Yjgy2QaJPcU8wXLfO29nHmHeO0VfQC33XeaMJ2YOlvw/ud1l793LE9+8KmlzRrIK413Q1STRLQ=
	=
X-Google-Smtp-Source: AGHT+IGFC3i6TV46/FHVJ7XlKvlXXseDbsOWjOBT2bwYV8b0c9a09n+NkEFxzJUxUmUh9w15L4cyCxyH
X-Received: from ejczh18.prod.google.com ([2002:a17:907:e912:b0:ae9:ba12:ebd1])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a17:907:501e:b0:ae3:8c9b:bd61
 with SMTP id a640c23a62f3a-aec4fa438c3mr1257714766b.12.1753169398866; Tue, 22
 Jul 2025 00:29:58 -0700 (PDT)
Date: Tue, 22 Jul 2025 09:27:18 +0200
In-Reply-To: <20250722072708.2079165-24-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250722072708.2079165-24-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=5481; i=ardb@kernel.org;
 h=from:subject; bh=U5+R57w6urjcMH6V7vXc1AZ3AS7l8D6IN1d+7fzQ4zE=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIaPetkqz8zGn1tmMtLJM1d21qSfz2UsFeHekhusJfa164
 RVj9rSjlIVBjItBVkyRRWD233c7T0+UqnWeJQszh5UJZAgDF6cATKT5CcM/zYU7F9WZWSi0z154
 M0PJ6J/HTHGWQznnrv2xftvicEpVk+G/T+dj/XdKH//OfK30RFrondclc/fZ/+Uv+W223Ve6cU4 OMwA=
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250722072708.2079165-33-ardb+git@google.com>
Subject: [PATCH v6 09/22] x86/sev: Use boot SVSM CA for all startup and init code
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
index 22b8667310d5..55fc6d0641d3 100644
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


