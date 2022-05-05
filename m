Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D44C751C4F0
	for <lists+linux-efi@lfdr.de>; Thu,  5 May 2022 18:13:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232543AbiEEQP5 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 5 May 2022 12:15:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbiEEQP4 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 5 May 2022 12:15:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65A43B80
        for <linux-efi@vger.kernel.org>; Thu,  5 May 2022 09:12:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 12B6EB82DF7
        for <linux-efi@vger.kernel.org>; Thu,  5 May 2022 16:12:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C74E5C385B0
        for <linux-efi@vger.kernel.org>; Thu,  5 May 2022 16:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651767133;
        bh=ipdW/XK4EChOh7CNBfnV5DfI8o2DDjutNch/JdNzlgM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CV7GqME4fDg3wwymQJWMV28qap2cOfLHFgr7gUDW1On0x/tAYmCvvtpeSjqtyKKhn
         OA3YNDmegDz47F7w3Bb7pTlx0itz7L8HZzdMWC2wFk7vnihyWGE+sQZEkeMBuWs3iD
         IlvEqAp51aOnI0IC3F/8AbYoVn1NG1wkTfyiEefixGLNSughoqETMFh3xBpEGN/u5E
         xPSKnMHG0B150gY1RHunS/g2NE4aZ4y6dDTM/TwW4Tsqm8UGrGaQAQvpSum+AmCzDr
         wwxl/00n622KHycdHHE/FJZJ/14UtBxG6/7Cc+QcdHDNfRnZjaKlCF3wq9pjMxlYH0
         jN7neIC0H/F+g==
Received: by mail-oi1-f172.google.com with SMTP id m11so4800427oib.11
        for <linux-efi@vger.kernel.org>; Thu, 05 May 2022 09:12:13 -0700 (PDT)
X-Gm-Message-State: AOAM531/NqBAfGdgN1i9M2F2qG200CwXhWWs4h6GrqQLEQQynhxB5BKn
        3wRWZOpi1W9qBl4oii3mPHuZuETqRb6jpuamZXk=
X-Google-Smtp-Source: ABdhPJxKZwloLkKq0RUD/Xi1dUNvDYLjRTku73thHqgWWBdFLvsVWi3P3+Hf1krvwR2iTMa1wG4DMWTtsgyuuBsw5oI=
X-Received: by 2002:a05:6808:e8d:b0:322:bac0:2943 with SMTP id
 k13-20020a0568080e8d00b00322bac02943mr2921525oil.126.1651767132906; Thu, 05
 May 2022 09:12:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220503152131.263711-1-ardb@kernel.org> <9472d1d5-7f03-eaaf-2846-a4340163d5c0@huawei.com>
In-Reply-To: <9472d1d5-7f03-eaaf-2846-a4340163d5c0@huawei.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 5 May 2022 18:12:01 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEPVEzMgOM4+Yj6PxHA-jFuDOAUdDJSiSxy_XaP4P7LSw@mail.gmail.com>
Message-ID: <CAMj1kXEPVEzMgOM4+Yj6PxHA-jFuDOAUdDJSiSxy_XaP4P7LSw@mail.gmail.com>
Subject: Re: [PATCH] efi: stub: prefer mirrored memory for randomized allocations
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Wupeng Ma <mawupeng1@huawei.com>,
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

On Thu, 5 May 2022 at 15:43, Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
>
>
> On 2022/5/3 23:21, Ard Biesheuvel wrote:
> > If the system exposes memory regions with the EFI_MORE_RELIABLE
> > attribute, it is implied that it is intended to be used for allocations
> > that are relatively important, such as the kernel's static image.
> >
> > Since efi_random_alloc() is mostly (only) used for allocating space for
> > the kernel image, let's update it to take this into account, and
> > disregard all memory without the EFI_MORE_RELIABLE attribute if there is
> > sufficient memory available that does have this attribute.
> >
> > Note that this change only affects booting with randomization enabled.
> > In other cases, the EFI stub runs the kernel image in place unless its
> > placement is unsuitable for some reason (i.e., misaligned, or its BSS
> > overlaps with another allocation), and it is left to the bootloader to
> > ensure that the kernel was loaded into EFI_MORE_RELIABLE memory if this
> > is desired.
> >
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
> >   drivers/firmware/efi/libstub/randomalloc.c | 11 +++++++++++
> >   1 file changed, 11 insertions(+)
> >
> > diff --git a/drivers/firmware/efi/libstub/randomalloc.c b/drivers/firmware/efi/libstub/randomalloc.c
> > index 724155b9e10d..07a762910312 100644
> > --- a/drivers/firmware/efi/libstub/randomalloc.c
> > +++ b/drivers/firmware/efi/libstub/randomalloc.c
> > @@ -56,6 +56,7 @@ efi_status_t efi_random_alloc(unsigned long size,
> >                             unsigned long random_seed)
> >   {
> >       unsigned long map_size, desc_size, total_slots = 0, target_slot;
> > +     unsigned long total_mirrored_slots = 0;
> >       unsigned long buff_size;
> >       efi_status_t status;
> >       efi_memory_desc_t *memory_map;
> > @@ -86,8 +87,14 @@ efi_status_t efi_random_alloc(unsigned long size,
> >               slots = get_entry_num_slots(md, size, ilog2(align));
> >               MD_NUM_SLOTS(md) = slots;
> >               total_slots += slots;
> > +             if (md->attribute & EFI_MEMORY_MORE_RELIABLE)
> > +                     total_mirrored_slots += slots;
> >       }
> >
> > +     /* only consider mirrored slots for randomization if any exist */
> > +     if (total_mirrored_slots > 0)
> > +             total_slots = total_mirrored_slots;
> > +
>
> The kernel will check 4G lower limit to enable kernelcore=mirror feature.
>

Why? I mean, why is 4G a magic number also on arm64?


> Do we need some fallback mechanism in case of small mirror slots which
>
> leads to fail allocation for Image?
>

This code only counts slots that are large enough to hold the Image so
this can never happen. If total_mirrored_slots > 0, there is at least
one possible placement of the kernel where it falls entirely inside a
EFI_MORE_RELIABLE region.

>
> >       /* find a random number between 0 and total_slots */
> >       target_slot = (total_slots * (u64)(random_seed & U32_MAX)) >> 32;
> >
> > @@ -107,6 +114,10 @@ efi_status_t efi_random_alloc(unsigned long size,
> >               efi_physical_addr_t target;
> >               unsigned long pages;
> >
> > +             if (total_mirrored_slots > 0 &&
> > +                 !(md->attribute & EFI_MEMORY_MORE_RELIABLE))
> > +                     continue;
> > +
> >               if (target_slot >= MD_NUM_SLOTS(md)) {
> >                       target_slot -= MD_NUM_SLOTS(md);
> >                       continue;
