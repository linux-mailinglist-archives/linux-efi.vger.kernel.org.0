Return-Path: <linux-efi+bounces-244-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D39C8183AB
	for <lists+linux-efi@lfdr.de>; Tue, 19 Dec 2023 09:45:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AD241F250DD
	for <lists+linux-efi@lfdr.de>; Tue, 19 Dec 2023 08:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD7611CA8;
	Tue, 19 Dec 2023 08:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RxirvHeK"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F5411C9C
	for <linux-efi@vger.kernel.org>; Tue, 19 Dec 2023 08:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-5d226f51f71so34728877b3.3
        for <linux-efi@vger.kernel.org>; Tue, 19 Dec 2023 00:45:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702975513; x=1703580313; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q87ZV7GV4SfgD1DUS1KyLkKLdOmh9utgX4BTAUPc0yE=;
        b=RxirvHeKNZPREGh18KCRNWqqF9y0cpEvKnXR8I+3DboeIub6E5J1lsGyQLK4Gxl6Oa
         nuKBH6KkAlU3RlCiI0fvLLHldX6nnDxpXzJ/YzxT/VoAFdsdq03un4CcgYZM+8VPPwa1
         oQ6eqBu4nJY3dX3s4e+G0StJKGzOzM8j3QjSp0548Jw5ZjRuJmnjonSCg3MHP/AvUcRH
         Gc37lmiPaRonVKdfHQgmAKe90tyQCUEFxys6IKG637kHvFGvD37TLvtIR7tVcEW6H7KR
         LqraGADKGA9V4HW7Z3Fq8UaupGnMg+N9yxqkuIulUkVfjouY/cQc2svtPq5EN7pDlmBZ
         91bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702975513; x=1703580313;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q87ZV7GV4SfgD1DUS1KyLkKLdOmh9utgX4BTAUPc0yE=;
        b=H05WFQviX0x3L0Y0Wp5SOdmdoXX8CQcYDbelC8DAGvFlCAh9PF00DsiLkuIB5WA5iK
         G7LxlrVsg8ugFlk9VLgYoEOdmUdeUw/YguU/RilvB64nja2+JEECDNe7fvM2ohs4IPJ0
         HwSsxOSWgZCpxsRxaqq0BCSUANcyKRQhUgJADTNOF4DHzh2T1pNIEGodiTIT4gntifdr
         kBtAa1GNRakoWnTU54FVxjJQtwcdZWOOd6D0UrfrugDhZZ9cnbM3X57QLVH4UEwfUCVo
         mbeLnxM2fqgQvJpQupGWMRbNEUaovwHtfBorDxkvWRVLMDRuqgtMXVgphKXzMcyLu3Nq
         gL0g==
X-Gm-Message-State: AOJu0YwBKJHgPsHzwB1aXbVqCAsDWLxFbAj/G0Bdy9SmnB2xQXbpZP7L
	EBxs7Dh941G8YwKvnlNLlHVeEu5RUGLyp9CIRfo=
X-Google-Smtp-Source: AGHT+IEEvJ/xphWdpeMhtooYW74eRginzNA3yLIQnkZI2MN1xy147juG4Ml4to/1QtZAD8LcQNTaTSkJEMYIy0S91L4=
X-Received: by 2002:a25:8704:0:b0:dbd:1d6:db19 with SMTP id
 a4-20020a258704000000b00dbd01d6db19mr3265059ybl.20.1702975513084; Tue, 19 Dec
 2023 00:45:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231219053543.11726-1-wangyao@lemote.com> <CAAhV-H5VtHmDJhwQp7SJ_uF92+ReEjcSLDpFh+y618SG=YXpbw@mail.gmail.com>
 <CAMj1kXFHVTSQ3yTTTY8QS8chmZXVQdYwyZJJ4TrnQWYzk=7awQ@mail.gmail.com>
In-Reply-To: <CAMj1kXFHVTSQ3yTTTY8QS8chmZXVQdYwyZJJ4TrnQWYzk=7awQ@mail.gmail.com>
From: Ainux Wang <ainux.wang@gmail.com>
Date: Tue, 19 Dec 2023 16:44:36 +0800
Message-ID: <CAPWE4_w2Sf3FBFVbAZz4AwaRnY_8GK_57nvA1xm1EMpQoXAHrQ@mail.gmail.com>
Subject: Re: [PATCH] efi/loongarch: Directly position the loaded image file
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Huacai Chen <chenhuacai@kernel.org>, wangyao@lemote.com, wangrui@loongson.cn, 
	linux-efi@vger.kernel.org, loongarch@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ard Biesheuvel <ardb@kernel.org> =E4=BA=8E2023=E5=B9=B412=E6=9C=8819=E6=97=
=A5=E5=91=A8=E4=BA=8C 16:28=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue, 19 Dec 2023 at 07:40, Huacai Chen <chenhuacai@kernel.org> wrote:
> >
> > Hi, Ard and Yao,
> >
> > The logic of this patch seems right, but I see this in arm64 code:
> >
> >         if (image->image_base !=3D _text) {
> >                 efi_err("FIRMWARE BUG: efi_loaded_image_t::image_base
> > has bogus value\n");
> >                 image->image_base =3D _text;
> >         }
> >
> > Does this mean image_base is unreliable?
> >
>
> Only if you use an old distro fork of GRUB. Those would 'repurpose'
> the LoadImage protocol created by the firmware to load GRUB by
> updating some fields and passing the same protocol to the kernel as
> the kernel's loaded image, but failed to set the image_base correctly.
>
> I don't think this is a concern for LoongArch.
>
> > The arm64 code is introduced in commit c2136dceba9a329e997ccce3277
> > ("efi/libstub/arm64: Avoid image_base value from efi_loaded_image"),
> > and I don't know whether LoongArch has similar problems.
> >
> > Huacai
> >
> > On Tue, Dec 19, 2023 at 1:36=E2=80=AFPM <wangyao@lemote.com> wrote:
> > >
> > > From: Wang Yao <wangyao@lemote.com>
> > >
> > > Replace kernel_offset with image_base to positon the image file that =
has
> > > been loaded by UEFI or GRUB.
> > >
>
> Why?
>
> When you write a commit log, focus on the why not on the how (we can
> all see the 'how' by reading the patch itself)
>

OK=EF=BC=8CI will rewrite the commit log in V2.

> > > Signed-off-by: Wang Yao <wangyao@lemote.com>
> > > ---
> > >  arch/loongarch/include/asm/efi.h              | 2 --
> > >  arch/loongarch/kernel/head.S                  | 1 -
> > >  arch/loongarch/kernel/image-vars.h            | 1 -
> > >  arch/loongarch/kernel/vmlinux.lds.S           | 1 -
> > >  drivers/firmware/efi/libstub/loongarch-stub.c | 9 +++++----
> > >  drivers/firmware/efi/libstub/loongarch-stub.h | 4 ++++
> > >  drivers/firmware/efi/libstub/loongarch.c      | 6 ++++--
> > >  7 files changed, 13 insertions(+), 11 deletions(-)
> > >  create mode 100644 drivers/firmware/efi/libstub/loongarch-stub.h
> > >
> > > diff --git a/arch/loongarch/include/asm/efi.h b/arch/loongarch/includ=
e/asm/efi.h
> > > index 91d81f9730ab..eddc8e79b3fa 100644
> > > --- a/arch/loongarch/include/asm/efi.h
> > > +++ b/arch/loongarch/include/asm/efi.h
> > > @@ -32,6 +32,4 @@ static inline unsigned long efi_get_kimg_min_align(=
void)
> > >
> > >  #define EFI_KIMG_PREFERRED_ADDRESS     PHYSADDR(VMLINUX_LOAD_ADDRESS=
)
> > >
> > > -unsigned long kernel_entry_address(unsigned long kernel_addr);
> > > -
> > >  #endif /* _ASM_LOONGARCH_EFI_H */
> > > diff --git a/arch/loongarch/kernel/head.S b/arch/loongarch/kernel/hea=
d.S
> > > index 53b883db0786..0ecab4216392 100644
> > > --- a/arch/loongarch/kernel/head.S
> > > +++ b/arch/loongarch/kernel/head.S
> > > @@ -34,7 +34,6 @@ pe_header:
> > >
> > >  SYM_DATA(kernel_asize, .long _kernel_asize);
> > >  SYM_DATA(kernel_fsize, .long _kernel_fsize);
> > > -SYM_DATA(kernel_offset, .long _kernel_offset);
> > >
> > >  #endif
> > >
> > > diff --git a/arch/loongarch/kernel/image-vars.h b/arch/loongarch/kern=
el/image-vars.h
> > > index 5087416b9678..41ddcf56d21c 100644
> > > --- a/arch/loongarch/kernel/image-vars.h
> > > +++ b/arch/loongarch/kernel/image-vars.h
> > > @@ -11,7 +11,6 @@ __efistub_strcmp              =3D strcmp;
> > >  __efistub_kernel_entry         =3D kernel_entry;
> > >  __efistub_kernel_asize         =3D kernel_asize;
> > >  __efistub_kernel_fsize         =3D kernel_fsize;
> > > -__efistub_kernel_offset                =3D kernel_offset;
> > >  #if defined(CONFIG_EFI_EARLYCON) || defined(CONFIG_SYSFB)
> > >  __efistub_screen_info          =3D screen_info;
> > >  #endif
> > > diff --git a/arch/loongarch/kernel/vmlinux.lds.S b/arch/loongarch/ker=
nel/vmlinux.lds.S
> > > index bb2ec86f37a8..a5d0cd2035da 100644
> > > --- a/arch/loongarch/kernel/vmlinux.lds.S
> > > +++ b/arch/loongarch/kernel/vmlinux.lds.S
> > > @@ -143,7 +143,6 @@ SECTIONS
> > >         _kernel_fsize =3D _edata - _text;
> > >         _kernel_vsize =3D _end - __initdata_begin;
> > >         _kernel_rsize =3D _edata - __initdata_begin;
> > > -       _kernel_offset =3D kernel_offset - _text;
> > >  #endif
> > >
> > >         .gptab.sdata : {
> > > diff --git a/drivers/firmware/efi/libstub/loongarch-stub.c b/drivers/=
firmware/efi/libstub/loongarch-stub.c
> > > index d6ec5d4b8dbe..736b6aae323d 100644
> > > --- a/drivers/firmware/efi/libstub/loongarch-stub.c
> > > +++ b/drivers/firmware/efi/libstub/loongarch-stub.c
> > > @@ -8,10 +8,10 @@
> > >  #include <asm/efi.h>
> > >  #include <asm/addrspace.h>
> > >  #include "efistub.h"
> > > +#include "loongarch-stub.h"
> > >
> > >  extern int kernel_asize;
> > >  extern int kernel_fsize;
> > > -extern int kernel_offset;
> > >  extern int kernel_entry;
> > >
> > >  efi_status_t handle_kernel_image(unsigned long *image_addr,
> > > @@ -24,7 +24,7 @@ efi_status_t handle_kernel_image(unsigned long *ima=
ge_addr,
> > >         efi_status_t status;
> > >         unsigned long kernel_addr =3D 0;
> > >
> > > -       kernel_addr =3D (unsigned long)&kernel_offset - kernel_offset=
;
> > > +       kernel_addr =3D (unsigned long)image->image_base;
> > >
> > >         status =3D efi_relocate_kernel(&kernel_addr, kernel_fsize, ke=
rnel_asize,
> > >                      EFI_KIMG_PREFERRED_ADDRESS, efi_get_kimg_min_ali=
gn(), 0x0);
> > > @@ -35,9 +35,10 @@ efi_status_t handle_kernel_image(unsigned long *im=
age_addr,
> > >         return status;
> > >  }
> > >
> > > -unsigned long kernel_entry_address(unsigned long kernel_addr)
> > > +unsigned long kernel_entry_address(unsigned long kernel_addr,
> > > +               efi_loaded_image_t *image)
> > >  {
> > > -       unsigned long base =3D (unsigned long)&kernel_offset - kernel=
_offset;
> > > +       unsigned long base =3D (unsigned long)image->image_base;
> > >
> > >         return (unsigned long)&kernel_entry - base + kernel_addr;
> > >  }
> > > diff --git a/drivers/firmware/efi/libstub/loongarch-stub.h b/drivers/=
firmware/efi/libstub/loongarch-stub.h
> > > new file mode 100644
> > > index 000000000000..cd015955a015
> > > --- /dev/null
> > > +++ b/drivers/firmware/efi/libstub/loongarch-stub.h
> > > @@ -0,0 +1,4 @@
> > > +/* SPDX-License-Identifier: GPL-2.0-only */
> > > +
> > > +unsigned long kernel_entry_address(unsigned long kernel_addr,
> > > +               efi_loaded_image_t *image);
> > > diff --git a/drivers/firmware/efi/libstub/loongarch.c b/drivers/firmw=
are/efi/libstub/loongarch.c
> > > index 0e0aa6cda73f..684c9354637c 100644
> > > --- a/drivers/firmware/efi/libstub/loongarch.c
> > > +++ b/drivers/firmware/efi/libstub/loongarch.c
> > > @@ -8,6 +8,7 @@
> > >  #include <asm/efi.h>
> > >  #include <asm/addrspace.h>
> > >  #include "efistub.h"
> > > +#include "loongarch-stub.h"
> > >
> > >  typedef void __noreturn (*kernel_entry_t)(bool efi, unsigned long cm=
dline,
> > >                                           unsigned long systab);
> > > @@ -37,7 +38,8 @@ static efi_status_t exit_boot_func(struct efi_boot_=
memmap *map, void *priv)
> > >         return EFI_SUCCESS;
> > >  }
> > >
> > > -unsigned long __weak kernel_entry_address(unsigned long kernel_addr)
> > > +unsigned long __weak kernel_entry_address(unsigned long kernel_addr,
> > > +               efi_loaded_image_t *image)
> > >  {
> > >         return *(unsigned long *)(kernel_addr + 8) - VMLINUX_LOAD_ADD=
RESS + kernel_addr;
> > >  }
> > > @@ -73,7 +75,7 @@ efi_status_t efi_boot_kernel(void *handle, efi_load=
ed_image_t *image,
> > >         csr_write64(CSR_DMW0_INIT, LOONGARCH_CSR_DMWIN0);
> > >         csr_write64(CSR_DMW1_INIT, LOONGARCH_CSR_DMWIN1);
> > >
> > > -       real_kernel_entry =3D (void *)kernel_entry_address(kernel_add=
r);
> > > +       real_kernel_entry =3D (void *)kernel_entry_address(kernel_add=
r, image);
> > >
> > >         real_kernel_entry(true, (unsigned long)cmdline_ptr,
> > >                           (unsigned long)efi_system_table);
> > > --
> > > 2.27.0
> > >

