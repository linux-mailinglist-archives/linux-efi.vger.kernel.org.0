Return-Path: <linux-efi+bounces-5347-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4AB7C31F11
	for <lists+linux-efi@lfdr.de>; Tue, 04 Nov 2025 16:53:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A999018C451E
	for <lists+linux-efi@lfdr.de>; Tue,  4 Nov 2025 15:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5E0B27146A;
	Tue,  4 Nov 2025 15:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eP7/zdJv"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D131E9B37;
	Tue,  4 Nov 2025 15:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762271553; cv=none; b=o/1hot5t58aVhegM2o7hl/1FQibSaALWKQaVWatRvAHCdsVahJjUTqKxqophLXQexakuqjyxt2MWHM+AAaX/NfA4wD9zPvcA+ioGeLAw4YChh+ltrqvdU0u2lp7WM6bnxCF67ZIcJJWADhhQdzNbj+ypXj0MEyxhbtz7vQoeNCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762271553; c=relaxed/simple;
	bh=FptEc2MZwx9dNjeyW235y8KQvDpvs5UTFR4T5099nDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IZOBSSiVLPPXZKKk3ZyvLKVKXtFTDcWnpLcQcavIYBOuouc4lJox4mLg87+Mnz0eYNyGUALmV3c2FhtSn/dQz5pWa6VAHfgxCtsVelrSSClZ30sMPZKz98On4lKl8Z/JTECBCorC5/GnKV8rDj9N2V8lAVONi0nS8H2sfjOGPOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eP7/zdJv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C11ABC4CEF8;
	Tue,  4 Nov 2025 15:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762271553;
	bh=FptEc2MZwx9dNjeyW235y8KQvDpvs5UTFR4T5099nDo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eP7/zdJvv5oA4eUAgZBZfROBTPXF0AGhszclDFsQ9K36ZL7UguMIlkB9mIDX1jLXD
	 pj0fC9D4Y4vCJ3b2jRzRGeE7sRRDzImAiiGHtnq150lheDex1fxcm/jUOXEgMT5Ipr
	 6DpZ+VVmfMmRKUpR94XtptTkkrl+UtU94P3S1B4H+m070ssZFKhzk7gD618oXALPOQ
	 MvCD/IRI8Gu/24TW93pwKCWwEq5Z4JW0mE4y1i7p/7kWO5Ue9Pqz8D67HHacjhdRKd
	 JBG6rsQnEKRflR067gAcTc6rzTM1xWFgSfnRfdM0HDD8iGKTqPvmFBYjJwrY9QvuEQ
	 ceQme3cb4Tc1w==
Date: Tue, 4 Nov 2025 15:52:27 +0000
From: Will Deacon <will@kernel.org>
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Ard Biesheuvel <ardb@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Mark Brown <broonie@kernel.org>,
	Pierre Gondois <Pierre.Gondois@arm.com>,
	Sami Mujawar <Sami.Mujawar@arm.com>
Subject: Re: [PATCH v4 resend 3/7] arm64/fpsimd: Don't warn when EFI
 execution context is preemptible
Message-ID: <aQohO07DpxlriQfJ@willie-the-truck>
References: <20251015205634.3820870-9-ardb+git@google.com>
 <20251015205634.3820870-12-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015205634.3820870-12-ardb+git@google.com>

On Wed, Oct 15, 2025 at 10:56:38PM +0200, Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
> 
> Kernel mode FP/SIMD no longer requires preemption to be disabled, so
> only warn on uses of FP/SIMD from preemptible context if the fallback
> path is taken for cases where kernel mode NEON would not be allowed
> otherwise.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/arm64/kernel/fpsimd.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
> index e3f8f51748bc..3d848c89604e 100644
> --- a/arch/arm64/kernel/fpsimd.c
> +++ b/arch/arm64/kernel/fpsimd.c
> @@ -1934,11 +1934,11 @@ void __efi_fpsimd_begin(void)
>  	if (!system_supports_fpsimd())
>  		return;
>  
> -	WARN_ON(preemptible());
> -
>  	if (may_use_simd()) {
>  		kernel_neon_begin();
>  	} else {
> +		WARN_ON(preemptible());
> +

Given that may_use_simd() returns false on systems without support for
fpsimd, I wonder whether moving this WARN_ON() actually helps with
anything. That is, you probably shouldn't be calling __efi_fpsimd_begin()
from preemptible code regardless, no?

Will

