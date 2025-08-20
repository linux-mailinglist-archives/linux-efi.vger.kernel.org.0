Return-Path: <linux-efi+bounces-4575-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66714B2D488
	for <lists+linux-efi@lfdr.de>; Wed, 20 Aug 2025 09:11:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 690791C4034A
	for <lists+linux-efi@lfdr.de>; Wed, 20 Aug 2025 07:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADDBF2D24B3;
	Wed, 20 Aug 2025 07:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OaS57JIw"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063DB2D24AA
	for <linux-efi@vger.kernel.org>; Wed, 20 Aug 2025 07:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755673860; cv=none; b=Jkgrk6ylYCU0l9StuCid5udJ+ipafJ00Z7RGTvce6RijTX2jrzjIEW5VULxdFwoHS9EtTsQf3xW3nbpDmo3KfaiU7qhiDzngmlIKBPLO6xprSaWE4Iqpl/pFjmq7Hz0AfGorDAS99rvindOeK3UcRc2Z2vTRCoQG4NQfPfQ2WjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755673860; c=relaxed/simple;
	bh=prgVg9HiEJ4uV/6zMq1ntYT+mrJSc9pU9ueTTctA7Ww=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=slt/13BJrZI1J/U0cFcgFpUwilpRyEKGD/m7ApXFl6emXQ1HjB+QLYWvO6m41sgHi3mPyHbHAPdbu6j1l66p08G8HvvQWPWe1s2+afYiWbvGmIupdb7bAUHvStePyFvwqSqsC3HormiDa7BP14Rqzt2buZHSb0BOb9LceQX5Y5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OaS57JIw; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e934c8f9751so3284587276.2
        for <linux-efi@vger.kernel.org>; Wed, 20 Aug 2025 00:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755673858; x=1756278658; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gN4MlxyW6r3qWYrx46kUgQuaQDW5GOfX7NwZdxQNvEM=;
        b=OaS57JIwKq88vRMD28/b1MTPLMB36E3i0ZPo743hrcwj913yjTQiznGVg/aeC0NUHF
         ZxV54JGSCAXPQV6ftj41whk76bVqFBW3c2+BvadPaS3zdfWsGNoH2zOLwHSaYFgH745N
         WuRbSkYgaMwAJes1cKTsvWQz0HcmiPZ8/4aLluXiH0c6nf0HSx5R+aEU9WVzENuHNh2j
         PGgANBNx5KSoRkDlVdgIo3yy+GeallXLMALa/QIqeXtx25c4bOKV2NKPUgOD0uVa0Xg/
         UTCEyPMQvdKIUNOJ6VRb4Nme2TVX+KyZb05ggvcUaHb5JRHhQpsK6pp9uePyuTg84cd+
         qTEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755673858; x=1756278658;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gN4MlxyW6r3qWYrx46kUgQuaQDW5GOfX7NwZdxQNvEM=;
        b=Rvm7qY7XC3TmwWKI1ZrUwmYUhS3CPBr3XvmxPlRiN4sCrj/bVROmExGRrurp5EB8kZ
         5bXrGmvBdbNM1CVIJZL6zaUSiycB3lF/BtZ5/kFwMNwD/ehaM1jeC1Dgz2GiX4VGGtfI
         UsQYRX997U7uBwtlUX9w+pohMtFldnIu3XvVDtl1qcAdG233p5cD9w+IZAj7m53kDaA1
         C1eKgcTh33KPYkU/rq4+cUnvyVut2TyxiMM3LixCdrmJqLSn+un1r/ZvGQl0XN40MrmZ
         Ftn+1SfXc9rNqQfvwNzKnbTPD4I2b+/rKCLxkN88U2xWLMwvpLA6VAEZcMNX2yR/D1qk
         smcQ==
X-Forwarded-Encrypted: i=1; AJvYcCU57d7KPVfz6VLlgZcRvDdr+g08YRH0hJ4e09b+7OgAswg/AKlKSe/qK1qxKXkzxf9ysB4vJpFkTvw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGT5m2nb2R7sitwxDrVyzLf0sbI+dSvXnby06GTTwU8b5CLufT
	Ksm982kC8iPYhcmhnHl5T0suBGaVvYM/HUoXk8+tgeXZ4GTO1UlMTu1dWx2/1E9ZltHPae48Guf
	9UxjApv8ojp01F5q6ArtodQjdNyMnJ/09LiKrKClvRw==
X-Gm-Gg: ASbGncumdETRT4icO8uIRb0KOBXaUO45230yj7tmI+3LIVBUf0lVNRZu+tathB76rjp
	W516pLDfr/kFKJ7DNtQrLHKITsCDqGdJbZJf5oGsJs7NTzTySo2t+Fym/HnhwcqdZW3nrFlM5xU
	AOcV9vD7Msdgz5INRP2HJJXgo4v0dcq2ahS51rMqexly990mjbyOayFwadQqb2oYdXrZVvVPbV8
	VUOj7ckNRg3aIWIfAhX27DoUfSZh3UxHM56/gpd
X-Google-Smtp-Source: AGHT+IHT0m1so+m2DnVNQMxzC59omwxRiB0xv+lEru6KW8Qz0ZRm2ca6i/Xd/a4hCrOi+ZEgA4u3fe6sRq342P6YZ98=
X-Received: by 2002:a05:6902:6316:b0:e93:3d4b:40d2 with SMTP id
 3f1490d57ef6-e94f659be41mr2605537276.15.1755673857649; Wed, 20 Aug 2025
 00:10:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1755285161.git.jan.kiszka@siemens.com> <c53346c183ce0c3d02322726ef5808f468441a42.1755285161.git.jan.kiszka@siemens.com>
In-Reply-To: <c53346c183ce0c3d02322726ef5808f468441a42.1755285161.git.jan.kiszka@siemens.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 20 Aug 2025 10:10:21 +0300
X-Gm-Features: Ac12FXwAEwrbRnqKeCUup8XV1JWb-Q0hv7z2-rczEYxbT-5qBQyf2uoeL5WDaqY
Message-ID: <CAC_iWjLMFGp3wg=59PruJQb7heds6CUcy8FMZ_cdT0b2vC5a3g@mail.gmail.com>
Subject: Re: [PATCH 2/3] efi: stmm: Use EFI return code of setup_mm_hdr
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, Masahisa Kojima <masahisa.kojima@linaro.org>, 
	linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sumit Garg <sumit.garg@linaro.org>, Jens Wiklander <jens.wiklander@linaro.org>
Content-Type: text/plain; charset="UTF-8"

Hi Jan

On Fri, 15 Aug 2025 at 22:12, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>
> From: Jan Kiszka <jan.kiszka@siemens.com>
>
> If a too large payload_size is passed to setup_mm_hdr, callers will
> returned EFI_OUT_OF_RESOURCES rather than EFI_INVALID_PARAMETER that is
> passed down via ret. No need to fold errors here.

Apart from not folding the error here, the current code kind of
violates the EFI spec.
If you look at GetVariable, GetNextVariable, SetVariable, and
QueryVariableInfo only SetVariable is supposed to return
EFI_OUT_OF_RESOURCES, if there's no storage space left.

Should we also change setup_mm_hdr() and return EFI_INVALID_PARAMETER
always? It's still not ideal, but much closer to the spec.

Cheers
/Ilias
>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  drivers/firmware/efi/stmm/tee_stmm_efi.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/firmware/efi/stmm/tee_stmm_efi.c b/drivers/firmware/efi/stmm/tee_stmm_efi.c
> index 706ba095a4ba..bf992b42be70 100644
> --- a/drivers/firmware/efi/stmm/tee_stmm_efi.c
> +++ b/drivers/firmware/efi/stmm/tee_stmm_efi.c
> @@ -220,7 +220,7 @@ static efi_status_t get_max_payload(size_t *size)
>                                    SMM_VARIABLE_FUNCTION_GET_PAYLOAD_SIZE,
>                                    &ret);
>         if (!var_payload)
> -               return EFI_OUT_OF_RESOURCES;
> +               return ret;
>
>         ret = mm_communicate(comm_buf, payload_size);
>         if (ret != EFI_SUCCESS)
> @@ -267,7 +267,7 @@ static efi_status_t get_property_int(u16 *name, size_t name_size,
>                 &comm_buf, &nr_pages, payload_size,
>                 SMM_VARIABLE_FUNCTION_VAR_CHECK_VARIABLE_PROPERTY_GET, &ret);
>         if (!smm_property)
> -               return EFI_OUT_OF_RESOURCES;
> +               return ret;
>
>         memcpy(&smm_property->guid, vendor, sizeof(smm_property->guid));
>         smm_property->name_size = name_size;
> @@ -324,7 +324,7 @@ static efi_status_t tee_get_variable(u16 *name, efi_guid_t *vendor,
>         var_acc = setup_mm_hdr(&comm_buf, &nr_pages, payload_size,
>                                SMM_VARIABLE_FUNCTION_GET_VARIABLE, &ret);
>         if (!var_acc)
> -               return EFI_OUT_OF_RESOURCES;
> +               return ret;
>
>         /* Fill in contents */
>         memcpy(&var_acc->guid, vendor, sizeof(var_acc->guid));
> @@ -391,7 +391,7 @@ static efi_status_t tee_get_next_variable(unsigned long *name_size,
>                                    SMM_VARIABLE_FUNCTION_GET_NEXT_VARIABLE_NAME,
>                                    &ret);
>         if (!var_getnext)
> -               return EFI_OUT_OF_RESOURCES;
> +               return ret;
>
>         /* Fill in contents */
>         memcpy(&var_getnext->guid, guid, sizeof(var_getnext->guid));
> @@ -448,7 +448,7 @@ static efi_status_t tee_set_variable(efi_char16_t *name, efi_guid_t *vendor,
>         var_acc = setup_mm_hdr(&comm_buf, &nr_pages, payload_size,
>                                SMM_VARIABLE_FUNCTION_SET_VARIABLE, &ret);
>         if (!var_acc)
> -               return EFI_OUT_OF_RESOURCES;
> +               return ret;
>
>         /*
>          * The API has the ability to override RO flags. If no RO check was
> @@ -505,7 +505,7 @@ static efi_status_t tee_query_variable_info(u32 attributes,
>                                 SMM_VARIABLE_FUNCTION_QUERY_VARIABLE_INFO,
>                                 &ret);
>         if (!mm_query_info)
> -               return EFI_OUT_OF_RESOURCES;
> +               return ret;
>
>         mm_query_info->attr = attributes;
>         ret = mm_communicate(comm_buf, payload_size);
> --
> 2.43.0
>

