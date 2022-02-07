Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3335C4ACB1E
	for <lists+linux-efi@lfdr.de>; Mon,  7 Feb 2022 22:18:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237866AbiBGVSo (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 7 Feb 2022 16:18:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238010AbiBGVSm (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 7 Feb 2022 16:18:42 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37127C0401DA
        for <linux-efi@vger.kernel.org>; Mon,  7 Feb 2022 13:18:39 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id h20-20020a17090adb9400b001b518bf99ffso302798pjv.1
        for <linux-efi@vger.kernel.org>; Mon, 07 Feb 2022 13:18:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=d9ldJz2Q7a+QVeuu97JN0SwCkiiYh+lvruWks9vjas4=;
        b=HN5KAg7FfgSlG7ghrTxnwTa8Ug/eFmqTBqT3YZyhVOi2WegMyHWZ9kBoUmgzz7iGCB
         1Lu01bwgofvuB4skGH5FcZr7JQ0Tnxb1Zvf8OKjODPhmT7I6p8vX0ip5dSbHXWYIatCb
         rpbeA86N2Kb6Zi1ZTFPZ3r2GHF+ERV7cJxxuo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=d9ldJz2Q7a+QVeuu97JN0SwCkiiYh+lvruWks9vjas4=;
        b=qpORqp1lkE39FHJGaE8M/RKJr+RQ+BGMSV5uf7zQNTD+xfewpOIMNdgIaViaSwNo4e
         C+5ehH4aRPAQ56hrvgvFRulsPp8cJRchb8rfvlXjVYxzjNs8ZWMVboys+l1eLMitiFxs
         ER2po5SP19fHJSxV4ilmQLGXgSh6LdLq2Qt+SgT2RqmHNQdfw+1X9ATdwbi5Ob6xhnCU
         hCOIfQwzyDxWsOwFRRw1ew3c3LWRIzM3bIagn5JdzukKwi/tvWD5IKk9+9N+qEAEmqNw
         FTgzv75yZiPd4yAk8AEI6K8SkKKwPNYgIb2MwmX91221E5kKEWXuIj/GMuPZwl4ZcIhO
         gEzw==
X-Gm-Message-State: AOAM533/T9V5cjVkKsGxCX9dGIKWFw7uvv+XKsgk1nDbSwt9QX1UtJ7+
        fD50sarmQprEfahJayRb63RxGA==
X-Google-Smtp-Source: ABdhPJyibyWrBtKFyxmmMoKFcsegALaR2GiBWlPPZmpl80cyGmRpdn7SL+WBVzHCcvr1CvrcX8MA+Q==
X-Received: by 2002:a17:90a:348f:: with SMTP id p15mr858535pjb.173.1644268718557;
        Mon, 07 Feb 2022 13:18:38 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id lk8sm263098pjb.40.2022.02.07.13.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 13:18:38 -0800 (PST)
Date:   Mon, 7 Feb 2022 13:18:37 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Martin Fernandez <martin.fernandez@eclypsium.com>
Cc:     linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-mm@kvack.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        ardb@kernel.org, dvhart@infradead.org, andy@infradead.org,
        gregkh@linuxfoundation.org, rafael@kernel.org, rppt@kernel.org,
        akpm@linux-foundation.org, daniel.gutson@eclypsium.com,
        hughsient@gmail.com, alex.bazhaniuk@eclypsium.com,
        alison.schofield@intel.com
Subject: Re: [PATCH v6 1/6] mm/memblock: Tag memblocks with crypto
 capabilities
Message-ID: <202202061945.DACC7BD04@keescook>
References: <20220203164328.203629-1-martin.fernandez@eclypsium.com>
 <20220203164328.203629-2-martin.fernandez@eclypsium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220203164328.203629-2-martin.fernandez@eclypsium.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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

As already suggested, please keep the tabs like they were. If you're
going to change every line, maybe expand the single-digit literals to 2
digits. (i.e. 0x0 -> 0x00, to keep the most significant bits lined up.)

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

This was already mentioned, but I just thought I'd add: this made me
double-take, given the "||" (instead of "|") in an assignment. It looked
like a typo, but yes it's correct. I was expecting something like:

			crypto_capable |=
				!!(region->flags & MEMBLOCK_CRYPTO_CAPABLE);

> +			not_crypto_capable =
> +				not_crypto_capable ||
> +				!(region->flags & MEMBLOCK_CRYPTO_CAPABLE);

			not_crypto_capable |=
				!(region->flags & MEMBLOCK_CRYPTO_CAPABLE);

> +		}
> +	}
> +
> +	if (crypto_capable && not_crypto_capable)
> +		pr_warn_once("Node %d has regions that are encryptable and regions that aren't",
> +			     nid);
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
Kees Cook
