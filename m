Return-Path: <linux-efi+bounces-445-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACFE2844E92
	for <lists+linux-efi@lfdr.de>; Thu,  1 Feb 2024 02:17:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6304728E30A
	for <lists+linux-efi@lfdr.de>; Thu,  1 Feb 2024 01:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15DF22116;
	Thu,  1 Feb 2024 01:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d+lu4MWJ"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E6B1FD7;
	Thu,  1 Feb 2024 01:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706750226; cv=none; b=PunF175viweYhE1mlYSCYuYZntxTQyoUaXwx/0mtcEZgwa1rmEPqHXf5Vy0vhzDHasF6WNeYzAb9kCavSX+cFDnWixWip8F33eo46VXK5d3jQoS44xpTEjRvK8JcGeFg3h3kSOgt2a2+pSESHwxKq1ZT1MJdrePWUJGxQvMeI9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706750226; c=relaxed/simple;
	bh=/yzOHUGz8I5VmiYmy9LqG/OTwYwmI0QnLNBMfvd/EmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kP0UQd8zecYgasz9K7xx90v8O2O5KmuQRe0p5noJvaM5jOrb8zJ7kt2pMW9OJ6zto53v1bMBKT/9ol2igXe4LN4YwzUIZ02urXbYnt6ZFMKnEDVPZHwJpg1jHC17BoWaZbqj8qwyq1vEEq909F9aOe5ey2sIl2sLtsD9jlMG6/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d+lu4MWJ; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706750225; x=1738286225;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/yzOHUGz8I5VmiYmy9LqG/OTwYwmI0QnLNBMfvd/EmQ=;
  b=d+lu4MWJr0RmyIxnAVQPZsnZlFbnFfJw0c14heLK6EhprR5cVAoA4Z6t
   z/3Hq6S12xLbAzb730gvP9BuYhtTmg3XJditwcK94O3ig1qIzjjv2lwtj
   77QOl8PqjjCVNr+ihTzZGz5Gykyal+sImoICgcITSvrfLlnDaDAjEgEyl
   VS/xoCswWZ05NxqnoHchRSXn1oqUgBPogVQ8MpQpUX+NYonRYWL01/NOb
   Cqjl6oeQEoKr0mDaR9Dib2cD/qo56E0mFWo4uxydZco2G7MFx3M6gLuTS
   u3ZvqVszqFnVRIewzHTDeQMivwskJ2UmwqWBPwvKDtXnCWV6772PkK8zr
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="22277930"
X-IronPort-AV: E=Sophos;i="6.05,233,1701158400"; 
   d="scan'208";a="22277930"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 17:17:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="858992489"
X-IronPort-AV: E=Sophos;i="6.05,233,1701158400"; 
   d="scan'208";a="858992489"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.39.51])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 17:17:02 -0800
Date: Wed, 31 Jan 2024 17:17:00 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Ira Weiny <ira.weiny@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
	linux-cxl@vger.kernel.org
Subject: Re: [PATCH 1/2] cxl/cper: Fix errant CPER prints for CXL events
Message-ID: <ZbrxDMwn4h3y5waj@aschofie-mobl2>
References: <20240131-cxl-cper-fixups-v1-0-335c85b1d77b@intel.com>
 <20240131-cxl-cper-fixups-v1-1-335c85b1d77b@intel.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240131-cxl-cper-fixups-v1-1-335c85b1d77b@intel.com>

On Wed, Jan 31, 2024 at 03:55:38PM -0800, Ira Weiny wrote:
> Jonathan reports that CXL CPER events dump an extra generic error
> message.
> 
> 	{1}[Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 1
> 	{1}[Hardware Error]: event severity: recoverable
> 	{1}[Hardware Error]:  Error 0, type: recoverable
> 	{1}[Hardware Error]:   section type: unknown, fbcd0a77-c260-417f-85a9-088b1621eba6
> 	{1}[Hardware Error]:   section length: 0x90
> 	{1}[Hardware Error]:   00000000: 00000090 00000007 00000000 0d938086 ................
> 	{1}[Hardware Error]:   00000010: 00100000 00000000 00040000 00000000 ................
> 	...
> 
> CXL events were rerouted though the CXL subsystem for additional
> processing.  However, when that work was done it was missed that
> cper_estatus_print_section() continued with a generic error message
> which is confusing.
> 
> Teach CPER print code to ignore printing details of some section types.
> Assign the CXL event GUIDs to this set to prevent confusing unknown
> prints.

Reviewed-by: Alison Schofield <alison.schofield@intel.com>


> 
> Reported-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Suggested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> ---
>  drivers/acpi/apei/ghes.c    | 26 --------------------------
>  drivers/firmware/efi/cper.c | 19 +++++++++++++++++++
>  include/linux/cper.h        | 23 +++++++++++++++++++++++
>  3 files changed, 42 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index 7b7c605166e0..fe825a432c5b 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -680,32 +680,6 @@ static void ghes_defer_non_standard_event(struct acpi_hest_generic_data *gdata,
>  static DECLARE_RWSEM(cxl_cper_rw_sem);
>  static cxl_cper_callback cper_callback;
>  
> -/* CXL Event record UUIDs are formatted as GUIDs and reported in section type */
> -
> -/*
> - * General Media Event Record
> - * CXL rev 3.0 Section 8.2.9.2.1.1; Table 8-43
> - */
> -#define CPER_SEC_CXL_GEN_MEDIA_GUID					\
> -	GUID_INIT(0xfbcd0a77, 0xc260, 0x417f,				\
> -		  0x85, 0xa9, 0x08, 0x8b, 0x16, 0x21, 0xeb, 0xa6)
> -
> -/*
> - * DRAM Event Record
> - * CXL rev 3.0 section 8.2.9.2.1.2; Table 8-44
> - */
> -#define CPER_SEC_CXL_DRAM_GUID						\
> -	GUID_INIT(0x601dcbb3, 0x9c06, 0x4eab,				\
> -		  0xb8, 0xaf, 0x4e, 0x9b, 0xfb, 0x5c, 0x96, 0x24)
> -
> -/*
> - * Memory Module Event Record
> - * CXL rev 3.0 section 8.2.9.2.1.3; Table 8-45
> - */
> -#define CPER_SEC_CXL_MEM_MODULE_GUID					\
> -	GUID_INIT(0xfe927475, 0xdd59, 0x4339,				\
> -		  0xa5, 0x86, 0x79, 0xba, 0xb1, 0x13, 0xb7, 0x74)
> -
>  static void cxl_cper_post_event(enum cxl_event_type event_type,
>  				struct cxl_cper_event_rec *rec)
>  {
> diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
> index 35c37f667781..9b3884ff81e6 100644
> --- a/drivers/firmware/efi/cper.c
> +++ b/drivers/firmware/efi/cper.c
> @@ -523,6 +523,17 @@ static void cper_print_tstamp(const char *pfx,
>  	}
>  }
>  
> +struct ignore_section {
> +	guid_t guid;
> +	const char *name;
> +};
> +
> +static const struct ignore_section ignore_sections[] = {
> +	{ .guid = CPER_SEC_CXL_GEN_MEDIA_GUID, .name = "CXL General Media Event" },
> +	{ .guid = CPER_SEC_CXL_DRAM_GUID, .name = "CXL DRAM Event" },
> +	{ .guid = CPER_SEC_CXL_MEM_MODULE_GUID, .name = "CXL Memory Module Event" },
> +};
> +
>  static void
>  cper_estatus_print_section(const char *pfx, struct acpi_hest_generic_data *gdata,
>  			   int sec_no)
> @@ -543,6 +554,14 @@ cper_estatus_print_section(const char *pfx, struct acpi_hest_generic_data *gdata
>  		printk("%s""fru_text: %.20s\n", pfx, gdata->fru_text);
>  
>  	snprintf(newpfx, sizeof(newpfx), "%s ", pfx);
> +
> +	for (int i = 0; i < ARRAY_SIZE(ignore_sections); i++) {
> +		if (guid_equal(sec_type, &ignore_sections[i].guid)) {
> +			printk("%ssection_type: %s\n", newpfx, ignore_sections[i].name);
> +			return;
> +		}
> +	}
> +
>  	if (guid_equal(sec_type, &CPER_SEC_PROC_GENERIC)) {
>  		struct cper_sec_proc_generic *proc_err = acpi_hest_get_payload(gdata);
>  
> diff --git a/include/linux/cper.h b/include/linux/cper.h
> index c1a7dc325121..265b0f8fc0b3 100644
> --- a/include/linux/cper.h
> +++ b/include/linux/cper.h
> @@ -90,6 +90,29 @@ enum {
>  	GUID_INIT(0x667DD791, 0xC6B3, 0x4c27, 0x8A, 0x6B, 0x0F, 0x8E,	\
>  		  0x72, 0x2D, 0xEB, 0x41)
>  
> +/* CXL Event record UUIDs are formatted as GUIDs and reported in section type */
> +/*
> + * General Media Event Record
> + * CXL rev 3.0 Section 8.2.9.2.1.1; Table 8-43
> + */
> +#define CPER_SEC_CXL_GEN_MEDIA_GUID					\
> +	GUID_INIT(0xfbcd0a77, 0xc260, 0x417f,				\
> +		  0x85, 0xa9, 0x08, 0x8b, 0x16, 0x21, 0xeb, 0xa6)
> +/*
> + * DRAM Event Record
> + * CXL rev 3.0 section 8.2.9.2.1.2; Table 8-44
> + */
> +#define CPER_SEC_CXL_DRAM_GUID						\
> +	GUID_INIT(0x601dcbb3, 0x9c06, 0x4eab,				\
> +		  0xb8, 0xaf, 0x4e, 0x9b, 0xfb, 0x5c, 0x96, 0x24)
> +/*
> + * Memory Module Event Record
> + * CXL rev 3.0 section 8.2.9.2.1.3; Table 8-45
> + */
> +#define CPER_SEC_CXL_MEM_MODULE_GUID					\
> +	GUID_INIT(0xfe927475, 0xdd59, 0x4339,				\
> +		  0xa5, 0x86, 0x79, 0xba, 0xb1, 0x13, 0xb7, 0x74)
> +
>  /*
>   * Flags bits definitions for flags in struct cper_record_header
>   * If set, the error has been recovered
> 
> -- 
> 2.43.0
> 

