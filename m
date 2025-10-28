Return-Path: <linux-efi+bounces-5196-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9E18C14F0C
	for <lists+linux-efi@lfdr.de>; Tue, 28 Oct 2025 14:44:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1601188B780
	for <lists+linux-efi@lfdr.de>; Tue, 28 Oct 2025 13:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A83932E130;
	Tue, 28 Oct 2025 13:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XW1JDYO5"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80CE334694
	for <linux-efi@vger.kernel.org>; Tue, 28 Oct 2025 13:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761658991; cv=none; b=MZUQf++y0jo+Hh63saY32O+KxGjc6sAmF+bIl8/Ct0fTyb9jEJn01qRz91jON7AoG81UwF/DU+UzS4A/mRbeeO4EAI4ZkZKDrLhJta88m1UNx7kGUGQyrQ7oabA8leYZl9wFa7w91W106X41vxZg1iUbNm/gCcj4gbqRA7BPXmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761658991; c=relaxed/simple;
	bh=RqU8ooxGP3d5BGDqht1wRrVV5zKW2fpWna7YCD6BgNw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uAOHVEGg/TLP5ZS1rbNGnHkcwesGA45an/ncxH5F9R9NiHPHYKmW0Nj5io863RjGegvm33622GaKXmUj7S1S7uwa6CBOEgqdxQlMP5xlANLz8KswNG6ST25zAwqzeku8T/YF0Hazvqi2Rg87FHM3FqDjEeUgPi1RQfb1lkfBu0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XW1JDYO5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D355EC116B1
	for <linux-efi@vger.kernel.org>; Tue, 28 Oct 2025 13:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761658990;
	bh=RqU8ooxGP3d5BGDqht1wRrVV5zKW2fpWna7YCD6BgNw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=XW1JDYO5bhGuvRO+8LaNPWDiMiEqn46XlG5pAHuTYPkkUwBfTHWIAo+yXKtoSVHIS
	 QwxYFYx5WIJJEeB4g3QNRzjXzTfPYrjPG+ZwdI3xBC0Daac07Z4zohSUGonNyodnii
	 /AyQ1SnXero0WO6CulXzUwyYA6ovHLfupI2mwbWbcFKefRYy0zFCHA4sRvLQPw7W6q
	 WovyFEWAD0BLQZ02LNlTlNLYo5R2bsLc+sM8KPQ820jhB/fbIyk8YKnqZ8TMcjebhG
	 sYIERJasZzoYs1nUXRkmota1/ZmbGbMYSx9f4n/KW8tTjClw7rDR5fKA7XKgJd/aC1
	 vfHC9vKfIAtaA==
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-378de7d3057so53810761fa.1
        for <linux-efi@vger.kernel.org>; Tue, 28 Oct 2025 06:43:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVof1HbbwhS3Lr0lDL266FhbVntTeGleGi+DyQ+PhpfTkd82rp5d52my/Oz/lJIFmd/o+6Bx5OLPcc=@vger.kernel.org
X-Gm-Message-State: AOJu0YysOwSeSCJsFoiI3ywb6JFkLRia+If8j89S/ZnPfRqOu8Wzwp+K
	q3S1dNS2rvlZ0lIrs2VnzMmzBgW7zx7j0Y0+eNOPaZwMFjCDYMrqJQCic+QfzzjJZ/UdYNFjY8P
	1RD4YzFQiVVBtxKqYoas6LAIrWQc2xsA=
X-Google-Smtp-Source: AGHT+IHkIw26u7F419Pj1lh4qhYibZamlABQDX5PY5n3HBNOILBNvfOulAOIRz2raMKa11mn/73gf+9CSS24BrZo03Y=
X-Received: by 2002:a05:651c:2352:20b0:36e:ca93:62df with SMTP id
 38308e7fff4ca-3790768fa7fmr9485091fa.3.1761658989237; Tue, 28 Oct 2025
 06:43:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251023082129.75612-1-maqianga@uniontech.com>
 <CAMj1kXHs3vC4TEWg1ogG=N8Dd5L0rkQ=qAFLWKiAA5yi_He3GA@mail.gmail.com> <10D9A93B0633E6BE+75720e07-b39d-452c-952e-41f8ab6aad94@uniontech.com>
In-Reply-To: <10D9A93B0633E6BE+75720e07-b39d-452c-952e-41f8ab6aad94@uniontech.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 28 Oct 2025 14:42:57 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHQ6WQWfbkMP4JUk=nKwSt7CovY25RC4JA0ZM7vRWu6dA@mail.gmail.com>
X-Gm-Features: AWmQ_bkQl15BrZRzZGKbVV0HuIh0-gITf1_INVKqu5_rHF8PwaNBiut4Akzbt3c
Message-ID: <CAMj1kXHQ6WQWfbkMP4JUk=nKwSt7CovY25RC4JA0ZM7vRWu6dA@mail.gmail.com>
Subject: Re: [PATCH 1/2] ARM/efi: Remove duplicate permission settings
To: Qiang Ma <maqianga@uniontech.com>
Cc: linux@armlinux.org.uk, linux-efi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 27 Oct 2025 at 04:46, Qiang Ma <maqianga@uniontech.com> wrote:
>
>
> =E5=9C=A8 2025/10/23 16:30, Ard Biesheuvel =E5=86=99=E9=81=93:
> > On Thu, 23 Oct 2025 at 10:22, Qiang Ma <maqianga@uniontech.com> wrote:
> >> In the efi_virtmap_init(), permission settings have been applied:
> >>
> >> static bool __init efi_virtmap_init(void)
> >> {
> >>          ...
> >>          for_each_efi_memory_desc(md)
> >>                  ...
> >>                  efi_create_mapping(&efi_mm, md);
> >>          ...
> >>          efi_memattr_apply_permissions(&efi_mm, efi_set_mapping_permis=
sions);
> >>          ...
> >> }
> >>
> >> Therefore, there is no need to apply it again in the efi_create_mappin=
g().
> >>
> >> Fixes: 9fc68b717c24 ("ARM/efi: Apply strict permissions for UEFI Runti=
me Services regions")
> >>
> >> Signed-off-by: Qiang Ma <maqianga@uniontech.com>
> > No, efi_memattr_apply_permissions() uses the /optional/ memory
> > attributes table, whereas efi_create_mapping() uses the permission
> > attributes in the EFI memory map. The memory attributes table is
> > optional, in which case any RO/XP attributes from the memory map
> > should be used.
> >
> I see.
>
> Then, can it be modified like this?

No

> --- a/arch/arm/kernel/efi.c
> +++ b/arch/arm/kernel/efi.c
> @@ -65,16 +65,13 @@ int __init efi_create_mapping(struct mm_struct *mm,
> efi_memory_desc_t *md)
>                  desc.type =3D MT_MEMORY_RWX_NONCACHED;
>          else if (md->attribute & EFI_MEMORY_WC)
>                  desc.type =3D MT_DEVICE_WC;
> +       else if (md->attribute & (EFI_MEMORY_RO | EFI_MEMORY_XP))

This will be true for RO, XP or RO+XP.

> +               desc.type =3D MT_MEMORY_RO;

This will apply RO permissions even to XP regions, which need to be writabl=
e.

