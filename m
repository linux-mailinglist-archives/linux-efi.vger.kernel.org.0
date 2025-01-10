Return-Path: <linux-efi+bounces-2574-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 166F5A0973E
	for <lists+linux-efi@lfdr.de>; Fri, 10 Jan 2025 17:24:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A55773A9B28
	for <lists+linux-efi@lfdr.de>; Fri, 10 Jan 2025 16:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 088B9211A19;
	Fri, 10 Jan 2025 16:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bPSGYoH7"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D972212D7C;
	Fri, 10 Jan 2025 16:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736526262; cv=none; b=In/LUY/bM74UtdGCXw0lFgCJiVDZSnG1gXbT6j2x3izbYdv+yBoxJ/qltESD5D8XakgxxltXOEy52TOrA8PhF283JXgu+onRxuZ1CgohiSLC+IQXWLOxj1j1u/21omSHhEqce1zeB/q+fCgsKMHkLYfUn1RsqVWbA8sESM6Jyv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736526262; c=relaxed/simple;
	bh=ycTW+N/fGzdzPCXRpaZyC+j8WT5ekMm5rkXGi1WTylE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pshc8IsFnNUPBqfM48AovgZTrO3+OAhZI3TZKy9wz6wggUsO8jSqQKn33pqapmyJ9q+f7rt+3jQF1qEucRE/jfzR7Pe6fcLo76gS0O5ax2vQDW+TUF3YDFjdB+xlX7QDXo7N+MGjSv6dqrrrd5MggbBXe2kw7YZJ39A9rJ5L97U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bPSGYoH7; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736526261; x=1768062261;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ycTW+N/fGzdzPCXRpaZyC+j8WT5ekMm5rkXGi1WTylE=;
  b=bPSGYoH7+/kCmZiZgPXBkdHiT/Qzud/TxvHlTM5UuLNNJWCjEQJ3eA5T
   XsrFbsqoMMqYLEQWCwzQkYY4tVgSodynyKw09gYLF0qswVu7KYeslil1e
   Wx2K8fzL1/xNV8+3vhsyYXW04sPAa76h6IB7TLMPfHTKw35joJaC22mmo
   MbAIYNL8O50SxwveRkHAnW3TgTsKcVOL0qUJiHkytc+uQAbiTzPvAvMCe
   T/2y5I0Y3Gi/AaKlIMd0/1qAc0U+vLriebD2HZmTGpJddqYYt1L/tZqCR
   My2JmTd8PpeC/l1oOBpN2gU7Urk7svBkm9ddy/+19MtPKMa9Wxg8V96UM
   g==;
X-CSE-ConnectionGUID: 2kEx4TyXREG0IiRx3Yzm7w==
X-CSE-MsgGUID: urbSKJ+rRj2TDXk2aXfpcQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11311"; a="36725429"
X-IronPort-AV: E=Sophos;i="6.12,303,1728975600"; 
   d="scan'208";a="36725429"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2025 08:24:21 -0800
X-CSE-ConnectionGUID: 9PSg+zbsT8KVVlkslWtn1g==
X-CSE-MsgGUID: 4UiR8MsdQy2Mb+9wTIOQ7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,303,1728975600"; 
   d="scan'208";a="104335961"
Received: from ehanks-mobl1.amr.corp.intel.com (HELO [10.125.111.175]) ([10.125.111.175])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2025 08:24:19 -0800
Message-ID: <8373bda4-6fb2-4bbb-9d19-9b1369cba666@intel.com>
Date: Fri, 10 Jan 2025 09:24:18 -0700
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/5] acpi/ghes, cper: Recognize and cache CXL Protocol
 errors
To: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
 linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-cxl@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Yazen Ghannam <yazen.ghannam@amd.com>, Terry Bowman <terry.bowman@amd.com>
References: <20241217022032.87298-1-Smita.KoralahalliChannabasappa@amd.com>
 <20241217022032.87298-5-Smita.KoralahalliChannabasappa@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20241217022032.87298-5-Smita.KoralahalliChannabasappa@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/16/24 7:20 PM, Smita Koralahalli wrote:
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

With the issue Ira pointed out fixed,
Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/acpi/apei/ghes.c | 52 ++++++++++++++++++++++++++++++++++++++++
>  include/cxl/event.h      |  6 +++++
>  2 files changed, 58 insertions(+)
> 
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index ada93cfde9ba..63afef58b3b7 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -676,6 +676,54 @@ static void ghes_defer_non_standard_event(struct acpi_hest_generic_data *gdata,
>  	schedule_work(&entry->work);
>  }
>  
> +static void cxl_cper_post_prot_err(struct cxl_cper_sec_prot_err *prot_err,
> +				   int severity)
> +{
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
> +}
> +
>  /* Room for 8 entries for each of the 4 event log queues */
>  #define CXL_CPER_FIFO_DEPTH 32
>  DEFINE_KFIFO(cxl_cper_fifo, struct cxl_cper_work_data, CXL_CPER_FIFO_DEPTH);
> @@ -779,6 +827,10 @@ static bool ghes_do_proc(struct ghes *ghes,
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


