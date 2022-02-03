Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7E564A8B33
	for <lists+linux-efi@lfdr.de>; Thu,  3 Feb 2022 19:08:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353175AbiBCSHz (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 3 Feb 2022 13:07:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353131AbiBCSHy (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 3 Feb 2022 13:07:54 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A254FC061714;
        Thu,  3 Feb 2022 10:07:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3570BB8351A;
        Thu,  3 Feb 2022 18:07:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5256C340E8;
        Thu,  3 Feb 2022 18:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643911672;
        bh=YUZr7XbeIyN08iazuMzS2G23rEaa9Gbz97J61hHim+Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o8iht2n8UHL+kEAb+gtG0oxtkBVpcCEPiQ/35xD3MyqOOg11qMUEwuCAnAG5p+ZhV
         00Q26tjpbetSchpxqplcJnNGgknS7lpliwiApV27x+9v8EMTB0A3wSkWwXl9XvNAeL
         eKuXcTEN7YTu8+eL+nzWMRB1osbE4eYqJ8rDBHMCiOCZaVZ7LZZah/ZQ9oJzfguu3/
         qilaWa30TIygTPRP+NhERY7z6y9mKXFTJmc7Mh463vgkdiaSIHMOe/7XE+AHgDdgnp
         SmC75UrQ6K5cGE1VYnRiVJtJy9M3R59AOQpGNpo39DtYOI+9BdgkjKnfxuaEZ8/WK3
         rWz+jwwDldV2A==
Date:   Thu, 3 Feb 2022 20:07:38 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Martin Fernandez <martin.fernandez@eclypsium.com>
Cc:     linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-mm@kvack.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        ardb@kernel.org, dvhart@infradead.org, andy@infradead.org,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        akpm@linux-foundation.org, daniel.gutson@eclypsium.com,
        hughsient@gmail.com, alex.bazhaniuk@eclypsium.com,
        alison.schofield@intel.com, keescook@chromium.org
Subject: Re: [PATCH v6 1/6] mm/memblock: Tag memblocks with crypto
 capabilities
Message-ID: <YfwZ6ne9ND1JaReS@kernel.org>
References: <20220203164328.203629-1-martin.fernandez@eclypsium.com>
 <20220203164328.203629-2-martin.fernandez@eclypsium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220203164328.203629-2-martin.fernandez@eclypsium.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Feb 03, 2022 at 01:43:23PM -0300, Martin Fernandez wrote:
> Add the capability to mark regions of the memory memory_type able of
> hardware memory encryption.
> 
> Also add the capability to query if all regions of a memory node are
> able to do hardware memory encryption to call it when initializing the
> nodes. Warn the user if a node has both encryptable and
> non-encryptable regions.
> 
> Signed-off-by: Martin Fernandez <martin.fernandez@eclypsium.com>
> ---
>  include/linux/memblock.h | 15 ++++++----
>  mm/memblock.c            | 64 ++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 74 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/memblock.h b/include/linux/memblock.h
> index 9dc7cb239d21..73edcce165a5 100644
> --- a/include/linux/memblock.h
> +++ b/include/linux/memblock.h
> @@ -41,13 +41,15 @@ extern unsigned long long max_possible_pfn;
>   * via a driver, and never indicated in the firmware-provided memory map as
>   * system RAM. This corresponds to IORESOURCE_SYSRAM_DRIVER_MANAGED in the
>   * kernel resource tree.
> + * @MEMBLOCK_CRYPTO_CAPABLE: capable of hardware encryption
>   */
>  enum memblock_flags {
> -	MEMBLOCK_NONE		= 0x0,	/* No special request */
> -	MEMBLOCK_HOTPLUG	= 0x1,	/* hotpluggable region */
> -	MEMBLOCK_MIRROR		= 0x2,	/* mirrored region */
> -	MEMBLOCK_NOMAP		= 0x4,	/* don't add to kernel direct mapping */
> -	MEMBLOCK_DRIVER_MANAGED = 0x8,	/* always detected via a driver */
> +	MEMBLOCK_NONE		= 0x0,		/* No special request */
> +	MEMBLOCK_HOTPLUG	= 0x1,		/* hotpluggable region */
> +	MEMBLOCK_MIRROR		= 0x2,		/* mirrored region */
> +	MEMBLOCK_NOMAP		= 0x4,		/* don't add to kernel direct mapping */
> +	MEMBLOCK_DRIVER_MANAGED = 0x8,		/* always detected via a driver */
> +	MEMBLOCK_CRYPTO_CAPABLE = 0x10,		/* capable of hardware encryption */

Please keep the comment indentation.

>  };
>  
>  /**
> @@ -121,6 +123,9 @@ int memblock_physmem_add(phys_addr_t base, phys_addr_t size);
>  void memblock_trim_memory(phys_addr_t align);
>  bool memblock_overlaps_region(struct memblock_type *type,
>  			      phys_addr_t base, phys_addr_t size);
> +bool memblock_node_is_crypto_capable(int nid);
> +int memblock_mark_crypto_capable(phys_addr_t base, phys_addr_t size);
> +int memblock_clear_crypto_capable(phys_addr_t base, phys_addr_t size);
>  int memblock_mark_hotplug(phys_addr_t base, phys_addr_t size);
>  int memblock_clear_hotplug(phys_addr_t base, phys_addr_t size);
>  int memblock_mark_mirror(phys_addr_t base, phys_addr_t size);
> diff --git a/mm/memblock.c b/mm/memblock.c
> index 1018e50566f3..fcf79befeab3 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -191,6 +191,42 @@ bool __init_memblock memblock_overlaps_region(struct memblock_type *type,
>  	return i < type->cnt;
>  }
>  
> +/**
> + * memblock_node_is_crypto_capable - get if whole node is capable
> + * of encryption
> + * @nid: number of node
> + *
> + * Iterate over all memory memblock_type and find if all regions under
> + * node @nid are capable of hardware encryption.
> + *
> + * Return:
> + * true if every region in memory memblock_type is capable of
> + * encryption, false otherwise.
> + */
> +bool __init_memblock memblock_node_is_crypto_capable(int nid)
> +{
> +	struct memblock_region *region;
> +	bool crypto_capable = false;
> +	bool not_crypto_capable = false;
> +
> +	for_each_mem_region(region) {
> +		if (memblock_get_region_node(region) == nid) {
> +			crypto_capable =
> +				crypto_capable ||
> +				(region->flags & MEMBLOCK_CRYPTO_CAPABLE);
> +			not_crypto_capable =
> +				not_crypto_capable ||
> +				!(region->flags & MEMBLOCK_CRYPTO_CAPABLE);

Isn't

 			if (region->flags & MEMBLOCK_CRYPTO_CAPABLE)
				crypto_capable++;
			else
				not_crypto_capable++;

simpler and clearer?

(of course s/bool/int in the declaration)

> +		}
> +	}
> +
> +	if (crypto_capable && not_crypto_capable)
> +		pr_warn_once("Node %d has regions that are encryptable and regions that aren't",
> +			     nid);

This will print only the first node with mixed regions. With a single
caller of memblock_node_is_crypto_capable() I think pr_warn() is ok.

> +
> +	return !not_crypto_capable;
> +}
> +
>  /**
>   * __memblock_find_range_bottom_up - find free area utility in bottom-up
>   * @start: start of candidate range
> @@ -885,6 +921,34 @@ static int __init_memblock memblock_setclr_flag(phys_addr_t base,
>  	return 0;
>  }
>  
> +/**
> + * memblock_mark_crypto_capable - Mark memory regions capable of hardware
> + * encryption with flag MEMBLOCK_CRYPTO_CAPABLE.
> + * @base: the base phys addr of the region
> + * @size: the size of the region
> + *
> + * Return: 0 on success, -errno on failure.
> + */
> +int __init_memblock memblock_mark_crypto_capable(phys_addr_t base,
> +						 phys_addr_t size)
> +{
> +	return memblock_setclr_flag(base, size, 1, MEMBLOCK_CRYPTO_CAPABLE);
> +}
> +
> +/**
> + * memblock_clear_crypto_capable - Clear flag MEMBLOCK_CRYPTO for a
> + * specified region.
> + * @base: the base phys addr of the region
> + * @size: the size of the region
> + *
> + * Return: 0 on success, -errno on failure.
> + */
> +int __init_memblock memblock_clear_crypto_capable(phys_addr_t base,
> +						  phys_addr_t size)
> +{
> +	return memblock_setclr_flag(base, size, 0, MEMBLOCK_CRYPTO_CAPABLE);
> +}
> +
>  /**
>   * memblock_mark_hotplug - Mark hotpluggable memory with flag MEMBLOCK_HOTPLUG.
>   * @base: the base phys addr of the region
> -- 
> 2.30.2
> 

-- 
Sincerely yours,
Mike.
