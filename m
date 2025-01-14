Return-Path: <linux-efi+bounces-2628-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7208CA10B46
	for <lists+linux-efi@lfdr.de>; Tue, 14 Jan 2025 16:43:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D7EA1614A4
	for <lists+linux-efi@lfdr.de>; Tue, 14 Jan 2025 15:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8089B159209;
	Tue, 14 Jan 2025 15:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KpbWhxiF"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C870149C57;
	Tue, 14 Jan 2025 15:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736869236; cv=none; b=lq2gHYCEKdHTHvRF6xrIHQWAX7R12A1utJPaRMwFqPXnzT+gnc3IBKcyn7jba+mp9Az6+c3OamwU6WvAuK7bomPBJk7ERxLlMd2clmRWuz1GOwfFa+8Ej+JQxW2QXv/uTmYXfdgSVZ1QHFKbvQpyD6y0sDsIiagsbr6klDa1WwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736869236; c=relaxed/simple;
	bh=EXSVcHZr13xDJlJ13qdV5eLNwcKS7ozyesIncTS9lUc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=US8ri2m/mBC8+bjiB1adnR14ONMlD6Svq5XNMSftdM2ufsL0M0zssXdiEVSlHc7kSUQ2h3HXCnbxMsdozTnNUDnAMEEcsHgk+kUfP97b+LP/HRulUpqWz+Whz+U+Dtr2cbqLSjmSqwS3F5bQ33fcQ+ulTUJsIGC1xnXSXxuYrLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KpbWhxiF; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736869234; x=1768405234;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=EXSVcHZr13xDJlJ13qdV5eLNwcKS7ozyesIncTS9lUc=;
  b=KpbWhxiFjN/62nhx0IKCHmICGagQ7tZg+n/8XNdkr3cc0LtsbeHhFWGi
   fFRLZyKopBQQp3R277SQVMRtcQwNcRDe/cnZpnV5YJZEZhowWoeV92hzN
   cOMQkFr4yioUrJLFJNwqOlDKyVsOuadGOWhxTcVCWutkGK2zNnavkP/fb
   FOJc3bc8vyj3j8Y+FSrVe5RiASpXx0KhCKgTeLaKedyIupLQhA9PMTJbV
   mmCeMgvY3Bieia201G78og0bQ6uL8v8gpBmian4m7kKT8KblL52nfJyf9
   6CFihOKCfUjHMcHUQzDj/MXC9YEtvemdoe7lLZHYCbHqbgjCYY+gO+seS
   g==;
X-CSE-ConnectionGUID: wevlWOWsS7uO9Z05C2BsBg==
X-CSE-MsgGUID: l+p3ChlnQ9CH+/P6UrShkQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11315"; a="54588963"
X-IronPort-AV: E=Sophos;i="6.12,314,1728975600"; 
   d="scan'208";a="54588963"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 07:40:34 -0800
X-CSE-ConnectionGUID: 5reZp7ytQDqLMoZkf4+27Q==
X-CSE-MsgGUID: gS/viDhjREOlzPhzriuONg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="128087772"
Received: from inaky-mobl1.amr.corp.intel.com (HELO [10.125.108.148]) ([10.125.108.148])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 07:40:25 -0800
Message-ID: <08417bb6-ffc5-44e8-a0c4-b38e914c107c@intel.com>
Date: Tue, 14 Jan 2025 08:40:23 -0700
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/5] acpi/ghes, cper: Recognize and cache CXL Protocol
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
References: <20250114120427.149260-1-Smita.KoralahalliChannabasappa@amd.com>
 <20250114120427.149260-5-Smita.KoralahalliChannabasappa@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250114120427.149260-5-Smita.KoralahalliChannabasappa@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/14/25 5:04 AM, Smita Koralahalli wrote:
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

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/acpi/apei/ghes.c | 54 ++++++++++++++++++++++++++++++++++++++++
>  include/cxl/event.h      |  6 +++++
>  2 files changed, 60 insertions(+)
> 
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index 07789f0b59bc..4ab3c8ae1360 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -676,6 +676,56 @@ static void ghes_defer_non_standard_event(struct acpi_hest_generic_data *gdata,
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
> @@ -779,6 +829,10 @@ static bool ghes_do_proc(struct ghes *ghes,
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


