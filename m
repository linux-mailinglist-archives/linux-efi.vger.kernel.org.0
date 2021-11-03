Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8C60443DB0
	for <lists+linux-efi@lfdr.de>; Wed,  3 Nov 2021 08:27:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232021AbhKCHa2 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 3 Nov 2021 03:30:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:58226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231994AbhKCHa2 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 3 Nov 2021 03:30:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 35EC6610FC;
        Wed,  3 Nov 2021 07:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635924472;
        bh=tnfQmWjEkbsU0hZniBI8oWHL/g4oQ2tadhyCRdPJjV8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=k3jNM0lEMdVZSVPx56BWxJrjphMABqdOYJF32LU6Yr6VbB+K4oO7BXPC5NGwAQLYD
         UXjHQBehwzJoExfv8BQ6YxxHYIyo2EJrwE3vmjfO9Xu1mCwW45bnS+gv3Ldx/liXVL
         zbUOVRuuUM1CKD8spO0CIDjfqpHJ3ljMiobfWzYZU7vcXfqkCbzkfeA9NkOr4qn9Md
         de2+vfT7R2Jpbf81jkW47VZQg281C6IKBMuoe3RUBbmfXWMIXIqIkhwnEC63pPE9mt
         nV/haVQhzu/pNYc2N0sy/4qWiWq7X0U/U0ozmYBcxlbfgOcvpFiQ9EHqisVTNTB+9Z
         7JcyNmQW58EFw==
Received: by mail-ot1-f48.google.com with SMTP id v2-20020a05683018c200b0054e3acddd91so2338937ote.8;
        Wed, 03 Nov 2021 00:27:52 -0700 (PDT)
X-Gm-Message-State: AOAM533xLOvoM5GEw5SP9pv7dgRRc9haI55z/dT/T8XgPspeCs1e1yuQ
        wHLiXFJQ/hQREQec+14yZAKNqxYap0OQo7EJZRU=
X-Google-Smtp-Source: ABdhPJz9s3ZtP373jajtXnetWVkbVsJq0tRLqIBJq6lJnfOfAoiEZQ0g78lwnEET+Wxq/ahoK5upOyMKgn3+Lol/ikY=
X-Received: by 2002:a9d:5911:: with SMTP id t17mr32196102oth.30.1635924471480;
 Wed, 03 Nov 2021 00:27:51 -0700 (PDT)
MIME-Version: 1.0
References: <20211012082708.121931-1-iivanov@suse.de> <YWVKAk4h5bsUA3b6@light.dominikbrodowski.net>
 <YX44DCaIg/qGOrtE@light.dominikbrodowski.net> <CAMj1kXEeCwhADMEwfE8SaG=1+J8Lzrck72DixSdxOP3cAK_Uzg@mail.gmail.com>
 <YYI2unrpOm/ap/y6@light.dominikbrodowski.net>
In-Reply-To: <YYI2unrpOm/ap/y6@light.dominikbrodowski.net>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 3 Nov 2021 08:27:39 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFCW4RQgXXNV7Z02Ljj36egidry0DyMm7+siSL6cocTOA@mail.gmail.com>
Message-ID: <CAMj1kXFCW4RQgXXNV7Z02Ljj36egidry0DyMm7+siSL6cocTOA@mail.gmail.com>
Subject: Re: [PATCH] random: fix crash on multiple early calls to add_bootloader_randomness()
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        "Ivan T. Ivanov" <iivanov@suse.de>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 3 Nov 2021 at 08:17, Dominik Brodowski
<linux@dominikbrodowski.net> wrote:
>
> Am Sun, Oct 31, 2021 at 01:33:34PM +0100 schrieb Ard Biesheuvel:
> > On Sun, 31 Oct 2021 at 07:31, Dominik Brodowski
> > <linux@dominikbrodowski.net> wrote:
> > >
> > > If add_bootloader_randomness() or add_hwgenerator_randomness() is
> > > called for the first time during early boot, crng_init equals 0. Then,
> > > crng_fast_load() gets called -- which is safe to do even if the input
> > > pool is not yet properly set up.
> > >
> > > If the added entropy suffices to increase crng_init to 1, future calls
> > > to add_bootloader_randomness() or add_hwgenerator_randomness() used to
> > > progress to credit_entropy_bits(). However, if the input pool is not yet
> > > properly set up, the cmpxchg call within that function can lead to an
> > > infinite recursion. This is not only a hypothetical problem, as qemu
> > > on x86 may provide bootloader entropy via EFI and via devicetree.
> > >
> >
> > arm64 not x86
>
> Thanks, fixed in v2
>
> > > As crng_global_init_time is set to != 0 once the input pool is properly
> > > set up, check (also) for this condition to determine which branch to take.
> > >
> > > Calls to crng_fast_load() do not modify the input pool; therefore, the
> > > entropy_count for the input pool must not be modified at that early
> > > stage.
> > >
> > > Reported-and-tested-by: Ivan T. Ivanov <iivanov@suse.de>
> >
> > Nit: fancy tags like this are more difficult to grep for
> >
> > Better to use separate Reported-by and Tested-by tags
>
> Well, it's used not all that rarely, but I don't care that much, so updated for v2.
>
> > Please don't drop the diffstat. Are you using git format-patch?
>
> For singular patches no; but fixed for v2.
>
> > > diff --git a/drivers/char/random.c b/drivers/char/random.c
> > > index 605969ed0f96..4211ff3092f9 100644
> > > --- a/drivers/char/random.c
> > > +++ b/drivers/char/random.c
> > > @@ -1763,8 +1763,8 @@ static void __init init_std_data(struct entropy_store *r)
> > >  }
> > >
> > >  /*
> > > - * Note that setup_arch() may call add_device_randomness()
> > > - * long before we get here. This allows seeding of the pools
> > > + * add_device_randomness() or add_bootloader_randomness() may be
> > > + * called long before we get here. This allows seeding of the pools
> > >   * with some platform dependent data very early in the boot
> > >   * process. But it limits our options here. We must use
> > >   * statically allocated structures that already have all
> > > @@ -2274,7 +2274,12 @@ void add_hwgenerator_randomness(const char *buffer, size_t count,
> > >  {
> > >         struct entropy_store *poolp = &input_pool;
> > >
> > > -       if (unlikely(crng_init == 0)) {
> > > +       /* We cannot do much with the input pool until it is set up in
> > > +        * rand_initalize(); therefore just mix into the crng state.
> > > +        * As this does not affect the input pool, we cannot credit
> > > +        * entropy for this.
> > > +        */
> > > +       if (unlikely(crng_init == 0) || unlikely(crng_global_init_time == 0)) {
> >
> > Can we just drop the unlikely()s here?
>
> As that would be a different change to the one necessary to resolve the bug,
> I'd like to defer that decision to the maintainer of random.c.
>

In that case, can we at least using a single unlikely() for the whole condition?
