Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4CF8174FF2
	for <lists+linux-efi@lfdr.de>; Sun,  1 Mar 2020 22:36:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbgCAVgT (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 1 Mar 2020 16:36:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:50018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726490AbgCAVgT (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sun, 1 Mar 2020 16:36:19 -0500
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A034A246A1
        for <linux-efi@vger.kernel.org>; Sun,  1 Mar 2020 21:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583098577;
        bh=77owyWtTWjpwXjB2ZhT8UyHqDn+3+zebWI50OnnD/+A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=v3kEhNg9ukS792lPAzuCxsjXsetqwusLYosQ9dyzYCFgWUbyDmd0G83cndrQCjaF6
         v2wYmtewFJsKrpiq2UOEM2rdzCBzsQvTgKPpBSghBMgpAWpp1x0bhFfapXs+OGcN1r
         +wZv1BbFHs1NlN2UzhKBIRzzb5HhUyHXEclV5SkY=
Received: by mail-wm1-f44.google.com with SMTP id 6so587402wmi.5
        for <linux-efi@vger.kernel.org>; Sun, 01 Mar 2020 13:36:17 -0800 (PST)
X-Gm-Message-State: APjAAAVnt0laH5gta+5ZkhU1ZGrFRdu9QtlBFB0PuyuGMGjzLzA7g5eF
        VkD4ML4lyHrS7pZGnmo1bmBJYRt/LRb30igAmaVIEQ==
X-Google-Smtp-Source: APXvYqwcn6fSzSRm2ev8EjkxoJv3ylc+ltp3RQcBM7KXHl3OhGRE4zzbAAriOwYHdWSsgx2VmS+nm3UMvJ1bz7YobbM=
X-Received: by 2002:a05:600c:24b:: with SMTP id 11mr15749264wmj.1.1583098576099;
 Sun, 01 Mar 2020 13:36:16 -0800 (PST)
MIME-Version: 1.0
References: <20200222155519.23550-1-ardb@kernel.org> <20200301171509.GA1845222@rani.riverdale.lan>
 <20200301172248.GA1851857@rani.riverdale.lan> <CAKv+Gu_N3vbea79CAQNZn6DmKBsKOhT9ucQYgBf0_8Pnd+vz2g@mail.gmail.com>
 <20200301200035.GA2031375@rani.riverdale.lan> <CAKv+Gu_megM4a26r8AxeVEBrDLcY202K6nEcVxQ5bAeCcDBekw@mail.gmail.com>
 <CAKv+Gu9=p8q3adeRVCbsxfoV17-SbKkeOe8Lx0OQYZAsmja+oQ@mail.gmail.com>
 <CAKv+Gu87vexrXoofKdoFNEcr_Zw1dwe6pXz3DHhJ4NGZG=8SiA@mail.gmail.com> <20200301205419.GA2116204@rani.riverdale.lan>
In-Reply-To: <20200301205419.GA2116204@rani.riverdale.lan>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sun, 1 Mar 2020 22:36:05 +0100
X-Gmail-Original-Message-ID: <CAKv+Gu-sqC4_1ry_D1WCqraFR3bnaMegkJv9SHzXuUY7FLYs2g@mail.gmail.com>
Message-ID: <CAKv+Gu-sqC4_1ry_D1WCqraFR3bnaMegkJv9SHzXuUY7FLYs2g@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] efi/x86: add support for generic EFI mixed mode boot
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sun, 1 Mar 2020 at 21:54, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> On Sun, Mar 01, 2020 at 09:41:33PM +0100, Ard Biesheuvel wrote:
> > On Sun, 1 Mar 2020 at 21:20, Ard Biesheuvel <ardb@kernel.org> wrote:
> > >
> > > On Sun, 1 Mar 2020 at 21:02, Ard Biesheuvel <ardb@kernel.org> wrote:
> > > >
> > > > On Sun, 1 Mar 2020 at 21:00, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> > > > >
> > > > > On Sun, Mar 01, 2020 at 08:36:42PM +0100, Ard Biesheuvel wrote:
> > > > > > On Sun, 1 Mar 2020 at 18:22, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> > > > > > >
> > > > > > > On Sun, Mar 01, 2020 at 12:15:10PM -0500, Arvind Sankar wrote:
> > > > > > > > What I'm doing is creating an x86-64 defconfig based on tip:efi/core,
> > > > > > > > and then running it via
> > > > > > > >
> > > > > > > > $ qemu-system-x86_64 -cpu Haswell -pflash qemu/OVMF_64.fd \
> > > > > > >                                                  ^^^^^^^
> > > > > > > That OVMF_64.fd is incorrect copy/paste from a different run, the panic
> > > > > > > case is using OVMF-mixed-mode-compat-section.fd.
> > > > > > > >   -drive file=fat:rw:qemu/boot -nographic -m 3072
> > > > > >
> > > > > > Thanks for the patch. Interestingly, I don't even make it to the point
> > > > > > where it crashes, and I end up in an ASSERT() in the firmware:
> > > > > >
> > > > > > ASSERT_EFI_ERROR (Status = Not Found)
> > > > > > ASSERT /home/ardbie01/build/edk2/MdeModulePkg/Universal/ReportStatusCodeRouter/RuntimeDxe/ReportStatusCodeRouterRuntimeDxe.c(347):
> > > > > > !EFI_ERROR (Status)
> > > > > >
> > > > > > which appears to be a result of the fact that the memory map passed to
> > > > > > SetVirtualAddressMap() does not cover some function pointer that gets
> > > > > > converted in that code.
> > > > > >
> > > > > > I don't remember - does mixed mode even work in general with 3 GB of memory?
> > > > >
> > > > > Oh -- is there some option to enable debugging assertions? I did see
> > > > > that it crashed somewhere inside SetVirtualMap (i.e. we called it and
> > > > > it never returned).
> > > > >
> > > >
> > > > The ASSERT()s are always active, but you don't see them if you don't
> > > > expose the debugcon
> > > >
> > > > > For some reason, with nokaslr on the command line, I can't get this to
> > > > > crash. All the addresses seem to be within 4Gb, so it ought to work, no?
> > > >
> > > > The issue is in the memory map we compile and send back to the firware
> > > > - apparently, that ends up wrong for some reason.
> > >
> > > BTW I uploaded another version which uses Loadimage/Startimage (and
> > > the .compat section) for mixed mode kernels passed to QEMU via the
> > > command line
> > >
> > > https://people.linaro.org/~ard.biesheuvel/OVMF-mixed-mode-compat-section-cmdline.fd
> >
> > I see this in the memory map
> >
> > [    0.000000] efi: mem47: [Conventional Memory|   |  |  |  |  |  |  |
> >  |   |WB|WT|WC|UC] range=[0x0000000100000000-0x000000013fffffff]
> > (1024MB)
> >
> > so it looks like qemu-system-x86_64 puts the memory in a weird place?
> > Or is this expected?
>
> Mine ended here:
> [    0.000000] efi: mem45: [Memory Mapped I/O  |RUN|  |  |  |  |  |  |  |   |  |  |  |UC] range=[0x00000000ffc00000-0x00000000ffffffff] (4MB)
> are you running with -m 3072 or more?
>

That is not memory, it's some mmio region

> If you get memory mapped above 4Gb you will almost certainly crash in
> the call to SetVirtualMemoryMap, but that's usually because the memmap
> you pass in is above 4Gb and can't be accessed by the firmware at all.
