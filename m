Return-Path: <linux-efi+bounces-1498-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E34A993D4C7
	for <lists+linux-efi@lfdr.de>; Fri, 26 Jul 2024 16:09:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A36A52860B4
	for <lists+linux-efi@lfdr.de>; Fri, 26 Jul 2024 14:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3209628EA;
	Fri, 26 Jul 2024 14:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gZSVitaD"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E45E1859
	for <linux-efi@vger.kernel.org>; Fri, 26 Jul 2024 14:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722002955; cv=none; b=gH5QxnSlFO2o5wuKGry3H7PtfchbbVRJTTVadoeNNV3YP7Gzs28F729Pd2IJmIqkDX/zIyq9tqO4O9568GmgOYpUw5Jh6mzhhk5DhhmLHzhIhjYl3KsBP8D0OBHigRWyoxcdW19ubn67ynMlpWofkv4Mu7j9g0UlG0CCrZvDNDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722002955; c=relaxed/simple;
	bh=mkYI/1Df40XHUiTBMh0ySDj4jatmJis2IWLw4SfW8Fw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tARVUwPQ1CC4a4s8kncXkZkIdtxfZlJMHSKNVOXfkCguXYnHMQHthMjD6fcL3xCp4xi6qhCpDAFx4ahZUzJBAiloPVcRA465Wcp8zQG4sKE1AaDThw8Xw9DGTsh7MqhUgwXEliQeblb/IZq3qPgJRPI2BlpiLccGS6izMofHUTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gZSVitaD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2225C4AF0B
	for <linux-efi@vger.kernel.org>; Fri, 26 Jul 2024 14:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722002954;
	bh=mkYI/1Df40XHUiTBMh0ySDj4jatmJis2IWLw4SfW8Fw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=gZSVitaDvcZUW0UEik5kZTkrTEEQu78CpPzKmVTxRZlES15m7UCWJajC72IscOgmG
	 dzWxOSfelepIpgb9TY4AfgjOK2haSssa05LZwUjytfKzk6d5Tf1ah/VZ4u4qTo0XLV
	 WWIVsomlfz9febIViIXhKAKyhMAQX7MYIBq5BkGg0OOceBupSXFid7i/Cd1cqstF0U
	 jdso1+UdavVcBqr73G2GZ4GYAbBN045MKKK+xbCbtj+n4bAKRzY+FW2Kfr6/Dw1+e/
	 YRf1I46mDRdQWJM4IdlOSpoW+bpKzRGnoC3SCsSxBK2sZKe7TnGZNOOG70JyprfHvh
	 YcHI8nXR9FkNg==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-52efc89dbedso1717027e87.3
        for <linux-efi@vger.kernel.org>; Fri, 26 Jul 2024 07:09:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUQeSfKpETyTPEOyCeWi3EpJpxUNveMD/mWytL4vnAjYqJAkYamNc8QEmDkmhdiaJFsgiY0DhvyNAvvYldd40y4xDYa5GNqX+vF
X-Gm-Message-State: AOJu0Yz2MUCOlFVAVC23OmgxS1l8KzhIo3I7lSDnaxftTHivYJiI8+N9
	xPmNDq++vkTV063Zvc7tjCnvnFx6KcGJ8USh/352xQrTx9JUOjl7jSy6nxSxJcB7DHZzd4FDl3f
	Qr2xIt/BKe+iuRRGVFzbLXFR0Jlg=
X-Google-Smtp-Source: AGHT+IHKl1n06NJxn7ZKqcOr5b3WaTXvAGKfASZQzKs24CXB4Ls1tFHPQ/L+ZMqMpIsjsQCvBeY6dK7npTqwwwzNu1Q=
X-Received: by 2002:a05:6512:304d:b0:52e:9670:e40b with SMTP id
 2adb3069b0e04-52fd60f5116mr3410823e87.39.1722002953137; Fri, 26 Jul 2024
 07:09:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <66a39687.050a0220.396642.1e5cSMTPIN_ADDED_BROKEN@mx.google.com>
In-Reply-To: <66a39687.050a0220.396642.1e5cSMTPIN_ADDED_BROKEN@mx.google.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 26 Jul 2024 16:09:02 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFa7jaVpGGKGYmD3_Gprgpd4LNsfG_73scGWmCGzoHd4A@mail.gmail.com>
Message-ID: <CAMj1kXFa7jaVpGGKGYmD3_Gprgpd4LNsfG_73scGWmCGzoHd4A@mail.gmail.com>
Subject: Re: [PATCH] loongarch/reset: use general efi poweroff
To: shankerwangmiao@gmail.com
Cc: loongarch@lists.linux.dev, linux-efi@vger.kernel.org, 
	Jiaxun Yang <jiaxun.yang@flygoat.com>, Huacai Chen <chenhuacai@kernel.org>, 
	WANG Xuerui <kernel@xen0n.name>
Content-Type: text/plain; charset="UTF-8"

On Fri, 26 Jul 2024 at 14:28, Miao Wang via B4 Relay
<devnull+shankerwangmiao.gmail.com@kernel.org> wrote:
>
> From: Miao Wang <shankerwangmiao@gmail.com>
>
> Currently efi_shutdown_init can register a general sys_off handler,
> efi_power_off, which will be called during do_kernel_power_off and shut
> the machine off via efi runtime services. So enable this by providing
> efi_poweroff_required, like arm and x86, and prevent directly calling
> efi.reset_system in machine_power_off.
>
> Signed-off-by: Miao Wang <shankerwangmiao@gmail.com>
> ---
>  arch/loongarch/kernel/efi.c   | 5 +++++
>  arch/loongarch/kernel/reset.c | 3 ---
>  2 files changed, 5 insertions(+), 3 deletions(-)
>

Acked-by: Ard Biesheuvel <ardb@kernel.org>

> diff --git a/arch/loongarch/kernel/efi.c b/arch/loongarch/kernel/efi.c
> index 000825406c1f..df57c2674758 100644
> --- a/arch/loongarch/kernel/efi.c
> +++ b/arch/loongarch/kernel/efi.c
> @@ -73,6 +73,11 @@ struct screen_info screen_info __section(".data");
>  EXPORT_SYMBOL_GPL(screen_info);
>  #endif
>
> +bool efi_poweroff_required(void)
> +{
> +       return efi_enabled(EFI_RUNTIME_SERVICES);
> +}
> +
>  static void __init init_screen_info(void)
>  {
>         struct screen_info *si;
> diff --git a/arch/loongarch/kernel/reset.c b/arch/loongarch/kernel/reset.c
> index 1ef8c6383535..9c8156798e8d 100644
> --- a/arch/loongarch/kernel/reset.c
> +++ b/arch/loongarch/kernel/reset.c
> @@ -48,9 +48,6 @@ void machine_power_off(void)
>                 enable_pci_wakeup();
>  #endif
>         do_kernel_power_off();
> -#ifdef CONFIG_EFI
> -       efi.reset_system(EFI_RESET_SHUTDOWN, EFI_SUCCESS, 0, NULL);
> -#endif
>
>         while (true) {
>                 __arch_cpu_idle();
> --
> 2.39.2
>
>

