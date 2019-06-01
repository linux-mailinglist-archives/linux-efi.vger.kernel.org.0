Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 150F9319AA
	for <lists+linux-efi@lfdr.de>; Sat,  1 Jun 2019 06:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726058AbfFAE0x (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 1 Jun 2019 00:26:53 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:38137 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbfFAE0x (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 1 Jun 2019 00:26:53 -0400
Received: by mail-oi1-f195.google.com with SMTP id 18so8479805oij.5
        for <linux-efi@vger.kernel.org>; Fri, 31 May 2019 21:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QNhOzt9mi4QEW/UkqlsD+LhM4aY8Y6V5JqJaEQnQrZQ=;
        b=eULIT2RUbl0QppQ6H9eCEst+tZtjWGfwdar6IgE+5A7dmFfh1ZeY2XyDRx/oNIhgUO
         GGNsqiKa0xpM3Nr2i9e786mXzhwNl/Xq1eonERgnlCZNWV/tYdtfaWjSgwdr/1tzfk/L
         5DO4m0UXmprTZzmKQs8b0kC5v7kUXidi2LJZrJxpAo3HErjCp/QvGRV6X0RTnBZ34ZKr
         udmUl3O34LWsBSKBasIJfybnTQpG5SpiwAMaozCzfOr3ifgomLjfRfGhu+foVEa36g3o
         TZY+dEmnqWFGw+Wg1ZmxdcQYZRfNnHrzZWhRHxNEjj6tazoyTq109M4x5OzNtB7fQ9aZ
         sgdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QNhOzt9mi4QEW/UkqlsD+LhM4aY8Y6V5JqJaEQnQrZQ=;
        b=YwM+J248CA1No0NrRb3wgMRo08bZt/wErccNRdVfDGbbvxvf8N5Cy6kfFikVmvi464
         oxhEYsUkfC2pwcVoK3qyXSr7S/1fiPtzdvWvAXgycHzVYPZUaKYiDG34Tsd5nGEw+M6N
         CXStI26FssretHv91wbiNgMFnI2eso3KIhvJnYCRgg1mpdBJ/KG4wegdtpo/kMm/Y+Hy
         EEEn6VUCvfK13lpwxjl5IFQ8jCg2nUc3u5pdR8STaKn84mD5bJGhLtDP1j3SUZVgpGYM
         6zTZXdgc2LGbhw6aAnYoDwlXZt+HkdBdgpV8E1c9ykXYZSNlt5+bjeUoPOeMDq7Zlfnc
         ETFA==
X-Gm-Message-State: APjAAAWKWP+gaRwMyApZhXH7TWtoiM91IxotQMak6m8hrZpox58dcKO9
        1/7bVfM4OvuXR2ijfWOIO7wGNvv4phO8rilLxuWJ7A==
X-Google-Smtp-Source: APXvYqzaVrB3g+ABIuTUypcECW4eQQb+L1oF8XmOAVSlRCVDBJ3IC+ot8aNdAKsRh5Ex61K+ZnvQLoiDoa1OvrTEoaY=
X-Received: by 2002:aca:6087:: with SMTP id u129mr1104493oib.70.1559363212074;
 Fri, 31 May 2019 21:26:52 -0700 (PDT)
MIME-Version: 1.0
References: <155925716254.3775979.16716824941364738117.stgit@dwillia2-desk3.amr.corp.intel.com>
 <155925718351.3775979.13546720620952434175.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CAKv+Gu-J3-66V7UhH3=AjN4sX7iydHNF7Fd+SMbezaVNrZQmGQ@mail.gmail.com>
 <CAPcyv4g-GNe2vSYTn0a6ivQYxJdS5khE4AJbcxysoGPsTZwswg@mail.gmail.com> <CAKv+Gu83QB6x8=LCaAcR0S65WELC-Y+Voxw6LzaVh4FSV3bxYA@mail.gmail.com>
In-Reply-To: <CAKv+Gu83QB6x8=LCaAcR0S65WELC-Y+Voxw6LzaVh4FSV3bxYA@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 31 May 2019 21:26:40 -0700
Message-ID: <CAPcyv4hXBJBMrqoUr4qG5A3CUVgWzWK6bfBX29JnLCKDC7CiGA@mail.gmail.com>
Subject: Re: [PATCH v2 4/8] x86, efi: Reserve UEFI 2.8 Specific Purpose Memory
 for dax
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
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

On Fri, May 31, 2019 at 8:30 AM Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
>
> On Fri, 31 May 2019 at 17:28, Dan Williams <dan.j.williams@intel.com> wrote:
> >
> > On Fri, May 31, 2019 at 1:30 AM Ard Biesheuvel
> > <ard.biesheuvel@linaro.org> wrote:
> > >
> > > (cc Mike for memblock)
> > >
> > > On Fri, 31 May 2019 at 01:13, Dan Williams <dan.j.williams@intel.com> wrote:
> > > >
> > > > UEFI 2.8 defines an EFI_MEMORY_SP attribute bit to augment the
> > > > interpretation of the EFI Memory Types as "reserved for a special
> > > > purpose".
> > > >
> > > > The proposed Linux behavior for specific purpose memory is that it is
> > > > reserved for direct-access (device-dax) by default and not available for
> > > > any kernel usage, not even as an OOM fallback. Later, through udev
> > > > scripts or another init mechanism, these device-dax claimed ranges can
> > > > be reconfigured and hot-added to the available System-RAM with a unique
> > > > node identifier.
> > > >
> > > > This patch introduces 3 new concepts at once given the entanglement
> > > > between early boot enumeration relative to memory that can optionally be
> > > > reserved from the kernel page allocator by default. The new concepts
> > > > are:
> > > >
> > > > - E820_TYPE_SPECIFIC: Upon detecting the EFI_MEMORY_SP attribute on
> > > >   EFI_CONVENTIONAL memory, update the E820 map with this new type. Only
> > > >   perform this classification if the CONFIG_EFI_SPECIFIC_DAX=y policy is
> > > >   enabled, otherwise treat it as typical ram.
> > > >
> > >
> > > OK, so now we have 'special purpose', 'specific' and 'app specific'
> > > [below]. Do they all mean the same thing?
> >
> > I struggled with separating the raw-EFI-type name from the name of the
> > Linux specific policy. Since the reservation behavior is optional I
> > was thinking there should be a distinct Linux kernel name for that
> > policy. I did try to go back and change all occurrences of "special"
> > to "specific" from the RFC to this v2, but seems I missed one.
> >
>
> OK

I'll go ahead and use "application reserved" terminology consistently
throughout the code to distinguish that Linux translation from the raw
"EFI specific purpose" attribute.

>
> > >
> > > > - IORES_DESC_APPLICATION_RESERVED: Add a new I/O resource descriptor for
> > > >   a device driver to search iomem resources for application specific
> > > >   memory. Teach the iomem code to identify such ranges as "Application
> > > >   Reserved".
> > > >
> > > > - MEMBLOCK_APP_SPECIFIC: Given the memory ranges can fallback to the
> > > >   traditional System RAM pool the expectation is that they will have
> > > >   typical SRAT entries. In order to support a policy of device-dax by
> > > >   default with the option to hotplug later, the numa initialization code
> > > >   is taught to avoid marking online MEMBLOCK_APP_SPECIFIC regions.
> > > >
> > >
> > > Can we move the generic memblock changes into a separate patch please?
> >
> > Yeah, that can move to a lead-in patch.
> >
> > [..]
> > > > diff --git a/include/linux/efi.h b/include/linux/efi.h
> > > > index 91368f5ce114..b57b123cbdf9 100644
> > > > --- a/include/linux/efi.h
> > > > +++ b/include/linux/efi.h
> > > > @@ -129,6 +129,19 @@ typedef struct {
> > > >         u64 attribute;
> > > >  } efi_memory_desc_t;
> > > >
> > > > +#ifdef CONFIG_EFI_SPECIFIC_DAX
> > > > +static inline bool is_efi_dax(efi_memory_desc_t *md)
> > > > +{
> > > > +       return md->type == EFI_CONVENTIONAL_MEMORY
> > > > +               && (md->attribute & EFI_MEMORY_SP);
> > > > +}
> > > > +#else
> > > > +static inline bool is_efi_dax(efi_memory_desc_t *md)
> > > > +{
> > > > +       return false;
> > > > +}
> > > > +#endif
> > > > +
> > > >  typedef struct {
> > > >         efi_guid_t guid;
> > > >         u32 headersize;
> > >
> > > I'd prefer it if we could avoid this DAX policy distinction leaking
> > > into the EFI layer.
> > >
> > > IOW, I am fine with having a 'is_efi_sp_memory()' helper here, but
> > > whether that is DAX memory or not should be decided in the DAX layer.
> >
> > Ok, how about is_efi_sp_ram()? Since EFI_MEMORY_SP might be applied to
> > things that aren't EFI_CONVENTIONAL_MEMORY.
>
> Yes, that is fine. As long as the #ifdef lives in the DAX code and not here.

We still need some ifdef in the efi core because that is the central
location to make the policy distinction to identify identify
EFI_CONVENTIONAL_MEMORY differently depending on whether EFI_MEMORY_SP
is present. I agree with you that "dax" should be dropped from the
naming. So how about:

#ifdef CONFIG_EFI_APPLICATION_RESERVED
static inline bool is_efi_application_reserved(efi_memory_desc_t *md)
{
        return md->type == EFI_CONVENTIONAL_MEMORY
                && (md->attribute & EFI_MEMORY_SP);
}
#else
static inline bool is_efi_application_reserved(efi_memory_desc_t *md)
{
        return false;
}
#endif
