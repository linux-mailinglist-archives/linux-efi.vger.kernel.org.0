Return-Path: <linux-efi+bounces-3838-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FA73AE0A87
	for <lists+linux-efi@lfdr.de>; Thu, 19 Jun 2025 17:33:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A540B1895AFD
	for <lists+linux-efi@lfdr.de>; Thu, 19 Jun 2025 15:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC59623505C;
	Thu, 19 Jun 2025 15:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HlTxmzcP"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71E421C18C
	for <linux-efi@vger.kernel.org>; Thu, 19 Jun 2025 15:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750347005; cv=none; b=VGlyx0sByDfp7dnCX3CjfTNiIRZZ4HozaRyBi7yY1TAVDGMhWFrUSaZW82Vw+FfyfbWuDOS1Cs7WPuEOTFnyeuSqvAmiqNe7Ra1oZb74EkQHfeFrjP0begnO2dfnHbGkffwIOMmn7bBVukdSYh/eZESaVCgVoo2jy5vIy4NmqtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750347005; c=relaxed/simple;
	bh=hF5A7pr0z0J9a0f2vBCryRsZLF0JK/ThvIjxm6xgYuY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jdBOgAyYhKiHOxEDzIrb4ncVa1kk08+jWwCnm9uhpBvgfY4FXVB5oR3B1P3WZftJ3CgL1gUDPw39Cv98r7q5EQBzkSR4K85h4EMRNY3/dYiNrWc/StlEhZeQB4EVLTU27PoGYRYpizpHQj2Psb6vUy2Am0O4cGb4sKwPDmYQRF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HlTxmzcP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4144EC4CEEA
	for <linux-efi@vger.kernel.org>; Thu, 19 Jun 2025 15:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750347005;
	bh=hF5A7pr0z0J9a0f2vBCryRsZLF0JK/ThvIjxm6xgYuY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=HlTxmzcPptpInHN7bCAAhF1QeQ4RuBIraSHBA7r6R2xHV2ffqNED4o9ZlClYyMtfw
	 QU+UninP3f81lG7fK6zBn+WSxKx5PT7QO514TdyKecaU0XW5o/9GLHWRtTjko8VvZE
	 BVgpHgMHCY/K3tSL0Hrk7a0lSrsKe+FMNzKlu7gQ2e4tKBDsJzcsIfFfxq6RzbwwrM
	 mIkNOsrIP0oPQZq49zFsc1p3nxE4RMCAH8CAdk0VQ0/0+a/ZOChHU6j077a6lDO2ou
	 G6UMlle6NS+wCvsi4lM4fN7C+o4lCRfKO+f05EjehcxwrqT1YpTyBbI+mkmvajLWze
	 TCKXJ+xQMIsbg==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-54e98f73850so819586e87.1
        for <linux-efi@vger.kernel.org>; Thu, 19 Jun 2025 08:30:05 -0700 (PDT)
X-Gm-Message-State: AOJu0YxjOY2c1sTeWBbwxvQEXw+MSTL7Vb2HbLJcfeXfaS1Zp8xLPOeH
	MGQM5e5yUPIF9Dy1DEqqN/jYiEjxlaNLF90NcKxiEx0z2t3fwHuaf4stPaa8Fip73yZjk7UCnKI
	xF5s4ZxWn4CvxribXIQrJZb++8JcdPgI=
X-Google-Smtp-Source: AGHT+IFhJZXg1HgkOXEU1npc8Ji+qFyhIqywvzpKHILwh0pMQM8QfFqizoDf1U/VmlEAc8RQxWl5hxUR6ID+Fe2rU84=
X-Received: by 2002:a05:6512:ac4:b0:553:2868:6362 with SMTP id
 2adb3069b0e04-553b6f0fc0dmr5670453e87.26.1750347003636; Thu, 19 Jun 2025
 08:30:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250618122008.264294-1-vkuznets@redhat.com>
In-Reply-To: <20250618122008.264294-1-vkuznets@redhat.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 19 Jun 2025 17:29:51 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEB7TSF2hUFqwxzdxca6YuCTbQ9fZv1KBf917=FVCvTgA@mail.gmail.com>
X-Gm-Features: AX0GCFvQE851RSWsS9EsfjfBoXa6p1pwEVN8SSGXLjmYJD36A8sT8dgD-Ca47SM
Message-ID: <CAMj1kXEB7TSF2hUFqwxzdxca6YuCTbQ9fZv1KBf917=FVCvTgA@mail.gmail.com>
Subject: Re: [PATCH] efi: Fix .data section size calculations when .sbat is present
To: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: linux-efi@vger.kernel.org, Peter Jones <pjones@redhat.com>, 
	Gerd Hoffmann <kraxel@redhat.com>, Heinrich Schuchardt <heinrich.schuchardt@gmx.de>
Content-Type: text/plain; charset="UTF-8"

On Wed, 18 Jun 2025 at 14:20, Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>
> Commit 0f9a1739dd0e ("efi: zboot specific mechanism for embedding SBAT
> section") neglected to adjust the sizes of the .data section when
> CONFIG_EFI_SBAT_FILE is set. As the result, the produced PE binary is
> incorrect and some tools complain about it. E.g. 'sbsign' reports:
>
>  # sbsign --key my.key --cert my.crt arch/arm64/boot/vmlinuz.efi
>  warning: file-aligned section .data extends beyond end of file
>  warning: checksum areas are greater than image size. Invalid section table?
>
> Note, '__data_size' was also used in the PE optional header. The field is
> supposed to reflect "The size of the initialized data section, or the sum
> of all such sections if there are multiple data sections.". While OVMF
> based firmware doesn't seem to care much about what's there, it sounds like
> including .sbat in the calculation is more correct.
>
> Fixes: 0f9a1739dd0e ("efi: zboot specific mechanism for embedding SBAT section")
> Reported-by: Heinrich Schuchardt <heinrich.schuchardt@gmx.de>
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  drivers/firmware/efi/libstub/zboot-header.S | 2 +-
>  drivers/firmware/efi/libstub/zboot.lds      | 6 ++++--
>  2 files changed, 5 insertions(+), 3 deletions(-)
>

Thanks for the fix.

> diff --git a/drivers/firmware/efi/libstub/zboot-header.S b/drivers/firmware/efi/libstub/zboot-header.S
> index b6431edd0fc9..65df5f52e138 100644
> --- a/drivers/firmware/efi/libstub/zboot-header.S
> +++ b/drivers/firmware/efi/libstub/zboot-header.S
> @@ -41,7 +41,7 @@ __efistub_efi_zboot_header:
>         .short          .Lpe_opt_magic
>         .byte           0, 0
>         .long           _etext - .Lefi_header_end
> -       .long           __data_size
> +       .long           __all_data_size

Frankly, I'm not sure if this is even worth the hassle.

There is also a 'size of uninitialized data' field, but given that the
.data section has both initialized data and uninitialized data, and
the fact that no loaders appear to care about these fields, let's just
not bother.


>         .long           0
>         .long           __efistub_efi_zboot_entry - .Ldoshdr
>         .long           .Lefi_header_end - .Ldoshdr
> diff --git a/drivers/firmware/efi/libstub/zboot.lds b/drivers/firmware/efi/libstub/zboot.lds
> index 4b8d5cd3dfa2..f423204fba0f 100644
> --- a/drivers/firmware/efi/libstub/zboot.lds
> +++ b/drivers/firmware/efi/libstub/zboot.lds
> @@ -58,6 +58,8 @@ SECTIONS
>  PROVIDE(__efistub__gzdata_size =
>                 ABSOLUTE(__efistub__gzdata_end - __efistub__gzdata_start));
>
> -PROVIDE(__data_rawsize = ABSOLUTE(_edata - _etext));
> -PROVIDE(__data_size = ABSOLUTE(_end - _etext));
> +PROVIDE(__data_rawsize = ABSOLUTE(_edata - _data));
> +PROVIDE(__data_size = ABSOLUTE(_end - _data));
> +/* The sum of all data sections, i.e. .data and .sbat */
> +PROVIDE(__all_data_size = ABSOLUTE(_end - _etext));
>  PROVIDE(__sbat_size = ABSOLUTE(_esbat - _sbat));
> --
> 2.49.0
>

