Return-Path: <linux-efi+bounces-3371-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B71BA93878
	for <lists+linux-efi@lfdr.de>; Fri, 18 Apr 2025 16:15:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F196920D00
	for <lists+linux-efi@lfdr.de>; Fri, 18 Apr 2025 14:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6B8519938D;
	Fri, 18 Apr 2025 14:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M6z0AboJ"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6FCC1990CD
	for <linux-efi@vger.kernel.org>; Fri, 18 Apr 2025 14:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744985658; cv=none; b=SAinXb7b/nv2JSRm6gpHWBKD9wob/DhMuc+IRtjGnKkQnWGCyM/8SUmShfYewsfUywis/jhFcI+4C1TcASo2o3C2D+b6JRYeVMzCUD6oD3Qcl12CPfMek09hfOL9Qbx3qfUlZ+b76p66h7NmNF2W2zSK4pOM/igX+o3/b2MEXYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744985658; c=relaxed/simple;
	bh=3Wa+zQjo35RdtJoouitO4B+QekEbNhlABlNA/Zkk0Xs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EH3JaMAQ2qp1rhvBpnQQjQf1W5D3l1l2+TlsN0VoyHIcK/Ay5StYYb76IE4NFmi84tVak1KOODH30CpiUiHff19/1MFeedPKfZ+x3/wHKgTv2B2E/jq5FSkbRJPhbbKf8Z8IIDLdZrSJZt8ZeNUY8o7xxnUGN44brKnZU2+j9qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M6z0AboJ; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-43efa869b19so10957865e9.2
        for <linux-efi@vger.kernel.org>; Fri, 18 Apr 2025 07:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744985655; x=1745590455; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4PTc5/YhHC0jHNtypAeHlTrcYEK5ok9GU9RX0YppwG4=;
        b=M6z0AboJSZ1Y+oHX9aaWsV8/bD3CuBAWXdZlFh8kzEDtYyutsPw6g8pA2E0H7KjxHs
         LWQZQ277DLyCYMQyqKTFseSSM3SlapyvQGlyjmUpkxQ7RzobVC3micvhU2UV4jWChKq3
         qvUp5dPFlzWMSu2NRuvSRplg0tuCTDWSgBqEUhCID+0Vt3ko0UrCB4g9eLAksmo+Frl7
         i1/dKoTqrM1loaocliT01X8YvlP9BDOoXVzkip2ruD/9/V5u5+/WcaeIWw6QAISwGKYc
         hft6QVxFoYtUACc2iqtqH4eHYGG0W2qR6fkxauPhz2fifBqLKHtr1/WZ27Z4RvKmoFR4
         A8RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744985655; x=1745590455;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4PTc5/YhHC0jHNtypAeHlTrcYEK5ok9GU9RX0YppwG4=;
        b=bqOTZgYEWsTiECeUsXW4M5Ji+7XFSpv+fuH+RTrTOIWvyXvwrR8HfcPgof2nWyWT85
         4tMyppcF4Dcxrek4kvruAP4/7FQH7Y6Mund8wQdEO8MNaPZXu3sWGQyvs4Eek8WTAhpp
         h8hIhlX0eJzGsAEToe+BWnJjZMkAbVHkmi0VrJZWTMTiZjZHGL5ChJPo+SqBOMvkuyEl
         u2RV7G/wlfxB4XXzoKRzseympRHz1LDv1bHRKO0eLPO0dOLnCSndMLLAHlfZAZwE1nBd
         yLlz236edNipqxXr9SMjwSJDkUKHb+VNtM042sGJC1dNEm1kM0DeqxLITwtxsCNRdnLU
         82gg==
X-Gm-Message-State: AOJu0Ywsem9ghGl4qkaAYZXMHwISd60ClkZnhuRdSRSg397TSNZFMm/P
	qA8R9Xp9638e71UWjieSIz9uGZGhfzTHCZ4VPAa6PIen4Fy5bVliQta45PPAxQtULNQWHw==
X-Google-Smtp-Source: AGHT+IG/xs+pf+sWRVh5OoD0r0kJQpxKVVDNbkk4mKp1AZ4Txb3WWk3a/KWax2QTX5FRTPy0o8SIjUfq
X-Received: from wmbes27.prod.google.com ([2002:a05:600c:811b:b0:440:5d62:5112])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:5491:b0:43c:fbe2:df3c
 with SMTP id 5b1f17b1804b1-4406abf9a9amr23008005e9.26.1744985655380; Fri, 18
 Apr 2025 07:14:15 -0700 (PDT)
Date: Fri, 18 Apr 2025 16:12:59 +0200
In-Reply-To: <20250418141253.2601348-8-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250418141253.2601348-8-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=7005; i=ardb@kernel.org;
 h=from:subject; bh=owxbl956vRhilcP5QTQUQ6a6cKAgLXRAzCdX704oRgM=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIYMp9q3NitydCyTDehlszkdMalb8y/PnSXx7Zd33HcfNP
 m2ateFjRykLgxgHg6yYIovA7L/vdp6eKFXrPEsWZg4rE8gQBi5OAZhIkSjD/6hHd+LYGVfcaZnM
 fmdizj4h+6LmgrYNl0Ju9B4P4Zj7yJrhr8DtqMebAkLOCXCH3d8486j7HQGFIxzq+idVtD8xcqd OYQIA
X-Mailer: git-send-email 2.49.0.805.g082f7c87e0-goog
Message-ID: <20250418141253.2601348-13-ardb+git@google.com>
Subject: [PATCH v5 5/6] x86/boot: Drop RIP_REL_REF() uses from early SEV code
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: linux-efi@vger.kernel.org, x86@kernel.org, mingo@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Dionna Amalie Glaze <dionnaglaze@google.com>, Kevin Loughlin <kevinloughlin@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Now that the early SEV code is built with -fPIC, RIP_REL_REF() has no
effect and can be dropped.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/startup/sev-shared.c  | 26 +++++++++-----------
 arch/x86/boot/startup/sev-startup.c | 21 ++++++----------
 arch/x86/include/asm/sev-internal.h | 18 +++-----------
 3 files changed, 23 insertions(+), 42 deletions(-)

diff --git a/arch/x86/boot/startup/sev-shared.c b/arch/x86/boot/startup/sev-shared.c
index 815542295f16..173f3d1f777a 100644
--- a/arch/x86/boot/startup/sev-shared.c
+++ b/arch/x86/boot/startup/sev-shared.c
@@ -299,7 +299,7 @@ static int svsm_perform_ghcb_protocol(struct ghcb *ghcb, struct svsm_call *call)
 	 * Fill in protocol and format specifiers. This can be called very early
 	 * in the boot, so use rip-relative references as needed.
 	 */
-	ghcb->protocol_version = RIP_REL_REF(ghcb_version);
+	ghcb->protocol_version = ghcb_version;
 	ghcb->ghcb_usage       = GHCB_DEFAULT_USAGE;
 
 	ghcb_set_sw_exit_code(ghcb, SVM_VMGEXIT_SNP_RUN_VMPL);
@@ -656,9 +656,9 @@ snp_cpuid(struct ghcb *ghcb, struct es_em_ctxt *ctxt, struct cpuid_leaf *leaf)
 		leaf->eax = leaf->ebx = leaf->ecx = leaf->edx = 0;
 
 		/* Skip post-processing for out-of-range zero leafs. */
-		if (!(leaf->fn <= RIP_REL_REF(cpuid_std_range_max) ||
-		      (leaf->fn >= 0x40000000 && leaf->fn <= RIP_REL_REF(cpuid_hyp_range_max)) ||
-		      (leaf->fn >= 0x80000000 && leaf->fn <= RIP_REL_REF(cpuid_ext_range_max))))
+		if (!(leaf->fn <= cpuid_std_range_max ||
+		      (leaf->fn >= 0x40000000 && leaf->fn <= cpuid_hyp_range_max) ||
+		      (leaf->fn >= 0x80000000 && leaf->fn <= cpuid_ext_range_max)))
 			return 0;
 	}
 
@@ -1179,11 +1179,11 @@ static void __head setup_cpuid_table(const struct cc_blob_sev_info *cc_info)
 		const struct snp_cpuid_fn *fn = &cpuid_table->fn[i];
 
 		if (fn->eax_in == 0x0)
-			RIP_REL_REF(cpuid_std_range_max) = fn->eax;
+			cpuid_std_range_max = fn->eax;
 		else if (fn->eax_in == 0x40000000)
-			RIP_REL_REF(cpuid_hyp_range_max) = fn->eax;
+			cpuid_hyp_range_max = fn->eax;
 		else if (fn->eax_in == 0x80000000)
-			RIP_REL_REF(cpuid_ext_range_max) = fn->eax;
+			cpuid_ext_range_max = fn->eax;
 	}
 }
 
@@ -1229,11 +1229,7 @@ static void __head pvalidate_4k_page(unsigned long vaddr, unsigned long paddr,
 {
 	int ret;
 
-	/*
-	 * This can be called very early during boot, so use rIP-relative
-	 * references as needed.
-	 */
-	if (RIP_REL_REF(snp_vmpl)) {
+	if (snp_vmpl) {
 		svsm_pval_4k_page(paddr, validate);
 	} else {
 		ret = pvalidate(vaddr, RMP_PG_SIZE_4K, validate);
@@ -1377,7 +1373,7 @@ static bool __head svsm_setup_ca(const struct cc_blob_sev_info *cc_info)
 	if (!secrets_page->svsm_guest_vmpl)
 		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_SVSM_VMPL0);
 
-	RIP_REL_REF(snp_vmpl) = secrets_page->svsm_guest_vmpl;
+	snp_vmpl = secrets_page->svsm_guest_vmpl;
 
 	caa = secrets_page->svsm_caa;
 
@@ -1392,8 +1388,8 @@ static bool __head svsm_setup_ca(const struct cc_blob_sev_info *cc_info)
 	 * The CA is identity mapped when this routine is called, both by the
 	 * decompressor code and the early kernel code.
 	 */
-	RIP_REL_REF(boot_svsm_caa) = (struct svsm_ca *)caa;
-	RIP_REL_REF(boot_svsm_caa_pa) = caa;
+	boot_svsm_caa = (struct svsm_ca *)caa;
+	boot_svsm_caa_pa = caa;
 
 	/* Advertise the SVSM presence via CPUID. */
 	cpuid_table = (struct snp_cpuid_table *)snp_cpuid_get_table();
diff --git a/arch/x86/boot/startup/sev-startup.c b/arch/x86/boot/startup/sev-startup.c
index 10b636009d1c..36a75c5096b0 100644
--- a/arch/x86/boot/startup/sev-startup.c
+++ b/arch/x86/boot/startup/sev-startup.c
@@ -462,15 +462,10 @@ int svsm_perform_call_protocol(struct svsm_call *call)
 	 */
 	flags = native_local_irq_save();
 
-	/*
-	 * Use rip-relative references when called early in the boot. If
-	 * ghcbs_initialized is set, then it is late in the boot and no need
-	 * to worry about rip-relative references in called functions.
-	 */
-	if (RIP_REL_REF(sev_cfg).ghcbs_initialized)
+	if (sev_cfg.ghcbs_initialized)
 		ghcb = __sev_get_ghcb(&state);
-	else if (RIP_REL_REF(boot_ghcb))
-		ghcb = RIP_REL_REF(boot_ghcb);
+	else if (boot_ghcb)
+		ghcb = boot_ghcb;
 	else
 		ghcb = NULL;
 
@@ -479,7 +474,7 @@ int svsm_perform_call_protocol(struct svsm_call *call)
 			   : svsm_perform_msr_protocol(call);
 	} while (ret == -EAGAIN);
 
-	if (RIP_REL_REF(sev_cfg).ghcbs_initialized)
+	if (sev_cfg.ghcbs_initialized)
 		__sev_put_ghcb(&state);
 
 	native_local_irq_restore(flags);
@@ -542,7 +537,7 @@ void __head early_snp_set_memory_private(unsigned long vaddr, unsigned long padd
 	 * This eliminates worries about jump tables or checking boot_cpu_data
 	 * in the cc_platform_has() function.
 	 */
-	if (!(RIP_REL_REF(sev_status) & MSR_AMD64_SEV_SNP_ENABLED))
+	if (!(sev_status & MSR_AMD64_SEV_SNP_ENABLED))
 		return;
 
 	 /*
@@ -561,7 +556,7 @@ void __head early_snp_set_memory_shared(unsigned long vaddr, unsigned long paddr
 	 * This eliminates worries about jump tables or checking boot_cpu_data
 	 * in the cc_platform_has() function.
 	 */
-	if (!(RIP_REL_REF(sev_status) & MSR_AMD64_SEV_SNP_ENABLED))
+	if (!(sev_status & MSR_AMD64_SEV_SNP_ENABLED))
 		return;
 
 	 /* Ask hypervisor to mark the memory pages shared in the RMP table. */
@@ -1356,8 +1351,8 @@ static __head void svsm_setup(struct cc_blob_sev_info *cc_info)
 	if (ret)
 		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_SVSM_CA_REMAP_FAIL);
 
-	RIP_REL_REF(boot_svsm_caa) = (struct svsm_ca *)pa;
-	RIP_REL_REF(boot_svsm_caa_pa) = pa;
+	boot_svsm_caa = (struct svsm_ca *)pa;
+	boot_svsm_caa_pa = pa;
 }
 
 bool __head snp_init(struct boot_params *bp)
diff --git a/arch/x86/include/asm/sev-internal.h b/arch/x86/include/asm/sev-internal.h
index 73cb774c3639..e54847a69107 100644
--- a/arch/x86/include/asm/sev-internal.h
+++ b/arch/x86/include/asm/sev-internal.h
@@ -68,28 +68,18 @@ extern u64 boot_svsm_caa_pa;
 
 static __always_inline struct svsm_ca *svsm_get_caa(void)
 {
-	/*
-	 * Use rIP-relative references when called early in the boot. If
-	 * ->use_cas is set, then it is late in the boot and no need
-	 * to worry about rIP-relative references.
-	 */
-	if (RIP_REL_REF(sev_cfg).use_cas)
+	if (sev_cfg.use_cas)
 		return this_cpu_read(svsm_caa);
 	else
-		return RIP_REL_REF(boot_svsm_caa);
+		return boot_svsm_caa;
 }
 
 static __always_inline u64 svsm_get_caa_pa(void)
 {
-	/*
-	 * Use rIP-relative references when called early in the boot. If
-	 * ->use_cas is set, then it is late in the boot and no need
-	 * to worry about rIP-relative references.
-	 */
-	if (RIP_REL_REF(sev_cfg).use_cas)
+	if (sev_cfg.use_cas)
 		return this_cpu_read(svsm_caa_pa);
 	else
-		return RIP_REL_REF(boot_svsm_caa_pa);
+		return boot_svsm_caa_pa;
 }
 
 int svsm_perform_call_protocol(struct svsm_call *call);
-- 
2.49.0.805.g082f7c87e0-goog


