Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40EFB507939
	for <lists+linux-efi@lfdr.de>; Tue, 19 Apr 2022 20:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244228AbiDSSi0 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 19 Apr 2022 14:38:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357578AbiDSShl (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 19 Apr 2022 14:37:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C7464EA28;
        Tue, 19 Apr 2022 11:29:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3811E61598;
        Tue, 19 Apr 2022 18:29:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92EA2C385A5;
        Tue, 19 Apr 2022 18:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650392979;
        bh=P3K1tP6cpjTFzC+59oPXafdJm30VtMZbfwvyBn+l0nE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KGDjP4xyx8qxb3jFDHz8SacfWd77hO7wBWOMnWzPRIf+36togREFgtvY+2GisJ5ua
         EHD0M8aZbVy49xB218L2eVROCktRHVlRDvSaLidilao+Y7wl7Xx0LYiLyJmIsL03a8
         bfW9XhwszwFNoSqXz0JnBmWXMG8R7GlFmt6q1YIPhRWQEz7n4rc2ff5LPJp2cPtXxi
         xa07K/QiNPc9XT3RmJMMChldEU66W8w7gOIpgjivdwmaolnQBl7AxOI1yM09fKC4Aj
         f/FYgrjmGmOaSrNgobpe1cKny6M9qVvgfpDYRTw/gRU6hssP9eo9T4rMq5ZDQevZWI
         0o4WyjwLZNeRQ==
Received: by mail-ot1-f44.google.com with SMTP id w23-20020a056830111700b00603c6d1ce73so8591016otq.9;
        Tue, 19 Apr 2022 11:29:39 -0700 (PDT)
X-Gm-Message-State: AOAM531U5wTZFEqw1TVcTgTASE88ztCsgEsa2eCEZVrz+95Xsj3B0K3z
        o63NrQwtHVl1MO2P0f0Z9+HK/skzfYQiAvZU99M=
X-Google-Smtp-Source: ABdhPJx9o5nnG+qju6sQJMbe2eMJR893omMynSTe6NVIGWkG2uzYm2akaRvmqHO268QDgzdEY4zNawIK3ayZ+NJ0zEc=
X-Received: by 2002:a05:6830:33eb:b0:5f8:d36d:3831 with SMTP id
 i11-20020a05683033eb00b005f8d36d3831mr6341951otu.265.1650392978707; Tue, 19
 Apr 2022 11:29:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220414101314.1250667-1-mawupeng1@huawei.com>
 <20220414101314.1250667-8-mawupeng1@huawei.com> <672ff459-81bd-38ef-882d-e718992d295c@arm.com>
In-Reply-To: <672ff459-81bd-38ef-882d-e718992d295c@arm.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 19 Apr 2022 20:29:27 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFnEhJ4Qu50Ads9psY6kmT3ddw5Za+6-YqUM+eYj1Oafw@mail.gmail.com>
Message-ID: <CAMj1kXFnEhJ4Qu50Ads9psY6kmT3ddw5Za+6-YqUM+eYj1Oafw@mail.gmail.com>
Subject: Re: [PATCH v2 7/9] mm: Calc the right pfn if page size is not 4K
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Wupeng Ma <mawupeng1@huawei.com>,
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
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 19 Apr 2022 at 13:13, Anshuman Khandual
<anshuman.khandual@arm.com> wrote:
>
>
>
> On 4/14/22 15:43, Wupeng Ma wrote:
> > From: Ma Wupeng <mawupeng1@huawei.com>
> >
> > Previous 0x100000 is used to check the 4G limit in
> > find_zone_movable_pfns_for_nodes(). This is right in x86 because
> > the page size can only be 4K. But 16K and 64K are available in
> > arm64. So replace it with PHYS_PFN(SZ_4G).
> >
> > Signed-off-by: Ma Wupeng <mawupeng1@huawei.com>
> > ---
> >  mm/page_alloc.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index 6e5b4488a0c5..570d0ebf98df 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -7870,7 +7870,7 @@ static void __init find_zone_movable_pfns_for_nodes(void)
> >
> >                       usable_startpfn = memblock_region_memory_base_pfn(r);
> >
> > -                     if (usable_startpfn < 0x100000) {
> > +                     if (usable_startpfn < PHYS_PFN(SZ_4G)) {
> >                               mem_below_4gb_not_mirrored = true;
> >                               continue;
> >                       }
>
> Regardless PFN value should never be encoded directly.
>
> Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

Acked-by: Ard Biesheuvel <ardb@kernel.org>

Andrew, can you please take this one through the -mm tree? The rest of
the series needs a bit more work, but is an obvious fix and there is
no point in holding it up.

Thanks,
Ard.
