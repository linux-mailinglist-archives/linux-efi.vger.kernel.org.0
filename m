Return-Path: <linux-efi+bounces-2215-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A57E09D9AE9
	for <lists+linux-efi@lfdr.de>; Tue, 26 Nov 2024 16:58:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 284AE1661D6
	for <lists+linux-efi@lfdr.de>; Tue, 26 Nov 2024 15:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F2401D90C5;
	Tue, 26 Nov 2024 15:57:31 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4042E1D90CB;
	Tue, 26 Nov 2024 15:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732636651; cv=none; b=DMPRD3W/p0MRO2CtoZw+yEM2M/QcTf4EilTZGgNwD+W/9mSI6QhOiuwRUh+ifl8jvm/fDXvpWeG+PCwwXhu4wlrv4oAnaYNzWpq0NLoTicYWZv+QM+9ZdrjMZWNYaIfRldc+mCZRomdVXDEqWEUKgoev4solX4lU9WmGDiZ8tiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732636651; c=relaxed/simple;
	bh=VfjwxKDKbiB7eQGIchcaTxv66YqHuyaSVSFlkGPzPOo=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YPQP6Prh1Y6hjBAIrxuuLFPfg/O2Qmh3iY3owvudzAVEbQJ068MeWs8F5X43mkmbzFBxNGPLdxHNh0GdbQwi1hoTLq8kXS72E6Gbip1u+fgfN59vrNUDEbNApJGcp/tVorp6UimNebKy+LEd6I0syH8KqNLGnN4jf3lR2ja7C28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XyRyt1LFLz6L9F1;
	Tue, 26 Nov 2024 23:56:54 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 087A51400CB;
	Tue, 26 Nov 2024 23:57:26 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 26 Nov
 2024 16:57:25 +0100
Date: Tue, 26 Nov 2024 15:57:24 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
CC: <linux-efi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, Ard Biesheuvel <ardb@kernel.org>, "Alison
 Schofield" <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Yazen Ghannam <yazen.ghannam@amd.com>, "Terry
 Bowman" <terry.bowman@amd.com>
Subject: Re: [PATCH v3 5/7] acpi/ghes, cxl: Refactor work registration
 functions to support multiple workqueues
Message-ID: <20241126155724.0000634c@huawei.com>
In-Reply-To: <20241119003915.174386-6-Smita.KoralahalliChannabasappa@amd.com>
References: <20241119003915.174386-1-Smita.KoralahalliChannabasappa@amd.com>
	<20241119003915.174386-6-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 19 Nov 2024 00:39:13 +0000
Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com> wrote:

> Refactor the work registration and unregistration functions in GHES to
> enable reuse across different workqueues. This update lays the foundation
> for integrating additional workqueues in the CXL subsystem for better
> modularity and code reuse.
> 
> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> ---
>  drivers/acpi/apei/ghes.c | 34 +++++++++++++++++++++++++---------
>  1 file changed, 25 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index 082c409707ba..62ffe6eb5503 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -717,26 +717,42 @@ static void cxl_cper_post_event(enum cxl_event_type event_type,
>  	schedule_work(cxl_cper_work);
>  }
>  
> -int cxl_cper_register_event_work(struct work_struct *work)
> +static int cxl_cper_register_work(struct work_struct **work_ptr,
> +				  spinlock_t *lock,
> +				  struct work_struct *work)

This is a somewhat strange interface.  It doesn't
really do anything particularly useful. I'd be tempted to
just open code this at each call site.


>  {
> -	if (cxl_cper_work)
> +	if (*work_ptr)
>  		return -EINVAL;
>  
> -	guard(spinlock)(&cxl_cper_work_lock);
> -	cxl_cper_work = work;
> +	guard(spinlock)(lock);
> +	*work_ptr = work;
>  	return 0;
>  }
> -EXPORT_SYMBOL_NS_GPL(cxl_cper_register_event_work, CXL);
>  
> -int cxl_cper_unregister_event_work(struct work_struct *work)
> +static int cxl_cper_unregister_work(struct work_struct **work_ptr,
> +				    spinlock_t *lock,
> +				    struct work_struct *work)
>  {
> -	if (cxl_cper_work != work)
> +	if (*work_ptr != work)
As above.

>  		return -EINVAL;
>  
> -	guard(spinlock)(&cxl_cper_work_lock);
> -	cxl_cper_work = NULL;
> +	guard(spinlock)(lock);
> +	*work_ptr = NULL;
>  	return 0;
>  }
> +
> +int cxl_cper_register_event_work(struct work_struct *work)
> +{
> +	return cxl_cper_register_work(&cxl_cper_work, &cxl_cper_work_lock,
> +				      work);
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_cper_register_event_work, CXL);
> +
> +int cxl_cper_unregister_event_work(struct work_struct *work)
> +{
> +	return cxl_cper_unregister_work(&cxl_cper_work, &cxl_cper_work_lock,
> +					work);
> +}
>  EXPORT_SYMBOL_NS_GPL(cxl_cper_unregister_event_work, CXL);
>  
>  int cxl_cper_kfifo_get(struct cxl_cper_work_data *wd)


