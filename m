Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D75DC5996C5
	for <lists+linux-efi@lfdr.de>; Fri, 19 Aug 2022 10:18:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347458AbiHSIKJ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 19 Aug 2022 04:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347314AbiHSIKH (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 19 Aug 2022 04:10:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57072BD29E
        for <linux-efi@vger.kernel.org>; Fri, 19 Aug 2022 01:10:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E04BE616A9
        for <linux-efi@vger.kernel.org>; Fri, 19 Aug 2022 08:10:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 479E0C43144
        for <linux-efi@vger.kernel.org>; Fri, 19 Aug 2022 08:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660896605;
        bh=95wqt86tm3h7Pj8LxV6Oq1W2YFp1L0/ZkBucaO1XXuw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XG1IyrSe7hR5unp6f0Bu5HU5io9TpVdgMEYVoZfNUXvTIOo5lHntNpR4griFjuiD4
         4O90cHc5mHaRPeLWWiaG7h5V2vkgPXHkhhsG0A/IlkA0RrHk7GUEwVJF28G1Chr82D
         wlNly9PR8LvEVABR+BJtaXef7xKzylYOebUZpUm41UqUS1afqM0HOBCz+suxSfMllb
         o6uI6EcVuTfWMXpVn1y7L9brcxGYGpVQv5BAP9mHI+G7YgdEwuW6NmjQHp71WqYY97
         WRBvBTRkduiVar+jcJdWNjJArmc9nbnATtKyUp/XD78iK3pjI3Z5KyxPMIVK68l2DC
         9aYrb5xp/QU+A==
Received: by mail-wm1-f41.google.com with SMTP id k6-20020a05600c1c8600b003a54ecc62f6so2100801wms.5
        for <linux-efi@vger.kernel.org>; Fri, 19 Aug 2022 01:10:05 -0700 (PDT)
X-Gm-Message-State: ACgBeo3hn3p/9I9m1Dc6nT7WjWGmJ1pG6IQp/7NdStXmx3P0YV3c4dyH
        se2vIp2LOc0BRpWB85dG4w2Bg01HatkB7qiT2OM=
X-Google-Smtp-Source: AA6agR7jIOn4FWn0CDfM2O/iXX5udLrrXlmfVLuNZ+TJIXC83aXglPRx+bxGjFYFZhIbQKqQg22RX67eI7bS4jiUjEo=
X-Received: by 2002:a7b:c84c:0:b0:3a5:dde3:2a9e with SMTP id
 c12-20020a7bc84c000000b003a5dde32a9emr7574307wml.84.1660896603348; Fri, 19
 Aug 2022 01:10:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220817110345.1771267-1-ardb@kernel.org> <20220817110345.1771267-5-ardb@kernel.org>
 <97c62ac5-46c5-c0cd-3226-07a28051a750@canonical.com> <CAMj1kXHgnsGWscVFs_HQ_tLmoLAgcORC8k5Y0K_1m-XZWsxqMg@mail.gmail.com>
 <f0660f09-94e6-3268-dc95-cb81d9c6f58a@canonical.com> <CAMj1kXFkDo7zHJ2csfRQpeXTWN2skw2yA_kso2Wu0tXQBKc=iA@mail.gmail.com>
 <607f3bb9-9d18-ba2a-3bea-88ae7be680c8@canonical.com> <CAMj1kXGchJNvsFPOW-_W1KgozSyyT_vE=PQiJmRH6NE3wbC7CA@mail.gmail.com>
 <2f741514-0791-6e82-d51c-f1a800f260f7@canonical.com>
In-Reply-To: <2f741514-0791-6e82-d51c-f1a800f260f7@canonical.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 19 Aug 2022 10:09:51 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGv_RUOoGwr=Ka-dV2iA8Dc=ugXVjuk+FG9gpfVpjm2yA@mail.gmail.com>
Message-ID: <CAMj1kXGv_RUOoGwr=Ka-dV2iA8Dc=ugXVjuk+FG9gpfVpjm2yA@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] efi/libstub: implement generic EFI zboot
To:     Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc:     "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Peter Jones <pjones@redhat.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Atish Patra <atishp@atishpatra.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Lennart Poettering <lennart@poettering.net>,
        Jeremy Linton <jeremy.linton@arm.com>,
        linux-efi@vger.kernel.org
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

On Fri, 19 Aug 2022 at 09:41, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> On 8/19/22 09:07, Ard Biesheuvel wrote:
> > On Fri, 19 Aug 2022 at 09:01, Heinrich Schuchardt
> > <heinrich.schuchardt@canonical.com> wrote:
> >>
> >> On 8/19/22 08:52, Ard Biesheuvel wrote:
> >>> On Fri, 19 Aug 2022 at 07:29, Heinrich Schuchardt
> >>> <heinrich.schuchardt@canonical.com> wrote:
> >>>>
> >>>>
> >>>>
> >>>> On 8/18/22 19:10, Ard Biesheuvel wrote:
...
> >>>>> What we could do is define a vendor GUID for the decompressed kernel,
> >>>>> and create a device path for it. That way, you can grab the
> >>>>> loaded_image of the parent to obtain this information.
> >>>>>
> >>>>> What did you have in mind as a use case?
> >>>>
> >>>> The device-path could be used in the kernel log.
> >>>>
> >>>> It can be used to find the device or folder with initrd where we use
> >>>> initrd= on the command line.
> >>>>
> >>>> You could use the device path to access the original file, e.g. to read
> >>>> additional information.
> >>>>
> >>>> For all use cases you would want to have the original device path.
> >>>>
> >>>
> >>> What we could do is:
> >>>
> >>> - define a device path in the decompressor, e.g.,
> >>>
> >>> <original device path>/Offset(<start>, <end>)/VendorMedia(xxx-xxx-xxx,
> >>> <compression type>)
> >>>
> >>> where start, end and compression type describe the compressed payload
> >>> inside the decompressor executable. (The compression type could be
> >>> omitted, or could be a separate node.)
> >>>
> >>> - install the LoadFile2 protocol and the device path protocol onto a
> >>> handle, and move the decompression logic into the LoadFile2
> >>> implementation
>
> Why would you create a LoadFile2 implementation if the decompressor is
> the only user? In this case I think an internal function call is more
> adequate.
>

You argued that you would want to access the original file, no? When
using the SourceBuffer argument to LoadImage(), the original data is
gone. When you pass a LoadFile2 protocol, you can use the device path
to reload the data (compressed or uncompressed) as needed.

> A LoadFile2 protocol would make sense if the compressed image contains
> both a compressed kernel and the initrd and you wanted to provide the
> initrd via the LoadFile2 protocol.
>

The initrd loading is a completely separate issue, and the fact that
we might use LoadFile2 for both is just a coincidence.

> For Iot use cases it would make sense to have a standalone process which
> you can use to:
>
> * compress a kernel
> * create a binary containing
> * * a prepended decompressor binary
> * * the compressed kernel
> * * an optional initrd
> * * an optional device-tree
> * sign the complete file
>
> At runtime the decompressor would:
>
> * decompress the kernel
> * create a LoadFile2 protocol for the initrd
> * call the firmware to fix-up the device-tree
> * install the fixed-up device-tree
> * invoke the EFI stub of the kernel
>
> This way we could have one binary where all relevant components are
> inside a single signed image.
>

The only generic and portable way to move data into memory and execute
it as code is using LoadImage/StartImage. Everything else is a hack,
and hacks are notoriously non-portable between architectures and
firmware implementations.

This means the 'inner' executable *must* be invoked using
LoadImage/StartImage, which implies it must be signed if secure boot
is enabled.

Fixing up the device tree is tied to specific architectures, and the
notion that the OS should be involved in poking the firmware at the
right time to fix it up is also highly arch dependent. Which means it
does not belong in a generic EFI decompressor either.

What you are describing is essentially the systemd-stub, which also
omits LoadImage/StartImage, which means it has to parse the PE/COFF
image, load the sections, apply the relocations, etc etc, all of which
it surely got correct right off the bat ...

The reason I am so adamant about this is that we are digging ourselves
into a hole here, and the more instances we add of this pattern, the
more difficult it is to reason about it, and to fix it when things
break.

Shim should not need to exist, but we all know it has to. But ideally,
it would only hook LoadImage/StartImage to interpose its own
implementations, leaving subsequent stages none the wiser. I
personally find it very disappointing that distro GRUB cannot work
without shim even if the distro's signing key is in db - this is a
missed opportunity imo.

But if we repeat this pattern at every level above it, (i.e., open
code PE app launch to avoid using LoadImage/StartImage), reasoning
about secure boot and measured boot becomes very difficult, and every
stage needs to invoke the TCG protocols directly etc etc
