Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9624E16F84C
	for <lists+linux-efi@lfdr.de>; Wed, 26 Feb 2020 08:04:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbgBZHEU (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 26 Feb 2020 02:04:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:40514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726587AbgBZHET (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 26 Feb 2020 02:04:19 -0500
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA1132467D
        for <linux-efi@vger.kernel.org>; Wed, 26 Feb 2020 07:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582700659;
        bh=2Mn2rh2UnmkLwubpFpFIFXU5YjtRyl4XRJrdW3Zv9eg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tjIqbhWsUsTz4+iaFuaG3Q3kZPeya2RNPgdfY9noKlzPMqR70kquicHQLOlKKBWSh
         eYRTl6fWrrUsdHkTvGZghxaIlHSgAmwwb0d/CUZ3po4ElqkuoNAYxicPT4hSPsXM3e
         nYG0nVkZhDRwP3wJsVw62bE3cGetKKrWbXVlDqHg=
Received: by mail-wr1-f49.google.com with SMTP id j7so1518198wrp.13
        for <linux-efi@vger.kernel.org>; Tue, 25 Feb 2020 23:04:18 -0800 (PST)
X-Gm-Message-State: APjAAAWMojQBxt4cp1BPcC2L3suzgWrCtGeSPSmwW4ktt8dAacoKKatN
        QcsFltFzPLA/jcwJ565GnOmn21zXxkqsiMkpdveafg==
X-Google-Smtp-Source: APXvYqxa555rzHIoZ0rL1iFd+0wW3hZMB+8tKwX5N+47RWMS2ZNV5aiZqsLpbDwxvKr3L1l/1SoAEfvpxFPPGEc0+z4=
X-Received: by 2002:a05:6000:110b:: with SMTP id z11mr3726058wrw.252.1582700657097;
 Tue, 25 Feb 2020 23:04:17 -0800 (PST)
MIME-Version: 1.0
References: <20200226011037.7179-1-atish.patra@wdc.com> <20200226011037.7179-2-atish.patra@wdc.com>
In-Reply-To: <20200226011037.7179-2-atish.patra@wdc.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 26 Feb 2020 08:04:06 +0100
X-Gmail-Original-Message-ID: <CAKv+Gu-Dk4hOobKhOEn1Wpbc4Ta2F5anZQ4rRmjpkPfT2g1L3w@mail.gmail.com>
Message-ID: <CAKv+Gu-Dk4hOobKhOEn1Wpbc4Ta2F5anZQ4rRmjpkPfT2g1L3w@mail.gmail.com>
Subject: Re: [RFC PATCH 1/5] efi: Move arm-stub to a common file
To:     Atish Patra <atish.patra@wdc.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Allison Randal <allison@lohutok.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anup Patel <Anup.Patel@wdc.com>, Arnd Bergmann <arnd@arndb.de>,
        Borislav Petkov <bp@suse.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        linux-riscv@lists.infradead.org, Mao Han <han_mao@c-sky.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        Alexander Graf <agraf@csgraf.de>,
        "leif@nuviainc.com" <leif@nuviainc.com>,
        "Chang, Abner (HPS SW/FW Technologist)" <abner.chang@hpe.com>,
        "Schaefer, Daniel (DualStudy)" <daniel.schaefer@hpe.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Atish,

On Wed, 26 Feb 2020 at 02:10, Atish Patra <atish.patra@wdc.com> wrote:
>
> Most of the arm-stub code is written in an architecture independent manner.
> As a result, RISC-V can reuse most of the arm-stub code.
>
> Rename the arm-stub.c to efi-stub.c so that ARM, ARM64 and RISC-V can use it.
> This patch doesn't introduce any functional changes.
>
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> ---
>  arch/arm/Kconfig                                     |  2 +-
>  arch/arm64/Kconfig                                   |  2 +-
>  drivers/firmware/efi/Kconfig                         |  6 +++---
>  drivers/firmware/efi/libstub/Makefile                | 12 ++++++------
>  .../firmware/efi/libstub/{arm-stub.c => efi-stub.c}  |  7 ++++++-
>  5 files changed, 17 insertions(+), 12 deletions(-)
>  rename drivers/firmware/efi/libstub/{arm-stub.c => efi-stub.c} (98%)
>
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 97864aabc2a6..9931fea06076 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1955,7 +1955,7 @@ config EFI
>         select UCS2_STRING
>         select EFI_PARAMS_FROM_FDT
>         select EFI_STUB
> -       select EFI_ARMSTUB
> +       select EFI_GENERIC_ARCH_STUB
>         select EFI_RUNTIME_WRAPPERS
>         ---help---
>           This option provides support for runtime services provided
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 0b30e884e088..ae776d8ef2f9 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -1720,7 +1720,7 @@ config EFI
>         select EFI_PARAMS_FROM_FDT
>         select EFI_RUNTIME_WRAPPERS
>         select EFI_STUB
> -       select EFI_ARMSTUB
> +       select EFI_GENERIC_ARCH_STUB
>         default y
>         help
>           This option provides support for runtime services provided
> diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
> index ecc83e2f032c..1bcedb7812da 100644
> --- a/drivers/firmware/efi/Kconfig
> +++ b/drivers/firmware/efi/Kconfig
> @@ -106,12 +106,12 @@ config EFI_PARAMS_FROM_FDT
>  config EFI_RUNTIME_WRAPPERS
>         bool
>
> -config EFI_ARMSTUB
> +config EFI_GENERIC_ARCH_STUB

Let's call it EFI_GENERIC_STUB

>         bool
>
> -config EFI_ARMSTUB_DTB_LOADER
> +config EFI_STUB_DTB_LOADER
>         bool "Enable the DTB loader"
> -       depends on EFI_ARMSTUB
> +       depends on EFI_GENERIC_ARCH_STUB

Do you actually need the DTB loader? I feel adding this for ARM was a
mistake, so you may want to make this depend on !RISCV while you're at
it.

>         default y
>         help
>           Select this config option to add support for the dtb= command
> diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
> index 4d6246c6f651..2c5b76787126 100644
> --- a/drivers/firmware/efi/libstub/Makefile
> +++ b/drivers/firmware/efi/libstub/Makefile
> @@ -22,7 +22,7 @@ cflags-$(CONFIG_ARM)          := $(subst $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)) \
>                                    -fno-builtin -fpic \
>                                    $(call cc-option,-mno-single-pic-base)
>
> -cflags-$(CONFIG_EFI_ARMSTUB)   += -I$(srctree)/scripts/dtc/libfdt
> +cflags-$(CONFIG_EFI_GENERIC_ARCH_STUB) += -I$(srctree)/scripts/dtc/libfdt
>
>  KBUILD_CFLAGS                  := $(cflags-y) -DDISABLE_BRANCH_PROFILING \
>                                    -include $(srctree)/drivers/firmware/efi/libstub/hidden.h \
> @@ -44,13 +44,13 @@ lib-y                               := efi-stub-helper.o gop.o secureboot.o tpm.o \
>                                    skip_spaces.o lib-cmdline.o lib-ctype.o
>
>  # include the stub's generic dependencies from lib/ when building for ARM/arm64
> -arm-deps-y := fdt_rw.c fdt_ro.c fdt_wip.c fdt.c fdt_empty_tree.c fdt_sw.c
> +efi-deps-y := fdt_rw.c fdt_ro.c fdt_wip.c fdt.c fdt_empty_tree.c fdt_sw.c
>
>  $(obj)/lib-%.o: $(srctree)/lib/%.c FORCE
>         $(call if_changed_rule,cc_o_c)
>
> -lib-$(CONFIG_EFI_ARMSTUB)      += arm-stub.o fdt.o string.o \
> -                                  $(patsubst %.c,lib-%.o,$(arm-deps-y))
> +lib-$(CONFIG_EFI_GENERIC_ARCH_STUB)            += efi-stub.o fdt.o string.o \
> +                                  $(patsubst %.c,lib-%.o,$(efi-deps-y))
>
>  lib-$(CONFIG_ARM)              += arm32-stub.o
>  lib-$(CONFIG_ARM64)            += arm64-stub.o
> @@ -72,8 +72,8 @@ CFLAGS_arm64-stub.o           := -DTEXT_OFFSET=$(TEXT_OFFSET)
>  # a verification pass to see if any absolute relocations exist in any of the
>  # object files.
>  #
> -extra-$(CONFIG_EFI_ARMSTUB)    := $(lib-y)
> -lib-$(CONFIG_EFI_ARMSTUB)      := $(patsubst %.o,%.stub.o,$(lib-y))
> +extra-$(CONFIG_EFI_GENERIC_ARCH_STUB)  := $(lib-y)
> +lib-$(CONFIG_EFI_GENERIC_ARCH_STUB)    := $(patsubst %.o,%.stub.o,$(lib-y))
>
>  STUBCOPY_FLAGS-$(CONFIG_ARM64) += --prefix-alloc-sections=.init \
>                                    --prefix-symbols=__efistub_
> diff --git a/drivers/firmware/efi/libstub/arm-stub.c b/drivers/firmware/efi/libstub/efi-stub.c
> similarity index 98%
> rename from drivers/firmware/efi/libstub/arm-stub.c
> rename to drivers/firmware/efi/libstub/efi-stub.c
> index 13559c7e6643..b87c3f70430c 100644
> --- a/drivers/firmware/efi/libstub/arm-stub.c
> +++ b/drivers/firmware/efi/libstub/efi-stub.c
> @@ -15,6 +15,7 @@
>
>  #include "efistub.h"
>
> +#if IS_ENABLED(CONFIG_ARM64) || IS_ENABLED(CONFIG_ARM)
>  /*
>   * This is the base address at which to start allocating virtual memory ranges
>   * for UEFI Runtime Services. This is in the low TTBR0 range so that we can use
> @@ -27,6 +28,10 @@
>   * entire footprint of the UEFI runtime services memory regions)
>   */
>  #define EFI_RT_VIRTUAL_BASE    SZ_512M
> +#else
> +#define EFI_RT_VIRTUAL_BASE    SZ_2G
> +#endif
> +

Can we drop this hunk for now? It should be part of your runtime
services series.

>  #define EFI_RT_VIRTUAL_SIZE    SZ_512M
>
>  #ifdef CONFIG_ARM64
> @@ -243,7 +248,7 @@ efi_status_t efi_entry(efi_handle_t handle, efi_system_table_t *sys_table_arg)
>          * 'dtb=' unless UEFI Secure Boot is disabled.  We assume that secure
>          * boot is enabled if we can't determine its state.
>          */
> -       if (!IS_ENABLED(CONFIG_EFI_ARMSTUB_DTB_LOADER) ||
> +       if (!IS_ENABLED(CONFIG_EFI_STUB_DTB_LOADER) ||
>              secure_boot != efi_secureboot_mode_disabled) {
>                 if (strstr(cmdline_ptr, "dtb="))
>                         pr_efi("Ignoring DTB from command line.\n");
> --
> 2.24.0
>
