Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7205E12DD83
	for <lists+linux-efi@lfdr.de>; Wed,  1 Jan 2020 04:35:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbgAADfc (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 31 Dec 2019 22:35:32 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:31810 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727105AbgAADfb (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 31 Dec 2019 22:35:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1577849729;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xGzTIGJEZW1rd19x+B/i8LC/d+Fdo/UuA9DXF5ovwZU=;
        b=c6mzRu2YA7y8/ZaFOUGQuMWQZ/1DjL85H7UwSqAJK2xCxN5uvxI2LtLvyowOgyOLSGzeTW
        T85zzhMnkNAkn9T9SxE6gg4LDjCuhFerx4kGgUsdwSt52qBFfH9EGlNUlM40ITRfPQdAF1
        xRBgiv95UaxPDmas1GUDlbvsO3I7THI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-235-roboTYx1PPClg702gfWojQ-1; Tue, 31 Dec 2019 22:35:26 -0500
X-MC-Unique: roboTYx1PPClg702gfWojQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 94034477;
        Wed,  1 Jan 2020 03:35:24 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-60.pek2.redhat.com [10.72.12.60])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2A9ED5C1D8;
        Wed,  1 Jan 2020 03:35:20 +0000 (UTC)
Date:   Wed, 1 Jan 2020 11:35:17 +0800
From:   Dave Young <dyoung@redhat.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     mingo@redhat.com, Taku Izumi <izumi.taku@jp.fujitsu.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        kexec@lists.infradead.org, x86@kernel.org
Subject: Re: [PATCH v2 3/4] efi: Fix efi_memmap_alloc() leaks
Message-ID: <20200101033517.GB14346@dhcp-128-65.nay.redhat.com>
References: <157782985777.367056.14741265874314204783.stgit@dwillia2-desk3.amr.corp.intel.com>
 <157782987346.367056.16932641815225610530.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <157782987346.367056.16932641815225610530.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Dan,
On 12/31/19 at 02:04pm, Dan Williams wrote:
> With efi_fake_memmap() and efi_arch_mem_reserve() the efi table may be
> updated and replaced multiple times. When that happens a previous
> dynamically allocated efi memory map can be garbage collected. Use the
> new EFI_MEMMAP_{SLAB,MEMBLOCK} flags to detect when a dynamically
> allocated memory map is being replaced.
> 
> Cc: Taku Izumi <izumi.taku@jp.fujitsu.com>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/firmware/efi/memmap.c |   24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/drivers/firmware/efi/memmap.c b/drivers/firmware/efi/memmap.c
> index 2b81ee6858a9..188ab3cd5c52 100644
> --- a/drivers/firmware/efi/memmap.c
> +++ b/drivers/firmware/efi/memmap.c
> @@ -29,6 +29,28 @@ static phys_addr_t __init __efi_memmap_alloc_late(unsigned long size)
>  	return PFN_PHYS(page_to_pfn(p));
>  }
>  
> +static void __init __efi_memmap_free(u64 phys, unsigned long size, unsigned long flags)
> +{
> +	if (WARN_ON(slab_is_available() && (flags & EFI_MEMMAP_MEMBLOCK)))
> +		return;
> +
> +	if (flags & EFI_MEMMAP_MEMBLOCK) {
> +		memblock_free(phys, size);
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
> @@ -209,6 +231,8 @@ int __init efi_memmap_install(phys_addr_t addr, unsigned int nr_map,
>  	data.desc_size = efi.memmap.desc_size;
>  	flags |= efi.memmap.flags & EFI_MEMMAP_LATE;
>  
> +	efi_memmap_free();
> +
>  	return __efi_memmap_init(&data, flags);

Hmm, only free the memmap in case __efi_memmap_init succeeded..

Thanks
Dave

