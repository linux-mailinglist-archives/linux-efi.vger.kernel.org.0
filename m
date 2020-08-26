Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E5DB2534D5
	for <lists+linux-efi@lfdr.de>; Wed, 26 Aug 2020 18:27:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbgHZQ13 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 26 Aug 2020 12:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726990AbgHZQ1Z (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 26 Aug 2020 12:27:25 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CCA9C061756
        for <linux-efi@vger.kernel.org>; Wed, 26 Aug 2020 09:27:25 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id h2so1132305plr.0
        for <linux-efi@vger.kernel.org>; Wed, 26 Aug 2020 09:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=lJ3G0gTR9+Iw0B9/g5WZ2HvqezgldzfGfwfapbSA23Y=;
        b=l/x8gyc+V7Ew88lbrlQZHFhl/r8ABCsqqNroUrPSvz0jwcRY9jjfgauDPK19wtuAXD
         EILb+Fh9Le9NiEfVwDxkjhtBEgP0KGnz2O/QSUmX9Xt0TPy5ewVPbiYzXEtYSopJnUBK
         NHCNHHhklVNVI2P4Xu2AOuNIUtLDahFHnkS/D1gjbqwDp9+fRNv1aQvKt/1U9jfXgtDI
         idq8bFyRlqs9p7Eleo8upUmSodK8LGZn0+d2GCGaUoLSTtaRxJl+lfQjS0FkzJay2L7s
         2gBxJ5BOmB2ykLvvBeBgswAFjQQ9FJLuLj7GfEiv8IpqEPtcgl2wwOrEvhSAfrQ2GMcl
         t5dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=lJ3G0gTR9+Iw0B9/g5WZ2HvqezgldzfGfwfapbSA23Y=;
        b=bEDqax/M6HnFv8/cmhvYOc4YOSeVGgL59MBwfBXTEeOrCSHZX4lJk78ecX80p3ifHJ
         uJP5eAt+oItlhbTTPMS7Yhrw0hLnitLnWQjt2Id5z+JIJsFfjFJCmjz//nsAGm/lnTCs
         h29zJt9PDiyG2KqhxCt0yRnj5hBQOxjwqv4U1lX4hJ85rnC2XwJO4Z1pVvARvrFl/iti
         gKeEDOR/YuPDtxnkMiSupLHkpMjv7y/uGIcJjG7SsmVnOwbDqkhJV0S7xWuuf//FWlD0
         /p/n9OkrQnqExsbWHNMUGnivIP04Xxfg0WLgLwgugx7s7aA0hi7yaknkZE5PbUMMtlEm
         Si7g==
X-Gm-Message-State: AOAM533rnq1qxPwBoZlfckQunmFbmBN38DwmDW+Q0PL7hQqQMnx+AqxB
        sBxS/F/yfkGkOBd0GWopEWSZny6mALhokGcx
X-Google-Smtp-Source: ABdhPJxvmex3/pI48JqWEpOtzt6q3XJkInaFmpqLe+d+QpfhKT+ODj79oec2SDDm5C6Kmj5RWprrCQ==
X-Received: by 2002:a17:902:6bc2:: with SMTP id m2mr12388170plt.114.1598459244972;
        Wed, 26 Aug 2020 09:27:24 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id q7sm3498303pfl.156.2020.08.26.09.27.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 09:27:24 -0700 (PDT)
Date:   Wed, 26 Aug 2020 09:27:24 -0700 (PDT)
X-Google-Original-Date: Wed, 26 Aug 2020 09:27:22 PDT (-0700)
Subject:     Re: [PATCH v6 0/9] Add UEFI support for RISC-V
In-Reply-To: <CAMj1kXFstJ-hh=+HyNMA_E8eLWZFobrGBcFKFf13OgrHiTce8g@mail.gmail.com>
CC:     Atish Patra <Atish.Patra@wdc.com>, linux-kernel@vger.kernel.org,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <Anup.Patel@wdc.com>, nivedita@alum.mit.edu,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        greentime.hu@sifive.com, hca@linux.ibm.com, mingo@kernel.org,
        keescook@chromium.org, linux-efi@vger.kernel.org,
        linux-riscv@lists.infradead.org, masahiroy@kernel.org,
        michal.simek@xilinx.com, rppt@kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>, steven.price@arm.com,
        longman@redhat.com, zong.li@sifive.com, daniel.schaefer@hpe.com,
        abner.chang@hpe.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     ardb@kernel.org
Message-ID: <mhng-aca02cc6-bb2f-404e-bcdf-e6703e9fc938@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 26 Aug 2020 04:22:07 PDT (-0700), ardb@kernel.org wrote:
> On Tue, 25 Aug 2020 at 20:04, Palmer Dabbelt <palmer@dabbelt.com> wrote:
>>
>> On Wed, 19 Aug 2020 15:24:16 PDT (-0700), Atish Patra wrote:
>> > This series adds UEFI support for RISC-V.
>> >
>> > Linux kernel: v5.9-rc1
>> > U-Boot: v2020.07
>> > OpenSBI: master
>> >
>> > Patch 1-3 are generic riscv feature addition required for UEFI support.
>> > Patch 4-7 adds the efi stub support for RISC-V which was reviewed few months back.
>> > https://www.spinics.net/lists/linux-efi/msg19144.html
>> > Patch 8 just renames arm-init code so that it can be used across different
>> > architectures.
>> > Patch 9 adds the runtime services for RISC-V.
>> >
>> > The working set of patches can also be found in following git repo.
>> > https://github.com/atishp04/linux/tree/uefi_riscv_5.10_v6
>> >
>> > The patches have been verified on following platforms:
>> > 1. Qemu (both RV32 & RV64) for the following bootflow
>> >    OpenSBI->U-Boot->Linux
>> >    EDK2->Linux
>> > 2. HiFive unleashed using (RV64) for the following bootflow
>> >    OpenSBI->U-Boot->Linux
>> >    EDK2->Linux
>> >
>> > Thanks Abner & Daniel for all work done for EDK2.
>> > The EDK2 instructions are available here.
>> > https://github.com/JohnAZoidberg/riscv-edk2-docker/
>> >
>> > Note:
>> > 1. Currently, EDK2 RISC-V port doesn't support OVMF package. That's why
>> > EFI_GENERIC_STUB_INITRD_CMDLINE_LOADER should be enabled to load initrd via
>> > commandline until OVMF patches are available.
>> >
>> > 2. For RV32, maximum allocated memory should be 1G as RISC-V kernel can not map
>> > beyond 1G of physical memory for RV32.
>> >
>> > 3. Runtime services have been verified with fwts on EDK2.
>> >
>> > ***********************************************************************
>> > [root@fedora-riscv ~]# fwts uefirtvariable
>> > Running 1 tests, results appended to results.log
>> > Test: UEFI Runtime service variable interface tests.
>> >   Test UEFI RT service get variable interface.            1 passed
>> >   Test UEFI RT service get next variable name interface.  4 passed
>> >   Test UEFI RT service set variable interface.            7 passed, 1 warning
>> >   Test UEFI RT service query variable info interface.     1 passed
>> >   Test UEFI RT service variable interface stress test.    2 passed
>> >   Test UEFI RT service set variable interface stress t..  4 passed
>> >   Test UEFI RT service query variable info interface s..  1 passed
>> >   Test UEFI RT service get variable interface, invalid..  5 passed
>> >   Test UEFI RT variable services supported status.        1 skipped
>> >
>> > Test           |Pass |Fail |Abort|Warn |Skip |Info |
>> > uefirtvariable |   25|     |     |    1|    1|     |
>> > Total:         |   25|    0|    0|    1|    1|    0|
>> >
>> > ***********************************************************************
>> >
>> > Changes from v5->v6:
>> > 1. Fixed the static declaration for pt_ops.
>> > 2. Added Reviewed/Acked-by.
>> >
>> > Changes from v4->v5:
>> > 1. Late mappings allocations are now done through function pointers.
>> > 2. EFI run time services are verified using full linux boot and fwts using EDK2.
>> >
>> > Changes from v3->v4:
>> > 1. Used pgd mapping to avoid copying DT to bss.
>> >
>> > Changes from v2->v3:
>> > 1. Fixed few bugs in run time services page table mapping.
>> > 2. Dropped patch 1 as it is already taken into efi-tree.
>> > 3. Sent few generic mmu fixes as a separate series to ease the merge conflicts.
>> >
>> > Changes from v1->v2:
>> > 1. Removed patch 1 as it is already taken into efi-tree.
>> > 2. Fixed compilation issues with patch 9.
>> > 3. Moved few function prototype declaration to header file to keep kbuild happy.
>> >
>> > Changes from previous version:
>> > 1. Added full ioremap support.
>> > 2. Added efi runtime services support.
>> > 3. Fixes mm issues
>> >
>> > Anup Patel (1):
>> > RISC-V: Move DT mapping outof fixmap
>> >
>> > Atish Patra (8):
>> > RISC-V: Add early ioremap support
>> > RISC-V: Implement late mapping page table allocation functions
>> > include: pe.h: Add RISC-V related PE definition
>> > RISC-V: Add PE/COFF header for EFI stub
>> > RISC-V: Add EFI stub support.
>> > efi: Rename arm-init to efi-init common for all arch
>> > RISC-V: Add EFI runtime services
>> > RISC-V: Add page table dump support for uefi
>> >
>> > arch/riscv/Kconfig                            |  25 +++
>> > arch/riscv/Makefile                           |   1 +
>> > arch/riscv/configs/defconfig                  |   1 +
>> > arch/riscv/include/asm/Kbuild                 |   1 +
>> > arch/riscv/include/asm/efi.h                  |  56 +++++
>> > arch/riscv/include/asm/fixmap.h               |  16 +-
>> > arch/riscv/include/asm/io.h                   |   1 +
>> > arch/riscv/include/asm/mmu.h                  |   2 +
>> > arch/riscv/include/asm/pgtable.h              |   5 +
>> > arch/riscv/include/asm/sections.h             |  13 ++
>> > arch/riscv/kernel/Makefile                    |   5 +
>> > arch/riscv/kernel/efi-header.S                | 104 ++++++++++
>> > arch/riscv/kernel/efi.c                       | 105 ++++++++++
>> > arch/riscv/kernel/head.S                      |  17 +-
>> > arch/riscv/kernel/head.h                      |   2 -
>> > arch/riscv/kernel/image-vars.h                |  51 +++++
>> > arch/riscv/kernel/setup.c                     |  17 +-
>> > arch/riscv/kernel/vmlinux.lds.S               |  22 +-
>> > arch/riscv/mm/init.c                          | 191 +++++++++++++-----
>> > arch/riscv/mm/ptdump.c                        |  48 ++++-
>> > drivers/firmware/efi/Kconfig                  |   3 +-
>> > drivers/firmware/efi/Makefile                 |   4 +-
>> > .../firmware/efi/{arm-init.c => efi-init.c}   |   0
>> > drivers/firmware/efi/libstub/Makefile         |  10 +
>> > drivers/firmware/efi/libstub/efi-stub.c       |  11 +-
>> > drivers/firmware/efi/libstub/riscv-stub.c     | 110 ++++++++++
>> > drivers/firmware/efi/riscv-runtime.c          | 143 +++++++++++++
>> > include/linux/pe.h                            |   3 +
>> > 28 files changed, 900 insertions(+), 67 deletions(-)
>> > create mode 100644 arch/riscv/include/asm/efi.h
>> > create mode 100644 arch/riscv/include/asm/sections.h
>> > create mode 100644 arch/riscv/kernel/efi-header.S
>> > create mode 100644 arch/riscv/kernel/efi.c
>> > create mode 100644 arch/riscv/kernel/image-vars.h
>> > rename drivers/firmware/efi/{arm-init.c => efi-init.c} (100%)
>> > create mode 100644 drivers/firmware/efi/libstub/riscv-stub.c
>> > create mode 100644 drivers/firmware/efi/riscv-runtime.c
>>
>> I've put these on for-next.  It's still pretty early in the cycle so there's
>> some time to fix stuff up, but it looks like we've pretty much come to
>> consensus on this.
>>
>
> I requested the following when acking these changes:
>
> """
> Note to the maintainer: to the extent possible, please put the patches
> in this series that touch drivers/firmware/efi on a separate branch
> based on v5.9-rc1, and merge that into your for-v5.10 branch at the
> appropriate spot. I don't have anything queued in the EFI tree at the
> moment, and so these changes can happily go through the riscv tree, as
> long as I am not forced to merge a bunch of unrelated changes on the
> off chance that something does come up.
> """
>
> Something has come up, and given that the patch
>
> efi: Rename arm-init to efi-init common for all arch
>
> lives on your for-next branch after a bunch of RISCV changes, I cannot
> merge anything for EFI without pulling all of that into the EFI tree
> as well.
>
> Also, it is not clear to me whether the current ordering does not
> break bisect, given that efi-init.o is referenced in patch #8 but is
> not created until patch #9
>
> So could you please do the following:
>
> - drop 'efi: Rename arm-init to efi-init common for all arch' from the
> top of your for-next branch
> - create a separate topic branch that carries the dropped patch
> - recreate the for-next branch so the topic branch is merged into it
> at the right spot (i.e., before patch #8)
>
> That way, I can merge your topic branch into the EFI tree as well, and
> apply the other EFI changes on top of it.

Sorry, I forgot about that.  I'll go deal with this, but probably not today
because of Plumbers.
