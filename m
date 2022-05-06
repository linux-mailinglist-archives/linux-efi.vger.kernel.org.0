Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F26551D129
	for <lists+linux-efi@lfdr.de>; Fri,  6 May 2022 08:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232493AbiEFGXb (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 6 May 2022 02:23:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389388AbiEFGXW (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 6 May 2022 02:23:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 998F55C669
        for <linux-efi@vger.kernel.org>; Thu,  5 May 2022 23:19:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 34AFF61F1C
        for <linux-efi@vger.kernel.org>; Fri,  6 May 2022 06:19:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98325C385AC
        for <linux-efi@vger.kernel.org>; Fri,  6 May 2022 06:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651817977;
        bh=IUl60lZB9k2Omx05KnvR9/Pnx4r4J6gGGycPuLGxQhs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Wn4TowktAoGU6/7hE0aJOA6AA+2coq7oanmB6OhX7edUBX8ZM1u/eVdxOjnfyzb05
         oNHQtOn3vlgDQJ5b8jOkrKp7rTxPx8pzzWhOo9UjoClUUza9rDvpu1+KLbcttKPbXN
         K+Tm6Byp2i+zEVoAL2yDq60AUekvb9o6cCXSRtNhiV9kVWMJi5aMdu7+N3erAzEVmT
         qsRh5jUjWNsz44MV60iJ/qNxl6FKKz85fF1uKYqHTFE2s5SUmggTITni7LO2eucND+
         5Wa7GpGzSzK6fUvX8UM1SQ2chViQMTMOLNB20U6Z6PPIpg3ImWn+gEYpGDL8FlK0Yv
         nurSv6ESZuzEg==
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-d6e29fb3d7so6322477fac.7
        for <linux-efi@vger.kernel.org>; Thu, 05 May 2022 23:19:37 -0700 (PDT)
X-Gm-Message-State: AOAM53050c8YMHcYVDgRbaQqV/sfuPz0BiUD4jy1WketiWDZ6PaZYIpE
        aY85FR3j4n3xiyx1igv5M6/TPL7c7yYyKhah1eg=
X-Google-Smtp-Source: ABdhPJydfyazSt7F/4W0H97tAcaXutERRfuxdMEi3I4BCOviCwX7pCQexWP/deuaaJkfCStxlkMTky2/H4Myo/Aqm5w=
X-Received: by 2002:a05:6870:eaa5:b0:da:b3f:2b45 with SMTP id
 s37-20020a056870eaa500b000da0b3f2b45mr3890092oap.228.1651817976736; Thu, 05
 May 2022 23:19:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220503152131.263711-1-ardb@kernel.org> <9472d1d5-7f03-eaaf-2846-a4340163d5c0@huawei.com>
 <CAMj1kXEPVEzMgOM4+Yj6PxHA-jFuDOAUdDJSiSxy_XaP4P7LSw@mail.gmail.com> <0e6b7f51-7560-3d5f-e2ee-c479e735beb1@huawei.com>
In-Reply-To: <0e6b7f51-7560-3d5f-e2ee-c479e735beb1@huawei.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 6 May 2022 08:19:25 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHL5nTptXXdo1g=rSQUp+rKRVsoHngo41cM0uUh7BUgeQ@mail.gmail.com>
Message-ID: <CAMj1kXHL5nTptXXdo1g=rSQUp+rKRVsoHngo41cM0uUh7BUgeQ@mail.gmail.com>
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

On Fri, 6 May 2022 at 03:43, Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
>
>
> On 2022/5/6 0:12, Ard Biesheuvel wrote:
> > On Thu, 5 May 2022 at 15:43, Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
> >>
> >> On 2022/5/3 23:21, Ard Biesheuvel wrote:
> >>> If the system exposes memory regions with the EFI_MORE_RELIABLE
> >>> attribute, it is implied that it is intended to be used for allocations
> >>> that are relatively important, such as the kernel's static image.
> >>>
> >>> Since efi_random_alloc() is mostly (only) used for allocating space for
> >>> the kernel image, let's update it to take this into account, and
> >>> disregard all memory without the EFI_MORE_RELIABLE attribute if there is
> >>> sufficient memory available that does have this attribute.
> >>>
> >>> Note that this change only affects booting with randomization enabled.
> >>> In other cases, the EFI stub runs the kernel image in place unless its
> >>> placement is unsuitable for some reason (i.e., misaligned, or its BSS
> >>> overlaps with another allocation), and it is left to the bootloader to
> >>> ensure that the kernel was loaded into EFI_MORE_RELIABLE memory if this
> >>> is desired.
> >>>
> >>> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> >>> ---
> >>>    drivers/firmware/efi/libstub/randomalloc.c | 11 +++++++++++
> >>>    1 file changed, 11 insertions(+)
> >>>
> >>> diff --git a/drivers/firmware/efi/libstub/randomalloc.c b/drivers/firmware/efi/libstub/randomalloc.c
> >>> index 724155b9e10d..07a762910312 100644
> >>> --- a/drivers/firmware/efi/libstub/randomalloc.c
> >>> +++ b/drivers/firmware/efi/libstub/randomalloc.c
> >>> @@ -56,6 +56,7 @@ efi_status_t efi_random_alloc(unsigned long size,
> >>>                              unsigned long random_seed)
> >>>    {
> >>>        unsigned long map_size, desc_size, total_slots = 0, target_slot;
> >>> +     unsigned long total_mirrored_slots = 0;
> >>>        unsigned long buff_size;
> >>>        efi_status_t status;
> >>>        efi_memory_desc_t *memory_map;
> >>> @@ -86,8 +87,14 @@ efi_status_t efi_random_alloc(unsigned long size,
> >>>                slots = get_entry_num_slots(md, size, ilog2(align));
> >>>                MD_NUM_SLOTS(md) = slots;
> >>>                total_slots += slots;
> >>> +             if (md->attribute & EFI_MEMORY_MORE_RELIABLE)
> >>> +                     total_mirrored_slots += slots;
> >>>        }
> >>>
> >>> +     /* only consider mirrored slots for randomization if any exist */
> >>> +     if (total_mirrored_slots > 0)
> >>> +             total_slots = total_mirrored_slots;
> >>> +
> >> The kernel will check 4G lower limit to enable kernelcore=mirror feature.
> >>
> > Why? I mean, why is 4G a magic number also on arm64?
> Please ignore this, replied in the previous email.
> >
> >> Do we need some fallback mechanism in case of small mirror slots which
> >>
> >> leads to fail allocation for Image?
> >>
> > This code only counts slots that are large enough to hold the Image so
> > this can never happen. If total_mirrored_slots > 0, there is at least
> > one possible placement of the kernel where it falls entirely inside a
> > EFI_MORE_RELIABLE region.
>
> I see,  slots = get_entry_num_slots(md, *size*, ilog2(align));
>
> Thanks.
>
> Reviewed-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>

Thank you. I have queued this up now.
