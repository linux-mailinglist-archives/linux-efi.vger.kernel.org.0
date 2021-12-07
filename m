Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD81246B37D
	for <lists+linux-efi@lfdr.de>; Tue,  7 Dec 2021 08:14:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbhLGHSS (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 7 Dec 2021 02:18:18 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:57078 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbhLGHSS (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 7 Dec 2021 02:18:18 -0500
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from owl.dominikbrodowski.net (owl.brodo.linta [10.2.0.111])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id DE6ED2013ED;
        Tue,  7 Dec 2021 07:14:45 +0000 (UTC)
Received: by owl.dominikbrodowski.net (Postfix, from userid 1000)
        id 3FFA880671; Tue,  7 Dec 2021 08:14:27 +0100 (CET)
Date:   Tue, 7 Dec 2021 08:14:27 +0100
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     "Jason A. Donenfeld" <jason@zx2c4.com>,
        Theodore Ts'o <tytso@mit.edu>,
        "Ivan T. Ivanov" <iivanov@suse.de>,
        Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5] random: fix crash on multiple early calls to
 add_bootloader_randomness()
Message-ID: <Ya8J084926PUC4l4@owl.dominikbrodowski.net>
References: <20211012082708.121931-1-iivanov@suse.de>
 <YWVKAk4h5bsUA3b6@light.dominikbrodowski.net>
 <YaivhAV8LouB0zGV@light.dominikbrodowski.net>
 <CAHmME9qxBeBzfKCjzfAFX9ZWAGKv1TKCQw3x22d_DmJtaAewLw@mail.gmail.com>
 <YanOIvAV1iPBEXR3@light.dominikbrodowski.net>
 <CAJMQK-i0vZ8k8cNrUaDBdCBv4ucd-DzUWix3ui7QZ_2awZHe6g@mail.gmail.com>
 <Ya55SjgSkO+INcbb@light.dominikbrodowski.net>
 <CAJMQK-g8J8VCthoe5c9TWozycufhgWQQshRpEnHRo=y5A3m74g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJMQK-g8J8VCthoe5c9TWozycufhgWQQshRpEnHRo=y5A3m74g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Am Tue, Dec 07, 2021 at 03:09:21PM +0800 schrieb Hsin-Yi Wang:
> On Tue, Dec 7, 2021 at 4:58 AM Dominik Brodowski
> <linux@dominikbrodowski.net> wrote:
> >
> > Am Mon, Dec 06, 2021 at 01:42:01PM +0800 schrieb Hsin-Yi Wang:
> > > On Fri, Dec 3, 2021 at 3:59 PM Dominik Brodowski
> > > <linux@dominikbrodowski.net> wrote:
> > > >
> > > > Hi Jason,
> > > >
> > > > Am Thu, Dec 02, 2021 at 11:55:10AM -0500 schrieb Jason A. Donenfeld:
> > > > > Thanks for the patch. One trivial nit and one question:
> > > >
> > > > Thanks for your review!
> > > >
> > > > > On Thu, Dec 2, 2021 at 6:35 AM Dominik Brodowski
> > > > > <linux@dominikbrodowski.net> wrote:
> > > > > > +       /* We cannot do much with the input pool until it is set up in
> > > > > > +        * rand_initalize(); therefore just mix into the crng state.
> > > > >
> > > > > I think you meant "rand_initialize()" here (missing 'i').
> > > >
> > > > Indeed, sorry about that.
> > > >
> > > > > > If the added entropy suffices to increase crng_init to 1, future calls
> > > > > > to add_bootloader_randomness() or add_hwgenerator_randomness() used to
> > > > > > progress to credit_entropy_bits(). However, if the input pool is not yet
> > > > > > properly set up, the cmpxchg call within that function can lead to an
> > > > > > infinite recursion.
> > > > >
> > > > > I see what this patch does with crng_global_init_time, and that seems
> > > > > probably sensible, but I didn't understand this part of the reasoning
> > > > > in the commit message; I might just be a bit slow here. Where's the
> > > > > recursion exactly? Or even an infinite loop?
> > > >
> > > > On arm64, it was actually a NULL pointer dereference reported by Ivan T.
> > > > Ivanov; see
> > > >
> > > >         https://lore.kernel.org/lkml/20211012082708.121931-1-iivanov@suse.de/
> > > >
> > > > Trying to reproduce this rather bluntly on x86/qemu by multiple manual calls
> > > > to add_bootloader_randomness(), I mis-interpreted the symptoms to point to an
> > > > infinite recursion. The real problem seems to be that crng_reseed() isn't
> > > > ready to be called too early in the boot process, in particular before
> > > > workqueues are ready (see the call to numa_crng_init()).
> > > >
> > > > However, there seem be additional issues with add_bootloader_randomness()
> > > > not yet addressed (or worsened) by my patch:
> > > >
> > > >         - If CONFIG_RANDOM_TRUST_BOOTLOADER is enabled and crng_init==0,
> > > >           add_hwgenerator_randomness() calls crng_fast_load() and returns
> > > >           immediately. If it is disabled and crng_init==0,
> > > >           add_device_randnomness() calls crng_slow_load() but still
> > > >           continues to call _mix_pool_bytes(). That means the seed is
> > > >           used more extensively if CONFIG_RANDOM_TRUST_BOOTLOADER is not
> > > >           set!
> > > If called by the crng_slow_load(), it's mixed into the pool but we're
> > > not trusting it. But in crng_fast_load() we're using it to init crng.
> > >
> > > >
> > > >         - If CONFIG_RANDOM_TRUST_BOOTLOADER is enabled and crng_init==0,
> > > >           the entropy is not credited -- same as if
> > > >           CONFIG_RANDOM_TRUST_BOOTLOADER is not set. Only subsequent calls
> > >
> > > In crng_fast_load(), the seed would be mixed to primary_crng.state[4],
> >
> > Actually, that is also the case for crng_slow_load() (see dest_buf there).
> >
> Right, but the difference is if we want to credit(trust) that for crng init.

... which is, unfortunately, not the only difference between slow and
fast...

> > > and then crng_init will be 1 if the added seed is enough.
> > > rng-seed in dt (called in early_init_dt_scan_chosen()) also needs to
> > > use this function to init crng.
> >
> > Indeed, crng_init should be set to 1 in that case.
> >
> > > With the patch, we're seeing
> > > [    0.000000] random: get_random_u64 called from
> > > __kmem_cache_create+0x34/0x270 with crng_init=0
> > >
> > > While before it should be
> > > [    0.000000] random: get_random_u64 called from
> > > __kmem_cache_create+0x34/0x280 with crng_init=1
> > >
> > > >           to add_bootloader_randomness() would credit entropy, but that
> > > >           causes the issue NULL pointer dereference or the hang...
> > > >
> > > >         - As crng_fast_load() returns early, that actually means that my
> > > >           patch causes the additional entropy submitted to
> > > >           add_hwgenerator_randomness() by subsequent calls to be completely
> > > >           lost.
> > > Only when crng_init==0, if crng is initialized, it would continue with
> > > credit_entropy_bits().
> >
> > However, if workqueues are not up and running (yet), it will fail.
> >
> > New draft below!
> 
> Thanks, the new draft now takes care of the crng init.
> [    0.000000] random: get_random_u64 called from
> __kmem_cache_create+0x34/0x270 with crng_init=1

Thanks for testing!

> > ---
> >
> > Currently, if CONFIG_RANDOM_TRUST_BOOTLOADER is enabled, mutliple calls
> > to add_bootloader_randomness() are broken and can cause a NULL pointer
> > dereference, as noted by Ivan T. Ivanov. This is not only a hypothetical
> > problem, as qemu on arm64 may provide bootloader entropy via EFI and via
> > devicetree.
> >
> > On the first call to add_hwgenerator_randomness(), crng_fast_load() is
> > executed, and if the seed is long enough, crng_init will be set to 1.
> > However, no entropy is currently credited for that, even though the
> > name and description of CONFIG_RANDOM_TRUST_BOOTLOADER states otherwise.
> >
> > On subsequent calls to add_bootloader_randomness() and then to
> > add_hwgenerator_randomness(), crng_fast_load() will be skipped. Instead,
> > wait_event_interruptible() (which makes no sense for the init process)
> > and then credit_entropy_bits() will be called. If the entropy count for
> > that second seed is large enough, that proceeds to crng_reseed().
> > However, crng_reseed() may depend on workqueues being available, which
> > is not the case early during boot.
> >
> > To fix these issues, explicitly call crng_fast_load() or crng_slow_load()
> > depending on whether the bootloader is trusted -- only in the first
> > instance, crng_init may progress to 1. Also, mix the seed into the
> > input pool unconditionally, and credit the entropy for that iff
> > CONFIG_RANDOM_TRUST_BOOTLOADER is set. However, avoid a call to
> > crng_reseed() too early during boot. It is safe to be called after
> > rand_initialize(), so use crng_global_init_time (which is set to != 0
> > in that function) to determine which branch to take.
> >
> > Reported-by: Ivan T. Ivanov <iivanov@suse.de>
> > Fixes: 18b915ac6b0a ("efi/random: Treat EFI_RNG_PROTOCOL output as bootloader randomness")
> > Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
> >
> > diff --git a/drivers/char/random.c b/drivers/char/random.c
> > index 605969ed0f96..abe4571fd2c0 100644
> > --- a/drivers/char/random.c
> > +++ b/drivers/char/random.c
> > @@ -722,7 +722,8 @@ static void credit_entropy_bits(struct entropy_store *r, int nbits)
> >         if (r == &input_pool) {
> >                 int entropy_bits = entropy_count >> ENTROPY_SHIFT;
> >
> > -               if (crng_init < 2 && entropy_bits >= 128)
> > +               if (crng_init < 2 && entropy_bits >= 128 &&
> > +                   crng_global_init_time > 0)
> >                         crng_reseed(&primary_crng, r);
> >         }
> >  }
> > @@ -1763,8 +1764,8 @@ static void __init init_std_data(struct entropy_store *r)
> >  }
> >
> >  /*
> > - * Note that setup_arch() may call add_device_randomness()
> > - * long before we get here. This allows seeding of the pools
> > + * add_device_randomness() or add_bootloader_randomness() may be
> > + * called long before we get here. This allows seeding of the pools
> >   * with some platform dependent data very early in the boot
> >   * process. But it limits our options here. We must use
> >   * statically allocated structures that already have all
> > @@ -2291,15 +2292,29 @@ void add_hwgenerator_randomness(const char *buffer, size_t count,
> >  EXPORT_SYMBOL_GPL(add_hwgenerator_randomness);
> >
> >  /* Handle random seed passed by bootloader.
> > - * If the seed is trustworthy, it would be regarded as hardware RNGs. Otherwise
> > - * it would be regarded as device data.
> > + * If the seed is trustworthy, its entropy will be credited.
> >   * The decision is controlled by CONFIG_RANDOM_TRUST_BOOTLOADER.
> >   */
> >  void add_bootloader_randomness(const void *buf, unsigned int size)
> >  {
> > -       if (IS_ENABLED(CONFIG_RANDOM_TRUST_BOOTLOADER))
> > -               add_hwgenerator_randomness(buf, size, size * 8);
> > -       else
> > -               add_device_randomness(buf, size);
> > +       unsigned long time = random_get_entropy() ^ jiffies;
> > +       unsigned long flags;
> > +
> > +       if (!crng_ready() && size) {
> size is checked here but not below?

credit_entropy_bits() returns early if bits==0.

Thanks,
	Dominik
