Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CCDD68D1FA
	for <lists+linux-efi@lfdr.de>; Tue,  7 Feb 2023 10:04:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbjBGJEF (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 7 Feb 2023 04:04:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjBGJEE (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 7 Feb 2023 04:04:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00E042E83B;
        Tue,  7 Feb 2023 01:04:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8FF7560FF9;
        Tue,  7 Feb 2023 09:04:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F236BC433D2;
        Tue,  7 Feb 2023 09:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675760643;
        bh=GwA5gwbk8+QhblnmHKzsrENVD31MoaYxk7xIPyjNSrM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=uCSjKQ/fHbofVKESP+e8Cx7ofqCEwcai1FJx1YnZbZKMLfMNZ0UMHyDBd3h4a2VsF
         tk2ZsLZylFozZC1ggQ7xclv6Ax27fq0P1ITMkZ1LfF6JBugYavQDsCux+unA908rkE
         tjL9iuglHoZ2FJZXtEIINhPOJXZeiMjSgY7graW2MErpXDPOHmOZwVJxk+P27Ry6bN
         FB5xbxmFGekwJMgiE8aHcktV+D6cKyHq+O8htF4IZ4l62gP+lCu8xwAv79DW/a1+3K
         +jHPJIARpAfDs2DHrr4P60uTjCDT/Se1XqQFzgxxTPHblCciLV0rR8u7U88zu56klg
         iy0RMJsPicczA==
Received: by mail-lj1-f178.google.com with SMTP id u27so14769776ljo.12;
        Tue, 07 Feb 2023 01:04:02 -0800 (PST)
X-Gm-Message-State: AO0yUKXf7hhEdU3MyOW1JUHv/Tz/c+mSuu6gSapEGHvUIdAkyHu774Yy
        0B6NE2OHhTjthRpuk4qa2eEoqGzKnfTiqN7MpUg=
X-Google-Smtp-Source: AK7set/waY4dfzQ0Wr26PP1jxYSwPt25ybOikk/EckmNsv0cfe4JRILmvup1wyrLBFRS7o0Oh/BLS8cZPPQ2z+/RJMY=
X-Received: by 2002:a2e:b4b2:0:b0:290:66b3:53e5 with SMTP id
 q18-20020a2eb4b2000000b0029066b353e5mr411139ljm.57.1675760641044; Tue, 07 Feb
 2023 01:04:01 -0800 (PST)
MIME-Version: 1.0
References: <20230131040355.3116-1-justin.he@arm.com> <CAMj1kXFTUXgaENBSYh+cGCS3wFCFunf+auk3nKwHVJWiZ7crig@mail.gmail.com>
 <DBBPR08MB45383B479656BA18FEFFB7D5F7D09@DBBPR08MB4538.eurprd08.prod.outlook.com>
 <Y9lchEgyNGLKu/4R@zx2c4.com> <DBBPR08MB4538E2CE68BCBF15B9F0093AF7D69@DBBPR08MB4538.eurprd08.prod.outlook.com>
 <DBBPR08MB4538A07A62DC4A10257B3277F7DB9@DBBPR08MB4538.eurprd08.prod.outlook.com>
 <CAMj1kXFE7A0=+MA2tCtuwjeGMcc1hgzvDnEJy1xGE=fh9Kgc2Q@mail.gmail.com>
 <DBBPR08MB4538E402B7DC8C747252E22FF7DB9@DBBPR08MB4538.eurprd08.prod.outlook.com>
 <CAMj1kXGKhWJii7Q7yQR9U+1F5Vo4SaVXVixNXeY4U0aZyrJBdA@mail.gmail.com> <DBBPR08MB453816F6266D9686CDE61F24F7DB9@DBBPR08MB4538.eurprd08.prod.outlook.com>
In-Reply-To: <DBBPR08MB453816F6266D9686CDE61F24F7DB9@DBBPR08MB4538.eurprd08.prod.outlook.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 7 Feb 2023 10:03:49 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFwn9epkakWBd537seUK48EfmxQz0fNi=h3L2SDTW24Bw@mail.gmail.com>
Message-ID: <CAMj1kXFwn9epkakWBd537seUK48EfmxQz0fNi=h3L2SDTW24Bw@mail.gmail.com>
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

On Tue, 7 Feb 2023 at 10:03, Justin He <Justin.He@arm.com> wrote:
>
> Hi Ard
>
> > -----Original Message-----
> > From: Ard Biesheuvel <ardb@kernel.org>
> > Sent: Tuesday, February 7, 2023 4:54 PM
> > To: Justin He <Justin.He@arm.com>
> > Cc: Huacai Chen <chenhuacai@kernel.org>; linux-efi@vger.kernel.org;
> > linux-kernel@vger.kernel.org; Alexandru Elisei <Alexandru.Elisei@arm.co=
m>;
> > Jason A. Donenfeld <Jason@zx2c4.com>; nd <nd@arm.com>
> > Subject: Re: [PATCH 0/2] Fix boot hang issue on Ampere Emag server
> >
> > On Tue, 7 Feb 2023 at 09:49, Justin He <Justin.He@arm.com> wrote:
> > >
> > >
> > >
> > > > -----Original Message-----
> > > [..]
> > > > > The root cause of the hung IMO might be similar to commit
> > > > > 550b33cfd445296868a478e8413ffb2e963eed32
> > > > > Author: Ard Biesheuvel <ardb@kernel.org>
> > > > > Date:   Thu Nov 10 10:36:20 2022 +0100
> > > > >
> > > > >     arm64: efi: Force the use of SetVirtualAddressMap() on Altra
> > > > > machines
> > > > >
> > > > > Do you agree with the idea if I add Ampere =E2=80=9DeMAG=E2=80=9D=
 machine into the
> > > > > list of Using SetVirtualAddressMap() forcibly?
> > > > >
> > > > > Please note that even in previous kernel patch, the efibootmgr -t
> > > > > 10 will make kernel hung if I passed "efi=3Dnovamap" to the boot
> > parameter.
> > > > >
> > > >
> > > > Interesting. What does dmidecode return for the family in the type =
1
> > record?
> > >
> > > # dmidecode |grep -i family
> > >         Family: eMAG
> > >         Family: ARMv8
> > >
> > > The full dmidecode log is at https://pastebin.com/M3MAJtUG
> > >
> >
> > OK please try this:
> >
> > diff --git a/drivers/firmware/efi/libstub/arm64.c
> > b/drivers/firmware/efi/libstub/arm64.c
> > index ff2d18c42ee74979..fae930dec82be7c6 100644
> > --- a/drivers/firmware/efi/libstub/arm64.c
> > +++ b/drivers/firmware/efi/libstub/arm64.c
> > @@ -22,7 +22,8 @@ static bool system_needs_vamap(void)
> >          * Ampere Altra machines crash in SetTime() if
> > SetVirtualAddressMap()
> >          * has not been called prior.
> >          */
> > -       if (!type1_family || strcmp(type1_family, "Altra"))
> > +       if (!type1_family ||
> > +           (strcmp(type1_family, "Altra") && strcmp(type1_family,
> > + "eMAG")))
> >                 return false;
> >
> >         efi_warn("Working around broken SetVirtualAddressMap()\n");
>
> Yes, it works on my eMAG server: the kernel boots.
> Other than efibootmgr failure. But I noticed this efibootmgr failure even=
 before
> Commit d3549a938b7 ("avoid SetVirtualAddressMap() when possible ")
>
> root@:~/linux# efibootmgr -t 9; efibootmgr -t 5;
> Could not set Timeout: Input/output error
> Could not set Timeout: Input/output error
>

Do you get any [Firmware Bug] lines in the kernel log?
