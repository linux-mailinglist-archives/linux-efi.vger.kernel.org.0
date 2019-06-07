Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB7BF38A4B
	for <lists+linux-efi@lfdr.de>; Fri,  7 Jun 2019 14:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728684AbfFGM30 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 7 Jun 2019 08:29:26 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:34330 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728597AbfFGM30 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 7 Jun 2019 08:29:26 -0400
Received: by mail-io1-f68.google.com with SMTP id k8so1263074iot.1
        for <linux-efi@vger.kernel.org>; Fri, 07 Jun 2019 05:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZAvCebdzLCcSo6NRDYnZ6+WboqvZJ6BWkvuu4gNcNRU=;
        b=l4nQx5bFXnCKwqIlYU0J3gLgZ0wR2UHkkyD80ob8NWqEzmyQRyDonYA1xejed7SD7I
         kl8UJmHVctl7fGkgf+4DP5y24neUBNA+zxlxJY3S4HVfsZwYCbLpbC5X/rnEuTmx0XXh
         TM3xqj2bbhQ5K2+gr7mtqkPtJTeLrCTJIkyzfvXg394Cl7G+Ji9ZKHSnA1ZN2SUSoI8i
         uwU2sOnfICyeKhaZfC07P/kXjxtmj4uZ0679dcT9GHa3muXEwPVuvI4jtVZZhHeErlrd
         8nBJksrkmuE8GCa9e4sgJfJqjQV2LI1VOgH3RQx135gNWHZBHKd/iVGw+7oY5dE1Bxte
         Coew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZAvCebdzLCcSo6NRDYnZ6+WboqvZJ6BWkvuu4gNcNRU=;
        b=AnVThxmBgAN4aYhS5ELCmWIayzrGLtjLadygXXRwprURjFqVW+bysE8wc8gvPkzP9i
         Xj2ix34/TEzUval3+qUxCnuJSmOFxOsyeXObe+gscyYxj7dN1PiNwTgPHf653ktCMKjL
         qEdLdBsXw20VH7rK7dyD2fNT9ykiQPvlxYisXFl9ZpLvYvEYTRBKdUC88k38UkqXKVvR
         RB8gHROqblMPZwivZe++Bvpu3OIj0LM66SLTDbDETXlKae+JmuD5R6J3BWez0CMt/Oal
         /u0lg15LbXw+rPWdv7lvVLOVFiHwmxYleZcicXRmQ1RkQaJYO+tYr00fPh2mDMbY0srE
         ZlDQ==
X-Gm-Message-State: APjAAAUkdi7/srTdJe2W4UflJnO5DERKTgi6PoGDnQBup12eVSWPFCAV
        rhizkaiunHK3TFgO3NiC/4L+tWU2tc1WWMVtj6l2Tg==
X-Google-Smtp-Source: APXvYqwpgjUncM9YwGMeAEjGhHkH4kygINBHDj2ErQa4lBEYa0dUkEHo5JqszczMdAM7yNXhdyvGEegvK6pJJXoP2q8=
X-Received: by 2002:a5d:9402:: with SMTP id v2mr15677145ion.128.1559910565141;
 Fri, 07 Jun 2019 05:29:25 -0700 (PDT)
MIME-Version: 1.0
References: <155925716254.3775979.16716824941364738117.stgit@dwillia2-desk3.amr.corp.intel.com>
 <155925718351.3775979.13546720620952434175.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CAKv+Gu-J3-66V7UhH3=AjN4sX7iydHNF7Fd+SMbezaVNrZQmGQ@mail.gmail.com>
 <CAPcyv4g-GNe2vSYTn0a6ivQYxJdS5khE4AJbcxysoGPsTZwswg@mail.gmail.com>
 <CAKv+Gu83QB6x8=LCaAcR0S65WELC-Y+Voxw6LzaVh4FSV3bxYA@mail.gmail.com> <CAPcyv4hXBJBMrqoUr4qG5A3CUVgWzWK6bfBX29JnLCKDC7CiGA@mail.gmail.com>
In-Reply-To: <CAPcyv4hXBJBMrqoUr4qG5A3CUVgWzWK6bfBX29JnLCKDC7CiGA@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 7 Jun 2019 14:29:12 +0200
Message-ID: <CAKv+Gu_ZYpey0dWYebFgCaziyJ-_x+KbCmOegWqFjwC0U-5QaA@mail.gmail.com>
Subject: Re: [PATCH v2 4/8] x86, efi: Reserve UEFI 2.8 Specific Purpose Memory
 for dax
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Mike Rapoport <rppt@linux.ibm.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        kbuild test robot <lkp@intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sat, 1 Jun 2019 at 06:26, Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Fri, May 31, 2019 at 8:30 AM Ard Biesheuvel
> <ard.biesheuvel@linaro.org> wrote:
> >
> > On Fri, 31 May 2019 at 17:28, Dan Williams <dan.j.williams@intel.com> wrote:
> > >
> > > On Fri, May 31, 2019 at 1:30 AM Ard Biesheuvel
> > > <ard.biesheuvel@linaro.org> wrote:
> > > >
> > > > (cc Mike for memblock)
> > > >
> > > > On Fri, 31 May 2019 at 01:13, Dan Williams <dan.j.williams@intel.com> wrote:
> > > > >
> > > > > UEFI 2.8 defines an EFI_MEMORY_SP attribute bit to augment the
> > > > > interpretation of the EFI Memory Types as "reserved for a special
> > > > > purpose".
> > > > >
> > > > > The proposed Linux behavior for specific purpose memory is that it is
> > > > > reserved for direct-access (device-dax) by default and not available for
> > > > > any kernel usage, not even as an OOM fallback. Later, through udev
> > > > > scripts or another init mechanism, these device-dax claimed ranges can
> > > > > be reconfigured and hot-added to the available System-RAM with a unique
> > > > > node identifier.
> > > > >
> > > > > This patch introduces 3 new concepts at once given the entanglement
> > > > > between early boot enumeration relative to memory that can optionally be
> > > > > reserved from the kernel page allocator by default. The new concepts
> > > > > are:
> > > > >
> > > > > - E820_TYPE_SPECIFIC: Upon detecting the EFI_MEMORY_SP attribute on
> > > > >   EFI_CONVENTIONAL memory, update the E820 map with this new type. Only
> > > > >   perform this classification if the CONFIG_EFI_SPECIFIC_DAX=y policy is
> > > > >   enabled, otherwise treat it as typical ram.
> > > > >
> > > >
> > > > OK, so now we have 'special purpose', 'specific' and 'app specific'
> > > > [below]. Do they all mean the same thing?
> > >
> > > I struggled with separating the raw-EFI-type name from the name of the
> > > Linux specific policy. Since the reservation behavior is optional I
> > > was thinking there should be a distinct Linux kernel name for that
> > > policy. I did try to go back and change all occurrences of "special"
> > > to "specific" from the RFC to this v2, but seems I missed one.
> > >
> >
> > OK
>
> I'll go ahead and use "application reserved" terminology consistently
> throughout the code to distinguish that Linux translation from the raw
> "EFI specific purpose" attribute.
>

OK

> >
> > > >
> > > > > - IORES_DESC_APPLICATION_RESERVED: Add a new I/O resource descriptor for
> > > > >   a device driver to search iomem resources for application specific
> > > > >   memory. Teach the iomem code to identify such ranges as "Application
> > > > >   Reserved".
> > > > >
> > > > > - MEMBLOCK_APP_SPECIFIC: Given the memory ranges can fallback to the
> > > > >   traditional System RAM pool the expectation is that they will have
> > > > >   typical SRAT entries. In order to support a policy of device-dax by
> > > > >   default with the option to hotplug later, the numa initialization code
> > > > >   is taught to avoid marking online MEMBLOCK_APP_SPECIFIC regions.
> > > > >
> > > >
> > > > Can we move the generic memblock changes into a separate patch please?
> > >
> > > Yeah, that can move to a lead-in patch.
> > >
> > > [..]
> > > > > diff --git a/include/linux/efi.h b/include/linux/efi.h
> > > > > index 91368f5ce114..b57b123cbdf9 100644
> > > > > --- a/include/linux/efi.h
> > > > > +++ b/include/linux/efi.h
> > > > > @@ -129,6 +129,19 @@ typedef struct {
> > > > >         u64 attribute;
> > > > >  } efi_memory_desc_t;
> > > > >
> > > > > +#ifdef CONFIG_EFI_SPECIFIC_DAX
> > > > > +static inline bool is_efi_dax(efi_memory_desc_t *md)
> > > > > +{
> > > > > +       return md->type == EFI_CONVENTIONAL_MEMORY
> > > > > +               && (md->attribute & EFI_MEMORY_SP);
> > > > > +}
> > > > > +#else
> > > > > +static inline bool is_efi_dax(efi_memory_desc_t *md)
> > > > > +{
> > > > > +       return false;
> > > > > +}
> > > > > +#endif
> > > > > +
> > > > >  typedef struct {
> > > > >         efi_guid_t guid;
> > > > >         u32 headersize;
> > > >
> > > > I'd prefer it if we could avoid this DAX policy distinction leaking
> > > > into the EFI layer.
> > > >
> > > > IOW, I am fine with having a 'is_efi_sp_memory()' helper here, but
> > > > whether that is DAX memory or not should be decided in the DAX layer.
> > >
> > > Ok, how about is_efi_sp_ram()? Since EFI_MEMORY_SP might be applied to
> > > things that aren't EFI_CONVENTIONAL_MEMORY.
> >
> > Yes, that is fine. As long as the #ifdef lives in the DAX code and not here.
>
> We still need some ifdef in the efi core because that is the central
> location to make the policy distinction to identify identify
> EFI_CONVENTIONAL_MEMORY differently depending on whether EFI_MEMORY_SP
> is present. I agree with you that "dax" should be dropped from the
> naming. So how about:
>
> #ifdef CONFIG_EFI_APPLICATION_RESERVED
> static inline bool is_efi_application_reserved(efi_memory_desc_t *md)
> {
>         return md->type == EFI_CONVENTIONAL_MEMORY
>                 && (md->attribute & EFI_MEMORY_SP);
> }
> #else
> static inline bool is_efi_application_reserved(efi_memory_desc_t *md)
> {
>         return false;
> }
> #endif

I think this policy decision should not live inside the EFI subsystem.
EFI just gives you the memory map, and mangling that information
depending on whether you think a certain memory attribute should be
ignored is the job of the MM subsystem.
