Return-Path: <linux-efi+bounces-864-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78F72887876
	for <lists+linux-efi@lfdr.de>; Sat, 23 Mar 2024 13:16:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA50E1C214ED
	for <lists+linux-efi@lfdr.de>; Sat, 23 Mar 2024 12:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8750A168A9;
	Sat, 23 Mar 2024 12:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QMax+p5K"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43330224C7;
	Sat, 23 Mar 2024 12:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711196164; cv=none; b=U4tiTGvsyfbMdqrFfCgntP0aktCtlixhPhK9ErR2rvTguq4TGbS/kUi3RVU4LI3MpBTJ9zbQCdDXjaHq8ysfr5B5+n620EDnRjNlZLNG2XfYFuDvuARwvZoTYDfXJGHrmJqsYhxJ2q/x51KweWHHPg0uRztlSKXPEl/E9HYtApg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711196164; c=relaxed/simple;
	bh=298pc/6jgFUt0TwsCfTIdMnWzb5pr9qYj3xJKL5h9b4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dtbwy+Ga88SjO2IQI59Nv9Owz1dc7BsltlYNmbR40DTppbvhV7ipLFAi6P7H5Q0zFivlLQ1LG3oHlH7UK8Q8wtwhX9Atgc1s48QefMPqOGIKVkATJCIWhqjHVSZpTqD3nNb1xHRSM924gdaqcv4tbRLyk14q0LSg4d5SAHuluZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QMax+p5K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB1D8C43390;
	Sat, 23 Mar 2024 12:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711196163;
	bh=298pc/6jgFUt0TwsCfTIdMnWzb5pr9qYj3xJKL5h9b4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=QMax+p5KYlB+npS6Z4iPkf+3iwEXX34LNFxzva2NMTymhzQ2p+A1obKHyBhQUGOwZ
	 Qw4sJkEcc3vIUBZBNOalhDX+nRpzY31zZ2C85/vzZVv6NTlNDvcO/SSMg06pSdCsOp
	 ydxnEkcB+4mCsJqZLeEx5ndCIkfL3qM/K/Q7kLLvgJV3rk7EJWT8l+TFE9xznwV05i
	 9YsYB3UDpdh4o3QwLiH7Ab+9iMXEZLSGMOAyYK7EU/oVyZjOJOP9qiP0nOF6TIHKWu
	 VU4ov1y4QOxbxkLSWLJ3LAKwUbgRoQH4eChYDR2ONZ/bcEOdvagoWLXG5ISzepx4Rj
	 Adg8I+HgUrgbg==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d6a1af9c07so41272071fa.3;
        Sat, 23 Mar 2024 05:16:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW6AxBjmvSJOmpM+Ch9gvalN4wLqx013Ep/e2k+2P+FKAAy+bX2dQKOPFq8ThZd+UtuFEquy8BDpuoniad6nN5CrRUwhcpbU2YdzXoi/n4uUPcH9CUhdz0v+nDnFBDKTWheSAV7NfbYDeUsCjQuEACxjK0HZfR+ehg5YD9wnJP+
X-Gm-Message-State: AOJu0YwZ8PgLbc4G4ilTQHuFfRB+Buv2aNCZdPcxvSkG+DeEl3hpsR3g
	S+w0fZvBbYhC85gJne2VGcoL4uKU3KTpjmrGS7nR+logM9Cdhz+ZIYoHdtL434Mvcvo42TeHeiN
	kQEXEEyfBDTUtVmyxxyzxpo6EHeg=
X-Google-Smtp-Source: AGHT+IHUBS5vtwn45KMvgPpQE099s2U9NrhFU0h6pQa4pjHfgrf1U2XXsDqbwTu0oIxWu3ZZUniBzF45ZNzdWf2sx2s=
X-Received: by 2002:a05:651c:11c9:b0:2d3:ada4:1228 with SMTP id
 z9-20020a05651c11c900b002d3ada41228mr1357649ljo.18.1711196162074; Sat, 23 Mar
 2024 05:16:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240323063334.735219-1-ovt@google.com>
In-Reply-To: <20240323063334.735219-1-ovt@google.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Sat, 23 Mar 2024 14:15:50 +0200
X-Gmail-Original-Message-ID: <CAMj1kXF0oM4CZM6GBQ+JNdk0ipf62cVJWjaR7Qy8YEU2B6=MVg@mail.gmail.com>
Message-ID: <CAMj1kXF0oM4CZM6GBQ+JNdk0ipf62cVJWjaR7Qy8YEU2B6=MVg@mail.gmail.com>
Subject: Re: [PATCH v2] efi: fix panic in kdump kernel
To: Oleksandr Tymoshenko <ovt@google.com>
Cc: Johan Hovold <johan+linaro@kernel.org>, stable@vger.kernel.org, 
	linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 23 Mar 2024 at 08:33, Oleksandr Tymoshenko <ovt@google.com> wrote:
>
> Check if get_next_variable() is actually valid pointer before
> calling it. In kdump kernel this method is set to NULL that causes
> panic during the kexec-ed kernel boot.
>
> Tested with QEMU and OVMF firmware.
>
> Fixes: bad267f9e18f ("efi: verify that variable services are supported")
> Cc: stable@vger.kernel.org
> Signed-off-by: Oleksandr Tymoshenko <ovt@google.com>

Thanks. Queued as a fix.

> ---
> Changes in v2:
>   - Style fix
>   - Added Cc: stable
>   - Added Fixes: trailer
> ---
>  drivers/firmware/efi/efi.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> index 8859fb0b006d..fdf07dd6f459 100644
> --- a/drivers/firmware/efi/efi.c
> +++ b/drivers/firmware/efi/efi.c
> @@ -203,6 +203,8 @@ static bool generic_ops_supported(void)
>
>         name_size = sizeof(name);
>
> +       if (!efi.get_next_variable)
> +               return false;
>         status = efi.get_next_variable(&name_size, &name, &guid);
>         if (status == EFI_UNSUPPORTED)
>                 return false;
> --
> 2.44.0.396.g6e790dbe36-goog
>

