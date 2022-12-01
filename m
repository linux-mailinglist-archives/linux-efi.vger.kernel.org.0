Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8576263F978
	for <lists+linux-efi@lfdr.de>; Thu,  1 Dec 2022 21:57:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbiLAU5Q (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 1 Dec 2022 15:57:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbiLAU5P (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 1 Dec 2022 15:57:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95A26AC6D2
        for <linux-efi@vger.kernel.org>; Thu,  1 Dec 2022 12:57:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3AB6762117
        for <linux-efi@vger.kernel.org>; Thu,  1 Dec 2022 20:57:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A35CC43148
        for <linux-efi@vger.kernel.org>; Thu,  1 Dec 2022 20:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669928233;
        bh=fdrJ15WDKSBx3YB1MakWvP0kCrIB8zpank2IGVDBUI4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=AWUsJlemRllHnB3KbfYBFan7MowqWGBBzZXfshK50w7NfgU8DbH0i5URYIiA8i4li
         GBUHSuMbeF3CoaT6OuX5j6oPgqzYbAa/mwWgJUV1gWr1qn9pDtFcODeJKzmf8ZyH4y
         Z+z3JndoNbtogS6pfY3Fyl2L/Hd/rs/27letywm4FVrVRK6ziqXPEP1vx34e1upKXp
         mxZEMect0GromyYeJZOF/2zhuyduh+oNMYqxKtFAdPDwzKvtfdD8O7hVAWvlFNd3jj
         x6E72ApwWEejybOeqWXhZw3qwRw6IBDRohe6AxHKCqbAYRU4OgHLN8q+YqRmdWZteY
         b6z6C2+Vm9P0g==
Received: by mail-lf1-f53.google.com with SMTP id c1so4387118lfi.7
        for <linux-efi@vger.kernel.org>; Thu, 01 Dec 2022 12:57:13 -0800 (PST)
X-Gm-Message-State: ANoB5pncxPce6qB/MS60K4J5pIGhI+8hLQjMcI+g1nhAUCOXXSps1qzy
        9JzI1mHF7c9AUjoCXOruMu2wp5qdLOTqc6OzR/0=
X-Google-Smtp-Source: AA0mqf4aRybCNgkYFiWCi2CJQd3OPiCCr15y3XRLfWcWG+1KjPdzD46/6PygpsQciMdDVS+ncbsST+gLVrEqsm5wvZ0=
X-Received: by 2002:a05:6512:15a8:b0:4a6:3ed2:3717 with SMTP id
 bp40-20020a05651215a800b004a63ed23717mr18342342lfb.637.1669928231609; Thu, 01
 Dec 2022 12:57:11 -0800 (PST)
MIME-Version: 1.0
References: <20221130225614.1594256-1-heiko@sntech.de> <20221130225614.1594256-13-heiko@sntech.de>
 <20221201193455.2hr6mwm6sa6vnd3w@kamzik>
In-Reply-To: <20221201193455.2hr6mwm6sa6vnd3w@kamzik>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 1 Dec 2022 21:57:00 +0100
X-Gmail-Original-Message-ID: <CAMj1kXG=zM0EFFPn8MBWFurk=oSRPqwdd6CP1dudQC+JXV36Og@mail.gmail.com>
Message-ID: <CAMj1kXG=zM0EFFPn8MBWFurk=oSRPqwdd6CP1dudQC+JXV36Og@mail.gmail.com>
Subject: Re: [PATCH v3 12/14] efi/riscv: libstub: mark when compiling libstub
To:     Andrew Jones <ajones@ventanamicro.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, linux-riscv@lists.infradead.org,
        palmer@dabbelt.com, christoph.muellner@vrull.eu,
        prabhakar.csengg@gmail.com, conor@kernel.org,
        philipp.tomsich@vrull.eu, emil.renner.berthing@canonical.com,
        linux-efi@vger.kernel.org,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Conor Dooley <conor.dooley@microchip.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 1 Dec 2022 at 20:35, Andrew Jones <ajones@ventanamicro.com> wrote:
>
> On Wed, Nov 30, 2022 at 11:56:12PM +0100, Heiko Stuebner wrote:
> > From: Heiko Stuebner <heiko.stuebner@vrull.eu>
> >
> > We may want to runtime-optimize some core functions (str*, mem*),
> > but not have this leak into libstub and cause build issues.
> > Instead libstub, for the short while it's running, should just use
> > the generic implementation.
> >
> > So, to be able to determine whether functions, that are used both in
> > libstub and the main kernel, are getting compiled as part of libstub or
> > not, add a compile-flag we can check via #ifdef.
> >
> > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> > Signed-off-by: Heiko Stuebner <heiko.stuebner@vrull.eu>

I think it would be better to update arch/riscv/kernel/image-vars.h so
that only these generic implementations are exposed to the stub in the
first place.

> > ---
> >  drivers/firmware/efi/libstub/Makefile | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
> > index ef5045a53ce0..777d1ab059e3 100644
> > --- a/drivers/firmware/efi/libstub/Makefile
> > +++ b/drivers/firmware/efi/libstub/Makefile
> > @@ -25,7 +25,7 @@ cflags-$(CONFIG_ARM)                := $(subst $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)) \
> >                                  -fno-builtin -fpic \
> >                                  $(call cc-option,-mno-single-pic-base)
> >  cflags-$(CONFIG_RISCV)               := $(subst $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)) \
> > -                                -fpic
> > +                                -fpic -DRISCV_EFISTUB
> >  cflags-$(CONFIG_LOONGARCH)   := $(subst $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)) \
> >                                  -fpie
> >
> > --
> > 2.35.1
> >
>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
