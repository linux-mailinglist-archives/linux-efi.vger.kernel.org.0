Return-Path: <linux-efi+bounces-4506-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EB46B1915C
	for <lists+linux-efi@lfdr.de>; Sun,  3 Aug 2025 03:05:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E79A17B035
	for <lists+linux-efi@lfdr.de>; Sun,  3 Aug 2025 01:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 562AB17BA1;
	Sun,  3 Aug 2025 01:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ibJLf44S"
X-Original-To: linux-efi@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C092C190;
	Sun,  3 Aug 2025 01:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754183102; cv=none; b=jnKXxm0COUS9L9rxzeYvPg4jSG6LSGz0rpg++WOlpM8QUbuhpnk9TnZk+pDK6ekl7d9gwiMUsYP5pwXlhu13pZBD2SfAoMHIDAf5VEpW6Yp7wywmbFbPJ7n1wvO7lWSGwmMWNf449H2bPL1lhyktuV+9/ISOzsM0mJIKNoPdBBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754183102; c=relaxed/simple;
	bh=P7fbkK2lQmJQF2LSFdn1FL/Uiv2amrUFSemfc1Sl0YA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q94IEskEtytZhdYiOqF30D3pXYrHFGXzNLigdr8uthwAqbofngBOKBb1cmUfeVQeJPJCX6d9SoyDyBWkcWvaRTY/ZgnpPMzFV65Rr6VFqtWKZPNiM0XItCuJDiK6TWjXkEfTPr78QIGheuugXjE2RLp5cdtaE/VOY2igtUBKTTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ibJLf44S; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 395D841DE2;
	Sun,  3 Aug 2025 01:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1754183092;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IG2HpXzsqu+NkhilqnbEM95yf9B6n+TV1enjTn2IGB8=;
	b=ibJLf44Stz+KQ8z1BIhUrXB8Hx8q3mDVJsoazKdnF5cGuJvjReExXK4mcEOGy+KCLeZn/+
	kiZ6ksHecS6yzjenen9Bap4+NogZvlkX8LS/fcaTLx2nCLDMs16sjfVWHO2BVoee+7W6h1
	UEJQo/hhQZmslKN2uXNBIo6f/iV7i4i2ULavQeZYg9xJlgn+4UWyifl1oqRN5FdvDOipjo
	Anoil5WSqw3fdSJJkxGIZeUHKgePK471C7AqiXKnuTl4IJNxiRavQiZ+ZSEcB4GlH//Ny4
	WFnmiHTOQORQeOxW5S5sx2Fjc6aV8soQemag6oeQvhlj/yfB9gN8N5R45YYCkg==
Date: Sun, 3 Aug 2025 03:04:49 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Ard Biesheuvel <ardb@kernel.org>,
	Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
	Feng Tang <feng.tang@linux.alibaba.com>,
	Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Bibo Mao <maobibo@loongson.cn>, linux-rtc@vger.kernel.org,
	linux-efi@vger.kernel.org, xen-devel@lists.xenproject.org,
	x86@kernel.org, linux-riscv@lists.infradead.org,
	loongarch@lists.linux.dev
Subject: Re: [RFC PATCH 1/3] efi-rtc: Remove wakeup functionality
Message-ID: <20250803010449df1f5cfb@mail.local>
References: <20250714060843.4029171-5-ardb+git@google.com>
 <20250714060843.4029171-6-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714060843.4029171-6-ardb+git@google.com>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutdektdekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeetlhgvgigrnhgurhgvuceuvghllhhonhhiuceorghlvgigrghnughrvgdrsggvlhhlohhnihessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgeeiudeuteehhfekgeejveefhfeiudejuefhgfeljefgjeegkeeujeeugfehgefgnecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppedvrgdtudemvgdtrgemvdgumeeifeejtdemjeekvgdtmegttdgvkeemvdektdeimeekrggtieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgdtrgemvdgumeeifeejtdemjeekvgdtmegttdgvkeemvdektdeimeekrggtiedphhgvlhhopehlohgtrghlhhhoshhtpdhmrghilhhfrhhomheprghlvgigrghnughrvgdrsggvlhhlohhnihessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudejpdhrtghpthhtoheprghruggsodhgihhtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehli
 hhnuhigqdgrrhhmqdhkvghrnhgvlheslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopegrrhgusgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhgvihhnrhhitghhrdhstghhuhgthhgrrhguthestggrnhhonhhitggrlhdrtghomhdprhgtphhtthhopehfvghnghdrthgrnhhgsehlihhnuhigrdgrlhhisggrsggrrdgtohhmpdhrtghpthhtohepjhhgrhhoshhssehsuhhsvgdrtghomhdprhgtphhtthhopehsshhtrggsvghllhhinhhisehkvghrnhgvlhdrohhrgh
X-GND-Sasl: alexandre.belloni@bootlin.com

Hello,

Apart from the topic that should be "rtc: efi:...", I'm ready to apply
this patch.

On 14/07/2025 08:08:45+0200, Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
> 
> The EFI rtc driver is used by non-x86 architectures only, and exposes
> the get/set wakeup time functionality provided by the underlying
> platform. This is usually broken on most platforms, and not widely used
> to begin with [if at all], so let's just remove it.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  drivers/rtc/rtc-efi.c | 76 +-------------------
>  1 file changed, 2 insertions(+), 74 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-efi.c b/drivers/rtc/rtc-efi.c
> index fa8bf82df948..b4f44999ef0f 100644
> --- a/drivers/rtc/rtc-efi.c
> +++ b/drivers/rtc/rtc-efi.c
> @@ -112,48 +112,6 @@ convert_from_efi_time(efi_time_t *eft, struct rtc_time *wtime)
>  	return true;
>  }
>  
> -static int efi_read_alarm(struct device *dev, struct rtc_wkalrm *wkalrm)
> -{
> -	efi_time_t eft;
> -	efi_status_t status;
> -
> -	/*
> -	 * As of EFI v1.10, this call always returns an unsupported status
> -	 */
> -	status = efi.get_wakeup_time((efi_bool_t *)&wkalrm->enabled,
> -				     (efi_bool_t *)&wkalrm->pending, &eft);
> -
> -	if (status != EFI_SUCCESS)
> -		return -EINVAL;
> -
> -	if (!convert_from_efi_time(&eft, &wkalrm->time))
> -		return -EIO;
> -
> -	return rtc_valid_tm(&wkalrm->time);
> -}
> -
> -static int efi_set_alarm(struct device *dev, struct rtc_wkalrm *wkalrm)
> -{
> -	efi_time_t eft;
> -	efi_status_t status;
> -
> -	convert_to_efi_time(&wkalrm->time, &eft);
> -
> -	/*
> -	 * XXX Fixme:
> -	 * As of EFI 0.92 with the firmware I have on my
> -	 * machine this call does not seem to work quite
> -	 * right
> -	 *
> -	 * As of v1.10, this call always returns an unsupported status
> -	 */
> -	status = efi.set_wakeup_time((efi_bool_t)wkalrm->enabled, &eft);
> -
> -	dev_warn(dev, "write status is %d\n", (int)status);
> -
> -	return status == EFI_SUCCESS ? 0 : -EINVAL;
> -}
> -
>  static int efi_read_time(struct device *dev, struct rtc_time *tm)
>  {
>  	efi_status_t status;
> @@ -188,17 +146,13 @@ static int efi_set_time(struct device *dev, struct rtc_time *tm)
>  
>  static int efi_procfs(struct device *dev, struct seq_file *seq)
>  {
> -	efi_time_t        eft, alm;
> +	efi_time_t        eft;
>  	efi_time_cap_t    cap;
> -	efi_bool_t        enabled, pending;
> -	struct rtc_device *rtc = dev_get_drvdata(dev);
>  
>  	memset(&eft, 0, sizeof(eft));
> -	memset(&alm, 0, sizeof(alm));
>  	memset(&cap, 0, sizeof(cap));
>  
>  	efi.get_time(&eft, &cap);
> -	efi.get_wakeup_time(&enabled, &pending, &alm);
>  
>  	seq_printf(seq,
>  		   "Time\t\t: %u:%u:%u.%09u\n"
> @@ -214,26 +168,6 @@ static int efi_procfs(struct device *dev, struct seq_file *seq)
>  		/* XXX fixme: convert to string? */
>  		seq_printf(seq, "Timezone\t: %u\n", eft.timezone);
>  
> -	if (test_bit(RTC_FEATURE_ALARM, rtc->features)) {
> -		seq_printf(seq,
> -			   "Alarm Time\t: %u:%u:%u.%09u\n"
> -			   "Alarm Date\t: %u-%u-%u\n"
> -			   "Alarm Daylight\t: %u\n"
> -			   "Enabled\t\t: %s\n"
> -			   "Pending\t\t: %s\n",
> -			   alm.hour, alm.minute, alm.second, alm.nanosecond,
> -			   alm.year, alm.month, alm.day,
> -			   alm.daylight,
> -			   enabled == 1 ? "yes" : "no",
> -			   pending == 1 ? "yes" : "no");
> -
> -		if (alm.timezone == EFI_UNSPECIFIED_TIMEZONE)
> -			seq_puts(seq, "Timezone\t: unspecified\n");
> -		else
> -			/* XXX fixme: convert to string? */
> -			seq_printf(seq, "Timezone\t: %u\n", alm.timezone);
> -	}
> -
>  	/*
>  	 * now prints the capabilities
>  	 */
> @@ -249,8 +183,6 @@ static int efi_procfs(struct device *dev, struct seq_file *seq)
>  static const struct rtc_class_ops efi_rtc_ops = {
>  	.read_time	= efi_read_time,
>  	.set_time	= efi_set_time,
> -	.read_alarm	= efi_read_alarm,
> -	.set_alarm	= efi_set_alarm,
>  	.proc		= efi_procfs,
>  };
>  
> @@ -271,11 +203,7 @@ static int __init efi_rtc_probe(struct platform_device *dev)
>  	platform_set_drvdata(dev, rtc);
>  
>  	rtc->ops = &efi_rtc_ops;
> -	clear_bit(RTC_FEATURE_UPDATE_INTERRUPT, rtc->features);
> -	if (efi_rt_services_supported(EFI_RT_SUPPORTED_WAKEUP_SERVICES))
> -		set_bit(RTC_FEATURE_ALARM_WAKEUP_ONLY, rtc->features);
> -	else
> -		clear_bit(RTC_FEATURE_ALARM, rtc->features);
> +	clear_bit(RTC_FEATURE_ALARM, rtc->features);
>  
>  	device_init_wakeup(&dev->dev, true);
>  
> -- 
> 2.50.0.727.gbf7dc18ff4-goog
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

