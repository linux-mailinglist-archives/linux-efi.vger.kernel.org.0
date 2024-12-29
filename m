Return-Path: <linux-efi+bounces-2490-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D93A99FE02B
	for <lists+linux-efi@lfdr.de>; Sun, 29 Dec 2024 19:22:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8EE7B7A149F
	for <lists+linux-efi@lfdr.de>; Sun, 29 Dec 2024 18:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E24BE1993B9;
	Sun, 29 Dec 2024 18:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HEQNjUsr"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA9FE1993A3;
	Sun, 29 Dec 2024 18:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735496540; cv=none; b=hy1GOX8xr0KRbbrH/qoZUMCwscZ6DEHnD7r/PJCaLRiLiN6Z7HkpDKWvOi+94WvkzWM4FsXcwW8AMSZY2FXpAqXHwFWKrAWQAXAkMjuHWzgt7QD++o6naXSXKSCOgKIVzhoudmHyvhCj0+nqJFWgDm+fUDnepJ70AIje6763kS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735496540; c=relaxed/simple;
	bh=IwmVD/pfn9Z6ZEv5gsx6bjYprTjnRWG6n0XEBSo0xVc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IhulkFGS11Th3v8Mxa+3NXYvkdSR9l/cobvdFSg95SyGjRssco5lY2rG5/7aTrbbPHP3HMKJekbHAT6Lv48B0MnzWQnET91p1M5Eu5+iFyJ7WMUFsNwva2KvvqsRKcLXeIkWAvy7j+/9VZG00dXzgFz0EmOs3I3VeOoTc4s0+lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HEQNjUsr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51B79C4CEDC;
	Sun, 29 Dec 2024 18:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735496540;
	bh=IwmVD/pfn9Z6ZEv5gsx6bjYprTjnRWG6n0XEBSo0xVc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=HEQNjUsrs1I6THoFy3I6hAcv7MaW31kuXKo8Fa8BqNGi+Qg/zTtN7LV/5PykGyHXs
	 QXOE+rK++3dLxLwQ0it0dngw62neDOhxo3iehSJXMhxOA2/H76Wxj4e1fh1nWkhq+9
	 587914WMkrMSsBY5mTTlfHVseMaVkihYGD+CIuZkAn7qjRpJyUw0Wz8edWuTiJxE7m
	 BfDpzt6CZS3jRzjIewOR8rTiZHukXE6Gmp1LwGpEXslGBCp3uKVv5AGG2KZvHPqibk
	 xK/nd94GrvNy23shNYXsUHlWBj4JGy/3SuBhPO3W2QEhW/ulZFOdX0KaPm9ZAspH4a
	 YEorvWkAoj9fA==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-53e3a5fa6aaso10994781e87.0;
        Sun, 29 Dec 2024 10:22:20 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUBZnaOlYfRSfggNdkjK3FWtE/4LpL8mngKsOYktOVo8Ld1zXHwqRLJVfzrI8Szq6WSHJCFX+Rm+Wk=@vger.kernel.org, AJvYcCWCKFZQmA6S8rsGDJgzaSsr9v7uLUvkPKkWlNG1VpFflCizZ1BOA4hWIP1fUXkt2NfvnMKuZkLcFyYHeLiS@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/eVsMNvctSXbGVa3AKxJastxh8ol41zbEhmjvY6sCevcIWSjM
	g9MiJbRZ3a+lyiRH+MhhcegimX/uOvGFXqUvE3qcN5IM0UWqXgtgYf2n8jVchHGC9/idxORcgRZ
	bo6RpH36glDFtfvNhMcL/EJWREaw=
X-Google-Smtp-Source: AGHT+IGnKtK44Z8ts7r2aAQuHAOIL71MBqc2eTrIwyruWHtIw4H40g5sgERV9zjFWPm61x849rkHfkehEfdG973s9Ps=
X-Received: by 2002:a05:6512:b19:b0:541:1c5f:bf86 with SMTP id
 2adb3069b0e04-5422946ee2fmr10129596e87.18.1735496538691; Sun, 29 Dec 2024
 10:22:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241228202212.89069-1-lleyton@fyralabs.com> <Z3EdkuCBzTGzTHK3@wunner.de>
 <CAMj1kXHWoD78QdFnEY_=Mtz02zN3rhN5+Skgv=fHG91TD8Mmvw@mail.gmail.com> <Z3EmoNWbkbYZ7NZO@wunner.de>
In-Reply-To: <Z3EmoNWbkbYZ7NZO@wunner.de>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Sun, 29 Dec 2024 19:22:07 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEb9NPSwEr2brHYJtFQhnW55hoPycjcAgoPAfjU5ZFqZw@mail.gmail.com>
Message-ID: <CAMj1kXEb9NPSwEr2brHYJtFQhnW55hoPycjcAgoPAfjU5ZFqZw@mail.gmail.com>
Subject: Re: [PATCH] x86/efistub: Add options for forcing Apple set_os protocol
To: Lukas Wunner <lukas@wunner.de>
Cc: Lleyton Gray <lleyton@fyralabs.com>, gargaditya08@live.com, 
	linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 29 Dec 2024 at 11:38, Lukas Wunner <lukas@wunner.de> wrote:
>
> On Sun, Dec 29, 2024 at 11:08:55AM +0100, Ard Biesheuvel wrote:
> > IIRC, the original issue is about not being able to use the discrete
> > GPU with the built-in panel, and the issue about an external GPU did
> > come up in the discussion - however, this does not affect the built-in
> > panel at all.
>
> The original issue was that the integrated GPU is hidden (powered off)
> unless the set_os protocol is used.  So only the discrete GPU is
> available, which results in terrible battery life.  Using set_os
> keeps the iGPU exposed so the OS can switch to it and power off
> the dGPU.
>

OK, thanks for clearing that up.

But this is distinctly different from the eGPU case we are dealing with here.

> We could have solved this by checking whether there are two PCI devices
> with VGA class in the system.  But that would have triggered in the
> iGPU + eGPU case.  We wanted to avoid that and thus quirked for the
> DMI product names instead.
>

Yeah, so it would be good to know what issue are trying to fix with this patch.

