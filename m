Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F18E45BEB28
	for <lists+linux-efi@lfdr.de>; Tue, 20 Sep 2022 18:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbiITQf4 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 20 Sep 2022 12:35:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231133AbiITQfx (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 20 Sep 2022 12:35:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F4EA6582D
        for <linux-efi@vger.kernel.org>; Tue, 20 Sep 2022 09:35:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4BAA5B82A83
        for <linux-efi@vger.kernel.org>; Tue, 20 Sep 2022 16:35:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3E99C433D7
        for <linux-efi@vger.kernel.org>; Tue, 20 Sep 2022 16:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663691749;
        bh=nzip6q0nkuSSnmOO1FyIV55k1J/bXWoNrARNJ+O+hMs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=iWb1n9y/8MmrqLzFMWPLEgdT911K+HfCrC9XpnFErEA3ahzJ2sp9ltp+lnjvO8etr
         NreZptYqfUjU0OJalFmlyDDEGlAX1jfSp3wi2GazXYsXVRyLVXXHK+h1ITAswAwB2N
         3j/cZuwnFfPT2fhxcE/ocazjKiK8qTK2u9tEQ2B8IROh5m/mp65cJ7TYKB4q2NAoL+
         uMySVDf8gj+5Q+8IPgRAoiJlyJTDL2KJxsDgZsbEHxe37Jeu/B1Kmdx74pbQ7FoEQb
         Xp+Ktbit/SqIftEIKv5QibxBy9HzdzvnfspXmA7fC+eDCeCyAukbUuyumWCnXAu6Kb
         nTI0l3tLVcQTw==
Received: by mail-lj1-f173.google.com with SMTP id b6so3652860ljr.10
        for <linux-efi@vger.kernel.org>; Tue, 20 Sep 2022 09:35:48 -0700 (PDT)
X-Gm-Message-State: ACrzQf3fRaCFYgEbAHag+0cMdkA98LAFA1MUzRBFyYeKorkPE75nnyWG
        2DJlKQqOKv1foKJVQuQRgzPtlt//slAeDTVt+KI=
X-Google-Smtp-Source: AMsMyM5UHnDNHpLRVTDGOIe1LM9FWPauVxbmSyWGkvIhich5HMWDJAb+wMzOy7bwn6USlA8Fd1kat2lqJDyiCA/MY7o=
X-Received: by 2002:a2e:9115:0:b0:26a:c086:5138 with SMTP id
 m21-20020a2e9115000000b0026ac0865138mr6776636ljg.189.1663691747040; Tue, 20
 Sep 2022 09:35:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220919160931.2945427-1-ardb@kernel.org> <20220919160931.2945427-4-ardb@kernel.org>
 <YynqHm//QwEBzBWr@gardel-login>
In-Reply-To: <YynqHm//QwEBzBWr@gardel-login>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 20 Sep 2022 18:35:35 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEJz5CXWJQ3YwC864XtU2kLJ+N7s6RU8EEBoHQSY8Vhkg@mail.gmail.com>
Message-ID: <CAMj1kXEJz5CXWJQ3YwC864XtU2kLJ+N7s6RU8EEBoHQSY8Vhkg@mail.gmail.com>
Subject: Re: [PATCH 3/3] efi: random: combine bootloader provided RNG seed
 with RNG protocol output
To:     Lennart Poettering <lennart@poettering.net>
Cc:     linux-efi@vger.kernel.org,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 20 Sept 2022 at 18:28, Lennart Poettering
<lennart@poettering.net> wrote:
>
> On Mo, 19.09.22 18:09, Ard Biesheuvel (ardb@kernel.org) wrote:
>
> Heya!
>
> Looks excellent!
>
> I was wondering though, shouldn't the memory the seed data is stored
> in be zeroed out when you dispose of it, just for safety?
>
> > +     if (rng) {
> > +             const int sz =3D EFI_RANDOM_SEED_SIZE;
> > +             u8 bits[EFI_RANDOM_SEED_SIZE];
> >
> > -     if (status =3D=3D EFI_UNSUPPORTED)
> > -             /*
> > -              * Use whatever algorithm we have available if the raw al=
gorithm
> > -              * is not implemented.
> > -              */
> > -             status =3D efi_call_proto(rng, get_rng, NULL,
> > -                                     EFI_RANDOM_SEED_SIZE, seed->bits)=
;
> > +             status =3D efi_call_proto(rng, get_rng, &rng_algo_raw, sz=
, bits);
> > +             if (status =3D=3D EFI_UNSUPPORTED)
> > +                     /*
> > +                      * Use whatever algorithm we have available if th=
e raw algorithm
> > +                      * is not implemented.
> > +                      */
> > +                     status =3D efi_call_proto(rng, get_rng, NULL, sz,=
 bits);
> >
> > +             if (status =3D=3D EFI_SUCCESS) {
> > +                     blake2s_update(&state, (void *)&sz, sizeof(sz));
> > +                     blake2s_update(&state, bits, sz);
> So, here, shouldn't bit=C5=BF[] be zeroed out?
>
> > -     seed->size =3D EFI_RANDOM_SEED_SIZE;
> > +     blake2s_final(&state, seed->bits);
>
> And here, shouldn't the state struct be zeroed out? (or does
> blake2s_final() do that implicitly?
>

Yes, Jason pointed that out as well. (Twice, actually :-))

> Looks excellent otherwise!
>
> Will-be-used-by: systemd
> Reviewed-by: Lennart Poettering <mzxreary@0pointer.net>

Thanks, much appreciated.
