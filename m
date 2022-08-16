Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10E8D595F1B
	for <lists+linux-efi@lfdr.de>; Tue, 16 Aug 2022 17:33:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235586AbiHPPc5 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 16 Aug 2022 11:32:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234199AbiHPPcx (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 16 Aug 2022 11:32:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3EAC46201;
        Tue, 16 Aug 2022 08:32:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 76865611CD;
        Tue, 16 Aug 2022 15:32:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6B54C433C1;
        Tue, 16 Aug 2022 15:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660663967;
        bh=PrCMfKsHN/J7SvycOVjlMXPZ40WE8uc7XB/vs4ZNd/k=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=j9F7mAaBsPJFRisqrRDdPnWezVLhN7pBIEX1ypTkB+qj+Lu7RxQlM7FqJ2BZa1Un4
         zQ8JSVz9tXXEK9HO21B2m5t9+MW7JNh/deG1JNUxeHBzyb1M3jrLqLRqn8peuag2ed
         usWRj+VcEXMqvB20jm1g5AqpiBzIjrTmct04G0ubpeTKnEp1lSDkDwBoNcxpHxda/j
         h2LM6khcITzynt/LUXnzuO/itD2fkSZfjD7C5/+eeTZsVoxxvIJBJttxpuDJV6tjX7
         oiM9Hnb8LqDKMS4V19jtS5+yKBdKR1O0N9I4FXa+Wll7e7PY8gmh6nn2QzKXooGSMh
         hb6foTdHCkPQQ==
Received: by mail-wm1-f45.google.com with SMTP id r83-20020a1c4456000000b003a5cb389944so5677067wma.4;
        Tue, 16 Aug 2022 08:32:47 -0700 (PDT)
X-Gm-Message-State: ACgBeo3AgXfxk4EcS7OMGBBcsVWKV2ge9SSxYuQqQtGeudKDteTBIoCL
        nkvPU7m/xzx3G9qj5FyjYg7F3OoDJPy0kZPUIkQ=
X-Google-Smtp-Source: AA6agR5mKhVc8dcsujRE8wKc9N43Zrlu+Ppm2C1SmhPxj1FL5hd28Ybl26Hf3lCfyEocWrGiaxuEcjPUrc15tgrgA2Q=
X-Received: by 2002:a05:600c:3d88:b0:3a6:a5:19eb with SMTP id
 bi8-20020a05600c3d8800b003a600a519ebmr4557645wmb.163.1660663966027; Tue, 16
 Aug 2022 08:32:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220617145754.582056-1-chenhuacai@loongson.cn>
 <CAMj1kXERN209b7dbVs_hy4BeUwrmk2p9_vF+Wq2W8PUeHOQTkg@mail.gmail.com> <CAAhV-H60CJDRY4c+Eu+L=rNgHsXQqx=HK9nNSqg69WVV+Bm3SQ@mail.gmail.com>
In-Reply-To: <CAAhV-H60CJDRY4c+Eu+L=rNgHsXQqx=HK9nNSqg69WVV+Bm3SQ@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 16 Aug 2022 17:32:34 +0200
X-Gmail-Original-Message-ID: <CAMj1kXE1MijqonkPeH+Ydg8ti4_4YFXxBKK6Wztb=HtSY5EAgQ@mail.gmail.com>
Message-ID: <CAMj1kXE1MijqonkPeH+Ydg8ti4_4YFXxBKK6Wztb=HtSY5EAgQ@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: Add efistub booting support
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>, loongarch@lists.linux.dev,
        linux-arch <linux-arch@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 16 Aug 2022 at 17:23, Huacai Chen <chenhuacai@kernel.org> wrote:
>
> Hi, Ard,
>
> On Tue, Aug 16, 2022 at 9:27 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > On Fri, 17 Jun 2022 at 16:56, Huacai Chen <chenhuacai@loongson.cn> wrote:
> > >
...
> > > diff --git a/arch/loongarch/kernel/efi.c b/arch/loongarch/kernel/efi.c
> > > index a50b60c587fa..42f7cfe9ab03 100644
> > > --- a/arch/loongarch/kernel/efi.c
> > > +++ b/arch/loongarch/kernel/efi.c
> > > @@ -22,19 +22,141 @@
> > >
> > >  #include <asm/early_ioremap.h>
> > >  #include <asm/efi.h>
> > > +#include <asm/tlb.h>
> > >  #include <asm/loongson.h>
> > >
> > >  static unsigned long efi_nr_tables;
> > >  static unsigned long efi_config_table;
> > > +static unsigned long screen_info_table __initdata = EFI_INVALID_TABLE_ADDR;
> > >
> > >  static efi_system_table_t *efi_systab;
> > > -static efi_config_table_type_t arch_tables[] __initdata = {{},};
> > > +static efi_config_table_type_t arch_tables[] __initdata = {
> > > +       {LINUX_EFI_LARCH_SCREEN_INFO_TABLE_GUID, &screen_info_table, "SINFO"},
> > > +       {},
> > > +};
> > > +
> > > +static void __init init_screen_info(void)
> > > +{
> > > +       struct screen_info *si;
> > > +
> > > +       if (screen_info_table == EFI_INVALID_TABLE_ADDR)
> > > +               return;
> > > +
> > > +       si = early_memremap_ro(screen_info_table, sizeof(*si));
> > > +       if (!si) {
> > > +               pr_err("Could not map screen_info config table\n");
> > > +               return;
> > > +       }
> > > +       screen_info = *si;
> > > +       early_memunmap(si, sizeof(*si));
> > > +
> > > +       if (screen_info.orig_video_isVGA == VIDEO_TYPE_EFI)
> > > +               memblock_reserve(screen_info.lfb_base, screen_info.lfb_size);
> > > +}
> > > +
> >
> > The above may be unnecessary - the EFI stub is part of the core kernel
> > image, so you can access screen_info directly (please refer to the
> > arm64 port for an example)
> Though we haven't supported zboot yet, but you are proposing for that.
> I think in that case we should use dynamic allocation?
>

No that makes no difference. The point is that the EFI stub and the
core kernel are the same image, so when the stub runs, the core
kernel's screen_info already exists in memory - the only thing you
need to do is make it accessible by adding it to image-vars.h

...
> > > +
> > > +/*
> > > + * set_virtual_map() - create a virtual mapping for the EFI memory map and call
> > > + * efi_set_virtual_address_map enter virtual for runtime service
> > > + *
> > > + * This function populates the virt_addr fields of all memory region descriptors
> > > + * in @memory_map whose EFI_MEMORY_RUNTIME attribute is set. Those descriptors
> > > + * are also copied to @runtime_map, and their total count is returned in @count.
> > > + */
> >
> > You mentioned before that this must be done in the core kernel and not
> > in the EFI stub, but I don't remember the reason.
> >
> > Can you add a comment here why the below conversions cannot be done by
> > the EFI stub? Doing this in the stub removes the need to set up a 1:1
> > mapping just for a single invocation of SetVirtualAddressMap(), so if
> > there is any way to move this into the stub, I would strongly prefer
> > it.
> In the current implementation of generic efistub, efi runtime is in a
> separate address space, but we want to map efi runtime in the kernel
> address space. So, even if we do SVAM in stub, we still need to modify
> some code.

That is fine.

> And if we do SVAM in the core kernel, we don't need to
> modify generic stub (as a side effect, this makes the non-EFI kernel
> be also able to use efi runtime).
>
> If use efi runtime in non-EFI kernel is unacceptable, and if we are
> free to modify the generic stub, then we can move SVAM to the stub.
>

We should only support EFI runtime services when booting via the EFI stub.

...
> > > diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
> > > index 7aa4717cdcac..9e4645e5a5c0 100644
> > > --- a/drivers/firmware/efi/Kconfig
> > > +++ b/drivers/firmware/efi/Kconfig
> > > @@ -118,7 +118,7 @@ config EFI_GENERIC_STUB
> > >
> > >  config EFI_ARMSTUB_DTB_LOADER
> > >         bool "Enable the DTB loader"
> > > -       depends on EFI_GENERIC_STUB && !RISCV
> > > +       depends on EFI_GENERIC_STUB && !RISCV && !LOONGARCH
> > >         default y
> > >         help
> > >           Select this config option to add support for the dtb= command
> >
> > Please make the initrd command line loader depend on !LOONGARCH.
> > systemd-boot already supports this, and GRUB patches are on the list
> > (the one you quoted above is part of the series that adds support for
> > it). Your QEMU/edk2 firmware port also implements support for the
> > LoadFile2 based method.
> I agree to not select "initrd command line loader" by default, but can
> we have a chance to select it even just for debugging? Because
> sometimes we want to load the kernel and initrd via the command line
> in the EFI shell.
>

The EFI shell has a 'initrd' command which implements the LoadFile2
protocol: please refer to

OvmfPkg/LinuxInitrdDynamicShellCommand/LinuxInitrdDynamicShellCommand.inf

and include it in your build of the UEFI shell. (It can be added to
the UEFI shell even when it runs on non-QEMU systems)

> >
> > > diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
> > > index d0537573501e..1588c61939e7 100644
> > > --- a/drivers/firmware/efi/libstub/Makefile
> > > +++ b/drivers/firmware/efi/libstub/Makefile
> > > @@ -26,6 +26,8 @@ cflags-$(CONFIG_ARM)          := $(subst $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)) \
> > >                                    $(call cc-option,-mno-single-pic-base)
> > >  cflags-$(CONFIG_RISCV)         := $(subst $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)) \
> > >                                    -fpic
> > > +cflags-$(CONFIG_LOONGARCH)     := $(subst $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)) \
> > > +                                  -fpic
> > >
> > >  cflags-$(CONFIG_EFI_GENERIC_STUB) += -I$(srctree)/scripts/dtc/libfdt
> > >
> > > @@ -70,6 +72,8 @@ lib-$(CONFIG_ARM)             += arm32-stub.o
> > >  lib-$(CONFIG_ARM64)            += arm64-stub.o
> > >  lib-$(CONFIG_X86)              += x86-stub.o
> > >  lib-$(CONFIG_RISCV)            += riscv-stub.o
> > > +lib-$(CONFIG_LOONGARCH)                += loongarch-stub.o
> > > +
> > >  CFLAGS_arm32-stub.o            := -DTEXT_OFFSET=$(TEXT_OFFSET)
> > >
> > >  # Even when -mbranch-protection=none is set, Clang will generate a
> > > @@ -125,6 +129,12 @@ STUBCOPY_FLAGS-$(CONFIG_RISCV)     += --prefix-alloc-sections=.init \
> > >                                    --prefix-symbols=__efistub_
> > >  STUBCOPY_RELOC-$(CONFIG_RISCV) := R_RISCV_HI20
> > >
> > > +# For LoongArch, keep all the symbols in .init section and make sure that no
> > > +# absolute symbols references doesn't exist.
> > > +STUBCOPY_FLAGS-$(CONFIG_LOONGARCH)     += --prefix-alloc-sections=.init \
> > > +                                          --prefix-symbols=__efistub_
> > > +STUBCOPY_RELOC-$(CONFIG_LOONGARCH)     := R_LARCH_MARK_LA
> > > +
> > >  $(obj)/%.stub.o: $(obj)/%.o FORCE
> > >         $(call if_changed,stubcopy)
> > >
> > > diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
> > > index 3d972061c1b0..f612cfceda22 100644
> > > --- a/drivers/firmware/efi/libstub/efi-stub-helper.c
> > > +++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
> > > @@ -21,7 +21,7 @@
> > >  bool efi_nochunk;
> > >  bool efi_nokaslr = !IS_ENABLED(CONFIG_RANDOMIZE_BASE);
> > >  int efi_loglevel = CONSOLE_LOGLEVEL_DEFAULT;
> > > -bool efi_novamap;
> > > +bool efi_novamap = IS_ENABLED(CONFIG_LOONGARCH); /* LoongArch call svam() in kernel */
> > >
> > >  static bool efi_noinitrd;
> > >  static bool efi_nosoftreserve;
> > > diff --git a/drivers/firmware/efi/libstub/efi-stub.c b/drivers/firmware/efi/libstub/efi-stub.c
> > > index f515394cce6e..730b7bd21776 100644
> > > --- a/drivers/firmware/efi/libstub/efi-stub.c
> > > +++ b/drivers/firmware/efi/libstub/efi-stub.c
> > > @@ -40,9 +40,9 @@
> > >
> > >  #ifdef CONFIG_ARM64
> > >  # define EFI_RT_VIRTUAL_LIMIT  DEFAULT_MAP_WINDOW_64
> > > -#elif defined(CONFIG_RISCV)
> > > +#elif defined(CONFIG_RISCV) || defined(CONFIG_LOONGARCH)
> > >  # define EFI_RT_VIRTUAL_LIMIT  TASK_SIZE_MIN
> > > -#else
> > > +#else /* Only if TASK_SIZE is a constant */
> > >  # define EFI_RT_VIRTUAL_LIMIT  TASK_SIZE
> > >  #endif
> > >
> > > diff --git a/drivers/firmware/efi/libstub/loongarch-stub.c b/drivers/firmware/efi/libstub/loongarch-stub.c
> > > new file mode 100644
> > > index 000000000000..beee086d9950
> > > --- /dev/null
> > > +++ b/drivers/firmware/efi/libstub/loongarch-stub.c
> > > @@ -0,0 +1,88 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * Author: Yun Liu <liuyun@loongson.cn>
> > > + *         Huacai Chen <chenhuacai@loongson.cn>
> > > + * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
> > > + */
> > > +
> > > +#include <linux/efi.h>
> > > +#include <asm/efi.h>
> > > +#include <asm/addrspace.h>
> > > +#include "efistub.h"
> > > +
> > > +typedef void __noreturn (*kernel_entry_t)(bool efi, unsigned long fdt);
> > > +
> > > +extern int kernel_asize;
> > > +extern int kernel_fsize;
> > > +extern int kernel_offset;
> > > +extern kernel_entry_t kernel_entry;
> > > +
> > > +static efi_guid_t screen_info_guid = LINUX_EFI_LARCH_SCREEN_INFO_TABLE_GUID;
> > > +
> > > +struct screen_info *alloc_screen_info(void)
> > > +{
> > > +       efi_status_t status;
> > > +       struct screen_info *si;
> > > +
> > > +       status = efi_bs_call(allocate_pool,
> > > +                       EFI_RUNTIME_SERVICES_DATA, sizeof(*si), (void **)&si);
> > > +       if (status != EFI_SUCCESS)
> > > +               return NULL;
> > > +
> > > +       status = efi_bs_call(install_configuration_table, &screen_info_guid, si);
> > > +       if (status == EFI_SUCCESS)
> > > +               return si;
> > > +
> > > +       efi_bs_call(free_pool, si);
> > > +
> > > +       return NULL;
> > > +}
> > > +
> > > +void free_screen_info(struct screen_info *si)
> > > +{
> > > +       if (!si)
> > > +               return;
> > > +
> > > +       efi_bs_call(install_configuration_table, &screen_info_guid, NULL);
> > > +       efi_bs_call(free_pool, si);
> > > +}
> > > +
> >
> > As indicated above, I think you can adopt the arm64 approach here instead.
> >
> > > +efi_status_t check_platform_features(void)
> > > +{
> > > +       /* Config Direct Mapping */
> > > +       csr_write64(CSR_DMW0_INIT, LOONGARCH_CSR_DMWIN0);
> > > +       csr_write64(CSR_DMW1_INIT, LOONGARCH_CSR_DMWIN1);
> > > +
> > > +       return EFI_SUCCESS;
> > > +}
> > > +
> >
> > This code is not checking a platform feature so it does not belong here.
> >
> > The EFI stub code is an ordinary EFI app, and it runs in the execution
> > context provided by EFI. So why is this needed so early? Can you move
> > it into the kernel entry routine instead?
> This is useful once we use our own zboot implementation, maybe we
> don't need it with the new method you are proposing.
>

If this is part of your zboot implementation, please drop it for now.
Let's try using the generic EFI zboot instead - if we need to, we can
find a way to add it there.

But out of curiosity, why is this needed at all?
