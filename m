Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51F7048E163
	for <lists+linux-efi@lfdr.de>; Fri, 14 Jan 2022 01:10:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238373AbiANAKy (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 13 Jan 2022 19:10:54 -0500
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:36845 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238356AbiANAKx (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 13 Jan 2022 19:10:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1642119055; x=1673655055;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sZ0Q13DS9ckI0r0N0o++8V1Ury3/fcldI1Z3JXkEwlc=;
  b=EQzd5bG4CrzTcBZOrRQUnobH60cCj2aPHEfNulrRU+QWCi2f5eH9yQ2S
   Y0EJW4PjLFfJeeqhNr6AMO5GEwBpIh4ozKFATOxvcwy4CrT22ZqSF/lWi
   GmiSAdLiJqIrZ8iaFPjdMcAcqUhWy10fKI2NuWpg+KWkOuio9ipMz8rSI
   s=;
X-IronPort-AV: E=Sophos;i="5.88,286,1635206400"; 
   d="scan'208";a="168914631"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-pdx-2b-22c2b493.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP; 14 Jan 2022 00:10:53 +0000
Received: from EX13MTAUEE002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-pdx-2b-22c2b493.us-west-2.amazon.com (Postfix) with ESMTPS id 640AA41501;
        Fri, 14 Jan 2022 00:10:48 +0000 (UTC)
Received: from EX13D08UEE002.ant.amazon.com (10.43.62.92) by
 EX13MTAUEE002.ant.amazon.com (10.43.62.24) with Microsoft SMTP Server (TLS)
 id 15.0.1497.28; Fri, 14 Jan 2022 00:10:47 +0000
Received: from EX13MTAUEE002.ant.amazon.com (10.43.62.24) by
 EX13D08UEE002.ant.amazon.com (10.43.62.92) with Microsoft SMTP Server (TLS)
 id 15.0.1497.28; Fri, 14 Jan 2022 00:10:47 +0000
Received: from dev-dsk-fllinden-2c-d7720709.us-west-2.amazon.com
 (172.19.206.175) by mail-relay.amazon.com (10.43.62.224) with Microsoft SMTP
 Server id 15.0.1497.28 via Frontend Transport; Fri, 14 Jan 2022 00:10:47
 +0000
Received: by dev-dsk-fllinden-2c-d7720709.us-west-2.amazon.com (Postfix, from userid 6262777)
        id 6BE7EC6; Fri, 14 Jan 2022 00:10:46 +0000 (UTC)
Date:   Fri, 14 Jan 2022 00:10:46 +0000
From:   Frank van der Linden <fllinden@amazon.com>
To:     Mike Rapoport <rppt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>, <robh+dt@kernel.org>,
        <frowand.list@gmail.com>, <ardb@kernel.org>, <linux-mm@kvack.org>,
        <devicetree@vger.kernel.org>, <linux-efi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kexec@lists.infradead.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <geert+renesas@glider.be>
Subject: Re: [PATCH 1/3] memblock: define functions to set the usable memory
 range
Message-ID: <20220114001046.GA10609@dev-dsk-fllinden-2c-d7720709.us-west-2.amazon.com>
References: <20220110210809.3528-1-fllinden@amazon.com>
 <20220110210809.3528-2-fllinden@amazon.com> <Yd1cnquQFZoNE7FP@kernel.org>
 <20220111204441.GA36458@dev-dsk-fllinden-2c-d7720709.us-west-2.amazon.com>
 <YeBiV8fuCCLWyHYb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YeBiV8fuCCLWyHYb@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Jan 13, 2022 at 07:33:11PM +0200, Mike Rapoport wrote:
> On Tue, Jan 11, 2022 at 08:44:41PM +0000, Frank van der Linden wrote:
> > On Tue, Jan 11, 2022 at 12:31:58PM +0200, Mike Rapoport wrote:
> > > > --- a/include/linux/memblock.h
> > > > +++ b/include/linux/memblock.h
> > > > @@ -481,6 +481,8 @@ phys_addr_t memblock_reserved_size(void);
> > > >  phys_addr_t memblock_start_of_DRAM(void);
> > > >  phys_addr_t memblock_end_of_DRAM(void);
> > > >  void memblock_enforce_memory_limit(phys_addr_t memory_limit);
> > > > +void memblock_set_usable_range(phys_addr_t base, phys_addr_t size);
> > > > +void memblock_enforce_usable_range(void);
> > > >  void memblock_cap_memory_range(phys_addr_t base, phys_addr_t size);
> > > >  void memblock_mem_limit_remove_map(phys_addr_t limit);
> > >
> > > We already have 3 very similar interfaces that deal with memory capping.
> > > Now you suggest to add fourth that will "generically" solve a single use
> > > case of DT, EFI and kdump interaction on arm64.
> > >
> > > Looks like a workaround for a fundamental issue of incompatibility between
> > > DT and EFI wrt memory registration.
> >
> > Yep, I figured this would be the main argument against this - arm64
> > already added several other more-or-less special cased interfaces over
> > time.
> >
> > I'm more than happy to solve this in a different way.
> >
> > What would you suggest:
> >
> > 1) Try to merge the similar interfaces in to one.
> > 2) Just deal with it at a lower (arm64) level?
> > 3) Some other way?
> 
> We've discussed this with Ard on IRC, and our conclusion was that on arm64
> kdump kernel should have memblock.memory exactly the same as the normal
> kernel. Then, the memory outside usable-memory-range should be reserved so
> that kdump kernel won't step over it.
> 
> With that, simple (untested) patch below could be what we need:
> 
> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index bdca35284ceb..371418dffaf1 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -1275,7 +1275,8 @@ void __init early_init_dt_scan_nodes(void)
>         of_scan_flat_dt(early_init_dt_scan_memory, NULL);
> 
>         /* Handle linux,usable-memory-range property */
> -       memblock_cap_memory_range(cap_mem_addr, cap_mem_size);
> +       memblock_reserve(0, cap_mem_addr);
> +       memblock_reserve(cap_mem_addr + cap_mem_size, PHYS_ADDR_MAX);
>  }
> 
>  bool __init early_init_dt_scan(void *params)

Thanks for discussing this further! I tried the above change, although
I wrapped it in an if (cap_mem_size != 0), so that a normal kernel
doesn't get its entire memory marked as reserved.

The crash kernel hung without producing output - I haven't chased that
down. This particular kernel was a bit older (5.15), so I'll try again
with 5.17-rc to make sure.

- Frank
