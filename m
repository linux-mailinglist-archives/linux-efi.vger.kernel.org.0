Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2053B48DCF6
	for <lists+linux-efi@lfdr.de>; Thu, 13 Jan 2022 18:33:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234382AbiAMRdW (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 13 Jan 2022 12:33:22 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:58284 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbiAMRdV (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 13 Jan 2022 12:33:21 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 75CFF61CF4;
        Thu, 13 Jan 2022 17:33:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C804C36AE9;
        Thu, 13 Jan 2022 17:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642095200;
        bh=kTQ0RXYCVzEJELAfnWtXQDxddDbKHo6D1Ei14G+EQHE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NxBJeuvDtGQbr0LbThSZ2HVyPJ5cxzw8itQLvCWUTjMiU/YvloyTJCRTYf8zwSu61
         8ItjDqmR4xOhz3Yf5QAqI6f6hhT7wZxL/l/SXa+KYfDd5I+bgtbqpro+1z2bt6wldo
         KSa1OsX/m+Z3Shyc6S56BcwTUBy+WYuTeA9VPVrQrRqDuLDZHan5NMjJZVd32/7SFB
         eVA/4xbS86b/bkZKikDOW5tr3760HDpjHbDeVAd7BVLG5S6dAN4Lh1eXCychO76I/R
         IyrlyFsLKjpJJe1ZbbNG4BwGyghMBuxhkE70dn3rhvyOLqRjKGhF1VhC8Ero14Iouc
         AZRxv0/JHYnYQ==
Date:   Thu, 13 Jan 2022 19:33:11 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Frank van der Linden <fllinden@amazon.com>
Cc:     linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
        frowand.list@gmail.com, ardb@kernel.org, linux-mm@kvack.org,
        devicetree@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        catalin.marinas@arm.com, will@kernel.org, geert+renesas@glider.be
Subject: Re: [PATCH 1/3] memblock: define functions to set the usable memory
 range
Message-ID: <YeBiV8fuCCLWyHYb@kernel.org>
References: <20220110210809.3528-1-fllinden@amazon.com>
 <20220110210809.3528-2-fllinden@amazon.com>
 <Yd1cnquQFZoNE7FP@kernel.org>
 <20220111204441.GA36458@dev-dsk-fllinden-2c-d7720709.us-west-2.amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220111204441.GA36458@dev-dsk-fllinden-2c-d7720709.us-west-2.amazon.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Jan 11, 2022 at 08:44:41PM +0000, Frank van der Linden wrote:
> On Tue, Jan 11, 2022 at 12:31:58PM +0200, Mike Rapoport wrote:
> > > --- a/include/linux/memblock.h
> > > +++ b/include/linux/memblock.h
> > > @@ -481,6 +481,8 @@ phys_addr_t memblock_reserved_size(void);
> > >  phys_addr_t memblock_start_of_DRAM(void);
> > >  phys_addr_t memblock_end_of_DRAM(void);
> > >  void memblock_enforce_memory_limit(phys_addr_t memory_limit);
> > > +void memblock_set_usable_range(phys_addr_t base, phys_addr_t size);
> > > +void memblock_enforce_usable_range(void);
> > >  void memblock_cap_memory_range(phys_addr_t base, phys_addr_t size);
> > >  void memblock_mem_limit_remove_map(phys_addr_t limit);
> > 
> > We already have 3 very similar interfaces that deal with memory capping.
> > Now you suggest to add fourth that will "generically" solve a single use
> > case of DT, EFI and kdump interaction on arm64.
> > 
> > Looks like a workaround for a fundamental issue of incompatibility between
> > DT and EFI wrt memory registration.
> 
> Yep, I figured this would be the main argument against this - arm64
> already added several other more-or-less special cased interfaces over
> time.
> 
> I'm more than happy to solve this in a different way.
> 
> What would you suggest:
> 
> 1) Try to merge the similar interfaces in to one.
> 2) Just deal with it at a lower (arm64) level?
> 3) Some other way?

We've discussed this with Ard on IRC, and our conclusion was that on arm64
kdump kernel should have memblock.memory exactly the same as the normal
kernel. Then, the memory outside usable-memory-range should be reserved so
that kdump kernel won't step over it.

With that, simple (untested) patch below could be what we need:

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index bdca35284ceb..371418dffaf1 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -1275,7 +1275,8 @@ void __init early_init_dt_scan_nodes(void)
 	of_scan_flat_dt(early_init_dt_scan_memory, NULL);
 
 	/* Handle linux,usable-memory-range property */
-	memblock_cap_memory_range(cap_mem_addr, cap_mem_size);
+	memblock_reserve(0, cap_mem_addr);
+	memblock_reserve(cap_mem_addr + cap_mem_size, PHYS_ADDR_MAX);
 }
 
 bool __init early_init_dt_scan(void *params)

> Thanks,
> 
> - Frank
> 

-- 
Sincerely yours,
Mike.
