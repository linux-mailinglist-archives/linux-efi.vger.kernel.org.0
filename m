Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65C085B46A1
	for <lists+linux-efi@lfdr.de>; Sat, 10 Sep 2022 16:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbiIJO2Z (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 10 Sep 2022 10:28:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiIJO2Y (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 10 Sep 2022 10:28:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07E50491DF;
        Sat, 10 Sep 2022 07:28:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 79546B808BB;
        Sat, 10 Sep 2022 14:28:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EE1BC433D6;
        Sat, 10 Sep 2022 14:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662820100;
        bh=xHN3NSjIeZYZ84pGWY4+aE92maVg9bJlxPx1OGdXJwM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lAYR45N4lBoaZhi1i5SeDab4LK/wNpVDTWRlRDSSspcAzZXB4uA6nx8hdPVtFYdsU
         OXJsP1+oLTMAhmBky+eo44bruMk6luvJ5n3xqEX7cgEzXrnWLHMea+Z/XpHslKStiJ
         AaEwT1x989pZz0PXPXFQR8PDBe2BllxQ71vU/mn28xVfplWFgPslkeqsZq0+0cKGqB
         vhLfPuPWycrE8Q/yZwu8RA07HF9FpmzegErYPzoZB+HMMseoA2oLQVorjUIBtUYhtA
         f2P2VM6uDx5XJZYSShS9pZ58V9zTFEEcEb2cmuaVl+vFYe6wMnC6C6+N7w1tHN4YlD
         D/zXZg6h2DvUA==
Received: by mail-lj1-f176.google.com with SMTP id y29so5347081ljq.7;
        Sat, 10 Sep 2022 07:28:20 -0700 (PDT)
X-Gm-Message-State: ACgBeo08C2yLel3VrCwABwqnfBcMcSbFFjwfHopFfsrSOmxMBGIDxdLF
        zf4XypC1Cqk88XYCf4s8boRyH+3mtMJlh/H/fPE=
X-Google-Smtp-Source: AA6agR5dZInxiYwE2o/zXlVfI9F5B1DzhKpbxArnE8m04/TD9+3GgFnsj17o1QtDRrrETHJN1uslO0iiuBDOU39HSwQ=
X-Received: by 2002:a05:651c:b94:b0:26a:d317:57d5 with SMTP id
 bg20-20020a05651c0b9400b0026ad31757d5mr4672614ljb.152.1662820096098; Sat, 10
 Sep 2022 07:28:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220910081152.2238369-1-ardb@kernel.org> <20220910081152.2238369-9-ardb@kernel.org>
 <6876236f.7b0c.18327c74248.Coremail.chenhuacai@loongson.cn>
In-Reply-To: <6876236f.7b0c.18327c74248.Coremail.chenhuacai@loongson.cn>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sat, 10 Sep 2022 15:28:04 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFpQ1FkiMMXeA-E5FdnDzhZr7qmN15PNig_9KXxGNRJhQ@mail.gmail.com>
Message-ID: <CAMj1kXFpQ1FkiMMXeA-E5FdnDzhZr7qmN15PNig_9KXxGNRJhQ@mail.gmail.com>
Subject: Re: [PATCH v5 8/8] loongarch: efi: enable generic EFI compressed boot
To:     =?UTF-8?B?6ZmI5Y2O5omN?= <chenhuacai@loongson.cn>
Cc:     linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Peter Jones <pjones@redhat.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Atish Patra <atishp@atishpatra.org>,
        Arnd Bergmann <arnd@arndb.de>, Xi Ruoyao <xry111@xry111.site>,
        Lennart Poettering <lennart@poettering.net>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sat, 10 Sept 2022 at 15:22, =E9=99=88=E5=8D=8E=E6=89=8D <chenhuacai@loon=
gson.cn> wrote:
>
> Hi, Ard,
>
> I prefer to give a chance to disable ZBOOT, so I don't want to select EFI=
_ZBOOT unconditionally in Kconfig, and then the Makefile can be like this:
> diff --git a/arch/loongarch/Makefile b/arch/loongarch/Makefile
> index c3f579bdf9e5..bc6fe65125f5 100644
> --- a/arch/loongarch/Makefile
> +++ b/arch/loongarch/Makefile
> @@ -14,6 +14,10 @@ else
>  KBUILD_IMAGE   :=3D $(boot)/vmlinux.efi
>  endif
>
> +ifdef CONFIG_EFI_ZBOOT
> +KBUILD_IMAGE    :=3D $(boot)/vmlinuz.efi
> +endif
> +
>  archscripts: scripts_basic
>         $(Q)$(MAKE) $(build)=3Darch/loongarch/boot/tools relocs
>

OK, I will fold this in. This actually aligns it with the other
architectures, so I prefer this approach as well.


>
> > -----=E5=8E=9F=E5=A7=8B=E9=82=AE=E4=BB=B6-----
> > =E5=8F=91=E4=BB=B6=E4=BA=BA: "Ard Biesheuvel" <ardb@kernel.org>
> > =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4:2022-09-10 16:11:52 (=E6=98=9F=E6=
=9C=9F=E5=85=AD)
> > =E6=94=B6=E4=BB=B6=E4=BA=BA: linux-efi@vger.kernel.org
> > =E6=8A=84=E9=80=81: linux-arm-kernel@lists.infradead.org, linux-kernel@=
vger.kernel.org, "Ard Biesheuvel" <ardb@kernel.org>, "James E.J. Bottomley"=
 <James.Bottomley@HansenPartnership.com>, "Matthew Garrett" <mjg59@srcf.uca=
m.org>, "Peter Jones" <pjones@redhat.com>, "Ilias Apalodimas" <ilias.apalod=
imas@linaro.org>, "Heinrich Schuchardt" <heinrich.schuchardt@canonical.com>=
, "AKASHI Takahiro" <takahiro.akashi@linaro.org>, "Palmer Dabbelt" <palmer@=
dabbelt.com>, "Atish Patra" <atishp@atishpatra.org>, "Arnd Bergmann" <arnd@=
arndb.de>, "Huacai Chen" <chenhuacai@loongson.cn>, "Xi Ruoyao" <xry111@xry1=
11.site>, "Lennart Poettering" <lennart@poettering.net>, "Jeremy Linton" <j=
eremy.linton@arm.com>, "Will Deacon" <will@kernel.org>, "Catalin Marinas" <=
catalin.marinas@arm.com>
> > =E4=B8=BB=E9=A2=98: [PATCH v5 8/8] loongarch: efi: enable generic EFI c=
ompressed boot
> >
> > Wire up the generic EFI zboot support for LoongArch64
> >
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
> >  arch/loongarch/Kconfig         | 1 +
> >  arch/loongarch/Makefile        | 4 ++--
> >  arch/loongarch/boot/.gitignore | 1 +
> >  arch/loongarch/boot/Makefile   | 6 ++++++
> >  4 files changed, 10 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> > index fca106a8b8af..f960dbbfb62d 100644
> > --- a/arch/loongarch/Kconfig
> > +++ b/arch/loongarch/Kconfig
> > @@ -55,6 +55,7 @@ config LOONGARCH
> >       select BUILDTIME_TABLE_SORT
> >       select COMMON_CLK
> >       select EFI
> > +     select EFI_ZBOOT
> >       select GENERIC_CLOCKEVENTS
> >       select GENERIC_CMOS_UPDATE
> >       select GENERIC_CPU_AUTOPROBE
> > diff --git a/arch/loongarch/Makefile b/arch/loongarch/Makefile
> > index 4bc47f47cfd8..357ed2a771bf 100644
> > --- a/arch/loongarch/Makefile
> > +++ b/arch/loongarch/Makefile
> > @@ -10,7 +10,7 @@ KBUILD_DEFCONFIG :=3D loongson3_defconfig
> >  ifndef CONFIG_EFI_STUB
> >  KBUILD_IMAGE :=3D $(boot)/vmlinux.elf
> >  else
> > -KBUILD_IMAGE :=3D $(boot)/vmlinux.efi
> > +KBUILD_IMAGE :=3D $(boot)/vmlinuz.efi
> >  endif
> >
> >  #
> > @@ -93,7 +93,7 @@ vdso_install:
> >
> >  all: $(notdir $(KBUILD_IMAGE))
> >
> > -vmlinux.elf vmlinux.efi: vmlinux
> > +vmlinux.elf vmlinux.efi vmlinuz.efi: vmlinux
> >       $(Q)$(MAKE) $(build)=3D$(boot) $(bootvars-y) $(boot)/$@
> >
> >  install:
> > diff --git a/arch/loongarch/boot/.gitignore b/arch/loongarch/boot/.giti=
gnore
> > index 49423ee96ef3..e5dc594dc4b6 100644
> > --- a/arch/loongarch/boot/.gitignore
> > +++ b/arch/loongarch/boot/.gitignore
> > @@ -1,2 +1,3 @@
> >  # SPDX-License-Identifier: GPL-2.0-only
> >  vmlinux*
> > +vmlinuz*
> > diff --git a/arch/loongarch/boot/Makefile b/arch/loongarch/boot/Makefil=
e
> > index fecf34f50e56..4e1c374c5782 100644
> > --- a/arch/loongarch/boot/Makefile
> > +++ b/arch/loongarch/boot/Makefile
> > @@ -18,3 +18,9 @@ $(obj)/vmlinux.elf: vmlinux FORCE
> >  targets +=3D vmlinux.efi
> >  $(obj)/vmlinux.efi: vmlinux FORCE
> >       $(call if_changed,objcopy)
> > +
> > +EFI_ZBOOT_PAYLOAD      :=3D vmlinux.efi
> > +EFI_ZBOOT_BFD_TARGET   :=3D elf64-loongarch
> > +EFI_ZBOOT_MACH_TYPE    :=3D LOONGARCH64
> > +
> > +include $(srctree)/drivers/firmware/efi/libstub/Makefile.zboot
> > --
> > 2.35.1
>
>
> =E6=9C=AC=E9=82=AE=E4=BB=B6=E5=8F=8A=E5=85=B6=E9=99=84=E4=BB=B6=E5=90=AB=
=E6=9C=89=E9=BE=99=E8=8A=AF=E4=B8=AD=E7=A7=91=E7=9A=84=E5=95=86=E4=B8=9A=E7=
=A7=98=E5=AF=86=E4=BF=A1=E6=81=AF=EF=BC=8C=E4=BB=85=E9=99=90=E4=BA=8E=E5=8F=
=91=E9=80=81=E7=BB=99=E4=B8=8A=E9=9D=A2=E5=9C=B0=E5=9D=80=E4=B8=AD=E5=88=97=
=E5=87=BA=E7=9A=84=E4=B8=AA=E4=BA=BA=E6=88=96=E7=BE=A4=E7=BB=84=E3=80=82=E7=
=A6=81=E6=AD=A2=E4=BB=BB=E4=BD=95=E5=85=B6=E4=BB=96=E4=BA=BA=E4=BB=A5=E4=BB=
=BB=E4=BD=95=E5=BD=A2=E5=BC=8F=E4=BD=BF=E7=94=A8=EF=BC=88=E5=8C=85=E6=8B=AC=
=E4=BD=86=E4=B8=8D=E9=99=90=E4=BA=8E=E5=85=A8=E9=83=A8=E6=88=96=E9=83=A8=E5=
=88=86=E5=9C=B0=E6=B3=84=E9=9C=B2=E3=80=81=E5=A4=8D=E5=88=B6=E6=88=96=E6=95=
=A3=E5=8F=91=EF=BC=89=E6=9C=AC=E9=82=AE=E4=BB=B6=E5=8F=8A=E5=85=B6=E9=99=84=
=E4=BB=B6=E4=B8=AD=E7=9A=84=E4=BF=A1=E6=81=AF=E3=80=82=E5=A6=82=E6=9E=9C=E6=
=82=A8=E9=94=99=E6=94=B6=E6=9C=AC=E9=82=AE=E4=BB=B6=EF=BC=8C=E8=AF=B7=E6=82=
=A8=E7=AB=8B=E5=8D=B3=E7=94=B5=E8=AF=9D=E6=88=96=E9=82=AE=E4=BB=B6=E9=80=9A=
=E7=9F=A5=E5=8F=91=E4=BB=B6=E4=BA=BA=E5=B9=B6=E5=88=A0=E9=99=A4=E6=9C=AC=E9=
=82=AE=E4=BB=B6=E3=80=82
> This email and its attachments contain confidential information from Loon=
gson Technology , which is intended only for the person or entity whose add=
ress is listed above. Any use of the information contained herein in any wa=
y (including, but not limited to, total or partial disclosure, reproduction=
 or dissemination) by persons other than the intended recipient(s) is prohi=
bited. If you receive this email in error, please notify the sender by phon=
e or email immediately and delete it.
