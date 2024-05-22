Return-Path: <linux-efi+bounces-1063-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6393C8CC5F6
	for <lists+linux-efi@lfdr.de>; Wed, 22 May 2024 19:59:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 864231C209AC
	for <lists+linux-efi@lfdr.de>; Wed, 22 May 2024 17:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 584AA143C5B;
	Wed, 22 May 2024 17:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="naWG00b7"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CEA41411FF;
	Wed, 22 May 2024 17:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716400790; cv=none; b=URwB9RI1QMjwxsYXW7LBpj7MmT9Zl3hRyrWGkv+0uC1X8q9GcF7r4vYXkd8IkhICxIZ7M2yr73a6UC5a9+AVnIvguLHNetrQFADP2I8d8bYeO+Q4DBUYLX/8IF8QRQp3GW1ICk8hf0KNxTRWg0P6VcIY4q0/5SO2hYktTKVxW0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716400790; c=relaxed/simple;
	bh=m8dSaMf+9viOYLDWhAIIO5d+dTaOcVWzhd5wL34Njkk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I58Wf9oEEoUUD11BUlqFbUlDNZVvjXY3nDEiLp62N3IYi2OCw8zbHKuCPmQvEjEqhA07nLdGU9bPDxxA6q3V1UEP/ca7t2TCSIQBEA0NLpZiyTj3tw0uErJl8nKPZfsCovRX2ILMiSsUv4oqQ2hjUhIa6Ndeq7sdhTl57lyVJnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=naWG00b7; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716400788; x=1747936788;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=m8dSaMf+9viOYLDWhAIIO5d+dTaOcVWzhd5wL34Njkk=;
  b=naWG00b75Tf3q3vOMd0nVBuhx5WaeadodDoftSYZwQmYyx12BZ2jx8uT
   9bdwiIQry4yILrWy3g1JJY+w1seQ19/6Fp+MTboAfJwELYK2TmUZxx+36
   msT6m8IQ0D24DjZ6+J+C2iomu56D84ioFMFrxWG65segW4+rsZSTIMxm/
   N4JfQRMdwAoROhuVFUgrFuLjGJErGoNI4T7g5i6dqHK7o1zE4TKVQyVO5
   hn2nBac/D9VtAtF3GUQg+QXg7P5P2TMslQwsLCRoRnND72xIgtn93t8oF
   jjO7toJXXvx+bUAZdVGl2kUgFOwbKVhXZmhe0suGbpu31hM3QYfGTMNBS
   Q==;
X-CSE-ConnectionGUID: i//ccQYJS0KrP1+6bwjCNQ==
X-CSE-MsgGUID: Rvue0N8tS829Y1yzeZQUhw==
X-IronPort-AV: E=McAfee;i="6600,9927,11080"; a="15624524"
X-IronPort-AV: E=Sophos;i="6.08,181,1712646000"; 
   d="scan'208";a="15624524"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2024 10:59:47 -0700
X-CSE-ConnectionGUID: RflMnJeIRfCjQ79P9qwagA==
X-CSE-MsgGUID: NgPq+JFfT4Ww72g129iM7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,181,1712646000"; 
   d="scan'208";a="33833457"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.125.109.237]) ([10.125.109.237])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2024 10:59:46 -0700
Message-ID: <8470dcc5-fbd4-4977-b8e8-5f7bfbf4b220@intel.com>
Date: Wed, 22 May 2024 10:59:45 -0700
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] acpi/ghes, efi/cper: Recognize and process CXL
 Protocol Errors.
To: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
 linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-cxl@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Yazen Ghannam <yazen.ghannam@amd.com>, Bowman Terry <terry.bowman@amd.com>
References: <20240522150839.27578-1-Smita.KoralahalliChannabasappa@amd.com>
 <20240522150839.27578-3-Smita.KoralahalliChannabasappa@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20240522150839.27578-3-Smita.KoralahalliChannabasappa@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/22/24 8:08 AM, Smita Koralahalli wrote:
> UEFI v2.10 section N.2.13 defines a CPER record for CXL Protocol errors.
> 
> Add GHES support to detect CXL CPER Protocol Error Record and Cache Error
> Severity, Device ID, Device Serial number and CXL RAS capability struct in
> struct cxl_cper_prot_err. Include this struct as a member of struct
> cxl_cper_work_data.
> 
> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> ---
>  drivers/acpi/apei/ghes.c        | 10 +++++
>  drivers/firmware/efi/cper_cxl.c | 66 +++++++++++++++++++++++++++++++++
>  include/linux/cxl-event.h       | 26 +++++++++++++
>  3 files changed, 102 insertions(+)
> 
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index 623cc0cb4a65..1a58032770ee 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -717,6 +717,14 @@ static void cxl_cper_post_event(enum cxl_event_type event_type,
>  	schedule_work(cxl_cper_work);
>  }
>  
> +static void cxl_cper_handle_prot_err(struct acpi_hest_generic_data *gdata)
> +{
> +	struct cxl_cper_work_data wd;
> +
> +	if (cxl_cper_handle_prot_err_info(gdata, &wd.p_err))
> +		return;
> +}
> +
>  int cxl_cper_register_work(struct work_struct *work)
>  {
>  	if (cxl_cper_work)
> @@ -791,6 +799,8 @@ static bool ghes_do_proc(struct ghes *ghes,
>  			struct cxl_cper_event_rec *rec = acpi_hest_get_payload(gdata);
>  
>  			cxl_cper_post_event(CXL_CPER_EVENT_MEM_MODULE, rec);
> +		} else if (guid_equal(sec_type, &CPER_SEC_CXL_PROT_ERR)) {
> +			cxl_cper_handle_prot_err(gdata);
>  		} else {
>  			void *err = acpi_hest_get_payload(gdata);
>  
> diff --git a/drivers/firmware/efi/cper_cxl.c b/drivers/firmware/efi/cper_cxl.c
> index 4fd8d783993e..03b9839f3b73 100644
> --- a/drivers/firmware/efi/cper_cxl.c
> +++ b/drivers/firmware/efi/cper_cxl.c
> @@ -8,6 +8,7 @@
>   */
>  
>  #include <linux/cper.h>
> +#include <acpi/ghes.h>
>  #include "cper_cxl.h"
>  
>  #define PROT_ERR_VALID_AGENT_TYPE		BIT_ULL(0)
> @@ -44,6 +45,17 @@ enum {
>  	USP,	/* CXL Upstream Switch Port */
>  };
>  
> +static enum cxl_aer_err_type cper_severity_cxl_aer(int cper_severity)
> +{
> +	switch (cper_severity) {
> +	case CPER_SEV_RECOVERABLE:
> +	case CPER_SEV_FATAL:
> +		return CXL_AER_UNCORRECTABLE;
> +	default:
> +		return CXL_AER_CORRECTABLE;
> +	}
> +}
> +
>  void cper_print_prot_err(const char *pfx, const struct cper_sec_prot_err *prot_err)
>  {
>  	if (prot_err->valid_bits & PROT_ERR_VALID_AGENT_TYPE)
> @@ -176,3 +188,57 @@ void cper_print_prot_err(const char *pfx, const struct cper_sec_prot_err *prot_e
>  			       sizeof(cxl_ras->header_log), 0);
>  	}
>  }
> +
> +int cxl_cper_handle_prot_err_info(struct acpi_hest_generic_data *gdata,
> +				  struct cxl_cper_prot_err *p_err)
> +{
> +	struct cper_sec_prot_err *prot_err = acpi_hest_get_payload(gdata);
> +	u8 *dvsec_start, *cap_start;
> +
> +	if (!(prot_err->valid_bits & PROT_ERR_VALID_DEVICE_ID)) {
> +		pr_err(FW_WARN "No Device ID\n");
> +		return -EINVAL;
> +	}
> +
> +	/*
> +	 * The device ID or agent address is required for CXL RCD, CXL
> +	 * SLD, CXL LD, CXL Fabric Manager Managed LD, CXL Root Port,
> +	 * CXL Downstream Switch Port and CXL Upstream Switch Port.
> +	 */
> +	if (prot_err->agent_type <= 0x7 && prot_err->agent_type != RCH_DP) {

Perhaps define an enum CXL_AGENT_TYPE_MAX instead of 0x7 magic number? Otherwise if a new type is introduced, it would break this code.
 
> +		p_err->segment = prot_err->agent_addr.segment;
> +		p_err->bus = prot_err->agent_addr.bus;
> +		p_err->device = prot_err->agent_addr.device;
> +		p_err->function = prot_err->agent_addr.function;
> +	} else {
> +		pr_err(FW_WARN "Invalid agent type\n");
> +		return -EINVAL;
> +	}

Up to you if you want to do this or not, but maybe:

	if (prot_err->agent_type >= CXL_AGENT_TYPE_MAX || prot_err->agent_type == RCH_DP) {
		pr_warn(...);
		return -EINVAL;
	}

	p_err->segment = ...;
	p_err->bus = ...;
	...

Although perhaps a helper function cxl_cper_valid_agent_type() that checks invalid agent type by checking the valid_bits, the agent_type boundary, and if agent_type != RCH_DP?
> +
> +	if (!(prot_err->valid_bits & PROT_ERR_VALID_ERROR_LOG)) {
> +		pr_err(FW_WARN "Invalid Protocol Error log\n");
> +		return -EINVAL;
> +	}
> +
> +	dvsec_start = (u8 *)(prot_err + 1);
> +	cap_start = dvsec_start + prot_err->dvsec_len;
> +	p_err->cxl_ras = *(struct cxl_ras_capability_regs *)cap_start;
> +
> +	/*
> +	 * Set device serial number unconditionally.
> +	 *
> +	 * Print a warning message if it is not valid. The device serial
> +	 * number is required for CXL RCD, CXL SLD, CXL LD and CXL Fabric
> +	 * Manager Managed LD.
> +	 */
> +	if (!(prot_err->valid_bits & PROT_ERR_VALID_SERIAL_NUMBER) ||
> +	      prot_err->agent_type > 0x4 || prot_err->agent_type == RCH_DP)

prot_err->agent_type > FM_LD? Although maybe it would be a clearer read if a helper function is defined to identify the agent types such as cxl_cper_prot_err_serial_needed() or cxl_cper_prot_agent_type_device() and with it a switch statement to explicitly identify all the agent types that require serial number. If a future device is defined, the > 0x4 logic may break.  

DJ

> +		pr_warn(FW_WARN "No Device Serial number\n");
> +
> +	p_err->lower_dw = prot_err->dev_serial_num.lower_dw;
> +	p_err->upper_dw = prot_err->dev_serial_num.upper_dw;
> +
> +	p_err->severity = cper_severity_cxl_aer(gdata->error_severity);
> +
> +	return 0;
> +}
> diff --git a/include/linux/cxl-event.h b/include/linux/cxl-event.h
> index f11e52ff565a..9c7b69e076a0 100644
> --- a/include/linux/cxl-event.h
> +++ b/include/linux/cxl-event.h
> @@ -165,11 +165,37 @@ struct cxl_ras_capability_regs {
>  	u32 header_log[16];
>  };
>  
> +enum cxl_aer_err_type {
> +	CXL_AER_UNCORRECTABLE,
> +	CXL_AER_CORRECTABLE,
> +};
> +
> +struct cxl_cper_prot_err {
> +	struct cxl_ras_capability_regs cxl_ras;
> +
> +	/* Device ID */
> +	u8 function;
> +	u8 device;
> +	u8 bus;
> +	u16 segment;
> +
> +	/* Device Serial Number */
> +	u32 lower_dw;
> +	u32 upper_dw;
> +
> +	int severity;
> +};
> +
>  struct cxl_cper_work_data {
>  	enum cxl_event_type event_type;
>  	struct cxl_cper_event_rec rec;
> +	struct cxl_cper_prot_err p_err;
>  };
>  
> +struct acpi_hest_generic_data;
> +int cxl_cper_handle_prot_err_info(struct acpi_hest_generic_data *gdata,
> +				  struct cxl_cper_prot_err *p_err);
> +
>  #ifdef CONFIG_ACPI_APEI_GHES
>  int cxl_cper_register_work(struct work_struct *work);
>  int cxl_cper_unregister_work(struct work_struct *work);

