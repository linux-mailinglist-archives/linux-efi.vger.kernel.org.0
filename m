Return-Path: <linux-efi+bounces-2629-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47BA9A10B5C
	for <lists+linux-efi@lfdr.de>; Tue, 14 Jan 2025 16:45:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B682188A53B
	for <lists+linux-efi@lfdr.de>; Tue, 14 Jan 2025 15:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E87871922C0;
	Tue, 14 Jan 2025 15:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AZtGVSD9"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E997F35950;
	Tue, 14 Jan 2025 15:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736869373; cv=none; b=ZMOpQiHo4uSIIxKjpdNJz7w/SbvyNsumTB4xxHmqMP+BpDKQpXbwJUcjmhdtckECbuUy73YSjSAVa2w1+gyCIsu5bBy2d1uJ0oZ4z3TxpBXujuiUnDkD5DzTP/kNzpuQoDcbL1lhFfVZmdl/kSf+rKaCW3N57bZj4Sjfi5XJYdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736869373; c=relaxed/simple;
	bh=Ohzl6Jhn8KvaV+y+bG5yaKVARGTYIYleeGFZFKjlwQo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JslPlHkA+1+GcY9bzBXSRJuR0ElArjaf6tuhP3IwyY4PGjiV2vweACLBxWwbyQIVZiFQyPG5dgcn1vIm7q4jr4dCgNPu3nYGecUq5HdYDBvzo11HFDfsSqBu7BYGkluv5O0fOsvYdBqntBCvub8AqTb+6KBAuEsDj9TVzrOwXos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AZtGVSD9; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736869372; x=1768405372;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Ohzl6Jhn8KvaV+y+bG5yaKVARGTYIYleeGFZFKjlwQo=;
  b=AZtGVSD9b/tIOJIVz5gl52kgF8OfxbMT7Ltx3Fm+iaeMEaF5tRUwiMtO
   cyi2jnQ3qGbJoWL4F50M815STQhp3sydaLp/HgSKmJgJtxocXvBVwH76N
   F0cnZ+prOhbsH0AkcSuYWrrCelRmu70NmZSgQLb258h3MfJJ7YAHBeOjZ
   IULzhmS8WqUBMIbX3WcYTqTwo/8m7JxwtkcUcU0a83+zaGF9KrEwlqvHc
   rWWzW7dK1aWE5yhpvjzR/5mWBP1edBunZhJWcYBOfQDQddJd9j2bVZmG/
   T7josAcpjFsgBDwX9ZShYU/tob+KKJ02jEC4kbASm7dwzRT2KwuGMcdHa
   g==;
X-CSE-ConnectionGUID: KMVs4nqoT8SasOCtUSHQHA==
X-CSE-MsgGUID: 98RbDfPFRdOStnw1/5QV2A==
X-IronPort-AV: E=McAfee;i="6700,10204,11315"; a="37086315"
X-IronPort-AV: E=Sophos;i="6.12,314,1728975600"; 
   d="scan'208";a="37086315"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 07:42:51 -0800
X-CSE-ConnectionGUID: xnL6M0uPS8OBfem7DGFTtQ==
X-CSE-MsgGUID: beTaYMT+Rd6y3ETlCnqD6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,314,1728975600"; 
   d="scan'208";a="104669113"
Received: from inaky-mobl1.amr.corp.intel.com (HELO [10.125.108.148]) ([10.125.108.148])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 07:42:50 -0800
Message-ID: <268f4d98-ed7f-421b-85b5-8e90ada8773f@intel.com>
Date: Tue, 14 Jan 2025 08:42:49 -0700
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/5] acpi/ghes, cxl/pci: Process CXL CPER Protocol
 Errors
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
 <20250114120427.149260-6-Smita.KoralahalliChannabasappa@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250114120427.149260-6-Smita.KoralahalliChannabasappa@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/14/25 5:04 AM, Smita Koralahalli wrote:
> When PCIe AER is in FW-First, OS should process CXL Protocol errors from
> CPER records. Introduce support for handling and logging CXL Protocol
> errors.
> 
> The defined trace events cxl_aer_uncorrectable_error and
> cxl_aer_correctable_error trace native CXL AER endpoint errors, while
> cxl_cper_trace_corr_prot_err and cxl_cper_trace_uncorr_prot_err
> trace native CXL AER port errors. Reuse both sets to trace FW-First
> protocol errors.
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

Just a small nit below, otherwise
Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/acpi/apei/ghes.c | 49 +++++++++++++++++++++++++++++++
>  drivers/cxl/core/pci.c   | 62 ++++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxlpci.h     |  9 ++++++
>  drivers/cxl/pci.c        | 59 +++++++++++++++++++++++++++++++++++++-
>  include/cxl/event.h      | 15 ++++++++++
>  5 files changed, 193 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index 4ab3c8ae1360..8dc693e9b2d0 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -676,6 +676,15 @@ static void ghes_defer_non_standard_event(struct acpi_hest_generic_data *gdata,
>  	schedule_work(&entry->work);
>  }
>  
> +/* Room for 8 entries */
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
> @@ -702,6 +711,11 @@ static void cxl_cper_post_prot_err(struct cxl_cper_sec_prot_err *prot_err,
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
> @@ -723,9 +737,44 @@ static void cxl_cper_post_prot_err(struct cxl_cper_sec_prot_err *prot_err,
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
> index 6c10eab82eff..4ec060032ae8 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -650,6 +650,68 @@ void read_cdat_data(struct cxl_port *port)
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
> +	if (hweight32(status) > 1)
> +		fe = BIT(FIELD_GET(CXL_RAS_CAP_CONTROL_FE_MASK,
> +				   ras_cap.cap_control));
> +	else
> +		fe = status;
> +
> +	cxlds = pci_get_drvdata(pdev);
> +	if (!cxlds)
> +		return;

Maybe do this check first in the function so it doesn't waste cycles retrieving 'fe' earlier for the no driver case.

DJ


> +
> +	trace_cxl_aer_uncorrectable_error(cxlds->cxlmd, status, fe,
> +					  ras_cap.header_log);
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_cper_trace_uncorr_prot_err, "CXL");
> +
> +void cxl_cper_trace_corr_port_prot_err(struct pci_dev *pdev,
> +				       struct cxl_ras_capability_regs ras_cap)
> +{
> +	u32 status = ras_cap.cor_status & ~ras_cap.cor_mask;
> +
> +	trace_cxl_port_aer_correctable_error(&pdev->dev, status);
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_cper_trace_corr_port_prot_err, "CXL");
> +
> +void cxl_cper_trace_uncorr_port_prot_err(struct pci_dev *pdev,
> +					 struct cxl_ras_capability_regs ras_cap)
> +{
> +	u32 status = ras_cap.uncor_status & ~ras_cap.uncor_mask;
> +	u32 fe;
> +
> +	if (hweight32(status) > 1)
> +		fe = BIT(FIELD_GET(CXL_RAS_CAP_CONTROL_FE_MASK,
> +				   ras_cap.cap_control));
> +	else
> +		fe = status;
> +
> +	trace_cxl_port_aer_uncorrectable_error(&pdev->dev, status, fe,
> +					       ras_cap.header_log);
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_cper_trace_uncorr_port_prot_err, "CXL");
> +
>  static void __cxl_handle_cor_ras(struct device *dev,
>  				 void __iomem *ras_base)
>  {
> diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
> index 4da07727ab9c..23f2b1c9bd13 100644
> --- a/drivers/cxl/cxlpci.h
> +++ b/drivers/cxl/cxlpci.h
> @@ -129,4 +129,13 @@ void read_cdat_data(struct cxl_port *port);
>  void cxl_cor_error_detected(struct pci_dev *pdev);
>  pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
>  				    pci_channel_state_t state);
> +struct cxl_ras_capability_regs;
> +void cxl_cper_trace_corr_prot_err(struct pci_dev *pdev,
> +				  struct cxl_ras_capability_regs ras_cap);
> +void cxl_cper_trace_uncorr_prot_err(struct pci_dev *pdev,
> +				    struct cxl_ras_capability_regs ras_cap);
> +void cxl_cper_trace_corr_port_prot_err(struct pci_dev *pdev,
> +				       struct cxl_ras_capability_regs ras_cap);
> +void cxl_cper_trace_uncorr_port_prot_err(struct pci_dev *pdev,
> +					 struct cxl_ras_capability_regs ras_cap);
>  #endif /* __CXL_PCI_H__ */
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 6d94ff4a4f1a..766447c169c8 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -1160,6 +1160,50 @@ static void cxl_cper_work_fn(struct work_struct *work)
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
> +	int port_type;
> +
> +	if (!pdev)
> +		return;
> +
> +	guard(device)(&pdev->dev);
> +	if (pdev->driver != &cxl_pci_driver)
> +		return;
> +
> +	port_type = pci_pcie_type(pdev);
> +	if (port_type == PCI_EXP_TYPE_ROOT_PORT ||
> +	    port_type == PCI_EXP_TYPE_DOWNSTREAM ||
> +	    port_type == PCI_EXP_TYPE_UPSTREAM) {
> +		if (data->severity == AER_CORRECTABLE)
> +			cxl_cper_trace_corr_port_prot_err(pdev, data->ras_cap);
> +		else
> +			cxl_cper_trace_uncorr_port_prot_err(pdev, data->ras_cap);
> +
> +		return;
> +	}
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
> @@ -1170,7 +1214,18 @@ static int __init cxl_pci_driver_init(void)
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
> @@ -1178,7 +1233,9 @@ static int __init cxl_pci_driver_init(void)
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


