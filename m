Return-Path: <linux-efi+bounces-2513-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 125D6A0308B
	for <lists+linux-efi@lfdr.de>; Mon,  6 Jan 2025 20:26:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F03DD7A25CD
	for <lists+linux-efi@lfdr.de>; Mon,  6 Jan 2025 19:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 446391DFDA1;
	Mon,  6 Jan 2025 19:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VztqKG55"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9521DE3BF;
	Mon,  6 Jan 2025 19:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736191567; cv=none; b=Ibzp84+BEHNDHLZemryWd1+3FM7OA9VwaKKeiwJEeD2XvHzG3OJ5/JWgmDAbt2qfC1pQpDIaVjiL6Uy0zc/QeakNiaYNYZBP9sKYY+LE+JKJEq+ES0gGsMdxHcoDT1s8xEVZcvfhRTIbK0hWgdBIIkNlqVW34KDgsXxn/+eqFfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736191567; c=relaxed/simple;
	bh=Foq+XzwysIEZj68WE6QVggJw0ktMECaV7JADVt4sYco=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MqCuhIUhoS55tiq+g0B/9hkK70uIPcwKcynTTA3dmhZJvBsnH07E1mId00Cl0Tn6i+w/poDzCRheheJ9QY2XtWBQ7v6Ii3LADKjfED4pWIx/+ZVJ2f2MDau9AbugH6PNpInOgjn5MA+tVbM4sIueAkdKRBqjmtAC93ykEk8MBhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VztqKG55; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 791B6C4AF09;
	Mon,  6 Jan 2025 19:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736191566;
	bh=Foq+XzwysIEZj68WE6QVggJw0ktMECaV7JADVt4sYco=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=VztqKG55HSbmvfhV3BzR2ZXHohaXxFzJObemAHg0XSgp0KcOmc47GIyplmZoCITH8
	 Cb6O7ZapfoQoXtCOiRGr0NVrOPupFjk9GUVufidc36WLTeo60Rw8qP5sZQL/qoMJn1
	 uSSTXC4RMuaM9gf2EL8Etjlq2IACleo8qoc2eMYbaGMAJkI0b3tcK0fbECJ86t3wZF
	 3LsadxsuRlQi8En1rKh0wha4DsZ4oFuuwUz+hJ+feBax4qRrVGnzCaxKDuAu6rieYN
	 sEuOKr1vTfKrgd2IegnHr7d1o0bGHZyVH9lMBwu6giNrUYNzicv0LNcodWx+RXaqRW
	 wbFFnh1ryhTeQ==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-54025432becso15491744e87.1;
        Mon, 06 Jan 2025 11:26:06 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWi4nZDbB8giLcJBr6i+2vKHZz170qva6t5StUJY1YSM5wAnCSjkCQ2ZODiENHwO1LCVuOH50/Ex81uyrlM@vger.kernel.org, AJvYcCXa4k+hk45XgkGxQSaKHUx14us7pXzXhcQ+BmTmG+hpvHiXaX049Cyk2/kH3zZHLwjpLPiHkz//EhI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxw3svVq4UvDvwzZrF5NuFmQ0EzfZI6kKi5PNeVbDCJfBgTrNg3
	gwp1TvCNIw30xlU1Yga1slxAGSRdpGGiIIVIL47V6WdTl/wETZivXJeG+hqRymFnltKAWABO9+K
	dkRRDmn2qT7kmHYAt6KrC52P+1FA=
X-Google-Smtp-Source: AGHT+IFdbhDs6FQ2fYa9/nk1FxsNYXAezG7vSrCduGAiFUbZQfx6lcEwD4Olw1BTMbsf/54thfM5HEwCuawZZ15mu8U=
X-Received: by 2002:a05:6512:3b1e:b0:542:2a20:e695 with SMTP id
 2adb3069b0e04-5422a20e76emr13595235e87.9.1736191564745; Mon, 06 Jan 2025
 11:26:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250106-efi_fw_bug-v1-0-01a8eb40bfeb@debian.org> <20250106-efi_fw_bug-v1-2-01a8eb40bfeb@debian.org>
In-Reply-To: <20250106-efi_fw_bug-v1-2-01a8eb40bfeb@debian.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 6 Jan 2025 20:25:53 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEvUimztetYmuieRynUL+dE1aB2gU1w4gf76HeKUAmDeQ@mail.gmail.com>
X-Gm-Features: AbW1kvYxlRtbepTcElYjfntcx0_fETiku4471kVJP1NbzJeH1RZfGwGX4yci-2k
Message-ID: <CAMj1kXEvUimztetYmuieRynUL+dE1aB2gU1w4gf76HeKUAmDeQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] efi/memattr: Add FW_BUG prefix to firmware error messages
To: Breno Leitao <leitao@debian.org>
Cc: Gregory Price <gourry@gourry.net>, Usama Arif <usamaarif642@gmail.com>, linux-efi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 6 Jan 2025 at 20:03, Breno Leitao <leitao@debian.org> wrote:
>
> Tag firmware-related error messages with FW_BUG in efi_memattr_init() to
> make EFI firmware issues more discoverable and consistent with kernel
> error reporting conventions.
>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  drivers/firmware/efi/memattr.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/firmware/efi/memattr.c b/drivers/firmware/efi/memattr.c
> index e727cc5909cb676c47d787ab0d7754b6fdcb493d..5f83cdea88b05cb325e9f90c14a0048131e53cfa 100644
> --- a/drivers/firmware/efi/memattr.c
> +++ b/drivers/firmware/efi/memattr.c
> @@ -29,13 +29,13 @@ void __init efi_memattr_init(void)
>
>         tbl = early_memremap(efi_mem_attr_table, sizeof(*tbl));
>         if (!tbl) {
> -               pr_err("Failed to map EFI Memory Attributes table @ 0x%lx\n",
> +               pr_err(FW_BUG "Failed to map EFI Memory Attributes table @ 0x%lx\n",
>                        efi_mem_attr_table);
>                 return;
>         }
>
>         if (tbl->version > 2) {
> -               pr_warn("Unexpected EFI Memory Attributes table version %d\n",
> +               pr_warn(FW_BUG "Unexpected EFI Memory Attributes table version %d\n",
>                         tbl->version);
>                 goto unmap;
>         }
>

Neither of these are firmware bugs, so we shouldn't report them as such.

(A future version of the table could be > 2, and we wouldn't know how
to deal with that. That doesn't mean there is anything wrong with the
firmware, it only means the kernel is too old)

