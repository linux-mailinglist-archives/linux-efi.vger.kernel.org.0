Return-Path: <linux-efi+bounces-4211-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAE1BAFE20F
	for <lists+linux-efi@lfdr.de>; Wed,  9 Jul 2025 10:12:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF85C3AEAED
	for <lists+linux-efi@lfdr.de>; Wed,  9 Jul 2025 08:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA354273D8E;
	Wed,  9 Jul 2025 08:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NuxZSXdg"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C242A273D89
	for <linux-efi@vger.kernel.org>; Wed,  9 Jul 2025 08:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752048677; cv=none; b=OR3YEqq/AlK8URZYEHdwY/YQAW7axjLX8PY/h8wORVwxa7XJUhaBa+m02EKrmhdaEa0u83tVtEosqpwUDAD3qQtSJ2eivPPX+LDI5ILJTzAiHGqaIs4xx9kJKR3szWcM+ymAFyJcXhv12xeK3Twj3NIcqOzugwS9zQfr8XRTldo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752048677; c=relaxed/simple;
	bh=ItWFSyXoBmB4uVduKx6yBlJXnE8elZdNhG81ejKpu8Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CAwseYkNxs+BK0WW/9+Dnx0aaTgk9msVPPWkU7+1DpVQ/k0snA99C/YqbG+M+J0Fj/g2UwzmDbOi89qg84UxGwZaL9JUPqANVYkFqiaWyhdF0MSYBjhzg5/drrbYlQG51FnUjZYSyIKtpca1No8e+neCghEdXvj7RYGe1sPaa48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NuxZSXdg; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-45311704d1fso34466965e9.1
        for <linux-efi@vger.kernel.org>; Wed, 09 Jul 2025 01:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752048674; x=1752653474; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cJdpIMsXQL2y8bYTX8A03sa5glKmzQX9hVMCSZiBYuo=;
        b=NuxZSXdgGpmM8wJR/Jbwx1P2tLSk3hs4UzVIvZucN8sudGxULxvfQmb0G532n15ck9
         9DHumD5d9uBBEbpzpXst+YBaRnfaHyU0yqFtTA7M5nFhmmxaSzC1tY2iefcWT0TGW2p2
         fkp9TiGKUSt/GwTUaCb7Yx407L6ULMS8O1P+eyrsor8nQo6qcCCybk7KoXo+XgN331uD
         kS1ZoysaRnhhBNWJ5C0JYNIXYSHtm84Ndx3+pRG0PVHW/MwStQEANIiFI4YHEN4C3crU
         WcU5K/9cpvsXKEnLs7exrtmJ925WovYfmzVnQPhown3MTWhRHU/MHpmX7svjUPJV0alN
         TU4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752048674; x=1752653474;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cJdpIMsXQL2y8bYTX8A03sa5glKmzQX9hVMCSZiBYuo=;
        b=T4x61oRFuvIIgPZpglSTtp4Su23fbxjv4M9GeyiW0siTwv7SbH0cDMBCb5qcsKgVnu
         0yxX1saNhVo9J55Rek/ny/5QPX0igyaBwmkJcRvlTpgNQYuGKaVs1hDnAXfcCYFt8nMG
         BS8HiiGgY1Z9eufcY5KkZahrfLH0M86RaqzrQTKdg5zNHNAdJAd4mRce9ed5N+A7uoDb
         vuZxPoMqd8eE6zErb2XON1e4CIlNRS2Q59F5jdC0WdHL5cJaEsPkrdFsq1XNp2p5wnnR
         o6YOw9itZ2nNef00GuqWUzvEF2MCE3qWuPZ1fskHiQP/22I+zOe8uGozBrcQVWf9x6gk
         HZBg==
X-Gm-Message-State: AOJu0YwFtPLFUhm+iDbG44gAiqThTmP6oLr6hfJFgAlwTS4SDM4jtnYt
	RzE0vTUnIK7fYljIeW2pbwOdssMbcoMASEalo2fZRSUIKpQ6CCpQVdFkPGPtoiJ5BJX3YB3WCQ=
	=
X-Google-Smtp-Source: AGHT+IGUkfcE4wYRge7y8M2jUPAiCLxtD89dxIjE3JRNPv1cIdMr7lu7RAnGVxFkUwJeCw4PNMtQPbTV
X-Received: from wmtk5.prod.google.com ([2002:a05:600c:c4a5:b0:442:fa3c:8612])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a5d:5d87:0:b0:3a8:38b4:1d55
 with SMTP id ffacd0b85a97d-3b5e457b3a4mr1138090f8f.28.1752048674228; Wed, 09
 Jul 2025 01:11:14 -0700 (PDT)
Date: Wed,  9 Jul 2025 10:08:47 +0200
In-Reply-To: <20250709080840.2233208-26-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250709080840.2233208-26-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=6918; i=ardb@kernel.org;
 h=from:subject; bh=2OVDZ9hILTe0+BgMGrz+LNIKYLNIqrJLUEd2skWOhYM=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JISNPedX2sj1LVH0EW2+LJMVMqVabrdl47Yboonc+un4Hr
 P4KVc7rKGVhEONikBVTZBGY/ffdztMTpWqdZ8nCzGFlAhnCwMUpABOJ8mVk2GW797xPaU2Lu9s5
 qbJrTUzXtv3qZL/IuP+wj+/uPqGLRowM1+8vdXN/63qDu4ntxUyNxsQfvXs393CXx9su3vGJvTy cEwA=
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250709080840.2233208-32-ardb+git@google.com>
Subject: [PATCH v4 06/24] x86/sev: Avoid global variable to store virtual
 address of SVSM area
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: linux-efi@vger.kernel.org, x86@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>, 
	Dionna Amalie Glaze <dionnaglaze@google.com>, Kevin Loughlin <kevinloughlin@google.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

The boottime SVSM calling area is used both by the startup code running
from a 1:1 mapping, and potentially later on running from the ordinary
kernel mapping.

This SVSM calling area is statically allocated, and so its physical
address doesn't change. However, its virtual address depends on the
calling context (1:1 mapping or kernel virtual mapping), and even though
the variable that holds the virtual address of this calling area gets
updated from 1:1 address to kernel address during the boot, it is hard
to reason about why this is guaranteed to be safe.

So instead, take the RIP-relative address of the boottime SVSM calling
area whenever its virtual address is required, and only use a global
variable for the physical address.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/sev.c      | 5 ++---
 arch/x86/boot/startup/sev-shared.c  | 6 ------
 arch/x86/boot/startup/sev-startup.c | 4 ++--
 arch/x86/coco/sev/core.c            | 9 ---------
 arch/x86/include/asm/sev-internal.h | 3 +--
 arch/x86/include/asm/sev.h          | 2 --
 arch/x86/mm/mem_encrypt_amd.c       | 6 ------
 7 files changed, 5 insertions(+), 30 deletions(-)

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index 3628e9bddc6a..6c0f91d38595 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -37,12 +37,12 @@ struct ghcb *boot_ghcb;
 
 #define __BOOT_COMPRESSED
 
-extern struct svsm_ca *boot_svsm_caa;
 extern u64 boot_svsm_caa_pa;
 
 struct svsm_ca *svsm_get_caa(void)
 {
-	return boot_svsm_caa;
+	/* The decompressor is mapped 1:1 so VA == PA */
+	return (struct svsm_ca *)boot_svsm_caa_pa;
 }
 
 u64 svsm_get_caa_pa(void)
@@ -530,7 +530,6 @@ bool early_is_sevsnp_guest(void)
 
 			/* Obtain the address of the calling area to use */
 			boot_rdmsr(MSR_SVSM_CAA, &m);
-			boot_svsm_caa = (void *)m.q;
 			boot_svsm_caa_pa = m.q;
 
 			/*
diff --git a/arch/x86/boot/startup/sev-shared.c b/arch/x86/boot/startup/sev-shared.c
index 7d2415d690c9..7ca59038269f 100644
--- a/arch/x86/boot/startup/sev-shared.c
+++ b/arch/x86/boot/startup/sev-shared.c
@@ -26,7 +26,6 @@
  *   early boot, both with identity mapped virtual addresses and proper kernel
  *   virtual addresses.
  */
-struct svsm_ca *boot_svsm_caa __ro_after_init;
 u64 boot_svsm_caa_pa __ro_after_init;
 
 /*
@@ -697,11 +696,6 @@ static bool __head svsm_setup_ca(const struct cc_blob_sev_info *cc_info,
 	if (caa & (PAGE_SIZE - 1))
 		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_SVSM_CAA);
 
-	/*
-	 * The CA is identity mapped when this routine is called, both by the
-	 * decompressor code and the early kernel code.
-	 */
-	boot_svsm_caa = (struct svsm_ca *)caa;
 	boot_svsm_caa_pa = caa;
 
 	/* Advertise the SVSM presence via CPUID. */
diff --git a/arch/x86/boot/startup/sev-startup.c b/arch/x86/boot/startup/sev-startup.c
index 050e071504af..8edf1ba78a48 100644
--- a/arch/x86/boot/startup/sev-startup.c
+++ b/arch/x86/boot/startup/sev-startup.c
@@ -252,6 +252,7 @@ static __head struct cc_blob_sev_info *find_cc_blob(struct boot_params *bp)
 
 static __head void svsm_setup(struct cc_blob_sev_info *cc_info)
 {
+	struct snp_secrets_page *secrets = (void *)cc_info->secrets_phys;
 	struct svsm_call call = {};
 	int ret;
 	u64 pa;
@@ -280,7 +281,7 @@ static __head void svsm_setup(struct cc_blob_sev_info *cc_info)
 	 *   RAX = 0 (Protocol=0, CallID=0)
 	 *   RCX = New CA GPA
 	 */
-	call.caa = svsm_get_caa();
+	call.caa = (struct svsm_ca *)secrets->svsm_caa;
 	call.rax = SVSM_CORE_CALL(SVSM_CORE_REMAP_CA);
 	call.rcx = pa;
 	do {
@@ -289,7 +290,6 @@ static __head void svsm_setup(struct cc_blob_sev_info *cc_info)
 	if (ret)
 		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_SVSM_CA_REMAP_FAIL);
 
-	boot_svsm_caa = (struct svsm_ca *)pa;
 	boot_svsm_caa_pa = pa;
 }
 
diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index 15be9e52848d..bea67d017bf0 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -1643,15 +1643,6 @@ void sev_show_status(void)
 	pr_cont("\n");
 }
 
-void __init snp_update_svsm_ca(void)
-{
-	if (!snp_vmpl)
-		return;
-
-	/* Update the CAA to a proper kernel address */
-	boot_svsm_caa = &boot_svsm_ca_page;
-}
-
 #ifdef CONFIG_SYSFS
 static ssize_t vmpl_show(struct kobject *kobj,
 			 struct kobj_attribute *attr, char *buf)
diff --git a/arch/x86/include/asm/sev-internal.h b/arch/x86/include/asm/sev-internal.h
index 6199b35a82e4..ffe4755962fe 100644
--- a/arch/x86/include/asm/sev-internal.h
+++ b/arch/x86/include/asm/sev-internal.h
@@ -60,7 +60,6 @@ void early_set_pages_state(unsigned long vaddr, unsigned long paddr,
 DECLARE_PER_CPU(struct svsm_ca *, svsm_caa);
 DECLARE_PER_CPU(u64, svsm_caa_pa);
 
-extern struct svsm_ca *boot_svsm_caa;
 extern u64 boot_svsm_caa_pa;
 
 static __always_inline struct svsm_ca *svsm_get_caa(void)
@@ -68,7 +67,7 @@ static __always_inline struct svsm_ca *svsm_get_caa(void)
 	if (sev_cfg.use_cas)
 		return this_cpu_read(svsm_caa);
 	else
-		return boot_svsm_caa;
+		return rip_rel_ptr(&boot_svsm_ca_page);
 }
 
 static __always_inline u64 svsm_get_caa_pa(void)
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 135e91a17d04..f3acbfcdca9a 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -519,7 +519,6 @@ void snp_accept_memory(phys_addr_t start, phys_addr_t end);
 u64 snp_get_unsupported_features(u64 status);
 u64 sev_get_status(void);
 void sev_show_status(void);
-void snp_update_svsm_ca(void);
 int prepare_pte_enc(struct pte_enc_desc *d);
 void set_pte_enc_mask(pte_t *kpte, unsigned long pfn, pgprot_t new_prot);
 void snp_kexec_finish(void);
@@ -600,7 +599,6 @@ static inline void snp_accept_memory(phys_addr_t start, phys_addr_t end) { }
 static inline u64 snp_get_unsupported_features(u64 status) { return 0; }
 static inline u64 sev_get_status(void) { return 0; }
 static inline void sev_show_status(void) { }
-static inline void snp_update_svsm_ca(void) { }
 static inline int prepare_pte_enc(struct pte_enc_desc *d) { return 0; }
 static inline void set_pte_enc_mask(pte_t *kpte, unsigned long pfn, pgprot_t new_prot) { }
 static inline void snp_kexec_finish(void) { }
diff --git a/arch/x86/mm/mem_encrypt_amd.c b/arch/x86/mm/mem_encrypt_amd.c
index faf3a13fb6ba..2f8c32173972 100644
--- a/arch/x86/mm/mem_encrypt_amd.c
+++ b/arch/x86/mm/mem_encrypt_amd.c
@@ -536,12 +536,6 @@ void __init sme_early_init(void)
 		x86_init.resources.dmi_setup = snp_dmi_setup;
 	}
 
-	/*
-	 * Switch the SVSM CA mapping (if active) from identity mapped to
-	 * kernel mapped.
-	 */
-	snp_update_svsm_ca();
-
 	if (sev_status & MSR_AMD64_SNP_SECURE_TSC)
 		setup_force_cpu_cap(X86_FEATURE_TSC_RELIABLE);
 }
-- 
2.50.0.727.gbf7dc18ff4-goog


