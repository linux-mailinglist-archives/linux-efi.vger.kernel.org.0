Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6091683EB
	for <lists+linux-efi@lfdr.de>; Fri, 21 Feb 2020 17:45:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726150AbgBUQpy (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 21 Feb 2020 11:45:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:47106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726132AbgBUQpy (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 21 Feb 2020 11:45:54 -0500
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A124724673
        for <linux-efi@vger.kernel.org>; Fri, 21 Feb 2020 16:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582303552;
        bh=Pns+ERY7mpTMf04NOQCmngZvRZZtQGF/khd1faPzvo0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hpODqaIPLQ6FPydOMO0UFxS71ogf89iJcP0MmU5Yb/I+DFlnfI64/PZvm9e05ylB9
         hhKFF5/EIsARyVBNPHvD+BqTn6NURuCZ7wWRIWYT8vcxVJayaL48eJkMT0qwogqI+G
         KN4tdwI6pCDkj0/6tTAgcMOXjMUk+eQEXV9pqCIk=
Received: by mail-wr1-f47.google.com with SMTP id z3so2784856wru.3
        for <linux-efi@vger.kernel.org>; Fri, 21 Feb 2020 08:45:52 -0800 (PST)
X-Gm-Message-State: APjAAAUIiN8JQDbHrl3QQ9eLNO5xyp8lma/dNRdDbJZAORdvIgphohjI
        cdaWcIHE9U0btSH3ObKBMYR0NhdCnSVZoKiUh8Jn5Q==
X-Google-Smtp-Source: APXvYqzYiqkbWcZsThISpUsgu3zjOcTUy1IyBUajc2V79w/UFgUxPc3gKgoogmJ6rA/b5DBpfcoPWoGeFaT1rqZs9sM=
X-Received: by 2002:adf:fd8d:: with SMTP id d13mr50163730wrr.208.1582303551022;
 Fri, 21 Feb 2020 08:45:51 -0800 (PST)
MIME-Version: 1.0
References: <20200217144822.24616-1-ardb@kernel.org> <20200217144822.24616-2-ardb@kernel.org>
 <20200221164010.GB2766905@rani.riverdale.lan>
In-Reply-To: <20200221164010.GB2766905@rani.riverdale.lan>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 21 Feb 2020 17:45:40 +0100
X-Gmail-Original-Message-ID: <CAKv+Gu89Y8RP9-cS3z+m6gpkp3Wy-n6FxocMwOSsrGobWUw3Jg@mail.gmail.com>
Message-ID: <CAKv+Gu89Y8RP9-cS3z+m6gpkp3Wy-n6FxocMwOSsrGobWUw3Jg@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] efi/x86: Drop redundant .bss section
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Laszlo Ersek <lersek@redhat.com>,
        Leif Lindholm <leif@nuviainc.com>,
        Peter Jones <pjones@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        Alexander Graf <agraf@csgraf.de>,
        Daniel Kiper <daniel.kiper@oracle.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 21 Feb 2020 at 17:40, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> On Mon, Feb 17, 2020 at 03:48:18PM +0100, Ard Biesheuvel wrote:
> > In commit
> >
> >   c7fb93ec51d462ec ("x86/efi: Include a .bss section within the PE/COFF headers")
> >
> > we added a separate .bss section to the PE/COFF header of the compressed
> > kernel describing the static memory footprint of the decompressor, to
> > ensure that it has enough headroom to decompress itself.
> >
> > We can achieve the exact same result by increasing the virtual size of
> > the .text section, without changing the raw size, which, as per the
> > PE/COFF specification, requires the loader to zero initialize the delta.
> >
> > Doing so frees up a slot in the section table, which we will use later
> > to describe the mixed mode entrypoint.
> >
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
> >  arch/x86/boot/header.S      | 21 +-----------
> >  arch/x86/boot/tools/build.c | 35 ++++++++------------
> >  2 files changed, 14 insertions(+), 42 deletions(-)
> >
> > diff --git a/arch/x86/boot/tools/build.c b/arch/x86/boot/tools/build.c
> > index 55e669d29e54..0c8c5a52f1f0 100644
> > --- a/arch/x86/boot/tools/build.c
> > +++ b/arch/x86/boot/tools/build.c
> > @@ -203,10 +203,12 @@ static void update_pecoff_setup_and_reloc(unsigned int size)
> >       put_unaligned_le32(10, &buf[reloc_offset + 4]);
> >  }
> >
> > -static void update_pecoff_text(unsigned int text_start, unsigned int file_sz)
> > +static void update_pecoff_text(unsigned int text_start, unsigned int file_sz,
> > +                            unsigned int init_sz)
> >  {
> >       unsigned int pe_header;
> >       unsigned int text_sz = file_sz - text_start;
> > +     unsigned int bss_sz = init_sz - file_sz;
> >
> >       pe_header = get_unaligned_le32(&buf[0x3c]);
> >
> > @@ -216,28 +218,19 @@ static void update_pecoff_text(unsigned int text_start, unsigned int file_sz)
> >        */
> >       put_unaligned_le32(file_sz - 512, &buf[pe_header + 0x1c]);
> >
> > -     /*
> > -      * Address of entry point for PE/COFF executable
> > -      */
> > -     put_unaligned_le32(text_start + efi_pe_entry, &buf[pe_header + 0x28]);
> > -
> > -     update_pecoff_section_header(".text", text_start, text_sz);
> > -}
> > -
> > -static void update_pecoff_bss(unsigned int file_sz, unsigned int init_sz)
> > -{
> > -     unsigned int pe_header;
> > -     unsigned int bss_sz = init_sz - file_sz;
> > -
> > -     pe_header = get_unaligned_le32(&buf[0x3c]);
> > -
> >       /* Size of uninitialized data */
> >       put_unaligned_le32(bss_sz, &buf[pe_header + 0x24]);
>
> Should this still be populated given that there's no .bss section any
> more?

Good point. The PE/COFF spec is explicit, for a change, and
specifically mentions that this should be the combined sizeof all BSS
sections. It doesn't really specify how one could have multiple BSS
sections, but the wording does support your view that this should be
zero, and the value of bss_sz added to the SizeOfText field.

I couldn't find any code in EDK2 that actually references this field
(apart from the ELF to PE/COFF converter that always sets it to 0x0),
and so I don't think it really matters.
