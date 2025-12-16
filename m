Return-Path: <linux-efi+bounces-5882-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E3E0CC1C5C
	for <lists+linux-efi@lfdr.de>; Tue, 16 Dec 2025 10:26:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 66AF730A09AF
	for <lists+linux-efi@lfdr.de>; Tue, 16 Dec 2025 09:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20553328B6F;
	Tue, 16 Dec 2025 09:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="InsGYELx"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB0C338917
	for <linux-efi@vger.kernel.org>; Tue, 16 Dec 2025 09:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765876892; cv=none; b=XUxHBdYpXktjZzIqQqI8S/qVHXBVCXdWyZoDlZlTZoYBQVhBXY+iCLi9CHd7cWEz6/3RWCeYW1rsFWd+EgcEqU7dGP7Ch8xG5Um1fAdI3YRAQ5iFoyqHDp2cDB4+Oqlxc2bDHdjobvfuGCyfvUPvyMeUCVCMO/tLHslQsond3+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765876892; c=relaxed/simple;
	bh=t0He5qzPvxqQBqYHuEwPFbFjMfXUQ5JZwsoRGKdPeV0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kv4vhcS/gycqf7jSEitOlVzWqhcWH2bVLGmVj2DkHJgeGjdX5VPPCSa1Jndni9k0XmPBHdff43EKGdmpgTAIG4YKD260QtMUyUyl1xTUIJdsnTh0gjX2LhTXLiqcmKIMZbIzSzzKjB9Sby5e2fw/YoZK/V0KpJA2OlFU1zYgOFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=InsGYELx; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-78e7cfd782aso20032417b3.0
        for <linux-efi@vger.kernel.org>; Tue, 16 Dec 2025 01:21:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1765876889; x=1766481689; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NGYedUjMSAQqTTCfPBzG7GGpp5/HnFYa13zWq/TfU5g=;
        b=InsGYELx7Dwt/g1P6+17u04JkdvFifoWO2q0Ilkzcc3VBTrrPx6ILo+8Aic/oW6G/c
         sZb6toLZPtk0NU740LMgq2bnJN5wOrnCJ8DoWjGHokvIN+xPhPVKhKQROaEb6kvPd94h
         9eoP9V6OkkCPEY9PIMyIG/iFkRhfCw4ASgk49Z5rTfCJNt2I9EvFhztn7qG55U7XZwNF
         zfqNkj56MSxSmOnKgmYUDU4CknSf+Crq/daxQRWgrABa9nTxguaxtHIyowtAW2N5g5vs
         plpqwuBn4D8HWdOGhE/6EvVdBVrppUeEW0VyONSDHWrSNw4SbfybzU0IWW7IX2V9fsYh
         l+Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765876889; x=1766481689;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NGYedUjMSAQqTTCfPBzG7GGpp5/HnFYa13zWq/TfU5g=;
        b=pjtdEoi0fkhiUoZ9/uBPc76QqvBzxPOWULngZHduZsH8i4ZoxfHcunozEijsWBHLWS
         zjcgIJXXfKiYef0C0VZ0Ih0VHQhqHhKzXf6oCW8v2YLAFBdoPMkNbN+g7K+Z98TmPcyj
         +xR2kxCn4nuKGFTfPcdEp78pNlNSohUj8mPJrxAbiAVCE/NKq+cYIZvGsYkXsLjA3TsK
         AHQHEkNMVLPK1gI5VQg40TqwZFU2zvz+HOxM7dCTPBjc2RGGhgLmMcNnyew5UcwgaKx0
         QYRp455OeVNqf6CzcrJXkF/kQ/DwRPmuEx/wFFLf8rh2+GsiZN09A5iWErnEQKrGAdkd
         toTA==
X-Forwarded-Encrypted: i=1; AJvYcCXlqaCCeI0lmyuGcAJvwKxrm84wG3vR7w1yUFzs7E9QiNWDgmXCMgHhRch1B6ZBauH8on1v75WEpmA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwY+Rmg4lfjfG9tgOqTrMS7QVwl41P4xWr6OghSvJqrVLiaORQQ
	V09kKuBWIq0f6Q+q/XBHeiz5ixI2wCuoXWjjtxtVp62IzzKC+ckJlcudg6mlSviY2j2bkuE/fdL
	wSspADbi43s7ccsNj9iME3ngcc9HIOUZaLNrCGAcO1g==
X-Gm-Gg: AY/fxX7+U26q39UXU8OcO+YmqaMp7vgRJf+38Tzk2w1U+y+EMx/Gck3GTCXnqbPOiGD
	Nf4AkhDX8GXDwO5w4GwRUNDMq2hxnhQZcdmdZQfSOmP1BQDaSvIyrKIT1NdsvzUOo60tqDBnTg4
	BL8Xw3w72EbL2nDSzIlXYrxi7Bo9GtlkKQBJKfGDIAWKbFuVqE0eoeeZ8DkyC3OKYVddegWxDO3
	imQf50a1/afG1dhQ3UhMgMYL5TB045GYKUPrltm/zhsHzx6J7EnvNqlqFheO2Xth2StLPV9dxLH
	HIH01lF4PuJ1turNHAglrNc2dlKvHwFcjZqyOOTbFi7vXOnxF5WRypQnqzPOf9Yh1Jm/gzM+NhO
	SJgp59xpvlN3RKdo+CitZbLw9kQNkrkc5Ml9lSI/POFUl8QCd7LNBCqBKT4z11aFrVOxJC9VR2k
	qIK6+wJdoBcJ6H5ABFjKk3K+gru1laHXUCJjQhvP+VzInZhyWIG5NApi2PzGHIkaZsQ0KxWnGYF
	H05T7o3wnpI40xWT3OkvhCXoUicZdf7jA2hmLk4jtbhp5fpRyxTjC3KXxMmJJ9td26N4UTSVuFe
	nCxuu1cwsStKK5As0zknS9m54CEAfAUN
X-Google-Smtp-Source: AGHT+IEAFokQb5D1JItH9s+uj3Sa3EAOeQhnCG2QizFVOaNkP6qUDXOVMm6HltsGpBU7JI8LFSpiz0VIaHoanmm6gBM=
X-Received: by 2002:a05:690c:688f:b0:78d:6c06:4a0f with SMTP id
 00721157ae682-78e6809a375mr112570247b3.0.1765876889065; Tue, 16 Dec 2025
 01:21:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1765791463.git.u.kleine-koenig@baylibre.com> <6a56ee61e485703d548e9e44d53b2920b4e43ca6.1765791463.git.u.kleine-koenig@baylibre.com>
In-Reply-To: <6a56ee61e485703d548e9e44d53b2920b4e43ca6.1765791463.git.u.kleine-koenig@baylibre.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 16 Dec 2025 11:20:52 +0200
X-Gm-Features: AQt7F2rtv6sYjRJcPW49bnernszF66e86Q28fTD0Bfhuswf7pxXDfIzUWVoUNmU
Message-ID: <CAC_iWjLG7o96E=9W-cjJ=_622RFg-b9t6hQnMrSmgHS+ThaXyw@mail.gmail.com>
Subject: Re: [PATCH v2 08/17] efi: stmm: Make use of module_tee_client_driver()
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Jens Wiklander <jens.wiklander@linaro.org>, Ard Biesheuvel <ardb@kernel.org>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Sumit Garg <sumit.garg@oss.qualcomm.com>, Jan Kiszka <jan.kiszka@siemens.com>, 
	linux-efi@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	op-tee@lists.trustedfirmware.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 15 Dec 2025 at 16:17, Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@baylibre.com> wrote:
>
> Reduce boilerplate by using the newly introduced module_tee_client_driver=
().
> That takes care of assigning the driver's bus, so the explicit assigning
> in this driver can be dropped.
>
> Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>
> ---

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

>  drivers/firmware/efi/stmm/tee_stmm_efi.c | 14 +-------------
>  1 file changed, 1 insertion(+), 13 deletions(-)
>
> diff --git a/drivers/firmware/efi/stmm/tee_stmm_efi.c b/drivers/firmware/=
efi/stmm/tee_stmm_efi.c
> index 65c0fe1ba275..5903811858b6 100644
> --- a/drivers/firmware/efi/stmm/tee_stmm_efi.c
> +++ b/drivers/firmware/efi/stmm/tee_stmm_efi.c
> @@ -584,24 +584,12 @@ static struct tee_client_driver tee_stmm_efi_driver=
 =3D {
>         .id_table       =3D tee_stmm_efi_id_table,
>         .driver         =3D {
>                 .name           =3D "tee-stmm-efi",
> -               .bus            =3D &tee_bus_type,
>                 .probe          =3D tee_stmm_efi_probe,
>                 .remove         =3D tee_stmm_efi_remove,
>         },
>  };
>
> -static int __init tee_stmm_efi_mod_init(void)
> -{
> -       return driver_register(&tee_stmm_efi_driver.driver);
> -}
> -
> -static void __exit tee_stmm_efi_mod_exit(void)
> -{
> -       driver_unregister(&tee_stmm_efi_driver.driver);
> -}
> -
> -module_init(tee_stmm_efi_mod_init);
> -module_exit(tee_stmm_efi_mod_exit);
> +module_tee_client_driver(tee_stmm_efi_driver);
>
>  MODULE_LICENSE("GPL");
>  MODULE_AUTHOR("Ilias Apalodimas <ilias.apalodimas@linaro.org>");
> --
> 2.47.3
>

