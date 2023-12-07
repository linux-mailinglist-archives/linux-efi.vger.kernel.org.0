Return-Path: <linux-efi+bounces-135-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C879808CEA
	for <lists+linux-efi@lfdr.de>; Thu,  7 Dec 2023 17:08:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D3D11C209BA
	for <lists+linux-efi@lfdr.de>; Thu,  7 Dec 2023 16:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DB264652D;
	Thu,  7 Dec 2023 16:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T56Bm75H"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602A440BE5
	for <linux-efi@vger.kernel.org>; Thu,  7 Dec 2023 16:08:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1A83C433CA
	for <linux-efi@vger.kernel.org>; Thu,  7 Dec 2023 16:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701965313;
	bh=QVGHxqqfOAQTzUWC27XRFJ7sAfygcugd147o0t5Ow6M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=T56Bm75HO4kbSA0Ka2g8Rl6W3JRdkBTX6FgeL6+01sHqa8If+PgBGSXFw90cAdqgJ
	 +KUd4tG6y1DIRaVgJleI72wN1oOftmzc2OZuS/TQ9Bir2AAbtxYpHyYBO6UmxRtziA
	 l/h/lpeVdspdE9xuqu61xj4Src0vVgWJw/Lr05O1w0B43LAU1mox6QsLi9ARnvovHR
	 2kNGhTiQpovXmeHseQiCxCnKyqQKA40IozUEH/Bn31Kl21juG1Vqr9sdDQJ3eH22Ff
	 3rUqoIU/Cx7+iUBTJII7teG/xg9Fi0AbDTHlIXlO8tfTBZuNj4zoHw5k7KtYsAjob8
	 g4geZrHzNMBTg==
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2c9f8faf57bso12176781fa.3
        for <linux-efi@vger.kernel.org>; Thu, 07 Dec 2023 08:08:33 -0800 (PST)
X-Gm-Message-State: AOJu0Yx0A/ZNIP6HShjUZBfA59K52Ntnv7AtdP1lLngk//2aTrq+58Vn
	WCI1IqpIJGx3gsA9i1ZCtwP7UUAlahdJBVL/nO4=
X-Google-Smtp-Source: AGHT+IE+IWlCKzuHRuwxN3k6U9hFijvLFNFwe3M1UxOQDoQwaC9pPwzBK/71KHdEl+hxMOEEtIqDagBMyjqC/5PuASA=
X-Received: by 2002:a2e:9043:0:b0:2ca:c96:f4c with SMTP id n3-20020a2e9043000000b002ca0c960f4cmr1683385ljg.85.1701965311918;
 Thu, 07 Dec 2023 08:08:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231206002427.25480-1-wangyao@lemote.com>
In-Reply-To: <20231206002427.25480-1-wangyao@lemote.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 7 Dec 2023 17:08:20 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGACgVd2S3J4roGgOzL0o7VmBFEgRNKKhaLHnPh1AxuQQ@mail.gmail.com>
Message-ID: <CAMj1kXGACgVd2S3J4roGgOzL0o7VmBFEgRNKKhaLHnPh1AxuQQ@mail.gmail.com>
Subject: Re: [PATCH v4] efi/loongarch: Use load address to calculate kernel
 entry address
To: wangyao@lemote.com
Cc: chenhuacai@kernel.org, wangrui@loongson.cn, linux-efi@vger.kernel.org, 
	ainux.wang@gmail.com, Huacai Chen <chenhuacai@loongson.cn>
Content-Type: text/plain; charset="UTF-8"

On Wed, 6 Dec 2023 at 01:25, <wangyao@lemote.com> wrote:
>
> From: Wang Yao <wangyao@lemote.com>
>
> The efi_relocate_kernel() may load the PIE kernel to anywhere, the loaded
> address may not be equal to link address or EFI_KIMG_PREFERRED_ADDRESS.
>
> Acked-by: Huacai Chen <chenhuacai@loongson.cn>
> Signed-off-by: Wang Yao <wangyao@lemote.com>

Queued up now in the efi/next tree - thanks.

> ---
>
> v3->v4:
> Add Acked-by: Huacai Chen <chenhuacai@loongson.cn>
>
> v2->v3:
> Dropped TO_CACHE:
> kernel_addr may be DA/PG address, both access kernel entry.
>
> v1->v2:
> Use link address that from DOS header to calculate kernel entry,
> corrected by Huacai Chen.
>
>  arch/loongarch/include/asm/efi.h              | 2 +-
>  drivers/firmware/efi/libstub/loongarch-stub.c | 4 ++--
>  drivers/firmware/efi/libstub/loongarch.c      | 6 +++---
>  3 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/arch/loongarch/include/asm/efi.h b/arch/loongarch/include/asm/efi.h
> index 091897d40b03..91d81f9730ab 100644
> --- a/arch/loongarch/include/asm/efi.h
> +++ b/arch/loongarch/include/asm/efi.h
> @@ -32,6 +32,6 @@ static inline unsigned long efi_get_kimg_min_align(void)
>
>  #define EFI_KIMG_PREFERRED_ADDRESS     PHYSADDR(VMLINUX_LOAD_ADDRESS)
>
> -unsigned long kernel_entry_address(void);
> +unsigned long kernel_entry_address(unsigned long kernel_addr);
>
>  #endif /* _ASM_LOONGARCH_EFI_H */
> diff --git a/drivers/firmware/efi/libstub/loongarch-stub.c b/drivers/firmware/efi/libstub/loongarch-stub.c
> index 72c71ae201f0..d6ec5d4b8dbe 100644
> --- a/drivers/firmware/efi/libstub/loongarch-stub.c
> +++ b/drivers/firmware/efi/libstub/loongarch-stub.c
> @@ -35,9 +35,9 @@ efi_status_t handle_kernel_image(unsigned long *image_addr,
>         return status;
>  }
>
> -unsigned long kernel_entry_address(void)
> +unsigned long kernel_entry_address(unsigned long kernel_addr)
>  {
>         unsigned long base = (unsigned long)&kernel_offset - kernel_offset;
>
> -       return (unsigned long)&kernel_entry - base + VMLINUX_LOAD_ADDRESS;
> +       return (unsigned long)&kernel_entry - base + kernel_addr;
>  }
> diff --git a/drivers/firmware/efi/libstub/loongarch.c b/drivers/firmware/efi/libstub/loongarch.c
> index 807cba2693fc..0e0aa6cda73f 100644
> --- a/drivers/firmware/efi/libstub/loongarch.c
> +++ b/drivers/firmware/efi/libstub/loongarch.c
> @@ -37,9 +37,9 @@ static efi_status_t exit_boot_func(struct efi_boot_memmap *map, void *priv)
>         return EFI_SUCCESS;
>  }
>
> -unsigned long __weak kernel_entry_address(void)
> +unsigned long __weak kernel_entry_address(unsigned long kernel_addr)
>  {
> -       return *(unsigned long *)(PHYSADDR(VMLINUX_LOAD_ADDRESS) + 8);
> +       return *(unsigned long *)(kernel_addr + 8) - VMLINUX_LOAD_ADDRESS + kernel_addr;
>  }
>
>  efi_status_t efi_boot_kernel(void *handle, efi_loaded_image_t *image,
> @@ -73,7 +73,7 @@ efi_status_t efi_boot_kernel(void *handle, efi_loaded_image_t *image,
>         csr_write64(CSR_DMW0_INIT, LOONGARCH_CSR_DMWIN0);
>         csr_write64(CSR_DMW1_INIT, LOONGARCH_CSR_DMWIN1);
>
> -       real_kernel_entry = (void *)kernel_entry_address();
> +       real_kernel_entry = (void *)kernel_entry_address(kernel_addr);
>
>         real_kernel_entry(true, (unsigned long)cmdline_ptr,
>                           (unsigned long)efi_system_table);
> --
> 2.27.0
>

