Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FE9516581E
	for <lists+linux-efi@lfdr.de>; Thu, 20 Feb 2020 08:02:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725988AbgBTHCe (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 20 Feb 2020 02:02:34 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:47480 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbgBTHCe (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 20 Feb 2020 02:02:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=8ANy1vYAhIgDUqoTAy5l6fXOYEoAukR3rCEaYz88ZmQ=; b=llgBaSTq+3DIg8x3rDq6Y2Y++U
        5IF3jcJU7FuhS8j8aW6a1uvxTRS3RZifc0SfO12iUvNFJ2DE0nLsrvoQJWQ3Auc+LiovXJHvMme7n
        7rPmAzrayKHlofyZH/aE/ISfikb1oO8J9Yj/bN/kI1byyp2w8GvaV9zjhAd1cRP0Dzc3Fm2zSI43N
        SFlthETNh0/KxZ/xaj4HfejqZ/m9PFeHOhaHM7DcsBRAB1MCYA30dKKFYfK8VXvFopMCS3qStobLB
        lTJ3c8TuNaDgw5gjATbKwaw+bUGpQtPH+dgvKqV/K5gLb7U6enNxfLhvtXjvofG/lRxZI8mRy67ia
        snVaeA2w==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j4fqz-0003Jk-UV; Thu, 20 Feb 2020 07:02:34 +0000
Subject: Re: [PATCH 1/1] efi/libstub: describe efi_relocate_kernel()
To:     Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200220065317.9096-1-xypron.glpk@gmx.de>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <9687832d-e9a9-ca47-34d5-7b912b2f718a@infradead.org>
Date:   Wed, 19 Feb 2020 23:02:32 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200220065317.9096-1-xypron.glpk@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi,
Mostly looks good.  One comment below:

On 2/19/20 10:53 PM, Heinrich Schuchardt wrote:
> Update the description of of efi_relocate_kernel() to match Sphinx style.
> 
> Update parameter references in the description of other memory functions
> to use @param style.
> 
> Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> ---
>  drivers/firmware/efi/libstub/mem.c | 38 +++++++++++++++++++-----------
>  1 file changed, 24 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/firmware/efi/libstub/mem.c b/drivers/firmware/efi/libstub/mem.c
> index 0d57078e5e62..7efe3ed2d5a6 100644
> --- a/drivers/firmware/efi/libstub/mem.c
> +++ b/drivers/firmware/efi/libstub/mem.c
> @@ -86,7 +86,7 @@ efi_status_t efi_get_memory_map(struct efi_boot_memmap *map)
>   *
>   * Allocate pages as EFI_LOADER_DATA. The allocated pages are aligned according
>   * to EFI_ALLOC_ALIGN. The last allocated page will not exceed the address
> - * given by 'max'.
> + * given by @max.
>   *
>   * Return:	status code
>   */
> @@ -126,10 +126,10 @@ efi_status_t efi_allocate_pages(unsigned long size, unsigned long *addr,
>   * @addr:	on exit the address of the allocated memory
>   * @min:	minimum address to used for the memory allocation
>   *
> - * Allocate at the lowest possible address that is not below 'min' as
> - * EFI_LOADER_DATA. The allocated pages are aligned according to 'align' but at
> + * Allocate at the lowest possible address that is not below @min as
> + * EFI_LOADER_DATA. The allocated pages are aligned according to @align but at
>   * least EFI_ALLOC_ALIGN. The first allocated page will not below the address
> - * given by 'min'.
> + * given by @min.
>   *
>   * Return:	status code
>   */
> @@ -214,7 +214,7 @@ efi_status_t efi_low_alloc_above(unsigned long size, unsigned long align,
>   * @addr:	start of the memory area to free (must be EFI_PAGE_SIZE
>   *		aligned)
>   *
> - * 'size' is rounded up to a multiple of EFI_ALLOC_ALIGN which is an
> + * @size is rounded up to a multiple of EFI_ALLOC_ALIGN which is an
>   * architecture specific multiple of EFI_PAGE_SIZE. So this function should
>   * only be used to return pages allocated with efi_allocate_pages() or
>   * efi_low_alloc_above().
> @@ -230,15 +230,25 @@ void efi_free(unsigned long size, unsigned long addr)
>  	efi_bs_call(free_pages, addr, nr_pages);
>  }
> 
> -/*
> - * Relocate a kernel image, either compressed or uncompressed.
> - * In the ARM64 case, all kernel images are currently
> - * uncompressed, and as such when we relocate it we need to
> - * allocate additional space for the BSS segment. Any low
> - * memory that this function should avoid needs to be
> - * unavailable in the EFI memory map, as if the preferred
> - * address is not available the lowest available address will
> - * be used.
> +/**
> + * efi_relocate_kernel() - copy memory area
> + * @image_addr:		address of memory area to copy, on exit target address

The "on exit target address" is a little bit confusing IMO.
Is it like this?

  On exit, @image_addr is updated to the target copy address that was used.

?  or some other better description?

Thanks.

Acked-by: Randy Dunlap <rdunlap@infradead.org>


> + * @image_size:		size of memory area to copy
> + * @alloc_size:		minimum size of memory to allocate, must be greater or
> + *			equal to image_size
> + * @preferred_addr:	preferred target address
> + * @alignment:		minimum alignment of the allocated memory area. It
> + *			should be a power of two.
> + * @min_addr:		minimum target address
> + *
> + * Copy a memory area to a newly allocated memory area aligned according
> + * to @alignment but at least EFI_ALLOC_ALIGN. If the preferred address
> + * is not available, the allocated address will not be below @min_addr.
> + *
> + * This function is used to copy the Linux kernel verbatim. It does not apply
> + * any relocation changes.
> + *
> + * Return:		status code
>   */
>  efi_status_t efi_relocate_kernel(unsigned long *image_addr,
>  				 unsigned long image_size,
> --
> 2.25.0
> 


-- 
~Randy

