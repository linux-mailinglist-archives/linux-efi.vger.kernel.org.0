Return-Path: <linux-efi+bounces-122-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EE1D804C1C
	for <lists+linux-efi@lfdr.de>; Tue,  5 Dec 2023 09:19:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3206728162F
	for <lists+linux-efi@lfdr.de>; Tue,  5 Dec 2023 08:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B59A3BB41;
	Tue,  5 Dec 2023 08:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OnXAPvDF"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86E2E10F
	for <linux-efi@vger.kernel.org>; Tue,  5 Dec 2023 00:19:44 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-db8892a5f96so2426681276.2
        for <linux-efi@vger.kernel.org>; Tue, 05 Dec 2023 00:19:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701764383; x=1702369183; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZJRyCpi1oUPu9udj0QmdnuCDWqQStDGSV3LdwuOgS+M=;
        b=OnXAPvDFL9Vb7nXE26AQaGNx8rsnuE/VHu/xtLU4K44l15eySXPu9O3/n9uoj1Hv2T
         kcyoG2PJ6k+UY5NqNyQTsLdr4ruCVdgu+Am7+x7P+e79+rTwLuPf93FKsyjpBYKag9gB
         srfRqwFTN6Jo3N+f+/usNcoaT+eE9HDt9rDlVcRD8wdwE2Kgziifk8LHRKhmP3tBUzae
         btX+azwDkUix3rsrFP7Rs7he/17HBNpoR3QEh1yptJ8AjudLbgsslA5HC9l4nKfkM/tP
         btz9FkjioaieaGIPcGQGJc1S4MlE6r+p+EIF2yQZosZljkCV4NRCiZS+MbUg+Wu11mOy
         FjDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701764383; x=1702369183;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZJRyCpi1oUPu9udj0QmdnuCDWqQStDGSV3LdwuOgS+M=;
        b=GxUq3cZCMBNqrTt9knciuQVfQn3/DMvKYRCvfvWD7rwYs3rCO8Odzqrt50dQFjk5pf
         nB9BQF01k6MYpIQL30lJibM22uzO5EABf5LNUZrGFk8akMHeVxUWfPccIUV+dZtHc6VD
         GbcnCT2nJK2Had9snAXsGvUrgs+gr2bDSHiFAUGbytrKtdXmugU3ZVnVgBuxEO2pR9h1
         +FYYGUxLqfkfEiwQCQchS42z/rG7+tOUnsDgxJL07LH9Q0NRtrGzD9x17m+1NqLtoJ8n
         I7Yu1EOgBv6SQsxrJichWkA58QG7KfhtK2gTF2bi6RVgNtIP3cJ9O95PAxPUa7MdV1Gn
         I6yA==
X-Gm-Message-State: AOJu0YwWcZ9/EB9KUxYb11oAS1W8Z4K3cMT8azm9RqxzggEq9SSDWWcS
	9X47PjL96zpn41sg+GgN/8+uxF5jaLa18mXmXBI=
X-Google-Smtp-Source: AGHT+IHoBn+OMP06lgjiC3n1pOInhTXc0CLdeeZ0Sh/O8jwTKR/MvtTVYZQcCNAuFy31jj2YzHis1Gn2mzqQuYCdljk=
X-Received: by 2002:a5b:a52:0:b0:db5:d88:d463 with SMTP id z18-20020a5b0a52000000b00db50d88d463mr3706042ybq.51.1701764383558;
 Tue, 05 Dec 2023 00:19:43 -0800 (PST)
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
 <CAPWE4_x_XQRsRc4ZEQHv5cy-_A2EchT7TvfTVYmjJL-NjW0WgQ@mail.gmail.com> <CAAhV-H7NJuMMS_hyyouH7n7xpcXSCLeMKdVk68n9F2OvzOB9Uw@mail.gmail.com>
In-Reply-To: <CAAhV-H7NJuMMS_hyyouH7n7xpcXSCLeMKdVk68n9F2OvzOB9Uw@mail.gmail.com>
From: Ainux Wang <ainux.wang@gmail.com>
Date: Tue, 5 Dec 2023 16:19:06 +0800
Message-ID: <CAPWE4_zv1hscnBN-sf0TBjc5-T58C_xuWqm1jrdUqx9mvPP5Gg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] efi/loongarch: load address is not equal to link address
To: Huacai Chen <chenhuacai@kernel.org>
Cc: wangyao@lemote.com, ardb@kernel.org, wangrui@loongson.cn, 
	linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Huacai Chen <chenhuacai@kernel.org> =E4=BA=8E2023=E5=B9=B412=E6=9C=885=E6=
=97=A5=E5=91=A8=E4=BA=8C 15:41=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue, Dec 5, 2023 at 2:24=E2=80=AFPM Ainux Wang <ainux.wang@gmail.com> =
wrote:
> >
> > Huacai Chen <chenhuacai@kernel.org> =E4=BA=8E2023=E5=B9=B412=E6=9C=885=
=E6=97=A5=E5=91=A8=E4=BA=8C 14:18=E5=86=99=E9=81=93=EF=BC=9A
> > >
> > > On Tue, Dec 5, 2023 at 2:16=E2=80=AFPM Ainux Wang <ainux.wang@gmail.c=
om> wrote:
> > > >
> > > > Huacai Chen <chenhuacai@kernel.org> =E4=BA=8E2023=E5=B9=B412=E6=9C=
=885=E6=97=A5=E5=91=A8=E4=BA=8C 14:09=E5=86=99=E9=81=93=EF=BC=9A
> > > > >
> > > > > Why send a test patch?
> > > > >
> > > >
> > > > Confirm the accuracy of the testing method
> > >
> > > Don't use maillist to do this.
> >
> > Sorry, I don't know about this :-(
> But from this patch, you only test the vmlinux.efi not loaded at link
> address, but haven't tested the vmlinuz.efi not decompressed to the
> link address. You should test that, but don't submit patches for that.

vmlinuz.efi decompress at 0x300000  is ok.

>
> >
> > >
> > > >
> > > > > On Tue, Dec 5, 2023 at 2:04=E2=80=AFPM <wangyao@lemote.com> wrote=
:
> > > > > >
> > > > > > From: Wang Yao <wangyao@lemote.com>
> > > > > >
> > > > > > This is a test patch for PIE kernel that load address is not eq=
ual to
> > > > > > link address.
> > > > > >
> > > > > > Signed-off-by: Wang Yao <wangyao@lemote.com>
> > > > > > ---
> > > > > >  drivers/firmware/efi/libstub/loongarch-stub.c | 12 +++++++++++=
-
> > > > > >  1 file changed, 11 insertions(+), 1 deletion(-)
> > > > > >
> > > > > > diff --git a/drivers/firmware/efi/libstub/loongarch-stub.c b/dr=
ivers/firmware/efi/libstub/loongarch-stub.c
> > > > > > index d6ec5d4b8dbe..c13c022d18cf 100644
> > > > > > --- a/drivers/firmware/efi/libstub/loongarch-stub.c
> > > > > > +++ b/drivers/firmware/efi/libstub/loongarch-stub.c
> > > > > > @@ -22,12 +22,22 @@ efi_status_t handle_kernel_image(unsigned l=
ong *image_addr,
> > > > > >                                  efi_handle_t image_handle)
> > > > > >  {
> > > > > >         efi_status_t status;
> > > > > > -       unsigned long kernel_addr =3D 0;
> > > > > > +       unsigned long kernel_addr =3D 0, tmp_addr =3D 0;
> > > > > >
> > > > > >         kernel_addr =3D (unsigned long)&kernel_offset - kernel_=
offset;
> > > > > >
> > > > > > +       /*
> > > > > > +        * Allocate 2M space at 0x200000(EFI_KIMG_PREFERRED_ADD=
RESS) for
> > > > > > +        * test, this will lead to the kernel be loaded at 0x40=
00000.
> > > > > > +        */
> > > > > > +       status =3D efi_relocate_kernel(&tmp_addr, 0x100000, 0x2=
00000,
> > > > > > +                    EFI_KIMG_PREFERRED_ADDRESS, efi_get_kimg_m=
in_align(), 0x0);
> > > > > > +       efi_info("@@@[%s] tmp_addr: 0x%lx\n", __func__, tmp_add=
r);
> > > > > > +
> > > > > > +       /* kernel_addr =3D=3D 0x400000 */
> > > > > >         status =3D efi_relocate_kernel(&kernel_addr, kernel_fsi=
ze, kernel_asize,
> > > > > >                      EFI_KIMG_PREFERRED_ADDRESS, efi_get_kimg_m=
in_align(), 0x0);
> > > > > > +       efi_info("@@@[%s] kernel_addr: 0x%lx\n", __func__, kern=
el_addr);
> > > > > >
> > > > > >         *image_addr =3D kernel_addr;
> > > > > >         *image_size =3D kernel_asize;
> > > > > > --
> > > > > > 2.27.0
> > > > > >

