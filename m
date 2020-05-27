Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 165D81E4D5E
	for <lists+linux-efi@lfdr.de>; Wed, 27 May 2020 20:48:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728043AbgE0Ssv (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 27 May 2020 14:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbgE0Srg (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 27 May 2020 14:47:36 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DF79C08C5C3;
        Wed, 27 May 2020 11:29:13 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id h10so27159609iob.10;
        Wed, 27 May 2020 11:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FW8Q9Rorz9pPYc/xr3AkQmCBY01IskGBSmgwhtvJ9ZU=;
        b=sZtyFQORrPLQ4OmmN95ukhbr9eaO4A0bRAoSlF5lwld76UrlDxnqypcamYyZpQ0AKV
         zLq/+vZ7EKnSzTICk4F5MqdhPiIliA6GZHvGRUyHrAdiE4Y9Bl1oMG6fzDbyDcjb+2Ng
         TPq4XyNGzDlZV03yi9zrIlFCURC3zvRe0M36EhkoPKGiMxmfrWuYVz9zCniCv/epCuLw
         3WMd2NUY/g7cAvZtI+Kkuu5LLfQ5GLAcw9keDaFUOGQlgbYRgEp5woAZvDmgna+TyQHX
         sEmUL/oBKUXwoxEBd0udHuvYcwFHsiDwJ85qcIqhsXrUap6I7Jhi+/kOV6fcFRHvrylS
         iz5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FW8Q9Rorz9pPYc/xr3AkQmCBY01IskGBSmgwhtvJ9ZU=;
        b=nQ5wCdAK6vlvjz9P0gHrFWqyYFAOsmz6oZDjU6Rv64iFAlMINxi2sFPQHBt92Dl1pa
         4Kko3axL1GHpo7nkQb0j91D/5HbZP860xcR06ZbqYBeZIs9xKmqdiDMeufaJSRVhxKMi
         NSvmmhogP6wnuptL/apuGfFSLEJvJX/PKEg1ZuhDy8CT+JHFGJ+6GPpfkTBdA+0cO/24
         PhXNugVYhW0qCwNIO7GFAZub8ezWpbWs0L32GoV31hF2brfJJAQBdLIDM/daCPdISRx7
         W4iPoYEV1cjKgx5rKe42e9uotmx6I/5SK3DnZQub0gPmZSb6BjLI7ZC304s/FgKbBID7
         op2Q==
X-Gm-Message-State: AOAM532Jb/Vnh/qzXOUqJNJlXtHZaKkXnjkSqH7J1O/V8NQuufSLs6Uz
        8RvOhfQIPnV3AA6QpdP2TZkcEhBU8e+fw/7Idw==
X-Google-Smtp-Source: ABdhPJwMhonBm2LfUtNamMbLFx30kjbOuifum2IycgYlpJGgwHftdyG08kcAUDL/v2FAUAHwx2hTCUduOaeaf68PHwY=
X-Received: by 2002:a5d:9758:: with SMTP id c24mr21786555ioo.144.1590604152179;
 Wed, 27 May 2020 11:29:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200523120021.34996-1-ardb@kernel.org> <20200523120021.34996-3-ardb@kernel.org>
 <20200527143650.GA3103408@rani.riverdale.lan>
In-Reply-To: <20200527143650.GA3103408@rani.riverdale.lan>
From:   Brian Gerst <brgerst@gmail.com>
Date:   Wed, 27 May 2020 14:29:01 -0400
Message-ID: <CAMzpN2ikgiXdaJ8t2ivB90JhOQsa=ziV738wVsXo3JU4HjAbOw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] x86/boot/compressed: force hidden visibility for
 all symbol references
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, May 27, 2020 at 2:08 PM Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> On Sat, May 23, 2020 at 02:00:20PM +0200, Ard Biesheuvel wrote:
> > Eliminate all GOT entries in the decompressor binary, by forcing hidden
> > visibility for all symbol references, which informs the compiler that
> > such references will be resolved at link time without the need for
> > allocating GOT entries.
> >
> > To ensure that no GOT entries will creep back in, add an assertion to
> > the decompressor linker script that will fire if the .got section has
> > a non-zero size.
> >
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
> >  arch/x86/boot/compressed/Makefile      |  1 +
> >  arch/x86/boot/compressed/hidden.h      | 19 +++++++++++++++++++
> >  arch/x86/boot/compressed/vmlinux.lds.S |  1 +
> >  3 files changed, 21 insertions(+)
> >
> > diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
> > index 5f7c262bcc99..aa9ed814e5fa 100644
> > --- a/arch/x86/boot/compressed/Makefile
> > +++ b/arch/x86/boot/compressed/Makefile
> > @@ -40,6 +40,7 @@ KBUILD_CFLAGS += $(call cc-disable-warning, gnu)
> >  KBUILD_CFLAGS += -Wno-pointer-sign
> >  KBUILD_CFLAGS += $(call cc-option,-fmacro-prefix-map=$(srctree)/=)
> >  KBUILD_CFLAGS += -fno-asynchronous-unwind-tables
> > +KBUILD_CFLAGS += -include hidden.h
> >
>
> Ard, from the other thread [1] in case you missed it -- the plain
> hidden.h fails to build in-tree. We need something like
>         KBUILD_CFLAGS += -include $(srctree)/$(src)/hidden.h
> instead.
>
> [1] https://lore.kernel.org/lkml/20200526153104.GC2190602@rani.riverdale.lan/

How about using -fvisibility=hidden instead of including this header?

--
Brian Gerst
