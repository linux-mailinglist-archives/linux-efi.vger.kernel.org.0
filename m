Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30641161B8F
	for <lists+linux-efi@lfdr.de>; Mon, 17 Feb 2020 20:23:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728483AbgBQTX2 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 17 Feb 2020 14:23:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:43250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726788AbgBQTX1 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 17 Feb 2020 14:23:27 -0500
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F9F124658
        for <linux-efi@vger.kernel.org>; Mon, 17 Feb 2020 19:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581967406;
        bh=602xr8fGbZ4Uj6wDW+Ne5jhonEwkBVOajGL488Xv3nw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QiW9R5WBkYxI5ev+s1kOn4bR2TlTM+QMysiJ2EofVN6bgKM6nLs4Tii8mC67SeDcY
         RjbKUONzD7NZpS9jPjEPeiDPD/oB+/XNTsu4aDFEoSFXgTfwLZKJLCm9JgSRS7NGsj
         DOr0ab2UIt2+Uk6Bwewq1hnuNtmGmO5PqqH3uyVk=
Received: by mail-wr1-f45.google.com with SMTP id k11so21091206wrd.9
        for <linux-efi@vger.kernel.org>; Mon, 17 Feb 2020 11:23:26 -0800 (PST)
X-Gm-Message-State: APjAAAWnRZP5dcAzFnS7sui3Oq4IheVP8OTacOhs6yo1iHcwDfRc3nLv
        mqL8dRl5S4iUYH4vHjSvSKW1/QYiMGwCUc/UXd8QXA==
X-Google-Smtp-Source: APXvYqwsJMZfj7iGiljF60L1NGGN+k/xB8x4Q1WS1VC+9NZDJ4Klt+mARcgs7lpKKM8v2t73mxU9U0+5hcmUm7o/8AU=
X-Received: by 2002:a5d:65cf:: with SMTP id e15mr23324673wrw.126.1581967404448;
 Mon, 17 Feb 2020 11:23:24 -0800 (PST)
MIME-Version: 1.0
References: <20200216141104.21477-1-ardb@kernel.org> <CACi5LpN_Aqop1MQx3ouRd4V27GtiMXBiT=w916P1_zEEc2SJcQ@mail.gmail.com>
In-Reply-To: <CACi5LpN_Aqop1MQx3ouRd4V27GtiMXBiT=w916P1_zEEc2SJcQ@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 17 Feb 2020 20:23:13 +0100
X-Gmail-Original-Message-ID: <CAKv+Gu9XOcQfQCbrEgNPQWY0WhGRFPJSPPDykRHDdX+E5B6DhQ@mail.gmail.com>
Message-ID: <CAKv+Gu9XOcQfQCbrEgNPQWY0WhGRFPJSPPDykRHDdX+E5B6DhQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] arch-agnostic initrd loading method for EFI systems
To:     Bhupesh Sharma <bhsharma@redhat.com>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Laszlo Ersek <lersek@redhat.com>,
        Leif Lindholm <leif@nuviainc.com>,
        Peter Jones <pjones@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        Alexander Graf <agraf@csgraf.de>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Daniel Kiper <daniel.kiper@oracle.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Lukas Wunner <lukas@wunner.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, 17 Feb 2020 at 20:11, Bhupesh Sharma <bhsharma@redhat.com> wrote:
>
> Hi Ard,
>
> On Sun, Feb 16, 2020 at 7:41 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > This series introduces an arch agnostic way of loading the initrd into
> > memory from the EFI stub. This addresses a number of shortcomings that
> > affect the current implementations that exist across architectures:
> >
> > - The initrd=<file> command line option can only load files that reside
> >   on the same file system that the kernel itself was loaded from, which
> >   requires the bootloader or firmware to expose that file system via the
> >   appropriate EFI protocol, which is not always feasible. From the kernel
> >   side, this protocol is problematic since it is incompatible with mixed
> >   mode on x86 (this is due to the fact that some of its methods have
> >   prototypes that are difficult to marshall)
> >
> > - The approach that is ordinarily taken by GRUB is to load the initrd into
> >   memory, and pass it to the kernel proper via the bootparams structure or
> >   via the device tree. This requires the boot loader to have an understanding
> >   of those structures, which are not always set in stone, and of the policies
> >   around where the initrd may be loaded into memory. In the ARM case, it
> >   requires GRUB to modify the hardware description provided by the firmware,
> >   given that the initrd base and offset in memory are passed via the same
> >   data structure. It also creates a time window where the initrd data sits
> >   in memory, and can potentially be corrupted before the kernel is booted.
> >
> > Considering that we will soon have new users of these interfaces (EFI for
> > kvmtool on ARM, RISC-V in u-boot, etc), it makes sense to add a generic
> > interface now, before having another wave of bespoke arch specific code
> > coming in.
> >
> > Another aspect to take into account is that support for UEFI secure boot
> > and measured boot is being taken into the upstream, and being able to
> > rely on the PE entry point for booting any architecture makes the GRUB
> > vs shim story much cleaner, as we should be able to rely on LoadImage
> > and StartImage on all architectures, while retaining the ability to
> > load initrds from anywhere.
> >
> > Note that these patches depend on a fair amount of cleanup work that I
> > am targetting for v5.7. Branch can be found at:
> > https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git/log/?h=next
> >
> > A PoC implementation for OVMF and ArmVirtQemu (OVMF for ARM aka AAVMF) can
> > be found at https://github.com/ardbiesheuvel/edk2/commits/linux-efi-generic.
> >
> > A U-Boot implementation is under development as well, and can be found at
> > https://github.com/apalos/u-boot/commits/efi_load_file_8
>

Hello Bhupesh,

> Thanks a lot for the patchset. I am still going through the patchset
> and trying to understand how will it impact
> kexec use-cases, namely:
>
> 1. kexec_load() and kecec_file_load(), use '--initrd=<file>' like
> command line options.
>

These should not be affected at all, since they don't go through the EFI stub.

> 2. We have several kexec based bootloader implementations (for example
> linuxboot, see (a) and (b) below) that replaces specific firmware
> functionality like the UEFI DXE phase with a Linux kernel and runtime
> and find the initrd image (for example, uroot) from that same
> filesystem. So these would need modification(s) similar to the OVMF
> AAVMF and u-boot, right?
>

These changes only affect the interaction between the EFI firmware and
the EFI stub. Anything that relies on the raw x86 boot protocol (jump
to offset 0x0 for 32-bit or offset 0x200 for 64-bit) or the EFI
handover protocol (find the boot offset in the setup header and jump
into the image at the discovered offset) will work as before, although
the EFI handover protocol is something I would like to get rid of at
some point in the future. Kexec typically mimics the handover between
the EFI stub and the kernel, not the EFI firmware and the EFI stub, so
I would not expect kexec to be affected at all by any of this.

In general, the intent is to make kexec idempotent, i.e., to make the
first boot as similar as we can to subsequent kexec boots, which is
why we are pushing back against adding bespoke interfaces to pass ACPI
rsdp pointer, smbios table addresses etc.
