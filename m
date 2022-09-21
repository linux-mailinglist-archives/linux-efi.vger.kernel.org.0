Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D672E5BF8D1
	for <lists+linux-efi@lfdr.de>; Wed, 21 Sep 2022 10:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbiIUIQe (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 21 Sep 2022 04:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbiIUIP6 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 21 Sep 2022 04:15:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D104491C9
        for <linux-efi@vger.kernel.org>; Wed, 21 Sep 2022 01:15:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D2D8AB82E95
        for <linux-efi@vger.kernel.org>; Wed, 21 Sep 2022 08:14:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76C0FC433D7
        for <linux-efi@vger.kernel.org>; Wed, 21 Sep 2022 08:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663748098;
        bh=/PqYWwwkeySJ5saGeQdPoyktWjATBx3z6FaN15zklBg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=o8p3Y1iyxwbOsGKnTG50+zZx+B6C4TLwGyEUHPQ8Sl5w7YBloTlsbDA5V5NaN0oUh
         7obAlPZhxuu2UEJFKZA2cnB/vMIUr8FhkJXqMSrWiT8FUFw6RKe3lvOGAeklj/qJZx
         chAHeqvRP1L5L5JKSO+o/V4V2HDePUNrJEZHAZW6IJ7l3B3gsb7Rk1jVJebK4yvh36
         GC+vQ3oenulS4pJw7Y7rYAD8tcU/fDk7Sjac+vym2eqjYWnQKCq36JxfaRL3mBI5u/
         tNlTNEWaVwd/lv2qRa8/Di9vpGjlttOtJq0/s4KgeqmFZmuPyDDWo4qX83fV3cLipn
         SZ957vLnU1zzA==
Received: by mail-lf1-f52.google.com with SMTP id x27so8012622lfu.0
        for <linux-efi@vger.kernel.org>; Wed, 21 Sep 2022 01:14:58 -0700 (PDT)
X-Gm-Message-State: ACrzQf1hAEP87btC9v9grfHEyTNsv64adlWkbY2dGMgtynpfezL/YsV2
        Te7HULhlN26nIhLxxFirhdWvhyQhJpC3rU32CX8=
X-Google-Smtp-Source: AMsMyM5hg64sqvZz/PiJ36cgIZh6mBIO7YguDRG1oMpuPG1LpfTjVdUhdaAyuWGgTBxZP7f3BWKxfITtIWQb6780MwI=
X-Received: by 2002:ac2:4431:0:b0:497:aaf5:83eb with SMTP id
 w17-20020ac24431000000b00497aaf583ebmr9479515lfl.228.1663748096281; Wed, 21
 Sep 2022 01:14:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220920183554.3870247-1-ardb@kernel.org> <20220920183554.3870247-9-ardb@kernel.org>
 <CAAhV-H4+Exqu6Z3G_hYmhz=Ccv_4EKLjQ5GVT8h3YsJy0FSpAg@mail.gmail.com>
In-Reply-To: <CAAhV-H4+Exqu6Z3G_hYmhz=Ccv_4EKLjQ5GVT8h3YsJy0FSpAg@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 21 Sep 2022 10:14:44 +0200
X-Gmail-Original-Message-ID: <CAMj1kXG9HRn6iV5x-Q94xdOhNhiKMGiO6SkE3LMwzXPkXxen_Q@mail.gmail.com>
Message-ID: <CAMj1kXG9HRn6iV5x-Q94xdOhNhiKMGiO6SkE3LMwzXPkXxen_Q@mail.gmail.com>
Subject: Re: [PATCH v2 8/8] efi/loongarch: libstub: remove dependency on
 flattened DT
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     linux-efi <linux-efi@vger.kernel.org>, loongarch@lists.linux.dev,
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

On Wed, 21 Sept 2022 at 06:02, Huacai Chen <chenhuacai@kernel.org> wrote:
>
> Acked-by: Huacai Chen <chenhuacai@loongson.cn>
>

Thank you Huacai

I have created a separate tag with these patches applied onto the
first loongarch efi enablement patch (see below)

I would prefer to keep the loongarch trees separate for the next merge
window, but if needed to avoid massive conflicts, you could merge the
tag into the loongarch tree and rebase your changes on top. But please
take care not to rebase those patches themselves: the commit SHAs need
to remain the same.

However, if the conflicts are only minor, you can just explain in your
PR to Linus what the resolution should look like.

The tag can be found here:
https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git/tag/?h=efi-loongarch-for-v6.1-2

I have merged this into the EFI tree as well and pushed it out; it
should appear in -next tomorrow.



b093dc55ba9a efi/loongarch: libstub: remove dependency on flattened DT
102faf0747c2 efi: libstub: install boot-time memory map as config table
7318926e7bc9 efi: libstub: remove DT dependency from generic stub
7cb6671e3caa efi: libstub: unify initrd loading between architectures
1add08ceb15b efi: libstub: remove pointless goto kludge
d2130a9cf0f7 efi: libstub: simplify efi_get_memory_map() and struct
efi_boot_memmap
bc5853aa56de efi: libstub: avoid efi_get_memory_map() for allocating
the virt map
d80ca810f096 efi: libstub: drop pointless get_memory_map() call
ead384d95634 (tag: efi-loongarch-for-v6.1) efi/loongarch: Add efistub
booting support
568035b01cfb (tag: v6.0-rc1) Linux 6.0-rc1



> On Wed, Sep 21, 2022 at 2:36 AM Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > LoongArch does not use FDT or DT natively [yet], and the only reason it
> > currently uses it is so that it can reuse the existing EFI stub code.
> >
> > Overloading the DT with data passed between the EFI stub and the core
> > kernel has been a source of problems: there is the overlap between
> > information provided by EFI which DT can also provide (initrd base/size,
> > command line, memory descriptions), requiring us to reason about which
> > is which and what to prioritize. It has also resulted in ABI leaks,
> > i.e., internal ABI being promoted to external ABI inadvertently because
> > the bootloader can set the EFI stub's DT properties as well (e.g.,
> > "kaslr-seed"). This has become especially problematic with boot
> > environments that want to pretend that EFI boot is being done (to access
> > ACPI and SMBIOS tables, for instance) but have no ability to execute the
> > EFI stub, and so the environment that the EFI stub creates is emulated
> > [poorly, in some cases].
> >
> > Another downside of treating DT like this is that the DT binary that the
> > kernel receives is different from the one created by the firmware, which
> > is undesirable in the context of secure and measured boot.
> >
> > Given that LoongArch support in Linux is brand new, we can avoid these
> > pitfalls, and treat the DT strictly as a hardware description, and use a
> > separate handover method between the EFI stub and the kernel. Now that
> > initrd loading and passing the EFI memory map have been refactored into
> > pure EFI routines that use EFI configuration tables, the only thing we
> > need to pass directly is the kernel command line (even if we could pass
> > this via a config table as well, it is used extremely early, so passing
> > it directly is preferred in this case.)
> >
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
> >  arch/loongarch/Kconfig                        |  3 --
> >  arch/loongarch/include/asm/bootinfo.h         |  2 +-
> >  arch/loongarch/kernel/efi.c                   | 30 ++++++++++-
> >  arch/loongarch/kernel/env.c                   | 13 ++---
> >  arch/loongarch/kernel/head.S                  |  2 +
> >  arch/loongarch/kernel/setup.c                 |  4 +-
> >  drivers/firmware/efi/libstub/Makefile         | 13 +++--
> >  drivers/firmware/efi/libstub/loongarch-stub.c | 56 +++++++++++++++++---
> >  8 files changed, 95 insertions(+), 28 deletions(-)
> >
> > diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> > index fca106a8b8af..14a2a1ec8561 100644
> > --- a/arch/loongarch/Kconfig
> > +++ b/arch/loongarch/Kconfig
> > @@ -104,8 +104,6 @@ config LOONGARCH
> >         select MODULES_USE_ELF_RELA if MODULES
> >         select NEED_PER_CPU_EMBED_FIRST_CHUNK
> >         select NEED_PER_CPU_PAGE_FIRST_CHUNK
> > -       select OF
> > -       select OF_EARLY_FLATTREE
> >         select PCI
> >         select PCI_DOMAINS_GENERIC
> >         select PCI_ECAM if ACPI
> > @@ -311,7 +309,6 @@ config DMI
> >  config EFI
> >         bool "EFI runtime service support"
> >         select UCS2_STRING
> > -       select EFI_PARAMS_FROM_FDT
> >         select EFI_RUNTIME_WRAPPERS
> >         help
> >           This enables the kernel to use EFI runtime services that are
> > diff --git a/arch/loongarch/include/asm/bootinfo.h b/arch/loongarch/include/asm/bootinfo.h
> > index e02ac4af7f6e..8e5881bc5ad1 100644
> > --- a/arch/loongarch/include/asm/bootinfo.h
> > +++ b/arch/loongarch/include/asm/bootinfo.h
> > @@ -36,7 +36,7 @@ struct loongson_system_configuration {
> >  };
> >
> >  extern u64 efi_system_table;
> > -extern unsigned long fw_arg0, fw_arg1;
> > +extern unsigned long fw_arg0, fw_arg1, fw_arg2;
> >  extern struct loongson_board_info b_info;
> >  extern struct loongson_system_configuration loongson_sysconf;
> >
> > diff --git a/arch/loongarch/kernel/efi.c b/arch/loongarch/kernel/efi.c
> > index 1f1f755fb425..a31329971133 100644
> > --- a/arch/loongarch/kernel/efi.c
> > +++ b/arch/loongarch/kernel/efi.c
> > @@ -27,8 +27,13 @@
> >  static unsigned long efi_nr_tables;
> >  static unsigned long efi_config_table;
> >
> > +static unsigned long __initdata boot_memmap = EFI_INVALID_TABLE_ADDR;
> > +
> >  static efi_system_table_t *efi_systab;
> > -static efi_config_table_type_t arch_tables[] __initdata = {{},};
> > +static efi_config_table_type_t arch_tables[] __initdata = {
> > +       {LINUX_EFI_BOOT_MEMMAP_GUID,    &boot_memmap,   "MEMMAP" },
> > +       {},
> > +};
> >
> >  void __init efi_runtime_init(void)
> >  {
> > @@ -51,6 +56,7 @@ void __init efi_init(void)
> >  {
> >         int size;
> >         void *config_tables;
> > +       struct efi_boot_memmap *tbl;
> >
> >         if (!efi_system_table)
> >                 return;
> > @@ -61,6 +67,8 @@ void __init efi_init(void)
> >                 return;
> >         }
> >
> > +       efi_systab_report_header(&efi_systab->hdr, efi_systab->fw_vendor);
> > +
> >         set_bit(EFI_64BIT, &efi.flags);
> >         efi_nr_tables    = efi_systab->nr_tables;
> >         efi_config_table = (unsigned long)efi_systab->tables;
> > @@ -70,6 +78,26 @@ void __init efi_init(void)
> >         efi_config_parse_tables(config_tables, efi_systab->nr_tables, arch_tables);
> >         early_memunmap(config_tables, efi_nr_tables * size);
> >
> > +       set_bit(EFI_CONFIG_TABLES, &efi.flags);
> > +
> >         if (screen_info.orig_video_isVGA == VIDEO_TYPE_EFI)
> >                 memblock_reserve(screen_info.lfb_base, screen_info.lfb_size);
> > +
> > +       if (boot_memmap == EFI_INVALID_TABLE_ADDR)
> > +               return;
> > +
> > +       tbl = early_memremap_ro(boot_memmap, sizeof(*tbl));
> > +       if (tbl) {
> > +               struct efi_memory_map_data data;
> > +
> > +               data.phys_map           = boot_memmap + sizeof(*tbl);
> > +               data.size               = tbl->map_size;
> > +               data.desc_size          = tbl->desc_size;
> > +               data.desc_version       = tbl->desc_ver;
> > +
> > +               if (efi_memmap_init_early(&data) < 0)
> > +                       panic("Unable to map EFI memory map.\n");
> > +
> > +               early_memunmap(tbl, sizeof(*tbl));
> > +       }
> >  }
> > diff --git a/arch/loongarch/kernel/env.c b/arch/loongarch/kernel/env.c
> > index 82b478a5c665..6d56a463b091 100644
> > --- a/arch/loongarch/kernel/env.c
> > +++ b/arch/loongarch/kernel/env.c
> > @@ -8,7 +8,6 @@
> >  #include <linux/efi.h>
> >  #include <linux/export.h>
> >  #include <linux/memblock.h>
> > -#include <linux/of_fdt.h>
> >  #include <asm/early_ioremap.h>
> >  #include <asm/bootinfo.h>
> >  #include <asm/loongson.h>
> > @@ -20,21 +19,17 @@ EXPORT_SYMBOL(loongson_sysconf);
> >  void __init init_environ(void)
> >  {
> >         int efi_boot = fw_arg0;
> > -       struct efi_memory_map_data data;
> > -       void *fdt_ptr = early_memremap_ro(fw_arg1, SZ_64K);
> > +       char *cmdline = early_memremap_ro(fw_arg1, COMMAND_LINE_SIZE);
> >
> >         if (efi_boot)
> >                 set_bit(EFI_BOOT, &efi.flags);
> >         else
> >                 clear_bit(EFI_BOOT, &efi.flags);
> >
> > -       early_init_dt_scan(fdt_ptr);
> > -       early_init_fdt_reserve_self();
> > -       efi_system_table = efi_get_fdt_params(&data);
> > +       strscpy(boot_command_line, cmdline, COMMAND_LINE_SIZE);
> > +       early_memunmap(cmdline, COMMAND_LINE_SIZE);
> >
> > -       efi_memmap_init_early(&data);
> > -       memblock_reserve(data.phys_map & PAGE_MASK,
> > -                        PAGE_ALIGN(data.size + (data.phys_map & ~PAGE_MASK)));
> > +       efi_system_table = fw_arg2;
> >  }
> >
> >  static int __init init_cpu_fullname(void)
> > diff --git a/arch/loongarch/kernel/head.S b/arch/loongarch/kernel/head.S
> > index 01bac62a6442..8f89f39fd31b 100644
> > --- a/arch/loongarch/kernel/head.S
> > +++ b/arch/loongarch/kernel/head.S
> > @@ -67,6 +67,8 @@ SYM_CODE_START(kernel_entry)                  # kernel entry point
> >         st.d            a0, t0, 0               # firmware arguments
> >         la              t0, fw_arg1
> >         st.d            a1, t0, 0
> > +       la              t0, fw_arg2
> > +       st.d            a2, t0, 0
> >
> >         /* KSave3 used for percpu base, initialized as 0 */
> >         csrwr           zero, PERCPU_BASE_KS
> > diff --git a/arch/loongarch/kernel/setup.c b/arch/loongarch/kernel/setup.c
> > index e8714b1d94c8..7fabf2306e80 100644
> > --- a/arch/loongarch/kernel/setup.c
> > +++ b/arch/loongarch/kernel/setup.c
> > @@ -51,7 +51,7 @@
> >
> >  struct screen_info screen_info __section(".data");
> >
> > -unsigned long fw_arg0, fw_arg1;
> > +unsigned long fw_arg0, fw_arg1, fw_arg2;
> >  DEFINE_PER_CPU(unsigned long, kernelsp);
> >  struct cpuinfo_loongarch cpu_data[NR_CPUS] __read_mostly;
> >
> > @@ -187,7 +187,6 @@ early_param("mem", early_parse_mem);
> >
> >  void __init platform_init(void)
> >  {
> > -       efi_init();
> >  #ifdef CONFIG_ACPI_TABLE_UPGRADE
> >         acpi_table_upgrade();
> >  #endif
> > @@ -347,6 +346,7 @@ void __init setup_arch(char **cmdline_p)
> >         *cmdline_p = boot_command_line;
> >
> >         init_environ();
> > +       efi_init();
> >         memblock_init();
> >         parse_early_param();
> >
> > diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
> > index ec2a7ba9364f..6234edf3d827 100644
> > --- a/drivers/firmware/efi/libstub/Makefile
> > +++ b/drivers/firmware/efi/libstub/Makefile
> > @@ -29,7 +29,7 @@ cflags-$(CONFIG_RISCV)                := $(subst $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)) \
> >  cflags-$(CONFIG_LOONGARCH)     := $(subst $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)) \
> >                                    -fpie
> >
> > -cflags-$(CONFIG_EFI_GENERIC_STUB) += -I$(srctree)/scripts/dtc/libfdt
> > +cflags-$(CONFIG_EFI_PARAMS_FROM_FDT)   += -I$(srctree)/scripts/dtc/libfdt
> >
> >  KBUILD_CFLAGS                  := $(cflags-y) -Os -DDISABLE_BRANCH_PROFILING \
> >                                    -include $(srctree)/include/linux/hidden.h \
> > @@ -59,14 +59,17 @@ lib-y                               := efi-stub-helper.o gop.o secureboot.o tpm.o \
> >                                    skip_spaces.o lib-cmdline.o lib-ctype.o \
> >                                    alignedmem.o relocate.o vsprintf.o
> >
> > -# include the stub's generic dependencies from lib/ when building for ARM/arm64
> > -efi-deps-y := fdt_rw.c fdt_ro.c fdt_wip.c fdt.c fdt_empty_tree.c fdt_sw.c
> > +# include the stub's libfdt dependencies from lib/ when needed
> > +libfdt-deps                    := fdt_rw.c fdt_ro.c fdt_wip.c fdt.c \
> > +                                  fdt_empty_tree.c fdt_sw.c
> > +
> > +lib-$(CONFIG_EFI_PARAMS_FROM_FDT) += fdt.o \
> > +                                    $(patsubst %.c,lib-%.o,$(libfdt-deps))
> >
> >  $(obj)/lib-%.o: $(srctree)/lib/%.c FORCE
> >         $(call if_changed_rule,cc_o_c)
> >
> > -lib-$(CONFIG_EFI_GENERIC_STUB) += efi-stub.o fdt.o string.o \
> > -                                  $(patsubst %.c,lib-%.o,$(efi-deps-y))
> > +lib-$(CONFIG_EFI_GENERIC_STUB) += efi-stub.o string.o
> >
> >  lib-$(CONFIG_ARM)              += arm32-stub.o
> >  lib-$(CONFIG_ARM64)            += arm64-stub.o
> > diff --git a/drivers/firmware/efi/libstub/loongarch-stub.c b/drivers/firmware/efi/libstub/loongarch-stub.c
> > index b7ef8d2df59e..32329f2a92f9 100644
> > --- a/drivers/firmware/efi/libstub/loongarch-stub.c
> > +++ b/drivers/firmware/efi/libstub/loongarch-stub.c
> > @@ -9,7 +9,8 @@
> >  #include <asm/addrspace.h>
> >  #include "efistub.h"
> >
> > -typedef void __noreturn (*kernel_entry_t)(bool efi, unsigned long fdt);
> > +typedef void __noreturn (*kernel_entry_t)(bool efi, unsigned long cmdline,
> > +                                         unsigned long systab);
> >
> >  extern int kernel_asize;
> >  extern int kernel_fsize;
> > @@ -42,19 +43,60 @@ efi_status_t handle_kernel_image(unsigned long *image_addr,
> >         return status;
> >  }
> >
> > -void __noreturn efi_enter_kernel(unsigned long entrypoint, unsigned long fdt, unsigned long fdt_size)
> > +struct exit_boot_struct {
> > +       efi_memory_desc_t       *runtime_map;
> > +       int                     runtime_entry_count;
> > +};
> > +
> > +static efi_status_t exit_boot_func(struct efi_boot_memmap *map, void *priv)
> > +{
> > +       struct exit_boot_struct *p = priv;
> > +
> > +       /*
> > +        * Update the memory map with virtual addresses. The function will also
> > +        * populate @runtime_map with copies of just the EFI_MEMORY_RUNTIME
> > +        * entries so that we can pass it straight to SetVirtualAddressMap()
> > +        */
> > +       efi_get_virtmap(map->map, map->map_size, map->desc_size,
> > +                       p->runtime_map, &p->runtime_entry_count);
> > +
> > +       return EFI_SUCCESS;
> > +}
> > +
> > +efi_status_t efi_boot_kernel(void *handle, efi_loaded_image_t *image,
> > +                            unsigned long kernel_addr, char *cmdline_ptr)
> >  {
> >         kernel_entry_t real_kernel_entry;
> > +       struct exit_boot_struct priv;
> > +       unsigned long desc_size;
> > +       efi_status_t status;
> > +       u32 desc_ver;
> > +
> > +       status = efi_alloc_virtmap(&priv.runtime_map, &desc_size, &desc_ver);
> > +       if (status != EFI_SUCCESS) {
> > +               efi_err("Unable to retrieve UEFI memory map.\n");
> > +               return status;
> > +       }
> > +
> > +       efi_info("Exiting boot services\n");
> > +
> > +       efi_novamap = false;
> > +       status = efi_exit_boot_services(handle, &priv, exit_boot_func);
> > +       if (status != EFI_SUCCESS)
> > +               return status;
> > +
> > +       /* Install the new virtual address map */
> > +       efi_rt_call(set_virtual_address_map,
> > +                   priv.runtime_entry_count * desc_size, desc_size,
> > +                   desc_ver, priv.runtime_map);
> >
> >         /* Config Direct Mapping */
> >         csr_write64(CSR_DMW0_INIT, LOONGARCH_CSR_DMWIN0);
> >         csr_write64(CSR_DMW1_INIT, LOONGARCH_CSR_DMWIN1);
> >
> >         real_kernel_entry = (kernel_entry_t)
> > -               ((unsigned long)&kernel_entry - entrypoint + VMLINUX_LOAD_ADDRESS);
> > +               ((unsigned long)&kernel_entry - kernel_addr + VMLINUX_LOAD_ADDRESS);
> >
> > -       if (!efi_novamap)
> > -               real_kernel_entry(true, fdt);
> > -       else
> > -               real_kernel_entry(false, fdt);
> > +       real_kernel_entry(true, (unsigned long)cmdline_ptr,
> > +                         (unsigned long)efi_system_table);
> >  }
> > --
> > 2.35.1
> >
> >
