Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9C28610D74
	for <lists+linux-efi@lfdr.de>; Fri, 28 Oct 2022 11:39:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229455AbiJ1Jjd (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 28 Oct 2022 05:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiJ1Jjd (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 28 Oct 2022 05:39:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5696DC705B
        for <linux-efi@vger.kernel.org>; Fri, 28 Oct 2022 02:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666949906;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TlMk3uxOck66xP/DItTJRLFsn0WbLnFlNMTolGNe6+4=;
        b=PSU3tBJ+5rbamSGKTbldbavOsMmFruePGHMUebGikqaTKm5OwwqOVrk7Fy7DmlCJkIty4w
        AkJtwJExLhuPbEpUaWwzTn6LSxChL6jxazD27X6i79j8UhizfWif3Cwc7W5FD1wvG9BUb7
        fZ88WAwmbGh2LXqcUtGRDLSGQWocE84=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-363-KZD4WZ7JOIGIdILv6WxeSA-1; Fri, 28 Oct 2022 05:38:09 -0400
X-MC-Unique: KZD4WZ7JOIGIdILv6WxeSA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DB9591024D09;
        Fri, 28 Oct 2022 09:38:07 +0000 (UTC)
Received: from [10.64.54.151] (vpn2-54-151.bne.redhat.com [10.64.54.151])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 35FD91402BD9;
        Fri, 28 Oct 2022 09:38:05 +0000 (UTC)
Reply-To: Gavin Shan <gshan@redhat.com>
Subject: Re: [Issue] EFI runtime-wrapper is broken
To:     Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
References: <d799b60c-ff4e-44ae-84be-d9ade761ec6d@redhat.com>
 <CAMj1kXHDtwkMgqqwePEKdOdO=7-1_TYyuVNPJ7PkyreaMySjCw@mail.gmail.com>
From:   Gavin Shan <gshan@redhat.com>
Message-ID: <d469f6b9-d23a-abe6-27b7-f58f9de12a45@redhat.com>
Date:   Fri, 28 Oct 2022 17:38:03 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <CAMj1kXHDtwkMgqqwePEKdOdO=7-1_TYyuVNPJ7PkyreaMySjCw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Ard,

On 10/28/22 5:21 PM, Ard Biesheuvel wrote:
> On Fri, 28 Oct 2022 at 11:10, Gavin Shan <gshan@redhat.com> wrote:
>> I ran into the following crash with v6.1.rc2. I'm not sure if it's known
>> issue. Last good version is v6.0.rc6/rc7. The kernel configuration is attached.
> 
> This is probably related to the patch below. It means the firmware is
> buggy, and does not work as it should if the firmware never calls
> SetVirtualAddressMap() [and doing so is explicitly described as
> OPTIONAL by the EFI specification].
> 
> The problem here is that other EFI implementations (primarily the
> Qualcomm ones used on Windows-on-ARM laptops) are buggy too, and don't
> tolerate SetVirtualAddressMap().
> 
> Can you try whether reverting the patch below helps?
> 

I ran into the issue on server, equipped with Ampere CPUs. With d3549a938b73
reverted, the crash disappeared.

Thanks,
Gavin
  
> 
> commit d3549a938b73f203ef522562ae9f2d38aa43d234
> Author: Ard Biesheuvel <ardb@kernel.org>
> Date:   Fri Sep 16 11:48:30 2022 +0200
> 
>      efi/arm64: libstub: avoid SetVirtualAddressMap() when possible
> 
>      EFI's SetVirtualAddressMap() runtime service is a horrid hack that we'd
>      like to avoid using, if possible. For 64-bit architectures such as
>      arm64, the user and kernel mappings are entirely disjoint, and given
>      that we use the user region for mapping the UEFI runtime regions when
>      running under the OS, we don't rely on SetVirtualAddressMap() in the
>      conventional way, i.e., to permit kernel mappings of the OS to coexist
>      with kernel region mappings of the firmware regions. This means that, in
>      principle, we should be able to avoid SetVirtualAddressMap() altogether,
>      and simply use the 1:1 mapping that UEFI uses at boot time. (Note that
>      omitting SetVirtualAddressMap() is explicitly permitted by the UEFI
>      spec).
> 
>      However, there is a corner case on arm64, which, if configured for
>      3-level paging (or 2-level paging when using 64k pages), may not be able
>      to cover the entire range of firmware mappings (which might contain both
>      memory and MMIO peripheral mappings).
> 
>      So let's avoid SetVirtualAddressMap() on arm64, but only if the VA space
>      is guaranteed to be of sufficient size.
> 
>      Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> 
> 
> 
>> [   71.281677] Unable to handle kernel paging request at virtual address 00000000a934da68
>> [   71.289593] Mem abort info:
>> [   71.292375]   ESR = 0x0000000096000006
>> [   71.296111]   EC = 0x25: DABT (current EL), IL = 32 bits
>> [   71.301411]   SET = 0, FnV = 0
>> [   71.304453]   EA = 0, S1PTW = 0
>> [   71.307581]   FSC = 0x06: level 2 translation fault
>> [   71.312446] Data abort info:
>> [   71.315315]   ISV = 0, ISS = 0x00000006
>> [   71.319138]   CM = 0, WnR = 0
>> [   71.322094] user pgtable: 4k pages, 48-bit VAs, pgdp=0000080046ad6000
>> [   71.328522] [00000000a934da68] pgd=0000000000000000, p4d=0000000000000000
>> [   71.335299] Internal error: Oops: 0000000096000006 [#1] SMP
>> [   71.340860] Modules linked in: bridge stp llc qrtr rfkill sunrpc vfat fat mlx5_ib ib_uverbs cdc_ether usbnet mii ib_core acpi_ipmi ipmi_ssif arm_spe_pmu ipmi_devintf ipmi_msghandler arm_cmn arm_dmc620_pmu arm_dsu_pmu cppc_cpufreq xfs libcrc32c ast drm_vram_helper drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops drm_ttm_helper ttm mlx5_core crct10dif_ce ghash_ce sha2_ce sha256_arm64 sha1_ce drm sbsa_gwdt mlxfw tls nvme igb nvme_core psample nvme_common i2c_algo_bit pci_hyperv_intf i2c_designware_platform i2c_designware_core xgene_hwmon dm_mirror dm_region_hash dm_log dm_mod fuse
>> [   71.393089] CPU: 94 PID: 1563 Comm: kworker/u320:3 Not tainted 6.1.0-rc2-gavin+ #6
>> [   71.400646] Hardware name: FOXCONN Mt. Collins/Mt. Collins, BIOS 0ACOC017 (SCP: 1.08.20210825) 10/22/2021
>> [   71.410200] Workqueue: efi_rts_wq efi_call_rts
>> [   71.414636] pstate: 204000c9 (nzCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>> [   71.421585] pc : 0xb7ec7ae4
>> [   71.424367] lr : 0xb7ec8668
>> [   71.427149] sp : ffff80002f0e37e0
>> [   71.430452] x29: ffff80002f0e37e0 x28: ffffa4efa13bb0d0 x27: ffffa4efa0e32a18
>> [   71.437575] x26: ffff3fff93ce2d74 x25: ffff3fff90793805 x24: 0000000000000000
>> [   71.444698] x23: 0000000000000000 x22: 0000000000000000 x21: ffffa4efa06f0750
>> [   71.451821] x20: ffff8000279fbcc8 x19: ffffa4efa1df2a80 x18: 0000000000000000
>> [   71.458944] x17: 0000000000000000 x16: 0000000000000000 x15: 0000aaab19a5fb90
>> [   71.466067] x14: 0000000000000000 x13: 0000000000000010 x12: 0101010101010101
>> [   71.473190] x11: 7f7f7f7f7f7f7f7f x10: fefefefefeff7076 x9 : ffffa4ef9f5f7570
>> [   71.480313] x8 : 00000000b7cc05b8 x7 : ffff80002f0e3b60 x6 : ffff80002f0e3c00
>> [   71.487436] x5 : ffff80002f0e3b58 x4 : 00000000b7e81358 x3 : 00000000b7ec8600
>> [   71.494559] x2 : 0000000001000000 x1 : 0000000001000000 x0 : 00000000a934da60
>> [   71.501682] Call trace:
>> [   71.504116]  0xb7ec7ae4
>> [   71.506551]  0xb7ec8668
>> [   71.508985]  0xb7ec6e08
>> [   71.511419]  0xb7ec68ec
>> [   71.513853]  0xb7ec3824
>> [   71.516287]  0xb7ec05a8
>> [   71.518721]  0xb7ec12a0
>> [   71.521155]  0xb7e53524
>> [   71.523590]  0xb7e53670
>> [   71.526024]  0xb7e582f0
>> [   71.528458]  0xb7e5909c
>> [   71.530892]  0xb7e5a014
>> [   71.533326]  0xb7e508a8
>> [   71.535760]  0xb7cc3328
>> [   71.538195]  0xb7cc0674
>> [   71.540629]  __efi_rt_asm_wrapper+0x2c/0x48
>> [   71.544802]  efi_call_rts+0x2a8/0x440
>> [   71.548454]  process_one_work+0x1e4/0x460
>> [   71.552452]  worker_thread+0x74/0x414
>> [   71.556103]  kthread+0xf0/0xf4
>> [   71.559147]  ret_from_fork+0x10/0x20
>> [   71.562712] Code: 90000000 912c2000 f9400000 f9400000 (f9400401)
>> [   71.568794] ---[ end trace 0000000000000000 ]---
>> [   71.573401] Kernel panic - not syncing: Oops: Fatal exception in interrupt
>> [   71.580263] SMP: stopping secondary CPUs
>> [   71.584932] Kernel Offset: 0x24ef975e0000 from 0xffff800008000000
>> [   71.591012] PHYS_OFFSET: 0x80000000
>> [   71.594488] CPU features: 0x00000,001700a4,6601720b
>> [   71.599353] Memory Limit: none
>> [   71.602395] ---[ end Kernel panic - not syncing: Oops: Fatal exception in interrupt ]---
>>
>> Thanks,
>> Gavin
>>
> 

