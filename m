Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ADB61BEA2F
	for <lists+linux-efi@lfdr.de>; Wed, 29 Apr 2020 23:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbgD2Vs7 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 29 Apr 2020 17:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726950AbgD2Vs6 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 29 Apr 2020 17:48:58 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FA13C03C1AE;
        Wed, 29 Apr 2020 14:48:58 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id s63so3724201qke.4;
        Wed, 29 Apr 2020 14:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=thOleSHGhWbyHTDIvGgOd2/dGZB7Vh84eyjPoRKiWnQ=;
        b=teeEESUmzLLMOEc90ylDqcqx+Qfva8yu1CNLVDB8LPlO/RdfYgYiynsCiHuZ6CSq7y
         dd1Za8shoKcSXbm7Zn/9lrvmK7zgjCF8/tZa9M+lKNDDLM2nt4R6sG1LfMfL+uMEbUXB
         JjkH4ijiD9kUoEUaDaHUzGSxmO/MiUPUvXUc3cQkGXMZRShlhI85bkhYt3FhBtFfePJT
         77bsjgFMZNmZU6RZMbhyEUsaxx0EoxYBoRoTaNRJsTWVwKEp1Tu0/Dgg1bCL6kIwxbeD
         kiD2ksYa3IqrKKcKB/jv+/EdlD94C3RcoeG6zjYoBJ0itB26K/jOccJwq07uS7FIrXEw
         YrBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=thOleSHGhWbyHTDIvGgOd2/dGZB7Vh84eyjPoRKiWnQ=;
        b=OcdKW/Ks8QbfSwhooXFb1qh1Hbj+xxNBs2/u4hUMj1RCOYHtUxr7V/CQ7azH0fa2Hc
         zKN9vQ7PIyMbS4h796SigpPkJi/IFjg0NBF2F6YxIUNpJ/P/nUiuN281oteq2BiauYb+
         0bBTRyTZJh5Pw3x8IvP+v8nQLUkj05KoETk5+8k3plhNcLFVTXc9vLJNmIZXJuuWUl9h
         6K4a2nEi178tNSk56YZRqmp7SRMDlN5oJkFunnxw3GyLi5WXcPGviosv1qE/tQOxTk5j
         biGvIy0otpCC/AkBtCl22RySX94mBMnLYrg1fyEy6KQO/74bBQ+bgGNW+1OsN075Qbg+
         Kx5Q==
X-Gm-Message-State: AGi0PuZB7Kk9O8YARiYiZKx7n7No8BVuODHVw1sLmrWYyoVXgPlO5uJn
        7g/xqt+nUgZGz4vV2Z2iHh2HZqsGPxc=
X-Google-Smtp-Source: APiQypKY/EdqZ/JiagMoO4/EeKVtAr0upVP5Aae4lmR3rSpX8iCJ5cmj6wANetfMh+g7taAwygienw==
X-Received: by 2002:a37:6296:: with SMTP id w144mr574513qkb.310.1588196937327;
        Wed, 29 Apr 2020 14:48:57 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id p11sm309691qki.25.2020.04.29.14.48.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 14:48:56 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Wed, 29 Apr 2020 17:48:55 -0400
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        linux-efi <linux-efi@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 09/10] efi/x86: Support builtin command line
Message-ID: <20200429214855.GD1621173@rani.riverdale.lan>
References: <20200429174120.1497212-1-nivedita@alum.mit.edu>
 <20200429174120.1497212-11-nivedita@alum.mit.edu>
 <CAMj1kXF_-ZA4ghy_8Gx831UcAwn0VjFmDub5L1_h28vV+sdPDw@mail.gmail.com>
 <20200429213944.GB1621173@rani.riverdale.lan>
 <CAMj1kXHf9bXX8uDeSEL46r39uPiBOPjfmvkcL_MFtf9ZAo8ZqQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXHf9bXX8uDeSEL46r39uPiBOPjfmvkcL_MFtf9ZAo8ZqQ@mail.gmail.com>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Apr 29, 2020 at 11:40:51PM +0200, Ard Biesheuvel wrote:
> On Wed, 29 Apr 2020 at 23:39, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> >
> > On Wed, Apr 29, 2020 at 09:07:32PM +0200, Ard Biesheuvel wrote:
> > > On Wed, 29 Apr 2020 at 19:41, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> > > >
> > > > Add support for the x86 CMDLINE_BOOL and CMDLINE_OVERRIDE configuration
> > > > options.
> > > >
> > > > Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> > > > ---
> > > >  drivers/firmware/efi/libstub/x86-stub.c | 12 ++++++++----
> > > >  1 file changed, 8 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
> > > > index 85a924fecc87..0faba30d6406 100644
> > > > --- a/drivers/firmware/efi/libstub/x86-stub.c
> > > > +++ b/drivers/firmware/efi/libstub/x86-stub.c
> > > > @@ -680,7 +680,6 @@ unsigned long efi_main(efi_handle_t handle,
> > > >         unsigned long buffer_start, buffer_end;
> > > >         struct setup_header *hdr = &boot_params->hdr;
> > > >         efi_status_t status;
> > > > -       unsigned long cmdline_paddr;
> > > >
> > > >         efi_system_table = sys_table_arg;
> > > >
> > > > @@ -739,9 +738,14 @@ unsigned long efi_main(efi_handle_t handle,
> > > >                 image_offset = 0;
> > > >         }
> > > >
> > > > -       cmdline_paddr = ((u64)hdr->cmd_line_ptr |
> > > > -                        ((u64)boot_params->ext_cmd_line_ptr << 32));
> > > > -       efi_parse_options((char *)cmdline_paddr);
> > > > +#ifdef CONFIG_CMDLINE_BOOL
> > > > +       efi_parse_options(CONFIG_CMDLINE);
> > > > +#endif
> > >
> > > Can we use IS_ENABLED() here as well?
> >
> > Unfortunately on x86, CONFIG_CMDLINE is not defined if
> > CONFIG_CMDLINE_BOOL isn't enabled. So turning this into an
> > IS_ENABLED(CONFIG_CMDLINE_BOOL) causes a compile error when it's
> > disabled due to CONFIG_CMDLINE being an undeclared symbol.
> >
> 
> What about
> 
> efi_parse_options(CONFIG_CMDLINE "");
> 
> ?

That's still a syntax error if CONFIG_CMDLINE is undefined, no? It's not
defined to be empty -- it's undefined. IS_ENABLED doesn't work on
string-valued options so I can't use IS_ENABLED(CONFIG_CMDLINE) either.
