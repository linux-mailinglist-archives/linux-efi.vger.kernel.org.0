Return-Path: <linux-efi+bounces-80-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 102C77F48CD
	for <lists+linux-efi@lfdr.de>; Wed, 22 Nov 2023 15:22:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 409171C209AC
	for <lists+linux-efi@lfdr.de>; Wed, 22 Nov 2023 14:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F1A94E1AA;
	Wed, 22 Nov 2023 14:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GUMwU/gX"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F93D4E1A5
	for <linux-efi@vger.kernel.org>; Wed, 22 Nov 2023 14:22:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C789C433C8
	for <linux-efi@vger.kernel.org>; Wed, 22 Nov 2023 14:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700662952;
	bh=5MazeRHrmLUYXVf39lQU4apYB2KWbmVY8ffCHlqBXAI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=GUMwU/gXdeuY9tqie6kQyDaiqpt99T76LGkKpZPIWl56C/PfgRxI6lpx+ZI3h1acD
	 w6cBBwvUNL83mp6hRkS4GOr/TmNhNIDsXidkpIwsr++Qy4fCkAta6lmfgPUgPrbnNH
	 2ch9tpLdh4f2QCcT04kJo7CJFPZrOE0GFbPIbbAGsWA1qCTLjkfp+65KrE+TVH/+q0
	 lkzwFJqAiP7a0PFQKknlATwaZiY2h0zzXZWr+uTYWD+/gfHlpm7GcOLA1ft0upbYtN
	 kasjkYhkO76AiavGuGZ0c5pItDPwbkJIWcmieA4hazAWznBOdu+NxDNiG6shsGo30G
	 1yxMriaV9Povg==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5098e423ba2so9594941e87.2
        for <linux-efi@vger.kernel.org>; Wed, 22 Nov 2023 06:22:31 -0800 (PST)
X-Gm-Message-State: AOJu0YwRn9aOyMOgUn4kkz2dAv4u4T9RtpNuYHbNQzS7HqpOd/n6uJd/
	o0eAM2z55wHufYY0GRksx5N+NJTmA+HN0pVddpk=
X-Google-Smtp-Source: AGHT+IGcGTSWUWbkB6vxEj4vAnj7h17DJCUprZuGWq3WYEuVB8VascJtYxHSsNvv9+Df5qZwMbrC8zpj67w419jaA9c=
X-Received: by 2002:a05:6512:2384:b0:507:a04e:3207 with SMTP id
 c4-20020a056512238400b00507a04e3207mr2047228lfv.6.1700662950268; Wed, 22 Nov
 2023 06:22:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231122084906.12476-1-wangyao@lemote.com>
In-Reply-To: <20231122084906.12476-1-wangyao@lemote.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Wed, 22 Nov 2023 22:22:19 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5WZD5fWJ-3e1HMJ-bugy5BA-9zfaG+wmzJt9DoQu0pog@mail.gmail.com>
Message-ID: <CAAhV-H5WZD5fWJ-3e1HMJ-bugy5BA-9zfaG+wmzJt9DoQu0pog@mail.gmail.com>
Subject: Re: [PATCH] efi/loongarch: Change MMU translation mode
To: wangyao@lemote.com
Cc: ardb@kernel.org, wangrui@loongson.cn, linux-efi@vger.kernel.org, 
	ainux.wang@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Yao,

On Wed, Nov 22, 2023 at 4:50=E2=80=AFPM <wangyao@lemote.com> wrote:
>
> From: Wang Yao <wangyao@lemote.com>
>
> Refer ot UEFI spec v2.10 section 2.3.8 LoongArch Platforms:
>
> The processor is in the following execution mode during boot service:
>     ...
>     The memory is in physical addressing mode. LoongArch architecture
>     defines two memory access mode, namely direct address translation
>     mode and mapped address translation mode.
>
> So need to change MMU translation mode before config direct mapping.
From UEFI spec v2.10 section 2.3.8, you can also see "MMU enabled", so
PG is already enabled in UEFI.

Huacai

>
> Signed-off-by: Wang Yao <wangyao@lemote.com>
> ---
>  drivers/firmware/efi/libstub/loongarch.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/firmware/efi/libstub/loongarch.c b/drivers/firmware/=
efi/libstub/loongarch.c
> index 807cba2693fc..4c0a84c58f5b 100644
> --- a/drivers/firmware/efi/libstub/loongarch.c
> +++ b/drivers/firmware/efi/libstub/loongarch.c
> @@ -49,7 +49,7 @@ efi_status_t efi_boot_kernel(void *handle, efi_loaded_i=
mage_t *image,
>         struct exit_boot_struct priv;
>         unsigned long desc_size;
>         efi_status_t status;
> -       u32 desc_ver;
> +       u32 desc_ver, val;
>
>         status =3D efi_alloc_virtmap(&priv.runtime_map, &desc_size, &desc=
_ver);
>         if (status !=3D EFI_SUCCESS) {
> @@ -69,6 +69,12 @@ efi_status_t efi_boot_kernel(void *handle, efi_loaded_=
image_t *image,
>                     priv.runtime_entry_count * desc_size, desc_size,
>                     desc_ver, priv.runtime_map);
>
> +       /* Change address translation mode */
> +       val =3D csr_read32(LOONGARCH_CSR_CRMD);
> +       val &=3D ~CSR_CRMD_DA;
> +       val |=3D CSR_CRMD_PG;
> +       csr_write32(val, LOONGARCH_CSR_CRMD);
> +
>         /* Config Direct Mapping */
>         csr_write64(CSR_DMW0_INIT, LOONGARCH_CSR_DMWIN0);
>         csr_write64(CSR_DMW1_INIT, LOONGARCH_CSR_DMWIN1);
> --
> 2.27.0
>

