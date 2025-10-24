Return-Path: <linux-efi+bounces-5121-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B03C056B7
	for <lists+linux-efi@lfdr.de>; Fri, 24 Oct 2025 11:48:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CC9A1B86D04
	for <lists+linux-efi@lfdr.de>; Fri, 24 Oct 2025 09:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3078D30CD8D;
	Fri, 24 Oct 2025 09:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tso8acEI"
X-Original-To: linux-efi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB0823D7D1
	for <linux-efi@vger.kernel.org>; Fri, 24 Oct 2025 09:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761299252; cv=none; b=WjNp3pukbaX+ecwiifc+4GB4saLBUj5/M6Dob8FjDmAd3ItCGcA4IK8s6QlLU0FYX8h6QBINRU9qFKdK05KHXfej+s8s3PQNaLwWLIIbO8v3e5sj0AIzb6Xsc50F/nA6tZiD9i5Fx0VZ8kmPK2+a2mhQdlzBER1xwF/Gn2ei8IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761299252; c=relaxed/simple;
	bh=OVet1b2OltvYAT+J+4amsp/J07NrS8O/OQvynNik4js=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WaNCxZ822JeKiAU8cC3uYNDZxFEEVMB+a2snXQ6OkyxhBvw2aUP9+PGuKjE9WiXsnj6RunYQWM18K/pw+t8GsptDjFJeD7Hn9rHcJ+yl5vcK4emA287kequQ5jM8cPCJUGa1Khr4d5oM8DtblvJH0UTPe1p3xze6+/j9uPtgYJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Tso8acEI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761299248;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ArSephldfLwUPIZOEFTFAJsyT1UDLuvR2xDhoRsVk7I=;
	b=Tso8acEImYW1u95sTyeLP3vnN4lU4WK0awg5YB9cU+S7D9IbVQRgGnlC0ksfHt9TcW/jlM
	ghQltQOg9aTjjeCvXIcx6pOLIhyMDsWX24L3+zPHmNkOFhYw38R6K5eq5uXjsAeO64NIbH
	W/ai1FnTEE9Aqg9fZIVxzxPdLzdX7e0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-541-Kop32N41Me-guANwWpHL3w-1; Fri, 24 Oct 2025 05:47:27 -0400
X-MC-Unique: Kop32N41Me-guANwWpHL3w-1
X-Mimecast-MFC-AGG-ID: Kop32N41Me-guANwWpHL3w_1761299246
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-47111dc7c35so14622285e9.2
        for <linux-efi@vger.kernel.org>; Fri, 24 Oct 2025 02:47:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761299246; x=1761904046;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ArSephldfLwUPIZOEFTFAJsyT1UDLuvR2xDhoRsVk7I=;
        b=CmaHAkwW2mlLqpa4JuHO3R7prklR3fA+xoCuK6NzlstJwqKaAS3xSFioQdJX+4M9xN
         +xvFRfdL11qoIU/dKoYdupxOPF/tZcVqeuncHBQTZUFpykOUZD4m4K//cpWZv2WjMaT/
         kbmtLnZTmBNzG19DNPts4C/js00tPKoKcBTlWGdZRWkllIJtW9jwc18/9n8C77P/baGM
         uTBd6OSkJmuOzrgTLgBgxhwvJG+ZVQw2TlaX5aF92rqylgS3+cwdgOjRj+tA1cnagyWX
         vSOhyeTCtT+X2ayvL4kCjOX2nMWVM6XUgHOyu2N3HjsJRiH8ys3yrvjljOV6SSS3tfMa
         FEEQ==
X-Gm-Message-State: AOJu0YytAfHmMq37DoNR3HQ4msgQ+oA92YDL75J7mmzLCJ60QOw21Dh+
	OWeDJVXHWLF7NstPBJNlWW7lP2YIG2LGW1BonraqRqQLUYkq4kyC6KU9Ka0sP1wEy4qMLs5J24O
	dd3CJdFJSMFj+4IG9fUh8l1ZSYOvtyBh/Fc+RrYywL1S+apmDsNUQg3rTJCdWLA==
X-Gm-Gg: ASbGnctfT6mvkGdDSEBr7RkXhJCYreHtQS3Iy5WRLnB1hwUhxufLGtKrQn+emX58VLu
	3TuHeezTCexZbu/pJ5IXDr3QTJV2OSvLK66Un9PgPZgw8ZyvdvXikaX14b4R7A9CTA9jND4CnG/
	8sIO7NIFuCR6yLqhyzbY8uqIwiyZ1q6X2XockeiLsEVkfsmhre/c4LEbI4cpGPXX4LVZHl97fgD
	7blN3xzPp1l7zK4/hIugFX1CuhorZIz/BpBaw5U+3FM4Mpt3yoDT/eK6Iiimo8iH+gGwTGNd0fL
	38iu4fjd3J+T2KrwA5C6PXjTx7gmDiBbBtq6hCnZv/TJU66dQYuNat3ME4he3fRwdgZTmFFVwg+
	z1Li3JDQmii5y0ESM63L0CN68eaCjEvTUUqHSJhrog8VwPw+gBr9eQ3+kFg==
X-Received: by 2002:a05:600c:628f:b0:46f:b32e:5292 with SMTP id 5b1f17b1804b1-475d2e78ebcmr17247995e9.8.1761299246175;
        Fri, 24 Oct 2025 02:47:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEvkiM5n2goHpw250gyY/q1kAO+69ianJVaDlPPHq7N60XvGZtLDRIfaJsJf8t7LldVbkuQMA==
X-Received: by 2002:a05:600c:628f:b0:46f:b32e:5292 with SMTP id 5b1f17b1804b1-475d2e78ebcmr17247715e9.8.1761299245713;
        Fri, 24 Oct 2025 02:47:25 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429898cce3bsm8302856f8f.38.2025.10.24.02.47.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 02:47:25 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, ardb@kernel.org, jonathan@marek.ca
Cc: linux-efi@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 2/5] efi/libstub: gop: Find GOP handle instead of GOP data
In-Reply-To: <20251015160816.525825-3-tzimmermann@suse.de>
References: <20251015160816.525825-1-tzimmermann@suse.de>
 <20251015160816.525825-3-tzimmermann@suse.de>
Date: Fri, 24 Oct 2025 11:47:24 +0200
Message-ID: <87wm4k8wcz.fsf@ocarina.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Zimmermann <tzimmermann@suse.de> writes:

> The device handle of the GOP device is required to retrieve the
> correct EDID data. Find the handle instead of the GOP data. Still
> return the GOP data in the function arguments, as we already looked
> it up.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>  drivers/firmware/efi/libstub/gop.c | 27 +++++++++++++++++----------
>  1 file changed, 17 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/firmware/efi/libstub/gop.c b/drivers/firmware/efi/libstub/gop.c
> index 3785fb4986b4..fd32be8dd146 100644
> --- a/drivers/firmware/efi/libstub/gop.c
> +++ b/drivers/firmware/efi/libstub/gop.c
> @@ -402,12 +402,13 @@ setup_pixel_info(struct screen_info *si, u32 pixels_per_scan_line,
>  	}
>  }
>  
> -static efi_graphics_output_protocol_t *find_gop(unsigned long num,
> -						const efi_handle_t handles[])
> +static efi_handle_t find_handle_with_primary_gop(unsigned long num, const efi_handle_t handles[],
> +						 efi_graphics_output_protocol_t **found_gop)
>  {
>  	efi_graphics_output_protocol_t *first_gop;
> -	efi_handle_t h;
> +	efi_handle_t h, first_gop_handle;
>  
> +	first_gop_handle = NULL;
>  	first_gop = NULL;
>

I think the logic of this function could be simplified if you remove some
of the variables. For example, I don't think you need a fist_gop variable
anymore now that you are passing a found_gop variable as a function param.

>  	for_each_efi_handle(h, handles, num) {
> @@ -442,19 +443,25 @@ static efi_graphics_output_protocol_t *find_gop(unsigned long num,
>  		 */
>  		status = efi_bs_call(handle_protocol, h,
>  				     &EFI_CONSOLE_OUT_DEVICE_GUID, &dummy);
> -		if (status == EFI_SUCCESS)
> -			return gop;
> -
> -		if (!first_gop)
> +		if (status == EFI_SUCCESS) {
> +			if (found_gop)
> +				*found_gop = gop;
> +			return h;
> +		} else if (!first_gop_handle) {
> +			first_gop_handle = h;
>  			first_gop = gop;

You can just assign *found_gop = gop here...

> +		}
>  	}
>  
> -	return first_gop;
> +	if (found_gop)
> +		*found_gop = first_gop;

...and then this assignment won't be needed anynmore.

> +	return first_gop_handle;

Also, given that you are calling first_gop_handle to the variable to
store the first gop handle, I would for consistency name the parameter
fist_gop and just drop the local variable with the same name.

But I agree with the general logic of the patch, so regardless of what
you prefer to do:

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


