Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E279A174F87
	for <lists+linux-efi@lfdr.de>; Sun,  1 Mar 2020 21:21:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbgCAUVD (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 1 Mar 2020 15:21:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:38788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726351AbgCAUVC (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sun, 1 Mar 2020 15:21:02 -0500
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D768E246C2
        for <linux-efi@vger.kernel.org>; Sun,  1 Mar 2020 20:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583094062;
        bh=hHTSy3zS5dYSmTrSbUd/gPFZ1mWIfb8msLbCVruvFaQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PIVDc0ngnzAs8QWARQICiHd0l+ed5Ei8DEX6mLHnmgb6Zwi31F5EOZzGE5Ly4QX86
         hUrlzw53Dto8a5Gsg9Qrfz9mjJ3aX0C9siLbs30ysNB+rbdl02HIBYoVMai9MHf11X
         l7UCGm6Joc/bSzsvLj+esH4JMHexx2dAy/41u7kc=
Received: by mail-wr1-f41.google.com with SMTP id l5so9904495wrx.4
        for <linux-efi@vger.kernel.org>; Sun, 01 Mar 2020 12:21:01 -0800 (PST)
X-Gm-Message-State: APjAAAXUgI9inERcgwRSBUxULMRtzT/2pEHzGnv5LQZLZqBlFOegF/e4
        byuK5FRpoCFkc7rxt/j/Dz/63ZtCEgzefI+Y6b4xtw==
X-Google-Smtp-Source: APXvYqxENCLTjrtLtlr8eP4TmjwW21cmwS6k26+ZeiCdlo6MFb4PFyG/dx+0o+JbbA4MB3iSaSYfSvyBI5dZj4Sckc4=
X-Received: by 2002:adf:a411:: with SMTP id d17mr17403735wra.126.1583094060233;
 Sun, 01 Mar 2020 12:21:00 -0800 (PST)
MIME-Version: 1.0
References: <20200222155519.23550-1-ardb@kernel.org> <20200301171509.GA1845222@rani.riverdale.lan>
 <20200301172248.GA1851857@rani.riverdale.lan> <CAKv+Gu_N3vbea79CAQNZn6DmKBsKOhT9ucQYgBf0_8Pnd+vz2g@mail.gmail.com>
 <20200301200035.GA2031375@rani.riverdale.lan> <CAKv+Gu_megM4a26r8AxeVEBrDLcY202K6nEcVxQ5bAeCcDBekw@mail.gmail.com>
In-Reply-To: <CAKv+Gu_megM4a26r8AxeVEBrDLcY202K6nEcVxQ5bAeCcDBekw@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sun, 1 Mar 2020 21:20:49 +0100
X-Gmail-Original-Message-ID: <CAKv+Gu9=p8q3adeRVCbsxfoV17-SbKkeOe8Lx0OQYZAsmja+oQ@mail.gmail.com>
Message-ID: <CAKv+Gu9=p8q3adeRVCbsxfoV17-SbKkeOe8Lx0OQYZAsmja+oQ@mail.gmail.com>
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

On Sun, 1 Mar 2020 at 21:02, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Sun, 1 Mar 2020 at 21:00, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> >
> > On Sun, Mar 01, 2020 at 08:36:42PM +0100, Ard Biesheuvel wrote:
> > > On Sun, 1 Mar 2020 at 18:22, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> > > >
> > > > On Sun, Mar 01, 2020 at 12:15:10PM -0500, Arvind Sankar wrote:
> > > > > What I'm doing is creating an x86-64 defconfig based on tip:efi/core,
> > > > > and then running it via
> > > > >
> > > > > $ qemu-system-x86_64 -cpu Haswell -pflash qemu/OVMF_64.fd \
> > > >                                                  ^^^^^^^
> > > > That OVMF_64.fd is incorrect copy/paste from a different run, the panic
> > > > case is using OVMF-mixed-mode-compat-section.fd.
> > > > >   -drive file=fat:rw:qemu/boot -nographic -m 3072
> > >
> > > Thanks for the patch. Interestingly, I don't even make it to the point
> > > where it crashes, and I end up in an ASSERT() in the firmware:
> > >
> > > ASSERT_EFI_ERROR (Status = Not Found)
> > > ASSERT /home/ardbie01/build/edk2/MdeModulePkg/Universal/ReportStatusCodeRouter/RuntimeDxe/ReportStatusCodeRouterRuntimeDxe.c(347):
> > > !EFI_ERROR (Status)
> > >
> > > which appears to be a result of the fact that the memory map passed to
> > > SetVirtualAddressMap() does not cover some function pointer that gets
> > > converted in that code.
> > >
> > > I don't remember - does mixed mode even work in general with 3 GB of memory?
> >
> > Oh -- is there some option to enable debugging assertions? I did see
> > that it crashed somewhere inside SetVirtualMap (i.e. we called it and
> > it never returned).
> >
>
> The ASSERT()s are always active, but you don't see them if you don't
> expose the debugcon
>
> > For some reason, with nokaslr on the command line, I can't get this to
> > crash. All the addresses seem to be within 4Gb, so it ought to work, no?
>
> The issue is in the memory map we compile and send back to the firware
> - apparently, that ends up wrong for some reason.

BTW I uploaded another version which uses Loadimage/Startimage (and
the .compat section) for mixed mode kernels passed to QEMU via the
command line

https://people.linaro.org/~ard.biesheuvel/OVMF-mixed-mode-compat-section-cmdline.fd
