Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B69A34C8C16
	for <lists+linux-efi@lfdr.de>; Tue,  1 Mar 2022 13:58:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbiCAM64 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 1 Mar 2022 07:58:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234888AbiCAM6y (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 1 Mar 2022 07:58:54 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D501015A33
        for <linux-efi@vger.kernel.org>; Tue,  1 Mar 2022 04:58:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5B31DB80ACB
        for <linux-efi@vger.kernel.org>; Tue,  1 Mar 2022 12:58:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FC2FC36AEA
        for <linux-efi@vger.kernel.org>; Tue,  1 Mar 2022 12:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646139489;
        bh=oO15uM2g5KV3kj0Wtl8vsq/R8QnLI6yfPGDIHa1QlsU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=e+9nSUG59IZvP1TnIS4v47rdQf3FUeo+ntQKnPWt77tZYv+3qsSWghumf+lpRpoZI
         Z0ZT3cJlzlW3wylH2AfJkfIId+QxTRMlz9Dy5j5Y9JxjN0hU7RWiyN98beGfGIuweX
         iJe29CdSYV+SqH/DjsYoUHBc9Eh5awhU3gHQuU1E44qY4utPsHCuL5a4IJYJnF/vHT
         nDoL19+cQe6csNtu4hwRWQsAp41Ps3USMMHQb0BoisqQsT3Go8ejUdQq62mrkWyOf3
         cxpYIMIgkZiLCgi6tI9vdR6fgwn5XMhwVSPEeubJyhOQCNvA5dj3FCfMPmDN7I6K0I
         xBe9LSJhRs7vA==
Received: by mail-yb1-f178.google.com with SMTP id b35so26949771ybi.13
        for <linux-efi@vger.kernel.org>; Tue, 01 Mar 2022 04:58:09 -0800 (PST)
X-Gm-Message-State: AOAM530Z3Enjm5p2OlHRN+SKgv43S8JUmoW81qmZo8awSol2RB4BTFjA
        Yz6S+KRq7pSOBBiFMm08t7wCmDwhU2HoM3XtggQ=
X-Google-Smtp-Source: ABdhPJw1sd1iF21JSaK7ZWYpKZfj+/6o3ZNy296RvyKCleOArEHmtluYMgFKf50xXwVhO+t5MRQHnSnraNuaTT5Nb6g=
X-Received: by 2002:a25:4214:0:b0:624:6215:4823 with SMTP id
 p20-20020a254214000000b0062462154823mr23744241yba.432.1646139488054; Tue, 01
 Mar 2022 04:58:08 -0800 (PST)
MIME-Version: 1.0
References: <894d1598-7b05-9406-5c1a-162b749bb4e8@huawei.com>
 <CAMj1kXH3p3fTF-MKqJ6TAYc3Jm0WRit8u+ugjZdr-ykAR8ahTA@mail.gmail.com> <4792d478-edea-6c72-3e08-cf2a390f5a7c@huawei.com>
In-Reply-To: <4792d478-edea-6c72-3e08-cf2a390f5a7c@huawei.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 1 Mar 2022 13:57:55 +0100
X-Gmail-Original-Message-ID: <CAMj1kXH=Sy8m_Zi5PNDqX3GQqFQdXnd1DQkxGhEeM-uovfvVLw@mail.gmail.com>
Message-ID: <CAMj1kXH=Sy8m_Zi5PNDqX3GQqFQdXnd1DQkxGhEeM-uovfvVLw@mail.gmail.com>
Subject: Re: [Question] Should retain 2M alignment if kernel image is bad
 aligned at entry or BSS overlaps?
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 1 Mar 2022 at 11:34, Kefeng Wang <wangkefeng.wang@huawei.com> wrote=
:
>
>
> On 2022/3/1 15:22, Ard Biesheuvel wrote:
> > On Tue, 1 Mar 2022 at 07:50, Kefeng Wang <wangkefeng.wang@huawei.com> w=
rote:
> >> Hi Ard=EF=BC=8CWill and all maintainer=EF=BC=8C
> >>
> >> As commit 3a262423755b ("efi/libstub: arm64: Relax 2M alignment again
> >> for relocatable kernels") saids, a relocatable image does not need to
> >> be copied to a 2M aligned offset if it was loaded on a 64k boundary
> >> (for a 4 KB granule kernel) by EFI. But if there is some FIRMWARE BUG,
> >>
> >> 1) kernel image not aligned on 64k boundary
> >> or
> >> 2) Image BSS overlaps adjacent EFI memory region
> >>
> >> When kaslr is disabled(eg, EFI_RNG_PROTOCOL unavailable), it will lead=
s
> >> KPTI forced ON after kernel image relocated, message shown below,
> >>
> >>     CPU features: kernel page table isolation forced ON by KASLR
> >>     ...
> >>     KASLR disabled due to lack of seed
> >>
> >> The KASLR don't enabled actually, and KPTI is forced enabled which cou=
ld
> >> affect performance.
> >>
> > This message is misleading. If the alignment modulo 2M !=3D 0, we still
> > have 5 bits of 'randomization', although these bits are probably
> > highly predictable on a given system.
> Yes=EF=BC=8C this kernel boot message is misleading, I am confused and fi=
nd
> commit 3a262423755b ("efi/libstub: arm64: Relax 2M alignment again for
> relocatable kernels") leads to different behavior about KPTI.

That commit log explains how we ended up forcing 2M alignment
inadvertently if the EFI_RNG_PROTOCOL was not available. If we don't
force 2M alignment, and the physical address of the kernel happens to
be misaligned modulo 2M, the resulting offset is reused for virtual
randomization as well. Hence the 5 additional bits.

Given the predictability of those bits when used on their own, we
could decide to disable KPTI in this case as well.

> >> I found commit 7c116db24d94 ("efi/libstub/arm64: Retain 2MB kernel Ima=
ge
> >> alignment if !KASLR") in v5.8, should we retain 2M alignment if kernel=
 image
> >> is bad aligned at entry or BSS overlaps?
> >>
> > Personally, I think we're doing enough already to deal with Redhat's
> > broken out-of-tree GRUB/SHIM concoction, which is the primary reason
> > for these workarounds  IIRC.
>
> Not sure about this, what's your mean is that error message is enough and
>
> no need to adjust the alignment when image with bad aligned at entry or
> BSS overlaps?
>

I am having difficulty understanding which part of the current
behavior you think is causing a problem.

In a nutshell, what the current code aims to do is to only move the
image in memory if needed, and just boot if where it was loaded by EFI
otherwise.

Reasons for moving it could be any of:
- KASLR is enabled and we have a seed
- nokaslr was passed, and we are not aligned to 2M
- we are running a 64k pages + VMAP stack build, and the image is not
aligned to 128k
- the PE/COFF loader is broken, and ignored the minimum 64k alignment
in the PE/COFF header
- the PE/COFF loader is broken, and ignored the BSS size, resulting in
an overlap with a memory region that is already in use.

As you might have guessed, my grumbling about GRUB/SHIM was in
relation to the latter 2 points - upstream GRUB does not have its own
PE/COFF loader, but SHIM/GRUB implement their own, and don't follow
the PE/COFF spec too rigorously.

> > You can already pass nokalsr on the kernel command line if you want to
> > avoid the downsides entirely, so as I understand it, this is mostly
> > about an unquantified performance gain on systems that use a broken
> > bootloader and lack the entropy source for a KASLR seed, but are not
> > able to put nokaslr on the command line?
>
> nokaslr will use 2M alignment by default, but if some board with new
> BIOS/GRUB
>
> the kaslr won't enabled unless change the grub to drop it one by one, it
> is not kind
>
> for production deployment.
>
> Do you think the following adjustment make sense or it is definitely wron=
g?
>

I can only answer this if I understand which problem it solves. Why do
you need the 2M alignment in this case?
