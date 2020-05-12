Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10D6F1CF30C
	for <lists+linux-efi@lfdr.de>; Tue, 12 May 2020 13:05:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729365AbgELLFe (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 12 May 2020 07:05:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:32922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726891AbgELLFe (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 12 May 2020 07:05:34 -0400
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 26E6D20722;
        Tue, 12 May 2020 11:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589281533;
        bh=QcetHZ/WV7SzOJx7y3VtilFa5AxOHu2bW9ktZoVYN/8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=g45yf8oAz8COKkI+/aNxUYoI8+RyfVkKuD/2x13IgI/2BtQix5kFieBTfvI6Q3X+a
         Wbe4E+tvMvgSq1LGxSFgkBvIRSdnDuMc3Fa3HkwHeB6VTsLUQiadWSDzZROCKgkLur
         7eHTpecphnAV/nINzUsnKsRXEZbDTMAVDTzd8w2w=
Received: by mail-il1-f176.google.com with SMTP id m5so11771847ilj.10;
        Tue, 12 May 2020 04:05:33 -0700 (PDT)
X-Gm-Message-State: AGi0PuZtJwfq0YMFVrTFnACtn9xegIjVrOdVHsT8++UHpXal5LixxjIP
        Al3PLeG8etkxMazHkzvw9E3shDiJpgFjhugvUTk=
X-Google-Smtp-Source: APiQypJ87UPF7eEiYkWix4Qz1SdTjtsmUwKgHSVI39lmUIv19DKowo9AsBvtjj+BK5//JAqLu10TWJ1qAp9cXkFgP54=
X-Received: by 2002:a05:6e02:673:: with SMTP id l19mr1147334ilt.218.1589281532506;
 Tue, 12 May 2020 04:05:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200511225324.GA1307788@rani.riverdale.lan> <20200511225849.1311869-1-nivedita@alum.mit.edu>
 <CAHbf0-HLKiq_+erhHfV9XqMhfchN2975nAsuya4-oXEOUNdhiw@mail.gmail.com>
In-Reply-To: <CAHbf0-HLKiq_+erhHfV9XqMhfchN2975nAsuya4-oXEOUNdhiw@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 12 May 2020 13:05:21 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGbUg3g-s5qoHgrYoBnoJLR9Oc7YrCO1xMHx-+Ys6=Tfg@mail.gmail.com>
Message-ID: <CAMj1kXGbUg3g-s5qoHgrYoBnoJLR9Oc7YrCO1xMHx-+Ys6=Tfg@mail.gmail.com>
Subject: Re: [PATCH] x86/boot: Mark global variables as static
To:     Mike Lothian <mike@fireburn.co.uk>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 12 May 2020 at 01:12, Mike Lothian <mike@fireburn.co.uk> wrote:
>
> Feel free to add my tested by
>
>
> On Mon, 11 May 2020 at 23:58, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> >
> > Mike Lothian reports that after commit
> >   964124a97b97 ("efi/x86: Remove extra headroom for setup block")
> > gcc 10.1.0 fails with
> >
> >   HOSTCC  arch/x86/boot/tools/build
> >   /usr/lib/gcc/x86_64-pc-linux-gnu/10.1.0/../../../../x86_64-pc-linux-gnu/bin/ld:
> >   error: linker defined: multiple definition of '_end'
> >   /usr/lib/gcc/x86_64-pc-linux-gnu/10.1.0/../../../../x86_64-pc-linux-gnu/bin/ld:
> >   /tmp/ccEkW0jM.o: previous definition here
> >   collect2: error: ld returned 1 exit status
> >   make[1]: *** [scripts/Makefile.host:103: arch/x86/boot/tools/build] Error 1
> >   make: *** [arch/x86/Makefile:303: bzImage] Error 2
> >
> > The issue is with the _end variable that was added, to hold the end of
> > the compressed kernel from zoffsets.h (ZO__end). The name clashes with
> > the linker-defined _end symbol that indicates the end of the build
> > program itself.
> >
> > Even when there is no compile-time error, this causes build to use
> > memory past the end of its .bss section.
> >
> > To solve this, mark _end as static, and for symmetry, mark the rest of
> > the variables that keep track of symbols from the compressed kernel as
> > static as well.
> >
> > Fixes: 964124a97b97 ("efi/x86: Remove extra headroom for setup block")
> > Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>

Thanks, I'll queue this as a fix.


> > ---
> >  arch/x86/boot/tools/build.c | 16 ++++++++--------
> >  1 file changed, 8 insertions(+), 8 deletions(-)
> >
> > diff --git a/arch/x86/boot/tools/build.c b/arch/x86/boot/tools/build.c
> > index 8f8c8e386cea..c8b8c1a8d1fc 100644
> > --- a/arch/x86/boot/tools/build.c
> > +++ b/arch/x86/boot/tools/build.c
> > @@ -59,14 +59,14 @@ u8 buf[SETUP_SECT_MAX*512];
> >  #define PECOFF_COMPAT_RESERVE 0x0
> >  #endif
> >
> > -unsigned long efi32_stub_entry;
> > -unsigned long efi64_stub_entry;
> > -unsigned long efi_pe_entry;
> > -unsigned long efi32_pe_entry;
> > -unsigned long kernel_info;
> > -unsigned long startup_64;
> > -unsigned long _ehead;
> > -unsigned long _end;
> > +static unsigned long efi32_stub_entry;
> > +static unsigned long efi64_stub_entry;
> > +static unsigned long efi_pe_entry;
> > +static unsigned long efi32_pe_entry;
> > +static unsigned long kernel_info;
> > +static unsigned long startup_64;
> > +static unsigned long _ehead;
> > +static unsigned long _end;
> >
> >  /*----------------------------------------------------------------------*/
> >
> > --
> > 2.26.2
> >
