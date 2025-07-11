Return-Path: <linux-efi+bounces-4286-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 485ADB01E62
	for <lists+linux-efi@lfdr.de>; Fri, 11 Jul 2025 15:53:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5021B617FF
	for <lists+linux-efi@lfdr.de>; Fri, 11 Jul 2025 13:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A58F2D7819;
	Fri, 11 Jul 2025 13:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AQ2E+87a"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13DCE2D77FA;
	Fri, 11 Jul 2025 13:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752241324; cv=none; b=atBUs/deZbt3orNdQZxkoLLCbkFCKX/0IVrAIp8TbVPxXYwZ+h6UM8qxg3Kozd857Wigs74qgjKJNd1uvJu8d4owmbRb0mya4HFl8YpXYtwMq/vKmcI1fA3QVNjmEur2fOMFvsjcHTrEvagbSral6DUl+icyPzvd81WixNFSMhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752241324; c=relaxed/simple;
	bh=E+qQLRz6mPRPePZKtFgMgdhHMnIyYUYFPTP+kWQvHIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oMM+H90xyypLcLq4h5C2kAHCi/hWymdWc7AUMNRId7ext5/hcK2y6FqdVRJVRtIeloZNVpF0U1TOY4yNjq4kIvbGMg9n3L0l2fhIhZ0SAxGw+eVscA1lXoBHkgZzhNtyHyV4i5ZyLtpGBWIwW/wMf8GV18HXdkkzELnwSUpKSRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AQ2E+87a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F41F2C4CEED;
	Fri, 11 Jul 2025 13:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752241323;
	bh=E+qQLRz6mPRPePZKtFgMgdhHMnIyYUYFPTP+kWQvHIE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AQ2E+87aPmB2oO90D/mF50PyoPZCyzBHz4b5Y6PM2H+D1vplka2tb4RDipc9wFan8
	 vwNaJFJgXLt71CKtOsluLFBFPk4k6GDMtIepI+vZ6xouxcoDvD2EExIsRXQU4t0+QH
	 9LhtosxM6qmzWcb314/+AS9ZsLw2XoQaOS/X3K/5+qm67+uGm44WhPe6A0qTJfPPOc
	 7JsVNcPIqNfaiAPSPu4lNhCgQN0oGEFLV/xKNhU/Xkw0Fcr4kxt68pgAG0x53jB/NM
	 nQLxWnzjAvuIY5U7xkNxhgmIlJi6Myglh3Bl42w+Eh92hbZJyE+gVSNI2NyJ0QsHkC
	 c76o+WrRHzU1Q==
Date: Fri, 11 Jul 2025 14:41:58 +0100
From: Will Deacon <will@kernel.org>
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Ard Biesheuvel <ardb@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH 6/7] arm64/efi: Move uaccess en/disable out of
 efi_set_pgd()
Message-ID: <aHEUpiXt-pW7DBAN@willie-the-truck>
References: <20250514174339.1834871-9-ardb+git@google.com>
 <20250514174339.1834871-15-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250514174339.1834871-15-ardb+git@google.com>

On Wed, May 14, 2025 at 07:43:46PM +0200, Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
> 
> efi_set_pgd() will no longer be called when invoking EFI runtime
> services via the efi_rts_wq work queue, but the uaccess en/disable are
> still needed when using PAN emulation using TTBR0 switching. So move
> these into the callers.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/arm64/include/asm/efi.h | 3 ---
>  arch/arm64/kernel/efi.c      | 3 +++
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/efi.h b/arch/arm64/include/asm/efi.h
> index decf87777f57..abe9176a3a23 100644
> --- a/arch/arm64/include/asm/efi.h
> +++ b/arch/arm64/include/asm/efi.h
> @@ -132,15 +132,12 @@ static inline void efi_set_pgd(struct mm_struct *mm)
>  			 * exception when invoking the EFI run-time services.
>  			 */
>  			update_saved_ttbr0(current, mm);
> -			uaccess_ttbr0_enable();
> -			post_ttbr_update_workaround();
>  		} else {
>  			/*
>  			 * Defer the switch to the current thread's TTBR0_EL1
>  			 * until uaccess_enable(). Restore the current
>  			 * thread's saved ttbr0 corresponding to its active_mm
>  			 */
> -			uaccess_ttbr0_disable();
>  			update_saved_ttbr0(current, current->active_mm);
>  		}
>  	}
> diff --git a/arch/arm64/kernel/efi.c b/arch/arm64/kernel/efi.c
> index d01ae156bb63..5d188c6c44d7 100644
> --- a/arch/arm64/kernel/efi.c
> +++ b/arch/arm64/kernel/efi.c
> @@ -177,6 +177,8 @@ bool arch_efi_call_virt_setup(void)
>  		return false;
>  
>  	efi_virtmap_load();
> +	uaccess_ttbr0_enable();
> +	post_ttbr_update_workaround();
>  	__efi_fpsimd_begin();
>  	return true;
>  }
> @@ -185,6 +187,7 @@ void arch_efi_call_virt_teardown(void)
>  {
>  	__efi_fpsimd_end();
>  	efi_virtmap_unload();
> +	uaccess_ttbr0_disable();

Moving this after updating the saved TTBR0 isn't great for SWPAN, as it
means that if we take an exception (e.g. an IRQ) before calling
uaccess_ttbr0_disable() then I think we'll end up running with the user
page-table installed briefly in TTBR0 which SWPAN is supposed to prevent
outside of genuine uaccess sections.

Will

