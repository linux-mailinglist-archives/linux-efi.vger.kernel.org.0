Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C83C2AB24C
	for <lists+linux-efi@lfdr.de>; Mon,  9 Nov 2020 09:19:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728049AbgKIITd (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 9 Nov 2020 03:19:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbgKIITd (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 9 Nov 2020 03:19:33 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1EB1C0613D3
        for <linux-efi@vger.kernel.org>; Mon,  9 Nov 2020 00:19:31 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id h2so7106845wmm.0
        for <linux-efi@vger.kernel.org>; Mon, 09 Nov 2020 00:19:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fM3dn2zBu2revBJd0X+jLt5JXF/ljsOebMARPxC00FU=;
        b=xU2Zkmy+UpsqNlek+ujmVFc8sEN/VmFiTK2zdSdZ+vb0Z6RonwLAQz63aiMCByr+AH
         k2+LkLpWWLQuPxaLMhHykbt72eufPwgql5ghQDM5VcIMotTvRNm/23pnO2B9mKwBvrSi
         tFq0PqWRweSUmoB0QArfkUvgw98GSiiEsp2OYOJd522l6aUpUIR4FMVBbq1SGi+z5b5M
         +DI76WfaxBWrggqMdGVsC/sG0HDXqKUnlh+5SJQT89/pkDD31Ebcf8fti2wrhhrFzYlG
         v3aiqJtKqiNAB8PcDKgTMDKwWOrWd3zpKr54KQHwFDPOLaWUGt/egEc1wNAAOj0L3dDs
         Oa6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fM3dn2zBu2revBJd0X+jLt5JXF/ljsOebMARPxC00FU=;
        b=X/YZB2vqBxfJJ58R4zc8jozxrkZQrIhtYBLvrN5DfSVDXJUJyx7Ljx4E5Nod05i+PU
         7YJ/TlAMsDK2Ca+RXzuYSqfq0m0O7WxPrJTHIgA5gtygi1da9Jos9GrNKF3X9v/mmQCT
         aDk9Ztk+BbUP1KlYP0XZ7fEmNsh3yJQziqOz/rjGGyNR9YvfK1eH2I7iLsx0fVAK1kz0
         OZp6HMUN0MR4UEcwyQsgiZeRe1dMgFTs6GS46Mx9GgZGULX5o/92EvTgu+OpQUntk2uO
         rqlquUeJdXWpe5zxPPVYHrC899sr2z4fHGrxAXyqj+c8OI+O/ApPcvSh99Toq/fHR2xp
         SzXg==
X-Gm-Message-State: AOAM533lolC+RXNWSo7bA62NvKGiHxh+81a4+/R2sEhNP/ztkzMinNVN
        q45bLiRrZ6gy5GQ0saKaysUpaLh3GcXyu+OYRPwRWQ==
X-Google-Smtp-Source: ABdhPJzdbbASJGxV3opCjrRRX5ErXC12sjxxwIOsgBxivpFf1FRXpalgNzgoc86UAFbGJxzz/xGNy5Jg7CWcVuwI4Xk=
X-Received: by 2002:a1c:61c2:: with SMTP id v185mr12857062wmb.152.1604909970073;
 Mon, 09 Nov 2020 00:19:30 -0800 (PST)
MIME-Version: 1.0
References: <20200917223716.2300238-1-atish.patra@wdc.com> <20200917223716.2300238-2-atish.patra@wdc.com>
 <CAHCEehJVEJzUrAsYqiZCZ7_qtJ+uXBrdbj6LQkZW-v87CRiH=Q@mail.gmail.com>
In-Reply-To: <CAHCEehJVEJzUrAsYqiZCZ7_qtJ+uXBrdbj6LQkZW-v87CRiH=Q@mail.gmail.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Mon, 9 Nov 2020 13:49:16 +0530
Message-ID: <CAAhSdy1XXy0=Wiy9tYDVhMuvFubmAuoUYzwuaT2Ye63kKSD8Fw@mail.gmail.com>
Subject: Re: [PATCH v8 1/7] RISC-V: Move DT mapping outof fixmap
To:     Greentime Hu <greentime.hu@sifive.com>
Cc:     Atish Patra <atish.patra@wdc.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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
        Kees Cook <keescook@chromium.org>,
        linux-efi <linux-efi@vger.kernel.org>,
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

On Mon, Nov 9, 2020 at 1:14 PM Greentime Hu <greentime.hu@sifive.com> wrote=
:
>
> Atish Patra <atish.patra@wdc.com> =E6=96=BC 2020=E5=B9=B49=E6=9C=8818=E6=
=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8A=E5=8D=886:37=E5=AF=AB=E9=81=93=EF=BC=9A
> >
> > From: Anup Patel <anup.patel@wdc.com>
> >
> > Currently, RISC-V reserves 1MB of fixmap memory for device tree. Howeve=
r,
> > it maps only single PMD (2MB) space for fixmap which leaves only < 1MB =
space
> > left for other kernel features such as early ioremap which requires fix=
map
> > as well. The fixmap size can be increased by another 2MB but it brings
> > additional complexity and changes the virtual memory layout as well.
> > If we require some additional feature requiring fixmap again, it has to=
 be
> > moved again.
> >
> > Technically, DT doesn't need a fixmap as the memory occupied by the DT =
is
> > only used during boot. That's why, We map device tree in early page tab=
le
> > using two consecutive PGD mappings at lower addresses (< PAGE_OFFSET).
> > This frees lot of space in fixmap and also makes maximum supported
> > device tree size supported as PGDIR_SIZE. Thus, init memory section can=
 be used
> > for the same purpose as well. This simplifies fixmap implementation.
> >
> > Signed-off-by: Anup Patel <anup.patel@wdc.com>
> > Signed-off-by: Atish Patra <atish.patra@wdc.com>
> > Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
> > Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>
> > ---
> >  arch/riscv/include/asm/fixmap.h  |  3 ---
> >  arch/riscv/include/asm/pgtable.h |  1 +
> >  arch/riscv/kernel/head.S         |  1 -
> >  arch/riscv/kernel/head.h         |  2 --
> >  arch/riscv/kernel/setup.c        |  9 +++++++--
> >  arch/riscv/mm/init.c             | 26 ++++++++++++--------------
> >  6 files changed, 20 insertions(+), 22 deletions(-)
> >
> > diff --git a/arch/riscv/include/asm/fixmap.h b/arch/riscv/include/asm/f=
ixmap.h
> > index 1ff075a8dfc7..11613f38228a 100644
> > --- a/arch/riscv/include/asm/fixmap.h
> > +++ b/arch/riscv/include/asm/fixmap.h
> > @@ -22,9 +22,6 @@
> >   */
> >  enum fixed_addresses {
> >         FIX_HOLE,
> > -#define FIX_FDT_SIZE   SZ_1M
> > -       FIX_FDT_END,
> > -       FIX_FDT =3D FIX_FDT_END + FIX_FDT_SIZE / PAGE_SIZE - 1,
> >         FIX_PTE,
> >         FIX_PMD,
> >         FIX_TEXT_POKE1,
> > diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/=
pgtable.h
> > index eaea1f717010..815f8c959dd4 100644
> > --- a/arch/riscv/include/asm/pgtable.h
> > +++ b/arch/riscv/include/asm/pgtable.h
> > @@ -464,6 +464,7 @@ static inline void __kernel_map_pages(struct page *=
page, int numpages, int enabl
> >  #define kern_addr_valid(addr)   (1) /* FIXME */
> >
> >  extern void *dtb_early_va;
> > +extern uintptr_t dtb_early_pa;
> >  void setup_bootmem(void);
> >  void paging_init(void);
> >
> > diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
> > index 0a4e81b8dc79..c6a37e8231a8 100644
> > --- a/arch/riscv/kernel/head.S
> > +++ b/arch/riscv/kernel/head.S
> > @@ -259,7 +259,6 @@ clear_bss_done:
> >  #endif
> >         /* Start the kernel */
> >         call soc_early_init
> > -       call parse_dtb
> >         tail start_kernel
> >
> >  .Lsecondary_start:
> > diff --git a/arch/riscv/kernel/head.h b/arch/riscv/kernel/head.h
> > index 105fb0496b24..b48dda3d04f6 100644
> > --- a/arch/riscv/kernel/head.h
> > +++ b/arch/riscv/kernel/head.h
> > @@ -16,6 +16,4 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa);
> >  extern void *__cpu_up_stack_pointer[];
> >  extern void *__cpu_up_task_pointer[];
> >
> > -void __init parse_dtb(void);
> > -
> >  #endif /* __ASM_HEAD_H */
> > diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> > index 2c6dd329312b..edea7ef88402 100644
> > --- a/arch/riscv/kernel/setup.c
> > +++ b/arch/riscv/kernel/setup.c
> > @@ -48,8 +48,9 @@ atomic_t hart_lottery __section(.sdata);
> >  unsigned long boot_cpu_hartid;
> >  static DEFINE_PER_CPU(struct cpu, cpu_devices);
> >
> > -void __init parse_dtb(void)
> > +static void __init parse_dtb(void)
> >  {
> > +       /* Early scan of device tree from init memory */
> >         if (early_init_dt_scan(dtb_early_va))
> >                 return;
> >
> > @@ -62,6 +63,7 @@ void __init parse_dtb(void)
> >
> >  void __init setup_arch(char **cmdline_p)
> >  {
> > +       parse_dtb();
> >         init_mm.start_code =3D (unsigned long) _stext;
> >         init_mm.end_code   =3D (unsigned long) _etext;
> >         init_mm.end_data   =3D (unsigned long) _edata;
> > @@ -76,7 +78,10 @@ void __init setup_arch(char **cmdline_p)
> >  #if IS_ENABLED(CONFIG_BUILTIN_DTB)
> >         unflatten_and_copy_device_tree();
> >  #else
> > -       unflatten_device_tree();
> > +       if (early_init_dt_verify(__va(dtb_early_pa)))
> > +               unflatten_device_tree();
> > +       else
> > +               pr_err("No DTB found in kernel mappings\n");
> >  #endif
> >
> >  #ifdef CONFIG_SWIOTLB
> > diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> > index 787c75f751a5..2b651f63f5c4 100644
> > --- a/arch/riscv/mm/init.c
> > +++ b/arch/riscv/mm/init.c
> > @@ -28,7 +28,9 @@ unsigned long empty_zero_page[PAGE_SIZE / sizeof(unsi=
gned long)]
> >  EXPORT_SYMBOL(empty_zero_page);
> >
> >  extern char _start[];
> > -void *dtb_early_va;
> > +#define DTB_EARLY_BASE_VA      PGDIR_SIZE
> > +void *dtb_early_va __initdata;
> > +uintptr_t dtb_early_pa __initdata;
> >
> >  static void __init zone_sizes_init(void)
> >  {
> > @@ -141,8 +143,6 @@ static void __init setup_initrd(void)
> >  }
> >  #endif /* CONFIG_BLK_DEV_INITRD */
> >
> > -static phys_addr_t dtb_early_pa __initdata;
> > -
> >  void __init setup_bootmem(void)
> >  {
> >         struct memblock_region *reg;
> > @@ -399,7 +399,7 @@ static uintptr_t __init best_map_size(phys_addr_t b=
ase, phys_addr_t size)
> >
> >  asmlinkage void __init setup_vm(uintptr_t dtb_pa)
> >  {
> > -       uintptr_t va, end_va;
> > +       uintptr_t va, pa, end_va;
> >         uintptr_t load_pa =3D (uintptr_t)(&_start);
> >         uintptr_t load_sz =3D (uintptr_t)(&_end) - load_pa;
> >         uintptr_t map_size =3D best_map_size(load_pa, MAX_EARLY_MAPPING=
_SIZE);
> > @@ -448,16 +448,13 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
> >                                    load_pa + (va - PAGE_OFFSET),
> >                                    map_size, PAGE_KERNEL_EXEC);
> >
> > -       /* Create fixed mapping for early FDT parsing */
> > -       end_va =3D __fix_to_virt(FIX_FDT) + FIX_FDT_SIZE;
> > -       for (va =3D __fix_to_virt(FIX_FDT); va < end_va; va +=3D PAGE_S=
IZE)
> > -               create_pte_mapping(fixmap_pte, va,
> > -                                  dtb_pa + (va - __fix_to_virt(FIX_FDT=
)),
> > -                                  PAGE_SIZE, PAGE_KERNEL);
> > -
> > -       /* Save pointer to DTB for early FDT parsing */
> > -       dtb_early_va =3D (void *)fix_to_virt(FIX_FDT) + (dtb_pa & ~PAGE=
_MASK);
> > -       /* Save physical address for memblock reservation */
> > +       /* Create two consecutive PGD mappings for FDT early scan */
> > +       pa =3D dtb_pa & ~(PGDIR_SIZE - 1);
> > +       create_pgd_mapping(early_pg_dir, DTB_EARLY_BASE_VA,
> > +                          pa, PGDIR_SIZE, PAGE_KERNEL);
> Hi Anup,
>
> I hit a booting failure case in Unleashed board in v5.10-rc2.
>
> After debugging, it looks like something wrong in this patch.
> It will create 0x40000000 as a VA start address for this mapping in rv64 =
here.
> #define DTB_EARLY_BASE_VA      PGDIR_SIZE
>
> but using __va(dtb_early_pa) to get the virtual address?
> if (early_init_dt_verify(__va(dtb_early_pa)))
>               unflatten_device_tree();
>
> Would you please to take a look at it? I am not sure if I
> misunderstand something.
> Thank you. :)

This has been already fixed in v5.10-rc3 by following patch:
https://lkml.org/lkml/2020/11/4/34

Please try v5.10-rc3 at your end.

Regards,
Anup
