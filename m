Return-Path: <linux-efi+bounces-2216-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C30B9D9B03
	for <lists+linux-efi@lfdr.de>; Tue, 26 Nov 2024 17:05:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0A02282B93
	for <lists+linux-efi@lfdr.de>; Tue, 26 Nov 2024 16:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A4FB12C544;
	Tue, 26 Nov 2024 16:05:35 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5183EA69;
	Tue, 26 Nov 2024 16:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732637135; cv=none; b=U8gzSKKrI/nGuhzd15sxIw42F1rPCscURS4Uo4IDtVi4beOkqeag/B6bLNXjWZHgiJAqDXPEQSNduGmKOWqtaQY2HYzmSY3aRoTOoxzB3s8UXiZ8z79WJUW7FDhxtN53cIygfoUnXn+m9Pr4e9HXzj/+oi5q6zxYKp80hx1BQGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732637135; c=relaxed/simple;
	bh=1NhmZODDYwbjPMaQbrUwa3JIy5Pk0sfwrE7dv/SdACw=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NWpDGc84kvr5llLoNpod2RYby0nFHsCI25znJS8oJI7uAUXHTzefZDsnYJS/r2OwswdXvDmbu9yetXZt7NGOBzwxv54rjPer5VMo3P/kwA5lqQTn7Fp2E1PiBy62xXhDEzFNyJugLndO4cyQnKXP/YzBSJ0yu+254nsT6/H90Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XyS893nVMz6L6t4;
	Wed, 27 Nov 2024 00:04:57 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 5E2BE140A9C;
	Wed, 27 Nov 2024 00:05:29 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 26 Nov
 2024 17:05:28 +0100
Date: Tue, 26 Nov 2024 16:05:27 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
CC: <linux-efi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, Ard Biesheuvel <ardb@kernel.org>, "Alison
 Schofield" <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Yazen Ghannam <yazen.ghannam@amd.com>, "Terry
 Bowman" <terry.bowman@amd.com>
Subject: Re: [PATCH v3 7/7] acpi/ghes, cxl/pci: Process CXL CPER Protocol
 Errors
Message-ID: <20241126160527.00005c2d@huawei.com>
In-Reply-To: <20241119003915.174386-8-Smita.KoralahalliChannabasappa@amd.com>
References: <20241119003915.174386-1-Smita.KoralahalliChannabasappa@amd.com>
	<20241119003915.174386-8-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 19 Nov 2024 00:39:15 +0000
Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com> wrote:

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

A few minor comments inline.

Thanks

Jonathan

> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 4ede038a7148..c992b34c290b 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -650,6 +650,56 @@ void read_cdat_data(struct cxl_port *port)
>  }
>  EXPORT_SYMBOL_NS_GPL(read_cdat_data, CXL);
>  
> +void cxl_cper_trace_corr_prot_err(struct pci_dev *pdev, bool flag,
> +				  struct cxl_ras_capability_regs ras_cap)
> +{
> +	struct cxl_dev_state *cxlds;
> +	u32 status;
> +
> +	status = ras_cap.cor_status & ~ras_cap.cor_mask;
> +
> +	if (!flag) {

As below. Name of flag is not very helpful when reading the code.
Perhaps we can rename?

> +		trace_cxl_port_aer_correctable_error(&pdev->dev, status);
> +		return;
> +	}
> +
> +	cxlds = pci_get_drvdata(pdev);
> +	if (!cxlds)
> +		return;
> +
> +	trace_cxl_aer_correctable_error(cxlds->cxlmd, status);
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_cper_trace_corr_prot_err, CXL);
> +
> +void cxl_cper_trace_uncorr_prot_err(struct pci_dev *pdev, bool flag,
> +				    struct cxl_ras_capability_regs ras_cap)
> +{
> +	struct cxl_dev_state *cxlds;
> +	u32 status, fe;
> +
> +	status = ras_cap.uncor_status & ~ras_cap.uncor_mask;
> +
> +	if (hweight32(status) > 1)
> +		fe = BIT(FIELD_GET(CXL_RAS_CAP_CONTROL_FE_MASK,
> +				   ras_cap.cap_control));
> +	else
> +		fe = status;
> +
> +	if (!flag) {

Why does  a bool named flag indicate it's a port error?

> +		trace_cxl_port_aer_uncorrectable_error(&pdev->dev, status, fe,
> +						       ras_cap.header_log);
> +		return;
> +	}
> +
> +	cxlds = pci_get_drvdata(pdev);
> +	if (!cxlds)
> +		return;
> +
> +	trace_cxl_aer_uncorrectable_error(cxlds->cxlmd, status, fe,
> +					  ras_cap.header_log);
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_cper_trace_uncorr_prot_err, CXL);
> +
>  static void __cxl_handle_cor_ras(struct device *dev,
>  				 void __iomem *ras_base)
>  {
> diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
> index 4da07727ab9c..5e4aa8681937 100644
> --- a/drivers/cxl/cxlpci.h
> +++ b/drivers/cxl/cxlpci.h
> @@ -129,4 +129,10 @@ void read_cdat_data(struct cxl_port *port);
>  void cxl_cor_error_detected(struct pci_dev *pdev);
>  pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
>  				    pci_channel_state_t state);
> +
> +struct cxl_ras_capability_regs;
> +void cxl_cper_trace_corr_prot_err(struct pci_dev *pdev, bool flag,
> +				  struct cxl_ras_capability_regs ras_cap);
> +void cxl_cper_trace_uncorr_prot_err(struct pci_dev *pdev, bool flag,
> +				    struct cxl_ras_capability_regs ras_cap);
>  #endif /* __CXL_PCI_H__ */
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 88a14d7baa65..e261abe60e90 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -1067,6 +1067,53 @@ static void cxl_cper_work_fn(struct work_struct *work)
>  }
>  static DECLARE_WORK(cxl_cper_work, cxl_cper_work_fn);
>  
> +static void cxl_cper_handle_prot_err(struct cxl_cper_prot_err_work_data *data)
> +{
> +	unsigned int devfn = PCI_DEVFN(data->prot_err.agent_addr.device,
> +				       data->prot_err.agent_addr.function);
> +	struct pci_dev *pdev __free(pci_dev_put) =
> +		pci_get_domain_bus_and_slot(
> +			data->prot_err.agent_addr.segment,
> +			data->prot_err.agent_addr.bus,
> +			devfn
> +		);
		pci_get_domain_bus_and_slot(data->prot_err.agent_addr.segment,
					    data->prot_err.agent_addr.bus,
					    devfn);

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
> +			cxl_cper_trace_corr_prot_err(pdev, false, data->ras_cap);
> +		else
> +			cxl_cper_trace_uncorr_prot_err(pdev, false, data->ras_cap);
> +
> +		return;
> +	}
> +
> +	if (data->severity == AER_CORRECTABLE)
> +		cxl_cper_trace_corr_prot_err(pdev, true, data->ras_cap);
> +	else
> +		cxl_cper_trace_uncorr_prot_err(pdev, true, data->ras_cap);
> +
> +}

>  static int __init cxl_pci_driver_init(void)
>  {
>  	int rc;
> @@ -1079,13 +1126,21 @@ static int __init cxl_pci_driver_init(void)
>  	if (rc)
>  		pci_unregister_driver(&cxl_pci_driver);
>  
> +	rc = cxl_cper_register_prot_err_work(&cxl_cper_prot_err_work);
> +	if (rc) {
> +		cxl_cper_unregister_event_work(&cxl_cper_work);
> +		pci_unregister_driver(&cxl_pci_driver);
I'd switch this to a goto style for error handling.


> +	}
> +
>  	return rc;

that is
	return 0;

err_unregister_event_work:
	cxl_cper_unregister_event_work(&cxl_cper_work);
err_unreg:
	pci_unregister_driver(&cxl_pci_driver);
	return rc;
>  }


