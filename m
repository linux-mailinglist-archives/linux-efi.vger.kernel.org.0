Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A913F155790
	for <lists+linux-efi@lfdr.de>; Fri,  7 Feb 2020 13:23:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbgBGMXy (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 7 Feb 2020 07:23:54 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37101 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726857AbgBGMXy (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 7 Feb 2020 07:23:54 -0500
Received: by mail-wr1-f68.google.com with SMTP id w15so2467015wru.4
        for <linux-efi@vger.kernel.org>; Fri, 07 Feb 2020 04:23:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s9mNwVu6UPwo3klOK1lw0yhyo/vVobSRmEvvb899H58=;
        b=L1cK9vbufGotk/HgkzB7S2+EQkpwMxchGem3wDs/FKK4BBbGBH0AvDxSHPDeb69cz8
         2GikMX23rqtud4Xk91boYi8tYBciFM4FcHNnksPW4Rin9u6yPGQc1353hawQ9a2YeWY3
         88g4eFBZXJyla2nJONjucsXysrqb4X9wyUEMSA1t8x+6eoH0dVgovf/qJlAvelp+s4Pm
         v8rPq4YXkfm4IMQ8sikhCgKXac27Yhs9SFftBC7qI95/aFAj+dL4Zrv8N05ZuuJFavxv
         8rZ59NWvA02nIS3iavAp8m5n7Bk1qfjp3v/5SsQDpDxq2pfmc95L3eahNK2XvV/qec2q
         Jpgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s9mNwVu6UPwo3klOK1lw0yhyo/vVobSRmEvvb899H58=;
        b=kRiIQWnbMd22Z29oN01KEmpldhXT5yUKfZctdiSXDWxmEX/vl7Dqz5OXf7GrQ6K1xv
         diLMBUzVeJ9N9BI9pA22tB+AvOSY6UgPf+aSPh7K5YQO+cmK42C/Nz9YtS/xQdw4KA+6
         qKXTntTEMv9J23Q1X3iMzbJQoNO5j1t118wakol4oEUbcvfMLwUjrZ/uxA0xsvdAgtsi
         MtIxeciUb+qJZU40E0COfcwODKVGiO9gS2fJDRtNhz49Zk/64fowVVWlI+S+qLj3RUQG
         08f7evWhptRFeKbGPViYKcCY6GB6376BYYWY9gyzHI7uwqepBCe85rFn0SCMeC/Sxq84
         gpzg==
X-Gm-Message-State: APjAAAUGX6hyRsf6WoRLSKE5R+MaUy7ljXAZVfCZJCC194mh6wz5qScc
        dnmOrlIfWJk10uv8V1+8m6R/vjDE0ZoQZ8CbWtf1ww==
X-Google-Smtp-Source: APXvYqy1aja7klc/f3krQcz8ds8Vg7AEMMftrJr2tmzUb7q+R0CRNxzD+d0Cx8d5MnI4Eker20sH0AJ0tE/1+0PUoJY=
X-Received: by 2002:adf:8564:: with SMTP id 91mr4649217wrh.252.1581078230421;
 Fri, 07 Feb 2020 04:23:50 -0800 (PST)
MIME-Version: 1.0
References: <20200206140352.6300-1-ardb@kernel.org> <fa3b3103-e77d-571d-71a4-604fa48368e6@redhat.com>
 <cfb38b38-14f2-c61a-60a0-dfe14667b49c@redhat.com>
In-Reply-To: <cfb38b38-14f2-c61a-60a0-dfe14667b49c@redhat.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 7 Feb 2020 12:23:39 +0000
Message-ID: <CAKv+Gu__fUGyv4eu5oKcsVZYSbKRfYYd_VS8CGEV4jC+GuvqJA@mail.gmail.com>
Subject: Re: [PATCH 0/2] arch-agnostic initrd loading method for EFI systems
To:     Laszlo Ersek <lersek@redhat.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Leif Lindholm <leif@nuviainc.com>,
        Peter Jones <pjones@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        Alexander Graf <agraf@csgraf.de>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Daniel Kiper <daniel.kiper@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 7 Feb 2020 at 09:22, Laszlo Ersek <lersek@redhat.com> wrote:
>
> On 02/07/20 10:09, Laszlo Ersek wrote:
> > On 02/06/20 15:03, Ard Biesheuvel wrote:
> >> This series introduces an arch agnostic way of loading the initrd into
> >> memory from the EFI stub. This addresses a number of shortcomings that
> >> affect the current implementations that exist across architectures:
> >>
> >> - The initrd=<file> command line option can only load files that reside
> >>   on the same file system that the kernel itself was loaded from, which
> >>   requires the bootloader or firmware to expose that file system via the
> >>   appropriate EFI protocol, which is not always feasible. From the kernel
> >>   side, this protocol is problematic since it is incompatible with mixed
> >>   mode on x86 (this is due to the fact that some of its methods have
> >>   prototypes that are difficult to marshall)
> >>
> >> - The approach that is ordinarily taken by GRUB is to load the initrd into
> >>   memory, and pass it to the kernel proper via the bootparams structure or
> >>   via the device tree. This requires the boot loader to have an understanding
> >>   of those structures, which are not always set in stone, and of the policies
> >>   around where the initrd may be loaded into memory. In the ARM case, it
> >>   requires GRUB to modify the hardware description provided by the firmware,
> >>   given that the initrd base and offset in memory are passed via the same
> >>   data structure. It also creates a time window where the initrd data sits
> >>   in memory, and can potentially be corrupted before the kernel is booted.
> >>
> >> Considering that we will soon have new users of these interfaces (EFI for
> >> kvmtool on ARM, RISC-V in u-boot, etc), it makes sense to add a generic
> >> interface now, before having another wave of bespoke arch specific code
> >> coming in.
> >>
> >> Another aspect to take into account is that support for UEFI secure boot
> >> and measured boot is being taken into the upstream, and being able to
> >> rely on the PE entry point for booting any architecture makes the GRUB
> >> vs shim story much cleaner, as we should be able to rely on LoadImage
> >> and StartImage on all architectures, while retaining the ability to
> >> load initrds from anywhere.
> >>
> >> Note that these patches depend on a fair amount of cleanup work that I
> >> am targetting for v5.7. Branch can be found at:
> >> https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/log/?h=efistub-unification2
> >>
> >> An implementation for ArmVirtQemu (OVMF for ARM aka AAVMF) can be found
> >> at https://github.com/ardbiesheuvel/edk2/commits/linux-efi-generic.
> >> The change is for ARM only, but the exact same code could be used on x86.
> >
> > I like this ArmVirtQemu feature, but I think it should be implemented as
> > an addition, rather than a replacement. Older kernels (older EFI stubs)
> > will try to fetch the initrd from the same fs where grub loaded the
> > kernel from (exactly as you describe in the blurb).
> >

Agreed. The ArmVirtQemu change is not intended for merging, but
primarily as a test rig for the kernel changes.

> > For example, virt-install's "--location" option "can recognize certain
> > distribution trees and fetches a bootable kernel/initrd pair to launch
> > the install". It would be nice to keep that working for older distros.
> >
> > I think LoadFile[2] can co-exist with SimpleFs.
> >
> > I also think that the "try SimpleFs first, fall back to LoadFile[2]
> > second" requirement applies only to the UEFI boot manager, and not to
> > the kernel's EFI stub. IOW in the new approach the kernel is free to
> > ignore (abandon) the old approach for good.
>
> ... But that might not be good for compatibility with grub and/or the
> platform firmware, from the kernel's own perspective, perhaps?...
>
> Who is supposed to produce LoadFile2 with the new VenMedia devpath?
>

What I am ultimately after is a generic GRUB that uses
LoadImage+Startimage for starting the kernel on all architectures, and
is able to load the initrd from anywhere in an arch agnostic manner.

Additionally, we might have
- an implementation for OVMF/AAVMF,
- a EDK2 UEFI Shell command that takes a shell file path to provide
the Linux initrd
- a uboot implementation that passes the initrd this way.

This series is the first step, to align between all the stakeholders
on the approach for this aspect, before taking it any further.
