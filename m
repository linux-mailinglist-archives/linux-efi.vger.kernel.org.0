Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D3C1507EB4
	for <lists+linux-efi@lfdr.de>; Wed, 20 Apr 2022 04:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358829AbiDTCQ3 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 19 Apr 2022 22:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbiDTCQ2 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 19 Apr 2022 22:16:28 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90B50289BC;
        Tue, 19 Apr 2022 19:13:43 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Kjkjr0kH9zhXYf;
        Wed, 20 Apr 2022 10:13:36 +0800 (CST)
Received: from dggpemm500014.china.huawei.com (7.185.36.153) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 20 Apr 2022 10:13:41 +0800
Received: from [10.174.178.120] (10.174.178.120) by
 dggpemm500014.china.huawei.com (7.185.36.153) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 20 Apr 2022 10:13:40 +0800
Message-ID: <b2864968-3cc7-dba3-5361-d8ee4cc3482a@huawei.com>
Date:   Wed, 20 Apr 2022 10:13:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v2 0/9] introduce mirrored memory support for arm64
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
        <platform-driver-x86@vger.kernel.org>, <linux-mm@kvack.org>
References: <20220414101314.1250667-1-mawupeng1@huawei.com>
 <CAMj1kXGSStDgj9ABmUaTLnBmpQFksh3wx4tx=mJohum4GQe3Gg@mail.gmail.com>
 <6de859df-e1c3-e9aa-4530-3b61b9c69a28@huawei.com>
 <CAMj1kXGyKQMeFWSK-s84pdL89qPTyTN_x3WHTgp_R7sH1+qOfA@mail.gmail.com>
From:   mawupeng <mawupeng1@huawei.com>
In-Reply-To: <CAMj1kXGyKQMeFWSK-s84pdL89qPTyTN_x3WHTgp_R7sH1+qOfA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.120]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500014.china.huawei.com (7.185.36.153)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



在 2022/4/20 2:32, Ard Biesheuvel 写道:
> On Sat, 16 Apr 2022 at 03:32, mawupeng <mawupeng1@huawei.com> wrote:
>>
>>
>>
>> 在 2022/4/14 18:22, Ard Biesheuvel 写道:
>>> On Thu, 14 Apr 2022 at 11:54, Wupeng Ma <mawupeng1@huawei.com> wrote:
>>>>
>>>> From: Ma Wupeng <mawupeng1@huawei.com>
>>>>
>>>> Commit b05b9f5f9dcf ("x86, mirror: x86 enabling - find mirrored memory ranges")
>>>> introduced mirrored memory support for x86. This support rely on UEFI to
>>>> report mirrored memory address ranges.  See UEFI 2.5 spec pages 157-158:
>>>>
>>>>     http://www.uefi.org/sites/default/files/resources/UEFI%202_5.pdf
>>>>
>>>> Memory mirroring is a technique used to separate memory into two separate
>>>> channels, usually on a memory device, like a server. In memory mirroring,
>>>> one channel is copied to another to create redundancy. This method makes
>>>> input/output (I/O) registers and memory appear with more than one address
>>>> range because the same physical byte is accessible at more than one
>>>> address. Using memory mirroring, higher memory reliability and a higher
>>>> level of memory consolidation are possible.
>>>>
>>>> Arm64 can support this too. So mirrored memory support is added to support
>>>> arm64.
>>>>
>>>> Efi_fake_mem is used for testing mirrored features and will not be used in
>>>> production environment. This test features can fake memory's attribute
>>>> values.
>>>>
>>>> The reason why efi_fake_mem support is put first is that memory's attribute
>>>> is reported by BIOS which is hard to simulate. With this support, any arm64
>>>> machines with efi support can easily test mirrored features.
>>>>
>>>> The main purpose of this patchset is to introduce mirrored support for
>>>> arm64 and we have already fixed the problems we had which is shown in
>>>> patch #5 to patch #7 and try to bring total isolation in patch #8 which
>>>> will disable mirror feature if kernelcore is not specified.
>>>>
>>>> In order to test this support in arm64:
>>>> - patch this patchset
>>>> - add efi_fake_mem=8G@0:0x10000 in kernel parameter to simulate mirrored
>>>>     memroy between phy addr 0-8G.
>>>> - add kernelcore=mirror in kernel parameter
>>>> - start you kernel
>>>>
>>>
>>> As I explained before:
>>>
>>> - NAK to EFI fake_mem support on arm64
>>
>> fake_mem support on arm64 will be removed in subsequent version.
>>
>>> - NAK to the whole series until you come up with a proposal on how to
>>> locate the static kernel image itself into more reliable memory, as
>>> there is really no point to any of this otherwise.
>>
>> Sorry I am not familiar with this, as you metioned before,
>>
>>   > you have to iterate over the memory map and look for regions with
>>   > the desired attribute, and allocate those pages explicitly.
>>
>> Do you mean this is x86, commit c05cd79750fb
>> ("x86/boot/KASLR: Prefer mirrored memory regions for the kernel physical address").
>> I will do some research.
>>
>>   > I'd prefer to implement this in the bootloader, and only add minimal
>>   > logic to the stub to respect the placement of the kernel by the loader
>>   > if the loader signals it to do so.
>>
>> Does this bootloader refer to grub and then add minimal logic to arm64-stub.c?
>>
> 
> Any bootloader, yes.
> 
>> What is the loader signal?
> 
> A protocol installed onto the image handle, as I suggested before. I
> even cc'ed you on a patch that implements this.

Sorry to bother you.
I didn't receive any patches.
Could you share the link?

> 
>> System exists mirrored memory reported by uefi?
>>
> 
> What on earth is the point of any of this if the only use case being
> targeted is efi_fake_mem with arbitrary fake mirrored regions?
> 
> So yes, unless there are systems that need this, I don't see a point
> in merging any of this
We do have mirrored memory reported by uefi and efi_fake_mem is added for easy testing
with qemu/hardware without update UEFI.

> .
