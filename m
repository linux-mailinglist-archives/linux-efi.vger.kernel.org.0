Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6352674AD84
	for <lists+linux-efi@lfdr.de>; Fri,  7 Jul 2023 11:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232532AbjGGJHM (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 7 Jul 2023 05:07:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232584AbjGGJHJ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 7 Jul 2023 05:07:09 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88F451FEE
        for <linux-efi@vger.kernel.org>; Fri,  7 Jul 2023 02:07:07 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-307d58b3efbso1560230f8f.0
        for <linux-efi@vger.kernel.org>; Fri, 07 Jul 2023 02:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1688720826; x=1691312826;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0j1Mjil1srPw084knHzYgXyHjdm+Cb0b+kJmKHhJ9iw=;
        b=xtk8m8TFBcFOq13Z3Zw12EKrYYQ+LbR5rqu9t6AGXK9ZX6Sfp5+Omo5+lBVZQzg/V3
         V+YFD6FCjrpdblAP4MBzcbLbDoblYvdUgoSVkUD2icnXQ6T55qMkxZb1fPBGSBvG0MuB
         J4wefxvJ3A+AN338vyJJx7bGlxxPlCghTeCrSfZwfYp+4wbLWyYtzh5PPlTHHnhKhstZ
         15haP3D1AGLmW3e+aKghSStCwHzvvqcetiIHDoXSrnpC5S/Ht2KN4/9XWivlog+pc3QW
         2XE8rfV86Q/3Ko3cqCl8a1cQ2tSH4tA/+Rxo2km3Hoi1ksLYXwyTttR/8ozfTPy4Kp4B
         Ybrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688720826; x=1691312826;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0j1Mjil1srPw084knHzYgXyHjdm+Cb0b+kJmKHhJ9iw=;
        b=IWFSPqR1eWVrtSVal+9cpJV+sE1KPhH+/Qik2Zi3zPpf+tAHB053MuUc+X89+ir8yY
         XEuG/pb4AZRvlz83KkNcan4RDjMMSurwylbb7yqBJ+kRHHx9AKS2we/nfQfXPbRVyR0C
         bQ2Ounv5IuX1HvtKY9bra1m6WOSWl0WTOHLd56KI9JJw5f14/hoGFXxkv+dXx78Z2A2m
         2laywn+6kqK00pANEr4r6gHW5bkXCbLkPYHc61gnrnD8YeiOp+rO1Et8OTRgXKEeTtsB
         munGZLtfRv3d/DsXd3jR0ciObxewfFbpWMKHZp5NoUlHfHvE5DDDZg7o9cLVbowNvD5Y
         v7nQ==
X-Gm-Message-State: ABy/qLaj9gKKTIxxU04uFDeLb7DDxgCorcOVMFSTR6w6HWksg71Ucw6V
        EWwCX90bw7Uh3U3aOV3lKB5+cQIsCViefsmukWBc1Q==
X-Google-Smtp-Source: APBJJlH4Y9NSx/z29c7baQkACHT8+6GamPLew3bOsgu8lZRN2X8KAmYRABjBRie2DN0G1qQ25DUwnq7RRCDX4ikImmI=
X-Received: by 2002:a5d:5683:0:b0:314:c9c:94dd with SMTP id
 f3-20020a5d5683000000b003140c9c94ddmr3503054wrv.20.1688720825889; Fri, 07 Jul
 2023 02:07:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230621114439.42851-1-alexghiti@rivosinc.com>
 <20230621114439.42851-2-alexghiti@rivosinc.com> <CAHVXubicGLp0-aOpeq7M1Cs3YZ+3WC1d_0gjyaoS8Z1j03JAQQ@mail.gmail.com>
 <CAMj1kXH1VZqrekHELZG6DdSU6mnF91vo=GbQTYmwJetKB8Cd1Q@mail.gmail.com>
In-Reply-To: <CAMj1kXH1VZqrekHELZG6DdSU6mnF91vo=GbQTYmwJetKB8Cd1Q@mail.gmail.com>
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
Date:   Fri, 7 Jul 2023 11:06:55 +0200
Message-ID: <CAHVXubh5RZ37kLaVt+D_eEnEaP7A-wk9eQmdXWeb2MoRcWxvvw@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] libstub: zboot: Use -ffunction-sections + --gc-sections
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Jul 7, 2023 at 10:47=E2=80=AFAM Ard Biesheuvel <ardb@kernel.org> wr=
ote:
>
> On Fri, 7 Jul 2023 at 10:44, Alexandre Ghiti <alexghiti@rivosinc.com> wro=
te:
> >
> > Hi Ard,
> >
> > On Wed, Jun 21, 2023 at 1:45=E2=80=AFPM Alexandre Ghiti <alexghiti@rivo=
sinc.com> wrote:
> > >
> > > Static linking is done at an object file (actually section) granulari=
ty,
> > > meaning that if a function in an object has an undefined reference, t=
he
> > > link will fail, even though this function is not used in the resultin=
g
> > > ELF.
> > >
> > > To avoid such failures, allow the linker to garbage collect unused se=
ctions
> > > (which actually are functions).
> > >
> > > Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> > > ---
> > >  drivers/firmware/efi/libstub/Makefile       | 1 +
> > >  drivers/firmware/efi/libstub/Makefile.zboot | 2 +-
> > >  2 files changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware=
/efi/libstub/Makefile
> > > index 3abb2b357482..6182366d00c0 100644
> > > --- a/drivers/firmware/efi/libstub/Makefile
> > > +++ b/drivers/firmware/efi/libstub/Makefile
> > > @@ -40,6 +40,7 @@ KBUILD_CFLAGS                 :=3D $(subst $(CC_FLA=
GS_FTRACE),,$(cflags-y)) \
> > >                                    -ffreestanding \
> > >                                    -fno-stack-protector \
> > >                                    $(call cc-option,-fno-addrsig) \
> > > +                                  -ffunction-sections \
> > >                                    -D__DISABLE_EXPORTS
> > >
> > >  #
> > > diff --git a/drivers/firmware/efi/libstub/Makefile.zboot b/drivers/fi=
rmware/efi/libstub/Makefile.zboot
> > > index 89ef820f3b34..5bb52d262133 100644
> > > --- a/drivers/firmware/efi/libstub/Makefile.zboot
> > > +++ b/drivers/firmware/efi/libstub/Makefile.zboot
> > > @@ -51,7 +51,7 @@ $(obj)/zboot-header.o: $(srctree)/drivers/firmware/=
efi/libstub/zboot-header.S FO
> > >
> > >  ZBOOT_DEPS :=3D $(obj)/zboot-header.o $(objtree)/drivers/firmware/ef=
i/libstub/lib.a
> > >
> > > -LDFLAGS_vmlinuz.efi.elf :=3D -T $(srctree)/drivers/firmware/efi/libs=
tub/zboot.lds
> > > +LDFLAGS_vmlinuz.efi.elf :=3D -T $(srctree)/drivers/firmware/efi/libs=
tub/zboot.lds --gc-sections
> > >  $(obj)/vmlinuz.efi.elf: $(obj)/vmlinuz.o $(ZBOOT_DEPS) FORCE
> > >         $(call if_changed,ld)
> > >
> > > --
> > > 2.39.2
> > >
> >
> > Sorry to bother you, do you have any opinion about this patch? Does
> > that make sense? If not, I should find another solution for my riscv
> > KASLR series!
> >
>
> Hi,
>
> Apologies for the delay in responding. I have been away and email
> tends to pile up a bit.

No worries!

>
> The patch by itself looks fine to me, but I do wonder if your series
> could be improved slightly by moving those newly shared pieces into a
> separate source file, rather than to an existing one.

If you prefer this solution, I'll do that then.

But I'm happy the patch makes sense to you, I'll probably use this to
fix some issues/limitations with the riscv pre-mmu code :)

Thanks for your quick answer!

Alex
