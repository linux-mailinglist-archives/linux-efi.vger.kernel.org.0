Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E56EA19F6F0
	for <lists+linux-efi@lfdr.de>; Mon,  6 Apr 2020 15:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728308AbgDFN3c (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 6 Apr 2020 09:29:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:36232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728304AbgDFN3c (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 6 Apr 2020 09:29:32 -0400
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 76F74221EC;
        Mon,  6 Apr 2020 13:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586179770;
        bh=cT5aiBiaDN+mknjSAU1YJCKd3LpD4afmF92dqiFWPcs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OpaU/fdXCVzLI+98p0c4cHjYadRosyr2ugnFykx08WKOfHe2O+mFvPzbxT3GEbUDx
         V+74Gj1UWcxUc+ZAbUtKKViEOhCJ8hzXrxE1DcUnqhiZs+TPSSreflaI+K594kxDxH
         kpp4vjzOcjkRbilKMjZUCN7a8kNNfCjcve7/Ps28=
Received: by mail-il1-f169.google.com with SMTP id 7so14651210ill.2;
        Mon, 06 Apr 2020 06:29:30 -0700 (PDT)
X-Gm-Message-State: AGi0PubWlV7oMk7W6r6wF0YRS7C8N7SdI4IadCo7Z82NyIihRM0HDDyv
        FBBtTr5TWrwxvT6xKQEfdKQ5C5Cc6X/wn+9r55o=
X-Google-Smtp-Source: APiQypIH8pqcrpa4MStCjFoM4SH24wHLsQ4ZYOb1ESUETqsi+cwlgr5EuTIHH9XorE01jrk7eab0+NnibTOsSHLypMU=
X-Received: by 2002:a05:6e02:4c:: with SMTP id i12mr21180329ilr.211.1586179769792;
 Mon, 06 Apr 2020 06:29:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200109150218.16544-1-nivedita@alum.mit.edu> <20200405154245.11972-1-me@prok.pw>
 <20200405231845.GA3095309@rani.riverdale.lan> <c692eea9213172d8ef937322b02ff585b0dfea82.camel@prok.pw>
 <20200406035110.GA3241052@rani.riverdale.lan> <CAMj1kXEUhyv886CjyKvjw2F12WaZxZRUWF6t_XzP4C2TJPdpeg@mail.gmail.com>
 <20200406084738.GA2520@zn.tnic> <CAMj1kXHAieZDvPKfjF=J+G=QVS+=XS-b4RP_=mjCEFEB_E_+Qw@mail.gmail.com>
 <20200406112042.GC2520@zn.tnic> <20200406132215.GA113388@rani.riverdale.lan>
In-Reply-To: <20200406132215.GA113388@rani.riverdale.lan>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 6 Apr 2020 15:29:18 +0200
X-Gmail-Original-Message-ID: <CAMj1kXG+34-bK1XuxX5VopkRt1SV1ewUAEmif+aQj5cJQ=9vbA@mail.gmail.com>
Message-ID: <CAMj1kXG+34-bK1XuxX5VopkRt1SV1ewUAEmif+aQj5cJQ=9vbA@mail.gmail.com>
Subject: Re: [PATCH 1/2] x86/boot/compressed/64: Remove .bss/.pgtable from bzImage
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Borislav Petkov <bp@alien8.de>, Sergey Shatunov <me@prok.pw>,
        hpa@zytor.com,
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

On Mon, 6 Apr 2020 at 15:22, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> On Mon, Apr 06, 2020 at 01:20:42PM +0200, Borislav Petkov wrote:
> > On Mon, Apr 06, 2020 at 11:11:21AM +0200, Ard Biesheuvel wrote:
> > > Yes, it is in the PE/COFF specification. [0]
> > >
> > > The whole problem is that we are conflating 'loading a PE/COFF image'
> > > with 'copying a PE/COFF image into memory', which are not the same
> > > thing. It is not just the layout issue, we are running into other
> > > problems with things like UEFI secure boot and TPM-based measured
> > > boot, where the fact that omitting the standard LoadImage() boot
> > > service (which takes care of these things under the hood) means that
> > > you now have to do your own checks and measurements. These things are
> > > literally all over the place at the moment, shim, GRUB, systemd-boot
> > > etc, with no authoritative spec that describes which component should
> > > be doing what.
> >
> > Sounds to me like what LoadImage() does is what the authoritative spec
> > should be. Perhaps we should write it down as "Do what LoadImage()
> > does... " and then enumerate the requirements.
> >
> > > Commit ec93fc371f014a6fb483e3556061ecad4b40735c has the background, but ...
> >
> > Nice, I like the aspect of letting firmware do only a minimum amount of
> > work. :)
> >
> > > ... I'll look into updating the documentation as well.
> >
> > Thanks!
> >
> > > Note that this stuff is hot off the press, so there may be some issues
> > > lurking (like this one) that we hadn't thought of yet.
> >
> > Right.
> >
> > > Actually, it may be sufficient to #define __efistub_global to
> > > __section(.data) like we already do for ARM, to ensure that these
> > > global flags are always initialized correctly. (I'll wait for Sergey
> > > to confirm that the spurious enabling of the PCI DMA protection
> > > resulting from this BSS issue is causing the boot regression)
>
> Yeah I thought of that as the easiest fix, but it might be safer to
> explicitly zero-init in efi_main to avoid future problems in case
> someone adds another variable in bss and isn't aware of this obscure
> requirement. We actually already have sys_table in bss, but that one is
> always initialized. There's also other globals that aren't annotated
> (but not in bss by virtue of having initializers). What do you think?
>

*If* we zero init BSS, I'd prefer for it to be done in the EFI
handover protocol entrypoint only. But does that fix the issue that
BSS lives outside of the memory footprint of the kernel image?


> What do you think of the other problem -- that's actually worse to fix,
> as it won't just be when kaslr is disabled, the startup_64 code will do
> relocation to the end of init_size and clobber the initrd before getting
> to the kaslr code, so it will break as soon as the firmware loads the
> "unified kernel image" at a 2Mb-aligned address. The only thing I can
> think of is to just unconditionally call efi_relocate_kernel if we were
> entered via handover_entry?
>

Yes, that seems to be the most robust approach.
