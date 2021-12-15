Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0ACC475332
	for <lists+linux-efi@lfdr.de>; Wed, 15 Dec 2021 07:53:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240195AbhLOGxx (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 15 Dec 2021 01:53:53 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:29195 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240111AbhLOGxw (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 15 Dec 2021 01:53:52 -0500
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4JDQrn5NhVz8vgT;
        Wed, 15 Dec 2021 14:51:37 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 15 Dec 2021 14:53:50 +0800
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 15 Dec 2021 14:53:49 +0800
Subject: Re: [PATCHv3] efi: apply memblock cap after memblock_add()
To:     Pingfan Liu <kernelfans@gmail.com>
CC:     <devicetree@vger.kernel.org>, <linux-efi@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Frank Rowand <frowand.list@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Nick Terrell <terrelln@fb.com>,
        <linux-arm-kernel@lists.infradead.org>
References: <20211214040157.27443-3-kernelfans@gmail.com>
 <20211215021348.8766-1-kernelfans@gmail.com>
 <7fa6bfd1-357d-10ad-0375-a6efdc7b89e4@huawei.com>
 <Ybl9RYCIo14qyxqL@piliu.users.ipa.redhat.com>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <ef184207-57db-f80e-7ee3-264110c1ba10@huawei.com>
Date:   Wed, 15 Dec 2021 14:53:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <Ybl9RYCIo14qyxqL@piliu.users.ipa.redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 2021/12/15 13:29, Pingfan Liu wrote:
> On Wed, Dec 15, 2021 at 11:58:03AM +0800, Leizhen (ThunderTown) wrote:
>>
>>
>> On 2021/12/15 10:13, Pingfan Liu wrote:
>>> On arm64, during kdump kernel saves vmcore, it runs into the following bug:
>>> ...
>>> [   15.148919] usercopy: Kernel memory exposure attempt detected from SLUB object 'kmem_cache_node' (offset 0, size 4096)!
>>> [   15.159707] ------------[ cut here ]------------
>>> [   15.164311] kernel BUG at mm/usercopy.c:99!
>>> [   15.168482] Internal error: Oops - BUG: 0 [#1] SMP
>>> [   15.173261] Modules linked in: xfs libcrc32c crct10dif_ce ghash_ce sha2_ce sha256_arm64 sha1_ce sbsa_gwdt ast i2c_algo_bit drm_vram_helper drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops cec drm_ttm_helper ttm drm nvme nvme_core xgene_hwmon i2c_designware_platform i2c_designware_core dm_mirror dm_region_hash dm_log dm_mod overlay squashfs zstd_decompress loop
>>> [   15.206186] CPU: 0 PID: 542 Comm: cp Not tainted 5.16.0-rc4 #1
>>> [   15.212006] Hardware name: GIGABYTE R272-P30-JG/MP32-AR0-JG, BIOS F12 (SCP: 1.5.20210426) 05/13/2021
>>> [   15.221125] pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>>> [   15.228073] pc : usercopy_abort+0x9c/0xa0
>>> [   15.232074] lr : usercopy_abort+0x9c/0xa0
>>> [   15.236070] sp : ffff8000121abba0
>>> [   15.239371] x29: ffff8000121abbb0 x28: 0000000000003000 x27: 0000000000000000
>>> [   15.246494] x26: 0000000080000400 x25: 0000ffff885c7000 x24: 0000000000000000
>>> [   15.253617] x23: 000007ff80400000 x22: ffff07ff80401000 x21: 0000000000000001
>>> [   15.260739] x20: 0000000000001000 x19: ffff07ff80400000 x18: ffffffffffffffff
>>> [   15.267861] x17: 656a626f2042554c x16: 53206d6f72662064 x15: 6574636574656420
>>> [   15.274983] x14: 74706d6574746120 x13: 2129363930342065 x12: 7a6973202c302074
>>> [   15.282105] x11: ffffc8b041d1b148 x10: 00000000ffff8000 x9 : ffffc8b04012812c
>>> [   15.289228] x8 : 00000000ffff7fff x7 : ffffc8b041d1b148 x6 : 0000000000000000
>>> [   15.296349] x5 : 0000000000000000 x4 : 0000000000007fff x3 : 0000000000000000
>>> [   15.303471] x2 : 0000000000000000 x1 : ffff07ff8c064800 x0 : 000000000000006b
>>> [   15.310593] Call trace:
>>> [   15.313027]  usercopy_abort+0x9c/0xa0
>>> [   15.316677]  __check_heap_object+0xd4/0xf0
>>> [   15.320762]  __check_object_size.part.0+0x160/0x1e0
>>> [   15.325628]  __check_object_size+0x2c/0x40
>>> [   15.329711]  copy_oldmem_page+0x7c/0x140
>>> [   15.333623]  read_from_oldmem.part.0+0xfc/0x1c0
>>> [   15.338142]  __read_vmcore.constprop.0+0x23c/0x350
>>> [   15.342920]  read_vmcore+0x28/0x34
>>> [   15.346309]  proc_reg_read+0xb4/0xf0
>>> [   15.349871]  vfs_read+0xb8/0x1f0
>>> [   15.353088]  ksys_read+0x74/0x100
>>> [   15.356390]  __arm64_sys_read+0x28/0x34
>>> ...
>>>
>>> This bug introduced by commit b261dba2fdb2 ("arm64: kdump: Remove custom
>>> linux,usable-memory-range handling"), which moves
>>> memblock_cap_memory_range() to fdt, but it breaches the rules that
>>> memblock_cap_memory_range() should come after memblock_add() etc as said
>>> in commit e888fa7bb882 ("memblock: Check memory add/cap ordering").
>>
>> void __init early_init_dt_scan_nodes(void)
>> {
>> 	//(1) -->early_init_dt_check_for_usable_mem_range, fill cap_mem_addr
>>         rc = of_scan_flat_dt(early_init_dt_scan_chosen, boot_command_line);
>>
>> 	//(2) --> early_init_dt_add_memory_arch --> memblock_add()
>>         of_scan_flat_dt(early_init_dt_scan_memory, NULL);
>>
>> 	//(3)
>>         memblock_cap_memory_range(cap_mem_addr, cap_mem_size);
>> }
>>
>> I didn't get it. The above step (1),(2),(3) comply with
>> commit e888fa7bb882 ("memblock: Check memory add/cap ordering")
>>
> Well, at this scope, it does. But from a larger scope, let's say on
> arm64,
> setup_arch
>   ...
>   setup_machine_fdt(); //which holds your case
>   ...
>   efi_init(); //which call memblock_add, and breach the ordering.
> 
>> Did you see the warning?
>> pr_warn("%s: No memory registered yet\n", __func__);
>>
> Yes, I did see this message, which brings me to commit e888fa7bb882
> ("memblock: Check memory add/cap ordering")
> 
> I am also curious why this bug does not be discovered. Is CONFIG_EFI
> on at your case? 

Yes, Both X86 and ARM64, CONFIG_EFI=y. I used the defconfig.

> 
> Thanks,
> 
> 	Pingfan
>>>
>>> As a consequence, the virtual address set up by copy_oldmem_page() does
>>> not bail out from the test of virt_addr_valid() in check_heap_object(),
>>> and finally hits the BUG_ON().
>>>
>>> Since memblock allocator has no idea about when the memblock is fully
>>> populated, while efi_init() is aware, so tackling this issue by calling the
>>> interface early_init_dt_check_for_usable_mem_range() exposed by of/fdt.
>>>
>>> Fixes: b261dba2fdb2 ("arm64: kdump: Remove custom linux,usable-memory-range handling")
>>> Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
>>> Cc: Rob Herring <robh+dt@kernel.org>
>>> Cc: Zhen Lei <thunder.leizhen@huawei.com>
>>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>>> Cc: Will Deacon <will@kernel.org>
>>> Cc: Andrew Morton <akpm@linux-foundation.org>
>>> Cc: Mike Rapoport <rppt@kernel.org>
>>> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
>>> Cc: Frank Rowand <frowand.list@gmail.com>
>>> Cc: Ard Biesheuvel <ardb@kernel.org>
>>> Cc: Nick Terrell <terrelln@fb.com>
>>> Cc: linux-arm-kernel@lists.infradead.org
>>> To: devicetree@vger.kernel.org
>>> To: linux-efi@vger.kernel.org
>>> ---
>>> v2 -> v3:
>>>  use static inline stub to avoid #ifdef according to Rob's suggestion 
>>>
>>>  drivers/firmware/efi/efi-init.c | 5 +++++
>>>  drivers/of/fdt.c                | 2 +-
>>>  include/linux/of_fdt.h          | 2 ++
>>>  3 files changed, 8 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/firmware/efi/efi-init.c b/drivers/firmware/efi/efi-init.c
>>> index b19ce1a83f91..b2c829e95bd1 100644
>>> --- a/drivers/firmware/efi/efi-init.c
>>> +++ b/drivers/firmware/efi/efi-init.c
>>> @@ -235,6 +235,11 @@ void __init efi_init(void)
>>>  	}
>>>  
>>>  	reserve_regions();
>>> +	/*
>>> +	 * For memblock manipulation, the cap should come after the memblock_add().
>>> +	 * And now, memblock is fully populated, it is time to do capping.
>>> +	 */
>>> +	early_init_dt_check_for_usable_mem_range();
>>>  	efi_esrt_init();
>>>  	efi_mokvar_table_init();
>>>  
>>> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
>>> index 18a2df431bfd..aa07ef5cab5f 100644
>>> --- a/drivers/of/fdt.c
>>> +++ b/drivers/of/fdt.c
>>> @@ -972,7 +972,7 @@ static unsigned long chosen_node_offset = -FDT_ERR_NOTFOUND;
>>>   * location from flat tree
>>>   * @node: reference to node containing usable memory range location ('chosen')
>>>   */
>>> -static void __init early_init_dt_check_for_usable_mem_range(void)
>>> +void __init early_init_dt_check_for_usable_mem_range(void)
>>>  {
>>>  	const __be32 *prop;
>>>  	int len;
>>> diff --git a/include/linux/of_fdt.h b/include/linux/of_fdt.h
>>> index cf48983d3c86..ad09beb6d13c 100644
>>> --- a/include/linux/of_fdt.h
>>> +++ b/include/linux/of_fdt.h
>>> @@ -62,6 +62,7 @@ extern int early_init_dt_scan_chosen(unsigned long node, const char *uname,
>>>  				     int depth, void *data);
>>>  extern int early_init_dt_scan_memory(unsigned long node, const char *uname,
>>>  				     int depth, void *data);
>>> +extern void early_init_dt_check_for_usable_mem_range(void);
>>>  extern int early_init_dt_scan_chosen_stdout(void);
>>>  extern void early_init_fdt_scan_reserved_mem(void);
>>>  extern void early_init_fdt_reserve_self(void);
>>> @@ -86,6 +87,7 @@ extern void unflatten_and_copy_device_tree(void);
>>>  extern void early_init_devtree(void *);
>>>  extern void early_get_first_memblock_info(void *, phys_addr_t *);
>>>  #else /* CONFIG_OF_EARLY_FLATTREE */
>>> +static inline void early_init_dt_check_for_usable_mem_range(void) {}
>>>  static inline int early_init_dt_scan_chosen_stdout(void) { return -ENODEV; }
>>>  static inline void early_init_fdt_scan_reserved_mem(void) {}
>>>  static inline void early_init_fdt_reserve_self(void) {}
>>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> .
> 
