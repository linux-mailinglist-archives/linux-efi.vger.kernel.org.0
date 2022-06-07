Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AFEC5401C4
	for <lists+linux-efi@lfdr.de>; Tue,  7 Jun 2022 16:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343654AbiFGOuP (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 7 Jun 2022 10:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244698AbiFGOtx (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 7 Jun 2022 10:49:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 175E06898A;
        Tue,  7 Jun 2022 07:49:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CD488B81DB3;
        Tue,  7 Jun 2022 14:49:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92CF3C34114;
        Tue,  7 Jun 2022 14:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654613389;
        bh=21Q6z4C7gLAJxDrMjpR35TaWJleKEVSnTcJc1XoghQY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WYB46EnJQ8KmDZFu6jSEUXfmMoEna05up4CJncyNZI8uwIsHCdYLTKRC0+amkX8Oj
         MulYqkmJUA5xdzBLnlJ21Knk2rVOc1evBYmVmwsz4nrwG0eEcpPi7TeRtjNt61KxNH
         ccUjQNum/v+Ub+BowdrQm3vPx9vFs8vP3DY+hXLw6mwabo8XB7Rxm9sNnN0iS1uWFt
         MCOberJ0KBzQM0XYyIpd9+CCCedeK4LgO49Mt/bgctMQbCdSeaqZNeB83IrXJR28LR
         KWDkX7QpyE+RWe5J/rqQ+SXWifk/MNU4VEaxvRBiJnHsZjTRfkssXiFrUar+JjE+ED
         LRsfm30v4ZsqQ==
Received: by mail-yb1-f174.google.com with SMTP id i39so3516277ybj.9;
        Tue, 07 Jun 2022 07:49:49 -0700 (PDT)
X-Gm-Message-State: AOAM531PoxGs168BNfggXTkK7OoPqGKnF3FpxEMyEMGHnN7dg9v81+IA
        otFwgXBOWL5ZF6y8/uQfSWEa1iJj6nUUj9UI0Ew=
X-Google-Smtp-Source: ABdhPJzju8BnufR6dAUwCuaVy7emdCBqao+Rd1rppQ3NzXkq8vagt8De7zdNBr5XdK5Y5+FNyl+7NFE6w3IjeLs4C7w=
X-Received: by 2002:a9d:76d5:0:b0:60b:1882:78bd with SMTP id
 p21-20020a9d76d5000000b0060b188278bdmr12748793otl.71.1654613377932; Tue, 07
 Jun 2022 07:49:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220607093805.1354256-1-mawupeng1@huawei.com>
 <20220607093805.1354256-6-mawupeng1@huawei.com> <99900b31-2605-2c85-a1b7-9ef2666b58da@redhat.com>
In-Reply-To: <99900b31-2605-2c85-a1b7-9ef2666b58da@redhat.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 7 Jun 2022 16:49:24 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGkzjq3koW_sgO4uzrdtwqSqzsJfT5ABYyvodf+ggXT2w@mail.gmail.com>
Message-ID: <CAMj1kXGkzjq3koW_sgO4uzrdtwqSqzsJfT5ABYyvodf+ggXT2w@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] mm: Add mirror flag back on initrd memory
To:     David Hildenbrand <david@redhat.com>
Cc:     Wupeng Ma <mawupeng1@huawei.com>, corbet@lwn.net, will@kernel.org,
        catalin.marinas@arm.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, dvhart@infradead.org, andy@infradead.org,
        rppt@kernel.org, akpm@linux-foundation.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, paulmck@kernel.org, keescook@chromium.org,
        songmuchun@bytedance.com, rdunlap@infradead.org,
        damien.lemoal@opensource.wdc.com, swboyd@chromium.org,
        wei.liu@kernel.org, robin.murphy@arm.com,
        anshuman.khandual@arm.com, thunder.leizhen@huawei.com,
        wangkefeng.wang@huawei.com, gpiccoli@igalia.com,
        chenhuacai@kernel.org, geert@linux-m68k.org, chenzhou10@huawei.com,
        vijayb@linux.microsoft.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-mm@kvack.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 7 Jun 2022 at 14:22, David Hildenbrand <david@redhat.com> wrote:
>
> On 07.06.22 11:38, Wupeng Ma wrote:
> > From: Ma Wupeng <mawupeng1@huawei.com>
> >
> > Initrd memory will be removed and then added in arm64_memblock_init() and this
> > will cause it to lose all of its memblock flags. The lost of MEMBLOCK_MIRROR
> > flag will lead to error log printed by find_zone_movable_pfns_for_nodes if
> > the lower 4G range has some non-mirrored memory.
> >
> > In order to solve this problem, the lost MEMBLOCK_MIRROR flag will be
> > reinstalled if the origin memblock has this flag.
> >
> > Signed-off-by: Ma Wupeng <mawupeng1@huawei.com>
> > ---
> >  arch/arm64/mm/init.c     |  9 +++++++++
> >  include/linux/memblock.h |  1 +
> >  mm/memblock.c            | 20 ++++++++++++++++++++
> >  3 files changed, 30 insertions(+)
> >
> > diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> > index 339ee84e5a61..11641f924d08 100644
> > --- a/arch/arm64/mm/init.c
> > +++ b/arch/arm64/mm/init.c
> > @@ -350,9 +350,18 @@ void __init arm64_memblock_init(void)
> >                       "initrd not fully accessible via the linear mapping -- please check your bootloader ...\n")) {
> >                       phys_initrd_size = 0;
> >               } else {
> > +                     int flags, ret;
> > +
> > +                     ret = memblock_get_flags(base, &flags);
> > +                     if (ret)
> > +                             flags = 0;
> > +
> >                       memblock_remove(base, size); /* clear MEMBLOCK_ flags */
> >                       memblock_add(base, size);
> >                       memblock_reserve(base, size);
>
> Can you explain why we're removing+re-adding here exactly? Is it just to
> clear flags as the comment indicates?
>

This should only happen if the placement of the initrd conflicts with
a mem= command line parameter or it is not covered by memblock for
some other reason.

IOW, this should never happen, and if re-memblock_add'ing this memory
unconditionally is causing problems, we should fix that instead of
working around it.

> If it's really just about clearing flags, I wonder if we rather want to
> have an interface that does exactly that, and hides the way this is
> actually implemented (obtain flags, remove, re-add ...), internally.
>
> But most probably there is more magic in the code and clearing flags
> isn't all it ends up doing.
>

I don't remember exactly why we needed to clear the flags, but I think
it had to do with some corner case we hit when the initrd was
partially covered.
