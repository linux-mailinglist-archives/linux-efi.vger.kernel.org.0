Return-Path: <linux-efi+bounces-525-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6329F8534A9
	for <lists+linux-efi@lfdr.de>; Tue, 13 Feb 2024 16:31:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF4C91F22147
	for <lists+linux-efi@lfdr.de>; Tue, 13 Feb 2024 15:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DF645DF25;
	Tue, 13 Feb 2024 15:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XXT/JSwY"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7621E224D5;
	Tue, 13 Feb 2024 15:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707838272; cv=none; b=JY7J5W+NXM9DKY12JVyquq9lTQF+xD/JcelXHW8IQ1fB19OY2dbj3E18FjgrqKL4CIZ/Ne4uNOOw02abVi8QQbfH/jmT5+XipTpka5z5ZeaZQAXDNHcBCT0JBFOS64H8t7Pq912NE2O4t9WmQ/W9vvUk/jqzON/9Pjx79GYR0qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707838272; c=relaxed/simple;
	bh=r/+C0SiRxWLKFJH5sGebudN07tjJgDQUZiy0Bx6875c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MOawDTV5eKZKKR4KLno3ephCE2Q37xaPZXojUVi5coODwLFpkiwhgUwvKGK3fvoz+0cJpDr+S7No2VyROpBNe8J4AVVs3xVn6o3sewvzVSeu+ZKDG059P6G7/aFhQQmOXwf9qH1ZqxaVkPCfR537V+uVEwcjLEnlhFyPTcPyetk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XXT/JSwY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8A13C433F1;
	Tue, 13 Feb 2024 15:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707838271;
	bh=r/+C0SiRxWLKFJH5sGebudN07tjJgDQUZiy0Bx6875c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=XXT/JSwYKZ3WcbK3s9sTrDW7EzwbqPC3j5k1/P19GJe5rYm1UlsFlP7q7PfT2sgk9
	 x44CiQBeGeM8z/LR5lgm2lK33cMq/zPJV88BKL2lwc+j3FYx9YsWelMQRoPmOdPvGO
	 nwO8nFeKAwyu9bKMbEDK+ZYqw5kDYcE+aWkthQn0ohHdmMtCGkNounNjgIhY2phC4l
	 aHIO9K5p89pJcbSMDhjxooONnVgXdiO5BZt2YGP+/+Mn0l3kidZGXAUXmPvvWIZnvu
	 UcAlxkRLTbDvgfimTQyQ/koaOXs2ZrMpjhnpSoOTni8c10sMC7zsdz/v/40kk9i68N
	 KpDlgwyMvqfIg==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-51181d8f52fso1347590e87.3;
        Tue, 13 Feb 2024 07:31:11 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXmh0Uuh8R9qYh6ShwJHuztoIJ4nQgdPtSjyzPsqpzsgjv88BuvfzPDbUsnZltD1IAEoH4IgYZlU4EBC8/YhH9kYzplgmFSd+eoNSNT7eYlkIbf4oHw6PM5uTH0MgqIAcHWib6Wchgw
X-Gm-Message-State: AOJu0YycL2LWHKUhgKjzwy2TFFWvqD/K8osE1jU3q1gy8bpTABU3SPSQ
	IyKSYcLmtQBEfgcKJanlPxHluHDHNFX19yaT47uuacd6Xxf+1vrzUrGcqeB9Ycly8vQNTc+827X
	ANpNIsVhjAaRt4EEEU4o0DHZUCrA=
X-Google-Smtp-Source: AGHT+IHQQczxxFJV1oZMs4WrcBiuVuJaftM4fY+IdGHjoagL08HzQXVj3V9Ba3iDUTzPRDcyQ6eXfD6Oi34gn989GIQ=
X-Received: by 2002:a05:6512:3d11:b0:511:5237:a357 with SMTP id
 d17-20020a0565123d1100b005115237a357mr8197638lfv.48.1707838270132; Tue, 13
 Feb 2024 07:31:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212112454.1213449-1-arnd@kernel.org>
In-Reply-To: <20240212112454.1213449-1-arnd@kernel.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 13 Feb 2024 16:30:58 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEVJai4NF3P4kpVPNrSLv5ui5ayEpq05WWk=-hPEBHb+g@mail.gmail.com>
Message-ID: <CAMj1kXEVJai4NF3P4kpVPNrSLv5ui5ayEpq05WWk=-hPEBHb+g@mail.gmail.com>
Subject: Re: [PATCH] efi/capsule-loader: fix incorrect allocation size
To: Arnd Bergmann <arnd@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Arnd Bergmann <arnd@arndb.de>, linux-efi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 12 Feb 2024 at 12:25, Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> gcc-14 notices that the allocation with sizeof(void) on 32-bit architectures
> is not enough for a 64-bit phys_addr_t:
>
> drivers/firmware/efi/capsule-loader.c: In function 'efi_capsule_open':
> drivers/firmware/efi/capsule-loader.c:295:24: error: allocation of insufficient size '4' for type 'phys_addr_t' {aka 'long long unsigned int'} with size '8' [-Werror=alloc-size]
>   295 |         cap_info->phys = kzalloc(sizeof(void *), GFP_KERNEL);
>       |                        ^
>
> Use the correct type instead here.
>
> Fixes: f24c4d478013 ("efi/capsule-loader: Reinstate virtual capsule mapping")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/firmware/efi/capsule-loader.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/firmware/efi/capsule-loader.c b/drivers/firmware/efi/capsule-loader.c
> index 3e8d4b51a814..97bafb5f7038 100644
> --- a/drivers/firmware/efi/capsule-loader.c
> +++ b/drivers/firmware/efi/capsule-loader.c
> @@ -292,7 +292,7 @@ static int efi_capsule_open(struct inode *inode, struct file *file)
>                 return -ENOMEM;
>         }
>
> -       cap_info->phys = kzalloc(sizeof(void *), GFP_KERNEL);
> +       cap_info->phys = kzalloc(sizeof(phys_addr_t), GFP_KERNEL);
>         if (!cap_info->phys) {
>                 kfree(cap_info->pages);
>                 kfree(cap_info);

Thanks, queued as a fix.

