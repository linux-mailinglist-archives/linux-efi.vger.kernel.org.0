Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB542172921
	for <lists+linux-efi@lfdr.de>; Thu, 27 Feb 2020 21:02:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbgB0UBH (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 27 Feb 2020 15:01:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:56996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730716AbgB0UBH (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 27 Feb 2020 15:01:07 -0500
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9544E246B1
        for <linux-efi@vger.kernel.org>; Thu, 27 Feb 2020 20:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582833666;
        bh=i92tSJsBqBk3CzP62C3QM9Ge7+B8VLDLy8QK6K05kzY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Af4+Ycw0mp762ZvtUz3b1inyyPqDhnONpKiGtbRNgUnGODZiiRX+jKpuvneJqCMK2
         yt0KHWD/L0+VcRVkZmE8NyS9VNtXCJ7+ABqNAkVHWpqpVBZlB5Tqz2KB4ffrbqgbkG
         Rei/ImwXN38VutUjRo2TSMXYrUSmbEnjBMpMScyM=
Received: by mail-wr1-f45.google.com with SMTP id x7so356851wrr.0
        for <linux-efi@vger.kernel.org>; Thu, 27 Feb 2020 12:01:06 -0800 (PST)
X-Gm-Message-State: APjAAAWGpGncpg9lPU71LoVrEoM9h5JXQkLRGju8oF5AEhmNsTxRnw3m
        I2Veq4o869eGqDmWkU8BdiAWzl4WbaY+4E9HuSgoNw==
X-Google-Smtp-Source: APXvYqwNfGcYXWESaIhXXtct1v7f5gXKx5rzPZ8W7+pk2wS+P5lHRdVGAWs4Aafi3JACnyUrHs0Dsd9MpMVFbVYKcC4=
X-Received: by 2002:adf:f84a:: with SMTP id d10mr551741wrq.208.1582833665009;
 Thu, 27 Feb 2020 12:01:05 -0800 (PST)
MIME-Version: 1.0
References: <20200226011037.7179-1-atish.patra@wdc.com> <20200226011037.7179-4-atish.patra@wdc.com>
 <CAKv+Gu8HdRa5k=h1XF2fm80VEgvuxa_tX_P0qFSdkk=CVc6ffA@mail.gmail.com> <08322b0eeb26b564954a14273baf18db72e2f1e9.camel@wdc.com>
In-Reply-To: <08322b0eeb26b564954a14273baf18db72e2f1e9.camel@wdc.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 27 Feb 2020 21:00:54 +0100
X-Gmail-Original-Message-ID: <CAKv+Gu_OMs12qBxvZGnrUnMD782yYPpcvBDqRGug2YDhhvcfSw@mail.gmail.com>
Message-ID: <CAKv+Gu_OMs12qBxvZGnrUnMD782yYPpcvBDqRGug2YDhhvcfSw@mail.gmail.com>
Subject: Re: [RFC PATCH 3/5] RISC-V: Define fixmap bindings for generic early
 ioremap support
To:     Atish Patra <Atish.Patra@wdc.com>
Cc:     "alexios.zavras@intel.com" <alexios.zavras@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
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
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "bp@suse.de" <bp@suse.de>,
        "greentime.hu@sifive.com" <greentime.hu@sifive.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "agraf@csgraf.de" <agraf@csgraf.de>,
        "will@kernel.org" <will@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "allison@lohutok.net" <allison@lohutok.net>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "leif@nuviainc.com" <leif@nuviainc.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 27 Feb 2020 at 20:58, Atish Patra <Atish.Patra@wdc.com> wrote:
>
> On Wed, 2020-02-26 at 08:08 +0100, Ard Biesheuvel wrote:
> > On Wed, 26 Feb 2020 at 02:10, Atish Patra <atish.patra@wdc.com>
> > wrote:
> > > UEFI uses early IO or memory mappings for runtime services before
> > > normal ioremap() is usable. This patch only adds minimum necessary
> > > fixmap bindings and headers for generic ioremap support to work.
> > >
> > > Signed-off-by: Atish Patra <atish.patra@wdc.com>
> >
> > Looks reasonable to me,
> >
> > Acked-by: Ard Biesheuvel <ardb@kernel.org>
> >
> > although I wonder why it is part of this series?
> >
>
> because of CONFIG_EFI. With CONFIG_EFI enabled, all the run time
> service memory mapping code is compiled for RISC-V. I could have
> createa a separate config for only boot time services or used EFI_STUB
> at places where CONFI_EFI. But it seems redundant as we will support
> runtime services soon. Let me know if that's a wrong approach.
>

No that's fine



> > > ---
> > >  arch/riscv/Kconfig              |  1 +
> > >  arch/riscv/include/asm/Kbuild   |  1 +
> > >  arch/riscv/include/asm/fixmap.h | 21 ++++++++++++++++++++-
> > >  arch/riscv/include/asm/io.h     |  1 +
> > >  4 files changed, 23 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > > index 27bfc7947e44..42c122170cfd 100644
> > > --- a/arch/riscv/Kconfig
> > > +++ b/arch/riscv/Kconfig
> > > @@ -65,6 +65,7 @@ config RISCV
> > >         select ARCH_HAS_GCOV_PROFILE_ALL
> > >         select HAVE_COPY_THREAD_TLS
> > >         select HAVE_ARCH_KASAN if MMU && 64BIT
> > > +       select GENERIC_EARLY_IOREMAP
> > >
> > >  config ARCH_MMAP_RND_BITS_MIN
> > >         default 18 if 64BIT
> > > diff --git a/arch/riscv/include/asm/Kbuild
> > > b/arch/riscv/include/asm/Kbuild
> > > index ec0ca8c6ab64..517394390106 100644
> > > --- a/arch/riscv/include/asm/Kbuild
> > > +++ b/arch/riscv/include/asm/Kbuild
> > > @@ -4,6 +4,7 @@ generic-y += checksum.h
> > >  generic-y += compat.h
> > >  generic-y += device.h
> > >  generic-y += div64.h
> > > +generic-y += early_ioremap.h
> > >  generic-y += extable.h
> > >  generic-y += flat.h
> > >  generic-y += dma.h
> > > diff --git a/arch/riscv/include/asm/fixmap.h
> > > b/arch/riscv/include/asm/fixmap.h
> > > index 42d2c42f3cc9..7a4beb7e29a3 100644
> > > --- a/arch/riscv/include/asm/fixmap.h
> > > +++ b/arch/riscv/include/asm/fixmap.h
> > > @@ -25,9 +25,28 @@ enum fixed_addresses {
> > >  #define FIX_FDT_SIZE   SZ_1M
> > >         FIX_FDT_END,
> > >         FIX_FDT = FIX_FDT_END + FIX_FDT_SIZE / PAGE_SIZE - 1,
> > > +       FIX_EARLYCON_MEM_BASE,
> > > +
> > >         FIX_PTE,
> > >         FIX_PMD,
> > > -       FIX_EARLYCON_MEM_BASE,
> > > +       /*
> > > +        * Make sure that it is 2MB aligned.
> > > +        */
> > > +#define NR_FIX_SZ_2M   (SZ_2M / PAGE_SIZE)
> > > +       FIX_THOLE = NR_FIX_SZ_2M - FIX_PMD - 1,
> > > +
> > > +       __end_of_permanent_fixed_addresses,
> > > +       /*
> > > +        * Temporary boot-time mappings, used by early_ioremap(),
> > > +        * before ioremap() is functional.
> > > +        */
> > > +#define NR_FIX_BTMAPS          (SZ_256K / PAGE_SIZE)
> > > +#define FIX_BTMAPS_SLOTS       7
> > > +#define TOTAL_FIX_BTMAPS       (NR_FIX_BTMAPS * FIX_BTMAPS_SLOTS)
> > > +
> > > +       FIX_BTMAP_END = __end_of_permanent_fixed_addresses,
> > > +       FIX_BTMAP_BEGIN = FIX_BTMAP_END + TOTAL_FIX_BTMAPS - 1,
> > > +
> > >         __end_of_fixed_addresses
> > >  };
> > >
> > > diff --git a/arch/riscv/include/asm/io.h
> > > b/arch/riscv/include/asm/io.h
> > > index 0f477206a4ed..047f414b6948 100644
> > > --- a/arch/riscv/include/asm/io.h
> > > +++ b/arch/riscv/include/asm/io.h
> > > @@ -14,6 +14,7 @@
> > >  #include <linux/types.h>
> > >  #include <asm/mmiowb.h>
> > >  #include <asm/pgtable.h>
> > > +#include <asm/early_ioremap.h>
> > >
> > >  /*
> > >   * MMIO access functions are separated out to break dependency
> > > cycles
> > > --
> > > 2.24.0
> > >
>
> --
> Regards,
> Atish
