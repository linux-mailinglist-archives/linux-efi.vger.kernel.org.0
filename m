Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AF766B7864
	for <lists+linux-efi@lfdr.de>; Mon, 13 Mar 2023 14:04:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbjCMNE5 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 13 Mar 2023 09:04:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbjCMNEs (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 13 Mar 2023 09:04:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40BAA664F1
        for <linux-efi@vger.kernel.org>; Mon, 13 Mar 2023 06:04:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DEE94B810DB
        for <linux-efi@vger.kernel.org>; Mon, 13 Mar 2023 13:04:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B155C433EF
        for <linux-efi@vger.kernel.org>; Mon, 13 Mar 2023 13:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678712681;
        bh=/vucZP2mPMlyumcebZ63XE2amBMJ1xmLp4/RTyYx/V4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tVYutPcJeIBuE9d1diSY4e106xtwcXBXIDj0VVjj0yVzQhOhJo1wHUkhznz1xDSS1
         Vy6nc3XfhHW1xH5IjgksLGHY72anafImyKIYDeJhbyty8L8BUQvV9IxoHhw5x/GMxL
         GQKatol787V1qijn6tndzGyC85cwC/q8O4xNTHkPHBgdnn9eoghZYN687ETG8t+BhW
         dcvazf0AEDWzmhNRi5eQ2ZFHpEbSJwhEJ0ZWXy7Lcwu8/B+Bz4I49YSt0akjJzeP+i
         o6sFBZhGREC6xZC7tEsBsBJyJ1ww63dEs8+OZnIxPei7EkvZJr/BqADbdEPZMqy3Qg
         4Eor6vR8MJRug==
Received: by mail-ed1-f41.google.com with SMTP id o12so48404657edb.9
        for <linux-efi@vger.kernel.org>; Mon, 13 Mar 2023 06:04:41 -0700 (PDT)
X-Gm-Message-State: AO0yUKUOYRSCP3I+Sj1MwHrfhvm2cub4K3gjIZVi6H++UD0E2DSYE18D
        872J3/xLtGMrPzvvdSXzIZrF3XKkQqH+O4SQ1Jw=
X-Google-Smtp-Source: AK7set+aJeCjQtASvuc4EZBXMVvJjIlJGUuQLf3YS2V04aF3+wW8e93YAMhhKb/HYNKjGN5kPj5ah7OttgULV4i+Xgc=
X-Received: by 2002:a50:8e5d:0:b0:4fc:6494:81c3 with SMTP id
 29-20020a508e5d000000b004fc649481c3mr1698511edx.1.1678712679792; Mon, 13 Mar
 2023 06:04:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230313081432.3769496-1-ardb@kernel.org> <CAMj1kXFBB9DK_zNL2h2=5-8P+VzOO=K1SgJ+07C55zbZoMHRLw@mail.gmail.com>
 <CAMj1kXGFb+0-e_t+LeRSJzqweU=SL98cfFnem625PGjjuGCv0A@mail.gmail.com>
In-Reply-To: <CAMj1kXGFb+0-e_t+LeRSJzqweU=SL98cfFnem625PGjjuGCv0A@mail.gmail.com>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Mon, 13 Mar 2023 21:04:28 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5T2iVbyUiifDG-pKHisr0HYX=tw=xDHEOn5n0Yo41eoA@mail.gmail.com>
Message-ID: <CAAhV-H5T2iVbyUiifDG-pKHisr0HYX=tw=xDHEOn5n0Yo41eoA@mail.gmail.com>
Subject: Re: [PATCH] efi: libstub: Use relocated version of kernel's struct screen_info
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, loongarch@lists.linux.dev,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Xuerui Wang <kernel@xen0n.name>,
        loongson-kernel@lists.loongnix.cn,
        Huacai Chen <chenhuacai@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi, Ard,

On Mon, Mar 13, 2023 at 6:00=E2=80=AFPM Ard Biesheuvel <ardb@kernel.org> wr=
ote:
>
> On Mon, 13 Mar 2023 at 09:48, Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > On Mon, 13 Mar 2023 at 09:14, Ard Biesheuvel <ardb@kernel.org> wrote:
> > >
> > > In some cases, we expose the kernel's struct screen_info to the EFI s=
tub
> > > directly, so it gets populated before even entering the kernel.  This
> > > means the early console is available as soon as the early param parsi=
ng
> > > happens, which is nice. It also means we need two different ways to p=
ass
> > > this information, as this trick only works if the EFI stub is baked i=
nto
> > > the core kernel image, which is not always the case.
> > >
> > > Huacai reports that the preparatory refactoring that was needed to
> > > implement this alternative method for zboot resulted in a non-functio=
nal
> > > efifb earlycon for other cases as well, due to the reordering of the
> > > kernel image relocation with the population of the screen_info struct=
,
> > > and the latter now takes place after copying the image to its new
> > > location, which means we copy the old, uninitialized state.
> > >
> > > So let's ensure that alloc_screen_info() produces the correct
> > > screen_info pointer, by keeping its relocated address in a global
> > > variable.
> > >
> > > Cc: loongarch@lists.linux.dev
> > > Cc: Xuefeng Li <lixuefeng@loongson.cn>
> > > Cc: Xuerui Wang <kernel@xen0n.name>
> > > Cc: loongson-kernel@lists.loongnix.cn
> > > Reported-by: Huacai Chen <chenhuacai@loongson.cn>
> > > Link: https://lore.kernel.org/linux-efi/20230310021749.921041-1-chenh=
uacai@loongson.cn/
> > > Fixes: 42c8ea3dca094ab8 ("efi: libstub: Factor out EFI stub entrypoin=
t into separate file")
> > > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> >
> > This is still not working :-(
> >
>
> Huacai, could you try this patch please? It is working now - I don't
> know what I did wrong before when testing it.
I've tested, it works for me.

Tested-by: Huacai Chen <chenhuacai@loongson.cn>

But I think my original patch is also OK, unless screen_info is needed
by zboot (but the earliest zboot doesn't need it).

Huacai
>
