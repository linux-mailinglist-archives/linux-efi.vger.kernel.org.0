Return-Path: <linux-efi+bounces-563-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35DCA85624E
	for <lists+linux-efi@lfdr.de>; Thu, 15 Feb 2024 12:57:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E398D289481
	for <lists+linux-efi@lfdr.de>; Thu, 15 Feb 2024 11:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0D3812B164;
	Thu, 15 Feb 2024 11:56:52 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15905127B41;
	Thu, 15 Feb 2024 11:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707998212; cv=none; b=AURPw1pbmie/0FvynviUKVdvPyuffsCmfVwiRdQJYVn8d4okG1EQQBT23qkxF67gZ5Kk9zL0g0fmL5lnnKs6AKlgDzLlCMRUqROkXyFV0OZntn1RGSYWVgLkkD8nJIY9Vp3nJwUEgfD+smspcve/TirdhbzNzxECp9FmPt0zQgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707998212; c=relaxed/simple;
	bh=GuEq2m8kfPXvgra25VpHA7V6cCxxsrm6u7nxl0eVd0s=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mJEDVxCawZCvaLhPGiciN58VqEWMWjkuNyTJEwqfvuLkv/AqirbRRbXKXmQI0AGojlLBmVxGMQjmHYT6p1VWrLNKXsbKfdA1igBd+NSyg1JwInFBrOw44eECzE88gPFvm0u4ns6n1SF5Z7ockpOjq5w56XbUU/jgu5Wgn222F18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TbD2j1XwCz6J9xX;
	Thu, 15 Feb 2024 19:52:45 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 78D9C140D1A;
	Thu, 15 Feb 2024 19:56:47 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 15 Feb
 2024 11:56:47 +0000
Date: Thu, 15 Feb 2024 11:56:46 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
CC: <linux-efi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, Ard Biesheuvel <ardb@kernel.org>, "Alison
 Schofield" <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Yazen Ghannam <yazen.ghannam@amd.com>
Subject: Re: [PATCH v2 1/4] acpi/ghes, cxl: Create a common CXL struct to
 handle different CXL CPER records
Message-ID: <20240215115646.000038d6@Huawei.com>
In-Reply-To: <20240109034755.100555-2-Smita.KoralahalliChannabasappa@amd.com>
References: <20240109034755.100555-1-Smita.KoralahalliChannabasappa@amd.com>
	<20240109034755.100555-2-Smita.KoralahalliChannabasappa@amd.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Tue, 9 Jan 2024 03:47:52 +0000
Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com> wrote:

> Currently defined cxl_cper_callback interface between CXL subsystem and
> GHES module is just confined to handling CXL Component errors only.
> 
> Extend this callback to process CXL Protocol errors as well. Achieve
> by defining a new struct cxl_cper_event_info to include cxl_cper_event_rec
> and other fields of CXL protocol errors which will be defined in future
> patches.
> 
> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Hi Smita,

I guess this will get effected by the mess around the reporting that
Ira is fixing but in meantime some comments on the current code.
> ---
> v2:
> 	cxl_cper_rec_data -> cxl_cper_event_info
> 	data -> info
> ---
>  drivers/acpi/apei/ghes.c  | 6 +++++-
>  drivers/cxl/pci.c         | 8 ++++----
>  include/linux/cxl-event.h | 6 +++++-
>  3 files changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index aed465d2fd68..60b615d361d3 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -693,6 +693,10 @@ static cxl_cper_callback cper_callback;
>  static void cxl_cper_post_event(enum cxl_event_type event_type,
>  				struct cxl_cper_event_rec *rec)
>  {
> +	struct cxl_cper_event_info info;
> +
> +	info.rec = *(struct cxl_cper_event_rec *)rec;

Why cast?

> +
>  	if (rec->hdr.length <= sizeof(rec->hdr) ||
>  	    rec->hdr.length > sizeof(*rec)) {
>  		pr_err(FW_WARN "CXL CPER Invalid section length (%u)\n",
> @@ -707,7 +711,7 @@ static void cxl_cper_post_event(enum cxl_event_type event_type,
>  
>  	guard(rwsem_read)(&cxl_cper_rw_sem);
>  	if (cper_callback)
> -		cper_callback(event_type, rec);
> +		cper_callback(event_type, &info);
>  }
>  
>  int cxl_cper_register_callback(cxl_cper_callback callback)
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index b14237f824cf..1ad240ead4fd 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -972,9 +972,9 @@ static struct pci_driver cxl_pci_driver = {
>  
>  #define CXL_EVENT_HDR_FLAGS_REC_SEVERITY GENMASK(1, 0)
>  static void cxl_cper_event_call(enum cxl_event_type ev_type,
> -				struct cxl_cper_event_rec *rec)
> +				struct cxl_cper_event_info *info)
>  {
> -	struct cper_cxl_event_devid *device_id = &rec->hdr.device_id;
> +	struct cper_cxl_event_devid *device_id = &info->rec.hdr.device_id;
>  	struct pci_dev *pdev __free(pci_dev_put) = NULL;
>  	enum cxl_event_log_type log_type;
>  	struct cxl_dev_state *cxlds;
> @@ -996,11 +996,11 @@ static void cxl_cper_event_call(enum cxl_event_type ev_type,
>  		return;
>  
>  	/* Fabricate a log type */
> -	hdr_flags = get_unaligned_le24(rec->event.generic.hdr.flags);
> +	hdr_flags = get_unaligned_le24(info->rec.event.generic.hdr.flags);
>  	log_type = FIELD_GET(CXL_EVENT_HDR_FLAGS_REC_SEVERITY, hdr_flags);
>  
>  	cxl_event_trace_record(cxlds->cxlmd, log_type, ev_type,
> -			       &uuid_null, &rec->event);
> +			       &uuid_null, &info->rec.event);
>  }
>  
>  static int __init cxl_pci_driver_init(void)
> diff --git a/include/linux/cxl-event.h b/include/linux/cxl-event.h
> index 17eadee819b6..6ce839c59749 100644
> --- a/include/linux/cxl-event.h
> +++ b/include/linux/cxl-event.h
> @@ -141,8 +141,12 @@ struct cxl_cper_event_rec {
>  	union cxl_event event;
>  } __packed;
>  
> +struct cxl_cper_event_info {
> +	struct cxl_cper_event_rec rec;

Only parts of this will be relevant to the protocol errors.
Maybe worth doing a union with the first part of rec in both
structures but not the union cxl_event in the protocol error.
Keep it all anonymous to avoid yet another structure in the
reads/and writes though.

> +};
> +
>  typedef void (*cxl_cper_callback)(enum cxl_event_type type,
> -				  struct cxl_cper_event_rec *rec);
> +				  struct cxl_cper_event_info *info);
>  
>  #ifdef CONFIG_ACPI_APEI_GHES
>  int cxl_cper_register_callback(cxl_cper_callback callback);


