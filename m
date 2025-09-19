Return-Path: <linux-efi+bounces-4872-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89ED4B8947C
	for <lists+linux-efi@lfdr.de>; Fri, 19 Sep 2025 13:33:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E73D7C4B34
	for <lists+linux-efi@lfdr.de>; Fri, 19 Sep 2025 11:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D4602FC00E;
	Fri, 19 Sep 2025 11:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V5NAluUH"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D0286347;
	Fri, 19 Sep 2025 11:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758281602; cv=none; b=bCylm47WIJ3TNeXseNUL/N1u/8hn23EE8C1Jw+DWHoRSDUb0yOhUFEg7GUrK2yZHJ4cvpBM5OYsJuJ9JSdLS+q/tpqmjRbZ/lorF4VccYFw1+OEB/cePVxeCpsn8sgdKb67YtUk59Ed7VkqydlYRgT13tWAXsFSG7GUvR2tS99k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758281602; c=relaxed/simple;
	bh=60tCwws14AuRTFjXSEyQh2FegsOGpWR0H6cOtV+AU1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aPp2Q34i/1mtR4MgQeLRkQiPVvzXATI4x6Ag5jr4L3xnnzUo8TAPT6JzEJ4SndAgv/0RBtgROxgTLBRUy3OU9cJ0j1WdqJ4mrQHrYVKA5xeMkBKx8gBqZ72SZ3PlcNib/plr2UUOE85T3wA/323DdeBgXA5tLb9FVoLAvQHXC6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V5NAluUH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FF28C4CEF0;
	Fri, 19 Sep 2025 11:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758281601;
	bh=60tCwws14AuRTFjXSEyQh2FegsOGpWR0H6cOtV+AU1s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V5NAluUHjHtCOMCXJ4XwrXs4pzxwgex/sH+MaMTdYp/oCzjboGHROfXR3FRjc8ndF
	 s96itkkalOZXQEcUq7lUR+jO6oFiqROlEWpduBktsh9dTUd4s8cpn3jhJcXL1Br77Z
	 vFlYVtXPD/0sEnom513qD3tQ6gD7Z0p/xbX6OP/pjnVHsxQ+Y0e+rL18zP32spqHua
	 FmUpsY8KM9uAFpayuLzH1dxO7K8CGMBAycEqaO5+ot5XRMvnrFcv4tAN5wydjYhks/
	 COFZVxCOeSNJqiSxFs5tgFlkwVrhaOsd5z523Volgjc0h253cGVeK8fJ+WRVqPcIFv
	 hGCCnyx5DrkIg==
Date: Fri, 19 Sep 2025 12:33:16 +0100
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
Subject: Re: [PATCH v3 4/8] arm64/fpsimd: Permit kernel mode NEON with IRQs
 off
Message-ID: <aM0_fHqDtDyhZ8L-@willie-the-truck>
References: <20250918103010.2973462-10-ardb+git@google.com>
 <20250918103010.2973462-14-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250918103010.2973462-14-ardb+git@google.com>

On Thu, Sep 18, 2025 at 12:30:15PM +0200, Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
> 
> Currently, may_use_simd() will return false when called from a context
> where IRQs are disabled. One notable case where this happens is when
> calling the ResetSystem() EFI runtime service from the reboot/poweroff
> code path. For this case alone, there is a substantial amount of FP/SIMD
> support code to handle the corner case where a EFI runtime service is
> invoked with IRQs disabled.
> 
> The only reason kernel mode SIMD is not allowed when IRQs are disabled
> is that re-enabling softirqs in this case produces a noisy diagnostic
> when lockdep is enabled. The warning is valid, in the sense that
> delivering pending softirqs over the back of the call to
> local_bh_enable() is problematic when IRQs are disabled.
> 
> While the API lacks a facility to simply mask and unmask softirqs
> without triggering their delivery, disabling softirqs is not needed to
> begin with when IRQs are disabled, given that softirqs are only every
> taken asynchronously over the back of a hard IRQ.
> 
> So dis/enable softirq processing conditionally, based on whether IRQs
> are enabled, and relax the check in may_use_simd().
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/arm64/include/asm/simd.h |  2 +-
>  arch/arm64/kernel/fpsimd.c    | 16 ++++++++++------
>  2 files changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/simd.h b/arch/arm64/include/asm/simd.h
> index 8e86c9e70e48..abd642c92f86 100644
> --- a/arch/arm64/include/asm/simd.h
> +++ b/arch/arm64/include/asm/simd.h
> @@ -29,7 +29,7 @@ static __must_check inline bool may_use_simd(void)
>  	 */
>  	return !WARN_ON(!system_capabilities_finalized()) &&
>  	       system_supports_fpsimd() &&
> -	       !in_hardirq() && !irqs_disabled() && !in_nmi();
> +	       !in_hardirq() && !in_nmi();
>  }
>  
>  #else /* ! CONFIG_KERNEL_MODE_NEON */
> diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
> index c37f02d7194e..96a226316d1f 100644
> --- a/arch/arm64/kernel/fpsimd.c
> +++ b/arch/arm64/kernel/fpsimd.c
> @@ -225,10 +225,12 @@ static void fpsimd_bind_task_to_cpu(void);
>   */
>  static void get_cpu_fpsimd_context(void)
>  {
> -	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
> -		local_bh_disable();
> -	else
> +	if (!IS_ENABLED(CONFIG_PREEMPT_RT)) {
> +		if (!irqs_disabled())
> +			local_bh_disable();
> +	} else {
>  		preempt_disable();
> +	}
>  }
>  
>  /*
> @@ -240,10 +242,12 @@ static void get_cpu_fpsimd_context(void)
>   */
>  static void put_cpu_fpsimd_context(void)
>  {
> -	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
> -		local_bh_enable();
> -	else
> +	if (!IS_ENABLED(CONFIG_PREEMPT_RT)) {
> +		if (!irqs_disabled())
> +			local_bh_enable();

This is a little ugly, so I think a small comment summarising the
penultimate paragraph of your commit message would help to explain the dance
you're doing.

With that:

Acked-by: Will Deacon <will@kernel.org>

Will

