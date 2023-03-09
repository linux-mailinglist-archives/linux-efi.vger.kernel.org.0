Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A08046B2CA8
	for <lists+linux-efi@lfdr.de>; Thu,  9 Mar 2023 19:10:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbjCISJ6 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 9 Mar 2023 13:09:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjCISJ5 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 9 Mar 2023 13:09:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CD53E8430
        for <linux-efi@vger.kernel.org>; Thu,  9 Mar 2023 10:09:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EEA3B61C83
        for <linux-efi@vger.kernel.org>; Thu,  9 Mar 2023 18:09:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D1CDC433EF
        for <linux-efi@vger.kernel.org>; Thu,  9 Mar 2023 18:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678385394;
        bh=cAbjhqchPU+2fzN5xWEkMNOGYxmq7E1UjGbmJ5BKaWs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DA3yGVZrc5R4jDcbwk1d0b8AgVFT1G4Mg45hs4b2ANixO3Mpk0cHImD/ozRu3Aga5
         zuRKYFSJ6MW4+g4g4gv00vhr0u7LvcwEbUNKbfx8mf0JU8BCTmTYHRYJilI8E4Zclg
         UIU505z1ocyBDLmG/eLFs8evOgHk7X83onoLGlr/IotP9CQyH+Xy4Q5bi2EdImyaws
         PDUKnfCpU91eUHPHlqZ+GUlfjsmEKWaLlij56964XxT/Jl5/ucQFXfhVe980qls+hz
         xAw2H42xhGBKoK1oQ+z+jxIU3/AsGzft1mhuWLSH8mCdMft/2vDNdEeTa35LJ6YkOh
         5jImallO8qPeQ==
Received: by mail-lf1-f46.google.com with SMTP id t11so3421958lfr.1
        for <linux-efi@vger.kernel.org>; Thu, 09 Mar 2023 10:09:54 -0800 (PST)
X-Gm-Message-State: AO0yUKWzxaH8H3a0knUolnJ+zBIF2rJutWpT0VIbZyTA9kFP1B8dCmav
        f/o+xx3N+bfqjSYIdKfPQIYnKnpp7nhtEqBE9NQ=
X-Google-Smtp-Source: AK7set/swcw1VvLhcCsae4yMZBCz791OCWLmxqmHwd7Z3UtDmplUYGcD8TNdn2tNTo9/EPOSA/qlXhlwDGq9CVYv7/8=
X-Received: by 2002:ac2:4c2e:0:b0:4d5:ca32:6ae4 with SMTP id
 u14-20020ac24c2e000000b004d5ca326ae4mr6992311lfq.4.1678385392447; Thu, 09 Mar
 2023 10:09:52 -0800 (PST)
MIME-Version: 1.0
References: <20230308202209.2980947-1-ardb@kernel.org> <29877cfc0be87c081e175608003b709a@ispras.ru>
In-Reply-To: <29877cfc0be87c081e175608003b709a@ispras.ru>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 9 Mar 2023 19:09:41 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEya6xiZiccaEwDKMBhjcTF4f5DU7fA+NZHtrqDZo5_0Q@mail.gmail.com>
Message-ID: <CAMj1kXEya6xiZiccaEwDKMBhjcTF4f5DU7fA+NZHtrqDZo5_0Q@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] efi: x86: Use strict W^X mappings in PE/COFF header
To:     Evgeniy Baskov <baskov@ispras.ru>
Cc:     linux-efi@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Peter Jones <pjones@redhat.com>,
        "Limonciello, Mario" <mario.limonciello@amd.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 9 Mar 2023 at 18:59, Evgeniy Baskov <baskov@ispras.ru> wrote:
>
> On 2023-03-08 23:22, Ard Biesheuvel wrote:
> > This is a follow-up to work proposed by Evgeny to tighten memory
> > permissions used by the EFI stub and subsequently by the decompressor
> > on
> > x86.
> >
> > Instead of going out of our way to make more space in the first 500
> > bytes of the image, and relying on non-1:1 mapped sections (which is
> > risky in the context of bespoke PE loaders), these patches reorganize
> > the header so the PE header comes after the x86 setup header, and can
> > be
> > extended at will.
> >
> > I pushed a branch at [1] that combines this with v4 of Evgeny's series
> > (after some minor surgery, e.g., to reorder the text and rodata
> > sections
> > so they are contiguous)
> >
> > We might split off the rodata section as well, and give it
> > read/non-exec
> > permissions, but I'd like to discuss the approach first, and perhaps
> > get
> > some testing data points.
> >
> > Cc: Evgeniy Baskov <baskov@ispras.ru>
> > Cc: Borislav Petkov <bp@alien8.de>
> > Cc: Alexey Khoroshilov <khoroshilov@ispras.ru>
> > Cc: Peter Jones <pjones@redhat.com>
> > Cc: "Limonciello, Mario" <mario.limonciello@amd.com>
> >
> > [0]
> > https://lore.kernel.org/linux-efi/cover.1671098103.git.baskov@ispras.ru/
> > [1]
> > https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/log/?h=efi-x86-nx-v4
> >
> > Ard Biesheuvel (4):
> >   efi: x86: Use private copy of struct setup_header
> >   efi: x86: Move PE header after setup header
> >   efi: x86: Drop alignment section header flags
> >   efi: x86: Split PE/COFF .text section into .text and .data
> >
> >  arch/x86/boot/Makefile                  |  2 +-
> >  arch/x86/boot/header.S                  | 52 +++++++++-----------
> >  arch/x86/boot/setup.ld                  |  1 +
> >  arch/x86/boot/tools/build.c             | 38 +++++++++-----
> >  drivers/firmware/efi/libstub/x86-stub.c | 43 +++-------------
> >  5 files changed, 59 insertions(+), 77 deletions(-)
>
> I've quickly looked through these patches but I'll do more testing
> tomorrow.
>
> This approach seems to be better than mine if it will work. I've tried
> the similar thing but I did not think of creating the local copy of the
> bootparams and the attempt to map them did not work since the PE loader
> I am trying to get kernel booting with does not accept sections before
> the PE header. But since the bootparams is inside the padding and is
> not used, it should be fine.
>
> But this will still need more changes to work properly with stricter PE
> loaders like the one that I've mentioned in my patch series [1].
>
> The image should also have 4K aligned section virtual addresses and
> sizes
> (even on .reloc and .compat AFAIK), otherwise UEFI will ignore memory
> attributes (or refuse to load the kernel).

EDK2 works fine as is, i.e. with only .text and .data aligned to 4k
virtually, and the data size of .data aligned to 512 bytes.

ProtectUefiImageCommon - 0x3C8600C0
  - 0x0000000038777000 - 0x0000000002BC6000
SetUefiImageMemoryAttributes - 0x0000000038777000 - 0x0000000000004000
(0x0000000000004008)
SetUefiImageMemoryAttributes - 0x000000003877B000 - 0x0000000000BEE000
(0x0000000000020008)
SetUefiImageMemoryAttributes - 0x0000000039369000 - 0x0000000001FD4000
(0x0000000000004008)

> Another desired thing is
> having
> adjacent section with no padding in between them, since [1] does have a
> mode that requires sections them to be adjacent.

Does that have any basis in the PE/COFF spec?

> (SizeOfHeaders/header_size
> should also be set to the size of setup since it is also checked to be
> adjacent to the first section.)
>

Does that have any basis in the PE/COFF spec?

> I did not do the one-to-one mapping of file and virtual addresses since
> it
> would require almost 4K paddings for the auxiliary sections.
>
> [1] https://github.com/acidanthera/audk/tree/secure_pe
>

I've backpedaled a little bit from this approach (see my other comment).

If we just rip out the real mode stub, we can keep the PE header
before the setup header, and simply describe whatever comes as .text.
