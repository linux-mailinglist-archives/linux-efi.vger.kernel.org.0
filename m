Return-Path: <linux-efi+bounces-248-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1062781846C
	for <lists+linux-efi@lfdr.de>; Tue, 19 Dec 2023 10:30:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B390C280CD5
	for <lists+linux-efi@lfdr.de>; Tue, 19 Dec 2023 09:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE453134D2;
	Tue, 19 Dec 2023 09:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ydo22n/W"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41D913FF6
	for <linux-efi@vger.kernel.org>; Tue, 19 Dec 2023 09:30:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 602F7C433CD
	for <linux-efi@vger.kernel.org>; Tue, 19 Dec 2023 09:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702978249;
	bh=RNkZtbjv50OmYyb+/zjcwl0OfBEXfOZmDDPtSM3PH+g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Ydo22n/W8ftPA6LAovd+8FtKLgzZ9eTprSJU1NvZAzoPbSM8eGBLuasgCOmEgHGwT
	 KX+gt1EezGqgPB+qGCQ2aNbvdNX/W/htmtQtICAYDbScwfgZHXsA7h/wItimmX/oBY
	 pLSkMlQcCfGMZmoGTSTLQPtxbpGZVKFnqaBOkWuwC0oYmMDVE6g+28mZB6kS1KjCxR
	 06YhbW0pJTFf0D6HJH0s2m8ClVeMHJFkaiGQl8uKdmWCRUwyg9wguufcNj6IkRuCXa
	 yQR4otywArbLfOFoEA1v/Jbp5flbe0pI1z2C2+8CDr4KkVk91REg1xiLh0PBvtBbNc
	 pZqa9oZ87JqEQ==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-50e3901c2e2so2436606e87.0
        for <linux-efi@vger.kernel.org>; Tue, 19 Dec 2023 01:30:49 -0800 (PST)
X-Gm-Message-State: AOJu0Yzd4J3oRrYUpY6qawC0K1b4x534ltrEEXm5V1sptTJ7Z2kdaJRd
	XjSiMqXqyqOdbiwq0B/r/KaYERnz1kFuKuwkCDM=
X-Google-Smtp-Source: AGHT+IEN1cSBnp7VxqDxdWJSFJ/N4Xl2yi7248JMwxq2PE2Cvb8fTqtTyBI6sHuHpcheN4QmcVRStexWIoB+9W/R3Nc=
X-Received: by 2002:a05:6512:e88:b0:50c:be7:f322 with SMTP id
 bi8-20020a0565120e8800b0050c0be7f322mr11146254lfb.14.1702978247586; Tue, 19
 Dec 2023 01:30:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231219091405.39867-1-wangyao@lemote.com> <CAMj1kXEPdMBkne=ugR_j1Be8Aeh8jCA_ryHvh8rMA-c27i+RuA@mail.gmail.com>
 <CAPWE4_wydoTWHUYPmALp1oii+=ALVy_BTDUO_1wOo7XmkJ=cjA@mail.gmail.com>
In-Reply-To: <CAPWE4_wydoTWHUYPmALp1oii+=ALVy_BTDUO_1wOo7XmkJ=cjA@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 19 Dec 2023 10:30:36 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEL2nuVyNq1O=ytrCr3xh3tA6TU6kRFuk07H1EmneRTTg@mail.gmail.com>
Message-ID: <CAMj1kXEL2nuVyNq1O=ytrCr3xh3tA6TU6kRFuk07H1EmneRTTg@mail.gmail.com>
Subject: Re: [PATCH v2] efi/loongarch: Directly position the loaded image file
To: Ainux Wang <ainux.wang@gmail.com>
Cc: wangyao@lemote.com, chenhuacai@kernel.org, wangrui@loongson.cn, 
	linux-efi@vger.kernel.org, loongarch@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 19 Dec 2023 at 10:27, Ainux Wang <ainux.wang@gmail.com> wrote:
>
> Ard Biesheuvel <ardb@kernel.org> =E4=BA=8E2023=E5=B9=B412=E6=9C=8819=E6=
=97=A5=E5=91=A8=E4=BA=8C 17:22=E5=86=99=E9=81=93=EF=BC=9A
> >
> > On Tue, 19 Dec 2023 at 10:14, <wangyao@lemote.com> wrote:
> > >
> > > From: Wang Yao <wangyao@lemote.com>
> > >
> > > The use of the 'kernel_offset' variable to position the image file th=
at
> > > has been loaded by UEFI or GRUB is unnecessary, because we can direct=
ly
> > > position the loaded image file through using the image_base field of =
the
> > > efi_loaded_image struct provided by UEFI.
> > >
> > > Replace kernel_offset with image_base to positon the image file that =
has
> > > been loaded by UEFI or GRUB.
> > >
> > > Signed-off-by: Wang Yao <wangyao@lemote.com>
> > > ---
> > >
> > > v1->v2:
> > > Rewrite the commit log include 'why', not just include 'how'.
> > >
> > >  arch/loongarch/include/asm/efi.h              | 2 --
> > >  arch/loongarch/kernel/head.S                  | 1 -
> > >  arch/loongarch/kernel/image-vars.h            | 1 -
> > >  arch/loongarch/kernel/vmlinux.lds.S           | 1 -
> > >  drivers/firmware/efi/libstub/loongarch-stub.c | 9 +++++----
> > >  drivers/firmware/efi/libstub/loongarch-stub.h | 4 ++++
> > >  drivers/firmware/efi/libstub/loongarch.c      | 6 ++++--
> > >  7 files changed, 13 insertions(+), 11 deletions(-)
> > >  create mode 100644 drivers/firmware/efi/libstub/loongarch-stub.h
> > >
> > > diff --git a/arch/loongarch/include/asm/efi.h b/arch/loongarch/includ=
e/asm/efi.h
> > > index 91d81f9730ab..eddc8e79b3fa 100644
> > > --- a/arch/loongarch/include/asm/efi.h
> > > +++ b/arch/loongarch/include/asm/efi.h
> > > @@ -32,6 +32,4 @@ static inline unsigned long efi_get_kimg_min_align(=
void)
> > >
> > >  #define EFI_KIMG_PREFERRED_ADDRESS     PHYSADDR(VMLINUX_LOAD_ADDRESS=
)
> > >
> > > -unsigned long kernel_entry_address(unsigned long kernel_addr);
> > > -
> >
> > Why are you removing this? Won't that cause missing prototype warnings?
> >
> > The rest of the patch looks fine to me, but I haven't tested it.
> >
>
> Because the efi_loaded_image_t struct is defined in the efistub.h.
>

And the other question?

