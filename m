Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A58D4CB6D2
	for <lists+linux-efi@lfdr.de>; Thu,  3 Mar 2022 07:14:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbiCCGPE (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 3 Mar 2022 01:15:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbiCCGPD (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 3 Mar 2022 01:15:03 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D64FC145ADB
        for <linux-efi@vger.kernel.org>; Wed,  2 Mar 2022 22:14:10 -0800 (PST)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4K8LJ309fkzdfmc;
        Thu,  3 Mar 2022 14:12:51 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 3 Mar 2022 14:14:08 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.21; Thu, 3 Mar 2022 14:14:08 +0800
Message-ID: <90370cea-a3d2-6ae8-0b9d-71a3a9d97c12@huawei.com>
Date:   Thu, 3 Mar 2022 14:14:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [Question] Should retain 2M alignment if kernel image is bad
 aligned at entry or BSS overlaps?
Content-Language: en-US
To:     Ard Biesheuvel <ardb@kernel.org>
CC:     Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
References: <894d1598-7b05-9406-5c1a-162b749bb4e8@huawei.com>
 <CAMj1kXH3p3fTF-MKqJ6TAYc3Jm0WRit8u+ugjZdr-ykAR8ahTA@mail.gmail.com>
 <4792d478-edea-6c72-3e08-cf2a390f5a7c@huawei.com>
 <CAMj1kXH=Sy8m_Zi5PNDqX3GQqFQdXnd1DQkxGhEeM-uovfvVLw@mail.gmail.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <CAMj1kXH=Sy8m_Zi5PNDqX3GQqFQdXnd1DQkxGhEeM-uovfvVLw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggeme706-chm.china.huawei.com (10.1.199.102) To
 dggpemm500001.china.huawei.com (7.185.36.107)
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


On 2022/3/1 20:57, Ard Biesheuvel wrote:
> On Tue, 1 Mar 2022 at 11:34, Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
>>
>> On 2022/3/1 15:22, Ard Biesheuvel wrote:
>>> On Tue, 1 Mar 2022 at 07:50, Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
>>>> Hi Ard，Will and all maintainer，
>>>>
>>>> As commit 3a262423755b ("efi/libstub: arm64: Relax 2M alignment again
>>>> for relocatable kernels") saids, a relocatable image does not need to
>>>> be copied to a 2M aligned offset if it was loaded on a 64k boundary
>>>> (for a 4 KB granule kernel) by EFI. But if there is some FIRMWARE BUG,
>>>>
>>>> 1) kernel image not aligned on 64k boundary
>>>> or
>>>> 2) Image BSS overlaps adjacent EFI memory region
>>>>
>>>> When kaslr is disabled(eg, EFI_RNG_PROTOCOL unavailable), it will leads
>>>> KPTI forced ON after kernel image relocated, message shown below,
>>>>
>>>>      CPU features: kernel page table isolation forced ON by KASLR
>>>>      ...
>>>>      KASLR disabled due to lack of seed
>>>>
>>>> The KASLR don't enabled actually, and KPTI is forced enabled which could
>>>> affect performance.
>>>>
>>> This message is misleading. If the alignment modulo 2M != 0, we still
>>> have 5 bits of 'randomization', although these bits are probably
>>> highly predictable on a given system.
>> Yes， this kernel boot message is misleading, I am confused and find
>> commit 3a262423755b ("efi/libstub: arm64: Relax 2M alignment again for
>> relocatable kernels") leads to different behavior about KPTI.
> That commit log explains how we ended up forcing 2M alignment
> inadvertently if the EFI_RNG_PROTOCOL was not available. If we don't
> force 2M alignment, and the physical address of the kernel happens to
> be misaligned modulo 2M, the resulting offset is reused for virtual
> randomization as well. Hence the 5 additional bits.
>
> Given the predictability of those bits when used on their own, we
> could decide to disable KPTI in this case as well.
>
>>>> I found commit 7c116db24d94 ("efi/libstub/arm64: Retain 2MB kernel Image
>>>> alignment if !KASLR") in v5.8, should we retain 2M alignment if kernel image
>>>> is bad aligned at entry or BSS overlaps?
>>>>
>>> Personally, I think we're doing enough already to deal with Redhat's
>>> broken out-of-tree GRUB/SHIM concoction, which is the primary reason
>>> for these workarounds  IIRC.
>> Not sure about this, what's your mean is that error message is enough and
>>
>> no need to adjust the alignment when image with bad aligned at entry or
>> BSS overlaps?
>>
> I am having difficulty understanding which part of the current
> behavior you think is causing a problem.
>
> In a nutshell, what the current code aims to do is to only move the
> image in memory if needed, and just boot if where it was loaded by EFI
> otherwise.
>
> Reasons for moving it could be any of:
> - KASLR is enabled and we have a seed
> - nokaslr was passed, and we are not aligned to 2M
> - we are running a 64k pages + VMAP stack build, and the image is not
> aligned to 128k
> - the PE/COFF loader is broken, and ignored the minimum 64k alignment
> in the PE/COFF header
> - the PE/COFF loader is broken, and ignored the BSS size, resulting in
> an overlap with a memory region that is already in use.
>
> As you might have guessed, my grumbling about GRUB/SHIM was in
> relation to the latter 2 points - upstream GRUB does not have its own
> PE/COFF loader, but SHIM/GRUB implement their own, and don't follow
> the PE/COFF spec too rigorously.
>
>>> You can already pass nokalsr on the kernel command line if you want to
>>> avoid the downsides entirely, so as I understand it, this is mostly
>>> about an unquantified performance gain on systems that use a broken
>>> bootloader and lack the entropy source for a KASLR seed, but are not
>>> able to put nokaslr on the command line?
>> nokaslr will use 2M alignment by default, but if some board with new
>> BIOS/GRUB
>>
>> the kaslr won't enabled unless change the grub to drop it one by one, it
>> is not kind
>>
>> for production deployment.
>>
>> Do you think the following adjustment make sense or it is definitely wrong?
>>
> I can only answer this if I understand which problem it solves. Why do
> you need the 2M alignment in this case?
> .

Sorry for the late response，my purpose is that we don't want to enable 
KPTI if

KASLR is disabled. For now, if there are some firmware bug, the kernel 
image is

relocated which lead to kaslr_requires_kpti() returen 
ture(kaslr_offset() > 0).

the change to 2M alignment is a workaround and according to your 
explanation,

I don't think the workaround is necessary.  I want to make sure that the 
above

scene is expected? thanks.

