Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 188BC16F857
	for <lists+linux-efi@lfdr.de>; Wed, 26 Feb 2020 08:09:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbgBZHJE (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 26 Feb 2020 02:09:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:42496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726948AbgBZHJE (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 26 Feb 2020 02:09:04 -0500
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DBDED24670
        for <linux-efi@vger.kernel.org>; Wed, 26 Feb 2020 07:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582700943;
        bh=BdvukjoB3WBnGxQuMkXsAyznS/yxxSlgLx6C/Lh+O5s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=aLXV00WGNbPLHXgt1q6/H3/GVzQFXdwh6tHYzbPOgypdiAlt3vP/fGyZQrHx8mSxE
         /Xrq/zq1RkklN4cocFA1Hae36qAzR3g6ChMWulwQWOy2JQcTCIidyU6lZztqBrS3os
         1MvQ7Rex4Tm3nmfMV9H1IR8j8w0hYofJf/Tvxxpg=
Received: by mail-wm1-f45.google.com with SMTP id m3so1799787wmi.0
        for <linux-efi@vger.kernel.org>; Tue, 25 Feb 2020 23:09:02 -0800 (PST)
X-Gm-Message-State: APjAAAVadc+9LaCYD+MoonybZVgryBrwvozl+8S7vf/57fmgyTJ80wye
        y6ejFYHFHRfiyLmjxe73RMbasJJlAUrCJroyASKNPw==
X-Google-Smtp-Source: APXvYqygd/ulFA+LBYcE+02wpHVNjovd2gznC4M9/EIQzEGIl8/sG8qvkHkL/jt8pXKkT3+TfT6z5RSmn21ULS3+N40=
X-Received: by 2002:a7b:cb93:: with SMTP id m19mr72538wmi.133.1582700941221;
 Tue, 25 Feb 2020 23:09:01 -0800 (PST)
MIME-Version: 1.0
References: <20200226011037.7179-1-atish.patra@wdc.com> <20200226011037.7179-4-atish.patra@wdc.com>
In-Reply-To: <20200226011037.7179-4-atish.patra@wdc.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 26 Feb 2020 08:08:50 +0100
X-Gmail-Original-Message-ID: <CAKv+Gu8HdRa5k=h1XF2fm80VEgvuxa_tX_P0qFSdkk=CVc6ffA@mail.gmail.com>
Message-ID: <CAKv+Gu8HdRa5k=h1XF2fm80VEgvuxa_tX_P0qFSdkk=CVc6ffA@mail.gmail.com>
Subject: Re: [RFC PATCH 3/5] RISC-V: Define fixmap bindings for generic early
 ioremap support
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

On Wed, 26 Feb 2020 at 02:10, Atish Patra <atish.patra@wdc.com> wrote:
>
> UEFI uses early IO or memory mappings for runtime services before
> normal ioremap() is usable. This patch only adds minimum necessary
> fixmap bindings and headers for generic ioremap support to work.
>
> Signed-off-by: Atish Patra <atish.patra@wdc.com>

Looks reasonable to me,

Acked-by: Ard Biesheuvel <ardb@kernel.org>

although I wonder why it is part of this series?

> ---
>  arch/riscv/Kconfig              |  1 +
>  arch/riscv/include/asm/Kbuild   |  1 +
>  arch/riscv/include/asm/fixmap.h | 21 ++++++++++++++++++++-
>  arch/riscv/include/asm/io.h     |  1 +
>  4 files changed, 23 insertions(+), 1 deletion(-)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 27bfc7947e44..42c122170cfd 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -65,6 +65,7 @@ config RISCV
>         select ARCH_HAS_GCOV_PROFILE_ALL
>         select HAVE_COPY_THREAD_TLS
>         select HAVE_ARCH_KASAN if MMU && 64BIT
> +       select GENERIC_EARLY_IOREMAP
>
>  config ARCH_MMAP_RND_BITS_MIN
>         default 18 if 64BIT
> diff --git a/arch/riscv/include/asm/Kbuild b/arch/riscv/include/asm/Kbuild
> index ec0ca8c6ab64..517394390106 100644
> --- a/arch/riscv/include/asm/Kbuild
> +++ b/arch/riscv/include/asm/Kbuild
> @@ -4,6 +4,7 @@ generic-y += checksum.h
>  generic-y += compat.h
>  generic-y += device.h
>  generic-y += div64.h
> +generic-y += early_ioremap.h
>  generic-y += extable.h
>  generic-y += flat.h
>  generic-y += dma.h
> diff --git a/arch/riscv/include/asm/fixmap.h b/arch/riscv/include/asm/fixmap.h
> index 42d2c42f3cc9..7a4beb7e29a3 100644
> --- a/arch/riscv/include/asm/fixmap.h
> +++ b/arch/riscv/include/asm/fixmap.h
> @@ -25,9 +25,28 @@ enum fixed_addresses {
>  #define FIX_FDT_SIZE   SZ_1M
>         FIX_FDT_END,
>         FIX_FDT = FIX_FDT_END + FIX_FDT_SIZE / PAGE_SIZE - 1,
> +       FIX_EARLYCON_MEM_BASE,
> +
>         FIX_PTE,
>         FIX_PMD,
> -       FIX_EARLYCON_MEM_BASE,
> +       /*
> +        * Make sure that it is 2MB aligned.
> +        */
> +#define NR_FIX_SZ_2M   (SZ_2M / PAGE_SIZE)
> +       FIX_THOLE = NR_FIX_SZ_2M - FIX_PMD - 1,
> +
> +       __end_of_permanent_fixed_addresses,
> +       /*
> +        * Temporary boot-time mappings, used by early_ioremap(),
> +        * before ioremap() is functional.
> +        */
> +#define NR_FIX_BTMAPS          (SZ_256K / PAGE_SIZE)
> +#define FIX_BTMAPS_SLOTS       7
> +#define TOTAL_FIX_BTMAPS       (NR_FIX_BTMAPS * FIX_BTMAPS_SLOTS)
> +
> +       FIX_BTMAP_END = __end_of_permanent_fixed_addresses,
> +       FIX_BTMAP_BEGIN = FIX_BTMAP_END + TOTAL_FIX_BTMAPS - 1,
> +
>         __end_of_fixed_addresses
>  };
>
> diff --git a/arch/riscv/include/asm/io.h b/arch/riscv/include/asm/io.h
> index 0f477206a4ed..047f414b6948 100644
> --- a/arch/riscv/include/asm/io.h
> +++ b/arch/riscv/include/asm/io.h
> @@ -14,6 +14,7 @@
>  #include <linux/types.h>
>  #include <asm/mmiowb.h>
>  #include <asm/pgtable.h>
> +#include <asm/early_ioremap.h>
>
>  /*
>   * MMIO access functions are separated out to break dependency cycles
> --
> 2.24.0
>
