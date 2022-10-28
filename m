Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A8AC610CF6
	for <lists+linux-efi@lfdr.de>; Fri, 28 Oct 2022 11:21:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbiJ1JVa (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 28 Oct 2022 05:21:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbiJ1JV3 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 28 Oct 2022 05:21:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88096189837
        for <linux-efi@vger.kernel.org>; Fri, 28 Oct 2022 02:21:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 24329626E4
        for <linux-efi@vger.kernel.org>; Fri, 28 Oct 2022 09:21:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81FAAC433B5
        for <linux-efi@vger.kernel.org>; Fri, 28 Oct 2022 09:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666948887;
        bh=eEkZPtst0MFgZScq/MptQuWYqED2ck+nzm7YjKzIpSs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=md6IUFp9NovZEM253LDfrR6Y0Y9A6R6Izx0Ernha1z4TuaSp1IlGC+NNZLTpDvubO
         W7GanlFIL5XF1KLdKXi9Ed2uomu4SIYv4BHZbA3jitiQO+ETAekdS5xLfZK6nmuRVe
         5oSr0ISJ7bVo4XOeWLX/94kt+9oYBjMQDCYZc3wjv4iJ/vyI7x4joJQV4RE4d3off/
         hhEchFpS/+nKqowze3PEkJASaY/u0CrOCK4x0g96GwOKyRqlFgyIXzbueOcLu5AJFN
         zTPIPfM4BV5ZspZEabQabDSNYE6asP6OC0OU6Uwb3gePQZLpE+AuXhJlEgHaugKt95
         e2im+XYyZT1YQ==
Received: by mail-lj1-f175.google.com with SMTP id z24so7608945ljn.4
        for <linux-efi@vger.kernel.org>; Fri, 28 Oct 2022 02:21:27 -0700 (PDT)
X-Gm-Message-State: ACrzQf0cxdmhPgv6VrbWaRDshsxd2UASrrA49dMRrd6J40EKuAstWaAr
        /OUsnt/zM6opSZuDOICsSSWCJ30cZb1KywAQjr0=
X-Google-Smtp-Source: AMsMyM5rSizTW67n11AEHhWlkghOcNwrbvOpka2pDvrcX7yxCV3foClsKxb5qwi9mx/Go7+5VmvHG+m81JpIywGFsv8=
X-Received: by 2002:a05:651c:1590:b0:26c:4311:9b84 with SMTP id
 h16-20020a05651c159000b0026c43119b84mr21700737ljq.152.1666948885444; Fri, 28
 Oct 2022 02:21:25 -0700 (PDT)
MIME-Version: 1.0
References: <d799b60c-ff4e-44ae-84be-d9ade761ec6d@redhat.com>
In-Reply-To: <d799b60c-ff4e-44ae-84be-d9ade761ec6d@redhat.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 28 Oct 2022 11:21:14 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHDtwkMgqqwePEKdOdO=7-1_TYyuVNPJ7PkyreaMySjCw@mail.gmail.com>
Message-ID: <CAMj1kXHDtwkMgqqwePEKdOdO=7-1_TYyuVNPJ7PkyreaMySjCw@mail.gmail.com>
Subject: Re: [Issue] EFI runtime-wrapper is broken
To:     Gavin Shan <gshan@redhat.com>,
        linux-efi <linux-efi@vger.kernel.org>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 28 Oct 2022 at 11:10, Gavin Shan <gshan@redhat.com> wrote:
>
> Hi Ard,
>
> I ran into the following crash with v6.1.rc2. I'm not sure if it's known
> issue. Last good version is v6.0.rc6/rc7. The kernel configuration is att=
ached.
>

Hello Gavin,

This is probably related to the patch below. It means the firmware is
buggy, and does not work as it should if the firmware never calls
SetVirtualAddressMap() [and doing so is explicitly described as
OPTIONAL by the EFI specification].

The problem here is that other EFI implementations (primarily the
Qualcomm ones used on Windows-on-ARM laptops) are buggy too, and don't
tolerate SetVirtualAddressMap().

Can you try whether reverting the patch below helps?




commit d3549a938b73f203ef522562ae9f2d38aa43d234
Author: Ard Biesheuvel <ardb@kernel.org>
Date:   Fri Sep 16 11:48:30 2022 +0200

    efi/arm64: libstub: avoid SetVirtualAddressMap() when possible

    EFI's SetVirtualAddressMap() runtime service is a horrid hack that we'd
    like to avoid using, if possible. For 64-bit architectures such as
    arm64, the user and kernel mappings are entirely disjoint, and given
    that we use the user region for mapping the UEFI runtime regions when
    running under the OS, we don't rely on SetVirtualAddressMap() in the
    conventional way, i.e., to permit kernel mappings of the OS to coexist
    with kernel region mappings of the firmware regions. This means that, i=
n
    principle, we should be able to avoid SetVirtualAddressMap() altogether=
,
    and simply use the 1:1 mapping that UEFI uses at boot time. (Note that
    omitting SetVirtualAddressMap() is explicitly permitted by the UEFI
    spec).

    However, there is a corner case on arm64, which, if configured for
    3-level paging (or 2-level paging when using 64k pages), may not be abl=
e
    to cover the entire range of firmware mappings (which might contain bot=
h
    memory and MMIO peripheral mappings).

    So let's avoid SetVirtualAddressMap() on arm64, but only if the VA spac=
e
    is guaranteed to be of sufficient size.

    Signed-off-by: Ard Biesheuvel <ardb@kernel.org>



> [   71.281677] Unable to handle kernel paging request at virtual address =
00000000a934da68
> [   71.289593] Mem abort info:
> [   71.292375]   ESR =3D 0x0000000096000006
> [   71.296111]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
> [   71.301411]   SET =3D 0, FnV =3D 0
> [   71.304453]   EA =3D 0, S1PTW =3D 0
> [   71.307581]   FSC =3D 0x06: level 2 translation fault
> [   71.312446] Data abort info:
> [   71.315315]   ISV =3D 0, ISS =3D 0x00000006
> [   71.319138]   CM =3D 0, WnR =3D 0
> [   71.322094] user pgtable: 4k pages, 48-bit VAs, pgdp=3D0000080046ad600=
0
> [   71.328522] [00000000a934da68] pgd=3D0000000000000000, p4d=3D000000000=
0000000
> [   71.335299] Internal error: Oops: 0000000096000006 [#1] SMP
> [   71.340860] Modules linked in: bridge stp llc qrtr rfkill sunrpc vfat =
fat mlx5_ib ib_uverbs cdc_ether usbnet mii ib_core acpi_ipmi ipmi_ssif arm_=
spe_pmu ipmi_devintf ipmi_msghandler arm_cmn arm_dmc620_pmu arm_dsu_pmu cpp=
c_cpufreq xfs libcrc32c ast drm_vram_helper drm_kms_helper syscopyarea sysf=
illrect sysimgblt fb_sys_fops drm_ttm_helper ttm mlx5_core crct10dif_ce gha=
sh_ce sha2_ce sha256_arm64 sha1_ce drm sbsa_gwdt mlxfw tls nvme igb nvme_co=
re psample nvme_common i2c_algo_bit pci_hyperv_intf i2c_designware_platform=
 i2c_designware_core xgene_hwmon dm_mirror dm_region_hash dm_log dm_mod fus=
e
> [   71.393089] CPU: 94 PID: 1563 Comm: kworker/u320:3 Not tainted 6.1.0-r=
c2-gavin+ #6
> [   71.400646] Hardware name: FOXCONN Mt. Collins/Mt. Collins, BIOS 0ACOC=
017 (SCP: 1.08.20210825) 10/22/2021
> [   71.410200] Workqueue: efi_rts_wq efi_call_rts
> [   71.414636] pstate: 204000c9 (nzCv daIF +PAN -UAO -TCO -DIT -SSBS BTYP=
E=3D--)
> [   71.421585] pc : 0xb7ec7ae4
> [   71.424367] lr : 0xb7ec8668
> [   71.427149] sp : ffff80002f0e37e0
> [   71.430452] x29: ffff80002f0e37e0 x28: ffffa4efa13bb0d0 x27: ffffa4efa=
0e32a18
> [   71.437575] x26: ffff3fff93ce2d74 x25: ffff3fff90793805 x24: 000000000=
0000000
> [   71.444698] x23: 0000000000000000 x22: 0000000000000000 x21: ffffa4efa=
06f0750
> [   71.451821] x20: ffff8000279fbcc8 x19: ffffa4efa1df2a80 x18: 000000000=
0000000
> [   71.458944] x17: 0000000000000000 x16: 0000000000000000 x15: 0000aaab1=
9a5fb90
> [   71.466067] x14: 0000000000000000 x13: 0000000000000010 x12: 010101010=
1010101
> [   71.473190] x11: 7f7f7f7f7f7f7f7f x10: fefefefefeff7076 x9 : ffffa4ef9=
f5f7570
> [   71.480313] x8 : 00000000b7cc05b8 x7 : ffff80002f0e3b60 x6 : ffff80002=
f0e3c00
> [   71.487436] x5 : ffff80002f0e3b58 x4 : 00000000b7e81358 x3 : 00000000b=
7ec8600
> [   71.494559] x2 : 0000000001000000 x1 : 0000000001000000 x0 : 00000000a=
934da60
> [   71.501682] Call trace:
> [   71.504116]  0xb7ec7ae4
> [   71.506551]  0xb7ec8668
> [   71.508985]  0xb7ec6e08
> [   71.511419]  0xb7ec68ec
> [   71.513853]  0xb7ec3824
> [   71.516287]  0xb7ec05a8
> [   71.518721]  0xb7ec12a0
> [   71.521155]  0xb7e53524
> [   71.523590]  0xb7e53670
> [   71.526024]  0xb7e582f0
> [   71.528458]  0xb7e5909c
> [   71.530892]  0xb7e5a014
> [   71.533326]  0xb7e508a8
> [   71.535760]  0xb7cc3328
> [   71.538195]  0xb7cc0674
> [   71.540629]  __efi_rt_asm_wrapper+0x2c/0x48
> [   71.544802]  efi_call_rts+0x2a8/0x440
> [   71.548454]  process_one_work+0x1e4/0x460
> [   71.552452]  worker_thread+0x74/0x414
> [   71.556103]  kthread+0xf0/0xf4
> [   71.559147]  ret_from_fork+0x10/0x20
> [   71.562712] Code: 90000000 912c2000 f9400000 f9400000 (f9400401)
> [   71.568794] ---[ end trace 0000000000000000 ]---
> [   71.573401] Kernel panic - not syncing: Oops: Fatal exception in inter=
rupt
> [   71.580263] SMP: stopping secondary CPUs
> [   71.584932] Kernel Offset: 0x24ef975e0000 from 0xffff800008000000
> [   71.591012] PHYS_OFFSET: 0x80000000
> [   71.594488] CPU features: 0x00000,001700a4,6601720b
> [   71.599353] Memory Limit: none
> [   71.602395] ---[ end Kernel panic - not syncing: Oops: Fatal exception=
 in interrupt ]---
>
> Thanks,
> Gavin
>
