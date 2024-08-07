Return-Path: <linux-efi+bounces-1536-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0683C94A50F
	for <lists+linux-efi@lfdr.de>; Wed,  7 Aug 2024 12:06:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 371181C20FC7
	for <lists+linux-efi@lfdr.de>; Wed,  7 Aug 2024 10:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50ED71D3650;
	Wed,  7 Aug 2024 10:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PFVF49K4"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2E71D363B
	for <linux-efi@vger.kernel.org>; Wed,  7 Aug 2024 10:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723025188; cv=none; b=n0r2fLKS7mEz/SNur+S0a6BgbgYTXPFU4xmRdElIJHkWfkwzz33VAWrzD6GA84105aodu+xna/37IoliF0x45BuWJNFSEII/EGfxHcuvqrJUmrO0M9wBCr526S7sWAeHV1vXXVXWeSPFYFFevOzFe6geYUVWzddd0PE/oib2aas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723025188; c=relaxed/simple;
	bh=kJ5T6A32kDeNCl0GvaRC+V4muNe1lMPSaqgtsY31RDg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qv/vp+6r+YIwgJjzuyr6737jBo2DNJ7KgDGa1BdSYwzvKQa4tWhmHhNYR/k5Owd92XEy9VlXX5nANWHuw5XZ3H2g0gNrP3QWUqrh9P5Z/9WJrdMNFTwcXST6HW1jZIpi6R3PXffw8+sHeibDxI6fVCnQ1+d4iwnguYnbvGHgquc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PFVF49K4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8815C4AF12
	for <linux-efi@vger.kernel.org>; Wed,  7 Aug 2024 10:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723025187;
	bh=kJ5T6A32kDeNCl0GvaRC+V4muNe1lMPSaqgtsY31RDg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=PFVF49K4vZDP6W7mhcjSUh/4S2l67jdsek7aPDIiwxdSwxiQ84z5WOJcddomPDXKC
	 xgMqAfUlenBc8LTbNavmPiLYYoumnhWuEseOIMZplD3DXL0lNSM7CRO9tl137iCUYM
	 IKZpdYf+MmkPlTMDEfrfKo+YmbVj1ezLnyTOu8yMKkRy1oZBI7med2fzm0+Au21vjb
	 J1LWyvaE/liODVqM8V0ulEUTsf/oFgdiuSa+v4FLKc3xirkz+f8OocATcwA+BhIpBe
	 8gPoEuD6PO4LTti1a2WMYXjzu5Mb8A8kmluuy+Bv2aGaScPUGw6RrbEgZwnuIq0w86
	 OeryhvGw1f32g==
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5a2a90243c9so1528557a12.0
        for <linux-efi@vger.kernel.org>; Wed, 07 Aug 2024 03:06:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW3pzK6f0OupDWwsxT7g9Wd3d2sBZNMmoiQBh8EFQba2TAs1myNpEtR8Y0qdNidf71aDqDHYCzXYxS61VEZ5UPRCWXu6bQr+E/8
X-Gm-Message-State: AOJu0YyyrRVh7X7QUhd+5k0dJKMT/EOasPJDoO1G2MZVjgxWCk5rqfsd
	4z8snacWdC2xxdy6KiVAw3yM4Zj4cr8bvtFqh4QfTUAgCVGROeGGRVKwEdrXfib7kzL+0eOBvJP
	QVIFkxMDVQmBp/Ffc3WNCLqQ156k=
X-Google-Smtp-Source: AGHT+IFDjCYDdrt0fm2Iy8PHjml6fyYttKXQez8vg+/KWK4r/1FbA8ALNFpyI+7n/fLFRt3x728tp3DzDjIzebiy9XY=
X-Received: by 2002:a17:906:4788:b0:a7a:a30b:7b91 with SMTP id
 a640c23a62f3a-a7dc51be557mr1313655066b.64.1723025186480; Wed, 07 Aug 2024
 03:06:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <66b309e9.050a0220.a8344.6d9eSMTPIN_ADDED_BROKEN@mx.google.com>
In-Reply-To: <66b309e9.050a0220.a8344.6d9eSMTPIN_ADDED_BROKEN@mx.google.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Wed, 7 Aug 2024 18:06:13 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5g1azDU+Oscr0CT3CxgN8f_VOsihMCERLvgjLci+CTgQ@mail.gmail.com>
Message-ID: <CAAhV-H5g1azDU+Oscr0CT3CxgN8f_VOsihMCERLvgjLci+CTgQ@mail.gmail.com>
Subject: Re: [PATCH] loongarch/efi: enable general efi poweroff
To: shankerwangmiao@gmail.com
Cc: loongarch@lists.linux.dev, linux-efi@vger.kernel.org, 
	Jiaxun Yang <jiaxun.yang@flygoat.com>, WANG Xuerui <kernel@xen0n.name>, 
	Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied with small modifications, thanks.

Huacai

On Wed, Aug 7, 2024 at 1:45=E2=80=AFPM Miao Wang via B4 Relay
<devnull+shankerwangmiao.gmail.com@kernel.org> wrote:
>
> From: Miao Wang <shankerwangmiao@gmail.com>
>
> efi_shutdown_init can register a general sys_off handler,
> efi_power_off. Enable this by providing efi_poweroff_required,
> like arm and x86, since this is also supported on loongarch.
>
> Signed-off-by: Miao Wang <shankerwangmiao@gmail.com>
> ---
>  arch/loongarch/kernel/efi.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
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
> --
> 2.43.0
>
>
>

