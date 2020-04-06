Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A12B19F221
	for <lists+linux-efi@lfdr.de>; Mon,  6 Apr 2020 11:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbgDFJLe (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 6 Apr 2020 05:11:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:57746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726689AbgDFJLe (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 6 Apr 2020 05:11:34 -0400
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C6E12078A;
        Mon,  6 Apr 2020 09:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586164293;
        bh=IEKnLroPOXhZZoEjwk2Sy7qHL1p/3PpX8cAZjySktEg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=x9/XnaHxSYASdAnWEA1KJzzEgemj3vDGBjEXM3ZS/mXiYMEt9DQ0mPtb0MiA+/29Y
         +kCeLxo9TBIfyZSeU3y51QeFqzPHoFJwv+7AsMuW4PnVgUifoqVMoKIWZOPhq55kOi
         pVVdq0uKWDmwPU73ZYVXd9jmL6nD/cuzCdeXqVa8=
Received: by mail-io1-f47.google.com with SMTP id o3so15016926ioh.2;
        Mon, 06 Apr 2020 02:11:33 -0700 (PDT)
X-Gm-Message-State: AGi0PuapjANHW4VO8VO6oiRiB4Y98aWNUuCGaZXoWBGpkzkewu0xYMuV
        jkaTDn8/aNZH+I6KsID7rmIvziKT/7zZJSP6ztA=
X-Google-Smtp-Source: APiQypJ08+HDD3z4MBXBa9W9lMQHNod6bQSMdsaxyTfs2CUw/1PrNMe5MnrwEhdaeSq/8Hso8MUAfaqal+pRLZa+9IU=
X-Received: by 2002:a6b:f413:: with SMTP id i19mr18808491iog.203.1586164292977;
 Mon, 06 Apr 2020 02:11:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200109150218.16544-1-nivedita@alum.mit.edu> <20200405154245.11972-1-me@prok.pw>
 <20200405231845.GA3095309@rani.riverdale.lan> <c692eea9213172d8ef937322b02ff585b0dfea82.camel@prok.pw>
 <20200406035110.GA3241052@rani.riverdale.lan> <CAMj1kXEUhyv886CjyKvjw2F12WaZxZRUWF6t_XzP4C2TJPdpeg@mail.gmail.com>
 <20200406084738.GA2520@zn.tnic>
In-Reply-To: <20200406084738.GA2520@zn.tnic>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 6 Apr 2020 11:11:21 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHAieZDvPKfjF=J+G=QVS+=XS-b4RP_=mjCEFEB_E_+Qw@mail.gmail.com>
Message-ID: <CAMj1kXHAieZDvPKfjF=J+G=QVS+=XS-b4RP_=mjCEFEB_E_+Qw@mail.gmail.com>
Subject: Re: [PATCH 1/2] x86/boot/compressed/64: Remove .bss/.pgtable from bzImage
To:     Borislav Petkov <bp@alien8.de>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Sergey Shatunov <me@prok.pw>, hpa@zytor.com,
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

On Mon, 6 Apr 2020 at 10:47, Borislav Petkov <bp@alien8.de> wrote:
>
> On Mon, Apr 06, 2020 at 09:32:47AM +0200, Ard Biesheuvel wrote:
> > The EFI handover protocol strikes again :-(
> >
> > It seems we did not include any guidance in the documentation in
> > Documentation/x86/boot.rst regarding zero-initializing BSS, and come
> > to think of it, we don't include any other requirements either, i.e.,
> > regarding placement wrt section alignment etc. This is a serious bug.
> > Even though EFI usually lays out PE/COFF images in files the exact way
> > they appear in memory, this is not actually required by the spec. Most
> > notably, the virtual size can be smaller than the file size, and the
> > loader is expected to zero-initialize the difference as well.
>
> Is that expectation stated explicitly somewhere?
>

Yes, it is in the PE/COFF specification. [0]

The whole problem is that we are conflating 'loading a PE/COFF image'
with 'copying a PE/COFF image into memory', which are not the same
thing. It is not just the layout issue, we are running into other
problems with things like UEFI secure boot and TPM-based measured
boot, where the fact that omitting the standard LoadImage() boot
service (which takes care of these things under the hood) means that
you now have to do your own checks and measurements. These things are
literally all over the place at the moment, shim, GRUB, systemd-boot
etc, with no authoritative spec that describes which component should
be doing what.

> > Since the EFI handover protocol should be considered deprecated at
> > this point (and is never going to be supported in upstream GRUB
> > either, for instance), I would recommend the systemd-boot developers
> > to start looking into deprecating this as well, and switch to the
> > ordinary PE/COFF entry point, and use the new initrd callback protocol
> > for initrd loading.
>
> Any pointers to that new initrd callback protocol?
>

Commit ec93fc371f014a6fb483e3556061ecad4b40735c has the background, but ...

> In any case, I'd really appreciate a patch to boot.rst formulating those
> requirements so that they're written down and people can find them.
>

... I'll look into updating the documentation as well. Note that this
stuff is hot off the press, so there may be some issues lurking (like
this one) that we hadn't thought of yet.

OVMF and u-boot already have implementations of this initrd loading
approach. A GRUB version is under discussion.

> > On the Linux/x86 side, we should at least add some code to the EFI
> > handover protocol entry point to zero initialize BSS, and ensure that
> > it is either not needed in other places, or add the code to deal with
> > those as well.
>
> Sounds like a simple fix, if that would fix it.
>

Actually, it may be sufficient to #define __efistub_global to
__section(.data) like we already do for ARM, to ensure that these
global flags are always initialized correctly. (I'll wait for Sergey
to confirm that the spurious enabling of the PCI DMA protection
resulting from this BSS issue is causing the boot regression)



[0] https://docs.microsoft.com/en-us/windows/win32/debug/pe-format
