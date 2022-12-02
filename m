Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8C2E64020C
	for <lists+linux-efi@lfdr.de>; Fri,  2 Dec 2022 09:24:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232473AbiLBIY0 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 2 Dec 2022 03:24:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232446AbiLBIXk (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 2 Dec 2022 03:23:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D4FFC4CC1
        for <linux-efi@vger.kernel.org>; Fri,  2 Dec 2022 00:19:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3DD25B8210D
        for <linux-efi@vger.kernel.org>; Fri,  2 Dec 2022 08:19:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05E6FC433B5
        for <linux-efi@vger.kernel.org>; Fri,  2 Dec 2022 08:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669969197;
        bh=0ZnuSrqRuhjsk8n2SNjuiavyYPMTBT4baAW3idwtSMA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PEJWzUXY6QnPddhCAbQA8Ln91+6Q5En2+9t2sVpA4vsVdZe77SuR6aAi/8+gTnUCR
         FGXnBVhujiFE5Ecac3Q5VKonJpxy0TEepShozzYro8G1s1nSLHatxRrQuwIF44WjxK
         P1Linb7dP2eP+zcHeHs5oEzMJDEP0FMH/cbn3VinGNrwUd30hHB3a2q3kK33WHePOR
         VxLQdHy5iBkGnEfnZuebaIPFlPYpoXKE632mnDepqho/B+FJbLwg+KEjt3En0eAC9H
         Jm8E6sIXamcHVA/XHuoqnm3M9TGSdcTQiAhsoO610SUf/lUpWB/s1K7/SI++D0smW4
         JI6nJ2bGNJDZQ==
Received: by mail-lf1-f44.google.com with SMTP id f13so6296195lfa.6
        for <linux-efi@vger.kernel.org>; Fri, 02 Dec 2022 00:19:56 -0800 (PST)
X-Gm-Message-State: ANoB5pm4UYAslW5qGfQRcIY1C7WmHqpzbkZHpmMg7v60dy3ZM6/E3/6O
        QBQwwxxGvlf7jJGoNpO4rV3ZDpL4aFlyQQ7Pgag=
X-Google-Smtp-Source: AA0mqf5YZdoAmm+Igxnj0lPbYCtmTJqEXXksr0fEhk12uTEra6daOFKOHf35q/qBplj4yWq5qKZdMFxf9LtEh2101pc=
X-Received: by 2002:a05:6512:3e2a:b0:4ab:534b:1b2c with SMTP id
 i42-20020a0565123e2a00b004ab534b1b2cmr18339569lfv.426.1669969194978; Fri, 02
 Dec 2022 00:19:54 -0800 (PST)
MIME-Version: 1.0
References: <20221130225614.1594256-14-heiko@sntech.de> <mhng-3dd5efb0-e79f-4978-89a8-f9ec02004a7e@palmer-ri-x1c9a>
In-Reply-To: <mhng-3dd5efb0-e79f-4978-89a8-f9ec02004a7e@palmer-ri-x1c9a>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 2 Dec 2022 09:19:43 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFHuSzZ2X3+Z0wj6BZ5YrPwaaQrHJWGc48A-C2M8A=5Mw@mail.gmail.com>
Message-ID: <CAMj1kXFHuSzZ2X3+Z0wj6BZ5YrPwaaQrHJWGc48A-C2M8A=5Mw@mail.gmail.com>
Subject: Re: [PATCH v3 13/14] RISC-V: add infrastructure to allow different
 str* implementations
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Cc:     heiko@sntech.de, Ard Biesheuvel <aardb@kernel.org>,
        linux-riscv@lists.infradead.org, christoph.muellner@vrull.eu,
        prabhakar.csengg@gmail.com, Conor Dooley <conor@kernel.org>,
        philipp.tomsich@vrull.eu, ajones@ventanamicro.com,
        emil.renner.berthing@canonical.com, linux-efi@vger.kernel.org,
        heiko.stuebner@vrull.eu, Conor Dooley <conor.dooley@microchip.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 2 Dec 2022 at 05:08, Palmer Dabbelt <palmer@dabbelt.com> wrote:
>
> On Wed, 30 Nov 2022 14:56:13 PST (-0800), heiko@sntech.de wrote:
> > From: Heiko Stuebner <heiko.stuebner@vrull.eu>
> >
> > Depending on supported extensions on specific RISC-V cores,
> > optimized str* functions might make sense.
> >
> > This adds basic infrastructure to allow patching the function calls
> > via alternatives later on.
> >
> > The main idea is to have the core str* functions be inline functions
> > which then call the most optimized variant and this call then be
> > replaced via alternatives.
> >
> > The big advantage is that we don't need additional calls.
> > Though we need to duplicate the generic functions as the main code
> > expects either itself or the architecture to provide the str* functions.
> >
> > The added *_generic functions are done in assembler (taken from
> > disassembling the main-kernel functions for now) to allow us to control
> > the used registers.
> >
> > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> > Signed-off-by: Heiko Stuebner <heiko.stuebner@vrull.eu>
> > ---
> >  arch/riscv/Makefile             |  3 ++
> >  arch/riscv/include/asm/string.h | 66 +++++++++++++++++++++++++++++++++
> >  arch/riscv/kernel/image-vars.h  |  6 +--
> >  arch/riscv/lib/Makefile         |  3 ++
> >  arch/riscv/lib/strcmp.S         | 38 +++++++++++++++++++
> >  arch/riscv/lib/strlen.S         | 29 +++++++++++++++
> >  arch/riscv/lib/strncmp.S        | 41 ++++++++++++++++++++
> >  7 files changed, 183 insertions(+), 3 deletions(-)
> >  create mode 100644 arch/riscv/lib/strcmp.S
> >  create mode 100644 arch/riscv/lib/strlen.S
> >  create mode 100644 arch/riscv/lib/strncmp.S
> >
> > diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
> > index 0d13b597cb55..581e4370c2a6 100644
> > --- a/arch/riscv/Makefile
> > +++ b/arch/riscv/Makefile
> > @@ -80,6 +80,9 @@ ifeq ($(CONFIG_PERF_EVENTS),y)
> >          KBUILD_CFLAGS += -fno-omit-frame-pointer
> >  endif
> >
> > +# strchr is special case, as gcc might want to call its own strlen from there
> > +KBUILD_CFLAGS += -fno-builtin-strlen -fno-builtin-strcmp -fno-builtin-strncmp -fno-builtin-strchr
>
> I was poking around Ard's comment on that -DRISCV_EFI to try and figure
> out what it was doing, but I think this is the bigger issue.  I haven't
> benchmarked anything, but my guess is that turning off support for these
> builtin routines will outweigh the faster outline implementations of
> these routines.  I don't have any benchmarks to prove that, but in
> general compilers are pretty smart about handling these builtin routines
> in the common cases and deferring that to runtime is probably the wrong
> option.
>

Indeed. Case in point:

riscv64-linux-gnugcc -O -S -o - -xc - <<<"int foo() { return strlen(\"bar\"); }"

gives me

li a0,3
ret

whereas this

riscv64-linux-gnu-gcc -fno-builtin-strlen -O -S -o - -xc - <<<"int
foo() { return strlen(\"bar\"); }"

gives me

.LC0:
  .string "bar"
  .text
  .align 1
  .globl foo
  .type foo, @function
foo:
  addi sp,sp,-16
  sd ra,8(sp)
  lla a0,.LC0
  call strlen@plt
  ld ra,8(sp)
  addi sp,sp,16
  jr ra

Other str* and mem* routines are optimized in similar ways when
dealing with small sizes or compile time constants.

Also, I'd recommend avoiding redefining these prototypes to static
inline as it deviates from the official prototypes in the C library.

> I haven't looked all that closely at this patch set.  Is there some
> reason it's necessary to disable the builtin handling?  If not then my
> guess is it's better to leave that enabled unless some benchmarks show
> otherwise (and I don't know of any Zb* hardware to test against).
>

Why not have a single generic version of each in the binary with a
patchable NOP at the start, and patch that to an optimized version
when available? That way. all of the early code can remain as is.
