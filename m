Return-Path: <linux-efi+bounces-4873-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9674B89497
	for <lists+linux-efi@lfdr.de>; Fri, 19 Sep 2025 13:35:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3C6F1C84613
	for <lists+linux-efi@lfdr.de>; Fri, 19 Sep 2025 11:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 368833054C3;
	Fri, 19 Sep 2025 11:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AjT670fa"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F80D2E3AE6;
	Fri, 19 Sep 2025 11:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758281725; cv=none; b=CB+OxejBUy4WPWmzYewOdfVxC9+gtwOVtNxc6V0cYgQ/r3DHsXYPdGkEvw00RwQwXRKnR/9Q+SHACiCA6AN3dAOddyvM3nL6TktMCsqo5JMPTVyk+tbZQrzpHDvEXBZN3i5kLvshTUl8XdnftivUHSaM3oFwBWqsncfSm7BsWdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758281725; c=relaxed/simple;
	bh=8V/ME5FetuhSVUNdHBVPAq2YDWKI9klTf230RijzXoo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GjOHtqPeYqzARRv2xn9Beo7p3CUHK1oVJtzerQNO5KDg2T+77UqcM+TCPfw+VUVdRZpxr3+Xcf0sxRbg16vg5txDaO7H5tFPkx2zWV5h2XJaCu9CEfvTDNtdrP9JhII88dnRUjEjQtUJm0wQgwz9iFCo/4AV1Thqj1YokFeAF6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AjT670fa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6FACC4CEF0;
	Fri, 19 Sep 2025 11:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758281724;
	bh=8V/ME5FetuhSVUNdHBVPAq2YDWKI9klTf230RijzXoo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AjT670faGCLl/hl2yw+AaBv0uZfKXVuSzZ1v7N4f2eiUHjVVkho9EAKbR+5PazVVj
	 aM28J8HnJRxj6uxMdgPSFO4YpOVSDfaCK0sqjQFQV+RYZU/jh++3Am8SUEfT44I9io
	 9UWTXZcg7ZxsMkGGyvdthYlDqHsIDE3EmsageVOSjh0U/ZLmDwDVGvocctIZjj8nCf
	 lJpkc4VlgxtjrTtAmf/b09maMt1ydxNvpUx/9r9mDHVRPGaOx6GjcyseWVsJp5AFsJ
	 8HBQJp0qYYctc+hmJ+WDtSHIdfMDipo2gHK+2ddPycJqFc8Y1RzRfUM7dpzKOvkDt3
	 FtOzPc95o4KMw==
Date: Fri, 19 Sep 2025 12:35:19 +0100
From: Will Deacon <will@kernel.org>
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Ard Biesheuvel <ardb@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 6/8] arm64/efi: Use a mutex to protect the EFI stack
 and FP/SIMD state
Message-ID: <aM0_96QvR-hlYMJJ@willie-the-truck>
References: <20250918103010.2973462-10-ardb+git@google.com>
 <20250918103010.2973462-16-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250918103010.2973462-16-ardb+git@google.com>

On Thu, Sep 18, 2025 at 12:30:17PM +0200, Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
> 
> Replace the spinlock in the arm64 glue code with a mutex, so that
> the CPU can preempted while running the EFI runtime service.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/arm64/kernel/efi.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/kernel/efi.c b/arch/arm64/kernel/efi.c
> index 0d52414415f3..4372fafde8e9 100644
> --- a/arch/arm64/kernel/efi.c
> +++ b/arch/arm64/kernel/efi.c
> @@ -166,15 +166,22 @@ asmlinkage efi_status_t efi_handle_corrupted_x18(efi_status_t s, const char *f)
>  	return s;
>  }
>  
> -static DEFINE_RAW_SPINLOCK(efi_rt_lock);
> +static DEFINE_MUTEX(efi_rt_lock);
>  
>  bool arch_efi_call_virt_setup(void)
>  {
>  	if (!may_use_simd())
>  		return false;
>  
> +	/*
> +	 * This might be called from a non-sleepable context so try to take the
> +	 * lock but don't block on it. This should never fail in practice, as
> +	 * all EFI runtime calls are serialized under the efi_runtime_lock.
> +	 */
> +	if (WARN_ON(!mutex_trylock(&efi_rt_lock)))
> +		return false;

If it will never fail in practice, why do we need the lock at all? Can we
just assert that the efi_runtime_lock is held instead and rely on that?

Will

