Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 732CC5A37E9
	for <lists+linux-efi@lfdr.de>; Sat, 27 Aug 2022 15:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbiH0N1j (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 27 Aug 2022 09:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbiH0N1i (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 27 Aug 2022 09:27:38 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0BC37AC3A
        for <linux-efi@vger.kernel.org>; Sat, 27 Aug 2022 06:27:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D75F9CE01BC
        for <linux-efi@vger.kernel.org>; Sat, 27 Aug 2022 13:27:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D5EFC43143
        for <linux-efi@vger.kernel.org>; Sat, 27 Aug 2022 13:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661606854;
        bh=uOLfS/GgDYDJ36K34FD8ZBngFpl0n/bSL2PfPHeQEZk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WI6NeyRnuVPfYAoklYSqjru/J+9Lm7uZclpeydQa58dodwZhyligSdhNIQaHa9H8I
         zShaOfsH3TzMaL1bzvBdaVUe3pNVOIggexxGj0RG+HCdUfZn9GCTKSBvcAg2LN+Q2d
         UqmM2aExEe8P4dQGD93oob1EaCESKvpsbDN28Yg4FAN6gfgcw/PY5Qn0raTqRbvzxP
         qq7OudMXebDyp8WtkVm293/fRcfUYu0TgNEsGBnhSVF39pJErGlJcYIZv0z7zHTCoR
         jK6Vb9JLi1tFNiZcrwhcpFy6ESD9dMV0mO6CihlItg9UfxAUSiwbZQSOg6EdE2Z7YS
         xbS2PnpxWcc/w==
Received: by mail-wm1-f41.google.com with SMTP id k6-20020a05600c1c8600b003a54ecc62f6so2158324wms.5
        for <linux-efi@vger.kernel.org>; Sat, 27 Aug 2022 06:27:34 -0700 (PDT)
X-Gm-Message-State: ACgBeo0/PWm/El95rcs6GdN3OerWv64vo64ho1AFmkv68E4AJPBitH5x
        L2TlGBl01Lzw7tCdndvDjs14CLHUdctucPorFqs=
X-Google-Smtp-Source: AA6agR4sY0r+ifUCaAvlMd/0WwK2TqjAGBe2WdunhXddhB0ZUKW4S/qyh+Iq739Ad6hL/0425vE4di10KcqpwoTnkGU=
X-Received: by 2002:a05:600c:384f:b0:3a6:603c:4338 with SMTP id
 s15-20020a05600c384f00b003a6603c4338mr2360171wmr.192.1661606852188; Sat, 27
 Aug 2022 06:27:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220827083850.2702465-1-ardb@kernel.org> <20220827083850.2702465-9-ardb@kernel.org>
 <7aa14d72.3a4f.182deccc341.Coremail.chenhuacai@loongson.cn>
In-Reply-To: <7aa14d72.3a4f.182deccc341.Coremail.chenhuacai@loongson.cn>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sat, 27 Aug 2022 15:27:20 +0200
X-Gmail-Original-Message-ID: <CAMj1kXG4CXUEtx9r=r-sOyU6cUmDaknKqu3_W_FUQ+_gpdLzXg@mail.gmail.com>
Message-ID: <CAMj1kXG4CXUEtx9r=r-sOyU6cUmDaknKqu3_W_FUQ+_gpdLzXg@mail.gmail.com>
Subject: Re: [PATCH v4 8/9] loongarch: avoid orphan input sections
To:     =?UTF-8?B?6ZmI5Y2O5omN?= <chenhuacai@loongson.cn>
Cc:     linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
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
        Jeremy Linton <jeremy.linton@arm.com>
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

On Sat, 27 Aug 2022 at 12:16, =E9=99=88=E5=8D=8E=E6=89=8D <chenhuacai@loong=
son.cn> wrote:
>
> Hi, Ard,
>
> It seems that this patch is a normal bugfix and has no relation with this=
 series. If so, I prefer to take into loongarch-fixes for 6.0-rc4. Thanks.
>

It does have a relation: the signing tool will complain because the
PE/COFF metadata goes out of sync, like so

  SBSIGN  arch/loongarch/boot/vmlinux.efi.signed
warning: data remaining[20754944 vs 20755016]: gaps between PE/COFF section=
s?

This is because of the *(.rela.dyn) section created by the linker,
which is appended after the .data section, and so the PE/COFF .data
section size does not match the file size.

*However*, you explained to me that vmlinux is not a PIC binary, and
the link should be non-PIE as well. So this looks like another
toolchain issue to me, that you may want to look into.

(The .rela.dyn section typically contains relocations applied by
ld.so, either to PIE executables, or to shared libraries. It is
probably harmless given that the loongarch kernel runs from its link
time address, but it is still odd that this section is being
generated)

Anyway, I will drop this patch from the series - I will leave it up to
you entirely how you prefer to fix this.





>
> > -----=E5=8E=9F=E5=A7=8B=E9=82=AE=E4=BB=B6-----
> > =E5=8F=91=E4=BB=B6=E4=BA=BA: "Ard Biesheuvel" <ardb@kernel.org>
> > =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4:2022-08-27 16:38:49 (=E6=98=9F=E6=
=9C=9F=E5=85=AD)
> > =E6=94=B6=E4=BB=B6=E4=BA=BA: linux-efi@vger.kernel.org
> > =E6=8A=84=E9=80=81: linux-arm-kernel@lists.infradead.org, "Ard Biesheuv=
el" <ardb@kernel.org>, "James E.J. Bottomley" <James.Bottomley@HansenPartne=
rship.com>, "Matthew Garrett" <mjg59@srcf.ucam.org>, "Peter Jones" <pjones@=
redhat.com>, "Ilias Apalodimas" <ilias.apalodimas@linaro.org>, "Heinrich Sc=
huchardt" <heinrich.schuchardt@canonical.com>, "AKASHI Takahiro" <takahiro.=
akashi@linaro.org>, "Palmer Dabbelt" <palmer@dabbelt.com>, "Atish Patra" <a=
tishp@atishpatra.org>, "Arnd Bergmann" <arnd@arndb.de>, "Huacai Chen" <chen=
huacai@loongson.cn>, "Xi Ruoyao" <xry111@xry111.site>, "Lennart Poettering"=
 <lennart@poettering.net>, "Jeremy Linton" <jeremy.linton@arm.com>
> > =E4=B8=BB=E9=A2=98: [PATCH v4 8/9] loongarch: avoid orphan input sectio=
ns
> >
> > Ensure that all input sections are listed explicitly in the linker
> > script, and issue a warning otherwise. This ensures that the binary
> > image matches the PE/COFF and other image metadata exactly, which is
> > important for things like code signing.
> >
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
> >  arch/loongarch/Kconfig              | 1 +
> >  arch/loongarch/kernel/vmlinux.lds.S | 2 ++
> >  2 files changed, 3 insertions(+)
> >
> > diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> > index fca106a8b8af..407502da4335 100644
> > --- a/arch/loongarch/Kconfig
> > +++ b/arch/loongarch/Kconfig
> > @@ -51,6 +51,7 @@ config LOONGARCH
> >       select ARCH_USE_CMPXCHG_LOCKREF
> >       select ARCH_USE_QUEUED_RWLOCKS
> >       select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT
> > +     select ARCH_WANT_LD_ORPHAN_WARN
> >       select ARCH_WANTS_NO_INSTR
> >       select BUILDTIME_TABLE_SORT
> >       select COMMON_CLK
> > diff --git a/arch/loongarch/kernel/vmlinux.lds.S b/arch/loongarch/kerne=
l/vmlinux.lds.S
> > index 36d042739f3c..17d33308dfba 100644
> > --- a/arch/loongarch/kernel/vmlinux.lds.S
> > +++ b/arch/loongarch/kernel/vmlinux.lds.S
> > @@ -74,6 +74,8 @@ SECTIONS
> >               EXIT_DATA
> >       }
> >
> > +     .rela.dyn : { *(.rela.dyn) *(.rela*) }
> > +
> >  #ifdef CONFIG_SMP
> >       PERCPU_SECTION(1 << CONFIG_L1_CACHE_SHIFT)
> >  #endif
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
