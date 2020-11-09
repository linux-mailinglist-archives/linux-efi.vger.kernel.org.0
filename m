Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 113542AB1D8
	for <lists+linux-efi@lfdr.de>; Mon,  9 Nov 2020 08:44:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729663AbgKIHoT (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 9 Nov 2020 02:44:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728038AbgKIHoT (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 9 Nov 2020 02:44:19 -0500
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EE7CC0613D3
        for <linux-efi@vger.kernel.org>; Sun,  8 Nov 2020 23:44:17 -0800 (PST)
Received: by mail-qv1-xf43.google.com with SMTP id e5so1915055qvs.1
        for <linux-efi@vger.kernel.org>; Sun, 08 Nov 2020 23:44:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=BAzxImQeGew3V10Gaqbpb9UzE3FgbyZVObI8SUJB0VA=;
        b=kVHWiVnD0G8/FYfq6hhlxCzSZT8Njd8zOKuOz7NPGjAhjjj0yDi+s9MAL3my+eKufe
         YfH5JdtT9e7TuG7KQlDtqJS6O9cnBWPxylZObMOfQJJmymIwb2oGwkqPQ6pMPuD+BIp3
         1WnqA/wxBv5Ghys0mPb8GZDuRbpEIikT1GbWB5OvIcIsqQlAN4lXNZm1OThjia98Mfde
         ipeqgHlDghxnMi4UHHLGoKlI1VPinX5A8jSNXCLS7rPrV/WB/Z1xdyRi1+p2Iuc/wLbf
         vTG6lHMIHNGie6nBkKS4V8sviX7IGbGp/f8W08hPk0b0lBJtOya+yhAzq+ADMz32LKD2
         r9Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BAzxImQeGew3V10Gaqbpb9UzE3FgbyZVObI8SUJB0VA=;
        b=HrssXXtbegSA8roi9BV6wNY0VbDUKH9VT4MgAl/WboKeP/dqvYrlTUR221ByyHDK/M
         EqmI5WXl5dFkLosKOOPLRs7SUKZmaPnG30Yp3jz77X6vjiialCLb/QAVoO7y2liPdfSu
         mHrVjk5qxaG0QfbtJEIIxHxaqkezzXVITVQ2XL+lcFycXO88dqKSGlm2tn7Ky8uS3MIG
         ZkoURzULDnAYMF+smWI93XrrN2ajg+0WjMnOeSymSArtS7XxjqAOxKObcMBpbAEoArEs
         ua9TrO3hWJreAop4uhhdTzR4NDvnEUGPAoz8pUgePuDzx5W2wFVHCNxv644BxoGDwiTR
         EzPw==
X-Gm-Message-State: AOAM531P0PUBoS6e3qUsa87vfL3VtAG7p1z49SqXvkpWKnRDyKbC/K13
        juhTpiSkLaFqJeNDP64SNlMfO8V0SyCVaayoHMQBcQ==
X-Google-Smtp-Source: ABdhPJzTAq2BKHPHpV6EFm4+yiXyKDUSQ98sZi+LPscPMQaxtU1GGednDBD+A1+kCmij+ZIIexd2JUJ9Ux4Cb3REhBQ=
X-Received: by 2002:ad4:55c2:: with SMTP id bt2mr2621224qvb.48.1604907855424;
 Sun, 08 Nov 2020 23:44:15 -0800 (PST)
MIME-Version: 1.0
References: <20200917223716.2300238-1-atish.patra@wdc.com> <20200917223716.2300238-2-atish.patra@wdc.com>
In-Reply-To: <20200917223716.2300238-2-atish.patra@wdc.com>
From:   Greentime Hu <greentime.hu@sifive.com>
Date:   Mon, 9 Nov 2020 15:44:03 +0800
Message-ID: <CAHCEehJVEJzUrAsYqiZCZ7_qtJ+uXBrdbj6LQkZW-v87CRiH=Q@mail.gmail.com>
Subject: Re: [PATCH v8 1/7] RISC-V: Move DT mapping outof fixmap
To:     Atish Patra <atish.patra@wdc.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Anup Patel <anup.patel@wdc.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alistair Francis <alistair.francis@wdc.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Borislav Petkov <bp@suse.de>,
        Heiko Carstens <hca@linux.ibm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Kees Cook <keescook@chromium.org>, linux-efi@vger.kernel.org,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Maxim Uvarov <maxim.uvarov@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Mike Rapoport <rppt@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Zong Li <zong.li@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Atish Patra <atish.patra@wdc.com> =E6=96=BC 2020=E5=B9=B49=E6=9C=8818=E6=97=
=A5 =E9=80=B1=E4=BA=94 =E4=B8=8A=E5=8D=886:37=E5=AF=AB=E9=81=93=EF=BC=9A
>
> From: Anup Patel <anup.patel@wdc.com>
>
> Currently, RISC-V reserves 1MB of fixmap memory for device tree. However,
> it maps only single PMD (2MB) space for fixmap which leaves only < 1MB sp=
ace
> left for other kernel features such as early ioremap which requires fixma=
p
> as well. The fixmap size can be increased by another 2MB but it brings
> additional complexity and changes the virtual memory layout as well.
> If we require some additional feature requiring fixmap again, it has to b=
e
> moved again.
>
> Technically, DT doesn't need a fixmap as the memory occupied by the DT is
> only used during boot. That's why, We map device tree in early page table
> using two consecutive PGD mappings at lower addresses (< PAGE_OFFSET).
> This frees lot of space in fixmap and also makes maximum supported
> device tree size supported as PGDIR_SIZE. Thus, init memory section can b=
e used
> for the same purpose as well. This simplifies fixmap implementation.
>
> Signed-off-by: Anup Patel <anup.patel@wdc.com>
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
> Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>
> ---
>  arch/riscv/include/asm/fixmap.h  |  3 ---
>  arch/riscv/include/asm/pgtable.h |  1 +
>  arch/riscv/kernel/head.S         |  1 -
>  arch/riscv/kernel/head.h         |  2 --
>  arch/riscv/kernel/setup.c        |  9 +++++++--
>  arch/riscv/mm/init.c             | 26 ++++++++++++--------------
>  6 files changed, 20 insertions(+), 22 deletions(-)
>
> diff --git a/arch/riscv/include/asm/fixmap.h b/arch/riscv/include/asm/fix=
map.h
> index 1ff075a8dfc7..11613f38228a 100644
> --- a/arch/riscv/include/asm/fixmap.h
> +++ b/arch/riscv/include/asm/fixmap.h
> @@ -22,9 +22,6 @@
>   */
>  enum fixed_addresses {
>         FIX_HOLE,
> -#define FIX_FDT_SIZE   SZ_1M
> -       FIX_FDT_END,
> -       FIX_FDT =3D FIX_FDT_END + FIX_FDT_SIZE / PAGE_SIZE - 1,
>         FIX_PTE,
>         FIX_PMD,
>         FIX_TEXT_POKE1,
> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pg=
table.h
> index eaea1f717010..815f8c959dd4 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -464,6 +464,7 @@ static inline void __kernel_map_pages(struct page *pa=
ge, int numpages, int enabl
>  #define kern_addr_valid(addr)   (1) /* FIXME */
>
>  extern void *dtb_early_va;
> +extern uintptr_t dtb_early_pa;
>  void setup_bootmem(void);
>  void paging_init(void);
>
> diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
> index 0a4e81b8dc79..c6a37e8231a8 100644
> --- a/arch/riscv/kernel/head.S
> +++ b/arch/riscv/kernel/head.S
> @@ -259,7 +259,6 @@ clear_bss_done:
>  #endif
>         /* Start the kernel */
>         call soc_early_init
> -       call parse_dtb
>         tail start_kernel
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
> index 2c6dd329312b..edea7ef88402 100644
> --- a/arch/riscv/kernel/setup.c
> +++ b/arch/riscv/kernel/setup.c
> @@ -48,8 +48,9 @@ atomic_t hart_lottery __section(.sdata);
>  unsigned long boot_cpu_hartid;
>  static DEFINE_PER_CPU(struct cpu, cpu_devices);
>
> -void __init parse_dtb(void)
> +static void __init parse_dtb(void)
>  {
> +       /* Early scan of device tree from init memory */
>         if (early_init_dt_scan(dtb_early_va))
>                 return;
>
> @@ -62,6 +63,7 @@ void __init parse_dtb(void)
>
>  void __init setup_arch(char **cmdline_p)
>  {
> +       parse_dtb();
>         init_mm.start_code =3D (unsigned long) _stext;
>         init_mm.end_code   =3D (unsigned long) _etext;
>         init_mm.end_data   =3D (unsigned long) _edata;
> @@ -76,7 +78,10 @@ void __init setup_arch(char **cmdline_p)
>  #if IS_ENABLED(CONFIG_BUILTIN_DTB)
>         unflatten_and_copy_device_tree();
>  #else
> -       unflatten_device_tree();
> +       if (early_init_dt_verify(__va(dtb_early_pa)))
> +               unflatten_device_tree();
> +       else
> +               pr_err("No DTB found in kernel mappings\n");
>  #endif
>
>  #ifdef CONFIG_SWIOTLB
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index 787c75f751a5..2b651f63f5c4 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -28,7 +28,9 @@ unsigned long empty_zero_page[PAGE_SIZE / sizeof(unsign=
ed long)]
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
>         struct memblock_region *reg;
> @@ -399,7 +399,7 @@ static uintptr_t __init best_map_size(phys_addr_t bas=
e, phys_addr_t size)
>
>  asmlinkage void __init setup_vm(uintptr_t dtb_pa)
>  {
> -       uintptr_t va, end_va;
> +       uintptr_t va, pa, end_va;
>         uintptr_t load_pa =3D (uintptr_t)(&_start);
>         uintptr_t load_sz =3D (uintptr_t)(&_end) - load_pa;
>         uintptr_t map_size =3D best_map_size(load_pa, MAX_EARLY_MAPPING_S=
IZE);
> @@ -448,16 +448,13 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
>                                    load_pa + (va - PAGE_OFFSET),
>                                    map_size, PAGE_KERNEL_EXEC);
>
> -       /* Create fixed mapping for early FDT parsing */
> -       end_va =3D __fix_to_virt(FIX_FDT) + FIX_FDT_SIZE;
> -       for (va =3D __fix_to_virt(FIX_FDT); va < end_va; va +=3D PAGE_SIZ=
E)
> -               create_pte_mapping(fixmap_pte, va,
> -                                  dtb_pa + (va - __fix_to_virt(FIX_FDT))=
,
> -                                  PAGE_SIZE, PAGE_KERNEL);
> -
> -       /* Save pointer to DTB for early FDT parsing */
> -       dtb_early_va =3D (void *)fix_to_virt(FIX_FDT) + (dtb_pa & ~PAGE_M=
ASK);
> -       /* Save physical address for memblock reservation */
> +       /* Create two consecutive PGD mappings for FDT early scan */
> +       pa =3D dtb_pa & ~(PGDIR_SIZE - 1);
> +       create_pgd_mapping(early_pg_dir, DTB_EARLY_BASE_VA,
> +                          pa, PGDIR_SIZE, PAGE_KERNEL);
Hi Anup,

I hit a booting failure case in Unleashed board in v5.10-rc2.

After debugging, it looks like something wrong in this patch.
It will create 0x40000000 as a VA start address for this mapping in rv64 he=
re.
#define DTB_EARLY_BASE_VA      PGDIR_SIZE

but using __va(dtb_early_pa) to get the virtual address?
if (early_init_dt_verify(__va(dtb_early_pa)))
              unflatten_device_tree();

Would you please to take a look at it? I am not sure if I
misunderstand something.
Thank you. :)
