Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F9C91BEA16
	for <lists+linux-efi@lfdr.de>; Wed, 29 Apr 2020 23:41:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbgD2VlE (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 29 Apr 2020 17:41:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:39294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726511AbgD2VlE (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 29 Apr 2020 17:41:04 -0400
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F397220B1F;
        Wed, 29 Apr 2020 21:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588196464;
        bh=PiKJ0Zcclx7zxFJZauZJsh2q/PZ0w2dzU3Qo8l37Nfs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=V2BwzdyddFOhFfOyL9DMOOSHnupl1FQpNSkINwR7Co3bIN4J54qRfdmEli6CPyE9T
         JgIZcZwo31vF8opxNxOWb6wssnuXzLSB+S1Gkhp2n3822CBCU8zEbcsuJe2zPMv3+P
         DyVZcfD0/H86/ZZvefZvaOhOyaawQO+FXyK1z5zM=
Received: by mail-il1-f182.google.com with SMTP id m5so3939273ilj.10;
        Wed, 29 Apr 2020 14:41:03 -0700 (PDT)
X-Gm-Message-State: AGi0PubHkJzGP+w1fIXYByolWNeh/EmVwHGjOebi4JD8W0wgyACiML2c
        7yfPPkvEZVnXzqaQHZICehP2mvrdhTOBYYd1G+8=
X-Google-Smtp-Source: APiQypIHt4SIaQvB+vzV0BhbTo+9okeeoDEdkxDX4tgP3wDODxAVFVlI09ibxC2HXF7763WE3TQ16D63uu7+xHmIgko=
X-Received: by 2002:a92:607:: with SMTP id x7mr394396ilg.218.1588196463379;
 Wed, 29 Apr 2020 14:41:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200429174120.1497212-1-nivedita@alum.mit.edu>
 <20200429174120.1497212-11-nivedita@alum.mit.edu> <CAMj1kXF_-ZA4ghy_8Gx831UcAwn0VjFmDub5L1_h28vV+sdPDw@mail.gmail.com>
 <20200429213944.GB1621173@rani.riverdale.lan>
In-Reply-To: <20200429213944.GB1621173@rani.riverdale.lan>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 29 Apr 2020 23:40:51 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHf9bXX8uDeSEL46r39uPiBOPjfmvkcL_MFtf9ZAo8ZqQ@mail.gmail.com>
Message-ID: <CAMj1kXHf9bXX8uDeSEL46r39uPiBOPjfmvkcL_MFtf9ZAo8ZqQ@mail.gmail.com>
Subject: Re: [PATCH 09/10] efi/x86: Support builtin command line
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     linux-efi <linux-efi@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 29 Apr 2020 at 23:39, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> On Wed, Apr 29, 2020 at 09:07:32PM +0200, Ard Biesheuvel wrote:
> > On Wed, 29 Apr 2020 at 19:41, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> > >
> > > Add support for the x86 CMDLINE_BOOL and CMDLINE_OVERRIDE configuration
> > > options.
> > >
> > > Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> > > ---
> > >  drivers/firmware/efi/libstub/x86-stub.c | 12 ++++++++----
> > >  1 file changed, 8 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
> > > index 85a924fecc87..0faba30d6406 100644
> > > --- a/drivers/firmware/efi/libstub/x86-stub.c
> > > +++ b/drivers/firmware/efi/libstub/x86-stub.c
> > > @@ -680,7 +680,6 @@ unsigned long efi_main(efi_handle_t handle,
> > >         unsigned long buffer_start, buffer_end;
> > >         struct setup_header *hdr = &boot_params->hdr;
> > >         efi_status_t status;
> > > -       unsigned long cmdline_paddr;
> > >
> > >         efi_system_table = sys_table_arg;
> > >
> > > @@ -739,9 +738,14 @@ unsigned long efi_main(efi_handle_t handle,
> > >                 image_offset = 0;
> > >         }
> > >
> > > -       cmdline_paddr = ((u64)hdr->cmd_line_ptr |
> > > -                        ((u64)boot_params->ext_cmd_line_ptr << 32));
> > > -       efi_parse_options((char *)cmdline_paddr);
> > > +#ifdef CONFIG_CMDLINE_BOOL
> > > +       efi_parse_options(CONFIG_CMDLINE);
> > > +#endif
> >
> > Can we use IS_ENABLED() here as well?
>
> Unfortunately on x86, CONFIG_CMDLINE is not defined if
> CONFIG_CMDLINE_BOOL isn't enabled. So turning this into an
> IS_ENABLED(CONFIG_CMDLINE_BOOL) causes a compile error when it's
> disabled due to CONFIG_CMDLINE being an undeclared symbol.
>

What about

efi_parse_options(CONFIG_CMDLINE "");

?
