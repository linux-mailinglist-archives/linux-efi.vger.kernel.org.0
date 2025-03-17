Return-Path: <linux-efi+bounces-3004-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FDA5A65040
	for <lists+linux-efi@lfdr.de>; Mon, 17 Mar 2025 14:08:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B4201887231
	for <lists+linux-efi@lfdr.de>; Mon, 17 Mar 2025 13:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D9A623AE96;
	Mon, 17 Mar 2025 13:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1e9fQ8VL"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B774238146;
	Mon, 17 Mar 2025 13:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742216920; cv=none; b=PjweWFcKJBarsUBBy+os0dCC0aVtVcxTpjNZ44/C28KDdYix3HrotGfXRi/AJTEsFu2+n+1FxqIMbxLOwx2tM2oJ2h/zJwz6NwfSP5uuHEr6eukHySGPj1IKnoFPWv3bJ1YjNx/9Y5XvmMvvjR66XgIliybKETaEa93CzWxRLOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742216920; c=relaxed/simple;
	bh=A2buZVyCTM/JLx3cksI2FxOC72ZMVKmlADsSnDNR/kk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VUOEAc+Y9BTHWoY/5zIZg8jzLbQcv0z34Rzs1DKIfNc4Z+cCP+b6feg+LZb70j14ond1+UmOJL9v4ipLB8Gyavd1JjnSaIoF3wN85chl+aFctqNGLbhIknq1fIpLHvkMlWvnR2uKEgH/ipjKxgBqAkZXujeSgpHiimjoC+rTgtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1e9fQ8VL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77510C4CEE3;
	Mon, 17 Mar 2025 13:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742216919;
	bh=A2buZVyCTM/JLx3cksI2FxOC72ZMVKmlADsSnDNR/kk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1e9fQ8VLMdvG0BUnk8W99h+nfmKSGbOZ4VwsxabWWPiErqHlcAWqjmhN2lyP+gvwp
	 R8VWYY+QIi+ghpcCVuDIvDDGLjP4k9RMJbEej69VO69kbuc+xPBLr4RuVQZU65TLeT
	 rE78qf0qIC7NdQc04B+uvDpVXOP5oPff+cDf5qzY=
Date: Mon, 17 Mar 2025 14:07:00 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-rtc@vger.kernel.org, linux-efi@vger.kernel.org
Subject: Re: [PATCH 4/9] rtc: efi: Transition to the faux device interface
Message-ID: <2025031755-simile-landside-e719@gregkh>
References: <20250317-plat2faux_dev-v1-0-5fe67c085ad5@arm.com>
 <20250317-plat2faux_dev-v1-4-5fe67c085ad5@arm.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250317-plat2faux_dev-v1-4-5fe67c085ad5@arm.com>

On Mon, Mar 17, 2025 at 10:13:16AM +0000, Sudeep Holla wrote:
> The EFI RTC driver does not require the creation of a platform device.
> Originally, this approach was chosen for simplicity when the driver was
> first implemented.
> 
> With the introduction of the lightweight faux device interface, we now
> have a more appropriate alternative. Migrate the driver to utilize the
> faux bus, given that the platform device it previously created was not
> a real one anyway. This will simplify the code, reducing its footprint
> while maintaining functionality.
> 
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Cc: linux-rtc@vger.kernel.org
> Cc: linux-efi@vger.kernel.org
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  drivers/firmware/efi/efi.c |  3 ---
>  drivers/rtc/rtc-efi.c      | 31 ++++++++++++++++++++++---------
>  2 files changed, 22 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> index eec173cb1f398d3b4f28b42c917e50e1728dc277..18deb2d212ce6944927f5e3a9a40bb6754e7ffa9 100644
> --- a/drivers/firmware/efi/efi.c
> +++ b/drivers/firmware/efi/efi.c
> @@ -427,9 +427,6 @@ static int __init efisubsys_init(void)
>  		}
>  	}
>  
> -	if (efi_rt_services_supported(EFI_RT_SUPPORTED_TIME_SERVICES))
> -		platform_device_register_simple("rtc-efi", 0, NULL, 0);
> -
>  	/* We register the efi directory at /sys/firmware/efi */
>  	efi_kobj = kobject_create_and_add("efi", firmware_kobj);
>  	if (!efi_kobj) {
> diff --git a/drivers/rtc/rtc-efi.c b/drivers/rtc/rtc-efi.c
> index fa8bf82df9488e7d1c23c058b4a3032dde74bc6e..3d21a470e8ff9777c5eeb991f3aa9170f6351930 100644
> --- a/drivers/rtc/rtc-efi.c
> +++ b/drivers/rtc/rtc-efi.c
> @@ -14,7 +14,7 @@
>  #include <linux/module.h>
>  #include <linux/stringify.h>
>  #include <linux/time.h>
> -#include <linux/platform_device.h>
> +#include <linux/device/faux.h>
>  #include <linux/rtc.h>
>  #include <linux/efi.h>
>  
> @@ -254,7 +254,7 @@ static const struct rtc_class_ops efi_rtc_ops = {
>  	.proc		= efi_procfs,
>  };
>  
> -static int __init efi_rtc_probe(struct platform_device *dev)
> +static int __init efi_rtc_probe(struct faux_device *dev)
>  {
>  	struct rtc_device *rtc;
>  	efi_time_t eft;
> @@ -268,7 +268,7 @@ static int __init efi_rtc_probe(struct platform_device *dev)
>  	if (IS_ERR(rtc))
>  		return PTR_ERR(rtc);
>  
> -	platform_set_drvdata(dev, rtc);
> +	faux_device_set_drvdata(dev, rtc);
>  
>  	rtc->ops = &efi_rtc_ops;
>  	clear_bit(RTC_FEATURE_UPDATE_INTERRUPT, rtc->features);
> @@ -282,15 +282,28 @@ static int __init efi_rtc_probe(struct platform_device *dev)
>  	return devm_rtc_register_device(rtc);
>  }
>  
> -static struct platform_driver efi_rtc_driver = {
> -	.driver = {
> -		.name = "rtc-efi",
> -	},
> +static struct faux_device_ops efi_rtc_fdev_ops = {
> +	.probe = efi_rtc_probe,
>  };
>  
> -module_platform_driver_probe(efi_rtc_driver, efi_rtc_probe);
> +static int __init rtc_efi_init(void)
> +{
> +	struct faux_device *fdev;
> +
> +	if (!efi_rt_services_supported(EFI_RT_SUPPORTED_TIME_SERVICES))
> +		return 0;
> +
> +	fdev = faux_device_create("rtc-efi", NULL, &efi_rtc_fdev_ops);
> +	if (!fdev) {
> +		pr_err("rtc-efi: could not create the device\n");
> +		return -ENODEV;
> +	}
> +
> +	return 0;
> +}
> +device_initcall(rtc_efi_init);
>  
>  MODULE_AUTHOR("dann frazier <dannf@dannf.org>");
>  MODULE_LICENSE("GPL");
>  MODULE_DESCRIPTION("EFI RTC driver");
> -MODULE_ALIAS("platform:rtc-efi");
> +MODULE_ALIAS("faux:rtc-efi");

No alias please.

