Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4CAE23BA83
	for <lists+linux-efi@lfdr.de>; Tue,  4 Aug 2020 14:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726356AbgHDMlP (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 4 Aug 2020 08:41:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:56958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725864AbgHDMlL (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 4 Aug 2020 08:41:11 -0400
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C98622BED
        for <linux-efi@vger.kernel.org>; Tue,  4 Aug 2020 12:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596544870;
        bh=QU2pSvaZV1KtMwZYMcedjy8l3khzEPaqkhJCfCrFtK4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FSLS02wmdSuZbHg+F9B/P3fC/UcdBIWETnQaPVZ2O7EqKZmqvIQN1Z+d6002/oNm/
         8o8Izr9pbaq7zN1YaRHJ7YAjhxF3/7j9t50ZdTkrgCDler+bxpvTpL3YGSMmBCrsjb
         JuXEdV6x7P/ky2xtXCBKLsg4ARxThMRH4AYda3H8=
Received: by mail-oi1-f182.google.com with SMTP id o21so15457446oie.12
        for <linux-efi@vger.kernel.org>; Tue, 04 Aug 2020 05:41:10 -0700 (PDT)
X-Gm-Message-State: AOAM5319aJMYXz7CzOBAafxmct4g2rpPptffElF7JIjfV6uI10xIZE5E
        mY44iSPerJpJrucomcVw/KTTdIBWunS5RgrDIJo=
X-Google-Smtp-Source: ABdhPJypAJbECXWBhTKw1HRiWTnJ6TEh661Ks0jXxYTTNBtRAxvXUpBFuVQ7Jb43aTWKTb/TSFL2d9/q/qH2UFTAC0Q=
X-Received: by 2002:aca:afd0:: with SMTP id y199mr3015769oie.47.1596544869896;
 Tue, 04 Aug 2020 05:41:09 -0700 (PDT)
MIME-Version: 1.0
References: <202008020649.TJ8Zu7ei%lkp@intel.com> <CAAeHK+zbBF0YVveGNZo0bJ8fWHVZRcrr6n90eYLDCov2vcfZyg@mail.gmail.com>
 <20200803180358.GA1299225@rani.riverdale.lan> <CAAeHK+wobK72fWK=v7JosQL3UEe2HG4n2wwVpf1PN30Xkra6rA@mail.gmail.com>
In-Reply-To: <CAAeHK+wobK72fWK=v7JosQL3UEe2HG4n2wwVpf1PN30Xkra6rA@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 4 Aug 2020 14:40:57 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEp0pc8UN-BnJPT36KAKNLOL1EUBHgLABJwF2qwLrz6KA@mail.gmail.com>
Message-ID: <CAMj1kXEp0pc8UN-BnJPT36KAKNLOL1EUBHgLABJwF2qwLrz6KA@mail.gmail.com>
Subject: Re: [hnaz-linux-mm:master 168/421] init/main.c:1012: undefined
 reference to `efi_enter_virtual_mode'
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        linux-efi <linux-efi@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        kbuild-all@lists.01.org, Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 4 Aug 2020 at 14:27, Andrey Konovalov <andreyknvl@google.com> wrote:
>
> On Mon, Aug 3, 2020 at 8:04 PM Arvind Sankar <nivedita@alum.mit.edu> wrote:
> >
> > On Mon, Aug 03, 2020 at 05:37:32PM +0200, Andrey Konovalov wrote:
> > > On Sun, Aug 2, 2020 at 12:25 AM kernel test robot <lkp@intel.com> wrote:
> > > >
> > > > tree:   https://github.com/hnaz/linux-mm master
> > > > head:   2932a9e66c580f3c8d95ec27716d437198fb4c94
> > > > commit: 7c0265f304de3c3acd02d0015b56a076357bcce3 [168/421] kasan, arm64: don't instrument functions that enable kasan
> > > > config: x86_64-randconfig-r036-20200802 (attached as .config)
> > > > compiler: gcc-9 (Debian 9.3.0-14) 9.3.0
> > > > reproduce (this is a W=1 build):
> > > >         git checkout 7c0265f304de3c3acd02d0015b56a076357bcce3
> > > >         # save the attached .config to linux build tree
> > > >         make W=1 ARCH=x86_64
> > > >
> > > > If you fix the issue, kindly add following tag as appropriate
> > > > Reported-by: kernel test robot <lkp@intel.com>
> > > >
> > > > All errors (new ones prefixed by >>):
> > > >
> > > >    ld: init/main.o: in function `start_kernel':
> > > > >> init/main.c:1012: undefined reference to `efi_enter_virtual_mode'
> > >
> > > Hm, I can reproduce the issue, but I don't understand why it happens.
> > >
> > > +EFI and KASAN people, maybe someone has an idea.
> > >
> > > This is the guilty patch:
> > >
> > > https://github.com/hnaz/linux-mm/commit/7c0265f304de3c3acd02d0015b56a076357bcce3
> > >
> > > The issue is only with efi_enter_virtual_mode() AFAIU, not with any of
> > > the other functions.
> > >
> > > Thanks!
> > >
> >
> > After adding __no_sanitize_address, gcc doesn't inline efi_enabled() on
> > a KASAN build, even when CONFIG_EFI is disabled, and the function is
> > just
> >         return false;
> > and so it isn't optimizing out the call to efi_enter_virtual_mode().
> >
> > Making efi_enabled() __always_inline fixes this, but not sure if that is
> > the correct fix?
>
> Ah, makes sense.
>
> We could also do #if defined(CONFIG_X86) && defined(CONFIG_EFI) in
> start_kernel().
>
> Or provide an empty efi_enter_virtual_mode() implementation when
> CONFIG_EFI isn't enabled.
>
> Ard, WDYT?
>

The latter seems more appropriate (as a static inline in efi.h), since
we could then remove the ifdef altogether afaict.
