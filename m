Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04BE654637B
	for <lists+linux-efi@lfdr.de>; Fri, 10 Jun 2022 12:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238600AbiFJKYn (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 10 Jun 2022 06:24:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245446AbiFJKYl (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 10 Jun 2022 06:24:41 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79E7027C;
        Fri, 10 Jun 2022 03:24:39 -0700 (PDT)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LKH9j4GNGzjXTF;
        Fri, 10 Jun 2022 18:23:37 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 10 Jun 2022 18:24:37 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 10 Jun 2022 18:24:35 +0800
Message-ID: <174f988c-ea14-9f10-40e1-7bdddcef5d35@huawei.com>
Date:   Fri, 10 Jun 2022 18:24:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3 2/6] arm64/mirror: arm64 enabling - find mirrored
 memory ranges
Content-Language: en-US
To:     Ard Biesheuvel <ardb@kernel.org>
CC:     Wupeng Ma <mawupeng1@huawei.com>, Jonathan Corbet <corbet@lwn.net>,
        "Will Deacon" <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "Borislav Petkov" <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>, <songmuchun@bytedance.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        <damien.lemoal@opensource.wdc.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Wei Liu <wei.liu@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        David Hildenbrand <david@redhat.com>,
        "Anshuman Khandual" <anshuman.khandual@arm.com>,
        Zhen Lei <thunder.leizhen@huawei.com>, <gpiccoli@igalia.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        "Geert Uytterhoeven" <geert@linux-m68k.org>,
        <vijayb@linux.microsoft.com>,
        "Linux Doc Mailing List" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>,
        "Linux Memory Management List" <linux-mm@kvack.org>,
        linux-riscv <linux-riscv@lists.infradead.org>
References: <20220607093805.1354256-1-mawupeng1@huawei.com>
 <20220607093805.1354256-3-mawupeng1@huawei.com>
 <bfa0b919-fbc1-056c-4ed9-e940edfb6125@huawei.com>
 <CAMj1kXGku3Y5d6Z+AAFkEauMWFY6LYpQAybqkXiQdRCMpS5tbw@mail.gmail.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <CAMj1kXGku3Y5d6Z+AAFkEauMWFY6LYpQAybqkXiQdRCMpS5tbw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
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


On 2022/6/10 17:34, Ard Biesheuvel wrote:
> On Fri, 10 Jun 2022 at 11:27, Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
>>
>> On 2022/6/7 17:38, Wupeng Ma wrote:
>>> From: Ma Wupeng <mawupeng1@huawei.com>
>>>
>>> Commit b05b9f5f9dcf ("x86, mirror: x86 enabling - find mirrored memory ranges")
>>> introduced mirrored memory support for x86 and this could be used on arm64.
>>>
>>> Since we only support this feature on arm64, efi_find_mirror() won't be placed
>>> into efi_init(), which is used by riscv/arm/arm64, it is added in setup_arch()
>>> to scan the memory map and mark mirrored memory in memblock.
>> Move into efi_init() looks better, it won't bring negative effects on
>> arm/riscv.
>>
>> but let's maintainer to make a decision.
>>
>> Reviewed-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>>
> I don't disagree with that in principle, but x86 calls the efi fake
> memmap stuff between efi_init() and efi_find_mirror(), and I already
> indicated that I don't want to enable fake memmap on !X86.

I mean move into efi_init() in drivers/firmware/efi/efi-init.c which 
only used

in arm32/arm64/riscv.

>
> But I do think there is some room for improvement here: we could move
> things like efi_mokvar_table_init() and efi_esrt_init() into
> efi_init() as well, and make efi_fake_memmap() do nothing on !X86 so
> we can move it into efi_init() too.

x86 has own efi_init() in arch/x86/platform/efi/efi.c, it seams that all 
the above

function could move into x86's own efi_init(), not sure, but we could do 
it later

if it possible.

>
>>> Signed-off-by: Ma Wupeng <mawupeng1@huawei.com>
>>> ---
>>>    Documentation/admin-guide/kernel-parameters.txt | 2 +-
>>>    arch/arm64/kernel/setup.c                       | 1 +
>>>    2 files changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>>> index 8090130b544b..e3537646b6f7 100644
>>> --- a/Documentation/admin-guide/kernel-parameters.txt
>>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>>> @@ -2301,7 +2301,7 @@
>>>
>>>        keepinitrd      [HW,ARM]
>>>
>>> -     kernelcore=     [KNL,X86,IA-64,PPC]
>>> +     kernelcore=     [KNL,X86,IA-64,PPC,ARM64]
>>>                        Format: nn[KMGTPE] | nn% | "mirror"
>>>                        This parameter specifies the amount of memory usable by
>>>                        the kernel for non-movable allocations.  The requested
>>> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
>>> index cf3a759f10d4..6e9acd7ecf0f 100644
>>> --- a/arch/arm64/kernel/setup.c
>>> +++ b/arch/arm64/kernel/setup.c
>>> @@ -328,6 +328,7 @@ void __init __no_sanitize_address setup_arch(char **cmdline_p)
>>>
>>>        xen_early_init();
>>>        efi_init();
>>> +     efi_find_mirror();
>>>
>>>        if (!efi_enabled(EFI_BOOT) && ((u64)_text % MIN_KIMG_ALIGN) != 0)
>>>             pr_warn(FW_BUG "Kernel image misaligned at boot, please fix your bootloader!");
> .
