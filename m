Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB5D548AB6B
	for <lists+linux-efi@lfdr.de>; Tue, 11 Jan 2022 11:32:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348934AbiAKKcJ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 11 Jan 2022 05:32:09 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:48742 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348912AbiAKKcJ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 11 Jan 2022 05:32:09 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 18B0761577;
        Tue, 11 Jan 2022 10:32:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A36BC36AE9;
        Tue, 11 Jan 2022 10:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641897128;
        bh=0rqIA4/jVYclQqB4xsgy2sHCQiJcK7V1GCT/RCzcwNA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GiO8Clp3cKZA4rIZp4mXsEZtFZFQIjGujQZVsgjW3KUTthAM6Og1vdB3sEDH7qcmN
         MIGhdJ+XFMo+Xg0jLuDpHnErkwvpSy67p/5UXrlZyHO+b74FlJL2hiPML5ZYg+vf8/
         lGVi59S8akIRZPOpWFM7t9O1oUgnVqbuGgqRVPpxImW6qEFwAzqxvlTNAXseGOKGPa
         izbV7cKz0VTB4NWpjIx+mayXjchu19ZHo5ODX54W1eWwi2mKJwW94XmnJ21tmy4sQF
         BpyMsLHetjLj2AEGd9fmnUy1DjGjWtNTvqWy4yCMJKaOad/v4Rvlws90muDMMF0lE3
         n4uyyryvSmreQ==
Date:   Tue, 11 Jan 2022 12:31:58 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Frank van der Linden <fllinden@amazon.com>
Cc:     linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
        frowand.list@gmail.com, ardb@kernel.org, linux-mm@kvack.org,
        devicetree@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        catalin.marinas@arm.com, will@kernel.org, geert+renesas@glider.be
Subject: Re: [PATCH 1/3] memblock: define functions to set the usable memory
 range
Message-ID: <Yd1cnquQFZoNE7FP@kernel.org>
References: <20220110210809.3528-1-fllinden@amazon.com>
 <20220110210809.3528-2-fllinden@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220110210809.3528-2-fllinden@amazon.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Jan 10, 2022 at 09:08:07PM +0000, Frank van der Linden wrote:
> Some architectures might limit the usable memory range based
> on a firmware property, like "linux,usable-memory-range"
> for ARM crash kernels. This limit needs to be enforced after
> firmware memory map processing has been done, which might be
> e.g. FDT or EFI, or both.
> 
> Define an interface for it that is firmware type agnostic.
> 
> Signed-off-by: Frank van der Linden <fllinden@amazon.com>
> ---
>  include/linux/memblock.h |  2 ++
>  mm/memblock.c            | 37 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 39 insertions(+)
> 
> diff --git a/include/linux/memblock.h b/include/linux/memblock.h
> index 34de69b3b8ba..6128efa50d33 100644
> --- a/include/linux/memblock.h
> +++ b/include/linux/memblock.h
> @@ -481,6 +481,8 @@ phys_addr_t memblock_reserved_size(void);
>  phys_addr_t memblock_start_of_DRAM(void);
>  phys_addr_t memblock_end_of_DRAM(void);
>  void memblock_enforce_memory_limit(phys_addr_t memory_limit);
> +void memblock_set_usable_range(phys_addr_t base, phys_addr_t size);
> +void memblock_enforce_usable_range(void);
>  void memblock_cap_memory_range(phys_addr_t base, phys_addr_t size);
>  void memblock_mem_limit_remove_map(phys_addr_t limit);

We already have 3 very similar interfaces that deal with memory capping.
Now you suggest to add fourth that will "generically" solve a single use
case of DT, EFI and kdump interaction on arm64.

Looks like a workaround for a fundamental issue of incompatibility between
DT and EFI wrt memory registration.

>  bool memblock_is_memory(phys_addr_t addr);
> diff --git a/mm/memblock.c b/mm/memblock.c
> index 5096500b2647..cb961965f3ad 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -101,6 +101,7 @@ unsigned long max_low_pfn;
>  unsigned long min_low_pfn;
>  unsigned long max_pfn;
>  unsigned long long max_possible_pfn;
> +phys_addr_t usable_start, usable_size;
>
>  static struct memblock_region memblock_memory_init_regions[INIT_MEMBLOCK_REGIONS] __initdata_memblock;
>  static struct memblock_region memblock_reserved_init_regions[INIT_MEMBLOCK_RESERVED_REGIONS] __initdata_memblock;
> @@ -1715,6 +1716,42 @@ void __init memblock_cap_memory_range(phys_addr_t base, phys_addr_t size)
>  			base + size, PHYS_ADDR_MAX);
>  }
>  
> +/**
> + * memblock_set_usable_range - set usable memory range
> + * @base: physical address that is the start of the range
> + * @size: size of the range.
> + *
> + * Used when a firmware property limits the range of usable
> + * memory, like for the linux,usable-memory-range property
> + * used by ARM crash kernels.
> + */
> +void __init memblock_set_usable_range(phys_addr_t base, phys_addr_t size)
> +{
> +	usable_start = base;
> +	usable_size = size;
> +}
> +
> +/**
> + * memblock_enforce_usable_range - cap memory ranges to usable range
> + *
> + * Some architectures call this during boot after firmware memory ranges
> + * have been scanned, to make sure they fall within the usable range
> + * set by memblock_set_usable_range.
> + *
> + * This may be called more than once if there are multiple firmware sources
> + * for memory ranges.
> + *
> + * Avoid "no memory registered" warning - the warning itself is
> + * useful, but we know this can be called with no registered
> + * memory (e.g. when the synthetic DT for the crash kernel has
> + * been parsed on EFI arm64 systems).
> + */
> +void __init memblock_enforce_usable_range(void)
> +{
> +	if (memblock_memory->total_size)
> +		memblock_cap_memory_range(usable_start, usable_size);
> +}
> +
>  void __init memblock_mem_limit_remove_map(phys_addr_t limit)
>  {
>  	phys_addr_t max_addr;
> -- 
> 2.32.0
> 

-- 
Sincerely yours,
Mike.
