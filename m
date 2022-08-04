Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C951E589BB1
	for <lists+linux-efi@lfdr.de>; Thu,  4 Aug 2022 14:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239557AbiHDM3M (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 4 Aug 2022 08:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234364AbiHDM3L (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 4 Aug 2022 08:29:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABC9322BD3
        for <linux-efi@vger.kernel.org>; Thu,  4 Aug 2022 05:29:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5D495B82520
        for <linux-efi@vger.kernel.org>; Thu,  4 Aug 2022 12:29:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FF4AC433D7
        for <linux-efi@vger.kernel.org>; Thu,  4 Aug 2022 12:29:06 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="jkmvqQc3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1659616144;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+ft9Y9up8afZChbanOQ0TxRBUYYC/I7vBKGIHBhadLI=;
        b=jkmvqQc3zGOknN3pTjqTnyqVV2PAKAu1NvInyCyTdHjuNhK2RyVkO6B+ijL950agT5mh/b
        yC5mHRoUHI3FONiFz4YrC0woWYd7dKPE+qyfHEdAl/FqsdBAs80TJ6788P1HAuwvDieTe0
        OhhHkx+PPdNbMdbUrn+jyAqbsmTYOGs=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id b793edd4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <linux-efi@vger.kernel.org>;
        Thu, 4 Aug 2022 12:29:03 +0000 (UTC)
Received: by mail-yb1-f179.google.com with SMTP id 204so31598418yba.1
        for <linux-efi@vger.kernel.org>; Thu, 04 Aug 2022 05:29:03 -0700 (PDT)
X-Gm-Message-State: ACgBeo2a1GKLpPvC/fZgzVuHXtvLaCx4pyN63AjFDpn+6nTRwv2Q9wcx
        kN46iFOv2qxFqOXBiOIFfEUa/HgE0yIpVjBqpBc=
X-Google-Smtp-Source: AA6agR6i3ys/JUEM1mdrypNwZ9jCOrBJCbhPYQNvbb/8Ru3K4uow+R3grsefYCWOI4plIOWnZNJVS/gTNAhHV2KW3dc=
X-Received: by 2002:a05:6902:100a:b0:676:ed53:25b0 with SMTP id
 w10-20020a056902100a00b00676ed5325b0mr1097920ybt.365.1659616142360; Thu, 04
 Aug 2022 05:29:02 -0700 (PDT)
MIME-Version: 1.0
References: <YusVVLNbLgsk49PK@zx2c4.com> <20220804004411.1343158-1-Jason@zx2c4.com>
 <20220804030012-mutt-send-email-mst@kernel.org> <bfa5704d-755c-5a52-e7cc-bd9b34e5bb03@redhat.com>
 <YuuQb3D/YY1SiUqY@redhat.com> <Yuu1kX9CAqSUNNAj@zx2c4.com>
 <Yuu3ee1iB3IoLdZS@redhat.com> <CAMj1kXFAz1ttRmt5_utReSC=TjdfmrgwbwSaAZTDnx6OPGuRRg@mail.gmail.com>
 <CAHmME9pxrFpGWXiubxU9r2sDMV-P+QuDiZvw4OaSZvWOkDbyTA@mail.gmail.com>
In-Reply-To: <CAHmME9pxrFpGWXiubxU9r2sDMV-P+QuDiZvw4OaSZvWOkDbyTA@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Thu, 4 Aug 2022 14:28:51 +0200
X-Gmail-Original-Message-ID: <CAHmME9pydxka29rQp_o4Sqss_+4VGMj09F_JACxAFMaq9sM36g@mail.gmail.com>
Message-ID: <CAHmME9pydxka29rQp_o4Sqss_+4VGMj09F_JACxAFMaq9sM36g@mail.gmail.com>
Subject: Re: [PATCH v2] hw/i386: place setup_data at fixed place in memory
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
        Laszlo Ersek <lersek@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        QEMU Developers <qemu-devel@nongnu.org>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Peter Maydell <peter.maydell@linaro.org>,
        Gerd Hoffmann <kraxel@redhat.com>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Aug 4, 2022 at 2:17 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> Hi Ard,
>
> On Thu, Aug 4, 2022 at 2:16 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > On Thu, 4 Aug 2022 at 14:11, Daniel P. Berrang=C3=A9 <berrange@redhat.c=
om> wrote:
> > >
> > > On Thu, Aug 04, 2022 at 02:03:29PM +0200, Jason A. Donenfeld wrote:
> > > > Hi Daniel,
> > > >
> > > > On Thu, Aug 04, 2022 at 10:25:36AM +0100, Daniel P. Berrang=C3=A9 w=
rote:
> > > > > Yep, and ultimately the inability to distinguish UEFI vs other fi=
rmware
> > > > > is arguably correct by design, as the QEMU <-> firmware interface=
 is
> > > > > supposed to be arbitrarily pluggable for any firmware implementat=
ion
> > > > > not  limited to merely UEFI + seabios.
> > > >
> > > > Indeed, I agree with this.
> > > >
> > > > >
> > > > > > For now I suggest either reverting the original patch, or at le=
ast not
> > > > > > enabling the knob by default for any machine types. In particul=
ar, when
> > > > > > using MicroVM, the user must leave the knob disabled when direc=
t booting
> > > > > > a kernel on OVMF, and the user may or may not enable the knob w=
hen
> > > > > > direct booting a kernel on SeaBIOS.
> > > > >
> > > > > Having it opt-in via a knob would defeat Jason's goal of having t=
he seed
> > > > > available automatically.
> > > >
> > > > Yes, adding a knob is absolutely out of the question.
> > > >
> > > > It also doesn't actually solve the problem: this triggers when QEMU
> > > > passes a DTB too. It's not just for the new RNG seed thing. This bu=
g
> > > > isn't new.
> > >
> > > In the other thread I also mentioned that this RNG Seed addition has
> > > caused a bug with AMD SEV too, making boot measurement attestation
> > > fail because the kernel blob passed to the firmware no longer matches
> > > what the tenant expects, due to the injected seed.
> > >
> >
> > I was actually expecting this to be an issue in the
> > signing/attestation department as well, and you just confirmed my
> > suspicion.
> >
> > But does this mean that populating the setup_data pointer is out of
> > the question altogether? Or only that putting the setup_data linked
> > list nodes inside the image is a problem?
>
> If you look at the v2 patch, populating boot_param->setup_data winds
> up being a fixed value. So even if that part was a problem (though I
> don't think it is), it won't be with the v2 patch, since it's always
> the same.

Actually, `setup` isn't even modified if SEV is being used anyway. So
really, the approach of this v2 -- of not modifying the kernel image
-- should fix that issue, no matter what.

Jason
