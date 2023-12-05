Return-Path: <linux-efi+bounces-121-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 754BE804B47
	for <lists+linux-efi@lfdr.de>; Tue,  5 Dec 2023 08:41:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5CC51C20CE6
	for <lists+linux-efi@lfdr.de>; Tue,  5 Dec 2023 07:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CD0C241E5;
	Tue,  5 Dec 2023 07:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DJpuUO3R"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E338B1A70C
	for <linux-efi@vger.kernel.org>; Tue,  5 Dec 2023 07:41:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63539C433CC
	for <linux-efi@vger.kernel.org>; Tue,  5 Dec 2023 07:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701762095;
	bh=gCxKZBrtpkXGvSqM7jPkDlNYLIX/6gq6V8RDicUtNTM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=DJpuUO3RnpGsaU4UB7FxSrK1j4MDvBOlLA1eXd5r1h3mKftZe0D9XbF3t7jf8rqCc
	 RpiVXtV4kjscnifiN09hQteSCCgbZJz64Qd/qBEJv1P6vebLHy2gr/le+JtpNN3ssU
	 e+q96X9cW2OCsgfe1qb7vXrvM/6VnRJf4qsXjmITfKHfGVTOftwATmjRSpYBT64y9j
	 CCbYl6Suh+3npZnlQhz30vjx2ABpiZCqBNjB3O+YKHu9F0HVZP+URIaWUMxutRqcmE
	 t1Js8hLxIyJMZ08k9cUxqZD5sYyHI9n0nXDV/mYsMZ+LCTmQXVmuYNIWzFHiasy9Xp
	 yBigcXekdYmrQ==
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a18f732dc83so930518266b.1
        for <linux-efi@vger.kernel.org>; Mon, 04 Dec 2023 23:41:35 -0800 (PST)
X-Gm-Message-State: AOJu0Yy43yt/Iu4SNrcHRRt3FmBptjtvWSoGnFEQMPCmGtTqDIni36IW
	tk8p45ohxfiIuBW8EYKkMP7dS04EIj32peWHKx8=
X-Google-Smtp-Source: AGHT+IF38MXV4apyzZFXs9mHJVJxLqYxQxx10YpzCfyyyi73+5ILyOM9TFDHLVUhHHZkbbpvd1siiRki4d5BTDKkvG0=
X-Received: by 2002:a17:906:3b0d:b0:a19:a409:37ee with SMTP id
 g13-20020a1709063b0d00b00a19a40937eemr624826ejf.71.1701762093780; Mon, 04 Dec
 2023 23:41:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231205060345.7742-1-wangyao@lemote.com> <20231205060345.7742-3-wangyao@lemote.com>
 <CAAhV-H4ou+rMOKT=GvWD2f9j4CiQ5VC13hYMeaU5ecOaDjLTwQ@mail.gmail.com>
 <CAPWE4_zrq=9FQ=bEh85Eo03CTWF=Nn1_OM=uvoY5ti_m+sWbhg@mail.gmail.com>
 <CAAhV-H5x-ige6uxiL_oVqOw54Vm1V0d4aNNtUTerobaqQx6Nqw@mail.gmail.com> <CAPWE4_x_XQRsRc4ZEQHv5cy-_A2EchT7TvfTVYmjJL-NjW0WgQ@mail.gmail.com>
In-Reply-To: <CAPWE4_x_XQRsRc4ZEQHv5cy-_A2EchT7TvfTVYmjJL-NjW0WgQ@mail.gmail.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Tue, 5 Dec 2023 15:41:22 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7NJuMMS_hyyouH7n7xpcXSCLeMKdVk68n9F2OvzOB9Uw@mail.gmail.com>
Message-ID: <CAAhV-H7NJuMMS_hyyouH7n7xpcXSCLeMKdVk68n9F2OvzOB9Uw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] efi/loongarch: load address is not equal to link address
To: Ainux Wang <ainux.wang@gmail.com>
Cc: wangyao@lemote.com, ardb@kernel.org, wangrui@loongson.cn, 
	linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 5, 2023 at 2:24=E2=80=AFPM Ainux Wang <ainux.wang@gmail.com> wr=
ote:
>
> Huacai Chen <chenhuacai@kernel.org> =E4=BA=8E2023=E5=B9=B412=E6=9C=885=E6=
=97=A5=E5=91=A8=E4=BA=8C 14:18=E5=86=99=E9=81=93=EF=BC=9A
> >
> > On Tue, Dec 5, 2023 at 2:16=E2=80=AFPM Ainux Wang <ainux.wang@gmail.com=
> wrote:
> > >
> > > Huacai Chen <chenhuacai@kernel.org> =E4=BA=8E2023=E5=B9=B412=E6=9C=88=
5=E6=97=A5=E5=91=A8=E4=BA=8C 14:09=E5=86=99=E9=81=93=EF=BC=9A
> > > >
> > > > Why send a test patch?
> > > >
> > >
> > > Confirm the accuracy of the testing method
> >
> > Don't use maillist to do this.
>
> Sorry, I don't know about this :-(
But from this patch, you only test the vmlinux.efi not loaded at link
address, but haven't tested the vmlinuz.efi not decompressed to the
link address. You should test that, but don't submit patches for that.

>
> >
> > >
> > > > On Tue, Dec 5, 2023 at 2:04=E2=80=AFPM <wangyao@lemote.com> wrote:
> > > > >
> > > > > From: Wang Yao <wangyao@lemote.com>
> > > > >
> > > > > This is a test patch for PIE kernel that load address is not equa=
l to
> > > > > link address.
> > > > >
> > > > > Signed-off-by: Wang Yao <wangyao@lemote.com>
> > > > > ---
> > > > >  drivers/firmware/efi/libstub/loongarch-stub.c | 12 +++++++++++-
> > > > >  1 file changed, 11 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/drivers/firmware/efi/libstub/loongarch-stub.c b/driv=
ers/firmware/efi/libstub/loongarch-stub.c
> > > > > index d6ec5d4b8dbe..c13c022d18cf 100644
> > > > > --- a/drivers/firmware/efi/libstub/loongarch-stub.c
> > > > > +++ b/drivers/firmware/efi/libstub/loongarch-stub.c
> > > > > @@ -22,12 +22,22 @@ efi_status_t handle_kernel_image(unsigned lon=
g *image_addr,
> > > > >                                  efi_handle_t image_handle)
> > > > >  {
> > > > >         efi_status_t status;
> > > > > -       unsigned long kernel_addr =3D 0;
> > > > > +       unsigned long kernel_addr =3D 0, tmp_addr =3D 0;
> > > > >
> > > > >         kernel_addr =3D (unsigned long)&kernel_offset - kernel_of=
fset;
> > > > >
> > > > > +       /*
> > > > > +        * Allocate 2M space at 0x200000(EFI_KIMG_PREFERRED_ADDRE=
SS) for
> > > > > +        * test, this will lead to the kernel be loaded at 0x4000=
000.
> > > > > +        */
> > > > > +       status =3D efi_relocate_kernel(&tmp_addr, 0x100000, 0x200=
000,
> > > > > +                    EFI_KIMG_PREFERRED_ADDRESS, efi_get_kimg_min=
_align(), 0x0);
> > > > > +       efi_info("@@@[%s] tmp_addr: 0x%lx\n", __func__, tmp_addr)=
;
> > > > > +
> > > > > +       /* kernel_addr =3D=3D 0x400000 */
> > > > >         status =3D efi_relocate_kernel(&kernel_addr, kernel_fsize=
, kernel_asize,
> > > > >                      EFI_KIMG_PREFERRED_ADDRESS, efi_get_kimg_min=
_align(), 0x0);
> > > > > +       efi_info("@@@[%s] kernel_addr: 0x%lx\n", __func__, kernel=
_addr);
> > > > >
> > > > >         *image_addr =3D kernel_addr;
> > > > >         *image_size =3D kernel_asize;
> > > > > --
> > > > > 2.27.0
> > > > >

