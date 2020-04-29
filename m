Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB7BF1BEA49
	for <lists+linux-efi@lfdr.de>; Wed, 29 Apr 2020 23:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726929AbgD2Vvd (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 29 Apr 2020 17:51:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:43232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726554AbgD2Vvd (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 29 Apr 2020 17:51:33 -0400
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B22B720B1F;
        Wed, 29 Apr 2020 21:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588197092;
        bh=zzbAROcZjDIWpI2AVBgh/PsMuE+z2F5jB65yqNftvhY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CDechDbWVk1cf54E1W1FviFigjrzDWvi/YUHL8US/DxGCUTz/PzTgFEsx1vNofl97
         tyuQh+LnjOBsqRsh1ZxpZ7+r4eoRKewidDHwQk9QWPDWmYChBezbumijWLBnX2sWWs
         ajaA1ILzCJn8AIB5pAya4Y3MTrGYBNBtD7hJMezQ=
Received: by mail-io1-f49.google.com with SMTP id b12so3926450ion.8;
        Wed, 29 Apr 2020 14:51:32 -0700 (PDT)
X-Gm-Message-State: AGi0PuZefrSESEw9a/GeNxtpQTKzO+C50rRhkKqDGTaCcSkFk8AHF+j/
        sk5yOLKInjAhICIXR3Bh/BgwxDZjaQGpCY9z5fI=
X-Google-Smtp-Source: APiQypINNclMKxGwHaJyPAEG7gd4uP2wdISWcWZ/mrGkVwaeY3K4I6ejEkqM2J/mhockQu94EgMDMwpqPah8cxjLulY=
X-Received: by 2002:a6b:5904:: with SMTP id n4mr273245iob.142.1588197091171;
 Wed, 29 Apr 2020 14:51:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200429174120.1497212-1-nivedita@alum.mit.edu>
 <20200429174120.1497212-11-nivedita@alum.mit.edu> <CAMj1kXF_-ZA4ghy_8Gx831UcAwn0VjFmDub5L1_h28vV+sdPDw@mail.gmail.com>
 <20200429213944.GB1621173@rani.riverdale.lan> <CAMj1kXHf9bXX8uDeSEL46r39uPiBOPjfmvkcL_MFtf9ZAo8ZqQ@mail.gmail.com>
 <20200429214855.GD1621173@rani.riverdale.lan>
In-Reply-To: <20200429214855.GD1621173@rani.riverdale.lan>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 29 Apr 2020 23:51:20 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFEFz7Exeah2MGEbxdR8OL4XtJXwxAn1TLr2Gqjv+k-rA@mail.gmail.com>
Message-ID: <CAMj1kXFEFz7Exeah2MGEbxdR8OL4XtJXwxAn1TLr2Gqjv+k-rA@mail.gmail.com>
Subject: Re: [PATCH 09/10] efi/x86: Support builtin command line
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     linux-efi <linux-efi@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 29 Apr 2020 at 23:48, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> On Wed, Apr 29, 2020 at 11:40:51PM +0200, Ard Biesheuvel wrote:
> > On Wed, 29 Apr 2020 at 23:39, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> > >
> > > On Wed, Apr 29, 2020 at 09:07:32PM +0200, Ard Biesheuvel wrote:
> > > > On Wed, 29 Apr 2020 at 19:41, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> > > > >
> > > > > Add support for the x86 CMDLINE_BOOL and CMDLINE_OVERRIDE configuration
> > > > > options.
> > > > >
> > > > > Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> > > > > ---
> > > > >  drivers/firmware/efi/libstub/x86-stub.c | 12 ++++++++----
> > > > >  1 file changed, 8 insertions(+), 4 deletions(-)
> > > > >
> > > > > diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
> > > > > index 85a924fecc87..0faba30d6406 100644
> > > > > --- a/drivers/firmware/efi/libstub/x86-stub.c
> > > > > +++ b/drivers/firmware/efi/libstub/x86-stub.c
> > > > > @@ -680,7 +680,6 @@ unsigned long efi_main(efi_handle_t handle,
> > > > >         unsigned long buffer_start, buffer_end;
> > > > >         struct setup_header *hdr = &boot_params->hdr;
> > > > >         efi_status_t status;
> > > > > -       unsigned long cmdline_paddr;
> > > > >
> > > > >         efi_system_table = sys_table_arg;
> > > > >
> > > > > @@ -739,9 +738,14 @@ unsigned long efi_main(efi_handle_t handle,
> > > > >                 image_offset = 0;
> > > > >         }
> > > > >
> > > > > -       cmdline_paddr = ((u64)hdr->cmd_line_ptr |
> > > > > -                        ((u64)boot_params->ext_cmd_line_ptr << 32));
> > > > > -       efi_parse_options((char *)cmdline_paddr);
> > > > > +#ifdef CONFIG_CMDLINE_BOOL
> > > > > +       efi_parse_options(CONFIG_CMDLINE);
> > > > > +#endif
> > > >
> > > > Can we use IS_ENABLED() here as well?
> > >
> > > Unfortunately on x86, CONFIG_CMDLINE is not defined if
> > > CONFIG_CMDLINE_BOOL isn't enabled. So turning this into an
> > > IS_ENABLED(CONFIG_CMDLINE_BOOL) causes a compile error when it's
> > > disabled due to CONFIG_CMDLINE being an undeclared symbol.
> > >
> >
> > What about
> >
> > efi_parse_options(CONFIG_CMDLINE "");
> >
> > ?
>
> That's still a syntax error if CONFIG_CMDLINE is undefined, no? It's not
> defined to be empty -- it's undefined. IS_ENABLED doesn't work on
> string-valued options so I can't use IS_ENABLED(CONFIG_CMDLINE) either.

I see. Not the end of the world to have to keep it as is, I was just curious.
