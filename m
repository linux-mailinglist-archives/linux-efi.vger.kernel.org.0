Return-Path: <linux-efi+bounces-1064-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D475F8CC614
	for <lists+linux-efi@lfdr.de>; Wed, 22 May 2024 20:07:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BBD71F24900
	for <lists+linux-efi@lfdr.de>; Wed, 22 May 2024 18:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B68E0145B1D;
	Wed, 22 May 2024 18:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KvaZcWE9"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498E51487C5;
	Wed, 22 May 2024 18:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716401153; cv=none; b=HGkgxTAZH92S3alPrj3tfccSk/Fl1WiBPwaNUVBEHhkTpF2BGbYRd6NtfHZourlBdjNAM2c/iGm2cGT4FV9WhlM9aHy5w+fcpnXutAen6s3OB9/W/Y2ZvtW9LDxQBBQU8t4qoi5lj6ZcJyeMyBWw1n/0fzSDvBWn1RRnzxlayUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716401153; c=relaxed/simple;
	bh=rGKA2eDEvUItRMtWurjYPOOFfebKNdda5YnYlMMO0K4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i71pUw42bwGenPseXGvE184AmDmkMgd9rg+Jlj2s2nWMqvuPXqzHRtcHJRIYN9a6yKQC7KmgZy/RB42kRGcRt+DGqK+qbeclxZPOp0X0q4yNos5jLUrag94EU6uZ6qrYtNvFNJUajFT7Vid15GEpHnj0CKOquQLkiZ1APPRDBIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KvaZcWE9; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716401151; x=1747937151;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=rGKA2eDEvUItRMtWurjYPOOFfebKNdda5YnYlMMO0K4=;
  b=KvaZcWE961W0HpTEUoRlyBnODHHJ2XgjjzvEtKzJTIlPKN0VLmmgo9Pe
   RQ/2tRvx1Rnj4YEtiTvjd54ASLQriG1XCs/EKjMT6xs/FWdROvEfbCQ0F
   HsZyuyABSKnpdlrv0L3iazPws+I3V9YNlWWJeVTqe4TZRXfu49N44i24y
   wVw47fFTmvt2IgpLOfiBBPkCmFl71U+Wqaeq3HZz2P7ROU1Q6yyjF7u8D
   StikRavZdObMAycx8jYdORGtFqj1bWLqTjTTwF0aMSiVuXi2/sFohup46
   cJvS2Yj7VB6bkoJF7IPafULv3fzxan074PyX+gHOOlxLIn5YdhHfgi7AT
   w==;
X-CSE-ConnectionGUID: rI3Q7YFYT7upXEa0uqguBw==
X-CSE-MsgGUID: RQ7DS5BbQze/LlIa5uwNGA==
X-IronPort-AV: E=McAfee;i="6600,9927,11080"; a="23340835"
X-IronPort-AV: E=Sophos;i="6.08,181,1712646000"; 
   d="scan'208";a="23340835"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2024 11:05:50 -0700
X-CSE-ConnectionGUID: ndMXfA3GRVWUmcf4dXcPeA==
X-CSE-MsgGUID: bOIZU3NbTnCcVNh3qRuyAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,181,1712646000"; 
   d="scan'208";a="38164509"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.125.109.237]) ([10.125.109.237])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2024 11:05:50 -0700
Message-ID: <7dc64418-6821-49c2-b9af-ee4ab148ba9f@intel.com>
Date: Wed, 22 May 2024 11:05:49 -0700
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] acpi/ghes, cxl/pci: Trace FW-First CXL Protocol
 Errors
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
 <20240522150839.27578-4-Smita.KoralahalliChannabasappa@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20240522150839.27578-4-Smita.KoralahalliChannabasappa@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/22/24 8:08 AM, Smita Koralahalli wrote:
> When PCIe AER is in FW-First, OS should process CXL Protocol errors from
> CPER records.
> 
> Reuse the existing work queue cxl_cper_work registered with GHES to notify
> the CXL subsystem on a Protocol error.
> 
> The defined trace events cxl_aer_uncorrectable_error and
> cxl_aer_correctable_error currently trace native CXL AER errors. Reuse
> them to trace FW-First Protocol Errors.
> 
> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> ---
>  drivers/acpi/apei/ghes.c  | 14 ++++++++++++++
>  drivers/cxl/core/pci.c    | 24 ++++++++++++++++++++++++
>  drivers/cxl/cxlpci.h      |  3 +++
>  drivers/cxl/pci.c         | 34 ++++++++++++++++++++++++++++++++--
>  include/linux/cxl-event.h |  1 +
>  5 files changed, 74 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index 1a58032770ee..a31bd91e9475 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -723,6 +723,20 @@ static void cxl_cper_handle_prot_err(struct acpi_hest_generic_data *gdata)
>  
>  	if (cxl_cper_handle_prot_err_info(gdata, &wd.p_err))
>  		return;
> +
> +	guard(spinlock_irqsave)(&cxl_cper_work_lock);
> +
> +	if (!cxl_cper_work)
> +		return;
> +
> +	wd.event_type = CXL_CPER_EVENT_PROT_ERR;
> +
> +	if (!kfifo_put(&cxl_cper_fifo, wd)) {
> +		pr_err_ratelimited("CXL CPER kfifo overflow\n");
> +		return;
> +	}
> +
> +	schedule_work(cxl_cper_work);
>  }
>  
>  int cxl_cper_register_work(struct work_struct *work)
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 0df09bd79408..ef9438cb1dd6 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -686,6 +686,30 @@ void read_cdat_data(struct cxl_port *port)
>  }
>  EXPORT_SYMBOL_NS_GPL(read_cdat_data, CXL);
>  
> +void cxl_trace_prot_err(struct cxl_dev_state *cxlds,
> +			struct cxl_cper_prot_err *p_err)
> +{
> +	u32 status, fe;
> +
> +	if (p_err->severity == CXL_AER_CORRECTABLE) {
> +		status = p_err->cxl_ras.cor_status & ~p_err->cxl_ras.cor_mask;
> +
> +		trace_cxl_aer_correctable_error(cxlds->cxlmd, status);
> +	} else {
> +		status = p_err->cxl_ras.uncor_status & ~p_err->cxl_ras.uncor_mask;
> +
> +		if (hweight32(status) > 1)
> +			fe = BIT(FIELD_GET(CXL_RAS_CAP_CONTROL_FE_MASK,
> +					   p_err->cxl_ras.cap_control));
> +		else
> +			fe = status;
> +
> +		trace_cxl_aer_uncorrectable_error(cxlds->cxlmd, status, fe,
> +						  p_err->cxl_ras.header_log);
> +	}
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_trace_prot_err, CXL);
> +
>  static void __cxl_handle_cor_ras(struct cxl_dev_state *cxlds,
>  				 void __iomem *ras_base)
>  {
> diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
> index 93992a1c8eec..0ba3215786e1 100644
> --- a/drivers/cxl/cxlpci.h
> +++ b/drivers/cxl/cxlpci.h
> @@ -130,4 +130,7 @@ void read_cdat_data(struct cxl_port *port);
>  void cxl_cor_error_detected(struct pci_dev *pdev);
>  pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
>  				    pci_channel_state_t state);
> +struct cxl_cper_prot_err;
> +void cxl_trace_prot_err(struct cxl_dev_state *cxlds,
> +			struct cxl_cper_prot_err *p_err);
>  #endif /* __CXL_PCI_H__ */
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 74876c9835e8..3e3c36983686 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -1011,12 +1011,42 @@ static void cxl_handle_cper_event(enum cxl_event_type ev_type,
>  			       &uuid_null, &rec->event);
>  }
>  
> +static void cxl_handle_prot_err(struct cxl_cper_prot_err *p_err)
> +{
> +	struct pci_dev *pdev __free(pci_dev_put) = NULL;
> +	struct cxl_dev_state *cxlds;
> +	unsigned int devfn;
> +
> +	devfn = PCI_DEVFN(p_err->device, p_err->function);
> +	pdev = pci_get_domain_bus_and_slot(p_err->segment,
> +					   p_err->bus, devfn);
> +	if (!pdev)
> +		return;
> +
> +	guard(device)(&pdev->dev);
> +	if (pdev->driver != &cxl_pci_driver)
> +		return;
> +
> +	cxlds = pci_get_drvdata(pdev);
> +	if (!cxlds)
> +		return;
> +
> +	if (((u64)p_err->upper_dw << 32 | p_err->lower_dw) != cxlds->serial)
> +		pr_warn("CPER-reported device serial number does not match expected value\n");

Given that we are operating on a device, perhaps dev_warn(&pdev->dev, ...) may be better served.

DJ
> +
> +	cxl_trace_prot_err(cxlds, p_err);
> +}
> +
>  static void cxl_cper_work_fn(struct work_struct *work)
>  {
>  	struct cxl_cper_work_data wd;
>  
> -	while (cxl_cper_kfifo_get(&wd))
> -		cxl_handle_cper_event(wd.event_type, &wd.rec);
> +	while (cxl_cper_kfifo_get(&wd)) {
> +		if (wd.event_type == CXL_CPER_EVENT_PROT_ERR)
> +			cxl_handle_prot_err(&wd.p_err);
> +		else
> +			cxl_handle_cper_event(wd.event_type, &wd.rec);
> +	}
>  }
>  static DECLARE_WORK(cxl_cper_work, cxl_cper_work_fn);
>  
> diff --git a/include/linux/cxl-event.h b/include/linux/cxl-event.h
> index 9c7b69e076a0..5562844df850 100644
> --- a/include/linux/cxl-event.h
> +++ b/include/linux/cxl-event.h
> @@ -122,6 +122,7 @@ struct cxl_event_record_raw {
>  } __packed;
>  
>  enum cxl_event_type {
> +	CXL_CPER_EVENT_PROT_ERR,
>  	CXL_CPER_EVENT_GENERIC,
>  	CXL_CPER_EVENT_GEN_MEDIA,
>  	CXL_CPER_EVENT_DRAM,

