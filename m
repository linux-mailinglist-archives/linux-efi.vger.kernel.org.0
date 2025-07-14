Return-Path: <linux-efi+bounces-4314-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBFF6B037AF
	for <lists+linux-efi@lfdr.de>; Mon, 14 Jul 2025 09:16:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29AC017A165
	for <lists+linux-efi@lfdr.de>; Mon, 14 Jul 2025 07:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB9E22F767;
	Mon, 14 Jul 2025 07:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="EJQCnQrX"
X-Original-To: linux-efi@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2012C22F772;
	Mon, 14 Jul 2025 07:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752477410; cv=none; b=EDrsxOvsjfJCcnoAbtB8aWm0y3Ub92DnNvp4u0AO6I9ABLtKSuIntwho3E6/qoyaempPtOMI6aSDvW8jLqNDYdnyZaSVdJ3DOEfxv8baQq1RaUPqE6HZt6xmVH1H5a9QIQWqEEUv/ELjBKTNCW7WuLxOoK6ARkL/gNbNtwcs8Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752477410; c=relaxed/simple;
	bh=VO3OlWP7PfH6wAV86OL6U9gKiGINg7rJ7KPBm+jtPZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mtme2pCj+iY9PtgC8s+4w3VtgNE9EM5m/J/kHOYpHTv0KRw64s8jW5R25FCTzG9NIDV7+IGC1KjDRBi619VAw94Y4H2geSNZihf/rI9AFZcCYeue+UzJ+mQc5erFy4e0652jBZdyCUcadzMTbIdDGXZ7pHgxDSH+4lr7BkOBOb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=EJQCnQrX; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1752477399; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=uDmSekQrgZGL8r2lWAymZdEWRY9s0eH9Oe3pP00uIuU=;
	b=EJQCnQrXmdcSLqSk752xKkuGapxwKdrDM8eMOrazmBCO4N2CxL854+rx9oxeCSUS3ew2P93QKTp+bm9Y2Ka55JP7ejjcDXOYINBZKJNWBoIxV9uV6RsEM7UxCKmDVdEGjxneElhUo82p3nqz0GKQ6FkHbddoM1Yl4EDpjxenuVE=
Received: from localhost(mailfrom:feng.tang@linux.alibaba.com fp:SMTPD_---0WiqeCDu_1752477397 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 14 Jul 2025 15:16:37 +0800
Date: Mon, 14 Jul 2025 15:16:37 +0800
From: Feng Tang <feng.tang@linux.alibaba.com>
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Ard Biesheuvel <ardb@kernel.org>,
	Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Bibo Mao <maobibo@loongson.cn>, linux-rtc@vger.kernel.org,
	linux-efi@vger.kernel.org, xen-devel@lists.xenproject.org,
	x86@kernel.org, linux-riscv@lists.infradead.org,
	loongarch@lists.linux.dev
Subject: Re: [RFC PATCH 1/3] efi-rtc: Remove wakeup functionality
Message-ID: <aHSu1WVYXZ2N5X8X@U-2FWC9VHC-2323.local>
References: <20250714060843.4029171-5-ardb+git@google.com>
 <20250714060843.4029171-6-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250714060843.4029171-6-ardb+git@google.com>

On Mon, Jul 14, 2025 at 08:08:45AM +0200, Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
> 
> The EFI rtc driver is used by non-x86 architectures only, and exposes
> the get/set wakeup time functionality provided by the underlying
> platform. This is usually broken on most platforms, and not widely used
> to begin with [if at all], so let's just remove it.

This solves the problem reported in 
https://lore.kernel.org/all/20250710084151.55003-1-feng.tang@linux.alibaba.com/T/#u

Tested-by: Feng Tang <feng.tang@linux.alibaba.com>

Thanks!

- Feng

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

