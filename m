Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03BBB26D494
	for <lists+linux-efi@lfdr.de>; Thu, 17 Sep 2020 09:23:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726153AbgIQHXY (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 17 Sep 2020 03:23:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:33678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726191AbgIQHXX (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 17 Sep 2020 03:23:23 -0400
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 33510208DB
        for <linux-efi@vger.kernel.org>; Thu, 17 Sep 2020 07:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600327402;
        bh=m9pguxBA+2aUP10prJ3i52WIN52Fl4niKZCFGt8No6U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HvrC9QgF4nFdffX3tfXahMkjj5i7Ek2e0LLJrVPj87tjccHIlckPdVqTZ2bSrw+bh
         fA2hRqAN7AdlqUMG/zvBWnFQWRRtgDUuOljob5dorMgccLoq4hSIFej5w53x5RieLr
         DGMKSuPb2RHXu/a8+4a5/5iU+ngaRbc3fA5Leggg=
Received: by mail-oi1-f182.google.com with SMTP id v20so1395337oiv.3
        for <linux-efi@vger.kernel.org>; Thu, 17 Sep 2020 00:23:22 -0700 (PDT)
X-Gm-Message-State: AOAM532k9HRjREPj1udLF5SnC1LyzUaZ1JsxMceFs2oNJr6aGZ1P+Xju
        8BXJqYgNAOwZskWvSolRu703ucujYlt4XM0hYLg=
X-Google-Smtp-Source: ABdhPJwclugqJ/5ZGNdyIULMOqcDdJyURzvnFCxhvUCSqpqSwmUAu7ktLCH4eIAHPH7nM/rF/KHRTHthqeAn0dIsb/Y=
X-Received: by 2002:a05:6808:8e5:: with SMTP id d5mr5530316oic.33.1600327401544;
 Thu, 17 Sep 2020 00:23:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200914213535.933454-1-nivedita@alum.mit.edu>
 <20200914213535.933454-2-nivedita@alum.mit.edu> <CAMj1kXHy4d6zEJhJtdkHyYx-jnhJJzJ4Xi+qyawhjg6hXhAQgw@mail.gmail.com>
 <CAO18KQi9icju0YJ-dGe70NC8oFN0GL0hM1_fn8xE9dEkcrU_8A@mail.gmail.com>
 <20200916174550.GA1281480@rani.riverdale.lan> <CAO18KQgrAGCy3E5k2W52GhNY7VF5HNjc=i0Gw4nW4VnMCvCUtQ@mail.gmail.com>
In-Reply-To: <CAO18KQgrAGCy3E5k2W52GhNY7VF5HNjc=i0Gw4nW4VnMCvCUtQ@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 17 Sep 2020 10:23:10 +0300
X-Gmail-Original-Message-ID: <CAMj1kXH5dERqWsjFR9OGqUxf1UPk00iecmwPLyEiRSAJ_TAdzQ@mail.gmail.com>
Message-ID: <CAMj1kXH5dERqWsjFR9OGqUxf1UPk00iecmwPLyEiRSAJ_TAdzQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] efi/x86: Add a quirk to support command line
 arguments on Dell EFI firmware
To:     Jacobo Pantoja <jacobopantoja@gmail.com>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        "Limonciello, Mario" <Mario.Limonciello@dell.com>,
        Peter Jones <pjones@redhat.com>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 16 Sep 2020 at 23:51, Jacobo Pantoja <jacobopantoja@gmail.com> wrote:
>
> On Wed, 16 Sep 2020 at 19:45, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> >
> > On Wed, Sep 16, 2020 at 06:50:15PM +0200, Jacobo Pantoja wrote:
> > > Hi, I'd like to update my testing and share my thoughts.
> > >
> > > Regarding the patches:
> > > 1) The patches in email 1/2 (the functions "efi_warn", etc.) are not working
> > > properly. I got some suggestions for testing from Ard in a separate email.
> > >   3a. If, in this 2nd patch, I switch the "efi_warn_once" with an
> > > "efi_printk", the
> > >   messages appear.
> > >   1a. I've set CONFIG_CONSOLE_LOGLEVEL_DEFAULT=5, same result
> > >   2a. I've switched from "efi_warn_once" to "efi_warn", same result.
> >
> > I had tested on QEMU, and the messages appear there. Not sure what might
> > cause efi_warn to not work if efi_printk is working.
>
> I was changing the wrong "config", so LOGLEVEL was really 4. Now, being set
> as 5, everything appears as expected (after almost 2 hours recompiling, lucky
> ThreadRipper owners).
> Sorry for the noise
>
> >
> > > 2) Even if they would be working, since it is not logged anywhere, I
> > > don't really
> > > think these messages make sense. Idk if these can be made available to dmesg.
> >
> > They're useful mostly in the case the boot hangs in the EFI stub. If the
> > boot works, they will generally disappear very quickly, making them
> > difficult to notice/read.
> >
> > > 3) The function "efi_apply_loadoptions_quirk" is called twice, it seems to me
> > > that calling it from the "file.c" is redundant, but probably I'm
> > > missing something.
> >
> > file.c reads the original UTF-16 command line. It's possible to refactor
> > the code so it doesn't have to quirk twice, but this was the smallest
> > change for now.
> >
>
> Understood, thanks for the explanation.
>
> > >
> > > Regarding the quirk itself, in my opinion we should wait for Mario's
> > > news, since,
> > > again in my opinion, this is something that should be fixed in the
> > > firmware itself.
> > > Being Dell a serious company, I think it is feasible that, at least
> > > for their enterprise
> > > products, they might fix it.
> > >
> > > On Tue, 15 Sep 2020 at 17:09, Ard Biesheuvel <ardb@kernel.org> wrote:
> > > >
> > > > On Tue, 15 Sep 2020 at 00:35, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> > > > >
> > > > > At least some versions of Dell EFI firmware pass the entire
> > > > > EFI_LOAD_OPTION descriptor, rather than just the OptionalData part, to
> > > > > the loaded image. This was verified with firmware revision 2.15.0 on a
> > > > > Dell Precision T3620 by Jacobo Pontaja.
> > >
> > > Please be so kind to correct my name, if it's being included in the commit msg.
> >
> > Oops, sorry about that. Ard, can you fix that up?
> Thanks

Done
