Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8C2148CA9B
	for <lists+linux-efi@lfdr.de>; Wed, 12 Jan 2022 19:05:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241136AbiALSFz (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 12 Jan 2022 13:05:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355976AbiALSFx (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 12 Jan 2022 13:05:53 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8064C06173F;
        Wed, 12 Jan 2022 10:05:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 479BA6194E;
        Wed, 12 Jan 2022 18:05:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DDABC36AE5;
        Wed, 12 Jan 2022 18:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642010751;
        bh=jeMAXsD0RQlHdtuX5ty1VxBTZG6coZYil0NxX+mHVXQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rKRlZc1mzdvVLDPimEh2XnSL8qxBf/33jwUf4yenZgE3OzOhcsRRweFgWg/iuckRY
         clYXBJqANQ0mO8U6PXE0O8QefvoYrqyD8mhvN+Vh0scBpgefaSNjdiegPiEh7TqmNw
         PYBwjIRX+4K0kD1Adwzevv6CnYI35vPhUSYKm9IAr+DaBM3PJaLzXcfauR2tbp3ORX
         O8k9JGDFGs/m1s1bsVs/sXXL1vU+0cv5PkvmqkTJG0D44P1ra12fGVBdccnB4pWbs5
         IuynmG80HNYhcx75MCn/e0PP7lKe9S23QhRF/safDSz0jzs9FN604K1pLkBJlo7yxp
         zEWKF0EHBSMpw==
Date:   Wed, 12 Jan 2022 20:05:41 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Frank van der Linden <fllinden@amazon.com>
Cc:     linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
        frowand.list@gmail.com, ardb@kernel.org, linux-mm@kvack.org,
        devicetree@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        catalin.marinas@arm.com, will@kernel.org, geert+renesas@glider.be
Subject: Re: [PATCH 1/3] memblock: define functions to set the usable memory
 range
Message-ID: <Yd8Yda7oadoB1E+w@kernel.org>
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

This could be a nice cleanup regardless of how we handle
"linux,usable-memory-range".

> 2) Just deal with it at a lower (arm64) level?

Probably it will be the simplest solution in the short term.

> 3) Some other way?

I'm not expert enough on DT and EFI to see how they communicate the
linux,usable-memory-range property. 

One thought I have is since we already create a DT for kexec/kdump why
can't we add some data to EFI memory description similar to
linux,usable-memore-range?

Another thing is, if we could presume that DT and EFI are consistent in
their view what is the span of the physical memory, we could drop
memblock_remove(EVERYTHIING) and early_init_dt_add_memory_arch() from
efi_init::reserve_regions() and then the loop over EFI memory descriptors
will only take care of reserved and nomap regions.

> Thanks,
> 
> - Frank
> 

-- 
Sincerely yours,
Mike.
