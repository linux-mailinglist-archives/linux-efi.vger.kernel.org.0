Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0B4B161E10
	for <lists+linux-efi@lfdr.de>; Tue, 18 Feb 2020 00:51:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725997AbgBQXvA (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 17 Feb 2020 18:51:00 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:57408 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbgBQXu7 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 17 Feb 2020 18:50:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=29XCVZ6MEgsOLMxDMjehb8rSsFsJuSKk87zyMpgb1VA=; b=odK3e3zrx2546t3+GrvwcaIYD/
        Wd8uWJlRlz+EgeMJFk8iYNj/QdNHHJWLhFPGvPXRwimLC3QygjOGcgs2r9ro8sb8YylbSecvkanNK
        FvkvzbgU0CBka0kuvv6rf8TT8LGrV0+cdI0096xMoxa8dyIwNd5XflMBkWJe4BHLWUTC/6kpJ5/Kf
        SE/jriwq90Q2M7UBemF+Rep0yRck3iaUC7pELrrBfwJbKQRopLRt0T+5iAfjD/thOUWWR5L3bgl0g
        Q95KFnWQrLuUf/6LfuHyZ8QvPcwW2+v1tQXiDgP4KnLiMT4wfponVanAEPh/tbQ7oqQcXRT8aebcd
        qKbs9Vxw==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j3qAF-0000ve-1z; Mon, 17 Feb 2020 23:50:59 +0000
Subject: Re: [PATCH v2 1/1] efi/libstub: describe memory functions
To:     Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200217215443.3004-1-xypron.glpk@gmx.de>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <3fbbd26d-2de0-08b3-e41e-6ab58bf792a6@infradead.org>
Date:   Mon, 17 Feb 2020 15:50:57 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200217215443.3004-1-xypron.glpk@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 2/17/20 1:54 PM, Heinrich Schuchardt wrote:
> Provide descriptions of:
> 
> * efi_get_memory_map()
> * efi_low_alloc_above()
> * efi_free()
> 
> Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> ---
> v2:
> 	point out how efi_free() is rounding up the memory size
> ---
>  drivers/firmware/efi/libstub/mem.c | 36 ++++++++++++++++++++++++++++--
>  1 file changed, 34 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/firmware/efi/libstub/mem.c b/drivers/firmware/efi/libstub/mem.c
> index c25fd9174b74..49116b9b0801 100644
> --- a/drivers/firmware/efi/libstub/mem.c
> +++ b/drivers/firmware/efi/libstub/mem.c
> @@ -16,6 +16,15 @@ static inline bool mmap_has_headroom(unsigned long buff_size,
>  	return slack / desc_size >= EFI_MMAP_NR_SLACK_SLOTS;
>  }
> 

Hi,
Please use proper kernel-doc notation. See below...

> +/**
> + * efi_get_memory_map() - get memory map
> + * @map		on return pointer to memory map

    * @map:

> + *
> + * Retrieve the UEFI memory map. The allocated memory leaves room for
> + * up to EFI_MMAP_NR_SLACK_SLOTS additional memory map entries.
> + *
> + * Return:	status code
> + */
>  efi_status_t efi_get_memory_map(struct efi_boot_memmap *map)
>  {
>  	efi_memory_desc_t *m = NULL;
> @@ -109,8 +118,20 @@ efi_status_t efi_allocate_pages(unsigned long size, unsigned long *addr,
>  	}
>  	return EFI_SUCCESS;
>  }
> -/*
> - * Allocate at the lowest possible address that is not below 'min'.
> +/**
> + * efi_low_alloc_above() - allocate pages at or above given address
> + * @size:	size of the memory area to allocate
> + * @align:	minimum alignment of the allocated memory area. It should
> + *		a power of two.
> + * @addr:	on exit the address of the allocated memory
> + * @min:	minimum address to used for the memory allocation
> + *
> + * Allocate at the lowest possible address that is not below 'min' as
> + * EFI_LOADER_DATA. The allocated pages are aligned according to 'align' but at
> + * least EFI_ALLOC_ALIGN. The first allocated page will not below the address
> + * given by 'min'.
> + *
> + * Return:	status code
>   */
>  efi_status_t efi_low_alloc_above(unsigned long size, unsigned long align,
>  				 unsigned long *addr, unsigned long min)
> @@ -187,6 +208,17 @@ efi_status_t efi_low_alloc_above(unsigned long size, unsigned long align,
>  	return status;
>  }
> 
> +/**
> + * efi_free() - free memory pages
> + * @size	size of the memory area to free in bytes

    * @size:
    * @addr:

> + * @addr	start of the memory area to free (must be EFI_PAGE_SIZE
> + *		aligned)
> + *
> + * 'size' is rounded up to a multiple of EFI_ALLOC_ALIGN which is an
> + * architecture specific multiple of EFI_PAGE_SIZE. So this function should
> + * only be used to return pages allocated with efi_allocate_pages() or
> + * efi_low_alloc_above().
> + */
>  void efi_free(unsigned long size, unsigned long addr)
>  {
>  	unsigned long nr_pages;
> --
> 2.25.0
> 

Thanks.
-- 
~Randy

