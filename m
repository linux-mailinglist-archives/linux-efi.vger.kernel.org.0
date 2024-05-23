Return-Path: <linux-efi+bounces-1067-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C68DA8CCA08
	for <lists+linux-efi@lfdr.de>; Thu, 23 May 2024 02:04:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1DD31C210C9
	for <lists+linux-efi@lfdr.de>; Thu, 23 May 2024 00:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31CC7365;
	Thu, 23 May 2024 00:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hZAw7k6I"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2341A29;
	Thu, 23 May 2024 00:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716422636; cv=none; b=kEqj1QdV7IGPJrPNvFRJd57NdbmGFkWBJFm57eN5ocVE8g+OWpjzNnSzEUnfxAN9+9zeh8VwKNn0Yxnu+0cMdd8TwyIVg71AyFI1maRlwcp4pPcWQKP4XYi9X65YdJZBx6l0bXIdgRu8VSIg1UUg/QTkin11up+H2v0Fd+kMZm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716422636; c=relaxed/simple;
	bh=RT+caFpkAm8/AIPivntwX9aXZiZnGg/DtgFipSNqI6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zic3r8iaxQZl+ZDIhadgOENnBzqXOQlL/7saQUGTPvLHp0S/CfQzWWVnRB/DeHORHm0eec/fz06/uDzeI9qmkklhHhQOl1pvyYUEofCYzGOd2g122vvVmlBCK4+jc59hUonjvYn/qGDdv4HCbNY6bXt0DwQqVNlj2IIfgcH3Ydc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hZAw7k6I; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716422634; x=1747958634;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RT+caFpkAm8/AIPivntwX9aXZiZnGg/DtgFipSNqI6A=;
  b=hZAw7k6IhQfXovVUd2c94xuI4/9kRHZaeVaP/qWaGxpMGPPPfth6q/Xm
   NMggRQTzARTt61ci6Ms8zkA+6TeRzS1keOdAO0MPYuUySDuQf2HXK9Rqa
   f88hY1ViOvSCUNF3/l0BObaz3k4zIYXihQ4+8D0UCgmYhBVuvnhjpcEjW
   vHf2seicL9pVnohZVv+i3Kn0Q8ZNHNkDfqmAfFMfh9VCCUB1kiIo73jhS
   rMybHuXixg0rJCFz8MJp5k+55D1/6p21AG4ZrKIBYHOLVL3xeJS8z7Mff
   9uUyoqdWHxZ9MRJnI01WUHQCDDC3yE0/PKIpdg1S+TLhfeGfP0FsSwiu1
   Q==;
X-CSE-ConnectionGUID: 3jDGynsvTymHtkQaGm6IWg==
X-CSE-MsgGUID: /8ALuBZxSfW3KEidi2A/8w==
X-IronPort-AV: E=McAfee;i="6600,9927,11080"; a="16550767"
X-IronPort-AV: E=Sophos;i="6.08,181,1712646000"; 
   d="scan'208";a="16550767"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2024 17:03:53 -0700
X-CSE-ConnectionGUID: NcroTDNgQg2DVSyzolN95g==
X-CSE-MsgGUID: qnFzbpJoTi6mM829vak6Pg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,181,1712646000"; 
   d="scan'208";a="33309965"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.68.11])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2024 17:03:52 -0700
Date: Wed, 22 May 2024 17:03:50 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>,
	Bowman Terry <terry.bowman@amd.com>
Subject: Re: [PATCH 2/4] acpi/ghes, efi/cper: Recognize and process CXL
 Protocol Errors.
Message-ID: <Zk6H5jTdVfN4aFhF@aschofie-mobl2>
References: <20240522150839.27578-1-Smita.KoralahalliChannabasappa@amd.com>
 <20240522150839.27578-3-Smita.KoralahalliChannabasappa@amd.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240522150839.27578-3-Smita.KoralahalliChannabasappa@amd.com>

On Wed, May 22, 2024 at 03:08:37PM +0000, Smita Koralahalli wrote:
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

For this check against agent_type, and the similar one below, would a boolean
array indexed by the agent type work? That would avoid the <= 0x7 and > 0x4 
below. It seems one array would suffice for this case, but naming it isn't obvious
to me. Maybe it'll be to you.

Something similar to what is done for prot_err_agent_type_strs[]

static const bool agent_requires_id_address_serial[] = {
	true,	/* RDC */ 	
	false,	/* RCH_DP */
	.
	.
	.
};


> +		p_err->segment = prot_err->agent_addr.segment;
> +		p_err->bus = prot_err->agent_addr.bus;
> +		p_err->device = prot_err->agent_addr.device;
> +		p_err->function = prot_err->agent_addr.function;
> +	} else {
> +		pr_err(FW_WARN "Invalid agent type\n");
> +		return -EINVAL;
> +	}
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

then this also can be replaced with
		agent_requires_id_address_serial[prot_err->agent_type]


-- Alison


> +		pr_warn(FW_WARN "No Device Serial number\n");
> +
> +	p_err->lower_dw = prot_err->dev_serial_num.lower_dw;
> +	p_err->upper_dw = prot_err->dev_serial_num.upper_dw;
> +
> +	p_err->severity = cper_severity_cxl_aer(gdata->error_severity);
> +
> +	return 0;
> +}

snip


