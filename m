Return-Path: <linux-efi+bounces-3009-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AE4BA6599B
	for <lists+linux-efi@lfdr.de>; Mon, 17 Mar 2025 18:07:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 636E47AAAE2
	for <lists+linux-efi@lfdr.de>; Mon, 17 Mar 2025 17:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1C9B186E2D;
	Mon, 17 Mar 2025 17:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XVytgnHJ"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989A818787A;
	Mon, 17 Mar 2025 17:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742231197; cv=none; b=Zz+3x4Qx2GE/l17xc7fORExj7qb0jdSM5iePIAIojgrEs83K7ygXXUIM7CxoHHBqXA0PZfQVnMIy8xK//CArNRAYg9ttRABM2RaD8s23MSYvMgNMJWGpf5ft501VNnBcnbJ6m+7AKP9rKh64iydSCIzjNXI6d3HpuxplCgDkKls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742231197; c=relaxed/simple;
	bh=sLNQSbl0TkH6y7EASnxzkx+y3wCavvX+Q9NF5vgcOtc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OMXADPqVcnzwcEIrqaWsrrdbXPdyRAQ9JbW5T7S0doV4AeBbp531eB4PreAOG3EDP70tJq4amDfjhz8f0thZwKzJHkg70NAV9DgzGyz20Wo6tYokYz1Zi0nWOFUt6tZVsToTjN/5HezFbaHS1WEwEK8Kc6dM4fFzY3m8WAFGOLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XVytgnHJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F16EC4CEE3;
	Mon, 17 Mar 2025 17:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742231197;
	bh=sLNQSbl0TkH6y7EASnxzkx+y3wCavvX+Q9NF5vgcOtc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=XVytgnHJORt5fBrvWySWYVLEU6Zbr7JCakRxx2Y/FOTn6+6Tjbu28xk4zKRv45OED
	 hX5H5kReNUxOiy/9FWhW++4iugJVyt+RtkGY08oxELcUxm4QS7gVP1Er7dXJfzDrlV
	 Z1sJLCSWFbdBFlrtlcOoroCzA2ouDg0p6bNV72PsyRHl47FPeo8ytwBehQDO6EdJsb
	 DZ0AFSlY7h0yiEsG7SW3JmIBmSAovDUlwFS1N6UlJuqtQDNGHB5RR52s5MLRyNdNvY
	 UZNjEsw2DjkozbRLzZL8EbcCBlaGygXQswwcZsOSirIdn8n0SonQo/BHn15yJcGl7U
	 LBQPqhmpOMJoA==
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-30761be8fcfso51555111fa.0;
        Mon, 17 Mar 2025 10:06:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXy0HcjL/t+h83ngx7NoRX9b8qABor0xTb1NPDamQ5vrOW/+XLAqdI+5tCiPQq3QjttLx2R+9wezfo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzssbbCyxgsroIuos7sIpOJqHU+k+Uh8i8CkPNpPKpFooDnwGZg
	pChZTxnNQ2nPdMqV7CQFeva8JdL32futqE59jxcMtQq9mvqW9H+W7x1TibFiRfKj2QH8cE1d4J2
	Uv8cj8d2bblgoabMNraiPSqK5iqA=
X-Google-Smtp-Source: AGHT+IERF0n+pA9W18Wvlnp1Z9YqN77YTorPRreSKdvnYxg3VYGHd79F7+XYUdVbAxG3VnwS7ZocmUrzwEzxW2UnY74=
X-Received: by 2002:a05:6512:3091:b0:545:6cf:6f3e with SMTP id
 2adb3069b0e04-549c3989ac9mr8420296e87.49.1742231195393; Mon, 17 Mar 2025
 10:06:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250317-plat2faux_dev-v1-0-5fe67c085ad5@arm.com> <20250317-plat2faux_dev-v1-3-5fe67c085ad5@arm.com>
In-Reply-To: <20250317-plat2faux_dev-v1-3-5fe67c085ad5@arm.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 17 Mar 2025 18:06:24 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEejZr2RCUJ59HfLwxQ1zFnWqj7vJ_ObrPTztE5s2UUcQ@mail.gmail.com>
X-Gm-Features: AQ5f1Jqf1O8iSYFfzLZH3qq1LKMRuI87oQw6DruwoLkOlzXICX9hN0zaV-Yd_gk
Message-ID: <CAMj1kXEejZr2RCUJ59HfLwxQ1zFnWqj7vJ_ObrPTztE5s2UUcQ@mail.gmail.com>
Subject: Re: [PATCH 3/9] efi: Remove redundant creation of the "efivars"
 platform device
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-kernel@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 17 Mar 2025 at 11:13, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> The "efivars" platform device is created but never tracked or used,
> as there is no driver associated with it. Since this device serves
> no functional purpose, removing its creation without affecting any
> functionality.
>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: linux-efi@vger.kernel.org
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  drivers/firmware/efi/efi.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> index 7309394b8fc98cf7a3424af209b752f0251c8c89..eec173cb1f398d3b4f28b42c917e50e1728dc277 100644
> --- a/drivers/firmware/efi/efi.c
> +++ b/drivers/firmware/efi/efi.c
> @@ -446,7 +446,6 @@ static int __init efisubsys_init(void)
>                 error = efivar_ssdt_load();
>                 if (error)
>                         pr_err("efi: failed to load SSDT, error %d.\n", error);
> -               platform_device_register_simple("efivars", 0, NULL, 0);
>         }
>
>         BLOCKING_INIT_NOTIFIER_HEAD(&efivar_ops_nh);
>

IIRC the efi-pstore module autoloads based on this platform device

