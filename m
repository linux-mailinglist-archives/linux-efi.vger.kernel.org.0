Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3B46262278
	for <lists+linux-efi@lfdr.de>; Wed,  9 Sep 2020 00:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729525AbgIHWMu (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 8 Sep 2020 18:12:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726694AbgIHWMt (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 8 Sep 2020 18:12:49 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF9EC061573
        for <linux-efi@vger.kernel.org>; Tue,  8 Sep 2020 15:12:48 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id y2so492470lfy.10
        for <linux-efi@vger.kernel.org>; Tue, 08 Sep 2020 15:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BZkMavbqjh4tF5e5xy74hwsNQ+WgdMeOkzIbaHvyv+8=;
        b=O65EPKCIF9cPCAi7YzG0xiI+1DZHcDTRwWRVbdoFJAbw8UUOiqdbeGL5rEF0uMP4+k
         x+vGK8lBaFSgwqSvdJH7yXwcS3CkloUlMvLFYLxzO0V3bDKEi+W3RHiEdrbUgHS699Pv
         /dC9ZAWMxHNnR1Ze3dWT2Y5DP7/UyNcVf2KbX2mCjJ1lnLWhi3RD7PE37euUZWebRTE4
         +wbPNtwP18671698XZAwDMsB2Q41sWhmUvimth/dklIt+3XB7ECQD2gsNIbeuy4kpXVW
         CFOcGGZeqR4QNnIhSrnFalSdN4jV1/WI2Lm2Ubi0TXZ9jjPzE5FbNGcadDUXnAzJbYYr
         Ib9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BZkMavbqjh4tF5e5xy74hwsNQ+WgdMeOkzIbaHvyv+8=;
        b=V8jqR8KplsSiOrmvpWzqvWt3kNsEodEjdaK43qFYHzpYzGUU6m75xwlJf4wh1aBqTk
         dTr6TdLoHQPHrTVtvMFqVfQTOc8YIjlzRfsuXGOeceeWl5TBRQ+FrRRykbYdoaq9sqsx
         CI+zX8nULwS1/sb4TLTGi8LbbPhkwA5iAK9661h7hI/y8wvqHeMz2HxnxErJ72ahZ4Hr
         5y9paQKuiGgR2ToCeB48yr60s2c36YcklU83AH7qYJJsUfe1OgQHjfwv0OBFxv9Xs/rh
         87azaDT6/nEl8gqK+BwyQjD6o4XELsbgwQaxmJXD1uNwsUW81hqpK0OhN4axVO6K0RVV
         +KsQ==
X-Gm-Message-State: AOAM531ljr6o2Z15vxUr5bambIT4XChWDuyicpjIMLY7TBP8Uy7+30PZ
        DzG3MwVOln5aDysqOwJ9xwZEfT8apWgFm/NHlog=
X-Google-Smtp-Source: ABdhPJyUnZIFJ2LYI6oOrQE2i7vTEOHOVio7AvRaZXRfdJ8s3q41ZJkxSSL/1jhXmoBRLPuoUsIgoTqt4sK1m8ldAcU=
X-Received: by 2002:a19:4402:: with SMTP id r2mr479587lfa.111.1599603166850;
 Tue, 08 Sep 2020 15:12:46 -0700 (PDT)
MIME-Version: 1.0
References: <CAO18KQgxfCBFacLxpLZJZ6iDmEA83DUwG2kjfPyJmPZHPQZ5vQ@mail.gmail.com>
 <20200907170021.GA2284449@rani.riverdale.lan>
In-Reply-To: <20200907170021.GA2284449@rani.riverdale.lan>
From:   Jacobo Pantoja <jacobopantoja@gmail.com>
Date:   Wed, 9 Sep 2020 00:12:35 +0200
Message-ID: <CAO18KQg9wLFF8KxZdP4fVv-vk_CpfV+_v38WnCJ-uqEAJ3FNwA@mail.gmail.com>
Subject: Re: EFISTUB arguments in Dell BIOS
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     ardb@kernel.org, linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Sorry for the delay. I accidentally bricked the machine during a BIOS updated.
It is recovered now.

On Mon, 7 Sep 2020 at 19:00, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> On Mon, Sep 07, 2020 at 05:30:39PM +0200, Jacobo Pantoja wrote:
> > Hi Arvind and Ard:
> >
> > First, I'm sorry to use a direct email communication instead of a mailing
> > list, but honestly at this point I cannot guess the correct procedure. If
> > this should be managed from a mailing list, please be so kind to indicate
> > to me which one would it be. I've seen that you have authored some commits
> > regarding EFISTUB, so I guess you can at the very least direct me in the
> > right way.
>
> Adding linux-efi to Cc.
Thank you very much

>
> >
> > Now the problem, related to EFISTUB and argument passing: I've setup a Dell
> > workstation for use with ArchLinux, as the rest of my machines, but I've
> > faced a problem when using EFI boot stub: kernel arguments are not passed,
> > _apparently_. I've seen in [1], [2], [3] and [4] that it might be a common
> > problem to Dell's BIOS implementation, not passing the arguments to the
> > kernel at all.
>
> Just to check, are you directly booting from firmware into the EFI stub,
> or do you have something (grub2/systemd-boot/refind etc) in between?
> Which kernel version are you using, and are you able to compile your own
> kernel with patches for testing? If so, we should be able to add in some
> debug statements in the EFI stub itself to see what the firmware passed
> it as the command line, and if it's getting truncated or something.
>
Yes I'm booting directly from firmware into EFI stub, no
grub2/systemd-boot/refind
involved. My current kernel is 5.8.5.
I'm able to compile kernel with patches, no problem.
As a side note, the exact same kernel with the exact same efibootmgr command
is booting in other machines (different models).

> >
> > Now the _apparently_ part. I have a simple script to create the bootloader
> > entry, and it is properly working in at least 3 different machines.
> > * If I simply leave the command line empty (i.e. I pass no arguments, i.e.
> > no --unicode "..." section in the efibootmgr command): I can see a blank
> > screen.
> > * However, if I specify my initramfs via the "initrd=\..." argument (i.e.
> > efibootmgr ... -u "initrd=...."), it properly boots up to a rescue console.
> >
> > In the rescue console, I can see that /proc/cmdline is empty. As no root
> > has been specified, the boot process cannot continue. If I manually mount
> > the root fs and exit the console, the boot is completed (with no arguments,
> > obviously).
>
> If you boot directly from firmware, the EFI stub is what would load the
> initramfs, and at least the initrd= argument should be in /proc/cmdline
> after boot.
>
That is weird; I can see the difference between including initrd arg or not
including, but "cat /proc/cmdline" returns a blank line. Hexdump reveals
that it is really 0x01 0x0a. I'm 100% sure the initramfs is being loaded when
passed as an argument, although the cmdline does not reflect it.

> >
> > That said, I can boot in several different ways, but I'd like to understand
> > the problem, and solve it if possible.
> > My understanding is that the firmware *is* actually passing somehow the
> > arguments (because initramfs is properly mounted), but somehow the
> > arguments are being discarded or something. *Is there a way I can properly
> > debug this?* I'm a bit lost in the kernel tree, I see a lot of ASM that I
> > don't understand so I don't know how to debug.
> >
>
> Does efibootmgr -v show the complete command line (i.e. both initrd and
> any rootfs argument), so we're sure the full command line did make it to
> NVRAM? Check it after a power cycle so we can cross at least that off
> the list.
>
Yes, I'm including here my efibootmgr command, and the output after calling
with -v. Line breaks are simply for the email readability.

$ efibootmgr --disk /dev/disk/by-id/ata-(...) --part 1 --create
--label "ArchLinux" \
  --loader /vmlinuz-linux --unicode "root=LABEL=ArchRoot rw quiet \
  initrd=\intel-ucode.img initrd=\initramfs-linux.img intel_iommu=on audit=0"

$ efibootmgr -v
Boot0000* ArchLinux
HD(1,GPT,b0fd4cf1-1566-4c71-b214-c3c0c5924fea,0x800,0xfa000)/File(\vmlinuz-linux)r.o.o.t.=.L.A.B.E.L.=.A.r.c.h.R.o.o.t.
.r.w. .q.u.i.e.t. .i.n.i.t.r.d.=.\.i.n.t.e.l.-.u.c.o.d.e...i.m.g.
.i.n.i.t.r.d.=.\.i.n.i.t.r.a.m.f.s.-.l.i.n.u.x...i.m.g.
.i.n.t.e.l._.i.o.m.m.u.=.o.n. .a.u.d.i.t.=.0.

I've just checked right after a power cycle, with the exact same result:
1) No parameters appended in efibootmgr => black screen
2) Parameters appended in efibootmgr => boots to rescue shell

> > Thank you very much in advance,
> > JPantoja
> >
> > [1]:
> > https://www.dell.com/community/Linux-Developer-Systems/Linux-EFISTUB/td-p/4586378
> > [2]:
> > https://www.dell.com/community/Laptops-General-Read-Only/Dell-UEFI-implementation-does-not-support-Linux-Kernel-EFISTUB/td-p/5185272
> > [3]: https://bbs.archlinux.org/viewtopic.php?pid=1753169#p1753169
> > [4]: https://github.com/xdever/arch-efiboot
