Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A5E11735E2
	for <lists+linux-efi@lfdr.de>; Fri, 28 Feb 2020 12:14:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbgB1LO5 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 28 Feb 2020 06:14:57 -0500
Received: from foss.arm.com ([217.140.110.172]:36606 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726400AbgB1LO4 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 28 Feb 2020 06:14:56 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 05B854B2;
        Fri, 28 Feb 2020 03:14:56 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6F9853F73B;
        Fri, 28 Feb 2020 03:14:55 -0800 (PST)
Date:   Fri, 28 Feb 2020 11:14:50 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH efi-next 2/3] efi/arm64: clean EFI stub exit code from
 cache instead of avoiding it
Message-ID: <20200228111450.GA36089@lakrids.cambridge.arm.com>
References: <20200228100244.10979-1-ardb@kernel.org>
 <20200228100244.10979-3-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200228100244.10979-3-ardb@kernel.org>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Feb 28, 2020 at 11:02:43AM +0100, Ard Biesheuvel wrote:
> Commit 9f9223778 ("efi/libstub/arm: Make efi_entry() an ordinary PE/COFF
> entrypoint") modified the handover code written in assembler, and for
> maintainability, aligned the logic with the logic used in the 32-bit ARM
> version, which is to avoid cache maintenance on the remaining instructions
> in the subroutine that will be executed with the MMU and caches off, and
> instead, branch into the relocated copy of the kernel image.
> 
> However, this assumes that this copy is executable, and this means we
> expect EFI_LOADER_DATA regions to be executable as well, which is not
> a reasonable assumption to make, even if this is true for most UEFI
> implementations today.
> 
> So change this back, and add a __flush_dcache_area() call to cover the
> remaining code in the subroutine.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/arm64/kernel/efi-entry.S  | 18 +++++++++---------
>  arch/arm64/kernel/image-vars.h |  2 +-
>  2 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/arm64/kernel/efi-entry.S b/arch/arm64/kernel/efi-entry.S
> index 4cfd03c35c49..d5dee064975f 100644
> --- a/arch/arm64/kernel/efi-entry.S
> +++ b/arch/arm64/kernel/efi-entry.S
> @@ -19,7 +19,8 @@ ENTRY(efi_enter_kernel)
>  	 * point stored in x0. Save those values in registers which are
>  	 * callee preserved.
>  	 */
> -	mov	x19, x0			// relocated Image address
> +	ldr	w2, =stext_offset
> +	add	x19, x0, x2		// relocated Image entrypoint
>  	mov	x20, x1			// DTB address
>  
>  	/*
> @@ -29,15 +30,14 @@ ENTRY(efi_enter_kernel)
>  	ldr	w1, =kernel_size
>  	bl	__flush_dcache_area
>  	ic	ialluis
> -	dsb	sy
>  
>  	/*
> -	 * Jump across, into the copy of the image that we just cleaned
> -	 * to the PoC, so that we can safely disable the MMU and caches.
> +	 * Flush the remainder of this routine to the PoC

Minor nit, but could we please say 'Clean' rather than 'Flush' here?

Even better, we now have __clean_dcache_area_poc(), and can use that
too.

Thanks,
Mark.

> +	 * so that we can safely disable the MMU and caches.
>  	 */
> -	ldr	w0, .Ljmp
> -	sub	x0, x19, w0, sxtw
> -	br	x0
> +	adr	x0, 0f
> +	ldr	w1, 3f
> +	bl	__flush_dcache_area
>  0:
>  	/* Turn off Dcache and MMU */
>  	mrs	x0, CurrentEL
> @@ -63,6 +63,6 @@ ENTRY(efi_enter_kernel)
>  	mov	x1, xzr
>  	mov	x2, xzr
>  	mov	x3, xzr
> -	b	stext
> +	br	x19
>  ENDPROC(efi_enter_kernel)
> -.Ljmp:	.long	_text - 0b
> +3:	.long	. - 0b
> diff --git a/arch/arm64/kernel/image-vars.h b/arch/arm64/kernel/image-vars.h
> index 9a7aef0d6f70..28bf98f84adf 100644
> --- a/arch/arm64/kernel/image-vars.h
> +++ b/arch/arm64/kernel/image-vars.h
> @@ -13,6 +13,7 @@
>  #ifdef CONFIG_EFI
>  
>  __efistub_kernel_size		= _edata - _text;
> +__efistub_stext_offset		= stext - _text;
>  
>  
>  /*
> @@ -43,7 +44,6 @@ __efistub___memset		= __pi_memset;
>  #endif
>  
>  __efistub__text			= _text;
> -__efistub_stext			= stext;
>  __efistub__end			= _end;
>  __efistub__edata		= _edata;
>  __efistub_screen_info		= screen_info;
> -- 
> 2.17.1
> 
