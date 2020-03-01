Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25447174FBB
	for <lists+linux-efi@lfdr.de>; Sun,  1 Mar 2020 21:54:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726188AbgCAUyX (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 1 Mar 2020 15:54:23 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:42311 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbgCAUyX (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 1 Mar 2020 15:54:23 -0500
Received: by mail-qv1-f68.google.com with SMTP id e7so59912qvy.9
        for <linux-efi@vger.kernel.org>; Sun, 01 Mar 2020 12:54:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wfaojDGI+/BuYQR6+DqzKeBFK8zD59YXzqTNrLvjjKk=;
        b=H3n+BGD/dgDWCq6jiqWKtJF+SC+qSHY2x4zAW62tI4vSSHc/YGTP519DgQ86XwKM/1
         HXVIwyQKq0AoSrsLT3EPOUiDXMwGa6V0bsurhqkp2UDcHDMm9usFBQjUFSCW3Sl5Y9mt
         ftpO+QFEp35katZEivxmMI/FpbmRGsk9Mc5tvu5LfnXOwFmwQmMpT4XrzWt6bNiosqME
         aVeRS1T/PogEhtGNxOxsddjXYjt/iWxCffJgt6Re/jjqWpf9MtbdBjfoAHDKLy3NPnrr
         i/XyEnAXPcpeYk/I7VEc/WAdErbHPRA/hL4yuSNXQeVos6U4rNbcG3ez9+WnrezwZE5j
         Pq5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=wfaojDGI+/BuYQR6+DqzKeBFK8zD59YXzqTNrLvjjKk=;
        b=q+BiBIQipFrfYU+pxwSdYS20QMjD2Ddr5qcFYJcuOEpdX1aW5csN7XOaJ7Vf0QOqHd
         g9Z91ZrBlwqoeGTXjShRnzFw+Cx0zcsEe8dKIUbzZmJbHm1JtWb9W+eidcnRlnZvD08S
         Z61A2iKFU1BHD39RW3yCLIdWN/3GUtnBJbY1p2+OGWKvio3RjYwC8NJtfwIU0b5SpUyV
         3IEukdlJtCgXS6mLrUU4M/RKJEu6S/3Qg2pQz2iK685IOlmrF0uecrt2nvi/j0EmEz6C
         w0UFdE3+BfxTM3TsrEnzaKWCbV2pqRnTLOK869AknMAM2hvtT0+qo2lFphspvQDVuN6x
         5dEw==
X-Gm-Message-State: APjAAAW1ZIII4FMh+lH1z+ZitxGMbu6D2Ir/4wmL4JC29bAwhrvXhpY9
        wPQHQdrxe4cC/xJb3kOVRXk=
X-Google-Smtp-Source: APXvYqwxQ04PPtVjMxbgDAogGenAeVnxFtgywQqwX9VctYOpvrTnSZBvSrxOfusTZ0wZyBmurHYsJA==
X-Received: by 2002:ad4:4d50:: with SMTP id m16mr12485539qvm.186.1583096062079;
        Sun, 01 Mar 2020 12:54:22 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id t13sm8836147qkm.60.2020.03.01.12.54.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2020 12:54:21 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Sun, 1 Mar 2020 15:54:20 -0500
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        linux-efi <linux-efi@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [PATCH v3 0/6] efi/x86: add support for generic EFI mixed mode
 boot
Message-ID: <20200301205419.GA2116204@rani.riverdale.lan>
References: <20200222155519.23550-1-ardb@kernel.org>
 <20200301171509.GA1845222@rani.riverdale.lan>
 <20200301172248.GA1851857@rani.riverdale.lan>
 <CAKv+Gu_N3vbea79CAQNZn6DmKBsKOhT9ucQYgBf0_8Pnd+vz2g@mail.gmail.com>
 <20200301200035.GA2031375@rani.riverdale.lan>
 <CAKv+Gu_megM4a26r8AxeVEBrDLcY202K6nEcVxQ5bAeCcDBekw@mail.gmail.com>
 <CAKv+Gu9=p8q3adeRVCbsxfoV17-SbKkeOe8Lx0OQYZAsmja+oQ@mail.gmail.com>
 <CAKv+Gu87vexrXoofKdoFNEcr_Zw1dwe6pXz3DHhJ4NGZG=8SiA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKv+Gu87vexrXoofKdoFNEcr_Zw1dwe6pXz3DHhJ4NGZG=8SiA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sun, Mar 01, 2020 at 09:41:33PM +0100, Ard Biesheuvel wrote:
> On Sun, 1 Mar 2020 at 21:20, Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > On Sun, 1 Mar 2020 at 21:02, Ard Biesheuvel <ardb@kernel.org> wrote:
> > >
> > > On Sun, 1 Mar 2020 at 21:00, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> > > >
> > > > On Sun, Mar 01, 2020 at 08:36:42PM +0100, Ard Biesheuvel wrote:
> > > > > On Sun, 1 Mar 2020 at 18:22, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> > > > > >
> > > > > > On Sun, Mar 01, 2020 at 12:15:10PM -0500, Arvind Sankar wrote:
> > > > > > > What I'm doing is creating an x86-64 defconfig based on tip:efi/core,
> > > > > > > and then running it via
> > > > > > >
> > > > > > > $ qemu-system-x86_64 -cpu Haswell -pflash qemu/OVMF_64.fd \
> > > > > >                                                  ^^^^^^^
> > > > > > That OVMF_64.fd is incorrect copy/paste from a different run, the panic
> > > > > > case is using OVMF-mixed-mode-compat-section.fd.
> > > > > > >   -drive file=fat:rw:qemu/boot -nographic -m 3072
> > > > >
> > > > > Thanks for the patch. Interestingly, I don't even make it to the point
> > > > > where it crashes, and I end up in an ASSERT() in the firmware:
> > > > >
> > > > > ASSERT_EFI_ERROR (Status = Not Found)
> > > > > ASSERT /home/ardbie01/build/edk2/MdeModulePkg/Universal/ReportStatusCodeRouter/RuntimeDxe/ReportStatusCodeRouterRuntimeDxe.c(347):
> > > > > !EFI_ERROR (Status)
> > > > >
> > > > > which appears to be a result of the fact that the memory map passed to
> > > > > SetVirtualAddressMap() does not cover some function pointer that gets
> > > > > converted in that code.
> > > > >
> > > > > I don't remember - does mixed mode even work in general with 3 GB of memory?
> > > >
> > > > Oh -- is there some option to enable debugging assertions? I did see
> > > > that it crashed somewhere inside SetVirtualMap (i.e. we called it and
> > > > it never returned).
> > > >
> > >
> > > The ASSERT()s are always active, but you don't see them if you don't
> > > expose the debugcon
> > >
> > > > For some reason, with nokaslr on the command line, I can't get this to
> > > > crash. All the addresses seem to be within 4Gb, so it ought to work, no?
> > >
> > > The issue is in the memory map we compile and send back to the firware
> > > - apparently, that ends up wrong for some reason.
> >
> > BTW I uploaded another version which uses Loadimage/Startimage (and
> > the .compat section) for mixed mode kernels passed to QEMU via the
> > command line
> >
> > https://people.linaro.org/~ard.biesheuvel/OVMF-mixed-mode-compat-section-cmdline.fd
> 
> I see this in the memory map
> 
> [    0.000000] efi: mem47: [Conventional Memory|   |  |  |  |  |  |  |
>  |   |WB|WT|WC|UC] range=[0x0000000100000000-0x000000013fffffff]
> (1024MB)
> 
> so it looks like qemu-system-x86_64 puts the memory in a weird place?
> Or is this expected?

Mine ended here:
[    0.000000] efi: mem45: [Memory Mapped I/O  |RUN|  |  |  |  |  |  |  |   |  |  |  |UC] range=[0x00000000ffc00000-0x00000000ffffffff] (4MB)
are you running with -m 3072 or more?

If you get memory mapped above 4Gb you will almost certainly crash in
the call to SetVirtualMemoryMap, but that's usually because the memmap
you pass in is above 4Gb and can't be accessed by the firmware at all.
