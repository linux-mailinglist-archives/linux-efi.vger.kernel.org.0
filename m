Return-Path: <linux-efi+bounces-4463-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3587B0E414
	for <lists+linux-efi@lfdr.de>; Tue, 22 Jul 2025 21:24:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 061355412D5
	for <lists+linux-efi@lfdr.de>; Tue, 22 Jul 2025 19:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20E66283CB1;
	Tue, 22 Jul 2025 19:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LOBLLQ+M"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DAB521E097;
	Tue, 22 Jul 2025 19:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753212288; cv=none; b=myK+77r0zjzrfkECFPubC0Tio4Z24ONzV2RmjwAtlWLjByeA/j0GpRBPR2d7CJjpskicB9AlcC0W0YWCioFgNgnZwoVNEvfAl8yWPVfgN40U4ByHhbnjTe9WfMroIYVYb+g4zsJhaT+ZxKOkXhweHyPsw93RIDNCq2cXLRYUz4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753212288; c=relaxed/simple;
	bh=3dd/ws0FWrilDPNuVMNcBMIppoB7h3664eeTV3AbPFw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FeNCQbgMReRxi2QxYl29fpDh9rm5vcOOjKpyU6hDULPn7wyzHyr/p/sWtkQz9deCb2maQBB0rsyrokncpxTszSMH1Qngb4x6Q0xBv3QqO1NWFlQCz+urTJ1EgnANembBigjZU77tcvq1l7+Hx7iOy6N+tPL4KjfdwSog2Cs0RXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LOBLLQ+M; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753212287; x=1784748287;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=3dd/ws0FWrilDPNuVMNcBMIppoB7h3664eeTV3AbPFw=;
  b=LOBLLQ+MtgdNfYv63C5fpFfZhOoGeBraNhtxM9UtbO+NIVZTfkxkGgnp
   iFJn63095vWdR2El1f35YC/Cgr5l348Vmnr9oVZdDNz0PgbKsoCmd0qrp
   jIESccRO+9CQvxgTm6N+okZ0bsl8dvoziXyoAKeBTT5OsgRxrADeflcmc
   L/lJDIqGIWNFWkQLypFj70Vob9DF4olc8jGMG5iEYmENF23R5cb6EzDsm
   w9oGUgnlqJ3DGiqsqNTNUWJRKxn40S0WiY3UITbWM+mEz+igNOdlopSHS
   r7Z4NY/2cYaCfvgiPFWJskv9jAooSM5BjXiHWRUN/fjpaYlklHFGLsGN3
   Q==;
X-CSE-ConnectionGUID: BeWAG2w6RqKjrAPiglxhmQ==
X-CSE-MsgGUID: 37WMwETuQ5OUMyKfoRfbTg==
X-IronPort-AV: E=McAfee;i="6800,10657,11500"; a="59277944"
X-IronPort-AV: E=Sophos;i="6.16,332,1744095600"; 
   d="scan'208";a="59277944"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 12:24:46 -0700
X-CSE-ConnectionGUID: pqF62NKLSCCDncpRYCmrjA==
X-CSE-MsgGUID: PaFKCI00Rvq2x1K4Ca6/hw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,332,1744095600"; 
   d="scan'208";a="163467261"
Received: from hlamarch-ivm2.amr.corp.intel.com (HELO [10.125.95.137]) ([10.125.95.137])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 12:24:46 -0700
Message-ID: <074f5f77-7bef-4857-97fe-b68ee9b0afaf@linux.intel.com>
Date: Tue, 22 Jul 2025 12:24:39 -0700
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: "invalid agent type: 1" in acpi/ghes, cper: Recognize and cache CXL
 Protocol errors
To: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
 linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-cxl@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Yazen Ghannam <yazen.ghannam@amd.com>, Terry Bowman <terry.bowman@amd.com>,
 Dave Jiang <dave.jiang@intel.com>, tony.luck@intel.com,
 Gregory Price <gourry@gourry.net>
References: <20250123084421.127697-1-Smita.KoralahalliChannabasappa@amd.com>
 <20250123084421.127697-5-Smita.KoralahalliChannabasappa@amd.com>
Content-Language: en-GB
From: Marc Herbert <marc.herbert@linux.intel.com>
In-Reply-To: <20250123084421.127697-5-Smita.KoralahalliChannabasappa@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Smita,

  The code below triggers the error "invalid agent type: 1" in Intel
validation (internal issue 15018133056)

It's not clear to anyone we asked why you did not include RCH_DP in
the `switch (prot_err->agent_type)` in cxl_cper_post_prot_err() below.

I can see how RCH_DP is special in cxl_cper_PRINT_prot_err() and I can
even understand (despite my near-zero CPER knowledge) some of the
special cases there. But in cxl_cper_post_prot_err() here, it's not
clear why RCH_DP would be rejected. Could this be an oversight? If not,
a comment with a short explanation would not hurt.

Marc

PS: the newer cxl_cper_post_prot_err() code is longer and does
something with `wd`. That's irrelevant for this test case since the
function errors and returns earlier anyway.


On 2025-01-23 00:44, Smita Koralahalli wrote:
> Add support in GHES to detect and process CXL CPER Protocol errors, as
> defined in UEFI v2.10, section N.2.13.
> 
> Define struct cxl_cper_prot_err_work_data to cache CXL protocol error
> information, including RAS capabilities and severity, for further
> handling.
> 
> These cached CXL CPER records will later be processed by workqueues
> within the CXL subsystem.
> 
> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> ---
>  drivers/acpi/apei/ghes.c | 54 ++++++++++++++++++++++++++++++++++++++++
>  include/cxl/event.h      |  6 +++++
>  2 files changed, 60 insertions(+)
> 
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index b72772494655..4d725d988c43 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -674,6 +674,56 @@ static void ghes_defer_non_standard_event(struct acpi_hest_generic_data *gdata,
>  	schedule_work(&entry->work);
>  }
>  
> +static void cxl_cper_post_prot_err(struct cxl_cper_sec_prot_err *prot_err,
> +				   int severity)
> +{
> +#ifdef CONFIG_ACPI_APEI_PCIEAER
> +	struct cxl_cper_prot_err_work_data wd;
> +	u8 *dvsec_start, *cap_start;
> +
> +	if (!(prot_err->valid_bits & PROT_ERR_VALID_AGENT_ADDRESS)) {
> +		pr_err_ratelimited("CXL CPER invalid agent type\n");
> +		return;
> +	}
> +
> +	if (!(prot_err->valid_bits & PROT_ERR_VALID_ERROR_LOG)) {
> +		pr_err_ratelimited("CXL CPER invalid protocol error log\n");
> +		return;
> +	}
> +
> +	if (prot_err->err_len != sizeof(struct cxl_ras_capability_regs)) {
> +		pr_err_ratelimited("CXL CPER invalid RAS Cap size (%u)\n",
> +				   prot_err->err_len);
> +		return;
> +	}
> +
> +	if (!(prot_err->valid_bits & PROT_ERR_VALID_SERIAL_NUMBER))
> +		pr_warn(FW_WARN "CXL CPER no device serial number\n");
> +
> +	switch (prot_err->agent_type) {
> +	case RCD:
> +	case DEVICE:
> +	case LD:
> +	case FMLD:
> +	case RP:
> +	case DSP:
> +	case USP:
> +		memcpy(&wd.prot_err, prot_err, sizeof(wd.prot_err));
> +
> +		dvsec_start = (u8 *)(prot_err + 1);
> +		cap_start = dvsec_start + prot_err->dvsec_len;
> +
> +		memcpy(&wd.ras_cap, cap_start, sizeof(wd.ras_cap));
> +		wd.severity = cper_severity_to_aer(severity);
> +		break;
> +	default:
> +		pr_err_ratelimited("CXL CPER invalid agent type: %d\n",
> +				   prot_err->agent_type);
> +		return;
> +	}
> +#endif
> +}
> +
>  /* Room for 8 entries for each of the 4 event log queues */
>  #define CXL_CPER_FIFO_DEPTH 32
>  DEFINE_KFIFO(cxl_cper_fifo, struct cxl_cper_work_data, CXL_CPER_FIFO_DEPTH);
> @@ -777,6 +827,10 @@ static bool ghes_do_proc(struct ghes *ghes,
>  		}
>  		else if (guid_equal(sec_type, &CPER_SEC_PROC_ARM)) {
>  			queued = ghes_handle_arm_hw_error(gdata, sev, sync);
> +		} else if (guid_equal(sec_type, &CPER_SEC_CXL_PROT_ERR)) {
> +			struct cxl_cper_sec_prot_err *prot_err = acpi_hest_get_payload(gdata);
> +
> +			cxl_cper_post_prot_err(prot_err, gdata->error_severity);
>  		} else if (guid_equal(sec_type, &CPER_SEC_CXL_GEN_MEDIA_GUID)) {
>  			struct cxl_cper_event_rec *rec = acpi_hest_get_payload(gdata);
>  
> diff --git a/include/cxl/event.h b/include/cxl/event.h
> index 66d85fc87701..ee1c3dec62fa 100644
> --- a/include/cxl/event.h
> +++ b/include/cxl/event.h
> @@ -232,6 +232,12 @@ struct cxl_ras_capability_regs {
>  	u32 header_log[16];
>  };
>  
> +struct cxl_cper_prot_err_work_data {
> +	struct cxl_cper_sec_prot_err prot_err;
> +	struct cxl_ras_capability_regs ras_cap;
> +	int severity;
> +};
> +
>  #ifdef CONFIG_ACPI_APEI_GHES
>  int cxl_cper_register_work(struct work_struct *work);
>  int cxl_cper_unregister_work(struct work_struct *work);

