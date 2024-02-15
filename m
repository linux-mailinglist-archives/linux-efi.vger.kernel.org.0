Return-Path: <linux-efi+bounces-551-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A42E4855BE8
	for <lists+linux-efi@lfdr.de>; Thu, 15 Feb 2024 08:59:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C725C1C21A7F
	for <lists+linux-efi@lfdr.de>; Thu, 15 Feb 2024 07:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92FAA1118F;
	Thu, 15 Feb 2024 07:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CEYad3Pe"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C514BA37;
	Thu, 15 Feb 2024 07:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707983982; cv=none; b=d8p2UsGNkDZ6uLNt3oHjjy7fCRJT5OPXTYzEx+OogK5DmKjDmFHQgc3HaUw+mPOmnLAnS2e6fbI8yoWYxkQuVJS/Zm/ZwSGHDIGiaX/c9CipIqztlKj1oQuVxE0tPfq8XW3SjzjbA1wfcYF/wC/tM6ZHX3IX1aWIWdRrx0ucCNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707983982; c=relaxed/simple;
	bh=lglMDlZkFJKsCIT7Fn8mnC0sShe/3fOaUD6KwdKeRb4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RQhNgzrklGP/12xfVrv9u38GY8aKAeZUIQjIpjV4x8YE+XwbF2kZ7wR3jMzQUxF35pI78v/tEEF+IULpLFMaHqp48RUQuMuOmYPYCFbQapZZlQOvLw4fhYyD0vR+JqCycrR2TpEnHZbTQOfJsCZVjZTM8BgIixIbqDEGLaPJ5is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CEYad3Pe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0F6DC433A6;
	Thu, 15 Feb 2024 07:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707983981;
	bh=lglMDlZkFJKsCIT7Fn8mnC0sShe/3fOaUD6KwdKeRb4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=CEYad3Pec9rSmWPcYhdduNgmoa7KOhGjCI0MBxDg7AhPRC8sNL1DTZ/tqGc5Sb4/V
	 nUYef9ls3xuZTT8BD2qUJZphInbwGWoKoejY0HkhKGoToxxzxy712koyGEOSkvQnKy
	 CsfiJYgrfZGeLpwaHirxGD+uIirvYSDmo+Cc9elHJcXSTd6MC8nuduwJBbwdzF/rrM
	 9f4TbAphPqfEcpd3Unrvc72PbWm43zAscaXJQT4LPOV0Zk+S4Wr3CzErkLe8uTS31Q
	 vLSVtVt2UZspkYhZju46AepuPzW8elm1OLcb07F8K/1rPKJm2sJEu9gMY8pSDl1UIa
	 wJQX4cTjoJg4Q==
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2d180d6bd32so7178561fa.1;
        Wed, 14 Feb 2024 23:59:41 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWXuGQg+Pli6Px0P+FSwOyoHd4HRSoSSnX8go6KH3pbWJzaGKKOY6hN5VMo5UcUBV4cOvqaz54nNDsn0ljkTU6kOnbiUI3JAffD0OKCo7M1NUVV9xwWBTR15vTMB9Po9tBcmIpm93O+u6WR86tNkXk7kMqOa8T/Z4x7oqmcQSMDcaUFD9Zn7wlb5OVyh7dQBWZurepw7AoLZEdqUB3YCxN+v2TZ
X-Gm-Message-State: AOJu0YxAWSsQKTEHD702xTMeF6atQmItVV9wYuX0P5IqjDtmtNJFCqAN
	mXd3kZoiyu3JWZ754Y4AuoTl5ZYdJbEGqt2+CrcFVaogOtqKojUpk6XZ8jCwfvrCiGNj2CZfA6p
	n6E9UUT9mP+bBvwog66cFZuQ1z4o=
X-Google-Smtp-Source: AGHT+IE1UYvZkxI1EHEg3S8OzBox7W7fKR3c8y6QpY2+mbq0oQnr/WTTSEAnxqLhggjEtq/NwYteLwaSmzpeW6JkJSE=
X-Received: by 2002:a19:f70b:0:b0:512:55c8:da20 with SMTP id
 z11-20020a19f70b000000b0051255c8da20mr789212lfe.56.1707983979967; Wed, 14 Feb
 2024 23:59:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240214221847.2066632-1-ross.philipson@oracle.com> <20240214221847.2066632-4-ross.philipson@oracle.com>
In-Reply-To: <20240214221847.2066632-4-ross.philipson@oracle.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 15 Feb 2024 08:59:28 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHxvmHo-FWa8PXoZSTVyeSsgFyOaSuXP=2Bhj2YjxCALQ@mail.gmail.com>
Message-ID: <CAMj1kXHxvmHo-FWa8PXoZSTVyeSsgFyOaSuXP=2Bhj2YjxCALQ@mail.gmail.com>
Subject: Re: [PATCH v8 03/15] x86: Secure Launch Kconfig
To: Ross Philipson <ross.philipson@oracle.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, 
	linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-crypto@vger.kernel.org, kexec@lists.infradead.org, 
	linux-efi@vger.kernel.org, dpsmith@apertussolutions.com, tglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, hpa@zytor.com, dave.hansen@linux.intel.com, 
	mjg59@srcf.ucam.org, James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de, 
	jarkko@kernel.org, jgg@ziepe.ca, luto@amacapital.net, nivedita@alum.mit.edu, 
	herbert@gondor.apana.org.au, davem@davemloft.net, kanth.ghatraju@oracle.com, 
	trenchboot-devel@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 14 Feb 2024 at 23:31, Ross Philipson <ross.philipson@oracle.com> wrote:
>
> Initial bits to bring in Secure Launch functionality. Add Kconfig
> options for compiling in/out the Secure Launch code.
>
> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
> ---
>  arch/x86/Kconfig | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 5edec175b9bf..d96d75f6f1a9 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -2071,6 +2071,18 @@ config EFI_RUNTIME_MAP
>
>           See also Documentation/ABI/testing/sysfs-firmware-efi-runtime-map.
>
> +config SECURE_LAUNCH
> +       bool "Secure Launch support"
> +       default n

'n' is already the default, so you can drop this line.

> +       depends on X86_64 && X86_X2APIC

This depends on CONFIG_TCG_TPM as well (I got build failures without it)

> +       help
> +          The Secure Launch feature allows a kernel to be loaded
> +          directly through an Intel TXT measured launch. Intel TXT
> +          establishes a Dynamic Root of Trust for Measurement (DRTM)
> +          where the CPU measures the kernel image. This feature then
> +          continues the measurement chain over kernel configuration
> +          information and init images.
> +
>  source "kernel/Kconfig.hz"
>
>  config ARCH_SUPPORTS_KEXEC
> --
> 2.39.3
>

