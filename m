Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D28D62346D2
	for <lists+linux-efi@lfdr.de>; Fri, 31 Jul 2020 15:26:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730643AbgGaN0H (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 31 Jul 2020 09:26:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:37756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728252AbgGaN0G (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 31 Jul 2020 09:26:06 -0400
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 84AD522BF3;
        Fri, 31 Jul 2020 13:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596201965;
        bh=kiABRkM+l4ig/cD2nH8sLh6Q2EQZatMUbedijCspTS8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HFIrJcQVIlRxhjRE5g2guG8BBTbB8gcY4mFfzRn6ftJBOOzaKG3r97YkZzZcFqWVp
         C91LyF17sRKj0jnuP0iqt+z5BwQod9BugSBsC+vfz4fkLlcErxySo1ecxhoToH0Fqk
         BO74fjI62dBL1TkQRhoodGL+PUFcPv9hattKw1yQ=
Received: by mail-ot1-f43.google.com with SMTP id l26so6063664otj.4;
        Fri, 31 Jul 2020 06:26:05 -0700 (PDT)
X-Gm-Message-State: AOAM53117CMDtjJHTkpEY1UKjZmCK3IS+pkvOLSyFBOX0uT78rDCNntV
        o5Igst0TboEHK2GAGX7GTBbpen2HKSY7JfIdRyI=
X-Google-Smtp-Source: ABdhPJwqejim9uD7ymbbLYfkTjOqYSs8DwQcIR8vUokBpFtUDjoUc/mptlY54R9ubTh7sxn+dne50wJnW9nGTqi4byY=
X-Received: by 2002:a05:6830:1094:: with SMTP id y20mr2790921oto.90.1596201964770;
 Fri, 31 Jul 2020 06:26:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200729233635.14406-1-atish.patra@wdc.com>
In-Reply-To: <20200729233635.14406-1-atish.patra@wdc.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 31 Jul 2020 16:25:53 +0300
X-Gmail-Original-Message-ID: <CAMj1kXFC-mQRrr+U_HRSzDEYsub-2Gb_F0r1Teh=MB0oJ-de2g@mail.gmail.com>
Message-ID: <CAMj1kXFC-mQRrr+U_HRSzDEYsub-2Gb_F0r1Teh=MB0oJ-de2g@mail.gmail.com>
Subject: Re: [RFT PATCH v4 0/9] Add UEFI support for RISC-V
To:     Atish Patra <atish.patra@wdc.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Anup Patel <anup.patel@wdc.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Greentime Hu <greentime.hu@sifive.com>,
        Ingo Molnar <mingo@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Nick Hu <nickhu@andestech.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        Yash Shah <yash.shah@sifive.com>, Zong Li <zong.li@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 30 Jul 2020 at 02:36, Atish Patra <atish.patra@wdc.com> wrote:
>
> This series adds UEFI support for RISC-V.
>
> Linux kernel: 5.8-rc7 + 1 exception vector setup patch (queued for for-next)
> U-Boot: v2020.07
> OpenSBI: master
>
> This series depends on early setup of exeception vector patch
> http://lists.infradead.org/pipermail/linux-riscv/2020-July/001207.html
>
> Patch 1-3 are generic riscv feature addition required for UEFI support.
> Patch 4-7 adds the efi stub support for RISC-V which was reviewed few months back.
> https://www.spinics.net/lists/linux-efi/msg19144.html
> Patch 8 just renames arm-init code so that it can be used across different
> architectures. Patch 11 adds the runtime services for RISC-V.
>
> The working set of patches can also be found in following git repo.
> https://github.com/atishp04/linux/tree/uefi_riscv_5.9_v4
>


Thanks Atish.

I think these patches have now reached a state where you can stop
sending out new revisions until you have something that works as
expected in combination with EDK2 based firmware that implements  the
UEFI runtime services fully.


> The patches have been verified on Qemu/HiFive unleashed using bootefi command in
> U-Boot for both RV32 and RV64.
>
> For RV32, maximum allocated memory should be 1G as RISC-V kernel can not map
> beyond 1G of physical memory for RV32.
>
> Runtime services have been verified with fwts. Here is the snippet of the result.
>
> ***********************************************************************
> This test run on 16/07/20 at 17:54:53 on host Linux fedora-riscv
> 5.8.0-rc5-00015-g5e61441080fd-dirty #938 SMP Thu Jul 16 14:50:11 PDT 2020
> riscv64.
>
> Command: "fwts uefirtvariable".
> Running tests: uefirtvariable.
>
> uefirtvariable: UEFI Runtime service variable interface tests.
> Test 1 of 9: Test UEFI RT service get variable interface.
> SKIPPED: Test 1, Skipping test, SetVariable runtime service is not supported on
> this platform.
>
> Test 2 of 9: Test UEFI RT service get next variable name interface.
> The runtime service GetNextVariableName interface function test.
> SKIPPED: Test 2, Skipping test, SetVariable runtime service is not supported on
> this platform.
>
> ...
>
> Test 4 of 9: Test UEFI RT service query variable info interface.
> SKIPPED: Test 4, Not support the QueryVariableInfo UEFI runtime interface:
> cannot test.
>
> ADVICE: Firmware also needs to check if the revision of system table is correct
> or not. Linux kernel returns EFI_UNSUPPORTED as well, if the FirmwareRevision of
> system table is less than EFI_2_00_SYSTEM_TABLE_REVISION.
>
> ...
> ***********************************************************************
>
> Currently, U-Boot EFI implementation returns EFI_UNSUPPORTED for set_variable
> service. That's why all tests have been skipped but I manually verified that the
> value is returned from U-Boot not kernel :).
>
> EDK2 can boot quite far into Linux with the current series. However, it crashes
> before userspace because of a possible memory corruption by EDK2.
>
> Changes from v3->v4:
> 1. Used pgd mapping to avoid copying DT to bss.
>
> Changes from v2->v3:
> 1. Fixed few bugs in run time services page table mapping.
> 2. Dropped patch 1 as it is already taken into efi-tree.
> 3. Sent few generic mmu fixes as a separate series to ease the merge conflicts.
>
> Changes from v1->v2:
> 1. Removed patch 1 as it is already taken into efi-tree.
> 2. Fixed compilation issues with patch 9.
> 3. Moved few function prototype declaration to header file to keep kbuild happy.
>
> Changes from previous version:
> 1. Added full ioremap support.
> 2. Added efi runtime services support.
> 3. Fixes mm issues
>
> Anup Patel (1):
> RISC-V: Move DT mapping outof fixmap
>
> Atish Patra (8):
> RISC-V: Add early ioremap support
> RISC-V: Implement late mapping page table allocation functions
> include: pe.h: Add RISC-V related PE definition
> RISC-V: Add PE/COFF header for EFI stub
> RISC-V: Add EFI stub support.
> efi: Rename arm-init to efi-init common for all arch
> RISC-V: Add EFI runtime services
> RISC-V: Add page table dump support for uefi
>
> arch/riscv/Kconfig                            |  25 +++
> arch/riscv/Makefile                           |   1 +
> arch/riscv/configs/defconfig                  |   1 +
> arch/riscv/include/asm/Kbuild                 |   1 +
> arch/riscv/include/asm/efi.h                  |  56 +++++++
> arch/riscv/include/asm/fixmap.h               |  16 +-
> arch/riscv/include/asm/io.h                   |   1 +
> arch/riscv/include/asm/mmu.h                  |   2 +
> arch/riscv/include/asm/pgtable.h              |   5 +
> arch/riscv/include/asm/sections.h             |  13 ++
> arch/riscv/kernel/Makefile                    |   5 +
> arch/riscv/kernel/efi-header.S                | 104 +++++++++++++
> arch/riscv/kernel/efi.c                       | 105 +++++++++++++
> arch/riscv/kernel/head.S                      |  17 ++-
> arch/riscv/kernel/head.h                      |   2 -
> arch/riscv/kernel/image-vars.h                |  51 +++++++
> arch/riscv/kernel/setup.c                     |  17 ++-
> arch/riscv/kernel/vmlinux.lds.S               |  22 ++-
> arch/riscv/mm/init.c                          |  90 ++++++++---
> arch/riscv/mm/ptdump.c                        |  48 +++++-
> drivers/firmware/efi/Kconfig                  |   3 +-
> drivers/firmware/efi/Makefile                 |   4 +-
> .../firmware/efi/{arm-init.c => efi-init.c}   |   0
> drivers/firmware/efi/libstub/Makefile         |  10 ++
> drivers/firmware/efi/libstub/efi-stub.c       |  11 +-
> drivers/firmware/efi/libstub/riscv-stub.c     | 110 ++++++++++++++
> drivers/firmware/efi/riscv-runtime.c          | 143 ++++++++++++++++++
> include/linux/pe.h                            |   3 +
> 28 files changed, 825 insertions(+), 41 deletions(-)
> create mode 100644 arch/riscv/include/asm/efi.h
> create mode 100644 arch/riscv/include/asm/sections.h
> create mode 100644 arch/riscv/kernel/efi-header.S
> create mode 100644 arch/riscv/kernel/efi.c
> create mode 100644 arch/riscv/kernel/image-vars.h
> rename drivers/firmware/efi/{arm-init.c => efi-init.c} (100%)
> create mode 100644 drivers/firmware/efi/libstub/riscv-stub.c
> create mode 100644 drivers/firmware/efi/riscv-runtime.c
>
> --
> 2.24.0
>
