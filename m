Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F7681BF734
	for <lists+linux-efi@lfdr.de>; Thu, 30 Apr 2020 13:55:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbgD3LzB (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 30 Apr 2020 07:55:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:48310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726127AbgD3LzA (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 30 Apr 2020 07:55:00 -0400
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D8CE92082E
        for <linux-efi@vger.kernel.org>; Thu, 30 Apr 2020 11:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588247699;
        bh=6exdI6IOKOvwYpX87SA9c24+CEE5P9lDZk7I86ngsIw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ntGZnwiihZSMnKCPBTHBMuN0dg57pMiYX0qVsIpKDG5M6ey7sRuy7tkTuGgTPU9X0
         94wfedYmYc5n36sG/ENE856Bq3i2uoWCPjcHcYGx4HW54ExArnK/j77Tq52ZzrUKez
         4m6CZs5lpBzfod8fEx0PLtA1CjKnpc30shXBQECg=
Received: by mail-il1-f180.google.com with SMTP id b18so1035100ilf.2
        for <linux-efi@vger.kernel.org>; Thu, 30 Apr 2020 04:54:59 -0700 (PDT)
X-Gm-Message-State: AGi0PubIy/mtWJVLi954xLX7wAwd502/kMPfMDQ0X4r+a9oNLoMUohx1
        Cw+dKDcgNbR782gD/xqJMl0f8wFX+lS1BG/F/w0=
X-Google-Smtp-Source: APiQypJeRfYTYYnm7KocjfHYpA+DLis3+KeYfVc/9Ao9m5RR0SP6bJ9dWZ0lqLUUNjnu+60n3rQPYZpA2pZnIYoUcEk=
X-Received: by 2002:a92:3c55:: with SMTP id j82mr1536736ila.258.1588247699224;
 Thu, 30 Apr 2020 04:54:59 -0700 (PDT)
MIME-Version: 1.0
References: <CAOnJCUJp12H_QSbw9zcYQxeZtNGpNxQhu8mkzzxrFAUArf9qfg@mail.gmail.com>
 <mhng-970b2596-146b-456e-be2d-9b7291775df5@palmerdabbelt-glaptop1>
In-Reply-To: <mhng-970b2596-146b-456e-be2d-9b7291775df5@palmerdabbelt-glaptop1>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 30 Apr 2020 13:54:48 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHXaTP=GN8s9Q0DWGT7XtV+XnB_2R68yyuWguMqP3m3+w@mail.gmail.com>
Message-ID: <CAMj1kXHXaTP=GN8s9Q0DWGT7XtV+XnB_2R68yyuWguMqP3m3+w@mail.gmail.com>
Subject: Re: [GIT PULL] EFI stub loading support for RISC-V
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Atish Patra <atishp@atishpatra.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Atish Patra <Atish.Patra@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 30 Apr 2020 at 00:52, Palmer Dabbelt <palmer@dabbelt.com> wrote:
>
> On Tue, 28 Apr 2020 10:57:48 PDT (-0700), atishp@atishpatra.org wrote:
> > On Sun, Apr 26, 2020 at 12:52 PM Atish Patra <atishp@atishpatra.org> wrote:
> >>
> >> On Sat, Apr 25, 2020 at 12:31 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> >> >
> >> > Palmer,
> >> >
> >> > As discussed, below are the changes for v5.8 that can be taken via the
> >> > RISC-V tree to implement booting RISC-V Linux from EFI firmware.
> >> >
> >> > You can fetch and merge the signed tag directly, or merge 22090f84bc3f80
> >> > and cherry pick the 4 patches on top of it, if you see any need to do so
> >> > (but please use a topic branch in that case)
> >> >
> >> > Please be aware (as is noted in the tag) that these changes are really
> >> > the bare minimum that is needed to launch the kernel from EFI firmware.
> >> > In the current state, you may be able to boot from Uboot in EFI mode,
> >> > but Tianocore based boot will not work at all, unless you convert the
> >> > EFI memory map back to DT memory nodes in the firmware implementation,
> >> > and I can assure you that that is not something that will be accepted in
> >> > upstream Tianocore.
> >> >
> >> > So in summary, this is unfinished work, and I can only recommend merging
> >> > these changes once there is a plan in place to complete the implementation.
> >> >
> >>
> >> I have started looking into this part. My initial plan was to start
> >> looking into it right after I got
> >> the boot time services working but other things took priority. Thanks
> >> for your review and
> >> suggestion throughout the process. I will coordinate with Abner/Daniel
> >> to test RISC-V UEFI
> >> runtime services(once implemented)  with tianocore.
> >> > --
> >> > Ard.
> >> >
> >> >
> >> > The following changes since commit 22090f84bc3f8081e0ec180ccaedc85820085376:
> >> >
> >> >   efi/libstub: unify EFI call wrappers for non-x86 (2020-04-23 20:15:06 +0200)
> >> >
> >> > are available in the Git repository at:
> >> >
> >> >   git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/riscv-efi-for-v5.8
> >> >
> >> > for you to fetch changes up to 66b4ac6b9dd1fdbb8ac7a1f20a8d08066368245d:
> >> >
> >> >   RISC-V: Add EFI stub support. (2020-04-25 13:59:54 +0200)
> >> >
> >> > ----------------------------------------------------------------
> >> > EFI stub loading support for RISC-V
> >> >
> >> > This branch implements support for loading the RISC-V Linux kernel
> >> > straight from EFI firmware, by adding PE/COFF metadata to the kernel
> >> > image and incorporating the kernel's EFI stub.
> >> >
> >> > Note that this is the *bare* minimum that is needed to boot from EFI
> >> > firmware. The following pieces are still missing at this point, and
> >> > will be required for full interoperability with generic EFI firmware:
> >> > - using the EFI memory map instead of the device tree to populate the
> >> >   memblock tables
> >> > - parsing and handling of generic EFI configuration tables (such as
> >> >   SMBIOS), as well as architecture specific ones that may be defined
> >> >   for RISC-V
> >> > - runtime mapping of EFI runtime services memory and MMIO regions, and
> >> >   support for EFI runtime services (get/set time, get/set variable, reset
> >> >   system)
> >> >
> >> > ----------------------------------------------------------------
> >> >
> >> > Cc: Atish Patra <atish.patra@wdc.com>
> >> > Cc: Palmer Dabbelt <palmer@dabbelt.com>
> >> > Cc: Paul Walmsley <paul.walmsley@sifive.com>
> >> > Cc: Albert Ou <aou@eecs.berkeley.edu>
> >> > Cc: linux-riscv@lists.infradead.org
> >> >
> >> > Atish Patra (4):
> >> >       include: pe.h: Add RISC-V related PE definition
> >> >       RISC-V: Define fixmap bindings for generic early ioremap support
> >> >       RISC-V: Add PE/COFF header for EFI stub
> >> >       RISC-V: Add EFI stub support.
> >> >
> >> >  arch/riscv/Kconfig                        |  22 ++++++
> >> >  arch/riscv/Makefile                       |   1 +
> >> >  arch/riscv/configs/defconfig              |   1 +
> >> >  arch/riscv/include/asm/Kbuild             |   1 +
> >> >  arch/riscv/include/asm/efi.h              |  33 +++++++++
> >> >  arch/riscv/include/asm/fixmap.h           |  18 +++++
> >> >  arch/riscv/include/asm/io.h               |   1 +
> >> >  arch/riscv/include/asm/sections.h         |  13 ++++
> >> >  arch/riscv/kernel/Makefile                |   4 ++
> >> >  arch/riscv/kernel/efi-header.S            | 100 +++++++++++++++++++++++++++
> >> >  arch/riscv/kernel/head.S                  |  16 +++++
> >> >  arch/riscv/kernel/image-vars.h            |  53 +++++++++++++++
> >> >  arch/riscv/kernel/vmlinux.lds.S           |  22 +++++-
> >> >  drivers/firmware/efi/Kconfig              |   3 +-
> >> >  drivers/firmware/efi/libstub/Makefile     |  10 +++
> >> >  drivers/firmware/efi/libstub/riscv-stub.c | 109 ++++++++++++++++++++++++++++++
> >> >  include/linux/pe.h                        |   3 +
> >> >  17 files changed, 407 insertions(+), 3 deletions(-)
> >> >  create mode 100644 arch/riscv/include/asm/efi.h
> >> >  create mode 100644 arch/riscv/include/asm/sections.h
> >> >  create mode 100644 arch/riscv/kernel/efi-header.S
> >> >  create mode 100644 arch/riscv/kernel/image-vars.h
> >> >  create mode 100644 drivers/firmware/efi/libstub/riscv-stub.c
> >>
> >>
> >>
> >> --
> >> Regards,
> >> Atish
> >
> > Hi Palmer,
> > There were few build errors for all-yes config and nommu reported by
> > 0-day tests.
> > As some of the fixes require to add some dummy declarations for efi
> > runtime related functions,
> > Ard suggested that we should drop the series for now and merge with
> > full uefi support later.
>
> OK, I'll wait for another patch set.  That makes my life a bit easier as well,
> as we don't have to do the multi-tree merge in a single release.

Yeah. Apologies for the back and forth, but I really don't want to end
up in a place where I am juggling EFI fixes and have to care about
architectures that can't even use EFI in a meaningful way.
