Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DEC8A1A47D6
	for <lists+linux-efi@lfdr.de>; Fri, 10 Apr 2020 17:26:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726080AbgDJP0q (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 10 Apr 2020 11:26:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:49124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726049AbgDJP0q (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 10 Apr 2020 11:26:46 -0400
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B046E214DB;
        Fri, 10 Apr 2020 15:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586532405;
        bh=31d3HggV5/2Hyq9KvrXaSioOTKPE4/gu+YWfp6Sojts=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qJ/ke3O3uXxyG6ftBxMHvWFfTlHdXskZxiY2nqgBZ0x7nvRaZbGqIrk6Alrmi5YaS
         X8Rt9Hn+hWvgyS0XxGcQ3/obRqKPcH75fFT2u81ot76o4EewB/5WCx6VYyCtAMeeoq
         TZqrPDo4b5n3AVcAIQIVZSd7tK5+xxCvGLNBM6sA=
Received: by mail-io1-f47.google.com with SMTP id i19so2047108ioh.12;
        Fri, 10 Apr 2020 08:26:45 -0700 (PDT)
X-Gm-Message-State: AGi0PuaGSAxIr0AhPzYjMHy1Nk1qa1THhDcH58oVJ1ekR1XrK/iNJsMf
        2Lu/a4XiEAQrmhSd/S7iSqPcCGgPYTw5cYDCx2Y=
X-Google-Smtp-Source: APiQypKRwZj4Or9d0A2n1aoV+x18e94FxGo1pxTdgccUKzCWzjNKokQNnWypgoA71gqrxtAO2g+kKg9TNKIJ3dXg7Go=
X-Received: by 2002:a02:6a1e:: with SMTP id l30mr4919933jac.98.1586532404967;
 Fri, 10 Apr 2020 08:26:44 -0700 (PDT)
MIME-Version: 1.0
References: <CAMj1kXEUkJ1XJ9OTsijeq8tNNYC00bXqEV44OMtX5ugo9WoLKA@mail.gmail.com>
 <20200406180614.429454-1-nivedita@alum.mit.edu> <20200408074334.GA21886@dhcp-128-65.nay.redhat.com>
 <CAMj1kXGPOZ6zWtgGScLy0ECrTtf1yhngDTNE1chW-MQw3XQp9Q@mail.gmail.com>
 <20200409143910.GA727557@rani.riverdale.lan> <CAMj1kXEm=E6B+kjZktG=sBPLQ=_HFfUz6KFLskNGzRnuMjn0gA@mail.gmail.com>
 <20200409163530.GA785575@rani.riverdale.lan> <20200410144758.GC936997@rani.riverdale.lan>
In-Reply-To: <20200410144758.GC936997@rani.riverdale.lan>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 10 Apr 2020 17:26:34 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHMQgnmdoA+qKLGa=gYg4J2p-DU3-K1LiM=AT61pi+Fvw@mail.gmail.com>
Message-ID: <CAMj1kXHMQgnmdoA+qKLGa=gYg4J2p-DU3-K1LiM=AT61pi+Fvw@mail.gmail.com>
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

On Fri, 10 Apr 2020 at 16:48, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> On Thu, Apr 09, 2020 at 12:35:30PM -0400, Arvind Sankar wrote:
> > On Thu, Apr 09, 2020 at 04:47:55PM +0200, Ard Biesheuvel wrote:
> > > On Thu, 9 Apr 2020 at 16:39, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> > > >
> > > > On Wed, Apr 08, 2020 at 09:49:15AM +0200, Ard Biesheuvel wrote:
> > > > > (add Peter, Leif and Daniel)
> > > > >
> > > > > On Wed, 8 Apr 2020 at 09:43, Dave Young <dyoung@redhat.com> wrote:
> > > > > >
> > > > > > On 04/06/20 at 02:06pm, Arvind Sankar wrote:
> > > > > > > Commit
> > > > > > >
> > > > > > >   3ee372ccce4d ("x86/boot/compressed/64: Remove .bss/.pgtable from
> > > > > > >   bzImage")
> > > > > > >
> > > > > > > removed the .bss section from the bzImage.
> > > > > > >
> > > > > > > However, while a PE loader is required to zero-initialize the .bss
> > > > > > > section before calling the PE entry point, the EFI handover protocol
> > > > > > > does not currently document any requirement that .bss be initialized by
> > > > > > > the bootloader prior to calling the handover entry.
> > > > > > >
> > > > > > > When systemd-boot is used to boot a unified kernel image [1], the image
> > > > > > > is constructed by embedding the bzImage as a .linux section in a PE
> > > > > > > executable that contains a small stub loader from systemd together with
> > > > > > > additional sections and potentially an initrd. As the .bss section
> > > > > > > within the bzImage is no longer explicitly present as part of the file,
> > > > > > > it is not initialized before calling the EFI handover entry.
> > > > > > > Furthermore, as the size of the embedded .linux section is only the size
> > > > > > > of the bzImage file itself, the .bss section's memory may not even have
> > > > > > > been allocated.
> > > > > >
> > > > > > I did not follow up the old report, maybe I missed something. But not
> > > > > > sure why only systemd-boot is mentioned here.  I also have similar issue
> > > > > > with early efi failure.  With these two patches applied, it works well
> > > > > > then.
> > > > > >
> > > > > > BTW, I use Fedora 31 + Grub2
> > > > > >
> > > > >
> > > > > OK, so I take it this means that GRUB's PE/COFF loader does not
> > > > > zero-initialize BSS either? Does it honor the image size in memory if
> > > > > it exceeds the file size?
> > > >
> > > > Dave, that comment was because the previous report was for systemd-boot
> > > > stub.
> > > >
> > > > Ard, should I revise the commit message to make it clear it's not
> > > > restricted to systemd-boot but anything using handover entry may be
> > > > affected? Maybe just a "for example, when systemd-boot..." and then a
> > > > line to say grub2 with the EFI stub patches is also impacted?
> > > >
> > >
> > > Well, the fact the /some/ piece of software is used in production that
> > > relies on the ill-defined EFI handover protocol is sufficient
> > > justification, so I don't think it is hugely important to update it.
> > >
> > > > https://src.fedoraproject.org/rpms/grub2/blob/f31/f/0001-Add-support-for-Linux-EFI-stub-loading.patch#_743
> > > >
> > > > +  kernel_mem = grub_efi_allocate_pages_max(lh.pref_address,
> > > > +                                          BYTES_TO_PAGES(lh.init_size));
> > > >
> > > > Looking at this, grub does allocate init_size for the image, but it
> > > > doesn't zero it out.
> > > >
> > > > This call also looks wrong to me though. It allocates at max address of
> > > > pref_address, which, if it succeeds, will guarantee that the kernel gets
> > > > loaded entirely below pref_address == LOAD_PHYSICAL_ADDR. In native
> > > > mode, if it weren't for the EFI stub copying the kernel again, this
> > > > would cause the startup code to relocate the kernel into unallocated
> > > > memory. On a mixed-mode boot, this would cause the early page tables
> > > > setup prior to transitioning to 64-bit mode to be in unallocated memory
> > > > and potentially get clobbered by the EFI stub.
> > > >
> > > > The first try to allocate pref_address should be calling
> > > > grub_efi_allocate_fixed instead.
> > >
> > > Thanks Arvind. I'm sure the Fedora/RedHat folks on cc should be able
> > > to get these logged somewhere.
> >
> > Ok. For dracut, the process for building the unified kernel image needs
> > a check to make sure the kernel can fit in the space provided for it --
> > there is 16MiB of space and the distro bzImage's are up to 10-11MiB in
> > size, so there's some slack left at present.
> >
> > Additionally, in mixed-mode, the unified kernel images are quite likely
> > to end up with early pgtables from startup_32 clobbering the initrd,
> > independently of the recent kernel changes. Hopefully no-one actually
> > uses these in mixed-mode.
>
> The grub EFI handover entry patch is busted in mixed-mode for another
> reason -- while it allocates init_size, it doesn't use the correct
> alignment. I tested on a Debian buster VM in mixed-mode (that was the
> one I was able to get to install/boot with mixed-mode), and the early
> pagetable from startup_32 ends up in unallocated memory due to the
> rounding up of the bzImage address to account for kernel alignment. This
> would be an existing problem prior to these patches.
>
> Should we try to handle this in the kernel? At some point KASLR is going
> to pick that memory for the kernel and overwrite the pagetables I would
> think, resulting in sporadic crashes that are almost unreproducible.

Upstream GRUB does not implement the EFI handover protocol at all, and
the distros all have their own GRUB forks that implement this along
with mixed mode, secure boot, shim, measured boot etc.

What you are saying is that GRUB forks turn out to exist that violate
both the PE/COFF specification and the Linux/x86 boot protocol in a
way that might break mixed mode, and nobody noticed until you happened
to find it by code inspection. While I appreciate the effort, I think
this is where I would like to draw the line, and say that there is
only so much we can do to work around bugs in out-of-tree forks of
other projects. So unless it can be done cleanly and without losing
any of the benefits of the recent cleanup and optimization work, I'd
say don't bother.
