Return-Path: <linux-efi+bounces-4663-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 925CCB3E643
	for <lists+linux-efi@lfdr.de>; Mon,  1 Sep 2025 15:56:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4862E1A8577C
	for <lists+linux-efi@lfdr.de>; Mon,  1 Sep 2025 13:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0996E33CE82;
	Mon,  1 Sep 2025 13:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="ilHppsfD"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD7D33CE81;
	Mon,  1 Sep 2025 13:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756734927; cv=none; b=ElIzAztFjrqyLnaax4L2HclZbMqbrGsKB3CzZ5j0dB4nsrskGgS50cJQWpV8s+ynWUixUWEGKAPAo6UjAkhmjlIHREu4Y7u0g1QQNFQ7LrL1Odz4o1T+D2DL771fvhLfhKXk7uF0iUiaSrhKn3vmlKTiMLH2NKu/PvWVkg/hjuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756734927; c=relaxed/simple;
	bh=EpZOwE4ansUe1tibfuHjQYSuDiy53AFMsDy9fb4cwCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OyCIjOJQZcdfGCIXwX+t3lwtzN6lcez6XAdOmHzsPNs2wE373cFjVAQYgh9RKeM0CndGzIdS20u5nh0lOi8MC8+t/tOkigczucegbwu2zKJoIYRQfV3uVsz0yY4jwCN3RP1zFMxp6idzKlf0ZVPWMQfvR6HMVb04dIz5aboqk3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=ilHppsfD; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 2AE4E40E01A2;
	Mon,  1 Sep 2025 13:55:22 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Rra4kGcpECf6; Mon,  1 Sep 2025 13:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1756734917; bh=ZJkhduMDiVeUow+g3GYo2YpO94DgdHVPHY9D98WjWHI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ilHppsfDoQX8SkLg7CT7/8PZJ2HmbLM9epl845d4RTQFwRtO5ru8qu43nz7XQDXW0
	 GxpuwLpw0P1KAsfqNwUHyc+odq9nkdpXz8BHR3sJKkhB5jEixY+pmkU6GDhcWa/Ohi
	 AgRrbFy8ED8GkRJPuITybuhrSsFBRhI4MIiEjhr61R/E1/4mFjoiIa1EwKUq/oOCQ3
	 b1INlwgI+xQRDOop13YZr0QtosJ0WylpEZh7uOJoUw7gRm0bREN4bNoYVsJUqJYpo1
	 4pnbz9d8tkiTxzgHJ57MBBgr0fX6lZoj6BsCJkPRPIvbe/VzvWHRfEkgdY1Dz5DGF5
	 s91BwsYqzZu8yELo4iw8+ucvetg8T1hKxrWWcgcsL6ghPzRuUSWYI3D9Xtbd0jXQaM
	 8Fua/tJbUw0l6pM0gR3z2ZZ7Pyos/jhzmOrPI3xuYe3eCAZvvAiU0s1e/zwT3cT33/
	 QFtWz6kWQUeN8sxDUM3ihpkk4n64fR/GzGkgDprLDTB6JUvH0EPDDF5KijXBr7xS+2
	 XohPaGHl5vUYdH1ujqpFQxdG6OcQFJLEqWgR8BO7QI27oG9kxCaTSgyptwss77W2Tw
	 Cvr7TxB0wwt1K4tk8t0AR/ZWNDwM+VQpjZ3tsZM9qbcPe4HepuwkVflOJXH3jsDwVi
	 z8CeHpFLFiDFc8dr6WEoU/oo=
Received: from zn.tnic (p5de8ed27.dip0.t-ipconnect.de [93.232.237.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id AC33940E019E;
	Mon,  1 Sep 2025 13:55:06 +0000 (UTC)
Date: Mon, 1 Sep 2025 15:54:59 +0200
From: Borislav Petkov <bp@alien8.de>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org,
	linux-efi@vger.kernel.org, x86@kernel.org,
	Ingo Molnar <mingo@kernel.org>,
	Kevin Loughlin <kevinloughlin@google.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Nikunj A Dadhania <nikunj@amd.com>
Subject: Re: [PATCH v7 05/22] x86/sev: Move GHCB page based HV communication
 out of startup code
Message-ID: <20250901135459.GAaLWlsx75fnPHveLl@fat_crate.local>
References: <20250828102202.1849035-24-ardb+git@google.com>
 <20250828102202.1849035-29-ardb+git@google.com>
 <20250831104945.GAaLQoyYmr316kHrKs@fat_crate.local>
 <CAMj1kXF-aD74+O_xf_f902wq2RdPpiXCEjJ9osbnEwAMoN_5Rw@mail.gmail.com>
 <CAMj1kXEQghhi4qCdV6PrYK-mTYFu5yVcn3fEOSZsC6vR7TiMEg@mail.gmail.com>
 <20250831111521.GAaLQuyYLUSN24_ZmT@fat_crate.local>
 <CAMj1kXFHrkY9R8xjrB_PFqswc2yOHGpPfEBq5WZ0rH_vbo55Mw@mail.gmail.com>
 <CAMj1kXHzK0pSjuRYcZ3E2PQzCx4PTAC-UDHirgFDPYEyLMtoeA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXHzK0pSjuRYcZ3E2PQzCx4PTAC-UDHirgFDPYEyLMtoeA@mail.gmail.com>

On Sun, Aug 31, 2025 at 03:11:04PM +0200, Ard Biesheuvel wrote:
> Alternatively, we might consider the below:

This is the full diff ontop of this current patch - it removes the
get_cpuflags() hunk too as it is not needed now. It builds fine and I'll test
with it and if all looks good, merge it with your patch.

Thx.

---
diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index 3628e9bddc6a..5cacb68a2011 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -371,6 +371,8 @@ static int sev_check_cpu_support(void)
 	if (!(eax & BIT(1)))
 		return -ENODEV;
 
+       sev_snp_needs_sfw = !(ebx & BIT(31));
+
 	return ebx & 0x3f;
 }
 
diff --git a/arch/x86/boot/cpuflags.c b/arch/x86/boot/cpuflags.c
index 63e037e94e4c..916bac09b464 100644
--- a/arch/x86/boot/cpuflags.c
+++ b/arch/x86/boot/cpuflags.c
@@ -106,18 +106,5 @@ void get_cpuflags(void)
 			cpuid(0x80000001, &ignored, &ignored, &cpu.flags[6],
 			      &cpu.flags[1]);
 		}
-
-		if (max_amd_level >= 0x8000001f) {
-			u32 ebx;
-
-			/*
-			 * The X86_FEATURE_COHERENCY_SFW_NO feature bit is in
-			 * the virtualization flags entry (word 8) and set by
-			 * scattered.c, so the bit needs to be explicitly set.
-			 */
-			cpuid(0x8000001f, &ignored, &ebx, &ignored, &ignored);
-			if (ebx & BIT(31))
-				set_bit(X86_FEATURE_COHERENCY_SFW_NO, cpu.flags);
-		}
 	}
 }
diff --git a/arch/x86/boot/startup/sev-shared.c b/arch/x86/boot/startup/sev-shared.c
index 24cbeaf7ff4f..a74678ef2a7a 100644
--- a/arch/x86/boot/startup/sev-shared.c
+++ b/arch/x86/boot/startup/sev-shared.c
@@ -51,6 +51,8 @@ static u32 cpuid_std_range_max __ro_after_init;
 static u32 cpuid_hyp_range_max __ro_after_init;
 static u32 cpuid_ext_range_max __ro_after_init;
 
+bool sev_snp_needs_sfw;
+
 void __head __noreturn
 sev_es_terminate(unsigned int set, unsigned int reason)
 {
@@ -658,7 +660,7 @@ static void __head pvalidate_4k_page(unsigned long vaddr, unsigned long paddr,
 	 * If validating memory (making it private) and affected by the
 	 * cache-coherency vulnerability, perform the cache eviction mitigation.
 	 */
-	if (validate && !has_cpuflag(X86_FEATURE_COHERENCY_SFW_NO))
+       if (validate && sev_snp_needs_sfw)
 		sev_evict_cache((void *)vaddr, 1);
 }
 
diff --git a/arch/x86/boot/startup/sme.c b/arch/x86/boot/startup/sme.c
index 70ea1748c0a7..1e94c7a140ad 100644
--- a/arch/x86/boot/startup/sme.c
+++ b/arch/x86/boot/startup/sme.c
@@ -521,6 +521,7 @@ void __head sme_enable(struct boot_params *bp)
 		return;
 
 	me_mask = 1UL << (ebx & 0x3f);
+       sev_snp_needs_sfw = !(ebx & BIT(31));
 
 	/* Check the SEV MSR whether SEV or SME is enabled */
 	sev_status = msr = native_rdmsrq(MSR_AMD64_SEV);
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 096307dc8f39..be9d7cb87ad0 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -569,6 +569,7 @@ bool sev_es_check_cpu_features(void);
 
 extern u16 ghcb_version;
 extern struct ghcb *boot_ghcb;
+extern bool sev_snp_needs_sfw;
 
 #else	/* !CONFIG_AMD_MEM_ENCRYPT */
 

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

