Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D899131E2D
	for <lists+linux-efi@lfdr.de>; Tue,  7 Jan 2020 04:58:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727518AbgAGD6h (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 6 Jan 2020 22:58:37 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:32643 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727441AbgAGD6h (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 6 Jan 2020 22:58:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578369516;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zvPlPXxAILzoT01hro+Pbxw5KT7isqZ8jc9RoFXZI8Y=;
        b=Fh5f+1cVA0J0TOGbe3/idOtzv/Y6NGesCNS/1fcKzA4ndCdj6GefdllWJF/chX69HmXEjl
        E2fWeUA4RPtCZYNcICA3WqM05aDh90FaI+bDESZnbuLVpeyRiMeOvqiVVKjLX/GQI5jYM6
        tYmD3r/Brsm8Gv8Bv/+ftk3C/flHg6s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-161-j4eA_LLQNnyxsvzQk0VjvA-1; Mon, 06 Jan 2020 22:58:33 -0500
X-MC-Unique: j4eA_LLQNnyxsvzQk0VjvA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 93C11184B1E2;
        Tue,  7 Jan 2020 03:58:31 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-32.pek2.redhat.com [10.72.12.32])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 481079A84;
        Tue,  7 Jan 2020 03:58:27 +0000 (UTC)
Date:   Tue, 7 Jan 2020 11:58:24 +0800
From:   Dave Young <dyoung@redhat.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     mingo@redhat.com, Taku Izumi <izumi.taku@jp.fujitsu.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-efi@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, kexec@lists.infradead.org
Subject: Re: [PATCH v4 3/4] efi: Fix efi_memmap_alloc() leaks
Message-ID: <20200107035824.GA19080@dhcp-128-65.nay.redhat.com>
References: <157835762222.1456824.290100196815539830.stgit@dwillia2-desk3.amr.corp.intel.com>
 <157835763783.1456824.4013634516855823659.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <157835763783.1456824.4013634516855823659.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 01/06/20 at 04:40pm, Dan Williams wrote:
> With efi_fake_memmap() and efi_arch_mem_reserve() the efi table may be
> updated and replaced multiple times. When that happens a previous
> dynamically allocated efi memory map can be garbage collected. Use the
> new EFI_MEMMAP_{SLAB,MEMBLOCK} flags to detect when a dynamically
> allocated memory map is being replaced.
> 
> Debug statements in efi_memmap_free() reveal:
> 
>  efi: __efi_memmap_free:37: phys: 0x23ffdd580 size: 2688 flags: 0x2
>  efi: __efi_memmap_free:37: phys: 0x9db00 size: 2640 flags: 0x2
>  efi: __efi_memmap_free:37: phys: 0x9e580 size: 2640 flags: 0x2
> 
> ...a savings of 7968 bytes on a qemu boot with 2 entries specified to
> efi_fake_mem=.
> 
> Cc: Taku Izumi <izumi.taku@jp.fujitsu.com>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/firmware/efi/memmap.c |   24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/drivers/firmware/efi/memmap.c b/drivers/firmware/efi/memmap.c
> index 04dfa56b994b..bffa320d2f9a 100644
> --- a/drivers/firmware/efi/memmap.c
> +++ b/drivers/firmware/efi/memmap.c
> @@ -29,6 +29,28 @@ static phys_addr_t __init __efi_memmap_alloc_late(unsigned long size)
>  	return PFN_PHYS(page_to_pfn(p));
>  }
>  
> +static void __init __efi_memmap_free(u64 phys, unsigned long size, unsigned long flags)
> +{
> +	if (flags & EFI_MEMMAP_MEMBLOCK) {
> +		if (slab_is_available())
> +			memblock_free_late(phys, size);
> +		else
> +			memblock_free(phys, size);
> +	} else if (flags & EFI_MEMMAP_SLAB) {
> +		struct page *p = pfn_to_page(PHYS_PFN(phys));
> +		unsigned int order = get_order(size);
> +
> +		free_pages((unsigned long) page_address(p), order);
> +	}
> +}
> +
> +static void __init efi_memmap_free(void)
> +{
> +	__efi_memmap_free(efi.memmap.phys_map,
> +			efi.memmap.desc_size * efi.memmap.nr_map,
> +			efi.memmap.flags);
> +}
> +
>  /**
>   * efi_memmap_alloc - Allocate memory for the EFI memory map
>   * @num_entries: Number of entries in the allocated map.
> @@ -100,6 +122,8 @@ static int __init __efi_memmap_init(struct efi_memory_map_data *data)
>  		return -ENOMEM;
>  	}
>  
> +	efi_memmap_free();
> +

This seems still not safe,  see below function:
arch/x86/platform/efi/efi.c:
static void __init efi_clean_memmap(void)
It use same memmap for both old and new, and filter out those invalid
ranges in place, if the memory is freed then ..

>  	map.phys_map = data->phys_map;
>  	map.nr_map = data->size / data->desc_size;
>  	map.map_end = map.map + data->size;
> 

Thanks
Dave

