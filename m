Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A90E946B36D
	for <lists+linux-efi@lfdr.de>; Tue,  7 Dec 2021 08:10:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbhLGHNr (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 7 Dec 2021 02:13:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbhLGHNR (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 7 Dec 2021 02:13:17 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07CC6C061748
        for <linux-efi@vger.kernel.org>; Mon,  6 Dec 2021 23:09:48 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id m5so12701748ilh.11
        for <linux-efi@vger.kernel.org>; Mon, 06 Dec 2021 23:09:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eIorkq2sMVezkBsAIP3Avkx7qHILJR+a50Qp09DisFs=;
        b=VaMV0AZ7KSPcLIaVO/aIBtRMyxWeEeEDUX/8XFmvg/Z2qklsP1MG62W9t81aJraKO4
         ogfttH45Doi8QGT7h3HZpfEYm1LaUe8frT+1eMUszP3ER2pIe0UWbjn/+C4xui652okt
         fEW7xKo8ZHLqromyURpmg/mV23v3lkZaug29Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eIorkq2sMVezkBsAIP3Avkx7qHILJR+a50Qp09DisFs=;
        b=S+DEe/VN4vkMAAalB5l0DWo3tj+oGaXdHXk1r6R6lPD7OfFaR+ZBIk1fnWJT8xRnoK
         RApr6X6fh+tNy0/sm8Yd5H7ZAI/Ou9CYCy8EKwxaOqnJTc9ATeP0+SjfHf+Mo93Ai7p8
         El0h1N6vr7RUTs7LAzQeQ/JC4S6f9cZMJHfXeXnQPiWJc0tsAH/fZbwFRa5IbeIp3jER
         nVtBwpKkMu8hj5yTxq9oqEkaqv4HXUiQygfP1JDSHOBnfyUYNTMym5FwgisRAYZda9EP
         vnrQGVXVe0j/DddsLpVSdx6Nexqkz80LnQQjc2fomW9s9t3M8TrRPALMAGr1QwEmxCvn
         bOBg==
X-Gm-Message-State: AOAM532xbzORUlXU7KLT5df7QTDJm+hJyw0/I2L7FIzuAOpSWWg2bbcV
        nycjMxxjPTVM+Coz+PF23x1Ht51b/Cmyw8/b68wIpQ==
X-Google-Smtp-Source: ABdhPJxEzAHrvrIokXQzo56Rcma8vBU4cL0XbJdB2kh81qCfExjthTUZsEjcGXCp+ePqH+Za/j5co6S5cTpi8pusJeM=
X-Received: by 2002:a05:6e02:4c2:: with SMTP id f2mr37328322ils.105.1638860987351;
 Mon, 06 Dec 2021 23:09:47 -0800 (PST)
MIME-Version: 1.0
References: <20211012082708.121931-1-iivanov@suse.de> <YWVKAk4h5bsUA3b6@light.dominikbrodowski.net>
 <YaivhAV8LouB0zGV@light.dominikbrodowski.net> <CAHmME9qxBeBzfKCjzfAFX9ZWAGKv1TKCQw3x22d_DmJtaAewLw@mail.gmail.com>
 <YanOIvAV1iPBEXR3@light.dominikbrodowski.net> <CAJMQK-i0vZ8k8cNrUaDBdCBv4ucd-DzUWix3ui7QZ_2awZHe6g@mail.gmail.com>
 <Ya55SjgSkO+INcbb@light.dominikbrodowski.net>
In-Reply-To: <Ya55SjgSkO+INcbb@light.dominikbrodowski.net>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Tue, 7 Dec 2021 15:09:21 +0800
Message-ID: <CAJMQK-g8J8VCthoe5c9TWozycufhgWQQshRpEnHRo=y5A3m74g@mail.gmail.com>
Subject: Re: [PATCH v5] random: fix crash on multiple early calls to add_bootloader_randomness()
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     "Jason A. Donenfeld" <jason@zx2c4.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        "Ivan T. Ivanov" <iivanov@suse.de>,
        Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Dec 7, 2021 at 4:58 AM Dominik Brodowski
<linux@dominikbrodowski.net> wrote:
>
> Am Mon, Dec 06, 2021 at 01:42:01PM +0800 schrieb Hsin-Yi Wang:
> > On Fri, Dec 3, 2021 at 3:59 PM Dominik Brodowski
> > <linux@dominikbrodowski.net> wrote:
> > >
> > > Hi Jason,
> > >
> > > Am Thu, Dec 02, 2021 at 11:55:10AM -0500 schrieb Jason A. Donenfeld:
> > > > Thanks for the patch. One trivial nit and one question:
> > >
> > > Thanks for your review!
> > >
> > > > On Thu, Dec 2, 2021 at 6:35 AM Dominik Brodowski
> > > > <linux@dominikbrodowski.net> wrote:
> > > > > +       /* We cannot do much with the input pool until it is set up in
> > > > > +        * rand_initalize(); therefore just mix into the crng state.
> > > >
> > > > I think you meant "rand_initialize()" here (missing 'i').
> > >
> > > Indeed, sorry about that.
> > >
> > > > > If the added entropy suffices to increase crng_init to 1, future calls
> > > > > to add_bootloader_randomness() or add_hwgenerator_randomness() used to
> > > > > progress to credit_entropy_bits(). However, if the input pool is not yet
> > > > > properly set up, the cmpxchg call within that function can lead to an
> > > > > infinite recursion.
> > > >
> > > > I see what this patch does with crng_global_init_time, and that seems
> > > > probably sensible, but I didn't understand this part of the reasoning
> > > > in the commit message; I might just be a bit slow here. Where's the
> > > > recursion exactly? Or even an infinite loop?
> > >
> > > On arm64, it was actually a NULL pointer dereference reported by Ivan T.
> > > Ivanov; see
> > >
> > >         https://lore.kernel.org/lkml/20211012082708.121931-1-iivanov@suse.de/
> > >
> > > Trying to reproduce this rather bluntly on x86/qemu by multiple manual calls
> > > to add_bootloader_randomness(), I mis-interpreted the symptoms to point to an
> > > infinite recursion. The real problem seems to be that crng_reseed() isn't
> > > ready to be called too early in the boot process, in particular before
> > > workqueues are ready (see the call to numa_crng_init()).
> > >
> > > However, there seem be additional issues with add_bootloader_randomness()
> > > not yet addressed (or worsened) by my patch:
> > >
> > >         - If CONFIG_RANDOM_TRUST_BOOTLOADER is enabled and crng_init==0,
> > >           add_hwgenerator_randomness() calls crng_fast_load() and returns
> > >           immediately. If it is disabled and crng_init==0,
> > >           add_device_randnomness() calls crng_slow_load() but still
> > >           continues to call _mix_pool_bytes(). That means the seed is
> > >           used more extensively if CONFIG_RANDOM_TRUST_BOOTLOADER is not
> > >           set!
> > If called by the crng_slow_load(), it's mixed into the pool but we're
> > not trusting it. But in crng_fast_load() we're using it to init crng.
> >
> > >
> > >         - If CONFIG_RANDOM_TRUST_BOOTLOADER is enabled and crng_init==0,
> > >           the entropy is not credited -- same as if
> > >           CONFIG_RANDOM_TRUST_BOOTLOADER is not set. Only subsequent calls
> >
> > In crng_fast_load(), the seed would be mixed to primary_crng.state[4],
>
> Actually, that is also the case for crng_slow_load() (see dest_buf there).
>
Right, but the difference is if we want to credit(trust) that for crng init.
> > and then crng_init will be 1 if the added seed is enough.
> > rng-seed in dt (called in early_init_dt_scan_chosen()) also needs to
> > use this function to init crng.
>
> Indeed, crng_init should be set to 1 in that case.
>
> > With the patch, we're seeing
> > [    0.000000] random: get_random_u64 called from
> > __kmem_cache_create+0x34/0x270 with crng_init=0
> >
> > While before it should be
> > [    0.000000] random: get_random_u64 called from
> > __kmem_cache_create+0x34/0x280 with crng_init=1
> >
> > >           to add_bootloader_randomness() would credit entropy, but that
> > >           causes the issue NULL pointer dereference or the hang...
> > >
> > >         - As crng_fast_load() returns early, that actually means that my
> > >           patch causes the additional entropy submitted to
> > >           add_hwgenerator_randomness() by subsequent calls to be completely
> > >           lost.
> > Only when crng_init==0, if crng is initialized, it would continue with
> > credit_entropy_bits().
>
> However, if workqueues are not up and running (yet), it will fail.
>
> New draft below!

Thanks, the new draft now takes care of the crng init.
[    0.000000] random: get_random_u64 called from
__kmem_cache_create+0x34/0x270 with crng_init=1

>
> Thanks,
>         Dominik
>
> ---
>
> Currently, if CONFIG_RANDOM_TRUST_BOOTLOADER is enabled, mutliple calls
> to add_bootloader_randomness() are broken and can cause a NULL pointer
> dereference, as noted by Ivan T. Ivanov. This is not only a hypothetical
> problem, as qemu on arm64 may provide bootloader entropy via EFI and via
> devicetree.
>
> On the first call to add_hwgenerator_randomness(), crng_fast_load() is
> executed, and if the seed is long enough, crng_init will be set to 1.
> However, no entropy is currently credited for that, even though the
> name and description of CONFIG_RANDOM_TRUST_BOOTLOADER states otherwise.
>
> On subsequent calls to add_bootloader_randomness() and then to
> add_hwgenerator_randomness(), crng_fast_load() will be skipped. Instead,
> wait_event_interruptible() (which makes no sense for the init process)
> and then credit_entropy_bits() will be called. If the entropy count for
> that second seed is large enough, that proceeds to crng_reseed().
> However, crng_reseed() may depend on workqueues being available, which
> is not the case early during boot.
>
> To fix these issues, explicitly call crng_fast_load() or crng_slow_load()
> depending on whether the bootloader is trusted -- only in the first
> instance, crng_init may progress to 1. Also, mix the seed into the
> input pool unconditionally, and credit the entropy for that iff
> CONFIG_RANDOM_TRUST_BOOTLOADER is set. However, avoid a call to
> crng_reseed() too early during boot. It is safe to be called after
> rand_initialize(), so use crng_global_init_time (which is set to != 0
> in that function) to determine which branch to take.
>
> Reported-by: Ivan T. Ivanov <iivanov@suse.de>
> Fixes: 18b915ac6b0a ("efi/random: Treat EFI_RNG_PROTOCOL output as bootloader randomness")
> Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
>
> diff --git a/drivers/char/random.c b/drivers/char/random.c
> index 605969ed0f96..abe4571fd2c0 100644
> --- a/drivers/char/random.c
> +++ b/drivers/char/random.c
> @@ -722,7 +722,8 @@ static void credit_entropy_bits(struct entropy_store *r, int nbits)
>         if (r == &input_pool) {
>                 int entropy_bits = entropy_count >> ENTROPY_SHIFT;
>
> -               if (crng_init < 2 && entropy_bits >= 128)
> +               if (crng_init < 2 && entropy_bits >= 128 &&
> +                   crng_global_init_time > 0)
>                         crng_reseed(&primary_crng, r);
>         }
>  }
> @@ -1763,8 +1764,8 @@ static void __init init_std_data(struct entropy_store *r)
>  }
>
>  /*
> - * Note that setup_arch() may call add_device_randomness()
> - * long before we get here. This allows seeding of the pools
> + * add_device_randomness() or add_bootloader_randomness() may be
> + * called long before we get here. This allows seeding of the pools
>   * with some platform dependent data very early in the boot
>   * process. But it limits our options here. We must use
>   * statically allocated structures that already have all
> @@ -2291,15 +2292,29 @@ void add_hwgenerator_randomness(const char *buffer, size_t count,
>  EXPORT_SYMBOL_GPL(add_hwgenerator_randomness);
>
>  /* Handle random seed passed by bootloader.
> - * If the seed is trustworthy, it would be regarded as hardware RNGs. Otherwise
> - * it would be regarded as device data.
> + * If the seed is trustworthy, its entropy will be credited.
>   * The decision is controlled by CONFIG_RANDOM_TRUST_BOOTLOADER.
>   */
>  void add_bootloader_randomness(const void *buf, unsigned int size)
>  {
> -       if (IS_ENABLED(CONFIG_RANDOM_TRUST_BOOTLOADER))
> -               add_hwgenerator_randomness(buf, size, size * 8);
> -       else
> -               add_device_randomness(buf, size);
> +       unsigned long time = random_get_entropy() ^ jiffies;
> +       unsigned long flags;
> +
> +       if (!crng_ready() && size) {
size is checked here but not below?

> +#ifdef CONFIG_RANDOM_TRUST_BOOTLOADER
> +               crng_fast_load(buf, size);
> +#else
> +               crng_slow_load(buf, size);
> +#endif /* CONFIG_RANDOM_TRUST_BOOTLOADER */
> +       }
> +
> +       spin_lock_irqsave(&input_pool.lock, flags);
> +       _mix_pool_bytes(&input_pool, buf, size);
> +       _mix_pool_bytes(&input_pool, &time, sizeof(time));
> +       spin_unlock_irqrestore(&input_pool.lock, flags);
> +
> +#ifdef CONFIG_RANDOM_TRUST_BOOTLOADER
> +       credit_entropy_bits(&input_pool, size * 8);
> +#endif
>  }
>  EXPORT_SYMBOL_GPL(add_bootloader_randomness);
