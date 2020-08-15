Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E41E62454B1
	for <lists+linux-efi@lfdr.de>; Sun, 16 Aug 2020 00:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728130AbgHOWjk (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 15 Aug 2020 18:39:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726825AbgHOWjj (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 15 Aug 2020 18:39:39 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2614C061786
        for <linux-efi@vger.kernel.org>; Sat, 15 Aug 2020 15:39:39 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id t10so5699724plz.10
        for <linux-efi@vger.kernel.org>; Sat, 15 Aug 2020 15:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=WQ5OI4UCJDE+qCrOzP54nmzSKEv4r9sWpyhZFytCM3o=;
        b=t/Iwf9VEvU6m5tL6BD+5Z9xDWKQZ0bAXbfokrTshGedHqb5QkOILqKXIEBnmn9A2Ie
         HGZ9dPQ5JcHgpNRwnIl8o+e49+1yY2TnwIHdC96lXyRvFkBKo6VMVtmnomT5EriauY6Y
         +6im3cDE37fBt8odVlTm26Xjigm7NSOi0roUSWiLSCIHdnp02d1N4O9FLbGzrxMGLLV3
         0AQFh+Sogmb6I/IN3aQPc1OJ4YWNFqA/gIPH9/RssWuFDjUeT+m6cgSsRypBbo+bbk15
         YtFLBgjvEApBuQxCZQhQ5ofMlY9QHUWNPkxL7fbP7CSABAFOCfuSGvMBqwtEAkR4qkd2
         QSNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=WQ5OI4UCJDE+qCrOzP54nmzSKEv4r9sWpyhZFytCM3o=;
        b=oCHAe5fnlN1RAv0RSZ4yz6dM7pvHhiSp+k14bnMXADrNcpCdNxnfZuqFSEaJ1NU+DK
         MLTpR6VnQ6vn92nEVke2eFvXD3nv+eesT9+IGQ8Gr7fDceVvHzYN3EPyes5EbK1keLsF
         fQQ7Qveyi/ec7GIo1II5YYklO3cBmUCqiSMOpeLLzXlzoub/yNy+evRlHDrMQ7vsIha+
         BHhkeVjSAigGhfp8P+D0kImVqG8Hisu73C60CQRZu2O4kmv6eGdID83V3khUovl1bvN/
         95jLn3UuJF3C1jL3jEM8KHfaeeg9WcxsgkMk5oqsD64A+HtaJUP4ICDgUcH6UZrT7wY9
         v3cg==
X-Gm-Message-State: AOAM532wOfdBMyS8SBZCH6MM/qIrEUCxhmosZyPI+EdQoV7etR5MiaDN
        0AQKtKJyI8U1CMH5RaroDbSB7Q==
X-Google-Smtp-Source: ABdhPJyNIMVJgrggqji8XuHVSKPD4LVWLQ4smCU7xc+FXAM4pddrIpsAUMxVFqrfCnqajfwLEOLsRw==
X-Received: by 2002:a17:90a:1d0f:: with SMTP id c15mr7424337pjd.180.1597531179004;
        Sat, 15 Aug 2020 15:39:39 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id d127sm13047599pfc.175.2020.08.15.15.39.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2020 15:39:37 -0700 (PDT)
Date:   Sat, 15 Aug 2020 15:39:37 -0700 (PDT)
X-Google-Original-Date: Fri, 14 Aug 2020 17:17:01 PDT (-0700)
Subject:     Re: [PATCH v5 1/9] RISC-V: Move DT mapping outof fixmap
In-Reply-To: <20200812234758.3563-2-atish.patra@wdc.com>
CC:     linux-kernel@vger.kernel.org, Anup Patel <Anup.Patel@wdc.com>,
        Atish Patra <Atish.Patra@wdc.com>, aou@eecs.berkeley.edu,
        Alistair Francis <Alistair.Francis@wdc.com>,
        akpm@linux-foundation.org, ardb@kernel.org, nivedita@alum.mit.edu,
        bp@suse.de, greentime.hu@sifive.com, mingo@kernel.org,
        keescook@chromium.org, linux-efi@vger.kernel.org,
        linux-riscv@lists.infradead.org, fwts-devel@lists.ubuntu.com,
        han_mao@c-sky.com, masahiroy@kernel.org, michal.simek@xilinx.com,
        rppt@kernel.org, Nick Desaulniers <ndesaulniers@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>, steven.price@arm.com,
        longman@redhat.com, will@kernel.org, daniel.schaefer@hpe.com,
        abner.chang@hpe.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Atish Patra <Atish.Patra@wdc.com>
Message-ID: <mhng-163a2157-ae6c-424e-b3f1-581364f7650a@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 12 Aug 2020 16:47:50 PDT (-0700), Atish Patra wrote:
> From: Anup Patel <anup.patel@wdc.com>
>
> Currently, RISC-V reserves 1MB of fixmap memory for device tree. However,
> it maps only single PMD (2MB) space for fixmap which leaves only < 1MB space
> left for other kernel features such as early ioremap which requires fixmap
> as well. The fixmap size can be increased by another 2MB but it brings
> additional complexity and changes the virtual memory layout as well.
> If we require some additional feature requiring fixmap again, it has to be
> moved again.
>
> Technically, DT doesn't need a fixmap as the memory occupied by the DT is
> only used during boot. That's why, We map device tree in early page table
> using two consecutive PGD mappings at lower addresses (< PAGE_OFFSET).
> This frees lot of space in fixmap and also makes maximum supported
> device tree size supported as PGDIR_SIZE. Thus, init memory section can be used
> for the same purpose as well. This simplifies fixmap implementation.
>
> Signed-off-by: Anup Patel <anup.patel@wdc.com>
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> ---
>  arch/riscv/include/asm/fixmap.h  |  3 ---
>  arch/riscv/include/asm/pgtable.h |  1 +
>  arch/riscv/kernel/head.S         |  1 -
>  arch/riscv/kernel/head.h         |  2 --
>  arch/riscv/kernel/setup.c        |  9 +++++++--
>  arch/riscv/mm/init.c             | 26 ++++++++++++--------------
>  6 files changed, 20 insertions(+), 22 deletions(-)
>
> diff --git a/arch/riscv/include/asm/fixmap.h b/arch/riscv/include/asm/fixmap.h
> index 1ff075a8dfc7..11613f38228a 100644
> --- a/arch/riscv/include/asm/fixmap.h
> +++ b/arch/riscv/include/asm/fixmap.h
> @@ -22,9 +22,6 @@
>   */
>  enum fixed_addresses {
>  	FIX_HOLE,
> -#define FIX_FDT_SIZE	SZ_1M
> -	FIX_FDT_END,
> -	FIX_FDT = FIX_FDT_END + FIX_FDT_SIZE / PAGE_SIZE - 1,
>  	FIX_PTE,
>  	FIX_PMD,
>  	FIX_TEXT_POKE1,
> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
> index eaea1f717010..815f8c959dd4 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -464,6 +464,7 @@ static inline void __kernel_map_pages(struct page *page, int numpages, int enabl
>  #define kern_addr_valid(addr)   (1) /* FIXME */
>
>  extern void *dtb_early_va;
> +extern uintptr_t dtb_early_pa;
>  void setup_bootmem(void);
>  void paging_init(void);
>
> diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
> index 7822054dbd88..a2f0cb3ca0a6 100644
> --- a/arch/riscv/kernel/head.S
> +++ b/arch/riscv/kernel/head.S
> @@ -255,7 +255,6 @@ clear_bss_done:
>  #endif
>  	/* Start the kernel */
>  	call soc_early_init
> -	call parse_dtb
>  	tail start_kernel
>
>  .Lsecondary_start:
> diff --git a/arch/riscv/kernel/head.h b/arch/riscv/kernel/head.h
> index 105fb0496b24..b48dda3d04f6 100644
> --- a/arch/riscv/kernel/head.h
> +++ b/arch/riscv/kernel/head.h
> @@ -16,6 +16,4 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa);
>  extern void *__cpu_up_stack_pointer[];
>  extern void *__cpu_up_task_pointer[];
>
> -void __init parse_dtb(void);
> -
>  #endif /* __ASM_HEAD_H */
> diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> index f04373be54a6..6a0ee2405813 100644
> --- a/arch/riscv/kernel/setup.c
> +++ b/arch/riscv/kernel/setup.c
> @@ -49,8 +49,9 @@ atomic_t hart_lottery __section(.sdata);
>  unsigned long boot_cpu_hartid;
>  static DEFINE_PER_CPU(struct cpu, cpu_devices);
>
> -void __init parse_dtb(void)
> +static void __init parse_dtb(void)
>  {
> +	/* Early scan of device tree from init memory */
>  	if (early_init_dt_scan(dtb_early_va))
>  		return;
>
> @@ -63,6 +64,7 @@ void __init parse_dtb(void)
>
>  void __init setup_arch(char **cmdline_p)
>  {
> +	parse_dtb();
>  	init_mm.start_code = (unsigned long) _stext;
>  	init_mm.end_code   = (unsigned long) _etext;
>  	init_mm.end_data   = (unsigned long) _edata;
> @@ -77,7 +79,10 @@ void __init setup_arch(char **cmdline_p)
>  #if IS_ENABLED(CONFIG_BUILTIN_DTB)
>  	unflatten_and_copy_device_tree();
>  #else
> -	unflatten_device_tree();
> +	if (early_init_dt_verify(__va(dtb_early_pa)))
> +		unflatten_device_tree();
> +	else
> +		pr_err("No DTB found in kernel mappings\n");
>  #endif
>  	clint_init_boot_cpu();
>
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index 787c75f751a5..2b651f63f5c4 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -28,7 +28,9 @@ unsigned long empty_zero_page[PAGE_SIZE / sizeof(unsigned long)]
>  EXPORT_SYMBOL(empty_zero_page);
>
>  extern char _start[];
> -void *dtb_early_va;
> +#define DTB_EARLY_BASE_VA      PGDIR_SIZE
> +void *dtb_early_va __initdata;
> +uintptr_t dtb_early_pa __initdata;
>
>  static void __init zone_sizes_init(void)
>  {
> @@ -141,8 +143,6 @@ static void __init setup_initrd(void)
>  }
>  #endif /* CONFIG_BLK_DEV_INITRD */
>
> -static phys_addr_t dtb_early_pa __initdata;
> -
>  void __init setup_bootmem(void)
>  {
>  	struct memblock_region *reg;
> @@ -399,7 +399,7 @@ static uintptr_t __init best_map_size(phys_addr_t base, phys_addr_t size)
>
>  asmlinkage void __init setup_vm(uintptr_t dtb_pa)
>  {
> -	uintptr_t va, end_va;
> +	uintptr_t va, pa, end_va;
>  	uintptr_t load_pa = (uintptr_t)(&_start);
>  	uintptr_t load_sz = (uintptr_t)(&_end) - load_pa;
>  	uintptr_t map_size = best_map_size(load_pa, MAX_EARLY_MAPPING_SIZE);
> @@ -448,16 +448,13 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
>  				   load_pa + (va - PAGE_OFFSET),
>  				   map_size, PAGE_KERNEL_EXEC);
>
> -	/* Create fixed mapping for early FDT parsing */
> -	end_va = __fix_to_virt(FIX_FDT) + FIX_FDT_SIZE;
> -	for (va = __fix_to_virt(FIX_FDT); va < end_va; va += PAGE_SIZE)
> -		create_pte_mapping(fixmap_pte, va,
> -				   dtb_pa + (va - __fix_to_virt(FIX_FDT)),
> -				   PAGE_SIZE, PAGE_KERNEL);
> -
> -	/* Save pointer to DTB for early FDT parsing */
> -	dtb_early_va = (void *)fix_to_virt(FIX_FDT) + (dtb_pa & ~PAGE_MASK);
> -	/* Save physical address for memblock reservation */
> +	/* Create two consecutive PGD mappings for FDT early scan */
> +	pa = dtb_pa & ~(PGDIR_SIZE - 1);
> +	create_pgd_mapping(early_pg_dir, DTB_EARLY_BASE_VA,
> +			   pa, PGDIR_SIZE, PAGE_KERNEL);
> +	create_pgd_mapping(early_pg_dir, DTB_EARLY_BASE_VA + PGDIR_SIZE,
> +			   pa + PGDIR_SIZE, PGDIR_SIZE, PAGE_KERNEL);
> +	dtb_early_va = (void *)DTB_EARLY_BASE_VA + (dtb_pa & (PGDIR_SIZE - 1));
>  	dtb_early_pa = dtb_pa;
>  }
>
> @@ -516,6 +513,7 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
>  #else
>  	dtb_early_va = (void *)dtb_pa;
>  #endif
> +	dtb_early_pa = dtb_pa;
>  }
>
>  static inline void setup_vm_final(void)

Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
