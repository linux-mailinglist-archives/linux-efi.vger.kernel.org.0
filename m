Return-Path: <linux-efi+bounces-85-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA9A57F58CE
	for <lists+linux-efi@lfdr.de>; Thu, 23 Nov 2023 08:06:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6854FB20D64
	for <lists+linux-efi@lfdr.de>; Thu, 23 Nov 2023 07:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E6CC13FF5;
	Thu, 23 Nov 2023 07:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CwgzMb0j"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE2E183
	for <linux-efi@vger.kernel.org>; Wed, 22 Nov 2023 23:06:23 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-da077db5145so565830276.0
        for <linux-efi@vger.kernel.org>; Wed, 22 Nov 2023 23:06:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700723183; x=1701327983; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YKIet1g/3oVsvgeCNJPxfcTbKnmFmuA44h1daFn6fiM=;
        b=CwgzMb0jYRY1QD6pXQt9EidcOucKhqCiP54SqZP+EccRHnC9dhdij8dp5AnRgOT4RU
         EIee/WEKRbUp6PaLAu9ElP+jOOPDrKdIIu2KSsj+xt8lsD+JcTqpLo10IBLpvmPipMcC
         SnF6KLTjYB3SrhcnLlNUMuKzKyfgHaU1p0TyfBg0M5jzGX3IpB/ofQx9Op3wgJJwi16B
         Mxmta2b0cx9eFyLhv+LI+Ck2VEs/CXt0/gR6RynTN0s0IklZlh8L4D2+svAGdw/c7CRQ
         D371HYP18BpUDohXFMJc8INOyG3fUu2tfpzCimKxUms9yXAss4gQsYcYM/Q1xnGa+Xnu
         QLig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700723183; x=1701327983;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YKIet1g/3oVsvgeCNJPxfcTbKnmFmuA44h1daFn6fiM=;
        b=Sppkgy72d+IRimut5eGM3Fycbur9vI8zJtaXq2cnl5JVtpgqmURQr9h5J4cS6Bqi3h
         2gA297k2hRKya6uvogJm7Td+43lWPDW4B1u2PefDI8LCaOD0SVgcCEzqpzCP2ArDlhJr
         VqVa/yY8Yfk8VFoeWehlHZl2/EylpLcfkFqgPMe6NnC/uvIo68cuq8z1SJozYzsM4v6o
         h8+AFAC0SEN52HWJ148CPxGa/6khpwy548qUqGCSE0xdMuzXeX08mx4Fi73sAqt5P1Ls
         ppc7dyBNGLu28Rtq20GwdVB4cLkm63upYFFDvWg6ZCKuFoHOrExd1RzYHWEi5+ppYde8
         UEdg==
X-Gm-Message-State: AOJu0Yzth5LxzDRooKR2OiG3GcAC/kB6tkqoSxob/49w4Ch0L2mCF8pv
	Ml9FTqKxS4VTkGqW3l+Nrln1tGOUx24q3eZ9RljqoYKYFLwFfWfvvWM=
X-Google-Smtp-Source: AGHT+IH91RkRVqM0tzYnKcFoMAA2asi5+ucI90cJL9DpLI5qYZlTX++Xi07HE/vRoaDjJDCqTmQv+mt5PJtf6q8SsVs=
X-Received: by 2002:a25:d08b:0:b0:da0:470c:868f with SMTP id
 h133-20020a25d08b000000b00da0470c868fmr4572303ybg.51.1700723182842; Wed, 22
 Nov 2023 23:06:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231122084906.12476-1-wangyao@lemote.com> <CAAhV-H5WZD5fWJ-3e1HMJ-bugy5BA-9zfaG+wmzJt9DoQu0pog@mail.gmail.com>
 <CAPWE4_zy1Jt5Yo=TfSfo7mUxpi7eNxHMq=ED4srK2wVG0r=zrA@mail.gmail.com> <CAAhV-H7LxoHOrcT7UMbwg-wW1hrpOLxwqVztkj7ZZu_QbRwiAg@mail.gmail.com>
In-Reply-To: <CAAhV-H7LxoHOrcT7UMbwg-wW1hrpOLxwqVztkj7ZZu_QbRwiAg@mail.gmail.com>
From: Ainux Wang <ainux.wang@gmail.com>
Date: Thu, 23 Nov 2023 15:05:46 +0800
Message-ID: <CAPWE4_wx1hBmVR6Ppcia8C3xJECEKzGwvDj3hxaWXsKEpYFAsA@mail.gmail.com>
Subject: Re: [PATCH] efi/loongarch: Change MMU translation mode
To: Huacai Chen <chenhuacai@kernel.org>
Cc: wangyao@lemote.com, ardb@kernel.org, wangrui@loongson.cn, 
	linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Huacai Chen <chenhuacai@kernel.org> =E4=BA=8E2023=E5=B9=B411=E6=9C=8823=E6=
=97=A5=E5=91=A8=E5=9B=9B 12:05=E5=86=99=E9=81=93=EF=BC=9A
>
> On Thu, Nov 23, 2023 at 8:23=E2=80=AFAM Ainux Wang <ainux.wang@gmail.com>=
 wrote:
> >
> > Huacai Chen <chenhuacai@kernel.org> =E4=BA=8E2023=E5=B9=B411=E6=9C=8822=
=E6=97=A5=E5=91=A8=E4=B8=89 22:22=E5=86=99=E9=81=93=EF=BC=9A
> > >
> > > Hi, Yao,
> > >
> > > On Wed, Nov 22, 2023 at 4:50=E2=80=AFPM <wangyao@lemote.com> wrote:
> > > >
> > > > From: Wang Yao <wangyao@lemote.com>
> > > >
> > > > Refer ot UEFI spec v2.10 section 2.3.8 LoongArch Platforms:
> > > >
> > > > The processor is in the following execution mode during boot servic=
e:
> > > >     ...
> > > >     The memory is in physical addressing mode. LoongArch architectu=
re
> > > >     defines two memory access mode, namely direct address translati=
on
> > > >     mode and mapped address translation mode.
> > > >
> > > > So need to change MMU translation mode before config direct mapping=
.
> > > From UEFI spec v2.10 section 2.3.8, you can also see "MMU enabled", s=
o
> > > PG is already enabled in UEFI.
> > >
> > > Huacai
> > >
> > Hi,Huacai,
> >
> > From LoongArch-Vol1-v1.10-EN.pdf , DA or PG both refer to a mode enable=
d by MMU,
> > Will the UEFI firmware not use DA mode?
> > The UEFI spec did not specify the use of DA or PG mode, but the kernel
> > must use PG.
> In theory you are right, but "MMU" usually means "TLB", including this
> case. EFI runtime needs TLB, so UEFI cannot be in DA mode.
>
> Huacai
>
Is it possible that set_virtual_address_map() only configures the DMW
under PG mode
without switching DA to PG mode?

I noticed in efi_get_virtmap() that virt_addr =3D phys_addr +
0x8000_0000_0000_000,
and I also observed in the kernel's head.S there's a PG mode switch process
=EF=BC=8Cwhich could enable runtime services to use PG mode.

However, this occurs after the STUB,
so does the STUB phase really require or ensure that the UEFI firmware
is definitely in
PG mode?

> >
> > Best regards,
> > Ainux Wang.
> > > >
> > > > Signed-off-by: Wang Yao <wangyao@lemote.com>
> > > > ---
> > > >  drivers/firmware/efi/libstub/loongarch.c | 8 +++++++-
> > > >  1 file changed, 7 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/firmware/efi/libstub/loongarch.c b/drivers/fir=
mware/efi/libstub/loongarch.c
> > > > index 807cba2693fc..4c0a84c58f5b 100644
> > > > --- a/drivers/firmware/efi/libstub/loongarch.c
> > > > +++ b/drivers/firmware/efi/libstub/loongarch.c
> > > > @@ -49,7 +49,7 @@ efi_status_t efi_boot_kernel(void *handle, efi_lo=
aded_image_t *image,
> > > >         struct exit_boot_struct priv;
> > > >         unsigned long desc_size;
> > > >         efi_status_t status;
> > > > -       u32 desc_ver;
> > > > +       u32 desc_ver, val;
> > > >
> > > >         status =3D efi_alloc_virtmap(&priv.runtime_map, &desc_size,=
 &desc_ver);
> > > >         if (status !=3D EFI_SUCCESS) {
> > > > @@ -69,6 +69,12 @@ efi_status_t efi_boot_kernel(void *handle, efi_l=
oaded_image_t *image,
> > > >                     priv.runtime_entry_count * desc_size, desc_size=
,
> > > >                     desc_ver, priv.runtime_map);
> > > >
> > > > +       /* Change address translation mode */
> > > > +       val =3D csr_read32(LOONGARCH_CSR_CRMD);
> > > > +       val &=3D ~CSR_CRMD_DA;
> > > > +       val |=3D CSR_CRMD_PG;
> > > > +       csr_write32(val, LOONGARCH_CSR_CRMD);
> > > > +
> > > >         /* Config Direct Mapping */
> > > >         csr_write64(CSR_DMW0_INIT, LOONGARCH_CSR_DMWIN0);
> > > >         csr_write64(CSR_DMW1_INIT, LOONGARCH_CSR_DMWIN1);
> > > > --
> > > > 2.27.0
> > > >

