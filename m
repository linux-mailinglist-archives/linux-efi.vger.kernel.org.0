Return-Path: <linux-efi+bounces-4576-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DD7ACB2D4E1
	for <lists+linux-efi@lfdr.de>; Wed, 20 Aug 2025 09:30:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2801D7A8BED
	for <lists+linux-efi@lfdr.de>; Wed, 20 Aug 2025 07:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DBC32673AF;
	Wed, 20 Aug 2025 07:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BMGo+MPr"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14AA204F93
	for <linux-efi@vger.kernel.org>; Wed, 20 Aug 2025 07:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755675006; cv=none; b=SwXYQ/JujSZ8AaQzCp8dRzp35ZqxzWSlWG7hmX8Mh6iGyWwx8uLvYdBx88K4juL7gjUURMs865fmSZJJUMglkG8DaZUkLEr8Sjfv9wDLE/UOLM8vHSIAj0jyte3/JFb0ONE5onL41ngQt6B+JS+OU+H7HjpSDFnGKepti+Xyq/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755675006; c=relaxed/simple;
	bh=miVAnFzERkwwZFz+AHOVaJzq5T44NAxiX9riBc1AC0c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HSdTPJad4ejyyPesQECEZM3CzrIijM1swXKV2jgUnWvlnD3x3ZR0drlPyWkPhnzeIG1RUqlADN/DflprjtH+rEHiSd4H5fIBkigrxK9tEA8yZgKB7ILCsb7/m7F0u0hY8WgSyerUJmdvJDMrh4MUCIXuDsQCHrwmjSK/9mqy2Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BMGo+MPr; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-71d608e34b4so51287327b3.3
        for <linux-efi@vger.kernel.org>; Wed, 20 Aug 2025 00:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755675004; x=1756279804; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=h6kxQIF9sv3cEZtvcUECytdXb2q7OpgBwJtmcOdc1rc=;
        b=BMGo+MPryIlWfl4vd9+r9vWQ50R/zvSLDOE221XxA7oKY3J3odw84VkbFUfoZZmhas
         uAgA8pcUrr6okzd+ErIb8uNM54g02UVETlH2znvGodWbG++AoHAd+oxh95XG8tfblneU
         tJ4+dmReGfLDZd6Fp3rBVYeORUPzxrPFqTV0p/LpYuWY9sDRA6q9MK0wU58c1xPHIiKq
         7xNEVaFsW0yLYbLcqACVyAGxA8dM78mOcopTBGNJBjwp3v5fbDsq4SnJxTn7rEs+7eb0
         RJABJtG7VL0UtqoElkQ/OlyAPmh7kCXaDWxbL5LIAhTjUgugVLBocdW2KDv1PbzC0WBA
         d0ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755675004; x=1756279804;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h6kxQIF9sv3cEZtvcUECytdXb2q7OpgBwJtmcOdc1rc=;
        b=E2oq5vb30lq2ndLXJP58cIoO1yx59sde235KJRdXIhXWH3H+zrdBqMvkqaBqnXDUzp
         8JGIhfHzT3HtIo1Uu0ilcMu/ejJblFjkyBE6IZ3fPuLu3/AxI2XnAWHKMF+xwRNmEueT
         T8zJeErX2milCo59omJNYSPXlygYIGirHD4lc9d3egn0adqOrfWTuFS1SVlhF8iyHjye
         GHumsoCrY30vlAbPCMev4q4+/1Nk9ApDwVwGrvBbBxIuFQnPPp0cdYvfGHhLiwSJwZl4
         x6y2PoUdvToi8fyrdPRQYrVk3jD5bY8H8VEOHOp09R8GxoWXp8KX+NcjAV7A2HZ6XMCu
         Ga8g==
X-Forwarded-Encrypted: i=1; AJvYcCVG7B5EeFLAjCLEZZrXD/BdaUR5K60efotviFsxvLL2Nzc4JX9uvIQoCJku6rJtN/HRiSo0FKKVt6I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSjNnWyc3Sa4DJz4WOdocWP5HHDlNL4lvFxApc60ClGmnkt3Hp
	Pf3pqcVun8DMIgs/E3P251W9+wKNUZSrEeyAtmwTjMHBJp3j7kxqfKl0r6GU/7UsPbK5Sk0CFwe
	kQfT5+sAvd7DpCYYb8irs5RMAGVQx6YLbMkMvd8xrDg==
X-Gm-Gg: ASbGncuooAVn8p9R6BErx5pyPUqaCQPLHDhNiVUwz8V44zrwf1d2QP5A1gJXYHlsfLv
	JPxYk8CrKEHeIbtirB6a81VnbruKtHouYHSu8g1lyq6JrfOeVzGuuJIrtRGwQP0RbzNYkpbr4TR
	YoeXVMKwemImU4iEPRUxxxSM9AGU5naE7htPBWwmrz8GN6KFGdwGB6/9lByH/d7015LQWxiQnsH
	kty4dHY9mFB3/XqfE/qSW/daNRoITw+4aFFmEV5
X-Google-Smtp-Source: AGHT+IG9EQgvr3LW1UMH+B6ZIIE8UDnZRW2WwEgRLGIaE/SHRVIozb73o0V3qxtSruuPAXCzCUgBGoWi9dYHfkMKZnE=
X-Received: by 2002:a05:690c:7648:b0:71f:b944:100c with SMTP id
 00721157ae682-71fb9444a2cmr8056597b3.51.1755675003728; Wed, 20 Aug 2025
 00:30:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1755285161.git.jan.kiszka@siemens.com> <37ba67b97d55c49a7c6a1597f104b30b31a4a395.1755285161.git.jan.kiszka@siemens.com>
In-Reply-To: <37ba67b97d55c49a7c6a1597f104b30b31a4a395.1755285161.git.jan.kiszka@siemens.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 20 Aug 2025 10:29:27 +0300
X-Gm-Features: Ac12FXyvMaUjXv-7szvIFu7mXexg6FAgS7_Dd_6hAbv2GdCyqKhvuRxJ9CL1STc
Message-ID: <CAC_iWjL84EFiKh0ETb7LwYjMRgLAZA8hFKy-YDS4=YQ1LRwg9A@mail.gmail.com>
Subject: Re: [PATCH 1/3] efi: stmm: Fix incorrect buffer allocation method
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jens Wiklander <jens.wiklander@linaro.org>, 
	Masahisa Kojima <kojima.masahisa@socionext.com>, Sumit Garg <sumit.garg@kernel.org>
Content-Type: text/plain; charset="UTF-8"

(++cc Sumit and Kojima-san on their updated emails)

On Fri, 15 Aug 2025 at 22:12, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>
> From: Jan Kiszka <jan.kiszka@siemens.com>
>
> The communication buffer allocated by setup_mm_hdr is later on passed to
> tee_shm_register_kernel_buf. The latter expects those buffers to be
> contiguous pages, but setup_mm_hdr just uses kmalloc. That can cause
> various corruptions or BUGs, specifically since 9aec2fb0fd5e, though it
> was broken before as well.
>
> Fix this by using alloc_pages_exact instead of kmalloc.
>
> Fixes: c44b6be62e8d ("efi: Add tee-based EFI variable driver")
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---

[...]

>         const efi_guid_t mm_var_guid = EFI_MM_VARIABLE_GUID;
>         struct efi_mm_communicate_header *mm_hdr;
> @@ -173,9 +174,12 @@ static void *setup_mm_hdr(u8 **dptr, size_t payload_size, size_t func,
>                 return NULL;
>         }
>
> -       comm_buf = kzalloc(MM_COMMUNICATE_HEADER_SIZE +
> -                                  MM_VARIABLE_COMMUNICATE_SIZE + payload_size,
> -                          GFP_KERNEL);
> +       *nr_pages = roundup(MM_COMMUNICATE_HEADER_SIZE +
> +                           MM_VARIABLE_COMMUNICATE_SIZE + payload_size,
> +                           PAGE_SIZE) / PAGE_SIZE;
> +
> +       comm_buf = alloc_pages_exact(*nr_pages * PAGE_SIZE,
> +                                    GFP_KERNEL | __GFP_ZERO);

Rename nr_pages to something else and skip division, multiplying.
Unless there's a reason I am missing?
Also doesn't alloc_pages_exact() already rounds things up?

>         if (!comm_buf) {
>                 *ret = EFI_OUT_OF_RESOURCES;
>                 return NULL;
> @@ -205,13 +209,14 @@ static efi_status_t get_max_payload(size_t *size)
>         struct smm_variable_payload_size *var_payload = NULL;
>         size_t payload_size;
>         u8 *comm_buf = NULL;

[...]

Thanks
/Ilias

