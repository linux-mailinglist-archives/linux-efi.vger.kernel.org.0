Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9021558AF45
	for <lists+linux-efi@lfdr.de>; Fri,  5 Aug 2022 19:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241448AbiHER4f (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 5 Aug 2022 13:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241482AbiHER4e (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 5 Aug 2022 13:56:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14B1211A06
        for <linux-efi@vger.kernel.org>; Fri,  5 Aug 2022 10:56:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8C7A66191C
        for <linux-efi@vger.kernel.org>; Fri,  5 Aug 2022 17:56:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1735C43141
        for <linux-efi@vger.kernel.org>; Fri,  5 Aug 2022 17:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659722192;
        bh=YhasxSDyI4slT9TaDXzSb4BbP4M3MtpH6v54pjBX2W4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=duHRYD9VmqQD3wVmUH2SBvfZxofkwLrKk4e+lCrY9jUlA+2zrisMpIEN7+y0Xproq
         HQnYM3LPKgiZ+qvlbbRXC14c3ztjNJoidXfw/wBTKIKqyjfbcL1IiSEcRnnXfHaV39
         2vjPxJhryOd9dOPpflTRgjMxegazIgg1LT0s3MhYR9ckEnHWoq3tOA2V0RKTgJwhbh
         hHGY42IYzVbwNn51azIjGXum9e6svQi9YhzbdCIWQWoEKjPAEkoyoAJuIYMzEIBERm
         Gjd1AsyJnr3wyumZyvZQ2ubO5pQRbVxDUxxtV2qt2zX6vDnH2XUSRGpARAKXcfDLfs
         g10hGwDuZPsxA==
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-10ea7d8fbf7so3697534fac.7
        for <linux-efi@vger.kernel.org>; Fri, 05 Aug 2022 10:56:31 -0700 (PDT)
X-Gm-Message-State: ACgBeo3vpbpMo0gLOte6pvgIiKoUP0i3uQzHeDuSB6hN1MTfavbZD6wu
        e9U0TsiNjzBJF2cbsvqnLoJbp0qhdhboKrrOdxE=
X-Google-Smtp-Source: AA6agR6oRpwKgaz40rV0PVZGx2D8+KdCC17YSjJKY2v1+hdVsQkJwoCMtY/US6zKxUSkFVTk/Yo0Hjk0eePeoLuFw1k=
X-Received: by 2002:a05:6870:a90a:b0:10d:9e83:98a6 with SMTP id
 eq10-20020a056870a90a00b0010d9e8398a6mr6781986oab.228.1659722191032; Fri, 05
 Aug 2022 10:56:31 -0700 (PDT)
MIME-Version: 1.0
References: <YuxOgtykRQb1HU3e@zx2c4.com> <20220804230411.17720-1-Jason@zx2c4.com>
 <40fdfb11-1e40-a36a-d3a4-fcbef546a78a@redhat.com> <CAMj1kXFDs8HCCCcVAVwjLcATh6MYcUSAha5yvi0ftMw+Ddy_Xg@mail.gmail.com>
 <0bd57fab-836b-9898-9e3f-84dc66eca175@redhat.com>
In-Reply-To: <0bd57fab-836b-9898-9e3f-84dc66eca175@redhat.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 5 Aug 2022 19:56:20 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEmsDjStijJciuWjmugqAm8yvX_qihyg1Uah=V56mg2Bg@mail.gmail.com>
Message-ID: <CAMj1kXEmsDjStijJciuWjmugqAm8yvX_qihyg1Uah=V56mg2Bg@mail.gmail.com>
Subject: Re: [PATCH v3] hw/i386: place setup_data at fixed place in memory
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        QEMU Developers <qemu-devel@nongnu.org>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Peter Maydell <peter.maydell@linaro.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Laszlo Ersek <lersek@redhat.com>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 5 Aug 2022 at 19:29, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 8/5/22 13:08, Ard Biesheuvel wrote:
> >>
> >> Does it work to place setup_data at the end of the cmdline file instead
> >> of having it at the end of the kernel file?  This way the first item
> >> will be at 0x20000 + cmdline_size.
> >>
> > Does QEMU always allocate the command line statically like that?
> > AFAIK, OVMF never accesses that memory to read the command line, it
> > uses fw_cfg to copy it into a buffer it allocates itself. And I guess
> > that implies that this region could be clobbered by OVMF unless it is
> > told to preserve it.
>
> No it's not. :(  It also goes to gBS->AllocatePages in the end.
>
> At this point it seems to me that without extra changes the whole
> setup_data concept is dead on arrival for OVMF.  In principle there's no
> reason why the individual setup_data items couldn't include interior
> pointers, meaning that the setup_data _has_ to be at the address
> provided in fw_cfg by QEMU.
>

AIUI, the setup_data nodes are appended at the end, so they are not
covered by the setup_data fw_cfg file but the kernel one.

> One way to "fix" it would be for OVMF to overwrite the pointer to the
> head of the list, so that the kernel ignores the setup data provided by
> QEMU. Another way would be to put it in the command line fw_cfg blob and
> teach OVMF to use a fixed address for the command line.  Both are ugly,
> and both are also broken for new QEMU / old OVMF.
>

This is the 'pure EFI' boot path in OVMF, which means that the
firmware does not rely on definitions of struct bootparams or struct
setup_header at all. Introducing that dependency just for this is
something I'd really prefer to avoid.

> In any case, I don't think this should be fixed so close to the release.
>   We have two possibilities:
>
> 1) if we believe "build setup_data in QEMU" is a feasible design that
> only needs more yak shaving, we can keep the code in, but disabled by
> default, and sort it out in 7.2.
>

As I argued before, conflating the 'file' representation with the
'memory' representation like this is fundamentally flawed. fw_cfg
happily DMA's those files anywhere you like, so their contents should
not be position dependent like this.

So Jason's fix gets us halfway there, although we now pass information
to the kernel that is not covered by signatures or measurements, where
the setup_data pointer itself is. This means you can replace a single
SETUP_RNG_SEED node in memory with a whole set of SETUP_xxx nodes that
might be rigged to manipulate the boot in a way that measured boot
won't detect.

This is perhaps a bit of a stretch, and arguably only a problem if
secure or measured boot are enabled to begin with, in which case we
could impose additional policy on the use of setup_data. But still ...

> 2) if we go for an alternative design, it needs to be reverted.  For
> example the randomness could be in _another_ fw_cfg file, and the
> linuxboot DMA can patch it in the setup_data.
>
>
> With (2) the OVMF breakage would be limited to -dtb, which more or less
> nobody cares about, and we can just look the other way.
>
> Paolo
