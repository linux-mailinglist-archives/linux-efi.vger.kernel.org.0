Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 464C62628B0
	for <lists+linux-efi@lfdr.de>; Wed,  9 Sep 2020 09:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725864AbgIIH3i (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 9 Sep 2020 03:29:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:42028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725922AbgIIH3f (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 9 Sep 2020 03:29:35 -0400
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 505EC21D80;
        Wed,  9 Sep 2020 07:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599636574;
        bh=YTjibJJgcTMrv+eyJ7e8ROuPqmNOZQrNBZ1Olqx36VA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=vomabbUdlBUZCb5hWdG3jTmcOKZWOqZW/KEMslFPeytqmYVHqCSK5j3fVVSpoPYhg
         VWdGS4UzTTXxXpO01yleS3Nkz9jTEL29ycjTKfPaWKq0ILd22IIVMZasaefqhyr4gL
         YQJXK/C4Z5aW9Q69E8gSSOuauhB0Uf07oogBbYLE=
Received: by mail-oo1-f41.google.com with SMTP id 4so346822ooh.11;
        Wed, 09 Sep 2020 00:29:34 -0700 (PDT)
X-Gm-Message-State: AOAM532JkmqxLl5LIH0CZDryFG5Jjy3FoRQEDh5vKVCz2eltrYDgZrZK
        +9h8+8mAHHLCFUT1GnkLlqSHd5UhNcq6+3AtxjU=
X-Google-Smtp-Source: ABdhPJz8CHoTy/4ozaB74PFoPx5NTfNI2VB50LmNes0q+PYB7j3+VKj02l78mhwpgGCX8YDM4zdCyUcnGaOW4uPk4E4=
X-Received: by 2002:a4a:b443:: with SMTP id h3mr1810033ooo.45.1599636573457;
 Wed, 09 Sep 2020 00:29:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200828172036.8056-1-atish.patra@wdc.com> <mhng-755265fc-a7d4-442d-a49c-698914350116@palmerdabbelt-glaptop1>
In-Reply-To: <mhng-755265fc-a7d4-442d-a49c-698914350116@palmerdabbelt-glaptop1>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 9 Sep 2020 10:29:22 +0300
X-Gmail-Original-Message-ID: <CAMj1kXHp6JFRL7tgy5yMt2=_9OMbKHy16rzunpqhJ8t_sUnwzQ@mail.gmail.com>
Message-ID: <CAMj1kXHp6JFRL7tgy5yMt2=_9OMbKHy16rzunpqhJ8t_sUnwzQ@mail.gmail.com>
Subject: Re: [PATCH v7 0/9] Add UEFI support for RISC-V
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Atish Patra <Atish.Patra@wdc.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <Anup.Patel@wdc.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Greentime Hu <greentime.hu@sifive.com>,
        Ingo Molnar <mingo@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 9 Sep 2020 at 04:16, Palmer Dabbelt <palmer@dabbelt.com> wrote:
>
> On Fri, 28 Aug 2020 10:20:27 PDT (-0700), Atish Patra wrote:
> > This series adds UEFI support for RISC-V.
> >
> > Linux kernel: v5.9-rc2
> > U-Boot: v2020.07
> > OpenSBI: master
> >
> > Patch 1-3 are generic riscv feature addition required for UEFI support.
> > Patch 4-7 adds the efi stub support for RISC-V which was reviewed few months back.
> > https://www.spinics.net/lists/linux-efi/msg19144.html
> > Patch 8 just renames arm-init code so that it can be used across different
> > architectures.
> > Patch 9 adds the runtime services for RISC-V.
> >
> > The working set of patches can also be found in following git repo.
> > https://github.com/atishp04/linux/tree/uefi_riscv_5.10_v7
> >
> > The patches have been verified on following platforms:
> > 1. Qemu (both RV32 & RV64) for the following bootflow
> >    OpenSBI->U-Boot->Linux
> >    EDK2->Linux
> > 2. HiFive unleashed using (RV64) for the following bootflow
> >    OpenSBI->U-Boot->Linux
> >    EDK2->Linux
> >
> > Thanks Abner & Daniel for all work done for EDK2.
> > The EDK2 instructions are available here.
> > https://github.com/JohnAZoidberg/riscv-edk2-docker/
> >
> > Note:
> > 1. Currently, EDK2 RISC-V port doesn't support OVMF package. That's why
> > EFI_GENERIC_STUB_INITRD_CMDLINE_LOADER should be enabled to load initrd via
> > commandline until OVMF patches are available.
> >
> > 2. For RV32, maximum allocated memory should be 1G as RISC-V kernel can not map
> > beyond 1G of physical memory for RV32.
> >
> > 3. Runtime services have been verified with fwts on EDK2.
> >
> > ***********************************************************************
> > [root@fedora-riscv ~]# fwts uefirtvariable
> > Running 1 tests, results appended to results.log
> > Test: UEFI Runtime service variable interface tests.
> >   Test UEFI RT service get variable interface.            1 passed
> >   Test UEFI RT service get next variable name interface.  4 passed
> >   Test UEFI RT service set variable interface.            7 passed, 1 warning
> >   Test UEFI RT service query variable info interface.     1 passed
> >   Test UEFI RT service variable interface stress test.    2 passed
> >   Test UEFI RT service set variable interface stress t..  4 passed
> >   Test UEFI RT service query variable info interface s..  1 passed
> >   Test UEFI RT service get variable interface, invalid..  5 passed
> >   Test UEFI RT variable services supported status.        1 skipped
> >
> > Test           |Pass |Fail |Abort|Warn |Skip |Info |
> > uefirtvariable |   25|     |     |    1|    1|     |
> > Total:         |   25|    0|    0|    1|    1|    0|
> >
> > ***********************************************************************
> >
> > Changes from v6->v7:
> > 1. Fixed build error reported on linux-next for patch2.
> >
> > Changes from v5->v6:
> > 1. Fixed the static declaration for pt_ops.
> > 2. Added Reviewed/Acked-by.
> >
> > Changes from v4->v5:
> > 1. Late mappings allocations are now done through function pointers.
> > 2. EFI run time services are verified using full linux boot and fwts using EDK2.
> >
> > Changes from v3->v4:
> > 1. Used pgd mapping to avoid copying DT to bss.
> >
> > Changes from v2->v3:
> > 1. Fixed few bugs in run time services page table mapping.
> > 2. Dropped patch 1 as it is already taken into efi-tree.
> > 3. Sent few generic mmu fixes as a separate series to ease the merge conflicts.
> >
> > Changes from v1->v2:
> > 1. Removed patch 1 as it is already taken into efi-tree.
> > 2. Fixed compilation issues with patch 9.
> > 3. Moved few function prototype declaration to header file to keep kbuild happy.
> >
> > Changes from previous version:
> > 1. Added full ioremap support.
> > 2. Added efi runtime services support.
> > 3. Fixes mm issues
> >
> > Anup Patel (1):
> > RISC-V: Move DT mapping outof fixmap
> >
> > Atish Patra (8):
> > RISC-V: Add early ioremap support
> > RISC-V: Implement late mapping page table allocation functions
> > include: pe.h: Add RISC-V related PE definition
> > RISC-V: Add PE/COFF header for EFI stub
> > RISC-V: Add EFI stub support.
> > efi: Rename arm-init to efi-init common for all arch
> > RISC-V: Add EFI runtime services
> > RISC-V: Add page table dump support for uefi
> >
> > arch/riscv/Kconfig                            |  25 +++
> > arch/riscv/Makefile                           |   1 +
> > arch/riscv/configs/defconfig                  |   1 +
> > arch/riscv/include/asm/Kbuild                 |   1 +
> > arch/riscv/include/asm/efi.h                  |  56 +++++
> > arch/riscv/include/asm/fixmap.h               |  16 +-
> > arch/riscv/include/asm/io.h                   |   1 +
> > arch/riscv/include/asm/mmu.h                  |   2 +
> > arch/riscv/include/asm/pgtable.h              |   5 +
> > arch/riscv/include/asm/sections.h             |  13 ++
> > arch/riscv/kernel/Makefile                    |   5 +
> > arch/riscv/kernel/efi-header.S                | 104 ++++++++++
> > arch/riscv/kernel/efi.c                       | 105 ++++++++++
> > arch/riscv/kernel/head.S                      |  17 +-
> > arch/riscv/kernel/head.h                      |   2 -
> > arch/riscv/kernel/image-vars.h                |  51 +++++
> > arch/riscv/kernel/setup.c                     |  18 +-
> > arch/riscv/kernel/vmlinux.lds.S               |  22 +-
> > arch/riscv/mm/init.c                          | 191 +++++++++++++-----
> > arch/riscv/mm/ptdump.c                        |  48 ++++-
> > drivers/firmware/efi/Kconfig                  |   3 +-
> > drivers/firmware/efi/Makefile                 |   4 +-
> > .../firmware/efi/{arm-init.c => efi-init.c}   |   0
> > drivers/firmware/efi/libstub/Makefile         |  10 +
> > drivers/firmware/efi/libstub/efi-stub.c       |  11 +-
> > drivers/firmware/efi/libstub/riscv-stub.c     | 110 ++++++++++
> > drivers/firmware/efi/riscv-runtime.c          | 143 +++++++++++++
> > include/linux/pe.h                            |   3 +
> > 28 files changed, 901 insertions(+), 67 deletions(-)
> > create mode 100644 arch/riscv/include/asm/efi.h
> > create mode 100644 arch/riscv/include/asm/sections.h
> > create mode 100644 arch/riscv/kernel/efi-header.S
> > create mode 100644 arch/riscv/kernel/efi.c
> > create mode 100644 arch/riscv/kernel/image-vars.h
> > rename drivers/firmware/efi/{arm-init.c => efi-init.c} (100%)
> > create mode 100644 drivers/firmware/efi/libstub/riscv-stub.c
> > create mode 100644 drivers/firmware/efi/riscv-runtime.c
>
> Thanks.  I've also got the tag "riscv-for-efi-5.10", which consists of
>
>     6bf710098245 ("efi: Rename arm-init to efi-init common for all arch")
>     f7305a30f0ec ("include: pe.h: Add RISC-V related PE definition")
>     d012a7190fc1 ("Linux 5.9-rc2")
>
> and is the base of my for-next.  The rest of the patches are also on for-next,
> but quite a bit later.
>
> Ard: IIUC that's what you were looking for?  Those two as-is definately aren't
> going to break bisecting, so I think we should be good to start both of our
> for-next branches there.  LMK if you were looking for something else.

Yeah that looks fine.
