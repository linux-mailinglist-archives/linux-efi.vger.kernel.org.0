Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7D321ABA31
	for <lists+linux-efi@lfdr.de>; Thu, 16 Apr 2020 09:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439496AbgDPHpE (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 16 Apr 2020 03:45:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:48506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2439413AbgDPHpB (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 16 Apr 2020 03:45:01 -0400
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5269E21569;
        Thu, 16 Apr 2020 07:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587023100;
        bh=hE1B/GqPyAwbhU6GurhlP98Cp3yFkzngF+v28Ae6CuY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SefdfvWwUvkpCeZp632BCeHzCD1E+eBxMDa0onCAH2Tli/pzkNVZABj0lO3n08pjY
         VmCQN2x6QO95MKY5BUqMKZ4c1AH4K5buh1gDeCK6qDQM8rcrHaQo2cDaCTUluNRYae
         GB4jKKXt3Dw279ToHWFpWHh8k1UkuKegrxexBgm4=
Received: by mail-io1-f50.google.com with SMTP id i19so20000090ioh.12;
        Thu, 16 Apr 2020 00:45:00 -0700 (PDT)
X-Gm-Message-State: AGi0PuYu8mYXck4Ea3/DjMk8hO07aHjn5WbDUDaJ3YgJauMCilQIJTDe
        TdlvP9q/q7LALh98Db9sgWl2GFYjxoosntD85TE=
X-Google-Smtp-Source: APiQypLeNbjPF2bsg5mHsKG6G7YQ+2nbEUjMovAnSywp2+B1+QAFYCPiz1sV8RVxrQ6TQUjDzT1dDy7DHtl2X6Sr8S8=
X-Received: by 2002:a02:3341:: with SMTP id k1mr20976288jak.74.1587023099650;
 Thu, 16 Apr 2020 00:44:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200415195422.19866-1-atish.patra@wdc.com>
In-Reply-To: <20200415195422.19866-1-atish.patra@wdc.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 16 Apr 2020 09:44:48 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEJGED_uumBR3V-cVjmCpJZu9mwW42gc9hptw+YS-004w@mail.gmail.com>
Message-ID: <CAMj1kXEJGED_uumBR3V-cVjmCpJZu9mwW42gc9hptw+YS-004w@mail.gmail.com>
Subject: Re: [v3 PATCH 0/5] Add UEFI support for RISC-V
To:     Atish Patra <atish.patra@wdc.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        linux-riscv@lists.infradead.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Russell King <linux@armlinux.org.uk>,
        Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

(+ Arvind)

On Wed, 15 Apr 2020 at 21:54, Atish Patra <atish.patra@wdc.com> wrote:
>
> This series adds UEFI support for RISC-V. Currently, only boot time
> services have been added. Runtime services will be added in a separate
> series. This series depends on some core EFI patches
> present in current in efi-next and following other patches.
>
> U-Boot: Adds the boot hartid under chosen node.
> https://lists.denx.de/pipermail/u-boot/2020-April/405726.html
>
> Linux kernel: 5.7-rc1
>
> OpenSBI: master
>
> Patch 1 just moves arm-stub code to a generic code so that it can be used
> across different architecture.
>
> Patch 3 adds fixmap bindings so that CONFIG_EFI can be compiled and we do not
> have create separate config to enable boot time services.
> As runtime services are not enabled at this time, full generic early ioremap
> support is also not added in this series.
>
> Patch 4 and 5 adds the PE/COFF header and EFI stub code support for RISC-V
> respectively.
>
> The patches can also be found in following git repo.
>
> https://github.com/atishp04/linux/tree/wip_uefi_riscv_v3
>
> The patches have been verified on Qemu using bootefi command in U-Boot.
>
> Changes from v2->v3:
> 1. Rebased on top of latest efi patches.
> 2. Improved handle_kernel_image().
>
> Changes from v1->v2:
> 1. Rebased on 5.7-rc1.
> 2. Fixed minor typos and removed redundant macros/comments.
>
> Changes from previous version:
> 1. Renamed to the generic efi stub macro.
> 2. Address all redundant comments.
> 3. Supported EFI kernel image with normal booti command.
> 4. Removed runtime service related macro defines.
>
> Atish Patra (5):
> efi: Move arm-stub to a common file
> include: pe.h: Add RISC-V related PE definition
> RISC-V: Define fixmap bindings for generic early ioremap support
> RISC-V: Add PE/COFF header for EFI stub
> RISC-V: Add EFI stub support.
>

I had some comments regarding patch #5, but the other ones look fine.

Given that there are two series in flight now that touch the same
code, I am going to merge the patches #1 and #2 of this series into
efi/next.

Once the remaining changes are good to go, I can take them as well,
but I'll need one of the RISC-V maintainers to ack them first.


> arch/arm/Kconfig                              |   2 +-
> arch/arm64/Kconfig                            |   2 +-
> arch/riscv/Kconfig                            |  21 ++++
> arch/riscv/Makefile                           |   1 +
> arch/riscv/configs/defconfig                  |   1 +
> arch/riscv/include/asm/Kbuild                 |   1 +
> arch/riscv/include/asm/efi.h                  |  44 +++++++
> arch/riscv/include/asm/fixmap.h               |  18 +++
> arch/riscv/include/asm/io.h                   |   1 +
> arch/riscv/include/asm/sections.h             |  13 ++
> arch/riscv/kernel/Makefile                    |   4 +
> arch/riscv/kernel/efi-header.S                |  99 ++++++++++++++++
> arch/riscv/kernel/head.S                      |  16 +++
> arch/riscv/kernel/image-vars.h                |  53 +++++++++
> arch/riscv/kernel/vmlinux.lds.S               |  20 +++-
> drivers/firmware/efi/Kconfig                  |   4 +-
> drivers/firmware/efi/libstub/Makefile         |  19 ++-
> .../efi/libstub/{arm-stub.c => efi-stub.c}    |   0
> drivers/firmware/efi/libstub/riscv-stub.c     | 111 ++++++++++++++++++
> include/linux/pe.h                            |   3 +
> 20 files changed, 421 insertions(+), 12 deletions(-)
> create mode 100644 arch/riscv/include/asm/efi.h
> create mode 100644 arch/riscv/include/asm/sections.h
> create mode 100644 arch/riscv/kernel/efi-header.S
> create mode 100644 arch/riscv/kernel/image-vars.h
> rename drivers/firmware/efi/libstub/{arm-stub.c => efi-stub.c} (100%)
> create mode 100644 drivers/firmware/efi/libstub/riscv-stub.c
>
> --
> 2.24.0
>
