Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EA0F6B70C9
	for <lists+linux-efi@lfdr.de>; Mon, 13 Mar 2023 09:04:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbjCMIEO (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 13 Mar 2023 04:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbjCMIDw (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 13 Mar 2023 04:03:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D4A75ADD3
        for <linux-efi@vger.kernel.org>; Mon, 13 Mar 2023 01:00:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 97ED4B80E30
        for <linux-efi@vger.kernel.org>; Mon, 13 Mar 2023 07:59:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45182C4339B
        for <linux-efi@vger.kernel.org>; Mon, 13 Mar 2023 07:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678694366;
        bh=f/E1zk/mvL+tY6xYCyUcJFmKEzAoUVLSeHdrOdJ3IFk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Bs/gWjvYYQZlgy0fERaR5+ddonAG87o1+7U6BOpEhgSu4yXaVBBFmoDClATrZBSI0
         fFtsIr2o+cXkI5N+z151eid7wjfJN/xazjdN794d17C2dVT6Ip5y9pDQB+Fl9oR8q/
         ejWZ5nsUj26qqr5GNHE9iNZqQy39R4e9sxijSvKWYT76MbcAhGL3HN4WQ68X88800m
         01nGyedQ2510LP97opNg8YLB9mdGgVoXNTGDxpGS+pPeCKqVU7vNsesSFD2Ugi1xKJ
         f894NKb+kfHQZGF/1ZsXNOMnPyukOBCfo394CJ/wYiTvgxfb6mujixbWnd3OO3CbN8
         KASZULNp5N/kQ==
Received: by mail-lf1-f47.google.com with SMTP id f18so14541637lfa.3
        for <linux-efi@vger.kernel.org>; Mon, 13 Mar 2023 00:59:26 -0700 (PDT)
X-Gm-Message-State: AO0yUKUaVH8sFa8Ji0Kjy9LRAIU1e6cpio+ualIP3r+8zQIqC3OX1s75
        MGN+s9hSu4SlRusU21jy/PNsKVejU23w+0PI1ZY=
X-Google-Smtp-Source: AK7set8YW2Uh8srUYc3RGqn0w0OsuKh7Gga22egPs09G79d3N0f0Q44gfpPIpB57dl8wjMRQ9nm5z1neinzf8lBK2oo=
X-Received: by 2002:a19:f606:0:b0:4e7:ed3c:68ee with SMTP id
 x6-20020a19f606000000b004e7ed3c68eemr9578246lfe.4.1678694364291; Mon, 13 Mar
 2023 00:59:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230312225838.3702574-1-ardb@kernel.org> <CAMj1kXGeL8p5Ctg=fsCnJYqmA8NHeN9uMgO1JWVxoiyBdSau4Q@mail.gmail.com>
 <CAAhV-H6LQgEikq+E3_9sRoQzbt8jMC+LtLQ0DmLzy_nnq2jtRQ@mail.gmail.com>
In-Reply-To: <CAAhV-H6LQgEikq+E3_9sRoQzbt8jMC+LtLQ0DmLzy_nnq2jtRQ@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 13 Mar 2023 08:59:13 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGqQjgOdi1Y2Tdd6sBUFvvP=+ZrQV3PQ9+fBNyuOabZ6g@mail.gmail.com>
Message-ID: <CAMj1kXGqQjgOdi1Y2Tdd6sBUFvvP=+ZrQV3PQ9+fBNyuOabZ6g@mail.gmail.com>
Subject: Re: [PATCH] efi: libstub: Always pass screen_info via config table
To:     Huacai Chen <chenhuacai@kernel.org>
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

On Mon, 13 Mar 2023 at 08:56, Huacai Chen <chenhuacai@kernel.org> wrote:
>
> Hi, Ard,
>
> I'm a bit confused, It seems this patch cannot solve the problem
> reported in [1] for LoongArch.
> [1] https://lore.kernel.org/linux-efi/20230310021749.921041-1-chenhuacai@=
loongson.cn/
>

The intent was to always pass the screen_info contents via the
configuration table, so I am surprised that this does not work.

However, I am preparing a v2 that preserves the old behavior - I'll
send it out in a minute.

>
> On Mon, Mar 13, 2023 at 3:45=E2=80=AFPM Ard Biesheuvel <ardb@kernel.org> =
wrote:
> >
> > On Sun, 12 Mar 2023 at 23:58, Ard Biesheuvel <ardb@kernel.org> wrote:
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
> > > To fix this and simplify things at the same time, let's just always u=
se
> > > the config table method.
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
> > Please disregard - I think I can simplify this without losing the very
> > early earlycon.
> >
> >
> > > ---
> > >  arch/arm64/kernel/image-vars.h             |  1 -
> > >  arch/loongarch/kernel/image-vars.h         |  1 -
> > >  arch/riscv/kernel/image-vars.h             |  1 -
> > >  drivers/firmware/efi/libstub/efi-stub.c    |  9 ---------
> > >  drivers/firmware/efi/libstub/screen_info.c | 19 -------------------
> > >  5 files changed, 31 deletions(-)
> > >
> > > diff --git a/arch/arm64/kernel/image-vars.h b/arch/arm64/kernel/image=
-vars.h
> > > index 8309197c0ebd4a8e..01382bd99d0addea 100644
> > > --- a/arch/arm64/kernel/image-vars.h
> > > +++ b/arch/arm64/kernel/image-vars.h
> > > @@ -27,7 +27,6 @@ PROVIDE(__efistub__text                       =3D _=
text);
> > >  PROVIDE(__efistub__end                 =3D _end);
> > >  PROVIDE(__efistub___inittext_end               =3D __inittext_end);
> > >  PROVIDE(__efistub__edata               =3D _edata);
> > > -PROVIDE(__efistub_screen_info          =3D screen_info);
> > >  PROVIDE(__efistub__ctype               =3D _ctype);
> > >
> > >  PROVIDE(__pi___memcpy                  =3D __pi_memcpy);
> > > diff --git a/arch/loongarch/kernel/image-vars.h b/arch/loongarch/kern=
el/image-vars.h
> > > index e561989d02de93c5..110cdc32cba5f28b 100644
> > > --- a/arch/loongarch/kernel/image-vars.h
> > > +++ b/arch/loongarch/kernel/image-vars.h
> > > @@ -12,7 +12,6 @@ __efistub_kernel_entry                =3D kernel_en=
try;
> > >  __efistub_kernel_asize         =3D kernel_asize;
> > >  __efistub_kernel_fsize         =3D kernel_fsize;
> > >  __efistub_kernel_offset                =3D kernel_offset;
> > > -__efistub_screen_info          =3D screen_info;
> > >
> > >  #endif
> > >
> > > diff --git a/arch/riscv/kernel/image-vars.h b/arch/riscv/kernel/image=
-vars.h
> > > index 7e2962ef73f92e95..5e2515fa013495cb 100644
> > > --- a/arch/riscv/kernel/image-vars.h
> > > +++ b/arch/riscv/kernel/image-vars.h
> > > @@ -29,7 +29,6 @@ __efistub__start              =3D _start;
> > >  __efistub__start_kernel                =3D _start_kernel;
> > >  __efistub__end                 =3D _end;
> > >  __efistub__edata               =3D _edata;
> > > -__efistub_screen_info          =3D screen_info;
> > >
> > >  #endif
> > >
> > > diff --git a/drivers/firmware/efi/libstub/efi-stub.c b/drivers/firmwa=
re/efi/libstub/efi-stub.c
> > > index 2955c1ac6a36ee00..c4b9eccad0f103dc 100644
> > > --- a/drivers/firmware/efi/libstub/efi-stub.c
> > > +++ b/drivers/firmware/efi/libstub/efi-stub.c
> > > @@ -47,15 +47,6 @@
> > >  static u64 virtmap_base =3D EFI_RT_VIRTUAL_BASE;
> > >  static bool flat_va_mapping =3D (EFI_RT_VIRTUAL_OFFSET !=3D 0);
> > >
> > > -struct screen_info * __weak alloc_screen_info(void)
> > > -{
> > > -       return &screen_info;
> > > -}
> > > -
> > > -void __weak free_screen_info(struct screen_info *si)
> > > -{
> > > -}
> > > -
> > >  static struct screen_info *setup_graphics(void)
> > >  {
> > >         efi_guid_t gop_proto =3D EFI_GRAPHICS_OUTPUT_PROTOCOL_GUID;
> > > diff --git a/drivers/firmware/efi/libstub/screen_info.c b/drivers/fir=
mware/efi/libstub/screen_info.c
> > > index 8e76a8b384ba142d..7b791541a1ad1b48 100644
> > > --- a/drivers/firmware/efi/libstub/screen_info.c
> > > +++ b/drivers/firmware/efi/libstub/screen_info.c
> > > @@ -5,25 +5,6 @@
> > >
> > >  #include "efistub.h"
> > >
> > > -/*
> > > - * There are two ways of populating the core kernel's struct screen_=
info via the stub:
> > > - * - using a configuration table, like below, which relies on the EF=
I init code
> > > - *   to locate the table and copy the contents;
> > > - * - by linking directly to the core kernel's copy of the global sym=
bol.
> > > - *
> > > - * The latter is preferred because it makes the EFIFB earlycon avail=
able very
> > > - * early, but it only works if the EFI stub is part of the core kern=
el image
> > > - * itself. The zboot decompressor can only use the configuration tab=
le
> > > - * approach.
> > > - *
> > > - * In order to support both methods from the same build of the EFI s=
tub
> > > - * library, provide this dummy global definition of struct screen_in=
fo. If it
> > > - * is required to satisfy a link dependency, it means we need to ove=
rride the
> > > - * __weak alloc and free methods with the ones below, and those will=
 be pulled
> > > - * in as well.
> > > - */
> > > -struct screen_info screen_info;
> > > -
> > >  static efi_guid_t screen_info_guid =3D LINUX_EFI_SCREEN_INFO_TABLE_G=
UID;
> > >
> > >  struct screen_info *alloc_screen_info(void)
> > > --
> > > 2.39.2
> > >
> >
