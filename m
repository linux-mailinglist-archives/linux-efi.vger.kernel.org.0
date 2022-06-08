Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A524D542CDF
	for <lists+linux-efi@lfdr.de>; Wed,  8 Jun 2022 12:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236421AbiFHKO4 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 8 Jun 2022 06:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236622AbiFHKNb (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 8 Jun 2022 06:13:31 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D603322C8A0;
        Wed,  8 Jun 2022 03:00:42 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 60F83143D;
        Wed,  8 Jun 2022 03:00:42 -0700 (PDT)
Received: from [10.162.41.25] (unknown [10.162.41.25])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1EA093F73B;
        Wed,  8 Jun 2022 03:00:29 -0700 (PDT)
Message-ID: <1f2a76d5-7c4e-46bc-ce66-20a962eac73c@arm.com>
Date:   Wed, 8 Jun 2022 15:30:26 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3 4/6] mm: Demote warning message in vmemmap_verify() to
 debug level
Content-Language: en-US
To:     mawupeng <mawupeng1@huawei.com>, david@redhat.com, corbet@lwn.net,
        will@kernel.org, ardb@kernel.org, catalin.marinas@arm.com
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        dvhart@infradead.org, andy@infradead.org, rppt@kernel.org,
        akpm@linux-foundation.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, paulmck@kernel.org,
        keescook@chromium.org, songmuchun@bytedance.com,
        rdunlap@infradead.org, damien.lemoal@opensource.wdc.com,
        swboyd@chromium.org, wei.liu@kernel.org, robin.murphy@arm.com,
        thunder.leizhen@huawei.com, wangkefeng.wang@huawei.com,
        gpiccoli@igalia.com, chenhuacai@kernel.org, geert@linux-m68k.org,
        vijayb@linux.microsoft.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-mm@kvack.org, linux-riscv@lists.infradead.org
References: <20220607093805.1354256-1-mawupeng1@huawei.com>
 <20220607093805.1354256-5-mawupeng1@huawei.com>
 <b1975f44-2552-a03c-bb6f-1452f1fd99c0@redhat.com>
 <a820f287-e879-6183-a917-6a577b6160ab@huawei.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <a820f287-e879-6183-a917-6a577b6160ab@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 6/8/22 06:56, mawupeng wrote:
> 
> 
> 在 2022/6/7 20:25, David Hildenbrand 写道:
>> On 07.06.22 11:38, Wupeng Ma wrote:
>>> From: Ma Wupeng <mawupeng1@huawei.com>
>>>
>>> For a system only have limited mirrored memory or some numa node without
>>> mirrored memory, the per node vmemmap page_structs prefer to allocate
>>> memory from mirrored region, which will lead to vmemmap_verify() in
>>> vmemmap_populate_basepages() report lots of warning message.
>>>
>>> This patch demote the "potential offnode page_structs" warning messages
>>> to debug level to avoid a very long print during bootup.
>>>
>>> Signed-off-by: Ma Wupeng <mawupeng1@huawei.com>
>>> ---
>>>   mm/sparse-vmemmap.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
>>> index f4fa61dbbee3..78debdb89eb1 100644
>>> --- a/mm/sparse-vmemmap.c
>>> +++ b/mm/sparse-vmemmap.c
>>> @@ -528,7 +528,7 @@ void __meminit vmemmap_verify(pte_t *pte, int node,
>>>       int actual_node = early_pfn_to_nid(pfn);
>>>         if (node_distance(actual_node, node) > LOCAL_DISTANCE)
>>> -        pr_warn("[%lx-%lx] potential offnode page_structs\n",
>>> +        pr_debug("[%lx-%lx] potential offnode page_structs\n",
>>>               start, end - 1);
>>>   }
>>>   
>>
>> This will possibly hide it in environments where this might indeed
>> indicate performance issues.
>>
>> What about a pr_warn_once()?
>>
> 
> Sure.
> 
> This will works. We can certainly use a pr_warn_once().

Why not pr_warn_ratelimited() like in the previous patch ?
