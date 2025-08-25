Return-Path: <linux-efi+bounces-4601-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC40EB33895
	for <lists+linux-efi@lfdr.de>; Mon, 25 Aug 2025 10:18:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E1D620230F
	for <lists+linux-efi@lfdr.de>; Mon, 25 Aug 2025 08:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6221A33985;
	Mon, 25 Aug 2025 08:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TdZTAG2F"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87FB01DFCB
	for <linux-efi@vger.kernel.org>; Mon, 25 Aug 2025 08:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756109904; cv=none; b=mWgd6RjthJLV7ItMLIHTHXDZKsYaVetB/5dfBxJKvDS2vYTW5o6YfTUzk77tPZ+5RTdu0BEJQfLWL5YWOh0aiBZq1F55jzpTtt9cDoGSbKHuCSxybt9OZyiHTR7TlFtSHnUt9/q5uWTovFot9GVlXpoAOBnjfP6WYmCK+/dMwWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756109904; c=relaxed/simple;
	bh=OkAcdd8J8Fjd6pXdPPl+yjjUVnoXGCuIN9KC8b/vjS0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OWhusaDuthMDiFByXbJ2yHYDXwYyd8bXIFMyiJF2ikziq6HPMQVXm99qC2zlJpquIuCCHttN66eAEjLTgfgqaPDf6FI7UUzDUYCqUxVuJN4mK8kne+0oh3RqpE+4hvEw/vVGkN/56JnWpeWiINbm8+y9MqxFSmmA0wXYhQ/z96s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TdZTAG2F; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-71d6051aeafso34373837b3.2
        for <linux-efi@vger.kernel.org>; Mon, 25 Aug 2025 01:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756109901; x=1756714701; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+0Oybj0M0yoKkhWS1OYGK0UFnQZogX/+t9MX3nl4xcE=;
        b=TdZTAG2FK64axxkK0STNH2C0k0IpU6KHpFhG2+dYFoi+C6MWCVpecgiQd85ZskuV4Y
         6wVjEbfVSz4mwVF84bV8+GI8i9nRWNVawvKbUzkag5GlfQx9ZcDoenMVj/6oPig3kWSY
         WKWEf8yNFH9rV3o26XQaGAS3FCBL+AM9fBayGHAub8nf9rBp3U7Y+LZMuvvl5R4XhkqC
         aw+JgUSJkjiJ/N7fvqi2h1UirNtBjvLh5MCyIrUu4UjbbFMOi+D6FUljZDaRsx1aSM5b
         7mowil8SOTsTeRroBf/PYdaymiBhMxzx8FhkVlijlg3Hlhrdefqv7f5/VfIAMjD8vo8r
         0tsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756109901; x=1756714701;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+0Oybj0M0yoKkhWS1OYGK0UFnQZogX/+t9MX3nl4xcE=;
        b=S8082srvyIzyTfmPKGLaY2Dluvvr+Jvw/yU1H0RUhHP91nhL2dgBDqKGHUCHJFY2sE
         KeePq0cr5lxjphTKJMoEAWnEjIpNAh4ItnNnG9BdsafmHyqubeMTFp1m5Z9q7X1PXwGo
         rej2j14gIyW0T65KWEhem9Zzk3luGuRkU7GQJgErgflDqvQ2dnSMjVFfAEKh0hgTH7++
         Z1Me7wKmt2dqiW5+wyiwLeXprBWV+R3nz8eFcx8B6QNtb2cWIbBY5YPG7bkpcmpaLwzy
         /k/HfnftH7CeHL0hFTTQbFoJNsYeaMwqX+aBU+1rdMQpX1d9QfLamiioXDcIpQcYPyMG
         vwZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXwOLt4mZM8UIXnyRgbT0qQBulstK+5j7IqYvXkz+rhwVP+LnS+iReE7zTu8J/uH2yhiX7RURSl08s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIM7CT51bpAoVXlYQI5MQLiah+tObKjy7gSekbNmTYmwZC+j+i
	mJjIDTvSsFKqg7CaOy7VaHVxqLS+ZHH0urlLFlMqNa0XLNhrpHteA97n/NUvKwnR0oagGt8Pi52
	3HKg+otlY0pyew0QmK/aLR5n4kESG81YXZal2e7IMrQ==
X-Gm-Gg: ASbGnctAaCgYq6mvn/0FHMNKIGIVwpMpOi2FGj0Bwr957h2GVckBXeoqKvfkeIvd3AT
	Fe9ggIiokKwEhLvt03fbta42SXcvc8onRs4I2CxsSgmIQTdERbtc4sWYk6xe99SCbOCHK5p+UIt
	kDZUshPZHEHYvvxnFGXP9u8KJVR1k9OVliFzj3o45Va8MzUTCB6l26GvdGtdKWA1zBB1qGoRDdQ
	U6vOipz9oVFu0OfFh9Ls8zGXrdPQIg7evaReszgwKtEH1CMub8Htq88Y7/StWvSckSa2V1Wv79a
	op9lJSFzCQs8aJp5Lo6XrbacVVVhlaggLvJBX8yn7+OjZdn+S4O0cOoKB0FDrUNL8MTvLQrJJnY
	BtRIpkJ6NwaizIWctrW4=
X-Google-Smtp-Source: AGHT+IFlchCrXoWj4MOj8DWBnk7iM3uEWC5Al3yIogbIC43b2Wxo4c2bAsYc4GzxL9VpWzUBWRbHHvVjWH3UvaJFfQI=
X-Received: by 2002:a05:690c:60c5:b0:71c:3fde:31b6 with SMTP id
 00721157ae682-71fdc3d153cmr110423217b3.34.1756109901271; Mon, 25 Aug 2025
 01:18:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1755969734.git.jan.kiszka@siemens.com> <445bbda26e505e06b9b830cb9938ac57e847b28e.1755969734.git.jan.kiszka@siemens.com>
In-Reply-To: <445bbda26e505e06b9b830cb9938ac57e847b28e.1755969734.git.jan.kiszka@siemens.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 25 Aug 2025 11:17:45 +0300
X-Gm-Features: Ac12FXw0L_5HY92V1wJ2FCWLVP6n9-dDpc8AyHfbxYYZN-5rou3wGiH51oh3ulU
Message-ID: <CAC_iWjK69CjJq_ia0RG7DD5-EaQtVkBE_66RxaW1PCDaa_skSw@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] efi: stmm: Drop unused EFI error from setup_mm_hdr arguments
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, Masahisa Kojima <kojima.masahisa@socionext.com>, 
	linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sumit Garg <sumit.garg@kernel.org>, Jens Wiklander <jens.wiklander@linaro.org>, 
	Hua Qian Li <huaqian.li@siemens.com>
Content-Type: text/plain; charset="UTF-8"

Hi Jan

On Sat, 23 Aug 2025 at 20:22, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>
> From: Jan Kiszka <jan.kiszka@siemens.com>
>
> No caller evaluates it.

We need a better description on this one, other than that I am fine
with the patch.
Callers were never evaluating the ret, they just used the return value
in case of an error

With that fixed
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  drivers/firmware/efi/stmm/tee_stmm_efi.c | 25 ++++++++----------------
>  1 file changed, 8 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/firmware/efi/stmm/tee_stmm_efi.c b/drivers/firmware/efi/stmm/tee_stmm_efi.c
> index 8501056ade8a..c2bc8467b099 100644
> --- a/drivers/firmware/efi/stmm/tee_stmm_efi.c
> +++ b/drivers/firmware/efi/stmm/tee_stmm_efi.c
> @@ -154,11 +154,9 @@ static efi_status_t mm_communicate(u8 *comm_buf, size_t payload_size)
>   * @dptr:              pointer address to store allocated buffer
>   * @payload_size:      payload size
>   * @func:              standAloneMM function number
> - * @ret:               EFI return code
>   * Return:             pointer to corresponding StandAloneMM function buffer or NULL
>   */
> -static void *setup_mm_hdr(u8 **dptr, size_t payload_size, size_t func,
> -                         efi_status_t *ret)
> +static void *setup_mm_hdr(u8 **dptr, size_t payload_size, size_t func)
>  {
>         const efi_guid_t mm_var_guid = EFI_MM_VARIABLE_GUID;
>         struct efi_mm_communicate_header *mm_hdr;
> @@ -173,16 +171,13 @@ static void *setup_mm_hdr(u8 **dptr, size_t payload_size, size_t func,
>         if (max_buffer_size &&
>             max_buffer_size < (MM_COMMUNICATE_HEADER_SIZE +
>                                MM_VARIABLE_COMMUNICATE_SIZE + payload_size)) {
> -               *ret = EFI_INVALID_PARAMETER;
>                 return NULL;
>         }
>
>         comm_buf = alloc_pages_exact(COMM_BUF_SIZE(payload_size),
>                                      GFP_KERNEL | __GFP_ZERO);
> -       if (!comm_buf) {
> -               *ret = EFI_OUT_OF_RESOURCES;
> +       if (!comm_buf)
>                 return NULL;
> -       }
>
>         mm_hdr = (struct efi_mm_communicate_header *)comm_buf;
>         memcpy(&mm_hdr->header_guid, &mm_var_guid, sizeof(mm_hdr->header_guid));
> @@ -192,7 +187,6 @@ static void *setup_mm_hdr(u8 **dptr, size_t payload_size, size_t func,
>         var_hdr->function = func;
>         if (dptr)
>                 *dptr = comm_buf;
> -       *ret = EFI_SUCCESS;
>
>         return var_hdr->data;
>  }
> @@ -215,8 +209,7 @@ static efi_status_t get_max_payload(size_t *size)
>
>         payload_size = sizeof(*var_payload);
>         var_payload = setup_mm_hdr(&comm_buf, payload_size,
> -                                  SMM_VARIABLE_FUNCTION_GET_PAYLOAD_SIZE,
> -                                  &ret);
> +                                  SMM_VARIABLE_FUNCTION_GET_PAYLOAD_SIZE);
>         if (!var_payload)
>                 return EFI_DEVICE_ERROR;
>
> @@ -262,7 +255,7 @@ static efi_status_t get_property_int(u16 *name, size_t name_size,
>
>         smm_property = setup_mm_hdr(
>                 &comm_buf, payload_size,
> -               SMM_VARIABLE_FUNCTION_VAR_CHECK_VARIABLE_PROPERTY_GET, &ret);
> +               SMM_VARIABLE_FUNCTION_VAR_CHECK_VARIABLE_PROPERTY_GET);
>         if (!smm_property)
>                 return EFI_DEVICE_ERROR;
>
> @@ -318,7 +311,7 @@ static efi_status_t tee_get_variable(u16 *name, efi_guid_t *vendor,
>
>         payload_size = MM_VARIABLE_ACCESS_HEADER_SIZE + name_size + tmp_dsize;
>         var_acc = setup_mm_hdr(&comm_buf, payload_size,
> -                              SMM_VARIABLE_FUNCTION_GET_VARIABLE, &ret);
> +                              SMM_VARIABLE_FUNCTION_GET_VARIABLE);
>         if (!var_acc)
>                 return EFI_DEVICE_ERROR;
>
> @@ -383,8 +376,7 @@ static efi_status_t tee_get_next_variable(unsigned long *name_size,
>
>         payload_size = MM_VARIABLE_GET_NEXT_HEADER_SIZE + out_name_size;
>         var_getnext = setup_mm_hdr(&comm_buf, payload_size,
> -                                  SMM_VARIABLE_FUNCTION_GET_NEXT_VARIABLE_NAME,
> -                                  &ret);
> +                               SMM_VARIABLE_FUNCTION_GET_NEXT_VARIABLE_NAME);
>         if (!var_getnext)
>                 return EFI_DEVICE_ERROR;
>
> @@ -440,7 +432,7 @@ static efi_status_t tee_set_variable(efi_char16_t *name, efi_guid_t *vendor,
>          * the properties, if the allocation fails
>          */
>         var_acc = setup_mm_hdr(&comm_buf, payload_size,
> -                              SMM_VARIABLE_FUNCTION_SET_VARIABLE, &ret);
> +                              SMM_VARIABLE_FUNCTION_SET_VARIABLE);
>         if (!var_acc)
>                 return EFI_DEVICE_ERROR;
>
> @@ -495,8 +487,7 @@ static efi_status_t tee_query_variable_info(u32 attributes,
>
>         payload_size = sizeof(*mm_query_info);
>         mm_query_info = setup_mm_hdr(&comm_buf, payload_size,
> -                               SMM_VARIABLE_FUNCTION_QUERY_VARIABLE_INFO,
> -                               &ret);
> +                               SMM_VARIABLE_FUNCTION_QUERY_VARIABLE_INFO);
>         if (!mm_query_info)
>                 return EFI_DEVICE_ERROR;
>
> --
> 2.43.0
>

