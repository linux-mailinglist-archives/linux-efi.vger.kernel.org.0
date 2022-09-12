Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 197175B580B
	for <lists+linux-efi@lfdr.de>; Mon, 12 Sep 2022 12:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbiILKSV (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 12 Sep 2022 06:18:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbiILKSU (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 12 Sep 2022 06:18:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4E7B2C11B;
        Mon, 12 Sep 2022 03:18:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 80AFE60B50;
        Mon, 12 Sep 2022 10:18:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2D09C43150;
        Mon, 12 Sep 2022 10:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662977898;
        bh=kWMe+7CNzjzp4rQ47QWRnkKq04EFkqQePpgjxxrETT0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kQ3TQ5tXtnMgJDPPtVoB8Bec6sFR8CjOajsR7riY9VpKsQpePLQVOPwfFENxjXWsZ
         7VDJZN8eIt8Po98Fx5++QRnaKoYz1N6+P3ePsgXBD+/wQB4EsHfI3XeQIlFc79FFFV
         PF4WrTNH8U0vqTOAEfwaHEB/djY/642sK0MpDUwRqXaglNfXDSJeHdNUXaxEGleXhg
         uJ1Q/JdxtoPBvJTyad5qw1AXcuwwMXcuehbd0XxEAORiGW7iZNkH16ZEwp4SC8o61O
         6iJQolyxsM2mXsatX+aBxfnb3G1cIoPFTR4URZrQ3Je/xHHlIlKtPErI+wGnR8vV1E
         kT/NrAKyhcWGA==
Received: by mail-lf1-f54.google.com with SMTP id f9so13295685lfr.3;
        Mon, 12 Sep 2022 03:18:18 -0700 (PDT)
X-Gm-Message-State: ACgBeo31X4gHUFA+Sg8E0qCcqUiOmZVKNHkn/7Nt+r99DRWgBcdfD+J3
        dONOax8lRqceFp3fvd3gQGKwfQVn+y/RKg+qLic=
X-Google-Smtp-Source: AA6agR7O6xg9bgH0x4tI6uxzwzVJNBUTTbg0uuggt6ZblPTlbBD+d8aB6msOoYCXnSzyFMj81e920oC6STcRn0s3770=
X-Received: by 2002:a05:6512:150e:b0:492:d9fd:9bdf with SMTP id
 bq14-20020a056512150e00b00492d9fd9bdfmr8203912lfb.583.1662977896827; Mon, 12
 Sep 2022 03:18:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220910081152.2238369-1-ardb@kernel.org> <20220910081152.2238369-9-ardb@kernel.org>
 <6876236f.7b0c.18327c74248.Coremail.chenhuacai@loongson.cn>
 <CAMj1kXFpQ1FkiMMXeA-E5FdnDzhZr7qmN15PNig_9KXxGNRJhQ@mail.gmail.com> <2c005589.7bc5.1832d12eb0c.Coremail.chenhuacai@loongson.cn>
In-Reply-To: <2c005589.7bc5.1832d12eb0c.Coremail.chenhuacai@loongson.cn>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 12 Sep 2022 11:18:05 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEvRfgMo+kJBwdNQfcBSfEXYGZ5vTbh2Ym8T6X+p9iWBA@mail.gmail.com>
Message-ID: <CAMj1kXEvRfgMo+kJBwdNQfcBSfEXYGZ5vTbh2Ym8T6X+p9iWBA@mail.gmail.com>
Subject: Re: Re: [PATCH v5 8/8] loongarch: efi: enable generic EFI compressed boot
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

On Sun, 11 Sept 2022 at 16:03, =E9=99=88=E5=8D=8E=E6=89=8D <chenhuacai@loon=
gson.cn> wrote:
>
>
>
>
> > -----=E5=8E=9F=E5=A7=8B=E9=82=AE=E4=BB=B6-----
> > =E5=8F=91=E4=BB=B6=E4=BA=BA: "Ard Biesheuvel" <ardb@kernel.org>
> > =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4:2022-09-10 22:28:04 (=E6=98=9F=E6=
=9C=9F=E5=85=AD)
> > =E6=94=B6=E4=BB=B6=E4=BA=BA: "=E9=99=88=E5=8D=8E=E6=89=8D" <chenhuacai@=
loongson.cn>
> > =E6=8A=84=E9=80=81: linux-efi@vger.kernel.org, linux-arm-kernel@lists.i=
nfradead.org, linux-kernel@vger.kernel.org, "James E.J. Bottomley" <James.B=
ottomley@hansenpartnership.com>, "Matthew Garrett" <mjg59@srcf.ucam.org>, "=
Peter Jones" <pjones@redhat.com>, "Ilias Apalodimas" <ilias.apalodimas@lina=
ro.org>, "Heinrich Schuchardt" <heinrich.schuchardt@canonical.com>, "AKASHI=
 Takahiro" <takahiro.akashi@linaro.org>, "Palmer Dabbelt" <palmer@dabbelt.c=
om>, "Atish Patra" <atishp@atishpatra.org>, "Arnd Bergmann" <arnd@arndb.de>=
, "Xi Ruoyao" <xry111@xry111.site>, "Lennart Poettering" <lennart@poetterin=
g.net>, "Jeremy Linton" <jeremy.linton@arm.com>, "Will Deacon" <will@kernel=
.org>, "Catalin Marinas" <catalin.marinas@arm.com>
> > =E4=B8=BB=E9=A2=98: Re: [PATCH v5 8/8] loongarch: efi: enable generic E=
FI compressed boot
> >
> > On Sat, 10 Sept 2022 at 15:22, =E9=99=88=E5=8D=8E=E6=89=8D <chenhuacai@=
loongson.cn> wrote:
> > >
> > > Hi, Ard,
> > >
> > > I prefer to give a chance to disable ZBOOT, so I don't want to select=
 EFI_ZBOOT unconditionally in Kconfig, and then the Makefile can be like th=
is:
> > > diff --git a/arch/loongarch/Makefile b/arch/loongarch/Makefile
> > > index c3f579bdf9e5..bc6fe65125f5 100644
> > > --- a/arch/loongarch/Makefile
> > > +++ b/arch/loongarch/Makefile
> > > @@ -14,6 +14,10 @@ else
> > >  KBUILD_IMAGE   :=3D $(boot)/vmlinux.efi
> > >  endif
> > >
> > > +ifdef CONFIG_EFI_ZBOOT
> > > +KBUILD_IMAGE    :=3D $(boot)/vmlinuz.efi
> > > +endif
> > > +
> > >  archscripts: scripts_basic
> > >         $(Q)$(MAKE) $(build)=3Darch/loongarch/boot/tools relocs
> > >
> >
> > OK, I will fold this in. This actually aligns it with the other
> > architectures, so I prefer this approach as well.
>
> Thank you, and if "make install" can also handle the zboot case, that's e=
ven better. :)
>
> diff --git a/arch/loongarch/Makefile b/arch/loongarch/Makefile
> index c3f579bdf9e5..5480fe2de7cd 100644
> --- a/arch/loongarch/Makefile
> +++ b/arch/loongarch/Makefile
> @@ -137,7 +137,11 @@ vmlinux.elf vmlinux.efi vmlinuz.efi: vmlinux
>  core-y +=3D arch/loongarch/boot/dts/
>
>  install:
> +ifndef CONFIG_EFI_ZBOOT
>         $(Q)install -D -m 755 $(KBUILD_IMAGE) $(INSTALL_PATH)/vmlinux-$(K=
ERNELRELEASE)
> +else
> +       $(Q)install -D -m 755 $(KBUILD_IMAGE) $(INSTALL_PATH)/vmlinuz-$(K=
ERNELRELEASE)
> +endif
>         $(Q)install -D -m 644 .config $(INSTALL_PATH)/config-$(KERNELRELE=
ASE)
>         $(Q)install -D -m 644 System.map $(INSTALL_PATH)/System.map-$(KER=
NELRELEASE)
>

Is there any reason in particular this is open coded like this? Other
architectures just do something like

install:
    $(call cmd,install)

and be done with it.
