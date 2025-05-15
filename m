Return-Path: <linux-efi+bounces-3715-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FE22AB8CB8
	for <lists+linux-efi@lfdr.de>; Thu, 15 May 2025 18:44:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E76E64607F0
	for <lists+linux-efi@lfdr.de>; Thu, 15 May 2025 16:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C2FC221289;
	Thu, 15 May 2025 16:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="NEYY0NGj"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C58C220F36;
	Thu, 15 May 2025 16:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747327444; cv=none; b=paiAy+qthwnEaZKifI3GRSdrM/zBk+OeoTaDEGlcz4sCxE/gcSUjLEoEqRWnEcSsSG3Ay932e4UQGPoHQ9qZykmScNmzlBo3TJiT/t0JxUwFcAfoF65HXRMWpYw1klz4/02ENMl/Mwu5fudHYKEMf2sVSSgsWeyblO2gVTa3KY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747327444; c=relaxed/simple;
	bh=hUuvLAlxl36gzoPyWEpN4pSZaYUNo3hhA/Y82uDCWvI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q8X+GEOLFn9RGe4oApkdS+cghvVxAjk2CJAoKRc0Zc47cekbZdsO+tiCoTzQlnbbXC8yT56p+SkrOvJsMqiZpXW+GgIHJfqpZkKdsHpNLWP9qqlA3cWST02MS4UsgrQNn1BwAHsVEf4lbmWq9KGzwhdTuG2RBuwjFEXNe0TS9rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=NEYY0NGj; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id A598140E01ED;
	Thu, 15 May 2025 16:43:58 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id DKdTbWNw82uG; Thu, 15 May 2025 16:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1747327434; bh=heO/KKccK7/qsTVyu/x6gPewEvLAKaNyPahysf1Wvno=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NEYY0NGjCf2etHNpYOdE6F1X2bmjkcx2E/BEQGyuhS/iDfgI0XCsRAK2DRndXxGN8
	 xGZt2g4glR0jfkJMBgIeseEqknKTFDcjFcZNZ0nS3Omhi8io3eM+pxgFjW+dwU7afZ
	 r0Rjz/hsL9nmuhmQEIkcRJDnQPCffTJFMchzCftd2FwWjCYMsu3Oqk4uVUyKVxtmWU
	 ctc5rQrvH3NwrJteaDoY2zHvddKPzB9rD7Y2ll9kf24gYjqcp8Cy3aJOA2VNL5RBjp
	 A1UKtiPhw9pl/ZGUvpnmwDWqhxgcctQF3G0IpnV9NpJ1vyjga6ciG7ZlXhofFVWBLm
	 NHwh0gdMIds8PKDEa7jlyRGiWTfAg+tqePHUt+s9BxB/TJ5TyG6u/smsoKdZmozub+
	 LPaxP8yu1lGagWJd0nkj4qckhR/UsXu3x0j7zEDFYPP0Dbu9RcKGDMRqKSv0Nrhds7
	 CNeGoZXtRwz+28zE3yylq6TpGfv2GkJiNeVD/62snH8LciZ1aFjN4eHuQF8kXYgkFt
	 5cg9eLkJ6GIoEf+orKpCN1bk0Zyp6364QJUK++YgXnvydU2+gyRpQVFeBkqn8t1IKX
	 OzMl1I1DQlNiUNb6onK+punbviq5T0yx0XunBn7BRJfWoADXZDaiRV/Q+BXUnEwy4i
	 O8H1Ph/0ANc35433TMHc02g8=
Received: from zn.tnic (p579690ee.dip0.t-ipconnect.de [87.150.144.238])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2036440E0196;
	Thu, 15 May 2025 16:43:45 +0000 (UTC)
Date: Thu, 15 May 2025 18:43:37 +0200
From: Borislav Petkov <bp@alien8.de>
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org, x86@kernel.org,
	Ard Biesheuvel <ardb@kernel.org>, Ingo Molnar <mingo@kernel.org>,
	Dionna Amalie Glaze <dionnaglaze@google.com>,
	Kevin Loughlin <kevinloughlin@google.com>,
	Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [RFT PATCH v3 02/21] x86/sev: Use MSR protocol for remapping
 SVSM calling area
Message-ID: <20250515164337.GDaCYZuXXjJkfRlK8k@fat_crate.local>
References: <20250512190834.332684-23-ardb+git@google.com>
 <20250512190834.332684-25-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250512190834.332684-25-ardb+git@google.com>

On Mon, May 12, 2025 at 09:08:37PM +0200, Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
> 
> As the preceding code comment already indicates, remapping the SVSM
> calling area occurs long before the GHCB page is configured, and so
> calling svsm_perform_call_protocol() is guaranteed to result in a call
> to svsm_perform_msr_protocol().
> 
> So just call the latter directly. This allows most of the GHCB based API
> infrastructure to be moved out of the startup code in a subsequent
> patch.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/x86/boot/startup/sev-startup.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/boot/startup/sev-startup.c b/arch/x86/boot/startup/sev-startup.c
> index 435853a55768..a1d5a5632d58 100644
> --- a/arch/x86/boot/startup/sev-startup.c
> +++ b/arch/x86/boot/startup/sev-startup.c
> @@ -325,7 +325,9 @@ static __head void svsm_setup(struct cc_blob_sev_info *cc_info)
>  	call.caa = svsm_get_caa();
>  	call.rax = SVSM_CORE_CALL(SVSM_CORE_REMAP_CA);
>  	call.rcx = pa;
> -	ret = svsm_perform_call_protocol(&call);
> +	do {
> +		ret = svsm_perform_msr_protocol(&call);
> +	} while (ret == -EAGAIN);

Right, a future cleanup for another patch would be to wrap that loop into
a function. But not now.

>  	if (ret)
>  		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_SVSM_CA_REMAP_FAIL);
>  
> -- 

Reviewed-by: Borislav Petkov (AMD) <bp@alien8.de>

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

