Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 971065FD7FC
	for <lists+linux-efi@lfdr.de>; Thu, 13 Oct 2022 12:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229462AbiJMK5Q (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 13 Oct 2022 06:57:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiJMK5P (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 13 Oct 2022 06:57:15 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06841FBCCF
        for <linux-efi@vger.kernel.org>; Thu, 13 Oct 2022 03:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665658635; x=1697194635;
  h=message-id:date:mime-version:to:cc:from:subject:
   content-transfer-encoding;
  bh=zTjRrtn935+Ml/HWZ95dmiYlf0sJbh6MA4w4Uswb74k=;
  b=Ut2BbnVd0goKPm9+BwRXa60dkWqWacRSFoTPh/r96cgT9EXlSlpd++cD
   lUsj8LQ8uPUPjgNDqGhzzc8DWsNkZv3Z/SRhzOOVBPbPaT7t7fYBpJaDU
   bQ4b4RW/aqso17jI0lWewCYIHoVJDxL+OpJxzoqJfjSol3iixm3eXCEO8
   PXYX5qLv/j8+GLiNoA4BlcAE3B2hcrndtL3rzldgAAeQd9o19HhlZvFPa
   5gXqiwrys5BuD8Y9Uph49OFyzkhwbYwK4bO/cIDN3ARl7mp1mEZH65n8q
   KqX0xG3Xq8uJaHnH2pwoWCprUoB6wp/Twzpm4F9f4xjv6ZqB3tioV4xLY
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10498"; a="306109744"
X-IronPort-AV: E=Sophos;i="5.95,180,1661842800"; 
   d="scan'208";a="306109744"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2022 03:57:14 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10498"; a="752476766"
X-IronPort-AV: E=Sophos;i="5.95,180,1661842800"; 
   d="scan'208";a="752476766"
Received: from aslawinx-mobl.ger.corp.intel.com (HELO [10.99.249.83]) ([10.99.249.83])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2022 03:57:13 -0700
Message-ID: <a101a10a-4fbb-5fae-2e3c-76cf96ed8fbd@linux.intel.com>
Date:   Thu, 13 Oct 2022 12:57:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Content-Language: en-US
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org,
        Cezary Rojewski <cezary.rojewski@intel.com>
From:   =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
Subject: KASAN on SSDT override
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEXHASH_WORD,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Ard,

since v6.0-rc1 we seem to occasionally hit KASAN warning on one of the 
platforms where we override SSDT.

I seem to have narrowed it down to merge commit 
97a77ab14ffac749ec2419c92ec2954111c22d22, I suspect that it is caused by 
3881ee0b1edce0ece72d24b7c74f46b73bd6dcba, but as the issue happens 
sporadically it is bit hard to narrow it down.

Do you have any idea for potential fix?

Following is KASAN warning that we see:

[    6.367849] efi: loading SSDT from variable 
rt298-feec8565-23da-477c-a92d-9e0d5216fd74
[    6.367851] ACPI: Host-directed Dynamic ACPI Table Load:
[    6.367851] ACPI: SSDT 0xFFFF88810457F000 000122 (v01 INTEL  ALC298 
00000000 INTL 20180105)
[    6.584455] 
==================================================================
[    6.584455] BUG: KASAN: use-after-free in acpi_ns_repair_HID+0x125/0x242
[    6.584455] Read of size 1 at addr ffff88810457f0d3 by task 
kworker/0:1/18

[    6.584551] CPU: 0 PID: 18 Comm: kworker/0:1 Not tainted 5.19.0+ #100
[    6.584697] Hardware name: Intel Corporation Kabylake Client 
platform/Kabylake R DDR4 RVP, BIOS KBLSE2R1.R00.X142.P00.1809060233 
09/06/2018
[    6.584857] Workqueue: events acpi_table_events_fn
[    6.585006] Call Trace:
[    6.585023]  <TASK>
[    6.585038]  dump_stack_lvl+0x49/0x63
[    6.585190]  print_report.cold+0x5e/0x5d3
[    6.585338]  ? acpi_ns_repair_HID+0x125/0x242
[    6.585482]  kasan_report+0xaa/0x120
[    6.585513]  ? acpi_ns_repair_HID+0x125/0x242
[    6.585661]  __asan_load1+0x6e/0x80
[    6.585805]  acpi_ns_repair_HID+0x125/0x242
[    6.585951]  acpi_ns_repair_CID+0x62/0x18e
[    6.586099]  acpi_ns_complex_repairs+0xb0/0xec
[    6.586129]  ? acpi_ns_repair_HID+0x242/0x242
[    6.586278]  acpi_ns_check_return_value+0x16f/0x1bf
[    6.586429]  acpi_ns_evaluate+0x69a/0x811
[    6.586455]  acpi_ut_evaluate_object+0xe3/0x301
[    6.586481]  acpi_ut_execute_CID+0xb1/0x344
[    6.586504]  ? acpi_ut_execute_UID+0x1b1/0x1f3
[    6.586527]  ? acpi_ut_execute_UID+0x1f3/0x1f3
[    6.586549]  ? acpi_os_signal_semaphore+0xa6/0xd0
[    6.586574]  ? acpi_ut_release_mutex+0x1cb/0x1e0
[    6.586599]  acpi_get_object_info+0x206/0x5cd
[    6.586626]  ? acpi_ns_copy_device_id+0x6f/0x6f
[    6.586649]  ? up+0x4b/0x70
[    6.586671]  ? acpi_os_signal_semaphore+0xa6/0xd0
[    6.586702]  acpi_init_device_object+0x5b5/0xd00
[    6.586729]  ? acpi_iommu_fwspec_init+0xc0/0xc0
[    6.586752]  ? acpi_get_handle+0x103/0x154
[    6.586774]  ? acpi_get_data+0x16/0x16
[    6.586798]  ? __kasan_kmalloc+0xae/0xe0
[    6.586821]  ? kmem_cache_alloc_trace+0x19c/0x340
[    6.586847]  acpi_add_single_object+0xe6/0xd20
[    6.586871]  ? acpi_scan_check_dep+0xdb/0x380
[    6.586895]  ? get_acpi_device+0x30/0x30
[    6.586917]  ? acpi_init_device_object+0xd00/0xd00
[    6.586940]  ? preempt_count_sub+0x18/0xc0
[    6.586964]  ? _raw_spin_unlock_irqrestore+0x27/0x50
[    6.586987]  ? up+0x4b/0x70
[    6.587008]  ? acpi_os_signal_semaphore+0xa6/0xd0
[    6.587033]  ? acpi_ut_release_mutex+0x1cb/0x1e0
[    6.587060]  acpi_bus_check_add+0x1aa/0x3c0
[    6.587082]  ? __kasan_check_write+0x14/0x20
[    6.587106]  ? acpi_add_single_object+0xd20/0xd20
[    6.587132]  ? wake_up_process+0x15/0x20
[    6.587153]  ? preempt_count_sub+0x18/0xc0
[    6.587176]  ? _raw_spin_unlock_irqrestore+0x27/0x50
[    6.587199]  ? up+0x4b/0x70
[    6.587220]  ? acpi_os_signal_semaphore+0xa6/0xd0
[    6.587247]  acpi_bus_check_add_1+0x16/0x20
[    6.587269]  acpi_ns_walk_namespace+0x183/0x308
[    6.587293]  ? acpi_bus_check_add_2+0x20/0x20
[    6.587316]  ? acpi_bus_check_add_2+0x20/0x20
[    6.587340]  acpi_walk_namespace+0xfa/0x14b
[    6.587366]  acpi_bus_scan+0x13a/0x180
[    6.587390]  ? acpi_bus_check_add_1+0x20/0x20
[    6.587421]  ? __mutex_lock_slowpath+0x20/0x20
[    6.587455]  ? _raw_spin_unlock_bh+0x30/0x30
[    6.587487]  acpi_table_events_fn+0x26/0x50
[    6.587520]  process_one_work+0x452/0x740
[    6.587559]  worker_thread+0x2bb/0x6f0
[    6.587597]  ? process_one_work+0x740/0x740
[    6.587629]  kthread+0x175/0x1b0
[    6.587656]  ? kthread_complete_and_exit+0x30/0x30
[    6.587691]  ret_from_fork+0x1f/0x30
[    6.587700]  </TASK>

[    6.587700] Allocated by task 1:
[    6.587700]  kasan_save_stack+0x26/0x50
[    6.587700]  __kasan_kmalloc+0xae/0xe0
[    6.587700]  __kmalloc+0x1cc/0x3c0
[    6.587700]  efisubsys_init+0x371/0x778
[    6.587700]  do_one_initcall+0x97/0x2d0
[    6.587700]  kernel_init_freeable+0x3ca/0x459
[    6.587700]  kernel_init+0x1f/0x180
[    6.587700]  ret_from_fork+0x1f/0x30

[    6.587700] Freed by task 1:
[    6.587700]  kasan_save_stack+0x26/0x50
[    6.587700]  kasan_set_track+0x25/0x40
[    6.587700]  kasan_set_free_info+0x24/0x40
[    6.587700]  ____kasan_slab_free+0x177/0x1c0
[    6.587700]  __kasan_slab_free+0x12/0x20
[    6.587700]  slab_free_freelist_hook+0x97/0x1b0
[    6.587700]  kfree+0x1a9/0x3d0
[    6.587700]  efisubsys_init+0x3c8/0x778
[    6.587700]  do_one_initcall+0x97/0x2d0
[    6.587700]  kernel_init_freeable+0x3ca/0x459
[    6.587700]  kernel_init+0x1f/0x180
[    6.587700]  ret_from_fork+0x1f/0x30

[    6.587700] The buggy address belongs to the object at ffff88810457f000
                 which belongs to the cache kmalloc-512 of size 512
[    6.587700] The buggy address is located 211 bytes inside of
                 512-byte region [ffff88810457f000, ffff88810457f200)

[    6.587700] The buggy address belongs to the physical page:
[    6.587700] page:0000000009e09455 refcount:1 mapcount:0 
mapping:0000000000000000 index:0x0 pfn:0x10457c
[    6.587700] head:0000000009e09455 order:2 compound_mapcount:0 
compound_pincount:0
[    6.587700] flags: 
0x17ffffc0010200(slab|head|node=0|zone=2|lastcpupid=0x1fffff)
[    6.587700] raw: 0017ffffc0010200 0000000000000000 dead000000000122 
ffff888100042c80
[    6.587700] raw: 0000000000000000 0000000080100010 00000001ffffffff 
0000000000000000
[    6.587700] page dumped because: kasan: bad access detected

[    6.587700] Memory state around the buggy address:
[    6.587700]  ffff88810457ef80: fc fc fc fc fc fc fc fc fc fc fc fc fc 
fc fc fc
[    6.587700]  ffff88810457f000: fa fb fb fb fb fb fb fb fb fb fb fb fb 
fb fb fb
[    6.587700] >ffff88810457f080: fb fb fb fb fb fb fb fb fb fb fb fb fb 
fb fb fb
[    6.587700]                                                  ^
[    6.587700]  ffff88810457f100: fb fb fb fb fb fb fb fb fb fb fb fb fb 
fb fb fb
[    6.587700]  ffff88810457f180: fb fb fb fb fb fb fb fb fb fb fb fb fb 
fb fb fb
[    6.587700] 
==================================================================

Thanks,
Amadeusz
