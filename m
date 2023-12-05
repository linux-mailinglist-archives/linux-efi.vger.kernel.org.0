Return-Path: <linux-efi+bounces-117-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FDC88049BD
	for <lists+linux-efi@lfdr.de>; Tue,  5 Dec 2023 07:09:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43FAF2815E6
	for <lists+linux-efi@lfdr.de>; Tue,  5 Dec 2023 06:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67713D52C;
	Tue,  5 Dec 2023 06:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tAAGssjq"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B667D52B
	for <linux-efi@vger.kernel.org>; Tue,  5 Dec 2023 06:09:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 971F0C433C7
	for <linux-efi@vger.kernel.org>; Tue,  5 Dec 2023 06:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701756570;
	bh=0iMKXqQ6pk1X9a6gcZp641mZUoqHJEUJzFM03IDwE/c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=tAAGssjqA2VM+JaTiVcbjxG9Pj1GeWFJ/Qlb8Jg7FisElpPH5WPyOzMbwOAi3S+sK
	 ZKUmBgECkFuzQB0FHzCGIUoMcm1p62gXmjhPE01Y20dX567haJ2f0n5fulxXw0mEXI
	 9V1ISGo97kFbVa+PGTeVgVYtOnF0bzwCRFdWsmzkMOwwYpkwklD4wm46pyE89Ow6os
	 1DzUGwJ0xfUeJxBmv70DS+D9o4XGlyKl7npD2zPyPjlOqGwgRYEcwrnEnq2R7claOV
	 y/tUGzPXDuzrObrtieVrf9wJbZu96sA3RvaawKfBXTNkjsbucvxSImeMB2b6C6NeM0
	 opgS3ZiDiQ0Eg==
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-54917ef6c05so6527274a12.1
        for <linux-efi@vger.kernel.org>; Mon, 04 Dec 2023 22:09:30 -0800 (PST)
X-Gm-Message-State: AOJu0Yx46zpg/BSC9tLU/pQqnOrWyZuoiOQCFIn7E9Y5/CHcW5fl2Cq8
	fYJzKhSt7bcxgS7p5CjscXXfaM8D7hXc4q+6kJU=
X-Google-Smtp-Source: AGHT+IEcaKLtjq9fWBdDTcgs/1z5gA8KRlw7Ik6NKDFxZIIx0Uln4oLt/ctuXVlY4EfWE0ibAP/89bG2MV/+7RZFr/w=
X-Received: by 2002:a17:906:191:b0:a19:a19b:425f with SMTP id
 17-20020a170906019100b00a19a19b425fmr98079ejb.202.1701756569044; Mon, 04 Dec
 2023 22:09:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231205060345.7742-1-wangyao@lemote.com> <20231205060345.7742-3-wangyao@lemote.com>
In-Reply-To: <20231205060345.7742-3-wangyao@lemote.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Tue, 5 Dec 2023 14:09:17 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4ou+rMOKT=GvWD2f9j4CiQ5VC13hYMeaU5ecOaDjLTwQ@mail.gmail.com>
Message-ID: <CAAhV-H4ou+rMOKT=GvWD2f9j4CiQ5VC13hYMeaU5ecOaDjLTwQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] efi/loongarch: load address is not equal to link address
To: wangyao@lemote.com
Cc: ardb@kernel.org, wangrui@loongson.cn, linux-efi@vger.kernel.org, 
	ainux.wang@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Why send a test patch?

On Tue, Dec 5, 2023 at 2:04=E2=80=AFPM <wangyao@lemote.com> wrote:
>
> From: Wang Yao <wangyao@lemote.com>
>
> This is a test patch for PIE kernel that load address is not equal to
> link address.
>
> Signed-off-by: Wang Yao <wangyao@lemote.com>
> ---
>  drivers/firmware/efi/libstub/loongarch-stub.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/firmware/efi/libstub/loongarch-stub.c b/drivers/firm=
ware/efi/libstub/loongarch-stub.c
> index d6ec5d4b8dbe..c13c022d18cf 100644
> --- a/drivers/firmware/efi/libstub/loongarch-stub.c
> +++ b/drivers/firmware/efi/libstub/loongarch-stub.c
> @@ -22,12 +22,22 @@ efi_status_t handle_kernel_image(unsigned long *image=
_addr,
>                                  efi_handle_t image_handle)
>  {
>         efi_status_t status;
> -       unsigned long kernel_addr =3D 0;
> +       unsigned long kernel_addr =3D 0, tmp_addr =3D 0;
>
>         kernel_addr =3D (unsigned long)&kernel_offset - kernel_offset;
>
> +       /*
> +        * Allocate 2M space at 0x200000(EFI_KIMG_PREFERRED_ADDRESS) for
> +        * test, this will lead to the kernel be loaded at 0x4000000.
> +        */
> +       status =3D efi_relocate_kernel(&tmp_addr, 0x100000, 0x200000,
> +                    EFI_KIMG_PREFERRED_ADDRESS, efi_get_kimg_min_align()=
, 0x0);
> +       efi_info("@@@[%s] tmp_addr: 0x%lx\n", __func__, tmp_addr);
> +
> +       /* kernel_addr =3D=3D 0x400000 */
>         status =3D efi_relocate_kernel(&kernel_addr, kernel_fsize, kernel=
_asize,
>                      EFI_KIMG_PREFERRED_ADDRESS, efi_get_kimg_min_align()=
, 0x0);
> +       efi_info("@@@[%s] kernel_addr: 0x%lx\n", __func__, kernel_addr);
>
>         *image_addr =3D kernel_addr;
>         *image_size =3D kernel_asize;
> --
> 2.27.0
>

