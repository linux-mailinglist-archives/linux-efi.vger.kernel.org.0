Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF8A254650D
	for <lists+linux-efi@lfdr.de>; Fri, 10 Jun 2022 13:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345418AbiFJLHF (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 10 Jun 2022 07:07:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345394AbiFJLHD (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 10 Jun 2022 07:07:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 286F11451ED;
        Fri, 10 Jun 2022 04:07:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B3DF0620B5;
        Fri, 10 Jun 2022 11:07:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A680C3411D;
        Fri, 10 Jun 2022 11:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654859221;
        bh=QPelFN8AL92VksfY96r5jUsYCZvlTT4zLZ07LzwS7DQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TbeEV5zTgTFMoLxNVhKthTVyn5XyvE8Fbp4zvNMejyx03T4L2AWB92TD3XT8LxSsN
         jCETP4gGqG3aeHzvjivz7oF/AcPPJHytWgKees1A9JZYTGjQPRLRANhlGlb0qIhyf+
         2Z0bdasjlXW9YPINyJl/DIb8ICVzapI1pmHVuvUj+/nr2FMCrV5BBjoIWbDOy50ORQ
         owJxEdkih/z++eSAXm8V+jjY2ptZwGXqpKCdp7h7weQ+nx7sAQdxawZa+9wya3fKy3
         ZtHXeWaecHLcio1xfUVwus7ccZn9Ar4adja1NyMUmIpHVYOg0Xsg1qJaMVL1kDGAqY
         9Qx8AA7sIQA7g==
Received: by mail-ot1-f42.google.com with SMTP id 93-20020a9d02e6000000b0060c252ee7a4so3158976otl.13;
        Fri, 10 Jun 2022 04:07:01 -0700 (PDT)
X-Gm-Message-State: AOAM530rgZ2wq6XIJFwcvk1LUYeSCz8pGPKk226w8d/HZ41pxK2JorBr
        6GRcOwuUDlBeM2lrkhTUSIVnJSrKlih/oLlMEkg=
X-Google-Smtp-Source: ABdhPJzh16psgzjij7DW4g0fUughTfP83t6zSkopbYoDijol00+82UviKfwBST1gV1Xr1xLVMsx+Y8jk4I968paElKA=
X-Received: by 2002:a05:6830:9c2:b0:606:1e0a:cc8d with SMTP id
 y2-20020a05683009c200b006061e0acc8dmr19062664ott.265.1654859209198; Fri, 10
 Jun 2022 04:06:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220607093805.1354256-1-mawupeng1@huawei.com>
 <20220607093805.1354256-6-mawupeng1@huawei.com> <99900b31-2605-2c85-a1b7-9ef2666b58da@redhat.com>
 <CAMj1kXGkzjq3koW_sgO4uzrdtwqSqzsJfT5ABYyvodf+ggXT2w@mail.gmail.com>
 <29900b05-ec44-76a2-645a-22a13399d7fd@huawei.com> <YqBzwgTgWEAx8J/C@kernel.org>
 <cd0e727d-8ad6-2d74-55f5-498394aae297@redhat.com> <CAMj1kXEKKcnPE5crMYbuFpDJBqmgjFwna84MzAZkfp-mM3B7vA@mail.gmail.com>
 <1e7df7bc-5a18-f76a-4408-0579a60c91e3@huawei.com>
In-Reply-To: <1e7df7bc-5a18-f76a-4408-0579a60c91e3@huawei.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 10 Jun 2022 13:06:35 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFTR=aHBN9oKdQjhNvS4_CX=uaPnpN7gGi0bEbOkmgXhg@mail.gmail.com>
Message-ID: <CAMj1kXFTR=aHBN9oKdQjhNvS4_CX=uaPnpN7gGi0bEbOkmgXhg@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] mm: Add mirror flag back on initrd memory
To:     mawupeng <mawupeng1@huawei.com>
Cc:     david@redhat.com, rppt@kernel.org, corbet@lwn.net, will@kernel.org,
        catalin.marinas@arm.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, dvhart@infradead.org, andy@infradead.org,
        akpm@linux-foundation.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, paulmck@kernel.org,
        keescook@chromium.org, songmuchun@bytedance.com,
        rdunlap@infradead.org, damien.lemoal@opensource.wdc.com,
        swboyd@chromium.org, wei.liu@kernel.org, robin.murphy@arm.com,
        anshuman.khandual@arm.com, thunder.leizhen@huawei.com,
        wangkefeng.wang@huawei.com, gpiccoli@igalia.com,
        chenhuacai@kernel.org, geert@linux-m68k.org,
        vijayb@linux.microsoft.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-mm@kvack.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 9 Jun 2022 at 10:16, mawupeng <mawupeng1@huawei.com> wrote:
>
>
>
> =E5=9C=A8 2022/6/8 18:12, Ard Biesheuvel =E5=86=99=E9=81=93:
> > On Wed, 8 Jun 2022 at 12:08, David Hildenbrand <david@redhat.com> wrote=
:
> >>
> >> On 08.06.22 12:02, Mike Rapoport wrote:
> >>> On Wed, Jun 08, 2022 at 03:27:09PM +0800, mawupeng wrote:
> >>>>
> >>>> =E5=9C=A8 2022/6/7 22:49, Ard Biesheuvel =E5=86=99=E9=81=93:
> >>>>> On Tue, 7 Jun 2022 at 14:22, David Hildenbrand <david@redhat.com> w=
rote:
> >>>>>>
> >>>>>> On 07.06.22 11:38, Wupeng Ma wrote:
> >>>>>>> From: Ma Wupeng <mawupeng1@huawei.com>
> >>>>>>>
> >>>>>>> Initrd memory will be removed and then added in arm64_memblock_in=
it() and this
> >>>>>>> will cause it to lose all of its memblock flags. The lost of MEMB=
LOCK_MIRROR
> >>>>>>> flag will lead to error log printed by find_zone_movable_pfns_for=
_nodes if
> >>>>>>> the lower 4G range has some non-mirrored memory.
> >>>>>>>
> >>>>>>> In order to solve this problem, the lost MEMBLOCK_MIRROR flag wil=
l be
> >>>>>>> reinstalled if the origin memblock has this flag.
> >>>>>>>
> >>>>>>> Signed-off-by: Ma Wupeng <mawupeng1@huawei.com>
> >>>>>>> ---
> >>>>>>>    arch/arm64/mm/init.c     |  9 +++++++++
> >>>>>>>    include/linux/memblock.h |  1 +
> >>>>>>>    mm/memblock.c            | 20 ++++++++++++++++++++
> >>>>>>>    3 files changed, 30 insertions(+)
> >>>>>>>
> >>>>>>> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> >>>>>>> index 339ee84e5a61..11641f924d08 100644
> >>>>>>> --- a/arch/arm64/mm/init.c
> >>>>>>> +++ b/arch/arm64/mm/init.c
> >>>>>>> @@ -350,9 +350,18 @@ void __init arm64_memblock_init(void)
> >>>>>>>                         "initrd not fully accessible via the line=
ar mapping -- please check your bootloader ...\n")) {
> >>>>>>>                         phys_initrd_size =3D 0;
> >>>>>>>                 } else {
> >>>>>>> +                     int flags, ret;
> >>>>>>> +
> >>>>>>> +                     ret =3D memblock_get_flags(base, &flags);
> >>>>>>> +                     if (ret)
> >>>>>>> +                             flags =3D 0;
> >>>>>>> +
> >>>>>>>                         memblock_remove(base, size); /* clear MEM=
BLOCK_ flags */
> >>>>>>>                         memblock_add(base, size);
> >>>>>>>                         memblock_reserve(base, size);
> >>>>>>
> >>>>>> Can you explain why we're removing+re-adding here exactly? Is it j=
ust to
> >>>>>> clear flags as the comment indicates?
> >>>>>>
> >>>>>
> >>>>> This should only happen if the placement of the initrd conflicts wi=
th
> >>>>> a mem=3D command line parameter or it is not covered by memblock fo=
r
> >>>>> some other reason.
> >>>>>
> >>>>> IOW, this should never happen, and if re-memblock_add'ing this memo=
ry
> >>>>> unconditionally is causing problems, we should fix that instead of
> >>>>> working around it.
> >>>>
> >>>> This will happen if we use initrdmem=3D3G,100M to reserve initrd mem=
ory below
> >>>> the 4G limit to test this scenario(just for testing, I have trouble =
to boot
> >>>> qemu with initrd enabled and memory below 4G are all mirror memory).
> >>>>
> >>>> Re-memblock_add'ing this memory unconditionally seems fine but clear=
 all
> >>>> flags(especially MEMBLOCK_MIRROR) may lead to some error log.
> >>>>
> >>>>>
> >>>>>> If it's really just about clearing flags, I wonder if we rather wa=
nt to
> >>>>>> have an interface that does exactly that, and hides the way this i=
s
> >>>>>> actually implemented (obtain flags, remove, re-add ...), internall=
y.
> >>>>>>
> >>>>>> But most probably there is more magic in the code and clearing fla=
gs
> >>>>>> isn't all it ends up doing.
> >>>>>>
> >>>>>
> >>>>> I don't remember exactly why we needed to clear the flags, but I th=
ink
> >>>>> it had to do with some corner case we hit when the initrd was
> >>>>> partially covered.
> >>>> If "mem=3D" is set in command line, memblock_mem_limit_remove_map() =
will
> >>>> remove all memory block without MEMBLOCK_NOMAP. Maybe this will brin=
g the
> >>>> memory back if this initrd mem has the MEMBLOCK_NOMAP flag?
> >>>>
> >>>> The rfc version [1] introduce and use memblock_clear_nomap() to clea=
r the
> >>>> MEMBLOCK_NOMAP of this initrd memblock.
> >>>> So maybe the usage of memblock_remove() is just to avoid introducing=
 new
> >>>> function(memblock_clear_nomap)?
> >>>>
> >>>> Since commit 4c546b8a3469 ("memblock: add memblock_clear_nomap()") a=
lready
> >>>> introduced memblock_clear_nomap(). Can we use this to remove flag ME=
MBLOCK_NOMAP
> >>>> to solve this problem rather than bring flag MEMBLOCK_MIRROR back?
> >>>
> >>> AFAICT, there are two corner cases that re-adding initrd memory cover=
s:
> >>> * initrd memory is not a part of the memory reported to memblock, eit=
her
> >>> because of firmware weirdness or because it was cut out with mem=3D
> >>> * initrd memory overlaps a NOMAP region
> >>>
> >>> So to make sure initrd memory is mapped properly and retains
> >>> MEMBLOCK_MIRROR I think the best we can do is
> >>>
> >>>        memblock_add();
> >>>        memblock_clear_nomap();
> >>>        memblock_reserve();
> >>
> >> Would simply detect+rejecting to boot on such setups be an option? The
> >> replies so far indicate to me that this is rather a corner case than a
> >> reasonable use case.
> >>
> >
> > The sad reality is that mem=3D is known to be used in production for
> > limiting the amount of memory that the kernel takes control of, in
> > order to allow the remainder to be used in platform specific ways.
> >
> > Of course, there are much better ways to achieve that, but given that
> > we currently support it, I don't think we can easily back that out.
> >
> > I do think that there is no need to go out of our way to make this
> > case work seamlessly with mirrored memory, though. So I'd prefer to
> > make the remove+re-add conditional on there actually being a need to
> > do so. That way, we don't break the old use case or mirrored memory,
> > and whatever happens when the two are combined is DONTCARE.
>
> Does that mean that we don't need to care about this scenario with
> mirror memory?
>

We shouldn't, but we do, unfortunately.

So we should probably adopt the sequence suggested by Mike.
