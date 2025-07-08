Return-Path: <linux-efi+bounces-4182-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEA69AFC148
	for <lists+linux-efi@lfdr.de>; Tue,  8 Jul 2025 05:19:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4B6B7A4CB6
	for <lists+linux-efi@lfdr.de>; Tue,  8 Jul 2025 03:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 614D2233D64;
	Tue,  8 Jul 2025 03:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AqUFzjF3"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DCA022FE15;
	Tue,  8 Jul 2025 03:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751944746; cv=none; b=hudP3TFTfUqnea5J7RTN20IJYwa5GLpeSVrH+RNWqWavUOzxe1YNmfEsOgXPJBF34unYY5T4oVq17L1KQvFM7EDdR5r/3IdYH2Vex9vgjFtUUc87UEGDLUhcpnd1DnzrJdjlL9RjnMSbn7vpsErjivHn4bKTq11mcrJl9MaIToU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751944746; c=relaxed/simple;
	bh=8NDk+I1a3VSOWF9fO8M5RCaQI/zdXTl7PcjpnESkpb8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gFYVqbD2HL/DmVlVtIS4/4itYQMyXMwgjMtF5legk2C0um/btX9zkxVozscvhCRiKA7qOEUCfyrCA5NDWKRjPLvMx35EyMCFFPGoK890LzmupfKT72agnXxarCXK2gKHJYW3jRSdmbTfLudFH0LNq3uXFxj478J9MkFgOWY/mZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AqUFzjF3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96A22C4CEF6;
	Tue,  8 Jul 2025 03:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751944745;
	bh=8NDk+I1a3VSOWF9fO8M5RCaQI/zdXTl7PcjpnESkpb8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=AqUFzjF3QVPJa7tu1iHs5me2odWP4ZHAcJtJvMqPM7yvkDGrXK38MEyy3JjLVe96k
	 LrBFi1QWR4kDD4SbQ+9tHDSbHAM6tcwfTx8OYtBOL/f9llh1pUyafoiDZVAqwP66E3
	 v5Yh7OcJfgbZtX1NjDmpMJ7M43AsjVakLrszfQsvm59nHPjnlDiNBR5mc3g/ql53T0
	 VptQ02EKvm4fyn42hhR4WxwFwj3EP7eW7X2TfYB00t7N8PSggE91xUeBybziE+MMSh
	 dKKMgBtqKdFxvv7Tbrcqu9eUvzcl2k4DVVPwGkMUnPerV4D4ibDPn+SeVUD61Jy81A
	 11U1lnb4vAnLg==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-55516abe02cso3853916e87.0;
        Mon, 07 Jul 2025 20:19:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU6DQYns/IKP7yAxyS2J+dgYksSTduDV+AGX3kOOjskw1Ba2W5o+mZK5QR6bXOOjaNQxkmggOf4RpsubwnZYA==@vger.kernel.org, AJvYcCVJp9j/mFHV2MTMBk6Qbqoxmlt4V2miy7AqYR5lpurvOaDvwfRG7mG2vQOxT9VAjlPEBp0LezlE6DAklOMA@vger.kernel.org, AJvYcCVMWDSjDGjV1CBCAgBlsn5Ry475aRi5SUpdxf/uc/CSX0MWvCMrdI8xEK0pkU5OsCptVJ/Hr37gaVV+@vger.kernel.org, AJvYcCW3xKwyxXCpt9MdFiTMmhKogoO7XQwD1TKACtPkl9HztXS9uDoVp++/VukaJMMYz0B95dYjK0MXBJRr@vger.kernel.org
X-Gm-Message-State: AOJu0YyX5OCZY+xJp7api+0pePPY2jRMdzLN63nTWgkPrXTelK9LLmEu
	cZ/OgejeSPkZp6ttpJnKxIcdsH0eaEjDPLuNw5ODEPmIWOFguqyAlCNOp+WEevyE1846S5KRrcm
	2D1kjS4iN7ha+iEFGZFpMLPuSonJUmxs=
X-Google-Smtp-Source: AGHT+IGvbXSHFQEmu9KySW2VKjlzReLbWNXccH/jW/03YsyONy30/49vibN95ETPJPHoofk70uksd2LDdhA+mi6mm3c=
X-Received: by 2002:a05:6512:340d:b0:553:2969:1d54 with SMTP id
 2adb3069b0e04-557f89b1acbmr355730e87.8.1751944743972; Mon, 07 Jul 2025
 20:19:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250624-more-qseecom-v3-0-95205cd88cc2@oss.qualcomm.com> <20250624-more-qseecom-v3-1-95205cd88cc2@oss.qualcomm.com>
In-Reply-To: <20250624-more-qseecom-v3-1-95205cd88cc2@oss.qualcomm.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 8 Jul 2025 13:18:52 +1000
X-Gmail-Original-Message-ID: <CAMj1kXGi55_bRD_Q4n6hKO6-fCUHrWfpKD29Rc+r+gv1odHm9w@mail.gmail.com>
X-Gm-Features: Ac12FXxCeYfV_TiBR5zCeFARm-H3LC_AZIXbKqNHVztOBDcfNmRsAK5SDEfPa-I
Message-ID: <CAMj1kXGi55_bRD_Q4n6hKO6-fCUHrWfpKD29Rc+r+gv1odHm9w@mail.gmail.com>
Subject: Re: [PATCH v3 1/8] efi: efivars: don't crash in efivar_set_variable{,_locked}
 in r/o case
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Maximilian Luz <luzmaximilian@gmail.com>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Johan Hovold <johan@kernel.org>, Steev Klimaszewski <steev@kali.org>, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 24 Jun 2025 at 12:14, Dmitry Baryshkov
<dmitry.baryshkov@oss.qualcomm.com> wrote:
>
> If efivar implementation doesn't provide write support, then calling
> efivar_set_variable() (e.g. when PM8xxx RTC driver tries to update the
> RTC offset) will crash the system. Prevent that by checking that
> set_variable callback is actually provided and fail with an
> EFI_WRITE_PROTECTED if it is not.
>
> Fixes: 472831d4c4b2 ("efi: vars: Add thin wrapper around EFI get/set variable interface")
> Reported-by: Johan Hovold <johan@kernel.org>
> Closes: https://lore.kernel.org/r/aFlps9iUcD42vN4w@hovoldconsulting.com
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
>  drivers/firmware/efi/vars.c | 2 ++
>  1 file changed, 2 insertions(+)
>

Acked-by: Ard Biesheuvel <ardb@kernel.org>

Feel free to merge this along with the rest of the series.

> diff --git a/drivers/firmware/efi/vars.c b/drivers/firmware/efi/vars.c
> index 3700e98697676d8e6f04f061f447391503f9abba..11c5f785c09364f61642d82416822cb2e1a027fd 100644
> --- a/drivers/firmware/efi/vars.c
> +++ b/drivers/firmware/efi/vars.c
> @@ -227,6 +227,8 @@ efi_status_t efivar_set_variable_locked(efi_char16_t *name, efi_guid_t *vendor,
>         setvar = __efivars->ops->set_variable_nonblocking;
>         if (!setvar || !nonblocking)
>                  setvar = __efivars->ops->set_variable;
> +       if (!setvar)
> +               return EFI_WRITE_PROTECTED;
>
>         return setvar(name, vendor, attr, data_size, data);
>  }
>
> --
> 2.39.5
>
>

