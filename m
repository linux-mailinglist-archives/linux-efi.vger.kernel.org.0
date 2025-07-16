Return-Path: <linux-efi+bounces-4352-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E52FB06AAA
	for <lists+linux-efi@lfdr.de>; Wed, 16 Jul 2025 02:41:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EC721890FBA
	for <lists+linux-efi@lfdr.de>; Wed, 16 Jul 2025 00:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E1107B3E1;
	Wed, 16 Jul 2025 00:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="laBd/cV3"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1760D481B1;
	Wed, 16 Jul 2025 00:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752626500; cv=none; b=YNxHL7tvFtgi56Hd9MgExnXfUMKUNiZWdFnUDyh8WgEAA7IywIQE/owoLdPAGSiTgf3CEbvmcaACojmZbLOWDZljpjeDM+AxNz04ddgJUcSpf+DbDNDjqmGm+VsrwG7aCfsaSRVwjTH7+ckB+itaTpbEicBw/X2P+7fWEHdJAxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752626500; c=relaxed/simple;
	bh=Z7l3jkmEP6QkwUklUJF2NCEsiSVVVNx8+PAgOHY1PbY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qUTMifaABTLNFcnu9Zy/Mv6e9yjW3mu6dEcYsE2QspdlTsSstddLZUB2fa82LQ+dwMQFPoI4vRYeRiLo4ou58wR3cIUiL6oXhgc/egUD/68VsnVkVEr34EcC7/BAMM4KPWnENhTXTffWvpTy7cYE8iHIBCMo8uDdjPe8RF4oNdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=laBd/cV3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90533C4AF0B;
	Wed, 16 Jul 2025 00:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752626497;
	bh=Z7l3jkmEP6QkwUklUJF2NCEsiSVVVNx8+PAgOHY1PbY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=laBd/cV3Y/Oyw2b5FDbeN12tuVadd9vNPzWtPpzT8KohZEMQD2eIlXqtn52++cp7z
	 SVo4oz/bkiRPl8ULjMzi0RJoV/CQFB5ZFSvePWGLyl6AzgRGKbaqX2/kze9o5QCwHn
	 kbd2rHv8tCx0VhGhYefxS1DOx+/3ID6MfhWT3rz9evaBnr04PiyTZGfi7NmwsdN3OW
	 p3GsUKkvR8ftjozanv5UzXBcjTJ/b6B6F30M7ur7oU3xtrKr1OAKm8L99zwVZ3S906
	 8I4yHLDR4m12HIPpcyKKy7KqN5MAtgwOT1L25KoeBlL5HQYg5rkSQoH6DUwp7ah2my
	 XV5U38X/Ml22Q==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-553c31542b1so5700789e87.2;
        Tue, 15 Jul 2025 17:41:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVhGWZhEbhHEjZBuY/jnfF1JkRenCXVeWdhiZCFRRdN+UHP03aDcZ4npCH13HRFmGNhEn/PUFJZOX0=@vger.kernel.org, AJvYcCW0pzraAu1Y2LRUGqVQci6TSV0ozHtX/4OC0YSyfL/QEhCVa/GYL/dkAKObovc1nx0xX1LhW+Xsq4VAh2t3@vger.kernel.org
X-Gm-Message-State: AOJu0YxrwHW2XsGoUjA8DfcCpdw29iJbury/M8OkH7CWyLLFoRPu4lxF
	Pa++D2SewGZwTSJ7X4v7mQXOjwLp+09Q9lltWy7Ul6SNSiV7+KgzNDeQ3s+GQxYuysWslu0fWTY
	eFTsf3iCuUhjATUy1Qp7qGnDUz7k1HY4=
X-Google-Smtp-Source: AGHT+IEBfD67PV7t1chxN96XoCwe1pI7x2lRLBhmLUXFsJJ1yjCwL+3+zVikKM9M30SJeq+2EdHBr2llWzJRcIDA8nE=
X-Received: by 2002:a05:6512:118f:b0:553:37e7:867b with SMTP id
 2adb3069b0e04-55a23f5660bmr283569e87.31.1752626495925; Tue, 15 Jul 2025
 17:41:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250715-kmemleak_efi-v1-1-c07e68c76ae8@debian.org>
In-Reply-To: <20250715-kmemleak_efi-v1-1-c07e68c76ae8@debian.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 16 Jul 2025 10:41:24 +1000
X-Gmail-Original-Message-ID: <CAMj1kXHJpRioZD7aUJnkMLWkiTmQ_Nr6MNcSYR0adeLdjf5BrA@mail.gmail.com>
X-Gm-Features: Ac12FXzXXfY5Gpu7WIHyasUCl-eF3Y6YMD9socEIt8LfSddUXnMWxEI2pb3mxno
Message-ID: <CAMj1kXHJpRioZD7aUJnkMLWkiTmQ_Nr6MNcSYR0adeLdjf5BrA@mail.gmail.com>
Subject: Re: [PATCH] efivarfs: Suppress false-positive kmemleak warning for sfi
To: Breno Leitao <leitao@debian.org>
Cc: Jeremy Kerr <jk@ozlabs.org>, linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 15 Jul 2025 at 19:31, Breno Leitao <leitao@debian.org> wrote:
>
> When kmemleak is enabled, it incorrectly reports the sfi structure
> allocated during efivarfs_init_fs_context() as leaked:
>
>     unreferenced object 0xffff888146250b80 (size 64):
>     __kmalloc_cache_noprof
>     efivarfs_init_fs_context
>     ...
>
> On module unload, this object is freed in efivarfs_kill_sb(), confirming
> no actual leak. Also, kfree(sfi) is called at efivarfs_kill_sb(). I am
> not able to explain why kmemleak detected it as a leak. To silence this
> false-positive, mark the sfi allocation as ignored by kmemleak right
> after allocation.
>
> This ensures clearer leak diagnostics for this allocation path.
>

Can you provide a reproducer? x86 defconfig with kmemleak enabled does
not show this behavior.

In any case, just silencing the diagnostic is not a great way to deal
with this imho.


> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  fs/efivarfs/super.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
> index c900d98bf4945..5f867ad2005ae 100644
> --- a/fs/efivarfs/super.c
> +++ b/fs/efivarfs/super.c
> @@ -19,6 +19,7 @@
>  #include <linux/notifier.h>
>  #include <linux/printk.h>
>  #include <linux/namei.h>
> +#include <linux/kmemleak.h>
>
>  #include "internal.h"
>  #include "../internal.h"
> @@ -498,6 +499,7 @@ static int efivarfs_init_fs_context(struct fs_context *fc)
>         if (!sfi)
>                 return -ENOMEM;
>
> +       kmemleak_ignore(sfi);
>         sfi->mount_opts.uid = GLOBAL_ROOT_UID;
>         sfi->mount_opts.gid = GLOBAL_ROOT_GID;
>
>
> ---
> base-commit: 8c2e52ebbe885c7eeaabd3b7ddcdc1246fc400d2
> change-id: 20250714-kmemleak_efi-bedfe48a304d
>
> Best regards,
> --
> Breno Leitao <leitao@debian.org>
>
>

