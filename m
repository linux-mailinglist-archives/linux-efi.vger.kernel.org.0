Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3946412CEFD
	for <lists+linux-efi@lfdr.de>; Mon, 30 Dec 2019 11:49:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727273AbfL3Ktj (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 30 Dec 2019 05:49:39 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:42248 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726196AbfL3Kti (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 30 Dec 2019 05:49:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1577702976;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hJa72CmFrQq4gAWpDR2+FRwRpYQu3hnMmC9EZDd2GoY=;
        b=hF+1q6+3vxI0Q17MyLCmfQhORkqzB4jfKO5uo0TDETUD6YtNy/fLpdM74GweQ1WDLHw3jW
        FGAmaz8jlln3iZQ4/1r1v62QjgpskQ0UI+CXoChN/5bpo94w1Aa4ObXD3tqp05ydUu8Erc
        RQmqjcwzqHUTw62Rgu4vV8ePQoiIbpk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-258-UW4dviq2Pt-WxMvgbk182w-1; Mon, 30 Dec 2019 05:49:33 -0500
X-MC-Unique: UW4dviq2Pt-WxMvgbk182w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1229F8024CD;
        Mon, 30 Dec 2019 10:49:31 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-231.pek2.redhat.com [10.72.12.231])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B37095C1B5;
        Mon, 30 Dec 2019 10:49:25 +0000 (UTC)
Date:   Mon, 30 Dec 2019 18:49:21 +0800
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
Message-ID: <20191230104921.GA16888@dhcp-128-65.nay.redhat.com>
References: <20191204075233.GA10520@dhcp-128-65.nay.redhat.com>
 <CANTgghnsdijH90qnm24qat70T7FA5qOwmnXXt+NYVxHYa4SLJA@mail.gmail.com>
 <CAPcyv4iRdJO6xrCaN=vrSvYFLZanLazmJLArT5YMfdJ6rc-PEQ@mail.gmail.com>
 <CAPcyv4hT9HXN2CqZw96zqgdNaapc=9oqSYvGrnEbeqSmx0t5xw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4hT9HXN2CqZw96zqgdNaapc=9oqSYvGrnEbeqSmx0t5xw@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 12/30/19 at 01:42am, Dan Williams wrote:
> On Sat, Dec 28, 2019 at 10:13 PM Dan Williams <dan.j.williams@intel.com> wrote:
> >
> > On Sat, Dec 28, 2019 at 12:54 PM Dan Williams
> > <dan.j.williams.korg@gmail.com> wrote:
> > >
> > > On Tue, Dec 3, 2019 at 11:53 PM Dave Young <dyoung@redhat.com> wrote:
> > > >
> > > > Michael Weiser reported he got below error during a kexec rebooting:
> > > > esrt: Unsupported ESRT version 2904149718861218184.
> > > >
> > > > The ESRT memory stays in EFI boot services data, and it was reserved
> > > > in kernel via efi_mem_reserve().  The initial purpose of the reservation
> > > > is to reuse the EFI boot services data across kexec reboot. For example
> > > > the BGRT image data and some ESRT memory like Michael reported.
> > > >
> > > > But although the memory is reserved it is not updated in X86 e820 table.
> > > > And kexec_file_load iterate system ram in io resource list to find places
> > > > for kernel, initramfs and other stuff. In Michael's case the kexec loaded
> > > > initramfs overwritten the ESRT memory and then the failure happened.
> > > >
> > > > Since kexec_file_load depends on the e820 to be updated, just fix this
> > > > by updating the reserved EFI boot services memory as reserved type in e820.
> > > >
> > > > Originally any memory descriptors with EFI_MEMORY_RUNTIME attribute are
> > > > bypassed in the reservation code path because they are assumed as reserved.
> > > > But the reservation is still needed for multiple kexec reboot.
> > > > And it is the only possible case we come here thus just drop the code
> > > > chunk then everything works without side effects.
> > > >
> > > > On my machine the ESRT memory sits in an EFI runtime data range, it does
> > > > not trigger the problem, but I successfully tested with BGRT instead.
> > > > both kexec_load and kexec_file_load work and kdump works as well.
> > > >
> > > > Signed-off-by: Dave Young <dyoung@redhat.com>
> > > > ---
> > > >  arch/x86/platform/efi/quirks.c |    6 ++----
> > > >  1 file changed, 2 insertions(+), 4 deletions(-)
> > > >
> > > > --- linux-x86.orig/arch/x86/platform/efi/quirks.c
> > > > +++ linux-x86/arch/x86/platform/efi/quirks.c
> > > > @@ -260,10 +260,6 @@ void __init efi_arch_mem_reserve(phys_ad
> > > >                 return;
> > > >         }
> > > >
> > > > -       /* No need to reserve regions that will never be freed. */
> > > > -       if (md.attribute & EFI_MEMORY_RUNTIME)
> > > > -               return;
> > > > -
> > > >         size += addr % EFI_PAGE_SIZE;
> > > >         size = round_up(size, EFI_PAGE_SIZE);
> > > >         addr = round_down(addr, EFI_PAGE_SIZE);
> > > > @@ -293,6 +289,8 @@ void __init efi_arch_mem_reserve(phys_ad
> > > >         early_memunmap(new, new_size);
> > > >
> > > >         efi_memmap_install(new_phys, num_entries);
> > > > +       e820__range_update(addr, size, E820_TYPE_RAM, E820_TYPE_RESERVED);
> > > > +       e820__update_table(e820_table);
> > > >  }
> > > >
> > > >  /*
> > > >
> > >
> > > Bisect says this change (commit af1648984828) is triggering a
> > > regression, likely not urgent, in my testing of the new efi_fake_mem=
> > > facility to allow memory to be marked "soft reserved" via the kernel
> > > command line (commit 199c84717612 x86/efi: Add efi_fake_mem support
> > > for EFI_MEMORY_SP). The following command line triggers the crash
> > > signature below:
> > >
> > >     efi_fake_mem=4G@9G:0x40000,4G@13G:0x40000
> > >
> > > However, this command line works ok:
> > >
> > >     efi_fake_mem=8G@9G:0x40000
> > >
> > > So, something about multiple efi_fake_mem statements interacts badly
> > > with this change. Nothing obvious occurs to me at the moment, I'll
> > > keep debugging, but wanted to highlight this in the meantime in case
> > > someone else sees a deeper issue or the root cause.
> >
> > Still looking, but this failure does not seem to be specific to the
> > "soft reservation" changes. Any update to the efi memmap that pushes
> > it over a page boundary triggers this failure. I.e. I can fix the
> > problem by over-allocating the efi memmap and then page aligning the
> > result. __early_ioremap "should" be handling this case, but it appears
> > something else is messing this up.
> 
> Found it. Neither this patch nor the soft reservation changes are at
> fault, they are just helping to trigger a long standing bug in
> efi_fake_memmap(). Its usage of efi_memmap_split_count() can over
> count the number of splits needed for new entries. Consider the case
> of 2 contiguous fake entries intersecting the end of a single entry.
> The first call to efi_memmap_split_count() determines the resulting
> split will be (old1, new1, old2), the second call determines (old1,
> new2). The result is 2 splits when only 1 is needed to get a result of
> (old1, new1, new2) and the new map ends up with an empty entry.
> efi_memmap_install() interprets an empty entry as start = 0 end =
> 0xffffffffffffffff and attempts an extra split / copy past the end of
> the new map.
> 
> I'll send a patch to fix up efi_fake_memmap().
> 

Cool, I also noticed if two of fake mem used, we only get one md with
"SP" attribute in print_efi_memmap, that is the root cause.

Thanks
Dave

