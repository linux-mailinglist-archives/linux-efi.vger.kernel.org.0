Return-Path: <linux-efi+bounces-4649-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A70B3A484
	for <lists+linux-efi@lfdr.de>; Thu, 28 Aug 2025 17:33:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5ADCFA01452
	for <lists+linux-efi@lfdr.de>; Thu, 28 Aug 2025 15:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD34E2397BF;
	Thu, 28 Aug 2025 15:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="epGcgtWO"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE46A230BF8;
	Thu, 28 Aug 2025 15:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756395226; cv=none; b=C8aONKTkANdaL78vJfohPRcVKfcN7iPEi07RyQhMHLpzhTKqVJ5YHXVh/mved6FlXAvTdGwuqFzmtOuGfLv31Mus8e7G+KqR3UW5bvZXoWHgQ5qsNFE/6ARK0rak2hN1NU8dEeVn5U02gZIOEvgoy5x+2fHl9/6I+Po7UiUfZvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756395226; c=relaxed/simple;
	bh=L/wrJJW+zsakS3v8mZhjJIFtUUxX77tfd0hFmjNdpv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LE+iWIDYOnqquQiwX3ubVPGGt2K1CIeWHnBrcneSJu6GVNgRfZwWOzPZemLfPC9mKYst4N+Zdy41m72NSPNQcdoHm/YJBjEtTtwxNQQR/XFFLxCylEwmaCx4JP2YF2aBmowpNp/5rDnAuef0VQNt8VjpZIpFWnyH9VBlvFe3gAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=epGcgtWO; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 7397540E0176;
	Thu, 28 Aug 2025 15:33:41 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id HpUUbd6cDfRY; Thu, 28 Aug 2025 15:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1756395218; bh=UNCPq6/6K2eLwrlzUsHd93fSfZJ45fbgGFibHSJZEek=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=epGcgtWO1dKvRMTIiyeuDpEXeGVhONNf7EYvYY/Gp9Xi4fKq1jifkr9oQdDMdNW7P
	 dCnVmv9CSP/wxGaqIQNO2om09/sANhNB+jQLN9XUgdXazf4YWQSpw5ZaKx0TWjlmJQ
	 6wpNIgBaWz9t9e9Mf4FnX/8ETBeB+OGzMYoUSEdCQ8yhBfPoAPogOp2yxzT73uT+H+
	 ZQysiiUHODuPtxSTPvhGrW6MwwZBOWkwlhX8qbOheRARbHebNQMRolhAPpKTiFXq3p
	 lJVwPzkuxpL1FIcsAuOhmwHrZLFQt8H49K1QI6FUW9hopVHBQ99fl7cvq9OPuRUEzs
	 WqCpXLWmlWhl3bgZkGN09XScz5jO7nlurG7lRs9HfPtDickzbkUpzkWSze16yOmn9c
	 mBrAhC9yskWVtO4e+93jJwnzOI9eQBabPdjphlpA5TDOUmiQaLJRTyCmejJh64MukU
	 6oV+1Mn63YU4O4LWjD4AhvuE7eBM3hDM7c2BAuvKp0pkN7PMs5E0eldzS2MQ53JNIS
	 +Upcq0n5QhS/+ph1F1fROF4XE4Up5zIuUZ0uo5NhfG9FECr3LB9mFg6QOC0O1IXl0/
	 v4ooBcIO3ZpIXyicX1uVqRLaBSX5tstMliISwmLzWRJSQvO5lajtOCgO9s/sTGGl42
	 pmQlXbROWCjnDKwbPEGD2sMI=
Received: from zn.tnic (pd953092e.dip0.t-ipconnect.de [217.83.9.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DA41940E00DD;
	Thu, 28 Aug 2025 15:33:24 +0000 (UTC)
Date: Thu, 28 Aug 2025 17:33:17 +0200
From: Borislav Petkov <bp@alien8.de>
To: Ard Biesheuvel <ardb+git@google.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Michael Roth <michael.roth@amd.com>,
	=?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
Cc: linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org, x86@kernel.org,
	Ard Biesheuvel <ardb@kernel.org>, Ingo Molnar <mingo@kernel.org>,
	Kevin Loughlin <kevinloughlin@google.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Nikunj A Dadhania <nikunj@amd.com>
Subject: Re: [PATCH v7 01/22] x86/sev: Separate MSR and GHCB based
 snp_cpuid() via a callback
Message-ID: <20250828153317.GJaLB2vSvuR20WzgQV@fat_crate.local>
References: <20250828102202.1849035-24-ardb+git@google.com>
 <20250828102202.1849035-25-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250828102202.1849035-25-ardb+git@google.com>

+ Joerg and Mike to doublecheck me.

On Thu, Aug 28, 2025 at 12:22:04PM +0200, Ard Biesheuvel wrote:
> @@ -648,7 +611,7 @@ void __head do_vc_no_ghcb(struct pt_regs *regs, unsigned long exit_code)
>  	leaf.fn = fn;
>  	leaf.subfn = subfn;
>  
> -	ret = snp_cpuid(NULL, NULL, &leaf);
> +	ret = snp_cpuid(snp_cpuid_hv_msr, NULL, &leaf);
>  	if (!ret)
>  		goto cpuid_done;
>  

So this code becomes now:

---
        ret = snp_cpuid(snp_cpuid_hv_msr, NULL, &leaf);
        if (!ret)
                goto cpuid_done;

<--- tries to find the CPUID leaf in the CPUID table
<--- otherwise uses the MSR protocol to read CPUID from HV and massage it

        if (ret != -EOPNOTSUPP)
                goto fail;

        if (__sev_cpuid_hv_msr(&leaf))
                goto fail;

<--- and now it tries to do the same - do CPUID over MSR protocol.

This flow made sense before your change because it'll try to use the GHCB
protocol but you're zapping that now so, IOW, you can zap that second call
too:


diff --git a/arch/x86/boot/startup/sev-shared.c b/arch/x86/boot/startup/sev-shared.c
index ed88dfe7605e..fbfdfe0dce70 100644
--- a/arch/x86/boot/startup/sev-shared.c
+++ b/arch/x86/boot/startup/sev-shared.c
@@ -612,16 +612,9 @@ void __head do_vc_no_ghcb(struct pt_regs *regs, unsigned long exit_code)
 	leaf.subfn = subfn;
 
 	ret = snp_cpuid(snp_cpuid_hv_msr, NULL, &leaf);
-	if (!ret)
-		goto cpuid_done;
-
-	if (ret != -EOPNOTSUPP)
-		goto fail;
-
-	if (__sev_cpuid_hv_msr(&leaf))
+	if (ret && ret != -EOPNOTSUPP)
 		goto fail;
 
-cpuid_done:
 	regs->ax = leaf.eax;
 	regs->bx = leaf.ebx;
 	regs->cx = leaf.ecx;

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

