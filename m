Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90F861C4963
	for <lists+linux-efi@lfdr.de>; Tue,  5 May 2020 00:10:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728134AbgEDWKM (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 4 May 2020 18:10:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726419AbgEDWKL (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 4 May 2020 18:10:11 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95048C061A0E
        for <linux-efi@vger.kernel.org>; Mon,  4 May 2020 15:10:11 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id r14so11400pfg.2
        for <linux-efi@vger.kernel.org>; Mon, 04 May 2020 15:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=qXuUF5w7g6lC1n/G1lz2lM2QKdQ45opx2MhRpkEwDZw=;
        b=lNcqGK492oKuELZ+zYOJ8tCM2rgWb0QYqBA6mHrjcG2ELqF3+5IOKNsYaCkK4c+rdR
         RNYzBuk4iXqnG6zK/SZYkVGFPkIr/Rr58+6SlKC7OzQXePdDOUC1NeS+Gv7eswRi6xXm
         zopB+GivActa4hEsrTK0EbvskRKHp6xBZFnNrdnzecZV0/x8N8ZCgSCloEYkYx3a11VO
         5UCZZqIZcDzCUkYYWy9eSKp9YpOwtJ7VTSXmMdrwZPkL0JhiLNgWlYRb5xDxRUvzcgoE
         Uwt0n5Uunaqffo7HutIbMmv6aEV3Rm6QJZHhjAVJWjuLznOeo56ru3+80saDRUWoxLIC
         HoPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=qXuUF5w7g6lC1n/G1lz2lM2QKdQ45opx2MhRpkEwDZw=;
        b=rqPAMRiiHNxXhJl7lFeohtsVlx8jkWCxYN1ZlpzfO8E8CeNdyp03wClUoBvRJxgvU1
         I3fYGdjOvtrhaB9TjlEuaIq91HIj8uAhaQCE+1LSbyAJ4/RqIb4lER4ufGXCDN86cixD
         kgHr0mJAQM8uPHm2pIz6ph4AXf8EnydNWWg8dJgC0jbIPIgijE2L26nDfXocEKvlz81Q
         vttfRpYCKl/teFFKKsBD7yC++hrTeDAGOdlaqxg0o6k/maDnZPExSZ0/cS465UaRcPmN
         VZe5oIRvUs3EoSdn0ouv3nQmdfRAnTBHEPwP8BDT/plzgVcSAG15ky0GS6ub4cTyssAh
         2dYA==
X-Gm-Message-State: AGi0Puaxi9PBjUgw/vISYSfqCkCiFSNjwPjt1nlU2NPjWLMNT9zfHj8j
        QJDaia669J73o7eKVBFvKlVdfg==
X-Google-Smtp-Source: APiQypLoAUQvfl3jCgNmkTEiCsKB+3A79WO2BHbTvZJwWQGZmdM62j+IsCQgcN7nYGFaZ29Ie/jMVg==
X-Received: by 2002:a62:e30f:: with SMTP id g15mr56001pfh.150.1588630210901;
        Mon, 04 May 2020 15:10:10 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id v26sm67384pfe.121.2020.05.04.15.10.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 15:10:10 -0700 (PDT)
Date:   Mon, 04 May 2020 15:10:10 -0700 (PDT)
X-Google-Original-Date: Mon, 04 May 2020 15:08:02 PDT (-0700)
Subject:     Re: [GIT PULL] EFI stub loading support for RISC-V
In-Reply-To: <CAMj1kXHXaTP=GN8s9Q0DWGT7XtV+XnB_2R68yyuWguMqP3m3+w@mail.gmail.com>
CC:     atishp@atishpatra.org, linux-efi@vger.kernel.org,
        Atish Patra <Atish.Patra@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     ardb@kernel.org
Message-ID: <mhng-4513bd18-556a-4b92-a16a-04be757776ed@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 30 Apr 2020 04:54:48 PDT (-0700), ardb@kernel.org wrote:
> On Thu, 30 Apr 2020 at 00:52, Palmer Dabbelt <palmer@dabbelt.com> wrote:
>>
>> On Tue, 28 Apr 2020 10:57:48 PDT (-0700), atishp@atishpatra.org wrote:
>> > On Sun, Apr 26, 2020 at 12:52 PM Atish Patra <atishp@atishpatra.org> wrote:
>> >>
>> >> On Sat, Apr 25, 2020 at 12:31 PM Ard Biesheuvel <ardb@kernel.org> wrote:
>> >> >
>> >> > Palmer,
>> >> >
>> >> > As discussed, below are the changes for v5.8 that can be taken via the
>> >> > RISC-V tree to implement booting RISC-V Linux from EFI firmware.
>> >> >
>> >> > You can fetch and merge the signed tag directly, or merge 22090f84bc3f80
>> >> > and cherry pick the 4 patches on top of it, if you see any need to do so
>> >> > (but please use a topic branch in that case)
>> >> >
>> >> > Please be aware (as is noted in the tag) that these changes are really
>> >> > the bare minimum that is needed to launch the kernel from EFI firmware.
>> >> > In the current state, you may be able to boot from Uboot in EFI mode,
>> >> > but Tianocore based boot will not work at all, unless you convert the
>> >> > EFI memory map back to DT memory nodes in the firmware implementation,
>> >> > and I can assure you that that is not something that will be accepted in
>> >> > upstream Tianocore.
>> >> >
>> >> > So in summary, this is unfinished work, and I can only recommend merging
>> >> > these changes once there is a plan in place to complete the implementation.
>> >> >
>> >>
>> >> I have started looking into this part. My initial plan was to start
>> >> looking into it right after I got
>> >> the boot time services working but other things took priority. Thanks
>> >> for your review and
>> >> suggestion throughout the process. I will coordinate with Abner/Daniel
>> >> to test RISC-V UEFI
>> >> runtime services(once implemented)  with tianocore.
>> >> > --
>> >> > Ard.
>> >> >
>> >> >
>> >> > The following changes since commit 22090f84bc3f8081e0ec180ccaedc85820085376:
>> >> >
>> >> >   efi/libstub: unify EFI call wrappers for non-x86 (2020-04-23 20:15:06 +0200)
>> >> >
>> >> > are available in the Git repository at:
>> >> >
>> >> >   git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/riscv-efi-for-v5.8
>> >> >
>> >> > for you to fetch changes up to 66b4ac6b9dd1fdbb8ac7a1f20a8d08066368245d:
>> >> >
>> >> >   RISC-V: Add EFI stub support. (2020-04-25 13:59:54 +0200)
>> >> >
>> >> > ----------------------------------------------------------------
>> >> > EFI stub loading support for RISC-V
>> >> >
>> >> > This branch implements support for loading the RISC-V Linux kernel
>> >> > straight from EFI firmware, by adding PE/COFF metadata to the kernel
>> >> > image and incorporating the kernel's EFI stub.
>> >> >
>> >> > Note that this is the *bare* minimum that is needed to boot from EFI
>> >> > firmware. The following pieces are still missing at this point, and
>> >> > will be required for full interoperability with generic EFI firmware:
>> >> > - using the EFI memory map instead of the device tree to populate the
>> >> >   memblock tables
>> >> > - parsing and handling of generic EFI configuration tables (such as
>> >> >   SMBIOS), as well as architecture specific ones that may be defined
>> >> >   for RISC-V
>> >> > - runtime mapping of EFI runtime services memory and MMIO regions, and
>> >> >   support for EFI runtime services (get/set time, get/set variable, reset
>> >> >   system)
>> >> >
>> >> > ----------------------------------------------------------------
>> >> >
>> >> > Cc: Atish Patra <atish.patra@wdc.com>
>> >> > Cc: Palmer Dabbelt <palmer@dabbelt.com>
>> >> > Cc: Paul Walmsley <paul.walmsley@sifive.com>
>> >> > Cc: Albert Ou <aou@eecs.berkeley.edu>
>> >> > Cc: linux-riscv@lists.infradead.org
>> >> >
>> >> > Atish Patra (4):
>> >> >       include: pe.h: Add RISC-V related PE definition
>> >> >       RISC-V: Define fixmap bindings for generic early ioremap support
>> >> >       RISC-V: Add PE/COFF header for EFI stub
>> >> >       RISC-V: Add EFI stub support.
>> >> >
>> >> >  arch/riscv/Kconfig                        |  22 ++++++
>> >> >  arch/riscv/Makefile                       |   1 +
>> >> >  arch/riscv/configs/defconfig              |   1 +
>> >> >  arch/riscv/include/asm/Kbuild             |   1 +
>> >> >  arch/riscv/include/asm/efi.h              |  33 +++++++++
>> >> >  arch/riscv/include/asm/fixmap.h           |  18 +++++
>> >> >  arch/riscv/include/asm/io.h               |   1 +
>> >> >  arch/riscv/include/asm/sections.h         |  13 ++++
>> >> >  arch/riscv/kernel/Makefile                |   4 ++
>> >> >  arch/riscv/kernel/efi-header.S            | 100 +++++++++++++++++++++++++++
>> >> >  arch/riscv/kernel/head.S                  |  16 +++++
>> >> >  arch/riscv/kernel/image-vars.h            |  53 +++++++++++++++
>> >> >  arch/riscv/kernel/vmlinux.lds.S           |  22 +++++-
>> >> >  drivers/firmware/efi/Kconfig              |   3 +-
>> >> >  drivers/firmware/efi/libstub/Makefile     |  10 +++
>> >> >  drivers/firmware/efi/libstub/riscv-stub.c | 109 ++++++++++++++++++++++++++++++
>> >> >  include/linux/pe.h                        |   3 +
>> >> >  17 files changed, 407 insertions(+), 3 deletions(-)
>> >> >  create mode 100644 arch/riscv/include/asm/efi.h
>> >> >  create mode 100644 arch/riscv/include/asm/sections.h
>> >> >  create mode 100644 arch/riscv/kernel/efi-header.S
>> >> >  create mode 100644 arch/riscv/kernel/image-vars.h
>> >> >  create mode 100644 drivers/firmware/efi/libstub/riscv-stub.c
>> >>
>> >>
>> >>
>> >> --
>> >> Regards,
>> >> Atish
>> >
>> > Hi Palmer,
>> > There were few build errors for all-yes config and nommu reported by
>> > 0-day tests.
>> > As some of the fixes require to add some dummy declarations for efi
>> > runtime related functions,
>> > Ard suggested that we should drop the series for now and merge with
>> > full uefi support later.
>>
>> OK, I'll wait for another patch set.  That makes my life a bit easier as well,
>> as we don't have to do the multi-tree merge in a single release.
>
> Yeah. Apologies for the back and forth, but I really don't want to end
> up in a place where I am juggling EFI fixes and have to care about
> architectures that can't even use EFI in a meaningful way.

No problem, I just wanted to make sure I understood correctly as it was going
to be my first time trying to handle a multi-tree patch set like this so I'm a
bit lost.
