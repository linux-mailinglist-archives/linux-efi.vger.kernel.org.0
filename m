Return-Path: <linux-efi+bounces-82-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E4877F5743
	for <lists+linux-efi@lfdr.de>; Thu, 23 Nov 2023 05:05:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13C96281272
	for <lists+linux-efi@lfdr.de>; Thu, 23 Nov 2023 04:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6AA7AD45;
	Thu, 23 Nov 2023 04:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sFcmf8L6"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C908F57
	for <linux-efi@vger.kernel.org>; Thu, 23 Nov 2023 04:05:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EE7FC433B8
	for <linux-efi@vger.kernel.org>; Thu, 23 Nov 2023 04:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700712318;
	bh=lNgNi+H/qGXallGC7x7HCRHvs/+eYAJdhSD/LBA8WA4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=sFcmf8L6PUUPVS2UwZR6iTp1LtCJqWXlm9hvy7cmcSybgz2RJuk36q38gGVujAjOA
	 m2w6R0Xm+JM5UTx3z1F2xxf45DDGVPFtCnb3OLoPqwAqC6GpJNCGyxMgylJm2eHiMM
	 Dvc9jz6+x0qIiWCHfz+6/W5CIXQ7fV3RyEjwAmwI46iKpmCkyix7qk5FZW9uSCAxP5
	 iU77Gdi2T2b78bxIdosB3Pd9h9ElyGozVFZBBNlrCufrFPMHBY/wcVjszxjCjLmQvR
	 lICHtiViZdaz7qzM00RvIUbTzHFv2LLsurJC8LkPcLLGSpl4xxyt/dEBmESyP4A32r
	 +W6tN5Ix2GLMg==
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-9fcfd2a069aso52490166b.1
        for <linux-efi@vger.kernel.org>; Wed, 22 Nov 2023 20:05:18 -0800 (PST)
X-Gm-Message-State: AOJu0YyZ8UhcfJf7XCqaN02CPN+CO4ND3ycyNWbiXKb3IDtaN774fdhB
	uf1yXubgSnkoRYtTTmEXVyMm3njfKdCLaKbnJLc=
X-Google-Smtp-Source: AGHT+IGDz+89yPoh1aQLWKCI/IRfN04m+M+8T3M0cWTtdVwuIgDxpTkVu630PFHMU8lptDaSaTKz/oPvVQq76kupF+w=
X-Received: by 2002:a17:906:7f0e:b0:a02:a2fb:7b with SMTP id
 d14-20020a1709067f0e00b00a02a2fb007bmr3119036ejr.72.1700712316696; Wed, 22
 Nov 2023 20:05:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231122084906.12476-1-wangyao@lemote.com> <CAAhV-H5WZD5fWJ-3e1HMJ-bugy5BA-9zfaG+wmzJt9DoQu0pog@mail.gmail.com>
 <CAPWE4_zy1Jt5Yo=TfSfo7mUxpi7eNxHMq=ED4srK2wVG0r=zrA@mail.gmail.com>
In-Reply-To: <CAPWE4_zy1Jt5Yo=TfSfo7mUxpi7eNxHMq=ED4srK2wVG0r=zrA@mail.gmail.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Thu, 23 Nov 2023 12:05:04 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7LxoHOrcT7UMbwg-wW1hrpOLxwqVztkj7ZZu_QbRwiAg@mail.gmail.com>
Message-ID: <CAAhV-H7LxoHOrcT7UMbwg-wW1hrpOLxwqVztkj7ZZu_QbRwiAg@mail.gmail.com>
Subject: Re: [PATCH] efi/loongarch: Change MMU translation mode
To: Ainux Wang <ainux.wang@gmail.com>
Cc: wangyao@lemote.com, ardb@kernel.org, wangrui@loongson.cn, 
	linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 23, 2023 at 8:23=E2=80=AFAM Ainux Wang <ainux.wang@gmail.com> w=
rote:
>
> Huacai Chen <chenhuacai@kernel.org> =E4=BA=8E2023=E5=B9=B411=E6=9C=8822=
=E6=97=A5=E5=91=A8=E4=B8=89 22:22=E5=86=99=E9=81=93=EF=BC=9A
> >
> > Hi, Yao,
> >
> > On Wed, Nov 22, 2023 at 4:50=E2=80=AFPM <wangyao@lemote.com> wrote:
> > >
> > > From: Wang Yao <wangyao@lemote.com>
> > >
> > > Refer ot UEFI spec v2.10 section 2.3.8 LoongArch Platforms:
> > >
> > > The processor is in the following execution mode during boot service:
> > >     ...
> > >     The memory is in physical addressing mode. LoongArch architecture
> > >     defines two memory access mode, namely direct address translation
> > >     mode and mapped address translation mode.
> > >
> > > So need to change MMU translation mode before config direct mapping.
> > From UEFI spec v2.10 section 2.3.8, you can also see "MMU enabled", so
> > PG is already enabled in UEFI.
> >
> > Huacai
> >
> Hi,Huacai,
>
> From LoongArch-Vol1-v1.10-EN.pdf , DA or PG both refer to a mode enabled =
by MMU,
> Will the UEFI firmware not use DA mode?
> The UEFI spec did not specify the use of DA or PG mode, but the kernel
> must use PG.
In theory you are right, but "MMU" usually means "TLB", including this
case. EFI runtime needs TLB, so UEFI cannot be in DA mode.

Huacai

>
> Best regards,
> Ainux Wang.
> > >
> > > Signed-off-by: Wang Yao <wangyao@lemote.com>
> > > ---
> > >  drivers/firmware/efi/libstub/loongarch.c | 8 +++++++-
> > >  1 file changed, 7 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/firmware/efi/libstub/loongarch.c b/drivers/firmw=
are/efi/libstub/loongarch.c
> > > index 807cba2693fc..4c0a84c58f5b 100644
> > > --- a/drivers/firmware/efi/libstub/loongarch.c
> > > +++ b/drivers/firmware/efi/libstub/loongarch.c
> > > @@ -49,7 +49,7 @@ efi_status_t efi_boot_kernel(void *handle, efi_load=
ed_image_t *image,
> > >         struct exit_boot_struct priv;
> > >         unsigned long desc_size;
> > >         efi_status_t status;
> > > -       u32 desc_ver;
> > > +       u32 desc_ver, val;
> > >
> > >         status =3D efi_alloc_virtmap(&priv.runtime_map, &desc_size, &=
desc_ver);
> > >         if (status !=3D EFI_SUCCESS) {
> > > @@ -69,6 +69,12 @@ efi_status_t efi_boot_kernel(void *handle, efi_loa=
ded_image_t *image,
> > >                     priv.runtime_entry_count * desc_size, desc_size,
> > >                     desc_ver, priv.runtime_map);
> > >
> > > +       /* Change address translation mode */
> > > +       val =3D csr_read32(LOONGARCH_CSR_CRMD);
> > > +       val &=3D ~CSR_CRMD_DA;
> > > +       val |=3D CSR_CRMD_PG;
> > > +       csr_write32(val, LOONGARCH_CSR_CRMD);
> > > +
> > >         /* Config Direct Mapping */
> > >         csr_write64(CSR_DMW0_INIT, LOONGARCH_CSR_DMWIN0);
> > >         csr_write64(CSR_DMW1_INIT, LOONGARCH_CSR_DMWIN1);
> > > --
> > > 2.27.0
> > >

