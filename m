Return-Path: <linux-efi+bounces-242-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A2F8181A1
	for <lists+linux-efi@lfdr.de>; Tue, 19 Dec 2023 07:40:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE9282851C9
	for <lists+linux-efi@lfdr.de>; Tue, 19 Dec 2023 06:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F85179EC;
	Tue, 19 Dec 2023 06:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RGhjgaX2"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842E9C2C2
	for <linux-efi@vger.kernel.org>; Tue, 19 Dec 2023 06:40:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2997FC433C7
	for <linux-efi@vger.kernel.org>; Tue, 19 Dec 2023 06:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702968028;
	bh=eBQp0k+VMiZEWn74CLYjQ4SZo7kTF5Wx2linxHm/Wcg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=RGhjgaX2Wv7ttNEgeDteJuQi3tS/XakPDslmwGS+RGw2GtqaR07xX0c64kI9HwNq6
	 UeSdOUG2SwOeTqLv8liQYspt0VRvoW4HGxoyefPjdV2NFz2+tHU4KMuOTsq7iQqRXw
	 VyAM7Hcvuq+gAmxBiUYG01ewem/YxWwrubycp2EAKMqgwXRGzjtbBkzLGTbHmmrvEq
	 NO94QyWHwQAQRCfAtSn1eDPCfgYayHbBXR6Sbga8MRlzP6d9z12uvIGAg6D3QyJjqB
	 laG8WgFqApd0cYSgHNwjTu1ol033+iKmtJZ37FKarThPKDCWENmdm8ppdP4lk/AnEx
	 KVGPCx/hjSm+g==
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a2331caab22so314301866b.3
        for <linux-efi@vger.kernel.org>; Mon, 18 Dec 2023 22:40:28 -0800 (PST)
X-Gm-Message-State: AOJu0YzY3PVGFDLLmwjZ8ehd+awvJBV5IeTELIJrbrfPY7IZ+20RP/Sa
	Gt6/fdJ59cCROV4hDLvV0Cl4MgreBZlQ1+YqRC0=
X-Google-Smtp-Source: AGHT+IF5rNX2FWvY25YKMU9hikGlnyqRnLnkwk1U2rmYBoPt4qtPdsucrs/xsbT06WQy/yp3z8Euu6X2/jeUGyrVoE8=
X-Received: by 2002:a17:906:1087:b0:a22:e827:fb79 with SMTP id
 u7-20020a170906108700b00a22e827fb79mr5699842eju.6.1702968026605; Mon, 18 Dec
 2023 22:40:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231219053543.11726-1-wangyao@lemote.com>
In-Reply-To: <20231219053543.11726-1-wangyao@lemote.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Tue, 19 Dec 2023 14:40:14 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5VtHmDJhwQp7SJ_uF92+ReEjcSLDpFh+y618SG=YXpbw@mail.gmail.com>
Message-ID: <CAAhV-H5VtHmDJhwQp7SJ_uF92+ReEjcSLDpFh+y618SG=YXpbw@mail.gmail.com>
Subject: Re: [PATCH] efi/loongarch: Directly position the loaded image file
To: wangyao@lemote.com
Cc: ardb@kernel.org, wangrui@loongson.cn, linux-efi@vger.kernel.org, 
	loongarch@lists.linux.dev, ainux.wang@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Ard and Yao,

The logic of this patch seems right, but I see this in arm64 code:

        if (image->image_base !=3D _text) {
                efi_err("FIRMWARE BUG: efi_loaded_image_t::image_base
has bogus value\n");
                image->image_base =3D _text;
        }

Does this mean image_base is unreliable?

The arm64 code is introduced in commit c2136dceba9a329e997ccce3277
("efi/libstub/arm64: Avoid image_base value from efi_loaded_image"),
and I don't know whether LoongArch has similar problems.

Huacai

On Tue, Dec 19, 2023 at 1:36=E2=80=AFPM <wangyao@lemote.com> wrote:
>
> From: Wang Yao <wangyao@lemote.com>
>
> Replace kernel_offset with image_base to positon the image file that has
> been loaded by UEFI or GRUB.
>
> Signed-off-by: Wang Yao <wangyao@lemote.com>
> ---
>  arch/loongarch/include/asm/efi.h              | 2 --
>  arch/loongarch/kernel/head.S                  | 1 -
>  arch/loongarch/kernel/image-vars.h            | 1 -
>  arch/loongarch/kernel/vmlinux.lds.S           | 1 -
>  drivers/firmware/efi/libstub/loongarch-stub.c | 9 +++++----
>  drivers/firmware/efi/libstub/loongarch-stub.h | 4 ++++
>  drivers/firmware/efi/libstub/loongarch.c      | 6 ++++--
>  7 files changed, 13 insertions(+), 11 deletions(-)
>  create mode 100644 drivers/firmware/efi/libstub/loongarch-stub.h
>
> diff --git a/arch/loongarch/include/asm/efi.h b/arch/loongarch/include/as=
m/efi.h
> index 91d81f9730ab..eddc8e79b3fa 100644
> --- a/arch/loongarch/include/asm/efi.h
> +++ b/arch/loongarch/include/asm/efi.h
> @@ -32,6 +32,4 @@ static inline unsigned long efi_get_kimg_min_align(void=
)
>
>  #define EFI_KIMG_PREFERRED_ADDRESS     PHYSADDR(VMLINUX_LOAD_ADDRESS)
>
> -unsigned long kernel_entry_address(unsigned long kernel_addr);
> -
>  #endif /* _ASM_LOONGARCH_EFI_H */
> diff --git a/arch/loongarch/kernel/head.S b/arch/loongarch/kernel/head.S
> index 53b883db0786..0ecab4216392 100644
> --- a/arch/loongarch/kernel/head.S
> +++ b/arch/loongarch/kernel/head.S
> @@ -34,7 +34,6 @@ pe_header:
>
>  SYM_DATA(kernel_asize, .long _kernel_asize);
>  SYM_DATA(kernel_fsize, .long _kernel_fsize);
> -SYM_DATA(kernel_offset, .long _kernel_offset);
>
>  #endif
>
> diff --git a/arch/loongarch/kernel/image-vars.h b/arch/loongarch/kernel/i=
mage-vars.h
> index 5087416b9678..41ddcf56d21c 100644
> --- a/arch/loongarch/kernel/image-vars.h
> +++ b/arch/loongarch/kernel/image-vars.h
> @@ -11,7 +11,6 @@ __efistub_strcmp              =3D strcmp;
>  __efistub_kernel_entry         =3D kernel_entry;
>  __efistub_kernel_asize         =3D kernel_asize;
>  __efistub_kernel_fsize         =3D kernel_fsize;
> -__efistub_kernel_offset                =3D kernel_offset;
>  #if defined(CONFIG_EFI_EARLYCON) || defined(CONFIG_SYSFB)
>  __efistub_screen_info          =3D screen_info;
>  #endif
> diff --git a/arch/loongarch/kernel/vmlinux.lds.S b/arch/loongarch/kernel/=
vmlinux.lds.S
> index bb2ec86f37a8..a5d0cd2035da 100644
> --- a/arch/loongarch/kernel/vmlinux.lds.S
> +++ b/arch/loongarch/kernel/vmlinux.lds.S
> @@ -143,7 +143,6 @@ SECTIONS
>         _kernel_fsize =3D _edata - _text;
>         _kernel_vsize =3D _end - __initdata_begin;
>         _kernel_rsize =3D _edata - __initdata_begin;
> -       _kernel_offset =3D kernel_offset - _text;
>  #endif
>
>         .gptab.sdata : {
> diff --git a/drivers/firmware/efi/libstub/loongarch-stub.c b/drivers/firm=
ware/efi/libstub/loongarch-stub.c
> index d6ec5d4b8dbe..736b6aae323d 100644
> --- a/drivers/firmware/efi/libstub/loongarch-stub.c
> +++ b/drivers/firmware/efi/libstub/loongarch-stub.c
> @@ -8,10 +8,10 @@
>  #include <asm/efi.h>
>  #include <asm/addrspace.h>
>  #include "efistub.h"
> +#include "loongarch-stub.h"
>
>  extern int kernel_asize;
>  extern int kernel_fsize;
> -extern int kernel_offset;
>  extern int kernel_entry;
>
>  efi_status_t handle_kernel_image(unsigned long *image_addr,
> @@ -24,7 +24,7 @@ efi_status_t handle_kernel_image(unsigned long *image_a=
ddr,
>         efi_status_t status;
>         unsigned long kernel_addr =3D 0;
>
> -       kernel_addr =3D (unsigned long)&kernel_offset - kernel_offset;
> +       kernel_addr =3D (unsigned long)image->image_base;
>
>         status =3D efi_relocate_kernel(&kernel_addr, kernel_fsize, kernel=
_asize,
>                      EFI_KIMG_PREFERRED_ADDRESS, efi_get_kimg_min_align()=
, 0x0);
> @@ -35,9 +35,10 @@ efi_status_t handle_kernel_image(unsigned long *image_=
addr,
>         return status;
>  }
>
> -unsigned long kernel_entry_address(unsigned long kernel_addr)
> +unsigned long kernel_entry_address(unsigned long kernel_addr,
> +               efi_loaded_image_t *image)
>  {
> -       unsigned long base =3D (unsigned long)&kernel_offset - kernel_off=
set;
> +       unsigned long base =3D (unsigned long)image->image_base;
>
>         return (unsigned long)&kernel_entry - base + kernel_addr;
>  }
> diff --git a/drivers/firmware/efi/libstub/loongarch-stub.h b/drivers/firm=
ware/efi/libstub/loongarch-stub.h
> new file mode 100644
> index 000000000000..cd015955a015
> --- /dev/null
> +++ b/drivers/firmware/efi/libstub/loongarch-stub.h
> @@ -0,0 +1,4 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +
> +unsigned long kernel_entry_address(unsigned long kernel_addr,
> +               efi_loaded_image_t *image);
> diff --git a/drivers/firmware/efi/libstub/loongarch.c b/drivers/firmware/=
efi/libstub/loongarch.c
> index 0e0aa6cda73f..684c9354637c 100644
> --- a/drivers/firmware/efi/libstub/loongarch.c
> +++ b/drivers/firmware/efi/libstub/loongarch.c
> @@ -8,6 +8,7 @@
>  #include <asm/efi.h>
>  #include <asm/addrspace.h>
>  #include "efistub.h"
> +#include "loongarch-stub.h"
>
>  typedef void __noreturn (*kernel_entry_t)(bool efi, unsigned long cmdlin=
e,
>                                           unsigned long systab);
> @@ -37,7 +38,8 @@ static efi_status_t exit_boot_func(struct efi_boot_memm=
ap *map, void *priv)
>         return EFI_SUCCESS;
>  }
>
> -unsigned long __weak kernel_entry_address(unsigned long kernel_addr)
> +unsigned long __weak kernel_entry_address(unsigned long kernel_addr,
> +               efi_loaded_image_t *image)
>  {
>         return *(unsigned long *)(kernel_addr + 8) - VMLINUX_LOAD_ADDRESS=
 + kernel_addr;
>  }
> @@ -73,7 +75,7 @@ efi_status_t efi_boot_kernel(void *handle, efi_loaded_i=
mage_t *image,
>         csr_write64(CSR_DMW0_INIT, LOONGARCH_CSR_DMWIN0);
>         csr_write64(CSR_DMW1_INIT, LOONGARCH_CSR_DMWIN1);
>
> -       real_kernel_entry =3D (void *)kernel_entry_address(kernel_addr);
> +       real_kernel_entry =3D (void *)kernel_entry_address(kernel_addr, i=
mage);
>
>         real_kernel_entry(true, (unsigned long)cmdline_ptr,
>                           (unsigned long)efi_system_table);
> --
> 2.27.0
>

