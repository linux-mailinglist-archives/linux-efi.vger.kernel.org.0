Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AEC96B70C1
	for <lists+linux-efi@lfdr.de>; Mon, 13 Mar 2023 09:01:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbjCMIBJ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 13 Mar 2023 04:01:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbjCMIAo (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 13 Mar 2023 04:00:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E787C144
        for <linux-efi@vger.kernel.org>; Mon, 13 Mar 2023 00:58:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D78F46113C
        for <linux-efi@vger.kernel.org>; Mon, 13 Mar 2023 07:56:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F00DC433A0
        for <linux-efi@vger.kernel.org>; Mon, 13 Mar 2023 07:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678694216;
        bh=vYFBn90YjrLJTrfF1CgtndynVuTjsbEmXV54xRsm9fQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BI+SZpXM39jZuG+hTALx3QdomEbkzK/rOMaGDSGYwROrHIwduCLkIuu7Sq+CSu8OO
         erluSFPLScb+9WyARw9wRWBm+Tsn92H4zfugSiTPOsaaKCSmGZftC99FcR6pZSFo4g
         zUYWiYC3BgtprwbDOQw4crRolGdyXVT7vaR1DcdxWaMF0TsKAf52Z25DE1/QwxmkQ3
         /E2Sk3fPpBwuBdfiDlbSV09+oCjCRXJnxzcO9SkQGNgEkpsvKJgZTRHUHq/kPXX1es
         qctbmLQN68RaNMPLMKJHHT2xWdEsWtdVdPMbkFdB5Y3CrqyPgEmWmk79LyKLSsmqwm
         IWxGIashOhwVw==
Received: by mail-ed1-f45.google.com with SMTP id r15so17736579edq.11
        for <linux-efi@vger.kernel.org>; Mon, 13 Mar 2023 00:56:56 -0700 (PDT)
X-Gm-Message-State: AO0yUKW/itLxckN6pa+P9kjl2IaZIq2iVKZsKt1ijXv1oy0K9hM7SvrS
        hAtgH2HNP7IVwvU4rsrkrV0tmiGZFpTZ7oC/tJo=
X-Google-Smtp-Source: AK7set+czD8yhSuYHqcJkGtDqBmg8dfG8ZDRRF5xSq4O44ZSaVTzXgWxUbrXCRaDVhTc9XeyadVGA6Iw7Yl3uuUJdns=
X-Received: by 2002:a50:99d6:0:b0:4fc:f0b8:7da0 with SMTP id
 n22-20020a5099d6000000b004fcf0b87da0mr658912edb.1.1678694214468; Mon, 13 Mar
 2023 00:56:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230312225838.3702574-1-ardb@kernel.org> <CAMj1kXGeL8p5Ctg=fsCnJYqmA8NHeN9uMgO1JWVxoiyBdSau4Q@mail.gmail.com>
In-Reply-To: <CAMj1kXGeL8p5Ctg=fsCnJYqmA8NHeN9uMgO1JWVxoiyBdSau4Q@mail.gmail.com>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Mon, 13 Mar 2023 15:56:42 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6LQgEikq+E3_9sRoQzbt8jMC+LtLQ0DmLzy_nnq2jtRQ@mail.gmail.com>
Message-ID: <CAAhV-H6LQgEikq+E3_9sRoQzbt8jMC+LtLQ0DmLzy_nnq2jtRQ@mail.gmail.com>
Subject: Re: [PATCH] efi: libstub: Always pass screen_info via config table
To:     Ard Biesheuvel <ardb@kernel.org>
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

Hi, Ard,

I'm a bit confused, It seems this patch cannot solve the problem
reported in [1] for LoongArch.
[1] https://lore.kernel.org/linux-efi/20230310021749.921041-1-chenhuacai@lo=
ongson.cn/

Huacai

On Mon, Mar 13, 2023 at 3:45=E2=80=AFPM Ard Biesheuvel <ardb@kernel.org> wr=
ote:
>
> On Sun, 12 Mar 2023 at 23:58, Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > In some cases, we expose the kernel's struct screen_info to the EFI stu=
b
> > directly, so it gets populated before even entering the kernel.  This
> > means the early console is available as soon as the early param parsing
> > happens, which is nice. It also means we need two different ways to pas=
s
> > this information, as this trick only works if the EFI stub is baked int=
o
> > the core kernel image, which is not always the case.
> >
> > Huacai reports that the preparatory refactoring that was needed to
> > implement this alternative method for zboot resulted in a non-functiona=
l
> > efifb earlycon for other cases as well, due to the reordering of the
> > kernel image relocation with the population of the screen_info struct,
> > and the latter now takes place after copying the image to its new
> > location, which means we copy the old, uninitialized state.
> >
> > To fix this and simplify things at the same time, let's just always use
> > the config table method.
> >
> > Cc: loongarch@lists.linux.dev
> > Cc: Xuefeng Li <lixuefeng@loongson.cn>
> > Cc: Xuerui Wang <kernel@xen0n.name>
> > Cc: loongson-kernel@lists.loongnix.cn
> > Reported-by: Huacai Chen <chenhuacai@loongson.cn>
> > Link: https://lore.kernel.org/linux-efi/20230310021749.921041-1-chenhua=
cai@loongson.cn/
> > Fixes: 42c8ea3dca094ab8 ("efi: libstub: Factor out EFI stub entrypoint =
into separate file")
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
>
> Please disregard - I think I can simplify this without losing the very
> early earlycon.
>
>
> > ---
> >  arch/arm64/kernel/image-vars.h             |  1 -
> >  arch/loongarch/kernel/image-vars.h         |  1 -
> >  arch/riscv/kernel/image-vars.h             |  1 -
> >  drivers/firmware/efi/libstub/efi-stub.c    |  9 ---------
> >  drivers/firmware/efi/libstub/screen_info.c | 19 -------------------
> >  5 files changed, 31 deletions(-)
> >
> > diff --git a/arch/arm64/kernel/image-vars.h b/arch/arm64/kernel/image-v=
ars.h
> > index 8309197c0ebd4a8e..01382bd99d0addea 100644
> > --- a/arch/arm64/kernel/image-vars.h
> > +++ b/arch/arm64/kernel/image-vars.h
> > @@ -27,7 +27,6 @@ PROVIDE(__efistub__text                       =3D _te=
xt);
> >  PROVIDE(__efistub__end                 =3D _end);
> >  PROVIDE(__efistub___inittext_end               =3D __inittext_end);
> >  PROVIDE(__efistub__edata               =3D _edata);
> > -PROVIDE(__efistub_screen_info          =3D screen_info);
> >  PROVIDE(__efistub__ctype               =3D _ctype);
> >
> >  PROVIDE(__pi___memcpy                  =3D __pi_memcpy);
> > diff --git a/arch/loongarch/kernel/image-vars.h b/arch/loongarch/kernel=
/image-vars.h
> > index e561989d02de93c5..110cdc32cba5f28b 100644
> > --- a/arch/loongarch/kernel/image-vars.h
> > +++ b/arch/loongarch/kernel/image-vars.h
> > @@ -12,7 +12,6 @@ __efistub_kernel_entry                =3D kernel_entr=
y;
> >  __efistub_kernel_asize         =3D kernel_asize;
> >  __efistub_kernel_fsize         =3D kernel_fsize;
> >  __efistub_kernel_offset                =3D kernel_offset;
> > -__efistub_screen_info          =3D screen_info;
> >
> >  #endif
> >
> > diff --git a/arch/riscv/kernel/image-vars.h b/arch/riscv/kernel/image-v=
ars.h
> > index 7e2962ef73f92e95..5e2515fa013495cb 100644
> > --- a/arch/riscv/kernel/image-vars.h
> > +++ b/arch/riscv/kernel/image-vars.h
> > @@ -29,7 +29,6 @@ __efistub__start              =3D _start;
> >  __efistub__start_kernel                =3D _start_kernel;
> >  __efistub__end                 =3D _end;
> >  __efistub__edata               =3D _edata;
> > -__efistub_screen_info          =3D screen_info;
> >
> >  #endif
> >
> > diff --git a/drivers/firmware/efi/libstub/efi-stub.c b/drivers/firmware=
/efi/libstub/efi-stub.c
> > index 2955c1ac6a36ee00..c4b9eccad0f103dc 100644
> > --- a/drivers/firmware/efi/libstub/efi-stub.c
> > +++ b/drivers/firmware/efi/libstub/efi-stub.c
> > @@ -47,15 +47,6 @@
> >  static u64 virtmap_base =3D EFI_RT_VIRTUAL_BASE;
> >  static bool flat_va_mapping =3D (EFI_RT_VIRTUAL_OFFSET !=3D 0);
> >
> > -struct screen_info * __weak alloc_screen_info(void)
> > -{
> > -       return &screen_info;
> > -}
> > -
> > -void __weak free_screen_info(struct screen_info *si)
> > -{
> > -}
> > -
> >  static struct screen_info *setup_graphics(void)
> >  {
> >         efi_guid_t gop_proto =3D EFI_GRAPHICS_OUTPUT_PROTOCOL_GUID;
> > diff --git a/drivers/firmware/efi/libstub/screen_info.c b/drivers/firmw=
are/efi/libstub/screen_info.c
> > index 8e76a8b384ba142d..7b791541a1ad1b48 100644
> > --- a/drivers/firmware/efi/libstub/screen_info.c
> > +++ b/drivers/firmware/efi/libstub/screen_info.c
> > @@ -5,25 +5,6 @@
> >
> >  #include "efistub.h"
> >
> > -/*
> > - * There are two ways of populating the core kernel's struct screen_in=
fo via the stub:
> > - * - using a configuration table, like below, which relies on the EFI =
init code
> > - *   to locate the table and copy the contents;
> > - * - by linking directly to the core kernel's copy of the global symbo=
l.
> > - *
> > - * The latter is preferred because it makes the EFIFB earlycon availab=
le very
> > - * early, but it only works if the EFI stub is part of the core kernel=
 image
> > - * itself. The zboot decompressor can only use the configuration table
> > - * approach.
> > - *
> > - * In order to support both methods from the same build of the EFI stu=
b
> > - * library, provide this dummy global definition of struct screen_info=
. If it
> > - * is required to satisfy a link dependency, it means we need to overr=
ide the
> > - * __weak alloc and free methods with the ones below, and those will b=
e pulled
> > - * in as well.
> > - */
> > -struct screen_info screen_info;
> > -
> >  static efi_guid_t screen_info_guid =3D LINUX_EFI_SCREEN_INFO_TABLE_GUI=
D;
> >
> >  struct screen_info *alloc_screen_info(void)
> > --
> > 2.39.2
> >
>
