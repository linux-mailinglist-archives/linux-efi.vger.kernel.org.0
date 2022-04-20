Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6E1D5092CB
	for <lists+linux-efi@lfdr.de>; Thu, 21 Apr 2022 00:27:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382738AbiDTWak (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 20 Apr 2022 18:30:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234341AbiDTWaj (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 20 Apr 2022 18:30:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BF7B419BD;
        Wed, 20 Apr 2022 15:27:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EB80C61A2A;
        Wed, 20 Apr 2022 22:27:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F4FDC385A1;
        Wed, 20 Apr 2022 22:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1650493671;
        bh=f03i65TjXt1wV5OHqyMzJA28lOrn/DtPA2CRRbwKgHM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=xRbqkjM/Ie8wCDh8lFTNir4DAVmdMcY9LuvmcZeYIeVsAxk69Iwg886RahAwszQNg
         wVjc8SbPk43znMip1B4TlXacUysfNXzwaIkbHXzV6admkQsk7YhOnTHETUxb0zsuBC
         YrKCJS/XJxlq2z5hFQlM4v0qkitAQ4WYCT5uOG5E=
Date:   Wed, 20 Apr 2022 15:27:49 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Wupeng Ma <mawupeng1@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        X86 ML <x86@kernel.org>, hpa@zyccr.com,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Mike Rapoport <rppt@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Joerg Roedel <jroedel@suse.de>, songmuchun@bytedance.com,
        macro@orcam.me.uk, Frederic Weisbecker <frederic@kernel.org>,
        W_Armin@gmx.de, John Garry <john.garry@huawei.com>,
        Sean Christopherson <seanjc@google.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        chenhuacai@kernel.org, David Hildenbrand <david@redhat.com>,
        gpiccoli@igalia.com, Mark Rutland <mark.rutland@arm.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        linux-ia64@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [PATCH v2 7/9] mm: Calc the right pfn if page size is not 4K
Message-Id: <20220420152749.d41097e7d53ccd6a2a2aea5f@linux-foundation.org>
In-Reply-To: <CAMj1kXFnEhJ4Qu50Ads9psY6kmT3ddw5Za+6-YqUM+eYj1Oafw@mail.gmail.com>
References: <20220414101314.1250667-1-mawupeng1@huawei.com>
        <20220414101314.1250667-8-mawupeng1@huawei.com>
        <672ff459-81bd-38ef-882d-e718992d295c@arm.com>
        <CAMj1kXFnEhJ4Qu50Ads9psY6kmT3ddw5Za+6-YqUM+eYj1Oafw@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 19 Apr 2022 20:29:27 +0200 Ard Biesheuvel <ardb@kernel.org> wrote:

> > > --- a/mm/page_alloc.c
> > > +++ b/mm/page_alloc.c
> > > @@ -7870,7 +7870,7 @@ static void __init find_zone_movable_pfns_for_nodes(void)
> > >
> > >                       usable_startpfn = memblock_region_memory_base_pfn(r);
> > >
> > > -                     if (usable_startpfn < 0x100000) {
> > > +                     if (usable_startpfn < PHYS_PFN(SZ_4G)) {
> > >                               mem_below_4gb_not_mirrored = true;
> > >                               continue;
> > >                       }
> >
> > Regardless PFN value should never be encoded directly.
> >
> > Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
> 
> Acked-by: Ard Biesheuvel <ardb@kernel.org>
> 
> Andrew, can you please take this one through the -mm tree? The rest of
> the series needs a bit more work, but is an obvious fix and there is
> no point in holding it up.

Sure.

I'm not seeing any description of the runtime effects of this
shortcoming.  I tentatively queued the fix for 5.18, without a
cc:stable for backporting.  But that might not be the best decision?

