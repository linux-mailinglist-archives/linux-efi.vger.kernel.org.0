Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A314589B86
	for <lists+linux-efi@lfdr.de>; Thu,  4 Aug 2022 14:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239700AbiHDMQk (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 4 Aug 2022 08:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234356AbiHDMQk (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 4 Aug 2022 08:16:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC69021821
        for <linux-efi@vger.kernel.org>; Thu,  4 Aug 2022 05:16:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 48A5761791
        for <linux-efi@vger.kernel.org>; Thu,  4 Aug 2022 12:16:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A78B1C433D6
        for <linux-efi@vger.kernel.org>; Thu,  4 Aug 2022 12:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659615397;
        bh=ylX5TvV3j6D/3PNgjjVFZ8XJIszfvNtpvYJyO6MWB74=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MWzg0Wn9L+HRdl6ind7nuh5aMjSbZrMFxrqCRVCDRkWPNJIyQvo4SXN59gPm3NnCj
         IPm1YTAZ0az6yN3sB7+6lAEo72rfPeLYIcPZhF/zroCfty12tcHg+jLodXX4C8YUn3
         GNT9EbT+iGKGOuuRhems+rBoNlA/RrQClTa7EHqvsmVP98J7lpq2f061RUupoBF4sj
         PQehCfB/+3JZhIBsX7LK/yDIkG6jwUOFb4aq6uNqA+/6NtN5Ozrwt0zD3kgc0pEtkH
         0gwYgYMfFTGb0KW3yDCa/xLbVN4OV9Hd43cnYXALizlOw/KN6uBcxtJ1tXcvkNEYB+
         GcJTQDjdWh/dQ==
Received: by mail-oi1-f178.google.com with SMTP id q184so4056468oif.1
        for <linux-efi@vger.kernel.org>; Thu, 04 Aug 2022 05:16:37 -0700 (PDT)
X-Gm-Message-State: ACgBeo3ZVhKrbbmqevDj7vrNaieGv34w/x6icWLTUOdH2Eee83Z8Oj7W
        DkVFi4GmBIkg8NjnCIeY1q0RISgX4hGeAe9S6Jc=
X-Google-Smtp-Source: AA6agR5imbDAqwKCycIGCGe8+Zb2VBwMHNw5iTGf+N0g6gDs/ql1UNJdZhCl7JyYPsETSPX6IXsE/0fz/UVoBvinsuE=
X-Received: by 2002:a05:6808:16ac:b0:33b:32ce:edd8 with SMTP id
 bb44-20020a05680816ac00b0033b32ceedd8mr708838oib.126.1659615396761; Thu, 04
 Aug 2022 05:16:36 -0700 (PDT)
MIME-Version: 1.0
References: <YusVVLNbLgsk49PK@zx2c4.com> <20220804004411.1343158-1-Jason@zx2c4.com>
 <20220804030012-mutt-send-email-mst@kernel.org> <bfa5704d-755c-5a52-e7cc-bd9b34e5bb03@redhat.com>
 <YuuQb3D/YY1SiUqY@redhat.com> <Yuu1kX9CAqSUNNAj@zx2c4.com> <Yuu3ee1iB3IoLdZS@redhat.com>
In-Reply-To: <Yuu3ee1iB3IoLdZS@redhat.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 4 Aug 2022 14:16:25 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFAz1ttRmt5_utReSC=TjdfmrgwbwSaAZTDnx6OPGuRRg@mail.gmail.com>
Message-ID: <CAMj1kXFAz1ttRmt5_utReSC=TjdfmrgwbwSaAZTDnx6OPGuRRg@mail.gmail.com>
Subject: Re: [PATCH v2] hw/i386: place setup_data at fixed place in memory
To:     =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
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
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 4 Aug 2022 at 14:11, Daniel P. Berrang=C3=A9 <berrange@redhat.com> =
wrote:
>
> On Thu, Aug 04, 2022 at 02:03:29PM +0200, Jason A. Donenfeld wrote:
> > Hi Daniel,
> >
> > On Thu, Aug 04, 2022 at 10:25:36AM +0100, Daniel P. Berrang=C3=A9 wrote=
:
> > > Yep, and ultimately the inability to distinguish UEFI vs other firmwa=
re
> > > is arguably correct by design, as the QEMU <-> firmware interface is
> > > supposed to be arbitrarily pluggable for any firmware implementation
> > > not  limited to merely UEFI + seabios.
> >
> > Indeed, I agree with this.
> >
> > >
> > > > For now I suggest either reverting the original patch, or at least =
not
> > > > enabling the knob by default for any machine types. In particular, =
when
> > > > using MicroVM, the user must leave the knob disabled when direct bo=
oting
> > > > a kernel on OVMF, and the user may or may not enable the knob when
> > > > direct booting a kernel on SeaBIOS.
> > >
> > > Having it opt-in via a knob would defeat Jason's goal of having the s=
eed
> > > available automatically.
> >
> > Yes, adding a knob is absolutely out of the question.
> >
> > It also doesn't actually solve the problem: this triggers when QEMU
> > passes a DTB too. It's not just for the new RNG seed thing. This bug
> > isn't new.
>
> In the other thread I also mentioned that this RNG Seed addition has
> caused a bug with AMD SEV too, making boot measurement attestation
> fail because the kernel blob passed to the firmware no longer matches
> what the tenant expects, due to the injected seed.
>

I was actually expecting this to be an issue in the
signing/attestation department as well, and you just confirmed my
suspicion.

But does this mean that populating the setup_data pointer is out of
the question altogether? Or only that putting the setup_data linked
list nodes inside the image is a problem?
