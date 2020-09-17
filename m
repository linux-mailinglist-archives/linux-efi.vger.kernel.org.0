Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6370326D309
	for <lists+linux-efi@lfdr.de>; Thu, 17 Sep 2020 07:25:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbgIQFZb (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 17 Sep 2020 01:25:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:51822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726072AbgIQFZa (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 17 Sep 2020 01:25:30 -0400
X-Greylist: delayed 336 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Sep 2020 01:25:30 EDT
Received: from kernel.org (unknown [87.71.73.56])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 38D71206C3;
        Thu, 17 Sep 2020 05:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600319993;
        bh=LQAOJ6T9kBFVpgSoZo/1UMJGmpXRbmDEcvqaS+t/aUA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nUxgf4XQ4VhQQj1qTiPIpZ1BdDJGpLUBLjLArIadmyhDC1bwCI2Ce5Gxnx7hr9i1c
         lu2MlZ7ectxebuu0hGymY6QkMWKm2qEetRgwyRF9vl/LUUy99tWTROSA7nbTl5XRFq
         ZR7Pae+Aa+MQekWUmReapezKvbgAXWXFXLv1Z36s=
Date:   Thu, 17 Sep 2020 08:19:45 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nicolas Pitre <nico@fluxnic.net>,
        Stefan Agner <stefan@agner.ch>,
        Peter Smith <Peter.Smith@arm.com>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Jian Cai <jiancai@google.com>, song.bao.hua@hisilicon.com,
        Anders Roxell <anders.roxell@linaro.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: [PATCH 00/12] ARM: use adr_l/ldr_l macros for PC-relative
 references
Message-ID: <20200917051945.GM2142832@kernel.org>
References: <20200914095706.3985-1-ardb@kernel.org>
 <CAKwvOdmSXm7cV3hB_Yp=DD0RwwDHtPzzDBU8Xj5kBREn3xqYdA@mail.gmail.com>
 <CAMj1kXGuFFUyT48EYvzFmjCP4QZi_Sk_GpBrBCaHjP7HKLhjBA@mail.gmail.com>
 <CAKwvOdmkNgi_+kfauTSLwtpVChipW851_KGJG+gBbhwRxJJORA@mail.gmail.com>
 <CAMj1kXHTkP7-8xscGZGXN_0Sq=BCSnt3zWqkcm8xdO11xmditA@mail.gmail.com>
 <CAKwvOd=G2Rr3StUJ=oWu1L4b5y615m+uYNW-Y5sis13uqBvrYQ@mail.gmail.com>
 <CAMj1kXHEpPc0MSoMrCxEkyb44AkLM2NJJGtOXLpr6kxBHS0vfA@mail.gmail.com>
 <CAKwvOd=Sq3XOquw4ACEi+cYCQp0-LW-JXoecFt+yy+jtmtuhiQ@mail.gmail.com>
 <CAKwvOd=CmiZ72yVmhX6LubObC6nUxjhwHhexjzW25j_8bpn_KA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOd=CmiZ72yVmhX6LubObC6nUxjhwHhexjzW25j_8bpn_KA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

(added Mike K.)

On Wed, Sep 16, 2020 at 05:16:32PM -0700, Nick Desaulniers wrote:
> On Wed, Sep 16, 2020 at 2:25 PM Nick Desaulniers
> <ndesaulniers@google.com> wrote:

...
 
> Maybe this is: https://lore.kernel.org/linux-next/20200916140437.GL2142832@kernel.org/
> ? That looks arm64 specific though.  Maybe 32b ARM needs the same or a
> similar fix?  Oh man, this boots, total shot in the dark:

The CMA change is the problem IMO and it's now removed from -mm and
-next trees. 

> diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
> index 45f9d5ec2360..7118b98c1f5f 100644
> --- a/arch/arm/mm/init.c
> +++ b/arch/arm/mm/init.c
> @@ -226,9 +226,6 @@ void __init arm_memblock_init(const struct
> machine_desc *mdesc)
>         early_init_fdt_reserve_self();
>         early_init_fdt_scan_reserved_mem();
> 
> -       /* reserve memory for DMA contiguous allocations */
> -       dma_contiguous_reserve(arm_dma_limit);
> -
>         arm_memblock_steal_permitted = false;
>         memblock_dump_all();
>  }
> @@ -248,6 +245,9 @@ void __init bootmem_init(void)
>          */
>         sparse_init();
> 
> +       /* reserve memory for DMA contiguous allocations */
> +       dma_contiguous_reserve(arm_dma_limit);
> +

This might be too late for ARM because in paging_init() it calls
dma_contiguous_remap() which presumes that the CMA area is already
reserved.

dma_contiguous_remap() might be NOP, so your fix will boot until it
fails eventually :) 

>         /*
>          * Now free the memory - free_area_init needs
>          * the sparse mem_map arrays initialized by sparse_init()

-- 
Sincerely yours,
Mike.
