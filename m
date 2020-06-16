Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D74641FAE7C
	for <lists+linux-efi@lfdr.de>; Tue, 16 Jun 2020 12:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbgFPKsu (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 16 Jun 2020 06:48:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:60936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725901AbgFPKsu (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 16 Jun 2020 06:48:50 -0400
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 30A3620776
        for <linux-efi@vger.kernel.org>; Tue, 16 Jun 2020 10:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592304529;
        bh=rOPMHNEU4g7buUM2Y3WpMEq2LU0QypRNIrKBgemrcD8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZnywB5enva02cduDVzEh/uXYf8/KRDhO7IoZ2hGsKql0wRfYYGQ1h1B1dfoCFjP/j
         ZkLp70K4HdtkxriuKOyXrw6YpKX+InIgKMVblkaDmnK0SZcIRnJ4HNlRDl6nsMPBMO
         TcNp03XFu9TM3egDadLE+Q0CNJ1dwKzWV4LkT+cc=
Received: by mail-oi1-f172.google.com with SMTP id p70so18770280oic.12
        for <linux-efi@vger.kernel.org>; Tue, 16 Jun 2020 03:48:49 -0700 (PDT)
X-Gm-Message-State: AOAM530RTGSHRROdDUxTPtyDJRRANhcTD9Uwko2SsUsTofzkkemkcnVU
        YnG+40ukIj606H33c93CiMkSY0L4whDVnIGjEkg=
X-Google-Smtp-Source: ABdhPJya1ABiVY7gxtazrfifA5pcPPrW0p9zjln/yKRXtKydIpRxJhdNFcEe9Cg6kywXtW0C4iOgoYQHg5fdxztNjwI=
X-Received: by 2002:aca:ba03:: with SMTP id k3mr2761160oif.33.1592304528407;
 Tue, 16 Jun 2020 03:48:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200616085050.994094-1-ardb@kernel.org> <CAMj1kXG9mY2SoHoHuvjhHB3SHPCq6-zEQZBqU1LX57fL-Gy__Q@mail.gmail.com>
 <20200616103922.GC6739@vanye> <CAMj1kXGUM1MHy8q3YLZx_MR8WRAc-4YJ54rE534=RWZMnJBn_Q@mail.gmail.com>
In-Reply-To: <CAMj1kXGUM1MHy8q3YLZx_MR8WRAc-4YJ54rE534=RWZMnJBn_Q@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 16 Jun 2020 12:48:37 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGbg369dh58qK4Pp51N8wPn5bWJDuuoyOjc4OdPqefwzA@mail.gmail.com>
Message-ID: <CAMj1kXGbg369dh58qK4Pp51N8wPn5bWJDuuoyOjc4OdPqefwzA@mail.gmail.com>
Subject: Re: [PATCH v3] efi/libstub: arm: Print CPU boot mode and MMU state at boot
To:     Leif Lindholm <leif@nuviainc.com>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Samer.El-Haj-Mahmoud@arm.com,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Grant Likely <grant.likely@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 16 Jun 2020 at 12:46, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Tue, 16 Jun 2020 at 12:39, Leif Lindholm <leif@nuviainc.com> wrote:
> >
> > On Tue, Jun 16, 2020 at 10:51:48 +0200, Ard Biesheuvel wrote:
> > > On Tue, 16 Jun 2020 at 10:50, Ard Biesheuvel <ardb@kernel.org> wrote:
> > > >
> > > > On 32-bit ARM, we may boot at HYP mode, or with the MMU and caches off
> > > > (or both), even though the EFI spec does not actually support this.
> > > > While booting at HYP mode is something we might tolerate, fiddling
> > > > with the caches is a more serious issue, as disabling the caches is
> > > > tricky to do safely from C code, and running without the Dcache makes
> > > > it impossible to support unaligned memory accesses, which is another
> > > > explicit requirement imposed by the EFI spec.
> > > >
> > > > So take note of the CPU mode and MMU state in the EFI stub diagnostic
> > > > output so that we can easily diagnose any issues that may arise from
> > > > this. E.g.,
> > > >
> > > >   EFI stub: Entering in SVC mode with MMU enabled
> > > >
> > > > Also, capture the CPSR and SCTLR system register values at EFI stub
> > > > entry, and after ExitBootServices() returns, and check whether the
> > > > MMU and Dcache were disabled at any point. If this is the case, a
> > > > diagnostic message like the following will be emitted:
> > > >
> > > >   efi: [Firmware Bug]: EFI stub was entered with MMU and Dcache disabled, please fix your firmware!
> > > >   efi: CPSR at EFI stub entry        : 0x600001d3
> > > >   efi: SCTLR at EFI stub entry       : 0x00c51838
> > > >   efi: CPSR after ExitBootServices() : 0x600001d3
> > > >   efi: SCTLR after ExitBootServices(): 0x00c50838
> > > >
> > > > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > > > ---
> > > > Adding Grant and Samer to cc, as this may be something that should be taken
> > > > into account in the EBBR context? Note that this affects 64-bit only.
> > > >
> > >
> > > Affects *32* bit only
> >
> > One question and a teeny tiny nit below.
> >
> > > >  arch/arm/include/asm/efi.h                |  7 +++
> > > >  drivers/firmware/efi/arm-init.c           | 37 ++++++++++++--
> > > >  drivers/firmware/efi/libstub/arm32-stub.c | 52 +++++++++++++++++++-
> > > >  drivers/firmware/efi/libstub/efi-stub.c   |  3 ++
> > > >  drivers/firmware/efi/libstub/efistub.h    |  2 +
> > > >  include/linux/efi.h                       |  1 +
> > > >  6 files changed, 98 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/arch/arm/include/asm/efi.h b/arch/arm/include/asm/efi.h
> > > > index 84dc0ba822f5..5dcf3c6011b7 100644
> > > > --- a/arch/arm/include/asm/efi.h
> > > > +++ b/arch/arm/include/asm/efi.h
> > > > @@ -87,4 +87,11 @@ static inline unsigned long efi_get_max_initrd_addr(unsigned long dram_base,
> > > >         return dram_base + SZ_512M;
> > > >  }
> > > >
> > > > +struct efi_arm_entry_state {
> > > > +       u32     cpsr_before_ebs;
> > > > +       u32     sctlr_before_ebs;
> > > > +       u32     cpsr_after_ebs;
> > > > +       u32     sctlr_after_ebs;
> > > > +};
> > > > +
> > > >  #endif /* _ASM_ARM_EFI_H */
> > > > diff --git a/drivers/firmware/efi/arm-init.c b/drivers/firmware/efi/arm-init.c
> > > > index c697e70ca7e7..4d1c272a4f79 100644
> > > > --- a/drivers/firmware/efi/arm-init.c
> > > > +++ b/drivers/firmware/efi/arm-init.c
> > > > @@ -52,9 +52,11 @@ static phys_addr_t __init efi_to_phys(unsigned long addr)
> > > >  }
> > > >
> > > >  static __initdata unsigned long screen_info_table = EFI_INVALID_TABLE_ADDR;
> > > > +static __initdata unsigned long cpu_state_table = EFI_INVALID_TABLE_ADDR;
> > > >
> > > >  static const efi_config_table_type_t arch_tables[] __initconst = {
> > > >         {LINUX_EFI_ARM_SCREEN_INFO_TABLE_GUID, &screen_info_table},
> > > > +       {LINUX_EFI_ARM_CPU_STATE_TABLE_GUID, &cpu_state_table},
> > > >         {}
> > > >  };
> > > >
> > > > @@ -116,7 +118,8 @@ static int __init uefi_init(u64 efi_system_table)
> > > >                 goto out;
> > > >         }
> > > >         retval = efi_config_parse_tables(config_tables, systab->nr_tables,
> > > > -                                        arch_tables);
> > > > +                                        IS_ENABLED(CONFIG_ARM) ? arch_tables
> > > > +                                                               : NULL);
> >
> > It this worthwhile?
> > If it turns out we have no need for an arch_table on arm64, should we
> > still include the static table, holding values only relevant for
> > 32-bit, in arm64 builds at all?
> >
>
> On arm64, the stub and the kernel proper are the same binary, so there
> should never be a need to use configuration tables to carry
> information from the stub to the kernel proper.
>
> As this is the only reference, the compiler will simply drop the table
> from the build, and it could even optimize away the '!=
> EFI_INVALID_TABLE_ADDR' checks and conditional code, as it can observe
> that those variables never change values.
>
> However, it appears that the latter does not actually occur in
> practice, so I will rewrite the test below:
>
> > > >
> > > >         early_memunmap(config_tables, table_size);
> > > >  out:
> > > > @@ -238,9 +241,37 @@ void __init efi_init(void)
> > > >
> > > >         init_screen_info();
> > > >
> > > > +#ifdef CONFIG_ARM
> > > >         /* ARM does not permit early mappings to persist across paging_init() */
> > > > -       if (IS_ENABLED(CONFIG_ARM))
> > > > -               efi_memmap_unmap();
> > > > +       efi_memmap_unmap();
> > > > +
> > > > +       if (cpu_state_table != EFI_INVALID_TABLE_ADDR) {
>
> if (IS_ENABLED(CONFIG_ARM)) && cpu_state_table != EFI_INVALID_TABLE_ADDR
>

Ah never mind, this is already inside #ifdef CONFIG_ARM

> and do the same for screen_info_table (but in a separate patch)
>

but this I will still do

> > > > +               struct efi_arm_entry_state *state;
> > > > +               bool dump_state = true;
> > > > +
> > > > +               state = early_memremap_ro(cpu_state_table,
> > > > +                                         sizeof(struct efi_arm_entry_state));
> > > > +               if (state == NULL) {
> > > > +                       pr_warn("Unable to map CPU entry state table.\n");
> > > > +                       return;
> > > > +               }
> > > > +
> > > > +               if ((state->sctlr_before_ebs & 1) == 0)
> > > > +                       pr_warn(FW_BUG "EFI stub was entered with MMU and Dcache disabled, please fix your firmware!\n");
> > > > +               else if ((state->sctlr_after_ebs & 1) == 0)
> > > > +                       pr_warn(FW_BUG "ExitBootServices() returned with MMU and Dcache disabled, please fix your firmware!\n");
> > > > +               else
> > > > +                       dump_state = false;
> > > > +
> > > > +               if (dump_state || efi_enabled(EFI_DBG)) {
> > > > +                       pr_info("CPSR at EFI stub entry        : 0x%08x\n", state->cpsr_before_ebs);
> > > > +                       pr_info("SCTLR at EFI stub entry       : 0x%08x\n", state->sctlr_before_ebs);
> > > > +                       pr_info("CPSR after ExitBootServices() : 0x%08x\n", state->cpsr_after_ebs);
> > > > +                       pr_info("SCTLR after ExitBootServices(): 0x%08x\n", state->sctlr_after_ebs);
> > > > +               }
> > > > +               early_memunmap(state, sizeof(struct efi_arm_entry_state));
> > > > +       }
> > > > +#endif
> > > >  }
> > > >
> > > >  static bool efifb_overlaps_pci_range(const struct of_pci_range *range)
> > > > diff --git a/drivers/firmware/efi/libstub/arm32-stub.c b/drivers/firmware/efi/libstub/arm32-stub.c
> > > > index 40243f524556..60783228db6e 100644
> > > > --- a/drivers/firmware/efi/libstub/arm32-stub.c
> > > > +++ b/drivers/firmware/efi/libstub/arm32-stub.c
> > > > @@ -7,10 +7,49 @@
> > > >
> > > >  #include "efistub.h"
> > > >
> > > > +static efi_guid_t cpu_state_guid = LINUX_EFI_ARM_CPU_STATE_TABLE_GUID;
> > > > +
> > > > +struct efi_arm_entry_state *efi_entry_state;
> > > > +
> > > > +static void get_cpu_state(u32 *cpsr, u32 *sctlr)
> > > > +{
> > > > +       asm("mrs %0, cpsr" : "=r"(*cpsr));
> > > > +       if ((*cpsr & MODE_MASK) == HYP_MODE)
> > > > +               asm("mrc p15, 4, %0, c1, c0, 0" : "=r"(*sctlr));
> > > > +       else
> > > > +               asm("mrc p15, 0, %0, c1, c0, 0" : "=r"(*sctlr));
> > > > +}
> > > > +
> > > >  efi_status_t check_platform_features(void)
> > > >  {
> > > > +       efi_status_t status;
> > > > +       u32 cpsr, sctlr;
> > > >         int block;
> > > >
> > > > +       get_cpu_state(&cpsr, &sctlr);
> > > > +
> > > > +       efi_info("Entering in %s mode with MMU %sabled\n",
> > > > +                ((cpsr & MODE_MASK) == HYP_MODE) ? "HYP" : "SVC",
> > > > +                (sctlr & 1) ? "en" : "dis");
> > > > +
> > > > +       status = efi_bs_call(allocate_pool, EFI_LOADER_DATA,
> > > > +                            sizeof(*efi_entry_state),
> > > > +                            (void **)&efi_entry_state);
> > > > +       if (status != EFI_SUCCESS) {
> > > > +               efi_err("allocate_pool() failed\n");
> > > > +               return status;
> > > > +       }
> > > > +
> > > > +       efi_entry_state->cpsr_before_ebs = cpsr;
> > > > +       efi_entry_state->sctlr_before_ebs = sctlr;
> > > > +
> > > > +       status = efi_bs_call(install_configuration_table, &cpu_state_guid,
> > > > +                            efi_entry_state);
> > > > +       if (status != EFI_SUCCESS) {
> > > > +               efi_err("install_configuration_table() failed\n");
> > > > +               goto free_state;
> > > > +       }
> > > > +
> > > >         /* non-LPAE kernels can run anywhere */
> > > >         if (!IS_ENABLED(CONFIG_ARM_LPAE))
> > > >                 return EFI_SUCCESS;
> > > > @@ -19,9 +58,20 @@ efi_status_t check_platform_features(void)
> > > >         block = cpuid_feature_extract(CPUID_EXT_MMFR0, 0);
> > > >         if (block < 5) {
> > > >                 efi_err("This LPAE kernel is not supported by your CPU\n");
> > > > -               return EFI_UNSUPPORTED;
> > > > +               status = EFI_UNSUPPORTED;
> > > > +               goto free_state;
> > > >         }
> > > >         return EFI_SUCCESS;
> > > > +
> > > > +free_state:
> > > > +       efi_bs_call(free_pool, efi_entry_state);
> > > > +       return status;
> > > > +}
> > > > +
> > > > +void efi_handle_post_ebs_state(void)
> > > > +{
> > > > +       get_cpu_state(&efi_entry_state->cpsr_after_ebs,
> > > > +                     &efi_entry_state->sctlr_after_ebs);
> > > >  }
> > > >
> > > >  static efi_guid_t screen_info_guid = LINUX_EFI_ARM_SCREEN_INFO_TABLE_GUID;
> > > > diff --git a/drivers/firmware/efi/libstub/efi-stub.c b/drivers/firmware/efi/libstub/efi-stub.c
> > > > index e97370bdfdb0..3318ec3f8e5b 100644
> > > > --- a/drivers/firmware/efi/libstub/efi-stub.c
> > > > +++ b/drivers/firmware/efi/libstub/efi-stub.c
> > > > @@ -329,6 +329,9 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
> > > >         if (status != EFI_SUCCESS)
> > > >                 goto fail_free_initrd;
> > > >
> > > > +       if (IS_ENABLED(CONFIG_ARM))
> > > > +               efi_handle_post_ebs_state();
> > > > +
> > > >         efi_enter_kernel(image_addr, fdt_addr, fdt_totalsize((void *)fdt_addr));
> > > >         /* not reached */
> > > >
> > > > diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
> > > > index bcd8c0a785f0..6217ce647ebf 100644
> > > > --- a/drivers/firmware/efi/libstub/efistub.h
> > > > +++ b/drivers/firmware/efi/libstub/efistub.h
> > > > @@ -771,4 +771,6 @@ efi_status_t efi_load_initrd(efi_loaded_image_t *image,
> > > >                              unsigned long soft_limit,
> > > >                              unsigned long hard_limit);
> > > >
> > > > +void efi_handle_post_ebs_state(void);
> > > > +
> >
> > This declaration is made for both arm/arm64.
> > (I said it was tiny, feel free to ignore.)
> >
>
> Yes, that was deliberate. Forward declarations don't take up any
> space, and so there is no need for an #ifdef here.
>
>
> > > >  #endif
> > > > diff --git a/include/linux/efi.h b/include/linux/efi.h
> > > > index c3449c9699d0..bb35f3305e55 100644
> > > > --- a/include/linux/efi.h
> > > > +++ b/include/linux/efi.h
> > > > @@ -350,6 +350,7 @@ void efi_native_runtime_setup(void);
> > > >   * associated with ConOut
> > > >   */
> > > >  #define LINUX_EFI_ARM_SCREEN_INFO_TABLE_GUID   EFI_GUID(0xe03fc20a, 0x85dc, 0x406e,  0xb9, 0x0e, 0x4a, 0xb5, 0x02, 0x37, 0x1d, 0x95)
> > > > +#define LINUX_EFI_ARM_CPU_STATE_TABLE_GUID     EFI_GUID(0xef79e4aa, 0x3c3d, 0x4989,  0xb9, 0x02, 0x07, 0xa9, 0x43, 0xe5, 0x50, 0xd2)
> > > >  #define LINUX_EFI_LOADER_ENTRY_GUID            EFI_GUID(0x4a67b082, 0x0a4c, 0x41cf,  0xb6, 0xc7, 0x44, 0x0b, 0x29, 0xbb, 0x8c, 0x4f)
> > > >  #define LINUX_EFI_RANDOM_SEED_TABLE_GUID       EFI_GUID(0x1ce1e5bc, 0x7ceb, 0x42f2,  0x81, 0xe5, 0x8a, 0xad, 0xf1, 0x80, 0xf5, 0x7b)
> > > >  #define LINUX_EFI_TPM_EVENT_LOG_GUID           EFI_GUID(0xb7799cb0, 0xeca2, 0x4943,  0x96, 0x67, 0x1f, 0xae, 0x07, 0xb7, 0x47, 0xfa)
> > > > --
> > > > 2.27.0
> > > >
