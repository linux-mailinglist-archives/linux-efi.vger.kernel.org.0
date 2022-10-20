Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB6146066CC
	for <lists+linux-efi@lfdr.de>; Thu, 20 Oct 2022 19:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbiJTRMM (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 20 Oct 2022 13:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiJTRLu (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 20 Oct 2022 13:11:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC7BF1A910C
        for <linux-efi@vger.kernel.org>; Thu, 20 Oct 2022 10:11:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 98A1DB82706
        for <linux-efi@vger.kernel.org>; Thu, 20 Oct 2022 17:11:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55672C433D7
        for <linux-efi@vger.kernel.org>; Thu, 20 Oct 2022 17:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666285906;
        bh=+y0RwQl4C7clUe9Aqv8lNxnxW3/T+qFLPkrT6N4cjR4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rPO+nqRAmawhJA9SgWYL7gQkCwJ01v5fv9NBfoRllI3A8uZDmgHXaRDNxYIAhDaUz
         d3yiOJE+LG3Uy593OxeEF5hbG0D8tutEOsc2s5EhhEUGjTbovTDGJbVwWtLPfdXchH
         fPMftRG/F9Gqsv4R3+aDL8ndyXEwfsNbaM5icBg06rVBUXWhFum4XQvvy2/2ly/11N
         J4hVv0RdjjxCFmzwmxRcWHKu2s9piJcdT3BITt9GWMKfxQx2JEf+R43uIytVK4kBQ4
         IO9CEx5qdAMaPC7JLiU9QGggTjqkWyJzYre+/+Oat0FvDC8K7tKhn5a0LmeZ9YULNR
         L9se6mA48Gd+A==
Received: by mail-lf1-f41.google.com with SMTP id g7so487654lfv.5
        for <linux-efi@vger.kernel.org>; Thu, 20 Oct 2022 10:11:46 -0700 (PDT)
X-Gm-Message-State: ACrzQf1afxmRUmyl9zydYVC87/8GAoaVUrDR25k8c3d15moNWNjxi4H0
        Etduzdc7gh/LznTidLm7+Zf6e7wa0wtTVulXTYs=
X-Google-Smtp-Source: AMsMyM7jkr0W8CD1HomqYy2Dx4f0KIH6srw6rLcNr7z6UAUZ9ZtyFlVSkxrabSo77w1iB6J8X7vchmfcSoywFC1PqbI=
X-Received: by 2002:a19:c20b:0:b0:4a2:40e5:78b1 with SMTP id
 l11-20020a19c20b000000b004a240e578b1mr5079281lfc.228.1666285904260; Thu, 20
 Oct 2022 10:11:44 -0700 (PDT)
MIME-Version: 1.0
References: <20221020083910.1902009-1-ardb@kernel.org> <20221020083910.1902009-4-ardb@kernel.org>
 <Y1F9oyE9QlJrzZNg@zx2c4.com>
In-Reply-To: <Y1F9oyE9QlJrzZNg@zx2c4.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 20 Oct 2022 19:11:33 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHG4_sboDNnZDvbuCr3oAYdeEn1kqAx3in1WXyBzXXaiQ@mail.gmail.com>
Message-ID: <CAMj1kXHG4_sboDNnZDvbuCr3oAYdeEn1kqAx3in1WXyBzXXaiQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] efi: random: combine bootloader provided RNG seed
 with RNG protocol output
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-efi@vger.kernel.org,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Lennart Poettering <lennart@poettering.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 20 Oct 2022 at 18:56, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> Hi Ard,
>
> Thanks for doing this. Some comments below:
>
> On Thu, Oct 20, 2022 at 10:39:10AM +0200, Ard Biesheuvel wrote:
> > Instead of blindly creating the EFI random seed configuration table if
> > the RNG protocol is implemented and works, check whether such a EFI
> > configuration table was provided by an earlier boot stage and if so,
> > concatenate the existing and the new seeds, leaving it up to the core
> > code to mix it in and credit it the way it sees fit.
> >
> > This can be used for, e.g., systemd-boot, to pass an additional seed to
> > Linux in a way that can be consumed by the kernel very early. In that
> > case, the following definitions should be used to pass the seed to the
> > EFI stub:
> >
> > struct linux_efi_random_seed {
> >       u32     size; // of the 'seed' array in bytes
> >       u8      seed[];
> > };
> >
> > The memory for the struct must be allocated as EFI_ACPI_RECLAIM_MEMORY
> > pool memory, and the address of the struct in memory should be installed
> > as a EFI configuration table using the following GUID:
> >
> > LINUX_EFI_RANDOM_SEED_TABLE_GUID        1ce1e5bc-7ceb-42f2-81e5-8aadf180f57b
> >
> > Note that doing so is safe even on kernels that were built without this
> > patch applied, but the seed will simply be overwritten with a seed
> > derived from the EFI RNG protocol, if available. The recommended seed
> > size is 32 bytes, anything beyond that is disregarded when the seeds are
> > concatenated.
>
> Since this commit message will be used by other implementers inevitably,
> you might want to include something about forward secrecy, memzeroing
> old allocations, etc.
>

Good point. Did you have any prose in mind?

>
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
>
> You can treat overwriting the old seed as an accidental bug, and Cc this
> as stable like the rest of this series.
>
> > +     /*
> > +      * Check whether a seed was provided by a prior boot stage. In that
> > +      * case, instead of overwriting it, let's create a new buffer that can
> > +      * hold both, and concatenate the existing and the new seeds.
> > +      */
> > +     prev_seed = get_efi_config_table(LINUX_EFI_RANDOM_SEED_TABLE_GUID);
> > +     if (prev_seed) {
> > +             prev_seed_size = min(prev_seed->size, EFI_RANDOM_SEED_SIZE);
> > +             seed_size += prev_seed_size;
> > +     }
>
> I think you can omit the min() here. If a bootloader passes a massive
> seed such that allocations later fail, that's a bootloader problem, and
> we should just complain loudly about it.
>

I'm more worried about memory corruption here. If the memory that the
table points to was overwritten arbitrarily, the size field will be
bogus, and memcpy()ing that number of bytes is likely to lead to
tears.

> > +     seed->size = seed_size;
> > +     if (prev_seed)
> > +             memcpy(seed->bits + EFI_RANDOM_SEED_SIZE, prev_seed->bits,
> > +                    prev_seed_size);
>
> You memcpy here, but then:
>
> > +
> >       status = efi_bs_call(install_configuration_table, &rng_table_guid, seed);
> >       if (status != EFI_SUCCESS)
> >               goto err_freepool;
>
> If the installation here fails, you abort, leaving the memcpy'd seed in
> memory without memzeroing.
>

Indeed.

> >
> > +     if (prev_seed) {
> > +             /* wipe and free the old seed if we managed to install the new one */
> > +             memzero_explicit(prev_seed->bits, prev_seed_size);
> > +             efi_bs_call(free_pool, prev_seed);
> > +     }
> >       return EFI_SUCCESS;
> >
> >  err_freepool:
> > +     efi_warn("Failed to obtain seed from EFI_RNG_PROTOCOL%s\n",
> > +              prev_seed ? ", retaining bootloader supplied seed only" : "");
>
> So maybe it makes sense to stick a memzero here too, just before
> freeing?
>

Yes, that makes sense.

> Also, I don't think that efi_warn() makes sense. In the easy case, if
> the bootloader provides a seed bu EFI doesn't have a RNG_PROTOCOL
> implementation, then that's a firmware limitation the user likely can't
> do anything about, in which case it's really good that systemd-boot is
> providing something instead. So that's not something to worry about.

We don't hit the warn in that case. If EFI_RNG_PROTOCOL does not
exist, we just bail and if the bootloader provided a seed as well, it
just remains where it was.

> In the more complicated cases, you jump here when
> install_configuration_table() fails, so that's something to warn about,
> but perhaps just before goto. Then, you also return early from the
> function up at the call to allocate_pool, so that'd be a place to warn
> about too.
>
> Not seen in this diff, but relevant too is that you currently exit early
> from the function if locate_protocol fails. If there's a systemd-boot
> seed already, this is premature.

Why? The bootloader seed will just be passed on in that case - no need
to touch it if we're not going to combine it with anything else.

> Instead, move the call to
> locate_protocol down to just before the call to get_rng.
>
> Jason
>
> >       efi_bs_call(free_pool, seed);
> >       return status;
> >  }
> > diff --git a/include/linux/efi.h b/include/linux/efi.h
> > index cf96f8d5f15f..69454a7ccc6f 100644
> > --- a/include/linux/efi.h
> > +++ b/include/linux/efi.h
> > @@ -1172,8 +1172,6 @@ void efi_check_for_embedded_firmwares(void);
> >  static inline void efi_check_for_embedded_firmwares(void) { }
> >  #endif
> >
> > -efi_status_t efi_random_get_seed(void);
> > -
> >  #define arch_efi_call_virt(p, f, args...)    ((p)->f(args))
> >
> >  /*
> > --
> > 2.35.1
> >
