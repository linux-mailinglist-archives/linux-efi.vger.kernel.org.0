Return-Path: <linux-efi+bounces-4288-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DEEDB01E36
	for <lists+linux-efi@lfdr.de>; Fri, 11 Jul 2025 15:48:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8DDB1CA5F9F
	for <lists+linux-efi@lfdr.de>; Fri, 11 Jul 2025 13:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06B1E1FBEA6;
	Fri, 11 Jul 2025 13:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ILSyCxPb"
X-Original-To: linux-efi@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04CD29B23E;
	Fri, 11 Jul 2025 13:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752241721; cv=none; b=Z6Oz8uE+LPch8TD1JhUSO9+/8jTR4IZiCf2T+4W1iAu0+JaaHPQ+ZmDZkxF98MrpvbAICDQxSoIpQSkQlQ76WuvoiM4K5UmM9DmrBO685TWnKj0WyZfiOmbIj6pGw1OxbjG/mbcWay0NMGxBroWd6exy1QdiRIu/KnxabWBZLco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752241721; c=relaxed/simple;
	bh=IHqigtY29yY7gPTIcs+da8MtQgmREaPNajbBlRNBv+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C/PacXjsprEk/+yPjhpMA8s5kCL5lEfVpqWBDJbcGzE/IBD1HQ4wQSHGJ/wNimJbGEBVHf71FARw8t7sgM2lWYBE8Xz7azt2TC6rIZB/exLd+l13xkCLJKH1Pf1H9w4kX0gmEaROK7Krlpg+FebMZX0HkhfzH/3Zkh3xHqw1TRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ILSyCxPb; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=tUH0tIJOVwWDFNy2+9dmZOhPrE/5Fvoqxfp+0bTHgrI=; b=ILSyCxPbk9iapgeHlg4wA4zdDm
	lO8IwymKmEFClv4NLy7s1kVZAteH8c9eQg/Zw80qWFIqwNkSVOvx1Kcofm7oF5VOxM7OjiTMLyukj
	6CrTpwLxe2sdVRcN1KJN39vynhDYc4PPOlttlR/7/iOcMcDts42+IvYh+bLP5mVA6gvyj47/vwQdV
	hqzmPYBzqd3LWdPotluHFfUBwtgaVNc+xuZ01DVi11lGFk7LCRkNsrWHtI16FKBXjf5Aqn+lPmQKL
	07mbIPOyVpRo6s9rCf4R/I2+myctI6Os1ssVStTLFPhaXGo4DPV1QV/RzcanSRYTmPS7j71utJ33m
	uP3ltx1w==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uaE77-0000000DBNW-3Hvg;
	Fri, 11 Jul 2025 13:48:34 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 2C35D3001AA; Fri, 11 Jul 2025 15:48:33 +0200 (CEST)
Date: Fri, 11 Jul 2025 15:48:33 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Ard Biesheuvel <ardb@kernel.org>, Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [RFC PATCH 7/7] arm64/efi: Call EFI runtime services without
 disabling preemption
Message-ID: <20250711134833.GI905792@noisy.programming.kicks-ass.net>
References: <20250514174339.1834871-9-ardb+git@google.com>
 <20250514174339.1834871-16-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250514174339.1834871-16-ardb+git@google.com>

On Wed, May 14, 2025 at 07:43:47PM +0200, Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
> 
> The only remaining reason why EFI runtime services are invoked with
> preemption disabled is the fact that the mm is swapped out behind the
> back of the context switching code.
> 
> The kernel no longer disables preemption in kernel_neon_begin().
> Furthermore, the EFI spec is being clarified to explicitly state that
> only baseline FP/SIMD is permitted in EFI runtime service
> implementations, and so the existing kernel mode NEON context switching
> code is sufficient to preserve and restore the execution context of an
> in-progress EFI runtime service call.
> 
> Most EFI calls are made from the efi_rts_wq, which is serviced by a
> kthread. As kthreads never return to user space, they usually don't have
> an mm, and so we can use the existing infrastructure to swap in the
> efi_mm while the EFI call is in progress. This is visible to the
> scheduler, which will therefore reactivate the selected mm when
> switching out the kthread and back in again.
> 
> Given that the EFI spec explicitly permits runtime services to be called
> with interrupts enabled, firmware code is already required to tolerate
> interruptions. So rather than disable preemption, disable only migration
> so that EFI runtime services are less likely to cause scheduling delays.
> 
> Note, though, that the firmware executes at the same privilege level as
> the kernel, and is therefore able to disable interrupts altogether.

Is the migrate_disable() strictly required, or just paranoia?

> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/arm64/kernel/efi.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/kernel/efi.c b/arch/arm64/kernel/efi.c
> index 5d188c6c44d7..1c86a891f6d7 100644
> --- a/arch/arm64/kernel/efi.c
> +++ b/arch/arm64/kernel/efi.c
> @@ -10,6 +10,7 @@
>  #include <linux/efi.h>
>  #include <linux/init.h>
>  #include <linux/kmemleak.h>
> +#include <linux/kthread.h>
>  #include <linux/screen_info.h>
>  #include <linux/vmalloc.h>
>  
> @@ -176,7 +177,12 @@ bool arch_efi_call_virt_setup(void)
>  	if (WARN_ON(down_trylock(&efi_rt_lock)))
>  		return false;
>  
> -	efi_virtmap_load();
> +	if (preemptible() && (current->flags & PF_KTHREAD)) {
> +		migrate_disable();
> +		kthread_use_mm(&efi_mm);
> +	} else {
> +		efi_virtmap_load();
> +	}
>  	uaccess_ttbr0_enable();
>  	post_ttbr_update_workaround();
>  	__efi_fpsimd_begin();
> @@ -186,7 +192,12 @@ bool arch_efi_call_virt_setup(void)
>  void arch_efi_call_virt_teardown(void)
>  {
>  	__efi_fpsimd_end();
> -	efi_virtmap_unload();
> +	if (preemptible() && (current->flags & PF_KTHREAD)) {
> +		kthread_unuse_mm(&efi_mm);
> +		migrate_enable();
> +	} else {
> +		efi_virtmap_unload();
> +	}
>  	uaccess_ttbr0_disable();
>  	up(&efi_rt_lock);
>  }
> -- 
> 2.49.0.1101.gccaa498523-goog
> 

