Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD96B35952D
	for <lists+linux-efi@lfdr.de>; Fri,  9 Apr 2021 08:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231280AbhDIGLL (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 9 Apr 2021 02:11:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:60092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229715AbhDIGLL (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 9 Apr 2021 02:11:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CE2CD61168
        for <linux-efi@vger.kernel.org>; Fri,  9 Apr 2021 06:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617948658;
        bh=2CnXvGWo2BCAh7NB7UTnDzOwAoFrMz50mGWvgvLepIQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rIedZz5nP8eiZDpSGOtNEgOSDn13xsEMRGPYGgNiSnQZISBWgtLHEYEPapKZvwkIb
         +oG+AsE/YhA8zxg53Ixk4JL2/qkk/IyxBpdbfmVchjV/E5IxKXMDAcvGwSGfJx5+j8
         yl3SYZRq6vGxLYolXcT8DAL2UPAVYa0zw7e3Oacj7d37esWjCizbFrIRqiz2XlUBTC
         9Tq3bKpCrgHan/ophId5MN/N/hhSTBC66rjLGm820HSlXtWloQ6pzVjJa2oFoQHe3O
         bbqI0tuJ3Qu2QULBXYE2g1u2r0WhYjk3qK0Gb8ftfYHgK0RHTZmPIIau2E0iGL0r/2
         Q3wkfoij/XRvA==
Received: by mail-ot1-f43.google.com with SMTP id 91-20020a9d08640000b0290237d9c40382so4645337oty.12
        for <linux-efi@vger.kernel.org>; Thu, 08 Apr 2021 23:10:58 -0700 (PDT)
X-Gm-Message-State: AOAM530MVbE7DzGm6ghF4kW+4yxx578ZsVawflSQRfXHYW5N8TmzXtLc
        92vEs/031bwZFSWxWcp3D4ZriOvMIXstIN8Tays=
X-Google-Smtp-Source: ABdhPJwMpQLd8Tp+LeBSJVYrZXv1Sf5UhczUTGD/GB3FWcC6IpyzMxiAu55hH0vP1OM6K2lHho4Q0uPRGxPSSovjolg=
X-Received: by 2002:a9d:7ccf:: with SMTP id r15mr10616439otn.108.1617948658117;
 Thu, 08 Apr 2021 23:10:58 -0700 (PDT)
MIME-Version: 1.0
References: <20201025134941.4805-1-ard.biesheuvel@arm.com> <20201025134941.4805-4-ard.biesheuvel@arm.com>
 <19e3bf0e-8bec-2485-1f79-4859ab0d7de5@gmx.de>
In-Reply-To: <19e3bf0e-8bec-2485-1f79-4859ab0d7de5@gmx.de>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 9 Apr 2021 08:10:47 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHjZ15gGkR7vazVuMViLE5wgzgjxH+RkGbYVfkx30MWXA@mail.gmail.com>
Message-ID: <CAMj1kXHjZ15gGkR7vazVuMViLE5wgzgjxH+RkGbYVfkx30MWXA@mail.gmail.com>
Subject: Re: [PATCH v2 3/8] efi: move MS-DOS stub out of generic PE header definition
To:     Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc:     Ard Biesheuvel <ard.biesheuvel@arm.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        Daniel Kiper <dkiper@net-space.pl>,
        GRUB development mailing list <grub-devel@gnu.org>,
        "Leif Lindholm <Leif Lindholm" <leif@nuviainc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 8 Apr 2021 at 20:45, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 10/25/20 2:49 PM, Ard Biesheuvel wrote:
> > The PE/COFF spec permits the COFF signature and file header to appear
> > anywhere in the file, and the actual offset is recorded in 4 byte
> > little endian field at offset 0x3c of the image.
> >
> > When GRUB is emitted as a PE/COFF binary, we reuse the 128 byte MS-DOS
> > stub (even for non-x86 architectures), putting the COFF signature and
> > file header at offset 0x80. However, other PE/COFF images may use
> > different values, and non-x86 Linux kernels use an offset of 0x40
> > instead.
> >
> > So let's get rid of the grub_pe32_header struct from pe32.h, given that
> > it does not represent anything defined by the PE/COFF spec. Instead,
> > use the GRUB_PE32_MSDOS_STUB_SIZE macro explicitly to reference the
> > COFF header in the only place in the code where we rely on this.
> >
> > The remaining fields are moved into a struct grub_coff_image_header,
> > which we will use later to access COFF header fields of arbitrary
> > images (and which may therefore appear at different offsets)
> >
> > Signed-off-by: Ard Biesheuvel <ard.biesheuvel@arm.com>
> > ---
> >   grub-core/kern/efi/efi.c | 5 +++--
> >   include/grub/efi/pe32.h  | 5 +----
> >   2 files changed, 4 insertions(+), 6 deletions(-)
> >
> > diff --git a/grub-core/kern/efi/efi.c b/grub-core/kern/efi/efi.c
> > index e0165e74c587..9e5a72be538d 100644
> > --- a/grub-core/kern/efi/efi.c
> > +++ b/grub-core/kern/efi/efi.c
> > @@ -282,7 +282,7 @@ grub_addr_t
> >   grub_efi_modules_addr (void)
> >   {
> >     grub_efi_loaded_image_t *image;
> > -  struct grub_pe32_header *header;
> > +  struct grub_coff_image_header *header;
> >     struct grub_pe32_coff_header *coff_header;
> >     struct grub_pe32_section_table *sections;
> >     struct grub_pe32_section_table *section;
> > @@ -293,7 +293,8 @@ grub_efi_modules_addr (void)
> >     if (! image)
> >       return 0;
> >
> > -  header = image->image_base;
> > +  header = (struct grub_coff_image_header *) ((char *) image->image_base
> > +                                           + GRUB_PE32_MSDOS_STUB_SIZE);
>
> After checking that the file starts with the letters 'MZ' we can find at
> file offset 0x3c the position of the 'PE\0\0' indicating the start of
> the COFF header. This avoids relying upon any fixed offset and conforms
> to the PE Format specification.
>

I think you might be missing the point here. This is not about
arbitrary PE/COFF images that GRUB loads, this is about the PE/COFF
image that is constructed by the GRUB build system to carry GRUB
itself: what would be the point of extracting the offset from the
image if we always put the PE header at the same offset?

In any case, I don't care deeply one way or the other, so feel free to
propose an alternative to this patch.


> See
> https://docs.microsoft.com/en-us/windows/win32/debug/pe-format#ms-dos-stub-image-only
>
> Best regards
>
> Heinrich
>
> >     coff_header = &(header->coff_header);
> >     sections
> >       = (struct grub_pe32_section_table *) ((char *) coff_header
> > diff --git a/include/grub/efi/pe32.h b/include/grub/efi/pe32.h
> > index 0ed8781f0376..a2da4b318c85 100644
> > --- a/include/grub/efi/pe32.h
> > +++ b/include/grub/efi/pe32.h
> > @@ -254,11 +254,8 @@ struct grub_pe32_section_table
> >
> >   #define GRUB_PE32_SIGNATURE_SIZE 4
> >
> > -struct grub_pe32_header
> > +struct grub_coff_image_header
> >   {
> > -  /* This should be filled in with GRUB_PE32_MSDOS_STUB.  */
> > -  grub_uint8_t msdos_stub[GRUB_PE32_MSDOS_STUB_SIZE];
> > -
> >     /* This is always PE\0\0.  */
> >     char signature[GRUB_PE32_SIGNATURE_SIZE];
> >
> >
>
