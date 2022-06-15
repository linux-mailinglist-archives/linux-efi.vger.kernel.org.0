Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A063354C2FB
	for <lists+linux-efi@lfdr.de>; Wed, 15 Jun 2022 09:54:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242755AbiFOHyb (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 15 Jun 2022 03:54:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239892AbiFOHy3 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 15 Jun 2022 03:54:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BFBD4339A;
        Wed, 15 Jun 2022 00:54:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1F4EFB81CD1;
        Wed, 15 Jun 2022 07:54:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84DCFC341C0;
        Wed, 15 Jun 2022 07:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655279666;
        bh=VM9JsnNuaNSKfXw3/W5PC+ryw2B8xnjrM3+SbaLRwlY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HGl2tA+QFedQio6WLQwpcsHPnnA1J6C5L1sRmDLoeb3aoI8ASmSAQZPpx3dpnJQiI
         pDOcKbh0vMtfkMxkcx4TlTVvIJUrjr76Cw1solVGw/gRLRYWv3JlY6Lq9MmxVxT5j/
         bkbcToCwXmrl3xvOw9GSJTg2DmPekpNmHTRPDzapkdq/a3RdN3rabGuDhMuStcQS6x
         VwlN1I1cwKuDoqdyORjIwz6SNT2g6+KyOxR+MKurRsgXM+YaKexJa5CjJYGmPn3H1V
         DFahL1shyawETgdZ0mzky2SzjljSvbv90h7cW6JEneyZ1UqvKnIQa24J2Jm+ovL4uY
         0sx+LrZ32kNwg==
Date:   Wed, 15 Jun 2022 10:54:10 +0300
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
Subject: Re: [PATCH v5 0/5] introduce mirrored memory support for arm64
Message-ID: <YqmQIpQ8hzxYkMv2@kernel.org>
References: <20220614092156.1972846-1-mawupeng1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220614092156.1972846-1-mawupeng1@huawei.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Jun 14, 2022 at 05:21:51PM +0800, Wupeng Ma wrote:
> From: Ma Wupeng <mawupeng1@huawei.com>
> 
> Patch #1 introduce mirrored memory support form arm64.
> Patch #2-#4 fix some bugs for arm64 if memory reliable is enabled.
> Patch #5 disable mirror feature if kernelcore is not specified.
> 
> Thanks to Ard Biesheuvel's hard work [1], now kernel will perfer mirrored
> memory if kaslr is enabled.
> 
> [1] https://lore.kernel.org/linux-arm-kernel/CAMj1kXEPVEzMgOM4+Yj6PxHA-jFuDOAUdDJSiSxy_XaP4P7LSw@mail.gmail.com/T/
> 
> 
> Ma Wupeng (5):
>   efi: arm64: Introduce ability to find mirrored memory ranges
>   mm: Ratelimited mirrored memory related warning messages
>   mm: Limit warning message in vmemmap_verify() to once
>   arm64: mm: Only remove nomap flag for initrd
>   memblock: Disable mirror feature if kernelcore is not specified
> 
>  arch/arm64/mm/init.c            |  2 +-
>  arch/x86/include/asm/efi.h      |  4 ----
>  arch/x86/platform/efi/efi.c     | 23 -----------------------
>  drivers/firmware/efi/efi-init.c |  1 +
>  drivers/firmware/efi/efi.c      | 23 +++++++++++++++++++++++
>  include/linux/efi.h             |  3 +++
>  mm/internal.h                   |  2 ++
>  mm/memblock.c                   |  7 +++++--
>  mm/page_alloc.c                 |  2 +-
>  mm/sparse-vmemmap.c             |  2 +-
>  10 files changed, 37 insertions(+), 32 deletions(-)

For the series: Acked-by: Mike Rapoport <rppt@linux.ibm.com>

> -- 
> 2.25.1
> 

-- 
Sincerely yours,
Mike.
