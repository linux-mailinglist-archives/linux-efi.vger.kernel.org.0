Return-Path: <linux-efi+bounces-2810-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B6D6A3EF8B
	for <lists+linux-efi@lfdr.de>; Fri, 21 Feb 2025 10:08:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A881919C6334
	for <lists+linux-efi@lfdr.de>; Fri, 21 Feb 2025 09:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5A5B1D7E4C;
	Fri, 21 Feb 2025 09:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EkEj/k9h"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE91202F68;
	Fri, 21 Feb 2025 09:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740128729; cv=none; b=M/AiSQ5iYwj85DzMNPtkpr7dzi8FBI9+GG1niqOlMmWWgm+svuqT7JeP+oHGaPrSfI5+KhYK65sUBO1wGCkol64kd9Bn2s2q7qQjhkj5nqjCMbu0D/sjwESkH/OrvVPPbL+Idgw1zSnHJ41H7Yk76Dh9jcjK5Y+wHcRoxgMcSmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740128729; c=relaxed/simple;
	bh=n4bRGNxDN26lyonAAX2Cqmt70QP0t6GFVCF8d+MlfWs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N+lw4LMYaNGEqoGJ2GwRjc0Em8dav4oMWAjmxySLm7gS5H9fhu5B1An0cyTSpyF8jP/VdZD4/DF15leNlQXlXVj24WRfHZ3WLGD54IGXuVq9da4WbE5ib9oYRkVI/91Cz0uYN9QWBm6SKQD+5A+ZMintE3lXC6y3+kkrfBoaCJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EkEj/k9h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE4A4C4CED6;
	Fri, 21 Feb 2025 09:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740128728;
	bh=n4bRGNxDN26lyonAAX2Cqmt70QP0t6GFVCF8d+MlfWs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=EkEj/k9h3IEdxhWdffZBn0DlFynQ0JULuX8ruZGFquv/BGQayWBt+/K32Iyi6LzuY
	 e5dHqSDIWa6jnv7jrRh42e/VIfVJlg66SMzm6FhzTzLuNVLL5iHC4v/zw8SgGM9VQI
	 BHXwShBPnPJrWKPitTEoQdT4AQn5EP5IRz0M7uKhvq3XXeA3nw7/eT4uXVZxNcQdat
	 SEYqgurTeT5vMvaMkW3pDj60Y4WEx5Kne+JAzQxiozYWjjqYQAb/8nKmI2xSlnNqZC
	 N9mP/rC+eGe+BdPsNQo27VYzv6lU1pezSEI7xpoo6VS4u4xZVZt/QUTT+D2YHmgGQ4
	 HFWSTtQ5BE32A==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5452c29bacfso2045828e87.3;
        Fri, 21 Feb 2025 01:05:28 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXw1WX6VZQlUQu0Fc4pg9+PWNekljr/vIGrIbbwW8fRP6x4Oz+131oYUfTKRcWLrF74oTm1dLLGCRy57Xs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDJGys9+CgEvRERH4P3kIgVCTNuikl+P9aiVvPTXyN7DDf22dx
	Q7yEk2EVTtiLeRve/I6OSYmp/3Z1u2HJ76zhqIcqvYRHikKdC1P540IvwXLMOr8qE6zww5b4K7V
	rMpKGNdH7bocGoFZrukNJZvG7vvI=
X-Google-Smtp-Source: AGHT+IECqsANGNMcVTNA/AzQxsb3KxDLT4R1LPxSCc9QnJ/pSsL/Yh+PrpKleSevVUhUornlaB/5EXQnyptPWeQo0Dc=
X-Received: by 2002:a05:6512:1189:b0:545:10cf:3468 with SMTP id
 2adb3069b0e04-548392685a7mr789242e87.37.1740128727263; Fri, 21 Feb 2025
 01:05:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250221081242.1411553-1-patrick.rudolph@9elements.com>
In-Reply-To: <20250221081242.1411553-1-patrick.rudolph@9elements.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 21 Feb 2025 10:05:15 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEcd33qWJHDxwOun=EF4mDLHRw9YtiPKUaeMAmsbpfLYQ@mail.gmail.com>
X-Gm-Features: AWEUYZnpce6BpEnKNwLRLDmazylhtSYCyqekWrYbrgJhqvX5y4lYR1ABZVSmlQg
Message-ID: <CAMj1kXEcd33qWJHDxwOun=EF4mDLHRw9YtiPKUaeMAmsbpfLYQ@mail.gmail.com>
Subject: Re: [PATCH] drivers/firmware/efi: Fix cper_ia_proc_ctx alignment
To: Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 21 Feb 2025 at 09:13, Patrick Rudolph
<patrick.rudolph@9elements.com> wrote:
>
> According to the UEFI Common Platform Error Record appendix, the
> IA32/X64 Processor Context Information Structure is a variable length
> structure, but "is padded with zeros if the size is not a multiple
> of 16 bytes".
>
> Currently this isn't honoured, causing all but the first structure to
> be garbage when printed. Thus align the size to be a multiple of 16.
>
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> ---
>  drivers/firmware/efi/cper-x86.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/firmware/efi/cper-x86.c b/drivers/firmware/efi/cper-x86.c
> index 438ed9eff6d0..3949d7b5e808 100644
> --- a/drivers/firmware/efi/cper-x86.c
> +++ b/drivers/firmware/efi/cper-x86.c
> @@ -325,7 +325,7 @@ void cper_print_proc_ia(const char *pfx, const struct cper_sec_proc_ia *proc)
>
>         ctx_info = (struct cper_ia_proc_ctx *)err_info;
>         for (i = 0; i < VALID_PROC_CXT_INFO_NUM(proc->validation_bits); i++) {
> -               int size = sizeof(*ctx_info) + ctx_info->reg_arr_size;
> +               int size = ALIGN(sizeof(*ctx_info) + ctx_info->reg_arr_size, 16);
>                 int groupsize = 4;
>
>                 printk("%sContext Information Structure %d:\n", pfx, i);

Thanks for the patch. It seems ARM suffers from the same issue, mind
fixing that too?

