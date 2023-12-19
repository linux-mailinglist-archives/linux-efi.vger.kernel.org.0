Return-Path: <linux-efi+bounces-243-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AE86818354
	for <lists+linux-efi@lfdr.de>; Tue, 19 Dec 2023 09:28:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85EA61C23973
	for <lists+linux-efi@lfdr.de>; Tue, 19 Dec 2023 08:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4E331170D;
	Tue, 19 Dec 2023 08:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XZmsvmTS"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB44F125BD
	for <linux-efi@vger.kernel.org>; Tue, 19 Dec 2023 08:28:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 661F0C433C7
	for <linux-efi@vger.kernel.org>; Tue, 19 Dec 2023 08:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702974517;
	bh=Tzw5X4hmiFkJqh8XnlTxfxniMBRb/2JB4nye1hrtzFw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=XZmsvmTSnihOCnx1zQY3RcjdLgVd0g0EPjVo3OrkneRp8gUP35ikpDPYRwS+Sg0Ww
	 +0h0+ZxRqWtvFMQdGNFYroGgK6ZSnaXfvuKhfiVCIzX/iLtRU1QyEgf2kP/uvECO7I
	 mIGCBWKKYlj4tpJ7nnaJLITWqBp8xLh7HTgem9Cj/q1so/U8lsShAKd6M8m6jpdI1v
	 dhe59st2hvypLvP2KszMM8RRDqtqU84+beQ0Za/bakEh8TrvoVwTQUXghT5X18shS5
	 pX50WbvJkPxKY9mbY2nXX+GWy69dUy+2Naipbz0dTPWALly5iHb+3F/ZHXyX6wqhsZ
	 SKaF03sAQQd6w==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-50e18689828so4740218e87.2
        for <linux-efi@vger.kernel.org>; Tue, 19 Dec 2023 00:28:37 -0800 (PST)
X-Gm-Message-State: AOJu0YzRSh1Igu1wtpDlVfTc/T1Rhheqnq6U+GuQIwmjEwe5sjWn5f5H
	zDWm6aecWh658LCw9mNNi/hMevU7L0e/BsuYRIE=
X-Google-Smtp-Source: AGHT+IGUDCbd1Ewal4Kwr2G2G6wVvLVNXTIf0QoDuJ7f6rwcc1AJ1jrBqn7UTLZJOduc82MxRUEymFzCyYk8lfQhzfA=
X-Received: by 2002:a05:6512:b9c:b0:50c:180:2162 with SMTP id
 b28-20020a0565120b9c00b0050c01802162mr9647874lfv.99.1702974515599; Tue, 19
 Dec 2023 00:28:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231219053543.11726-1-wangyao@lemote.com> <CAAhV-H5VtHmDJhwQp7SJ_uF92+ReEjcSLDpFh+y618SG=YXpbw@mail.gmail.com>
In-Reply-To: <CAAhV-H5VtHmDJhwQp7SJ_uF92+ReEjcSLDpFh+y618SG=YXpbw@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 19 Dec 2023 09:28:24 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFHVTSQ3yTTTY8QS8chmZXVQdYwyZJJ4TrnQWYzk=7awQ@mail.gmail.com>
Message-ID: <CAMj1kXFHVTSQ3yTTTY8QS8chmZXVQdYwyZJJ4TrnQWYzk=7awQ@mail.gmail.com>
Subject: Re: [PATCH] efi/loongarch: Directly position the loaded image file
To: Huacai Chen <chenhuacai@kernel.org>
Cc: wangyao@lemote.com, wangrui@loongson.cn, linux-efi@vger.kernel.org, 
	loongarch@lists.linux.dev, ainux.wang@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 19 Dec 2023 at 07:40, Huacai Chen <chenhuacai@kernel.org> wrote:
>
> Hi, Ard and Yao,
>
> The logic of this patch seems right, but I see this in arm64 code:
>
>         if (image->image_base !=3D _text) {
>                 efi_err("FIRMWARE BUG: efi_loaded_image_t::image_base
> has bogus value\n");
>                 image->image_base =3D _text;
>         }
>
> Does this mean image_base is unreliable?
>

Only if you use an old distro fork of GRUB. Those would 'repurpose'
the LoadImage protocol created by the firmware to load GRUB by
updating some fields and passing the same protocol to the kernel as
the kernel's loaded image, but failed to set the image_base correctly.

I don't think this is a concern for LoongArch.

> The arm64 code is introduced in commit c2136dceba9a329e997ccce3277
> ("efi/libstub/arm64: Avoid image_base value from efi_loaded_image"),
> and I don't know whether LoongArch has similar problems.
>
> Huacai
>
> On Tue, Dec 19, 2023 at 1:36=E2=80=AFPM <wangyao@lemote.com> wrote:
> >
> > From: Wang Yao <wangyao@lemote.com>
> >
> > Replace kernel_offset with image_base to positon the image file that ha=
s
> > been loaded by UEFI or GRUB.
> >

Why?

When you write a commit log, focus on the why not on the how (we can
all see the 'how' by reading the patch itself)

> > Signed-off-by: Wang Yao <wangyao@lemote.com>
> > ---
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

