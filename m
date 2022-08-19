Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25E035995D5
	for <lists+linux-efi@lfdr.de>; Fri, 19 Aug 2022 09:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237247AbiHSHQm (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 19 Aug 2022 03:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346992AbiHSHQk (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 19 Aug 2022 03:16:40 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94F10E341D
        for <linux-efi@vger.kernel.org>; Fri, 19 Aug 2022 00:16:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id CAC69CE2416
        for <linux-efi@vger.kernel.org>; Fri, 19 Aug 2022 07:16:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECFE3C43142
        for <linux-efi@vger.kernel.org>; Fri, 19 Aug 2022 07:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660893394;
        bh=wK/XF/F/2oIfqAatmRu9MAOiQXaBF+SFoRca/QzzhVU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Qf8I7VORalR7Q/MeO/yqh6bLYLKIQJB/dmeJpImBY0ZirfTQ/BHft9jEfFZ4435tp
         /pih1r3llw8zpYu9VC1FJTBanNkBGrJRYcdRlfgT7qA4tM3DB11j3W+bfgsCricXoE
         1Z3KFrJ8SFCdncIZJLUv/rI2tiXiqedV7ZbKhzSMn1Lnqn2TjsHvAG+UzZiOq7Jwot
         9Li4HfsIrLEDJJXMFm25H08uidf6cYJvZ15TGX1FpBHTnv0qk8y32c6LOqRsHn35nm
         1yCx09ncb54OUVKQ0lh0/F8zPqIEtlZakUoFPfoJNt4CXR3e8lPH6zZPvibB905cvN
         crvgZWIOGhHdg==
Received: by mail-wr1-f41.google.com with SMTP id h5so3342171wru.7
        for <linux-efi@vger.kernel.org>; Fri, 19 Aug 2022 00:16:33 -0700 (PDT)
X-Gm-Message-State: ACgBeo3St1hP27dIoKXteYwFOs+36ca3AUm+ei+jiF7LiQJIn3yRy54T
        4PllqugHU/iTwpQmF92I5gWmAzxDa6Uqd2ecTRQ=
X-Google-Smtp-Source: AA6agR4YxMUFB8Mh2wQONibmqrTFo5Kt/D9OYq2ZaJqwQHB+wo1l2FC9hYMF7c4Md0QVuZ4mRGyZwbGu1010D3C3m1k=
X-Received: by 2002:a5d:6d89:0:b0:225:16c2:6816 with SMTP id
 l9-20020a5d6d89000000b0022516c26816mr3407896wrs.380.1660893392125; Fri, 19
 Aug 2022 00:16:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220804030012-mutt-send-email-mst@kernel.org>
 <bfa5704d-755c-5a52-e7cc-bd9b34e5bb03@redhat.com> <YuuQb3D/YY1SiUqY@redhat.com>
 <Yuu1kX9CAqSUNNAj@zx2c4.com> <Yuu3ee1iB3IoLdZS@redhat.com>
 <CAMj1kXFAz1ttRmt5_utReSC=TjdfmrgwbwSaAZTDnx6OPGuRRg@mail.gmail.com>
 <cf60456e-a2cd-a64d-0cee-4bea30708fc9@redhat.com> <CAHmME9pUdckUwei234Xdge_G-=b6q2e9a8mTVExrV4WE=6TLig@mail.gmail.com>
 <20220816085511.nw5w3wt5vemkyryt@sirius.home.kraxel.org> <Yv5c/UMrEhTUlIID@zx2c4.com>
 <20220819064051.yopqxw3ynttnncca@sirius.home.kraxel.org>
In-Reply-To: <20220819064051.yopqxw3ynttnncca@sirius.home.kraxel.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 19 Aug 2022 09:16:20 +0200
X-Gmail-Original-Message-ID: <CAMj1kXF_ESRptjm3QmmgB6uysYfY2Pd8+jTd9Fmgf=bwhMqMyQ@mail.gmail.com>
Message-ID: <CAMj1kXF_ESRptjm3QmmgB6uysYfY2Pd8+jTd9Fmgf=bwhMqMyQ@mail.gmail.com>
Subject: Re: [PATCH v2] hw/i386: place setup_data at fixed place in memory
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Laszlo Ersek <lersek@redhat.com>,
        =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        QEMU Developers <qemu-devel@nongnu.org>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Peter Maydell <peter.maydell@linaro.org>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 19 Aug 2022 at 08:41, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> On Thu, Aug 18, 2022 at 05:38:37PM +0200, Jason A. Donenfeld wrote:
> > Hey Gerd,
> >
> > > Joining the party late (and still catching up the thread).  Given we
> > > don't need that anyway with EFI, only with legacy BIOS:  Can't that just
> > > be a protocol between qemu and pc-bios/optionrom/*boot*.S on how to pass
> > > those 48 bytes random seed?
> >
> > Actually, I want this to work with EFI, very much so.

Even if we wire this up for EFI in some way, it will only affect
direct kernel boot using -kernel/-initrd etc, which is a niche use
case at best (AIUI libvirt uses it for the initial boot only)

I personally rely on it heavily for development, and I imagine others
might too, but that is hardly relevant here.

> With EFI the kernel stub gets some random seed via EFI_RNG_PROTOCOL.
> I can't see any good reason to derive from that.  It works no matter
> how the kernel gets loaded.
>
> OVMF ships with a driver for the virtio-rng device.  So just add that
> to your virtual machine and seeding works fine ...
>

... or we find other ways for the platform to speak to the OS, using
EFI protocols or other EFI methods.

Currently, the 'pure EFI' boot code is arch agnostic - it can be built
and run on any architecture that supports EFI boot. Adding Linux+x86
specific hacks to it is out of the question.

So that means that setup_data provided by QEMU will be consumed
directly by the kernel (when doing direct kernel boot only), using an
out of band channel that EFI/OVMF are completely unaware of, putting
it outside the scope of secure boot, measure boot, etc.

This is not acceptable to me.

> > If our objective was to just not break EFI, the solution would be
> > simple: in the kernel we can have EFISTUB ignore the setup_data field
> > from the image, and then bump the boot header protocol number. If QEMU
> > sees the boot protocol number is below this one, then it won't set
> > setup_data. Done, fixed.
>
> As mentioned elsewhere in the thread patching in physical addresses on
> qemu side isn't going to fly due to the different load methods we have.
>

And it conflates the file representation with the in-memory
representation, which I object to fundamentally - setup_data is part
of the file image, and becomes part of the in-memory representation
when it gets staged in memory for booting, which only happens in the
EFI stub when using pure EFI boot.

Using setup_data as a hidden comms channel between QEMU and the core
kernel breaks that distinction.

> > Your option ROM idea is interesting; somebody mentioned that elsewhere
> > too I think.
>
> Doing the setup_data patching in the option rom has the advantage that
> it'll only happen with that specific load method being used.  Also the
> option rom knows where it places stuff in memory so it is in a much
> better position to find a good & non-conflicting place for the random
> seed.  Also reserve/allocate memory if needed etc.
>

Exactly. This is the only sensible place to do this.

> > I'm wondering, though: do option ROMs still run when
> > EFI/OVMF is being used?
>
> No, they are not used with EFI.  OVMF has a completely independent
> implementation for direct kernel boot.
>
> The options I see for EFI are:
>
>   (1) Do nothing and continue to depend on virtio-rng.
>   (2) Implement an efi driver which gets those 48 seed bytes from
>       qemu by whatever means we'll define and hands them out via
>       EFI_RNG_PROTOCOL.
>

We could explore other options, but SETUP_RNG_SEED is fundamentally
incompatible with EFI boot (or any other boot method where the image
is treated as an opaque file by the firmware/loader), so that is not
an acceptable approach to me.
