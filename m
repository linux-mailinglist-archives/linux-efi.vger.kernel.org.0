Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 225CD475B61
	for <lists+linux-efi@lfdr.de>; Wed, 15 Dec 2021 16:06:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbhLOPFj (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 15 Dec 2021 10:05:39 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:42286 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbhLOPFj (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 15 Dec 2021 10:05:39 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1B87FB81F96;
        Wed, 15 Dec 2021 15:05:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB1ECC34606;
        Wed, 15 Dec 2021 15:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639580736;
        bh=s2oMpXjPJ0435+BpTqmrBiOo4ltgVkbXybfcxoMKRSY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZGu65odMsR5SgOhpUSzVUNzZzc3fLMAd3NHaFUsEU9txc0FNslr8Cq1E7+gztPwOJ
         g87x9Uw6D7K7Vvm7gk7BsqHRNhYtgwQLJ820k0DMwzJzGjUo9/foLoKIpZc6zGvhb3
         Iw8yo5yBFXGj+3WRK/Z6ImVG1TdA84W2HUkaw6AYCzLa0ut+Pt9+/a2kpdefXKMDHV
         nyPxVaBv4Ik/TQuLIy6LiZt3SoLHGRlNFnSilrM04Ni4TPE8nTul78mBv5Ssw89XPA
         SLfRTZ0xN33okkgjPhsLDt7J6avLJZzvj6n+KwQYRQr4XHLYxX0+KywZhORfaCPJWa
         st3qOl957yZgg==
Received: by mail-ed1-f44.google.com with SMTP id z9so20892019edb.5;
        Wed, 15 Dec 2021 07:05:36 -0800 (PST)
X-Gm-Message-State: AOAM530Zb0t2fBnp5GiwxCTRcv3g9fvqaxXiWQvicHdZiEdiRCdKd1Lo
        4WkA9vYMvTFa/mLQzoRul51VbCgqCMCB8aK6iA==
X-Google-Smtp-Source: ABdhPJzVX+wFzD/i3rjZ6Jl105acBDc81S5ieOfWLq7tu+QfSx1YE9ES0OvoDhnOxzMrQYyjZv1UtcE9jz41ekPlvRo=
X-Received: by 2002:a05:6402:35ce:: with SMTP id z14mr15000800edc.197.1639580731708;
 Wed, 15 Dec 2021 07:05:31 -0800 (PST)
MIME-Version: 1.0
References: <20211214040157.27443-3-kernelfans@gmail.com> <20211215021348.8766-1-kernelfans@gmail.com>
 <7fa6bfd1-357d-10ad-0375-a6efdc7b89e4@huawei.com> <Ybl9RYCIo14qyxqL@piliu.users.ipa.redhat.com>
 <ef184207-57db-f80e-7ee3-264110c1ba10@huawei.com>
In-Reply-To: <ef184207-57db-f80e-7ee3-264110c1ba10@huawei.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 15 Dec 2021 09:05:19 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLS_=_Zeau-10aRkHWvvW-DNxB=CHr0mMo2SqbK35fLPA@mail.gmail.com>
Message-ID: <CAL_JsqLS_=_Zeau-10aRkHWvvW-DNxB=CHr0mMo2SqbK35fLPA@mail.gmail.com>
Subject: Re: [PATCHv3] efi: apply memblock cap after memblock_add()
To:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Cc:     Pingfan Liu <kernelfans@gmail.com>, devicetree@vger.kernel.org,
        linux-efi <linux-efi@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Frank Rowand <frowand.list@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Nick Terrell <terrelln@fb.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Dec 15, 2021 at 12:53 AM Leizhen (ThunderTown)
<thunder.leizhen@huawei.com> wrote:
>
>
>
> On 2021/12/15 13:29, Pingfan Liu wrote:
> > On Wed, Dec 15, 2021 at 11:58:03AM +0800, Leizhen (ThunderTown) wrote:
> >>
> >>
> >> On 2021/12/15 10:13, Pingfan Liu wrote:
> >>> On arm64, during kdump kernel saves vmcore, it runs into the followin=
g bug:
> >>> ...
> >>> [   15.148919] usercopy: Kernel memory exposure attempt detected from=
 SLUB object 'kmem_cache_node' (offset 0, size 4096)!
> >>> [   15.159707] ------------[ cut here ]------------
> >>> [   15.164311] kernel BUG at mm/usercopy.c:99!
> >>> [   15.168482] Internal error: Oops - BUG: 0 [#1] SMP
> >>> [   15.173261] Modules linked in: xfs libcrc32c crct10dif_ce ghash_ce=
 sha2_ce sha256_arm64 sha1_ce sbsa_gwdt ast i2c_algo_bit drm_vram_helper dr=
m_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops cec drm_ttm_help=
er ttm drm nvme nvme_core xgene_hwmon i2c_designware_platform i2c_designwar=
e_core dm_mirror dm_region_hash dm_log dm_mod overlay squashfs zstd_decompr=
ess loop
> >>> [   15.206186] CPU: 0 PID: 542 Comm: cp Not tainted 5.16.0-rc4 #1
> >>> [   15.212006] Hardware name: GIGABYTE R272-P30-JG/MP32-AR0-JG, BIOS =
F12 (SCP: 1.5.20210426) 05/13/2021
> >>> [   15.221125] pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS =
BTYPE=3D--)
> >>> [   15.228073] pc : usercopy_abort+0x9c/0xa0
> >>> [   15.232074] lr : usercopy_abort+0x9c/0xa0
> >>> [   15.236070] sp : ffff8000121abba0
> >>> [   15.239371] x29: ffff8000121abbb0 x28: 0000000000003000 x27: 00000=
00000000000
> >>> [   15.246494] x26: 0000000080000400 x25: 0000ffff885c7000 x24: 00000=
00000000000
> >>> [   15.253617] x23: 000007ff80400000 x22: ffff07ff80401000 x21: 00000=
00000000001
> >>> [   15.260739] x20: 0000000000001000 x19: ffff07ff80400000 x18: fffff=
fffffffffff
> >>> [   15.267861] x17: 656a626f2042554c x16: 53206d6f72662064 x15: 65746=
36574656420
> >>> [   15.274983] x14: 74706d6574746120 x13: 2129363930342065 x12: 7a697=
3202c302074
> >>> [   15.282105] x11: ffffc8b041d1b148 x10: 00000000ffff8000 x9 : ffffc=
8b04012812c
> >>> [   15.289228] x8 : 00000000ffff7fff x7 : ffffc8b041d1b148 x6 : 00000=
00000000000
> >>> [   15.296349] x5 : 0000000000000000 x4 : 0000000000007fff x3 : 00000=
00000000000
> >>> [   15.303471] x2 : 0000000000000000 x1 : ffff07ff8c064800 x0 : 00000=
0000000006b
> >>> [   15.310593] Call trace:
> >>> [   15.313027]  usercopy_abort+0x9c/0xa0
> >>> [   15.316677]  __check_heap_object+0xd4/0xf0
> >>> [   15.320762]  __check_object_size.part.0+0x160/0x1e0
> >>> [   15.325628]  __check_object_size+0x2c/0x40
> >>> [   15.329711]  copy_oldmem_page+0x7c/0x140
> >>> [   15.333623]  read_from_oldmem.part.0+0xfc/0x1c0
> >>> [   15.338142]  __read_vmcore.constprop.0+0x23c/0x350
> >>> [   15.342920]  read_vmcore+0x28/0x34
> >>> [   15.346309]  proc_reg_read+0xb4/0xf0
> >>> [   15.349871]  vfs_read+0xb8/0x1f0
> >>> [   15.353088]  ksys_read+0x74/0x100
> >>> [   15.356390]  __arm64_sys_read+0x28/0x34
> >>> ...
> >>>
> >>> This bug introduced by commit b261dba2fdb2 ("arm64: kdump: Remove cus=
tom
> >>> linux,usable-memory-range handling"), which moves
> >>> memblock_cap_memory_range() to fdt, but it breaches the rules that
> >>> memblock_cap_memory_range() should come after memblock_add() etc as s=
aid
> >>> in commit e888fa7bb882 ("memblock: Check memory add/cap ordering").
> >>
> >> void __init early_init_dt_scan_nodes(void)
> >> {
> >>      //(1) -->early_init_dt_check_for_usable_mem_range, fill cap_mem_a=
ddr
> >>         rc =3D of_scan_flat_dt(early_init_dt_scan_chosen, boot_command=
_line);
> >>
> >>      //(2) --> early_init_dt_add_memory_arch --> memblock_add()
> >>         of_scan_flat_dt(early_init_dt_scan_memory, NULL);
> >>
> >>      //(3)
> >>         memblock_cap_memory_range(cap_mem_addr, cap_mem_size);
> >> }
> >>
> >> I didn't get it. The above step (1),(2),(3) comply with
> >> commit e888fa7bb882 ("memblock: Check memory add/cap ordering")
> >>
> > Well, at this scope, it does. But from a larger scope, let's say on
> > arm64,
> > setup_arch
> >   ...
> >   setup_machine_fdt(); //which holds your case
> >   ...
> >   efi_init(); //which call memblock_add, and breach the ordering.
> >
> >> Did you see the warning?
> >> pr_warn("%s: No memory registered yet\n", __func__);
> >>
> > Yes, I did see this message, which brings me to commit e888fa7bb882
> > ("memblock: Check memory add/cap ordering")
> >
> > I am also curious why this bug does not be discovered. Is CONFIG_EFI
> > on at your case?
>
> Yes, Both X86 and ARM64, CONFIG_EFI=3Dy. I used the defconfig.

Are you booting using EFI though? efi_init() removes all memblocks
that may have been setup from the DT and adds memblocks using the EFI
memory map information.

Rob
