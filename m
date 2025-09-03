Return-Path: <linux-efi+bounces-4673-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DBEBB426C2
	for <lists+linux-efi@lfdr.de>; Wed,  3 Sep 2025 18:23:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52399681682
	for <lists+linux-efi@lfdr.de>; Wed,  3 Sep 2025 16:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6610D2C17B6;
	Wed,  3 Sep 2025 16:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="ckWGXJY6"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1434C2C11F9;
	Wed,  3 Sep 2025 16:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756916549; cv=none; b=nSB2BpxeprnxwzkTmCfCnpaKMNOtR0T2U0zbfv0uaRShWXU8QwNMnvkUFJae0FI7Br2JVap3VdgmcTFN7ur90eMcW8YoJKGwB9hd43+VGWnMIjtQ/efZNr8Ad0PmcBsR35SjR33UDzE9mjQEpT6RQYrJLC/ReEFD2pN49EC54zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756916549; c=relaxed/simple;
	bh=jZZngHPqPl0jzwcdfvrr1f4Qb2IcADssB2yhQ8TzxcE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=baq3aDb0EWQddY6kEM4Fx8EdOFzocIHwVA8yUORvZTJA1ID6HCryWN87tWEdUD3SyPP7iXlE9cpUy2xb+l3/vjoqUY1V/2RvJXM/MlYRxmoakoDvPnMG71rewf673TwafGpuHdT4+Ggh87LS5yUsUVrh2r5bAUwYQLfYmbqNMX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=ckWGXJY6; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id D9C9D40E00DE;
	Wed,  3 Sep 2025 16:22:23 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id E8Z0PEJV3Z0l; Wed,  3 Sep 2025 16:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1756916539; bh=Yg2x7twhatQMmLV35XK8qG2QDsmMBwv2i1ZvKyXM5L4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ckWGXJY6kAmZFF3NcGYnYQBkLFal1wh6zbcZMyxsAhCJ2kmjvs25HfuEDLs0fXcke
	 vDvLQ+vlaIfa9HJdiXRbf/lgDYYHI+rA4e4Y+QrvC5THuDOnIBWClTTdTNRc3+icST
	 QXKvSTbOPbrX311b6IpDhhn+w2gLDaLjW23lPgqrtjDe8owJQAttmpovsB5dO4D/Ka
	 uwlS2J2JF7M3RWW3ssoZy2ZjuFUrlXrVowxlNxAJQ4NJtk6w/UgLngc6kG791E0GIf
	 +bcSocNkFAmnq4QO1tswaETQevGgNoPFZsnRO2Ivami7hXU3WuB5g1IRk2k6rYe7gA
	 UDTYFZ1yr9EHQ84uWrsfsOp8I9NVLTKf5wY4uohyvTu7hReK2YkQp8di95JBsaGwIc
	 0J9FiXN6sUvEjz9rjtBKbLsqe8VEyjZNxmPyJQjmrhfHQuUClFgjtqnqyuLXpwdnfa
	 uMOdo1Bi3iy2JW3d6ZgZgHevd5q8MTYCVl5XAhZwvsbwivfIIA4pmRw70uI8I7mVmi
	 8qd4BXAVfCR/1Vi51WsWmWrCobLMM8olynHCBKY8mzBO6rTgei1yqdYyMaFvytdF3r
	 r0gwvXafBovgll6syanewcLDjp0fiopVoktMItFz1J8+4bboo/UzpS7ztG5d4MhflD
	 rFO2rVeGW6f8l76j2ttCgZLw=
Received: from zn.tnic (p5de8ed27.dip0.t-ipconnect.de [93.232.237.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id EDAF140E0163;
	Wed,  3 Sep 2025 16:22:06 +0000 (UTC)
Date: Wed, 3 Sep 2025 18:22:00 +0200
From: Borislav Petkov <bp@alien8.de>
To: Ard Biesheuvel <ardb+git@google.com>,
	Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Cc: linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org, x86@kernel.org,
	Ard Biesheuvel <ardb@kernel.org>, Ingo Molnar <mingo@kernel.org>,
	Kevin Loughlin <kevinloughlin@google.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Nikunj A Dadhania <nikunj@amd.com>
Subject: Re: [PATCH v7 00/22] x86: strict separation of startup code
Message-ID: <20250903162200.GIaLhrKOJeL6ThYHa1@fat_crate.local>
References: <20250828102202.1849035-24-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250828102202.1849035-24-ardb+git@google.com>

On Thu, Aug 28, 2025 at 12:22:03PM +0200, Ard Biesheuvel wrote:
> Changes since v6:
> - Rebase onto latest tip/master which incorporates v6.17-rc1a

...

So, due to the interactions with the Secure AVIC stuff, I've been doing some
patch tetris. Two patches: the first one goes ontop of x86/apic and the second
one goes ontop of this set.

Will run some build tests with them first tho...

patch 1:

---

commit aa532319e46228422f7deb8d54853c4b218276f1 (HEAD -> refs/heads/tip-x86-apic)
Author: Borislav Petkov (AMD) <bp@alien8.de>
Date:   Wed Sep 3 17:42:05 2025 +0200

    WIP
    
    Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>

diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index b64f43010a12..e858e2979db0 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -1129,7 +1129,7 @@ u64 savic_ghcb_msr_read(u32 reg)
 	if (res != ES_OK) {
 		pr_err("Secure AVIC MSR (0x%llx) read returned error (%d)\n", msr, res);
 		/* MSR read failures are treated as fatal errors */
-		snp_abort();
+		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_SAVIC_FAIL);
 	}
 
 	__sev_put_ghcb(&state);
@@ -1159,7 +1159,7 @@ void savic_ghcb_msr_write(u32 reg, u64 value)
 	if (res != ES_OK) {
 		pr_err("Secure AVIC MSR (0x%llx) write returned error (%d)\n", msr, res);
 		/* MSR writes should never fail. Any failure is fatal error for SNP guest */
-		snp_abort();
+		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_SAVIC_FAIL);
 	}
 
 	__sev_put_ghcb(&state);
diff --git a/arch/x86/include/asm/sev-common.h b/arch/x86/include/asm/sev-common.h
index 0020d77a0800..01a6e4dbe423 100644
--- a/arch/x86/include/asm/sev-common.h
+++ b/arch/x86/include/asm/sev-common.h
@@ -208,6 +208,7 @@ struct snp_psc_desc {
 #define GHCB_TERM_SVSM_CAA		9	/* SVSM is present but CAA is not page aligned */
 #define GHCB_TERM_SECURE_TSC		10	/* Secure TSC initialization failed */
 #define GHCB_TERM_SVSM_CA_REMAP_FAIL	11	/* SVSM is present but CA could not be remapped */
+#define GHCB_TERM_SAVIC_FAIL		12	/* Secure AVIC-specific failure */
 
 #define GHCB_RESP_CODE(v)		((v) & GHCB_MSR_INFO_MASK)
 
diff --git a/arch/x86/kernel/apic/x2apic_savic.c b/arch/x86/kernel/apic/x2apic_savic.c
index b846de0fbcfa..2b82bb64055a 100644
--- a/arch/x86/kernel/apic/x2apic_savic.c
+++ b/arch/x86/kernel/apic/x2apic_savic.c
@@ -363,7 +363,7 @@ static void savic_setup(void)
 	 */
 	res = savic_register_gpa(gpa);
 	if (res != ES_OK)
-		snp_abort();
+		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_SAVIC_FAIL);
 
 	native_wrmsrq(MSR_AMD64_SAVIC_CONTROL,
 		      gpa | MSR_AMD64_SAVIC_EN | MSR_AMD64_SAVIC_ALLOWEDNMI);
@@ -376,13 +376,13 @@ static int savic_probe(void)
 
 	if (!x2apic_mode) {
 		pr_err("Secure AVIC enabled in non x2APIC mode\n");
-		snp_abort();
+		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_SAVIC_FAIL);
 		/* unreachable */
 	}
 
 	savic_page = alloc_percpu(struct secure_avic_page);
 	if (!savic_page)
-		snp_abort();
+		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_SAVIC_FAIL);;
 
 	return 1;
 }

---

patch 2

---

commit 07d41a19c5a01506e1080e352c26c50c8dce6e6b (refs/remotes/ps2/tip-x86-sev, refs/remotes/ps2/HEAD)
Author: Borislav Petkov (AMD) <bp@alien8.de>
Date:   Wed Sep 3 18:14:54 2025 +0200

    WIP
    
    Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>

diff --git a/arch/x86/boot/startup/sev-startup.c b/arch/x86/boot/startup/sev-startup.c
index 39465a0ff4e5..a9b0a9c32d8f 100644
--- a/arch/x86/boot/startup/sev-startup.c
+++ b/arch/x86/boot/startup/sev-startup.c
@@ -144,7 +144,7 @@ static struct cc_blob_sev_info *__init find_cc_blob(struct boot_params *bp)
 
 found_cc_info:
 	if (cc_info->magic != CC_BLOB_SEV_HDR_MAGIC)
-		snp_abort();
+		sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SNP_UNSUPPORTED);
 
 	return cc_info;
 }
@@ -218,8 +218,3 @@ bool __init snp_init(struct boot_params *bp)
 
 	return true;
 }
-
-void __init __noreturn snp_abort(void)
-{
-	sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SNP_UNSUPPORTED);
-}
diff --git a/arch/x86/boot/startup/sme.c b/arch/x86/boot/startup/sme.c
index 2ddde901c8c5..e7ea65f3f1d6 100644
--- a/arch/x86/boot/startup/sme.c
+++ b/arch/x86/boot/startup/sme.c
@@ -532,7 +532,7 @@ void __init sme_enable(struct boot_params *bp)
 	 * enablement abort the guest.
 	 */
 	if (snp_en ^ !!(msr & MSR_AMD64_SEV_SNP_ENABLED))
-		snp_abort();
+		sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SNP_UNSUPPORTED);
 
 	/* Check if memory encryption is enabled */
 	if (feature_mask == AMD_SME_BIT) {
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index f222bef9dca8..32c7dd916e4b 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -512,7 +512,6 @@ void snp_set_memory_shared(unsigned long vaddr, unsigned long npages);
 void snp_set_memory_private(unsigned long vaddr, unsigned long npages);
 void snp_set_wakeup_secondary_cpu(void);
 bool snp_init(struct boot_params *bp);
-void __noreturn snp_abort(void);
 void snp_dmi_setup(void);
 int snp_issue_svsm_attest_req(u64 call_id, struct svsm_call *call, struct svsm_attest_call *input);
 void snp_accept_memory(phys_addr_t start, phys_addr_t end);
@@ -597,7 +596,6 @@ static inline void snp_set_memory_shared(unsigned long vaddr, unsigned long npag
 static inline void snp_set_memory_private(unsigned long vaddr, unsigned long npages) { }
 static inline void snp_set_wakeup_secondary_cpu(void) { }
 static inline bool snp_init(struct boot_params *bp) { return false; }
-static inline void snp_abort(void) { }
 static inline void snp_dmi_setup(void) { }
 static inline int snp_issue_svsm_attest_req(u64 call_id, struct svsm_call *call, struct svsm_attest_call *input)
 {
diff --git a/tools/objtool/noreturns.h b/tools/objtool/noreturns.h
index 6a922d046b8e..802895fae3ca 100644
--- a/tools/objtool/noreturns.h
+++ b/tools/objtool/noreturns.h
@@ -45,7 +45,6 @@ NORETURN(rewind_stack_and_make_dead)
 NORETURN(rust_begin_unwind)
 NORETURN(rust_helper_BUG)
 NORETURN(sev_es_terminate)
-NORETURN(snp_abort)
 NORETURN(start_kernel)
 NORETURN(stop_this_cpu)
 NORETURN(usercopy_abort)


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

