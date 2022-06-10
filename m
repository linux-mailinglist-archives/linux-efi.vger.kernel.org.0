Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FD06546659
	for <lists+linux-efi@lfdr.de>; Fri, 10 Jun 2022 14:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345148AbiFJMP0 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 10 Jun 2022 08:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242459AbiFJMP0 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 10 Jun 2022 08:15:26 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3948622DB65;
        Fri, 10 Jun 2022 05:15:21 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LKKcR3XT9zgYbl;
        Fri, 10 Jun 2022 20:13:27 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 10 Jun 2022 20:15:19 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 10 Jun 2022 20:15:17 +0800
Message-ID: <70bd99eb-a05d-adb0-5cb8-84dcc66b674e@huawei.com>
Date:   Fri, 10 Jun 2022 20:15:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3 6/6] efi: Disable mirror feature if kernelcore is not
 specified
Content-Language: en-US
To:     Ard Biesheuvel <ardb@kernel.org>, Wupeng Ma <mawupeng1@huawei.com>
CC:     Jonathan Corbet <corbet@lwn.net>, Will Deacon <will@kernel.org>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>, <songmuchun@bytedance.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        <damien.lemoal@opensource.wdc.com>,
        Stephen Boyd <swboyd@chromium.org>, <wei.liu@kernel.org>,
        <robin.murphy@arm.com>, <david@redhat.com>,
        <anshuman.khandual@arm.com>, <thunder.leizhen@huawei.com>,
        <gpiccoli@igalia.com>, <chenhuacai@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        <chenzhou10@huawei.com>, <vijayb@linux.microsoft.com>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-efi@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>,
        <linux-mm@kvack.org>, <linux-riscv@lists.infradead.org>
References: <20220607093805.1354256-1-mawupeng1@huawei.com>
 <20220607093805.1354256-7-mawupeng1@huawei.com>
 <CAMj1kXGMHn_jsMe2WxWZ-s_QV==1tc5k=xpbNXuDbGp0qF534w@mail.gmail.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <CAMj1kXGMHn_jsMe2WxWZ-s_QV==1tc5k=xpbNXuDbGp0qF534w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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


On 2022/6/10 19:20, Ard Biesheuvel wrote:
> On Tue, 7 Jun 2022 at 11:16, Wupeng Ma <mawupeng1@huawei.com> wrote:
>> From: Ma Wupeng <mawupeng1@huawei.com>
>>
>> If system have some mirrored memory and mirrored feature is not specified
>> in boot parameter, the basic mirrored feature will be enabled and this will
>> lead to the following situations:
>>
>> - memblock memory allocation prefers mirrored region. This may have some
>>    unexpected influence on numa affinity.
>>
>> - contiguous memory will be split into several parts if parts of them
>>    is mirrored memory via memblock_mark_mirror().
>>
>> To fix this, variable mirrored_kernelcore will be checked before calling
>> efi_find_mirror() which will enable basic mirrored feature and this
>> variable is true if kernelcore=mirror is added in the kernel parameters.
>>
>> Signed-off-by: Ma Wupeng <mawupeng1@huawei.com>
> This seems like the wrong place to do this. If mirrored memory is
> irrelevant to memblock, it should ignore the attribute. So I think
> this check belongs in mm/memblock.c instead.

Sound good,  let's add check into memblock_mark_mirror() and retain

the efi memory mirror information printing.

>
>
>> ---
>>   drivers/firmware/efi/efi.c | 3 +++
>>   include/linux/mm.h         | 2 ++
>>   mm/page_alloc.c            | 2 +-
>>   3 files changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
>> index 79c232e07de7..8a5edcb0dd82 100644
>> --- a/drivers/firmware/efi/efi.c
>> +++ b/drivers/firmware/efi/efi.c
>> @@ -454,6 +454,9 @@ void __init efi_find_mirror(void)
>>          if (!efi_enabled(EFI_MEMMAP))
>>                  return;
>>
>> +       if (!mirrored_kernelcore)
>> +               return;
>> +
>>          for_each_efi_memory_desc(md) {
>>                  unsigned long long start = md->phys_addr;
>>                  unsigned long long size = md->num_pages << EFI_PAGE_SHIFT;
>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>> index bc8f326be0ce..741ac7d022c3 100644
>> --- a/include/linux/mm.h
>> +++ b/include/linux/mm.h
>> @@ -2540,6 +2540,8 @@ extern void get_pfn_range_for_nid(unsigned int nid,
>>                          unsigned long *start_pfn, unsigned long *end_pfn);
>>   extern unsigned long find_min_pfn_with_active_regions(void);
>>
>> +extern bool mirrored_kernelcore;
>> +
>>   #ifndef CONFIG_NUMA
>>   static inline int early_pfn_to_nid(unsigned long pfn)
>>   {
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index e008a3df0485..cf6f70aba787 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -356,7 +356,7 @@ static unsigned long required_kernelcore_percent __initdata;
>>   static unsigned long required_movablecore __initdata;
>>   static unsigned long required_movablecore_percent __initdata;
>>   static unsigned long zone_movable_pfn[MAX_NUMNODES] __initdata;
>> -static bool mirrored_kernelcore __meminitdata;
>> +bool mirrored_kernelcore __meminitdata;
>>
>>   /* movable_zone is the "real" zone pages in ZONE_MOVABLE are taken from */
>>   int movable_zone;
>> --
>> 2.25.1
>>
> .
