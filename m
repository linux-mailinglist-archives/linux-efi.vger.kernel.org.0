Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE6574EABDE
	for <lists+linux-efi@lfdr.de>; Tue, 29 Mar 2022 13:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235515AbiC2LF0 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 29 Mar 2022 07:05:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231437AbiC2LFZ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 29 Mar 2022 07:05:25 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33F071A82E;
        Tue, 29 Mar 2022 04:03:39 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4KSRWF10D9z1GD1m;
        Tue, 29 Mar 2022 19:03:21 +0800 (CST)
Received: from dggpemm500014.china.huawei.com (7.185.36.153) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 29 Mar 2022 19:03:37 +0800
Received: from [10.174.178.120] (10.174.178.120) by
 dggpemm500014.china.huawei.com (7.185.36.153) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.21; Tue, 29 Mar 2022 19:03:35 +0800
Message-ID: <4136ec1c-51a9-3874-9bf3-c81cd88e868a@huawei.com>
Date:   Tue, 29 Mar 2022 19:03:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 0/9] introduce mirrored memory support for arm64
To:     <ardb@kernel.org>
CC:     <akpm@linux-foundation.org>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <corbet@lwn.net>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
        <x86@kernel.org>, <hpa@zyccr.com>, <dvhart@infradead.org>,
        <andy@infradead.org>, <rppt@kernel.org>, <paulmck@kernel.org>,
        <peterz@infradead.org>, <jroedel@suse.de>,
        <songmuchun@bytedance.com>, <macro@orcam.me.uk>,
        <frederic@kernel.org>, <W_Armin@gmx.de>, <john.garry@huawei.com>,
        <seanjc@google.com>, <tsbogend@alpha.franken.de>,
        <anshuman.khandual@arm.com>, <chenhuacai@kernel.org>,
        <david@redhat.com>, <gpiccoli@igalia.com>, <mark.rutland@arm.com>,
        <wangkefeng.wang@huawei.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-efi@vger.kernel.org>, <linux-ia64@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>, <linux-mm@kvack.org>
References: <20220326064632.131637-1-mawupeng1@huawei.com>
 <CAMj1kXEwzJE8V-tqJJwZ-RqHB3atKJvoRZ8C6_EVM7caNbttxw@mail.gmail.com>
From:   mawupeng <mawupeng1@huawei.com>
In-Reply-To: <CAMj1kXEwzJE8V-tqJJwZ-RqHB3atKJvoRZ8C6_EVM7caNbttxw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.120]
X-ClientProxiedBy: dggeme706-chm.china.huawei.com (10.1.199.102) To
 dggpemm500014.china.huawei.com (7.185.36.153)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



在 2022/3/29 16:26, Ard Biesheuvel 写道:
> On Sat, 26 Mar 2022 at 07:27, Wupeng Ma <mawupeng1@huawei.com> wrote:
>>
>> From: Ma Wupeng <mawupeng1@huawei.com>
>>
>> Commit b05b9f5f9dcf ("x86, mirror: x86 enabling - find mirrored memory ranges")
>> introduced mirrored memory support for x86. This support rely on UEFI to
>> report mirrored memory address ranges.  See UEFI 2.5 spec pages 157-158:
>>
>>    http://www.uefi.org/sites/default/files/resources/UEFI%202_5.pdf
>>
>> Arm64 can support this too. So mirrored memory support is added to support
>> arm64.
>>
> 
> What is the point of this if the kernel itself is not loaded in
> EFI_MORE_RELIABLE memory? On x86, this is handled by the decompressor,
> but that does not exist on arm64.

Do you mean this is x86, commit c05cd79750fb
("x86/boot/KASLR: Prefer mirrored memory regions for the kernel physical address").
This scenario is not considered.

>  
> The problem here is that UEFI defines this as a memory *attribute*
> rather than a memory *type*, which means you cannot allocate
> EFI_MORE_RELIABLE memory easily: you have to iterate over the memory
> map and look for regions with the desired attribute, and allocate
> those pages explicitly. I'd prefer to implement this in the
> bootloader, and only add minimal logic to the stub to respect the
> placement of the kernel by the loader if the loader signals it to do
> so (there are other reasons for this - I will cc you on a patch
> shortly that implements this)

Thanks for your incoming patch.

> 
> This also means that the fake_mem stuff is not going to work: the
> memory map observed by the stub comes straight from the firmware, and
> if the stub needs to be involved in placing (or respecting the
> placement by the loader of) the kernel image, it needs to observe
> those EFI_MORE_RELIABLE regions too. If you don't have access to a
> machine that actually exposes EFI_MORE_RELIABLE memory, I suggest you
> prototype it in QEMU/edk2 instead.

You are right fake_mem stuff is not going to work. But, efi_fake_mem is
used for testing mirrored features and will not be used in production
environment. This test features can fake memory's attribute values.

The reason why efi_fake_mem support is put first is that memory's attribute
is reported by BIOS which is hard to simulate. With this support, any arm64
machines with efi support can easily test mirrored features.

> 
> In fact, we have been trying very hard not to touch the firmware
> provided memory map at all on ARM, rather than use it as a scratchpad
> for all kinds of annotations. This means, for instance, that kexec is
> idempotent - the next kernel should not be affected by modifications
> to the memory map applied by the previous kernel.

Yes, you're absolutely right. Efi_fake_mem is incompatible with kdump which
will use kexec. But we can remove specify cmdline(efi_fake_mem=xx) by
modofing /etc/sysconfig/kdump. Efi_fake_mem is only used for testing and
will not be used in production environment.

> 
> In summary, implementing kernelcore=mirror for arm64 is fine with me,
> but there are some issues we need to address first.
>
Can you be clear what the issues are?

The main purpose of this patchset is to introduce mirrored support for
arm64 and we have already fixed the problems we had which is shown in
patch #5 to patch #7 and try to bring total isolation in patch #8 which
will disable mirror feature if kernelcore is not specified.

Thanks for reviewing.

> 
> 
> 
>> Patch #1-#2 introduce efi_fake_mem support for arm64.
>> Patch #3-#4 introduce mirrored memory support form arm64.
>> Patch #5-#7 fix some bugs for arm64 if memory reliable is enabled.
>> Patch #8 disable mirror feature if kernelcore is not specified.
>> Patch #9 remove some redundant code in ia64 efi_init.
>>
>> Ma Wupeng (9):
>>    efi: Make efi_print_memmap() public
>>    arm64: efi: Add fake memory support
>>    efi: Make efi_find_mirror() public
>>    arm64/mirror: arm64 enabling - find mirrored memory ranges
>>    mm: Ratelimited mirrored memory related warning messages
>>    mm: Demote warning message in vmemmap_verify() to debug level
>>    mm: Calc the right pfn if page size is not 4K
>>    efi: Disable mirror feature if kernelcore is not specified
>>    ia64/efi: Code simplification in efi_init
>>
>>   .../admin-guide/kernel-parameters.txt         |  4 +-
>>   arch/arm64/kernel/setup.c                     |  3 ++
>>   arch/ia64/kernel/efi.c                        | 37 +-----------------
>>   arch/x86/include/asm/efi.h                    |  5 ---
>>   arch/x86/platform/efi/efi.c                   | 39 -------------------
>>   drivers/firmware/efi/Kconfig                  |  2 +-
>>   drivers/firmware/efi/efi.c                    | 26 +++++++++++++
>>   drivers/firmware/efi/memmap.c                 | 16 ++++++++
>>   include/linux/efi.h                           |  4 ++
>>   include/linux/mm.h                            |  2 +
>>   mm/memblock.c                                 |  4 +-
>>   mm/page_alloc.c                               |  4 +-
>>   mm/sparse-vmemmap.c                           |  2 +-
>>   13 files changed, 60 insertions(+), 88 deletions(-)
>>
>> --
>> 2.18.0.huawei.25
>>
> .
