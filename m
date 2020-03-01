Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 061D9174F9B
	for <lists+linux-efi@lfdr.de>; Sun,  1 Mar 2020 21:41:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725970AbgCAUlr (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 1 Mar 2020 15:41:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:42224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725895AbgCAUlr (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sun, 1 Mar 2020 15:41:47 -0500
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 052E924697
        for <linux-efi@vger.kernel.org>; Sun,  1 Mar 2020 20:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583095306;
        bh=z5nmAOt/I/UNodkRtotymydIxFyidCo5aD2hMXI3/BE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZxcBFaDFcLMNNcGUWrlGvCmj8rtDHUlCjZQodgS/wWvDyeD4VMhbfPdIHys2oGqN1
         1PcAYdyzKj9TjKVI93PuzEnoAsbiYH5z66ssha1yqsUYR8zcYE2xN+nxBXKCcCTy3i
         tCcpSWG4CTgpyUS9/iEKZE0oVz2tofi0fiZvOk1s=
Received: by mail-wm1-f51.google.com with SMTP id z12so8955919wmi.4
        for <linux-efi@vger.kernel.org>; Sun, 01 Mar 2020 12:41:45 -0800 (PST)
X-Gm-Message-State: APjAAAVKV1/wGGLYqxLf/jFE7a2pJUpeDvQkSNclkcRFJ71tm8frN40k
        Nd+kh1r4AgXiXNL9peR+vqFhbYLW2OZJo5DKAyNtIw==
X-Google-Smtp-Source: APXvYqykhs93FYj0IhBAL2zBkIJRIzYakzbpxjvBrMZUcGkX9FdOqMYlPpUpMOCr86AF6GfUSnVUgGs5It6b6EV5ztA=
X-Received: by 2002:a05:600c:24b:: with SMTP id 11mr15622196wmj.1.1583095304503;
 Sun, 01 Mar 2020 12:41:44 -0800 (PST)
MIME-Version: 1.0
References: <20200222155519.23550-1-ardb@kernel.org> <20200301171509.GA1845222@rani.riverdale.lan>
 <20200301172248.GA1851857@rani.riverdale.lan> <CAKv+Gu_N3vbea79CAQNZn6DmKBsKOhT9ucQYgBf0_8Pnd+vz2g@mail.gmail.com>
 <20200301200035.GA2031375@rani.riverdale.lan> <CAKv+Gu_megM4a26r8AxeVEBrDLcY202K6nEcVxQ5bAeCcDBekw@mail.gmail.com>
 <CAKv+Gu9=p8q3adeRVCbsxfoV17-SbKkeOe8Lx0OQYZAsmja+oQ@mail.gmail.com>
In-Reply-To: <CAKv+Gu9=p8q3adeRVCbsxfoV17-SbKkeOe8Lx0OQYZAsmja+oQ@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sun, 1 Mar 2020 21:41:33 +0100
X-Gmail-Original-Message-ID: <CAKv+Gu87vexrXoofKdoFNEcr_Zw1dwe6pXz3DHhJ4NGZG=8SiA@mail.gmail.com>
Message-ID: <CAKv+Gu87vexrXoofKdoFNEcr_Zw1dwe6pXz3DHhJ4NGZG=8SiA@mail.gmail.com>
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

On Sun, 1 Mar 2020 at 21:20, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Sun, 1 Mar 2020 at 21:02, Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > On Sun, 1 Mar 2020 at 21:00, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> > >
> > > On Sun, Mar 01, 2020 at 08:36:42PM +0100, Ard Biesheuvel wrote:
> > > > On Sun, 1 Mar 2020 at 18:22, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> > > > >
> > > > > On Sun, Mar 01, 2020 at 12:15:10PM -0500, Arvind Sankar wrote:
> > > > > > What I'm doing is creating an x86-64 defconfig based on tip:efi/core,
> > > > > > and then running it via
> > > > > >
> > > > > > $ qemu-system-x86_64 -cpu Haswell -pflash qemu/OVMF_64.fd \
> > > > >                                                  ^^^^^^^
> > > > > That OVMF_64.fd is incorrect copy/paste from a different run, the panic
> > > > > case is using OVMF-mixed-mode-compat-section.fd.
> > > > > >   -drive file=fat:rw:qemu/boot -nographic -m 3072
> > > >
> > > > Thanks for the patch. Interestingly, I don't even make it to the point
> > > > where it crashes, and I end up in an ASSERT() in the firmware:
> > > >
> > > > ASSERT_EFI_ERROR (Status = Not Found)
> > > > ASSERT /home/ardbie01/build/edk2/MdeModulePkg/Universal/ReportStatusCodeRouter/RuntimeDxe/ReportStatusCodeRouterRuntimeDxe.c(347):
> > > > !EFI_ERROR (Status)
> > > >
> > > > which appears to be a result of the fact that the memory map passed to
> > > > SetVirtualAddressMap() does not cover some function pointer that gets
> > > > converted in that code.
> > > >
> > > > I don't remember - does mixed mode even work in general with 3 GB of memory?
> > >
> > > Oh -- is there some option to enable debugging assertions? I did see
> > > that it crashed somewhere inside SetVirtualMap (i.e. we called it and
> > > it never returned).
> > >
> >
> > The ASSERT()s are always active, but you don't see them if you don't
> > expose the debugcon
> >
> > > For some reason, with nokaslr on the command line, I can't get this to
> > > crash. All the addresses seem to be within 4Gb, so it ought to work, no?
> >
> > The issue is in the memory map we compile and send back to the firware
> > - apparently, that ends up wrong for some reason.
>
> BTW I uploaded another version which uses Loadimage/Startimage (and
> the .compat section) for mixed mode kernels passed to QEMU via the
> command line
>
> https://people.linaro.org/~ard.biesheuvel/OVMF-mixed-mode-compat-section-cmdline.fd

I see this in the memory map

[    0.000000] efi: mem47: [Conventional Memory|   |  |  |  |  |  |  |
 |   |WB|WT|WC|UC] range=[0x0000000100000000-0x000000013fffffff]
(1024MB)

so it looks like qemu-system-x86_64 puts the memory in a weird place?
Or is this expected?
