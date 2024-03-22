Return-Path: <linux-efi+bounces-844-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BCB68867B1
	for <lists+linux-efi@lfdr.de>; Fri, 22 Mar 2024 08:58:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2C02B22167
	for <lists+linux-efi@lfdr.de>; Fri, 22 Mar 2024 07:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 788831429F;
	Fri, 22 Mar 2024 07:58:14 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36536168A4
	for <linux-efi@vger.kernel.org>; Fri, 22 Mar 2024 07:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711094294; cv=none; b=HqiQgK2d1NaVgzUeRqHEeUmvXj1hdZXVNeyF7JGS2tzvJbE0N+rWaPo7UOezi8WN1cHITvubPXTw59HZiHv+Z3Wz49xTwAxbdRK3/Q6N80zA6uArz/sTLbdbAql4LsUKl6Cf4tcEJx9lXyftl2kmDX9RYsnSj5rO86czuh4i2kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711094294; c=relaxed/simple;
	bh=siPh1etl7llRxd04jijNXiOGlqite2nDyOaKjguF/NU=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=PivPiVzSnUy/5qxYGAd7DNRqZbL0273OBXvDbb55k5+xmi5/vdQu/XWDwx8GpvXoNvRIMxLLBPPzEilvenpOg8yqzL83AHgjca6YvxuSM6g8hMeCGwcpkz4zngnSAt7xaZCBU/9Xrk/VEw40lBS3g8iFox7n4XnvwgtC8pMDJX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4V1F4F6ftMzXjXg;
	Fri, 22 Mar 2024 15:55:25 +0800 (CST)
Received: from kwepemd200008.china.huawei.com (unknown [7.221.188.40])
	by mail.maildlp.com (Postfix) with ESMTPS id 4E57814040F;
	Fri, 22 Mar 2024 15:58:05 +0800 (CST)
Received: from [10.67.110.237] (10.67.110.237) by
 kwepemd200008.china.huawei.com (7.221.188.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 22 Mar 2024 15:58:04 +0800
Subject: Re: Question about Address Range Validation in Crash Kernel
 Allocation
To: Dave Young <dyoung@redhat.com>, Ard Biesheuvel <ardb@kernel.org>
CC: "chenhaixiang (A)" <chenhaixiang3@huawei.com>, Baoquan He
	<bhe@redhat.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
	"chenhuacai@kernel.org" <chenhuacai@kernel.org>, "x86@kernel.org"
	<x86@kernel.org>, Louhongxiang <louhongxiang@huawei.com>, "wangbin (A)"
	<wangbin224@huawei.com>, "Fangchuangchuang(Fcc,Euler)"
	<fangchuangchuang@huawei.com>, "wanghai (M)" <wanghai38@huawei.com>,
	"Wangkefeng (OS Kernel Lab)" <wangkefeng.wang@huawei.com>,
	<linux-efi@vger.kernel.org>
References: <4eeac1f733584855965a2ea62fa4da58@huawei.com>
 <4c31664e-9c35-1956-e667-be976ac6510e@huawei.com>
 <CALu+AoQWiqMhRG=NXsbkBVDSTjYFfeOc9H0+GUXLE213ZWPANw@mail.gmail.com>
 <f286282d-a3ee-980e-565a-bf0c401ca529@huawei.com>
 <CALu+AoRaq0FinqJC-yDus7Df=XP2TfZREn9nsZ_1CaExuYOdaA@mail.gmail.com>
From: Li Huafei <lihuafei1@huawei.com>
Message-ID: <23ff1b10-68b0-34ae-6407-f377bbdb6ca7@huawei.com>
Date: Fri, 22 Mar 2024 15:58:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CALu+AoRaq0FinqJC-yDus7Df=XP2TfZREn9nsZ_1CaExuYOdaA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemd200008.china.huawei.com (7.221.188.40)



On 2024/3/22 15:18, Dave Young wrote:
> On Thu, 21 Mar 2024 at 20:37, Li Huafei <lihuafei1@huawei.com> wrote:
>>
>>
>>
>> On 2024/3/21 18:06, Dave Young wrote:
>>> Hi,
>>>
>>> On Thu, 21 Mar 2024 at 17:49, Li Huafei <lihuafei1@huawei.com> wrote:
>>>>
>>>> Hi Baoquan，
>>>>
>>>> On 2024/3/21 17:17, chenhaixiang (A) wrote:
>>>>>
>>>>>>> I'm sorry for the delay. Here are some details from the boot log and
>>>>>> /proc/iomem:
>>>>>>> The Boot log:
>>>>>>> [    0.000000] Linux version 6.8.0 (root@localhost.localdomain) (gcc (GCC)
>>>>>> 10.3.1, GNU ld (GNU Binutils) 2.37) #3 SMP PREEMPT_DYNAMIC Wed Mar 20
>>>>>> 11:46:11 UTC 2024
>>>>>>> [    0.000000] Command line: BOOT_IMAGE=/vmlinuz-6.8.0
>>>>>> root=/dev/mapper/root ro crashkernel=512M resume=/dev/mapper/swap
>>>>>> rd.lvm.lv=root rd.lvm.lv=swap crash_kexec_post_notifiers softlockup_panic=1
>>>>>> reserve_kbox_mem=16M fsck.mode=auto fsck.repair=yes panic=3
>>>>>> nmi_watchdog=1 quiet rd.shell=0 memblock=debug efi=debug
>>>>>> console=ttyS0,115200n8 console=tty0
>>>>>> ......snip...
>>>>>>> [    0.022622] memblock_phys_alloc_range: 536870912 bytes align=0x1000000
>>>>>> from=0x0000000000000000 max_addr=0x0000000100000000
>>>>>> reserve_crashkernel_generic+0x7c/0x220
>>>>>>> [    0.022628] memblock_phys_alloc_range: 536870912 bytes align=0x1000000
>>>>>> from=0x0000000100000000 max_addr=0x0000400000000000
>>>>>> reserve_crashkernel_generic+0x7c/0x220
>>>>>>> [    0.022632] memblock_reserve: [0x000000c01f000000-0x000000c03effffff]
>>>>>> memblock_alloc_range_nid+0xee/0x170
>>>>>>> [    0.022634] memblock_phys_alloc_range: 268435456 bytes align=0x1000000
>>>>>> from=0x0000000000000000 max_addr=0x0000000100000000
>>>>>> reserve_crashkernel_generic+0x11d/0x220
>>>>>>> [    0.022638] memblock_reserve: [0x0000000049000000-0x0000000058ffffff]
>>>>>> memblock_alloc_range_nid+0xee/0x170
>>>>>>> [    0.022640] crashkernel low memory reserved: 0x49000000 - 0x59000000
>>>>>> (256 MB)
>>>>>>> [    0.022641] crashkernel reserved: 0x000000c01f000000 -
>>>>>> 0x000000c03f000000 (512 MB)
>>>>>>
>>>>>> Here, crashkernel,low is reserved in region:  [0x49000000 - 0x59000000] (256
>>>>>> MB)
>>>>>>       crashkernel,high is reserved in region: [0x000000c01f000000 -
>>>>>> 0x000000c03f000000] (512 MB) ......
>>>>>>> [    0.029839] memblock_reserve: [0x000000c03ffff740-0x000000c03fffff7f]
>>>>>> memblock_alloc_range_nid+0xee/0x170
>>>>>>> [    0.029843] e820: update [mem 0x53cbd000-0x53ccffff] usable ==>
>>>>>> reserved
>>>>>>> [    0.029861] TSC deadline timer available
>>>>>>
>>>>>> Then here, region [0x53cbd000-0x53ccffff] is reserved in e820, and print abvoe
>>>>>> "usable ==> reserved". This should be the step which prevents earlier reserved
>>>>>> crashkernel,low from being added to iomem tree. I am not sure what triggered
>>>>>> the e820 update.
>>>>
>>>> We added dump_stack () printing in efi_mem_reserve () and found that
>>>> [0x53cbd000-0x53ccffff] was reserved by BGRT:
>>>>
>>>>   [    0.032259] e820: update [mem 0x53cbd000-0x53ccffff] usable ==>
>>>> reserved
>>>>   [    0.032262] CPU: 0 PID: 0 Comm: swapper Not tainted
>>>> 5.10.0-60.18.0.50.h820.eulerosv2r11.x86_64 #7
>>>>   [    0.032263] Hardware name: Huawei 2288H V5/BC11SPSCB0, BIOS 8.25
>>>> 08/30/2022
>>>>   [    0.032264] Call Trace:
>>>>   [    0.032265]  ? dump_stack+0x57/0x6e
>>>>   [    0.032267]  ? bgrt_init+0xc2/0xc2
>>>>   [    0.032268]  ? __e820__range_update+0x7a/0x1d6
>>>>   [    0.032270]  ? bgrt_init+0xc2/0xc2
>>>>   [    0.032272]  ? bgrt_init+0xc2/0xc2
>>>>   [    0.032274]  ? efi_arch_mem_reserve+0x1a3/0x1d0
>>>>   [    0.032276]  ? efi_mem_reserve+0x2d/0x42
>>>>   [    0.032278]  ? acpi_parse_bgrt+0xa/0x11
>>>>   [    0.032279]  ? acpi_table_parse+0x86/0xbc
>>>>   [    0.032281]  ? acpi_boot_init+0x79/0xad
>>>>   [    0.032282]  ? setup_arch+0x835/0x954
>>>>   [    0.032284]  ? start_kernel+0x5d/0x455
>>>>   [    0.032286]  ? secondary_startup_64_no_verify+0xc2/0xcb
>>>>
>>>> efi_reserve_boot_services() has reserved memory of type
>>>> EFI_BOOT_SERVICES_CODE & EFI_BOOT_SERVICES_DATA  before crashkernel.
>>>> efi_bgrt_init() assumes that EFI_BOOT_SERVICES_DATA is not reserved by
>>>> other modules. Then, the e820_table is directly updated, and the BGRT
>>>> memory is reserved.
>>>>
>>>> However, memblock_is_region_reserved() in efi_reserve_boot_services()
>>>> returns true when the ranges only overlap.
>>>>
>>>>      already_reserved = memblock_is_region_reserved(start, size);
>>>
>>> Do you mean efi_reserve_boot_services is supposed to reserve the bgrt
>>> memory but it does not reserve it due to the region overlapping with
>>> some other reserved region?  If so can you debug and find what exact
>>> memblock reserved region overlaps with the bgrt?
>>
>> Yes. I added the following debug print to efi_reserve_boot_services():
>>
>> --- a/arch/x86/platform/efi/quirks.c
>> +++ b/arch/x86/platform/efi/quirks.c
>> @@ -339,6 +339,10 @@ void __init efi_reserve_boot_services(void)
>>
>>                 already_reserved = memblock_is_region_reserved(start, size);
>>
>> +               pr_info("kdumpdebug: efi_reserve_boot_services start 0x%lu, "
>> +                       "size 0x%lx, type 0x%lx, already_reserved %d\n",
>> +                       start, size, md->type, already_reserved);
>> +
>>                 /*
>>                  * Because the following memblock_reserve() is paired
>>                  * with memblock_free_late() for this region in
>>
>> This memory [0x0000005976a018-0x00000005976abc7] is reserved here, which belongs to EFI_BOOT_SERVICES_DATA.
>>     [    0.000000] memblock_reserve: [0x000000005976a018-0x000000005976abc7] efi_memattr_init+0x51/0xa0
>> It falls in the following range
>>     [    0.000000] efi: mem22: [Boot Data   |   |  |  |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x0000000051329000-0x000000005cefefff] (187MB)
>>
>> in efi_reserve_boot_services(), [0x0000005132900-0x00000005cefeff] will not be fully reserved because [0x0000005976a018-0x0000005976abc7]
>> has already been reserved and overlaps with [0x0000005976a018-0x0000005976abc7]
> 
> Ok, it looks to me it is like this:
> 
> efi_memattr_init() reserved the memattr table with memblock_reserve
> efi_reserve_boot_services failed to reserve the boot data region which
> includes the memattr table due to it has been revervely partially.
>

Yes, that's my analysis.

> So this should be a UEFI issue revealed by the crashkernel resource
> late intert commit.   I suspect the memblock_reserve in
> efi_memattr_init can be just removed and leave to
> efi_reserve_boot_services to do that.
> 
> Added Ard and efi list for opinion.
> 

Thanks a lot! I was just about to ask the efi guys for help.

> 
>>
>>     [    0.021316] efi: kdumpdebug: efi_reserve_boot_services start 0x51329000, size 0xbbd6000, type 0x4, already_reserved 1
>>
>> It is not reserved by memblock, this free memory region is allocated by crashkernel
>>
>>     [    0.022597] crashkernel low memory reserved: 0x49000000 - 0x59000000 (256 MB)
>>     [    0.022599] crashkernel reserved: 0x000000c01f000000 - 0x000000c03f000000 (512 MB)
>>
>> In efi_bgrt_init (), it is assumed that the memory of the EFI_BOOT_SERVICES_DATA type has been successfully
>> reserved. Therefore, the address in the range is directly used. As a result, the memory overlaps with
>> the crashkernel region.
>>
>>     [    0.029694] e820: update [mem 0x53cbd000-0x53ccffff] usable ==> reserved
> 
> Thanks
> Dave
> 
> .
> 

