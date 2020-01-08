Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E4EA134618
	for <lists+linux-efi@lfdr.de>; Wed,  8 Jan 2020 16:25:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727629AbgAHPZ2 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 8 Jan 2020 10:25:28 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54947 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726556AbgAHPZ2 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 8 Jan 2020 10:25:28 -0500
Received: by mail-wm1-f66.google.com with SMTP id b19so2908445wmj.4
        for <linux-efi@vger.kernel.org>; Wed, 08 Jan 2020 07:25:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pU8spTHGsctUegdQeH7kAigQTMGwmurFZUhPuvvC4rc=;
        b=Yce8G1LbMz0h9SZNHGXpmkobD5golENnhTJgg6LshdFcU2yieYwJRljRwvBSeh+jD5
         Sc+WspbDaKMCZap4DgFpVvABvySTpVDg1eTcRcwDmEOz+BWPywQn3s9BoDCQxCQOsPGg
         4SiHCrOzQ45esWkGUC9Oqfhxn9iRywzQIDm0wizsVboUki8uwVjRA1X+F2tQV6ePnAZn
         Nm/r5aLiSF9vzY+oyCK0RGi1N8YQFrA+ZnZzjCfU5teSULoYryFxLmf7VZ2iSnZeftbK
         DOiShUNshdtgyDBXD9KYsDOFd4XCYJGneYCgIoPW1o9C7sznNnRHh23zjnx3RZoUvNFK
         AVNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pU8spTHGsctUegdQeH7kAigQTMGwmurFZUhPuvvC4rc=;
        b=tyQ9l1Q4zZCyhnhHarcSkq5kRbfMmbYt/2wbzz0O0METsLA/1wy4fyTqx8MC2ajjvg
         NQXX/zM2fr880gO+6zCIwWPCherB9KLD+44Fx6iRE5g6W5m9hOhNIL074FJ6jzYPAX7d
         q49ZeAazYgmeNSNFjjscdHA6HBYzYPtLIz0c54d1IajKb9irz+GtYbytxwZTJUtkcPln
         xq6tknASGtw0NwVoO7u8i0Va5U3qhzYTAZArpcLQk/l5cpvkYGd0FLYTrpwQ34qFqfZR
         vBsVgCObDmM5hWXQCq9dS+wjrww37fadIQGlgIWRLtbBX1SpBxRChGGL+DrJJ3Fv1XX6
         fVOw==
X-Gm-Message-State: APjAAAVraUYx8a6TMihAQZJ/rxrqTQKbEL9AyaJ23sh90iN68BCDsOCE
        wPeE+yn/nyXJqiQz5DtnUVEh+Jx23amRmHwOJoumEgTfC7U=
X-Google-Smtp-Source: APXvYqylMIo07ZmXn2ByJkYzxf//RmVu/g/KFojQXkFczaJ+fbCWki4iPRojSKZz3GQTcSSIoCzjvDfO4eSSIeKDFRc=
X-Received: by 2002:a1c:7205:: with SMTP id n5mr4697963wmc.9.1578497126614;
 Wed, 08 Jan 2020 07:25:26 -0800 (PST)
MIME-Version: 1.0
References: <20200108074502.10960-1-ardb@kernel.org> <20200108074502.10960-2-ardb@kernel.org>
 <20200108152325.GA2499882@rani.riverdale.lan>
In-Reply-To: <20200108152325.GA2499882@rani.riverdale.lan>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Wed, 8 Jan 2020 16:25:15 +0100
Message-ID: <CAKv+Gu80MujqKcyxAu9M_dR90cbcHo2_UDrHjuCLO_B0Adm7YQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] efi/libstub/x86: use const attribute for efi_is_64bit()
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 8 Jan 2020 at 16:23, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> On Wed, Jan 08, 2020 at 08:45:01AM +0100, Ard Biesheuvel wrote:
> > Reshuffle the x86 stub code a bit so that we can tag the efi_is_64bit()
> > function with the 'const' attribute, which permits the compiler to
> > optimize away any redundant calls. Since we have two different entry
> > points for 32 and 64 bit firmware in the startup code, this also
> > simplifies the C code since we'll enter it with the efi_is64 variable
> > already set.
> >
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
> >  arch/x86/boot/compressed/eboot.c   | 14 ++++++--------
> >  arch/x86/boot/compressed/head_64.S |  7 +++----
> >  arch/x86/include/asm/efi.h         |  2 +-
> >  3 files changed, 10 insertions(+), 13 deletions(-)
> >
> > diff --git a/arch/x86/boot/compressed/eboot.c b/arch/x86/boot/compressed/eboot.c
> > index 4afd29eb5b34..ab3a40283db7 100644
> > --- a/arch/x86/boot/compressed/eboot.c
> > +++ b/arch/x86/boot/compressed/eboot.c
> > @@ -21,16 +21,18 @@
> >  #include "eboot.h"
> >
> >  static efi_system_table_t *sys_table;
> > -static bool efi_is64 = IS_ENABLED(CONFIG_X86_64);
> > +extern const bool efi_is64;
> >
>
> Didn't we need to declare this with hidden visibility? Or use the
> #pragma GCC visibility push(hidden)?

Yes. So this patch depends on
