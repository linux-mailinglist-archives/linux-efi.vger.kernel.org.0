Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4C15548EA2
	for <lists+linux-efi@lfdr.de>; Mon, 13 Jun 2022 18:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355358AbiFMLqq (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 13 Jun 2022 07:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356763AbiFMLpB (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 13 Jun 2022 07:45:01 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBB3D21276;
        Mon, 13 Jun 2022 03:51:12 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4LM7bq14W9z1K9Sb;
        Mon, 13 Jun 2022 18:49:11 +0800 (CST)
Received: from dggpemm500014.china.huawei.com (7.185.36.153) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 13 Jun 2022 18:50:47 +0800
Received: from [10.174.178.120] (10.174.178.120) by
 dggpemm500014.china.huawei.com (7.185.36.153) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 13 Jun 2022 18:50:45 +0800
Message-ID: <4e312b22-73ba-8d59-b494-b7cb1d7bbb49@huawei.com>
Date:   Mon, 13 Jun 2022 18:50:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
From:   mawupeng <mawupeng1@huawei.com>
Subject: Re: [PATCH v4 5/6] mm: Only remove nomap flag for initrd
To:     <ardb@kernel.org>, <will@kernel.org>, <catalin.marinas@arm.com>
CC:     <corbet@lwn.net>, <tglx@linutronix.de>, <mingo@redhat.com>,
        <bp@alien8.de>, <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        <hpa@zytor.com>, <dvhart@infradead.org>, <andy@infradead.org>,
        <rppt@kernel.org>, <akpm@linux-foundation.org>,
        <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <paulmck@kernel.org>,
        <keescook@chromium.org>, <songmuchun@bytedance.com>,
        <rdunlap@infradead.org>, <damien.lemoal@opensource.wdc.com>,
        <swboyd@chromium.org>, <wei.liu@kernel.org>,
        <robin.murphy@arm.com>, <david@redhat.com>,
        <anshuman.khandual@arm.com>, <thunder.leizhen@huawei.com>,
        <wangkefeng.wang@huawei.com>, <gpiccoli@igalia.com>,
        <chenhuacai@kernel.org>, <geert@linux-m68k.org>,
        <vijayb@linux.microsoft.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-efi@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>,
        <linux-mm@kvack.org>, <linux-riscv@lists.infradead.org>,
        <mawupeng1@huawei.com>
References: <20220613082147.183145-1-mawupeng1@huawei.com>
 <20220613082147.183145-6-mawupeng1@huawei.com>
 <CAMj1kXFn_FKt2jLJOntvT0FBtL9b=VWZdrBFpn48LBMDLy1WBQ@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAMj1kXFn_FKt2jLJOntvT0FBtL9b=VWZdrBFpn48LBMDLy1WBQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.120]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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



On 6/13/2022 5:42 PM, Ard Biesheuvel wrote:
> On Mon, 13 Jun 2022 at 10:00, Wupeng Ma <mawupeng1@huawei.com> wrote:
>>
>> From: Ma Wupeng <mawupeng1@huawei.com>
>>
>> Commit 177e15f0c144 ("arm64: add the initrd region to the linear mapping explicitly")
>> remove all the flags of the memory used by initrd. This is fine since
>> MEMBLOCK_MIRROR is not used in arm64.
>>
>> However with mirrored feature introduced to arm64, this will clear the mirrored
>> flag used by initrd, which will lead to error log printed by
>> find_zone_movable_pfns_for_nodes() if the lower 4G range has some non-mirrored
>> memory.
>>
>> To solve this problem, only MEMBLOCK_NOMAP flag will be removed via
>> memblock_clear_nomap().
>>
>> Signed-off-by: Ma Wupeng <mawupeng1@huawei.com>
> 
> Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
> 
> This needs and ack from the arm64 maintainers, please?
> And also please fix the subject to include 'arm64'
> 

Ok, I will include 'arm64' in my subject in v5.

Thanks for reviewing.

> 
>> ---
>>  arch/arm64/mm/init.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
>> index 339ee84e5a61..8456dbae9441 100644
>> --- a/arch/arm64/mm/init.c
>> +++ b/arch/arm64/mm/init.c
>> @@ -350,8 +350,8 @@ void __init arm64_memblock_init(void)
>>                         "initrd not fully accessible via the linear mapping -- please check your bootloader ...\n")) {
>>                         phys_initrd_size = 0;
>>                 } else {
>> -                       memblock_remove(base, size); /* clear MEMBLOCK_ flags */
>>                         memblock_add(base, size);
>> +                       memblock_clear_nomap(base, size);
>>                         memblock_reserve(base, size);
>>                 }
>>         }
>> --
>> 2.25.1
>>
> .
