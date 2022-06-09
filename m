Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 691BF544579
	for <lists+linux-efi@lfdr.de>; Thu,  9 Jun 2022 10:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239425AbiFIIQD (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 9 Jun 2022 04:16:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232118AbiFIIQC (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 9 Jun 2022 04:16:02 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 261111C9260;
        Thu,  9 Jun 2022 01:16:00 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4LJcLl2xRHz1K9H5;
        Thu,  9 Jun 2022 16:14:07 +0800 (CST)
Received: from dggpemm500014.china.huawei.com (7.185.36.153) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 9 Jun 2022 16:15:57 +0800
Received: from [10.174.178.120] (10.174.178.120) by
 dggpemm500014.china.huawei.com (7.185.36.153) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 9 Jun 2022 16:15:55 +0800
Message-ID: <1e7df7bc-5a18-f76a-4408-0579a60c91e3@huawei.com>
Date:   Thu, 9 Jun 2022 16:15:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
From:   mawupeng <mawupeng1@huawei.com>
Subject: Re: [PATCH v3 5/6] mm: Add mirror flag back on initrd memory
To:     <ardb@kernel.org>, <david@redhat.com>
CC:     <rppt@kernel.org>, <corbet@lwn.net>, <will@kernel.org>,
        <catalin.marinas@arm.com>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
        <x86@kernel.org>, <hpa@zytor.com>, <dvhart@infradead.org>,
        <andy@infradead.org>, <akpm@linux-foundation.org>,
        <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <paulmck@kernel.org>,
        <keescook@chromium.org>, <songmuchun@bytedance.com>,
        <rdunlap@infradead.org>, <damien.lemoal@opensource.wdc.com>,
        <swboyd@chromium.org>, <wei.liu@kernel.org>,
        <robin.murphy@arm.com>, <anshuman.khandual@arm.com>,
        <thunder.leizhen@huawei.com>, <wangkefeng.wang@huawei.com>,
        <gpiccoli@igalia.com>, <chenhuacai@kernel.org>,
        <geert@linux-m68k.org>, <vijayb@linux.microsoft.com>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-efi@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>,
        <linux-mm@kvack.org>, <linux-riscv@lists.infradead.org>,
        <mawupeng1@huawei.com>
References: <20220607093805.1354256-1-mawupeng1@huawei.com>
 <20220607093805.1354256-6-mawupeng1@huawei.com>
 <99900b31-2605-2c85-a1b7-9ef2666b58da@redhat.com>
 <CAMj1kXGkzjq3koW_sgO4uzrdtwqSqzsJfT5ABYyvodf+ggXT2w@mail.gmail.com>
 <29900b05-ec44-76a2-645a-22a13399d7fd@huawei.com>
 <YqBzwgTgWEAx8J/C@kernel.org>
 <cd0e727d-8ad6-2d74-55f5-498394aae297@redhat.com>
 <CAMj1kXEKKcnPE5crMYbuFpDJBqmgjFwna84MzAZkfp-mM3B7vA@mail.gmail.com>
In-Reply-To: <CAMj1kXEKKcnPE5crMYbuFpDJBqmgjFwna84MzAZkfp-mM3B7vA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.120]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500014.china.huawei.com (7.185.36.153)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



在 2022/6/8 18:12, Ard Biesheuvel 写道:
> On Wed, 8 Jun 2022 at 12:08, David Hildenbrand <david@redhat.com> wrote:
>>
>> On 08.06.22 12:02, Mike Rapoport wrote:
>>> On Wed, Jun 08, 2022 at 03:27:09PM +0800, mawupeng wrote:
>>>>
>>>> 在 2022/6/7 22:49, Ard Biesheuvel 写道:
>>>>> On Tue, 7 Jun 2022 at 14:22, David Hildenbrand <david@redhat.com> wrote:
>>>>>>
>>>>>> On 07.06.22 11:38, Wupeng Ma wrote:
>>>>>>> From: Ma Wupeng <mawupeng1@huawei.com>
>>>>>>>
>>>>>>> Initrd memory will be removed and then added in arm64_memblock_init() and this
>>>>>>> will cause it to lose all of its memblock flags. The lost of MEMBLOCK_MIRROR
>>>>>>> flag will lead to error log printed by find_zone_movable_pfns_for_nodes if
>>>>>>> the lower 4G range has some non-mirrored memory.
>>>>>>>
>>>>>>> In order to solve this problem, the lost MEMBLOCK_MIRROR flag will be
>>>>>>> reinstalled if the origin memblock has this flag.
>>>>>>>
>>>>>>> Signed-off-by: Ma Wupeng <mawupeng1@huawei.com>
>>>>>>> ---
>>>>>>>    arch/arm64/mm/init.c     |  9 +++++++++
>>>>>>>    include/linux/memblock.h |  1 +
>>>>>>>    mm/memblock.c            | 20 ++++++++++++++++++++
>>>>>>>    3 files changed, 30 insertions(+)
>>>>>>>
>>>>>>> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
>>>>>>> index 339ee84e5a61..11641f924d08 100644
>>>>>>> --- a/arch/arm64/mm/init.c
>>>>>>> +++ b/arch/arm64/mm/init.c
>>>>>>> @@ -350,9 +350,18 @@ void __init arm64_memblock_init(void)
>>>>>>>                         "initrd not fully accessible via the linear mapping -- please check your bootloader ...\n")) {
>>>>>>>                         phys_initrd_size = 0;
>>>>>>>                 } else {
>>>>>>> +                     int flags, ret;
>>>>>>> +
>>>>>>> +                     ret = memblock_get_flags(base, &flags);
>>>>>>> +                     if (ret)
>>>>>>> +                             flags = 0;
>>>>>>> +
>>>>>>>                         memblock_remove(base, size); /* clear MEMBLOCK_ flags */
>>>>>>>                         memblock_add(base, size);
>>>>>>>                         memblock_reserve(base, size);
>>>>>>
>>>>>> Can you explain why we're removing+re-adding here exactly? Is it just to
>>>>>> clear flags as the comment indicates?
>>>>>>
>>>>>
>>>>> This should only happen if the placement of the initrd conflicts with
>>>>> a mem= command line parameter or it is not covered by memblock for
>>>>> some other reason.
>>>>>
>>>>> IOW, this should never happen, and if re-memblock_add'ing this memory
>>>>> unconditionally is causing problems, we should fix that instead of
>>>>> working around it.
>>>>
>>>> This will happen if we use initrdmem=3G,100M to reserve initrd memory below
>>>> the 4G limit to test this scenario(just for testing, I have trouble to boot
>>>> qemu with initrd enabled and memory below 4G are all mirror memory).
>>>>
>>>> Re-memblock_add'ing this memory unconditionally seems fine but clear all
>>>> flags(especially MEMBLOCK_MIRROR) may lead to some error log.
>>>>
>>>>>
>>>>>> If it's really just about clearing flags, I wonder if we rather want to
>>>>>> have an interface that does exactly that, and hides the way this is
>>>>>> actually implemented (obtain flags, remove, re-add ...), internally.
>>>>>>
>>>>>> But most probably there is more magic in the code and clearing flags
>>>>>> isn't all it ends up doing.
>>>>>>
>>>>>
>>>>> I don't remember exactly why we needed to clear the flags, but I think
>>>>> it had to do with some corner case we hit when the initrd was
>>>>> partially covered.
>>>> If "mem=" is set in command line, memblock_mem_limit_remove_map() will
>>>> remove all memory block without MEMBLOCK_NOMAP. Maybe this will bring the
>>>> memory back if this initrd mem has the MEMBLOCK_NOMAP flag?
>>>>
>>>> The rfc version [1] introduce and use memblock_clear_nomap() to clear the
>>>> MEMBLOCK_NOMAP of this initrd memblock.
>>>> So maybe the usage of memblock_remove() is just to avoid introducing new
>>>> function(memblock_clear_nomap)?
>>>>
>>>> Since commit 4c546b8a3469 ("memblock: add memblock_clear_nomap()") already
>>>> introduced memblock_clear_nomap(). Can we use this to remove flag MEMBLOCK_NOMAP
>>>> to solve this problem rather than bring flag MEMBLOCK_MIRROR back?
>>>
>>> AFAICT, there are two corner cases that re-adding initrd memory covers:
>>> * initrd memory is not a part of the memory reported to memblock, either
>>> because of firmware weirdness or because it was cut out with mem=
>>> * initrd memory overlaps a NOMAP region
>>>
>>> So to make sure initrd memory is mapped properly and retains
>>> MEMBLOCK_MIRROR I think the best we can do is
>>>
>>>        memblock_add();
>>>        memblock_clear_nomap();
>>>        memblock_reserve();
>>
>> Would simply detect+rejecting to boot on such setups be an option? The
>> replies so far indicate to me that this is rather a corner case than a
>> reasonable use case.
>>
> 
> The sad reality is that mem= is known to be used in production for
> limiting the amount of memory that the kernel takes control of, in
> order to allow the remainder to be used in platform specific ways.
> 
> Of course, there are much better ways to achieve that, but given that
> we currently support it, I don't think we can easily back that out.
> 
> I do think that there is no need to go out of our way to make this
> case work seamlessly with mirrored memory, though. So I'd prefer to
> make the remove+re-add conditional on there actually being a need to
> do so. That way, we don't break the old use case or mirrored memory,
> and whatever happens when the two are combined is DONTCARE.

Does that mean that we don't need to care about this scenario with
mirror memory?

Thanks for reviewing.

> .
