Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F4371B93C4
	for <lists+linux-efi@lfdr.de>; Sun, 26 Apr 2020 21:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726176AbgDZTwp (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 26 Apr 2020 15:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726171AbgDZTwo (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 26 Apr 2020 15:52:44 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49D11C061A0F
        for <linux-efi@vger.kernel.org>; Sun, 26 Apr 2020 12:52:43 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id d15so16441561wrx.3
        for <linux-efi@vger.kernel.org>; Sun, 26 Apr 2020 12:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vT/zsKORE2iDsOOIAsxzv0lVgu+AfWvwogQmIgzzmJ4=;
        b=rtJdJLtQldx1i8iCxZ5rDUF6CblbODdnDCgbNspbA0Ujnt6AyXZxpsgdlkh8mwzoXF
         KMrX+3oUGxKMSD2hLYMf5QwNUMDkMkaEyu8LaiTGPoi5gcnYJhug+ZtdkNBLLXxJYjER
         UUXfj2Dh60IM3DVXfvj4SGqeqxlDRpK9pAYDM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vT/zsKORE2iDsOOIAsxzv0lVgu+AfWvwogQmIgzzmJ4=;
        b=MmB+mk6kLAxawhCObuvD4nY89iu8YNbbsqnE1CW18TGEJlB+OvTQTzGzSxg6AU3Eo+
         W42qyNWhldITMbvvAJ/yqBPyeA/x3ncGjMe1OdknKsY17aDV7nsnUoAtZ8DW1vXD4rZG
         +VGOffdgecXxEJz7EYZK4KpoBXddR406/nfDahhr6vsWgs4kf6IKeTEm/OMB2vivNzOh
         nqfPIhiCj80snnX2kJhFwzLjQI7xLC2uUXoE6Nyi0kVmVfvjJNCFgnf62/KZrESx3VMo
         f/+nRGdIRYtmq6BifiTfytsWmT1phmxg6z58mmQ1wNikNuvcbG2e9L36wBgtPS1ADisE
         ZLBg==
X-Gm-Message-State: AGi0PuY6JYtTEuemqccqFxs9DRwxq76mW9/bR39VZpg9f7q8EHSYHVk/
        OpOnZmpWXcG4GTIFSFtzW/lhSyxGXJxgfYsJdsbi
X-Google-Smtp-Source: APiQypKlNYYpznrgIJwjt7cPENrof5+eRXXkEEBqLmoeRkhHUZQbLY/80ziELYDLrwHGr19YLPps7TrvHWU6Pl3PhwU=
X-Received: by 2002:a5d:4443:: with SMTP id x3mr23080870wrr.162.1587930760934;
 Sun, 26 Apr 2020 12:52:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200425193128.25638-1-ardb@kernel.org>
In-Reply-To: <20200425193128.25638-1-ardb@kernel.org>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Sun, 26 Apr 2020 12:52:29 -0700
Message-ID: <CAOnJCUJpGUyK09x0oc8Ci+SdFV-cCMPxLqvD4trx0nb+ub3Yvg@mail.gmail.com>
Subject: Re: [GIT PULL] EFI stub loading support for RISC-V
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Atish Patra <atish.patra@wdc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sat, Apr 25, 2020 at 12:31 PM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> Palmer,
>
> As discussed, below are the changes for v5.8 that can be taken via the
> RISC-V tree to implement booting RISC-V Linux from EFI firmware.
>
> You can fetch and merge the signed tag directly, or merge 22090f84bc3f80
> and cherry pick the 4 patches on top of it, if you see any need to do so
> (but please use a topic branch in that case)
>
> Please be aware (as is noted in the tag) that these changes are really
> the bare minimum that is needed to launch the kernel from EFI firmware.
> In the current state, you may be able to boot from Uboot in EFI mode,
> but Tianocore based boot will not work at all, unless you convert the
> EFI memory map back to DT memory nodes in the firmware implementation,
> and I can assure you that that is not something that will be accepted in
> upstream Tianocore.
>
> So in summary, this is unfinished work, and I can only recommend merging
> these changes once there is a plan in place to complete the implementation.
>

I have started looking into this part. My initial plan was to start
looking into it right after I got
the boot time services working but other things took priority. Thanks
for your review and
suggestion throughout the process. I will coordinate with Abner/Daniel
to test RISC-V UEFI
runtime services(once implemented)  with tianocore.
> --
> Ard.
>
>
> The following changes since commit 22090f84bc3f8081e0ec180ccaedc85820085376:
>
>   efi/libstub: unify EFI call wrappers for non-x86 (2020-04-23 20:15:06 +0200)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/riscv-efi-for-v5.8
>
> for you to fetch changes up to 66b4ac6b9dd1fdbb8ac7a1f20a8d08066368245d:
>
>   RISC-V: Add EFI stub support. (2020-04-25 13:59:54 +0200)
>
> ----------------------------------------------------------------
> EFI stub loading support for RISC-V
>
> This branch implements support for loading the RISC-V Linux kernel
> straight from EFI firmware, by adding PE/COFF metadata to the kernel
> image and incorporating the kernel's EFI stub.
>
> Note that this is the *bare* minimum that is needed to boot from EFI
> firmware. The following pieces are still missing at this point, and
> will be required for full interoperability with generic EFI firmware:
> - using the EFI memory map instead of the device tree to populate the
>   memblock tables
> - parsing and handling of generic EFI configuration tables (such as
>   SMBIOS), as well as architecture specific ones that may be defined
>   for RISC-V
> - runtime mapping of EFI runtime services memory and MMIO regions, and
>   support for EFI runtime services (get/set time, get/set variable, reset
>   system)
>
> ----------------------------------------------------------------
>
> Cc: Atish Patra <atish.patra@wdc.com>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Paul Walmsley <paul.walmsley@sifive.com>
> Cc: Albert Ou <aou@eecs.berkeley.edu>
> Cc: linux-riscv@lists.infradead.org
>
> Atish Patra (4):
>       include: pe.h: Add RISC-V related PE definition
>       RISC-V: Define fixmap bindings for generic early ioremap support
>       RISC-V: Add PE/COFF header for EFI stub
>       RISC-V: Add EFI stub support.
>
>  arch/riscv/Kconfig                        |  22 ++++++
>  arch/riscv/Makefile                       |   1 +
>  arch/riscv/configs/defconfig              |   1 +
>  arch/riscv/include/asm/Kbuild             |   1 +
>  arch/riscv/include/asm/efi.h              |  33 +++++++++
>  arch/riscv/include/asm/fixmap.h           |  18 +++++
>  arch/riscv/include/asm/io.h               |   1 +
>  arch/riscv/include/asm/sections.h         |  13 ++++
>  arch/riscv/kernel/Makefile                |   4 ++
>  arch/riscv/kernel/efi-header.S            | 100 +++++++++++++++++++++++++++
>  arch/riscv/kernel/head.S                  |  16 +++++
>  arch/riscv/kernel/image-vars.h            |  53 +++++++++++++++
>  arch/riscv/kernel/vmlinux.lds.S           |  22 +++++-
>  drivers/firmware/efi/Kconfig              |   3 +-
>  drivers/firmware/efi/libstub/Makefile     |  10 +++
>  drivers/firmware/efi/libstub/riscv-stub.c | 109 ++++++++++++++++++++++++++++++
>  include/linux/pe.h                        |   3 +
>  17 files changed, 407 insertions(+), 3 deletions(-)
>  create mode 100644 arch/riscv/include/asm/efi.h
>  create mode 100644 arch/riscv/include/asm/sections.h
>  create mode 100644 arch/riscv/kernel/efi-header.S
>  create mode 100644 arch/riscv/kernel/image-vars.h
>  create mode 100644 drivers/firmware/efi/libstub/riscv-stub.c



-- 
Regards,
Atish
