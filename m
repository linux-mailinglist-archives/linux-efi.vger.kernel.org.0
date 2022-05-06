Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F5FC51CE03
	for <lists+linux-efi@lfdr.de>; Fri,  6 May 2022 04:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355067AbiEFBq7 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 5 May 2022 21:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388184AbiEFBqs (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 5 May 2022 21:46:48 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64A7262134
        for <linux-efi@vger.kernel.org>; Thu,  5 May 2022 18:42:59 -0700 (PDT)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KvYGg0PnRzhYvD;
        Fri,  6 May 2022 09:42:35 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 6 May 2022 09:42:57 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 6 May 2022 09:42:57 +0800
Message-ID: <0e6b7f51-7560-3d5f-e2ee-c479e735beb1@huawei.com>
Date:   Fri, 6 May 2022 09:42:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH] efi: stub: prefer mirrored memory for randomized
 allocations
Content-Language: en-US
To:     Ard Biesheuvel <ardb@kernel.org>
CC:     linux-efi <linux-efi@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Wupeng Ma <mawupeng1@huawei.com>,
        Linux Memory Management List <linux-mm@kvack.org>
References: <20220503152131.263711-1-ardb@kernel.org>
 <9472d1d5-7f03-eaaf-2846-a4340163d5c0@huawei.com>
 <CAMj1kXEPVEzMgOM4+Yj6PxHA-jFuDOAUdDJSiSxy_XaP4P7LSw@mail.gmail.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <CAMj1kXEPVEzMgOM4+Yj6PxHA-jFuDOAUdDJSiSxy_XaP4P7LSw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


On 2022/5/6 0:12, Ard Biesheuvel wrote:
> On Thu, 5 May 2022 at 15:43, Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
>>
>> On 2022/5/3 23:21, Ard Biesheuvel wrote:
>>> If the system exposes memory regions with the EFI_MORE_RELIABLE
>>> attribute, it is implied that it is intended to be used for allocations
>>> that are relatively important, such as the kernel's static image.
>>>
>>> Since efi_random_alloc() is mostly (only) used for allocating space for
>>> the kernel image, let's update it to take this into account, and
>>> disregard all memory without the EFI_MORE_RELIABLE attribute if there is
>>> sufficient memory available that does have this attribute.
>>>
>>> Note that this change only affects booting with randomization enabled.
>>> In other cases, the EFI stub runs the kernel image in place unless its
>>> placement is unsuitable for some reason (i.e., misaligned, or its BSS
>>> overlaps with another allocation), and it is left to the bootloader to
>>> ensure that the kernel was loaded into EFI_MORE_RELIABLE memory if this
>>> is desired.
>>>
>>> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
>>> ---
>>>    drivers/firmware/efi/libstub/randomalloc.c | 11 +++++++++++
>>>    1 file changed, 11 insertions(+)
>>>
>>> diff --git a/drivers/firmware/efi/libstub/randomalloc.c b/drivers/firmware/efi/libstub/randomalloc.c
>>> index 724155b9e10d..07a762910312 100644
>>> --- a/drivers/firmware/efi/libstub/randomalloc.c
>>> +++ b/drivers/firmware/efi/libstub/randomalloc.c
>>> @@ -56,6 +56,7 @@ efi_status_t efi_random_alloc(unsigned long size,
>>>                              unsigned long random_seed)
>>>    {
>>>        unsigned long map_size, desc_size, total_slots = 0, target_slot;
>>> +     unsigned long total_mirrored_slots = 0;
>>>        unsigned long buff_size;
>>>        efi_status_t status;
>>>        efi_memory_desc_t *memory_map;
>>> @@ -86,8 +87,14 @@ efi_status_t efi_random_alloc(unsigned long size,
>>>                slots = get_entry_num_slots(md, size, ilog2(align));
>>>                MD_NUM_SLOTS(md) = slots;
>>>                total_slots += slots;
>>> +             if (md->attribute & EFI_MEMORY_MORE_RELIABLE)
>>> +                     total_mirrored_slots += slots;
>>>        }
>>>
>>> +     /* only consider mirrored slots for randomization if any exist */
>>> +     if (total_mirrored_slots > 0)
>>> +             total_slots = total_mirrored_slots;
>>> +
>> The kernel will check 4G lower limit to enable kernelcore=mirror feature.
>>
> Why? I mean, why is 4G a magic number also on arm64?
Please ignore this, replied in the previous email.
>
>> Do we need some fallback mechanism in case of small mirror slots which
>>
>> leads to fail allocation for Image?
>>
> This code only counts slots that are large enough to hold the Image so
> this can never happen. If total_mirrored_slots > 0, there is at least
> one possible placement of the kernel where it falls entirely inside a
> EFI_MORE_RELIABLE region.

I see,  slots = get_entry_num_slots(md, *size*, ilog2(align));

Thanks.

Reviewed-by: Kefeng Wang <wangkefeng.wang@huawei.com>

>
>>>        /* find a random number between 0 and total_slots */
>>>        target_slot = (total_slots * (u64)(random_seed & U32_MAX)) >> 32;
>>>
>>> @@ -107,6 +114,10 @@ efi_status_t efi_random_alloc(unsigned long size,
>>>                efi_physical_addr_t target;
>>>                unsigned long pages;
>>>
>>> +             if (total_mirrored_slots > 0 &&
>>> +                 !(md->attribute & EFI_MEMORY_MORE_RELIABLE))
>>> +                     continue;
>>> +
>>>                if (target_slot >= MD_NUM_SLOTS(md)) {
>>>                        target_slot -= MD_NUM_SLOTS(md);
>>>                        continue;
> .
