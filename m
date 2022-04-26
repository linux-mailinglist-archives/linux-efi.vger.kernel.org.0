Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 305D450F0BA
	for <lists+linux-efi@lfdr.de>; Tue, 26 Apr 2022 08:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244937AbiDZGOP (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 26 Apr 2022 02:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244963AbiDZGOO (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 26 Apr 2022 02:14:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C7913B6;
        Mon, 25 Apr 2022 23:11:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9EED3B818FE;
        Tue, 26 Apr 2022 06:11:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62CA1C385AC;
        Tue, 26 Apr 2022 06:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650953464;
        bh=hfNYTM7tCR7XMLe8YNkDfgK4t27yGuoKsqJS1LzijzI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e85e/ugCVVRQZCqy0k0uEuBzNQnCcVx4WIUnqB8C0T6QPCXjnaKf7IO2/aQ70Kljd
         vlE4dJmT//ZnuuDmcnfIhOT57sUgCI4rjNzURBa9MW8cg4J84Usgk9AUu2dYZFR/+P
         hOkua1+28HL8BCIBylnlN1u6bKb2qhmrdltoCCIDJmbqxwYWY9pUqfwQpqZJlHSrlb
         c3JJnANcPzM7wIjCbIMP18/4VwFmH3zWpvcoh2husAGZShb0RGCKuHgbUtchKoP9gq
         CNMmVG1ZRlp+uAHYK7X2HFON6jui9rVE1nNBwvP42hjrz1Rts6UOYHVHApUZyJLHth
         937AxW/3WnxlQ==
Date:   Tue, 26 Apr 2022 09:10:45 +0300
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
Subject: Re: [PATCH v7 1/8] mm/memblock: Tag memblocks with crypto
 capabilities
Message-ID: <YmeM5fklUssR/74e@kernel.org>
References: <20220425171526.44925-1-martin.fernandez@eclypsium.com>
 <20220425171526.44925-2-martin.fernandez@eclypsium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220425171526.44925-2-martin.fernandez@eclypsium.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Apr 25, 2022 at 02:15:19PM -0300, Martin Fernandez wrote:
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
>  include/linux/memblock.h |  5 ++++
>  mm/memblock.c            | 62 ++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 67 insertions(+)
> 
> diff --git a/include/linux/memblock.h b/include/linux/memblock.h
> index 50ad19662a32..00c4f1a20335 100644
> --- a/include/linux/memblock.h
> +++ b/include/linux/memblock.h
> @@ -40,6 +40,7 @@ extern unsigned long long max_possible_pfn;
>   * via a driver, and never indicated in the firmware-provided memory map as
>   * system RAM. This corresponds to IORESOURCE_SYSRAM_DRIVER_MANAGED in the
>   * kernel resource tree.
> + * @MEMBLOCK_CRYPTO_CAPABLE: capable of hardware encryption
>   */
>  enum memblock_flags {
>  	MEMBLOCK_NONE		= 0x0,	/* No special request */
> @@ -47,6 +48,7 @@ enum memblock_flags {
>  	MEMBLOCK_MIRROR		= 0x2,	/* mirrored region */
>  	MEMBLOCK_NOMAP		= 0x4,	/* don't add to kernel direct mapping */
>  	MEMBLOCK_DRIVER_MANAGED = 0x8,	/* always detected via a driver */
> +	MEMBLOCK_CRYPTO_CAPABLE = 0x10,	/* capable of hardware encryption */
>  };
>  
>  /**
> @@ -120,6 +122,9 @@ int memblock_physmem_add(phys_addr_t base, phys_addr_t size);
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
> index e4f03a6e8e56..fe62f81572e6 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -191,6 +191,40 @@ bool __init_memblock memblock_overlaps_region(struct memblock_type *type,
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

I'd s/in memory memblock_type/in @nid

> + * encryption, false otherwise.
> + */
> +bool __init_memblock memblock_node_is_crypto_capable(int nid)
> +{
> +	struct memblock_region *region;
> +	int crypto_capables = 0;
> +	int not_crypto_capables = 0;
> +
> +	for_each_mem_region(region) {
> +		if (memblock_get_region_node(region) == nid) {
> +			if (region->flags & MEMBLOCK_CRYPTO_CAPABLE)
> +				crypto_capables++;
> +			else
> +				not_crypto_capables++;
> +		}
> +	}
> +
> +	if (crypto_capables > 0 && not_crypto_capables > 0)
> +		pr_warn("Node %d has %d regions that are encryptable and %d regions that aren't",
> +			nid, not_crypto_capables, crypto_capables);
> +
> +	return not_crypto_capables == 0;

This will return true for memoryless nodes as well. Do you mean to consider
them as capable of encryption?

> +}
> +
>  /**
>   * __memblock_find_range_bottom_up - find free area utility in bottom-up
>   * @start: start of candidate range
> @@ -891,6 +925,34 @@ static int __init_memblock memblock_setclr_flag(phys_addr_t base,
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
