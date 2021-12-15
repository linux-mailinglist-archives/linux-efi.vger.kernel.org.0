Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3C2475213
	for <lists+linux-efi@lfdr.de>; Wed, 15 Dec 2021 06:29:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239874AbhLOF3x (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 15 Dec 2021 00:29:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231590AbhLOF3x (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 15 Dec 2021 00:29:53 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B87ACC061574;
        Tue, 14 Dec 2021 21:29:52 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id w24so2760929ply.12;
        Tue, 14 Dec 2021 21:29:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mSRd1l3jXtE+KZB/nZIfmfmh0C/1YzDMwQkHsDhD0zE=;
        b=XNi0rBVcE6PxLrvtPrEccoLm6jp9M2wD9lwnaqgUfKaItl4qV+Aq1LyuHl4i+BPFs6
         2i4R/QoOWZ+d+fCN9JKiRDVvTHmwfzqPncuWsVwiuJIyndoLefBkd3IXGD56PuMFo0Kn
         MS07ZTfMFogLTF5zemcz/NdW4McgSWtB6ljydXHe2fh9kc19DsaRlAa63FLXBj625xnK
         QKdmJ5cSd/3s4VtHEjapUXAAyBo+qJJKldz+NskEyWmxWNfu6Z6z/yI/2apYCWC42pif
         GS16d92iGsedbIaocV/wBs1s3Rapjgu6NU5nJX5ZDvfhX34C1tanlamIkOhXcyni07/y
         3OlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mSRd1l3jXtE+KZB/nZIfmfmh0C/1YzDMwQkHsDhD0zE=;
        b=larxYZqNfARRHiQRrvlLSGCNktiSl3mN8mwB6bZAzGga7BUT//S7tbzIkcmBccIbge
         G7pu91DSX9Z4/XvQbyH9xxHqjgI43bPcQSnJlGJfcZIdZ7o2gtGNST+0hJ0ksFfI69eH
         LSz1GxF/2FaFKoglu+9RtwHGTbq5R/erm2FLa5eiC2gvGtcCY15JT5DWVhn8LFaU7TAB
         gjYfK3vYqTVVGj5vxt6AWGwD2I6rEMkyfWNt5yCJKKG4Ec32tAj7Rr8+HjDdmNJrPaP5
         6ERXrz2niWY8XXbaw2sV3Pe57D6aSGtCKBpOp9PXsnAm2TtxxW4EuEGgo69qHABmNqzD
         1yFg==
X-Gm-Message-State: AOAM530fSbkGRKL2YChTShAHWweZaSRge6Y/KeWnUw17jAQfCuQxxsCq
        g99/5H7l/MZfbf8OB4KFS1ud7ntbnA==
X-Google-Smtp-Source: ABdhPJzqTFLP7+bCuIXeE/eOIKrOhS1QoRWB1PmgRXJdGanNHPdx2NUizoCTmloZXKTW+ppDun1MfQ==
X-Received: by 2002:a17:902:9343:b0:148:a2e7:fb5f with SMTP id g3-20020a170902934300b00148a2e7fb5fmr3012697plp.160.1639546192244;
        Tue, 14 Dec 2021 21:29:52 -0800 (PST)
Received: from piliu.users.ipa.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id s8sm871424pfw.75.2021.12.14.21.29.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 21:29:51 -0800 (PST)
Date:   Wed, 15 Dec 2021 13:29:41 +0800
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
Message-ID: <Ybl9RYCIo14qyxqL@piliu.users.ipa.redhat.com>
References: <20211214040157.27443-3-kernelfans@gmail.com>
 <20211215021348.8766-1-kernelfans@gmail.com>
 <7fa6bfd1-357d-10ad-0375-a6efdc7b89e4@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7fa6bfd1-357d-10ad-0375-a6efdc7b89e4@huawei.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Dec 15, 2021 at 11:58:03AM +0800, Leizhen (ThunderTown) wrote:
> 
> 
> On 2021/12/15 10:13, Pingfan Liu wrote:
> > On arm64, during kdump kernel saves vmcore, it runs into the following bug:
> > ...
> > [   15.148919] usercopy: Kernel memory exposure attempt detected from SLUB object 'kmem_cache_node' (offset 0, size 4096)!
> > [   15.159707] ------------[ cut here ]------------
> > [   15.164311] kernel BUG at mm/usercopy.c:99!
> > [   15.168482] Internal error: Oops - BUG: 0 [#1] SMP
> > [   15.173261] Modules linked in: xfs libcrc32c crct10dif_ce ghash_ce sha2_ce sha256_arm64 sha1_ce sbsa_gwdt ast i2c_algo_bit drm_vram_helper drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops cec drm_ttm_helper ttm drm nvme nvme_core xgene_hwmon i2c_designware_platform i2c_designware_core dm_mirror dm_region_hash dm_log dm_mod overlay squashfs zstd_decompress loop
> > [   15.206186] CPU: 0 PID: 542 Comm: cp Not tainted 5.16.0-rc4 #1
> > [   15.212006] Hardware name: GIGABYTE R272-P30-JG/MP32-AR0-JG, BIOS F12 (SCP: 1.5.20210426) 05/13/2021
> > [   15.221125] pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> > [   15.228073] pc : usercopy_abort+0x9c/0xa0
> > [   15.232074] lr : usercopy_abort+0x9c/0xa0
> > [   15.236070] sp : ffff8000121abba0
> > [   15.239371] x29: ffff8000121abbb0 x28: 0000000000003000 x27: 0000000000000000
> > [   15.246494] x26: 0000000080000400 x25: 0000ffff885c7000 x24: 0000000000000000
> > [   15.253617] x23: 000007ff80400000 x22: ffff07ff80401000 x21: 0000000000000001
> > [   15.260739] x20: 0000000000001000 x19: ffff07ff80400000 x18: ffffffffffffffff
> > [   15.267861] x17: 656a626f2042554c x16: 53206d6f72662064 x15: 6574636574656420
> > [   15.274983] x14: 74706d6574746120 x13: 2129363930342065 x12: 7a6973202c302074
> > [   15.282105] x11: ffffc8b041d1b148 x10: 00000000ffff8000 x9 : ffffc8b04012812c
> > [   15.289228] x8 : 00000000ffff7fff x7 : ffffc8b041d1b148 x6 : 0000000000000000
> > [   15.296349] x5 : 0000000000000000 x4 : 0000000000007fff x3 : 0000000000000000
> > [   15.303471] x2 : 0000000000000000 x1 : ffff07ff8c064800 x0 : 000000000000006b
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
> > This bug introduced by commit b261dba2fdb2 ("arm64: kdump: Remove custom
> > linux,usable-memory-range handling"), which moves
> > memblock_cap_memory_range() to fdt, but it breaches the rules that
> > memblock_cap_memory_range() should come after memblock_add() etc as said
> > in commit e888fa7bb882 ("memblock: Check memory add/cap ordering").
> 
> void __init early_init_dt_scan_nodes(void)
> {
> 	//(1) -->early_init_dt_check_for_usable_mem_range, fill cap_mem_addr
>         rc = of_scan_flat_dt(early_init_dt_scan_chosen, boot_command_line);
> 
> 	//(2) --> early_init_dt_add_memory_arch --> memblock_add()
>         of_scan_flat_dt(early_init_dt_scan_memory, NULL);
> 
> 	//(3)
>         memblock_cap_memory_range(cap_mem_addr, cap_mem_size);
> }
> 
> I didn't get it. The above step (1),(2),(3) comply with
> commit e888fa7bb882 ("memblock: Check memory add/cap ordering")
> 
Well, at this scope, it does. But from a larger scope, let's say on
arm64,
setup_arch
  ...
  setup_machine_fdt(); //which holds your case
  ...
  efi_init(); //which call memblock_add, and breach the ordering.

> Did you see the warning?
> pr_warn("%s: No memory registered yet\n", __func__);
> 
Yes, I did see this message, which brings me to commit e888fa7bb882
("memblock: Check memory add/cap ordering")

I am also curious why this bug does not be discovered. Is CONFIG_EFI
on at your case? 

Thanks,

	Pingfan
> > 
> > As a consequence, the virtual address set up by copy_oldmem_page() does
> > not bail out from the test of virt_addr_valid() in check_heap_object(),
> > and finally hits the BUG_ON().
> > 
> > Since memblock allocator has no idea about when the memblock is fully
> > populated, while efi_init() is aware, so tackling this issue by calling the
> > interface early_init_dt_check_for_usable_mem_range() exposed by of/fdt.
> > 
> > Fixes: b261dba2fdb2 ("arm64: kdump: Remove custom linux,usable-memory-range handling")
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
> > 
> > diff --git a/drivers/firmware/efi/efi-init.c b/drivers/firmware/efi/efi-init.c
> > index b19ce1a83f91..b2c829e95bd1 100644
> > --- a/drivers/firmware/efi/efi-init.c
> > +++ b/drivers/firmware/efi/efi-init.c
> > @@ -235,6 +235,11 @@ void __init efi_init(void)
> >  	}
> >  
> >  	reserve_regions();
> > +	/*
> > +	 * For memblock manipulation, the cap should come after the memblock_add().
> > +	 * And now, memblock is fully populated, it is time to do capping.
> > +	 */
> > +	early_init_dt_check_for_usable_mem_range();
> >  	efi_esrt_init();
> >  	efi_mokvar_table_init();
> >  
> > diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> > index 18a2df431bfd..aa07ef5cab5f 100644
> > --- a/drivers/of/fdt.c
> > +++ b/drivers/of/fdt.c
> > @@ -972,7 +972,7 @@ static unsigned long chosen_node_offset = -FDT_ERR_NOTFOUND;
> >   * location from flat tree
> >   * @node: reference to node containing usable memory range location ('chosen')
> >   */
> > -static void __init early_init_dt_check_for_usable_mem_range(void)
> > +void __init early_init_dt_check_for_usable_mem_range(void)
> >  {
> >  	const __be32 *prop;
> >  	int len;
> > diff --git a/include/linux/of_fdt.h b/include/linux/of_fdt.h
> > index cf48983d3c86..ad09beb6d13c 100644
> > --- a/include/linux/of_fdt.h
> > +++ b/include/linux/of_fdt.h
> > @@ -62,6 +62,7 @@ extern int early_init_dt_scan_chosen(unsigned long node, const char *uname,
> >  				     int depth, void *data);
> >  extern int early_init_dt_scan_memory(unsigned long node, const char *uname,
> >  				     int depth, void *data);
> > +extern void early_init_dt_check_for_usable_mem_range(void);
> >  extern int early_init_dt_scan_chosen_stdout(void);
> >  extern void early_init_fdt_scan_reserved_mem(void);
> >  extern void early_init_fdt_reserve_self(void);
> > @@ -86,6 +87,7 @@ extern void unflatten_and_copy_device_tree(void);
> >  extern void early_init_devtree(void *);
> >  extern void early_get_first_memblock_info(void *, phys_addr_t *);
> >  #else /* CONFIG_OF_EARLY_FLATTREE */
> > +static inline void early_init_dt_check_for_usable_mem_range(void) {}
> >  static inline int early_init_dt_scan_chosen_stdout(void) { return -ENODEV; }
> >  static inline void early_init_fdt_scan_reserved_mem(void) {}
> >  static inline void early_init_fdt_reserve_self(void) {}
> > 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
