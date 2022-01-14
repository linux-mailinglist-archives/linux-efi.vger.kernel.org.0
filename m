Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D17B448F302
	for <lists+linux-efi@lfdr.de>; Sat, 15 Jan 2022 00:28:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbiANX1d (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 14 Jan 2022 18:27:33 -0500
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:60308 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiANX1d (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 14 Jan 2022 18:27:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1642202853; x=1673738853;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject;
  bh=Mm62JXSl5zeICS/ifss0xt6fgpw3EJrv2ma2nrDfxt8=;
  b=iXErR/n0Uho4F6+bJctxxHzEAhrObbIKInQNag4TxE1E6Du4/YYA5L31
   eu5Or8MKqksTD/APrC+Ft3IzD+X2E9h8jpUKI1iw5momFXfi0jkmTuwG1
   zhvZncV9ESg2cSpGJv8lGFY1soRwGuj+ke72ED6qWWczMP8mpaGFWB9us
   Q=;
X-IronPort-AV: E=Sophos;i="5.88,290,1635206400"; 
   d="scan'208";a="170572735"
Subject: Re: [PATCH 1/3] memblock: define functions to set the usable memory range
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2a-e6c05252.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP; 14 Jan 2022 23:27:31 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-pdx-2a-e6c05252.us-west-2.amazon.com (Postfix) with ESMTPS id 8AB4841615;
        Fri, 14 Jan 2022 23:27:30 +0000 (UTC)
Received: from EX13D35UWB004.ant.amazon.com (10.43.161.230) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1497.28; Fri, 14 Jan 2022 23:27:30 +0000
Received: from EX13MTAUWB001.ant.amazon.com (10.43.161.207) by
 EX13D35UWB004.ant.amazon.com (10.43.161.230) with Microsoft SMTP Server (TLS)
 id 15.0.1497.26; Fri, 14 Jan 2022 23:27:30 +0000
Received: from dev-dsk-fllinden-2c-d7720709.us-west-2.amazon.com
 (172.19.206.175) by mail-relay.amazon.com (10.43.161.249) with Microsoft SMTP
 Server id 15.0.1497.28 via Frontend Transport; Fri, 14 Jan 2022 23:27:30
 +0000
Received: by dev-dsk-fllinden-2c-d7720709.us-west-2.amazon.com (Postfix, from userid 6262777)
        id 20DD5FC; Fri, 14 Jan 2022 23:27:29 +0000 (UTC)
Date:   Fri, 14 Jan 2022 23:27:29 +0000
From:   Frank van der Linden <fllinden@amazon.com>
To:     Mike Rapoport <rppt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>, <robh+dt@kernel.org>,
        <frowand.list@gmail.com>, <ardb@kernel.org>, <linux-mm@kvack.org>,
        <devicetree@vger.kernel.org>, <linux-efi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kexec@lists.infradead.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <geert+renesas@glider.be>
Message-ID: <20220114232729.GA35066@dev-dsk-fllinden-2c-d7720709.us-west-2.amazon.com>
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

Ok, tested this on 5.17-rc, and it's working OK there. Main kernel has
32G, crash kernel gets 512M:

Main kernel:

[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000040000000-0x00000000ffffffff]
[    0.000000]   DMA32    empty
[    0.000000]   Normal   [mem 0x0000000100000000-0x0000000b96ffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000040000000-0x00000000786effff]
[    0.000000]   node   0: [mem 0x00000000786f0000-0x000000007872ffff]
[    0.000000]   node   0: [mem 0x0000000078730000-0x000000007bbfffff]
[    0.000000]   node   0: [mem 0x000000007bc00000-0x000000007bfdffff]
[    0.000000]   node   0: [mem 0x000000007bfe0000-0x000000007fffffff]
[    0.000000]   node   0: [mem 0x0000000400000000-0x0000000b96ffffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000040000000-0x0000000b96ffffff]
[    0.000000] On node 0, zone Normal: 4096 pages in unavailable ranges
[    0.000000] cma: Reserved 64 MiB at 0x000000007c000000
[    0.000000] crashkernel reserved: 0x0000000054400000 - 0x0000000074400000 (512 MB)


Crash kernel:

[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000054400000-0x000000007bfdffff]
[    0.000000]   DMA32    empty
[    0.000000]   Normal   empty
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000054400000-0x00000000743fffff]
[    0.000000]   node   0: [mem 0x00000000786f0000-0x000000007872ffff]
[    0.000000]   node   0: [mem 0x000000007bc00000-0x000000007bfdffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000054400000-0x000000007bfdffff]
[    0.000000] On node 0, zone DMA: 17408 pages in unavailable ranges
[    0.000000] On node 0, zone DMA: 17136 pages in unavailable ranges
[    0.000000] On node 0, zone DMA: 13520 pages in unavailable ranges
[    0.000000] On node 0, zone DMA: 16416 pages in unavailable ranges

Not sure why I had trouble with the same on 5.15, I'll have to look
at that again. But this seems fine for 5.16+

Thanks,

- Frank
