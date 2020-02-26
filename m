Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5AF5170CBB
	for <lists+linux-efi@lfdr.de>; Thu, 27 Feb 2020 00:46:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728002AbgBZXqr (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 26 Feb 2020 18:46:47 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:54264 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728000AbgBZXqr (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 26 Feb 2020 18:46:47 -0500
Received: by mail-pj1-f65.google.com with SMTP id n96so316918pjc.3
        for <linux-efi@vger.kernel.org>; Wed, 26 Feb 2020 15:46:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=djIEdw8ANY4/stYcNyUCAg5bxeUx1iW05K2PCbQB4Xc=;
        b=Rlo5nx1PTAUXVDdYpnFkNekd6vje9me0Nm7R730e9zCmt5GtcTe5XP9GmY0rK3VPs5
         R0mrUtX4uqglI8t5qJBY3Ogq71BMF9m7bsFlJwoc/ASOMh6faKy9Ji11Ic/mVKRScJDr
         0LpMXMR90KpXWn9xhhriMUfVzC2NDGQJfG9IesjzKbVn0wM1b1t2dByUF/bPtk3g2IP+
         Gpm+kA12aw4OcOGZIwe6eQLBulL39GVFyULVOWUwNffMHvDF+sujWXAiSsQiPNE/l2Le
         8YPeLpER5zuZ9kH0QxbhpadmGnDYlRe8bwNyQqOBT5mwLATP6OiOUZLvlKZvr/sgW49B
         6mdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=djIEdw8ANY4/stYcNyUCAg5bxeUx1iW05K2PCbQB4Xc=;
        b=eIoL6aNfqXOUsml6MD5Pt3DRSzmEOdsqP+nwADA3OKUneIh1j1KAXoB+xvzuX+DHtP
         vz7MU8GJSetu5FpdA0vmiKqL5Uc+tjJTOO0m3aKImnqZrboCEvS//5vKhyV1XJPDosj3
         mw+3FnrMvSaZRvnzfU9pJ5d6ofjlaBttS/EkrfDtMdN2VwqnLWEduZy5i36z54S90O+D
         8M63W+NS6Am5UMq0a6LkzstTd/prgSc73PO2U+YKgheCLp4EcxQZA5jM6PjucrSbReT4
         fCxQMaCIHF0nmuBSEu4VTrWZmzoNVSO6Ang69n5P/uOmlrHFaxCLoPVUjxWtdVtLmlv1
         QJtg==
X-Gm-Message-State: APjAAAXisjYZzaHEG8Is0B3VM7WOFcZpBIXa5hApE3bLJa2uJ3Wq5KK3
        xWiCTC/h3EeTxIDIsyhG77B83A==
X-Google-Smtp-Source: APXvYqyeVQ8XiDhAtqRUbnJkvFlHHgzMPuVzSBSmWD0fYGVoMGMWw1rbT6oPGBkTZmrNxnWabwZ6Pw==
X-Received: by 2002:a17:902:6ac7:: with SMTP id i7mr1671228plt.314.1582760805540;
        Wed, 26 Feb 2020 15:46:45 -0800 (PST)
Received: from localhost ([2620:0:1000:2514:23a5:d584:6a92:3e3c])
        by smtp.gmail.com with ESMTPSA id q6sm4185715pfh.127.2020.02.26.15.46.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 15:46:44 -0800 (PST)
Date:   Wed, 26 Feb 2020 15:46:44 -0800 (PST)
X-Google-Original-Date: Wed, 26 Feb 2020 15:46:36 PST (-0800)
Subject:     Re: [RFC PATCH 0/5] Add UEFI support for RISC-V 
In-Reply-To: <20200226011037.7179-1-atish.patra@wdc.com>
CC:     linux-kernel@vger.kernel.org, Atish Patra <Atish.Patra@wdc.com>,
        aou@eecs.berkeley.edu, alexios.zavras@intel.com,
        allison@lohutok.net, akpm@linux-foundation.org,
        Anup Patel <Anup.Patel@wdc.com>, ardb@kernel.org,
        Arnd Bergmann <arnd@arndb.de>, bp@suse.de,
        catalin.marinas@arm.com, greentime.hu@sifive.com,
        Greg KH <gregkh@linuxfoundation.org>, mingo@kernel.org,
        kstewart@linuxfoundation.org, keescook@chromium.org,
        linus.walleij@linaro.org, linux-efi@vger.kernel.org,
        linux-riscv@lists.infradead.org, han_mao@c-sky.com,
        mchehab+samsung@kernel.org, michal.simek@xilinx.com,
        rppt@linux.ibm.com, pbonzini@redhat.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux@armlinux.org.uk, tglx@linutronix.de, will@kernel.org,
        agraf@csgraf.de, leif@nuviainc.com, abner.chang@hpe.com,
        daniel.schaefer@hpe.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Atish Patra <Atish.Patra@wdc.com>
Message-ID: <mhng-2fe6e2a0-9291-4810-b42c-af69b8dbaa06@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 25 Feb 2020 17:10:32 PST (-0800), Atish Patra wrote:
> This series adds UEFI support for RISC-V. Currently, only boot time
> services have been added. Runtime services will be added in a separate
> series. This series depends on some core EFI patches
> present in current in efi-next and following other patches.
>
> U-Boot: Adds the boot hartid under chosen node.
> https://lists.denx.de/pipermail/u-boot/2020-February/401227.html
>
> Linux kernel: SBI v0.2 and HSM extension support. This series is a mandatory
> pre-requisite for UEFI support as only single core can boot EFI stub and
> Linux via UEFI. All other cores are brought up using SBI HSM extension.
> http://lists.infradead.org/pipermail/linux-riscv/2020-February/008513.html
>
> OpenSBI: master (commit: ge3f69fc1e934)
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
> https://github.com/atishp04/linux/tree/wip_uefi_riscv
>
> The patches have been verified on Qemu using bootefi command in U-Boot.
> Here is a boot log.
>
> Atish Patra (5):
> efi: Move arm-stub to a common file
> include: pe.h: Add RISC-V related PE definition
> RISC-V: Define fixmap bindings for generic early ioremap support
> RISC-V: Add PE/COFF header for EFI stub
> RISC-V: Add EFI stub support.
>
> arch/arm/Kconfig                              |   2 +-
> arch/arm64/Kconfig                            |   2 +-
> arch/riscv/Kconfig                            |  21 +++
> arch/riscv/Makefile                           |   1 +
> arch/riscv/configs/defconfig                  |   1 +
> arch/riscv/include/asm/Kbuild                 |   2 +-
> arch/riscv/include/asm/fixmap.h               |  21 ++-
> arch/riscv/include/asm/io.h                   |   1 +
> arch/riscv/include/asm/sections.h             |  13 ++
> arch/riscv/kernel/Makefile                    |   4 +
> arch/riscv/kernel/efi-header.S                | 107 ++++++++++++++
> arch/riscv/kernel/head.S                      |  15 ++
> arch/riscv/kernel/image-vars.h                |  52 +++++++
> arch/riscv/kernel/vmlinux.lds.S               |  27 +++-
> drivers/firmware/efi/Kconfig                  |   6 +-
> drivers/firmware/efi/libstub/Makefile         |  20 ++-
> .../efi/libstub/{arm-stub.c => efi-stub.c}    |   7 +-
> drivers/firmware/efi/libstub/riscv-stub.c     | 135 ++++++++++++++++++
> include/linux/pe.h                            |   3 +
> 19 files changed, 420 insertions(+), 20 deletions(-)
> create mode 100644 arch/riscv/include/asm/sections.h
> create mode 100644 arch/riscv/kernel/efi-header.S
> create mode 100644 arch/riscv/kernel/image-vars.h
> rename drivers/firmware/efi/libstub/{arm-stub.c => efi-stub.c} (98%)
> create mode 100644 drivers/firmware/efi/libstub/riscv-stub.c

I'm in favor of adding EFI support, and I'd rather have it sooner than later so
we don't paint ourselves into a corner.  I'm not sure what happened to the
RISC-V EFI spec process, though, which would be my only worry here (also I
haven't looked at the code :)).  Do we have enough of a spec through the EFI
process that this is all kosher on their end?

Given that this definately isn't for these RCs, I'm going to leave it in my
review queue.  It might be best to get the "move stuff to generic" work merged
on its own, as then we can carry less diff around.

Thanks!
