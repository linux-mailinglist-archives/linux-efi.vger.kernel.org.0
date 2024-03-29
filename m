Return-Path: <linux-efi+bounces-899-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3BD1891472
	for <lists+linux-efi@lfdr.de>; Fri, 29 Mar 2024 08:43:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BF62281B23
	for <lists+linux-efi@lfdr.de>; Fri, 29 Mar 2024 07:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A3D040863;
	Fri, 29 Mar 2024 07:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sPcEgWwo"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0498440852
	for <linux-efi@vger.kernel.org>; Fri, 29 Mar 2024 07:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711698192; cv=none; b=lC9eLSGzd9lupc4vEn75ai7PbKdwjy320uvoFO8MTBDVU2ROmzLMo/KqfodGXPv1ZqVfK25JJruIX7slneBqZQZ/P7O+dNvWNe60AlkTHsVpFsJsix9thd0D5W1f5rammZvGiP703ccOWSJAJ0sZ5QPVxrgqooz+7RLuD2nEyII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711698192; c=relaxed/simple;
	bh=HfFqUDgblIGBsn6RpsswUShDOPxAIzQ5eDThIwAX51I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uvDIXKNyTiY7CFg+xj9TVzX9S85nmgKB6Y6HZg94NpcDGLGNax9ojcMGtxxNQO0vtPMIG7VHPPudgRkye6vrpRHtJCvIlf5K+phTPUYh+Zo8E5ff5AQz4cKZVMq7cEQEl3HZ4Crv2DKNdE8nBFiuqU+1KRCLfUyhhSe5QXdukn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sPcEgWwo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E983C433F1
	for <linux-efi@vger.kernel.org>; Fri, 29 Mar 2024 07:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711698191;
	bh=HfFqUDgblIGBsn6RpsswUShDOPxAIzQ5eDThIwAX51I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=sPcEgWwojctBaJ+vUVbGopL6WTJJuyXozZaIuGuTITX66e7jSl1c1sUCgipulDkky
	 VHjinuRdCfGq1G81oO/9JYWte0FKx1FrYHXEmc7vUDpnZJtzLLScA+aWWndW8zkukI
	 ysEGwsB6YEby2YdssSz37LSuw0YLwWLbKa4CbjGbrAAX4HfB3/wStdJPo5pCh34TrP
	 4jRKzf7TghsfW5U7NBZcmqoABAUgyn+J0gdQSEvN9RikYuKbuD/yOFBjmnYex83Q20
	 dY3Ig6Zq9NZ5elwa3giMdB0SLeosui3mSK8dlMGvtaoUt61juHXKna0mgBgnR2ZuAg
	 /k4GivUQbfsjQ==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-515a97846b5so1820134e87.2
        for <linux-efi@vger.kernel.org>; Fri, 29 Mar 2024 00:43:11 -0700 (PDT)
X-Gm-Message-State: AOJu0Yx5FcNZ3DQD7CfbawOG/th+jsDM9xHbWy8Kr/RvfLZBUfY1oWHB
	Jw5OGJs78gkZ54y3d+0OEpZ4F8x6OJ0Frk9WBghRlmbMvdYYoAyKSQp0c07gSbFoB4sgeY2klEd
	7YcyhzlSGIA5qaEdXyW4oUa/a72M=
X-Google-Smtp-Source: AGHT+IHT2Mr9UsDpvzOIAUOY/cA7k49yQ/8pcl7FlcoyMlkHKtLt2YxViaJx4iEhUPcvh2uQB/X8y9z7N6WUV2GdUZE=
X-Received: by 2002:a05:6512:400c:b0:513:2b35:2520 with SMTP id
 br12-20020a056512400c00b005132b352520mr1022850lfb.58.1711698189976; Fri, 29
 Mar 2024 00:43:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240315002616.422802-1-timschumi@gmx.de> <20240328205041.76812-1-timschumi@gmx.de>
 <20240328205041.76812-4-timschumi@gmx.de>
In-Reply-To: <20240328205041.76812-4-timschumi@gmx.de>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 29 Mar 2024 09:42:59 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGuQ2RCpyBdGfOsApT61syG=oeoNSUkmy3PCBnPkir8og@mail.gmail.com>
Message-ID: <CAMj1kXGuQ2RCpyBdGfOsApT61syG=oeoNSUkmy3PCBnPkir8og@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] efi: Clear up misconceptions about a maximum
 variable name size
To: Tim Schumacher <timschumi@gmx.de>
Cc: linux-efi@vger.kernel.org, Jeremy Kerr <jk@ozlabs.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 28 Mar 2024 at 22:51, Tim Schumacher <timschumi@gmx.de> wrote:
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

Thanks for resending. I've queued these up now.

> ---
> Changes from v1:
>  - None, resubmitted as part of a patch chain
> ---
>  drivers/firmware/efi/vars.c | 2 +-
>  fs/efivarfs/vars.c          | 5 +++--
>  include/linux/efi.h         | 9 ++++-----
>  3 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/firmware/efi/vars.c b/drivers/firmware/efi/vars.c
> index f654e6f6af873..4056ba7f34408 100644
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
> index 4d722af1014f2..3cc89bb624f07 100644
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
> index d59b0947fba08..418e555459da7 100644
> --- a/include/linux/efi.h
> +++ b/include/linux/efi.h
> @@ -1072,12 +1072,11 @@ static inline u64 efivar_reserved_space(void) { return 0; }
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

