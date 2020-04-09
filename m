Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 379E81A3818
	for <lists+linux-efi@lfdr.de>; Thu,  9 Apr 2020 18:35:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbgDIQfe (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 9 Apr 2020 12:35:34 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:35063 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726594AbgDIQfd (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 9 Apr 2020 12:35:33 -0400
Received: by mail-qk1-f195.google.com with SMTP id c63so4620561qke.2;
        Thu, 09 Apr 2020 09:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2c3b+sFRIs5t/mMN/hcINkKFhHzxooLvwWO9fVjznKU=;
        b=oh4NE8Jx3DmdPRpNeLql6mpzfrwJrvTl+vtxB3eVSSV4aOzTvDb+50KO40hXwq7CqL
         w9GNCAnD9FxKXG4TQnD8chjBpox8E2qDaWlUJqSBpvqChJbbUA+qDRhtC3uAEx5a4vfy
         6dpIo4yYQg0kD6dlJJMi00eYhtxr8tHtJYE8PFlBkVOCPWHFIcYZgrMUNjzqCDm9fHvB
         Jl2v3BEWOxc4oHZu10KIz3mfM5sIcpVKbFiYjSWOMJGmagqoOp/HXh6u8SotWBuyI3/y
         J4VSBJDWTiCDygsDX2VdW26SthM/o7kbj68MKznR96WWIRhCKA5tJsIEAQ5XHb7OALz/
         uLzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=2c3b+sFRIs5t/mMN/hcINkKFhHzxooLvwWO9fVjznKU=;
        b=m56DruYs+v6r1d1L+bUIjAJ19xhTQzcy1vh3GqjLv0kuKMZ4Bfu4G5KFDWFZkAbF8y
         1LKiL67KjexkYVQ5c9N2Qk7DO4Uk1eCp8A3yubHJwxc32afhJgbecHnfTlLjPxPp3esP
         lvdEr911emiC2g9WBFYBcJL8xr/j3cuQHOGC1MYmsO57bS9sn2dMZML0PbJGeZeC20F3
         cgkYULmLNSvmwOlVqgzt5tJRkxzo+rWX2bC0WQxgUJPvGKsNYT3d0nylbMHYLbCngwun
         C5vuvV1w8bXbdZlGuT1h0SamTb8+4ekc/US9AOv3Heal/YHXKjYwfLnFKJTBzzun3H0A
         iskA==
X-Gm-Message-State: AGi0Pua1lGZ/2KJTtdVTEDfVRvtwWeRSGuZrn5SZPo3g54GcVCjrBqB3
        0w4Qalf8rEoINlFhwYZx4Kk=
X-Google-Smtp-Source: APiQypJN6PuPBEyj4e7pYZGEQ4CM6aWCW9FwjSkz4Szc+KihfMtqkxAVbn7yjyJ/rUiCox8799Xoxw==
X-Received: by 2002:a37:9684:: with SMTP id y126mr682823qkd.151.1586450133301;
        Thu, 09 Apr 2020 09:35:33 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id 10sm21471275qtt.54.2020.04.09.09.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2020 09:35:32 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Thu, 9 Apr 2020 12:35:30 -0400
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Dave Young <dyoung@redhat.com>, pjones@redhat.com,
        daniel.kiper@oracle.com, Leif Lindholm <leif@nuviainc.com>,
        Borislav Petkov <bp@alien8.de>, Sergey Shatunov <me@prok.pw>,
        hpa@zytor.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        mingo@redhat.com, Thomas Gleixner <tglx@linutronix.de>,
        X86 ML <x86@kernel.org>, linux-efi <linux-efi@vger.kernel.org>,
        initramfs@vger.kernel.org,
        Donovan Tremura <neurognostic@protonmail.ch>,
        Harald Hoyer <harald@hoyer.xyz>
Subject: Re: [PATCH 1/2] efi/x86: Move efi stub globals from .bss to .data
Message-ID: <20200409163530.GA785575@rani.riverdale.lan>
References: <CAMj1kXEUkJ1XJ9OTsijeq8tNNYC00bXqEV44OMtX5ugo9WoLKA@mail.gmail.com>
 <20200406180614.429454-1-nivedita@alum.mit.edu>
 <20200408074334.GA21886@dhcp-128-65.nay.redhat.com>
 <CAMj1kXGPOZ6zWtgGScLy0ECrTtf1yhngDTNE1chW-MQw3XQp9Q@mail.gmail.com>
 <20200409143910.GA727557@rani.riverdale.lan>
 <CAMj1kXEm=E6B+kjZktG=sBPLQ=_HFfUz6KFLskNGzRnuMjn0gA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXEm=E6B+kjZktG=sBPLQ=_HFfUz6KFLskNGzRnuMjn0gA@mail.gmail.com>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Apr 09, 2020 at 04:47:55PM +0200, Ard Biesheuvel wrote:
> On Thu, 9 Apr 2020 at 16:39, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> >
> > On Wed, Apr 08, 2020 at 09:49:15AM +0200, Ard Biesheuvel wrote:
> > > (add Peter, Leif and Daniel)
> > >
> > > On Wed, 8 Apr 2020 at 09:43, Dave Young <dyoung@redhat.com> wrote:
> > > >
> > > > On 04/06/20 at 02:06pm, Arvind Sankar wrote:
> > > > > Commit
> > > > >
> > > > >   3ee372ccce4d ("x86/boot/compressed/64: Remove .bss/.pgtable from
> > > > >   bzImage")
> > > > >
> > > > > removed the .bss section from the bzImage.
> > > > >
> > > > > However, while a PE loader is required to zero-initialize the .bss
> > > > > section before calling the PE entry point, the EFI handover protocol
> > > > > does not currently document any requirement that .bss be initialized by
> > > > > the bootloader prior to calling the handover entry.
> > > > >
> > > > > When systemd-boot is used to boot a unified kernel image [1], the image
> > > > > is constructed by embedding the bzImage as a .linux section in a PE
> > > > > executable that contains a small stub loader from systemd together with
> > > > > additional sections and potentially an initrd. As the .bss section
> > > > > within the bzImage is no longer explicitly present as part of the file,
> > > > > it is not initialized before calling the EFI handover entry.
> > > > > Furthermore, as the size of the embedded .linux section is only the size
> > > > > of the bzImage file itself, the .bss section's memory may not even have
> > > > > been allocated.
> > > >
> > > > I did not follow up the old report, maybe I missed something. But not
> > > > sure why only systemd-boot is mentioned here.  I also have similar issue
> > > > with early efi failure.  With these two patches applied, it works well
> > > > then.
> > > >
> > > > BTW, I use Fedora 31 + Grub2
> > > >
> > >
> > > OK, so I take it this means that GRUB's PE/COFF loader does not
> > > zero-initialize BSS either? Does it honor the image size in memory if
> > > it exceeds the file size?
> >
> > Dave, that comment was because the previous report was for systemd-boot
> > stub.
> >
> > Ard, should I revise the commit message to make it clear it's not
> > restricted to systemd-boot but anything using handover entry may be
> > affected? Maybe just a "for example, when systemd-boot..." and then a
> > line to say grub2 with the EFI stub patches is also impacted?
> >
> 
> Well, the fact the /some/ piece of software is used in production that
> relies on the ill-defined EFI handover protocol is sufficient
> justification, so I don't think it is hugely important to update it.
> 
> > https://src.fedoraproject.org/rpms/grub2/blob/f31/f/0001-Add-support-for-Linux-EFI-stub-loading.patch#_743
> >
> > +  kernel_mem = grub_efi_allocate_pages_max(lh.pref_address,
> > +                                          BYTES_TO_PAGES(lh.init_size));
> >
> > Looking at this, grub does allocate init_size for the image, but it
> > doesn't zero it out.
> >
> > This call also looks wrong to me though. It allocates at max address of
> > pref_address, which, if it succeeds, will guarantee that the kernel gets
> > loaded entirely below pref_address == LOAD_PHYSICAL_ADDR. In native
> > mode, if it weren't for the EFI stub copying the kernel again, this
> > would cause the startup code to relocate the kernel into unallocated
> > memory. On a mixed-mode boot, this would cause the early page tables
> > setup prior to transitioning to 64-bit mode to be in unallocated memory
> > and potentially get clobbered by the EFI stub.
> >
> > The first try to allocate pref_address should be calling
> > grub_efi_allocate_fixed instead.
> 
> Thanks Arvind. I'm sure the Fedora/RedHat folks on cc should be able
> to get these logged somewhere.

Ok. For dracut, the process for building the unified kernel image needs
a check to make sure the kernel can fit in the space provided for it --
there is 16MiB of space and the distro bzImage's are up to 10-11MiB in
size, so there's some slack left at present.

Additionally, in mixed-mode, the unified kernel images are quite likely
to end up with early pgtables from startup_32 clobbering the initrd,
independently of the recent kernel changes. Hopefully no-one actually
uses these in mixed-mode.
