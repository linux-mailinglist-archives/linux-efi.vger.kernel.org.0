Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41A715F9CB6
	for <lists+linux-efi@lfdr.de>; Mon, 10 Oct 2022 12:24:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231906AbiJJKYO (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 10 Oct 2022 06:24:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231886AbiJJKYO (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 10 Oct 2022 06:24:14 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 015E953006;
        Mon, 10 Oct 2022 03:24:11 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MmFJn6CRWzmVCc;
        Mon, 10 Oct 2022 18:19:37 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 10 Oct 2022 18:24:10 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 10 Oct 2022 18:24:09 +0800
Message-ID: <b703f99f-bf7b-d8ce-d92a-5c8b4c481d02@huawei.com>
Date:   Mon, 10 Oct 2022 18:24:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2] efi/arm: dump UEFI runtime page tables for ARM
Content-Language: en-US
To:     Ard Biesheuvel <ardb@kernel.org>
CC:     Russell King <linux@armlinux.org.uk>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>
References: <20220930101024.118394-1-wangkefeng.wang@huawei.com>
 <28b5713f-6379-ef36-5139-6c3f0cbf27e8@huawei.com>
 <CAMj1kXEHQLxNR2ADR1A2CHHA3M8CWUnKrKWCMSBNnZOTvZasZg@mail.gmail.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <CAMj1kXEHQLxNR2ADR1A2CHHA3M8CWUnKrKWCMSBNnZOTvZasZg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


On 2022/10/10 17:47, Ard Biesheuvel wrote:
> On Sat, 8 Oct 2022 at 08:37, Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
>> Sorry, forget to Cc Ard and efi maillist, do it now.
>>
>> On 2022/9/30 18:10, Kefeng Wang wrote:
>>> UEFI runtime page tables dump only for ARM64 at present,
>>> but ARM support EFI and ARM_PTDUMP_DEBUGFS now. Since
>>> ARM could potentially execute with a 1G/3G user/kernel
>>> split, choosing 1G as the upper limit for UEFI runtime
>>> end, with this, we could enable UEFI runtime page tables.
>>>
>>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>>> ---
>>> v2: update upper limit for ARM, only build test due to
>>>       my qemu without UEFI boot support.
> Tested-by: Ard Biesheuvel <ardb@kernel.org>
> Acked-by: Ard Biesheuvel <ardb@kernel.org>
>
Many thanks：）
>
>
> / # cat /sys/kernel/debug/efi_page_tables
> ---[ UEFI runtime start ]---
> 0x20005000-0x20112000        1076K PTE KERNEL      RW NX SHD MEM/CACHED/WBWA
> 0x20112000-0x20114000           8K PTE KERNEL      ro x  SHD MEM/CACHED/WBWA
> 0x20114000-0x20117000          12K PTE KERNEL      RW NX SHD MEM/CACHED/WBWA
> 0x20117000-0x20118000           4K PTE KERNEL      ro x  SHD MEM/CACHED/WBWA
> 0x20118000-0x2011b000          12K PTE KERNEL      RW NX SHD MEM/CACHED/WBWA
> 0x2011b000-0x2011c000           4K PTE KERNEL      ro x  SHD MEM/CACHED/WBWA
> 0x2011c000-0x2011f000          12K PTE KERNEL      RW NX SHD MEM/CACHED/WBWA
> 0x2011f000-0x2017c000         372K PTE KERNEL      ro x  SHD MEM/CACHED/WBWA
> 0x2017c000-0x20183000          28K PTE KERNEL      RW NX SHD MEM/CACHED/WBWA
> 0x20183000-0x20186000          12K PTE KERNEL      ro x  SHD MEM/CACHED/WBWA
> 0x20186000-0x20189000          12K PTE KERNEL      RW NX SHD MEM/CACHED/WBWA
> 0x20189000-0x2018a000           4K PTE KERNEL      ro x  SHD MEM/CACHED/WBWA
> 0x2018a000-0x2018d000          12K PTE KERNEL      RW NX SHD MEM/CACHED/WBWA
> 0x2018d000-0x2018e000           4K PTE KERNEL      ro x  SHD MEM/CACHED/WBWA
> 0x2018e000-0x20191000          12K PTE KERNEL      RW NX SHD MEM/CACHED/WBWA
> 0x20191000-0x20193000           8K PTE KERNEL      ro x  SHD MEM/CACHED/WBWA
> 0x20193000-0x20195000           8K PTE KERNEL      RW NX SHD MEM/CACHED/WBWA
> 0x201a5000-0x203fd000        2400K PTE KERNEL      RW x  SHD MEM/CACHED/WBWA
> 0x20400000-0x24400000          64M PGD IO          RW NX SHD
> 0x24400000-0x24401000           4K PTE IO          RW NX SHD DEV/SHARED
> ---[ UEFI runtime end ]---
>
>>>    arch/arm/include/asm/ptdump.h      | 1 +
>>>    arch/arm64/include/asm/ptdump.h    | 1 +
>>>    drivers/firmware/efi/arm-runtime.c | 4 ++--
>>>    3 files changed, 4 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/arch/arm/include/asm/ptdump.h b/arch/arm/include/asm/ptdump.h
>>> index 0c2d3d0d4cc6..aad1d034136c 100644
>>> --- a/arch/arm/include/asm/ptdump.h
>>> +++ b/arch/arm/include/asm/ptdump.h
>>> @@ -21,6 +21,7 @@ struct ptdump_info {
>>>
>>>    void ptdump_walk_pgd(struct seq_file *s, struct ptdump_info *info);
>>>    #ifdef CONFIG_ARM_PTDUMP_DEBUGFS
>>> +#define EFI_RUNTIME_MAP_END  SZ_1G
>>>    void ptdump_debugfs_register(struct ptdump_info *info, const char *name);
>>>    #else
>>>    static inline void ptdump_debugfs_register(struct ptdump_info *info,
>>> diff --git a/arch/arm64/include/asm/ptdump.h b/arch/arm64/include/asm/ptdump.h
>>> index b1dd7ecff7ef..581caac525b0 100644
>>> --- a/arch/arm64/include/asm/ptdump.h
>>> +++ b/arch/arm64/include/asm/ptdump.h
>>> @@ -23,6 +23,7 @@ struct ptdump_info {
>>>
>>>    void ptdump_walk(struct seq_file *s, struct ptdump_info *info);
>>>    #ifdef CONFIG_PTDUMP_DEBUGFS
>>> +#define EFI_RUNTIME_MAP_END  DEFAULT_MAP_WINDOW_64
>>>    void __init ptdump_debugfs_register(struct ptdump_info *info, const char *name);
>>>    #else
>>>    static inline void ptdump_debugfs_register(struct ptdump_info *info,
>>> diff --git a/drivers/firmware/efi/arm-runtime.c b/drivers/firmware/efi/arm-runtime.c
>>> index 3359ae2adf24..8f8ae479061b 100644
>>> --- a/drivers/firmware/efi/arm-runtime.c
>>> +++ b/drivers/firmware/efi/arm-runtime.c
>>> @@ -25,14 +25,14 @@
>>>    #include <asm/mmu.h>
>>>    #include <asm/pgalloc.h>
>>>
>>> -#if defined(CONFIG_PTDUMP_DEBUGFS) && defined(CONFIG_ARM64)
>>> +#if defined(CONFIG_PTDUMP_DEBUGFS) || defined(CONFIG_ARM_PTDUMP_DEBUGFS)
>>>    #include <asm/ptdump.h>
>>>
>>>    static struct ptdump_info efi_ptdump_info = {
>>>        .mm             = &efi_mm,
>>>        .markers        = (struct addr_marker[]){
>>>                { 0,                            "UEFI runtime start" },
>>> -             { DEFAULT_MAP_WINDOW_64,        "UEFI runtime end" },
>>> +             { EFI_RUNTIME_MAP_END,          "UEFI runtime end" },
>>>                { -1,                           NULL }
>>>        },
>>>        .base_addr      = 0,
> .
