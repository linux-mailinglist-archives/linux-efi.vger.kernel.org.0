Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86A951B2E51
	for <lists+linux-efi@lfdr.de>; Tue, 21 Apr 2020 19:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729130AbgDURaI (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 21 Apr 2020 13:30:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726530AbgDURaI (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 21 Apr 2020 13:30:08 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE3FDC0610D5
        for <linux-efi@vger.kernel.org>; Tue, 21 Apr 2020 10:30:07 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id d17so17329633wrg.11
        for <linux-efi@vger.kernel.org>; Tue, 21 Apr 2020 10:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TqOZ+NIxx7CWkAc2Z7tIWcdMGQ0rKBuiSDleHFlId2w=;
        b=g9fSM/1mOQ8JhLXjvEAT44BjKSCUS05HYGGctXhqW0SL/vlyMFcaFjr7QjobHlV5g7
         t1lv6BTJzwmxXK0MeqbycCPy1qDf6jW3MvwiZdm6Ax+YnsOwi752gyD7RrdCigNe85Q3
         XT/7Bak1Vio3Vj0UA73N0ze5mbj60iDMf/38CTtK4bR4GJyHWWWgaKSb2PYH/FaoAPaN
         puKtbXD0U7DMTOzqdmBPFJMRDOJ76At8MSAJH9ISkeq68N+UPIzpLNiU/6m5BUOOwFaW
         FVe5v0qaaDqzbZOKoZDzQKit6MPiOhfy0axa97GmsqyJTYsQQzq8okwvRUmuXhuoLtF1
         fILw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TqOZ+NIxx7CWkAc2Z7tIWcdMGQ0rKBuiSDleHFlId2w=;
        b=jQKN4LulPofbE2R60pWWdWxlwQiQo7qKimU4rHdA/ZZ8RuL0Pqia/8WD7gZlv8rlLF
         2zcZ+TE2PrVXdI9ZrcxuDt0Iq/7mx7uZ23XzhUr2meEcZdx6rRy+UdRU+KMe6Cig1050
         vDTopK8jOFljmSk92gLksrPOentAy/GeYeg28VC67VnF89TJqPWk6U4FA+cXkjiRdRL0
         9wgHL6sxvhnGfSChYRTVvRHE5Vlq+FMWSHZAdcMrlBgGktAmfBrC1HEyK4PNMOBFF+FV
         9PejaXy9YVEkf60YCO+AJCqQpnZlZF/67f+2G3hgZURbjAs33sBlvYgYGDFLTVzDD1RA
         FUlw==
X-Gm-Message-State: AGi0PuZrRqCjdMN5IA+4Os1R0XEml11UjXzUoyzTRLzVKQmSkAy3/q8U
        GRhz7ajtPb+Latfzao7yaYcTCCyuMMeEosW+ZOAb
X-Google-Smtp-Source: APiQypKwTgmDh5dweCPXKSpnKdXbfJfMUJkZfbPD8dt0zPOvwlJJ58AVBwoIgpbu3/5RiL/cVKnV3rc2Bn1Qof2L61g=
X-Received: by 2002:adf:ab5c:: with SMTP id r28mr21585012wrc.384.1587490206521;
 Tue, 21 Apr 2020 10:30:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200421033336.9663-1-atish.patra@wdc.com> <CAMj1kXEXTq8RhD-AM4i3ZmXRcLDTW8waNDbWNa0V8V1nz4zb_A@mail.gmail.com>
In-Reply-To: <CAMj1kXEXTq8RhD-AM4i3ZmXRcLDTW8waNDbWNa0V8V1nz4zb_A@mail.gmail.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Tue, 21 Apr 2020 10:29:55 -0700
Message-ID: <CAOnJCUK3kTVo7fMWto0GtQ2RCVeP_WgFhkCgdnGj1XOteMjT-Q@mail.gmail.com>
Subject: Re: [v4 PATCH 0/3] Add UEFI support for RISC-V
To:     Ard Biesheuvel <ardb@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Atish Patra <atish.patra@wdc.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Apr 21, 2020 at 12:24 AM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Tue, 21 Apr 2020 at 05:34, Atish Patra <atish.patra@wdc.com> wrote:
> >
> > This series adds UEFI support for RISC-V. Currently, only boot time
> > services have been added. Runtime services will be added in a separate
> > series. This series depends on some core EFI patches
> > present in current in efi-next and following other patches.
> >
> > U-Boot: Adds the boot hartid under chosen node.
> > https://lists.denx.de/pipermail/u-boot/2020-April/405726.html
> >
> > Linux kernel: 5.7-rc1
> >
> > OpenSBI: master
> >
> > Patch 1 just moves arm-stub code to a generic code so that it can be used
> > across different architecture.
> >
> > Patch 3 adds fixmap bindings so that CONFIG_EFI can be compiled and we do not
> > have create separate config to enable boot time services.
> > As runtime services are not enabled at this time, full generic early ioremap
> > support is also not added in this series.
> >
> > Patch 4 and 5 adds the PE/COFF header and EFI stub code support for RISC-V
> > respectively.
> >
> > The patches can also be found in following git repo.
> >
> > https://github.com/atishp04/linux/tree/wip_uefi_riscv_v4
> >
> > The patches have been verified on Qemu using bootefi command in U-Boot.
> >
> > Changes from v3->v4:
> > 1. Rebased on top of efi-next.
> > 2. Dropped patch 1 & 2 from this series as it is already queued in efi-next.
> > Changes from v2->v3:
> > 3. Improved handle_kernel_image() for RISC-V.
> >
>
> Thanks Atish. This looks nice and simple now.
>
> I will need an ack from the RISC-V maintainers on these, and it is up
> to them to consider whether the changes to core kconfigs and makefiles
> are likely to cause trouble or not. If so, I am happy to work out a
> way to merge this via a shared stable branch.
>
@Palmer Dabbelt : Can you take a look at the series whenever you have
some free cycles ?
We would like to merge the series sooner than later.

>
>
> > Changes from v1->v2:
> > 1. Rebased on 5.7-rc1.
> > 2. Fixed minor typos and removed redundant macros/comments.
> >
> > Changes from previous version:
> > 1. Renamed to the generic efi stub macro.
> > 2. Address all redundant comments.
> > 3. Supported EFI kernel image with normal booti command.
> > 4. Removed runtime service related macro defines.
> >
> > Atish Patra (3):
> > RISC-V: Define fixmap bindings for generic early ioremap support
> > RISC-V: Add PE/COFF header for EFI stub
> > RISC-V: Add EFI stub support.
> >
> > arch/riscv/Kconfig                        |  21 +++++
> > arch/riscv/Makefile                       |   1 +
> > arch/riscv/configs/defconfig              |   1 +
> > arch/riscv/include/asm/Kbuild             |   1 +
> > arch/riscv/include/asm/efi.h              |  44 +++++++++
> > arch/riscv/include/asm/fixmap.h           |  18 ++++
> > arch/riscv/include/asm/io.h               |   1 +
> > arch/riscv/include/asm/sections.h         |  13 +++
> > arch/riscv/kernel/Makefile                |   4 +
> > arch/riscv/kernel/efi-header.S            |  99 ++++++++++++++++++++
> > arch/riscv/kernel/head.S                  |  16 ++++
> > arch/riscv/kernel/image-vars.h            |  53 +++++++++++
> > arch/riscv/kernel/vmlinux.lds.S           |  20 +++-
> > drivers/firmware/efi/Kconfig              |   2 +-
> > drivers/firmware/efi/libstub/Makefile     |  10 ++
> > drivers/firmware/efi/libstub/riscv-stub.c | 106 ++++++++++++++++++++++
> > 16 files changed, 407 insertions(+), 3 deletions(-)
> > create mode 100644 arch/riscv/include/asm/efi.h
> > create mode 100644 arch/riscv/include/asm/sections.h
> > create mode 100644 arch/riscv/kernel/efi-header.S
> > create mode 100644 arch/riscv/kernel/image-vars.h
> > create mode 100644 drivers/firmware/efi/libstub/riscv-stub.c
> >
> > --
> > 2.24.0
> >



-- 
Regards,
Atish
