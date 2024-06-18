Return-Path: <linux-efi+bounces-1239-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CB6D90CCDB
	for <lists+linux-efi@lfdr.de>; Tue, 18 Jun 2024 14:58:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3285D1C20A8C
	for <lists+linux-efi@lfdr.de>; Tue, 18 Jun 2024 12:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4172819F477;
	Tue, 18 Jun 2024 12:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LBYFTB6N"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162F815533D;
	Tue, 18 Jun 2024 12:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718714427; cv=none; b=Fyr7tLH8bNbAM6LhgUZaGbOqYeM8Aqou4/5dEqmxKa7Ah5Uzq9M3dCrVgOxes3OxC11ns6a+WlirR/jL6bxZvugfTyAvsNoRSjHvXofDToLcmrd75gForCuYUwLaPx4/IXy6Xz9NUpPrrUR7qggZ0BMGU2+lBTRx60Mfr0bJV6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718714427; c=relaxed/simple;
	bh=PLYFcs7ICDH3FpoaefktwgaRhPxIEU6ZQGa1ScCB6cA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TXroUZMkN6ucSXe3HQes9HLDES/8WNWvnj4LEpJtmyEqmTEJDktWrwdWafQizz6qAZpfOQpbTxrmF1PbOvVd8tfdYgOC6ogrIzaOL57ZMJCvnVCfTPFT0fepGKvxeageA0NK657t/1D3LQlI2ICgDsOg13aAd/5iAy50XxCDsXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LBYFTB6N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3B5FC4AF49;
	Tue, 18 Jun 2024 12:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718714426;
	bh=PLYFcs7ICDH3FpoaefktwgaRhPxIEU6ZQGa1ScCB6cA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=LBYFTB6Nmi/C+IIR/nuTMRIBuWLPz2ldfQEmQ/ZnM6HxS5xPxPdW2kIvfy7KY8ZwD
	 28ZeQ8oXU12vEuk6qIj9szZ5eqTCATUM2PBUZtj0uiWIQtXXVYgnZQRuYBSVvUYRLU
	 jBzfBro7TzHKgPD2CxmOzHhyb7Rl+tukcpn9zqk2iwhyPGB7gKmG9AlSS7CohtNrxS
	 pN0B0W5ixysc4z4kUIdOAZWovfHEkQJJp4vcbQP5pfDl0ImCmGjeFCqcbWh0KXFaQq
	 qkA6vJV5Rk8OfwUL7+DKkuE6TRWvnqXiqm5BsHRX2KY1EwqPbJnXHMLBpDu3i7BHRa
	 XOPBm0XB5+vhw==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2ec3c0dada3so2594751fa.0;
        Tue, 18 Jun 2024 05:40:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXC7nczjlSmVIgK8HFPHfz4jeRlWyG4b2LEQq7mdCLXEG23hxV8bvJRYjy/TAzgXtQQFl49lxMGUpDxqEiCOSw2HJi6y5c2ixyeX97SEBrFXdUbkcZ6D5//O1jcGN3Wvtdum6dAS71EltRnyH8MijbpUsMfdxI2ULz/Jfqfu5R/kqgZ
X-Gm-Message-State: AOJu0YzyF2S9Sec3Nh//rOkgItDWwAltupWE3t/7fNCg4Zuho79ZPwQG
	yaWyy7Cs1laD7lwOMJdZgkRj4YUZ37yUlWQHPtN0fQ5Ypz269iW9gETJZt9OcaBDeOoJoR8DDY3
	MgxIk1vXv0+pz8EVFrwUmUp4HSYM=
X-Google-Smtp-Source: AGHT+IES1HZ7KpNyPW3dWatBp5F9F7os952srDi0rQG4n/sgJkgHaQma8pvcT9JBsdMuwoondxheXbX6SpdohqLG+Zo=
X-Received: by 2002:a2e:878f:0:b0:2ec:3565:9a6a with SMTP id
 38308e7fff4ca-2ec35659ab0mr16207111fa.33.1718714424915; Tue, 18 Jun 2024
 05:40:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240618123611.3301370-1-sashal@kernel.org> <20240618123611.3301370-7-sashal@kernel.org>
In-Reply-To: <20240618123611.3301370-7-sashal@kernel.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 18 Jun 2024 14:40:13 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGzMCT4KQcrnD80p6ZA=-j+aAPuPbKRuYQiRjof-+dTUg@mail.gmail.com>
Message-ID: <CAMj1kXGzMCT4KQcrnD80p6ZA=-j+aAPuPbKRuYQiRjof-+dTUg@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 6.9 07/44] efi: pstore: Return proper errors on
 UEFI failures
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>, Kees Cook <keescook@chromium.org>, 
	linux-hardening@vger.kernel.org, linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

I already NAKed this yesterday.

Please stop proposing the same patches.

And in the future, please omit *any* patch from AUTOSEL that has been
signed off by me, not only authored by me.



On Tue, 18 Jun 2024 at 14:36, Sasha Levin <sashal@kernel.org> wrote:
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

