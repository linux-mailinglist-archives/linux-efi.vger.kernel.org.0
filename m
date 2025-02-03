Return-Path: <linux-efi+bounces-2739-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84A38A2632F
	for <lists+linux-efi@lfdr.de>; Mon,  3 Feb 2025 19:59:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB2CE162772
	for <lists+linux-efi@lfdr.de>; Mon,  3 Feb 2025 18:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA5781D63C5;
	Mon,  3 Feb 2025 18:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZHFHYkdy"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A20E1465BA;
	Mon,  3 Feb 2025 18:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738609159; cv=none; b=Ng0JO2pWaVRmDSJUd1m5DTNyWwL42PADrFSFIObWUJ9GSJdPkUFShXPX0FTkt1lu3qzNIes1118ukdgGgefLeUJRkxmbdTIIJ/v2RwQ9d5eMNUwO6mCXBc3GU5jefu/qKZaQdLcNWhNxez7zORFuzVHJIu46Ax232rxP/8f5zOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738609159; c=relaxed/simple;
	bh=/nOi6jdQcYk0gZgHPVlFL+62w87D1oXu43apfhgW1yA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ksd7jMGIH386zibRDlRLtxCs1C5yf2IDzh/xqdX6gKjtHSr8t9B0Igp0BDTGzi2VbUwcWRZg633LKmYFDZtUiYWDv3rqQ3CzZAMcaplbDo2nw7zbOav/thGzXgoSTddAaSnomwZ5QVv7AXo3DlJrS9OqqwxCGFXFl226OMbmiRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZHFHYkdy; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738609157; x=1770145157;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/nOi6jdQcYk0gZgHPVlFL+62w87D1oXu43apfhgW1yA=;
  b=ZHFHYkdye7Lx9RSMlPY7Q/fGrjzHgQ08Hfn5RM5hnayWRCeQojAFjOzd
   TLh8GafsEFmoky6gYxjbyWTGZDS0oUJivs7vzjWWJahiCv1wZ4ZNsJjJ0
   iKD8iYVhGFcxifZ/xsBFESVYxlOien0/KPezjTac501btCymNSQ9buDfO
   Rlf3pSfv/7twZvdJPXhn09y845cPdHo24H1AXKy3eILlDHz7Eyie/UBui
   LfEVXIxuvs19K57PHYO2HA7AOoveV25X9CDpmOvmjNSztUTH9zx0NPAc5
   ytYLCVWeSr7CwP9+QTJL5XF34G0RGf9SIJB+sEWm60nGOdpXAqU27RibD
   Q==;
X-CSE-ConnectionGUID: iF20CZVLRgu7MkJm2NS8yA==
X-CSE-MsgGUID: anocuvzbR02jNXTCCLso0A==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="50526878"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="50526878"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2025 10:59:16 -0800
X-CSE-ConnectionGUID: aQChCtIvQBSWHCWwBD6Yyg==
X-CSE-MsgGUID: 4hZUBpIZSfWANtbg7BuGaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="110832876"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.222.70])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2025 10:59:16 -0800
Date: Mon, 3 Feb 2025 10:59:14 -0800
From: "Luck, Tony" <tony.luck@intel.com>
To: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>,
	Terry Bowman <terry.bowman@amd.com>
Subject: Re: [PATCH v6 4/6] acpi/ghes, cper: Recognize and cache CXL Protocol
 errors
Message-ID: <Z6ESAm79OIAQaXM-@agluck-desk3>
References: <20250123084421.127697-1-Smita.KoralahalliChannabasappa@amd.com>
 <20250123084421.127697-5-Smita.KoralahalliChannabasappa@amd.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250123084421.127697-5-Smita.KoralahalliChannabasappa@amd.com>

On Thu, Jan 23, 2025 at 08:44:19AM +0000, Smita Koralahalli wrote:
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

#ifdef in ".c" code is ugly. But I don't see a less ugly way to deal
with this. Moving this elsewhere and adding an empty stub function
for when CONFIG_ACPI_APEI_PCIEAER isn't configured doesn't make things
any better.

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

Should this be rate limited too? It's not like this device will somehow
acquire a serial number if there is another error.

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
> -- 
> 2.17.1
> 

With added ratelimit mentioned above:

Reviewed-by: Tony Luck <tony.luck@intel.com>

-Tony

