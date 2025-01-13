Return-Path: <linux-efi+bounces-2612-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89CCEA0B93C
	for <lists+linux-efi@lfdr.de>; Mon, 13 Jan 2025 15:18:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2CA41671FF
	for <lists+linux-efi@lfdr.de>; Mon, 13 Jan 2025 14:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 636C354279;
	Mon, 13 Jan 2025 14:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HW37IBlA"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3583D22CF12;
	Mon, 13 Jan 2025 14:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736777899; cv=none; b=C+fV0iJJaGDNmhpwlwAN7bBTwn+AQTfQWPXTZPOtpy8SrGwZHV/N3il1O9E24Vaoi+kIgSdqtdWciQICQXQA1onqKHj2U2MYJIGDxUy7j+6+Y7M6D2p23AkD304MxMtqm27FXobPC6T4KMrL4nNSld1swO4j+k/iQ+8Fw+n/Zp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736777899; c=relaxed/simple;
	bh=JIrBeHttf6I/fLu6mjSVMdpC+lAqk1oqfwTbIcFecMU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X6JCTtO+1igXjB/yRza1fwmP5JWqCfuVTBKzN+2+/94CTT70AioZMbrDmnaO8OxXKxMfPSyn8PJj+UnZnSwoQw/c5eWJwA0Rc3FGggYrOHtm2jwjawTZZoV5zV8lOC7D+dySqyFiG09NdwIkTqFRlvPFYA+8xvfBeeJPbnBULg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HW37IBlA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC844C4CEE3;
	Mon, 13 Jan 2025 14:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736777898;
	bh=JIrBeHttf6I/fLu6mjSVMdpC+lAqk1oqfwTbIcFecMU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=HW37IBlAXzXPEDDqGRtGCvhGNaW+Z3DYJtYeg9OfFc0lTqW3Kd8rxXZPNbcJg207E
	 6M/p2S0VrCWs4wgftG8Y9q4CylASuDzRIv+XDFRSPsWdeyR9cRPclJKGsBMluWwEe7
	 SRGsF/wSi13uW0saaqfEjZAU44A+Vgrk8t0r8uMS9NK9SZoOYsLuczqzQB8l4+LH3b
	 rvXuJdlgyZJ8KEwgUnaZD+52CyDKHaU95sKJThqscjbUWBxIiL8FSHfDE0jYo5U9vK
	 EWlprlOj1vku9ZQFhSQYz83dM6P3iEglAsIRruAIbQIRFXN9xYyySwyF+kIP/+QtW+
	 oM6jhHPiQJytw==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-30613802a6bso18670371fa.1;
        Mon, 13 Jan 2025 06:18:18 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU2XrhH3er8fLacbET4F0RUMpWDt+8JgHIMR/+2MqYaT6IFQk1+Juz8slW24CG/Sk1wFZSpT0YjgH0X@vger.kernel.org, AJvYcCUky1zKMnCHOaKjiIR1iU/WhdIxaGqddsfLdMOkUM84Opy0MCsoKFJ0V+jl8k0eX160HieRAmTg3IKk1rTA@vger.kernel.org, AJvYcCXwsT+MDyCmFpNuqVZsu4I9xjUDIup5Rx46vSyMm/iuheFVqa9PuCI2+sXV+XTPg34JlpjOYhNs42F4yRiqJw8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxpz2IYM5ffN6BPoDiFjmE84oti6nbyZTmF11IsVn+rmTMqBr6k
	QAIwI7+XpPINhCz7DgMhAuO0cWKx0zJ+1xccEF3zj6lYVieK3YHBFB/G46m54fQzDlXGKHNp0EW
	VTspyviXk/Vi6mK8VqD8EvzJYi2Q=
X-Google-Smtp-Source: AGHT+IEbYAapgR3P8XqK9xEqeyJvNURt51Dn93R/joVVmWDoVWL+hMBQDhPPO7q4lbX0b6Adn/nnFgwX5/2E2cRKGGM=
X-Received: by 2002:a05:651c:154a:b0:303:4289:b991 with SMTP id
 38308e7fff4ca-305f459f152mr72365961fa.19.1736777896759; Mon, 13 Jan 2025
 06:18:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <7f7565d8-ef9f-4e5f-834b-9735db01835a@stanley.mountain>
In-Reply-To: <7f7565d8-ef9f-4e5f-834b-9735db01835a@stanley.mountain>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 13 Jan 2025 15:18:05 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEt6DJufw7Jv+nWYzt=SrBsiTmRrXeRZFYdA5zC+3M6kA@mail.gmail.com>
X-Gm-Features: AbW1kvbYvRsld8EQ-1cyjRL_bNp-iwY4TScxnTHJw3y4StYn78qnrh6oAS8pDGg
Message-ID: <CAMj1kXEt6DJufw7Jv+nWYzt=SrBsiTmRrXeRZFYdA5zC+3M6kA@mail.gmail.com>
Subject: Re: [PATCH next] efivarfs: Fix a NULL vs IS_ERR() bug
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>, Jeremy Kerr <jk@ozlabs.org>, 
	linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 13 Jan 2025 at 07:16, Dan Carpenter <dan.carpenter@linaro.org> wrote:
>
> The kernel_file_open() function doesn't return NULL, it retursn error
> pointers.  Fix the error checking to match.
>
> Fixes: eb11e99adef8 ("efivarfs: add variable resync after hibernation")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  fs/efivarfs/super.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Thanks - I'll fold this in rather than apply it on top though.

> diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
> index 961264f628dc..968e4af7b7e4 100644
> --- a/fs/efivarfs/super.c
> +++ b/fs/efivarfs/super.c
> @@ -492,7 +492,7 @@ static int efivarfs_pm_notify(struct notifier_block *nb, unsigned long action,
>         /* O_NOATIME is required to prevent oops on NULL mnt */
>         file = kernel_file_open(&path, O_RDONLY | O_DIRECTORY | O_NOATIME,
>                                 current_cred());
> -       if (!file)
> +       if (IS_ERR(file))
>                 return NOTIFY_DONE;
>
>         rescan_done = true;
> --
> 2.45.2
>

