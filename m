Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07C2F2454B3
	for <lists+linux-efi@lfdr.de>; Sun, 16 Aug 2020 00:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728660AbgHOWjm (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 15 Aug 2020 18:39:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727994AbgHOWjl (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 15 Aug 2020 18:39:41 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F034C061786
        for <linux-efi@vger.kernel.org>; Sat, 15 Aug 2020 15:39:41 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id ep8so5913763pjb.3
        for <linux-efi@vger.kernel.org>; Sat, 15 Aug 2020 15:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=qZZS3QqLxW0x2IUSQb8kGqWIW2Rbo+SUaTphs4YMLjY=;
        b=PahHdVgLtDceDSUxCJjinZbquJ+2LIhE3CgwscYYx81HvaSqgkv3iPPpKjsDFmmBkW
         Aw43/99brrNu1suJKzK3eGif/uI0zUWGh/iIP5Ud8vp+A1KXB49cVV04pH8z6Q8+4FxV
         xW9mqdN2G4G/P74iC5X050VLPNJZ2VgTGptDwz8dNCbRxL1PuqQENWEDQfbTswmgc3D0
         ZYBH818OeO8U11FgEvncSTAnFUR1o11u68sFj/v1TkVowymZwWbzRmCwd8yb/YdpkebS
         sRZUrYR8PVLdalwcxMFy2qM+kxfGpyWvfG5abP99aT0np0bf3maUITD4K5En8pK2KGpT
         e0pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=qZZS3QqLxW0x2IUSQb8kGqWIW2Rbo+SUaTphs4YMLjY=;
        b=Q6GjDN3dO5YQpWmrLG+qvZW2cO5KYXoUqSQJGdEpYAjQniWUGfI050L5XGQrzfGl9r
         uOINUyGxIz+jMAxaM4vW4m7j3f2dTQuacn8c54JdguMkfk6dXSH/yQK+vwAHBz7PgfgR
         M2bvlDCW39/MMTWcLYqTBO9hZ4ybP3opL7TryPrfpFYE1IwRZ3zKxcHUdMeKHWKYDMmL
         hi6880DX7MdkSUVWaxzahgEoruzA5rcSZ0xjsahjrNfqR/wRCGKT1EbNSwCLouGbcE/N
         94gfOmeNG/Sxe1w7CTYBjFgIzy6CTS7DcZgT7YWpOjaB/Rs2gfhLJJaSHkvM4Q6rsqx5
         1Zgg==
X-Gm-Message-State: AOAM532Mh70YkZ8pq2JgrOkmp80FTiBYxnbRUyqvFAKyfsJ4E7oy+Rhw
        DsrFq9cxAg7lGnRlMJUeckWxZSqqRvDcjQ==
X-Google-Smtp-Source: ABdhPJzQ3/qxoCM1pD6I7fIrLFu+lfjNpT/Xr+EeE2QbxI7YjKJFvDOcewB9Fy90lvmv3GRQ6gI9QQ==
X-Received: by 2002:a17:902:848d:: with SMTP id c13mr6283615plo.304.1597531180479;
        Sat, 15 Aug 2020 15:39:40 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id b22sm13476748pfb.52.2020.08.15.15.39.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2020 15:39:39 -0700 (PDT)
Date:   Sat, 15 Aug 2020 15:39:39 -0700 (PDT)
X-Google-Original-Date: Fri, 14 Aug 2020 17:33:14 PDT (-0700)
Subject:     Re: [PATCH v5 2/9] RISC-V: Add early ioremap support
In-Reply-To: <20200812234758.3563-3-atish.patra@wdc.com>
CC:     linux-kernel@vger.kernel.org, Atish Patra <Atish.Patra@wdc.com>,
        aou@eecs.berkeley.edu, Alistair Francis <Alistair.Francis@wdc.com>,
        akpm@linux-foundation.org, Anup Patel <Anup.Patel@wdc.com>,
        ardb@kernel.org, nivedita@alum.mit.edu, bp@suse.de,
        greentime.hu@sifive.com, mingo@kernel.org, keescook@chromium.org,
        linux-efi@vger.kernel.org, linux-riscv@lists.infradead.org,
        fwts-devel@lists.ubuntu.com, han_mao@c-sky.com,
        masahiroy@kernel.org, michal.simek@xilinx.com, rppt@kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>, steven.price@arm.com,
        longman@redhat.com, will@kernel.org, daniel.schaefer@hpe.com,
        abner.chang@hpe.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Atish Patra <Atish.Patra@wdc.com>
Message-ID: <mhng-13f476e6-5247-4960-83dd-4d2d96de4bce@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 12 Aug 2020 16:47:51 PDT (-0700), Atish Patra wrote:
> UEFI uses early IO or memory mappings for runtime services before
> normal ioremap() is usable. Add the necessary fixmap bindings and
> pmd mappings for generic ioremap support to work.
>
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> ---
>  arch/riscv/Kconfig              |  1 +
>  arch/riscv/include/asm/Kbuild   |  1 +
>  arch/riscv/include/asm/fixmap.h | 13 +++++++++++++
>  arch/riscv/include/asm/io.h     |  1 +
>  arch/riscv/kernel/setup.c       |  1 +
>  arch/riscv/mm/init.c            | 33 +++++++++++++++++++++++++++++++++
>  6 files changed, 50 insertions(+)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 7b5905529146..15597f5f504f 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -37,6 +37,7 @@ config RISCV
>  	select GENERIC_ARCH_TOPOLOGY if SMP
>  	select GENERIC_ATOMIC64 if !64BIT
>  	select GENERIC_CLOCKEVENTS
> +	select GENERIC_EARLY_IOREMAP
>  	select GENERIC_GETTIMEOFDAY if HAVE_GENERIC_VDSO
>  	select GENERIC_IOREMAP
>  	select GENERIC_IRQ_MULTI_HANDLER
> diff --git a/arch/riscv/include/asm/Kbuild b/arch/riscv/include/asm/Kbuild
> index 3d9410bb4de0..59dd7be55005 100644
> --- a/arch/riscv/include/asm/Kbuild
> +++ b/arch/riscv/include/asm/Kbuild
> @@ -1,4 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0
> +generic-y += early_ioremap.h
>  generic-y += extable.h
>  generic-y += flat.h
>  generic-y += kvm_para.h
> diff --git a/arch/riscv/include/asm/fixmap.h b/arch/riscv/include/asm/fixmap.h
> index 11613f38228a..54cbf07fb4e9 100644
> --- a/arch/riscv/include/asm/fixmap.h
> +++ b/arch/riscv/include/asm/fixmap.h
> @@ -27,6 +27,19 @@ enum fixed_addresses {
>  	FIX_TEXT_POKE1,
>  	FIX_TEXT_POKE0,
>  	FIX_EARLYCON_MEM_BASE,
> +
> +	__end_of_permanent_fixed_addresses,
> +	/*
> +	 * Temporary boot-time mappings, used by early_ioremap(),
> +	 * before ioremap() is functional.
> +	 */
> +#define NR_FIX_BTMAPS		(SZ_256K / PAGE_SIZE)
> +#define FIX_BTMAPS_SLOTS	7
> +#define TOTAL_FIX_BTMAPS	(NR_FIX_BTMAPS * FIX_BTMAPS_SLOTS)
> +
> +	FIX_BTMAP_END = __end_of_permanent_fixed_addresses,
> +	FIX_BTMAP_BEGIN = FIX_BTMAP_END + TOTAL_FIX_BTMAPS - 1,
> +
>  	__end_of_fixed_addresses
>  };
>
> diff --git a/arch/riscv/include/asm/io.h b/arch/riscv/include/asm/io.h
> index 3835c3295dc5..c025a746a148 100644
> --- a/arch/riscv/include/asm/io.h
> +++ b/arch/riscv/include/asm/io.h
> @@ -14,6 +14,7 @@
>  #include <linux/types.h>
>  #include <linux/pgtable.h>
>  #include <asm/mmiowb.h>
> +#include <asm/early_ioremap.h>
>
>  /*
>   * MMIO access functions are separated out to break dependency cycles
> diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> index 6a0ee2405813..c71788e6aff4 100644
> --- a/arch/riscv/kernel/setup.c
> +++ b/arch/riscv/kernel/setup.c
> @@ -72,6 +72,7 @@ void __init setup_arch(char **cmdline_p)
>
>  	*cmdline_p = boot_command_line;
>
> +	early_ioremap_setup();
>  	parse_early_param();
>
>  	setup_bootmem();
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index 2b651f63f5c4..b75ebe8e7a92 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -403,6 +403,9 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
>  	uintptr_t load_pa = (uintptr_t)(&_start);
>  	uintptr_t load_sz = (uintptr_t)(&_end) - load_pa;
>  	uintptr_t map_size = best_map_size(load_pa, MAX_EARLY_MAPPING_SIZE);
> +#ifndef __PAGETABLE_PMD_FOLDED
> +	pmd_t fix_bmap_spmd, fix_bmap_epmd;
> +#endif
>
>  	va_pa_offset = PAGE_OFFSET - load_pa;
>  	pfn_base = PFN_DOWN(load_pa);
> @@ -456,6 +459,36 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
>  			   pa + PGDIR_SIZE, PGDIR_SIZE, PAGE_KERNEL);
>  	dtb_early_va = (void *)DTB_EARLY_BASE_VA + (dtb_pa & (PGDIR_SIZE - 1));
>  	dtb_early_pa = dtb_pa;
> +
> +	/*
> +	 * Bootime fixmap only can handle PMD_SIZE mapping. Thus, boot-ioremap
> +	 * range can not span multiple pmds.
> +	 */
> +	BUILD_BUG_ON((__fix_to_virt(FIX_BTMAP_BEGIN) >> PMD_SHIFT)
> +		     != (__fix_to_virt(FIX_BTMAP_END) >> PMD_SHIFT));
> +
> +#ifndef __PAGETABLE_PMD_FOLDED
> +	/*
> +	 * Early ioremap fixmap is already created as it lies within first 2MB
> +	 * of fixmap region. We always map PMD_SIZE. Thus, both FIX_BTMAP_END
> +	 * FIX_BTMAP_BEGIN should lie in the same pmd. Verify that and warn
> +	 * the user if not.
> +	 */
> +	fix_bmap_spmd = fixmap_pmd[pmd_index(__fix_to_virt(FIX_BTMAP_BEGIN))];
> +	fix_bmap_epmd = fixmap_pmd[pmd_index(__fix_to_virt(FIX_BTMAP_END))];
> +	if (pmd_val(fix_bmap_spmd) != pmd_val(fix_bmap_epmd)) {
> +		WARN_ON(1);
> +		pr_warn("fixmap btmap start [%08lx] != end [%08lx]\n",
> +			pmd_val(fix_bmap_spmd), pmd_val(fix_bmap_epmd));
> +		pr_warn("fix_to_virt(FIX_BTMAP_BEGIN): %08lx\n",
> +			fix_to_virt(FIX_BTMAP_BEGIN));
> +		pr_warn("fix_to_virt(FIX_BTMAP_END):   %08lx\n",
> +			fix_to_virt(FIX_BTMAP_END));
> +
> +		pr_warn("FIX_BTMAP_END:       %d\n", FIX_BTMAP_END);
> +		pr_warn("FIX_BTMAP_BEGIN:     %d\n", FIX_BTMAP_BEGIN);
> +	}
> +#endif
>  }
>
>  static void __init setup_vm_final(void)

Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
