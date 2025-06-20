Return-Path: <linux-efi+bounces-3844-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C262AE1A21
	for <lists+linux-efi@lfdr.de>; Fri, 20 Jun 2025 13:39:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A95A8188E32B
	for <lists+linux-efi@lfdr.de>; Fri, 20 Jun 2025 11:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 014F528A1F5;
	Fri, 20 Jun 2025 11:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tfhSYPMu"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B90289E1B;
	Fri, 20 Jun 2025 11:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750419551; cv=none; b=VdxFMnNzGgn9yKIe/aKiRr5s8h4S6/vj29xpylCPy8HR2yi6cSfY7WtDJZ6VOuMISAW1ez2NxuaQcCNTXtINswxU1vn0E0WGESdW+UKBX5BZ+zP7FkNpgdx9KPCMjK8Dlx6OtmIEs85gpi5osJpW0ZPV3zpsh4tGSKW08F8KSvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750419551; c=relaxed/simple;
	bh=wlMSg2riugAfkN85IR0d+QwxYeOTHn4R4XxsXr3+82I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q8iqsvbYY+QJeAP+h5FE6ho85yV0hM5viyO6RMv/1bUuPMTYS/DJS6P+yy9n3ZMaaP8LlB8WRLTrwOSbZOYRnAgMGWeKVKNF3G1LyDgzG0DlDckVO39zQesNjkBFYXBTWtGLrh+zn5G8vTLvuNCqXP22QrYZQHnB8AqjQmximOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tfhSYPMu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C154C4CEE3;
	Fri, 20 Jun 2025 11:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750419551;
	bh=wlMSg2riugAfkN85IR0d+QwxYeOTHn4R4XxsXr3+82I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=tfhSYPMufvABKiFV/9fY8FJUQu2RGHa7314EGdcvwvKRV/HR+kLV5fuf90UfIJWYc
	 7ST7sXuTt2cEKvHPBW5j04HroR54BA2sxX5YTzDS8pV5MY22yooE3AKwP77SKVmal4
	 jXy67ke1l/6C2+fIxU+suWkeh9g6LyAu8uDpTxj9Ib9LkHApjLL/f+EBwpu/rPLfSp
	 6sIyokJrHWKcdEdUGgt4CBF0VxOITrk3sdYHx52XxB7ARX3FzvcePHwThFaG2J7lNE
	 gF4aaN9i9z9+CdhyiGglZtKL/ZXDXHs4JW1XiEPb3C3pk2UYt4ViwGlv6w60MhuFm7
	 QbdVHbuj64tpw==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-32b435ef653so15905741fa.2;
        Fri, 20 Jun 2025 04:39:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVgw7MCv818aVSXCBh/F3veBTGGaPaIfloShQxTAto6JJe/fdUPtLKUVEtaSplIpn7NEnUDtph/JhdquWU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0d8DI8Iqi1bTTAM5SUdJ9RTIS9x3zcrvHeayBZnvDZzXBk/UY
	ENmbieoSfiUSwf4qQ4E16LrZGPuNbM/T7notvMhFqOrK/5PThoCimd2eauVP/E1yNiVO7G1WjHF
	tMxYCgxQIxElCxoV3Nz7E04WMkabnjYk=
X-Google-Smtp-Source: AGHT+IFS6pYf1hoEDVGPVtohGNV2l8Me/be+PTgIC1679iU9mPhI9K4uWXdozzPLGEskHfgZ0nrLVH9A8nSFOVSp7/I=
X-Received: by 2002:a05:6512:3f10:b0:553:522f:61bb with SMTP id
 2adb3069b0e04-553e3b9a494mr1057793e87.12.1750419549990; Fri, 20 Jun 2025
 04:39:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250620111607.984534-1-vkuznets@redhat.com>
In-Reply-To: <20250620111607.984534-1-vkuznets@redhat.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 20 Jun 2025 13:38:56 +0200
X-Gmail-Original-Message-ID: <CAMj1kXESncEk_gtG_CV7XnMJTnZWEOs+Dj8jMHzsvuFvyOsLLw@mail.gmail.com>
X-Gm-Features: AX0GCFuuhr8MQbjwRSlAcE07yepOSaP-QcfzpK6ASqV62EM63LWxHnwJ05Z9SqQ
Message-ID: <CAMj1kXESncEk_gtG_CV7XnMJTnZWEOs+Dj8jMHzsvuFvyOsLLw@mail.gmail.com>
Subject: Re: [PATCH v2] efi: Fix .data section size calculations when .sbat is present
To: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: linux-efi@vger.kernel.org, Peter Jones <pjones@redhat.com>, 
	Gerd Hoffmann <kraxel@redhat.com>, Heinrich Schuchardt <heinrich.schuchardt@gmx.de>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 20 Jun 2025 at 13:16, Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
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
> Note, '__data_size' is also used in the PE optional header and it is not
> entirely clear whether .sbat needs to be accounted as part of
> SizeOfInitializedData or not. As the header seems to be unused by the real
> world firmware, keeping the field equal to __data_size.
>
> Fixes: 0f9a1739dd0e ("efi: zboot specific mechanism for embedding SBAT section")
> Reported-by: Heinrich Schuchardt <heinrich.schuchardt@gmx.de>
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
> Changes in v2: drop PE optional header adjustment [Ard]
> ---
>  drivers/firmware/efi/libstub/zboot.lds | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/firmware/efi/libstub/zboot.lds b/drivers/firmware/efi/libstub/zboot.lds
> index 4b8d5cd3dfa2..367907eb7d86 100644
> --- a/drivers/firmware/efi/libstub/zboot.lds
> +++ b/drivers/firmware/efi/libstub/zboot.lds
> @@ -58,6 +58,6 @@ SECTIONS
>  PROVIDE(__efistub__gzdata_size =
>                 ABSOLUTE(__efistub__gzdata_end - __efistub__gzdata_start));
>
> -PROVIDE(__data_rawsize = ABSOLUTE(_edata - _etext));
> -PROVIDE(__data_size = ABSOLUTE(_end - _etext));
> +PROVIDE(__data_rawsize = ABSOLUTE(_edata - _data));
> +PROVIDE(__data_size = ABSOLUTE(_end - _data));
>  PROVIDE(__sbat_size = ABSOLUTE(_esbat - _sbat));
> --
> 2.49.0
>
>

Thanks, I've queued this up now.

