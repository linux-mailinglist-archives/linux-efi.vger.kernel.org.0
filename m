Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D018478F16
	for <lists+linux-efi@lfdr.de>; Fri, 17 Dec 2021 16:08:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237910AbhLQPIR (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 17 Dec 2021 10:08:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237902AbhLQPIQ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 17 Dec 2021 10:08:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96E85C061574;
        Fri, 17 Dec 2021 07:08:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 25CE062264;
        Fri, 17 Dec 2021 15:08:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89020C36AE8;
        Fri, 17 Dec 2021 15:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639753695;
        bh=eJHTIWavl0k3o94qyql3p/I++DlWPzpcyFFkbXMM0SI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Px5NFoOBFuZ9nbTgLMUkrDXPLj8LVo+sHQMKkPmAcjZj3qddlVYkFIUdylBG0DPNX
         9oznzXZJB1UYdJdw9CC1H12oy0jIkiJXs77g/ImJRSoisz3ONsAO2uKnwn3z+8m8xx
         /etvIlM2RLVePuien5L1jZ1+/wPS0Ze4kk6os8NcTXUOupqp2usaMAEnsVDNheYcIz
         tNKXRzDEtvgnSV0kqND6/t7/29kZDOVX+X6waWZ+v6yNxoCoUrKrhRfvxXKVNRnWe9
         L2Eob7e5JUHv8GM++WCGlvtAgoVe0IjE8t/AD4enRxeBdATOj1CPyf7pVKKFFF9PKW
         vtOGCpouhRbyA==
Received: by mail-ed1-f50.google.com with SMTP id t5so9149940edd.0;
        Fri, 17 Dec 2021 07:08:15 -0800 (PST)
X-Gm-Message-State: AOAM533KFZU2fGnaE4rjq7bilAKlAyj6qdsaOtqh/fyMDCJnD22LLgBX
        YyWPdh2E3RKJEteOEKb7gJGU4wPrJunVZ+z6sA==
X-Google-Smtp-Source: ABdhPJz7UBjCanpqyXZ/N8JuQ+R70NOSb975SHvrNYEe4tU0DluKtehYgGBVwOME7X3J+ksi4rZcK88LE3vq3MICh/A=
X-Received: by 2002:a17:906:eb04:: with SMTP id mb4mr2842891ejb.27.1639753693801;
 Fri, 17 Dec 2021 07:08:13 -0800 (PST)
MIME-Version: 1.0
References: <20211214040157.27443-3-kernelfans@gmail.com> <20211215021348.8766-1-kernelfans@gmail.com>
In-Reply-To: <20211215021348.8766-1-kernelfans@gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 17 Dec 2021 09:08:02 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJQ4hiQ1eEYrnWax9oEDpwdh93pYo+sSV581R+F6F0ymA@mail.gmail.com>
Message-ID: <CAL_JsqJQ4hiQ1eEYrnWax9oEDpwdh93pYo+sSV581R+F6F0ymA@mail.gmail.com>
Subject: Re: [PATCHv3] efi: apply memblock cap after memblock_add()
To:     Pingfan Liu <kernelfans@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-efi <linux-efi@vger.kernel.org>,
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

On Tue, Dec 14, 2021 at 8:14 PM Pingfan Liu <kernelfans@gmail.com> wrote:
>
> On arm64, during kdump kernel saves vmcore, it runs into the following bu=
g:
> ...
> [   15.148919] usercopy: Kernel memory exposure attempt detected from SLU=
B object 'kmem_cache_node' (offset 0, size 4096)!
> [   15.159707] ------------[ cut here ]------------
> [   15.164311] kernel BUG at mm/usercopy.c:99!
> [   15.168482] Internal error: Oops - BUG: 0 [#1] SMP
> [   15.173261] Modules linked in: xfs libcrc32c crct10dif_ce ghash_ce sha=
2_ce sha256_arm64 sha1_ce sbsa_gwdt ast i2c_algo_bit drm_vram_helper drm_km=
s_helper syscopyarea sysfillrect sysimgblt fb_sys_fops cec drm_ttm_helper t=
tm drm nvme nvme_core xgene_hwmon i2c_designware_platform i2c_designware_co=
re dm_mirror dm_region_hash dm_log dm_mod overlay squashfs zstd_decompress =
loop
> [   15.206186] CPU: 0 PID: 542 Comm: cp Not tainted 5.16.0-rc4 #1
> [   15.212006] Hardware name: GIGABYTE R272-P30-JG/MP32-AR0-JG, BIOS F12 =
(SCP: 1.5.20210426) 05/13/2021
> [   15.221125] pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYP=
E=3D--)
> [   15.228073] pc : usercopy_abort+0x9c/0xa0
> [   15.232074] lr : usercopy_abort+0x9c/0xa0
> [   15.236070] sp : ffff8000121abba0
> [   15.239371] x29: ffff8000121abbb0 x28: 0000000000003000 x27: 000000000=
0000000
> [   15.246494] x26: 0000000080000400 x25: 0000ffff885c7000 x24: 000000000=
0000000
> [   15.253617] x23: 000007ff80400000 x22: ffff07ff80401000 x21: 000000000=
0000001
> [   15.260739] x20: 0000000000001000 x19: ffff07ff80400000 x18: fffffffff=
fffffff
> [   15.267861] x17: 656a626f2042554c x16: 53206d6f72662064 x15: 657463657=
4656420
> [   15.274983] x14: 74706d6574746120 x13: 2129363930342065 x12: 7a6973202=
c302074
> [   15.282105] x11: ffffc8b041d1b148 x10: 00000000ffff8000 x9 : ffffc8b04=
012812c
> [   15.289228] x8 : 00000000ffff7fff x7 : ffffc8b041d1b148 x6 : 000000000=
0000000
> [   15.296349] x5 : 0000000000000000 x4 : 0000000000007fff x3 : 000000000=
0000000
> [   15.303471] x2 : 0000000000000000 x1 : ffff07ff8c064800 x0 : 000000000=
000006b
> [   15.310593] Call trace:
> [   15.313027]  usercopy_abort+0x9c/0xa0
> [   15.316677]  __check_heap_object+0xd4/0xf0
> [   15.320762]  __check_object_size.part.0+0x160/0x1e0
> [   15.325628]  __check_object_size+0x2c/0x40
> [   15.329711]  copy_oldmem_page+0x7c/0x140
> [   15.333623]  read_from_oldmem.part.0+0xfc/0x1c0
> [   15.338142]  __read_vmcore.constprop.0+0x23c/0x350
> [   15.342920]  read_vmcore+0x28/0x34
> [   15.346309]  proc_reg_read+0xb4/0xf0
> [   15.349871]  vfs_read+0xb8/0x1f0
> [   15.353088]  ksys_read+0x74/0x100
> [   15.356390]  __arm64_sys_read+0x28/0x34
> ...
>
> This bug introduced by commit b261dba2fdb2 ("arm64: kdump: Remove custom
> linux,usable-memory-range handling"), which moves
> memblock_cap_memory_range() to fdt, but it breaches the rules that
> memblock_cap_memory_range() should come after memblock_add() etc as said
> in commit e888fa7bb882 ("memblock: Check memory add/cap ordering").
>
> As a consequence, the virtual address set up by copy_oldmem_page() does
> not bail out from the test of virt_addr_valid() in check_heap_object(),
> and finally hits the BUG_ON().
>
> Since memblock allocator has no idea about when the memblock is fully
> populated, while efi_init() is aware, so tackling this issue by calling t=
he
> interface early_init_dt_check_for_usable_mem_range() exposed by of/fdt.
>
> Fixes: b261dba2fdb2 ("arm64: kdump: Remove custom linux,usable-memory-ran=
ge handling")
> Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Zhen Lei <thunder.leizhen@huawei.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Frank Rowand <frowand.list@gmail.com>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: Nick Terrell <terrelln@fb.com>
> Cc: linux-arm-kernel@lists.infradead.org
> To: devicetree@vger.kernel.org
> To: linux-efi@vger.kernel.org
> ---
> v2 -> v3:
>  use static inline stub to avoid #ifdef according to Rob's suggestion
>
>  drivers/firmware/efi/efi-init.c | 5 +++++
>  drivers/of/fdt.c                | 2 +-
>  include/linux/of_fdt.h          | 2 ++
>  3 files changed, 8 insertions(+), 1 deletion(-)

Looks good to me. I'll apply and send to Linus once the EFI folks ack this.

Rob
