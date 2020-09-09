Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F9B9262469
	for <lists+linux-efi@lfdr.de>; Wed,  9 Sep 2020 03:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbgIIBQ0 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 8 Sep 2020 21:16:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726369AbgIIBQZ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 8 Sep 2020 21:16:25 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F48EC061573
        for <linux-efi@vger.kernel.org>; Tue,  8 Sep 2020 18:16:25 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id mm21so484819pjb.4
        for <linux-efi@vger.kernel.org>; Tue, 08 Sep 2020 18:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=WKRHwoOXDB0eVxHsEx1hEwul9R96gJI8i23WjxeBUv4=;
        b=N+faQGtb5z/kpBr6cK9HpGcuHd/PRIAcnn0uA4S696hx/DS3h8Z7bnS7D4HkAZQM94
         PsD973LgzmyAHTE96aXTyEpgHnABhDLQqeYJ8ff/6GbOQyHHaU1cfFS7/grlehP35Nkw
         x+1glZpTufy+LancD47T2XLiGKIlIJGyAPNlocg4A1pBy55iwQxTBWAGFz89yZU83rVO
         BCSxC7XayDD6jxSVhoiI0m15SXT/JashZTDbvk7H//oYrR0n6K1//rs+TSQ0XMGzVo6i
         9oCMELHf/cgSwqDoNmcMUL1Um05qn1EBRfDdXyXeQAUjRUVkGqcamieo1jPVtDzQeJPw
         5ytQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=WKRHwoOXDB0eVxHsEx1hEwul9R96gJI8i23WjxeBUv4=;
        b=kk9ElKdF1DdG6PnzqWYnnLPX1a3t9cQ0YyyMpBqf3hhzlQwbxqgdXeOHngWHnhW3hd
         +vW2LF0Ph+agr9d7S+blGdhmrraF/30Hti7a777mJzhgVzjxox/CBeN9GgbuUuTQ6Pk1
         2AKaQS+e2BYftTyYzUyQvo2rGmd34DrP4uTN6ua4Rl2gbQBzEo+VbgXI5G5OTZHVA8AC
         0uCV4DohrYqihZU466Nr88NSOTsxeBzxmdh5E2CSxeTDIZtGlhPaoxD8WY3sdLo1SMjh
         7FYS1RwvpQ5zd6y+P8yITE3P1gsamw2VcOijdlRTMk1LI5XB8odLahp3SZXFKa3fFjTF
         SC6A==
X-Gm-Message-State: AOAM530nIjB1BV0eRtuqRQC/Qkvm1PflyS+xr/P5EVR4ZXZaIXPrQZ3c
        0j+4FhPuQORfG18O6p9Dd3vCNg==
X-Google-Smtp-Source: ABdhPJy/9leJGa7TnkJIpm8WIUaUh9K2uzM/7yfpXsWuGYRpDPK1wPDcY30nnNawzoMMMgoyVcTiQw==
X-Received: by 2002:a17:90b:4acf:: with SMTP id mh15mr1330512pjb.204.1599614184277;
        Tue, 08 Sep 2020 18:16:24 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id z9sm595153pfk.118.2020.09.08.18.16.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 18:16:23 -0700 (PDT)
Date:   Tue, 08 Sep 2020 18:16:23 -0700 (PDT)
X-Google-Original-Date: Tue, 08 Sep 2020 18:16:21 PDT (-0700)
Subject:     Re: [PATCH v7 0/9] Add UEFI support for RISC-V
In-Reply-To: <20200828172036.8056-1-atish.patra@wdc.com>
CC:     linux-kernel@vger.kernel.org, Atish Patra <Atish.Patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <Anup.Patel@wdc.com>, nivedita@alum.mit.edu,
        greentime.hu@sifive.com, mingo@kernel.org,
        linux-efi@vger.kernel.org, linux-riscv@lists.infradead.org,
        masahiroy@kernel.org, rppt@kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Atish Patra <Atish.Patra@wdc.com>, ardb@kernel.org
Message-ID: <mhng-755265fc-a7d4-442d-a49c-698914350116@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 28 Aug 2020 10:20:27 PDT (-0700), Atish Patra wrote:
> This series adds UEFI support for RISC-V.
>
> Linux kernel: v5.9-rc2
> U-Boot: v2020.07
> OpenSBI: master
>
> Patch 1-3 are generic riscv feature addition required for UEFI support.
> Patch 4-7 adds the efi stub support for RISC-V which was reviewed few months back.
> https://www.spinics.net/lists/linux-efi/msg19144.html
> Patch 8 just renames arm-init code so that it can be used across different
> architectures.
> Patch 9 adds the runtime services for RISC-V.
>
> The working set of patches can also be found in following git repo.
> https://github.com/atishp04/linux/tree/uefi_riscv_5.10_v7
>
> The patches have been verified on following platforms:
> 1. Qemu (both RV32 & RV64) for the following bootflow
>    OpenSBI->U-Boot->Linux
>    EDK2->Linux
> 2. HiFive unleashed using (RV64) for the following bootflow
>    OpenSBI->U-Boot->Linux
>    EDK2->Linux
>
> Thanks Abner & Daniel for all work done for EDK2.
> The EDK2 instructions are available here.
> https://github.com/JohnAZoidberg/riscv-edk2-docker/
>
> Note:
> 1. Currently, EDK2 RISC-V port doesn't support OVMF package. That's why
> EFI_GENERIC_STUB_INITRD_CMDLINE_LOADER should be enabled to load initrd via
> commandline until OVMF patches are available.
>
> 2. For RV32, maximum allocated memory should be 1G as RISC-V kernel can not map
> beyond 1G of physical memory for RV32.
>
> 3. Runtime services have been verified with fwts on EDK2.
>
> ***********************************************************************
> [root@fedora-riscv ~]# fwts uefirtvariable
> Running 1 tests, results appended to results.log
> Test: UEFI Runtime service variable interface tests.
>   Test UEFI RT service get variable interface.            1 passed
>   Test UEFI RT service get next variable name interface.  4 passed
>   Test UEFI RT service set variable interface.            7 passed, 1 warning
>   Test UEFI RT service query variable info interface.     1 passed
>   Test UEFI RT service variable interface stress test.    2 passed
>   Test UEFI RT service set variable interface stress t..  4 passed
>   Test UEFI RT service query variable info interface s..  1 passed
>   Test UEFI RT service get variable interface, invalid..  5 passed
>   Test UEFI RT variable services supported status.        1 skipped
>
> Test           |Pass |Fail |Abort|Warn |Skip |Info |
> uefirtvariable |   25|     |     |    1|    1|     |
> Total:         |   25|    0|    0|    1|    1|    0|
>
> ***********************************************************************
>
> Changes from v6->v7:
> 1. Fixed build error reported on linux-next for patch2.
>
> Changes from v5->v6:
> 1. Fixed the static declaration for pt_ops.
> 2. Added Reviewed/Acked-by.
>
> Changes from v4->v5:
> 1. Late mappings allocations are now done through function pointers.
> 2. EFI run time services are verified using full linux boot and fwts using EDK2.
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
> arch/riscv/include/asm/efi.h                  |  56 +++++
> arch/riscv/include/asm/fixmap.h               |  16 +-
> arch/riscv/include/asm/io.h                   |   1 +
> arch/riscv/include/asm/mmu.h                  |   2 +
> arch/riscv/include/asm/pgtable.h              |   5 +
> arch/riscv/include/asm/sections.h             |  13 ++
> arch/riscv/kernel/Makefile                    |   5 +
> arch/riscv/kernel/efi-header.S                | 104 ++++++++++
> arch/riscv/kernel/efi.c                       | 105 ++++++++++
> arch/riscv/kernel/head.S                      |  17 +-
> arch/riscv/kernel/head.h                      |   2 -
> arch/riscv/kernel/image-vars.h                |  51 +++++
> arch/riscv/kernel/setup.c                     |  18 +-
> arch/riscv/kernel/vmlinux.lds.S               |  22 +-
> arch/riscv/mm/init.c                          | 191 +++++++++++++-----
> arch/riscv/mm/ptdump.c                        |  48 ++++-
> drivers/firmware/efi/Kconfig                  |   3 +-
> drivers/firmware/efi/Makefile                 |   4 +-
> .../firmware/efi/{arm-init.c => efi-init.c}   |   0
> drivers/firmware/efi/libstub/Makefile         |  10 +
> drivers/firmware/efi/libstub/efi-stub.c       |  11 +-
> drivers/firmware/efi/libstub/riscv-stub.c     | 110 ++++++++++
> drivers/firmware/efi/riscv-runtime.c          | 143 +++++++++++++
> include/linux/pe.h                            |   3 +
> 28 files changed, 901 insertions(+), 67 deletions(-)
> create mode 100644 arch/riscv/include/asm/efi.h
> create mode 100644 arch/riscv/include/asm/sections.h
> create mode 100644 arch/riscv/kernel/efi-header.S
> create mode 100644 arch/riscv/kernel/efi.c
> create mode 100644 arch/riscv/kernel/image-vars.h
> rename drivers/firmware/efi/{arm-init.c => efi-init.c} (100%)
> create mode 100644 drivers/firmware/efi/libstub/riscv-stub.c
> create mode 100644 drivers/firmware/efi/riscv-runtime.c

Thanks.  I've also got the tag "riscv-for-efi-5.10", which consists of

    6bf710098245 ("efi: Rename arm-init to efi-init common for all arch")
    f7305a30f0ec ("include: pe.h: Add RISC-V related PE definition")
    d012a7190fc1 ("Linux 5.9-rc2")

and is the base of my for-next.  The rest of the patches are also on for-next,
but quite a bit later.

Ard: IIUC that's what you were looking for?  Those two as-is definately aren't
going to break bisecting, so I think we should be good to start both of our
for-next branches there.  LMK if you were looking for something else.
