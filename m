Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FC2412C2AB
	for <lists+linux-efi@lfdr.de>; Sun, 29 Dec 2019 15:25:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbfL2OZM (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 29 Dec 2019 09:25:12 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:51154 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726535AbfL2OZM (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 29 Dec 2019 09:25:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1577629509;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RfWTGUOufJ9bQ4pR2PaE/6zDr2zhuJs0ed/uUQTcRSM=;
        b=bEJSrD304ZNCC5+kUdwg9pxVc83BpdJYnOMk0h3VZM1/Dvjqfhy9OCuNLAIjMMVPojoxmK
        XamyQkV26h7Dawe2NTL2pwl4YdElydmEUTOMHX2S2wacmiuSd4lb7Cz1rvND1GdX4rJdTI
        F03fEpcJb7zgQEpGj+XXGWR9lNp0teo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-202-vKIOHU98MjaBghCgwbmzGQ-1; Sun, 29 Dec 2019 09:25:05 -0500
X-MC-Unique: vKIOHU98MjaBghCgwbmzGQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E442310054E3;
        Sun, 29 Dec 2019 14:25:02 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-73.pek2.redhat.com [10.72.12.73])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 566EA1A7E4;
        Sun, 29 Dec 2019 14:24:57 +0000 (UTC)
Date:   Sun, 29 Dec 2019 22:24:53 +0800
From:   Dave Young <dyoung@redhat.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Dan Williams <dan.j.williams.korg@gmail.com>,
        linux-efi <linux-efi@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michael Weiser <michael@weiser.dinsnail.net>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        kexec@lists.infradead.org, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] x86/efi: update e820 about reserved EFI boot services
 data to fix kexec breakage
Message-ID: <20191229142453.GA18486@dhcp-128-65.nay.redhat.com>
References: <20191204075233.GA10520@dhcp-128-65.nay.redhat.com>
 <CANTgghnsdijH90qnm24qat70T7FA5qOwmnXXt+NYVxHYa4SLJA@mail.gmail.com>
 <CAPcyv4iRdJO6xrCaN=vrSvYFLZanLazmJLArT5YMfdJ6rc-PEQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4iRdJO6xrCaN=vrSvYFLZanLazmJLArT5YMfdJ6rc-PEQ@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Dan,
On 12/28/19 at 10:13pm, Dan Williams wrote:
> On Sat, Dec 28, 2019 at 12:54 PM Dan Williams
> <dan.j.williams.korg@gmail.com> wrote:
> >
> > On Tue, Dec 3, 2019 at 11:53 PM Dave Young <dyoung@redhat.com> wrote:
> > >
> > > Michael Weiser reported he got below error during a kexec rebooting:
> > > esrt: Unsupported ESRT version 2904149718861218184.
> > >
> > > The ESRT memory stays in EFI boot services data, and it was reserved
> > > in kernel via efi_mem_reserve().  The initial purpose of the reservation
> > > is to reuse the EFI boot services data across kexec reboot. For example
> > > the BGRT image data and some ESRT memory like Michael reported.
> > >
> > > But although the memory is reserved it is not updated in X86 e820 table.
> > > And kexec_file_load iterate system ram in io resource list to find places
> > > for kernel, initramfs and other stuff. In Michael's case the kexec loaded
> > > initramfs overwritten the ESRT memory and then the failure happened.
> > >
> > > Since kexec_file_load depends on the e820 to be updated, just fix this
> > > by updating the reserved EFI boot services memory as reserved type in e820.
> > >
> > > Originally any memory descriptors with EFI_MEMORY_RUNTIME attribute are
> > > bypassed in the reservation code path because they are assumed as reserved.
> > > But the reservation is still needed for multiple kexec reboot.
> > > And it is the only possible case we come here thus just drop the code
> > > chunk then everything works without side effects.
> > >
> > > On my machine the ESRT memory sits in an EFI runtime data range, it does
> > > not trigger the problem, but I successfully tested with BGRT instead.
> > > both kexec_load and kexec_file_load work and kdump works as well.
> > >
> > > Signed-off-by: Dave Young <dyoung@redhat.com>
> > > ---
> > >  arch/x86/platform/efi/quirks.c |    6 ++----
> > >  1 file changed, 2 insertions(+), 4 deletions(-)
> > >
> > > --- linux-x86.orig/arch/x86/platform/efi/quirks.c
> > > +++ linux-x86/arch/x86/platform/efi/quirks.c
> > > @@ -260,10 +260,6 @@ void __init efi_arch_mem_reserve(phys_ad
> > >                 return;
> > >         }
> > >
> > > -       /* No need to reserve regions that will never be freed. */
> > > -       if (md.attribute & EFI_MEMORY_RUNTIME)
> > > -               return;
> > > -
> > >         size += addr % EFI_PAGE_SIZE;
> > >         size = round_up(size, EFI_PAGE_SIZE);
> > >         addr = round_down(addr, EFI_PAGE_SIZE);
> > > @@ -293,6 +289,8 @@ void __init efi_arch_mem_reserve(phys_ad
> > >         early_memunmap(new, new_size);
> > >
> > >         efi_memmap_install(new_phys, num_entries);
> > > +       e820__range_update(addr, size, E820_TYPE_RAM, E820_TYPE_RESERVED);
> > > +       e820__update_table(e820_table);
> > >  }
> > >
> > >  /*
> > >
> >
> > Bisect says this change (commit af1648984828) is triggering a
> > regression, likely not urgent, in my testing of the new efi_fake_mem=
> > facility to allow memory to be marked "soft reserved" via the kernel
> > command line (commit 199c84717612 x86/efi: Add efi_fake_mem support
> > for EFI_MEMORY_SP). The following command line triggers the crash
> > signature below:
> >
> >     efi_fake_mem=4G@9G:0x40000,4G@13G:0x40000
> >
> > However, this command line works ok:
> >
> >     efi_fake_mem=8G@9G:0x40000
> >
> > So, something about multiple efi_fake_mem statements interacts badly
> > with this change. Nothing obvious occurs to me at the moment, I'll
> > keep debugging, but wanted to highlight this in the meantime in case
> > someone else sees a deeper issue or the root cause.
> 
> Still looking, but this failure does not seem to be specific to the
> "soft reservation" changes. Any update to the efi memmap that pushes
> it over a page boundary triggers this failure. I.e. I can fix the
> problem by over-allocating the efi memmap and then page aligning the
> result. __early_ioremap "should" be handling this case, but it appears
> something else is messing this up.

I seems can not reproduce the bug, but maybe my vm setup is different.
Can you do some debugging about the efi_memmap_insert function see if
something wrong happened, maybe happens when memcpy to some new allocated buffer via
memblock_alloc, just some guess.

Thanks
Dave

