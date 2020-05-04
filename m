Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AAED1C3CB2
	for <lists+linux-efi@lfdr.de>; Mon,  4 May 2020 16:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728486AbgEDOQL (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 4 May 2020 10:16:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:59840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728446AbgEDOQL (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 4 May 2020 10:16:11 -0400
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A2A252075A
        for <linux-efi@vger.kernel.org>; Mon,  4 May 2020 14:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588601770;
        bh=fsfmudmiNtCjytG3/nGr8xrfGt+8eMrBD/c3Iwuaspc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=sTxhBYK/Aw4WwTpsCHxmNaxCmPP93P6tXwN2czX8e1/mNCAKZCasohrm4kwIPayOP
         xgjGZ3uDAtV40YSo/Q9zQZNSS1VKM6wN9p43PpA0upWyP5ea+2JabxABmt3FITURT3
         xTqE6hMVxou9m6qRNgH6ztvApDPCxNYT2ZFeh1oo=
Received: by mail-io1-f48.google.com with SMTP id u11so12459767iow.4
        for <linux-efi@vger.kernel.org>; Mon, 04 May 2020 07:16:10 -0700 (PDT)
X-Gm-Message-State: AGi0PubaQSAVaVndg5CgtphwxunE4oSPludsJZveXLaV/Fv9I8RdsLHb
        wNoMaQIJaY4lJ2anWzboaf+up6mSBLr3BxD2b+E=
X-Google-Smtp-Source: APiQypKzjlEmaCV9JXmzzG7BVEvAxtGJHCXsrhWW2drkfy7tbaZn4VdTGpKzHVWSXLC86gJ4BoTaksDDSRcnQGAoqyA=
X-Received: by 2002:a5d:9b8a:: with SMTP id r10mr15659806iom.171.1588601770010;
 Mon, 04 May 2020 07:16:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200503154507.82880-1-ardb@kernel.org> <20200504003852.1096018-1-nivedita@alum.mit.edu>
 <20200504003852.1096018-2-nivedita@alum.mit.edu> <CAMj1kXHqt2h+6EUoQ4qquX5zUJDKpg5MhXaGQcdVguNcOHrZ+A@mail.gmail.com>
 <20200504140234.GA2943621@rani.riverdale.lan>
In-Reply-To: <20200504140234.GA2943621@rani.riverdale.lan>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 4 May 2020 16:15:59 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEjvRkcZ7_J9zVbqFoZsRfbDA8c_xyHRM+je2njHeDEMQ@mail.gmail.com>
Message-ID: <CAMj1kXEjvRkcZ7_J9zVbqFoZsRfbDA8c_xyHRM+je2njHeDEMQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] efi/libstub: Fix mixed mode boot issue after macro refactor
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, 4 May 2020 at 16:02, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> On Mon, May 04, 2020 at 10:05:23AM +0200, Ard Biesheuvel wrote:
> > On Mon, 4 May 2020 at 02:38, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> > >
> > > Commit
> > >   22090f84bc3f ("efi/libstub: unify EFI call wrappers for non-x86")
> > >
> > > refactored the macros that are used to provide wrappers for mixed-mode
> > > calls on x86, allowing us to boot a 64-bit kernel on 32-bit firmware.
> > >
> > > Unfortunately, this broke mixed mode boot due to the fact that
> > > efi_is_native() is not a macro on x86.
> > >
> > > Fix this by conditioning the generic macro definitions on
> > > CONFIG_EFI_MIXED, and removing the wrapper definitions on x86 if
> > > CONFIG_EFI_MIXED is not enabled.
> > >
> > > Reported-by: Guenter Roeck <linux@roeck-us.net>
> > > Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> >
> > Thanks Arvind.
> >
> > Currently, CONFIG_EFI_MIXED is never referenced outside of arch/x86,
> > and I prefer to keep it that way.
>
> All these macros go together though -- they should either all be defined
> or none, so it makes sense to put them under a single #if.

True.

> If you think
> it's possible that a future architecture might need the wrappers but not
> be mixed, we could maybe add an ARCH_NEEDS_EFISTUB_WRAPPERS?
>

Well, remember that x86 used wrappers for native invocations only two
releases ago, but that was mainly because of the SysV vs MS ABI issue,
so the issue could emerge again, but it is unlikely.

> >
> > Also, I fail to see where the definition of efi_is_native() comes from
> > after applying this patch.
>
> The generic definition is in the same place -- I just moved it to the
> top as it's a predicate rather than a wrapper, and kept all the actual
> wrappers together.
>

Ah yes, I see it now.


> > > diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
> > > index 874233cf8820..37ca286a40c6 100644
> > > --- a/drivers/firmware/efi/libstub/efistub.h
> > > +++ b/drivers/firmware/efi/libstub/efistub.h
> > > @@ -33,20 +33,14 @@ extern bool efi_novamap;
> > >
> > >  extern const efi_system_table_t *efi_system_table;
> > >
> > > -#ifndef efi_bs_call
> > > +#ifndef CONFIG_EFI_MIXED
> > > +
> > > +#define efi_is_native()                (true)
> > >  #define efi_bs_call(func, ...) efi_system_table->boottime->func(__VA_ARGS__)
> > > -#endif
> > > -#ifndef efi_rt_call
> > >  #define efi_rt_call(func, ...) efi_system_table->runtime->func(__VA_ARGS__)
> > > -#endif
> > > -#ifndef efi_is_native
> > > -#define efi_is_native()                (true)
> > > -#endif
> > > -#ifndef efi_table_attr
> > >  #define efi_table_attr(inst, attr)     (inst->attr)
> > > -#endif
> > > -#ifndef efi_call_proto
> > >  #define efi_call_proto(inst, func, ...) inst->func(inst, ##__VA_ARGS__)
> > > +
> > >  #endif
> > >
> > >  #define efi_info(msg)          do {                    \
> > > --
> > > 2.26.2
> > >
