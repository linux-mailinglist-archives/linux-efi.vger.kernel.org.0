Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55D6A4EA482
	for <lists+linux-efi@lfdr.de>; Tue, 29 Mar 2022 03:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbiC2BQj (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 28 Mar 2022 21:16:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiC2BQi (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 28 Mar 2022 21:16:38 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A4828A31D;
        Mon, 28 Mar 2022 18:14:55 -0700 (PDT)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4KSBMb1hj4z9smf;
        Tue, 29 Mar 2022 09:10:51 +0800 (CST)
Received: from dggpemm500014.china.huawei.com (7.185.36.153) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 29 Mar 2022 09:14:53 +0800
Received: from [10.174.178.120] (10.174.178.120) by
 dggpemm500014.china.huawei.com (7.185.36.153) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.21; Tue, 29 Mar 2022 09:14:51 +0800
Message-ID: <931b1e5a-de85-f172-a834-1496bc45535e@huawei.com>
Date:   Tue, 29 Mar 2022 09:14:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 7/9] mm: Calc the right pfn if page size is not 4K
To:     <david@redhat.com>, <akpm@linux-foundation.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>, <corbet@lwn.net>
CC:     <ardb@kernel.org>, <tglx@linutronix.de>, <mingo@redhat.com>,
        <bp@alien8.de>, <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        <hpa@zyccr.com>, <dvhart@infradead.org>, <andy@infradead.org>,
        <rppt@kernel.org>, <paulmck@kernel.org>, <peterz@infradead.org>,
        <jroedel@suse.de>, <songmuchun@bytedance.com>, <macro@orcam.me.uk>,
        <frederic@kernel.org>, <W_Armin@gmx.de>, <john.garry@huawei.com>,
        <seanjc@google.com>, <tsbogend@alpha.franken.de>,
        <anshuman.khandual@arm.com>, <chenhuacai@kernel.org>,
        <gpiccoli@igalia.com>, <mark.rutland@arm.com>,
        <wangkefeng.wang@huawei.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-efi@vger.kernel.org>, <linux-ia64@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>, <linux-mm@kvack.org>
References: <20220326064632.131637-1-mawupeng1@huawei.com>
 <20220326064632.131637-8-mawupeng1@huawei.com>
 <15e3f11b-1551-a9c2-c348-bbe1ae1d9ef7@redhat.com>
From:   mawupeng <mawupeng1@huawei.com>
In-Reply-To: <15e3f11b-1551-a9c2-c348-bbe1ae1d9ef7@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.120]
X-ClientProxiedBy: dggeme708-chm.china.huawei.com (10.1.199.104) To
 dggpemm500014.china.huawei.com (7.185.36.153)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



在 2022/3/28 20:33, David Hildenbrand 写道:
> On 26.03.22 07:46, Wupeng Ma wrote:
>> From: Ma Wupeng <mawupeng1@huawei.com>
>>
>> Pervious 0x100000 is used to check the 4G limit in
> 
> s/Pervious/Previous/
> 
>> find_zone_movable_pfns_for_nodes(). This is right in x86 because
>> the page size can only be 4K. But 16K and 64K are available in
>> arm64. So replate it with SIZE_4G >> PAGE_SHIFT.
> 
> s/replate/replace/
> 
>>
>> Signed-off-by: Ma Wupeng <mawupeng1@huawei.com>
>> ---
>>   mm/page_alloc.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index 6e0b4596cde9..41fd987b5b93 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -7811,7 +7811,7 @@ static void __init find_zone_movable_pfns_for_nodes(void)
>>   
>>   			usable_startpfn = memblock_region_memory_base_pfn(r);
>>   
>> -			if (usable_startpfn < 0x100000) {
>> +			if (usable_startpfn < (SZ_4G >> PAGE_SHIFT)) {
> 
> PHYS_PFN(SZ_4G)
> 
> ?
> 
Thanks for reviewing, will be fixed in the next version.

Thanks.
>>   				mem_below_4gb_not_mirrored = true;
>>   				continue;
>>   			}
> 
> 
