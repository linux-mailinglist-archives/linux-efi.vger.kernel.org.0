Return-Path: <linux-efi+bounces-1228-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56B0990AF8E
	for <lists+linux-efi@lfdr.de>; Mon, 17 Jun 2024 15:37:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7BF72926E9
	for <lists+linux-efi@lfdr.de>; Mon, 17 Jun 2024 13:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA0111B29AF;
	Mon, 17 Jun 2024 13:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZWSkafqW"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD021B29AB;
	Mon, 17 Jun 2024 13:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718630539; cv=none; b=OjF9YEh0DHJLDcbup0bej3ufYm3YdehqI3czCVnjRfGKRXZsxpRE/vxmh9HIiEsh9zQXrw4i/PxAh66xy5JEhuAWE6wUsrFkkijVtkIw8VeW5lTFEmKr+81zm1AXC7Oxjfx4DJGpkZlBu52xVEhSib0hZhuFCsUxCcFknP4zNUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718630539; c=relaxed/simple;
	bh=/CdsLM4OZtV2MzVFE1JTzdMKf9cHeecCDqvGLRrbY3M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UZjjzwJ9LkHxuLanhNT83zVIfWFIho7Ftyys+K8wtp5iECy0oz5JM8hw8fTZCSVay7nKgwxjIOGNL3O1DzTuYR7fyGMjjPP123fWvWLfC5wlDhIWpHj3ocHvY9GhSDS5ny6D4FrSb06z/WTjcUy37zdxNgv2TlgYIf9mT2VC27s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZWSkafqW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71746C2BD10;
	Mon, 17 Jun 2024 13:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718630539;
	bh=/CdsLM4OZtV2MzVFE1JTzdMKf9cHeecCDqvGLRrbY3M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ZWSkafqW/uBJloDfE2iS3jnJTe3NAfbfV/BnxvW1ZExc9IDIJAzQT3cafoR5e1PsH
	 dy4yG6MK2GfnHeZHsfuDdI0YrNgCUIfGNecBu5Z0HnW9CMAilVU3oKaRUVGsy5pYUA
	 OXUhbjyp7OAOnN34SaTcMo2u5Hs1a3LlkS97epTvNIsUOuNMpqAm9IdxzPyUvZy5B4
	 sTNNg0uaf+50rsuDLPu1c66+prlAuiD9egbPBBm4xuKskW2O9rVSx+qax9TbEFKvq2
	 f5RUk/HrmTTSzmale9I+jxoiPJPe1wveN7tdvV6/en2GdkhecSw5FtCLQKOOucXeRa
	 Rh+DpXeFoAsqQ==
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2eaafda3b5cso54519821fa.3;
        Mon, 17 Jun 2024 06:22:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX5aXL1BaVGPnkdtdLCTAS9YUhNUDBCQXmAbYwyBNPrSRyUO7D0R84/Gx6ssCS/PpIYwgr5JTBPWvcV+jZfpfh1bUDQHJ3oOqydMbM9zbqjWRc+O+maYuOXMbEwxpJgaDaOLlOBANm4IGp0xXX8JrY6rswLp3on/owJgnko+bB4gzpo
X-Gm-Message-State: AOJu0Yzlh2C3D6ZhW1AH/08zdCUfHbLqEOZAwtkjCxJt/G0Yhh9ofoIl
	jBx7QljKrzO6ATxGMA7xXEt5MDgD6apeinvA8TEP1hYducWnjSZ6xx05fRUFdf/umXKoKtAccwe
	NKO8WThX4jnwhYs11j1QSmnzjo1c=
X-Google-Smtp-Source: AGHT+IG9NJNmS6gWZLIc3t43DtdKd9O2Vql7o/j15MFKlZz9mwmPaYPtvxG+2OgKUYj4QWowKaOuyAw/OMsvOVStr1o=
X-Received: by 2002:a05:651c:20c:b0:2ec:1708:4db2 with SMTP id
 38308e7fff4ca-2ec170850a0mr48431831fa.47.1718630537833; Mon, 17 Jun 2024
 06:22:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240617132046.2587008-1-sashal@kernel.org> <20240617132046.2587008-7-sashal@kernel.org>
In-Reply-To: <20240617132046.2587008-7-sashal@kernel.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 17 Jun 2024 15:22:06 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGrPY-J=v6b1yXRMEGku7m9LVPE9MUFpg7LYXwtTiu3ZA@mail.gmail.com>
Message-ID: <CAMj1kXGrPY-J=v6b1yXRMEGku7m9LVPE9MUFpg7LYXwtTiu3ZA@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 6.9 07/44] efi: pstore: Return proper errors on
 UEFI failures
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>, Kees Cook <keescook@chromium.org>, 
	linux-hardening@vger.kernel.org, linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

NAK

Please don't backport this.


On Mon, 17 Jun 2024 at 15:21, Sasha Levin <sashal@kernel.org> wrote:
>
> From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
>
> [ Upstream commit 7c23b186ab892088f76a3ad9dbff1685ffe2e832 ]
>
> Right now efi-pstore either returns 0 (success) or -EIO; but we
> do have a function to convert UEFI errors in different standard
> error codes, helping to narrow down potential issues more accurately.
>
> So, let's use this helper here.
>
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  drivers/firmware/efi/efi-pstore.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/firmware/efi/efi-pstore.c b/drivers/firmware/efi/efi-pstore.c
> index 833cbb995dd3f..194fdbd600ad1 100644
> --- a/drivers/firmware/efi/efi-pstore.c
> +++ b/drivers/firmware/efi/efi-pstore.c
> @@ -136,7 +136,7 @@ static int efi_pstore_read_func(struct pstore_record *record,
>                                      &size, record->buf);
>         if (status != EFI_SUCCESS) {
>                 kfree(record->buf);
> -               return -EIO;
> +               return efi_status_to_err(status);
>         }
>
>         /*
> @@ -181,7 +181,7 @@ static ssize_t efi_pstore_read(struct pstore_record *record)
>                         return 0;
>
>                 if (status != EFI_SUCCESS)
> -                       return -EIO;
> +                       return efi_status_to_err(status);
>
>                 /* skip variables that don't concern us */
>                 if (efi_guidcmp(guid, LINUX_EFI_CRASH_GUID))
> @@ -219,7 +219,7 @@ static int efi_pstore_write(struct pstore_record *record)
>                                             record->size, record->psi->buf,
>                                             true);
>         efivar_unlock();
> -       return status == EFI_SUCCESS ? 0 : -EIO;
> +       return efi_status_to_err(status);
>  };
>
>  static int efi_pstore_erase(struct pstore_record *record)
> @@ -230,7 +230,7 @@ static int efi_pstore_erase(struct pstore_record *record)
>                                      PSTORE_EFI_ATTRIBUTES, 0, NULL);
>
>         if (status != EFI_SUCCESS && status != EFI_NOT_FOUND)
> -               return -EIO;
> +               return efi_status_to_err(status);
>         return 0;
>  }
>
> --
> 2.43.0
>

