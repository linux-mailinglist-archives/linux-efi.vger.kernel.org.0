Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 111A75FD813
	for <lists+linux-efi@lfdr.de>; Thu, 13 Oct 2022 13:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbiJMLFt (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 13 Oct 2022 07:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiJMLFr (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 13 Oct 2022 07:05:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4D9E105647
        for <linux-efi@vger.kernel.org>; Thu, 13 Oct 2022 04:05:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 89565B81C48
        for <linux-efi@vger.kernel.org>; Thu, 13 Oct 2022 11:05:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25D6AC433C1
        for <linux-efi@vger.kernel.org>; Thu, 13 Oct 2022 11:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665659143;
        bh=p4cD8OBbLizSs4+VUk4rpzAmtmYyQIuHe25plYpK/yg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=k3RBDwfXbN+uXTmWPvfwq/gxrxeLz+NB4XmOiknBYiRNxuDaSGBakGIZGBOBmc17Y
         So462KvbvkE2s3XM6WvhSjLz5shxkHW4a/NR1oPxNtB5w7mF6Ym+xP9ueQ9Ip18nNf
         zTXOWzlVN+l4yPLXNRi9NnAlsQm5tCSbtiXF9T4GcE5b42nntSnyRLI61E2qj4ldts
         eJ2LZQ+Q0D0Yy2xTMllONPxBTySEE9m4vdpthgGMhRYmuvgxgin3D36WDQwrgO6kdn
         BIogfYbvNXm3AOQtBHzFY+cHY4uUNPbYnV0EDq5OJ7UM3817uoNHW9tdUkGcBH4GBH
         y6GM+ppmNawXA==
Received: by mail-lj1-f171.google.com with SMTP id f9so1841037ljk.12
        for <linux-efi@vger.kernel.org>; Thu, 13 Oct 2022 04:05:43 -0700 (PDT)
X-Gm-Message-State: ACrzQf0lthWSWyuEJuU1kEtJAE5plJNcmie/e9JSDI/Y/oQf0NzRTnBf
        6ALhpnhqjzrNkl3srzn64WYuKlaDdKjyrtBohOw=
X-Google-Smtp-Source: AMsMyM5GyK0Ly5bUufhIzQP7PMG7acTe4p8k6O68hZRmrXZ2rn2XQ/xU6SYsUvAzeNuFUl0K6ua9TogWzmaCQ9qG6NU=
X-Received: by 2002:a2e:b635:0:b0:26e:989e:438f with SMTP id
 s21-20020a2eb635000000b0026e989e438fmr8222444ljn.189.1665659141066; Thu, 13
 Oct 2022 04:05:41 -0700 (PDT)
MIME-Version: 1.0
References: <a101a10a-4fbb-5fae-2e3c-76cf96ed8fbd@linux.intel.com>
In-Reply-To: <a101a10a-4fbb-5fae-2e3c-76cf96ed8fbd@linux.intel.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 13 Oct 2022 13:05:29 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGVDEC1rpTBi5YKLA4QeFe7Gps8NScCvUnFmJ2rO3Y0Ow@mail.gmail.com>
Message-ID: <CAMj1kXGVDEC1rpTBi5YKLA4QeFe7Gps8NScCvUnFmJ2rO3Y0Ow@mail.gmail.com>
Subject: Re: KASAN on SSDT override
To:     =?UTF-8?B?QW1hZGV1c3ogU8WCYXdpxYRza2k=?= 
        <amadeuszx.slawinski@linux.intel.com>
Cc:     linux-efi@vger.kernel.org,
        Cezary Rojewski <cezary.rojewski@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 13 Oct 2022 at 12:57, Amadeusz S=C5=82awi=C5=84ski
<amadeuszx.slawinski@linux.intel.com> wrote:
>
> Hi Ard,
>
> since v6.0-rc1 we seem to occasionally hit KASAN warning on one of the
> platforms where we override SSDT.
>
> I seem to have narrowed it down to merge commit
> 97a77ab14ffac749ec2419c92ec2954111c22d22, I suspect that it is caused by
> 3881ee0b1edce0ece72d24b7c74f46b73bd6dcba, but as the issue happens
> sporadically it is bit hard to narrow it down.
>
> Do you have any idea for potential fix?
>

Yes, it seems that data should only be kfree()'d if the
acpi_load_table() call returns an error. I missed that when I did the
conversion


> Following is KASAN warning that we see:
>
> [    6.367849] efi: loading SSDT from variable
> rt298-feec8565-23da-477c-a92d-9e0d5216fd74
> [    6.367851] ACPI: Host-directed Dynamic ACPI Table Load:
> [    6.367851] ACPI: SSDT 0xFFFF88810457F000 000122 (v01 INTEL  ALC298
> 00000000 INTL 20180105)
> [    6.584455]
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [    6.584455] BUG: KASAN: use-after-free in acpi_ns_repair_HID+0x125/0x2=
42
> [    6.584455] Read of size 1 at addr ffff88810457f0d3 by task
> kworker/0:1/18
>
> [    6.584551] CPU: 0 PID: 18 Comm: kworker/0:1 Not tainted 5.19.0+ #100
> [    6.584697] Hardware name: Intel Corporation Kabylake Client
> platform/Kabylake R DDR4 RVP, BIOS KBLSE2R1.R00.X142.P00.1809060233
> 09/06/2018
> [    6.584857] Workqueue: events acpi_table_events_fn
> [    6.585006] Call Trace:
> [    6.585023]  <TASK>
> [    6.585038]  dump_stack_lvl+0x49/0x63
> [    6.585190]  print_report.cold+0x5e/0x5d3
> [    6.585338]  ? acpi_ns_repair_HID+0x125/0x242
> [    6.585482]  kasan_report+0xaa/0x120
> [    6.585513]  ? acpi_ns_repair_HID+0x125/0x242
> [    6.585661]  __asan_load1+0x6e/0x80
> [    6.585805]  acpi_ns_repair_HID+0x125/0x242
> [    6.585951]  acpi_ns_repair_CID+0x62/0x18e
> [    6.586099]  acpi_ns_complex_repairs+0xb0/0xec
> [    6.586129]  ? acpi_ns_repair_HID+0x242/0x242
> [    6.586278]  acpi_ns_check_return_value+0x16f/0x1bf
> [    6.586429]  acpi_ns_evaluate+0x69a/0x811
> [    6.586455]  acpi_ut_evaluate_object+0xe3/0x301
> [    6.586481]  acpi_ut_execute_CID+0xb1/0x344
> [    6.586504]  ? acpi_ut_execute_UID+0x1b1/0x1f3
> [    6.586527]  ? acpi_ut_execute_UID+0x1f3/0x1f3
> [    6.586549]  ? acpi_os_signal_semaphore+0xa6/0xd0
> [    6.586574]  ? acpi_ut_release_mutex+0x1cb/0x1e0
> [    6.586599]  acpi_get_object_info+0x206/0x5cd
> [    6.586626]  ? acpi_ns_copy_device_id+0x6f/0x6f
> [    6.586649]  ? up+0x4b/0x70
> [    6.586671]  ? acpi_os_signal_semaphore+0xa6/0xd0
> [    6.586702]  acpi_init_device_object+0x5b5/0xd00
> [    6.586729]  ? acpi_iommu_fwspec_init+0xc0/0xc0
> [    6.586752]  ? acpi_get_handle+0x103/0x154
> [    6.586774]  ? acpi_get_data+0x16/0x16
> [    6.586798]  ? __kasan_kmalloc+0xae/0xe0
> [    6.586821]  ? kmem_cache_alloc_trace+0x19c/0x340
> [    6.586847]  acpi_add_single_object+0xe6/0xd20
> [    6.586871]  ? acpi_scan_check_dep+0xdb/0x380
> [    6.586895]  ? get_acpi_device+0x30/0x30
> [    6.586917]  ? acpi_init_device_object+0xd00/0xd00
> [    6.586940]  ? preempt_count_sub+0x18/0xc0
> [    6.586964]  ? _raw_spin_unlock_irqrestore+0x27/0x50
> [    6.586987]  ? up+0x4b/0x70
> [    6.587008]  ? acpi_os_signal_semaphore+0xa6/0xd0
> [    6.587033]  ? acpi_ut_release_mutex+0x1cb/0x1e0
> [    6.587060]  acpi_bus_check_add+0x1aa/0x3c0
> [    6.587082]  ? __kasan_check_write+0x14/0x20
> [    6.587106]  ? acpi_add_single_object+0xd20/0xd20
> [    6.587132]  ? wake_up_process+0x15/0x20
> [    6.587153]  ? preempt_count_sub+0x18/0xc0
> [    6.587176]  ? _raw_spin_unlock_irqrestore+0x27/0x50
> [    6.587199]  ? up+0x4b/0x70
> [    6.587220]  ? acpi_os_signal_semaphore+0xa6/0xd0
> [    6.587247]  acpi_bus_check_add_1+0x16/0x20
> [    6.587269]  acpi_ns_walk_namespace+0x183/0x308
> [    6.587293]  ? acpi_bus_check_add_2+0x20/0x20
> [    6.587316]  ? acpi_bus_check_add_2+0x20/0x20
> [    6.587340]  acpi_walk_namespace+0xfa/0x14b
> [    6.587366]  acpi_bus_scan+0x13a/0x180
> [    6.587390]  ? acpi_bus_check_add_1+0x20/0x20
> [    6.587421]  ? __mutex_lock_slowpath+0x20/0x20
> [    6.587455]  ? _raw_spin_unlock_bh+0x30/0x30
> [    6.587487]  acpi_table_events_fn+0x26/0x50
> [    6.587520]  process_one_work+0x452/0x740
> [    6.587559]  worker_thread+0x2bb/0x6f0
> [    6.587597]  ? process_one_work+0x740/0x740
> [    6.587629]  kthread+0x175/0x1b0
> [    6.587656]  ? kthread_complete_and_exit+0x30/0x30
> [    6.587691]  ret_from_fork+0x1f/0x30
> [    6.587700]  </TASK>
>
> [    6.587700] Allocated by task 1:
> [    6.587700]  kasan_save_stack+0x26/0x50
> [    6.587700]  __kasan_kmalloc+0xae/0xe0
> [    6.587700]  __kmalloc+0x1cc/0x3c0
> [    6.587700]  efisubsys_init+0x371/0x778
> [    6.587700]  do_one_initcall+0x97/0x2d0
> [    6.587700]  kernel_init_freeable+0x3ca/0x459
> [    6.587700]  kernel_init+0x1f/0x180
> [    6.587700]  ret_from_fork+0x1f/0x30
>
> [    6.587700] Freed by task 1:
> [    6.587700]  kasan_save_stack+0x26/0x50
> [    6.587700]  kasan_set_track+0x25/0x40
> [    6.587700]  kasan_set_free_info+0x24/0x40
> [    6.587700]  ____kasan_slab_free+0x177/0x1c0
> [    6.587700]  __kasan_slab_free+0x12/0x20
> [    6.587700]  slab_free_freelist_hook+0x97/0x1b0
> [    6.587700]  kfree+0x1a9/0x3d0
> [    6.587700]  efisubsys_init+0x3c8/0x778
> [    6.587700]  do_one_initcall+0x97/0x2d0
> [    6.587700]  kernel_init_freeable+0x3ca/0x459
> [    6.587700]  kernel_init+0x1f/0x180
> [    6.587700]  ret_from_fork+0x1f/0x30
>
> [    6.587700] The buggy address belongs to the object at ffff88810457f00=
0
>                  which belongs to the cache kmalloc-512 of size 512
> [    6.587700] The buggy address is located 211 bytes inside of
>                  512-byte region [ffff88810457f000, ffff88810457f200)
>
> [    6.587700] The buggy address belongs to the physical page:
> [    6.587700] page:0000000009e09455 refcount:1 mapcount:0
> mapping:0000000000000000 index:0x0 pfn:0x10457c
> [    6.587700] head:0000000009e09455 order:2 compound_mapcount:0
> compound_pincount:0
> [    6.587700] flags:
> 0x17ffffc0010200(slab|head|node=3D0|zone=3D2|lastcpupid=3D0x1fffff)
> [    6.587700] raw: 0017ffffc0010200 0000000000000000 dead000000000122
> ffff888100042c80
> [    6.587700] raw: 0000000000000000 0000000080100010 00000001ffffffff
> 0000000000000000
> [    6.587700] page dumped because: kasan: bad access detected
>
> [    6.587700] Memory state around the buggy address:
> [    6.587700]  ffff88810457ef80: fc fc fc fc fc fc fc fc fc fc fc fc fc
> fc fc fc
> [    6.587700]  ffff88810457f000: fa fb fb fb fb fb fb fb fb fb fb fb fb
> fb fb fb
> [    6.587700] >ffff88810457f080: fb fb fb fb fb fb fb fb fb fb fb fb fb
> fb fb fb
> [    6.587700]                                                  ^
> [    6.587700]  ffff88810457f100: fb fb fb fb fb fb fb fb fb fb fb fb fb
> fb fb fb
> [    6.587700]  ffff88810457f180: fb fb fb fb fb fb fb fb fb fb fb fb fb
> fb fb fb
> [    6.587700]
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Thanks,
> Amadeusz
