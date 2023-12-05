Return-Path: <linux-efi+bounces-112-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8575080449F
	for <lists+linux-efi@lfdr.de>; Tue,  5 Dec 2023 03:24:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B28091C20C85
	for <lists+linux-efi@lfdr.de>; Tue,  5 Dec 2023 02:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29FEC610D;
	Tue,  5 Dec 2023 02:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XtP4s+0n"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF35610C
	for <linux-efi@vger.kernel.org>; Tue,  5 Dec 2023 02:24:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D153C433CC
	for <linux-efi@vger.kernel.org>; Tue,  5 Dec 2023 02:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701743059;
	bh=WAue/D+qC5+ebeN/lNRjinRgVBDRlfgszxq0Ug+MW3Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=XtP4s+0nWZKlUvuQu91Ewq4Hc1mUTS0WH/8S/WpG+Jh47jyIsomh+FCNuQzLPA2eX
	 kOgvAd7+fI0M9G9Dxy7kd3eReVOlJslXugL/ZfauI/JVlAkydRNuEhWa0r0wmpY4BS
	 NXTsvNaqh7+1dINoJmB+k6Q0aEymJWyD6e5RQ2llPLRG4Cdlt/Dya3UgvJKBiBabRg
	 +5OzBqaYBxTOxcxxiDmzHJ7wZhLBtj2ZeE09QNMQPLjug4/OjnPHND+UCi2eWuwm7K
	 CbY7ZEp5uHSTA/ZDU5lankftv8grwppyhtoObf7NhNeFadD4lxRlpLQ40vMApbCXlW
	 5a7RqDtQizjFg==
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-54c967010b2so4405627a12.0
        for <linux-efi@vger.kernel.org>; Mon, 04 Dec 2023 18:24:19 -0800 (PST)
X-Gm-Message-State: AOJu0YyQDnD5BgCuJOcAc59/KzF8Rs2lCflbBZhB3dDsQuM1OTMNC8AZ
	D8uMddldAJolLUvOlhglMU479ugn7dm10HhlT5s=
X-Google-Smtp-Source: AGHT+IHz9k0lBv9jtjyH2ZV0+usKDKUzp8Q+F3uIpyyub3SyQaBgvPDF84yeR54KFwvNLpZmsVvabuW/R1LnPmbBqJ8=
X-Received: by 2002:a17:906:c292:b0:a1b:75f6:165c with SMTP id
 r18-20020a170906c29200b00a1b75f6165cmr283853ejz.52.1701743057988; Mon, 04 Dec
 2023 18:24:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231205021635.11663-1-wangyao@lemote.com>
In-Reply-To: <20231205021635.11663-1-wangyao@lemote.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Tue, 5 Dec 2023 10:24:06 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4q+y1X=tytQeyTRYzm8D7ZsEterrdZ=pjGGNaohgUjeQ@mail.gmail.com>
Message-ID: <CAAhV-H4q+y1X=tytQeyTRYzm8D7ZsEterrdZ=pjGGNaohgUjeQ@mail.gmail.com>
Subject: Re: [PATCH v2] efi/loongarch: Use load address to calculate kernel
 entry address
To: wangyao@lemote.com
Cc: ardb@kernel.org, wangrui@loongson.cn, linux-efi@vger.kernel.org, 
	ainux.wang@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 5, 2023 at 10:17=E2=80=AFAM <wangyao@lemote.com> wrote:
>
> From: Wang Yao <wangyao@lemote.com>
>
> The efi_relocate_kernel() may load the PIE kernel to anywhere, the load
> address may not be equal to link address or EFI_KIMG_PREFERRED_ADDRESS.
>
> Signed-off-by: Wang Yao <wangyao@lemote.com>
> ---
>
> v1->v2:
> Use link address that from DOS header to calculate kernel entry,
> corrected by Huacai Chen.
>
>  arch/loongarch/include/asm/efi.h              | 2 +-
>  drivers/firmware/efi/libstub/loongarch-stub.c | 4 ++--
>  drivers/firmware/efi/libstub/loongarch.c      | 7 ++++---
>  3 files changed, 7 insertions(+), 6 deletions(-)
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
> index 807cba2693fc..f17f3db55199 100644
> --- a/drivers/firmware/efi/libstub/loongarch.c
> +++ b/drivers/firmware/efi/libstub/loongarch.c
> @@ -37,9 +37,10 @@ static efi_status_t exit_boot_func(struct efi_boot_mem=
map *map, void *priv)
>         return EFI_SUCCESS;
>  }
>
> -unsigned long __weak kernel_entry_address(void)
> +unsigned long __weak kernel_entry_address(unsigned long kernel_addr)
>  {
> -       return *(unsigned long *)(PHYSADDR(VMLINUX_LOAD_ADDRESS) + 8);
> +       return *(unsigned long *)(TO_CACHE(kernel_addr) + 8) -
> +               VMLINUX_LOAD_ADDRESS + TO_CACHE(kernel_addr);
Now we are in UEFI environment, so the first TO_CACHE can be dropped,
the return value is used for jump to the core kernel, so the second
TO_CACHE should be used.

BTW, do enough tests please. :)

Huacai

>  }
>
>  efi_status_t efi_boot_kernel(void *handle, efi_loaded_image_t *image,
> @@ -73,7 +74,7 @@ efi_status_t efi_boot_kernel(void *handle, efi_loaded_i=
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

