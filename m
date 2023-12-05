Return-Path: <linux-efi+bounces-110-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C03A28043DE
	for <lists+linux-efi@lfdr.de>; Tue,  5 Dec 2023 02:17:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F13BC1C20C6D
	for <lists+linux-efi@lfdr.de>; Tue,  5 Dec 2023 01:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B19751373;
	Tue,  5 Dec 2023 01:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aC6BJpz5"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFF5FD5
	for <linux-efi@vger.kernel.org>; Mon,  4 Dec 2023 17:17:03 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-db547d3631fso3554133276.1
        for <linux-efi@vger.kernel.org>; Mon, 04 Dec 2023 17:17:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701739023; x=1702343823; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2cI1AxfJq9BtJ7fl7Vdny5aAStKFiE7rOt3KnMXKqB8=;
        b=aC6BJpz5+udYZAyrhLvwUYW77sIkZTcs9/xgCvZDS0cbhHo0GdSI+w2TgmDwODFuQR
         XjeUAAko1452X0sTSeHaC7wLtIkmJhY5l614/QGk5c7DekrrCHuPLPf3hcNPt2rRcSpI
         28Y6JcsANFR//AHit/Co9ch8RwnufESkTEDv5Vw6K1N5bkOPnyizp59eK8oAJkXB9Ide
         cgat4XhNjnR7ID66+ZclLtLyvleb7cZ1ATSPnDxHTcDFoRtOeITAmOGRyZQlMZK21Q7/
         HbFZpz54EtmsJeT2dcBokAuzCRJtd9BqYMDrAVNPW7neUsulR0NGUpachgxx43bjuYzF
         OAJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701739023; x=1702343823;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2cI1AxfJq9BtJ7fl7Vdny5aAStKFiE7rOt3KnMXKqB8=;
        b=ARnly+oNJ3VvZeHotC2KQkJKWwcKjfwGSjbIDXZDYsT+s4YdV1DqRiSGWahpCWpo4L
         tQL6gE3ylFW+W7uKFssMj25zFGIfURUzr9tG0ajTAa3niBIBse0zIap8J4UGZmYy/jnt
         IVTn6mZPI1QhYPT04ClvU0HReLwVlG8LXxCd6rlpisQ3fmhrQUEVWg39cZjGYeQ5/7er
         rEOvYt7cXqZx446rYBFilpgb5CetJbC5XKS29pAibmNpdUGPNFI+q6jt112P3VUUfhSP
         Up+b3MQwCEdHQTbY2DY3GLb4hDdRd4VmcO7ERwWJMzaMYdujpoM5o7DebsB7YR5VVFcb
         nWvA==
X-Gm-Message-State: AOJu0Yy9asejzOmKZmTcjRFvAZlHdTCUOz1GxmnOnYLR7ALoBLAg1Tp+
	0o+zDm/Vio2oTzqj1ffG6qFgjIT32AVUVvhIqILbExMJc3omOKUVadWd+g==
X-Google-Smtp-Source: AGHT+IE7IsQY42XHpp4W8PuwD9NoZ9hX8Q0k+oHpLaDgVLajtc4i1qyH9CyCwCe9xrhsLcQR3+XO8EyR0IdNhSX5zlA=
X-Received: by 2002:a25:2d1:0:b0:db7:dad0:60d4 with SMTP id
 200-20020a2502d1000000b00db7dad060d4mr3280290ybc.97.1701739023065; Mon, 04
 Dec 2023 17:17:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231204031853.6379-1-wangyao@lemote.com> <CAAhV-H4ZNsD8E=uEmtr3bgn4vfXXW0ugNHhwQHeKDKvyVAA=gA@mail.gmail.com>
In-Reply-To: <CAAhV-H4ZNsD8E=uEmtr3bgn4vfXXW0ugNHhwQHeKDKvyVAA=gA@mail.gmail.com>
From: Ainux Wang <ainux.wang@gmail.com>
Date: Tue, 5 Dec 2023 09:16:26 +0800
Message-ID: <CAPWE4_yLATC-Qh4STyxJ_o8DRu_+odJLDU5C6qebdmXVMaNuYA@mail.gmail.com>
Subject: Re: [PATCH] efi/loongarch: Use relocate address to calculate kernel
 entry address
To: Huacai Chen <chenhuacai@kernel.org>
Cc: wangyao@lemote.com, ardb@kernel.org, wangrui@loongson.cn, 
	linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Huacai Chen <chenhuacai@kernel.org> =E4=BA=8E2023=E5=B9=B412=E6=9C=884=E6=
=97=A5=E5=91=A8=E4=B8=80 21:02=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi, Yao,
>
> The title can be "Use load address ....".
>
>
> On Mon, Dec 4, 2023 at 11:19=E2=80=AFAM <wangyao@lemote.com> wrote:
> >
> > From: Wang Yao <wangyao@lemote.com>
> >
> > The efi_relocate_kernel() may relocate the PIE kernel to anywhere, the =
relocated
> > address may not be equal to link address or EFI_KIMG_PREFERRED_ADDRESS.
> >
> > Signed-off-by: Wang Yao <wangyao@lemote.com>
> > ---
> >  arch/loongarch/include/asm/efi.h              | 2 +-
> >  drivers/firmware/efi/libstub/loongarch-stub.c | 4 ++--
> >  drivers/firmware/efi/libstub/loongarch.c      | 6 +++---
> >  3 files changed, 6 insertions(+), 6 deletions(-)
> >
> > diff --git a/arch/loongarch/include/asm/efi.h b/arch/loongarch/include/=
asm/efi.h
> > index 091897d40b03..91d81f9730ab 100644
> > --- a/arch/loongarch/include/asm/efi.h
> > +++ b/arch/loongarch/include/asm/efi.h
> > @@ -32,6 +32,6 @@ static inline unsigned long efi_get_kimg_min_align(vo=
id)
> >
> >  #define EFI_KIMG_PREFERRED_ADDRESS     PHYSADDR(VMLINUX_LOAD_ADDRESS)
> >
> > -unsigned long kernel_entry_address(void);
> > +unsigned long kernel_entry_address(unsigned long kernel_addr);
> >
> >  #endif /* _ASM_LOONGARCH_EFI_H */
> > diff --git a/drivers/firmware/efi/libstub/loongarch-stub.c b/drivers/fi=
rmware/efi/libstub/loongarch-stub.c
> > index 72c71ae201f0..4d52f1dc5258 100644
> > --- a/drivers/firmware/efi/libstub/loongarch-stub.c
> > +++ b/drivers/firmware/efi/libstub/loongarch-stub.c
> > @@ -35,9 +35,9 @@ efi_status_t handle_kernel_image(unsigned long *image=
_addr,
> >         return status;
> >  }
> >
> > -unsigned long kernel_entry_address(void)
> > +unsigned long kernel_entry_address(unsigned long kernel_addr)
> >  {
> >         unsigned long base =3D (unsigned long)&kernel_offset - kernel_o=
ffset;
> >
> > -       return (unsigned long)&kernel_entry - base + VMLINUX_LOAD_ADDRE=
SS;
> > +       return (unsigned long)&kernel_entry - base + TO_CACHE(kernel_ad=
dr);
> >  }
> > diff --git a/drivers/firmware/efi/libstub/loongarch.c b/drivers/firmwar=
e/efi/libstub/loongarch.c
> > index 807cba2693fc..d7ec9381f8ea 100644
> > --- a/drivers/firmware/efi/libstub/loongarch.c
> > +++ b/drivers/firmware/efi/libstub/loongarch.c
> > @@ -37,9 +37,9 @@ static efi_status_t exit_boot_func(struct efi_boot_me=
mmap *map, void *priv)
> >         return EFI_SUCCESS;
> >  }
> >
> > -unsigned long __weak kernel_entry_address(void)
> > +unsigned long __weak kernel_entry_address(unsigned long kernel_addr)
> >  {
> > -       return *(unsigned long *)(PHYSADDR(VMLINUX_LOAD_ADDRESS) + 8);
> > +       return *(unsigned long *)(PHYSADDR(kernel_addr) + 8);
> The address read from DOS header is link address, so you should return
> *(unsigned long *)(kernel_addr + 8) -  VMLINUX_LOAD_ADDRESS +
> TO_CACHE(kernel_addr);
>
> Huacai
Ok, thanks.
Best regards,
Ainux Wang.
>
> >  }
> >
> >  efi_status_t efi_boot_kernel(void *handle, efi_loaded_image_t *image,
> > @@ -73,7 +73,7 @@ efi_status_t efi_boot_kernel(void *handle, efi_loaded=
_image_t *image,
> >         csr_write64(CSR_DMW0_INIT, LOONGARCH_CSR_DMWIN0);
> >         csr_write64(CSR_DMW1_INIT, LOONGARCH_CSR_DMWIN1);
> >
> > -       real_kernel_entry =3D (void *)kernel_entry_address();
> > +       real_kernel_entry =3D (void *)kernel_entry_address(kernel_addr)=
;
> >
> >         real_kernel_entry(true, (unsigned long)cmdline_ptr,
> >                           (unsigned long)efi_system_table);
> > --
> > 2.27.0
> >

