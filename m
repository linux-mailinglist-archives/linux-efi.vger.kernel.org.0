Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A42BD6229B6
	for <lists+linux-efi@lfdr.de>; Wed,  9 Nov 2022 12:09:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbiKILJq (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 9 Nov 2022 06:09:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230282AbiKILJ0 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 9 Nov 2022 06:09:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D8091900B
        for <linux-efi@vger.kernel.org>; Wed,  9 Nov 2022 03:09:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2C696B81D8B
        for <linux-efi@vger.kernel.org>; Wed,  9 Nov 2022 11:09:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6EC1C433C1
        for <linux-efi@vger.kernel.org>; Wed,  9 Nov 2022 11:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667992162;
        bh=U5Gx0+DBXrWApaYqqHI/F4GfWZ0je1gH6ecewfjJgUM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=iUbi/Kl1UzHq4ClLMTo4hE5B5NaUHKMRPm5a5mvgumfK0sau8RpPmdL8i6IU8gDqT
         W6efZBv+VPvsHki7S3ppXAypjlYUijoIQUjyMeaN1H5ttvSbIcLYsNrauexpImb+6v
         rmI5sr+AlrDTbhF/+l8WbEwonkrykYEsTUsjsvZjb6mrN/uS3QIUIOZCKrIZD/qZgC
         XAgFCjvd8P7F5JtxbgakUaf9U04kCameiLxgIze/DnJX5EP5blIPOuGzY/XREaP+I0
         Bh8i7O+CQlSjds1mpY+NyE6F5jvMtGyhYSlkHb0uqDnFtwqXQEnrmYuUxVEsdBgEEl
         g6aQYYOeUlsMg==
Received: by mail-lf1-f43.google.com with SMTP id r12so25138692lfp.1
        for <linux-efi@vger.kernel.org>; Wed, 09 Nov 2022 03:09:22 -0800 (PST)
X-Gm-Message-State: ACrzQf2kFDraXYrg8rDVf2/x3Yu0SJGsCCdfT84pXHNFkavuSOW528j2
        tccqViQVrtltRQhKpwJJLm4HHYMdF4AKI7wQelM=
X-Google-Smtp-Source: AMsMyM56RWfoWmMlBKjarZt1YOjku/7mzHEWJa3iyZBSupS7lrCDZBE0zn+PilbY65HNowUZIrhz2VZdqoycIG1gyyc=
X-Received: by 2002:a19:4f53:0:b0:4b1:1f35:279b with SMTP id
 a19-20020a194f53000000b004b11f35279bmr14720179lfk.637.1667992160719; Wed, 09
 Nov 2022 03:09:20 -0800 (PST)
MIME-Version: 1.0
References: <20221109095558.2572896-1-ardb@kernel.org> <Y2uCSvoAguYsWotP@zx2c4.com>
In-Reply-To: <Y2uCSvoAguYsWotP@zx2c4.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 9 Nov 2022 12:09:09 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGE2iWYk4mHM+2WRAN5QpV5utADZMi0WxyNiPcLLNFuhg@mail.gmail.com>
Message-ID: <CAMj1kXGE2iWYk4mHM+2WRAN5QpV5utADZMi0WxyNiPcLLNFuhg@mail.gmail.com>
Subject: Re: [PATCH v4] efi: random: combine bootloader provided RNG seed with
 RNG protocol output
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-efi@vger.kernel.org,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Lennart Poettering <lennart@poettering.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 9 Nov 2022 at 11:34, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> Hi Ard,
>
> Looking good! Thanks. A few brief comments.
>
> On Wed, Nov 09, 2022 at 10:55:58AM +0100, Ard Biesheuvel wrote:
> > The recommended seed
> > size is 32 bytes, anything beyond that is disregarded when the seeds are
> > concatenated.
>
> This should read, "The recommended seed size is 32 bytes, and seeds
> larger than 512 bytes are considered corrupted and ignored entirely."
>

Ack.

> > Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > Cc: Jason A. Donenfeld <Jason@zx2c4.com>
> > Cc: Lennart Poettering <lennart@poettering.net>
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
>
> I was thinking it might be best to add:
>
>    Cc: stable@vger.kernel.org
>
> "Don't clobber existing GUID" seems like it's arguably a fix.
>

Yeah, I'm on the fence about that one. I'll leave it out for now, and
we can always get it into -stable later. I am not going to queue it as
a fix now in any case.


> >       status = efi_bs_call(allocate_pool, EFI_ACPI_RECLAIM_MEMORY,
> > -                          sizeof(*seed) + EFI_RANDOM_SEED_SIZE,
> > +                          struct_size(seed, bits, seed_size),
> >                            (void **)&seed);
> >       if (status != EFI_SUCCESS)
> >               return status;
>
> Should this print "Failed to something something, retaining
> bootloader-supplied seed only", like the err_freepool case?
>

Yeah, it's just something that is exceedingly unlikely to ever occur
in practice, and if it does, whether or not the efi_warn() will
produce any observable output is anyone's guess.

But i'll add it just for good measure.

> > +     efi_warn("Failed to obtain seed from EFI_RNG_PROTOCOL%s\n",
> > +              prev_seed ? ", retaining bootloader supplied seed only" : "");
>
> "bootloader-supplied" with the hyphen, right?
>

Ack.

> If you make any of the above changes, feel free to do it when you commit
> this. IOW, my comments are nits, so:
>
>     Reviewed-by: Jason A. Donenfeld <Jason@zx2c4.com>
>

Thanks.

> Also, I verified that kexec correctly sets everything back to 32 bytes
> with this line:
>     size = min(seed->size, EFI_RANDOM_SEED_SIZE);
> So that's good.
>
> Jason
