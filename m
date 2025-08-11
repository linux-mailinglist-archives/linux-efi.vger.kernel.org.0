Return-Path: <linux-efi+bounces-4539-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 184EDB2150F
	for <lists+linux-efi@lfdr.de>; Mon, 11 Aug 2025 21:03:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D20E17F9D4
	for <lists+linux-efi@lfdr.de>; Mon, 11 Aug 2025 19:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9D3926CE2A;
	Mon, 11 Aug 2025 19:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Qfjiq5zw"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A151F4C87;
	Mon, 11 Aug 2025 19:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754939013; cv=none; b=uNvCsfMOqzMop8FnCQffA9ShYMYVaNyxdMw+QydbL9CtRyRmu0DsVYJVcW4UmALwamXhVISQSwBSGVggzoenqCoCXbn0FaI3Nt/OmP3C8drzYwMoml5KfKpuWulvN4U81qBMrD4MToLdeu45upEDO3juhCEDvuAWxLDNwXNtWP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754939013; c=relaxed/simple;
	bh=yGOPUJIeFSkxymBShB4lszt3VOaSUZophHZlGKFilbE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cq1C/QfwC8k0YU+WOZNAepE8YggU6I9u6fv6P6h1NoabXz8mS1ss+1EIHyPChcBqUyhLD7VNN36N9qMOWSQDwaI2zP/rzVy1mDuoNjGYShjh6TPcVPoGTDTapU0epIK7pex2ECJkWmtt5B1vzyt4kNOBJORQfVJYnarA8rSrO2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Qfjiq5zw; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 5831840E0217;
	Mon, 11 Aug 2025 19:03:28 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id PkZq-vT323ML; Mon, 11 Aug 2025 19:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1754939005; bh=URh6Vu3vykvoo88ywtGuNMkqzuS1DAGjt+6WPp89YFQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Qfjiq5zwaw/SvZWIcGVL6fV3kkK45yACPa5l0OG8TnG0gWS6iw8x0Xra8qaATaMZ3
	 3dM/jApgQ4VnEx82vSJdvPL3EfR7h1nvul6zG/RFwt2QhsWFKK1co67RtDqim7i7G6
	 7EjQMDQoIked5ylqIpTJ3/d58RW+15EbecQRcWRXW979IQxwPEAxTacr3IOEZeXOlS
	 hr17b8iY/TOWG2CwQemFw8ztOMsyLkYvwcBLNbtv/Qr90QveTHI1p/TL77LWXhJ+CN
	 PvOnwbiin4AVKfFjoFhhEOWhdYXInpdkXrtRm3Wk3Jj5axQHfxRn265XbxSuZyLBWo
	 KkiNLAOHjHvzJHUThOu+4ZlzPsy/7tIAgpFejSxRpXFtR50Lu1wAlutH1s8aSFhpvq
	 ibBsno4e5xFi/fGRWSkxnPjFTZXRk3vUTyZdWmCV7uBiPeravPVjKEQAa7g8hlFCgq
	 2WKIpMhbIZck72zR2Hy9n0+3BVIT412RYHpMyj7cbCpxLKWLV984SwSoRVHTS0vAdz
	 U6NKr6Q0NoLV0H39hfiP64PQ3mP8CySh7YovsAAQKgaEiXD24A8e6bgSZe+wPdtFIn
	 6LjFBNzJfRRB/RLCAqwhClXv4JBzbZIXgA5gY8Id7wf4sVtq63Lqw1mVZrb6pdxjKb
	 dD37O+SQrsqYdBQQtJ+USIzc=
Received: from zn.tnic (pd953092e.dip0.t-ipconnect.de [217.83.9.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D468D40E01FD;
	Mon, 11 Aug 2025 19:03:12 +0000 (UTC)
Date: Mon, 11 Aug 2025 21:03:06 +0200
From: Borislav Petkov <bp@alien8.de>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org,
	linux-efi@vger.kernel.org, x86@kernel.org,
	Ard Biesheuvel <ardb@kernel.org>, Ingo Molnar <mingo@kernel.org>,
	Kevin Loughlin <kevinloughlin@google.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Subject: Re: [PATCH v6 21/22] x86/boot: Move startup code out of __head
 section
Message-ID: <20250811190306.GAaJo-ai4M2aVod6_V@fat_crate.local>
References: <20250722072708.2079165-24-ardb+git@google.com>
 <20250722072708.2079165-45-ardb+git@google.com>
 <20250811174034.GRaJorEmcBfLTDhWml@fat_crate.local>
 <c9bb1b3f-17ce-254f-5d0f-ae3563b03b50@amd.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c9bb1b3f-17ce-254f-5d0f-ae3563b03b50@amd.com>

On Mon, Aug 11, 2025 at 01:05:42PM -0500, Tom Lendacky wrote:
> Yes, that works. Or just get rid of snp_abort() and call
> sev_es_terminate() directly. Secure AVIC could even use an
> SEV_TERM_SET_LINUX specific code instead of the generic failure code.

I *love* deleting code. Here's something to start the debate:

---
diff --git a/arch/x86/boot/startup/sev-startup.c b/arch/x86/boot/startup/sev-startup.c
index 7a8128dc076e..19b23e6d2dbe 100644
--- a/arch/x86/boot/startup/sev-startup.c
+++ b/arch/x86/boot/startup/sev-startup.c
@@ -135,7 +135,7 @@ static struct cc_blob_sev_info *__init find_cc_blob(struct boot_params *bp)
 
 found_cc_info:
 	if (cc_info->magic != CC_BLOB_SEV_HDR_MAGIC)
-		snp_abort();
+		sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SNP_UNSUPPORTED);
 
 	return cc_info;
 }
@@ -209,8 +209,3 @@ bool __init snp_init(struct boot_params *bp)
 
 	return true;
 }
-
-void __init __noreturn snp_abort(void)
-{
-	sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SNP_UNSUPPORTED);
-}
diff --git a/arch/x86/boot/startup/sme.c b/arch/x86/boot/startup/sme.c
index 39e7e9d18974..e389b39fa2a9 100644
--- a/arch/x86/boot/startup/sme.c
+++ b/arch/x86/boot/startup/sme.c
@@ -531,7 +531,7 @@ void __init sme_enable(struct boot_params *bp)
 	 * enablement abort the guest.
 	 */
 	if (snp_en ^ !!(msr & MSR_AMD64_SEV_SNP_ENABLED))
-		snp_abort();
+		sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SNP_UNSUPPORTED);
 
 	/* Check if memory encryption is enabled */
 	if (feature_mask == AMD_SME_BIT) {
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
 
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 2b8a779f1477..e907646b4e4b 100644
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
@@ -590,7 +589,6 @@ static inline void snp_set_memory_shared(unsigned long vaddr, unsigned long npag
 static inline void snp_set_memory_private(unsigned long vaddr, unsigned long npages) { }
 static inline void snp_set_wakeup_secondary_cpu(void) { }
 static inline bool snp_init(struct boot_params *bp) { return false; }
-static inline void snp_abort(void) { }
 static inline void snp_dmi_setup(void) { }
 static inline int snp_issue_svsm_attest_req(u64 call_id, struct svsm_call *call, struct svsm_attest_call *input)
 {
diff --git a/arch/x86/kernel/apic/x2apic_savic.c b/arch/x86/kernel/apic/x2apic_savic.c
index bea844f28192..f0270ce16e6c 100644
--- a/arch/x86/kernel/apic/x2apic_savic.c
+++ b/arch/x86/kernel/apic/x2apic_savic.c
@@ -26,7 +26,7 @@ static int savic_probe(void)
 
 	if (!x2apic_mode) {
 		pr_err("Secure AVIC enabled in non x2APIC mode\n");
-		snp_abort();
+		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_SAVIC_FAIL);
 		/* unreachable */
 	}
 
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

