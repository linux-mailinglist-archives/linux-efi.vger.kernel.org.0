Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7CBB7173173
	for <lists+linux-efi@lfdr.de>; Fri, 28 Feb 2020 07:57:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbgB1G51 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 28 Feb 2020 01:57:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:34640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726816AbgB1G51 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 28 Feb 2020 01:57:27 -0500
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A2E3246B7
        for <linux-efi@vger.kernel.org>; Fri, 28 Feb 2020 06:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582873046;
        bh=+rH1XpINpBtrm88dqha9DYIzJHHfZ5HEryEX8ySQ3v8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=1IXlJ9iAroPkej8YtxatmI+am+jjVjZK896xJjmwx0XgK4O9354IrhfiFdeMnmL0c
         yp5cRueU1MwnDlssmO/84v1WjeIWjW0ryn5kanidXZZFZnG4J0ltw1/dAHUYzylpe0
         EcRcTppk9/rAED5Y/tn6ZGtrY8njx9ogaYLF6wtc=
Received: by mail-wm1-f45.google.com with SMTP id c84so1987841wme.4
        for <linux-efi@vger.kernel.org>; Thu, 27 Feb 2020 22:57:26 -0800 (PST)
X-Gm-Message-State: APjAAAWQWPMBtU6AR3oNIEDOchFSMBpKTK2VHHV9TrayKrjRK1gsNapj
        enPjfUTvgIQrCYfioLKSIgLzwtRPeIXcR3Dy6F6TiA==
X-Google-Smtp-Source: APXvYqxtrGbWvZZne3m36BaZC5k/CTyLwXh+VURvxHGT0Tcc9qYyqdtozf4p3oSB1pCY8XemvKU0wJ114Y5Za7eguo4=
X-Received: by 2002:a1c:bc46:: with SMTP id m67mr3136039wmf.40.1582873044773;
 Thu, 27 Feb 2020 22:57:24 -0800 (PST)
MIME-Version: 1.0
References: <20200226011037.7179-1-atish.patra@wdc.com> <20200226011037.7179-6-atish.patra@wdc.com>
 <CAKv+Gu_iAzQ6et13aACarqns8-xzQ+YSqj+m3mVGGy=ny8GJBg@mail.gmail.com>
 <26172d39fdb5ecd951ade0a89566c010f6166a03.camel@wdc.com> <CAKv+Gu8i93gM0dMqzbhvNbqsgd9dHCMGzX7E47uusrUvv6xRJA@mail.gmail.com>
 <46e9873e288134f638cd8726a2c15c9ca63860ce.camel@wdc.com>
In-Reply-To: <46e9873e288134f638cd8726a2c15c9ca63860ce.camel@wdc.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 28 Feb 2020 07:57:14 +0100
X-Gmail-Original-Message-ID: <CAKv+Gu_2dCj74VvCMRQ9yFgBtJRENasBbEV0bwcfqLQwuaj0=A@mail.gmail.com>
Message-ID: <CAKv+Gu_2dCj74VvCMRQ9yFgBtJRENasBbEV0bwcfqLQwuaj0=A@mail.gmail.com>
Subject: Re: [RFC PATCH 5/5] RISC-V: Add EFI stub support.
To:     Atish Patra <Atish.Patra@wdc.com>
Cc:     "alexios.zavras@intel.com" <alexios.zavras@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "abner.chang@hpe.com" <abner.chang@hpe.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "daniel.schaefer@hpe.com" <daniel.schaefer@hpe.com>,
        Anup Patel <Anup.Patel@wdc.com>,
        "kstewart@linuxfoundation.org" <kstewart@linuxfoundation.org>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "rppt@linux.ibm.com" <rppt@linux.ibm.com>,
        "bp@suse.de" <bp@suse.de>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "greentime.hu@sifive.com" <greentime.hu@sifive.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "agraf@csgraf.de" <agraf@csgraf.de>,
        "will@kernel.org" <will@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "allison@lohutok.net" <allison@lohutok.net>,
        "han_mao@c-sky.com" <han_mao@c-sky.com>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "leif@nuviainc.com" <leif@nuviainc.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 28 Feb 2020 at 02:05, Atish Patra <Atish.Patra@wdc.com> wrote:
>
> On Thu, 2020-02-27 at 20:59 +0100, Ard Biesheuvel wrote:
> > On Thu, 27 Feb 2020 at 20:53, Atish Patra <Atish.Patra@wdc.com>
> > wrote:
> > > On Wed, 2020-02-26 at 08:28 +0100, Ard Biesheuvel wrote:
> > > > On Wed, 26 Feb 2020 at 02:10, Atish Patra <atish.patra@wdc.com>
> > > > wrote:
> > > > > Add a RISC-V architecture specific stub code that actually
> > > > > copies
> > > > > the
> > > > > actual kernel image to a valid address and jump to it after
> > > > > boot
> > > > > services
> > > > > are terminated. Enable UEFI related kernel configs as well for
> > > > > RISC-V.
> > > > >
> > > > > Signed-off-by: Atish Patra <atish.patra@wdc.com>
> > > > > ---
> > > > >  arch/riscv/Kconfig                        |  20 ++++
> > > > >  arch/riscv/Makefile                       |   1 +
> > > > >  arch/riscv/configs/defconfig              |   1 +
> > > > >  drivers/firmware/efi/libstub/Makefile     |   8 ++
> > > > >  drivers/firmware/efi/libstub/riscv-stub.c | 135
> > > > > ++++++++++++++++++++++
> > > > >  5 files changed, 165 insertions(+)
> > > > >  create mode 100644 drivers/firmware/efi/libstub/riscv-stub.c
> > > > >
> > > > > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > > > > index 42c122170cfd..68b1d565e51d 100644
> > > > > --- a/arch/riscv/Kconfig
> > > > > +++ b/arch/riscv/Kconfig
> > > > > @@ -372,10 +372,30 @@ config CMDLINE_FORCE
> > > > >
> > > > >  endchoice
> > > > >
> > > > > +config EFI_STUB
> > > > > +       bool
> > > > > +
> > > > > +config EFI
> > > > > +       bool "UEFI runtime support"
> > > > > +       depends on OF
> > > > > +       select LIBFDT
> > > > > +       select UCS2_STRING
> > > > > +       select EFI_PARAMS_FROM_FDT
> > > > > +       select EFI_STUB
> > > > > +       select EFI_GENERIC_ARCH_STUB
> > > > > +       default y
> > > > > +       help
> > > > > +         This option provides support for runtime services
> > > > > provided
> > > > > +         by UEFI firmware (such as non-volatile variables,
> > > > > realtime
> > > > > +          clock, and platform reset). A UEFI stub is also
> > > > > provided
> > > > > to
> > > > > +         allow the kernel to be booted as an EFI application.
> > > > > This
> > > > > +         is only useful on systems that have UEFI firmware.
> > > > > +
> > > > >  endmenu
> > > > >
> > > > >  menu "Power management options"
> > > > >
> > > > >  source "kernel/power/Kconfig"
> > > > > +source "drivers/firmware/Kconfig"
> > > > >
> > > > >  endmenu
> > > > > diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
> > > > > index b9009a2fbaf5..0afaa89ba9ad 100644
> > > > > --- a/arch/riscv/Makefile
> > > > > +++ b/arch/riscv/Makefile
> > > > > @@ -78,6 +78,7 @@ head-y := arch/riscv/kernel/head.o
> > > > >  core-y += arch/riscv/
> > > > >
> > > > >  libs-y += arch/riscv/lib/
> > > > > +core-$(CONFIG_EFI_STUB) +=
> > > > > $(objtree)/drivers/firmware/efi/libstub/lib.a
> > > > >
> > > > >  PHONY += vdso_install
> > > > >  vdso_install:
> > > > > diff --git a/arch/riscv/configs/defconfig
> > > > > b/arch/riscv/configs/defconfig
> > > > > index e2ff95cb3390..0a5d3578f51e 100644
> > > > > --- a/arch/riscv/configs/defconfig
> > > > > +++ b/arch/riscv/configs/defconfig
> > > > > @@ -125,3 +125,4 @@ CONFIG_DEBUG_BLOCK_EXT_DEVT=y
> > > > >  # CONFIG_FTRACE is not set
> > > > >  # CONFIG_RUNTIME_TESTING_MENU is not set
> > > > >  CONFIG_MEMTEST=y
> > > > > +CONFIG_EFI=y
> > > > > diff --git a/drivers/firmware/efi/libstub/Makefile
> > > > > b/drivers/firmware/efi/libstub/Makefile
> > > > > index 2c5b76787126..38facb61745b 100644
> > > > > --- a/drivers/firmware/efi/libstub/Makefile
> > > > > +++ b/drivers/firmware/efi/libstub/Makefile
> > > > > @@ -21,6 +21,8 @@ cflags-$(CONFIG_ARM64)                :=
> > > > > $(subst
> > > > > $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)) \
> > > > >  cflags-$(CONFIG_ARM)           := $(subst
> > > > > $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)) \
> > > > >                                    -fno-builtin -fpic \
> > > > >                                    $(call cc-option,-mno-
> > > > > single-
> > > > > pic-base)
> > > > > +cflags-$(CONFIG_RISCV)         := $(subst
> > > > > $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)) \
> > > > > +                                  -fpic
> > > > >
> > > > >  cflags-$(CONFIG_EFI_GENERIC_ARCH_STUB) +=
> > > > > -I$(srctree)/scripts/dtc/libfdt
> > > > >
> > > > > @@ -55,6 +57,7 @@ lib-
> > > > > $(CONFIG_EFI_GENERIC_ARCH_STUB)           +=
> > > > > efi-stub.o fdt.o string.o \
> > > > >  lib-$(CONFIG_ARM)              += arm32-stub.o
> > > > >  lib-$(CONFIG_ARM64)            += arm64-stub.o
> > > > >  lib-$(CONFIG_X86)              += x86-stub.o
> > > > > +lib-$(CONFIG_RISCV)            += riscv-stub.o
> > > > >  CFLAGS_arm32-stub.o            := -DTEXT_OFFSET=$(TEXT_OFFSET)
> > > > >  CFLAGS_arm64-stub.o            := -DTEXT_OFFSET=$(TEXT_OFFSET)
> > > > >
> > > > > @@ -79,6 +82,11 @@ STUBCOPY_FLAGS-$(CONFIG_ARM64)       += --
> > > > > prefix-alloc-sections=.init \
> > > > >                                    --prefix-symbols=__efistub_
> > > > >  STUBCOPY_RELOC-$(CONFIG_ARM64) := R_AARCH64_ABS
> > > > >
> > > > > +STUBCOPY_FLAGS-$(CONFIG_RISCV) += --prefix-alloc-
> > > > > sections=.init \
> > > > > +                                  --prefix-symbols=__efistub_
> > > > > +STUBCOPY_RELOC-$(CONFIG_RISCV) := R_RISCV_HI20
> > > > > +
> > > > > +
> > > > >  $(obj)/%.stub.o: $(obj)/%.o FORCE
> > > > >         $(call if_changed,stubcopy)
> > > > >
> > > > > diff --git a/drivers/firmware/efi/libstub/riscv-stub.c
> > > > > b/drivers/firmware/efi/libstub/riscv-stub.c
> > > > > new file mode 100644
> > > > > index 000000000000..3935b29ea93a
> > > > > --- /dev/null
> > > > > +++ b/drivers/firmware/efi/libstub/riscv-stub.c
> > > > > @@ -0,0 +1,135 @@
> > > > > +// SPDX-License-Identifier: GPL-2.0
> > > > > +/*
> > > > > + * Copyright (C) 2013, 2014 Linaro Ltd;  <roy.franz@linaro.org
> > > > > >
> > > > > + * Copyright (C) 2020 Western Digital Corporation or its
> > > > > affiliates.
> > > > > + *
> > > > > + * This file implements the EFI boot stub for the RISC-V
> > > > > kernel.
> > > > > + * Adapted from ARM64 version at
> > > > > drivers/firmware/efi/libstub/arm64-stub.c.
> > > > > + */
> > > > > +
> > > > > +#include <linux/efi.h>
> > > > > +#include <linux/libfdt.h>
> > > > > +#include <linux/libfdt_env.h>
> > > > > +#include <asm/efi.h>
> > > > > +#include <asm/sections.h>
> > > > > +
> > > > > +#include "efistub.h"
> > > > > +/*
> > > > > + * RISCV requires the kernel image to placed TEXT_OFFSET bytes
> > > > > beyond a 2 MB
> > > > > + * aligned base for 64 bit and 4MB for 32 bit.
> > > > > + */
> > > > > +#if IS_ENABLED(CONFIG_64BIT)
> > > >
> > > > You can use #ifdef here
> > > >
> > >
> > > ok.
> > >
> > > > > +#define MIN_KIMG_ALIGN SZ_2M
> > > > > +#else
> > > > > +#define MIN_KIMG_ALIGN SZ_4M
> > > > > +#endif
> > > > > +/*
> > > > > + * TEXT_OFFSET ensures that we don't overwrite the firmware
> > > > > that
> > > > > probably sits
> > > > > + * at the beginning of the DRAM.
> > > > > + */
> > > >
> > > > Ugh. Really? On an EFI system, that memory should be reserved in
> > > > some
> > > > way, we shouldn't be able to stomp on it like that.
> > > >
> > >
> > > Currently, we reserve the initial 128KB for run time firmware(only
> > > openSBI for now, EDK2 later) by using PMP (physical memory
> > > protection).
> > > Any acess to that region from supervisor mode (i.e. U-Boot) will
> > > result
> > > in a fault.
> > >
> > > Is it mandatory for UEFI to reserve the beginning of the DRAM ?
> > >
> >
> > It is mandatory to describe which memory is usable and which memory
> > is
> > reserved. If this memory is not usable, you either describe it as
> > reserved, or not describe it at all. Describing it as usable memory,
> > allocating it for the kernel but with a hidden agreement that it is
> > reserved is highly likely to cause problems down the road.
> >
>
> I completely agree with you on this. We have been talking to have a
> booting guide and memory map document for RISC-V Linux to document all
> the idiosyncries of RISC-V. But that has not happend until now.
> Once, the ordered booting patches are merged, I will try to take a stab
> at it.
>
> Other than that, do we need to describe it somewhere in U-boot wrt to
> UEFI so that it doesn't allocate memory from that region ?
>

It is an idiosyncrasy that the firmware should hide from the OS.

What if GRUB comes along and attempts to allocate that memory? Do we
also have to teach it that the first 128 KB memory of free memory are
magic and should not be touched?

So the answer is to mark it as reserved. This way, no UEFI tools,
bootloaders etc will ever try to use it. Then, in the stub, you can
tweak the existing code to cheat a bit, and make the TEXT_OFFSET
window overlap the 128 KB reserved window at the bottom of memory.
Doing that in the stub is fine - this is part of the kernel so it can
know about crazy RISC-V rules.
