Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35CA254629D
	for <lists+linux-efi@lfdr.de>; Fri, 10 Jun 2022 11:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349262AbiFJJf7 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 10 Jun 2022 05:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348886AbiFJJf6 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 10 Jun 2022 05:35:58 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9EAF215;
        Fri, 10 Jun 2022 02:35:56 -0700 (PDT)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LKG4W0dLlzdZvG;
        Fri, 10 Jun 2022 17:34:03 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 10 Jun 2022 17:35:54 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 10 Jun 2022 17:35:53 +0800
Message-ID: <be81558c-286d-3620-bd9f-014c7861d9d1@huawei.com>
Date:   Fri, 10 Jun 2022 17:35:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3 4/6] mm: Demote warning message in vmemmap_verify() to
 debug level
Content-Language: en-US
To:     mawupeng <mawupeng1@huawei.com>, <anshuman.khandual@arm.com>,
        <david@redhat.com>, <corbet@lwn.net>, <will@kernel.org>,
        <ardb@kernel.org>, <catalin.marinas@arm.com>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <dvhart@infradead.org>, <andy@infradead.org>, <rppt@kernel.org>,
        <akpm@linux-foundation.org>, <paul.walmsley@sifive.com>,
        <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
        <paulmck@kernel.org>, <keescook@chromium.org>,
        <songmuchun@bytedance.com>, <rdunlap@infradead.org>,
        <damien.lemoal@opensource.wdc.com>, <swboyd@chromium.org>,
        <wei.liu@kernel.org>, <robin.murphy@arm.com>,
        <thunder.leizhen@huawei.com>, <gpiccoli@igalia.com>,
        <chenhuacai@kernel.org>, <geert@linux-m68k.org>,
        <vijayb@linux.microsoft.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-efi@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>,
        <linux-mm@kvack.org>, <linux-riscv@lists.infradead.org>
References: <20220607093805.1354256-1-mawupeng1@huawei.com>
 <20220607093805.1354256-5-mawupeng1@huawei.com>
 <b1975f44-2552-a03c-bb6f-1452f1fd99c0@redhat.com>
 <a820f287-e879-6183-a917-6a577b6160ab@huawei.com>
 <1f2a76d5-7c4e-46bc-ce66-20a962eac73c@arm.com>
 <8d5e867f-e51a-d763-5ac3-6dfc4e67a376@huawei.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <8d5e867f-e51a-d763-5ac3-6dfc4e67a376@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


On 2022/6/9 16:13, mawupeng wrote:
>
>
> 在 2022/6/8 18:00, Anshuman Khandual 写道:
>>
>>
>> On 6/8/22 06:56, mawupeng wrote:
>>>
>>>
>>> 在 2022/6/7 20:25, David Hildenbrand 写道:
>>>> On 07.06.22 11:38, Wupeng Ma wrote:
>>>>> From: Ma Wupeng <mawupeng1@huawei.com>
>>>>>
>>>>> For a system only have limited mirrored memory or some numa node 
>>>>> without
>>>>> mirrored memory, the per node vmemmap page_structs prefer to allocate
>>>>> memory from mirrored region, which will lead to vmemmap_verify() in
>>>>> vmemmap_populate_basepages() report lots of warning message.
>>>>>
>>>>> This patch demote the "potential offnode page_structs" warning 
>>>>> messages
>>>>> to debug level to avoid a very long print during bootup.
>>>>>
>>>>> Signed-off-by: Ma Wupeng <mawupeng1@huawei.com>
>>>>> ---
>>>>>    mm/sparse-vmemmap.c | 2 +-
>>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
>>>>> index f4fa61dbbee3..78debdb89eb1 100644
>>>>> --- a/mm/sparse-vmemmap.c
>>>>> +++ b/mm/sparse-vmemmap.c
>>>>> @@ -528,7 +528,7 @@ void __meminit vmemmap_verify(pte_t *pte, int 
>>>>> node,
>>>>>        int actual_node = early_pfn_to_nid(pfn);
>>>>>          if (node_distance(actual_node, node) > LOCAL_DISTANCE)
>>>>> -        pr_warn("[%lx-%lx] potential offnode page_structs\n",
>>>>> +        pr_debug("[%lx-%lx] potential offnode page_structs\n",
>>>>>                start, end - 1);
>>>>>    }
>>>>
>>>> This will possibly hide it in environments where this might indeed
>>>> indicate performance issues.
>>>>
>>>> What about a pr_warn_once()?
>>>>
>>>
>>> Sure.
>>>
>>> This will works. We can certainly use a pr_warn_once().
>>
>> Why not pr_warn_ratelimited() like in the previous patch ?
>
> Function vmemmap_populate_basepages() is used to populate base pages.
> System with huge memory will produce lots lots of warning message
> during this populate process even with ratelimited. This may lead to slow
> startup.

I think pr_warn_once is better, the memblock_alloc fallback is not frequent,

but vmemmap_verify will verify each memory and print a lot.

>
> Thanks for reviewing.
>
>> .
> .
