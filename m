Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11962509302
	for <lists+linux-efi@lfdr.de>; Thu, 21 Apr 2022 00:40:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378673AbiDTWmu (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 20 Apr 2022 18:42:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383065AbiDTWmg (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 20 Apr 2022 18:42:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1939C2BE5;
        Wed, 20 Apr 2022 15:39:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CA471B821C7;
        Wed, 20 Apr 2022 22:39:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CFB3C385A0;
        Wed, 20 Apr 2022 22:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650494384;
        bh=aOWblUPe/xTg2PyxTWlH8msgIf3I/JIiGnioyKq1k9o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=sLGsVw8iJKIhDw1u+O84d+80f6CufGKkzbWTtkBFUOSaLA20JCvoQbxns38zq4At1
         TYhoFPR679gcwj8P4yiPPuUP0XCTtaV/xzMyb36BDYDNrLDMiUZaFgcUhDsT7+KmyE
         hKPSrLrPO7MYLAthlU4lMSHgeaHdyfoKHIs9cLQGh4OVupBYxgMH//159jpRXbDZXq
         iv0Cu8P/915WVO+C2YQlkX9sQ7EODIRaGwrY0InscJCM+f+QdOLEAuNpMMsO8RDqR0
         zRx2gFdKnjVuwAY1cMXHGfGfqkfoCXD5JjrmfpYzZmTaOscHiAN92G6n2C0aiTvaiZ
         8/jvgCEYDeRbA==
Received: by mail-oi1-f174.google.com with SMTP id z2so3720050oic.6;
        Wed, 20 Apr 2022 15:39:44 -0700 (PDT)
X-Gm-Message-State: AOAM533fzQOp4ZGR4sO13P07MFo8KTUxKaSXd4QYr/rIzC3KbclERKIR
        +PgpGbgwpNQUG0y4P8LMiVVx8/8ljdtKzJYMWBU=
X-Google-Smtp-Source: ABdhPJxZceLkzkgqQi9EwcZrYEUaymGtXEIUQiolsWwk3vI0ao36aw7Bq1YFbzNnKRMN7QZZzGSJVrbK043bNAiuq5Y=
X-Received: by 2002:a05:6808:e8d:b0:322:bac0:2943 with SMTP id
 k13-20020a0568080e8d00b00322bac02943mr2876683oil.126.1650494383711; Wed, 20
 Apr 2022 15:39:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220414101314.1250667-1-mawupeng1@huawei.com>
 <20220414101314.1250667-8-mawupeng1@huawei.com> <672ff459-81bd-38ef-882d-e718992d295c@arm.com>
 <CAMj1kXFnEhJ4Qu50Ads9psY6kmT3ddw5Za+6-YqUM+eYj1Oafw@mail.gmail.com> <20220420152749.d41097e7d53ccd6a2a2aea5f@linux-foundation.org>
In-Reply-To: <20220420152749.d41097e7d53ccd6a2a2aea5f@linux-foundation.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 21 Apr 2022 00:39:32 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFkso9i8OqHOA_XMu90mrSsSqR1uSmcUTxnD0SxStuTpw@mail.gmail.com>
Message-ID: <CAMj1kXFkso9i8OqHOA_XMu90mrSsSqR1uSmcUTxnD0SxStuTpw@mail.gmail.com>
Subject: Re: [PATCH v2 7/9] mm: Calc the right pfn if page size is not 4K
To:     Andrew Morton <akpm@linux-foundation.org>
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
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 21 Apr 2022 at 00:27, Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Tue, 19 Apr 2022 20:29:27 +0200 Ard Biesheuvel <ardb@kernel.org> wrote:
>
> > > > --- a/mm/page_alloc.c
> > > > +++ b/mm/page_alloc.c
> > > > @@ -7870,7 +7870,7 @@ static void __init find_zone_movable_pfns_for_nodes(void)
> > > >
> > > >                       usable_startpfn = memblock_region_memory_base_pfn(r);
> > > >
> > > > -                     if (usable_startpfn < 0x100000) {
> > > > +                     if (usable_startpfn < PHYS_PFN(SZ_4G)) {
> > > >                               mem_below_4gb_not_mirrored = true;
> > > >                               continue;
> > > >                       }
> > >
> > > Regardless PFN value should never be encoded directly.
> > >
> > > Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
> >
> > Acked-by: Ard Biesheuvel <ardb@kernel.org>
> >
> > Andrew, can you please take this one through the -mm tree? The rest of
> > the series needs a bit more work, but is an obvious fix and there is
> > no point in holding it up.
>
> Sure.
>
> I'm not seeing any description of the runtime effects of this
> shortcoming.  I tentatively queued the fix for 5.18, without a
> cc:stable for backporting.  But that might not be the best decision?
>

As far as I can tell, mirrored memory is only used on x86 today, where
pages are always 4k.

However, the whole notion of memory below 4 GB being special is a
x86-ism, and so this logic does not appear to extrapolate to other
architectures anyway, and probably needs more work.

So definitely not a backportable fix, but just an incremental
improvement, so either 5.18 or 5.19 should be fine afaict (and no
cc:stable)
