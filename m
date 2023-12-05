Return-Path: <linux-efi+bounces-119-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD248049ED
	for <lists+linux-efi@lfdr.de>; Tue,  5 Dec 2023 07:18:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54DDD281582
	for <lists+linux-efi@lfdr.de>; Tue,  5 Dec 2023 06:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D533DDD2;
	Tue,  5 Dec 2023 06:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f30zaJ4b"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61469DDA7
	for <linux-efi@vger.kernel.org>; Tue,  5 Dec 2023 06:18:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE47EC433CB
	for <linux-efi@vger.kernel.org>; Tue,  5 Dec 2023 06:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701757107;
	bh=x4+ALb0R4HgL5m2l2M0vta4RKjmib+cnDlwi8vy5QwQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=f30zaJ4bsW3OT6Xx3nvMlDT+s7RToHIOeqiUnKfOwuM0qvDp7FXiFn6shWYEVjFdC
	 cg/xdFr2MImt+yRaO86lZRzuPSlUQIwoq4HbLCznxxYV9VFlnMXIrM5cm37LK1MTfV
	 /CgeE67MOkq12Rdze3xYl8MKND8+tTbjZJb44odg/m2AsEJRfiZKYs+WG+HyNbXXhb
	 vM/amukmjVOtgQksT27SNOehpwgfZgxJx1x+zO85VeDtU5ZSmL3jp94oaGrlReVeY+
	 F2r4MJOAsL1yY9IkfEiLF44i+fjyR+otE2lJbHDOU2SFfWCKyJW5p97ur3jsbj50bp
	 onf3LhUiOydsA==
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5482df11e73so6703423a12.0
        for <linux-efi@vger.kernel.org>; Mon, 04 Dec 2023 22:18:27 -0800 (PST)
X-Gm-Message-State: AOJu0YwyNyfENU5k1i1EXvgMFmVvldyOQXKwkBfYyjU80Q1t1wJuW4Rl
	BQy7XXJJMeM+7BQwTREclhcYeOzgdtyRW9oq5nA=
X-Google-Smtp-Source: AGHT+IHrMST2C2mAtdMn9nvx437EqqUNXmefBqgK1OilW+dcXnbmFqT4Y9351tY3kt25GeN8a7kKui7WXu5y18pIbss=
X-Received: by 2002:a50:c201:0:b0:54c:4837:9a86 with SMTP id
 n1-20020a50c201000000b0054c48379a86mr3954047edf.45.1701757106259; Mon, 04 Dec
 2023 22:18:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231205060345.7742-1-wangyao@lemote.com> <20231205060345.7742-3-wangyao@lemote.com>
 <CAAhV-H4ou+rMOKT=GvWD2f9j4CiQ5VC13hYMeaU5ecOaDjLTwQ@mail.gmail.com> <CAPWE4_zrq=9FQ=bEh85Eo03CTWF=Nn1_OM=uvoY5ti_m+sWbhg@mail.gmail.com>
In-Reply-To: <CAPWE4_zrq=9FQ=bEh85Eo03CTWF=Nn1_OM=uvoY5ti_m+sWbhg@mail.gmail.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Tue, 5 Dec 2023 14:18:14 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5x-ige6uxiL_oVqOw54Vm1V0d4aNNtUTerobaqQx6Nqw@mail.gmail.com>
Message-ID: <CAAhV-H5x-ige6uxiL_oVqOw54Vm1V0d4aNNtUTerobaqQx6Nqw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] efi/loongarch: load address is not equal to link address
To: Ainux Wang <ainux.wang@gmail.com>
Cc: wangyao@lemote.com, ardb@kernel.org, wangrui@loongson.cn, 
	linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 5, 2023 at 2:16=E2=80=AFPM Ainux Wang <ainux.wang@gmail.com> wr=
ote:
>
> Huacai Chen <chenhuacai@kernel.org> =E4=BA=8E2023=E5=B9=B412=E6=9C=885=E6=
=97=A5=E5=91=A8=E4=BA=8C 14:09=E5=86=99=E9=81=93=EF=BC=9A
> >
> > Why send a test patch?
> >
>
> Confirm the accuracy of the testing method

Don't use maillist to do this.

>
> > On Tue, Dec 5, 2023 at 2:04=E2=80=AFPM <wangyao@lemote.com> wrote:
> > >
> > > From: Wang Yao <wangyao@lemote.com>
> > >
> > > This is a test patch for PIE kernel that load address is not equal to
> > > link address.
> > >
> > > Signed-off-by: Wang Yao <wangyao@lemote.com>
> > > ---
> > >  drivers/firmware/efi/libstub/loongarch-stub.c | 12 +++++++++++-
> > >  1 file changed, 11 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/firmware/efi/libstub/loongarch-stub.c b/drivers/=
firmware/efi/libstub/loongarch-stub.c
> > > index d6ec5d4b8dbe..c13c022d18cf 100644
> > > --- a/drivers/firmware/efi/libstub/loongarch-stub.c
> > > +++ b/drivers/firmware/efi/libstub/loongarch-stub.c
> > > @@ -22,12 +22,22 @@ efi_status_t handle_kernel_image(unsigned long *i=
mage_addr,
> > >                                  efi_handle_t image_handle)
> > >  {
> > >         efi_status_t status;
> > > -       unsigned long kernel_addr =3D 0;
> > > +       unsigned long kernel_addr =3D 0, tmp_addr =3D 0;
> > >
> > >         kernel_addr =3D (unsigned long)&kernel_offset - kernel_offset=
;
> > >
> > > +       /*
> > > +        * Allocate 2M space at 0x200000(EFI_KIMG_PREFERRED_ADDRESS) =
for
> > > +        * test, this will lead to the kernel be loaded at 0x4000000.
> > > +        */
> > > +       status =3D efi_relocate_kernel(&tmp_addr, 0x100000, 0x200000,
> > > +                    EFI_KIMG_PREFERRED_ADDRESS, efi_get_kimg_min_ali=
gn(), 0x0);
> > > +       efi_info("@@@[%s] tmp_addr: 0x%lx\n", __func__, tmp_addr);
> > > +
> > > +       /* kernel_addr =3D=3D 0x400000 */
> > >         status =3D efi_relocate_kernel(&kernel_addr, kernel_fsize, ke=
rnel_asize,
> > >                      EFI_KIMG_PREFERRED_ADDRESS, efi_get_kimg_min_ali=
gn(), 0x0);
> > > +       efi_info("@@@[%s] kernel_addr: 0x%lx\n", __func__, kernel_add=
r);
> > >
> > >         *image_addr =3D kernel_addr;
> > >         *image_size =3D kernel_asize;
> > > --
> > > 2.27.0
> > >

