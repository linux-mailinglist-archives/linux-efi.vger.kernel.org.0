Return-Path: <linux-efi+bounces-86-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9561D7F5997
	for <lists+linux-efi@lfdr.de>; Thu, 23 Nov 2023 08:49:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 363E8B20C02
	for <lists+linux-efi@lfdr.de>; Thu, 23 Nov 2023 07:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D703618642;
	Thu, 23 Nov 2023 07:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J5MpnSiO"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BADE21863F
	for <linux-efi@vger.kernel.org>; Thu, 23 Nov 2023 07:49:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E7FEC433C8
	for <linux-efi@vger.kernel.org>; Thu, 23 Nov 2023 07:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700725781;
	bh=2o4bmgYaDW+IGZg4W5E8AWUY5bFdFlw7QsX5T/5mEoY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=J5MpnSiO5D3dX8ir7wSJhQWVVfUc2QFFJaU2iBZAjYuoYTrRDW3r/Ll2vJarHjxKz
	 bIAlMEadTXuUFYH6gZ/ReAuuqlBqzSHTDRXrTsLq2QOsBnpPHIn8g/BCqRhGpY3aGb
	 RigVG5yL20KlHXDBv3OkaqE2jp0n92bw7wlqo4KcEId+GnQn2LqOUpZ7/l8quwPLCm
	 5o3AAzvXh0lKt+Ed5+Iy8DiyXk91y1AZWlonanMs6AXyDDHrYafYASvpil9usAwiHg
	 kH+bDuwFAGQtyvTkTZ0TYHTswm8jJOnmPiyiefDTLb+CFRxtiJrNLOJcUmUAKWkCFS
	 Nmptxnuvpk0dw==
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-9fd0059a967so323858766b.1
        for <linux-efi@vger.kernel.org>; Wed, 22 Nov 2023 23:49:41 -0800 (PST)
X-Gm-Message-State: AOJu0Yyw32XUx2aWCXeex7Gj5Ve07iqGQrDnvOA3+RR0btObZAg4Bwvt
	ZbF7chOA5iAUOE1Rw6ab8wXqaZhWhsW1l6qPhqo=
X-Google-Smtp-Source: AGHT+IEUPjeL+0DeBen5Lq8C58FngbavIacNs+mGAhH43TlBL67NnLnz8xzM6yMTNzxpGxwYo4+mCE/ZTnvMMXv5538=
X-Received: by 2002:a17:906:9e1d:b0:9e4:dc3f:ddae with SMTP id
 fp29-20020a1709069e1d00b009e4dc3fddaemr1479949ejc.33.1700725779676; Wed, 22
 Nov 2023 23:49:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231122084906.12476-1-wangyao@lemote.com> <CAAhV-H5WZD5fWJ-3e1HMJ-bugy5BA-9zfaG+wmzJt9DoQu0pog@mail.gmail.com>
 <CAPWE4_zy1Jt5Yo=TfSfo7mUxpi7eNxHMq=ED4srK2wVG0r=zrA@mail.gmail.com>
 <CAAhV-H7LxoHOrcT7UMbwg-wW1hrpOLxwqVztkj7ZZu_QbRwiAg@mail.gmail.com> <CAPWE4_wx1hBmVR6Ppcia8C3xJECEKzGwvDj3hxaWXsKEpYFAsA@mail.gmail.com>
In-Reply-To: <CAPWE4_wx1hBmVR6Ppcia8C3xJECEKzGwvDj3hxaWXsKEpYFAsA@mail.gmail.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Thu, 23 Nov 2023 15:49:27 +0800
X-Gmail-Original-Message-ID: <CAAhV-H41aFeA4CnDii2BT4NRUMY_rT_4MYFrnP_U9vok=3wm4A@mail.gmail.com>
Message-ID: <CAAhV-H41aFeA4CnDii2BT4NRUMY_rT_4MYFrnP_U9vok=3wm4A@mail.gmail.com>
Subject: Re: [PATCH] efi/loongarch: Change MMU translation mode
To: Ainux Wang <ainux.wang@gmail.com>
Cc: wangyao@lemote.com, ardb@kernel.org, wangrui@loongson.cn, 
	linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 23, 2023 at 3:06=E2=80=AFPM Ainux Wang <ainux.wang@gmail.com> w=
rote:
>
> Huacai Chen <chenhuacai@kernel.org> =E4=BA=8E2023=E5=B9=B411=E6=9C=8823=
=E6=97=A5=E5=91=A8=E5=9B=9B 12:05=E5=86=99=E9=81=93=EF=BC=9A
> >
> > On Thu, Nov 23, 2023 at 8:23=E2=80=AFAM Ainux Wang <ainux.wang@gmail.co=
m> wrote:
> > >
> > > Huacai Chen <chenhuacai@kernel.org> =E4=BA=8E2023=E5=B9=B411=E6=9C=88=
22=E6=97=A5=E5=91=A8=E4=B8=89 22:22=E5=86=99=E9=81=93=EF=BC=9A
> > > >
> > > > Hi, Yao,
> > > >
> > > > On Wed, Nov 22, 2023 at 4:50=E2=80=AFPM <wangyao@lemote.com> wrote:
> > > > >
> > > > > From: Wang Yao <wangyao@lemote.com>
> > > > >
> > > > > Refer ot UEFI spec v2.10 section 2.3.8 LoongArch Platforms:
> > > > >
> > > > > The processor is in the following execution mode during boot serv=
ice:
> > > > >     ...
> > > > >     The memory is in physical addressing mode. LoongArch architec=
ture
> > > > >     defines two memory access mode, namely direct address transla=
tion
> > > > >     mode and mapped address translation mode.
> > > > >
> > > > > So need to change MMU translation mode before config direct mappi=
ng.
> > > > From UEFI spec v2.10 section 2.3.8, you can also see "MMU enabled",=
 so
> > > > PG is already enabled in UEFI.
> > > >
> > > > Huacai
> > > >
> > > Hi,Huacai,
> > >
> > > From LoongArch-Vol1-v1.10-EN.pdf , DA or PG both refer to a mode enab=
led by MMU,
> > > Will the UEFI firmware not use DA mode?
> > > The UEFI spec did not specify the use of DA or PG mode, but the kerne=
l
> > > must use PG.
> > In theory you are right, but "MMU" usually means "TLB", including this
> > case. EFI runtime needs TLB, so UEFI cannot be in DA mode.
> >
> > Huacai
> >
> Is it possible that set_virtual_address_map() only configures the DMW
> under PG mode
> without switching DA to PG mode?
>
> I noticed in efi_get_virtmap() that virt_addr =3D phys_addr +
> 0x8000_0000_0000_000,
> and I also observed in the kernel's head.S there's a PG mode switch proce=
ss
> =EF=BC=8Cwhich could enable runtime services to use PG mode.
>
> However, this occurs after the STUB,
> so does the STUB phase really require or ensure that the UEFI firmware
> is definitely in
> PG mode?
Anything you think redundant may be not redundant, remember that UEFI
is not the only BIOS and Linux is not the only OS. So Linux kernel
cannot assume any BIOS is the same as UEFI does, UEFI cannot assume
any OS is the same as Linux does, too.

Huacai

>
> > >
> > > Best regards,
> > > Ainux Wang.
> > > > >
> > > > > Signed-off-by: Wang Yao <wangyao@lemote.com>
> > > > > ---
> > > > >  drivers/firmware/efi/libstub/loongarch.c | 8 +++++++-
> > > > >  1 file changed, 7 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/drivers/firmware/efi/libstub/loongarch.c b/drivers/f=
irmware/efi/libstub/loongarch.c
> > > > > index 807cba2693fc..4c0a84c58f5b 100644
> > > > > --- a/drivers/firmware/efi/libstub/loongarch.c
> > > > > +++ b/drivers/firmware/efi/libstub/loongarch.c
> > > > > @@ -49,7 +49,7 @@ efi_status_t efi_boot_kernel(void *handle, efi_=
loaded_image_t *image,
> > > > >         struct exit_boot_struct priv;
> > > > >         unsigned long desc_size;
> > > > >         efi_status_t status;
> > > > > -       u32 desc_ver;
> > > > > +       u32 desc_ver, val;
> > > > >
> > > > >         status =3D efi_alloc_virtmap(&priv.runtime_map, &desc_siz=
e, &desc_ver);
> > > > >         if (status !=3D EFI_SUCCESS) {
> > > > > @@ -69,6 +69,12 @@ efi_status_t efi_boot_kernel(void *handle, efi=
_loaded_image_t *image,
> > > > >                     priv.runtime_entry_count * desc_size, desc_si=
ze,
> > > > >                     desc_ver, priv.runtime_map);
> > > > >
> > > > > +       /* Change address translation mode */
> > > > > +       val =3D csr_read32(LOONGARCH_CSR_CRMD);
> > > > > +       val &=3D ~CSR_CRMD_DA;
> > > > > +       val |=3D CSR_CRMD_PG;
> > > > > +       csr_write32(val, LOONGARCH_CSR_CRMD);
> > > > > +
> > > > >         /* Config Direct Mapping */
> > > > >         csr_write64(CSR_DMW0_INIT, LOONGARCH_CSR_DMWIN0);
> > > > >         csr_write64(CSR_DMW1_INIT, LOONGARCH_CSR_DMWIN1);
> > > > > --
> > > > > 2.27.0
> > > > >

