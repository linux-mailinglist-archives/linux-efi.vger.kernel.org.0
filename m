Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 384F15BC2B2
	for <lists+linux-efi@lfdr.de>; Mon, 19 Sep 2022 08:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbiISGGf (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 19 Sep 2022 02:06:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiISGGe (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 19 Sep 2022 02:06:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B6A8186FC
        for <linux-efi@vger.kernel.org>; Sun, 18 Sep 2022 23:06:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8D53660EDF
        for <linux-efi@vger.kernel.org>; Mon, 19 Sep 2022 06:06:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8335C433D7
        for <linux-efi@vger.kernel.org>; Mon, 19 Sep 2022 06:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663567592;
        bh=7ySQ2t+BZcNM2kxa2VXkbJtuUkglxMLhFgGVnv8TdWQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=AIqeOSHz/LBr8FZQ7yfwL8k5F66aXE8TnLPAU03tIhSAzHBX/a5UpL7BMo0bV4vfS
         Oq8TaPxRPsNEYsdEdz2LRvvAQopg2OlFeWfbdbcYZASovguveBQ2Iqc/YW60NIUOeb
         f1kqiDwJ/+Me3MChSZL8wGHhFQLcqd6xyeqSGT29bnG+VXf3Uu9rTn2kiP0vQzMFks
         clHnDapDZ8kLkzpdxll8G97T3fpQ3PKZF9f1KMcQsupp4gyk7wLiYaLLaYTSTL79a9
         1oEWL/3TwFiT8/A2mIolWMua16wpuigw5V84lB3u05Wbl0PSDivePMPo7WjsPCqu2p
         P73V8bcKgibXQ==
Received: by mail-ua1-f50.google.com with SMTP id h22so7369058uab.5
        for <linux-efi@vger.kernel.org>; Sun, 18 Sep 2022 23:06:31 -0700 (PDT)
X-Gm-Message-State: ACrzQf07gTn+HiV0iOFOcph2V2x9E3ud/mDieLHKLiRJTkkoKhuzxIk9
        bH3a7xI2ArK4stZKjy3++TjvIDy+e3oXcVgHwl0=
X-Google-Smtp-Source: AMsMyM7UU85k7nlpPDrVk+UtpRhmA6pXIWTpe6yy3VYEX1gp64dL/KcsZgPKGTv5wCenXrNKr1IzyQTPws3s3uKoLVY=
X-Received: by 2002:ab0:2ea9:0:b0:395:b672:508 with SMTP id
 y9-20020ab02ea9000000b00395b6720508mr5292822uay.63.1663567590718; Sun, 18 Sep
 2022 23:06:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220918213544.2176249-1-ardb@kernel.org> <20220918213544.2176249-12-ardb@kernel.org>
 <CAAhV-H6Ke88sirvX9ut7JLWy+xaERZ7BeMEf97WHRWbsLqZC0A@mail.gmail.com> <CAMj1kXHuQHuCt9Z=qWRH_aZY5_+LzpicyE=agMyAX+O14khL_g@mail.gmail.com>
In-Reply-To: <CAMj1kXHuQHuCt9Z=qWRH_aZY5_+LzpicyE=agMyAX+O14khL_g@mail.gmail.com>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Mon, 19 Sep 2022 14:06:18 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7-JFwcwz5pBt7WZxJ2CkeUvc07OLgWxB9z-QTkr=njWw@mail.gmail.com>
Message-ID: <CAAhV-H7-JFwcwz5pBt7WZxJ2CkeUvc07OLgWxB9z-QTkr=njWw@mail.gmail.com>
Subject: Re: [PATCH 11/12] efi/loongarch: libstub: remove dependency on
 flattened DT
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi <linux-efi@vger.kernel.org>, loongarch@lists.linux.dev,
        "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Xi Ruoyao <xry111@xry111.site>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

 Hi, Ard,

On Mon, Sep 19, 2022 at 1:15 PM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Mon, 19 Sept 2022 at 03:58, Huacai Chen <chenhuacai@kernel.org> wrote:
> >
> > Hi, Ard,
> >
> > I think the parameters passed to the core kernel need to be discussed.
> > The old way (so-called old world):
> > a0=argc, a1=argv, a1=bpi
> >
> > The current way (so-called new world):
> > a0=efi boot flag, a1=fdt pointer
> >
> > The new way (in this patchset):
> > a0=efi boot flag, a1=systemtable, a2=cmdline
> >
> > I prefer to use the current way, there are 3 reasons:
> > 1, both acpi system and dt system can use the same parameters passing method;
>
> DT systems will use this too. The distinction is between EFI boot and
> non-EFI boot. We *really* should keep these separate, given the
> experience on ARM, where other projects invent ways to pass those
> values to the kernel without going through the stub.
In the last patch I see:
+               void *fdt_ptr = early_memremap_ro(fw_arg1, SZ_64K);
+
+               early_init_dt_scan(fdt_ptr);
+               early_init_fdt_reserve_self();
+
                clear_bit(EFI_BOOT, &efi.flags);
So I suppose for the DT system that means a0=efi boot flag, a1=fdt
pointer, a2=cmdline? Then it is not exactly the same as the ACPI
system, but similar.

>
> > 2, arm64, riscv and loongarch can use similar logics (light FDT);
>
> No need to repeat a mistake. I intend to fix RISC-V next.
>
> > 3, out-of-tree patches can make compatibility with the old world
> > easier by just judging whether a2 is zero.
> >
>
> The whole point of this series is that the EFI stub should not be
> touching the DT at all. In other words, there is no DT pointer, so the
> current method needs to be revised.
>
> What we might do is
>
> a0=systemtable, a1=cmdline
>
> as any non-zero value is treated as logic true. That way, your logic
> to test a2 is zero will still work.
I think the efi boot flag is still needed, even boot from efistub.
Because if boot with "efi=novamap", the efi runtime should be
disabled. Then we need efi_enabled(EFI_BOOT) to be false in
efi_init().

Huacai

>
>
> >
> > On Mon, Sep 19, 2022 at 5:36 AM Ard Biesheuvel <ardb@kernel.org> wrote:
> > >
> > > LoongArch does not use FDT or DT natively [yet], and the only reason it
> > > currently uses it is so that it can reuse the existing EFI stub code.
> > >
> > > Overloading the DT with data passed between the EFI stub and the core
> > > kernel has been a source of problems: there is the overlap between
> > > information provided by EFI which DT can also provide (initrd base/size,
> > > command line, memory descriptions), requiring us to reason about which
> > > is which and what to prioritize. It has also resulted in ABI leaks,
> > > i.e., internal ABI being promoted to external ABI inadvertently because
> > > the bootloader can set the EFI stub's DT properties as well (e.g.,
> > > "kaslr-seed"). This has become especially problematic with boot
> > > environments that want to pretend that EFI boot is being done (to access
> > > ACPI and SMBIOS tables, for instance) but have no ability to execute the
> > > EFI stub, and so the environment that the EFI stub creates is emulated
> > > [poorly, in some cases].
> > >
> > > Another downside of treating DT like this is that the DT binary that the
> > > kernel receives is different from the one created by the firmware, which
> > > is undesirable in the context of secure and measured boot.
> > >
> > > Given that LoongArch support in Linux is brand new, we can avoid these
> > > pitfalls, and treat the DT strictly as a hardware description, and use a
> > > separate handover method between the EFI stub and the kernel. Now that
> > > initrd loading and passing the EFI memory map have been refactored into
> > > pure EFI routines that use EFI configuration tables, the only thing we
> > > need to pass directly is the kernel command line (even if we could pass
> > > this via a config table as well, it is used extremely early, so passing
> > > it directly is preferred in this case.)
> > >
> > > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > > ---
> > >  arch/loongarch/Kconfig                        |  3 --
> > >  arch/loongarch/include/asm/bootinfo.h         |  2 +-
> > >  arch/loongarch/kernel/efi.c                   | 30 ++++++++++-
> > >  arch/loongarch/kernel/env.c                   | 22 ++++----
> > >  arch/loongarch/kernel/head.S                  |  2 +
> > >  arch/loongarch/kernel/setup.c                 |  4 +-
> > >  drivers/firmware/efi/libstub/Makefile         | 13 +++--
> > >  drivers/firmware/efi/libstub/loongarch-stub.c | 56 +++++++++++++++++---
> > >  8 files changed, 100 insertions(+), 32 deletions(-)
> > >
> > > diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> > > index fca106a8b8af..14a2a1ec8561 100644
> > > --- a/arch/loongarch/Kconfig
> > > +++ b/arch/loongarch/Kconfig
> > > @@ -104,8 +104,6 @@ config LOONGARCH
> > >         select MODULES_USE_ELF_RELA if MODULES
> > >         select NEED_PER_CPU_EMBED_FIRST_CHUNK
> > >         select NEED_PER_CPU_PAGE_FIRST_CHUNK
> > > -       select OF
> > > -       select OF_EARLY_FLATTREE
> > >         select PCI
> > >         select PCI_DOMAINS_GENERIC
> > >         select PCI_ECAM if ACPI
> > > @@ -311,7 +309,6 @@ config DMI
> > >  config EFI
> > >         bool "EFI runtime service support"
> > >         select UCS2_STRING
> > > -       select EFI_PARAMS_FROM_FDT
> > >         select EFI_RUNTIME_WRAPPERS
> > >         help
> > >           This enables the kernel to use EFI runtime services that are
> > > diff --git a/arch/loongarch/include/asm/bootinfo.h b/arch/loongarch/include/asm/bootinfo.h
> > > index e02ac4af7f6e..8e5881bc5ad1 100644
> > > --- a/arch/loongarch/include/asm/bootinfo.h
> > > +++ b/arch/loongarch/include/asm/bootinfo.h
> > > @@ -36,7 +36,7 @@ struct loongson_system_configuration {
> > >  };
> > >
> > >  extern u64 efi_system_table;
> > > -extern unsigned long fw_arg0, fw_arg1;
> > > +extern unsigned long fw_arg0, fw_arg1, fw_arg2;
> > >  extern struct loongson_board_info b_info;
> > >  extern struct loongson_system_configuration loongson_sysconf;
> > >
> > > diff --git a/arch/loongarch/kernel/efi.c b/arch/loongarch/kernel/efi.c
> > > index 1f1f755fb425..3b80675726ec 100644
> > > --- a/arch/loongarch/kernel/efi.c
> > > +++ b/arch/loongarch/kernel/efi.c
> > > @@ -27,8 +27,13 @@
> > >  static unsigned long efi_nr_tables;
> > >  static unsigned long efi_config_table;
> > >
> > > +static unsigned long __initdata boot_memmap = EFI_INVALID_TABLE_ADDR;
> > > +
> > >  static efi_system_table_t *efi_systab;
> > > -static efi_config_table_type_t arch_tables[] __initdata = {{},};
> > > +static efi_config_table_type_t arch_tables[] __initdata = {
> > > +       {LINUX_EFI_BOOT_MEMMAP_GUID,    &boot_memmap,   "MEMMAP" },
> > > +       {},
> > > +};
> > >
> > >  void __init efi_runtime_init(void)
> > >  {
> > > @@ -61,6 +66,8 @@ void __init efi_init(void)
> > >                 return;
> > >         }
> > >
> > > +       efi_systab_report_header(&efi_systab->hdr, efi_systab->fw_vendor);
> > > +
> > >         set_bit(EFI_64BIT, &efi.flags);
> > >         efi_nr_tables    = efi_systab->nr_tables;
> > >         efi_config_table = (unsigned long)efi_systab->tables;
> > > @@ -72,4 +79,25 @@ void __init efi_init(void)
> > >
> > >         if (screen_info.orig_video_isVGA == VIDEO_TYPE_EFI)
> > >                 memblock_reserve(screen_info.lfb_base, screen_info.lfb_size);
> > > +
> > > +       if (boot_memmap != EFI_INVALID_TABLE_ADDR) {
> > > +               struct efi_memory_map_data data;
> > > +               struct efi_boot_memmap *tbl;
> > > +
> > > +               tbl = early_memremap_ro(boot_memmap, sizeof(*tbl));
> > > +               if (tbl) {
> > > +                       data.phys_map           = boot_memmap + sizeof(*tbl);
> > > +                       data.size               = tbl->map_size;
> > > +                       data.desc_size          = tbl->desc_size;
> > > +                       data.desc_version       = tbl->desc_ver;
> > > +
> > > +                       if (efi_memmap_init_early(&data) < 0)
> > > +                               panic("Unable to map EFI memory map.\n");
> > > +
> > > +                       memblock_reserve(data.phys_map & PAGE_MASK,
> > > +                                        PAGE_ALIGN(data.size + (data.phys_map & ~PAGE_MASK)));
> > > +
> > > +                       early_memunmap(tbl, sizeof(*tbl));
> > > +               }
> > > +       }
> > >  }
> > > diff --git a/arch/loongarch/kernel/env.c b/arch/loongarch/kernel/env.c
> > > index 82b478a5c665..05c38d28476e 100644
> > > --- a/arch/loongarch/kernel/env.c
> > > +++ b/arch/loongarch/kernel/env.c
> > > @@ -8,7 +8,6 @@
> > >  #include <linux/efi.h>
> > >  #include <linux/export.h>
> > >  #include <linux/memblock.h>
> > > -#include <linux/of_fdt.h>
> > >  #include <asm/early_ioremap.h>
> > >  #include <asm/bootinfo.h>
> > >  #include <asm/loongson.h>
> > > @@ -20,21 +19,18 @@ EXPORT_SYMBOL(loongson_sysconf);
> > >  void __init init_environ(void)
> > >  {
> > >         int efi_boot = fw_arg0;
> > > -       struct efi_memory_map_data data;
> > > -       void *fdt_ptr = early_memremap_ro(fw_arg1, SZ_64K);
> > >
> > > -       if (efi_boot)
> > > -               set_bit(EFI_BOOT, &efi.flags);
> > > -       else
> > > -               clear_bit(EFI_BOOT, &efi.flags);
> > > +       if (efi_boot) {
> > > +               char *cmdline = early_memremap_ro(fw_arg2, COMMAND_LINE_SIZE);
> > >
> > > -       early_init_dt_scan(fdt_ptr);
> > > -       early_init_fdt_reserve_self();
> > > -       efi_system_table = efi_get_fdt_params(&data);
> > > +               strscpy(boot_command_line, cmdline, COMMAND_LINE_SIZE);
> > > +               early_memunmap(cmdline, COMMAND_LINE_SIZE);
> > >
> > > -       efi_memmap_init_early(&data);
> > > -       memblock_reserve(data.phys_map & PAGE_MASK,
> > > -                        PAGE_ALIGN(data.size + (data.phys_map & ~PAGE_MASK)));
> > > +               efi_system_table = fw_arg1;
> > > +               set_bit(EFI_BOOT, &efi.flags);
> > > +       } else {
> > > +               clear_bit(EFI_BOOT, &efi.flags);
> > > +       }
> > >  }
> > >
> > >  static int __init init_cpu_fullname(void)
> > > diff --git a/arch/loongarch/kernel/head.S b/arch/loongarch/kernel/head.S
> > > index 01bac62a6442..8f89f39fd31b 100644
> > > --- a/arch/loongarch/kernel/head.S
> > > +++ b/arch/loongarch/kernel/head.S
> > > @@ -67,6 +67,8 @@ SYM_CODE_START(kernel_entry)                  # kernel entry point
> > >         st.d            a0, t0, 0               # firmware arguments
> > >         la              t0, fw_arg1
> > >         st.d            a1, t0, 0
> > > +       la              t0, fw_arg2
> > > +       st.d            a2, t0, 0
> > >
> > >         /* KSave3 used for percpu base, initialized as 0 */
> > >         csrwr           zero, PERCPU_BASE_KS
> > > diff --git a/arch/loongarch/kernel/setup.c b/arch/loongarch/kernel/setup.c
> > > index e8714b1d94c8..7fabf2306e80 100644
> > > --- a/arch/loongarch/kernel/setup.c
> > > +++ b/arch/loongarch/kernel/setup.c
> > > @@ -51,7 +51,7 @@
> > >
> > >  struct screen_info screen_info __section(".data");
> > >
> > > -unsigned long fw_arg0, fw_arg1;
> > > +unsigned long fw_arg0, fw_arg1, fw_arg2;
> > >  DEFINE_PER_CPU(unsigned long, kernelsp);
> > >  struct cpuinfo_loongarch cpu_data[NR_CPUS] __read_mostly;
> > >
> > > @@ -187,7 +187,6 @@ early_param("mem", early_parse_mem);
> > >
> > >  void __init platform_init(void)
> > >  {
> > > -       efi_init();
> > >  #ifdef CONFIG_ACPI_TABLE_UPGRADE
> > >         acpi_table_upgrade();
> > >  #endif
> > > @@ -347,6 +346,7 @@ void __init setup_arch(char **cmdline_p)
> > >         *cmdline_p = boot_command_line;
> > >
> > >         init_environ();
> > > +       efi_init();
> > >         memblock_init();
> > >         parse_early_param();
> > >
> > > diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
> > > index 0dbc6d93f2e6..d8d6657e6277 100644
> > > --- a/drivers/firmware/efi/libstub/Makefile
> > > +++ b/drivers/firmware/efi/libstub/Makefile
> > > @@ -29,7 +29,7 @@ cflags-$(CONFIG_RISCV)                := $(subst $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)) \
> > >  cflags-$(CONFIG_LOONGARCH)     := $(subst $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)) \
> > >                                    -fpie
> > >
> > > -cflags-$(CONFIG_EFI_GENERIC_STUB) += -I$(srctree)/scripts/dtc/libfdt
> > > +cflags-$(CONFIG_EFI_PARAMS_FROM_FDT)   += -I$(srctree)/scripts/dtc/libfdt
> > >
> > >  KBUILD_CFLAGS                  := $(cflags-y) -Os -DDISABLE_BRANCH_PROFILING \
> > >                                    -include $(srctree)/include/linux/hidden.h \
> > > @@ -60,14 +60,17 @@ lib-y                               := efi-stub-helper.o gop.o secureboot.o tpm.o \
> > >                                    alignedmem.o relocate.o vsprintf.o \
> > >                                    systable.o
> > >
> > > -# include the stub's generic dependencies from lib/ when building for ARM/arm64
> > > -efi-deps-y := fdt_rw.c fdt_ro.c fdt_wip.c fdt.c fdt_empty_tree.c fdt_sw.c
> > > +# include the stub's libfdt dependencies from lib/ when needed
> > > +libfdt-deps                    := fdt_rw.c fdt_ro.c fdt_wip.c fdt.c \
> > > +                                  fdt_empty_tree.c fdt_sw.c
> > > +
> > > +lib-$(CONFIG_EFI_PARAMS_FROM_FDT) += fdt.o \
> > > +                                    $(patsubst %.c,lib-%.o,$(libfdt-deps))
> > >
> > >  $(obj)/lib-%.o: $(srctree)/lib/%.c FORCE
> > >         $(call if_changed_rule,cc_o_c)
> > >
> > > -lib-$(CONFIG_EFI_GENERIC_STUB) += efi-stub.o fdt.o string.o intrinsics.o \
> > > -                                  $(patsubst %.c,lib-%.o,$(efi-deps-y))
> > > +lib-$(CONFIG_EFI_GENERIC_STUB) += efi-stub.o string.o intrinsics.o
> > >
> > >  lib-$(CONFIG_ARM)              += arm32-stub.o
> > >  lib-$(CONFIG_ARM64)            += arm64-stub.o
> > > diff --git a/drivers/firmware/efi/libstub/loongarch-stub.c b/drivers/firmware/efi/libstub/loongarch-stub.c
> > > index b7ef8d2df59e..7c684d10f936 100644
> > > --- a/drivers/firmware/efi/libstub/loongarch-stub.c
> > > +++ b/drivers/firmware/efi/libstub/loongarch-stub.c
> > > @@ -9,7 +9,8 @@
> > >  #include <asm/addrspace.h>
> > >  #include "efistub.h"
> > >
> > > -typedef void __noreturn (*kernel_entry_t)(bool efi, unsigned long fdt);
> > > +typedef void __noreturn (*kernel_entry_t)(bool efi, unsigned long systab,
> > > +                                         unsigned long cmdline);
> > >
> > >  extern int kernel_asize;
> > >  extern int kernel_fsize;
> > > @@ -42,19 +43,60 @@ efi_status_t handle_kernel_image(unsigned long *image_addr,
> > >         return status;
> > >  }
> > >
> > > -void __noreturn efi_enter_kernel(unsigned long entrypoint, unsigned long fdt, unsigned long fdt_size)
> > > +struct exit_boot_struct {
> > > +       efi_memory_desc_t       *runtime_map;
> > > +       int                     runtime_entry_count;
> > > +};
> > > +
> > > +static efi_status_t exit_boot_func(struct efi_boot_memmap *map, void *priv)
> > > +{
> > > +       struct exit_boot_struct *p = priv;
> > > +
> > > +       /*
> > > +        * Update the memory map with virtual addresses. The function will also
> > > +        * populate @runtime_map with copies of just the EFI_MEMORY_RUNTIME
> > > +        * entries so that we can pass it straight to SetVirtualAddressMap()
> > > +        */
> > > +       efi_get_virtmap(map->map, map->map_size, map->desc_size,
> > > +                       p->runtime_map, &p->runtime_entry_count);
> > > +
> > > +       return EFI_SUCCESS;
> > > +}
> > > +
> > > +efi_status_t efi_boot_kernel(void *handle, efi_loaded_image_t *image,
> > > +                            unsigned long image_addr, char *cmdline_ptr)
> > >  {
> > >         kernel_entry_t real_kernel_entry;
> > > +       struct exit_boot_struct priv;
> > > +       unsigned long desc_size;
> > > +       efi_status_t status;
> > > +       u32 desc_ver;
> > > +
> > > +       status = efi_alloc_virtmap(&priv.runtime_map, &desc_size, &desc_ver);
> > > +       if (status != EFI_SUCCESS) {
> > > +               efi_err("Unable to retrieve UEFI memory map.\n");
> > > +               return status;
> > > +       }
> > > +
> > > +       efi_info("Exiting boot services\n");
> > > +
> > > +       efi_novamap = false;
> > > +       status = efi_exit_boot_services(handle, &priv, exit_boot_func);
> > > +       if (status != EFI_SUCCESS)
> > > +               return status;
> > > +
> > > +       /* Install the new virtual address map */
> > > +       efi_rt_call(set_virtual_address_map,
> > > +                   priv.runtime_entry_count * desc_size, desc_size,
> > > +                   desc_ver, priv.runtime_map);
> > >
> > >         /* Config Direct Mapping */
> > >         csr_write64(CSR_DMW0_INIT, LOONGARCH_CSR_DMWIN0);
> > >         csr_write64(CSR_DMW1_INIT, LOONGARCH_CSR_DMWIN1);
> > >
> > >         real_kernel_entry = (kernel_entry_t)
> > > -               ((unsigned long)&kernel_entry - entrypoint + VMLINUX_LOAD_ADDRESS);
> > > +               ((unsigned long)&kernel_entry - image_addr + VMLINUX_LOAD_ADDRESS);
> > >
> > > -       if (!efi_novamap)
> > > -               real_kernel_entry(true, fdt);
> > > -       else
> > > -               real_kernel_entry(false, fdt);
> > > +       real_kernel_entry(true, (unsigned long)efi_system_table,
> > > +                         (unsigned long)cmdline_ptr);
> > >  }
> > > --
> > > 2.35.1
> > >
> > >
