Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85459161B48
	for <lists+linux-efi@lfdr.de>; Mon, 17 Feb 2020 20:11:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728889AbgBQTLA (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 17 Feb 2020 14:11:00 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59639 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727749AbgBQTLA (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 17 Feb 2020 14:11:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581966659;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vsDIkm7LcuaYgzQdXvjeLYGIluTZwoeMgvuGfii/8og=;
        b=iXFQT6nhA7av4n3K+nVmXGojTRzyM4EsPEqV4Ise/pr0UUnrFvQcd6FSS8/qf32j1qTEDk
        jLl/vWmbRxshXaZ+fnLhEz2CVbcdGSpqhREOK7blM3BUqaTXB3tjAPDXYlELbM0l23uAQR
        L3zYmC3gduxyOHA40FkLziHLSh2wUbI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-191-LMKG53w4Pu6aKDIOBmh64Q-1; Mon, 17 Feb 2020 14:10:53 -0500
X-MC-Unique: LMKG53w4Pu6aKDIOBmh64Q-1
Received: by mail-wm1-f71.google.com with SMTP id p26so164569wmg.5
        for <linux-efi@vger.kernel.org>; Mon, 17 Feb 2020 11:10:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vsDIkm7LcuaYgzQdXvjeLYGIluTZwoeMgvuGfii/8og=;
        b=e8RREbQvV6YkLAAgxo+Y5f99KyVSqFVayRJvoOeZ5G0bIWEH1Y9MY5hhq8Kw45Q1Sj
         m4mgOh2QQHoPv+P4euCzmFw5nPCk3BaoJOc1Trx/HdcU8EpBUGxENTxl83kezM0dEr2z
         m8GLsqI5uExduxygOiayHmf5FI9Gu/wsbEPuZwr93Yh9rqie6SxDDpStbaJ1LRsuLoqh
         65zOXGtE4EYyCd5CKXebvYYTNeFBS4cZx97UiHw5NROZwEM3EnZ01Dfo/eBAruIq3OJA
         O/9bytMiFhd79fgQoYRQ/I/6LcemzPsYuPD9zCnHdxATK7Lplex5rgf91mjM3hwy3Csz
         7zcg==
X-Gm-Message-State: APjAAAVTr6iwuyBZABdnpa3WkeTHgaT698V+GypPBqwE1C2UDtATI+ri
        x9IEepmoxyMIBxrTalcaqociBUjRDOAFyK2ZE27xUl18//XlxtoR/aMSVF9oWCqPMAistBzZjd3
        h2geiOkbO9fHgA78olX/+RQcrMH/xKO2qirF3
X-Received: by 2002:a5d:5485:: with SMTP id h5mr19369842wrv.346.1581966652468;
        Mon, 17 Feb 2020 11:10:52 -0800 (PST)
X-Google-Smtp-Source: APXvYqy2W+Do9mbl/R68triIgvVafhz3P423qEuLPfPsfDhryaTHHrYIbw4irtNBbdRLZQKhBtvRYA3UOCzsxbOjDeA=
X-Received: by 2002:a5d:5485:: with SMTP id h5mr19369814wrv.346.1581966652120;
 Mon, 17 Feb 2020 11:10:52 -0800 (PST)
MIME-Version: 1.0
References: <20200216141104.21477-1-ardb@kernel.org>
In-Reply-To: <20200216141104.21477-1-ardb@kernel.org>
From:   Bhupesh Sharma <bhsharma@redhat.com>
Date:   Tue, 18 Feb 2020 00:40:39 +0530
Message-ID: <CACi5LpN_Aqop1MQx3ouRd4V27GtiMXBiT=w916P1_zEEc2SJcQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] arch-agnostic initrd loading method for EFI systems
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Laszlo Ersek <lersek@redhat.com>, leif@nuviainc.com,
        Peter Jones <pjones@redhat.com>, mjg59@google.com,
        agraf@csgraf.de, ilias.apalodimas@linaro.org, xypron.glpk@gmx.de,
        daniel.kiper@oracle.com, nivedita@alum.mit.edu,
        James.Bottomley@hansenpartnership.com, lukas@wunner.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Ard,

On Sun, Feb 16, 2020 at 7:41 PM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> This series introduces an arch agnostic way of loading the initrd into
> memory from the EFI stub. This addresses a number of shortcomings that
> affect the current implementations that exist across architectures:
>
> - The initrd=<file> command line option can only load files that reside
>   on the same file system that the kernel itself was loaded from, which
>   requires the bootloader or firmware to expose that file system via the
>   appropriate EFI protocol, which is not always feasible. From the kernel
>   side, this protocol is problematic since it is incompatible with mixed
>   mode on x86 (this is due to the fact that some of its methods have
>   prototypes that are difficult to marshall)
>
> - The approach that is ordinarily taken by GRUB is to load the initrd into
>   memory, and pass it to the kernel proper via the bootparams structure or
>   via the device tree. This requires the boot loader to have an understanding
>   of those structures, which are not always set in stone, and of the policies
>   around where the initrd may be loaded into memory. In the ARM case, it
>   requires GRUB to modify the hardware description provided by the firmware,
>   given that the initrd base and offset in memory are passed via the same
>   data structure. It also creates a time window where the initrd data sits
>   in memory, and can potentially be corrupted before the kernel is booted.
>
> Considering that we will soon have new users of these interfaces (EFI for
> kvmtool on ARM, RISC-V in u-boot, etc), it makes sense to add a generic
> interface now, before having another wave of bespoke arch specific code
> coming in.
>
> Another aspect to take into account is that support for UEFI secure boot
> and measured boot is being taken into the upstream, and being able to
> rely on the PE entry point for booting any architecture makes the GRUB
> vs shim story much cleaner, as we should be able to rely on LoadImage
> and StartImage on all architectures, while retaining the ability to
> load initrds from anywhere.
>
> Note that these patches depend on a fair amount of cleanup work that I
> am targetting for v5.7. Branch can be found at:
> https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git/log/?h=next
>
> A PoC implementation for OVMF and ArmVirtQemu (OVMF for ARM aka AAVMF) can
> be found at https://github.com/ardbiesheuvel/edk2/commits/linux-efi-generic.
>
> A U-Boot implementation is under development as well, and can be found at
> https://github.com/apalos/u-boot/commits/efi_load_file_8

Thanks a lot for the patchset. I am still going through the patchset
and trying to understand how will it impact
kexec use-cases, namely:

1. kexec_load() and kecec_file_load(), use '--initrd=<file>' like
command line options.

2. We have several kexec based bootloader implementations (for example
linuxboot, see (a) and (b) below) that replaces specific firmware
functionality like the UEFI DXE phase with a Linux kernel and runtime
and find the initrd image (for example, uroot) from that same
filesystem. So these would need modification(s) similar to the OVMF
AAVMF and u-boot, right?

a. https://www.linuxboot.org/
b. https://github.com/linuxboot/linuxboot/blob/master/dxe/linuxboot.c

Thanks,
Bhupesh


> Changes since v1:
> - merge vendor media device path type definition with the existing device path
>   definitions we already have, and rework the latter slightly to be more easily
>   reusable
> - use 'dev_path' not 'devpath' consistently
> - pass correct FilePath value to LoadFile2 (i.e., the device path pointer that
>   was advanced to point to the 'end' node by locate_device_path())
> - add kerneldoc comment to efi_load_initrd_dev_path()
> - take care to only return EFI_NOT_FOUND from efi_load_initrd_dev_path() if the
>   LoadFile2 protocol does not exist on the LINUX_EFI_INITRD_MEDIA_GUID device
>   path - this makes the logic whether to fallback to the command line method
>   more robust
>
> Cc: lersek@redhat.com
> Cc: leif@nuviainc.com
> Cc: pjones@redhat.com
> Cc: mjg59@google.com
> Cc: agraf@csgraf.de
> Cc: ilias.apalodimas@linaro.org
> Cc: xypron.glpk@gmx.de
> Cc: daniel.kiper@oracle.com
> Cc: nivedita@alum.mit.edu
> Cc: James.Bottomley@hansenpartnership.com
> Cc: lukas@wunner.de
>
> Ard Biesheuvel (3):
>   efi/dev-path-parser: Add struct definition for vendor type device path
>     nodes
>   efi/libstub: Add support for loading the initrd from a device path
>   efi/libstub: Take noinitrd cmdline argument into account for devpath
>     initrd
>
>  drivers/firmware/efi/apple-properties.c       |  8 +-
>  drivers/firmware/efi/dev-path-parser.c        | 38 ++++----
>  drivers/firmware/efi/libstub/arm-stub.c       | 20 ++++-
>  .../firmware/efi/libstub/efi-stub-helper.c    | 89 +++++++++++++++++++
>  drivers/firmware/efi/libstub/efistub.h        |  5 ++
>  drivers/firmware/efi/libstub/x86-stub.c       | 47 ++++++++--
>  include/linux/efi.h                           | 49 ++++++----
>  7 files changed, 201 insertions(+), 55 deletions(-)
>
> --
> 2.17.1
>

