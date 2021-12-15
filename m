Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C48C147543A
	for <lists+linux-efi@lfdr.de>; Wed, 15 Dec 2021 09:25:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240807AbhLOIZI (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 15 Dec 2021 03:25:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233798AbhLOIZE (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 15 Dec 2021 03:25:04 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B204CC061574;
        Wed, 15 Dec 2021 00:25:04 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id b13so15818178plg.2;
        Wed, 15 Dec 2021 00:25:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IC/cDfD9CXu0SzSqyYbs6ZJ2NVWoqyte1XtD4fYOMsA=;
        b=M/OHD96WOcVDJ69rvF9NrRAZbIIYNzZSx/utjLnI7odd0+pJALglEnLEluTNI+M+oR
         SmK3Bv8FVFYR7PdY4Kx/i7e0/XNTNrpt3EiPQ/Ka8votfWe9a4/GHnyP15Lz3jhD7fP9
         AGLBo4gxBH5uhqFBvveygdTgnIkaj4UMXggrl/CB/jQkTioBCj+kQFQLRpQPLfGV1Ydf
         B/uGZStwDQ6cEh7REARVBRr2xyfpmz6WEAeuSkEDZSbRJGgf16KR1dBGEw7k/0EaVh0B
         MBloseuUzQTaWDHGzP/vnE5HonUDhhzbARpyRgPl+OozzWNl2J0f5Off7FWb7J75IH8y
         b/zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IC/cDfD9CXu0SzSqyYbs6ZJ2NVWoqyte1XtD4fYOMsA=;
        b=uTyMCbuwOrz4/xBgkR2InV+zTCUuBwjmYXKwpRTEN2hDTQy+GYxkzG6YbkkDyZ6Eqe
         qql2hxc82co+pwnNx/Z6111YXtB770AfENfLUKMZn/g5DG/zbS+rbdm155xj7U9B0jE/
         7Vixh2nzbs71OYbqCD25hNCJRHVgxCojLLzNc7EfyihFSmXIjc3oKgOm2XRuquSFN5Kf
         viWWu/nPplw86R5eAgqRJ2tkhMha/5/4QnI6XoCF8qQJOTmY35DA/9haHLIh0fZyVH5r
         2SgxKVtVZAOAuwceIoeZg8mq8mEoTNgGGdfd+h+jqVxYj1/z11l74SLqsT/wXCKDNdDX
         qmug==
X-Gm-Message-State: AOAM531rxwU6Hu3R2hR1cOfHZRtNxaODwGRQmxPSkFIiqtpTtVYbuKUP
        iG0R15hrSP28kthub83R4Q==
X-Google-Smtp-Source: ABdhPJz5lIKOlhTTLMYkLfDgJzocNwLsUqlKiT0Xy2pbDqo2uKsB+YyX+wY1bGwYHI/D3rmtTsd2gA==
X-Received: by 2002:a17:90a:6e0c:: with SMTP id b12mr10334165pjk.41.1639556704006;
        Wed, 15 Dec 2021 00:25:04 -0800 (PST)
Received: from piliu.users.ipa.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id t66sm1512458pfd.150.2021.12.15.00.24.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 00:25:03 -0800 (PST)
Date:   Wed, 15 Dec 2021 16:24:56 +0800
From:   Pingfan Liu <kernelfans@gmail.com>
To:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Cc:     devicetree@vger.kernel.org, linux-efi@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Frank Rowand <frowand.list@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Nick Terrell <terrelln@fb.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCHv3] efi: apply memblock cap after memblock_add()
Message-ID: <YbmmWEY2N9Ee60Lf@piliu.users.ipa.redhat.com>
References: <20211214040157.27443-3-kernelfans@gmail.com>
 <20211215021348.8766-1-kernelfans@gmail.com>
 <7fa6bfd1-357d-10ad-0375-a6efdc7b89e4@huawei.com>
 <Ybl9RYCIo14qyxqL@piliu.users.ipa.redhat.com>
 <ef184207-57db-f80e-7ee3-264110c1ba10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef184207-57db-f80e-7ee3-264110c1ba10@huawei.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Dec 15, 2021 at 02:53:38PM +0800, Leizhen (ThunderTown) wrote:
> 
> 
> On 2021/12/15 13:29, Pingfan Liu wrote:
> > On Wed, Dec 15, 2021 at 11:58:03AM +0800, Leizhen (ThunderTown) wrote:
> >>
> >>
> >> On 2021/12/15 10:13, Pingfan Liu wrote:
> >>> On arm64, during kdump kernel saves vmcore, it runs into the following bug:
> >>> ...
> >>> [   15.148919] usercopy: Kernel memory exposure attempt detected from SLUB object 'kmem_cache_node' (offset 0, size 4096)!
> >>> [   15.159707] ------------[ cut here ]------------
> >>> [   15.164311] kernel BUG at mm/usercopy.c:99!
> >>> [   15.168482] Internal error: Oops - BUG: 0 [#1] SMP
> >>> [   15.173261] Modules linked in: xfs libcrc32c crct10dif_ce ghash_ce sha2_ce sha256_arm64 sha1_ce sbsa_gwdt ast i2c_algo_bit drm_vram_helper drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops cec drm_ttm_helper ttm drm nvme nvme_core xgene_hwmon i2c_designware_platform i2c_designware_core dm_mirror dm_region_hash dm_log dm_mod overlay squashfs zstd_decompress loop
> >>> [   15.206186] CPU: 0 PID: 542 Comm: cp Not tainted 5.16.0-rc4 #1
> >>> [   15.212006] Hardware name: GIGABYTE R272-P30-JG/MP32-AR0-JG, BIOS F12 (SCP: 1.5.20210426) 05/13/2021
> >>> [   15.221125] pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> >>> [   15.228073] pc : usercopy_abort+0x9c/0xa0
> >>> [   15.232074] lr : usercopy_abort+0x9c/0xa0
> >>> [   15.236070] sp : ffff8000121abba0
> >>> [   15.239371] x29: ffff8000121abbb0 x28: 0000000000003000 x27: 0000000000000000
> >>> [   15.246494] x26: 0000000080000400 x25: 0000ffff885c7000 x24: 0000000000000000
> >>> [   15.253617] x23: 000007ff80400000 x22: ffff07ff80401000 x21: 0000000000000001
> >>> [   15.260739] x20: 0000000000001000 x19: ffff07ff80400000 x18: ffffffffffffffff
> >>> [   15.267861] x17: 656a626f2042554c x16: 53206d6f72662064 x15: 6574636574656420
> >>> [   15.274983] x14: 74706d6574746120 x13: 2129363930342065 x12: 7a6973202c302074
> >>> [   15.282105] x11: ffffc8b041d1b148 x10: 00000000ffff8000 x9 : ffffc8b04012812c
> >>> [   15.289228] x8 : 00000000ffff7fff x7 : ffffc8b041d1b148 x6 : 0000000000000000
> >>> [   15.296349] x5 : 0000000000000000 x4 : 0000000000007fff x3 : 0000000000000000
> >>> [   15.303471] x2 : 0000000000000000 x1 : ffff07ff8c064800 x0 : 000000000000006b
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
> >>> This bug introduced by commit b261dba2fdb2 ("arm64: kdump: Remove custom
> >>> linux,usable-memory-range handling"), which moves
> >>> memblock_cap_memory_range() to fdt, but it breaches the rules that
> >>> memblock_cap_memory_range() should come after memblock_add() etc as said
> >>> in commit e888fa7bb882 ("memblock: Check memory add/cap ordering").
> >>
> >> void __init early_init_dt_scan_nodes(void)
> >> {
> >> 	//(1) -->early_init_dt_check_for_usable_mem_range, fill cap_mem_addr
> >>         rc = of_scan_flat_dt(early_init_dt_scan_chosen, boot_command_line);
> >>
> >> 	//(2) --> early_init_dt_add_memory_arch --> memblock_add()
> >>         of_scan_flat_dt(early_init_dt_scan_memory, NULL);
> >>
> >> 	//(3)
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
> Yes, Both X86 and ARM64, CONFIG_EFI=y. I used the defconfig.
> 
Maybe due to different md?

Because
efi_init()->reserve_regions()->early_init_dt_add_memory_arch()->memblock_add()
on arm64, if is_memory(md). This is the path breaching the rule during
my test.

Thanks

	Pingfan
> > 
> > Thanks,
> > 
> > 	Pingfan
> >>>
> >>> As a consequence, the virtual address set up by copy_oldmem_page() does
> >>> not bail out from the test of virt_addr_valid() in check_heap_object(),
> >>> and finally hits the BUG_ON().
> >>>
> >>> Since memblock allocator has no idea about when the memblock is fully
> >>> populated, while efi_init() is aware, so tackling this issue by calling the
> >>> interface early_init_dt_check_for_usable_mem_range() exposed by of/fdt.
> >>>
> >>> Fixes: b261dba2fdb2 ("arm64: kdump: Remove custom linux,usable-memory-range handling")
> >>> Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> >>> Cc: Rob Herring <robh+dt@kernel.org>
> >>> Cc: Zhen Lei <thunder.leizhen@huawei.com>
> >>> Cc: Catalin Marinas <catalin.marinas@arm.com>
> >>> Cc: Will Deacon <will@kernel.org>
> >>> Cc: Andrew Morton <akpm@linux-foundation.org>
> >>> Cc: Mike Rapoport <rppt@kernel.org>
> >>> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> >>> Cc: Frank Rowand <frowand.list@gmail.com>
> >>> Cc: Ard Biesheuvel <ardb@kernel.org>
> >>> Cc: Nick Terrell <terrelln@fb.com>
> >>> Cc: linux-arm-kernel@lists.infradead.org
> >>> To: devicetree@vger.kernel.org
> >>> To: linux-efi@vger.kernel.org
> >>> ---
> >>> v2 -> v3:
> >>>  use static inline stub to avoid #ifdef according to Rob's suggestion 
> >>>
> >>>  drivers/firmware/efi/efi-init.c | 5 +++++
> >>>  drivers/of/fdt.c                | 2 +-
> >>>  include/linux/of_fdt.h          | 2 ++
> >>>  3 files changed, 8 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/firmware/efi/efi-init.c b/drivers/firmware/efi/efi-init.c
> >>> index b19ce1a83f91..b2c829e95bd1 100644
> >>> --- a/drivers/firmware/efi/efi-init.c
> >>> +++ b/drivers/firmware/efi/efi-init.c
> >>> @@ -235,6 +235,11 @@ void __init efi_init(void)
> >>>  	}
> >>>  
> >>>  	reserve_regions();
> >>> +	/*
> >>> +	 * For memblock manipulation, the cap should come after the memblock_add().
> >>> +	 * And now, memblock is fully populated, it is time to do capping.
> >>> +	 */
> >>> +	early_init_dt_check_for_usable_mem_range();
> >>>  	efi_esrt_init();
> >>>  	efi_mokvar_table_init();
> >>>  
> >>> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> >>> index 18a2df431bfd..aa07ef5cab5f 100644
> >>> --- a/drivers/of/fdt.c
> >>> +++ b/drivers/of/fdt.c
> >>> @@ -972,7 +972,7 @@ static unsigned long chosen_node_offset = -FDT_ERR_NOTFOUND;
> >>>   * location from flat tree
> >>>   * @node: reference to node containing usable memory range location ('chosen')
> >>>   */
> >>> -static void __init early_init_dt_check_for_usable_mem_range(void)
> >>> +void __init early_init_dt_check_for_usable_mem_range(void)
> >>>  {
> >>>  	const __be32 *prop;
> >>>  	int len;
> >>> diff --git a/include/linux/of_fdt.h b/include/linux/of_fdt.h
> >>> index cf48983d3c86..ad09beb6d13c 100644
> >>> --- a/include/linux/of_fdt.h
> >>> +++ b/include/linux/of_fdt.h
> >>> @@ -62,6 +62,7 @@ extern int early_init_dt_scan_chosen(unsigned long node, const char *uname,
> >>>  				     int depth, void *data);
> >>>  extern int early_init_dt_scan_memory(unsigned long node, const char *uname,
> >>>  				     int depth, void *data);
> >>> +extern void early_init_dt_check_for_usable_mem_range(void);
> >>>  extern int early_init_dt_scan_chosen_stdout(void);
> >>>  extern void early_init_fdt_scan_reserved_mem(void);
> >>>  extern void early_init_fdt_reserve_self(void);
> >>> @@ -86,6 +87,7 @@ extern void unflatten_and_copy_device_tree(void);
> >>>  extern void early_init_devtree(void *);
> >>>  extern void early_get_first_memblock_info(void *, phys_addr_t *);
> >>>  #else /* CONFIG_OF_EARLY_FLATTREE */
> >>> +static inline void early_init_dt_check_for_usable_mem_range(void) {}
> >>>  static inline int early_init_dt_scan_chosen_stdout(void) { return -ENODEV; }
> >>>  static inline void early_init_fdt_scan_reserved_mem(void) {}
> >>>  static inline void early_init_fdt_reserve_self(void) {}
> >>>
> >>
> >> _______________________________________________
> >> linux-arm-kernel mailing list
> >> linux-arm-kernel@lists.infradead.org
> >> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> > .
> > 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
