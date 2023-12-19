Return-Path: <linux-efi+bounces-249-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C271481847A
	for <lists+linux-efi@lfdr.de>; Tue, 19 Dec 2023 10:32:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6260D1F26742
	for <lists+linux-efi@lfdr.de>; Tue, 19 Dec 2023 09:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 643D613AF9;
	Tue, 19 Dec 2023 09:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QVpSd/Wb"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2700613ADB
	for <linux-efi@vger.kernel.org>; Tue, 19 Dec 2023 09:32:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11EEAC433CA
	for <linux-efi@vger.kernel.org>; Tue, 19 Dec 2023 09:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702978350;
	bh=oRnCT+p/rVRfurChXU1xks4v70KCWsChZkH3+pXdnzA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=QVpSd/WbCjgnLei1aWNtz/kKa9ZGwC9AiNrM28PdjqeXG0LbJHi148+UV7RsvVGm6
	 VAvS5Mb+h7NABzdJjDtzU7VFinQGMuF4mWZvrHUHG4i5Y42v5P60T8rG6bqRF0eRFw
	 3gAEKstk2NvxYTa1WhS77E8sSdbipkye1ef9b/LaJTbcoKWBxWQp9KaB/5w84qkrFC
	 RItEJAUDpzEjfqvpis2evV6S8tuOqEpXugEp8onwO7LqVp7S01cfl8EWAav3Z7l0OU
	 KYwu6vmZfleANWAFGT37gkX961ahGupQdNrorlbLMgNR7XE9/eECF94E97vq60Y/T0
	 QbilCi3j6PkqQ==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-50e281b149aso3566865e87.1
        for <linux-efi@vger.kernel.org>; Tue, 19 Dec 2023 01:32:29 -0800 (PST)
X-Gm-Message-State: AOJu0Yz3Ml67VAxHyImmwhxMoA7HCyY/TPWCsRzk+aWQZSngKcqCMMd/
	r7ZJ/9qihqNwt5dvscD6xZlFJYlZY9CGftuGwJM=
X-Google-Smtp-Source: AGHT+IEPZY5vnYM902pQe1ukhnYBhcLPSb1c4xAeIto+pN/8Yl+1xJgIwbPNIQaGfd0MxLGheewLDRfD/hLIOee/vYA=
X-Received: by 2002:a19:7606:0:b0:50e:31b0:f550 with SMTP id
 c6-20020a197606000000b0050e31b0f550mr1617943lff.48.1702978348227; Tue, 19 Dec
 2023 01:32:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231219091405.39867-1-wangyao@lemote.com> <CAMj1kXEPdMBkne=ugR_j1Be8Aeh8jCA_ryHvh8rMA-c27i+RuA@mail.gmail.com>
 <CAPWE4_wydoTWHUYPmALp1oii+=ALVy_BTDUO_1wOo7XmkJ=cjA@mail.gmail.com> <CAMj1kXEL2nuVyNq1O=ytrCr3xh3tA6TU6kRFuk07H1EmneRTTg@mail.gmail.com>
In-Reply-To: <CAMj1kXEL2nuVyNq1O=ytrCr3xh3tA6TU6kRFuk07H1EmneRTTg@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 19 Dec 2023 10:32:17 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFqpJvH0ukOTufsLCTyCk1abct1kaPUV3JTaS6hMb75Og@mail.gmail.com>
Message-ID: <CAMj1kXFqpJvH0ukOTufsLCTyCk1abct1kaPUV3JTaS6hMb75Og@mail.gmail.com>
Subject: Re: [PATCH v2] efi/loongarch: Directly position the loaded image file
To: Ainux Wang <ainux.wang@gmail.com>
Cc: wangyao@lemote.com, chenhuacai@kernel.org, wangrui@loongson.cn, 
	linux-efi@vger.kernel.org, loongarch@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 19 Dec 2023 at 10:30, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Tue, 19 Dec 2023 at 10:27, Ainux Wang <ainux.wang@gmail.com> wrote:
> >
> > Ard Biesheuvel <ardb@kernel.org> =E4=BA=8E2023=E5=B9=B412=E6=9C=8819=E6=
=97=A5=E5=91=A8=E4=BA=8C 17:22=E5=86=99=E9=81=93=EF=BC=9A
> > >
> > > On Tue, 19 Dec 2023 at 10:14, <wangyao@lemote.com> wrote:
> > > >
> > > > From: Wang Yao <wangyao@lemote.com>
> > > >
> > > > The use of the 'kernel_offset' variable to position the image file =
that
> > > > has been loaded by UEFI or GRUB is unnecessary, because we can dire=
ctly
> > > > position the loaded image file through using the image_base field o=
f the
> > > > efi_loaded_image struct provided by UEFI.
> > > >
> > > > Replace kernel_offset with image_base to positon the image file tha=
t has
> > > > been loaded by UEFI or GRUB.
> > > >
> > > > Signed-off-by: Wang Yao <wangyao@lemote.com>
> > > > ---
> > > >
> > > > v1->v2:
> > > > Rewrite the commit log include 'why', not just include 'how'.
> > > >
> > > >  arch/loongarch/include/asm/efi.h              | 2 --
> > > >  arch/loongarch/kernel/head.S                  | 1 -
> > > >  arch/loongarch/kernel/image-vars.h            | 1 -
> > > >  arch/loongarch/kernel/vmlinux.lds.S           | 1 -
> > > >  drivers/firmware/efi/libstub/loongarch-stub.c | 9 +++++----
> > > >  drivers/firmware/efi/libstub/loongarch-stub.h | 4 ++++
> > > >  drivers/firmware/efi/libstub/loongarch.c      | 6 ++++--
> > > >  7 files changed, 13 insertions(+), 11 deletions(-)
> > > >  create mode 100644 drivers/firmware/efi/libstub/loongarch-stub.h
> > > >
> > > > diff --git a/arch/loongarch/include/asm/efi.h b/arch/loongarch/incl=
ude/asm/efi.h
> > > > index 91d81f9730ab..eddc8e79b3fa 100644
> > > > --- a/arch/loongarch/include/asm/efi.h
> > > > +++ b/arch/loongarch/include/asm/efi.h
> > > > @@ -32,6 +32,4 @@ static inline unsigned long efi_get_kimg_min_alig=
n(void)
> > > >
> > > >  #define EFI_KIMG_PREFERRED_ADDRESS     PHYSADDR(VMLINUX_LOAD_ADDRE=
SS)
> > > >
> > > > -unsigned long kernel_entry_address(unsigned long kernel_addr);
> > > > -
> > >
> > > Why are you removing this? Won't that cause missing prototype warning=
s?
> > >
> > > The rest of the patch looks fine to me, but I haven't tested it.
> > >
> >
> > Because the efi_loaded_image_t struct is defined in the efistub.h.
> >
>
> And the other question?

OK, you replied to me in private

> So move the kernel_entry_address to the
> drivers/firmware/efi/libstub/loongarch-stub.h
>

which I missed when looking at the patch. So no, this should not cause
missing prototypes warnings.

I'll queue this up.

Thanks,

