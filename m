Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD2BB440E6B
	for <lists+linux-efi@lfdr.de>; Sun, 31 Oct 2021 13:33:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbhJaMgS (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 31 Oct 2021 08:36:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:35064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229798AbhJaMgS (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sun, 31 Oct 2021 08:36:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 83CF360FD9;
        Sun, 31 Oct 2021 12:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635683626;
        bh=NRhO6hzo10XWUP2bFt6QNKXuMxBJ25uRfWxqDqY/+8M=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Jv5eTWcVA2z5JT5Ug7EiUMbH52+8dNpb/VkCf+EPr30fedYWXUmNZFRJMIHIC3j+r
         6T25N7FKIwciqwuAaqDfxutRyRRXKahzZpE5vN2Z3xenC7srxDMSnGZJTwZfoPxgg3
         LFv5mOcXmWURzDBG8n2REorEsFWZtw7e9T/edFX1WZ6y4gNT/vLog7Y45vDUt23c+l
         afQMNXZ7/dK9gKdCxdTSmyXwBPFB76JE7z0dBOEmLYYERrazqEPj1lz5+vsSI2FMsn
         jWMcTKZFeojo3DC/wA5FUoQEAD8AXA5WIEJnUGNIxzFy0Z9eVvHITxn2lsNKrXh0dg
         gD7bmlVX1nChg==
Received: by mail-oo1-f50.google.com with SMTP id m37-20020a4a9528000000b002b83955f771so5247282ooi.7;
        Sun, 31 Oct 2021 05:33:46 -0700 (PDT)
X-Gm-Message-State: AOAM530AcGtmbNf9FcxCs6h74fxU5euTx4BNfwxcevcRwh+3+XEL1CEV
        urVfV43fqww3foh298vIB2Rms63eCeDTEEvNpDY=
X-Google-Smtp-Source: ABdhPJzRyhFZSvvjXFfXlEbz9eE+P8RVY2MhVsjkKOk/v+Ogtl4XZxBwYW17JwmZzmZkY6SmoAfsZrsnF22NHXBzwEI=
X-Received: by 2002:a4a:e93d:: with SMTP id a29mr15115163ooe.63.1635683625840;
 Sun, 31 Oct 2021 05:33:45 -0700 (PDT)
MIME-Version: 1.0
References: <20211012082708.121931-1-iivanov@suse.de> <YWVKAk4h5bsUA3b6@light.dominikbrodowski.net>
 <YX44DCaIg/qGOrtE@light.dominikbrodowski.net>
In-Reply-To: <YX44DCaIg/qGOrtE@light.dominikbrodowski.net>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sun, 31 Oct 2021 13:33:34 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEeCwhADMEwfE8SaG=1+J8Lzrck72DixSdxOP3cAK_Uzg@mail.gmail.com>
Message-ID: <CAMj1kXEeCwhADMEwfE8SaG=1+J8Lzrck72DixSdxOP3cAK_Uzg@mail.gmail.com>
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

On Sun, 31 Oct 2021 at 07:31, Dominik Brodowski
<linux@dominikbrodowski.net> wrote:
>
> If add_bootloader_randomness() or add_hwgenerator_randomness() is
> called for the first time during early boot, crng_init equals 0. Then,
> crng_fast_load() gets called -- which is safe to do even if the input
> pool is not yet properly set up.
>
> If the added entropy suffices to increase crng_init to 1, future calls
> to add_bootloader_randomness() or add_hwgenerator_randomness() used to
> progress to credit_entropy_bits(). However, if the input pool is not yet
> properly set up, the cmpxchg call within that function can lead to an
> infinite recursion. This is not only a hypothetical problem, as qemu
> on x86 may provide bootloader entropy via EFI and via devicetree.
>

arm64 not x86

> As crng_global_init_time is set to != 0 once the input pool is properly
> set up, check (also) for this condition to determine which branch to take.
>
> Calls to crng_fast_load() do not modify the input pool; therefore, the
> entropy_count for the input pool must not be modified at that early
> stage.
>
> Reported-and-tested-by: Ivan T. Ivanov <iivanov@suse.de>

Nit: fancy tags like this are more difficult to grep for

Better to use separate Reported-by and Tested-by tags

> Fixes: 18b915ac6b0a ("efi/random: Treat EFI_RNG_PROTOCOL output as bootloader randomness")
> Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
>

Please don't drop the diffstat. Are you using git format-patch?


> diff --git a/drivers/char/random.c b/drivers/char/random.c
> index 605969ed0f96..4211ff3092f9 100644
> --- a/drivers/char/random.c
> +++ b/drivers/char/random.c
> @@ -1763,8 +1763,8 @@ static void __init init_std_data(struct entropy_store *r)
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
> @@ -2274,7 +2274,12 @@ void add_hwgenerator_randomness(const char *buffer, size_t count,
>  {
>         struct entropy_store *poolp = &input_pool;
>
> -       if (unlikely(crng_init == 0)) {
> +       /* We cannot do much with the input pool until it is set up in
> +        * rand_initalize(); therefore just mix into the crng state.
> +        * As this does not affect the input pool, we cannot credit
> +        * entropy for this.
> +        */
> +       if (unlikely(crng_init == 0) || unlikely(crng_global_init_time == 0)) {

Can we just drop the unlikely()s here?

>                 crng_fast_load(buffer, count);
>                 return;
>         }
