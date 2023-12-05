Return-Path: <linux-efi+bounces-118-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 726218049E8
	for <lists+linux-efi@lfdr.de>; Tue,  5 Dec 2023 07:16:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D1D11C20C7C
	for <lists+linux-efi@lfdr.de>; Tue,  5 Dec 2023 06:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC955DDB3;
	Tue,  5 Dec 2023 06:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JCWX/N5l"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFAE0B6
	for <linux-efi@vger.kernel.org>; Mon,  4 Dec 2023 22:16:19 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-dae0ab8ac3eso3675784276.0
        for <linux-efi@vger.kernel.org>; Mon, 04 Dec 2023 22:16:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701756979; x=1702361779; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ujDfj10zc0mHJVPjG0hklzt5FDtu6+s+6sEkshvfnC8=;
        b=JCWX/N5lk83B+0vcs6BjmCVjFIJ2K+aZwUnOx166bYtENQIFmlpV12397WG6tiWCK1
         PafFU3yydRK+l4yoARciqgMpnBCQ4keJtWKx2BPCxxTTKsRIGsbKAMWYlGTXjM2+X+1D
         Sn+ywjyrR+vsqalXtVeGdr6FlumPjRDA5lm9JOLq9LNpdrodJw+Uh4YD/ZPGyMKtatVd
         REMztTg2Xawlm55B+kVRTtK/my24eYRGdo5y/SgNu/QksIiwttpa+Gwvbu69xwRlnydE
         oViM7vC+AhX37z93Ad3vEwDqiIHPcIbi/gdvrSHN3y81fW0XRZ8rM3EOI5knfW7VK0x7
         9Omw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701756979; x=1702361779;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ujDfj10zc0mHJVPjG0hklzt5FDtu6+s+6sEkshvfnC8=;
        b=p4t3yNut+VzcZ7zY1tfdWqIL2ziI4llzuCGdKHNY2kKCE9rzQlAiJkwo6Ya/Bj64GG
         eR3l4o6kEcgtopaxJ8fkgG4Cgg4Jc49icYY6LZdSmaJ8CQeysbOOqFqFkGpiU1nNo0Cp
         t0dRxdpACcNYWK/HPgpJMVlSlW5PSQT13tAJRcuAQxxN+Z7QTbDa1sW2nCXd6g2uTGBF
         uNZ9m+pif6eMvARLR7JCdsLeRGUyBeS4D1MNbuzZdwpjaGdG/MfCuqk2LWHq3o7cKbYC
         iuO8T0YZ8/umlMafbabeGm1fdkXEqwUjyKhh+huhb8lVtCvREUXSo6sUcDvwdl4X1suA
         RTzQ==
X-Gm-Message-State: AOJu0YxVBO8N4gfkYQmpf9paNVptu+WfSZtZeT3csKh9UI3pMMe1PpJO
	HRo9iI5BTmT/fCgnxNeb9BPd4vj64Ds+LZcakqZl2EwKpdIqpibobnbVuw==
X-Google-Smtp-Source: AGHT+IF2hs95aeJawaaY3TWUcPf3JRvGkoqAiCW8kw7rEN0JIOYQI9Wggqj1ttXxwLCif/DPf5CCs4W/YKkdYduu8Ns=
X-Received: by 2002:a25:c091:0:b0:d86:57cc:aa74 with SMTP id
 c139-20020a25c091000000b00d8657ccaa74mr3982096ybf.35.1701756979122; Mon, 04
 Dec 2023 22:16:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231205060345.7742-1-wangyao@lemote.com> <20231205060345.7742-3-wangyao@lemote.com>
 <CAAhV-H4ou+rMOKT=GvWD2f9j4CiQ5VC13hYMeaU5ecOaDjLTwQ@mail.gmail.com>
In-Reply-To: <CAAhV-H4ou+rMOKT=GvWD2f9j4CiQ5VC13hYMeaU5ecOaDjLTwQ@mail.gmail.com>
From: Ainux Wang <ainux.wang@gmail.com>
Date: Tue, 5 Dec 2023 14:15:41 +0800
Message-ID: <CAPWE4_zrq=9FQ=bEh85Eo03CTWF=Nn1_OM=uvoY5ti_m+sWbhg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] efi/loongarch: load address is not equal to link address
To: Huacai Chen <chenhuacai@kernel.org>
Cc: wangyao@lemote.com, ardb@kernel.org, wangrui@loongson.cn, 
	linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Huacai Chen <chenhuacai@kernel.org> =E4=BA=8E2023=E5=B9=B412=E6=9C=885=E6=
=97=A5=E5=91=A8=E4=BA=8C 14:09=E5=86=99=E9=81=93=EF=BC=9A
>
> Why send a test patch?
>

Confirm the accuracy of the testing method

> On Tue, Dec 5, 2023 at 2:04=E2=80=AFPM <wangyao@lemote.com> wrote:
> >
> > From: Wang Yao <wangyao@lemote.com>
> >
> > This is a test patch for PIE kernel that load address is not equal to
> > link address.
> >
> > Signed-off-by: Wang Yao <wangyao@lemote.com>
> > ---
> >  drivers/firmware/efi/libstub/loongarch-stub.c | 12 +++++++++++-
> >  1 file changed, 11 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/firmware/efi/libstub/loongarch-stub.c b/drivers/fi=
rmware/efi/libstub/loongarch-stub.c
> > index d6ec5d4b8dbe..c13c022d18cf 100644
> > --- a/drivers/firmware/efi/libstub/loongarch-stub.c
> > +++ b/drivers/firmware/efi/libstub/loongarch-stub.c
> > @@ -22,12 +22,22 @@ efi_status_t handle_kernel_image(unsigned long *ima=
ge_addr,
> >                                  efi_handle_t image_handle)
> >  {
> >         efi_status_t status;
> > -       unsigned long kernel_addr =3D 0;
> > +       unsigned long kernel_addr =3D 0, tmp_addr =3D 0;
> >
> >         kernel_addr =3D (unsigned long)&kernel_offset - kernel_offset;
> >
> > +       /*
> > +        * Allocate 2M space at 0x200000(EFI_KIMG_PREFERRED_ADDRESS) fo=
r
> > +        * test, this will lead to the kernel be loaded at 0x4000000.
> > +        */
> > +       status =3D efi_relocate_kernel(&tmp_addr, 0x100000, 0x200000,
> > +                    EFI_KIMG_PREFERRED_ADDRESS, efi_get_kimg_min_align=
(), 0x0);
> > +       efi_info("@@@[%s] tmp_addr: 0x%lx\n", __func__, tmp_addr);
> > +
> > +       /* kernel_addr =3D=3D 0x400000 */
> >         status =3D efi_relocate_kernel(&kernel_addr, kernel_fsize, kern=
el_asize,
> >                      EFI_KIMG_PREFERRED_ADDRESS, efi_get_kimg_min_align=
(), 0x0);
> > +       efi_info("@@@[%s] kernel_addr: 0x%lx\n", __func__, kernel_addr)=
;
> >
> >         *image_addr =3D kernel_addr;
> >         *image_size =3D kernel_asize;
> > --
> > 2.27.0
> >

