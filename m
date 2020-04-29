Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 096D01BEA13
	for <lists+linux-efi@lfdr.de>; Wed, 29 Apr 2020 23:39:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbgD2Vjs (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 29 Apr 2020 17:39:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726481AbgD2Vjr (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 29 Apr 2020 17:39:47 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6A6BC03C1AE;
        Wed, 29 Apr 2020 14:39:47 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id k12so3302939qtm.4;
        Wed, 29 Apr 2020 14:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=//81xuDvw91NBaGMo+Bz8c0hjBsHlIYF4T1Vb0VVEKY=;
        b=VEWbDlyyto3P5se9pAuHdp3HB7tEO93f8SekLR2N5ljJaViCYo9BN7XM+EBsZP8Lcp
         7lwk3pxG7w0ekHWl4HQGpDNCL9jDRtHuvWpbnaEMR5EBT40WdVkohAVs3OhuHYf4R6Ki
         ZONR+NCueT96EBBRY9dbWnNyyvh6NMuhJVj8AdMG3athLtFTOulaIh4TSi3FRjhz6FTj
         6WY5j+royn9wy9jWJWsYJC9Bs9HYhxPDglBjQrclZV/+Ua+MmR/j/WXL4tPPELnkFRie
         fFvvgQI8bkkioU/8ZI5qmROcUR3OGreyuTuR8TDXmdZ4pQ93Ev0gJBhirMbnF+Ya/+ue
         hyGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=//81xuDvw91NBaGMo+Bz8c0hjBsHlIYF4T1Vb0VVEKY=;
        b=IDqUJO7fzcqr7wdRxrqBh4EAnRJYHzE9ghBvosMBc7vhr3QS1U2y0MUAx1MIAPUOUc
         D0ARzTFiJY4iTzQhII+tFOf3jsECsbBE6SSXxeP8nCb7MUyYJaFeTfBMOyBvzPTS/rza
         LcaL2x7nYtripC1txkO9HFHc/n1GWnpEzjzieyXa/6SlE+WYjC4VBniNODlDE55SDBJ/
         ikxeTdc2nz+lnv9Qe3h46usg/aRBkZO/C5qHDuWZIKredc8qfBktWRKDUu+kWPpmC1vE
         aZyhwERL8jIwnkit4DuCQyvLFP3beUkpqpl176k2xOGqctP8mUSNhgGplrazur+uaDB4
         x4oA==
X-Gm-Message-State: AGi0PubcAsqV3mZRs1WWRkiznv52xG1wfUIg85Cu00dPd7ovTMbeK37f
        r97QesSB7cp+mHMTXOMK5v0=
X-Google-Smtp-Source: APiQypL5f0/42X6H/Sqf+fFr1BX3JRcnlSfKpVCtbEvEzXJ/Aj+6ETtsQMvrDFCx10DysP0NzjLt4A==
X-Received: by 2002:aed:2e65:: with SMTP id j92mr347270qtd.273.1588196386857;
        Wed, 29 Apr 2020 14:39:46 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id u11sm418859qtj.10.2020.04.29.14.39.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 14:39:46 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Wed, 29 Apr 2020 17:39:44 -0400
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        linux-efi <linux-efi@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 09/10] efi/x86: Support builtin command line
Message-ID: <20200429213944.GB1621173@rani.riverdale.lan>
References: <20200429174120.1497212-1-nivedita@alum.mit.edu>
 <20200429174120.1497212-11-nivedita@alum.mit.edu>
 <CAMj1kXF_-ZA4ghy_8Gx831UcAwn0VjFmDub5L1_h28vV+sdPDw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXF_-ZA4ghy_8Gx831UcAwn0VjFmDub5L1_h28vV+sdPDw@mail.gmail.com>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Apr 29, 2020 at 09:07:32PM +0200, Ard Biesheuvel wrote:
> On Wed, 29 Apr 2020 at 19:41, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> >
> > Add support for the x86 CMDLINE_BOOL and CMDLINE_OVERRIDE configuration
> > options.
> >
> > Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> > ---
> >  drivers/firmware/efi/libstub/x86-stub.c | 12 ++++++++----
> >  1 file changed, 8 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
> > index 85a924fecc87..0faba30d6406 100644
> > --- a/drivers/firmware/efi/libstub/x86-stub.c
> > +++ b/drivers/firmware/efi/libstub/x86-stub.c
> > @@ -680,7 +680,6 @@ unsigned long efi_main(efi_handle_t handle,
> >         unsigned long buffer_start, buffer_end;
> >         struct setup_header *hdr = &boot_params->hdr;
> >         efi_status_t status;
> > -       unsigned long cmdline_paddr;
> >
> >         efi_system_table = sys_table_arg;
> >
> > @@ -739,9 +738,14 @@ unsigned long efi_main(efi_handle_t handle,
> >                 image_offset = 0;
> >         }
> >
> > -       cmdline_paddr = ((u64)hdr->cmd_line_ptr |
> > -                        ((u64)boot_params->ext_cmd_line_ptr << 32));
> > -       efi_parse_options((char *)cmdline_paddr);
> > +#ifdef CONFIG_CMDLINE_BOOL
> > +       efi_parse_options(CONFIG_CMDLINE);
> > +#endif
> 
> Can we use IS_ENABLED() here as well?

Unfortunately on x86, CONFIG_CMDLINE is not defined if
CONFIG_CMDLINE_BOOL isn't enabled. So turning this into an
IS_ENABLED(CONFIG_CMDLINE_BOOL) causes a compile error when it's
disabled due to CONFIG_CMDLINE being an undeclared symbol.

> 
> > +       if (!IS_ENABLED(CONFIG_CMDLINE_OVERRIDE)) {
> > +               unsigned long cmdline_paddr = ((u64)hdr->cmd_line_ptr |
> > +                                              ((u64)boot_params->ext_cmd_line_ptr << 32));
> > +               efi_parse_options((char *)cmdline_paddr);
> > +       }
> >
> >         /*
> >          * At this point, an initrd may already have been loaded by the
> > --
> > 2.26.2
> >
