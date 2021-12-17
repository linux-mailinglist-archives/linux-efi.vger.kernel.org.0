Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 814A5478F96
	for <lists+linux-efi@lfdr.de>; Fri, 17 Dec 2021 16:25:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238137AbhLQPZv (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 17 Dec 2021 10:25:51 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:34446 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232151AbhLQPZv (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 17 Dec 2021 10:25:51 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 145C162272;
        Fri, 17 Dec 2021 15:25:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DFF0C36AE9;
        Fri, 17 Dec 2021 15:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639754750;
        bh=YYidNFDHSr+OTVLKPb2QHNyzTBbDxrbfbiBT1vM51bI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YFbJNKiO4ffuqqvUXBSZMdtVP8BYMQxMaLvAJfYEFsFKlDzNCVjBZ9Qfo09IhwMKb
         Fb2wQv8O1HIXLv9TmMmO54IKQCmf/is0XIKGFBcPKwXFeS3V31x2DY78awdOMBm4Qi
         Oc/LGWCTK/e25V6IbQhQVrIBQ5iwW1nsZUNqM/paa+brNcHNzcFXPFA6E7BtbwKYwu
         GQ6K0f7qSRaI/ayEbpcWE/K99qWx3GNoHbXV9EsKJADQ+S2iz8usvSPkv7G7XFo1aX
         avEBaJA+GLjMnaPKCsszPUTptfXwQrY1++GwvNZ4QDIs3O878Rd/PAhk4t0KMHMUem
         TDTOthHFuj+/w==
Received: by mail-wr1-f51.google.com with SMTP id o13so4683113wrs.12;
        Fri, 17 Dec 2021 07:25:50 -0800 (PST)
X-Gm-Message-State: AOAM531TLt1h8xpzIh0enJgpqBG6Od3fiTxq8Uw35gP8g86Nd8KPQZyn
        IikKA4CxJ/VnnK5XfUzRt+EnvYFosUBfvSD4p6U=
X-Google-Smtp-Source: ABdhPJzL1e0y8TGNoMGmZhg9eysi6brKircb031trr94O7/QbqhUlpwEs1lt5KP3IOWvkeigLlJT+EQ3drk7FPvdufM=
X-Received: by 2002:adf:dc44:: with SMTP id m4mr3016729wrj.550.1639754748731;
 Fri, 17 Dec 2021 07:25:48 -0800 (PST)
MIME-Version: 1.0
References: <20211214040157.27443-3-kernelfans@gmail.com> <20211215021348.8766-1-kernelfans@gmail.com>
 <CAL_JsqJQ4hiQ1eEYrnWax9oEDpwdh93pYo+sSV581R+F6F0ymA@mail.gmail.com>
In-Reply-To: <CAL_JsqJQ4hiQ1eEYrnWax9oEDpwdh93pYo+sSV581R+F6F0ymA@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 17 Dec 2021 16:25:36 +0100
X-Gmail-Original-Message-ID: <CAMj1kXH07Q50Zf_=dJ8G1q7ngjKSO01usmQ25wouygmaV_+wnA@mail.gmail.com>
Message-ID: <CAMj1kXH07Q50Zf_=dJ8G1q7ngjKSO01usmQ25wouygmaV_+wnA@mail.gmail.com>
Subject: Re: [PATCHv3] efi: apply memblock cap after memblock_add()
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Frank Rowand <frowand.list@gmail.com>,
        Nick Terrell <terrelln@fb.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 17 Dec 2021 at 16:08, Rob Herring <robh+dt@kernel.org> wrote:
>
> On Tue, Dec 14, 2021 at 8:14 PM Pingfan Liu <kernelfans@gmail.com> wrote:
> >
> > On arm64, during kdump kernel saves vmcore, it runs into the following =
bug:
> > ...
> > [   15.148919] usercopy: Kernel memory exposure attempt detected from S=
LUB object 'kmem_cache_node' (offset 0, size 4096)!
> > [   15.159707] ------------[ cut here ]------------
> > [   15.164311] kernel BUG at mm/usercopy.c:99!
> > [   15.168482] Internal error: Oops - BUG: 0 [#1] SMP
> > [   15.173261] Modules linked in: xfs libcrc32c crct10dif_ce ghash_ce s=
ha2_ce sha256_arm64 sha1_ce sbsa_gwdt ast i2c_algo_bit drm_vram_helper drm_=
kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops cec drm_ttm_helper=
 ttm drm nvme nvme_core xgene_hwmon i2c_designware_platform i2c_designware_=
core dm_mirror dm_region_hash dm_log dm_mod overlay squashfs zstd_decompres=
s loop
> > [   15.206186] CPU: 0 PID: 542 Comm: cp Not tainted 5.16.0-rc4 #1
> > [   15.212006] Hardware name: GIGABYTE R272-P30-JG/MP32-AR0-JG, BIOS F1=
2 (SCP: 1.5.20210426) 05/13/2021
> > [   15.221125] pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BT=
YPE=3D--)
> > [   15.228073] pc : usercopy_abort+0x9c/0xa0
> > [   15.232074] lr : usercopy_abort+0x9c/0xa0
> > [   15.236070] sp : ffff8000121abba0
> > [   15.239371] x29: ffff8000121abbb0 x28: 0000000000003000 x27: 0000000=
000000000
> > [   15.246494] x26: 0000000080000400 x25: 0000ffff885c7000 x24: 0000000=
000000000
> > [   15.253617] x23: 000007ff80400000 x22: ffff07ff80401000 x21: 0000000=
000000001
> > [   15.260739] x20: 0000000000001000 x19: ffff07ff80400000 x18: fffffff=
fffffffff
> > [   15.267861] x17: 656a626f2042554c x16: 53206d6f72662064 x15: 6574636=
574656420
> > [   15.274983] x14: 74706d6574746120 x13: 2129363930342065 x12: 7a69732=
02c302074
> > [   15.282105] x11: ffffc8b041d1b148 x10: 00000000ffff8000 x9 : ffffc8b=
04012812c
> > [   15.289228] x8 : 00000000ffff7fff x7 : ffffc8b041d1b148 x6 : 0000000=
000000000
> > [   15.296349] x5 : 0000000000000000 x4 : 0000000000007fff x3 : 0000000=
000000000
> > [   15.303471] x2 : 0000000000000000 x1 : ffff07ff8c064800 x0 : 0000000=
00000006b
> > [   15.310593] Call trace:
> > [   15.313027]  usercopy_abort+0x9c/0xa0
> > [   15.316677]  __check_heap_object+0xd4/0xf0
> > [   15.320762]  __check_object_size.part.0+0x160/0x1e0
> > [   15.325628]  __check_object_size+0x2c/0x40
> > [   15.329711]  copy_oldmem_page+0x7c/0x140
> > [   15.333623]  read_from_oldmem.part.0+0xfc/0x1c0
> > [   15.338142]  __read_vmcore.constprop.0+0x23c/0x350
> > [   15.342920]  read_vmcore+0x28/0x34
> > [   15.346309]  proc_reg_read+0xb4/0xf0
> > [   15.349871]  vfs_read+0xb8/0x1f0
> > [   15.353088]  ksys_read+0x74/0x100
> > [   15.356390]  __arm64_sys_read+0x28/0x34
> > ...
> >
> > This bug introduced by commit b261dba2fdb2 ("arm64: kdump: Remove custo=
m
> > linux,usable-memory-range handling"), which moves
> > memblock_cap_memory_range() to fdt, but it breaches the rules that
> > memblock_cap_memory_range() should come after memblock_add() etc as sai=
d
> > in commit e888fa7bb882 ("memblock: Check memory add/cap ordering").
> >
> > As a consequence, the virtual address set up by copy_oldmem_page() does
> > not bail out from the test of virt_addr_valid() in check_heap_object(),
> > and finally hits the BUG_ON().
> >
> > Since memblock allocator has no idea about when the memblock is fully
> > populated, while efi_init() is aware, so tackling this issue by calling=
 the
> > interface early_init_dt_check_for_usable_mem_range() exposed by of/fdt.
> >
> > Fixes: b261dba2fdb2 ("arm64: kdump: Remove custom linux,usable-memory-r=
ange handling")
> > Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: Zhen Lei <thunder.leizhen@huawei.com>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Mike Rapoport <rppt@kernel.org>
> > Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> > Cc: Frank Rowand <frowand.list@gmail.com>
> > Cc: Ard Biesheuvel <ardb@kernel.org>
> > Cc: Nick Terrell <terrelln@fb.com>
> > Cc: linux-arm-kernel@lists.infradead.org
> > To: devicetree@vger.kernel.org
> > To: linux-efi@vger.kernel.org
> > ---
> > v2 -> v3:
> >  use static inline stub to avoid #ifdef according to Rob's suggestion
> >
> >  drivers/firmware/efi/efi-init.c | 5 +++++
> >  drivers/of/fdt.c                | 2 +-
> >  include/linux/of_fdt.h          | 2 ++
> >  3 files changed, 8 insertions(+), 1 deletion(-)
>
> Looks good to me. I'll apply and send to Linus once the EFI folks ack thi=
s.
>

Where needed in the series,

Acked-by: Ard Biesheuvel <ardb@kernel.org>
