Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75C8319668A
	for <lists+linux-efi@lfdr.de>; Sat, 28 Mar 2020 15:10:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbgC1OKh (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 28 Mar 2020 10:10:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:47760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726045AbgC1OKh (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sat, 28 Mar 2020 10:10:37 -0400
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A8A052073B
        for <linux-efi@vger.kernel.org>; Sat, 28 Mar 2020 14:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585404636;
        bh=VZQs1gVf2IDvqb7BYuqbkw5L8XebB0Z1pH9jbPoh7V4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=zMEHFmCcv4skXGyPp3q9oQCV5QtzPbbi4zxNJSe0qmF811PIiKr1y8OPdo96GdWZR
         qWQE+FJbwr5/LV5rTVaHRyVcrJf+bANb+qNZHqwjsz7gMh6l22xSsM6RSYYICAGyZL
         LfMdjuQIFIdC2XVfLKoSNWC3RrwVLwQnZiR503Zc=
Received: by mail-il1-f177.google.com with SMTP id k29so11488319ilg.0
        for <linux-efi@vger.kernel.org>; Sat, 28 Mar 2020 07:10:36 -0700 (PDT)
X-Gm-Message-State: ANhLgQ0gWrTm8/7KRnbFZ7Q3X/LETOh1XjLjWx7EcA9Gw8ISncqCJ/AM
        x/G8NRXxP9fsiLm/AeiKGThqZzD0YVfK+Zg6tmQ=
X-Google-Smtp-Source: ADFU+vtUUV8KCdGbs2VMIFXaD36NbeZJ9wf0loihOXgvnZLn5Z+77lVV0SV0f1j/SLKGcgPBnbxm2yHStIABPZ4Qtfg=
X-Received: by 2002:a92:dcd1:: with SMTP id b17mr3891182ilr.80.1585404636052;
 Sat, 28 Mar 2020 07:10:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200326165905.2240-1-ardb@kernel.org> <20200326165905.2240-3-ardb@kernel.org>
 <20200328140648.GA234129@rani.riverdale.lan>
In-Reply-To: <20200328140648.GA234129@rani.riverdale.lan>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sat, 28 Mar 2020 15:10:25 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEgduoZjtC2b16vJLmjc5UpEgFBAMbVB+zebL_NmXrHJQ@mail.gmail.com>
Message-ID: <CAMj1kXEgduoZjtC2b16vJLmjc5UpEgFBAMbVB+zebL_NmXrHJQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] efi/arm64: increase the PE/COFF alignment so the
 kernel can run in place
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Arvind,

Thanks for taking a look.

On Sat, 28 Mar 2020 at 15:06, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> On Thu, Mar 26, 2020 at 05:59:05PM +0100, Ard Biesheuvel wrote:
> > Update the PE/COFF metadata so that the UEFI image loader will load the
> > kernel image at an offset that allows it to execute in place.
> >
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
> >  arch/arm64/kernel/efi-header.S | 2 +-
> >  arch/arm64/kernel/image-vars.h | 7 +++++++
> >  2 files changed, 8 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/arm64/kernel/efi-header.S b/arch/arm64/kernel/efi-header.S
> > index 914999ccaf8a..f9ee1c2a5fd6 100644
> > --- a/arch/arm64/kernel/efi-header.S
> > +++ b/arch/arm64/kernel/efi-header.S
> > @@ -32,7 +32,7 @@ optional_header:
> >
> >  extra_header_fields:
> >       .quad   0                                       // ImageBase
> > -     .long   SZ_4K                                   // SectionAlignment
> > +     .long   PECOFF_SECTION_ALIGNMENT                // SectionAlignment
> >       .long   PECOFF_FILE_ALIGNMENT                   // FileAlignment
> >       .short  0                                       // MajorOperatingSystemVersion
> >       .short  0                                       // MinorOperatingSystemVersion
> > diff --git a/arch/arm64/kernel/image-vars.h b/arch/arm64/kernel/image-vars.h
> > index be0a63ffed23..7a7fa3ba7b2f 100644
> > --- a/arch/arm64/kernel/image-vars.h
> > +++ b/arch/arm64/kernel/image-vars.h
> > @@ -15,6 +15,13 @@
> >  __efistub_kernel_size                = _edata - _text;
> >  __efistub_primary_entry_offset       = primary_entry - _text;
> >
> > +#ifndef CONFIG_RELOCATABLE
> > +PECOFF_SECTION_ALIGNMENT = SZ_4K;
> > +#elif THREAD_ALIGN > SEGMENT_ALIGN
> > +PECOFF_SECTION_ALIGNMENT = THREAD_ALIGN;
> > +#else
> > +PECOFF_SECTION_ALIGNMENT = SEGMENT_ALIGN;
> > +#endif
> >
> >  /*
> >   * The EFI stub has its own symbol namespace prefixed by __efistub_, to
> > --
> > 2.17.1
> >
>
> The section virtual addresses and (possibly) size of image need to be
> updated to be a multiple of PECOFF_SECTION_ALIGNMENT, no?

Indeed. I spotted that after sending this patch - both _end and
_initdata_begin need to be aligned to this value. I also noticed that
it is unclear whether values over 64 KB are permitted: the PE/COFF
spec mentions that 64 KB is the max for FileAlignment, and that
SectionAlignment should be larger or equal to that.

So I think it would be better to set this value to 64 KB
unconditionally, and round up the sections to 64 KB. This means 64k
pagesize kernels with vmap'ed stack have a 50% chance of ending up at
an offset that requires moving the image, but this is still an
improvement over doing it all the time.
