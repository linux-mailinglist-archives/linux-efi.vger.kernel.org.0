Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2AF623BA4D
	for <lists+linux-efi@lfdr.de>; Tue,  4 Aug 2020 14:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726070AbgHDM1j (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 4 Aug 2020 08:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726056AbgHDM1i (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 4 Aug 2020 08:27:38 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC648C06179F
        for <linux-efi@vger.kernel.org>; Tue,  4 Aug 2020 05:27:37 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id 74so11827845pfx.13
        for <linux-efi@vger.kernel.org>; Tue, 04 Aug 2020 05:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BSEtcZMeEfd836sEUlnMwgLoZphV8omnRj5UAHtlG3M=;
        b=NcQ2Qf6i6p0NsVefmKlSDeQGR0LxrvqW/MhO+giMOwwmpXOiESMnpG/4G/LNzKITX5
         IdO44RhspOLAdVbDji/3twZBufSBi07TadDGckBsTb/YAoBJOAf0OHzsGOfa/LudQ4p8
         tjEeTgYs4QcQ1kcPlUK7JUIszd50AorZexxq52+rFQA2yzQ1cHfe+iHgMCYqIMcAt486
         ltUwGI90BEnzsgcPfQwnYimgQstHjeLm7M6s+OnjlXzmjutcNL7cP1F5WT/2JtMIbftv
         4yDoPO9uAVmVZ5+5bPswV6uhqICoBODDlh2/KgNDs8qNGCPNtz5XtJ2MDQepmk+uuMr9
         CV9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BSEtcZMeEfd836sEUlnMwgLoZphV8omnRj5UAHtlG3M=;
        b=j5fFglzS+a1sPmUzhGL5siPkeQMX3Iv7r/4WOrR3mRN0Y356RIFXi6Jf8AU73kHw06
         6oRzRKG95gOIiTA57TecLkdpdVWqXIjkk9OYN6w64VTNW7YYDIR76HdUGzCwD6JfneTR
         M4q7GwbxBGKwRk6WXh4ds1oQkfPZdt+b8tYYEkr+euUv64OwZySJv1IDT0nAy8MROI/V
         A9Bo++NN+Kz7tGn9Xjftef39F399sq1WrVYHOMIx0eprTaG53/lhpV1giRnglqrTFmUN
         RWIu5myeRH45Aui52TZ+3/W4MaF2wbVBBxu6BAGTFpY9Lc9vXuNn2ayCaz9eK8MIpLwa
         zkEA==
X-Gm-Message-State: AOAM530NwhTbM8hQfigTzJqxCj8chAUp5xENidWbnNQTWdZ4yz7jWcpQ
        ++6r9IaZPUm5YBbj9ZcNjad88azdBpIWSlSKzuzW1A==
X-Google-Smtp-Source: ABdhPJyXgZYHbw7Ug34k6Xe4thc7d74c1Y2g/5Ry8C4VwXrnQ70vm/WuZoCvs3qVyJ7svWsaAL7mIri32LVnz90BFrE=
X-Received: by 2002:aa7:97a3:: with SMTP id d3mr20240734pfq.178.1596544057176;
 Tue, 04 Aug 2020 05:27:37 -0700 (PDT)
MIME-Version: 1.0
References: <202008020649.TJ8Zu7ei%lkp@intel.com> <CAAeHK+zbBF0YVveGNZo0bJ8fWHVZRcrr6n90eYLDCov2vcfZyg@mail.gmail.com>
 <20200803180358.GA1299225@rani.riverdale.lan>
In-Reply-To: <20200803180358.GA1299225@rani.riverdale.lan>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Tue, 4 Aug 2020 14:27:26 +0200
Message-ID: <CAAeHK+wobK72fWK=v7JosQL3UEe2HG4n2wwVpf1PN30Xkra6rA@mail.gmail.com>
Subject: Re: [hnaz-linux-mm:master 168/421] init/main.c:1012: undefined
 reference to `efi_enter_virtual_mode'
To:     Arvind Sankar <nivedita@alum.mit.edu>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>,
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

On Mon, Aug 3, 2020 at 8:04 PM Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> On Mon, Aug 03, 2020 at 05:37:32PM +0200, Andrey Konovalov wrote:
> > On Sun, Aug 2, 2020 at 12:25 AM kernel test robot <lkp@intel.com> wrote:
> > >
> > > tree:   https://github.com/hnaz/linux-mm master
> > > head:   2932a9e66c580f3c8d95ec27716d437198fb4c94
> > > commit: 7c0265f304de3c3acd02d0015b56a076357bcce3 [168/421] kasan, arm64: don't instrument functions that enable kasan
> > > config: x86_64-randconfig-r036-20200802 (attached as .config)
> > > compiler: gcc-9 (Debian 9.3.0-14) 9.3.0
> > > reproduce (this is a W=1 build):
> > >         git checkout 7c0265f304de3c3acd02d0015b56a076357bcce3
> > >         # save the attached .config to linux build tree
> > >         make W=1 ARCH=x86_64
> > >
> > > If you fix the issue, kindly add following tag as appropriate
> > > Reported-by: kernel test robot <lkp@intel.com>
> > >
> > > All errors (new ones prefixed by >>):
> > >
> > >    ld: init/main.o: in function `start_kernel':
> > > >> init/main.c:1012: undefined reference to `efi_enter_virtual_mode'
> >
> > Hm, I can reproduce the issue, but I don't understand why it happens.
> >
> > +EFI and KASAN people, maybe someone has an idea.
> >
> > This is the guilty patch:
> >
> > https://github.com/hnaz/linux-mm/commit/7c0265f304de3c3acd02d0015b56a076357bcce3
> >
> > The issue is only with efi_enter_virtual_mode() AFAIU, not with any of
> > the other functions.
> >
> > Thanks!
> >
>
> After adding __no_sanitize_address, gcc doesn't inline efi_enabled() on
> a KASAN build, even when CONFIG_EFI is disabled, and the function is
> just
>         return false;
> and so it isn't optimizing out the call to efi_enter_virtual_mode().
>
> Making efi_enabled() __always_inline fixes this, but not sure if that is
> the correct fix?

Ah, makes sense.

We could also do #if defined(CONFIG_X86) && defined(CONFIG_EFI) in
start_kernel().

Or provide an empty efi_enter_virtual_mode() implementation when
CONFIG_EFI isn't enabled.

Ard, WDYT?

Thanks!
