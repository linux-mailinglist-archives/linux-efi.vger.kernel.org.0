Return-Path: <linux-efi+bounces-1939-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A49D599B1D7
	for <lists+linux-efi@lfdr.de>; Sat, 12 Oct 2024 09:55:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E94A1F24A6A
	for <lists+linux-efi@lfdr.de>; Sat, 12 Oct 2024 07:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F016B13D893;
	Sat, 12 Oct 2024 07:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GRZsYnXg"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53D2126BE1;
	Sat, 12 Oct 2024 07:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728719697; cv=none; b=lFYFVx3g1x9gXfVhVLFMXT2eCtar+g1e1O9zzuzaBnyac9T7tVuie3HduPaeggA0IYK3GxtN+YCrEQQ5eLmlNB6Wew4m5s5BGiOObRhAJNP11MNNlFpsxllkgIe+93n9kZUl8PwppPExAyHdeZ8qS2p+D1fqCUJma+R+89XwUcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728719697; c=relaxed/simple;
	bh=Jw7PmkQmbX4v3tS4291K5+sm4U9zchTdB1uxCSg0xHE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WEmUW9MUmk4DWLW7hEhb+pi5fNa/pDqUyzXxHONTdqLKEa14m4HN1dPPqXvTOb6o7CJyQNwG4U5D3kCT5qFbwYE8eixbUHo5bnc660XCQ3x1Kmw3DaEF+TW0t0pjsyBho05USG1T+UmFqE4ifcPMZAp4qU9MuQJHvi4EGO82roU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GRZsYnXg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3804FC4CECC;
	Sat, 12 Oct 2024 07:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728719697;
	bh=Jw7PmkQmbX4v3tS4291K5+sm4U9zchTdB1uxCSg0xHE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=GRZsYnXgvaRkC9YXxQDCD62TbyeM6ZlPJ91LwJjY5weU0RJNDZTPpL+KF2autY2qK
	 FKwdtPAYZP8aRRdSPpxHCHYk6ZCJxAQk7dC75LpAZSRLmiCHvKCDspkwuY5gDAO436
	 fIRsobRap03WCIx3TAUZqkG3U+9RiPSN+E35VYkLSLjK091Qdeh0jYAOtv1bazziRh
	 OOb6DojaMx5/DUFTBptU9h4sHXIsJ2vF20lenMSYnKnBzKPe0OBBaBn+h9DW0onJmK
	 BQK/PppO+nN5kekQpY6nRQ8DGfIdDu9wyKRW2I2OSUGYaS4CFp4x6hb00LmpqhKvs9
	 cGLrr0nVEh8sQ==
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2fb3debdc09so5597031fa.3;
        Sat, 12 Oct 2024 00:54:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWj5vlyI0jeU+sgV325LJFS8TYul5GoOp9VBoxMQrjHqM7vLNc7AwbbH26i23y6/OJrmxyEas+wdPSzN2c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNZAhpfu26/EJLR1K23QXrLgtnxC3ejkxUphNQpniA0/AT25ZV
	AUbmsyOIZzv0x2rsUE5WU8J5aSwXrshSxcnpuvERRj5IQe6ndZmhksgr514ToepIamKx/01/nZu
	BM/xHShsE9V15KBrnM6MwYhAP2Wc=
X-Google-Smtp-Source: AGHT+IEF7XGGtO9SU5vv5ZMoczydGnIfPCEvutde1lxo07Snzr8hJJcW0KC2dyM1sSBXXSpd2ewPFUqtvQRA2WTm8dk=
X-Received: by 2002:a05:6512:12d3:b0:52c:d904:d26e with SMTP id
 2adb3069b0e04-539da3c87f5mr2576385e87.21.1728719695575; Sat, 12 Oct 2024
 00:54:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241011224812.25763-1-jonathan@marek.ca> <20241011224812.25763-3-jonathan@marek.ca>
In-Reply-To: <20241011224812.25763-3-jonathan@marek.ca>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Sat, 12 Oct 2024 09:54:44 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHgFVs5Gt5hNao6DTZxqw4dO89OuUMH2tvdWPY1kxfc0Q@mail.gmail.com>
Message-ID: <CAMj1kXHgFVs5Gt5hNao6DTZxqw4dO89OuUMH2tvdWPY1kxfc0Q@mail.gmail.com>
Subject: Re: [PATCH 3/3] efi/libstub: consider CONFIG_CMDLINE for initrd= and
 dtb= options
To: Jonathan Marek <jonathan@marek.ca>
Cc: linux-efi@vger.kernel.org, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sat, 12 Oct 2024 at 00:52, Jonathan Marek <jonathan@marek.ca> wrote:
>
> Replace cmdline with CONFIG_CMDLINE when it should be used instead of
> load_options.
>
> In the EXTEND case, it may be necessary to combine both CONFIG_CMDLINE and
> load_options. In that case, keep the old behavior and print a warning about
> the incorrect behavior.
>

The core kernel has its own handling for EXTEND/FORCE, so while we
should parse it in the EFI stub to look for options that affect the
stub's own behavior, we should not copy it into the command line that
the stub provides to the core kernel.

E.g., drivers/of/fdt.c takes the bootargs from the DT and combines
them with CONFIG_CMDLINE.


> Signed-off-by: Jonathan Marek <jonathan@marek.ca>
> ---
>  drivers/firmware/efi/libstub/file.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/drivers/firmware/efi/libstub/file.c b/drivers/firmware/efi/libstub/file.c
> index d6a025df07dcf..2a69e2b3583d4 100644
> --- a/drivers/firmware/efi/libstub/file.c
> +++ b/drivers/firmware/efi/libstub/file.c
> @@ -208,6 +208,18 @@ efi_status_t handle_cmdline_files(efi_loaded_image_t *image,
>         if (IS_ENABLED(CONFIG_X86) && !efi_nochunk)
>                 efi_chunk_size = EFI_READ_CHUNK_SIZE;
>
> +       if (IS_ENABLED(CONFIG_CMDLINE_EXTEND) ||
> +           IS_ENABLED(CONFIG_CMDLINE_FORCE) ||
> +           cmdline_len == 0) {
> +               if (!IS_ENABLED(CONFIG_CMDLINE_FORCE) && cmdline_len > 0) {
> +                       /* both CONFIG_CMDLINE and load_options should be used */
> +                       efi_warn("ignoring %ls from CONFIG_CMDLINE\n", optstr);
> +               } else {
> +                       cmdline = L"" CONFIG_CMDLINE;
> +                       cmdline_len = ARRAY_SIZE(L"" CONFIG_CMDLINE) - 1;
> +               }
> +       }
> +
>         alloc_addr = alloc_size = 0;
>         do {
>                 struct finfo fi;
> --
> 2.45.1
>

