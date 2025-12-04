Return-Path: <linux-efi+bounces-5796-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D4EC0CA3160
	for <lists+linux-efi@lfdr.de>; Thu, 04 Dec 2025 10:50:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1130830292DA
	for <lists+linux-efi@lfdr.de>; Thu,  4 Dec 2025 09:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F0E8337BBF;
	Thu,  4 Dec 2025 09:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xv97JSzb"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD54E28642B
	for <linux-efi@vger.kernel.org>; Thu,  4 Dec 2025 09:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764841826; cv=none; b=dwniInZYbpq1JRvXIE1k0SFw2kFAfSp6IYmQ82RCeq/Q5by5qd4gksgAn2+UcfpqvrGBHd8DH9C2wYgdcL/5UgCTCfeSCF8h1hfAnOeZYO0l1ujXCb1f+uNTmhdf6P1HC8OJcfs3iQogukCyGyvH9M0GSA/FJb3IcmiJ0/pGPg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764841826; c=relaxed/simple;
	bh=o+P61rVu8ZNpn/6HFvSGVjAR7vo/Ef53hEYHqZsr23E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ejiznXAfcje4Wb+ZCdQLo0AcuksOxC/bFMd00/iUX0MzC61KM/SXfaD8kWQ66pcW4ZNPgCvudu8iC0OJaFa4IRhznHTMcVBlr04g8TZMyhoNEFy6JCPxPg1vExmDRJtEN20wuAYcx00Pb6qRB6G5/1KjxGzrj8pbX0tKG+l9/Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Xv97JSzb; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-7866bca6765so6314087b3.1
        for <linux-efi@vger.kernel.org>; Thu, 04 Dec 2025 01:50:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1764841821; x=1765446621; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vLMjAxuNLjxAHPFWv5uBrvQ127FNXj2NIv4kJy5PeNM=;
        b=Xv97JSzbWnxR75C9Zs6xljLrA+rynxXePWudFhMnhlLqmOyZqNLywjsYzT90ue39Le
         u0n/QsFVOsQl+6Qxlite+M68ON5UdEcKKxnrtWnpwMg7SsJryy3RRrPH2q6w5bX8B1v0
         kxM6BX97t9EX0yoldHFVmLHhz9FbMGYAuicvpKazqXG1AZC810/bWX64Y0eBxcIfeTKX
         DCISZ8vLZ1s1awZOMbV1MXIqTWdp2fJ3xKMQTmkOGeb6dTZ91AVUl/LSblJqoEse+WRf
         pIpC6IlzMqnk/g3Iy+Rbz241xoDE6wEBT+7bOkDS/TeuEpUUr4EgHtWr7L+q/36EHn89
         bKzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764841821; x=1765446621;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vLMjAxuNLjxAHPFWv5uBrvQ127FNXj2NIv4kJy5PeNM=;
        b=joE4pha6djd99O0CISJaOTy0NVGaxYRCcAxIk3BmhiGZlRSEUoPxfxfu/W8tBd+xIU
         H46e1nNFmkZ7z9MDh/9amEHrbPH0wq7km4qWNLOWLaYeQMF3QYDZD+IPG/7vR0LL88uB
         l+YHpqPCE4bvi1akDx2bKDUGyQAvM+bmauQvkA5jHItQSCuKlvgMHQpx7t+4lO4SH3Hi
         UuF9sB57R9N5KdDTC7DQ5LAr7i3yvhY6UE3gIbZFtGbYyGMdchB/U71ixQCHayvEbcY0
         C+cW7rrxwfphnJgjdBrnN4Oapu61FmRW06LkDTnYGdTPuhDs6QDFN3dSMQfl8bTJqvHO
         7PhA==
X-Forwarded-Encrypted: i=1; AJvYcCXDFTLZhmYxSM0PfSYAOHInsRzI8WQNz5EeWRexV32gJg8HHMO0RJw5iS/PHSey7b08QY0yV9Rzcgs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/RrGlWs+YHUpE4heygSLXvqaLb8aYE8yLJcC2MLmcQZSFzU6p
	wt1vEpCTvMsZ8SRc5sCcyBdg//KCiRUnR7wrHkHINqJmOLOqF3xKNpEpyLDONnT2wphgWdbgRvz
	XqD7se3r87KCeJhmNf7m9N1SoByarcdmv/nZD2VTfIg==
X-Gm-Gg: ASbGncuXPaFuv92RupKHOCEqS/lSgoj5mdoUd5VEiaw5GF5F5ZWWtXugSKMPH6GpZqj
	W37bhc57T1mQyTAULA+kXHUeelioEApcUekn+E1q1MZFsWVzbFUEVnWwxPzISjIrcqEcXGbDd2E
	MONaXXIIJ+n/XCE5w9T+Iea8rSJp/+OiNnVu+W2tVFD/h3qX1fkaan//xqzAE2fxPGIj4nRTIlA
	6tyXfY19onfNF+6qdMyYCUJ6aMvKE7YGdVnIY2TvTBSm7yCP3jXb0EnMXZg/mbmYhHAmGinU5Br
	e0uJ8CUKWhtivKQ935n+HpFwLRmI88TuZwDBfBQ3yWWgfmVuhs1qY0+1I2NS+SOiF800iQjoxk0
	Zw4wFTtY=
X-Google-Smtp-Source: AGHT+IESVNMLyNBq+KMoAIwBGZKyJG7Q+djOXcz0m8kP5bI3Id8gFGDOtuRSbxCzD+w3MnrHuTpJW8GBwvW3eJwYKhE=
X-Received: by 2002:a05:690c:6888:b0:786:6b92:b1f6 with SMTP id
 00721157ae682-78c0bef0dcfmr35611267b3.14.1764841820991; Thu, 04 Dec 2025
 01:50:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251203042850.14210-1-val@packett.cool>
In-Reply-To: <20251203042850.14210-1-val@packett.cool>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 4 Dec 2025 11:49:44 +0200
X-Gm-Features: AWmQ_bkoWe4VSWVPT7Lf9P2bC4G2RgQK_aKUcQmbMBERdDepLQ09G0K9DSjoKzY
Message-ID: <CAC_iWjKHO3BGdaK=8a1A3Ps3U5Cqt2urJqL8PPfGcaqsMw1Qgg@mail.gmail.com>
Subject: Re: [PATCH] efi: pstore: Support late setup with TEE-backed efivars ops
To: Val Packett <val@packett.cool>
Cc: Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>, 
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>, Ard Biesheuvel <ardb@kernel.org>, linux-hardening@vger.kernel.org, 
	linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Val,

On Wed, 3 Dec 2025 at 06:29, Val Packett <val@packett.cool> wrote:
>
> On some platforms, EFI variable services only become available when an
> appropriate TEE driver is initialized such as qseecom, gsmi or stmm.
>
> This would work fine when efi_pstore was built as a module and loaded
> late by userspace, but with CONFIG_EFI_VARS_PSTORE=y this driver would
> quit due to non-writable efivars before the necessary driver had any
> chance to load.

The problem, at least for OP-TEE/StMM, is that writing the variables
to an RPMB depends on a userspace application If CONFIG_RPMB is not
selected. We have no guarantees that the app will still be alive.
I don't know how gsmi or qseecom deal with writing variables. We can
probably allow it for StMM if CONFIG_RPMB is enabled, but we'll have
the right trigger to do so.

>
> Listen to efivar_ops_nh notifications and retry the initialization when
> writable EFI variable ops become available.
>
> Signed-off-by: Val Packett <val@packett.cool>

Thanks
/Ilias
> ---
>  drivers/firmware/efi/efi-pstore.c | 32 +++++++++++++++++++++++++++----
>  1 file changed, 28 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/firmware/efi/efi-pstore.c b/drivers/firmware/efi/efi-pstore.c
> index a253b6144945..ad5192d5892e 100644
> --- a/drivers/firmware/efi/efi-pstore.c
> +++ b/drivers/firmware/efi/efi-pstore.c
> @@ -253,14 +253,11 @@ static struct pstore_info efi_pstore_info = {
>         .erase          = efi_pstore_erase,
>  };
>
> -static int efivars_pstore_init(void)
> +static int efivars_pstore_setup(void)
>  {
>         if (!efivar_supports_writes())
>                 return 0;
>
> -       if (pstore_disable)
> -               return 0;
> -
>         /*
>          * Notice that 1024 is the minimum here to prevent issues with
>          * decompression algorithms that were spotted during tests;
> @@ -285,8 +282,35 @@ static int efivars_pstore_init(void)
>         return 0;
>  }
>
> +static int efivars_pstore_ops_notifier(struct notifier_block *nb,
> +                                unsigned long event, void *data)
> +{
> +       if (event == EFIVAR_OPS_RDWR && !efi_pstore_info.bufsize)
> +               efivars_pstore_setup();
> +
> +       return NOTIFY_OK;
> +}
> +
> +static struct notifier_block efivars_pstore_ops_notifier_block = {
> +       .notifier_call = efivars_pstore_ops_notifier,
> +};
> +
> +static int efivars_pstore_init(void)
> +{
> +       if (pstore_disable)
> +               return 0;
> +
> +       blocking_notifier_chain_register(&efivar_ops_nh,
> +                                       &efivars_pstore_ops_notifier_block);
> +
> +       return efivars_pstore_setup();
> +}
> +
>  static void efivars_pstore_exit(void)
>  {
> +       blocking_notifier_chain_unregister(&efivar_ops_nh,
> +                                       &efivars_pstore_ops_notifier_block);
> +
>         if (!efi_pstore_info.bufsize)
>                 return;
>
> --
> 2.51.0
>
>

