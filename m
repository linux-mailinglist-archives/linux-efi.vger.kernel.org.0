Return-Path: <linux-efi+bounces-1000-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C6628B5E03
	for <lists+linux-efi@lfdr.de>; Mon, 29 Apr 2024 17:48:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C29631C2124B
	for <lists+linux-efi@lfdr.de>; Mon, 29 Apr 2024 15:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B382382883;
	Mon, 29 Apr 2024 15:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lMc9yYED"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C0282881;
	Mon, 29 Apr 2024 15:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714405698; cv=none; b=gCshtltMs7aQygQ8UBthwvgXvEm+o/Gt5k4AHszLa+uRMB0ydwixdoNbVvfKAwvNu0oegvNMHujqH/r8RIRpwwpaR6j90KePtxlq3xoDLSRIf5/RuyrWmRWxe4Rf95p2MY+FSeb+K10bVt0a1JTdn95n1ff7njCF9J8MBv7TuBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714405698; c=relaxed/simple;
	bh=q0TrEuqJ399P2tU46vjogSsElHWc/nM7/9Z+Al4Ihls=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OBI0cy5evpflUZidOkyAmvjxuksL4qTgu+1nC5mycEJrnwxhaqnP50Yk4pBD8KIHGbn2qeHYFsdcbfP+kSV05gS4nrvPko2fwskoXXOb6WtLG/hGngcnAfT5dwEexLjp/7HhANd3hI3F/ZVZx7v0AuT4hZmx2Ar+pFXNg7qSfbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lMc9yYED; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13401C113CD;
	Mon, 29 Apr 2024 15:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714405698;
	bh=q0TrEuqJ399P2tU46vjogSsElHWc/nM7/9Z+Al4Ihls=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=lMc9yYEDyzeRZOJ1DRUT7SFpqY0LFuNwm2GRW2x2+4sUM7hTHv2OuNtKaNnQRJKHJ
	 ZQxj5mkTm8xhpjAE+gbLHw4eaTyF58ajvnGBOcHEY+04zix7O+IFSlWCa7RG2grPXU
	 bASVDmSzzNxqEKnUWhe66Lv/D8jUNNmhOiHs810CbbJYDiLAXDh0NQuPKM3gIUiJjE
	 NWqBY/ffZIk/VT1uhSMNEOSDWi3Ke7G+hILanka25TL5nSmc5g4JI4GJNeoNpnRn5c
	 qfDacGm6CMtmvyOq8M0a3yxpeZVKBongaytfhWthBPy24zkIx15HjVN+Ir57f7dppL
	 Kbpvz+lYzGXRA==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-51ca95db667so4074055e87.0;
        Mon, 29 Apr 2024 08:48:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUP5nZVHWN9lHtDCg/dvclg1HKyxFE0UaWtTRUgDd2NBhycQsO5z62Ihmv5CI2f2TtheRsWcmuuuBVGddMY56gaPZ0c+OSyItqo6bk5OXKy+9kEHV/JwCjWnzNJ1jyJoSRLRVkE5IqHOKJiqZs6/qwq+TeSWPHGFgadePtRIwfq
X-Gm-Message-State: AOJu0YyOvLxrGORjvkqf2N7jeQpWYMOmbqEA5ygfnVW+jZAFptY2hV/p
	Sfb3pLX+jRn8H2GD7O04kp0DS8/p4KNwiWUl5XGVPX0jKBDi42iyYhUklN4KEJ3R/Vtjw9160UT
	aRrMYFY7/B07g2vZBoxx42xAGv0k=
X-Google-Smtp-Source: AGHT+IH8dW+HR1/IwDDX3dJknVDKeoWFxn3QWuqcOlBwnDTa15PNjBagiz2MJ/zAfJQ1b/bGC3FTypm4Ztu41t9o6iE=
X-Received: by 2002:a05:6512:781:b0:51a:f31f:fc6e with SMTP id
 x1-20020a056512078100b0051af31ffc6emr7462063lfr.14.1714405696431; Mon, 29 Apr
 2024 08:48:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240423135928.1200-1-hagarhem@amazon.com>
In-Reply-To: <20240423135928.1200-1-hagarhem@amazon.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 29 Apr 2024 17:48:05 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHiPcgC7-kXToivcbfyHe9g3Cg6__TFWhHYRUcOJ8hy1g@mail.gmail.com>
Message-ID: <CAMj1kXHiPcgC7-kXToivcbfyHe9g3Cg6__TFWhHYRUcOJ8hy1g@mail.gmail.com>
Subject: Re: [PATCH v2] efi: libstub: only free priv.runtime_map when allocated
To: Hagar Hemdan <hagarhem@amazon.com>
Cc: Maximilian Heyne <mheyne@amazon.de>, Pratyush Yadav <ptyadav@amazon.de>, 
	Norbert Manthey <nmanthey@amazon.de>, stable@vger.kernel.org, linux-efi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 23 Apr 2024 at 16:00, Hagar Hemdan <hagarhem@amazon.com> wrote:
>
> priv.runtime_map is only allocated when efi_novamap is not set.
> Otherwise, it is an uninitialized value.
> In the error path, it is freed unconditionally.
> Avoid passing an uninitialized value to free_pool.
> Free priv.runtime_map only when it was allocated.
>
> This bug was discovered and resolved using Coverity Static Analysis
> Security Testing (SAST) by Synopsys, Inc.
>
> Fixes: f80d26043af9 ("efi: libstub: avoid efi_get_memory_map() for allocating the virt map")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hagar Hemdan <hagarhem@amazon.com>
> ---
> v2: added Cc stable tag to the commit message as requested by kernel
> test robot.
> ---
>  drivers/firmware/efi/libstub/fdt.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>

Queued up in efi/next, thanks.

> diff --git a/drivers/firmware/efi/libstub/fdt.c b/drivers/firmware/efi/libstub/fdt.c
> index 70e9789ff9de..6a337f1f8787 100644
> --- a/drivers/firmware/efi/libstub/fdt.c
> +++ b/drivers/firmware/efi/libstub/fdt.c
> @@ -335,8 +335,8 @@ efi_status_t allocate_new_fdt_and_exit_boot(void *handle,
>
>  fail:
>         efi_free(fdt_size, fdt_addr);
> -
> -       efi_bs_call(free_pool, priv.runtime_map);
> +       if (!efi_novamap)
> +               efi_bs_call(free_pool, priv.runtime_map);
>
>         return EFI_LOAD_ERROR;
>  }
> --
> 2.40.1
>

