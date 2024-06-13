Return-Path: <linux-efi+bounces-1215-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 11AF4907840
	for <lists+linux-efi@lfdr.de>; Thu, 13 Jun 2024 18:26:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8639CB2396D
	for <lists+linux-efi@lfdr.de>; Thu, 13 Jun 2024 16:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 263AA145FFD;
	Thu, 13 Jun 2024 16:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K6qjxhOj"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2AC2381B0;
	Thu, 13 Jun 2024 16:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718295960; cv=none; b=X+tatzKgEhchV18uOMCYVU+rVk3tNgFSYYXrNVS2OEe6U9s6wdLSkhsVLjPj2WxX8aFavhTs0FlOGNjihfRElzNzHpW3oOYgqfzXhF1D7xh+KM8uGns+EuHUnNTjyqh5SJsqOXS+S5K+PDhUq5F0sB9pUSrfkYxtYUXqf5XkqT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718295960; c=relaxed/simple;
	bh=PGv+Yopc7XLHNBcbDN2+JMRLeaSqYKy5SzRpJAxLlsc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nTl3CHMmKwYF4F3zup8RoH7eOPNvHuSrwRR4qRLHIZcTPnUxkc0A9ha/Eqym60OOJgOA4kA4kSnp63qawvHz0IHydS3a8s1EmYStLFsXzGEBkgQXqmNVurR68uiLWpZt0/yo6TK1UcxmEeTvPCLqoS1RVpsRd383/sLPMn7lRe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K6qjxhOj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF20CC4AF1D;
	Thu, 13 Jun 2024 16:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718295959;
	bh=PGv+Yopc7XLHNBcbDN2+JMRLeaSqYKy5SzRpJAxLlsc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=K6qjxhOjkSoyi6cghmlsIyEt4KaCiv81iGTSX7mA/Yjv0gtZe7JU1P9Oi8QUB5yNK
	 DfxOPyKSdZrvFUyMwkzTAQt2ucgVjqkavXFfpuOW2Ks5cujJGA4qy7HEvtASD30DSm
	 DPfgsJA3BvUOxr7ZqTKyfO9Gs01B8DglvYqbd0zt/y4RJIbsriNNP0MT18hrxBsGxc
	 uR5rzbl1jurwk2Aqa34eo4a99YGUNv8eTJ7xEINTnHOlXHHtgPgE9n1WTnFVBjpxpq
	 8Wj0O9LMGPlnHE9XM9DMNV3Nh2ZJRYw0+Qv3FetQHMwzr1qvMSv80WNtRLl263xaq9
	 OtT8OgK/6TUmw==
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2ebeefb9a7fso12275951fa.0;
        Thu, 13 Jun 2024 09:25:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUVRe+3d6WG533EEQSUipemDpxPV/1gSYZLwKKbFTRzpj71i6ifIezeridwvk5cWLa1xdLD0rWhCvBdP973XegBWh0D93uRyEZ6SJh5kJw5cYvT80TWGQDKAf+Dpgn3BuXdjjF5pYH8
X-Gm-Message-State: AOJu0Yw27sZJ/mLlY6dz91EVilNwQ4ZjSvQin4MJS2c3/p1loLCEqKpf
	lYXJqFnKtF/JaYxvKTRHdy4l8THiZEz8r5qGnLNRQCzQFX/xV6EPfifFOTjbpsCEOiUloWLrQ7I
	DQcYWRv30M3P0CNLNGG81cxMlDoU=
X-Google-Smtp-Source: AGHT+IFD8ZmkKw599RVKsqzV6/cQ1wsO8bqVKWGn3VFu4rQwLis1kNid+1+GB4cwCB7YQ7l5w2smXcjLC+iQVu7EeQU=
X-Received: by 2002:a2e:9056:0:b0:2ea:eaf1:a18 with SMTP id
 38308e7fff4ca-2ec0e60e0ebmr1915861fa.47.1718295958152; Thu, 13 Jun 2024
 09:25:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240613162031.142224-1-longman@redhat.com>
In-Reply-To: <20240613162031.142224-1-longman@redhat.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 13 Jun 2024 18:25:46 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGpbgrHo98RcpfVLc1zKE7D+isL5wmvTLA5cDvNQhHc=Q@mail.gmail.com>
Message-ID: <CAMj1kXGpbgrHo98RcpfVLc1zKE7D+isL5wmvTLA5cDvNQhHc=Q@mail.gmail.com>
Subject: Re: [PATCH] arm64/efi: Fix kmemleak false positive in arm64_efi_rt_init()
To: Waiman Long <longman@redhat.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, linux-efi@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 13 Jun 2024 at 18:21, Waiman Long <longman@redhat.com> wrote:
>
> The kmemleak code sometimes complains about the following leak:
>
> unreferenced object 0xffff8000102e0000 (size 32768):
>   comm "swapper/0", pid 1, jiffies 4294937323 (age 71.240s)
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<00000000db9a88a3>] __vmalloc_node_range+0x324/0x450
>     [<00000000ff8903a4>] __vmalloc_node+0x90/0xd0
>     [<000000001a06634f>] arm64_efi_rt_init+0x64/0xdc
>     [<0000000007826a8d>] do_one_initcall+0x178/0xac0
>     [<0000000054a87017>] do_initcalls+0x190/0x1d0
>     [<00000000308092d0>] kernel_init_freeable+0x2c0/0x2f0
>     [<000000003e7b99e0>] kernel_init+0x28/0x14c
>     [<000000002246af5b>] ret_from_fork+0x10/0x20
>
> The memory object in this case is for efi_rt_stack_top and is allocated
> in an initcall. So this is certainly a false positive. Mark the object
> as not a leak to quash it.
>
> Signed-off-by: Waiman Long <longman@redhat.com>

Acked-by: Ard Biesheuvel <ardb@kernel.org>

I'll take this as a fix via the EFI tree.

Thanks,

> ---
>  arch/arm64/kernel/efi.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/arm64/kernel/efi.c b/arch/arm64/kernel/efi.c
> index 4a92096db34e..712718aed5dd 100644
> --- a/arch/arm64/kernel/efi.c
> +++ b/arch/arm64/kernel/efi.c
> @@ -9,6 +9,7 @@
>
>  #include <linux/efi.h>
>  #include <linux/init.h>
> +#include <linux/kmemleak.h>
>  #include <linux/screen_info.h>
>  #include <linux/vmalloc.h>
>
> @@ -213,6 +214,7 @@ l:  if (!p) {
>                 return -ENOMEM;
>         }
>
> +       kmemleak_not_leak(p);
>         efi_rt_stack_top = p + THREAD_SIZE;
>         return 0;
>  }
> --
> 2.39.3
>
>

