Return-Path: <linux-efi+bounces-2202-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A934D9D8B69
	for <lists+linux-efi@lfdr.de>; Mon, 25 Nov 2024 18:37:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B639B285A7
	for <lists+linux-efi@lfdr.de>; Mon, 25 Nov 2024 17:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 675B21B4F2B;
	Mon, 25 Nov 2024 17:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DNShMXD/"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DACE19D096;
	Mon, 25 Nov 2024 17:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732555820; cv=none; b=UWC9wz11He4hsWUejoQnaHMELF9UPLaYVjmHRBiKU81F+XWOO9gL3G3j78YHzCN3+M4FDeflODUmUqknY/seedT+Oo6GFv3TvdHxn/dP588gf52OMx7rrKxnKQ71kf33pq+LlSjBJQGX+HQdY12U6eksG08gfQo1t7ppKpdEI/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732555820; c=relaxed/simple;
	bh=Ms6Tp0WGmGoKFqyK03ZhiTsaxbDlL4XS3o5GbsYdpFE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p0ZZgLQ8K8zb7mx2/JhBNphhwr1kvlG/QzQOgkTgJRSySTTBuAs1eKc5bc/4h7ksms2J6RTxMOKYv8QSDthCpB2gRtlQBGBPP+g6RTNcE4q6lXROSuzEOvmPG/6YiWYtTLIT+eNuzVeYVXwz8aUmq2IRDyiri4cifwSi53hDmjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DNShMXD/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99EE9C4AF0B;
	Mon, 25 Nov 2024 17:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732555819;
	bh=Ms6Tp0WGmGoKFqyK03ZhiTsaxbDlL4XS3o5GbsYdpFE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=DNShMXD/jO7JPNdkU6IBC5K5VJu1bWb2GEmZJcRuYasBkdRSIJkD3o/IYDHDujCYF
	 jTnL/3MEsuHVoAoSAb58/OYNiTPqDzU8eAuKKDSjAc33jF7uBXPPIsX6AaJ2jBCLNy
	 XkWZfR9hovod21iCQOmwXd1nq3wY/GlSlSZ1m47ag0uHrVXfMm1E48zwcHB+jHGM1y
	 v/6OF8Bpm6GnYnW/khKStHXQ+yVHtgDbcR8lIKN07D+jFmFmnKA50nncjhh5W31h0l
	 dDpf3LaoYLzmwwMMVhBczagNKILNDxYkEjhbbj6TSvt2fSUpH2seX5QSQJXCvPG1XK
	 f8SvoqBeb8K+g==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2fb4af0b6beso75097101fa.3;
        Mon, 25 Nov 2024 09:30:19 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVMZ1AP2mS10z+vkYtKmXC6J9rwoAUBBFmJdfeaTPs3AtjcPv7i29BlqsGhSygUhkh7S3n8huYDB+5KjBgh@vger.kernel.org, AJvYcCX8ybUsdzlKStsqDLXhoiiqmvTNT70c34RdQZcbOax5/82b5yDdre5aB48XkPzHBR1ByEu6MjShE4s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwA7rTXjSCEI4MkAaqzLLFcmck6d8jEhJazECu17UYxogy2OjrM
	8AyIv4ncfS31H2WnydlySdRSr43qPOwMgJbefox2RBZqM3aVGvZ6jzZEEssYzRC1N4Z2itIMGQa
	xobQHAG6uMtN66YFoIYjmkFu5DW8=
X-Google-Smtp-Source: AGHT+IHqC0nzXwAN0lGa143T4VRPp60pS6sz5dfzeHFmvQbYiE+ylUyy75S0vjqWZZhPL+RVYkE1mgUFvfGxWPocXaI=
X-Received: by 2002:a05:651c:158d:b0:2fa:d7ea:a219 with SMTP id
 38308e7fff4ca-2ffa718f84cmr98917471fa.37.1732555817932; Mon, 25 Nov 2024
 09:30:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241125170758.518943-1-yeoreum.yun@arm.com> <20241125170758.518943-2-yeoreum.yun@arm.com>
In-Reply-To: <20241125170758.518943-2-yeoreum.yun@arm.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 25 Nov 2024 18:30:06 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGBnYQi05qh0QZk2hVLjVhS774-nT=HLdL_kW1d7nxMVg@mail.gmail.com>
Message-ID: <CAMj1kXGBnYQi05qh0QZk2hVLjVhS774-nT=HLdL_kW1d7nxMVg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] arm64/acpi: panic when failed to init acpi table
 with acpi=force option
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: broonie@kernel.org, sami.mujawar@arm.com, sudeep.holla@arm.com, 
	pierre.gondois@arm.com, hagarhem@amazon.com, catalin.marinas@arm.com, 
	will@kernel.org, guohanjun@huawei.com, Jonathan.Cameron@huawei.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 25 Nov 2024 at 18:08, Yeoreum Yun <yeoreum.yun@arm.com> wrote:
>
> when the acpi=force option is used,
> the system does not fall back to the device tree (DT).
> If it fails to initialize the ACPI table, it cannot proceed further.
> In such cases, the system should invoke panic() to avoid contradicting
> the user's explicit intent, as failing or
> proceeding with unintended behavior would violate their wishes.
>

Calling panic() at this point does not achieve anything useful,
though. Without ACPI tables or a DT, the only way to observe this
panic message is by using earlycon= with an explicit MMIO address, and
it might be better to limp on instead. Is there anything bad that
might happen because of this, other than the user's wishes getting
violated?


> Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> Reviewed-by: Mark Brown <broonie@kernel.org>
> ---
>  arch/arm64/kernel/acpi.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
> index e6f66491fbe9..efdf24ed5c3e 100644
> --- a/arch/arm64/kernel/acpi.c
> +++ b/arch/arm64/kernel/acpi.c
> @@ -225,6 +225,8 @@ void __init acpi_boot_table_init(void)
>                 pr_err("Failed to init ACPI tables\n");
>                 if (!param_acpi_force)
>                         disable_acpi();
> +               else
> +                       panic("Failed to boot with ACPI tables\n");
>         }
>
>  done:
> --
> LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}
>

