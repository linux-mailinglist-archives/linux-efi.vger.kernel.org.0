Return-Path: <linux-efi+bounces-123-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2C7080535A
	for <lists+linux-efi@lfdr.de>; Tue,  5 Dec 2023 12:48:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FC851C20CDA
	for <lists+linux-efi@lfdr.de>; Tue,  5 Dec 2023 11:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1969159E2B;
	Tue,  5 Dec 2023 11:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JEtkvwkP"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB0159E2A
	for <linux-efi@vger.kernel.org>; Tue,  5 Dec 2023 11:48:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 852B1C433C8
	for <linux-efi@vger.kernel.org>; Tue,  5 Dec 2023 11:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701776919;
	bh=AnFPlNLNvIPi7ucCT6gFe7gtfIGXXETyN2sBVc+5vqY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=JEtkvwkPUd1lo7BFZm2H+EL3HFiANApfICB13mZt7A88+/GPjWf5cVHd7NBlOzeFE
	 HdkYYqdU+5OsZFT1qbQJEEEtVyuwpb5Maut3wTIN7m6iV6hNBs9fGXfM7ULFi3p0U6
	 +HaQdr2A50HSC+qWIqzaqbecsjuYW7AsmtX272Nfd3a1drHGuvrdREb7wubK5fDK6m
	 MX/XnP+QeGUaUNCZFsUYqAdOlHDySp27GfGWXosXUaz/GDX+po3kvIfjd5EI/fU1AG
	 hNXYzqVsleB97NWAK6rc3At7Yc/0hH8k5Y5AW78EsUxWiDBVdHNTYGiw/eCOpwdyo/
	 3kxJMf2/LPRAQ==
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a1b68ae40f0so212772266b.0
        for <linux-efi@vger.kernel.org>; Tue, 05 Dec 2023 03:48:39 -0800 (PST)
X-Gm-Message-State: AOJu0YxBoefHh42/fOAz3ShXHfdQLsgTA3resQKs3yby+0oZ3fLHXz47
	fpzGgcqf5E3PVOZXVFhmYqFpmbRcxu3/rg+F7bg=
X-Google-Smtp-Source: AGHT+IHIdqL++OvDHJ4DWeEMVv5+00jOvYoX8yjtxxVQqiWb4JHbnran6vUkf/ugsrxyn0RcW675AZEt9KrI5xby+f8=
X-Received: by 2002:a17:906:d0d0:b0:9fd:4bed:72af with SMTP id
 bq16-20020a170906d0d000b009fd4bed72afmr450423ejb.72.1701776917942; Tue, 05
 Dec 2023 03:48:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231205060345.7742-1-wangyao@lemote.com> <20231205060345.7742-3-wangyao@lemote.com>
 <CAAhV-H4ou+rMOKT=GvWD2f9j4CiQ5VC13hYMeaU5ecOaDjLTwQ@mail.gmail.com>
 <CAPWE4_zrq=9FQ=bEh85Eo03CTWF=Nn1_OM=uvoY5ti_m+sWbhg@mail.gmail.com>
 <CAAhV-H5x-ige6uxiL_oVqOw54Vm1V0d4aNNtUTerobaqQx6Nqw@mail.gmail.com>
 <CAPWE4_x_XQRsRc4ZEQHv5cy-_A2EchT7TvfTVYmjJL-NjW0WgQ@mail.gmail.com>
 <CAAhV-H7NJuMMS_hyyouH7n7xpcXSCLeMKdVk68n9F2OvzOB9Uw@mail.gmail.com> <CAPWE4_zv1hscnBN-sf0TBjc5-T58C_xuWqm1jrdUqx9mvPP5Gg@mail.gmail.com>
In-Reply-To: <CAPWE4_zv1hscnBN-sf0TBjc5-T58C_xuWqm1jrdUqx9mvPP5Gg@mail.gmail.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Tue, 5 Dec 2023 19:48:25 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4WE61RNJFw5=Q242CGUqcFi3yamuLpBa5HSey9npy2tA@mail.gmail.com>
Message-ID: <CAAhV-H4WE61RNJFw5=Q242CGUqcFi3yamuLpBa5HSey9npy2tA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] efi/loongarch: load address is not equal to link address
To: Ainux Wang <ainux.wang@gmail.com>
Cc: wangyao@lemote.com, ardb@kernel.org, wangrui@loongson.cn, 
	linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 5, 2023 at 4:19=E2=80=AFPM Ainux Wang <ainux.wang@gmail.com> wr=
ote:
>
> Huacai Chen <chenhuacai@kernel.org> =E4=BA=8E2023=E5=B9=B412=E6=9C=885=E6=
=97=A5=E5=91=A8=E4=BA=8C 15:41=E5=86=99=E9=81=93=EF=BC=9A
> >
> > On Tue, Dec 5, 2023 at 2:24=E2=80=AFPM Ainux Wang <ainux.wang@gmail.com=
> wrote:
> > >
> > > Huacai Chen <chenhuacai@kernel.org> =E4=BA=8E2023=E5=B9=B412=E6=9C=88=
5=E6=97=A5=E5=91=A8=E4=BA=8C 14:18=E5=86=99=E9=81=93=EF=BC=9A
> > > >
> > > > On Tue, Dec 5, 2023 at 2:16=E2=80=AFPM Ainux Wang <ainux.wang@gmail=
.com> wrote:
> > > > >
> > > > > Huacai Chen <chenhuacai@kernel.org> =E4=BA=8E2023=E5=B9=B412=E6=
=9C=885=E6=97=A5=E5=91=A8=E4=BA=8C 14:09=E5=86=99=E9=81=93=EF=BC=9A
> > > > > >
> > > > > > Why send a test patch?
> > > > > >
> > > > >
> > > > > Confirm the accuracy of the testing method
> > > >
> > > > Don't use maillist to do this.
> > >
> > > Sorry, I don't know about this :-(
> > But from this patch, you only test the vmlinux.efi not loaded at link
> > address, but haven't tested the vmlinuz.efi not decompressed to the
> > link address. You should test that, but don't submit patches for that.
>
> vmlinuz.efi decompress at 0x300000  is ok.
Then you can resend the first patch as v4, add:
Acked-by: Huacai Chen <chenhuacai@loongson.cn>


Huacai

>
> >
> > >
> > > >
> > > > >
> > > > > > On Tue, Dec 5, 2023 at 2:04=E2=80=AFPM <wangyao@lemote.com> wro=
te:
> > > > > > >
> > > > > > > From: Wang Yao <wangyao@lemote.com>
> > > > > > >
> > > > > > > This is a test patch for PIE kernel that load address is not =
equal to
> > > > > > > link address.
> > > > > > >
> > > > > > > Signed-off-by: Wang Yao <wangyao@lemote.com>
> > > > > > > ---
> > > > > > >  drivers/firmware/efi/libstub/loongarch-stub.c | 12 +++++++++=
++-
> > > > > > >  1 file changed, 11 insertions(+), 1 deletion(-)
> > > > > > >
> > > > > > > diff --git a/drivers/firmware/efi/libstub/loongarch-stub.c b/=
drivers/firmware/efi/libstub/loongarch-stub.c
> > > > > > > index d6ec5d4b8dbe..c13c022d18cf 100644
> > > > > > > --- a/drivers/firmware/efi/libstub/loongarch-stub.c
> > > > > > > +++ b/drivers/firmware/efi/libstub/loongarch-stub.c
> > > > > > > @@ -22,12 +22,22 @@ efi_status_t handle_kernel_image(unsigned=
 long *image_addr,
> > > > > > >                                  efi_handle_t image_handle)
> > > > > > >  {
> > > > > > >         efi_status_t status;
> > > > > > > -       unsigned long kernel_addr =3D 0;
> > > > > > > +       unsigned long kernel_addr =3D 0, tmp_addr =3D 0;
> > > > > > >
> > > > > > >         kernel_addr =3D (unsigned long)&kernel_offset - kerne=
l_offset;
> > > > > > >
> > > > > > > +       /*
> > > > > > > +        * Allocate 2M space at 0x200000(EFI_KIMG_PREFERRED_A=
DDRESS) for
> > > > > > > +        * test, this will lead to the kernel be loaded at 0x=
4000000.
> > > > > > > +        */
> > > > > > > +       status =3D efi_relocate_kernel(&tmp_addr, 0x100000, 0=
x200000,
> > > > > > > +                    EFI_KIMG_PREFERRED_ADDRESS, efi_get_kimg=
_min_align(), 0x0);
> > > > > > > +       efi_info("@@@[%s] tmp_addr: 0x%lx\n", __func__, tmp_a=
ddr);
> > > > > > > +
> > > > > > > +       /* kernel_addr =3D=3D 0x400000 */
> > > > > > >         status =3D efi_relocate_kernel(&kernel_addr, kernel_f=
size, kernel_asize,
> > > > > > >                      EFI_KIMG_PREFERRED_ADDRESS, efi_get_kimg=
_min_align(), 0x0);
> > > > > > > +       efi_info("@@@[%s] kernel_addr: 0x%lx\n", __func__, ke=
rnel_addr);
> > > > > > >
> > > > > > >         *image_addr =3D kernel_addr;
> > > > > > >         *image_size =3D kernel_asize;
> > > > > > > --
> > > > > > > 2.27.0
> > > > > > >

