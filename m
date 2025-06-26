Return-Path: <linux-efi+bounces-4010-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E1F9AE9D94
	for <lists+linux-efi@lfdr.de>; Thu, 26 Jun 2025 14:34:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EED3B17B183
	for <lists+linux-efi@lfdr.de>; Thu, 26 Jun 2025 12:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 469C32E11BF;
	Thu, 26 Jun 2025 12:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P3qKMOTo"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC672E11B3;
	Thu, 26 Jun 2025 12:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750941275; cv=none; b=WhJS0Yks4ea6T241Mm3IDPHLY3MGM0NvLFaJWsxMrR2qvGUC4R2HHDl18PbjS6BBSuMHemQKkWuw5IMqjhU8vBvB5UOFO2/svffdID5oucxLF/gkthz4NBuCRrHblY6gsDMYbTJLG9/+MsOA6w9vYXQslMT/hpm3hh3jNhZwiKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750941275; c=relaxed/simple;
	bh=hcQ6uyRoZdEeGK6Ue+aMRUyXS514RKes3MWuq/gg04A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dV9pSHZ0Hq0F6AF6MsrfpIOCKbPU+rab5wGT6Vu3XWkRBQjcjyrkKjRqglaAfG9pvoImgnQZr+pavHWDcqNETxs8+aROooxyexY0BeDRyDZE2VcCRZ5hQinjrJev0prtJxElhckXCPFSbPdUE/ct/6XOVAsYtVMIHK/Lajb/KyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P3qKMOTo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD90DC4CEEB;
	Thu, 26 Jun 2025 12:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750941274;
	bh=hcQ6uyRoZdEeGK6Ue+aMRUyXS514RKes3MWuq/gg04A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=P3qKMOToBvXmZ18EDXVLHHbD8r9WYfa9DQyIULHWBxyCGqq+gp6LmU3bJVgbPVHYy
	 ACyskFizMsRsnOeAEq8Lq6avpvQ7GptTWTYwlZun1KTg0kzLjueVIePmLuGx6AzoIW
	 0J+vq1kRjkh7ShIBmTcOjS7/jeymDKE48rZrNJFtBAJsIm0+wiSMRjeUnDzpdGAUMA
	 EgSaycyxf0PJ6us6EoylKTGidAGvQPKYvYOiIyAt2cCT+y02qZUyNZxu/bQ5q8Tsw+
	 LypZ/mZIDNfd2VpxsBZbDCThvWPoLGji6TKbnF9ZoPIjzSp8fIyluGRBhPdz+PHK05
	 TBzFjvsvItlKg==
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-60bf5a08729so1808236a12.0;
        Thu, 26 Jun 2025 05:34:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUs/e7kziYCIEEY03kVYuUqhmA8ygWV17JximH575wk0OIsCUFWlnTSyTDEJDFwdjdOuofJYa0qMvX7gd4D@vger.kernel.org, AJvYcCV0MAE/eWMbkxQIp6l7LBZNduRWOUlo+VoxHbjdldyL3tDfhtBo7266C02nAZ1JZ65iLZz+kTtz+n8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTMAdbFAMexEnNKRcaMKoaE5JagexqZz0Q4h1pGlnuiqggTLRf
	a6MGOcqzbLhgjDwgITLH4XkIn3Up4d28+dZskPI/M2TxspeixKfTC89qrrx7U0c088Tr7vXGTX1
	H3mXreA4OODuLJltISRWA3K8XK0v3WR8=
X-Google-Smtp-Source: AGHT+IHWYEFD7FhNFKe3vMe2MLiQzW6HtnNAGBb2VkYvPZzV8A//gU2qepXD36L8XdzwuDTZK3mZkCULBCl9iXk/ViI=
X-Received: by 2002:a05:6402:26c3:b0:606:eb8e:d975 with SMTP id
 4fb4d7f45d1cf-60c4d10f679mr6018333a12.0.1750941273373; Thu, 26 Jun 2025
 05:34:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250624081852.1563985-1-wangming01@loongson.cn>
In-Reply-To: <20250624081852.1563985-1-wangming01@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Thu, 26 Jun 2025 20:34:21 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5xc_Lp2=71goHF1nT4gHoavVKHPLuXRykU=7EMPS_QfQ@mail.gmail.com>
X-Gm-Features: Ac12FXwYs6C6bmyJVDxgUYr-kMO9to9KHAfTEDDKscaPoHTt09w5r3dn5a7lmCg
Message-ID: <CAAhV-H5xc_Lp2=71goHF1nT4gHoavVKHPLuXRykU=7EMPS_QfQ@mail.gmail.com>
Subject: Re: [PATCH] efi/loongarch: Reserve EFI memory map region
To: Ming Wang <wangming01@loongson.cn>
Cc: Ard Biesheuvel <ardb@kernel.org>, WANG Xuerui <kernel@xen0n.name>, linux-efi@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-kernel@vger.kernel.org, 
	lixuefeng@loongson.cn, chenhuacai@loongson.cn, gaojuxin@loongson.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied with some modifications, thanks.

https://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.g=
it/commit/?h=3Dloongarch-next&id=3D39503fc84b4ea94f2bedca481de5e225e0df729d

Huacai

On Tue, Jun 24, 2025 at 4:19=E2=80=AFPM Ming Wang <wangming01@loongson.cn> =
wrote:
>
> The EFI memory map at 'boot_memmap' is crucial for kdump to understand
> the primary kernel's memory layout. This memory region, typically part
> of EFI Boot Services (BS) data, can be overwritten after ExitBootServices
> if not explicitly preserved by the kernel.
>
> This commit addresses this by:
> 1. Calling memblock_reserve() to reserve the entire physical region
>    occupied by the EFI memory map (header + descriptors). This prevents
>    the primary kernel from reallocating and corrupting this area.
> 2. Setting the EFI_PRESERVE_BS_REGIONS flag in efi.flags. This indicates
>    that efforts have been made to preserve critical BS data regions,
>    which can be useful for other kernel subsystems or debugging.
>
> These changes ensure the original EFI memory map data remains intact,
> improving kdump reliability and potentially aiding other EFI-related
> functionalities that might rely on preserved BS data.
>
> Signed-off-by: Ming Wang <wangming01@loongson.cn>
> ---
>  arch/loongarch/kernel/efi.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/arch/loongarch/kernel/efi.c b/arch/loongarch/kernel/efi.c
> index de21e72759ee..98b1f0c030fc 100644
> --- a/arch/loongarch/kernel/efi.c
> +++ b/arch/loongarch/kernel/efi.c
> @@ -135,6 +135,7 @@ void __init efi_init(void)
>         tbl =3D early_memremap_ro(boot_memmap, sizeof(*tbl));
>         if (tbl) {
>                 struct efi_memory_map_data data;
> +               phys_addr_t reserve_size =3D sizeof(*tbl) + tbl->map_size=
;
>
>                 data.phys_map           =3D boot_memmap + sizeof(*tbl);
>                 data.size               =3D tbl->map_size;
> @@ -144,6 +145,18 @@ void __init efi_init(void)
>                 if (efi_memmap_init_early(&data) < 0)
>                         panic("Unable to map EFI memory map.\n");
>
> +               /*
> +                * Reserve the physical memory region occupied by the EFI
> +                * memory map table (header + descriptors). This is cruci=
al
> +                * for kdump, as the kdump kernel relies on this original
> +                * memmap passed by the bootloader. Without reservation,
> +                * this region could be overwritten by the primary kernel=
.
> +                * Also, set the EFI_PRESERVE_BS_REGIONS flag to indicate=
 that
> +                * critical boot services data regions like this are pres=
erved.
> +                */
> +               memblock_reserve((phys_addr_t)boot_memmap, reserve_size);
> +               set_bit(EFI_PRESERVE_BS_REGIONS, &efi.flags);
> +
>                 early_memunmap(tbl, sizeof(*tbl));
>         }
>
> --
> 2.43.0
>

