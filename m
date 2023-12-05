Return-Path: <linux-efi+bounces-120-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E05EF8049F9
	for <lists+linux-efi@lfdr.de>; Tue,  5 Dec 2023 07:24:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DAAC2815BA
	for <lists+linux-efi@lfdr.de>; Tue,  5 Dec 2023 06:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DB441094E;
	Tue,  5 Dec 2023 06:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i3z0r6J4"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33A17D7
	for <linux-efi@vger.kernel.org>; Mon,  4 Dec 2023 22:24:26 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-db35caa1749so3557304276.2
        for <linux-efi@vger.kernel.org>; Mon, 04 Dec 2023 22:24:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701757465; x=1702362265; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y462tnTOP+xhskFEZ1wt9WM02fnlhXUkYQV0xgyNtY0=;
        b=i3z0r6J4lCD2SPY1Y8+I2v18wqjkWZXiD7CEvVTOYNSmu5qemHbqY7dqAOZG+UWxze
         Zp6b5BbL8wwOmjISE8IVs8KnT7ONm/Thd9xpCUW9tSQzefY/bGucmNehDF8NUc2sUsM7
         thGP7WNafm1APCpXjshIiOvDKDO/pgEhisiV1Hs3BlwXTfWtff6GoTPruoDjIjsg0CGW
         z8VR6F0NtTX4MablZHLfCHRk9R1EzwCJ7uoJWYanGURLjVL+Vkv9qDZ0BIbUUf3QYq+4
         h63Byl/rCHrh6ZRm2WayGsn2qMAmL9/spK+bz9nKpWyoeXIKVDyF+nzhQ6dwBfmf1BhN
         zYlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701757465; x=1702362265;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y462tnTOP+xhskFEZ1wt9WM02fnlhXUkYQV0xgyNtY0=;
        b=uKzk1+rdMvs2dcqfE7gpzhb/wcG5Angrzw1wuaY0KofnDvvMKD2D7w6JjcFiyYuInA
         RUh9JgqTcdfn+pIcBoZfKUHu1XiFuZRGW2CkaOSSLVpLq6ZByuwQMhZLjdJ1KbHLV+Gq
         Uuh5UzAJvKu7x5mAPjz3JJoaEyq1wRA3wUlWZmuIhawERUk9gDgPTP0xPPqpH/f2dbIg
         6rcpJtOuOarXR0PXxVql1H1oPvTjcnZFmuJF4P2dchsBWZFEvVQjOyiQqh/W+5qjszGG
         lyAFv8pXyngqgf1uKpuO5a3Jn74t/5yelhSl9ps69tuqK1gzqb8DluvhaaxYm5TwpAaI
         L5iQ==
X-Gm-Message-State: AOJu0Yx2CSr/u1O/vJEO/iHkWWWm+LeBd47knOb6hV5yvK1C8S//a2i9
	BTHBUmbCNDhnTl7d0scqXrMdmVKf9d7TzTQWxgk=
X-Google-Smtp-Source: AGHT+IFrq4b8kmRVClOUSamtxIVAdR4LlS55j94qPni55M3Jrz5ZetrflQ+zej/hJ/BWUywsWrOAqu7ES+891vsAxpo=
X-Received: by 2002:a05:6902:251:b0:db7:dacf:3fa7 with SMTP id
 k17-20020a056902025100b00db7dacf3fa7mr3579207ybs.84.1701757465384; Mon, 04
 Dec 2023 22:24:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231205060345.7742-1-wangyao@lemote.com> <20231205060345.7742-3-wangyao@lemote.com>
 <CAAhV-H4ou+rMOKT=GvWD2f9j4CiQ5VC13hYMeaU5ecOaDjLTwQ@mail.gmail.com>
 <CAPWE4_zrq=9FQ=bEh85Eo03CTWF=Nn1_OM=uvoY5ti_m+sWbhg@mail.gmail.com> <CAAhV-H5x-ige6uxiL_oVqOw54Vm1V0d4aNNtUTerobaqQx6Nqw@mail.gmail.com>
In-Reply-To: <CAAhV-H5x-ige6uxiL_oVqOw54Vm1V0d4aNNtUTerobaqQx6Nqw@mail.gmail.com>
From: Ainux Wang <ainux.wang@gmail.com>
Date: Tue, 5 Dec 2023 14:23:49 +0800
Message-ID: <CAPWE4_x_XQRsRc4ZEQHv5cy-_A2EchT7TvfTVYmjJL-NjW0WgQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] efi/loongarch: load address is not equal to link address
To: Huacai Chen <chenhuacai@kernel.org>
Cc: wangyao@lemote.com, ardb@kernel.org, wangrui@loongson.cn, 
	linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Huacai Chen <chenhuacai@kernel.org> =E4=BA=8E2023=E5=B9=B412=E6=9C=885=E6=
=97=A5=E5=91=A8=E4=BA=8C 14:18=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue, Dec 5, 2023 at 2:16=E2=80=AFPM Ainux Wang <ainux.wang@gmail.com> =
wrote:
> >
> > Huacai Chen <chenhuacai@kernel.org> =E4=BA=8E2023=E5=B9=B412=E6=9C=885=
=E6=97=A5=E5=91=A8=E4=BA=8C 14:09=E5=86=99=E9=81=93=EF=BC=9A
> > >
> > > Why send a test patch?
> > >
> >
> > Confirm the accuracy of the testing method
>
> Don't use maillist to do this.

Sorry, I don't know about this :-(

>
> >
> > > On Tue, Dec 5, 2023 at 2:04=E2=80=AFPM <wangyao@lemote.com> wrote:
> > > >
> > > > From: Wang Yao <wangyao@lemote.com>
> > > >
> > > > This is a test patch for PIE kernel that load address is not equal =
to
> > > > link address.
> > > >
> > > > Signed-off-by: Wang Yao <wangyao@lemote.com>
> > > > ---
> > > >  drivers/firmware/efi/libstub/loongarch-stub.c | 12 +++++++++++-
> > > >  1 file changed, 11 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/firmware/efi/libstub/loongarch-stub.c b/driver=
s/firmware/efi/libstub/loongarch-stub.c
> > > > index d6ec5d4b8dbe..c13c022d18cf 100644
> > > > --- a/drivers/firmware/efi/libstub/loongarch-stub.c
> > > > +++ b/drivers/firmware/efi/libstub/loongarch-stub.c
> > > > @@ -22,12 +22,22 @@ efi_status_t handle_kernel_image(unsigned long =
*image_addr,
> > > >                                  efi_handle_t image_handle)
> > > >  {
> > > >         efi_status_t status;
> > > > -       unsigned long kernel_addr =3D 0;
> > > > +       unsigned long kernel_addr =3D 0, tmp_addr =3D 0;
> > > >
> > > >         kernel_addr =3D (unsigned long)&kernel_offset - kernel_offs=
et;
> > > >
> > > > +       /*
> > > > +        * Allocate 2M space at 0x200000(EFI_KIMG_PREFERRED_ADDRESS=
) for
> > > > +        * test, this will lead to the kernel be loaded at 0x400000=
0.
> > > > +        */
> > > > +       status =3D efi_relocate_kernel(&tmp_addr, 0x100000, 0x20000=
0,
> > > > +                    EFI_KIMG_PREFERRED_ADDRESS, efi_get_kimg_min_a=
lign(), 0x0);
> > > > +       efi_info("@@@[%s] tmp_addr: 0x%lx\n", __func__, tmp_addr);
> > > > +
> > > > +       /* kernel_addr =3D=3D 0x400000 */
> > > >         status =3D efi_relocate_kernel(&kernel_addr, kernel_fsize, =
kernel_asize,
> > > >                      EFI_KIMG_PREFERRED_ADDRESS, efi_get_kimg_min_a=
lign(), 0x0);
> > > > +       efi_info("@@@[%s] kernel_addr: 0x%lx\n", __func__, kernel_a=
ddr);
> > > >
> > > >         *image_addr =3D kernel_addr;
> > > >         *image_size =3D kernel_asize;
> > > > --
> > > > 2.27.0
> > > >

