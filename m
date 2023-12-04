Return-Path: <linux-efi+bounces-109-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF568033BF
	for <lists+linux-efi@lfdr.de>; Mon,  4 Dec 2023 14:02:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28708280E99
	for <lists+linux-efi@lfdr.de>; Mon,  4 Dec 2023 13:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9603249F0;
	Mon,  4 Dec 2023 13:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ibgK0akm"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6B7A20
	for <linux-efi@vger.kernel.org>; Mon,  4 Dec 2023 13:02:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A30AC433C7
	for <linux-efi@vger.kernel.org>; Mon,  4 Dec 2023 13:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701694952;
	bh=gTq4hFcq25zsoqrcN/aT3NIB0DYj5Wol6Eqm8tbCuz0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ibgK0akm1LhEdDxg13pFN59IcmYK+JPPqymf4BKTjL71KyTG2CLvYpQ1rSZyEwnzz
	 umBRtE5KINv0Fni36yreF7/LUP0LjY9KND6wsDjSwDleeIIb0lFZyz7UaK6VwqZfRR
	 GhJpErBEDqXQQktoN2S/DPNAj7ufcVM42axhuBEGxOBgb6eDtNyieDwCfd/E/0AUQa
	 EOSI4iF34WJfsuU1ima7co0NeLCyy4hxX4IUv7RBk0rusfnWRsZg1+ha41y2n4R7z9
	 fLZfQtd3Ua0A6BcM4sySWLYSEXQeAHLHQTEKOcV8kiQkeTuBu+3fF7jjjZD9NAqwab
	 gLPgdcKw234sw==
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-54ba86ae133so4751149a12.2
        for <linux-efi@vger.kernel.org>; Mon, 04 Dec 2023 05:02:32 -0800 (PST)
X-Gm-Message-State: AOJu0Yy3dv2AA8TIrWjBadm4Ek7Rjhg0qjQ3pjY9xOt1flKRfWNrRHmC
	yaAnn/2JS63qSioTG/tNR9SJPds1eQhVPkUi+dA=
X-Google-Smtp-Source: AGHT+IFtobe5T1jnVMWOnctnMjfSwCEYSxcvC4Kvf0Z6ECYQ/hDsY32KDaakhQrOFgv1tHfiJ5kWkO1tw7TVznP4gso=
X-Received: by 2002:a50:ccc6:0:b0:54c:4837:905d with SMTP id
 b6-20020a50ccc6000000b0054c4837905dmr3185750edj.85.1701694950816; Mon, 04 Dec
 2023 05:02:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231204031853.6379-1-wangyao@lemote.com>
In-Reply-To: <20231204031853.6379-1-wangyao@lemote.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Mon, 4 Dec 2023 21:02:20 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4ZNsD8E=uEmtr3bgn4vfXXW0ugNHhwQHeKDKvyVAA=gA@mail.gmail.com>
Message-ID: <CAAhV-H4ZNsD8E=uEmtr3bgn4vfXXW0ugNHhwQHeKDKvyVAA=gA@mail.gmail.com>
Subject: Re: [PATCH] efi/loongarch: Use relocate address to calculate kernel
 entry address
To: wangyao@lemote.com
Cc: ardb@kernel.org, wangrui@loongson.cn, linux-efi@vger.kernel.org, 
	ainux.wang@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Yao,

The title can be "Use load address ....".


On Mon, Dec 4, 2023 at 11:19=E2=80=AFAM <wangyao@lemote.com> wrote:
>
> From: Wang Yao <wangyao@lemote.com>
>
> The efi_relocate_kernel() may relocate the PIE kernel to anywhere, the re=
located
> address may not be equal to link address or EFI_KIMG_PREFERRED_ADDRESS.
>
> Signed-off-by: Wang Yao <wangyao@lemote.com>
> ---
>  arch/loongarch/include/asm/efi.h              | 2 +-
>  drivers/firmware/efi/libstub/loongarch-stub.c | 4 ++--
>  drivers/firmware/efi/libstub/loongarch.c      | 6 +++---
>  3 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/arch/loongarch/include/asm/efi.h b/arch/loongarch/include/as=
m/efi.h
> index 091897d40b03..91d81f9730ab 100644
> --- a/arch/loongarch/include/asm/efi.h
> +++ b/arch/loongarch/include/asm/efi.h
> @@ -32,6 +32,6 @@ static inline unsigned long efi_get_kimg_min_align(void=
)
>
>  #define EFI_KIMG_PREFERRED_ADDRESS     PHYSADDR(VMLINUX_LOAD_ADDRESS)
>
> -unsigned long kernel_entry_address(void);
> +unsigned long kernel_entry_address(unsigned long kernel_addr);
>
>  #endif /* _ASM_LOONGARCH_EFI_H */
> diff --git a/drivers/firmware/efi/libstub/loongarch-stub.c b/drivers/firm=
ware/efi/libstub/loongarch-stub.c
> index 72c71ae201f0..4d52f1dc5258 100644
> --- a/drivers/firmware/efi/libstub/loongarch-stub.c
> +++ b/drivers/firmware/efi/libstub/loongarch-stub.c
> @@ -35,9 +35,9 @@ efi_status_t handle_kernel_image(unsigned long *image_a=
ddr,
>         return status;
>  }
>
> -unsigned long kernel_entry_address(void)
> +unsigned long kernel_entry_address(unsigned long kernel_addr)
>  {
>         unsigned long base =3D (unsigned long)&kernel_offset - kernel_off=
set;
>
> -       return (unsigned long)&kernel_entry - base + VMLINUX_LOAD_ADDRESS=
;
> +       return (unsigned long)&kernel_entry - base + TO_CACHE(kernel_addr=
);
>  }
> diff --git a/drivers/firmware/efi/libstub/loongarch.c b/drivers/firmware/=
efi/libstub/loongarch.c
> index 807cba2693fc..d7ec9381f8ea 100644
> --- a/drivers/firmware/efi/libstub/loongarch.c
> +++ b/drivers/firmware/efi/libstub/loongarch.c
> @@ -37,9 +37,9 @@ static efi_status_t exit_boot_func(struct efi_boot_memm=
ap *map, void *priv)
>         return EFI_SUCCESS;
>  }
>
> -unsigned long __weak kernel_entry_address(void)
> +unsigned long __weak kernel_entry_address(unsigned long kernel_addr)
>  {
> -       return *(unsigned long *)(PHYSADDR(VMLINUX_LOAD_ADDRESS) + 8);
> +       return *(unsigned long *)(PHYSADDR(kernel_addr) + 8);
The address read from DOS header is link address, so you should return
*(unsigned long *)(kernel_addr + 8) -  VMLINUX_LOAD_ADDRESS +
TO_CACHE(kernel_addr);

Huacai

>  }
>
>  efi_status_t efi_boot_kernel(void *handle, efi_loaded_image_t *image,
> @@ -73,7 +73,7 @@ efi_status_t efi_boot_kernel(void *handle, efi_loaded_i=
mage_t *image,
>         csr_write64(CSR_DMW0_INIT, LOONGARCH_CSR_DMWIN0);
>         csr_write64(CSR_DMW1_INIT, LOONGARCH_CSR_DMWIN1);
>
> -       real_kernel_entry =3D (void *)kernel_entry_address();
> +       real_kernel_entry =3D (void *)kernel_entry_address(kernel_addr);
>
>         real_kernel_entry(true, (unsigned long)cmdline_ptr,
>                           (unsigned long)efi_system_table);
> --
> 2.27.0
>

