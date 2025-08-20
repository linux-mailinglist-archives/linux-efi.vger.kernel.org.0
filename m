Return-Path: <linux-efi+bounces-4577-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82D9AB2D5B5
	for <lists+linux-efi@lfdr.de>; Wed, 20 Aug 2025 10:10:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B85E072824B
	for <lists+linux-efi@lfdr.de>; Wed, 20 Aug 2025 08:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3A8B2C3266;
	Wed, 20 Aug 2025 08:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nTvKw6Iu"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AEEE286D55;
	Wed, 20 Aug 2025 08:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755677401; cv=none; b=XW1UgBkH65Z5+NuTR1aY3eFZipDNjpTSbMwrOLPwQ9UcX3Wl9AD+3wK03aphK9rxeUZ5QMFiOhxrXAZ2pIPIrYBjBCWxh106mb/pWlKpkEYefqu95vWqvqG3dLROTb9mxem7O0T5etWD80d/ATF9GMfIgujlWQ2zPGhRB32ZVss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755677401; c=relaxed/simple;
	bh=ZwBIaVwfHe/T7WlfARZdRvpXDhB+IehKv0D+1cs2k44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CuIXxql9sSlCT9it/V37qUlGadiyCZKorEAK5gHDcN+48zsS9kQz8k4yefRDaQvG8qwc3rrptZBDrRGN7cjvJkzX+rPGVpSDEDgrYyAfJSdcrHqaOHX2OGb3B8L0umoN36UCZpPAAJYSsYduDvfWPP+mQ2BaSb3Vz/E9xrajqDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nTvKw6Iu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 762BDC113D0;
	Wed, 20 Aug 2025 08:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755677401;
	bh=ZwBIaVwfHe/T7WlfARZdRvpXDhB+IehKv0D+1cs2k44=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nTvKw6IuGKUCM074ZO6HCTXEBhK8E5DzlI1NkU+TKjtyZQ9NfmN5Jc00uTv6/kKXa
	 hWwxb3f4bADolcJPjWJGnr7BlVGitV9WGRgHoVDov0n0e81rrltgT7ztXG6CCOadAR
	 A/9LHOmnMv4XoTm46Wi6wryYMO+yr1ndcmZ7Z4+cM94l/e5t+Tfq4j7t3XSGLaYVJe
	 hdsr2Cqlnz6j/nkCAU/SqzZhmd/08f79LP5yPzmavyUjM0kJD/Dz7lE6I9jr9jrSuU
	 BqR8XE6QJRoOvke2raPIVYoNu93YDKztyJOOABw4QkrKbpYxFS6kv6Yy/F9OwC7Q8C
	 AdL744Lg9k08Q==
Date: Wed, 20 Aug 2025 11:09:53 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Evangelos Petrongonas <epetron@amazon.de>
Cc: Ard Biesheuvel <ardb@kernel.org>, Alexander Graf <graf@amazon.com>,
	Changyuan Lyu <changyuanl@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org,
	linux-mm@kvack.org, linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org, nh-open-source@amazon.com
Subject: Re: [PATCH v2 2/2] efi: Support booting with kexec handover (KHO)
Message-ID: <aKWC0c3kliee8gtu@kernel.org>
References: <cover.1755643201.git.epetron@amazon.de>
 <9e80381d4fafc71d6e0c64d69a8b3ac9c8949865.1755643201.git.epetron@amazon.de>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e80381d4fafc71d6e0c64d69a8b3ac9c8949865.1755643201.git.epetron@amazon.de>

On Tue, Aug 19, 2025 at 11:22:46PM +0000, Evangelos Petrongonas wrote:
> When KHO (Kexec HandOver) is enabled, it sets up scratch memory regions
> early during device tree scanning. After kexec, the new kernel
> exclusively uses this region for memory allocations during boot up to
> the initialization of the page allocator
> 
> However, when booting with EFI, EFI's reserve_regions() uses
> memblock_remove(0, PHYS_ADDR_MAX) to clear all memory regions before
> rebuilding them from EFI data. This destroys KHO scratch regions and
> their flags, thus causing a kernel panic, as there are no scratch
> memory regions.
> 
> Instead of wholesale removal, iterate through memory regions and only
> remove non-KHO ones. This preserves KHO scratch regions, which are
> good known memory, while still allowing EFI to rebuild its memory map.
> 
> Signed-off-by: Evangelos Petrongonas <epetron@amazon.de>
> ---
> Changes in v2:
> 	- Replaced the for loop with for_each_mem_region
> 	- Fixed comment indentation
> 	- Amended commit message to specify that scratch regions
> 	are known good regions
> 
>  drivers/firmware/efi/efi-init.c | 28 ++++++++++++++++++++++++----
>  1 file changed, 24 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/firmware/efi/efi-init.c b/drivers/firmware/efi/efi-init.c
> index a00e07b853f2..99f7eecc320f 100644
> --- a/drivers/firmware/efi/efi-init.c
> +++ b/drivers/firmware/efi/efi-init.c
> @@ -12,6 +12,7 @@
>  #include <linux/efi.h>
>  #include <linux/fwnode.h>
>  #include <linux/init.h>
> +#include <linux/kexec_handover.h>
>  #include <linux/memblock.h>
>  #include <linux/mm_types.h>
>  #include <linux/of.h>
> @@ -164,12 +165,31 @@ static __init void reserve_regions(void)
>  		pr_info("Processing EFI memory map:\n");
>  
>  	/*
> -	 * Discard memblocks discovered so far: if there are any at this
> -	 * point, they originate from memory nodes in the DT, and UEFI
> -	 * uses its own memory map instead.
> +	 * Discard memblocks discovered so far except for KHO scratch
> +	 * regions. Most memblocks at this point originate from memory nodes
> +	 * in the DT and UEFI uses its own memory map instead. However, if
> +	 * KHO is enabled, scratch regions must be preserved.

I'd add that KHO scratch regions are good know memory here as well. With
that

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

>  	 */
>  	memblock_dump_all();
> -	memblock_remove(0, PHYS_ADDR_MAX);
> +
> +	if (is_kho_boot()) {
> +		struct memblock_region *r;
> +
> +		/* Remove all non-KHO regions */
> +		for_each_mem_region(r) {
> +			if (!memblock_is_kho_scratch(r)) {
> +				memblock_remove(r->base, r->size);
> +				r--;
> +			}
> +		}
> +	} else {
> +		/*
> +		 * KHO is disabled. Discard memblocks discovered so far:
> +		 * if there are any at this point, they originate from memory
> +		 * nodes in the DT, and UEFI uses its own memory map instead.
> +		 */
> +		memblock_remove(0, PHYS_ADDR_MAX);
> +	}
>  
>  	for_each_efi_memory_desc(md) {
>  		paddr = md->phys_addr;
> -- 
> 2.47.3

-- 
Sincerely yours,
Mike.

