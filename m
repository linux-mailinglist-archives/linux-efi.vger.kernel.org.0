Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6836542C80
	for <lists+linux-efi@lfdr.de>; Wed,  8 Jun 2022 12:04:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235338AbiFHKEf (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 8 Jun 2022 06:04:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236010AbiFHKC7 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 8 Jun 2022 06:02:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91514151FDA;
        Wed,  8 Jun 2022 02:45:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2CC59619FA;
        Wed,  8 Jun 2022 09:45:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDE36C3411C;
        Wed,  8 Jun 2022 09:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654681503;
        bh=eC3ZU1sGIhjzZLCps+HxX1Ppe0DIJdW2BceBVl9oo+U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pktPbLEeaAky17dLmb9pivTEyBK0H2sS17eVHHPAHPk0YF+9j8rR3HysSNKYOmSr8
         HRYG0xkAuXKuaHXofsU4P4oTPA5VxDxGZpRnW1qIvvzTFCfjD4/DwbaFa6AOXlZNZE
         HplT8LIBYvTvIej8PCkNSNXyr2NMJndntFXg/CJEHkzPr7/2Z9PbQveTolHDq8qGRg
         3Hh7FFYid6joddofVPduvwi9PvHOVyg58QN9Xwmo27Upu79Ntyg8BDUueh1eaZAuc3
         kH7BOwB7rhOZUlw+oE1QrCIASkeUfQvxfMMp9Dv/04dHQzIcK5+8NcHs3vW5y9b43+
         P1Zl9+X0RcLMw==
Date:   Wed, 8 Jun 2022 12:44:44 +0300
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
        chenzhou10@huawei.com, vijayb@linux.microsoft.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-efi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-mm@kvack.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v3 3/6] mm: Ratelimited mirrored memory related warning
 messages
Message-ID: <YqBvjDavqUdLgmuo@kernel.org>
References: <20220607093805.1354256-1-mawupeng1@huawei.com>
 <20220607093805.1354256-4-mawupeng1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220607093805.1354256-4-mawupeng1@huawei.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Jun 07, 2022 at 05:38:02PM +0800, Wupeng Ma wrote:
> From: Ma Wupeng <mawupeng1@huawei.com>
> 
> If system has mirrored memory, memblock will try to allocate mirrored
> memory firstly and fallback to non-mirrored memory when fails, but if with
> limited mirrored memory or some numa node without mirrored memory, lots of
> warning message about memblock allocation will occur.
> 
> This patch ratelimit the warning message to avoid a very long print during
> bootup.
> 
> Signed-off-by: Ma Wupeng <mawupeng1@huawei.com>

Acked-by: Mike Rapoport <rppt@linux.ibm.com>

> ---
>  mm/memblock.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/memblock.c b/mm/memblock.c
> index e4f03a6e8e56..b1d2a0009733 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -327,7 +327,7 @@ static phys_addr_t __init_memblock memblock_find_in_range(phys_addr_t start,
>  					    NUMA_NO_NODE, flags);
>  
>  	if (!ret && (flags & MEMBLOCK_MIRROR)) {
> -		pr_warn("Could not allocate %pap bytes of mirrored memory\n",
> +		pr_warn_ratelimited("Could not allocate %pap bytes of mirrored memory\n",
>  			&size);
>  		flags &= ~MEMBLOCK_MIRROR;
>  		goto again;
> @@ -1384,7 +1384,7 @@ phys_addr_t __init memblock_alloc_range_nid(phys_addr_t size,
>  
>  	if (flags & MEMBLOCK_MIRROR) {
>  		flags &= ~MEMBLOCK_MIRROR;
> -		pr_warn("Could not allocate %pap bytes of mirrored memory\n",
> +		pr_warn_ratelimited("Could not allocate %pap bytes of mirrored memory\n",
>  			&size);
>  		goto again;
>  	}
> -- 
> 2.25.1
> 

-- 
Sincerely yours,
Mike.
