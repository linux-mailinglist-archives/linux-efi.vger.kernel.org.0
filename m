Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 193E619FA08
	for <lists+linux-efi@lfdr.de>; Mon,  6 Apr 2020 18:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729015AbgDFQWq (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 6 Apr 2020 12:22:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:47688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728984AbgDFQWq (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 6 Apr 2020 12:22:46 -0400
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 84EF52495D;
        Mon,  6 Apr 2020 16:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586190165;
        bh=VMbOHNIJUU6wtuNXM/KpfPMrJ+VJJp/0yvARzGuxhns=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Mkc/Oe5jmPqDwbcLbtNLBGDsfnBNUl27B9fqNyDnAw3AjizHsZrdu0uXijFtFPYsv
         AcGo6LEiNRy3gV1Qw5b71E5M5yo2dmcJSCvyzn462SU2nS3kOY7D1TMZ0cbxUJWU4V
         vqkWnyyjv4lwdikFM/8S/zh8myYxD3U57vx4aG7A=
Received: by mail-io1-f42.google.com with SMTP id n20so89736ioa.4;
        Mon, 06 Apr 2020 09:22:45 -0700 (PDT)
X-Gm-Message-State: AGi0Pub2FMFtnfLe07PFOCjRdZQghiIy2/YFkCn9m2HLiK9vh2zlS1HT
        MjzyYbU0S6rTGy49gVWQB3WlNEiuWY3i0kMo0+A=
X-Google-Smtp-Source: APiQypJ7FjsDq1c+cxNDw/VPS6TAM5OkzwpVEnSs12EWNwTSEG5pqC1LBnZGw6vsL9wMA2ktnw47aW8A5dBJpjXxhAE=
X-Received: by 2002:a5d:8b57:: with SMTP id c23mr20509472iot.161.1586190164808;
 Mon, 06 Apr 2020 09:22:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200405154245.11972-1-me@prok.pw> <20200405231845.GA3095309@rani.riverdale.lan>
 <c692eea9213172d8ef937322b02ff585b0dfea82.camel@prok.pw> <20200406035110.GA3241052@rani.riverdale.lan>
 <CAMj1kXEUhyv886CjyKvjw2F12WaZxZRUWF6t_XzP4C2TJPdpeg@mail.gmail.com>
 <20200406084738.GA2520@zn.tnic> <CAMj1kXHAieZDvPKfjF=J+G=QVS+=XS-b4RP_=mjCEFEB_E_+Qw@mail.gmail.com>
 <20200406112042.GC2520@zn.tnic> <20200406132215.GA113388@rani.riverdale.lan>
 <CAMj1kXG+34-bK1XuxX5VopkRt1SV1ewUAEmif+aQj5cJQ=9vbA@mail.gmail.com> <20200406160148.GB113388@rani.riverdale.lan>
In-Reply-To: <20200406160148.GB113388@rani.riverdale.lan>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 6 Apr 2020 18:22:33 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFKDWB9n0kWhXHLH0XP0O1v_0b=bFJad=kBvx2qVxqDcQ@mail.gmail.com>
Message-ID: <CAMj1kXFKDWB9n0kWhXHLH0XP0O1v_0b=bFJad=kBvx2qVxqDcQ@mail.gmail.com>
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

On Mon, 6 Apr 2020 at 18:01, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> On Mon, Apr 06, 2020 at 03:29:18PM +0200, Ard Biesheuvel wrote:
> > > >
> > > > > Actually, it may be sufficient to #define __efistub_global to
> > > > > __section(.data) like we already do for ARM, to ensure that these
> > > > > global flags are always initialized correctly. (I'll wait for Sergey
> > > > > to confirm that the spurious enabling of the PCI DMA protection
> > > > > resulting from this BSS issue is causing the boot regression)
> > >
> > > Yeah I thought of that as the easiest fix, but it might be safer to
> > > explicitly zero-init in efi_main to avoid future problems in case
> > > someone adds another variable in bss and isn't aware of this obscure
> > > requirement. We actually already have sys_table in bss, but that one is
> > > always initialized. There's also other globals that aren't annotated
> > > (but not in bss by virtue of having initializers). What do you think?
> > >
> >
> > *If* we zero init BSS, I'd prefer for it to be done in the EFI
> > handover protocol entrypoint only. But does that fix the issue that
> > BSS lives outside of the memory footprint of the kernel image?
> >
>
> Yes, I was thinking of only doing it if we didn't come through the
> pe_entry. We could also avoid re-parsing the command line if we add a
> global flag to indicate that.
>

Yeah. I was trying to avoid that, but if we end up needing to
distinguish between the two cases anyway, we might just as well
optimize that too.

> Regarding the memory footprint, if there's no initrd that might be a
> problem, since in that case ImageSize will only cover the actual data
> from the bzImage, so it would be safer to move them to data (including
> sys_table).
>


> We could just pull the stub's bss section all into data with objcopy
> similar to what ARM64 does [1]? i.e. rename .bss to .bss.efistub and
> then pull that into .data in the linker script for the compressed
> kernel?
>

I don't follow. I'm not aware of arm64 doing anything out of the
ordinary with .bss? Note that arm64 does not have a separate
decompressor, so the EFI stub is part of the kernel proper. This is
why sections are renamed to start with .init

> There is also this scary looking comment in gnu-efi's linker script:
>         /* the EFI loader doesn't seem to like a .bss section, so we stick
>            it all into .data: */
> I don't know what the history of that is.
>

I don't remember, to be honest, but I'm pretty sure I copy-pasted that
from elsewhere at the time.

> [1] As an aside, why doesn't ARM do this as well rather than using the
> section(.data) annotation?
>

The ARM decompressor has this hideous hack, where text [and rodata]
executes straight from flash, and BSS is relocated into DRAM. In order
for this to work, it actually *requires* GOT indirections for BSS
items, to ensure that all BSS references use absolute addresses, which
can be relocated independently from the rest of the kernel image. This
is the reason ARM does not permit a .data section in the decompressor.
However, the EFI stub does not support execute in place from flash,
and so we can permit a .data section there. At the same time, we don't
support GOT indirections in the EFI stub, so we cannot use the BSS
section. So instead, we just put the few BSS pieces we have into .data
instead.






> >
> > > What do you think of the other problem -- that's actually worse to fix,
> > > as it won't just be when kaslr is disabled, the startup_64 code will do
> > > relocation to the end of init_size and clobber the initrd before getting
> > > to the kaslr code, so it will break as soon as the firmware loads the
> > > "unified kernel image" at a 2Mb-aligned address. The only thing I can
> > > think of is to just unconditionally call efi_relocate_kernel if we were
> > > entered via handover_entry?
> > >
> >
> > Yes, that seems to be the most robust approach.
