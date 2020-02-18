Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41C32162B13
	for <lists+linux-efi@lfdr.de>; Tue, 18 Feb 2020 17:52:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbgBRQwA (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 18 Feb 2020 11:52:00 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:56092 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726402AbgBRQwA (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 18 Feb 2020 11:52:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=xBLjHMP2eGbIVzYd5mfcYLe+V9nuLC9yBBNTiFPgH+8=; b=J12p8UC2nnNT4XrmssDUP2jD/
        3zjetfjPdCrr3/fueG39+jDaHqUThGlv7Sg8q5y6RzKPRf3Cnu5t1nZpicCmpJc809U53llwT7ndt
        3WHX6tunomuyXyJF1hBNc90NhxUX46TryamYJEhWYfWcywmRIumEtJEFDLIvm74hVQxkeWtad7dRw
        TCSIagtBPZKzLR+s1I5a3BXHBgOZ9cMoVh4v7HJHQxFj0UBRrrAeZ1mSiDdFocxEB4nrsb5iFyOpv
        Pq1PrRJtygtFBSOE1K6LCTBmXbI6mVJI63oFdosyK4YMc+KMJ1BZ+3N5pegOyWYIsLr0yWeV7a8ET
        tJwsZmxkA==;
Received: from shell.armlinux.org.uk ([2002:4e20:1eda:1:5054:ff:fe00:4ec]:49568)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1j466D-0008Ni-Ll; Tue, 18 Feb 2020 16:51:53 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1j4669-0000ap-MZ; Tue, 18 Feb 2020 16:51:49 +0000
Date:   Tue, 18 Feb 2020 16:51:49 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Marc Zyngier <maz@kernel.org>,
        Nicolas Pitre <nico@fluxnic.net>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 1/2] ARM: decompressor: prepare cache_clean_flush for
 doing by-VA maintenance
Message-ID: <20200218165149.GK25745@shell.armlinux.org.uk>
References: <20200218164430.32671-1-ardb@kernel.org>
 <20200218164430.32671-2-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200218164430.32671-2-ardb@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Feb 18, 2020 at 05:44:29PM +0100, Ard Biesheuvel wrote:
> In preparation of turning the decompressor's cache clean/flush
> operations into proper by-VA maintenance for v7 cores, pass the
> start and end addresses of the regions that need cache maintenance
> into cache_clean_flush in registers r0 and r1.

Where's the documentation of the new calling convention?  This is
assembly code, it needs such things documented as there's no
function prototypes to give that information.

> 
> Currently, all implementations of cache_clean_flush ignore these
> values, so no functional change is expected as a result of this
> patch.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/arm/boot/compressed/head.S | 28 +++++++++++++++++---
>  1 file changed, 25 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
> index 7b86a2e1acce..935799b92198 100644
> --- a/arch/arm/boot/compressed/head.S
> +++ b/arch/arm/boot/compressed/head.S
> @@ -525,12 +525,15 @@ dtb_check_done:
>  		/* cache_clean_flush may use the stack, so relocate it */
>  		add	sp, sp, r6
>  #endif
> -
> +		mov	r0, r9
> +		ldr	r1, 0f
> +		add	r1, r1, r0
>  		bl	cache_clean_flush
>  
>  		badr	r0, restart
>  		add	r0, r0, r6
>  		mov	pc, r0
> +0:		.long	_edata - restart
>  
>  wont_overwrite:
>  /*
> @@ -622,6 +625,21 @@ not_relocated:	mov	r0, #0
>  		add	r2, sp, #0x10000	@ 64k max
>  		mov	r3, r7
>  		bl	decompress_kernel
> +
> +		mov	r0, r4			@ base of inflated image
> +		adr	r1, LC0			@ actual LC0
> +		ldr	r2, [r1]		@ linktime LC0
> +		sub	r2, r1, r2		@ LC0 delta
> +		ldr	r1, [r1, #16]		@ link time inflated size offset
> +		ldr	r1, [r1, r2]		@ actual inflated size (LE)
> +#ifdef __ARMEB__
> +		/* convert to big endian */
> +		eor	r2, r1, r1, ror #16
> +		bic	r2, r2, #0x00ff0000
> +		mov	r1, r1, ror #8
> +		eor	r1, r1, r2, lsr #8
> +#endif
> +		add	r1, r1, r0		@ end of inflated image
>  		bl	cache_clean_flush
>  		bl	cache_off
>  
> @@ -1439,6 +1457,7 @@ reloc_code_end:
>  #ifdef CONFIG_EFI_STUB
>  		.align	2
>  _start:		.long	start - .
> +__edata:	.long	_edata - .
>  
>  ENTRY(efi_stub_entry)
>  		@ allocate space on stack for passing current zImage address
> @@ -1470,8 +1489,11 @@ ENTRY(efi_stub_entry)
>  		.align	2
>  0:		.long	start - (. + 4)
>  
> -		@ Preserve return value of efi_entry() in r4
> -		mov	r4, r0
> +		mov	r4, r0				@ preserve DTB pointer
> +		mov	r0, r1				@ start of image
> +		adr	r2, __edata
> +		ldr	r1, [r2]
> +		add	r1, r1, r2			@ end of image
>  		bl	cache_clean_flush
>  		bl	cache_off
>  
> -- 
> 2.17.1
> 
> 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
