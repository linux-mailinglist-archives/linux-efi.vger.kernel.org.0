Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46C301B1FB8
	for <lists+linux-efi@lfdr.de>; Tue, 21 Apr 2020 09:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbgDUHYR (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 21 Apr 2020 03:24:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:37316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726563AbgDUHYR (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 21 Apr 2020 03:24:17 -0400
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 53C392098B;
        Tue, 21 Apr 2020 07:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587453856;
        bh=6zceOSWqwAhK0DKj/24rioNk8lT8HlLw+8jDXzMcwu4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZhKfsthw72RYzNNwt/UQWcOXo5c6OTyhBhIs+q+IZ3lQ/X8hwX/9GVV9KVKGKdZky
         ttGLRzjR4PGtnOMUEmEfP+DmkjqbBPpl981HAjr8bk/B7mpWg9hKApfYRHTpQkv5AW
         BStXSzf/nkAbo2uRyrnWwz4e7+4yyxwy1oL+CkS8=
Received: by mail-io1-f44.google.com with SMTP id e9so6400830iok.9;
        Tue, 21 Apr 2020 00:24:16 -0700 (PDT)
X-Gm-Message-State: AGi0PuZNdlRl8s9C8tY0PgIUVtU1EdjsEOa/xLb2FrDVYKoGjU4lBh2W
        o9o6pQLc878b84H/x6abWcP3fYpmAlbcR8ftS4A=
X-Google-Smtp-Source: APiQypLLHbqrAD1vb/WetErR87p9iw/49ROjWxRdn0kjV+DQlfDNrQQnbn+LbFZuM8xMBV08/FbGIw1Y0KIeou/Aw6Y=
X-Received: by 2002:a6b:5904:: with SMTP id n4mr19828247iob.142.1587453855746;
 Tue, 21 Apr 2020 00:24:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200421033336.9663-1-atish.patra@wdc.com>
In-Reply-To: <20200421033336.9663-1-atish.patra@wdc.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 21 Apr 2020 09:24:04 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEXTq8RhD-AM4i3ZmXRcLDTW8waNDbWNa0V8V1nz4zb_A@mail.gmail.com>
Message-ID: <CAMj1kXEXTq8RhD-AM4i3ZmXRcLDTW8waNDbWNa0V8V1nz4zb_A@mail.gmail.com>
Subject: Re: [v4 PATCH 0/3] Add UEFI support for RISC-V
To:     Atish Patra <atish.patra@wdc.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 21 Apr 2020 at 05:34, Atish Patra <atish.patra@wdc.com> wrote:
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
> https://github.com/atishp04/linux/tree/wip_uefi_riscv_v4
>
> The patches have been verified on Qemu using bootefi command in U-Boot.
>
> Changes from v3->v4:
> 1. Rebased on top of efi-next.
> 2. Dropped patch 1 & 2 from this series as it is already queued in efi-next.
> Changes from v2->v3:
> 3. Improved handle_kernel_image() for RISC-V.
>

Thanks Atish. This looks nice and simple now.

I will need an ack from the RISC-V maintainers on these, and it is up
to them to consider whether the changes to core kconfigs and makefiles
are likely to cause trouble or not. If so, I am happy to work out a
way to merge this via a shared stable branch.



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
> Atish Patra (3):
> RISC-V: Define fixmap bindings for generic early ioremap support
> RISC-V: Add PE/COFF header for EFI stub
> RISC-V: Add EFI stub support.
>
> arch/riscv/Kconfig                        |  21 +++++
> arch/riscv/Makefile                       |   1 +
> arch/riscv/configs/defconfig              |   1 +
> arch/riscv/include/asm/Kbuild             |   1 +
> arch/riscv/include/asm/efi.h              |  44 +++++++++
> arch/riscv/include/asm/fixmap.h           |  18 ++++
> arch/riscv/include/asm/io.h               |   1 +
> arch/riscv/include/asm/sections.h         |  13 +++
> arch/riscv/kernel/Makefile                |   4 +
> arch/riscv/kernel/efi-header.S            |  99 ++++++++++++++++++++
> arch/riscv/kernel/head.S                  |  16 ++++
> arch/riscv/kernel/image-vars.h            |  53 +++++++++++
> arch/riscv/kernel/vmlinux.lds.S           |  20 +++-
> drivers/firmware/efi/Kconfig              |   2 +-
> drivers/firmware/efi/libstub/Makefile     |  10 ++
> drivers/firmware/efi/libstub/riscv-stub.c | 106 ++++++++++++++++++++++
> 16 files changed, 407 insertions(+), 3 deletions(-)
> create mode 100644 arch/riscv/include/asm/efi.h
> create mode 100644 arch/riscv/include/asm/sections.h
> create mode 100644 arch/riscv/kernel/efi-header.S
> create mode 100644 arch/riscv/kernel/image-vars.h
> create mode 100644 drivers/firmware/efi/libstub/riscv-stub.c
>
> --
> 2.24.0
>
