Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75EF0477A98
	for <lists+linux-efi@lfdr.de>; Thu, 16 Dec 2021 18:30:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240221AbhLPRa3 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 16 Dec 2021 12:30:29 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:52242 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240213AbhLPRa1 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 16 Dec 2021 12:30:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D86ECB82551;
        Thu, 16 Dec 2021 17:30:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE8BDC36AE5;
        Thu, 16 Dec 2021 17:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639675824;
        bh=repGJGrbWDB32mgCMbp5RDwBf22fgEisX5KUEIO8s/Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=J4WxF6XlJCLPZ+qK824T+8sTJnkSymr+EuUc43akcb8yUTw1CkL/Q/HKTWIfKFkOk
         z9YBFf2d3s+i7ltbLmG7hBL5WmuVCz4+ikSEHNdkYfppZlyometlCg2fDVUKN9Jn2S
         y5Ine8/MXpwRmGzmnhk2rolhnoZKVdg7mBA0y5jDnsGoSs8H77WBPGKH6yZK43Fc7D
         KpgsxHn1l1IF+6iVsgYeitqtnIVPde89OI2ASeBgm729U5J1QV/QfDvwwaQR8gRxw5
         it8iwY7uKpG+z4+jtpoiscpRG54J0p2JcNCUHG9pSwinIA5G0V9XDuoouqCvmR+e+W
         Vb4BYldBxDxPQ==
Received: by mail-wm1-f47.google.com with SMTP id b186-20020a1c1bc3000000b00345734afe78so1245200wmb.0;
        Thu, 16 Dec 2021 09:30:24 -0800 (PST)
X-Gm-Message-State: AOAM531NbD/Su7+YVFFqdWW01L5AiYdKRfo2HWGCx8O48Yvu69IOO90g
        jOfdNlCgthj/ND37RhEu5gS8v5qb9ltr4NH5idE=
X-Google-Smtp-Source: ABdhPJwenX5HAlLyEor5+roBp4TZkrVgW/ElEqvdHFhJRuzDYedw6L0BNWivKo8sOYN5IPOdBMfDvWREw1QLCiCzIPQ=
X-Received: by 2002:a1c:8:: with SMTP id 8mr6003308wma.106.1639675823044; Thu,
 16 Dec 2021 09:30:23 -0800 (PST)
MIME-Version: 1.0
References: <20211110104613.23881-1-baskov@ispras.ru> <CAMj1kXGzdMfj0bdNFODFZ8jfo0iMaZ5SOfueciwtY7Y4V5G2JQ@mail.gmail.com>
 <1b013e77ec3d4c6288408b3caff093ef@ispras.ru>
In-Reply-To: <1b013e77ec3d4c6288408b3caff093ef@ispras.ru>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 16 Dec 2021 18:30:11 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHuYSMFfth8W=0YzvroBf8t5z-rAgE9JJA4zonFgS1TPQ@mail.gmail.com>
Message-ID: <CAMj1kXHuYSMFfth8W=0YzvroBf8t5z-rAgE9JJA4zonFgS1TPQ@mail.gmail.com>
Subject: Re: [PATCH RFC 0/5] Handle UEFI NX-restricted page tables
To:     Baskov Evgeniy <baskov@ispras.ru>
Cc:     Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>, X86 ML <x86@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 25 Nov 2021 at 08:36, <baskov@ispras.ru> wrote:
>
>
> Hello,
>
> I apologize for delayed reply.
>

No worries.


> The system in question runs in a firmware that tries to achieve
> complete W^X protection. Both loader code and loader data
> are not executable, so the suggested approach does not work.
> If you would like to test this, you can set
> the PcdDxeNxMemoryProtectionPolicy in any firmware available to you.
>

The PCD in question has the following note:

# NOTE: User must NOT set NX protection for EfiLoaderCode /
EfiBootServicesCode / EfiRuntimeServicesCode. <BR>

Any idea whether this is easily reproducible with OVMF? Restricting
the loader from creating executable regions seems rather daft, so we
should at least report this, and preferably fix it in EDK2.

> As a justification for the approach itself, I can use the fact that
> UEFI specification says nothing about the ability to execute
> self-allocated EfiLoaderCode or any other types besides the areas
> allocated by the firmware for UEFI Images. In fact, Table 7-5
> explicitly states that EfiLoaderCode is used for:
>
> > The code portions of a loaded UEFI application.
>

Fair enough. So EfiLoaderCode is not the right type.

> While we do not think it should be interpreted as one cannot allocate
> such areas at all, it is clear that there are no guarantees about the
> other use cases and permissions of the allocations of this type besides
> those stated by 2.3.4:
>
> > Paging mode is enabled and any memory space defined by the UEFI memory
> > map is identity mapped (virtual address equals physical address),
> > although the attributes of certain regions may not have all read,
> > write, and execute attributes or be unmarked for purposes of platform
> > protection.
>
> Long story short, the kernel is not allowed to allocate such areas and
> assume they are executable,

OK

> it should do paging itself,

Now you're going too fast. One does not necessarily imply the other.

> and the changes
> here address that. For the reference, Windows adheres to this convention
> and works fine on the target system.
>

Given that this issue is specific to EDK2 based firmwares, would it be
possible to fix this using DXE services instead? In particular, could
we use

gDS->SetMemorySpaceAttributes()

to ensure that the regions have executable permissions?





>
> On 2021-11-10 14:11, Ard Biesheuvel wrote:
> > On Wed, 10 Nov 2021 at 11:56, Baskov Evgeniy <baskov@ispras.ru> wrote:
> >>
> >> Note, that this patch series is RFC, since it is yet untested
> >> and possibly incompatible with AMD SEV and related extensions.
> >>
> >> The UEFI specification states that certain memory regions may
> >> not have every permission, i.e. may not be writable or executable.
> >>
> >> Furthermore there exist some implementations (at least on i386/x86_64)
> >> that restrict execution of memory regions expected by the kernel to
> >> be executable. E.g. first megabyte of address space, where trampoline
> >> for switching between 4/5 level paging is placed and memory regions,
> >> allocated as loader data.
> >>
> >> This patch series allows Linux kernel to boot on such UEFI
> >> implementations on i386 and x86_64.
> >>
> >> The simplest way to achieve that on i386 is to disable paging
> >> before jumping to potentially relocated code.
> >>
> >> x86_64, on the other hand, does not allow disabling paging so it
> >> is required to build temporary page tables containing memory regions
> >> required for Linux kernel to boot with appropriate access permissions.
> >>
> >
> > Hello Baskov,
> >
> > To be honest, I am truly not a fan of this approach.
> >
> > Which systems is this issue occurring on? Did you try something like
> > the below to allocate executable memory explicitly?
> >
> >
> > diff --git a/drivers/firmware/efi/libstub/relocate.c
> > b/drivers/firmware/efi/libstub/relocate.c
> > index 8ee9eb2b9039..b73012a7bcdc 100644
> > --- a/drivers/firmware/efi/libstub/relocate.c
> > +++ b/drivers/firmware/efi/libstub/relocate.c
> > @@ -80,7 +80,7 @@ efi_status_t efi_low_alloc_above(unsigned long size,
> > unsigned long align,
> >                         continue;
> >
> >                 status = efi_bs_call(allocate_pages,
> > EFI_ALLOCATE_ADDRESS,
> > -                                    EFI_LOADER_DATA, nr_pages,
> > &start);
> > +                                    EFI_LOADER_CODE, nr_pages,
> > &start);
> >                 if (status == EFI_SUCCESS) {
> >                         *addr = start;
> >                         break;
> > @@ -146,7 +146,7 @@ efi_status_t efi_relocate_kernel(unsigned long
> > *image_addr,
> >          */
> >         nr_pages = round_up(alloc_size, EFI_ALLOC_ALIGN) /
> > EFI_PAGE_SIZE;
> >         status = efi_bs_call(allocate_pages, EFI_ALLOCATE_ADDRESS,
> > -                            EFI_LOADER_DATA, nr_pages, &efi_addr);
> > +                            EFI_LOADER_CODE, nr_pages, &efi_addr);
> >         new_addr = efi_addr;
> >         /*
> >          * If preferred address allocation failed allocate as low as
>
>
