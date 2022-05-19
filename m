Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3428C52D12E
	for <lists+linux-efi@lfdr.de>; Thu, 19 May 2022 13:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237307AbiESLJ1 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 19 May 2022 07:09:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237168AbiESLJY (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 19 May 2022 07:09:24 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD0DFB0429;
        Thu, 19 May 2022 04:09:22 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4L3nCd4PfdzjWwl;
        Thu, 19 May 2022 19:08:29 +0800 (CST)
Received: from dggpemm500014.china.huawei.com (7.185.36.153) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 19 May 2022 19:09:20 +0800
Received: from [10.174.178.120] (10.174.178.120) by
 dggpemm500014.china.huawei.com (7.185.36.153) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 19 May 2022 19:09:19 +0800
Message-ID: <7058b8d8-c0cb-108e-0db9-2fdf5fb154cf@huawei.com>
Date:   Thu, 19 May 2022 19:09:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 0/2] Add support to relocate kernel image to mirrored
 region
To:     <ardb@kernel.org>
CC:     <akpm@linux-foundation.org>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <corbet@lwn.net>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
        <x86@kernel.org>, <dvhart@infradead.org>, <andy@infradead.org>,
        <rppt@kernel.org>, <paulmck@kernel.org>, <peterz@infradead.org>,
        <jroedel@suse.de>, <songmuchun@bytedance.com>, <macro@orcam.me.uk>,
        <frederic@kernel.org>, <W_Armin@gmx.de>, <john.garry@huawei.com>,
        <seanjc@google.com>, <tsbogend@alpha.franken.de>,
        <anshuman.khandual@arm.com>, <chenhuacai@kernel.org>,
        <david@redhat.com>, <gpiccoli@igalia.com>, <mark.rutland@arm.com>,
        <wangkefeng.wang@huawei.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-efi@vger.kernel.org>, <linux-ia64@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>, <linux-mm@kvack.org>,
        <mawupeng1@huawei.com>
References: <CAMj1kXGSStDgj9ABmUaTLnBmpQFksh3wx4tx=mJohum4GQe3Gg@mail.gmail.com>
 <20220419070150.254377-1-mawupeng1@huawei.com>
 <CAMj1kXHr2RdYSPor1st1ZnL=O42c8N6e=bNG+eFhatfefWLUrw@mail.gmail.com>
 <c65d22b4-f654-21aa-bd5f-d4f8b0939a25@huawei.com>
From:   mawupeng <mawupeng1@huawei.com>
In-Reply-To: <c65d22b4-f654-21aa-bd5f-d4f8b0939a25@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.120]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500014.china.huawei.com (7.185.36.153)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



在 2022/5/7 17:28, mawupeng 写道:
> 
> 
> 在 2022/5/3 17:58, Ard Biesheuvel 写道:
>> On Tue, 19 Apr 2022 at 08:43, Wupeng Ma <mawupeng1@huawei.com> wrote:
>>>
>>> From: Ma Wupeng <mawupeng1@huawei.com>
>>>
>>> Now system image will perfer to be located to mirrored regions both KASLR
>>> on and off.
>>>
>>
>> Hello Ma Wupeng,
>>
>> I wonder if we could simplify this as follows:
>> - ignore the non-KASLR case for now, and rely on the bootloader  > load the image into mirrored memory if it exists;
> 
> In grub, memory for static image is allocated via the following path:
> 
> grub_cmd_linux
>    kernel = grub_malloc(filelen)
>    kernel_alloc_addr = grub_efi_allocate_any_pages (kernel_alloc_pages)
>    grub_memcpy (kernel_addr, kernel, grub_min(filelen, kernel_size))
>     grub_loader_set (grub_linux_boot, grub_linux_unload, 0)
> 
> Can we get memory from mirrored region by the following steps:
> 1. get memory map by calling grub_efi_get_memory_map()
> 2. iter all memory map to find a suitable mirrored memory area
> 3. locate kernel image to this area
> 
> So, if kaslr is not enabled
>   - grub will load kernel into mirrored region
> else
>   - arm64-stub.c will relocate kernel image to mirrored region
> 
> Is this feasible?

Is this a feasible proposal to relocate the static kernel image itself
into more reliable memory?

> 
>> - simplify the KASLR case to the below.
> 
> Yes, we can certainly do this. I will remove my code and use yours.
> 
>>
>> I think this is reasonable, because it means we take mirrored memory
>> into account when we decide to move the image anyway, but expect the
>> boot chain to take care of this if there is no need to move the image.
>>
>> -------------8<------------------
>> --- a/drivers/firmware/efi/libstub/randomalloc.c
>> +++ b/drivers/firmware/efi/libstub/randomalloc.c
>> @@ -56,6 +56,7 @@ efi_status_t efi_random_alloc(unsigned long size,
>>                                unsigned long random_seed)
>>   {
>>          unsigned long map_size, desc_size, total_slots = 0, target_slot;
>> +       unsigned long total_mirrored_slots = 0;
>>          unsigned long buff_size;
>>          efi_status_t status;
>>          efi_memory_desc_t *memory_map;
>> @@ -86,8 +87,14 @@ efi_status_t efi_random_alloc(unsigned long size,
>>                  slots = get_entry_num_slots(md, size, ilog2(align));
>>                  MD_NUM_SLOTS(md) = slots;
>>                  total_slots += slots;
>> +               if (md->attribute & EFI_MEMORY_MORE_RELIABLE)
>> +                       total_mirrored_slots += slots;
>>          }
>>
>> +       /* only consider mirrored slots for randomization if any exist */
>> +       if (total_mirrored_slots > 0)
>> +               total_slots = total_mirrored_slots;
>> +
>>          /* find a random number between 0 and total_slots */
>>          target_slot = (total_slots * (u64)(random_seed & U32_MAX)) >> 32;
>>
>> @@ -107,6 +114,10 @@ efi_status_t efi_random_alloc(unsigned long size,
>>                  efi_physical_addr_t target;
>>                  unsigned long pages;
>>
>> +               if (total_mirrored_slots > 0 &&
>> +                   !(md->attribute & EFI_MEMORY_MORE_RELIABLE))
>> +                       continue;
>> +
>>                  if (target_slot >= MD_NUM_SLOTS(md)) {
>>                          target_slot -= MD_NUM_SLOTS(md);
>>                          continue;
>> .
