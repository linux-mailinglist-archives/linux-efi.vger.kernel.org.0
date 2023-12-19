Return-Path: <linux-efi+bounces-247-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C8438818465
	for <lists+linux-efi@lfdr.de>; Tue, 19 Dec 2023 10:27:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F15EB234D2
	for <lists+linux-efi@lfdr.de>; Tue, 19 Dec 2023 09:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1115813AD7;
	Tue, 19 Dec 2023 09:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mC6rAf7+"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247F614283
	for <linux-efi@vger.kernel.org>; Tue, 19 Dec 2023 09:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-dbd5b96b12eso153681276.2
        for <linux-efi@vger.kernel.org>; Tue, 19 Dec 2023 01:27:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702978020; x=1703582820; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wgr+bPFMf0jzYI3cGscIZIVI1UlYgc3N2TeKFvuxGPM=;
        b=mC6rAf7+Tlo5gT8O7tcFPiekvfGHdX/yEomCwUZstddwPsNH33kUbi1HzUESsPsp2o
         kv8rnFWNKUyMS8WdjrH8xrF18O7GbXH3Xgem7Iq3/udKyZxBbR5FSZxyYAGv7sBhkG6w
         Pgo1YOS06ODWpKX+8L3KlwbeGAKf5weWIwSV2OYL4IiNKWQeowkaAbNBJfeWxNO5qf7M
         Ik5IokTOZdWB5geIgKgC4tJTXo2Xvy41SICZQfVeyh05gQn4lugflcV9wVBP0TL6Zdtu
         OBn6ydKnrboU+Bqfe60yhrOacxYVdJIDuaBPgnnK8w4EwbxVt8CMhjt5wqstTKhK69Vj
         nCng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702978020; x=1703582820;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wgr+bPFMf0jzYI3cGscIZIVI1UlYgc3N2TeKFvuxGPM=;
        b=X9DQeTjY66giJAlwC95vXciVsjfX8Cq9i8W4nO/cKpYxMR/HkZ6HP/WPqKV5LERZMC
         NCC93ZfRqNYSRfWlCSeueMUUAGfR3Psde8Lc8wSpVmySYE9fABqShLYrRogFoo7WcCn3
         KQDnfzGXk+5pCVt02u2JQgJF/85Kki7U0Ij0NX9B92zxfCsjWbSlRePoVT3STMC/zgZ9
         eKcvnkfuYOv0VoldgfACgdbWoygSnie/kSPztq/jSVOoRnQIjAlM7A+fjKK15dzEzK7U
         sGMobqGP97XC5F0ctmOnuMcYnxWFn6NDJL/Gpi+ee/zqWgQ8Q7LG2oHFqp15m6QQ4l3e
         zWzA==
X-Gm-Message-State: AOJu0Yxr2WIU780rbe4io51zUweY65v5g+jDrVgq6H49X492S0prHAoG
	e/oEhGqLbiFozLsD5lAoMMBty9zKJy+h2qLVvC0piuXawo+Dwv4y
X-Google-Smtp-Source: AGHT+IGuzet49OLo7wla1HLPzfqDEhH2BYgEJTaX6a3rL8GfnBEaDXvvQb6RCyTzso9EfilLtSBnaFSZjKXhTYYQsRQ=
X-Received: by 2002:a25:c41:0:b0:db5:3b32:b1c3 with SMTP id
 62-20020a250c41000000b00db53b32b1c3mr9734179ybm.21.1702978020049; Tue, 19 Dec
 2023 01:27:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231219091405.39867-1-wangyao@lemote.com> <CAMj1kXEPdMBkne=ugR_j1Be8Aeh8jCA_ryHvh8rMA-c27i+RuA@mail.gmail.com>
In-Reply-To: <CAMj1kXEPdMBkne=ugR_j1Be8Aeh8jCA_ryHvh8rMA-c27i+RuA@mail.gmail.com>
From: Ainux Wang <ainux.wang@gmail.com>
Date: Tue, 19 Dec 2023 17:26:21 +0800
Message-ID: <CAPWE4_wydoTWHUYPmALp1oii+=ALVy_BTDUO_1wOo7XmkJ=cjA@mail.gmail.com>
Subject: Re: [PATCH v2] efi/loongarch: Directly position the loaded image file
To: Ard Biesheuvel <ardb@kernel.org>
Cc: wangyao@lemote.com, chenhuacai@kernel.org, wangrui@loongson.cn, 
	linux-efi@vger.kernel.org, loongarch@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ard Biesheuvel <ardb@kernel.org> =E4=BA=8E2023=E5=B9=B412=E6=9C=8819=E6=97=
=A5=E5=91=A8=E4=BA=8C 17:22=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue, 19 Dec 2023 at 10:14, <wangyao@lemote.com> wrote:
> >
> > From: Wang Yao <wangyao@lemote.com>
> >
> > The use of the 'kernel_offset' variable to position the image file that
> > has been loaded by UEFI or GRUB is unnecessary, because we can directly
> > position the loaded image file through using the image_base field of th=
e
> > efi_loaded_image struct provided by UEFI.
> >
> > Replace kernel_offset with image_base to positon the image file that ha=
s
> > been loaded by UEFI or GRUB.
> >
> > Signed-off-by: Wang Yao <wangyao@lemote.com>
> > ---
> >
> > v1->v2:
> > Rewrite the commit log include 'why', not just include 'how'.
> >
> >  arch/loongarch/include/asm/efi.h              | 2 --
> >  arch/loongarch/kernel/head.S                  | 1 -
> >  arch/loongarch/kernel/image-vars.h            | 1 -
> >  arch/loongarch/kernel/vmlinux.lds.S           | 1 -
> >  drivers/firmware/efi/libstub/loongarch-stub.c | 9 +++++----
> >  drivers/firmware/efi/libstub/loongarch-stub.h | 4 ++++
> >  drivers/firmware/efi/libstub/loongarch.c      | 6 ++++--
> >  7 files changed, 13 insertions(+), 11 deletions(-)
> >  create mode 100644 drivers/firmware/efi/libstub/loongarch-stub.h
> >
> > diff --git a/arch/loongarch/include/asm/efi.h b/arch/loongarch/include/=
asm/efi.h
> > index 91d81f9730ab..eddc8e79b3fa 100644
> > --- a/arch/loongarch/include/asm/efi.h
> > +++ b/arch/loongarch/include/asm/efi.h
> > @@ -32,6 +32,4 @@ static inline unsigned long efi_get_kimg_min_align(vo=
id)
> >
> >  #define EFI_KIMG_PREFERRED_ADDRESS     PHYSADDR(VMLINUX_LOAD_ADDRESS)
> >
> > -unsigned long kernel_entry_address(unsigned long kernel_addr);
> > -
>
> Why are you removing this? Won't that cause missing prototype warnings?
>
> The rest of the patch looks fine to me, but I haven't tested it.
>

Because the efi_loaded_image_t struct is defined in the efistub.h.

> >  #endif /* _ASM_LOONGARCH_EFI_H */
> > diff --git a/arch/loongarch/kernel/head.S b/arch/loongarch/kernel/head.=
S
> > index 53b883db0786..0ecab4216392 100644
> > --- a/arch/loongarch/kernel/head.S
> > +++ b/arch/loongarch/kernel/head.S
> > @@ -34,7 +34,6 @@ pe_header:
> >
> >  SYM_DATA(kernel_asize, .long _kernel_asize);
> >  SYM_DATA(kernel_fsize, .long _kernel_fsize);
> > -SYM_DATA(kernel_offset, .long _kernel_offset);
> >
> >  #endif
> >
> > diff --git a/arch/loongarch/kernel/image-vars.h b/arch/loongarch/kernel=
/image-vars.h
> > index 5087416b9678..41ddcf56d21c 100644
> > --- a/arch/loongarch/kernel/image-vars.h
> > +++ b/arch/loongarch/kernel/image-vars.h
> > @@ -11,7 +11,6 @@ __efistub_strcmp              =3D strcmp;
> >  __efistub_kernel_entry         =3D kernel_entry;
> >  __efistub_kernel_asize         =3D kernel_asize;
> >  __efistub_kernel_fsize         =3D kernel_fsize;
> > -__efistub_kernel_offset                =3D kernel_offset;
> >  #if defined(CONFIG_EFI_EARLYCON) || defined(CONFIG_SYSFB)
> >  __efistub_screen_info          =3D screen_info;
> >  #endif
> > diff --git a/arch/loongarch/kernel/vmlinux.lds.S b/arch/loongarch/kerne=
l/vmlinux.lds.S
> > index bb2ec86f37a8..a5d0cd2035da 100644
> > --- a/arch/loongarch/kernel/vmlinux.lds.S
> > +++ b/arch/loongarch/kernel/vmlinux.lds.S
> > @@ -143,7 +143,6 @@ SECTIONS
> >         _kernel_fsize =3D _edata - _text;
> >         _kernel_vsize =3D _end - __initdata_begin;
> >         _kernel_rsize =3D _edata - __initdata_begin;
> > -       _kernel_offset =3D kernel_offset - _text;
> >  #endif
> >
> >         .gptab.sdata : {
> > diff --git a/drivers/firmware/efi/libstub/loongarch-stub.c b/drivers/fi=
rmware/efi/libstub/loongarch-stub.c
> > index d6ec5d4b8dbe..736b6aae323d 100644
> > --- a/drivers/firmware/efi/libstub/loongarch-stub.c
> > +++ b/drivers/firmware/efi/libstub/loongarch-stub.c
> > @@ -8,10 +8,10 @@
> >  #include <asm/efi.h>
> >  #include <asm/addrspace.h>
> >  #include "efistub.h"
> > +#include "loongarch-stub.h"
> >
> >  extern int kernel_asize;
> >  extern int kernel_fsize;
> > -extern int kernel_offset;
> >  extern int kernel_entry;
> >
> >  efi_status_t handle_kernel_image(unsigned long *image_addr,
> > @@ -24,7 +24,7 @@ efi_status_t handle_kernel_image(unsigned long *image=
_addr,
> >         efi_status_t status;
> >         unsigned long kernel_addr =3D 0;
> >
> > -       kernel_addr =3D (unsigned long)&kernel_offset - kernel_offset;
> > +       kernel_addr =3D (unsigned long)image->image_base;
> >
> >         status =3D efi_relocate_kernel(&kernel_addr, kernel_fsize, kern=
el_asize,
> >                      EFI_KIMG_PREFERRED_ADDRESS, efi_get_kimg_min_align=
(), 0x0);
> > @@ -35,9 +35,10 @@ efi_status_t handle_kernel_image(unsigned long *imag=
e_addr,
> >         return status;
> >  }
> >
> > -unsigned long kernel_entry_address(unsigned long kernel_addr)
> > +unsigned long kernel_entry_address(unsigned long kernel_addr,
> > +               efi_loaded_image_t *image)
> >  {
> > -       unsigned long base =3D (unsigned long)&kernel_offset - kernel_o=
ffset;
> > +       unsigned long base =3D (unsigned long)image->image_base;
> >
> >         return (unsigned long)&kernel_entry - base + kernel_addr;
> >  }
> > diff --git a/drivers/firmware/efi/libstub/loongarch-stub.h b/drivers/fi=
rmware/efi/libstub/loongarch-stub.h
> > new file mode 100644
> > index 000000000000..cd015955a015
> > --- /dev/null
> > +++ b/drivers/firmware/efi/libstub/loongarch-stub.h
> > @@ -0,0 +1,4 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +
> > +unsigned long kernel_entry_address(unsigned long kernel_addr,
> > +               efi_loaded_image_t *image);
> > diff --git a/drivers/firmware/efi/libstub/loongarch.c b/drivers/firmwar=
e/efi/libstub/loongarch.c
> > index 0e0aa6cda73f..684c9354637c 100644
> > --- a/drivers/firmware/efi/libstub/loongarch.c
> > +++ b/drivers/firmware/efi/libstub/loongarch.c
> > @@ -8,6 +8,7 @@
> >  #include <asm/efi.h>
> >  #include <asm/addrspace.h>
> >  #include "efistub.h"
> > +#include "loongarch-stub.h"
> >
> >  typedef void __noreturn (*kernel_entry_t)(bool efi, unsigned long cmdl=
ine,
> >                                           unsigned long systab);
> > @@ -37,7 +38,8 @@ static efi_status_t exit_boot_func(struct efi_boot_me=
mmap *map, void *priv)
> >         return EFI_SUCCESS;
> >  }
> >
> > -unsigned long __weak kernel_entry_address(unsigned long kernel_addr)
> > +unsigned long __weak kernel_entry_address(unsigned long kernel_addr,
> > +               efi_loaded_image_t *image)
> >  {
> >         return *(unsigned long *)(kernel_addr + 8) - VMLINUX_LOAD_ADDRE=
SS + kernel_addr;
> >  }
> > @@ -73,7 +75,7 @@ efi_status_t efi_boot_kernel(void *handle, efi_loaded=
_image_t *image,
> >         csr_write64(CSR_DMW0_INIT, LOONGARCH_CSR_DMWIN0);
> >         csr_write64(CSR_DMW1_INIT, LOONGARCH_CSR_DMWIN1);
> >
> > -       real_kernel_entry =3D (void *)kernel_entry_address(kernel_addr)=
;
> > +       real_kernel_entry =3D (void *)kernel_entry_address(kernel_addr,=
 image);
> >
> >         real_kernel_entry(true, (unsigned long)cmdline_ptr,
> >                           (unsigned long)efi_system_table);
> > --
> > 2.27.0
> >

