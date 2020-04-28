Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 899301BC751
	for <lists+linux-efi@lfdr.de>; Tue, 28 Apr 2020 19:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728313AbgD1R6B (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 28 Apr 2020 13:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727827AbgD1R6B (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 28 Apr 2020 13:58:01 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07FDDC03C1AB
        for <linux-efi@vger.kernel.org>; Tue, 28 Apr 2020 10:58:01 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id k13so25783250wrw.7
        for <linux-efi@vger.kernel.org>; Tue, 28 Apr 2020 10:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5lOQR/0LhdL7Cn40m4Omd/1YL4MKB8xUQs57NlDuHek=;
        b=LQzvdqLM0oAZv3fkh6QdWruitiuJ8wS90F5YLeN+LjB+Cr4EK7t8TJCzxLIpRe8GTa
         tXIFSunSbn7/lJlK0l5Yn78GRhtJS8ep29w6Mh/maQgdvrtOBf8wQOB3I/Y1RuHji5iR
         H8QnB8AxX1FoW4LF+NGNF6uQFqliwu4k0yWPY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5lOQR/0LhdL7Cn40m4Omd/1YL4MKB8xUQs57NlDuHek=;
        b=mGJpGl8Yse8iwMYa8hlcSla/Jv9+23aXvSiY58OJmNWpNy0Mv/ovOmqWBN34o7jvNk
         8lc7xCZyD7byD832hgPCidH/kHvbIGEoXXWPyei1yb3zQOdLMrox0dAzi5yuuYV0g5Dw
         Zp6+BUSRzS7cllZmHGy0jYxvpYrN7UhFooGF7oYwmNGe0sE+459eEpzIVCPiso9WZDS6
         mrKeiFdxPMAgYD0qqWV488RLBTjU+QpMf/5a418C+TN7GLlt+TfCc0ZtZwLMYDqw9oWI
         +OOhMeHZDgZj1vHaUMlWwXwprixXXoeyyvTY5njeca28CFG8BTwLhr1MQfU1q/aH4Nvw
         76Bg==
X-Gm-Message-State: AGi0PuZQbWfQJr0gBrflrozayjS+bQUxOb4/8Z5WLnuBAkrTbRgE+7/a
        8sWBidFeXeqnqtIWuNkroHttBB6H/KxsnGKtZdbh
X-Google-Smtp-Source: APiQypKWJk01qLF2xkgo+QNE09A4kSBGEaG2H+m491sR6fEG52tfyM+gNyaDBuhPUd7YMpcrFO4ZpKQBDDix1isnEv0=
X-Received: by 2002:adf:ab5c:: with SMTP id r28mr34098877wrc.384.1588096679681;
 Tue, 28 Apr 2020 10:57:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200425193128.25638-1-ardb@kernel.org> <CAOnJCUJpGUyK09x0oc8Ci+SdFV-cCMPxLqvD4trx0nb+ub3Yvg@mail.gmail.com>
In-Reply-To: <CAOnJCUJpGUyK09x0oc8Ci+SdFV-cCMPxLqvD4trx0nb+ub3Yvg@mail.gmail.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Tue, 28 Apr 2020 10:57:48 -0700
Message-ID: <CAOnJCUJp12H_QSbw9zcYQxeZtNGpNxQhu8mkzzxrFAUArf9qfg@mail.gmail.com>
Subject: Re: [GIT PULL] EFI stub loading support for RISC-V
To:     Ard Biesheuvel <ardb@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Atish Patra <atish.patra@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sun, Apr 26, 2020 at 12:52 PM Atish Patra <atishp@atishpatra.org> wrote:
>
> On Sat, Apr 25, 2020 at 12:31 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > Palmer,
> >
> > As discussed, below are the changes for v5.8 that can be taken via the
> > RISC-V tree to implement booting RISC-V Linux from EFI firmware.
> >
> > You can fetch and merge the signed tag directly, or merge 22090f84bc3f80
> > and cherry pick the 4 patches on top of it, if you see any need to do so
> > (but please use a topic branch in that case)
> >
> > Please be aware (as is noted in the tag) that these changes are really
> > the bare minimum that is needed to launch the kernel from EFI firmware.
> > In the current state, you may be able to boot from Uboot in EFI mode,
> > but Tianocore based boot will not work at all, unless you convert the
> > EFI memory map back to DT memory nodes in the firmware implementation,
> > and I can assure you that that is not something that will be accepted in
> > upstream Tianocore.
> >
> > So in summary, this is unfinished work, and I can only recommend merging
> > these changes once there is a plan in place to complete the implementation.
> >
>
> I have started looking into this part. My initial plan was to start
> looking into it right after I got
> the boot time services working but other things took priority. Thanks
> for your review and
> suggestion throughout the process. I will coordinate with Abner/Daniel
> to test RISC-V UEFI
> runtime services(once implemented)  with tianocore.
> > --
> > Ard.
> >
> >
> > The following changes since commit 22090f84bc3f8081e0ec180ccaedc85820085376:
> >
> >   efi/libstub: unify EFI call wrappers for non-x86 (2020-04-23 20:15:06 +0200)
> >
> > are available in the Git repository at:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/riscv-efi-for-v5.8
> >
> > for you to fetch changes up to 66b4ac6b9dd1fdbb8ac7a1f20a8d08066368245d:
> >
> >   RISC-V: Add EFI stub support. (2020-04-25 13:59:54 +0200)
> >
> > ----------------------------------------------------------------
> > EFI stub loading support for RISC-V
> >
> > This branch implements support for loading the RISC-V Linux kernel
> > straight from EFI firmware, by adding PE/COFF metadata to the kernel
> > image and incorporating the kernel's EFI stub.
> >
> > Note that this is the *bare* minimum that is needed to boot from EFI
> > firmware. The following pieces are still missing at this point, and
> > will be required for full interoperability with generic EFI firmware:
> > - using the EFI memory map instead of the device tree to populate the
> >   memblock tables
> > - parsing and handling of generic EFI configuration tables (such as
> >   SMBIOS), as well as architecture specific ones that may be defined
> >   for RISC-V
> > - runtime mapping of EFI runtime services memory and MMIO regions, and
> >   support for EFI runtime services (get/set time, get/set variable, reset
> >   system)
> >
> > ----------------------------------------------------------------
> >
> > Cc: Atish Patra <atish.patra@wdc.com>
> > Cc: Palmer Dabbelt <palmer@dabbelt.com>
> > Cc: Paul Walmsley <paul.walmsley@sifive.com>
> > Cc: Albert Ou <aou@eecs.berkeley.edu>
> > Cc: linux-riscv@lists.infradead.org
> >
> > Atish Patra (4):
> >       include: pe.h: Add RISC-V related PE definition
> >       RISC-V: Define fixmap bindings for generic early ioremap support
> >       RISC-V: Add PE/COFF header for EFI stub
> >       RISC-V: Add EFI stub support.
> >
> >  arch/riscv/Kconfig                        |  22 ++++++
> >  arch/riscv/Makefile                       |   1 +
> >  arch/riscv/configs/defconfig              |   1 +
> >  arch/riscv/include/asm/Kbuild             |   1 +
> >  arch/riscv/include/asm/efi.h              |  33 +++++++++
> >  arch/riscv/include/asm/fixmap.h           |  18 +++++
> >  arch/riscv/include/asm/io.h               |   1 +
> >  arch/riscv/include/asm/sections.h         |  13 ++++
> >  arch/riscv/kernel/Makefile                |   4 ++
> >  arch/riscv/kernel/efi-header.S            | 100 +++++++++++++++++++++++++++
> >  arch/riscv/kernel/head.S                  |  16 +++++
> >  arch/riscv/kernel/image-vars.h            |  53 +++++++++++++++
> >  arch/riscv/kernel/vmlinux.lds.S           |  22 +++++-
> >  drivers/firmware/efi/Kconfig              |   3 +-
> >  drivers/firmware/efi/libstub/Makefile     |  10 +++
> >  drivers/firmware/efi/libstub/riscv-stub.c | 109 ++++++++++++++++++++++++++++++
> >  include/linux/pe.h                        |   3 +
> >  17 files changed, 407 insertions(+), 3 deletions(-)
> >  create mode 100644 arch/riscv/include/asm/efi.h
> >  create mode 100644 arch/riscv/include/asm/sections.h
> >  create mode 100644 arch/riscv/kernel/efi-header.S
> >  create mode 100644 arch/riscv/kernel/image-vars.h
> >  create mode 100644 drivers/firmware/efi/libstub/riscv-stub.c
>
>
>
> --
> Regards,
> Atish

Hi Palmer,
There were few build errors for all-yes config and nommu reported by
0-day tests.
As some of the fixes require to add some dummy declarations for efi
runtime related functions,
Ard suggested that we should drop the series for now and merge with
full uefi support later.

-- 
Regards,
Atish
