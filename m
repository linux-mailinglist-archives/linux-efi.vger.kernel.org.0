Return-Path: <linux-efi+bounces-455-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93AEB847502
	for <lists+linux-efi@lfdr.de>; Fri,  2 Feb 2024 17:38:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C72C91C20C99
	for <lists+linux-efi@lfdr.de>; Fri,  2 Feb 2024 16:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E1C1148315;
	Fri,  2 Feb 2024 16:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fXHS0fuy"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E989C14830B;
	Fri,  2 Feb 2024 16:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706891861; cv=none; b=bznc+aWZyo4KTlZBNtYNfZSGQCgIwVqfsS+cNngRNgCUx+8yuk4kw8x6OcZx9LybmXMyJEmI6beovbUN/0VkSB+H8iGkHWFQuDuTpZHOlKo/F6FJEK7klzRQKDSguv92qCh2EivED/nSdw1ydDqg4RK29QqiYJjBN0Oj3C5ZqVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706891861; c=relaxed/simple;
	bh=Uwkd7nTQQrSccD545d3Y+lH6FQYzJbXBcM9/NkSdyEU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=abHl6eBkfBtANzvGk/TKhv4AZl4en8hO2+1/J7ocZkXHBG+C2ZJUNaGHXRInC5+M6XukKG2QgckbvujfuAoN5oFFDjleErDDmWGZVtT1omfYmS6r4J1cS7/44Hh7NpUmfbZ/EqEabtbDxuFwvFJR6ms6F1xf0r30yguXDB9Wldo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fXHS0fuy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B904C433F1;
	Fri,  2 Feb 2024 16:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706891860;
	bh=Uwkd7nTQQrSccD545d3Y+lH6FQYzJbXBcM9/NkSdyEU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=fXHS0fuyj/S03+wmk5ISzAXdQ8cMdABMx6ExToz8J4VtDmQbJ8hPFgjtzru1e8/Aw
	 DLegNr7XswiSzak9whAzIsW+48P5LDZSbLuGEB31DJe6aKrSIkbhf1Di0GuD0R5KWR
	 9K/xj19XqXZLro3BoaW+43MvNTrvWnRPxmtN/+gYvTxpka5TxFtxKJaMDux/IszswB
	 JRKDFSIVE+zmeEjhlkCDUxJf0J1LHTMFPsTcJr1AOJ0mM0MQiLFw666l9tZ29VLPu0
	 LizKmg8YJIsUwwlbbNL8WPUowEqVutqGy87WF3IdnnRKYx7fB8NRX/lflzu+MzYVFq
	 cFuGogFLj8yEQ==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d093cb1ef3so1391161fa.3;
        Fri, 02 Feb 2024 08:37:40 -0800 (PST)
X-Gm-Message-State: AOJu0Yx34rge4x4vJNdeeLbsHZCKVRaW/iJWQLAmWIurEMzIL885cLdE
	YnN/6dm+7lN99zZGmMM5hvk3+5ZlORDKlHWzDhIeceZ7hbhzOhJpLs19TVou0/cMDveHNBZTfyV
	P7mBb6WohcwllqoQuULC6N6WKurM=
X-Google-Smtp-Source: AGHT+IH+2hrSf5CH7QZoCnp7kbDbwEWAwfZngecusVvcc+8VLLiXgX2u9WvaRUy0ZbgjPawIpFHcGXT0CgZtix88FXM=
X-Received: by 2002:a2e:bc1b:0:b0:2d0:870e:b29d with SMTP id
 b27-20020a2ebc1b000000b002d0870eb29dmr1857693ljf.50.1706891858752; Fri, 02
 Feb 2024 08:37:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240202163433.786581-1-abrestic@rivosinc.com> <20240202163433.786581-2-abrestic@rivosinc.com>
In-Reply-To: <20240202163433.786581-2-abrestic@rivosinc.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 2 Feb 2024 17:37:24 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGR0thbcDt32pC=KS=tsmSWqQuyhJ2Ftq0vX3u=dLX22g@mail.gmail.com>
Message-ID: <CAMj1kXGR0thbcDt32pC=KS=tsmSWqQuyhJ2Ftq0vX3u=dLX22g@mail.gmail.com>
Subject: Re: [PATCH 1/2] efi: runtime: Fix potential overflow of soft-reserved
 region size
To: Andrew Bresticker <abrestic@rivosinc.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, linux-efi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Hi Andrew,

On Fri, 2 Feb 2024 at 17:34, Andrew Bresticker <abrestic@rivosinc.com> wrote:
>
> md_size will have been narrowed if we have >= 4GB worth of pages in a
> soft-reserved region.
>
> Signed-off-by: Andrew Bresticker <abrestic@rivosinc.com>
> ---
>  drivers/firmware/efi/arm-runtime.c   | 2 +-
>  drivers/firmware/efi/riscv-runtime.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/firmware/efi/arm-runtime.c b/drivers/firmware/efi/arm-runtime.c
> index 83f5bb57fa4c..f369256c7003 100644
> --- a/drivers/firmware/efi/arm-runtime.c
> +++ b/drivers/firmware/efi/arm-runtime.c
> @@ -107,7 +107,7 @@ static int __init arm_enable_runtime_services(void)
>                 efi_memory_desc_t *md;
>
>                 for_each_efi_memory_desc(md) {
> -                       int md_size = md->num_pages << EFI_PAGE_SHIFT;
> +                       unsigned long md_size = md->num_pages << EFI_PAGE_SHIFT;

Better use u64 here, and below as well.


>                         struct resource *res;
>
>                         if (!(md->attribute & EFI_MEMORY_SP))
> diff --git a/drivers/firmware/efi/riscv-runtime.c b/drivers/firmware/efi/riscv-runtime.c
> index 09525fb5c240..9da79b8169d2 100644
> --- a/drivers/firmware/efi/riscv-runtime.c
> +++ b/drivers/firmware/efi/riscv-runtime.c
> @@ -85,7 +85,7 @@ static int __init riscv_enable_runtime_services(void)
>                 efi_memory_desc_t *md;
>
>                 for_each_efi_memory_desc(md) {
> -                       int md_size = md->num_pages << EFI_PAGE_SHIFT;
> +                       unsigned long md_size = md->num_pages << EFI_PAGE_SHIFT;
>                         struct resource *res;
>
>                         if (!(md->attribute & EFI_MEMORY_SP))
> --
> 2.34.1
>
>

