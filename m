Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EEAC68D23D
	for <lists+linux-efi@lfdr.de>; Tue,  7 Feb 2023 10:10:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbjBGJK1 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 7 Feb 2023 04:10:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjBGJK0 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 7 Feb 2023 04:10:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81E0C3867D;
        Tue,  7 Feb 2023 01:10:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B1FB8B8171F;
        Tue,  7 Feb 2023 09:09:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63880C4339C;
        Tue,  7 Feb 2023 09:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675760978;
        bh=v25yS98xXOuqzzO1dUZSyuA7/44T4tHhYy5xNWul2G8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mzlzERQGC5f4rgU24uSvTLR/8LtixAt/m9bAPKZctiU2yadT8HD5kLA6HS58cHuZg
         zjVHzbfv+lCSW6pBGOx9jiKvIYO3xJSP76R8xRB2uaeIPcrgAOkOWJuIft6wEQ1STG
         48m9azqcS6cHAz3d+2KMtY8qSUPn9mwjmvjgTseJchn+koeDhIPNvwpy56kxMhBZX8
         JpCQxtGXBfVhJhvCkoGvuSkDwns4h0/UQoGdsmuY5TarUgZEWx6eMP1w0CfFUbl8KM
         aba60nrrDAV09atA+7LL9L0/DfZ2XbegA9viGVxGe6py6D7nOl8ygkavJlQ51WQXYk
         51OsQPdtxLsxQ==
Received: by mail-lj1-f177.google.com with SMTP id b16so7039777ljr.11;
        Tue, 07 Feb 2023 01:09:38 -0800 (PST)
X-Gm-Message-State: AO0yUKUgiK/zEM/o9WgFkKepNCPoz/tFT1PU/yz6qUwOGN8Dpt/HEDH/
        l+3XyRFefZ1C4tmrXxvcXTQtYv+j8tN003ElU+0=
X-Google-Smtp-Source: AK7set/Q7jlGK3vXjv9uD8uTKZD4simHav0fWBqxTHeS+FkICYkNl6HcO+Nv1M8nFzYRti9PP7D0vWoyet3jQpLqxrE=
X-Received: by 2002:a2e:b4b2:0:b0:290:66b3:53e5 with SMTP id
 q18-20020a2eb4b2000000b0029066b353e5mr414463ljm.57.1675760976412; Tue, 07 Feb
 2023 01:09:36 -0800 (PST)
MIME-Version: 1.0
References: <20230131040355.3116-1-justin.he@arm.com> <CAMj1kXFTUXgaENBSYh+cGCS3wFCFunf+auk3nKwHVJWiZ7crig@mail.gmail.com>
 <DBBPR08MB45383B479656BA18FEFFB7D5F7D09@DBBPR08MB4538.eurprd08.prod.outlook.com>
 <Y9lchEgyNGLKu/4R@zx2c4.com> <DBBPR08MB4538E2CE68BCBF15B9F0093AF7D69@DBBPR08MB4538.eurprd08.prod.outlook.com>
 <DBBPR08MB4538A07A62DC4A10257B3277F7DB9@DBBPR08MB4538.eurprd08.prod.outlook.com>
 <CAMj1kXFE7A0=+MA2tCtuwjeGMcc1hgzvDnEJy1xGE=fh9Kgc2Q@mail.gmail.com>
 <DBBPR08MB4538E402B7DC8C747252E22FF7DB9@DBBPR08MB4538.eurprd08.prod.outlook.com>
 <CAMj1kXGKhWJii7Q7yQR9U+1F5Vo4SaVXVixNXeY4U0aZyrJBdA@mail.gmail.com>
 <DBBPR08MB453816F6266D9686CDE61F24F7DB9@DBBPR08MB4538.eurprd08.prod.outlook.com>
 <CAMj1kXFwn9epkakWBd537seUK48EfmxQz0fNi=h3L2SDTW24Bw@mail.gmail.com> <DBBPR08MB45383609E2B01955E5E0C81AF7DB9@DBBPR08MB4538.eurprd08.prod.outlook.com>
In-Reply-To: <DBBPR08MB45383609E2B01955E5E0C81AF7DB9@DBBPR08MB4538.eurprd08.prod.outlook.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 7 Feb 2023 10:09:25 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHQsbuEZbtH9XOp64BxwOroppockkEp7KhbKkWbdpExKw@mail.gmail.com>
Message-ID: <CAMj1kXHQsbuEZbtH9XOp64BxwOroppockkEp7KhbKkWbdpExKw@mail.gmail.com>
Subject: Re: [PATCH 0/2] Fix boot hang issue on Ampere Emag server
To:     Justin He <Justin.He@arm.com>
Cc:     Huacai Chen <chenhuacai@kernel.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alexandru Elisei <Alexandru.Elisei@arm.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>, nd <nd@arm.com>
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

On Tue, 7 Feb 2023 at 10:08, Justin He <Justin.He@arm.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Ard Biesheuvel <ardb@kernel.org>
> > Sent: Tuesday, February 7, 2023 5:04 PM
> > To: Justin He <Justin.He@arm.com>
> > Cc: Huacai Chen <chenhuacai@kernel.org>; linux-efi@vger.kernel.org;
> > linux-kernel@vger.kernel.org; Alexandru Elisei <Alexandru.Elisei@arm.co=
m>;
> > Jason A. Donenfeld <Jason@zx2c4.com>; nd <nd@arm.com>
> > Subject: Re: [PATCH 0/2] Fix boot hang issue on Ampere Emag server
> >
> > On Tue, 7 Feb 2023 at 10:03, Justin He <Justin.He@arm.com> wrote:
> > >
> > > Hi Ard
> > >
> > > > -----Original Message-----
> > > > From: Ard Biesheuvel <ardb@kernel.org>
> > > > Sent: Tuesday, February 7, 2023 4:54 PM
> > > > To: Justin He <Justin.He@arm.com>
> > > > Cc: Huacai Chen <chenhuacai@kernel.org>; linux-efi@vger.kernel.org;
> > > > linux-kernel@vger.kernel.org; Alexandru Elisei
> > > > <Alexandru.Elisei@arm.com>; Jason A. Donenfeld <Jason@zx2c4.com>; n=
d
> > > > <nd@arm.com>
> > > > Subject: Re: [PATCH 0/2] Fix boot hang issue on Ampere Emag server
> > > >
> > > > On Tue, 7 Feb 2023 at 09:49, Justin He <Justin.He@arm.com> wrote:
> > > > >
> > > > >
> > > > >
> > > > > > -----Original Message-----
> > > > > [..]
> > > > > > > The root cause of the hung IMO might be similar to commit
> > > > > > > 550b33cfd445296868a478e8413ffb2e963eed32
> > > > > > > Author: Ard Biesheuvel <ardb@kernel.org>
> > > > > > > Date:   Thu Nov 10 10:36:20 2022 +0100
> > > > > > >
> > > > > > >     arm64: efi: Force the use of SetVirtualAddressMap() on
> > > > > > > Altra machines
> > > > > > >
> > > > > > > Do you agree with the idea if I add Ampere =E2=80=9DeMAG=E2=
=80=9D machine into
> > > > > > > the list of Using SetVirtualAddressMap() forcibly?
> > > > > > >
> > > > > > > Please note that even in previous kernel patch, the efibootmg=
r
> > > > > > > -t
> > > > > > > 10 will make kernel hung if I passed "efi=3Dnovamap" to the b=
oot
> > > > parameter.
> > > > > > >
> > > > > >
> > > > > > Interesting. What does dmidecode return for the family in the
> > > > > > type 1
> > > > record?
> > > > >
> > > > > # dmidecode |grep -i family
> > > > >         Family: eMAG
> > > > >         Family: ARMv8
> > > > >
> > > > > The full dmidecode log is at https://pastebin.com/M3MAJtUG
> > > > >
> > > >
> > > > OK please try this:
> > > >
> > > > diff --git a/drivers/firmware/efi/libstub/arm64.c
> > > > b/drivers/firmware/efi/libstub/arm64.c
> > > > index ff2d18c42ee74979..fae930dec82be7c6 100644
> > > > --- a/drivers/firmware/efi/libstub/arm64.c
> > > > +++ b/drivers/firmware/efi/libstub/arm64.c
> > > > @@ -22,7 +22,8 @@ static bool system_needs_vamap(void)
> > > >          * Ampere Altra machines crash in SetTime() if
> > > > SetVirtualAddressMap()
> > > >          * has not been called prior.
> > > >          */
> > > > -       if (!type1_family || strcmp(type1_family, "Altra"))
> > > > +       if (!type1_family ||
> > > > +           (strcmp(type1_family, "Altra") && strcmp(type1_family,
> > > > + "eMAG")))
> > > >                 return false;
> > > >
> > > >         efi_warn("Working around broken SetVirtualAddressMap()\n");
> > >
> > > Yes, it works on my eMAG server: the kernel boots.
> > > Other than efibootmgr failure. But I noticed this efibootmgr failure
> > > even before Commit d3549a938b7 ("avoid SetVirtualAddressMap() when
> > > possible ")
> > >
> > > root@:~/linux# efibootmgr -t 9; efibootmgr -t 5; Could not set
> > > Timeout: Input/output error Could not set Timeout: Input/output error
> > >
> >
> > Do you get any [Firmware Bug] lines in the kernel log?
>
> No,
> I built the kernel based on:
> commit d2d11f342b179f1894a901f143ec7c008caba43e (HEAD -> master, origin/m=
aster, origin/HEAD)
> Author: Linus Torvalds <torvalds@linux-foundation.org>
> Date:   Sun Feb 5 17:17:10 2023 -0800
>
>     Merge branch 'fixes' of git://git.kernel.org/pub/scm/linux/kernel/git=
/viro/vfs
>
> Are you worried about your sync exception fixup patch? I think it has bee=
n included.
>


I would just like to understand why setvariable is still broken for you.
