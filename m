Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57140549809
	for <lists+linux-efi@lfdr.de>; Mon, 13 Jun 2022 18:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349870AbiFMMYd (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 13 Jun 2022 08:24:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356106AbiFMMYB (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 13 Jun 2022 08:24:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 861BB1FA76;
        Mon, 13 Jun 2022 04:05:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B4264B80E92;
        Mon, 13 Jun 2022 11:05:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CA26C34114;
        Mon, 13 Jun 2022 11:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655118317;
        bh=k9aUUnqcx7zhYyOXA4iphpmzLpkcUokEnBIJoGzV800=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uzP0GwrIIUvxLbEj5B1z2I4q/fkYHdxOBYFqKYQZL8zqRBMOlOnZT43ZKJHsrLuXl
         cipSxarShAqtSB1sU1Ser/ZNFiFrtEoyHVL+HdztzjouFS1UltSOAA8sBjH6sMKosd
         TW3yGWDTPLWUkj+q5vWjWBpZ+HP4UAkajg/fjdtCpIAKMC9Rfgh9UOxYexBSe5SYz4
         2YSzkZux8MxlhXu6DZPUnA1ullgrB9VKbi0+GAlywJ5U4uVJp0vd4cjZM1mtGqrWbO
         5knf8XGOYAsnLGi0PFadaEKXm3/iYrzaJ3Ngk8A1H3Gb0KPbIChGibpNWN6JHkZJl6
         tfL55Kv0OB6ew==
Date:   Mon, 13 Jun 2022 14:05:04 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Wupeng Ma <mawupeng1@huawei.com>
Cc:     corbet@lwn.net, will@kernel.org, ardb@kernel.org,
        catalin.marinas@arm.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, dvhart@infradead.org, andy@infradead.org,
        akpm@linux-foundation.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, paulmck@kernel.org,
        keescook@chromium.org, songmuchun@bytedance.com,
        rdunlap@infradead.org, damien.lemoal@opensource.wdc.com,
        swboyd@chromium.org, wei.liu@kernel.org, robin.murphy@arm.com,
        david@redhat.com, anshuman.khandual@arm.com,
        thunder.leizhen@huawei.com, wangkefeng.wang@huawei.com,
        gpiccoli@igalia.com, chenhuacai@kernel.org, geert@linux-m68k.org,
        vijayb@linux.microsoft.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-mm@kvack.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v4 6/6] memblock: Disable mirror feature if kernelcore is
 not specified
Message-ID: <YqcZ4O3pwceVtKYm@kernel.org>
References: <20220613082147.183145-1-mawupeng1@huawei.com>
 <20220613082147.183145-7-mawupeng1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220613082147.183145-7-mawupeng1@huawei.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Jun 13, 2022 at 04:21:47PM +0800, Wupeng Ma wrote:
> From: Ma Wupeng <mawupeng1@huawei.com>
> 
> If system have some mirrored memory and mirrored feature is not specified
> in boot parameter, the basic mirrored feature will be enabled and this will
> lead to the following situations:
> 
> - memblock memory allocation prefers mirrored region. This may have some
>   unexpected influence on numa affinity.
> 
> - contiguous memory will be split into several parts if parts of them
>   is mirrored memory via memblock_mark_mirror().
> 
> To fix this, variable mirrored_kernelcore will be checked in
> memblock_mark_mirror(). Mark mirrored memory with flag MEMBLOCK_MIRROR iff
> kernelcore=mirror is added in the kernel parameters.
> 
> Signed-off-by: Ma Wupeng <mawupeng1@huawei.com>
> ---
>  mm/internal.h   | 2 ++
>  mm/memblock.c   | 3 +++
>  mm/page_alloc.c | 2 +-
>  3 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/internal.h b/mm/internal.h
> index c0f8fbe0445b..ddd2d6a46f1b 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -861,4 +861,6 @@ struct folio *try_grab_folio(struct page *page, int refs, unsigned int flags);
>  
>  DECLARE_PER_CPU(struct per_cpu_nodestat, boot_nodestats);
>  
> +extern bool mirrored_kernelcore;
> +
>  #endif	/* __MM_INTERNAL_H */
> diff --git a/mm/memblock.c b/mm/memblock.c
> index b1d2a0009733..a9f18b988b7f 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -924,6 +924,9 @@ int __init_memblock memblock_clear_hotplug(phys_addr_t base, phys_addr_t size)
>   */
>  int __init_memblock memblock_mark_mirror(phys_addr_t base, phys_addr_t size)
>  {
> +	if (!mirrored_kernelcore)
> +		return 0;
> +

Hmm, this changes the way x86 uses mirrored memory.
This change makes sense for x86 as well, but we should get an Ack from x86 folks.

>  	system_has_some_mirror = true;
>  
>  	return memblock_setclr_flag(base, size, 1, MEMBLOCK_MIRROR);
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index e008a3df0485..9b030aeb4983 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -356,7 +356,7 @@ static unsigned long required_kernelcore_percent __initdata;
>  static unsigned long required_movablecore __initdata;
>  static unsigned long required_movablecore_percent __initdata;
>  static unsigned long zone_movable_pfn[MAX_NUMNODES] __initdata;
> -static bool mirrored_kernelcore __meminitdata;
> +bool mirrored_kernelcore __initdata;
>  
>  /* movable_zone is the "real" zone pages in ZONE_MOVABLE are taken from */
>  int movable_zone;
> -- 
> 2.25.1
> 

-- 
Sincerely yours,
Mike.
