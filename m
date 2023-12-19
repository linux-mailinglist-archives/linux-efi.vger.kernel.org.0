Return-Path: <linux-efi+bounces-246-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EB53818449
	for <lists+linux-efi@lfdr.de>; Tue, 19 Dec 2023 10:22:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 458611C23BA9
	for <lists+linux-efi@lfdr.de>; Tue, 19 Dec 2023 09:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42ABC13AC4;
	Tue, 19 Dec 2023 09:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i1HPC9Ex"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28DF4134B4
	for <linux-efi@vger.kernel.org>; Tue, 19 Dec 2023 09:22:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F224BC433CA
	for <linux-efi@vger.kernel.org>; Tue, 19 Dec 2023 09:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702977731;
	bh=0u58FpPHyar+jepb2pMgOvDTYMdpvayx2cB+S88DNRY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=i1HPC9Ex7wDpbXfE/hDPVU5nSgByNetoqAXXIYyHNPxgaV4VudTvTfg1k8E6CfVGR
	 ccMydP28+yZbessVbxFMasseh4/QoKGSH5zh+RPC7Bo09CuBXcwgkYObflKDlgbsJn
	 ibpC48h5v3s2X6Kc1XNvdO0xAT+FHiDG3jwLkV9GUdNK1R6CJY0/5CPlaMuPaUTT2x
	 pAK9B87tZoTMj2z3hb1tt1Gs91KAjXA/+K1F6EpCdQI/okBH/zQ1b7S4JP0395SqMt
	 tvRHcZvuJpx3rn34ht+HhVf9sj8eAielXIRIkv000nDqcS7fGpve/g/Y+EkdVX9qwX
	 lnU8WzaVehkZg==
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2cc7ba7d12eso9842851fa.3
        for <linux-efi@vger.kernel.org>; Tue, 19 Dec 2023 01:22:10 -0800 (PST)
X-Gm-Message-State: AOJu0Yyl9KzTMSb8Mj+Yqnw8ngOWX1/aLTfPcSYLRv8KFqwi2NAQuLGX
	Q14L3rrBkh0MJbCkiKAaLYGictb3VAdIiUP3YMQ=
X-Google-Smtp-Source: AGHT+IFrtRZXnAmsf4xPVXxtymglPLQlh/oKmjJsBlB/eoShYuX/BpbU2jhgL6ZP4LNhvMc8qfPMdg46mhd5F8zwEOo=
X-Received: by 2002:a2e:a363:0:b0:2cc:7868:c200 with SMTP id
 i3-20020a2ea363000000b002cc7868c200mr717572ljn.90.1702977729148; Tue, 19 Dec
 2023 01:22:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231219091405.39867-1-wangyao@lemote.com>
In-Reply-To: <20231219091405.39867-1-wangyao@lemote.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 19 Dec 2023 10:21:57 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEPdMBkne=ugR_j1Be8Aeh8jCA_ryHvh8rMA-c27i+RuA@mail.gmail.com>
Message-ID: <CAMj1kXEPdMBkne=ugR_j1Be8Aeh8jCA_ryHvh8rMA-c27i+RuA@mail.gmail.com>
Subject: Re: [PATCH v2] efi/loongarch: Directly position the loaded image file
To: wangyao@lemote.com
Cc: chenhuacai@kernel.org, wangrui@loongson.cn, linux-efi@vger.kernel.org, 
	loongarch@lists.linux.dev, ainux.wang@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 19 Dec 2023 at 10:14, <wangyao@lemote.com> wrote:
>
> From: Wang Yao <wangyao@lemote.com>
>
> The use of the 'kernel_offset' variable to position the image file that
> has been loaded by UEFI or GRUB is unnecessary, because we can directly
> position the loaded image file through using the image_base field of the
> efi_loaded_image struct provided by UEFI.
>
> Replace kernel_offset with image_base to positon the image file that has
> been loaded by UEFI or GRUB.
>
> Signed-off-by: Wang Yao <wangyao@lemote.com>
> ---
>
> v1->v2:
> Rewrite the commit log include 'why', not just include 'how'.
>
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
> diff --git a/arch/loongarch/include/asm/efi.h b/arch/loongarch/include/asm/efi.h
> index 91d81f9730ab..eddc8e79b3fa 100644
> --- a/arch/loongarch/include/asm/efi.h
> +++ b/arch/loongarch/include/asm/efi.h
> @@ -32,6 +32,4 @@ static inline unsigned long efi_get_kimg_min_align(void)
>
>  #define EFI_KIMG_PREFERRED_ADDRESS     PHYSADDR(VMLINUX_LOAD_ADDRESS)
>
> -unsigned long kernel_entry_address(unsigned long kernel_addr);
> -

Why are you removing this? Won't that cause missing prototype warnings?

The rest of the patch looks fine to me, but I haven't tested it.

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
> diff --git a/arch/loongarch/kernel/image-vars.h b/arch/loongarch/kernel/image-vars.h
> index 5087416b9678..41ddcf56d21c 100644
> --- a/arch/loongarch/kernel/image-vars.h
> +++ b/arch/loongarch/kernel/image-vars.h
> @@ -11,7 +11,6 @@ __efistub_strcmp              = strcmp;
>  __efistub_kernel_entry         = kernel_entry;
>  __efistub_kernel_asize         = kernel_asize;
>  __efistub_kernel_fsize         = kernel_fsize;
> -__efistub_kernel_offset                = kernel_offset;
>  #if defined(CONFIG_EFI_EARLYCON) || defined(CONFIG_SYSFB)
>  __efistub_screen_info          = screen_info;
>  #endif
> diff --git a/arch/loongarch/kernel/vmlinux.lds.S b/arch/loongarch/kernel/vmlinux.lds.S
> index bb2ec86f37a8..a5d0cd2035da 100644
> --- a/arch/loongarch/kernel/vmlinux.lds.S
> +++ b/arch/loongarch/kernel/vmlinux.lds.S
> @@ -143,7 +143,6 @@ SECTIONS
>         _kernel_fsize = _edata - _text;
>         _kernel_vsize = _end - __initdata_begin;
>         _kernel_rsize = _edata - __initdata_begin;
> -       _kernel_offset = kernel_offset - _text;
>  #endif
>
>         .gptab.sdata : {
> diff --git a/drivers/firmware/efi/libstub/loongarch-stub.c b/drivers/firmware/efi/libstub/loongarch-stub.c
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
> @@ -24,7 +24,7 @@ efi_status_t handle_kernel_image(unsigned long *image_addr,
>         efi_status_t status;
>         unsigned long kernel_addr = 0;
>
> -       kernel_addr = (unsigned long)&kernel_offset - kernel_offset;
> +       kernel_addr = (unsigned long)image->image_base;
>
>         status = efi_relocate_kernel(&kernel_addr, kernel_fsize, kernel_asize,
>                      EFI_KIMG_PREFERRED_ADDRESS, efi_get_kimg_min_align(), 0x0);
> @@ -35,9 +35,10 @@ efi_status_t handle_kernel_image(unsigned long *image_addr,
>         return status;
>  }
>
> -unsigned long kernel_entry_address(unsigned long kernel_addr)
> +unsigned long kernel_entry_address(unsigned long kernel_addr,
> +               efi_loaded_image_t *image)
>  {
> -       unsigned long base = (unsigned long)&kernel_offset - kernel_offset;
> +       unsigned long base = (unsigned long)image->image_base;
>
>         return (unsigned long)&kernel_entry - base + kernel_addr;
>  }
> diff --git a/drivers/firmware/efi/libstub/loongarch-stub.h b/drivers/firmware/efi/libstub/loongarch-stub.h
> new file mode 100644
> index 000000000000..cd015955a015
> --- /dev/null
> +++ b/drivers/firmware/efi/libstub/loongarch-stub.h
> @@ -0,0 +1,4 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +
> +unsigned long kernel_entry_address(unsigned long kernel_addr,
> +               efi_loaded_image_t *image);
> diff --git a/drivers/firmware/efi/libstub/loongarch.c b/drivers/firmware/efi/libstub/loongarch.c
> index 0e0aa6cda73f..684c9354637c 100644
> --- a/drivers/firmware/efi/libstub/loongarch.c
> +++ b/drivers/firmware/efi/libstub/loongarch.c
> @@ -8,6 +8,7 @@
>  #include <asm/efi.h>
>  #include <asm/addrspace.h>
>  #include "efistub.h"
> +#include "loongarch-stub.h"
>
>  typedef void __noreturn (*kernel_entry_t)(bool efi, unsigned long cmdline,
>                                           unsigned long systab);
> @@ -37,7 +38,8 @@ static efi_status_t exit_boot_func(struct efi_boot_memmap *map, void *priv)
>         return EFI_SUCCESS;
>  }
>
> -unsigned long __weak kernel_entry_address(unsigned long kernel_addr)
> +unsigned long __weak kernel_entry_address(unsigned long kernel_addr,
> +               efi_loaded_image_t *image)
>  {
>         return *(unsigned long *)(kernel_addr + 8) - VMLINUX_LOAD_ADDRESS + kernel_addr;
>  }
> @@ -73,7 +75,7 @@ efi_status_t efi_boot_kernel(void *handle, efi_loaded_image_t *image,
>         csr_write64(CSR_DMW0_INIT, LOONGARCH_CSR_DMWIN0);
>         csr_write64(CSR_DMW1_INIT, LOONGARCH_CSR_DMWIN1);
>
> -       real_kernel_entry = (void *)kernel_entry_address(kernel_addr);
> +       real_kernel_entry = (void *)kernel_entry_address(kernel_addr, image);
>
>         real_kernel_entry(true, (unsigned long)cmdline_ptr,
>                           (unsigned long)efi_system_table);
> --
> 2.27.0
>

