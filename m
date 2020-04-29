Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 861B61BEC2A
	for <lists+linux-efi@lfdr.de>; Thu, 30 Apr 2020 00:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbgD2WwO (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 29 Apr 2020 18:52:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726511AbgD2WwO (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 29 Apr 2020 18:52:14 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 238E2C03C1AE
        for <linux-efi@vger.kernel.org>; Wed, 29 Apr 2020 15:52:14 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id f7so1829304pfa.9
        for <linux-efi@vger.kernel.org>; Wed, 29 Apr 2020 15:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=c28pVgVmN/oYLckIHDfxeZNbVKB9dmutdgpZ/ZKNVUE=;
        b=QDM1bfH7SnhsG0nrQVYKjLFVhc4OAQQd5RESPdFxeQVb25X0P/pgW1RjESLmidczHn
         CTLXmIhucruBvlFhMB1bSu9dnSTyeAFI/EbEw7HXo2JaEFiJS5fdPLfP5FYZ3AHxgLDH
         3XdPDwd0xGRnpXoSh1f11gg5mZhJVaBPlKlqyN5n6zuCP8Sxol8wZMf2J9Xi787pUJri
         mu+v3sCkn2EbgsLDicjele/GhLJ+7fMVKVzxFs3xmbJoFghze5SytmctHngc7XeAHLvM
         cFNpbohWBa7DlHcPI/TlL7tjoDrTzOGKV/dASGYB3jU8kgBkb6hDIXyJ3VP5t5SEnu8s
         D6qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=c28pVgVmN/oYLckIHDfxeZNbVKB9dmutdgpZ/ZKNVUE=;
        b=n76DYxKjFhR0cajbmTGT8APHGHd9S54F4LMhNiRx8/svdSCjCNrSrZDURLApQ7jwkr
         ROTxek9gCyFYgGNatVbP6nbAxc0mjJflupiCu5a6UEy3U/Ju33GPoKJV++yTJEE/cMhE
         dxVzxPeEw3E7f3jVEKv+MYKewMu//Vb0zL307AwG4wsVcI87A1/lDg5nuRvZudp/K06H
         E8qb+Z6CqF5/z4smtAvvhGJ93AC6Wwt0er7a1mKsftZSV5VdyV/cIRxSJsEOfgDCIGaP
         OVXnad2DhdzU/JvNjV/ZLTEDqQvFA6WEbsih9+JDpHZp1P4FUVXBq60zSTBwJqwtr8mx
         AFVA==
X-Gm-Message-State: AGi0PuZJybUtiZ91YBcZapf9ZIu2VBSEoFE/CTyBLgoEzUQU+QmezINc
        GM8JD6UBApI3EVj24bo2lNkQR9V6vGxAqg==
X-Google-Smtp-Source: APiQypLGg2gCMFW/uloNU+mOluima13GaheC/chkrJwl0yyRNT9/8uvr9XYBOjA98Ul+9DhDWiwsGw==
X-Received: by 2002:aa7:81cf:: with SMTP id c15mr411430pfn.211.1588200732868;
        Wed, 29 Apr 2020 15:52:12 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id v133sm1884552pfc.113.2020.04.29.15.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 15:52:12 -0700 (PDT)
Date:   Wed, 29 Apr 2020 15:52:12 -0700 (PDT)
X-Google-Original-Date: Wed, 29 Apr 2020 15:51:45 PDT (-0700)
Subject:     Re: [GIT PULL] EFI stub loading support for RISC-V
In-Reply-To: <CAOnJCUJp12H_QSbw9zcYQxeZtNGpNxQhu8mkzzxrFAUArf9qfg@mail.gmail.com>
CC:     linux-efi@vger.kernel.org, Atish Patra <Atish.Patra@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     ardb@kernel.org, atishp@atishpatra.org
Message-ID: <mhng-970b2596-146b-456e-be2d-9b7291775df5@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 28 Apr 2020 10:57:48 PDT (-0700), atishp@atishpatra.org wrote:
> On Sun, Apr 26, 2020 at 12:52 PM Atish Patra <atishp@atishpatra.org> wrote:
>>
>> On Sat, Apr 25, 2020 at 12:31 PM Ard Biesheuvel <ardb@kernel.org> wrote:
>> >
>> > Palmer,
>> >
>> > As discussed, below are the changes for v5.8 that can be taken via the
>> > RISC-V tree to implement booting RISC-V Linux from EFI firmware.
>> >
>> > You can fetch and merge the signed tag directly, or merge 22090f84bc3f80
>> > and cherry pick the 4 patches on top of it, if you see any need to do so
>> > (but please use a topic branch in that case)
>> >
>> > Please be aware (as is noted in the tag) that these changes are really
>> > the bare minimum that is needed to launch the kernel from EFI firmware.
>> > In the current state, you may be able to boot from Uboot in EFI mode,
>> > but Tianocore based boot will not work at all, unless you convert the
>> > EFI memory map back to DT memory nodes in the firmware implementation,
>> > and I can assure you that that is not something that will be accepted in
>> > upstream Tianocore.
>> >
>> > So in summary, this is unfinished work, and I can only recommend merging
>> > these changes once there is a plan in place to complete the implementation.
>> >
>>
>> I have started looking into this part. My initial plan was to start
>> looking into it right after I got
>> the boot time services working but other things took priority. Thanks
>> for your review and
>> suggestion throughout the process. I will coordinate with Abner/Daniel
>> to test RISC-V UEFI
>> runtime services(once implemented)  with tianocore.
>> > --
>> > Ard.
>> >
>> >
>> > The following changes since commit 22090f84bc3f8081e0ec180ccaedc85820085376:
>> >
>> >   efi/libstub: unify EFI call wrappers for non-x86 (2020-04-23 20:15:06 +0200)
>> >
>> > are available in the Git repository at:
>> >
>> >   git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/riscv-efi-for-v5.8
>> >
>> > for you to fetch changes up to 66b4ac6b9dd1fdbb8ac7a1f20a8d08066368245d:
>> >
>> >   RISC-V: Add EFI stub support. (2020-04-25 13:59:54 +0200)
>> >
>> > ----------------------------------------------------------------
>> > EFI stub loading support for RISC-V
>> >
>> > This branch implements support for loading the RISC-V Linux kernel
>> > straight from EFI firmware, by adding PE/COFF metadata to the kernel
>> > image and incorporating the kernel's EFI stub.
>> >
>> > Note that this is the *bare* minimum that is needed to boot from EFI
>> > firmware. The following pieces are still missing at this point, and
>> > will be required for full interoperability with generic EFI firmware:
>> > - using the EFI memory map instead of the device tree to populate the
>> >   memblock tables
>> > - parsing and handling of generic EFI configuration tables (such as
>> >   SMBIOS), as well as architecture specific ones that may be defined
>> >   for RISC-V
>> > - runtime mapping of EFI runtime services memory and MMIO regions, and
>> >   support for EFI runtime services (get/set time, get/set variable, reset
>> >   system)
>> >
>> > ----------------------------------------------------------------
>> >
>> > Cc: Atish Patra <atish.patra@wdc.com>
>> > Cc: Palmer Dabbelt <palmer@dabbelt.com>
>> > Cc: Paul Walmsley <paul.walmsley@sifive.com>
>> > Cc: Albert Ou <aou@eecs.berkeley.edu>
>> > Cc: linux-riscv@lists.infradead.org
>> >
>> > Atish Patra (4):
>> >       include: pe.h: Add RISC-V related PE definition
>> >       RISC-V: Define fixmap bindings for generic early ioremap support
>> >       RISC-V: Add PE/COFF header for EFI stub
>> >       RISC-V: Add EFI stub support.
>> >
>> >  arch/riscv/Kconfig                        |  22 ++++++
>> >  arch/riscv/Makefile                       |   1 +
>> >  arch/riscv/configs/defconfig              |   1 +
>> >  arch/riscv/include/asm/Kbuild             |   1 +
>> >  arch/riscv/include/asm/efi.h              |  33 +++++++++
>> >  arch/riscv/include/asm/fixmap.h           |  18 +++++
>> >  arch/riscv/include/asm/io.h               |   1 +
>> >  arch/riscv/include/asm/sections.h         |  13 ++++
>> >  arch/riscv/kernel/Makefile                |   4 ++
>> >  arch/riscv/kernel/efi-header.S            | 100 +++++++++++++++++++++++++++
>> >  arch/riscv/kernel/head.S                  |  16 +++++
>> >  arch/riscv/kernel/image-vars.h            |  53 +++++++++++++++
>> >  arch/riscv/kernel/vmlinux.lds.S           |  22 +++++-
>> >  drivers/firmware/efi/Kconfig              |   3 +-
>> >  drivers/firmware/efi/libstub/Makefile     |  10 +++
>> >  drivers/firmware/efi/libstub/riscv-stub.c | 109 ++++++++++++++++++++++++++++++
>> >  include/linux/pe.h                        |   3 +
>> >  17 files changed, 407 insertions(+), 3 deletions(-)
>> >  create mode 100644 arch/riscv/include/asm/efi.h
>> >  create mode 100644 arch/riscv/include/asm/sections.h
>> >  create mode 100644 arch/riscv/kernel/efi-header.S
>> >  create mode 100644 arch/riscv/kernel/image-vars.h
>> >  create mode 100644 drivers/firmware/efi/libstub/riscv-stub.c
>>
>>
>>
>> --
>> Regards,
>> Atish
>
> Hi Palmer,
> There were few build errors for all-yes config and nommu reported by
> 0-day tests.
> As some of the fixes require to add some dummy declarations for efi
> runtime related functions,
> Ard suggested that we should drop the series for now and merge with
> full uefi support later.

OK, I'll wait for another patch set.  That makes my life a bit easier as well,
as we don't have to do the multi-tree merge in a single release.
