Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66F851A499E
	for <lists+linux-efi@lfdr.de>; Fri, 10 Apr 2020 20:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbgDJSB1 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 10 Apr 2020 14:01:27 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:42347 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbgDJSB1 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 10 Apr 2020 14:01:27 -0400
Received: by mail-qt1-f196.google.com with SMTP id b10so2061175qtt.9;
        Fri, 10 Apr 2020 11:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mQm+cfpWWNubJH8IeV0+wdXKUR9XPtCh19rQwA2lnYY=;
        b=CaveKvpOLQXG9VhSr0uDNp6G9Afwvp6Ys1zEJo7nBfUkRj+OVK4oMLcdM7OW8gV3yw
         InN4odf+FfCkSJstJGjCaH3Oy5aqir5boQPlBZfptZvJxNoy2RjM8gIn/jnEPV5OL3Er
         8yP4RDZ50n39q3l1QhAXtGfranzbVBNsBKX3FMSgZdCHWwv7P6L7xjQoPlW4GeOTDRDB
         +iiZkk9EJBfC82r+1wt8+f/D6mivq4igWA53XV6VJguSmSFdHr3skL2Do4El8fvHXvy9
         JQuSzY+P++qi0LQHkX8tJHr6J+jiWWngWMtnYq370tGQHiLJ8/TZXxcf1m6JkF5MOLuX
         J15g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=mQm+cfpWWNubJH8IeV0+wdXKUR9XPtCh19rQwA2lnYY=;
        b=SulLoZUtDm941b4FXb4OiXsaYYbGeo0WSZsjwjCHf6UxohYEF27EiJJGMr3JT+OSEg
         hwOLuRHOho9+7rM+16wCfR4E+jETSkyOauInxeOTp6gNhE78Zf92NFyT04KLNuSWuo4r
         p8wqfsGHPcg7Y2DwH12lpmaWhsFcgWJlO2hiPMcSOf3HtALb3AbBUqXrIrycL3Q6CEsQ
         z2PSfkZghpbN8200jBHFej+az54m6tQSgeuO3sGttJuKcgYVDE/L4hc8yHgERvjDiVod
         o7u4jhgZ3aB1UpielWSP1EvIRQlxLH2rjP7Ml9KQZ9Qrgr11VP4ahp4OTWXkP/+4yQjz
         FIUQ==
X-Gm-Message-State: AGi0PuZeOMXJvfvPALP9LlJvOZHsO4ul1V5WJNbRkc3R+06xCBDtl0kY
        fkt7LC673YCui1Yl5LmCSA0=
X-Google-Smtp-Source: APiQypJoS5m7D4g6TWDyXhnb5ZHWGUcsE3hdGJF2RVjvUDaZXUFg2mYNnlkGd689BW6RpC2l02SINQ==
X-Received: by 2002:ac8:4e01:: with SMTP id c1mr400253qtw.170.1586541686346;
        Fri, 10 Apr 2020 11:01:26 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id g2sm2034804qtj.96.2020.04.10.11.01.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2020 11:01:25 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Fri, 10 Apr 2020 14:01:23 -0400
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Brian Gerst <brgerst@gmail.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@suse.de>,
        Colin Ian King <colin.king@canonical.com>,
        Gary Lin <glin@suse.com>, Jiri Slaby <jslaby@suse.cz>,
        Sergey Shatunov <me@prok.pw>, Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH 3/9] efi/x86: Move efi stub globals from .bss to .data
Message-ID: <20200410180123.GA1155098@rani.riverdale.lan>
References: <20200409130434.6736-1-ardb@kernel.org>
 <20200409130434.6736-4-ardb@kernel.org>
 <CAMzpN2gJWwVun1Kp6vGuza9LM5KpB=0EwsP8x8eOJQuDGh38Hg@mail.gmail.com>
 <CAMzpN2jFbf8k99pWaTYRBmSB+iNAKYsufjEhqO6Vv0qxAcHyGA@mail.gmail.com>
 <20200409210847.GA1312580@rani.riverdale.lan>
 <CAMj1kXFhtK=FRDKBE5OtenNEtpK=kVwyo+0nqJZ_K80RmtYxEg@mail.gmail.com>
 <20200410151612.GA970420@rani.riverdale.lan>
 <CAMj1kXGMNMdgjinYNgrN2wGRFG4rKE2YHo-=3s4Ofv2KPUMqKQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXGMNMdgjinYNgrN2wGRFG4rKE2YHo-=3s4Ofv2KPUMqKQ@mail.gmail.com>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Apr 10, 2020 at 06:03:38PM +0200, Ard Biesheuvel wrote:
> On Fri, 10 Apr 2020 at 17:16, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> >
> > On Fri, Apr 10, 2020 at 10:20:42AM +0200, Ard Biesheuvel wrote:
> > > On Thu, 9 Apr 2020 at 23:08, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> > > >
> > > > On Thu, Apr 09, 2020 at 04:53:07PM -0400, Brian Gerst wrote:
> > > > > > Can we use the -fno-zero-initialized-in-bss compiler flag instead of
> > > > > > explicitly marking global variables?
> > > > >
> > > > > Scratch that.  Apparently it only works when a variable is explicitly
> > > > > initialized to zero.
> > > > >
> > > > > --
> > > > > Brian Gerst
> > > >
> > > > Right, there doesn't seem to be a compiler option to turn off the use of
> > > > .bss altogether.
> > >
> > > Yeah. I'll try to come up with a way to consolidate this a bit across
> > > architectures (which is a bit easier now that all of the EFI stub C
> > > code lives in the same place). It is probably easiest to use a section
> > > renaming trick similar to the one I added for ARM (as Arvind suggested
> > > as well, IIRC), and get rid of the per-symbol annotations altogether.
> >
> > Does that work for 32-bit ARM, or does it need to be .data to tell the
> > compiler to avoid generating GOT references? If that's fine, we don't
> > actually need to rename sections -- linker script magic is enough. For
> > eg, the below pulls the EFI stub bss into .data for x86 without the need
> > for the annotations.
> >
> > diff --git a/arch/x86/boot/compressed/vmlinux.lds.S b/arch/x86/boot/compressed/vmlinux.lds.S
> > index 508cfa6828c5..e324819c95bc 100644
> > --- a/arch/x86/boot/compressed/vmlinux.lds.S
> > +++ b/arch/x86/boot/compressed/vmlinux.lds.S
> > @@ -52,6 +52,7 @@ SECTIONS
> >                 _data = . ;
> >                 *(.data)
> >                 *(.data.*)
> > +               drivers/firmware/efi/libstub/lib.a:(.bss .bss.*)
> >                 _edata = . ;
> >         }
> >         . = ALIGN(L1_CACHE_BYTES);
> 
> No, we can add this to ARM as well, and get rid of the
> __efistub_global annotations entirely.

Cool.

> 
> We'll still need .data.efistub for the .data pieces, but that is a
> separate issue.

You can avoid that by using an archive specification like above. i.e.
adding
	drivers/firmware/efi/libstub/lib.a:(.data .data.*)
to the .init.data output section will pull in just the .data input
sections from the EFI stub into the .init.data section.
