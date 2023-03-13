Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B5016B7867
	for <lists+linux-efi@lfdr.de>; Mon, 13 Mar 2023 14:06:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbjCMNGm (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 13 Mar 2023 09:06:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbjCMNGl (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 13 Mar 2023 09:06:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5F076A052
        for <linux-efi@vger.kernel.org>; Mon, 13 Mar 2023 06:06:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 34C61612A0
        for <linux-efi@vger.kernel.org>; Mon, 13 Mar 2023 13:06:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9416DC4339B
        for <linux-efi@vger.kernel.org>; Mon, 13 Mar 2023 13:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678712799;
        bh=L3FchjpA4bzV2jLAWJH8Wp61+XGYw1QIBcOo8caSDTA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RE180UruhAMM8UVop5oq7pUX2p1H2MGkovBvw465HfPtLhxDcyQu6/pnT2XihIQTG
         zBxDLHiuukzCbwsWcwosjd1bM/RRtAAT+/csd36Sq9/DP662E/JJ1pp4I07VL7H3cc
         zAZ/qVZufBP6wf9BNFgVpW60BwkE3ZzWCxeifBl03PZj6hmurVP0GPEnWdCwfaEU1a
         tMRypFIcVZUreMsY1rWuO4rlyp3Xdkb0yKRi9veySmCsn1PqHU5pwUnza0Mc0jr9DN
         JjrLG7ez0kePG+m/o9P6dQvW7IPc8w+sff+auXw8YY1flXxEZEn8CBW3lvsvuRg0Tl
         jgZwuKo695wXQ==
Received: by mail-lj1-f175.google.com with SMTP id b13so12555699ljf.6
        for <linux-efi@vger.kernel.org>; Mon, 13 Mar 2023 06:06:39 -0700 (PDT)
X-Gm-Message-State: AO0yUKW0VoJXNggEqN7gGDAgwC86FGrwrv9YfxDdxwkCMBXrpQ6wzuWL
        x7kI6mfOt0NcVkxSqqNpRHp5HpI40ENIOCK/yqI=
X-Google-Smtp-Source: AK7set80TmZun/vd7+zl0tCuFtzAxhkFbzEVviN9pg23pWXnEufAw1vsQxylT/+SPSZUFuQO5irRffkrDzuCe8AMAZk=
X-Received: by 2002:a2e:a268:0:b0:295:ba26:8ad4 with SMTP id
 k8-20020a2ea268000000b00295ba268ad4mr10600967ljm.2.1678712797622; Mon, 13 Mar
 2023 06:06:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230313081432.3769496-1-ardb@kernel.org> <CAMj1kXFBB9DK_zNL2h2=5-8P+VzOO=K1SgJ+07C55zbZoMHRLw@mail.gmail.com>
 <CAMj1kXGFb+0-e_t+LeRSJzqweU=SL98cfFnem625PGjjuGCv0A@mail.gmail.com> <CAAhV-H5T2iVbyUiifDG-pKHisr0HYX=tw=xDHEOn5n0Yo41eoA@mail.gmail.com>
In-Reply-To: <CAAhV-H5T2iVbyUiifDG-pKHisr0HYX=tw=xDHEOn5n0Yo41eoA@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 13 Mar 2023 14:06:26 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEbsCPNWWv9a_aAT3hqxyMH=rt=vzvYvVG0JJpAL4rVsA@mail.gmail.com>
Message-ID: <CAMj1kXEbsCPNWWv9a_aAT3hqxyMH=rt=vzvYvVG0JJpAL4rVsA@mail.gmail.com>
Subject: Re: [PATCH] efi: libstub: Use relocated version of kernel's struct screen_info
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     linux-efi@vger.kernel.org, loongarch@lists.linux.dev,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Xuerui Wang <kernel@xen0n.name>,
        loongson-kernel@lists.loongnix.cn,
        Huacai Chen <chenhuacai@loongson.cn>
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

On Mon, 13 Mar 2023 at 14:04, Huacai Chen <chenhuacai@kernel.org> wrote:
>
> Hi, Ard,
>
> On Mon, Mar 13, 2023 at 6:00=E2=80=AFPM Ard Biesheuvel <ardb@kernel.org> =
wrote:
> >
> > On Mon, 13 Mar 2023 at 09:48, Ard Biesheuvel <ardb@kernel.org> wrote:
> > >
> > > On Mon, 13 Mar 2023 at 09:14, Ard Biesheuvel <ardb@kernel.org> wrote:
> > > >
> > > > In some cases, we expose the kernel's struct screen_info to the EFI=
 stub
> > > > directly, so it gets populated before even entering the kernel.  Th=
is
> > > > means the early console is available as soon as the early param par=
sing
> > > > happens, which is nice. It also means we need two different ways to=
 pass
> > > > this information, as this trick only works if the EFI stub is baked=
 into
> > > > the core kernel image, which is not always the case.
> > > >
> > > > Huacai reports that the preparatory refactoring that was needed to
> > > > implement this alternative method for zboot resulted in a non-funct=
ional
> > > > efifb earlycon for other cases as well, due to the reordering of th=
e
> > > > kernel image relocation with the population of the screen_info stru=
ct,
> > > > and the latter now takes place after copying the image to its new
> > > > location, which means we copy the old, uninitialized state.
> > > >
> > > > So let's ensure that alloc_screen_info() produces the correct
> > > > screen_info pointer, by keeping its relocated address in a global
> > > > variable.
> > > >
> > > > Cc: loongarch@lists.linux.dev
> > > > Cc: Xuefeng Li <lixuefeng@loongson.cn>
> > > > Cc: Xuerui Wang <kernel@xen0n.name>
> > > > Cc: loongson-kernel@lists.loongnix.cn
> > > > Reported-by: Huacai Chen <chenhuacai@loongson.cn>
> > > > Link: https://lore.kernel.org/linux-efi/20230310021749.921041-1-che=
nhuacai@loongson.cn/
> > > > Fixes: 42c8ea3dca094ab8 ("efi: libstub: Factor out EFI stub entrypo=
int into separate file")
> > > > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > >
> > > This is still not working :-(
> > >
> >
> > Huacai, could you try this patch please? It is working now - I don't
> > know what I did wrong before when testing it.
> I've tested, it works for me.
>
> Tested-by: Huacai Chen <chenhuacai@loongson.cn>
>
> But I think my original patch is also OK, unless screen_info is needed
> by zboot (but the earliest zboot doesn't need it).
>

Thanks.

zboot does need it, otherwise the EFI framebuffer does not work at all.
