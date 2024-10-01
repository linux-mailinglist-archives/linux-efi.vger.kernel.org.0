Return-Path: <linux-efi+bounces-1862-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D14CA98B3F8
	for <lists+linux-efi@lfdr.de>; Tue,  1 Oct 2024 07:59:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F282283D80
	for <lists+linux-efi@lfdr.de>; Tue,  1 Oct 2024 05:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 893501B373B;
	Tue,  1 Oct 2024 05:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pw/PCx5q"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5799636AF8;
	Tue,  1 Oct 2024 05:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727762348; cv=none; b=RSCwJIp3mc8wdaKvbiekXiGUuvhsUTFRdRiAUW72elH0gYRlW+kmTtZEQaxqp/MWZsYEBC4xvUYUUosjaZpqvmupeyu7qfhETpA1M8qIKmBbyK4/NDqVpkeSZ6hBtJFfDRPH1rBfbZuFHPcgKuj7dctJ5k7VNREisngTM8oUKBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727762348; c=relaxed/simple;
	bh=HfbzoxMtDwCaO5o4crY+tAP8aTcFv4LOoZTLbizRq64=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QF36dtKA7ATINCmDzevelR+esOg/9WJHABI6N3jv982SvfUw/cK26EtYALMUOP0RnbE3+6XZcHnOm6LCHqN69+oVP/lIwVNSmOEVtBSvzxT1oAKPieQ7C4U4xmUc0suWHehTFvo7IK5zSZA7pB+V/o0zOxZjI0EmsSFhgW0bCQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pw/PCx5q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E43CAC4CEC6;
	Tue,  1 Oct 2024 05:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727762347;
	bh=HfbzoxMtDwCaO5o4crY+tAP8aTcFv4LOoZTLbizRq64=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=pw/PCx5qFobE+Omwl/t2AJOS+8PYOGYBnu2FqEBF1eqXg80fyEZ4f6UkLmpC97/Vy
	 r+zR/Cd+lc5klJX5xYgS7DlelcM3CzSlsTeMYH0sYSzBUvTrpoir3sqmy+iJSdEqcc
	 NDp0IK3VmFvcT+/aKMSecYx1m1FYvRAg0mEPjUo5HAEka/yVYA2ApBaADFXWAERPhs
	 KiLod4ro5Ctn1x90EpW+ITEBuLtmhX/1F7K7oyq6/h3vWkRqZw4MdxFhLebyBN81lY
	 PYNzNMEP4tGi04x6b8eZwliEgdICzXNvIuzT7sJa2yeWqL/+ADD28RYIxXgXTc908o
	 qCm3XCcc9VlBw==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-539973829e7so1595700e87.0;
        Mon, 30 Sep 2024 22:59:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXgEhMjCVwX457IyxrM3YLAkF6BoPPXgwuvd83jFUUkUdnL3EzzMfZg5XkP4zd//y7Z19F68aXhX7LQ7HE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSfqzw24xOMVX+qjvHhoSk5o1NguEv5DKsYzjRKdcObJnz8p7v
	gcLNPqKfBFFo8KVzQgUMzBMFhflsfr7+ER/r259tHYVfkYY0i3hZ7ZgLpFAkQH9zoS9sibKHgGs
	n2CdLkLE3+DceRWDjZpiV8K+Zp7I=
X-Google-Smtp-Source: AGHT+IFXQwHKD0uaOWpCND7OCsswTrsvCQ/vNYzlRQfaD0tTW74PT0VYPMtXPJvjn31Vm9qS5qGXXjyH/KWiqpEnVKY=
X-Received: by 2002:a05:6512:3b0e:b0:52c:86d7:fa62 with SMTP id
 2adb3069b0e04-5389fc43de2mr8653973e87.23.1727762346227; Mon, 30 Sep 2024
 22:59:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001032028.483199-1-jeremy.linton@arm.com>
In-Reply-To: <20241001032028.483199-1-jeremy.linton@arm.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 1 Oct 2024 07:58:54 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEwsB2JZeE451Qf=tad7mapWATu_-ty+r7fcMTcxQ=StQ@mail.gmail.com>
Message-ID: <CAMj1kXEwsB2JZeE451Qf=tad7mapWATu_-ty+r7fcMTcxQ=StQ@mail.gmail.com>
Subject: Re: [PATCH] efi/libstub: measure initrd to PCR9 independent of source
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: linux-efi@vger.kernel.org, bp@alien8.de, 
	sathyanarayanan.kuppuswamy@linux.intel.com, linux-kernel@vger.kernel.org, 
	Jeremy Linton <jeremy.linton@arm.com>
Content-Type: text/plain; charset="UTF-8"

(cc Ilias)

On Tue, 1 Oct 2024 at 05:20, Jeremy Linton <jeremy.linton@arm.com> wrote:
>
> Currently the initrd is only measured if it can be loaded using the
> INITRD_MEDIA_GUID, if we are loading it from a path provided via the
> command line it is never measured. Lets move the check down a couple
> lines so the measurement happens independent of the source.
>
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> ---
>  drivers/firmware/efi/libstub/efi-stub-helper.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
> index de659f6a815f..555f84287f0b 100644
> --- a/drivers/firmware/efi/libstub/efi-stub-helper.c
> +++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
> @@ -621,10 +621,6 @@ efi_status_t efi_load_initrd(efi_loaded_image_t *image,
>         status = efi_load_initrd_dev_path(&initrd, hard_limit);
>         if (status == EFI_SUCCESS) {
>                 efi_info("Loaded initrd from LINUX_EFI_INITRD_MEDIA_GUID device path\n");
> -               if (initrd.size > 0 &&
> -                   efi_measure_tagged_event(initrd.base, initrd.size,
> -                                            EFISTUB_EVT_INITRD) == EFI_SUCCESS)
> -                       efi_info("Measured initrd data into PCR 9\n");
>         } else if (status == EFI_NOT_FOUND) {
>                 status = efi_load_initrd_cmdline(image, &initrd, soft_limit,
>                                                  hard_limit);
> @@ -637,6 +633,11 @@ efi_status_t efi_load_initrd(efi_loaded_image_t *image,
>         if (status != EFI_SUCCESS)
>                 goto failed;
>
> +       if (initrd.size > 0 &&
> +           efi_measure_tagged_event(initrd.base, initrd.size,
> +                                    EFISTUB_EVT_INITRD) == EFI_SUCCESS)
> +               efi_info("Measured initrd data into PCR 9\n");
> +
>         status = efi_bs_call(allocate_pool, EFI_LOADER_DATA, sizeof(initrd),
>                              (void **)&tbl);
>         if (status != EFI_SUCCESS)
> --
> 2.46.1
>

