Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC5119F0D0
	for <lists+linux-efi@lfdr.de>; Mon,  6 Apr 2020 09:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbgDFHdB (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 6 Apr 2020 03:33:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:48266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726491AbgDFHdB (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 6 Apr 2020 03:33:01 -0400
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 57B2920731;
        Mon,  6 Apr 2020 07:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586158380;
        bh=Ms5RsENvJRoFDdb9eiP3YLO9VeSzIi6xAFAgFda9T6o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=b7lVTB5lr9hZ+3dVyig/Cnn0Cs6y0NXNsLNwVL27F91zsnfPU4+X9prGzj0vRt7UE
         xr9O2/eOICdzw1ybRAOQNInnZ/94cLujisQCsmINUuz6rQDE3WiaknJFVngP+OsFg4
         4oDI2NOZDX9VvjYSBcBQxsTHE9fAuY/smFeKAvgM=
Received: by mail-il1-f180.google.com with SMTP id x16so13689772ilp.12;
        Mon, 06 Apr 2020 00:33:00 -0700 (PDT)
X-Gm-Message-State: AGi0PuZ8JXIOK1uCHvxVfyct9URSI/NvIvsjlQwptwbrfzP3PT6T3RKm
        ddAEXymQ7FdIWJ0kx8zDPgiZK+m9Yap6YOZIW9Y=
X-Google-Smtp-Source: APiQypLiaf9UohKxh3Y13jY61LCk2hUM4qVVKLN28RCHu30r14ussVsd2kZGb2FbBMTCwX6hSVz0TUifcWwc1mR+TAM=
X-Received: by 2002:a92:443:: with SMTP id 64mr20350053ile.258.1586158379626;
 Mon, 06 Apr 2020 00:32:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200109150218.16544-1-nivedita@alum.mit.edu> <20200405154245.11972-1-me@prok.pw>
 <20200405231845.GA3095309@rani.riverdale.lan> <c692eea9213172d8ef937322b02ff585b0dfea82.camel@prok.pw>
 <20200406035110.GA3241052@rani.riverdale.lan>
In-Reply-To: <20200406035110.GA3241052@rani.riverdale.lan>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 6 Apr 2020 09:32:47 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEUhyv886CjyKvjw2F12WaZxZRUWF6t_XzP4C2TJPdpeg@mail.gmail.com>
Message-ID: <CAMj1kXEUhyv886CjyKvjw2F12WaZxZRUWF6t_XzP4C2TJPdpeg@mail.gmail.com>
Subject: Re: [PATCH 1/2] x86/boot/compressed/64: Remove .bss/.pgtable from bzImage
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Sergey Shatunov <me@prok.pw>, bp@alien8.de, hpa@zytor.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        mingo@redhat.com, Thomas Gleixner <tglx@linutronix.de>,
        x86@kernel.org, linux-efi <linux-efi@vger.kernel.org>,
        initramfs@vger.kernel.org,
        Donovan Tremura <neurognostic@protonmail.ch>,
        Harald Hoyer <harald@hoyer.xyz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, 6 Apr 2020 at 05:51, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> On Mon, Apr 06, 2020 at 07:00:39AM +0700, Sergey Shatunov wrote:
> > On Sun, 2020-04-05 at 19:18 -0400, Arvind Sankar wrote:
> > > I'm not familiar with systemd-boot: when you say systemd-boot stub,
> > > is
> > > that something different from the kernel's EFI_STUB option? Or is it
> > > just a kernel with EFI_STUB enabled and with builtin initramfs +
> > > builtin
> > > cmdline?
> > Basicaly systemd-boot stub is efi application with packed EFI_STUB-
> > enabled kernel, initrd and cmdline into single file. Source can be
> > found here:
> > https://github.com/systemd/systemd/blob/master/src/boot/efi/stub.c
> >
> > It doesn't do anything unusual, just extracting data from sections and
> > calling efi handover.
> >
> > Final image created by objcopy'ing precompiled stub and adding sections with that stuff:
> >
> >     objcopy \
> >         --add-section .osrel=os_release --change-section-vma
> > '.osrel=0x20000' \
> >         --add-section .cmdline=cmdline --change-section-vma
> > '.cmdline=0x30000' \
> >         --add-section .linux=vmlinuz --change-section-vma
> > '.linux=0x2000000' \
> >         --add-section .initrd=initrd --change-section-vma
> > '.initrd=0x3000000' \
> >         /usr/lib/systemd/boot/efi/linuxx64.efi.stub output.efi
>
> So this embeds the bzImage which is a PE executable inside another PE
> executable. Before my patch, the bss section was explicitly part of the
> bzImage and so would have been zero, now it isn't any more and the PE
> loader is expected to zero it out before executing. systemd-boot's stub
> loader doesn't do that prior to jumping to the EFI handover entry, so
> the issue must be because bss contains garbage.  I'm not 100% sure why
> that leads to a crash, as the only variables in bss in the EFI stub are
> for some boolean EFI command line arguments, so it ought to still have
> worked, just as though it was invoked with random arguments. Anyway we
> need to handle an uninitialized bss to get this to work properly.
>

The EFI handover protocol strikes again :-(

It seems we did not include any guidance in the documentation in
Documentation/x86/boot.rst regarding zero-initializing BSS, and come
to think of it, we don't include any other requirements either, i.e.,
regarding placement wrt section alignment etc. This is a serious bug.
Even though EFI usually lays out PE/COFF images in files the exact way
they appear in memory, this is not actually required by the spec. Most
notably, the virtual size can be smaller than the file size, and the
loader is expected to zero-initialize the difference as well.

Since the EFI handover protocol should be considered deprecated at
this point (and is never going to be supported in upstream GRUB
either, for instance), I would recommend the systemd-boot developers
to start looking into deprecating this as well, and switch to the
ordinary PE/COFF entry point, and use the new initrd callback protocol
for initrd loading.

On the Linux/x86 side, we should at least add some code to the EFI
handover protocol entry point to zero initialize BSS, and ensure that
it is either not needed in other places, or add the code to deal with
those as well.

> I also see from systemd [0] and dracut source [1] that these VMA's seem
> to be hardcoded with no checking for how big the files actually are, and
> objcopy doesn't seem to complain if sections end up overlapping.
>
> So since [2] in dracut, the space available for the .linux section
> containing the bzImage shrank from ~48MiB to 16MiB. This will hopefully
> still fit the compressed kernel (although an allyesconfig bzImage is far
> bigger than even 48MiB), but in-place decompression is unlikely to be
> possible even for a normal config, which will break another patchset
> that got merged into mainline for 5.7 [3,4], which tries to avoid
> copying the kernel unless necessary, and has a good chance of triggering
> in-place decompression if kaslr is disabled.
>
> I'll get systemd-boot installed here so I can reproduce and implement
> some workarounds for both issues. I should hopefully have a fix in a day
> or two.
>

Thanks Arvind.
