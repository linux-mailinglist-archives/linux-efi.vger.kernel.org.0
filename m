Return-Path: <linux-efi+bounces-81-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7C997F553E
	for <lists+linux-efi@lfdr.de>; Thu, 23 Nov 2023 01:23:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71391281356
	for <lists+linux-efi@lfdr.de>; Thu, 23 Nov 2023 00:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 870E863E;
	Thu, 23 Nov 2023 00:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g8N+G759"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E6C01B2
	for <linux-efi@vger.kernel.org>; Wed, 22 Nov 2023 16:23:27 -0800 (PST)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-5cc642e4c69so3573967b3.0
        for <linux-efi@vger.kernel.org>; Wed, 22 Nov 2023 16:23:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700699006; x=1701303806; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UvBKUZJLlRE7I4DE2ldX8bsqChu7AaRRIqbonQAEsk8=;
        b=g8N+G759Vlg6HkNql1JNzOn9qbwsnuUnqDwZkFCaqU1Jnnlsg+qtu6mbEHuX4uc/Et
         rI8l1b9iMuUA2iqYGvpwVfuI3D23a7la6b0MZ+DnIgjl/X/tKGPOIQ5yp2XE+a8OCPTk
         FeIErdXsC87Fv6ON94bNTo1FcwCYY1J1Vh7P4XBSFo+ajgprRd+Uknp9UuMWo6gwExEI
         pvqZh7SPIQaYOuD5oS93CzZf5BHJVf6n4N+J/PI7vhqIlQjStKoa7hFNXr2RmJGI/qxg
         oB1jZAsrWQBsTZwKL5WlhO6zRW+tr/oFgBsEA583T4CDXnlvFEMt0O+Fc7Xj+6oIqh34
         oeBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700699006; x=1701303806;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UvBKUZJLlRE7I4DE2ldX8bsqChu7AaRRIqbonQAEsk8=;
        b=XpFaqkx3Z51RHFfECny2yXeEZDdh1M7PCfnpGxl5pYHODblEYCXiXeBg7x1viN4gDa
         RhZU2lLPbUtThA6ClCVr5tfVOaV2NH7B2diyD1DeBoo4iReSXB4LCAGruIda6D2PtiIJ
         gaiHxGMBjOuvsEOB5eUADjN/06so23qjxtJinp1r2MK+nwSLM0M1Dzv+su3iyUBdx94d
         DFByoZn4CXeE5KZnPLw+PZjWTAT0minlxGp6ooob4BceKWRrZWmp0S3kXtF6q6gKyQbo
         LW/xxeddf/rfgjSDjPV5s5WWidXe1lT6CuZbr24ZhjE3cfdHhSqwueFJHIIaWRlTLaTY
         c1iw==
X-Gm-Message-State: AOJu0YwKspN1biYgPUY5HHedtPkZEoTrjltX6Eif1oL+56phQTR6mFZG
	k6PQGy42+2kNOHXhEY5FZInNs99/TVcx/iNraQ9sL9Id/wxJ8f2L/FxMWQ==
X-Google-Smtp-Source: AGHT+IE90nelPcGQS2x3bUxH4gVXbe+ixMvRmP/NUoZiWzLAaBckikB9SN8wEKDiWpaOW6Hg1sOBzuz3YYHaT7d/YWk=
X-Received: by 2002:a25:664a:0:b0:d9a:fd25:e3ef with SMTP id
 z10-20020a25664a000000b00d9afd25e3efmr3474798ybm.64.1700699006504; Wed, 22
 Nov 2023 16:23:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231122084906.12476-1-wangyao@lemote.com> <CAAhV-H5WZD5fWJ-3e1HMJ-bugy5BA-9zfaG+wmzJt9DoQu0pog@mail.gmail.com>
In-Reply-To: <CAAhV-H5WZD5fWJ-3e1HMJ-bugy5BA-9zfaG+wmzJt9DoQu0pog@mail.gmail.com>
From: Ainux Wang <ainux.wang@gmail.com>
Date: Thu, 23 Nov 2023 08:22:50 +0800
Message-ID: <CAPWE4_zy1Jt5Yo=TfSfo7mUxpi7eNxHMq=ED4srK2wVG0r=zrA@mail.gmail.com>
Subject: Re: [PATCH] efi/loongarch: Change MMU translation mode
To: Huacai Chen <chenhuacai@kernel.org>
Cc: wangyao@lemote.com, ardb@kernel.org, wangrui@loongson.cn, 
	linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Huacai Chen <chenhuacai@kernel.org> =E4=BA=8E2023=E5=B9=B411=E6=9C=8822=E6=
=97=A5=E5=91=A8=E4=B8=89 22:22=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi, Yao,
>
> On Wed, Nov 22, 2023 at 4:50=E2=80=AFPM <wangyao@lemote.com> wrote:
> >
> > From: Wang Yao <wangyao@lemote.com>
> >
> > Refer ot UEFI spec v2.10 section 2.3.8 LoongArch Platforms:
> >
> > The processor is in the following execution mode during boot service:
> >     ...
> >     The memory is in physical addressing mode. LoongArch architecture
> >     defines two memory access mode, namely direct address translation
> >     mode and mapped address translation mode.
> >
> > So need to change MMU translation mode before config direct mapping.
> From UEFI spec v2.10 section 2.3.8, you can also see "MMU enabled", so
> PG is already enabled in UEFI.
>
> Huacai
>
Hi,Huacai,

From LoongArch-Vol1-v1.10-EN.pdf , DA or PG both refer to a mode enabled by=
 MMU,
Will the UEFI firmware not use DA mode?
The UEFI spec did not specify the use of DA or PG mode, but the kernel
must use PG.

Best regards,
Ainux Wang.
> >
> > Signed-off-by: Wang Yao <wangyao@lemote.com>
> > ---
> >  drivers/firmware/efi/libstub/loongarch.c | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/firmware/efi/libstub/loongarch.c b/drivers/firmwar=
e/efi/libstub/loongarch.c
> > index 807cba2693fc..4c0a84c58f5b 100644
> > --- a/drivers/firmware/efi/libstub/loongarch.c
> > +++ b/drivers/firmware/efi/libstub/loongarch.c
> > @@ -49,7 +49,7 @@ efi_status_t efi_boot_kernel(void *handle, efi_loaded=
_image_t *image,
> >         struct exit_boot_struct priv;
> >         unsigned long desc_size;
> >         efi_status_t status;
> > -       u32 desc_ver;
> > +       u32 desc_ver, val;
> >
> >         status =3D efi_alloc_virtmap(&priv.runtime_map, &desc_size, &de=
sc_ver);
> >         if (status !=3D EFI_SUCCESS) {
> > @@ -69,6 +69,12 @@ efi_status_t efi_boot_kernel(void *handle, efi_loade=
d_image_t *image,
> >                     priv.runtime_entry_count * desc_size, desc_size,
> >                     desc_ver, priv.runtime_map);
> >
> > +       /* Change address translation mode */
> > +       val =3D csr_read32(LOONGARCH_CSR_CRMD);
> > +       val &=3D ~CSR_CRMD_DA;
> > +       val |=3D CSR_CRMD_PG;
> > +       csr_write32(val, LOONGARCH_CSR_CRMD);
> > +
> >         /* Config Direct Mapping */
> >         csr_write64(CSR_DMW0_INIT, LOONGARCH_CSR_DMWIN0);
> >         csr_write64(CSR_DMW1_INIT, LOONGARCH_CSR_DMWIN1);
> > --
> > 2.27.0
> >

