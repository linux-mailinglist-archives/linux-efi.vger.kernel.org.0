Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C32D5BB70C
	for <lists+linux-efi@lfdr.de>; Sat, 17 Sep 2022 10:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbiIQIDW (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 17 Sep 2022 04:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiIQIDS (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 17 Sep 2022 04:03:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 848074BA63
        for <linux-efi@vger.kernel.org>; Sat, 17 Sep 2022 01:03:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3D866B802C3
        for <linux-efi@vger.kernel.org>; Sat, 17 Sep 2022 08:03:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8B37C433B5
        for <linux-efi@vger.kernel.org>; Sat, 17 Sep 2022 08:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663401794;
        bh=8MWqPLxycta7tKDmQhpCi+rXytPZGqnpbu/RfHFSaF0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=r6m0qqiQaI9yOp46mhoaKsYPVLf6bp2zLBiZR9kKNc7o9/lq1ofiYdzuvmz7hagQ5
         yuySXqA69fVpEOsrUlU66NatUvw8AlMlbALkZ5JvjOIS2DgpXttT3X/c3/aCV1cslU
         VCn5XBqUSDakl+AVfs3gmnfYGJBbC1dC7DlOvWOfFvnGsqsGMa0sOTL7VZD/4sIhJk
         wtD0C74EHzNLZtddi4oghQSXO227E9xq3L21fafMgB14tT5Zznakz+j7mo1Gb3zpAG
         lp9Ze5Fd2fU3TrQYq4LJwQRH65QGYwylWaKdQQP6VVpmmuxjclnszUWMUd5uQ+OiFW
         yCKz0dsS2pxsg==
Received: by mail-lj1-f181.google.com with SMTP id h3so19942230lja.1
        for <linux-efi@vger.kernel.org>; Sat, 17 Sep 2022 01:03:14 -0700 (PDT)
X-Gm-Message-State: ACrzQf3xjagLbCgm5iddKgiKoJhSpLp8bTOz2c7ZI4OpRo7G0KscKsjm
        CqE4GfDes2b57PGtHb+Jik4rlD+g78qjgaCOSJs=
X-Google-Smtp-Source: AMsMyM6VO6TctadgQr+j6O8q5pfpHZy4486aMDlGwGPZSbQmQSa8SEA7yK1XWHhp7DdXR+TokGYMk3vp+9N3TRVxwDA=
X-Received: by 2002:a05:651c:1a14:b0:26a:c8ca:7ed8 with SMTP id
 by20-20020a05651c1a1400b0026ac8ca7ed8mr2274601ljb.415.1663401792929; Sat, 17
 Sep 2022 01:03:12 -0700 (PDT)
MIME-Version: 1.0
References: <CAMj1kXHk2o2g2t34-iMawUjfJd1uCZc1QaXH90TpS54Sg6PiCQ@mail.gmail.com>
 <CAAhV-H5t0WRYqNi-jCBM0sikn9RUc88s8zLd8sKGmRvYxNFnnA@mail.gmail.com>
In-Reply-To: <CAAhV-H5t0WRYqNi-jCBM0sikn9RUc88s8zLd8sKGmRvYxNFnnA@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sat, 17 Sep 2022 10:03:01 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHLkHGSQuLTezWN9o_u5aAr1NmVWr55K9nY9=B6jreS5Q@mail.gmail.com>
Message-ID: <CAMj1kXHLkHGSQuLTezWN9o_u5aAr1NmVWr55K9nY9=B6jreS5Q@mail.gmail.com>
Subject: Re: Removing DT dependency from LoongArch EFI stub
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     Xuerui Wang <kernel@xen0n.name>,
        linux-efi <linux-efi@vger.kernel.org>, loongarch@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sat, 17 Sept 2022 at 09:59, Huacai Chen <chenhuacai@kernel.org> wrote:
>
> Hi, Ard,
>
> On Sat, Sep 17, 2022 at 2:37 AM Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > Hello,
> >
> > One of the things I didn't quite like was that LoongArch now uses
> > libfdt only because our EFI stub code depends on it. I would like to
> > fix this.
> >
> > I have pushed a branch here that implements this. Unfortunately, it
> > doesn't proceed beyond
> >
> > and I need some help debugging the error.
> >
> > EFI stub: Booting Linux Kernel...
> > EFI stub: Loaded initrd from LINUX_EFI_INITRD_MEDIA_GUID device path
> > EFI stub: Exiting boot services ...
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/commit/?h=efi-cleanups-for-v6.1
> >
> > The idea is to pass the EFI system table pointer and the command line
> > pointer directly. In previous patches, the initrd and memmap code is
> > updated so it exposes the information via configuration tables that
> > the generic code can parse.
> >
> > Any help is greatly appreciated.
> I'm sorry but I suggest keeping the current light FDT approach. Of
> course the upstream LoongArch kernel uses UEFI+ACPI, but it only
> supports high-end systems (Loongson-3A/3C CPU with LS7A chipset). In
> fact, low-end systems (Loongson-2K CPU in SoC) support is already on
> the way and target for 6.2, which uses FDT in order to share a number
> of existing drivers. Using the current approach can share lots of boot
> code for both high-end and low-end systems, and doesn't break boot
> again.
>

Ah fair enough. I didn't realize you were planning on using FDT as a
platform description.

I may still propose some enhancements that clean up the way we use FDT
in the EFI stub, but omitting it entirely is not going to be a
priority then.

Thanks,
Ard.
