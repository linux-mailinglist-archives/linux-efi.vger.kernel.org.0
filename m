Return-Path: <linux-efi+bounces-819-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF3D87CA9E
	for <lists+linux-efi@lfdr.de>; Fri, 15 Mar 2024 10:21:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1B5B284F1E
	for <lists+linux-efi@lfdr.de>; Fri, 15 Mar 2024 09:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69CB3182A7;
	Fri, 15 Mar 2024 09:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pA1inU3S"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4468E182A3
	for <linux-efi@vger.kernel.org>; Fri, 15 Mar 2024 09:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710494462; cv=none; b=u3qI0WzBvw1mVUoAp7O5gJtOr7Xqarltq+zuF9pnzj2HJxpqXvCJmWv5ra0CsupZldwW1l7siP4jnzo2AE3gZQ60oH1oJifTtcoTDOgwcMPiDqfrnoVOTTBAiNXabT6OjfgIFKWqepFJwwC4igI6D5rGF9ZminTNKd0QJkQU7RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710494462; c=relaxed/simple;
	bh=nU82x47O0ZkQjmXNQ9Ba80s8Z1hbDA+4ydJV51fxujo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rxaqVIdLT2dhvdJNDm8KMuu5MRWY4x4ri3y/FctP6qhM2McF8wp89Q7U6qVXMH3hBF/BYy5HCESaymYFP/zx0emTvnEzjh8NacrvMFZOindBuLQy7uYYo+pWwhaqbqi7y04GAYEjq0Y63rlPRnd0FHuqsBgEObgpkZAj1S5dcCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pA1inU3S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C664AC43399
	for <linux-efi@vger.kernel.org>; Fri, 15 Mar 2024 09:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710494461;
	bh=nU82x47O0ZkQjmXNQ9Ba80s8Z1hbDA+4ydJV51fxujo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=pA1inU3STbNjA+THAUW1lipcQVjh10aP3iLOvFiKelwFbWDWNrF7JIFOPljDK6fsY
	 jkZxg6TqiRDQQig4OZNL7K8TgTLpmnlfVEb18spdlUb7Y2k3Kzbp5G+LR6FIz7CZ2P
	 6+luVXyTQRfgTdFYTV1vWzYY8LEfAdBmT47dunOREQjBbEeTruhyS/JN68Z2WuaWPQ
	 6iWEZGGLhrmi2VWgjDL/x16k9xjd58GkchVMD5DPhGjjJ2dhgfRXzKuXIs9YafFtkL
	 uqMZHLzHbFsbFG3R06wf5xco0pAVhkG5go8ynrzto3B8Ac1Bv0TZuMQucdqFamuPU3
	 yNIg64QZ5pg9A==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-513a6416058so2720056e87.1
        for <linux-efi@vger.kernel.org>; Fri, 15 Mar 2024 02:21:01 -0700 (PDT)
X-Gm-Message-State: AOJu0YwUeV2XdYffGXMbBnoHvfx5Zj88mldodNGgt0ozPj31145Tq5XZ
	vk7s2sqM4S5wbu+pIhUK4ztLFc2VI98JEXppE23omp3CdSL9/zmzAfFrlKz/96v1OlCB0a8yWRT
	8FrKkAwL437kEaM1j02tAHTK7HAM=
X-Google-Smtp-Source: AGHT+IEU+PC0MnDFE3NFSnmk44ADMAf+lpigF99WMEYysAlsPh2AZUGVpz/u9dcEbiYJtBlgI+LtPXMslFf0L/swQZU=
X-Received: by 2002:a05:6512:32a6:b0:513:c54d:d4a with SMTP id
 q6-20020a05651232a600b00513c54d0d4amr3017013lfe.5.1710494460070; Fri, 15 Mar
 2024 02:21:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240315002616.422802-1-timschumi@gmx.de> <20240315002616.422802-3-timschumi@gmx.de>
In-Reply-To: <20240315002616.422802-3-timschumi@gmx.de>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 15 Mar 2024 10:20:48 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGBtF6v=QCeBjJsVr=wdndWM0DbyFXxObsd5YUcm7U3zQ@mail.gmail.com>
Message-ID: <CAMj1kXGBtF6v=QCeBjJsVr=wdndWM0DbyFXxObsd5YUcm7U3zQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] efi: Clear up misconceptions about a maximum variable
 name size
To: Tim Schumacher <timschumi@gmx.de>
Cc: linux-efi@vger.kernel.org, Jeremy Kerr <jk@ozlabs.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 15 Mar 2024 at 01:27, Tim Schumacher <timschumi@gmx.de> wrote:
>
> The UEFI specification does not make any mention of a maximum variable
> name size, so the headers and implementation shouldn't claim that one
> exists either.
>
> Comments referring to this limit have been removed or rewritten, as this
> is an implementation detail local to the Linux kernel.
>
> Where appropriate, the magic value of 1024 has been replaced with
> EFI_VAR_NAME_LEN, as this is used for the efi_variable struct
> definition. This in itself does not change any behavior, but should
> serve as points of interest when making future changes in the same area.
>
> A related build-time check has been added to ensure that the special
> 512 byte sized buffer will not overflow with a potentially decreased
> EFI_VAR_NAME_LEN.
>
> Signed-off-by: Tim Schumacher <timschumi@gmx.de>

Shouldn't we switch to 512 everywhere while at it?

> ---
>  drivers/firmware/efi/vars.c | 2 +-
>  fs/efivarfs/vars.c          | 5 +++--
>  include/linux/efi.h         | 9 ++++-----
>  3 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/firmware/efi/vars.c b/drivers/firmware/efi/vars.c
> index f654e6f6af87..4056ba7f3440 100644
> --- a/drivers/firmware/efi/vars.c
> +++ b/drivers/firmware/efi/vars.c
> @@ -215,7 +215,7 @@ efi_status_t efivar_set_variable_locked(efi_char16_t *name, efi_guid_t *vendor,
>
>         if (data_size > 0) {
>                 status = check_var_size(nonblocking, attr,
> -                                       data_size + ucs2_strsize(name, 1024));
> +                                       data_size + ucs2_strsize(name, EFI_VAR_NAME_LEN));
>                 if (status != EFI_SUCCESS)
>                         return status;
>         }
> diff --git a/fs/efivarfs/vars.c b/fs/efivarfs/vars.c
> index 4d722af1014f..3cc89bb624f0 100644
> --- a/fs/efivarfs/vars.c
> +++ b/fs/efivarfs/vars.c
> @@ -295,9 +295,9 @@ static bool variable_is_present(efi_char16_t *variable_name, efi_guid_t *vendor,
>         unsigned long strsize1, strsize2;
>         bool found = false;
>
> -       strsize1 = ucs2_strsize(variable_name, 1024);
> +       strsize1 = ucs2_strsize(variable_name, EFI_VAR_NAME_LEN);
>         list_for_each_entry_safe(entry, n, head, list) {
> -               strsize2 = ucs2_strsize(entry->var.VariableName, 1024);
> +               strsize2 = ucs2_strsize(entry->var.VariableName, EFI_VAR_NAME_LEN);
>                 if (strsize1 == strsize2 &&
>                         !memcmp(variable_name, &(entry->var.VariableName),
>                                 strsize2) &&
> @@ -396,6 +396,7 @@ int efivar_init(int (*func)(efi_char16_t *, efi_guid_t, unsigned long, void *,
>
>         do {
>                 variable_name_size = 512;
> +               BUILD_BUG_ON(EFI_VAR_NAME_LEN < 512);
>
>                 status = efivar_get_next_variable(&variable_name_size,
>                                                   variable_name,
> diff --git a/include/linux/efi.h b/include/linux/efi.h
> index c74f47711f0b..62f552057b06 100644
> --- a/include/linux/efi.h
> +++ b/include/linux/efi.h
> @@ -1065,12 +1065,11 @@ static inline u64 efivar_reserved_space(void) { return 0; }
>  #endif
>
>  /*
> - * The maximum size of VariableName + Data = 1024
> - * Therefore, it's reasonable to save that much
> - * space in each part of the structure,
> - * and we use a page for reading/writing.
> + * There is no actual upper limit specified for the variable name size.
> + *
> + * This limit exists only for practical purposes, since name conversions
> + * are bounds-checked and name data is occasionally stored in-line.
>   */
> -
>  #define EFI_VAR_NAME_LEN       1024
>
>  int efivars_register(struct efivars *efivars,
> --
> 2.44.0
>

