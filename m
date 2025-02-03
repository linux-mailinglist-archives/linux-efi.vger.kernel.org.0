Return-Path: <linux-efi+bounces-2740-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FC1EA26344
	for <lists+linux-efi@lfdr.de>; Mon,  3 Feb 2025 20:03:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0D8A3A2485
	for <lists+linux-efi@lfdr.de>; Mon,  3 Feb 2025 19:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C6301D516C;
	Mon,  3 Feb 2025 19:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Sbija6gW"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9D2194AEC;
	Mon,  3 Feb 2025 19:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738609409; cv=none; b=hYKAtS9YkFGf2Y2mb4m9+HmcW4hDS9iyd906A/XEW7AllqygcbjKQVTVjcreoUSIa3sw4FmH/JE1lRPgsl3XDpEhHdTQR4OF0BAOwR+My2mgyuD2oUzZd1wOQdS7fNz2QUif1IH/KHYOBmlI5MRqdIsr8Ts/5/D4Kgs0E3c74iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738609409; c=relaxed/simple;
	bh=XQhXHbhAEDtxueqiSGQTYU0jh9vxvyAdS/Wgrh2l3Kw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y7GmFuTHgY8j8JLWQz46tPWEMvmthkLte3GPgcqFyc1oPiHiyKoEcPJQ3CZqc2JD6hm2ZBGpr30dLhFfWgxzL4rMcw4nDdLsM8nIj4oRa0pM+Asmy1vBKNWN0Qaz0zhU4OYN5Xc/kF/7IL1YiA3M9t0MdaPhgkoHYPiDJmEf17o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Sbija6gW; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738609406; x=1770145406;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XQhXHbhAEDtxueqiSGQTYU0jh9vxvyAdS/Wgrh2l3Kw=;
  b=Sbija6gW5xkPxgd8OnjrOiJlto672Pg85nQW4bHfZ7QvEiNgHuTPz2+I
   UtV3E/XrXfqtpEj76fDyGK6iEVYZqMakSiBrFphq78w1iST2Gn8meYcSH
   ZGXn69wUxSSWIEXX3s6eb0T7C6P+tQrpu4mCtdNQ1bh9pjbGJ539hru3k
   8f/Ebofju5S38dZe042bB+FLm/P9xA1aP2Cgw4JbubkVVoOXjEeuSswTr
   Pg8uEAzwu/N6g/nR89sDpFuHaGK/do9SQ6b+fSD3tK4su6YgFayVlPGch
   gKllBI+dcfUi2E5VR1VX3NUZxoTcjSHtGTfvKfMyxQKOACwF9D3uEIgoa
   Q==;
X-CSE-ConnectionGUID: YfDgAxqLSomT61Bt5ovo0Q==
X-CSE-MsgGUID: S7sqgUmuTFKwV/Fhi6P0Pw==
X-IronPort-AV: E=McAfee;i="6700,10204,11335"; a="42867451"
X-IronPort-AV: E=Sophos;i="6.13,256,1732608000"; 
   d="scan'208";a="42867451"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2025 11:03:26 -0800
X-CSE-ConnectionGUID: 8XdfAsNPTi6nDdVLCtJEzA==
X-CSE-MsgGUID: /Qkl5+twQHq12NhbURUgtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="114409656"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.222.70])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2025 11:03:26 -0800
Date: Mon, 3 Feb 2025 11:03:24 -0800
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
Subject: Re: [PATCH v6 5/6] acpi/ghes, cxl/pci: Process CXL CPER Protocol
 Errors
Message-ID: <Z6ES_MZy2FuRsfjF@agluck-desk3>
References: <20250123084421.127697-1-Smita.KoralahalliChannabasappa@amd.com>
 <20250123084421.127697-6-Smita.KoralahalliChannabasappa@amd.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250123084421.127697-6-Smita.KoralahalliChannabasappa@amd.com>

On Thu, Jan 23, 2025 at 08:44:20AM +0000, Smita Koralahalli wrote:
> When PCIe AER is in FW-First, OS should process CXL Protocol errors from
> CPER records. Introduce support for handling and logging CXL Protocol
> errors.
> 
> The defined trace events cxl_aer_uncorrectable_error and
> cxl_aer_correctable_error trace native CXL AER endpoint errors. Reuse them
> to trace FW-First Protocol errors.
> 
> Since the CXL code is required to be called from process context and
> GHES is in interrupt context, use workqueues for processing.
> 
> Similar to CXL CPER event handling, use kfifo to handle errors as it
> simplifies queue processing by providing lock free fifo operations.
> 
> Add the ability for the CXL sub-system to register a workqueue to
> process CXL CPER protocol errors.
> 
> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> ---
>  drivers/acpi/apei/ghes.c | 49 ++++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/core/pci.c   | 36 +++++++++++++++++++++++++++++
>  drivers/cxl/cxlpci.h     |  5 ++++
>  drivers/cxl/pci.c        | 46 ++++++++++++++++++++++++++++++++++++-
>  include/cxl/event.h      | 15 ++++++++++++
>  5 files changed, 150 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index 4d725d988c43..289e365f84b2 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -674,6 +674,15 @@ static void ghes_defer_non_standard_event(struct acpi_hest_generic_data *gdata,
>  	schedule_work(&entry->work);
>  }
>  
> +/* Room for 8 entries */

Any science behind the choice of "8" here? This comment is merely
stating what the #define is used for, not why 8 was chosen.

> +#define CXL_CPER_PROT_ERR_FIFO_DEPTH 8
> +static DEFINE_KFIFO(cxl_cper_prot_err_fifo, struct cxl_cper_prot_err_work_data,
> +		    CXL_CPER_PROT_ERR_FIFO_DEPTH);
> +
> +/* Synchronize schedule_work() with cxl_cper_prot_err_work changes */
> +static DEFINE_SPINLOCK(cxl_cper_prot_err_work_lock);
> +struct work_struct *cxl_cper_prot_err_work;
> +
>  static void cxl_cper_post_prot_err(struct cxl_cper_sec_prot_err *prot_err,
>  				   int severity)
>  {
> @@ -700,6 +709,11 @@ static void cxl_cper_post_prot_err(struct cxl_cper_sec_prot_err *prot_err,
>  	if (!(prot_err->valid_bits & PROT_ERR_VALID_SERIAL_NUMBER))
>  		pr_warn(FW_WARN "CXL CPER no device serial number\n");
>  
> +	guard(spinlock_irqsave)(&cxl_cper_prot_err_work_lock);
> +
> +	if (!cxl_cper_prot_err_work)
> +		return;
> +
>  	switch (prot_err->agent_type) {
>  	case RCD:
>  	case DEVICE:
> @@ -721,9 +735,44 @@ static void cxl_cper_post_prot_err(struct cxl_cper_sec_prot_err *prot_err,
>  				   prot_err->agent_type);
>  		return;
>  	}
> +
> +	if (!kfifo_put(&cxl_cper_prot_err_fifo, wd)) {
> +		pr_err_ratelimited("CXL CPER kfifo overflow\n");
> +		return;
> +	}
> +
> +	schedule_work(cxl_cper_prot_err_work);
>  #endif
>  }
>  
> +int cxl_cper_register_prot_err_work(struct work_struct *work)
> +{
> +	if (cxl_cper_prot_err_work)
> +		return -EINVAL;
> +
> +	guard(spinlock)(&cxl_cper_prot_err_work_lock);
> +	cxl_cper_prot_err_work = work;
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_cper_register_prot_err_work, "CXL");
> +
> +int cxl_cper_unregister_prot_err_work(struct work_struct *work)
> +{
> +	if (cxl_cper_prot_err_work != work)
> +		return -EINVAL;
> +
> +	guard(spinlock)(&cxl_cper_prot_err_work_lock);
> +	cxl_cper_prot_err_work = NULL;
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_cper_unregister_prot_err_work, "CXL");
> +
> +int cxl_cper_prot_err_kfifo_get(struct cxl_cper_prot_err_work_data *wd)
> +{
> +	return kfifo_get(&cxl_cper_prot_err_fifo, wd);
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_cper_prot_err_kfifo_get, "CXL");
> +
>  /* Room for 8 entries for each of the 4 event log queues */
>  #define CXL_CPER_FIFO_DEPTH 32
>  DEFINE_KFIFO(cxl_cper_fifo, struct cxl_cper_work_data, CXL_CPER_FIFO_DEPTH);
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 9d58ab9d33c5..5840056bb9a3 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -650,6 +650,42 @@ void read_cdat_data(struct cxl_port *port)
>  }
>  EXPORT_SYMBOL_NS_GPL(read_cdat_data, "CXL");
>  
> +void cxl_cper_trace_corr_prot_err(struct pci_dev *pdev,
> +				  struct cxl_ras_capability_regs ras_cap)
> +{
> +	u32 status = ras_cap.cor_status & ~ras_cap.cor_mask;
> +	struct cxl_dev_state *cxlds;
> +
> +	cxlds = pci_get_drvdata(pdev);
> +	if (!cxlds)
> +		return;
> +
> +	trace_cxl_aer_correctable_error(cxlds->cxlmd, status);
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_cper_trace_corr_prot_err, "CXL");
> +
> +void cxl_cper_trace_uncorr_prot_err(struct pci_dev *pdev,
> +				    struct cxl_ras_capability_regs ras_cap)
> +{
> +	u32 status = ras_cap.uncor_status & ~ras_cap.uncor_mask;
> +	struct cxl_dev_state *cxlds;
> +	u32 fe;
> +
> +	cxlds = pci_get_drvdata(pdev);
> +	if (!cxlds)
> +		return;
> +
> +	if (hweight32(status) > 1)
> +		fe = BIT(FIELD_GET(CXL_RAS_CAP_CONTROL_FE_MASK,
> +				   ras_cap.cap_control));
> +	else
> +		fe = status;
> +
> +	trace_cxl_aer_uncorrectable_error(cxlds->cxlmd, status, fe,
> +					  ras_cap.header_log);
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_cper_trace_uncorr_prot_err, "CXL");
> +
>  static void __cxl_handle_cor_ras(struct cxl_dev_state *cxlds,
>  				 void __iomem *ras_base)
>  {
> diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
> index 4da07727ab9c..e457616373ed 100644
> --- a/drivers/cxl/cxlpci.h
> +++ b/drivers/cxl/cxlpci.h
> @@ -129,4 +129,9 @@ void read_cdat_data(struct cxl_port *port);
>  void cxl_cor_error_detected(struct pci_dev *pdev);
>  pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
>  				    pci_channel_state_t state);
> +struct cxl_ras_capability_regs;
> +void cxl_cper_trace_corr_prot_err(struct pci_dev *pdev,
> +				  struct cxl_ras_capability_regs ras_cap);
> +void cxl_cper_trace_uncorr_prot_err(struct pci_dev *pdev,
> +				    struct cxl_ras_capability_regs ras_cap);
>  #endif /* __CXL_PCI_H__ */
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 6d94ff4a4f1a..9d4b5f39b21a 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -1160,6 +1160,37 @@ static void cxl_cper_work_fn(struct work_struct *work)
>  }
>  static DECLARE_WORK(cxl_cper_work, cxl_cper_work_fn);
>  
> +static void cxl_cper_handle_prot_err(struct cxl_cper_prot_err_work_data *data)
> +{
> +	unsigned int devfn = PCI_DEVFN(data->prot_err.agent_addr.device,
> +				       data->prot_err.agent_addr.function);
> +	struct pci_dev *pdev __free(pci_dev_put) =
> +		pci_get_domain_bus_and_slot(data->prot_err.agent_addr.segment,
> +					    data->prot_err.agent_addr.bus,
> +					    devfn);
> +
> +	if (!pdev)
> +		return;
> +
> +	guard(device)(&pdev->dev);
> +	if (pdev->driver != &cxl_pci_driver)
> +		return;
> +
> +	if (data->severity == AER_CORRECTABLE)
> +		cxl_cper_trace_corr_prot_err(pdev, data->ras_cap);
> +	else
> +		cxl_cper_trace_uncorr_prot_err(pdev, data->ras_cap);
> +}
> +
> +static void cxl_cper_prot_err_work_fn(struct work_struct *work)
> +{
> +	struct cxl_cper_prot_err_work_data wd;
> +
> +	while (cxl_cper_prot_err_kfifo_get(&wd))
> +		cxl_cper_handle_prot_err(&wd);
> +}
> +static DECLARE_WORK(cxl_cper_prot_err_work, cxl_cper_prot_err_work_fn);
> +
>  static int __init cxl_pci_driver_init(void)
>  {
>  	int rc;
> @@ -1170,7 +1201,18 @@ static int __init cxl_pci_driver_init(void)
>  
>  	rc = cxl_cper_register_work(&cxl_cper_work);
>  	if (rc)
> -		pci_unregister_driver(&cxl_pci_driver);
> +		goto err_unreg;
> +
> +	rc = cxl_cper_register_prot_err_work(&cxl_cper_prot_err_work);
> +	if (rc)
> +		goto err_unregister_work;
> +
> +	return 0;
> +
> +err_unregister_work:
> +	cxl_cper_unregister_work(&cxl_cper_work);
> +err_unreg:
> +	pci_unregister_driver(&cxl_pci_driver);
>  
>  	return rc;
>  }
> @@ -1178,7 +1220,9 @@ static int __init cxl_pci_driver_init(void)
>  static void __exit cxl_pci_driver_exit(void)
>  {
>  	cxl_cper_unregister_work(&cxl_cper_work);
> +	cxl_cper_unregister_prot_err_work(&cxl_cper_prot_err_work);
>  	cancel_work_sync(&cxl_cper_work);
> +	cancel_work_sync(&cxl_cper_prot_err_work);
>  	pci_unregister_driver(&cxl_pci_driver);
>  }
>  
> diff --git a/include/cxl/event.h b/include/cxl/event.h
> index ee1c3dec62fa..359a8f44a2e0 100644
> --- a/include/cxl/event.h
> +++ b/include/cxl/event.h
> @@ -242,6 +242,9 @@ struct cxl_cper_prot_err_work_data {
>  int cxl_cper_register_work(struct work_struct *work);
>  int cxl_cper_unregister_work(struct work_struct *work);
>  int cxl_cper_kfifo_get(struct cxl_cper_work_data *wd);
> +int cxl_cper_register_prot_err_work(struct work_struct *work);
> +int cxl_cper_unregister_prot_err_work(struct work_struct *work);
> +int cxl_cper_prot_err_kfifo_get(struct cxl_cper_prot_err_work_data *wd);
>  #else
>  static inline int cxl_cper_register_work(struct work_struct *work)
>  {
> @@ -256,6 +259,18 @@ static inline int cxl_cper_kfifo_get(struct cxl_cper_work_data *wd)
>  {
>  	return 0;
>  }
> +static inline int cxl_cper_register_prot_err_work(struct work_struct *work)
> +{
> +	return 0;
> +}
> +static inline int cxl_cper_unregister_prot_err_work(struct work_struct *work)
> +{
> +	return 0;
> +}
> +static inline int cxl_cper_prot_err_kfifo_get(struct cxl_cper_prot_err_work_data *wd)
> +{
> +	return 0;
> +}
>  #endif
>  
>  #endif /* _LINUX_CXL_EVENT_H */
> -- 
> 2.17.1
> 

Nitpick about the "8" value, but patch can go in like this
and the value changed if there is later evidence to justify
some other value.

Reviewed-by: Tony Luck <tony.luck@intel.com>

-Tony

