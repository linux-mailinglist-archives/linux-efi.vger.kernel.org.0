Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A487648B8CF
	for <lists+linux-efi@lfdr.de>; Tue, 11 Jan 2022 21:44:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244226AbiAKUor (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 11 Jan 2022 15:44:47 -0500
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:51143 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244197AbiAKUoq (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 11 Jan 2022 15:44:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1641933886; x=1673469886;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject;
  bh=X+iEdzMsEoTMpcwwqvHDzvTqGb+6u2LSzv5AVOuyP5w=;
  b=eRgL5YJoSw9+ZVP5luZ4UHA01nXrMmgfFLqgZzcObCSDd0K7J3ckaVRk
   W2RSOp3XOZCSj/HOsbr2fLMRErMmzfYWEJqBlM6bNBu1TRWA1xHvOMsAz
   4bT3bynMHKpgbNYKNTDHj/Bvng49xU+EPP/ONMzKL2u8LT8VZ7DuxyHvT
   0=;
X-IronPort-AV: E=Sophos;i="5.88,279,1635206400"; 
   d="scan'208";a="168282843"
Subject: Re: [PATCH 1/3] memblock: define functions to set the usable memory range
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-pdx-2c-34cb9e7b.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP; 11 Jan 2022 20:44:44 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-pdx-2c-34cb9e7b.us-west-2.amazon.com (Postfix) with ESMTPS id 459BE4151D;
        Tue, 11 Jan 2022 20:44:44 +0000 (UTC)
Received: from EX13D31UEA001.ant.amazon.com (10.43.61.114) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.26; Tue, 11 Jan 2022 20:44:42 +0000
Received: from EX13MTAUEA001.ant.amazon.com (10.43.61.82) by
 EX13D31UEA001.ant.amazon.com (10.43.61.114) with Microsoft SMTP Server (TLS)
 id 15.0.1497.26; Tue, 11 Jan 2022 20:44:42 +0000
Received: from dev-dsk-fllinden-2c-d7720709.us-west-2.amazon.com
 (172.19.206.175) by mail-relay.amazon.com (10.43.61.243) with Microsoft SMTP
 Server id 15.0.1497.26 via Frontend Transport; Tue, 11 Jan 2022 20:44:42
 +0000
Received: by dev-dsk-fllinden-2c-d7720709.us-west-2.amazon.com (Postfix, from userid 6262777)
        id 20514A1; Tue, 11 Jan 2022 20:44:41 +0000 (UTC)
Date:   Tue, 11 Jan 2022 20:44:41 +0000
From:   Frank van der Linden <fllinden@amazon.com>
To:     Mike Rapoport <rppt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>, <robh+dt@kernel.org>,
        <frowand.list@gmail.com>, <ardb@kernel.org>, <linux-mm@kvack.org>,
        <devicetree@vger.kernel.org>, <linux-efi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kexec@lists.infradead.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <geert+renesas@glider.be>
Message-ID: <20220111204441.GA36458@dev-dsk-fllinden-2c-d7720709.us-west-2.amazon.com>
References: <20220110210809.3528-1-fllinden@amazon.com>
 <20220110210809.3528-2-fllinden@amazon.com> <Yd1cnquQFZoNE7FP@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Yd1cnquQFZoNE7FP@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Jan 11, 2022 at 12:31:58PM +0200, Mike Rapoport wrote:
> > --- a/include/linux/memblock.h
> > +++ b/include/linux/memblock.h
> > @@ -481,6 +481,8 @@ phys_addr_t memblock_reserved_size(void);
> >  phys_addr_t memblock_start_of_DRAM(void);
> >  phys_addr_t memblock_end_of_DRAM(void);
> >  void memblock_enforce_memory_limit(phys_addr_t memory_limit);
> > +void memblock_set_usable_range(phys_addr_t base, phys_addr_t size);
> > +void memblock_enforce_usable_range(void);
> >  void memblock_cap_memory_range(phys_addr_t base, phys_addr_t size);
> >  void memblock_mem_limit_remove_map(phys_addr_t limit);
> 
> We already have 3 very similar interfaces that deal with memory capping.
> Now you suggest to add fourth that will "generically" solve a single use
> case of DT, EFI and kdump interaction on arm64.
> 
> Looks like a workaround for a fundamental issue of incompatibility between
> DT and EFI wrt memory registration.

Yep, I figured this would be the main argument against this - arm64
already added several other more-or-less special cased interfaces over
time.

I'm more than happy to solve this in a different way.

What would you suggest:

1) Try to merge the similar interfaces in to one.
2) Just deal with it at a lower (arm64) level?
3) Some other way?

Thanks,

- Frank
