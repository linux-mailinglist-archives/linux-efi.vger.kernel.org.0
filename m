Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09F3723BA9F
	for <lists+linux-efi@lfdr.de>; Tue,  4 Aug 2020 14:45:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbgHDMpb (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 4 Aug 2020 08:45:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727982AbgHDMor (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 4 Aug 2020 08:44:47 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87A3EC06174A
        for <linux-efi@vger.kernel.org>; Tue,  4 Aug 2020 05:44:46 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id r11so12221395pfl.11
        for <linux-efi@vger.kernel.org>; Tue, 04 Aug 2020 05:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ryvLjVG1MrLc1WL5a6i4V+mIwati9JdZFbrWPVnD1eA=;
        b=hN+ZgtJj6srfcrMTwrTTNDNvecM0QKaNfxXUGaQinHyJ/p1HA0Vi49iumQ6MOKffgo
         mQGnl8ezc2TzTY3UVLvA84T5LgQXtB2U3CrHD4r2qSoegVdSTl8hsiww2Fq8h5/26jaT
         xIMQWyQpyD/ETLg4WMxdyDodK3jSY1djOBITkn2+cFKZOROgQOc5gq3isai/TakLiHCq
         Di7Fu1+7l+7ZV4G5ucWCDH8ANQHDG+fcVZRdinw7HbHLYww9SZvrwZ45BEsOADkNsRv0
         VWrV3t8Q0w71INGlbQOi7bTXJl47XcOQutk/bzOC8vF7nLAzypTDun+kaT7Md9/HTKQd
         EGdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ryvLjVG1MrLc1WL5a6i4V+mIwati9JdZFbrWPVnD1eA=;
        b=U4k5kPlgllB0/VNque1rcOFEsrNrBRHIqAYBKixPOM6+dsHhhpozYjOAQ2z5+s9IrJ
         vnibS/W89kzM+bKj/YGH3nlnXnyKVG66eW4Qfyb5rXNEecIixsnnQZsEoIZ0cptELijp
         nqmHTJZDj2i8Um5CCi2z32TkZ9HyvU6x+sEte9TqbjIh/HI/ASozi9sXwt0gS6+s5GGF
         FlxVcxJc6odorqiUPbR/v/0k9wA8vmw+QqnBrqaYvf2mGfpLbtzDkqyL36C1fSbFBjEl
         JOd7QA0zbGCl9Cy/aPiNcxDFG2AsnsGLybaZpkASsiMp4Tyt8Owt+5jRKtk79VGuzi/L
         FPeQ==
X-Gm-Message-State: AOAM530WI7MFn9OS0eM0JBkeiqMGpDtmyeoMY3Urdc70WN+LN85pH0s7
        lR+W8lewGABYvs8Z9EF7HF8J0aVM9buLuifbmhPDrw==
X-Google-Smtp-Source: ABdhPJz92vXv2YZ8xAVjfvEvO1wlLqHYZ/iFLwwh+P/7VeDOiUsQ0ZpfvH51U83oCk3zQ9RZx6opluDS0JZtta7naw8=
X-Received: by 2002:a62:a101:: with SMTP id b1mr845628pff.306.1596545085771;
 Tue, 04 Aug 2020 05:44:45 -0700 (PDT)
MIME-Version: 1.0
References: <202008020649.TJ8Zu7ei%lkp@intel.com> <CAAeHK+zbBF0YVveGNZo0bJ8fWHVZRcrr6n90eYLDCov2vcfZyg@mail.gmail.com>
 <20200803180358.GA1299225@rani.riverdale.lan> <CAAeHK+wobK72fWK=v7JosQL3UEe2HG4n2wwVpf1PN30Xkra6rA@mail.gmail.com>
 <CAMj1kXEp0pc8UN-BnJPT36KAKNLOL1EUBHgLABJwF2qwLrz6KA@mail.gmail.com>
In-Reply-To: <CAMj1kXEp0pc8UN-BnJPT36KAKNLOL1EUBHgLABJwF2qwLrz6KA@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Tue, 4 Aug 2020 14:44:34 +0200
Message-ID: <CAAeHK+z5jv58tXC6JuNseFOYoNq6y1Q6SZArjB_jbrQ_peBhzA@mail.gmail.com>
Subject: Re: [hnaz-linux-mm:master 168/421] init/main.c:1012: undefined
 reference to `efi_enter_virtual_mode'
To:     Ard Biesheuvel <ardb@kernel.org>
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

On Tue, Aug 4, 2020 at 2:41 PM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Tue, 4 Aug 2020 at 14:27, Andrey Konovalov <andreyknvl@google.com> wrote:
> >
> > On Mon, Aug 3, 2020 at 8:04 PM Arvind Sankar <nivedita@alum.mit.edu> wrote:
> > >
> > > On Mon, Aug 03, 2020 at 05:37:32PM +0200, Andrey Konovalov wrote:
> > > > On Sun, Aug 2, 2020 at 12:25 AM kernel test robot <lkp@intel.com> wrote:
> > > > >
> > > > > tree:   https://github.com/hnaz/linux-mm master
> > > > > head:   2932a9e66c580f3c8d95ec27716d437198fb4c94
> > > > > commit: 7c0265f304de3c3acd02d0015b56a076357bcce3 [168/421] kasan, arm64: don't instrument functions that enable kasan
> > > > > config: x86_64-randconfig-r036-20200802 (attached as .config)
> > > > > compiler: gcc-9 (Debian 9.3.0-14) 9.3.0
> > > > > reproduce (this is a W=1 build):
> > > > >         git checkout 7c0265f304de3c3acd02d0015b56a076357bcce3
> > > > >         # save the attached .config to linux build tree
> > > > >         make W=1 ARCH=x86_64
> > > > >
> > > > > If you fix the issue, kindly add following tag as appropriate
> > > > > Reported-by: kernel test robot <lkp@intel.com>
> > > > >
> > > > > All errors (new ones prefixed by >>):
> > > > >
> > > > >    ld: init/main.o: in function `start_kernel':
> > > > > >> init/main.c:1012: undefined reference to `efi_enter_virtual_mode'
> > > >
> > > > Hm, I can reproduce the issue, but I don't understand why it happens.
> > > >
> > > > +EFI and KASAN people, maybe someone has an idea.
> > > >
> > > > This is the guilty patch:
> > > >
> > > > https://github.com/hnaz/linux-mm/commit/7c0265f304de3c3acd02d0015b56a076357bcce3
> > > >
> > > > The issue is only with efi_enter_virtual_mode() AFAIU, not with any of
> > > > the other functions.
> > > >
> > > > Thanks!
> > > >
> > >
> > > After adding __no_sanitize_address, gcc doesn't inline efi_enabled() on
> > > a KASAN build, even when CONFIG_EFI is disabled, and the function is
> > > just
> > >         return false;
> > > and so it isn't optimizing out the call to efi_enter_virtual_mode().
> > >
> > > Making efi_enabled() __always_inline fixes this, but not sure if that is
> > > the correct fix?
> >
> > Ah, makes sense.
> >
> > We could also do #if defined(CONFIG_X86) && defined(CONFIG_EFI) in
> > start_kernel().
> >
> > Or provide an empty efi_enter_virtual_mode() implementation when
> > CONFIG_EFI isn't enabled.
> >
> > Ard, WDYT?
> >
>
> The latter seems more appropriate (as a static inline in efi.h), since

Sent out a v2 of my patchset with this exact fix included at the same
time I received this response :)

> we could then remove the ifdef altogether afaict.

I didn't do this part. I guess this can be done as a separate patch,
and will probably require some more testing.
