Return-Path: <linux-efi+bounces-4360-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0789B06C22
	for <lists+linux-efi@lfdr.de>; Wed, 16 Jul 2025 05:23:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28E321AA721D
	for <lists+linux-efi@lfdr.de>; Wed, 16 Jul 2025 03:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26F9428641F;
	Wed, 16 Jul 2025 03:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QZZHrIEy"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C5C279DC8
	for <linux-efi@vger.kernel.org>; Wed, 16 Jul 2025 03:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752636157; cv=none; b=LH6/jDLik3HP9bodpLRuEqKsAk5TFg7SHe7pMHtEA6rC5o6GFoErL8TPKcsYyaAUkHuidIUmPzfPlKkP6psqfapFX9sqH8+DB5R1P/ZuAnRwwRh31/JmWE+l2RGKyro8Cey3ElBlur+0kCP6MFajWBSM4B4NsNE7+cKeodkYD5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752636157; c=relaxed/simple;
	bh=oVYYVV7IM+oCaa8Iy2yVxJ/iXoqxeBe54KqLk1DrQiI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ges2T93/Yk/jQ5JnTDaiDuWCtmZH1Fx3UX6oswLq+3cBWKgm/qOg5QgUAmAZXd3PD50qai/dOBj0JAslCI80JMCEFNEeUzZi3aons6afsj7AxDVNF1W2HlrWU+eDFxauYq1RaNErd/FZkZ4kSeXq/kcTN4hHHGCzE1xUGpsWex8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QZZHrIEy; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-3a5281ba3a4so2283986f8f.0
        for <linux-efi@vger.kernel.org>; Tue, 15 Jul 2025 20:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752636153; x=1753240953; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jByEiSvZS6IwUNhPGQBR23wRpe9FzYy/zZntI8BuAY8=;
        b=QZZHrIEykoZfF9HG/Akh9C/t1PkbtGO0l53+76TS7oYY8OXRsEpFKnXfIwPTSuRyNb
         j10NJA2KUW7rWVr5v9ODkHPz0m979ktzOQqJWOOtDN+gMANQRsPq84tyq9VWuaJ/n/00
         vWYK2qtlvxaIy2MCKi4604YtlQJ64O5LW2UWP7ypWxpHqiJakT4dR1IldITE5PTqrOeG
         zYhoiEE6U5bHGFfq9I9V6sLvYgQ2Gkq5WvLQnMCQME9AmTCyNoFz5uy+rEoQLAdzrtGD
         JWBIOmKexhp+hYXasUHlgXEuhm63L+ho/xmUv8SKGZrcw4TBlk/wRZZqD23sdyr3CQ1y
         ll9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752636153; x=1753240953;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jByEiSvZS6IwUNhPGQBR23wRpe9FzYy/zZntI8BuAY8=;
        b=R23f5ym387+TKu6eX5nYpwA1VCHTZQAj6BO0Z5I3xVPTxSuIz07sfu7Y84k98aNvAT
         5OAoaEV8nkNuMBWSIRI5JCaPoH7LQ6siNepat5gdVj8ez+lTeNnHHZwtiggZsQKpY54y
         YbHbxZVxP7wcx/m0Kj0qK6AgG7Ah3zZzcI7KrnvVA2AO0A/lOcz7l1W+6jXdp4GAIytU
         TAOVFApg3Quj7bX6FFx7I2i4J3NCahaRcy6GNCsK2cVMJf5vvKnftLZk2EaYABAsi9QL
         Hal79xXSSeeCm0TiDOtGXywH5gc9VEC4GpAGDA6NqwHzFBgSECaZ76DNKIMWd7gYONiR
         7T6A==
X-Gm-Message-State: AOJu0Yxj1zE/PauaI/r99d2AX8yL9xPUa0NngmPwIOE93jqiNHhS8dIl
	e0AXKNygnYwPUNKeSN/pBcvcb2w1tG2bce6sNYkMWSWGQBy+95RlxhZR4Ca12dFqCg9K1JCrlw=
	=
X-Google-Smtp-Source: AGHT+IGY9nciXK+vatFpkWpVbsEnraCy8r+SHWAeZXPOzd+toVAnbbhja82L4vuBpWVxvhWcuVAt8L74
X-Received: from wrpd2.prod.google.com ([2002:adf:f2c2:0:b0:3a6:d8f2:be99])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:2888:b0:3b6:de9:8079
 with SMTP id ffacd0b85a97d-3b60de980b8mr922638f8f.0.1752636153422; Tue, 15
 Jul 2025 20:22:33 -0700 (PDT)
Date: Wed, 16 Jul 2025 05:18:21 +0200
In-Reply-To: <20250716031814.2096113-24-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250716031814.2096113-24-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=7326; i=ardb@kernel.org;
 h=from:subject; bh=JFjboX8rs6+vF/XKHgjFlUmhvXqsb1ZceclwpiVnh5Q=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIaNcSkbi/MW1d0/evG89RzBUfuahjbaeEbmrFuywL8j3c
 nDRm9rTUcrCIMbFICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACayU43hn+1MyzuuqVxPRDQF
 J0r4e4uzLMtc6fVUVn2/qWGKHvuP54wMHx4E9IRbcXbwLnsvqW0eqezlI8MiZt37tU2SjTFFNJA JAA==
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250716031814.2096113-30-ardb+git@google.com>
Subject: [PATCH v5 06/22] x86/sev: Avoid global variable to store virtual
 address of SVSM area
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: linux-efi@vger.kernel.org, x86@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>, 
	Kevin Loughlin <kevinloughlin@google.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Nikunj A Dadhania <nikunj@amd.com>
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
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/x86/boot/compressed/sev.c      | 5 ++---
 arch/x86/boot/startup/sev-shared.c  | 6 ------
 arch/x86/boot/startup/sev-startup.c | 9 +++++----
 arch/x86/coco/sev/core.c            | 9 ---------
 arch/x86/include/asm/sev-internal.h | 3 +--
 arch/x86/include/asm/sev.h          | 2 --
 arch/x86/mm/mem_encrypt_amd.c       | 6 ------
 7 files changed, 8 insertions(+), 32 deletions(-)

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
index f9de8b33de6c..51f2110bc509 100644
--- a/arch/x86/boot/startup/sev-shared.c
+++ b/arch/x86/boot/startup/sev-shared.c
@@ -26,7 +26,6 @@
  *   early boot, both with identity mapped virtual addresses and proper kernel
  *   virtual addresses.
  */
-struct svsm_ca *boot_svsm_caa __ro_after_init;
 u64 boot_svsm_caa_pa __ro_after_init;
 
 /*
@@ -709,11 +708,6 @@ static bool __head svsm_setup_ca(const struct cc_blob_sev_info *cc_info,
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
index 7b38085c7218..f3e247d205b7 100644
--- a/arch/x86/boot/startup/sev-startup.c
+++ b/arch/x86/boot/startup/sev-startup.c
@@ -252,6 +252,7 @@ static __head struct cc_blob_sev_info *find_cc_blob(struct boot_params *bp)
 
 static __head void svsm_setup(struct cc_blob_sev_info *cc_info)
 {
+	struct snp_secrets_page *secrets = (void *)cc_info->secrets_phys;
 	struct svsm_call call = {};
 	u64 pa;
 
@@ -272,21 +273,21 @@ static __head void svsm_setup(struct cc_blob_sev_info *cc_info)
 	pa = (u64)rip_rel_ptr(&boot_svsm_ca_page);
 
 	/*
-	 * Switch over to the boot SVSM CA while the current CA is still
-	 * addressable. There is no GHCB at this point so use the MSR protocol.
+	 * Switch over to the boot SVSM CA while the current CA is still 1:1
+	 * mapped and thus addressable with VA == PA. There is no GHCB at this
+	 * point so use the MSR protocol.
 	 *
 	 * SVSM_CORE_REMAP_CA call:
 	 *   RAX = 0 (Protocol=0, CallID=0)
 	 *   RCX = New CA GPA
 	 */
-	call.caa = svsm_get_caa();
+	call.caa = (struct svsm_ca *)secrets->svsm_caa;
 	call.rax = SVSM_CORE_CALL(SVSM_CORE_REMAP_CA);
 	call.rcx = pa;
 
 	if (svsm_perform_msr_protocol(&call))
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


