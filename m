Return-Path: <linux-efi+bounces-3810-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FDF6ACBAF8
	for <lists+linux-efi@lfdr.de>; Mon,  2 Jun 2025 20:13:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D495C1896086
	for <lists+linux-efi@lfdr.de>; Mon,  2 Jun 2025 18:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEB72227E97;
	Mon,  2 Jun 2025 18:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e/mwN56V"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966ED221DB3;
	Mon,  2 Jun 2025 18:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748888005; cv=none; b=DTomG3oH5EC31HdNpLSSp9xATFqX3vn0ocOCnHXPdRYMx115l3d/rOYBYFyqJqgsglVJKQdFEzIoL4gZSiZ/xhMd4R6/ORTxpkmF20EDDCK+O+2VqwdGDP1ypMO1zTcGX7JvYAJEMTzGVRd9XgIURhLGCMUr8NgZ43mu0Xe8Hy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748888005; c=relaxed/simple;
	bh=KNUq+XENitwkiKPVRLf55IWTEjyXC5YCoKCwRyMRwbE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yme0+F5qEsG8Wn4MXczA/YYb2/SKVngPqOKyFctkzPbZaUBGYcE/h8GuqXQEvYr/c4sp0gZBRC4bQYljtHgREWiwUnXRVkx+0p8fyF9qMVICHz7tYjOinaZKhV5bGER7Zxe2r0mpYzL6KUq5Wo90YXeQS5grkIjbOTsHvO7fjyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e/mwN56V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C71BC4CEEE;
	Mon,  2 Jun 2025 18:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748888005;
	bh=KNUq+XENitwkiKPVRLf55IWTEjyXC5YCoKCwRyMRwbE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=e/mwN56Vvgyw56epzkQL0WnN70mxuZqqKXhmcCJxlRNCmH+ydNulzf2iDvFVVPlze
	 034JEdOWt7Q7+eZCagfJmv2gs34pVeJeNy1PaWn/zDu9DA6oNm+A80YEA/OHX+CBEA
	 q5Haw+NV0e9Urk4/kfhLd6v3bU8YxNRcSj6mQyW0gDFGSq9RwVF1YZbtXQp/zqS+om
	 6mOAuiyygmJS8NClOAIH/ubBgO7Aji8uNQ+rCp0KteH5RWOn9PJyEqa1pKOAMZMyIm
	 OVAxCPlKf6GduyBHsC7jaydoBqgqD8dEdsGMfdZsejgRUsm/+82wuZlU5wSAbxqkm8
	 Y+VM8NBwU1pDg==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5533a86a134so4170198e87.3;
        Mon, 02 Jun 2025 11:13:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX8BuGNuvztrLgLwo/V4qblk4y6DepC1u8zmwBNCPqRyS/yLQhYcwHQDrfgGIQTQzWDrkMDqLW5nHA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhXbZ72F+vTCuFiJZmBlGiFhL44wMV/82fP3YsCgMlYRazypLv
	EiQLtIwAk2zyf/Bkdg7LZ/dLI/BVl/+0rbnffoi6U3mFRCNVYOpbOEBkBHWvC+ayuuGTGvXRJ8b
	78/yV1r4JWF8wz0mSZerwFSk2FmN2NHY=
X-Google-Smtp-Source: AGHT+IHi7iBGUqXzV+MY1M9GP5UG+TmmLh2F0LQuVAiJvmsFgj335SmtJTIHS3sSnFnUuXw+OJmOU4Q8vHjucdFME+M=
X-Received: by 2002:a05:6512:33d2:b0:553:2480:2309 with SMTP id
 2adb3069b0e04-5533d13e770mr4464635e87.3.1748888003523; Mon, 02 Jun 2025
 11:13:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250602181143.528789-1-masahiroy@kernel.org>
In-Reply-To: <20250602181143.528789-1-masahiroy@kernel.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 2 Jun 2025 20:13:12 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHEkHMPMJwsMc8WAmsMhJn3ynHqJku=jeKQOT0T_aNqNA@mail.gmail.com>
X-Gm-Features: AX0GCFuxHNzuPMmHD59NGR6naNpMTrB-gY8V6VYsoJ5iz52_YKFm5Xibs-JJa9I
Message-ID: <CAMj1kXHEkHMPMJwsMc8WAmsMhJn3ynHqJku=jeKQOT0T_aNqNA@mail.gmail.com>
Subject: Re: [PATCH] efi/libstub: use 'targets' instead of extra-y in Makefile
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 2 Jun 2025 at 20:11, Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> These objects are built as prerequisites of %.stub.o files.
> There is no need to use extra-y, which is planned for deprecation.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Acked-by: Ard Biesheuvel <ardb@kernel.org>

I misunderstood what extra-y was for - note that
arch/arm64/kernel/pi/Makefile has the same issue.

> ---
>
>  drivers/firmware/efi/libstub/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
> index d23a1b9fed75..5ce9f2098b99 100644
> --- a/drivers/firmware/efi/libstub/Makefile
> +++ b/drivers/firmware/efi/libstub/Makefile
> @@ -102,7 +102,7 @@ lib-$(CONFIG_EFI_ZBOOT)             += zboot.o $(zboot-obj-y)
>
>  lib-$(CONFIG_UNACCEPTED_MEMORY) += unaccepted_memory.o bitmap.o find.o
>
> -extra-y                                := $(lib-y)
> +targets                                := $(lib-y)
>  lib-y                          := $(patsubst %.o,%.stub.o,$(lib-y))
>
>  # Even when -mbranch-protection=none is set, Clang will generate a
> --
> 2.43.0
>

