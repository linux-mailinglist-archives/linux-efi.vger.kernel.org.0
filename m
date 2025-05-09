Return-Path: <linux-efi+bounces-3647-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4C5CAB0E3E
	for <lists+linux-efi@lfdr.de>; Fri,  9 May 2025 11:08:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 709713B47B4
	for <lists+linux-efi@lfdr.de>; Fri,  9 May 2025 09:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79061274FCA;
	Fri,  9 May 2025 09:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TIi+869B"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D857274666;
	Fri,  9 May 2025 09:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746781683; cv=none; b=SPcQvoS3TPxOOHk/v7mqySo3LV5kii2HJBt7Y52rTnTKa8brUw5PHh9sbQLCQu5fGYYY0gHC/bRMCeWaT+mSx0ZiwG+yowcDlLlGtx1gPe3cdB/Xz5821q32kkzOjYpZOFiQ5rhHoJ3jG/Fhi769mi4s/Xc93A0E4xuOZE3SAAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746781683; c=relaxed/simple;
	bh=+wXFTif+M/3rumavm/aTs/fXnfqu/iaBWzcA9lk9kMQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sm7v3uzsAlIh34E47wH84//Fvus2YyEDXmZm1yTvSJIxbMPwLFa8YlbbeGyNlLIt7AqXYdulJJyIP1juUrpu59f9mPBrWNIzLzZ6lNCXDKLWGKJlCi++MU4qNlVkMG3q4uu7yxro4bdMCAAtN2UHoFpLYTwQvYbfDZn/BOGx5Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TIi+869B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8221C4CEE4;
	Fri,  9 May 2025 09:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746781682;
	bh=+wXFTif+M/3rumavm/aTs/fXnfqu/iaBWzcA9lk9kMQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=TIi+869BEyHKMHe+40QI01VLvCkcKUxYe9vgstztL1gh9umrdW6gQ5MW3Dg7ekw9L
	 CrMfr3Sqf+25lzIx1AleQw7fwwAzr4hQZC9oVJGyogNdZMzVOPSkdZYXiW9OYzHxX1
	 cobya6v9C3uEugcQuPKhKNcA848+eTtptLOfSbeb1NVGl6w7VbVykTEER+1XYumqEr
	 Z2Hih7VY/9C+9N/YGIf+6NgOM6OmMBjt830faSnHPKt+N37yNRuSIUyNPFmoc8YTF0
	 R49H2A+5Hi4dfVlEZYrqhL/6XsCfPBUUoMdoOXPRjRQUom1OisuV24lTbSwBTB0s0m
	 IUnX8k1zzFvew==
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-30bfe0d2b6dso16224731fa.3;
        Fri, 09 May 2025 02:08:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWJ57L95K6qzr5LQVzBIqLw5b51ouWFBl2DlcY7Qy0UWNWC0lo/qpnk7CAIFcrdSA2JRFU8r4YmtqY=@vger.kernel.org, AJvYcCXAq6X0gacn4NMLxtUYkYxZA67j3NL6PQ8yu0zbHqkOYeTNA7vGJFAyU7BxTSRP9nqaKng1t2yBDpUf0SMx@vger.kernel.org
X-Gm-Message-State: AOJu0YzFYVqOeeTaCPMZSJbvNoL5c5vCQjq0/AAD5/4TJrPO5ZSS4cX+
	EUcJMbuRuNVe44aWy4yJMFL8iMVTZekmKZV8pJAJCzTXsLySEiIa+2VPf0Qq3o+OJDmRyC21own
	//EV3LaC8BwhkOL+qcF1+n7HhCXQ=
X-Google-Smtp-Source: AGHT+IHUfaJ4VzDPx8olPMyT7izaFqWlidBpN37tZ8on4zprI+sHJLyAeO8nQWb0t/vuvDNv2R2gyZ54f/DOzYjsL70=
X-Received: by 2002:a2e:bc86:0:b0:30a:4484:3ee1 with SMTP id
 38308e7fff4ca-326c45b2d9dmr11647651fa.23.1746781681101; Fri, 09 May 2025
 02:08:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250423090517.47049-1-bsz@amazon.de>
In-Reply-To: <20250423090517.47049-1-bsz@amazon.de>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 9 May 2025 11:07:50 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFtaf8c5cYSFL1nYgFkK1UGtfKyMU66_z_zHT_T8=7VXA@mail.gmail.com>
X-Gm-Features: ATxdqUEFns9iLM_azO5IApx679VOJKysccNbudGKnLBlD3PpVcxy4HsSZHzRGFI
Message-ID: <CAMj1kXFtaf8c5cYSFL1nYgFkK1UGtfKyMU66_z_zHT_T8=7VXA@mail.gmail.com>
Subject: Re: [PATCH] efi: Improve logging around memmap init
To: Bartosz Szczepanek <bsz@amazon.de>
Cc: nh-open-source@amazon.com, linux-efi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 23 Apr 2025 at 11:05, Bartosz Szczepanek <bsz@amazon.de> wrote:
>
> Be more informative if memremap fails, and print out physical address
> together with size. This change intends to make investigations of such
> early failures slightly easier.
>
> Signed-off-by: Bartosz Szczepanek <bsz@amazon.de>
> ---
>  drivers/firmware/efi/memmap.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>

Queued in efi/next - thanks.

> diff --git a/drivers/firmware/efi/memmap.c b/drivers/firmware/efi/memmap.c
> index 34109fd86c55..f1c04d7cfd71 100644
> --- a/drivers/firmware/efi/memmap.c
> +++ b/drivers/firmware/efi/memmap.c
> @@ -31,31 +31,32 @@
>   * Returns: zero on success, a negative error code on failure.
>   */
>  int __init __efi_memmap_init(struct efi_memory_map_data *data)
>  {
>         struct efi_memory_map map;
>         phys_addr_t phys_map;
>
>         phys_map = data->phys_map;
>
>         if (data->flags & EFI_MEMMAP_LATE)
>                 map.map = memremap(phys_map, data->size, MEMREMAP_WB);
>         else
>                 map.map = early_memremap(phys_map, data->size);
>
>         if (!map.map) {
> -               pr_err("Could not map the memory map!\n");
> +               pr_err("Could not map the memory map! phys_map=%pa, size=0x%lx\n",
> +                       &phys_map, data->size);
>                 return -ENOMEM;
>         }
>
>         map.phys_map = data->phys_map;
>         map.nr_map = data->size / data->desc_size;
>         map.map_end = map.map + data->size;
>
>         map.desc_version = data->desc_version;
>         map.desc_size = data->desc_size;
>         map.flags = data->flags;
>
>         set_bit(EFI_MEMMAP, &efi.flags);
>
>         efi.memmap = map;
>
> --
> 2.47.1
>

