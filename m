Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE0674AD49
	for <lists+linux-efi@lfdr.de>; Fri,  7 Jul 2023 10:47:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbjGGIrt (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 7 Jul 2023 04:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbjGGIrs (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 7 Jul 2023 04:47:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E9051FCE;
        Fri,  7 Jul 2023 01:47:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E7D7E61728;
        Fri,  7 Jul 2023 08:47:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49FF9C433C9;
        Fri,  7 Jul 2023 08:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688719666;
        bh=nDLct84XbdvtTYSifKLyBbzOc2cgi6lSKASzLLiQ2+A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mN/qZAh84pxtr7Lom14e6yhynXc0nKRJPNWUYAUMB8VTt5ihMY6ZXxJibGusmCFtH
         5Xl8yUMyBQPwUbJRAOcriN3X1o2/GsPTu11BqXQSJNwiFGZMn1VhyRn3Rf+dfrWfRR
         ITYJxFW8+YY0MlzJjBAPutpzxsIPcixTdtSL4dncl5uGoy8PnC7fD1ttbfgejN7821
         V7Z5R5J37L+xN0ldk/0dWQ4U4pK31n3iBduFfe0Xxz9n9/VMPMQywRY6d2gJr1g7Na
         dXcLnNj3lagJNsNxQrZRgYB15nMm+1RZFDJMiEY6Lj3l8XS9HZC3mVgFCsbYBaNRTY
         QuaWFWYVuzyRQ==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2b701e1c80fso23829661fa.2;
        Fri, 07 Jul 2023 01:47:46 -0700 (PDT)
X-Gm-Message-State: ABy/qLZlyzGMptLH/A/J0Uu+PuYhNOdNJ8S3pBi57lKolDEExnzWenXF
        djsX9EilgX/fxviezn+OaANL7W9kGzaSjYywOh0=
X-Google-Smtp-Source: APBJJlEZDLQTAwPo5ZNI/O17855BNJ+q6WItOhlKfpo2UGioItlbEcSg7bTNxRAT4tLResnCDRUqV395x96BZd5UyQ4=
X-Received: by 2002:a2e:87c3:0:b0:2b6:bd09:4d64 with SMTP id
 v3-20020a2e87c3000000b002b6bd094d64mr3335448ljj.34.1688719664209; Fri, 07 Jul
 2023 01:47:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230621114439.42851-1-alexghiti@rivosinc.com>
 <20230621114439.42851-2-alexghiti@rivosinc.com> <CAHVXubicGLp0-aOpeq7M1Cs3YZ+3WC1d_0gjyaoS8Z1j03JAQQ@mail.gmail.com>
In-Reply-To: <CAHVXubicGLp0-aOpeq7M1Cs3YZ+3WC1d_0gjyaoS8Z1j03JAQQ@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 7 Jul 2023 10:47:32 +0200
X-Gmail-Original-Message-ID: <CAMj1kXH1VZqrekHELZG6DdSU6mnF91vo=GbQTYmwJetKB8Cd1Q@mail.gmail.com>
Message-ID: <CAMj1kXH1VZqrekHELZG6DdSU6mnF91vo=GbQTYmwJetKB8Cd1Q@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] libstub: zboot: Use -ffunction-sections + --gc-sections
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 7 Jul 2023 at 10:44, Alexandre Ghiti <alexghiti@rivosinc.com> wrote=
:
>
> Hi Ard,
>
> On Wed, Jun 21, 2023 at 1:45=E2=80=AFPM Alexandre Ghiti <alexghiti@rivosi=
nc.com> wrote:
> >
> > Static linking is done at an object file (actually section) granularity=
,
> > meaning that if a function in an object has an undefined reference, the
> > link will fail, even though this function is not used in the resulting
> > ELF.
> >
> > To avoid such failures, allow the linker to garbage collect unused sect=
ions
> > (which actually are functions).
> >
> > Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> > ---
> >  drivers/firmware/efi/libstub/Makefile       | 1 +
> >  drivers/firmware/efi/libstub/Makefile.zboot | 2 +-
> >  2 files changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/e=
fi/libstub/Makefile
> > index 3abb2b357482..6182366d00c0 100644
> > --- a/drivers/firmware/efi/libstub/Makefile
> > +++ b/drivers/firmware/efi/libstub/Makefile
> > @@ -40,6 +40,7 @@ KBUILD_CFLAGS                 :=3D $(subst $(CC_FLAGS=
_FTRACE),,$(cflags-y)) \
> >                                    -ffreestanding \
> >                                    -fno-stack-protector \
> >                                    $(call cc-option,-fno-addrsig) \
> > +                                  -ffunction-sections \
> >                                    -D__DISABLE_EXPORTS
> >
> >  #
> > diff --git a/drivers/firmware/efi/libstub/Makefile.zboot b/drivers/firm=
ware/efi/libstub/Makefile.zboot
> > index 89ef820f3b34..5bb52d262133 100644
> > --- a/drivers/firmware/efi/libstub/Makefile.zboot
> > +++ b/drivers/firmware/efi/libstub/Makefile.zboot
> > @@ -51,7 +51,7 @@ $(obj)/zboot-header.o: $(srctree)/drivers/firmware/ef=
i/libstub/zboot-header.S FO
> >
> >  ZBOOT_DEPS :=3D $(obj)/zboot-header.o $(objtree)/drivers/firmware/efi/=
libstub/lib.a
> >
> > -LDFLAGS_vmlinuz.efi.elf :=3D -T $(srctree)/drivers/firmware/efi/libstu=
b/zboot.lds
> > +LDFLAGS_vmlinuz.efi.elf :=3D -T $(srctree)/drivers/firmware/efi/libstu=
b/zboot.lds --gc-sections
> >  $(obj)/vmlinuz.efi.elf: $(obj)/vmlinuz.o $(ZBOOT_DEPS) FORCE
> >         $(call if_changed,ld)
> >
> > --
> > 2.39.2
> >
>
> Sorry to bother you, do you have any opinion about this patch? Does
> that make sense? If not, I should find another solution for my riscv
> KASLR series!
>

Hi,

Apologies for the delay in responding. I have been away and email
tends to pile up a bit.

The patch by itself looks fine to me, but I do wonder if your series
could be improved slightly by moving those newly shared pieces into a
separate source file, rather than to an existing one.
