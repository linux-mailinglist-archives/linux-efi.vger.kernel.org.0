Return-Path: <linux-efi+bounces-4667-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CB51B3FF89
	for <lists+linux-efi@lfdr.de>; Tue,  2 Sep 2025 14:12:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D67CF7B6235
	for <lists+linux-efi@lfdr.de>; Tue,  2 Sep 2025 12:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C821D2FE56B;
	Tue,  2 Sep 2025 12:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="GgOyPr/L"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367F72FE07A;
	Tue,  2 Sep 2025 12:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756814571; cv=none; b=bFnBY0B3U7119pIkeHB/11RByf0qCcBXX+WesMTcO7kTThEfNGX4bdgW2NruuaI3z41oKYZovuYiaYM4V9YwGLspximiNm6Z6ufws/XsQwJcXf/FLw+2zJYicBcrf/xiIKS8O+mKotwu79bNtez8LOHsf1syxiC8c2nGhZ2DPoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756814571; c=relaxed/simple;
	bh=CwE8Iiw68/uzZT/mtmAwKoRWHB8F8/jfiVYaL+2zQP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ulwu12/lGJDfpdZMOz1RYwnSjpmkg0P+MULYjgZmj9oCWc44BRwIO6uuPz/d5lXZa6oMCG0oHyjDddwrapcibQF5vKMBmu8SgVNkpH3vPaD9dMcPWNFeGA9HYFCH0MlZtqKnxAzPZnwG9klT+iXOh4sCqXPC8+5T9vSZIRAoqck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=GgOyPr/L; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id EF02A40E015D;
	Tue,  2 Sep 2025 12:02:46 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id NvBnkxzadkuv; Tue,  2 Sep 2025 12:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1756814558; bh=OwxO8ZYN/0+6twEjoJqCZYdBQyL2rbwMVXMrhCi5yl4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GgOyPr/LaNeIM7fqQdue00qYiTpQ30zirpXn2vQmE9/jt78tN4WXipM104y0l9jJs
	 b9hrM9Z0w/oMGcLz7D+Ji8KoEt/ZK6uoujYUUj0NEmGJFXWzrufPqQ6B2/+5QfAh1W
	 zQMINzCSuzQdxwA3w1VXK0lU5NU2Sj/OWrvQ/CpHkFMhWL+ue0dYz5x06pET3lWi0C
	 eNExE5cBJq2vBDkwEo7C/lJLkCSQtatMErX0nAH8CIMhQ5ev4aMpRQl++gAsfaHRP6
	 DDePMCO+5b05BX82eyI7PUPMnZHvEqjukIQtSu8UWzx5Br6DoYnV+uQyRDPIeEKgNh
	 sk4THCX8f2ZNvYupZMMd6XvEKnMZyKOCVYoortzh8393BpWjgnzztPS3eKR+YDCAEV
	 0Omhuu9E3Df7er6IVgeaqStWb7SRVg61N69P6M4h6ExtIOLW0byhA9WcbZnX6s8qgi
	 5tFa93oGSO4Jk4id04hN7s2yE3Rs15S67GQq2HXaexoReU//mJ9OoRs4wqVUYCbGHL
	 WoHl6qihmkHbhkD8EbofdVEStxb27QuPLFKs/5S6PXUjD6DWNb/tNbSgAiIezd1/1A
	 WdGFZGIAiS6KgKUVIwzN/grdZuNW/pnqGLH+gtktd5tCfEPAYCbap6eYIN/XtDPYZc
	 ktgKxATR8k35dCPHKbex/gRQ=
Received: from zn.tnic (p5de8ed27.dip0.t-ipconnect.de [93.232.237.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 3355640E01B3;
	Tue,  2 Sep 2025 12:02:27 +0000 (UTC)
Date: Tue, 2 Sep 2025 14:02:21 +0200
From: Borislav Petkov <bp@alien8.de>
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org, x86@kernel.org,
	Ard Biesheuvel <ardb@kernel.org>, Ingo Molnar <mingo@kernel.org>,
	Kevin Loughlin <kevinloughlin@google.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Nikunj A Dadhania <nikunj@amd.com>
Subject: Re: [PATCH v7 10/22] x86/boot: Drop redundant RMPADJUST in SEV SVSM
 presence check
Message-ID: <20250902120221.GEaLbczaZ1RPY7dGKH@fat_crate.local>
References: <20250828102202.1849035-24-ardb+git@google.com>
 <20250828102202.1849035-34-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250828102202.1849035-34-ardb+git@google.com>

On Thu, Aug 28, 2025 at 12:22:13PM +0200, Ard Biesheuvel wrote:
> -		/*
> -		 * Running at VMPL0 is not required if an SVSM is present and the hypervisor
> -		 * supports the required SVSM GHCB events.
> -		 */
> -		if (ret &&
> -		    !(snp_vmpl && (hv_features & GHCB_HV_FT_SNP_MULTI_VMPL)))
> +		if (snp_vmpl > 0 && !(hv_features & GHCB_HV_FT_SNP_MULTI_VMPL))

Yeah, it is unsigned:

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index 973ca206794a..808211b09424 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -415,7 +415,7 @@ void sev_enable(struct boot_params *bp)
 		 * Running at VMPL0 is required unless an SVSM is present and
 		 * the hypervisor supports the required SVSM GHCB events.
 		 */
-		if (snp_vmpl > 0 && !(hv_features & GHCB_HV_FT_SNP_MULTI_VMPL))
+		if (snp_vmpl && !(hv_features & GHCB_HV_FT_SNP_MULTI_VMPL))
 			sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_NOT_VMPL0);
 	}
 
-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

