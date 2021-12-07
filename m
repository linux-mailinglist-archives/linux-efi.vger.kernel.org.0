Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96CBF46C1AA
	for <lists+linux-efi@lfdr.de>; Tue,  7 Dec 2021 18:22:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235567AbhLGR0P (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 7 Dec 2021 12:26:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230525AbhLGR0P (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 7 Dec 2021 12:26:15 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAF14C061574;
        Tue,  7 Dec 2021 09:22:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id EF76ECE1A08;
        Tue,  7 Dec 2021 17:22:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFC80C341C3;
        Tue,  7 Dec 2021 17:22:40 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Cko8u3R2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1638897759;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zMvetDw/BH1091ILlaKRflxk0F86VyRo0nLfwpJR+6k=;
        b=Cko8u3R2TbjxQBm5GrA08OyrHlGfCRNWm0Iovkp8+1J5Q6Q23BTZUef7xILpXrBP/zpQG4
        o9pxFVtrV7gBCvYRDuPqSo5UTdrdTHbF9dp+C3n6BrFmaUiMFBS1m3BqoTy5FdvY0aPmCv
        pnpA9IAiH8uknPQClOS3scOoHtFyAsA=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id cf73a017 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Tue, 7 Dec 2021 17:22:39 +0000 (UTC)
Received: by mail-yb1-f171.google.com with SMTP id v203so42765719ybe.6;
        Tue, 07 Dec 2021 09:22:38 -0800 (PST)
X-Gm-Message-State: AOAM531jyCinzZk8efFxNW0uJXj3yq6lh7rjdYghvHSObFP9if1DwGtR
        oaqBROVKYXwgwYNavqKwGAKWtlSYhnzxAMzGV0I=
X-Google-Smtp-Source: ABdhPJyQNr9n/JmeGtA3H8QnICWmQvq+f2MkfaNhFgvIFJ9/g3rlDVIOskyeSpQZDpkK+bq0awKYAAMJH+E5Y+SG+r8=
X-Received: by 2002:a5b:c81:: with SMTP id i1mr22242615ybq.115.1638897757942;
 Tue, 07 Dec 2021 09:22:37 -0800 (PST)
MIME-Version: 1.0
References: <20211012082708.121931-1-iivanov@suse.de> <YWVKAk4h5bsUA3b6@light.dominikbrodowski.net>
 <YaivhAV8LouB0zGV@light.dominikbrodowski.net> <CAHmME9qxBeBzfKCjzfAFX9ZWAGKv1TKCQw3x22d_DmJtaAewLw@mail.gmail.com>
 <YanOIvAV1iPBEXR3@light.dominikbrodowski.net> <CAJMQK-i0vZ8k8cNrUaDBdCBv4ucd-DzUWix3ui7QZ_2awZHe6g@mail.gmail.com>
 <Ya55SjgSkO+INcbb@light.dominikbrodowski.net>
In-Reply-To: <Ya55SjgSkO+INcbb@light.dominikbrodowski.net>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Tue, 7 Dec 2021 18:22:26 +0100
X-Gmail-Original-Message-ID: <CAHmME9oonMxxfEq7sjSSYc7XPwzjW4e45JTbBCJ2hFEbL-tnyw@mail.gmail.com>
Message-ID: <CAHmME9oonMxxfEq7sjSSYc7XPwzjW4e45JTbBCJ2hFEbL-tnyw@mail.gmail.com>
Subject: Re: [PATCH v5] random: fix crash on multiple early calls to add_bootloader_randomness()
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     Hsin-Yi Wang <hsinyi@chromium.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        "Ivan T. Ivanov" <iivanov@suse.de>,
        Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Dominik,

Thanks for the followup patch. Some comments below:

On Mon, Dec 6, 2021 at 9:58 PM Dominik Brodowski
<linux@dominikbrodowski.net> wrote:
> @@ -722,7 +722,8 @@ static void credit_entropy_bits(struct entropy_store *r, int nbits)
>         if (r == &input_pool) {
>                 int entropy_bits = entropy_count >> ENTROPY_SHIFT;
>
> -               if (crng_init < 2 && entropy_bits >= 128)
> +               if (crng_init < 2 && entropy_bits >= 128 &&
> +                   crng_global_init_time > 0)

crng_global_init_time is being used because it's set in
rand_initialize(), and rand_initialize() is called after workqueues
have been set up. Fair enough. But:
a) It's still set to `jiffies - 1` afterwards at runtime, via
ioctl(RNDRESEEDCRNG). I'm not sure if we want to mess around with
having a 1:2**32 chance of getting this at the unlucky 0 wraparound.
It seems like that kind of strategy generally works if unlikely
failure is tolerable, but it seems like that's not a game to play
here. There are a few other options:
b) Use another proxy for the state, like
rand_initialize()->primary_crng.state (ugly) or something better.
c) Add another static global state variable or static branch to random.c.
d) Actually conditionalize this on whether or not workqueues have been
init'd, which is *actually* the thing you care about, not whether
rand_initialize() has fired.

I think that of these, (d) seems the most correct. The thing you're
*actually* trying to prevent is that
`schedule_work(&numa_crng_init_work)` call being triggered before
workqueues are up. It looks like system_wq is made non-NULL by
workqueue_init_early(); perhaps you could get away with
conditionalizing it on that instead?

This also seems like a distinct state machine derp from the rest of
the patch, so I wonder if it could be separated out into a more
trivial patch, in case it does prove problematic somehow.

> +#ifdef CONFIG_RANDOM_TRUST_BOOTLOADER

Can you use IF_ENABLED() like the code that this replaces? Easier to
read and ensures syntax doesn't regress on less-used configurations.

>  void add_bootloader_randomness(const void *buf, unsigned int size)
> +       unsigned long time = random_get_entropy() ^ jiffies;
> +       unsigned long flags;
> +
> +       if (!crng_ready() && size) {
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


Trying to understand this and compare it to what was here before. Two
cases: trustbootloader and !trustbootloader.

trustbootloader looks like this:

       unsigned long time = random_get_entropy() ^ jiffies;
       unsigned long flags;
       if (!crng_ready() && size)
               crng_fast_load(buf, size);
       spin_lock_irqsave(&input_pool.lock, flags);
       _mix_pool_bytes(&input_pool, buf, size);
       _mix_pool_bytes(&input_pool, &time, sizeof(time));
       spin_unlock_irqrestore(&input_pool.lock, flags);
       credit_entropy_bits(&input_pool, size * 8);

!trustbooloader looks like this:

       unsigned long time = random_get_entropy() ^ jiffies;
       unsigned long flags;
       if (!crng_ready() && size)
               crng_slow_load(buf, size);
       spin_lock_irqsave(&input_pool.lock, flags);
       _mix_pool_bytes(&input_pool, buf, size);
       _mix_pool_bytes(&input_pool, &time, sizeof(time));
       spin_unlock_irqrestore(&input_pool.lock, flags);

So this means !trustbootloader is the same as add_device_randomness
(with the call to trace_add_device_randomness removed). It'd probably
make sense to continue just branching to add_device_randomness on an
IS_ENABLED(), then, so it's more clear what's up, rather than open
coding the distinct paths and copying code around.

But trustbootloader is a different case. Here the differences appear to be:

1) crng_fast_load is now called for crng_init==1||crng_init==0 [via
crng_ready()] instead of for crng_init==0;
2) The function now continues onward after calling crng_fast_load
instead of returning;
3) The useless call to wait_event_interruptible is now skipped;
4) _mix_pool_bytes(random_get_entropy() ^ jiffies) is now called in
addition to _mix_pool_bytes(buf).

I'd now like to map (1), (2), (3), and (4) back to the rationale in
your commit message.

(2) seems to be related to:

> On the first call to add_hwgenerator_randomness(), crng_fast_load() is
> executed, and if the seed is long enough, crng_init will be set to 1.
> However, no entropy is currently credited for that, even though the
> name and description of CONFIG_RANDOM_TRUST_BOOTLOADER states otherwise.

But it seems like rather than going from:
       if (!ready) {
               crng_fast_load(buf, size);
               return;
       }
to:
       if (!ready)
               crng_fast_load(buf, size);
the actually corresponding fix would be to go instead to:
       if (!ready)
               crng_fast_load(buf, size);
       if (!ready)
               return;

(3) seems to be related to:

> wait_event_interruptible() (which makes no sense for the init process)

which is fine.

(1) and (4) I don't see justification for. Perhaps it's a mistake?

Regards,
Jason
