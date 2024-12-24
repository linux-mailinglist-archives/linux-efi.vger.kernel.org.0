Return-Path: <linux-efi+bounces-2484-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1272F9FC132
	for <lists+linux-efi@lfdr.de>; Tue, 24 Dec 2024 19:15:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 988A9164DA6
	for <lists+linux-efi@lfdr.de>; Tue, 24 Dec 2024 18:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CBA6212F9F;
	Tue, 24 Dec 2024 18:15:05 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A9F212F84;
	Tue, 24 Dec 2024 18:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735064105; cv=none; b=MzMEwwedST673YvfTdTlYhjKdUCX6VXh3XIJZJbj2gOMGusbqppQClxmC8i0HiYEL3tWv/2EwSMblGX78Whu8dPW5TfNrvUDZTQZHCdU/G7YBEXYQAvLbq0Nd1MFmUqKxflHTU3TWPqIRY6OpoA49WdDU8WPDJOLFjd/UgW50Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735064105; c=relaxed/simple;
	bh=1ZoqEoEsDl8QD1YpYhYj/yt4tmftQUzukByM2WM94eM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lb7Ue52mFfq5ikbSKCYK5V+sMUIM1SULSkXsp6tyxoqxPw7dGzvi3NAI64pwY01HrXZqlaZhI4PIGLGCI1OYXDg7ec83cGhOpyKm669kYmb+XXehX3DPWrNk73QGAc53461t6FCtCx4RslMOdFyFfPBxVr4JdKFR+th+PwYZ2ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YHjhw15KHz6K6HK;
	Wed, 25 Dec 2024 02:14:40 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 80A6F140447;
	Wed, 25 Dec 2024 02:15:00 +0800 (CST)
Received: from localhost (10.48.156.150) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 24 Dec
 2024 19:14:59 +0100
Date: Tue, 24 Dec 2024 18:14:57 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
CC: <linux-efi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, Ard Biesheuvel <ardb@kernel.org>, "Alison
 Schofield" <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Yazen Ghannam <yazen.ghannam@amd.com>, "Terry
 Bowman" <terry.bowman@amd.com>
Subject: Re: [PATCH v4 5/5] acpi/ghes, cxl/pci: Process CXL CPER Protocol
 Errors
Message-ID: <20241224181457.00000e0c@huawei.com>
In-Reply-To: <20241217022032.87298-6-Smita.KoralahalliChannabasappa@amd.com>
References: <20241217022032.87298-1-Smita.KoralahalliChannabasappa@amd.com>
	<20241217022032.87298-6-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 17 Dec 2024 02:20:32 +0000
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

Hi Smita,

A few really minor thing inline. Main one is this needs a rebase
as the EXPORT_SYMBOL_NS_GPL() macros changed just after rc1
to require quoted strings.

>  #define CXL_CPER_FIFO_DEPTH 32
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 740ac5d8809f..5bad24965e24 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -650,6 +650,68 @@ void read_cdat_data(struct cxl_port *port)
>  }
>  EXPORT_SYMBOL_NS_GPL(read_cdat_data, CXL);

> +EXPORT_SYMBOL_NS_GPL(cxl_cper_trace_uncorr_prot_err, CXL);
Needs a rebase on rc2 or later.  "CXL" - quotes now needed.



> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 188412d45e0d..f6d467cd9232 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -1067,6 +1067,51 @@ static void cxl_cper_work_fn(struct work_struct *work)
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
> +
No need for this blank line.

> +}

