Return-Path: <linux-efi+bounces-1937-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C263A99B1C9
	for <lists+linux-efi@lfdr.de>; Sat, 12 Oct 2024 09:46:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D495B21103
	for <lists+linux-efi@lfdr.de>; Sat, 12 Oct 2024 07:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D87C12C52E;
	Sat, 12 Oct 2024 07:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pDF6pTAL"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B58BA49;
	Sat, 12 Oct 2024 07:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728719200; cv=none; b=hx3Ym3Obgo39KlbuY2wvpHRScXCrwYfuTu9lt1R5hSYBeFJgh7RUWPZ4Q3BLmfAETHmsCGJffrlLUmXnFWLEWLL7eo9VHANba4Xufjg1FZe2RBi3NlRzkh2Aq16M0lebPqu3mAHzOpLDnXO8Ys486MqPeqstEMUOYIbTM+Dzd+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728719200; c=relaxed/simple;
	bh=ZRUPD3J8aGBN9PhWgl4X4vTWVI4Rql4Z5FPqGSDuWXQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rgQhCof6Tx6OWNE9fqoR5sM0nIT7004Uq3O+kPNvJDrYZz93GlzZA+6ndMXTFIYoj5Vb7UeAMIX1CK/hROskuKD/uWvcbT6469Fo4S4X9YDcGHBR8kDZxYJWbIQr4UgLdsxSJ4Fw1Ht9bK9s0mjtCfIIQL4xCM3uSjXh5rzjjcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pDF6pTAL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68E12C4CEC6;
	Sat, 12 Oct 2024 07:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728719199;
	bh=ZRUPD3J8aGBN9PhWgl4X4vTWVI4Rql4Z5FPqGSDuWXQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=pDF6pTALXXbeVwEg5+fo/ScLVEQBWTMziwo6PQ+Lyj1k7q+BWd0f3etn7JYMaLXN2
	 ZB+PN5HYKcVjIZS4RS5yVCXRng1zWS7tvAPin5lm+6R+W2rZ19zokl2JAX17RCoOCB
	 en8B1Kbw42nPdUjgAMJwPLZZTjhteM2aTx9zQKJBUFUUceMIEguZZjWaB3UWvY3Wj5
	 a+2O/7MHeJDgWm3anYFaTHNrF5fMAdbgnraIRQpud3fKfp8S9uHxsHAlb01x5KI2wa
	 kWRjgxQou6SFIWghFeUbXjHTX8twdKl5ZT46oybth5YvyT7vpt7UPT99p5aDV7gzx9
	 k2qA1yKWDAGrA==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-539983beb19so3175752e87.3;
        Sat, 12 Oct 2024 00:46:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWP2jTDBRs8rYpdIlTXODomi+K84JlKb1lp2YICV0SgzbMK8ihjG+JkaOmSyI7PV9TTwXlDxg/0/jNKS5w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxL9DNo5ijUD/SAIMPiXW4txbNJNzDHsqDlmevG2UVu0D6AWyn5
	P/D6qDRxG/5DlueBIfMNoYSTD5FXHaAut7uaIJO6g0ko+qwh1ALuvbpexn7ohZYBWxVEFfJj9t5
	ciyM/cVRRfAzs3N47itKumu18eBM=
X-Google-Smtp-Source: AGHT+IFkMBrz+ODy9n+spcrU6olNgVKm3dqbV8KAo+qP2OgqmN1QBqy6/nJBr23w5YW6QcBdNsrAxPU3bkoT3PlvgGU=
X-Received: by 2002:a05:6512:6c2:b0:539:9505:7e5 with SMTP id
 2adb3069b0e04-539da5017a9mr2605565e87.36.1728719197818; Sat, 12 Oct 2024
 00:46:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241011224812.25763-1-jonathan@marek.ca>
In-Reply-To: <20241011224812.25763-1-jonathan@marek.ca>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Sat, 12 Oct 2024 09:46:26 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFstg+2j9nYCO=_=L3LAd4PYc5vO3OX4EtHfFA90BXv5Q@mail.gmail.com>
Message-ID: <CAMj1kXFstg+2j9nYCO=_=L3LAd4PYc5vO3OX4EtHfFA90BXv5Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] efi/libstub: fix efi_parse_options() ignoring the
 default command line
To: Jonathan Marek <jonathan@marek.ca>
Cc: linux-efi@vger.kernel.org, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, Ingo Molnar <mingo@kernel.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Jonathan,

Please use a cover letter when sending more than a single patch.

On Sat, 12 Oct 2024 at 00:51, Jonathan Marek <jonathan@marek.ca> wrote:
>
> efi_convert_cmdline() always returns a size of at least 1 because it counts
> the NUL terminator, so the "cmdline_size == 0" condition is not possible.
>
> Change it to compare against 1 to get the intended behavior: to use
> CONFIG_CMDLINE when load_options_size is 0.
>
> Fixes: 60f38de7a8d4 ("efi/libstub: Unify command line param parsing")
> Signed-off-by: Jonathan Marek <jonathan@marek.ca>
> ---
>  drivers/firmware/efi/libstub/efi-stub.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/firmware/efi/libstub/efi-stub.c b/drivers/firmware/efi/libstub/efi-stub.c
> index 958a680e0660d..709ae2d41a632 100644
> --- a/drivers/firmware/efi/libstub/efi-stub.c
> +++ b/drivers/firmware/efi/libstub/efi-stub.c
> @@ -129,7 +129,7 @@ efi_status_t efi_handle_cmdline(efi_loaded_image_t *image, char **cmdline_ptr)
>
>         if (IS_ENABLED(CONFIG_CMDLINE_EXTEND) ||
>             IS_ENABLED(CONFIG_CMDLINE_FORCE) ||
> -           cmdline_size == 0) {
> +           cmdline_size == 1) {

I'd prefer it if we could keep the weirdness local to
efi_convert_cmdline(). Would the below fix things too?

--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -395,9 +395,7 @@
                }
        }

-       options_bytes++;        /* NUL termination */
-
-       status = efi_bs_call(allocate_pool, EFI_LOADER_DATA, options_bytes,
+       status = efi_bs_call(allocate_pool, EFI_LOADER_DATA, options_bytes + 1,
                             (void **)&cmdline_addr);
        if (status != EFI_SUCCESS)
                return NULL;

Note that the only other caller of efi_convert_cmdline() in x86-stub.c
ignores this value entirely.

