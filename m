Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 373CB161C25
	for <lists+linux-efi@lfdr.de>; Mon, 17 Feb 2020 21:08:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728899AbgBQUIV (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 17 Feb 2020 15:08:21 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21129 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728667AbgBQUIV (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 17 Feb 2020 15:08:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581970099;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QTc5ShnDqrR+1+XO2uWJHJ3GTXHe6seQTNXgYqcv050=;
        b=SF746+HfNpdBsqNEt8aJUlCyE60wdgVSewEV+D/VLmx4AIzNio5XXce/+Y+2dGqM9VWSoC
        mDHNW3qS/PZYjv6xI4QyFB6aKV+WKj/KH3N7bXohjeMQiylwQMeu/8CcqYRHdl2xyPOb1d
        WLp7Tis97ZrCLHcbGtmfoaagSC7PZ3c=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-420-epkQRERyM2KZCeYu_ATheg-1; Mon, 17 Feb 2020 15:08:13 -0500
X-MC-Unique: epkQRERyM2KZCeYu_ATheg-1
Received: by mail-wm1-f70.google.com with SMTP id p26so220887wmg.5
        for <linux-efi@vger.kernel.org>; Mon, 17 Feb 2020 12:08:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QTc5ShnDqrR+1+XO2uWJHJ3GTXHe6seQTNXgYqcv050=;
        b=tDlyCM2iksxxCmdTny+v2yvGxQLqze2llF0NhqPR5K4X7oGS+MkF1kNtFoH6Sz0sO2
         koMff26AdKMQuORmV7cs5kT1l6ZtRm2Dx3/bWENbBDmE7sR1NdI8xZaFQmFbWd5nNJK2
         GoGhxTNd6TPi1h+Fvp7fTYeEZ30bnrxXFFdUwAKWdh3Xzi6YqSG26zUm2NrFJY8B8U1W
         RKK/dEdGv99eISNadp5G9aBJO/x1n85Y/e11m6LLdDctqAWxUFBwOEGeDXSs7C4IE4gL
         0s/6/eQl8IdamdzUQPle7EDn+63tWGL+YdgxEtoSdQFnfkf9I+z7Y2231JrrucIREFhP
         dxxg==
X-Gm-Message-State: APjAAAWSIq6uTNPusXWE0TmsZJ0faJo4SWE9vuWm+AZfWiZHeHx5vmYI
        8pbrQOu/SN6jNyhctQm2aRs/dUvmefrQ3jUR/cCimHQHoMfd9VUaURzrGDQ6vzd8BzqCfBlSpAB
        MonAQ0wSZPUPzwuRO9h+AKRssG8Of6I8VCoQz
X-Received: by 2002:a5d:4a89:: with SMTP id o9mr22937400wrq.32.1581970092197;
        Mon, 17 Feb 2020 12:08:12 -0800 (PST)
X-Google-Smtp-Source: APXvYqwBPNbYpDQ1aePUMvoCymTJ3o8aI9190iGkocZIExkK5mvFNO4INHKfail93/yp5XBWPAppQh6hqH9zeyv55dg=
X-Received: by 2002:a5d:4a89:: with SMTP id o9mr22937374wrq.32.1581970091914;
 Mon, 17 Feb 2020 12:08:11 -0800 (PST)
MIME-Version: 1.0
References: <20200216141104.21477-1-ardb@kernel.org> <CACi5LpN_Aqop1MQx3ouRd4V27GtiMXBiT=w916P1_zEEc2SJcQ@mail.gmail.com>
 <CAKv+Gu9XOcQfQCbrEgNPQWY0WhGRFPJSPPDykRHDdX+E5B6DhQ@mail.gmail.com>
In-Reply-To: <CAKv+Gu9XOcQfQCbrEgNPQWY0WhGRFPJSPPDykRHDdX+E5B6DhQ@mail.gmail.com>
From:   Bhupesh Sharma <bhsharma@redhat.com>
Date:   Tue, 18 Feb 2020 01:37:59 +0530
Message-ID: <CACi5LpMBCa-E0uofr9gdW9sMHQ6Qr7QBj1kauQit-6VwBfNpEg@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] arch-agnostic initrd loading method for EFI systems
To:     Ard Biesheuvel <ardb@kernel.org>
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

On Tue, Feb 18, 2020 at 12:53 AM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Mon, 17 Feb 2020 at 20:11, Bhupesh Sharma <bhsharma@redhat.com> wrote:
> >
> > Hi Ard,
> >
> > On Sun, Feb 16, 2020 at 7:41 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> > >
> > > This series introduces an arch agnostic way of loading the initrd into
> > > memory from the EFI stub. This addresses a number of shortcomings that
> > > affect the current implementations that exist across architectures:
> > >
> > > - The initrd=<file> command line option can only load files that reside
> > >   on the same file system that the kernel itself was loaded from, which
> > >   requires the bootloader or firmware to expose that file system via the
> > >   appropriate EFI protocol, which is not always feasible. From the kernel
> > >   side, this protocol is problematic since it is incompatible with mixed
> > >   mode on x86 (this is due to the fact that some of its methods have
> > >   prototypes that are difficult to marshall)
> > >
> > > - The approach that is ordinarily taken by GRUB is to load the initrd into
> > >   memory, and pass it to the kernel proper via the bootparams structure or
> > >   via the device tree. This requires the boot loader to have an understanding
> > >   of those structures, which are not always set in stone, and of the policies
> > >   around where the initrd may be loaded into memory. In the ARM case, it
> > >   requires GRUB to modify the hardware description provided by the firmware,
> > >   given that the initrd base and offset in memory are passed via the same
> > >   data structure. It also creates a time window where the initrd data sits
> > >   in memory, and can potentially be corrupted before the kernel is booted.
> > >
> > > Considering that we will soon have new users of these interfaces (EFI for
> > > kvmtool on ARM, RISC-V in u-boot, etc), it makes sense to add a generic
> > > interface now, before having another wave of bespoke arch specific code
> > > coming in.
> > >
> > > Another aspect to take into account is that support for UEFI secure boot
> > > and measured boot is being taken into the upstream, and being able to
> > > rely on the PE entry point for booting any architecture makes the GRUB
> > > vs shim story much cleaner, as we should be able to rely on LoadImage
> > > and StartImage on all architectures, while retaining the ability to
> > > load initrds from anywhere.
> > >
> > > Note that these patches depend on a fair amount of cleanup work that I
> > > am targetting for v5.7. Branch can be found at:
> > > https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git/log/?h=next
> > >
> > > A PoC implementation for OVMF and ArmVirtQemu (OVMF for ARM aka AAVMF) can
> > > be found at https://github.com/ardbiesheuvel/edk2/commits/linux-efi-generic.
> > >
> > > A U-Boot implementation is under development as well, and can be found at
> > > https://github.com/apalos/u-boot/commits/efi_load_file_8
> >
>
> Hello Bhupesh,
>
> > Thanks a lot for the patchset. I am still going through the patchset
> > and trying to understand how will it impact
> > kexec use-cases, namely:
> >
> > 1. kexec_load() and kecec_file_load(), use '--initrd=<file>' like
> > command line options.
> >
>
> These should not be affected at all, since they don't go through the EFI stub.
>
> > 2. We have several kexec based bootloader implementations (for example
> > linuxboot, see (a) and (b) below) that replaces specific firmware
> > functionality like the UEFI DXE phase with a Linux kernel and runtime
> > and find the initrd image (for example, uroot) from that same
> > filesystem. So these would need modification(s) similar to the OVMF
> > AAVMF and u-boot, right?
> >
>
> These changes only affect the interaction between the EFI firmware and
> the EFI stub. Anything that relies on the raw x86 boot protocol (jump
> to offset 0x0 for 32-bit or offset 0x200 for 64-bit) or the EFI
> handover protocol (find the boot offset in the setup header and jump
> into the image at the discovered offset) will work as before, although
> the EFI handover protocol is something I would like to get rid of at
> some point in the future. Kexec typically mimics the handover between
> the EFI stub and the kernel, not the EFI firmware and the EFI stub, so
> I would not expect kexec to be affected at all by any of this.

Thanks a lot for the clarification, Ard. You are right, currently
there are several kexec based bootloader implementations which follow
a non-standard (?) way of handing over the control from EFI firmware
to the Linux kernel.

While we cannot be sure about all, but in future we can try and move
some of the popular ones to more standard ways of using Linux kenrel +
kexec as a partial firmware replacement.

> In general, the intent is to make kexec idempotent, i.e., to make the
> first boot as similar as we can to subsequent kexec boots, which is
> why we are pushing back against adding bespoke interfaces to pass ACPI
> rsdp pointer, smbios table addresses etc.

Got it. Thanks a lot for your clarification.

Regards,
Bhupesh

