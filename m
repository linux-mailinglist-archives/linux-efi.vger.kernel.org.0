Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 400D947C29B
	for <lists+linux-efi@lfdr.de>; Tue, 21 Dec 2021 16:18:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239096AbhLUPSB (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 21 Dec 2021 10:18:01 -0500
Received: from mail-qt1-f174.google.com ([209.85.160.174]:33402 "EHLO
        mail-qt1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233629AbhLUPSB (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 21 Dec 2021 10:18:01 -0500
Received: by mail-qt1-f174.google.com with SMTP id n15so13210663qta.0;
        Tue, 21 Dec 2021 07:18:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZuWTuiIcvHfk+AaOUiK4K8LBct+NDkJ8LGEc0/K3Rj0=;
        b=kLWarkPg70aAifuAUJVO3ACl29Q/LaLlTuwkuAMpM6ZXYgX8ulESbAGnOQoLgE4IAF
         6AIAG4VzCulBb+NcskEdr1qRv9HSd0Wuf/JUVczH+GRpyAmYqGnRZoMexD0rZd3An91w
         iP1h4Vyhjg28TlLvRPgZB/5nSOVnnxlqSRtGSxbgla9IuJPi2gacg7bVdP8uIsygflRz
         MvVcWsUfmknJVmlnEB4RR+eLxUzeqlAlfB+8LVAIrGagpDYikghWfFu3DZllbOJHGK4a
         S10LwyCv1cKF2+BI620a2g4D483T3IVg2RDZ02kQgexRK0a7C02rhrT3Lk5vu8TC08BG
         1W9A==
X-Gm-Message-State: AOAM533Lu8uklfRZXUYQwWuiaFcWSSvuELsElmMZ1MN45kbIqOgFcvLM
        scAsg67FRRfO5vUQuLqReg==
X-Google-Smtp-Source: ABdhPJxLGOEzx5CVLiKWtyb14vWd21JwrsjGfSJy1nKfYaKTuFj86cGoP31MzIXvILcy+ObcPB2P0w==
X-Received: by 2002:ac8:5993:: with SMTP id e19mr2525883qte.239.1640099880176;
        Tue, 21 Dec 2021 07:18:00 -0800 (PST)
Received: from robh.at.kernel.org ([24.55.105.145])
        by smtp.gmail.com with ESMTPSA id h11sm14111622qko.18.2021.12.21.07.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 07:17:59 -0800 (PST)
Received: (nullmailer pid 1433915 invoked by uid 1000);
        Tue, 21 Dec 2021 15:17:57 -0000
Date:   Tue, 21 Dec 2021 11:17:57 -0400
From:   Rob Herring <robh@kernel.org>
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     Will Deacon <will@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Nick Terrell <terrelln@fb.com>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, linux-efi@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Zhen Lei <thunder.leizhen@huawei.com>
Subject: Re: [PATCHv3] efi: apply memblock cap after memblock_add()
Message-ID: <YcHwJeygyLNiSVjd@robh.at.kernel.org>
References: <20211214040157.27443-3-kernelfans@gmail.com>
 <20211215021348.8766-1-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211215021348.8766-1-kernelfans@gmail.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 15 Dec 2021 10:13:48 +0800, Pingfan Liu wrote:
> On arm64, during kdump kernel saves vmcore, it runs into the following bug:
> ...
> [   15.148919] usercopy: Kernel memory exposure attempt detected from SLUB object 'kmem_cache_node' (offset 0, size 4096)!
> [   15.159707] ------------[ cut here ]------------
> [   15.164311] kernel BUG at mm/usercopy.c:99!
> [   15.168482] Internal error: Oops - BUG: 0 [#1] SMP
> [   15.173261] Modules linked in: xfs libcrc32c crct10dif_ce ghash_ce sha2_ce sha256_arm64 sha1_ce sbsa_gwdt ast i2c_algo_bit drm_vram_helper drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops cec drm_ttm_helper ttm drm nvme nvme_core xgene_hwmon i2c_designware_platform i2c_designware_core dm_mirror dm_region_hash dm_log dm_mod overlay squashfs zstd_decompress loop
> [   15.206186] CPU: 0 PID: 542 Comm: cp Not tainted 5.16.0-rc4 #1
> [   15.212006] Hardware name: GIGABYTE R272-P30-JG/MP32-AR0-JG, BIOS F12 (SCP: 1.5.20210426) 05/13/2021
> [   15.221125] pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [   15.228073] pc : usercopy_abort+0x9c/0xa0
> [   15.232074] lr : usercopy_abort+0x9c/0xa0
> [   15.236070] sp : ffff8000121abba0
> [   15.239371] x29: ffff8000121abbb0 x28: 0000000000003000 x27: 0000000000000000
> [   15.246494] x26: 0000000080000400 x25: 0000ffff885c7000 x24: 0000000000000000
> [   15.253617] x23: 000007ff80400000 x22: ffff07ff80401000 x21: 0000000000000001
> [   15.260739] x20: 0000000000001000 x19: ffff07ff80400000 x18: ffffffffffffffff
> [   15.267861] x17: 656a626f2042554c x16: 53206d6f72662064 x15: 6574636574656420
> [   15.274983] x14: 74706d6574746120 x13: 2129363930342065 x12: 7a6973202c302074
> [   15.282105] x11: ffffc8b041d1b148 x10: 00000000ffff8000 x9 : ffffc8b04012812c
> [   15.289228] x8 : 00000000ffff7fff x7 : ffffc8b041d1b148 x6 : 0000000000000000
> [   15.296349] x5 : 0000000000000000 x4 : 0000000000007fff x3 : 0000000000000000
> [   15.303471] x2 : 0000000000000000 x1 : ffff07ff8c064800 x0 : 000000000000006b
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
> populated, while efi_init() is aware, so tackling this issue by calling the
> interface early_init_dt_check_for_usable_mem_range() exposed by of/fdt.
> 
> Fixes: b261dba2fdb2 ("arm64: kdump: Remove custom linux,usable-memory-range handling")
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
> 

Applied, thanks!
