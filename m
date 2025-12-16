Return-Path: <linux-efi+bounces-5881-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 38EB4CC1C53
	for <lists+linux-efi@lfdr.de>; Tue, 16 Dec 2025 10:26:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C0DB530934BA
	for <lists+linux-efi@lfdr.de>; Tue, 16 Dec 2025 09:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07FFC32863C;
	Tue, 16 Dec 2025 09:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N5SxssEf"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4735B328B58
	for <linux-efi@vger.kernel.org>; Tue, 16 Dec 2025 09:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765876817; cv=none; b=VpyJWkaMMDd2x/zYZVVvHeCCqE3Quj622ygrfoPEC4New2yswT76kvKUm0QSuvd2zivqiBYdC1hOElNG3wfc+UyARfSoAoCQmLDWbMNZ2CtgxwrdLVQ8HPMynqBhInY8pVQQwxk/vyJdJEfi2ZFTlmMtJwWSkLBJX5ZhpucpCEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765876817; c=relaxed/simple;
	bh=StetkjSsWcyNHASAlSM0JPvWiXV26tv4Q7OeSS5FTyQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nIUHXa8oJNRjHRW2bqNd5fQPk1ZbOwPmw4wknPd/sOFLu/iw0WQBScunstr70vemyQf4ilZhk6EK3XkaSwOhVa0ussh1jMAe8d3BGGQow+U0b15ANXR7+51Kdb0g5Z3zor61lc+B9JpHgXCEoY5whWwKIKK4/r4WE6NTyQiioaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=N5SxssEf; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-78f89501423so3693417b3.1
        for <linux-efi@vger.kernel.org>; Tue, 16 Dec 2025 01:20:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1765876815; x=1766481615; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vdbkGAZvcEXm5SWEKUVClkLJFjPHLzhKuSzzyVtMACI=;
        b=N5SxssEfSBIfo6Fvjy+1PikdbnDHZ+t4FcE09yR3vfDHqoH5TqBi9QIDbjEdKD7mKj
         D+GGdHEtpLyoWWRtGmY9H60p7EHw87SFc21aiccWQfkRbWNnrD7rau/M+amcoaBlp3j8
         aU4aAEZuywYY+Ugtao9g8gYljKpbm5U10p4jZKaVgr77TIn6L5SP+bI4n8V9toyoplmR
         /vsRp9MZ2T0adqxYC0j8GwHiHB0zr2/X1w+9DpxSc21J+Mj0LVwaqlh+RbYhawOePp5v
         FsznHESc+1w+t3tNxftl7cKHZEfT30JD0+ZURYhxCird+o47W8Z+AEB2eZQARIn7+0fp
         Wwjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765876815; x=1766481615;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vdbkGAZvcEXm5SWEKUVClkLJFjPHLzhKuSzzyVtMACI=;
        b=Wvs2gwLksSZYEWdoLl80VQwxW5JSMbq5mX2QpThVyIOAm3SblrUfEpxaVhBzcIRv77
         2oRI3ChZtqDizBcEbZ+mup3vTSiy7tD80YdC7Df6iynL91c00DOalOsXff3p898oJHuh
         j2otdk6X2ZwgoRsanUinmm5c+kbLxYzsuisijyjwmoHMdJu6j72KkBgU4XuF2IKQzfqn
         wkYFznCaZdw7qAfNLWoWWKjPTFR1NUuc+YvR+f4w2fPKLiAouYEnqiqCxhOdUfalMwbH
         aCim6kA7FM32mZo9Ur9etM687d2SrUxY4t6hDpiI/7kwa1vhB8+h+yxwwMf0KmmJ5zIg
         hEyw==
X-Forwarded-Encrypted: i=1; AJvYcCVc8SkTQ1hlk11xCexh1B5fmkQN8bhRsTXfyI0IWqEIlpnyysP2vjum9lsSO5q+0QerjZdL6dCbROw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbduKwkAPV/wZdDkDeIAiTvqNk/VNbCA8WBdQzvLGnJOXJkTO/
	LM+2+bGmuLhG8NEJeN1Hsyiy+OoWNL3dvpfG52JFLZ/1Z4ZpxILS25VA1DjptQj5PcPhyh3SKDK
	B5cjp+sPFYeQ8dz+hx6IxEj7vp/fvJsON45p+87BLBw==
X-Gm-Gg: AY/fxX5XsPL5V5ftxHrHk+7iob/79NAj1kBIiCMzpieDJWYoV7+YOr/7xHUdzdeDEoA
	U7Ist8BAk5PXqtWcW/Dz4I9etkoe3/CysHt10pVrd+MankVoonYUd5rjMhSqs3QmdqAdhdnTSEv
	EPSO7CioDDNRpZfjyKOiukTG57lTWRssS2NQu/pYGRel9fPP62/OEaHGPTfRvny2rE8mgsZwK4P
	brt4mGqQuUrgukF5gAzJ9JWHBSqymJfvx2VdJ8r1NAVgnbNaFFbNnD+ulNr/ycuRE8jgXGYPGTc
	9b8ElsIoGEXqIpnxarEJv+22TjbsGCFxVyFMPRdm8y3QKWLtTntvcCReZDy/+imiiE08wNiZQwO
	dsY26H+pxw73rN4rhkHFy0eaOYTTLO5ER6A13JLcQKBArACBXGyrqxH/s/0tQZ+jpaurQcP/Hqp
	+tvhHAaJZNbiQh1HY9/Gpk8fDSaVanE+pO81vk0+0wJBohTOw63HKLgvsJjv/ukA5cMSJKRZIeL
	fWIiXzvG9u+g74a9RIfPWLUgJlhyopC68G0WPrYUGSSst4OIzIxGBkAMNoEstl5rd0Oq64v84iw
	CJG2LjUgtJkhriHLRlU12v2YkX6oxHAw
X-Google-Smtp-Source: AGHT+IEctBGbOPb8tWUDebvS3L7V3SseQeGkk4xalk8WHK1PQ+/ej2AUM8IRRWIxM80NV5FFMSeI1zTaZrQqMMcHcdA=
X-Received: by 2002:a05:690e:d0b:b0:644:60d9:8660 with SMTP id
 956f58d0204a3-6447a5a7193mr11828178d50.44.1765876815167; Tue, 16 Dec 2025
 01:20:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1765791463.git.u.kleine-koenig@baylibre.com> <b70ad65c88a82cf56c93cf17cf326213f8273e37.1765791463.git.u.kleine-koenig@baylibre.com>
In-Reply-To: <b70ad65c88a82cf56c93cf17cf326213f8273e37.1765791463.git.u.kleine-koenig@baylibre.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 16 Dec 2025 11:19:39 +0200
X-Gm-Features: AQt7F2rnkMoQPLRnnlXil8zyHYfAadd5PzbCSjslnX3-94C0khuY7zIbQk2gds8
Message-ID: <CAC_iWj+TevKq7TzPQ4_eEhu0rJJ03PV=ASf7SwTszp-mJY6Vzw@mail.gmail.com>
Subject: Re: [PATCH v2 09/17] efi: stmm: Make use of tee bus methods
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
> The tee bus got dedicated callbacks for probe and remove.
> Make use of these. This fixes a runtime warning about the driver needing
> to be converted to the bus methods.
>
> Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>
> ---

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

>  drivers/firmware/efi/stmm/tee_stmm_efi.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/firmware/efi/stmm/tee_stmm_efi.c b/drivers/firmware/=
efi/stmm/tee_stmm_efi.c
> index 5903811858b6..7b04dd649629 100644
> --- a/drivers/firmware/efi/stmm/tee_stmm_efi.c
> +++ b/drivers/firmware/efi/stmm/tee_stmm_efi.c
> @@ -520,8 +520,9 @@ static void tee_stmm_restore_efivars_generic_ops(void=
)
>         efivars_generic_ops_register();
>  }
>
> -static int tee_stmm_efi_probe(struct device *dev)
> +static int tee_stmm_efi_probe(struct tee_client_device *tee_dev)
>  {
> +       struct device *dev =3D &tee_dev->dev;
>         struct tee_ioctl_open_session_arg sess_arg;
>         efi_status_t ret;
>         int rc;
> @@ -571,21 +572,19 @@ static int tee_stmm_efi_probe(struct device *dev)
>         return 0;
>  }
>
> -static int tee_stmm_efi_remove(struct device *dev)
> +static void tee_stmm_efi_remove(struct tee_client_device *dev)
>  {
>         tee_stmm_restore_efivars_generic_ops();
> -
> -       return 0;
>  }
>
>  MODULE_DEVICE_TABLE(tee, tee_stmm_efi_id_table);
>
>  static struct tee_client_driver tee_stmm_efi_driver =3D {
>         .id_table       =3D tee_stmm_efi_id_table,
> +       .probe          =3D tee_stmm_efi_probe,
> +       .remove         =3D tee_stmm_efi_remove,
>         .driver         =3D {
>                 .name           =3D "tee-stmm-efi",
> -               .probe          =3D tee_stmm_efi_probe,
> -               .remove         =3D tee_stmm_efi_remove,
>         },
>  };
>
> --
> 2.47.3
>

