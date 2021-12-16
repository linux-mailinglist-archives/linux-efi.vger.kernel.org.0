Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C47147733A
	for <lists+linux-efi@lfdr.de>; Thu, 16 Dec 2021 14:34:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232284AbhLPNeQ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 16 Dec 2021 08:34:16 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:30135 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232211AbhLPNeQ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 16 Dec 2021 08:34:16 -0500
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4JFChH1rN2z8vsp;
        Thu, 16 Dec 2021 21:31:59 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 16 Dec 2021 21:34:13 +0800
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 16 Dec 2021 21:34:12 +0800
Subject: Re: [PATCHv3] efi: apply memblock cap after memblock_add()
To:     Rob Herring <robh+dt@kernel.org>
CC:     Pingfan Liu <kernelfans@gmail.com>, <devicetree@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        "Geert Uytterhoeven" <geert+renesas@glider.be>,
        Frank Rowand <frowand.list@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Nick Terrell <terrelln@fb.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
References: <20211214040157.27443-3-kernelfans@gmail.com>
 <20211215021348.8766-1-kernelfans@gmail.com>
 <7fa6bfd1-357d-10ad-0375-a6efdc7b89e4@huawei.com>
 <Ybl9RYCIo14qyxqL@piliu.users.ipa.redhat.com>
 <ef184207-57db-f80e-7ee3-264110c1ba10@huawei.com>
 <CAL_JsqLS_=_Zeau-10aRkHWvvW-DNxB=CHr0mMo2SqbK35fLPA@mail.gmail.com>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <0b38a1bd-f862-402a-c146-7732289b21b7@huawei.com>
Date:   Thu, 16 Dec 2021 21:34:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqLS_=_Zeau-10aRkHWvvW-DNxB=CHr0mMo2SqbK35fLPA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 2021/12/15 23:05, Rob Herring wrote:
> On Wed, Dec 15, 2021 at 12:53 AM Leizhen (ThunderTown)
> <thunder.leizhen@huawei.com> wrote:
>>
>>
>>
>> On 2021/12/15 13:29, Pingfan Liu wrote:
>>> On Wed, Dec 15, 2021 at 11:58:03AM +0800, Leizhen (ThunderTown) wrote:
>>>>
>>>>
>>>> On 2021/12/15 10:13, Pingfan Liu wrote:
>>>>> On arm64, during kdump kernel saves vmcore, it runs into the following bug:
>>>>> ...
>>>>> [   15.148919] usercopy: Kernel memory exposure attempt detected from SLUB object 'kmem_cache_node' (offset 0, size 4096)!
>>>>> [   15.159707] ------------[ cut here ]------------
>>>>> [   15.164311] kernel BUG at mm/usercopy.c:99!
>>>>> [   15.168482] Internal error: Oops - BUG: 0 [#1] SMP
>>>>> [   15.173261] Modules linked in: xfs libcrc32c crct10dif_ce ghash_ce sha2_ce sha256_arm64 sha1_ce sbsa_gwdt ast i2c_algo_bit drm_vram_helper drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops cec drm_ttm_helper ttm drm nvme nvme_core xgene_hwmon i2c_designware_platform i2c_designware_core dm_mirror dm_region_hash dm_log dm_mod overlay squashfs zstd_decompress loop
>>>>> [   15.206186] CPU: 0 PID: 542 Comm: cp Not tainted 5.16.0-rc4 #1
>>>>> [   15.212006] Hardware name: GIGABYTE R272-P30-JG/MP32-AR0-JG, BIOS F12 (SCP: 1.5.20210426) 05/13/2021
>>>>> [   15.221125] pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>>>>> [   15.228073] pc : usercopy_abort+0x9c/0xa0
>>>>> [   15.232074] lr : usercopy_abort+0x9c/0xa0
>>>>> [   15.236070] sp : ffff8000121abba0
>>>>> [   15.239371] x29: ffff8000121abbb0 x28: 0000000000003000 x27: 0000000000000000
>>>>> [   15.246494] x26: 0000000080000400 x25: 0000ffff885c7000 x24: 0000000000000000
>>>>> [   15.253617] x23: 000007ff80400000 x22: ffff07ff80401000 x21: 0000000000000001
>>>>> [   15.260739] x20: 0000000000001000 x19: ffff07ff80400000 x18: ffffffffffffffff
>>>>> [   15.267861] x17: 656a626f2042554c x16: 53206d6f72662064 x15: 6574636574656420
>>>>> [   15.274983] x14: 74706d6574746120 x13: 2129363930342065 x12: 7a6973202c302074
>>>>> [   15.282105] x11: ffffc8b041d1b148 x10: 00000000ffff8000 x9 : ffffc8b04012812c
>>>>> [   15.289228] x8 : 00000000ffff7fff x7 : ffffc8b041d1b148 x6 : 0000000000000000
>>>>> [   15.296349] x5 : 0000000000000000 x4 : 0000000000007fff x3 : 0000000000000000
>>>>> [   15.303471] x2 : 0000000000000000 x1 : ffff07ff8c064800 x0 : 000000000000006b
>>>>> [   15.310593] Call trace:
>>>>> [   15.313027]  usercopy_abort+0x9c/0xa0
>>>>> [   15.316677]  __check_heap_object+0xd4/0xf0
>>>>> [   15.320762]  __check_object_size.part.0+0x160/0x1e0
>>>>> [   15.325628]  __check_object_size+0x2c/0x40
>>>>> [   15.329711]  copy_oldmem_page+0x7c/0x140
>>>>> [   15.333623]  read_from_oldmem.part.0+0xfc/0x1c0
>>>>> [   15.338142]  __read_vmcore.constprop.0+0x23c/0x350
>>>>> [   15.342920]  read_vmcore+0x28/0x34
>>>>> [   15.346309]  proc_reg_read+0xb4/0xf0
>>>>> [   15.349871]  vfs_read+0xb8/0x1f0
>>>>> [   15.353088]  ksys_read+0x74/0x100
>>>>> [   15.356390]  __arm64_sys_read+0x28/0x34
>>>>> ...
>>>>>
>>>>> This bug introduced by commit b261dba2fdb2 ("arm64: kdump: Remove custom
>>>>> linux,usable-memory-range handling"), which moves
>>>>> memblock_cap_memory_range() to fdt, but it breaches the rules that
>>>>> memblock_cap_memory_range() should come after memblock_add() etc as said
>>>>> in commit e888fa7bb882 ("memblock: Check memory add/cap ordering").
>>>>
>>>> void __init early_init_dt_scan_nodes(void)
>>>> {
>>>>      //(1) -->early_init_dt_check_for_usable_mem_range, fill cap_mem_addr
>>>>         rc = of_scan_flat_dt(early_init_dt_scan_chosen, boot_command_line);
>>>>
>>>>      //(2) --> early_init_dt_add_memory_arch --> memblock_add()
>>>>         of_scan_flat_dt(early_init_dt_scan_memory, NULL);
>>>>
>>>>      //(3)
>>>>         memblock_cap_memory_range(cap_mem_addr, cap_mem_size);
>>>> }
>>>>
>>>> I didn't get it. The above step (1),(2),(3) comply with
>>>> commit e888fa7bb882 ("memblock: Check memory add/cap ordering")
>>>>
>>> Well, at this scope, it does. But from a larger scope, let's say on
>>> arm64,
>>> setup_arch
>>>   ...
>>>   setup_machine_fdt(); //which holds your case
>>>   ...
>>>   efi_init(); //which call memblock_add, and breach the ordering.
>>>
>>>> Did you see the warning?
>>>> pr_warn("%s: No memory registered yet\n", __func__);
>>>>
>>> Yes, I did see this message, which brings me to commit e888fa7bb882
>>> ("memblock: Check memory add/cap ordering")
>>>
>>> I am also curious why this bug does not be discovered. Is CONFIG_EFI
>>> on at your case?
>>
>> Yes, Both X86 and ARM64, CONFIG_EFI=y. I used the defconfig.
> 
> Are you booting using EFI though? efi_init() removes all memblocks
> that may have been setup from the DT and adds memblocks using the EFI
> memory map information.

Sorry, I tested it with QEMU. I checked that efi_system_table is not exist.

> 
> Rob
> .
> 
