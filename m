Return-Path: <linux-efi+bounces-5520-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A2F74C5F695
	for <lists+linux-efi@lfdr.de>; Fri, 14 Nov 2025 22:45:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 074B14F27D4
	for <lists+linux-efi@lfdr.de>; Fri, 14 Nov 2025 21:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F4A235C189;
	Fri, 14 Nov 2025 21:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NC0xxulK"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D2E35E52E
	for <linux-efi@vger.kernel.org>; Fri, 14 Nov 2025 21:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763156483; cv=none; b=RUDOEtbG4Hz2JmpIDCY+upX2VHdWmvjfMeCfYNTIeu/G0jk6FsXLQePQAdUWb5CJR6fcJacw/yi+perxtiD8+Pv/yKQDBWkI2yy3fXLqyT3mfKOnAD3d+tm7heyW9g21q8xG23wn9Eh3a/w9vVqKwvBVLmTNHf3GH01tdzA9yWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763156483; c=relaxed/simple;
	bh=870jrKcu3+KExQtVbENYeTTMwFI1maOpGdGAxr2Wqk8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bfAPZULsGDOdguQfpG8FxRJSVpQVqtqGduuTYaclQamqmMhiCJDUFUeiLJRp86vAYzbgMWAQcRttCdWx4DZQA94xmCtbktXxeUzJungi9YySDkN/8PWQReqFtiQ7Mf+rFTb7gPSn07ruYruVu5JESrkvB800Jp4UeloOhj8lKss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NC0xxulK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38657C2BC87
	for <linux-efi@vger.kernel.org>; Fri, 14 Nov 2025 21:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763156483;
	bh=870jrKcu3+KExQtVbENYeTTMwFI1maOpGdGAxr2Wqk8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=NC0xxulKy/jVNsKu2R/tGkPcaCYwklP3aCdr0YuDrqo9Xf1BMj70GHOVB/x7T13fc
	 qU1A3v1x9XrtQ0c8xSf8OADRSL5K+1urQOAVJ8cNeEFWEmjZVWuhBOkeHgTHS3ngF7
	 jPwhSztkgPhTT/qVJgpNxF1JOAD+uqtvQkTUQ+E26SxQOdFQXdCiDx3XnXXJNK8RU/
	 2Vw7bEWpXeohGB1XY4JvKXTth4xCsIuPQfdwZXqrSkdwpOdlWL6WCEqN90Ff14rvTh
	 zDzv9J/aQx+5IXxQlDqcehvahGXpC3GL/kFgcD/f9Vd4lnSaNFQaxQOOYp0INu0SqM
	 Y1o9ShchqWI9w==
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-37a5bc6b491so19170761fa.0
        for <linux-efi@vger.kernel.org>; Fri, 14 Nov 2025 13:41:23 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVmh8skwlntMcY4tkiGDDxP5xI4R/lR5EbidrYxHHr3D4uq8eJy89mMiLLDAo9DbgFILwCLneP3cOI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4Cy40eaCDKoZK9LIRHcT4TpnD9NnOznOevoivqcjaLm67VeEP
	VZ7rDZEVr7hP8mThg/U29Tn1UHiWzxbb+wYv/7SVz4hXOCA+qVo+4qi9FvTtNYivh+9+nVl8LPp
	AMx1EDkdWfnQNFWWWmO0/G9Ws7mX+U+Y=
X-Google-Smtp-Source: AGHT+IFe29zqo8gCkaVXCnGx37R00NX2gqT1LHiMtVBd28KTVWuGUdLf+hz9jkToQkMKok2Ij0Qi5JeaMuvCOyDXR+c=
X-Received: by 2002:a2e:8a98:0:b0:379:348:80da with SMTP id
 38308e7fff4ca-37babb5eed2mr11178121fa.8.1763156481579; Fri, 14 Nov 2025
 13:41:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251114085058.2195900-1-sumit.garg@kernel.org> <20251114085058.2195900-2-sumit.garg@kernel.org>
In-Reply-To: <20251114085058.2195900-2-sumit.garg@kernel.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 14 Nov 2025 22:41:10 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEsJMp8O-BckAoizDQRyirbZN+jYjYF9GGga4kd30em=A@mail.gmail.com>
X-Gm-Features: AWmQ_bn_38f2aWCNi1v3PYjks773oxLFEOd0gS6-DSalAed6w3PWFNsA8Tlp6A8
Message-ID: <CAMj1kXEsJMp8O-BckAoizDQRyirbZN+jYjYF9GGga4kd30em=A@mail.gmail.com>
Subject: Re: [PATCH 1/2] efi/reboot: Add support for EFI_RESET_PLATFORM_SPECIFIC
To: Sumit Garg <sumit.garg@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-efi@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, catalin.marinas@arm.com, will@kernel.org, 
	mark.rutland@arm.com, andersson@kernel.org, konradybcio@kernel.org, 
	dmitry.baryshkov@oss.qualcomm.com, shivendra.pratap@oss.qualcomm.com, 
	leif.lindholm@oss.qualcomm.com, linux-kernel@vger.kernel.org, 
	Sumit Garg <sumit.garg@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 14 Nov 2025 at 09:51, Sumit Garg <sumit.garg@kernel.org> wrote:
>
> From: Sumit Garg <sumit.garg@oss.qualcomm.com>
>
> UEFI specification provides support for EfiResetPlatformSpecific reset
> type as follows:
>
> "
> ResetSystem:
>
> Calling this interface with ResetType of EfiResetPlatformSpecific
> causes a system-wide reset. The exact type of the reset is defined
> by the EFI_GUID that follows the Null-terminated Unicode string passed
> into ResetData. If the platform does not recognize the EFI_GUID in
> ResetData the platform must pick a supported reset type to perform.
> The platform may optionally log the parameters from any non-normal
> reset that occurs.
> "
>
> Lets use the ResetData to pass the platform specific reboot command
> issued and leave it's interpretation to UEFI implementation following
> the specification.
>
> Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> ---
>  drivers/firmware/efi/reboot.c | 25 +++++++++++++++----------
>  include/linux/efi.h           |  5 +++--
>  2 files changed, 18 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/firmware/efi/reboot.c b/drivers/firmware/efi/reboot.c
> index ceae84c19d22..23a2fc68e9c9 100644
> --- a/drivers/firmware/efi/reboot.c
> +++ b/drivers/firmware/efi/reboot.c
> @@ -10,7 +10,7 @@ static struct sys_off_handler *efi_sys_off_handler;
>
>  int efi_reboot_quirk_mode = -1;
>
> -void efi_reboot(enum reboot_mode reboot_mode, const char *__unused)
> +void efi_reboot(enum reboot_mode reboot_mode, const char *data)
>  {
>         const char *str[] = { "cold", "warm", "shutdown", "platform" };
>         int efi_mode, cap_reset_mode;
> @@ -18,14 +18,18 @@ void efi_reboot(enum reboot_mode reboot_mode, const char *__unused)
>         if (!efi_rt_services_supported(EFI_RT_SUPPORTED_RESET_SYSTEM))
>                 return;
>
> -       switch (reboot_mode) {
> -       case REBOOT_WARM:
> -       case REBOOT_SOFT:
> -               efi_mode = EFI_RESET_WARM;
> -               break;
> -       default:
> -               efi_mode = EFI_RESET_COLD;
> -               break;
> +       if (data) {
> +               efi_mode = EFI_RESET_PLATFORM_SPECIFIC;
> +       } else {
> +               switch (reboot_mode) {
> +               case REBOOT_WARM:
> +               case REBOOT_SOFT:
> +                       efi_mode = EFI_RESET_WARM;
> +                       break;
> +               default:
> +                       efi_mode = EFI_RESET_COLD;
> +                       break;
> +               }
>         }
>
>         /*
> @@ -43,7 +47,8 @@ void efi_reboot(enum reboot_mode reboot_mode, const char *__unused)
>                 efi_mode = cap_reset_mode;
>         }
>
> -       efi.reset_system(efi_mode, EFI_SUCCESS, 0, NULL);
> +       efi.reset_system(efi_mode, EFI_SUCCESS, sizeof(data),

You cannot use sizeof() here - it will return the size of a pointer to
const char.


> +                        (efi_char16_t *)data);
>  }
>
>  bool __weak efi_poweroff_required(void)
> diff --git a/include/linux/efi.h b/include/linux/efi.h
> index a98cc39e7aaa..5324db1518b6 100644
> --- a/include/linux/efi.h
> +++ b/include/linux/efi.h
> @@ -256,6 +256,7 @@ typedef union efi_boot_services efi_boot_services_t;
>  #define EFI_RESET_COLD 0
>  #define EFI_RESET_WARM 1
>  #define EFI_RESET_SHUTDOWN 2
> +#define EFI_RESET_PLATFORM_SPECIFIC 3
>
>  /*
>   * EFI Runtime Services table
> @@ -874,7 +875,7 @@ static inline bool efi_enabled(int feature)
>  {
>         return test_bit(feature, &efi.flags) != 0;
>  }
> -extern void efi_reboot(enum reboot_mode reboot_mode, const char *__unused);
> +extern void efi_reboot(enum reboot_mode reboot_mode, const char *data);
>
>  bool __pure __efi_soft_reserve_enabled(void);
>
> @@ -895,7 +896,7 @@ static inline bool efi_enabled(int feature)
>         return false;
>  }
>  static inline void
> -efi_reboot(enum reboot_mode reboot_mode, const char *__unused) {}
> +efi_reboot(enum reboot_mode reboot_mode, const char *data) {}
>
>  static inline bool efi_soft_reserve_enabled(void)
>  {
> --
> 2.48.1
>

