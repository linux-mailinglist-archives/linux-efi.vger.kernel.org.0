Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E68AA1A3638
	for <lists+linux-efi@lfdr.de>; Thu,  9 Apr 2020 16:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727867AbgDIOsI (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 9 Apr 2020 10:48:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:49886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726977AbgDIOsI (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 9 Apr 2020 10:48:08 -0400
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C2555218AC;
        Thu,  9 Apr 2020 14:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586443687;
        bh=onD7nON+N0SmQP21hJf/yfWHMLhZn2udjCwtUSwBH4w=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ce/KN0HiLFNEkDTXUXzwRMh3n3jinfdt7219BETuD5hR1yaVTWAvQ6qquA1uNEJJr
         M6kC4osT1xMNVUkKRT0OCUZyMB9IxKLS42j4FzIKilCOOlljn+/FHNr2Z7BLrK5N5I
         Teck01ooZ1zjKGtMkDhzXSMEBOgb9sGkzhm4OsPI=
Received: by mail-il1-f177.google.com with SMTP id z12so2368296ilb.10;
        Thu, 09 Apr 2020 07:48:07 -0700 (PDT)
X-Gm-Message-State: AGi0Puah2HqoA+yVgcTkEx2zqia6etXdoGyMNGztscQgHOJR7y8/x0Bi
        0lvYlTa2JyBSRRc62Zt2M/y4xVwBlnoGLAI4B7s=
X-Google-Smtp-Source: APiQypLTVZYQZNMcUuiIxXUciOnDNNy28jf8nu40nF6jk84cdapx5DOkpicHiM+00QCih8pPm+sifzIZQldzvWkFqa8=
X-Received: by 2002:a05:6e02:4c:: with SMTP id i12mr6094ilr.211.1586443687085;
 Thu, 09 Apr 2020 07:48:07 -0700 (PDT)
MIME-Version: 1.0
References: <CAMj1kXEUkJ1XJ9OTsijeq8tNNYC00bXqEV44OMtX5ugo9WoLKA@mail.gmail.com>
 <20200406180614.429454-1-nivedita@alum.mit.edu> <20200408074334.GA21886@dhcp-128-65.nay.redhat.com>
 <CAMj1kXGPOZ6zWtgGScLy0ECrTtf1yhngDTNE1chW-MQw3XQp9Q@mail.gmail.com> <20200409143910.GA727557@rani.riverdale.lan>
In-Reply-To: <20200409143910.GA727557@rani.riverdale.lan>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 9 Apr 2020 16:47:55 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEm=E6B+kjZktG=sBPLQ=_HFfUz6KFLskNGzRnuMjn0gA@mail.gmail.com>
Message-ID: <CAMj1kXEm=E6B+kjZktG=sBPLQ=_HFfUz6KFLskNGzRnuMjn0gA@mail.gmail.com>
Subject: Re: [PATCH 1/2] efi/x86: Move efi stub globals from .bss to .data
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Dave Young <dyoung@redhat.com>, pjones@redhat.com,
        daniel.kiper@oracle.com, Leif Lindholm <leif@nuviainc.com>,
        Borislav Petkov <bp@alien8.de>, Sergey Shatunov <me@prok.pw>,
        hpa@zytor.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        mingo@redhat.com, Thomas Gleixner <tglx@linutronix.de>,
        X86 ML <x86@kernel.org>, linux-efi <linux-efi@vger.kernel.org>,
        initramfs@vger.kernel.org,
        Donovan Tremura <neurognostic@protonmail.ch>,
        Harald Hoyer <harald@hoyer.xyz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 9 Apr 2020 at 16:39, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> On Wed, Apr 08, 2020 at 09:49:15AM +0200, Ard Biesheuvel wrote:
> > (add Peter, Leif and Daniel)
> >
> > On Wed, 8 Apr 2020 at 09:43, Dave Young <dyoung@redhat.com> wrote:
> > >
> > > On 04/06/20 at 02:06pm, Arvind Sankar wrote:
> > > > Commit
> > > >
> > > >   3ee372ccce4d ("x86/boot/compressed/64: Remove .bss/.pgtable from
> > > >   bzImage")
> > > >
> > > > removed the .bss section from the bzImage.
> > > >
> > > > However, while a PE loader is required to zero-initialize the .bss
> > > > section before calling the PE entry point, the EFI handover protocol
> > > > does not currently document any requirement that .bss be initialized by
> > > > the bootloader prior to calling the handover entry.
> > > >
> > > > When systemd-boot is used to boot a unified kernel image [1], the image
> > > > is constructed by embedding the bzImage as a .linux section in a PE
> > > > executable that contains a small stub loader from systemd together with
> > > > additional sections and potentially an initrd. As the .bss section
> > > > within the bzImage is no longer explicitly present as part of the file,
> > > > it is not initialized before calling the EFI handover entry.
> > > > Furthermore, as the size of the embedded .linux section is only the size
> > > > of the bzImage file itself, the .bss section's memory may not even have
> > > > been allocated.
> > >
> > > I did not follow up the old report, maybe I missed something. But not
> > > sure why only systemd-boot is mentioned here.  I also have similar issue
> > > with early efi failure.  With these two patches applied, it works well
> > > then.
> > >
> > > BTW, I use Fedora 31 + Grub2
> > >
> >
> > OK, so I take it this means that GRUB's PE/COFF loader does not
> > zero-initialize BSS either? Does it honor the image size in memory if
> > it exceeds the file size?
>
> Dave, that comment was because the previous report was for systemd-boot
> stub.
>
> Ard, should I revise the commit message to make it clear it's not
> restricted to systemd-boot but anything using handover entry may be
> affected? Maybe just a "for example, when systemd-boot..." and then a
> line to say grub2 with the EFI stub patches is also impacted?
>

Well, the fact the /some/ piece of software is used in production that
relies on the ill-defined EFI handover protocol is sufficient
justification, so I don't think it is hugely important to update it.

> https://src.fedoraproject.org/rpms/grub2/blob/f31/f/0001-Add-support-for-Linux-EFI-stub-loading.patch#_743
>
> +  kernel_mem = grub_efi_allocate_pages_max(lh.pref_address,
> +                                          BYTES_TO_PAGES(lh.init_size));
>
> Looking at this, grub does allocate init_size for the image, but it
> doesn't zero it out.
>
> This call also looks wrong to me though. It allocates at max address of
> pref_address, which, if it succeeds, will guarantee that the kernel gets
> loaded entirely below pref_address == LOAD_PHYSICAL_ADDR. In native
> mode, if it weren't for the EFI stub copying the kernel again, this
> would cause the startup code to relocate the kernel into unallocated
> memory. On a mixed-mode boot, this would cause the early page tables
> setup prior to transitioning to 64-bit mode to be in unallocated memory
> and potentially get clobbered by the EFI stub.
>
> The first try to allocate pref_address should be calling
> grub_efi_allocate_fixed instead.

Thanks Arvind. I'm sure the Fedora/RedHat folks on cc should be able
to get these logged somewhere.
