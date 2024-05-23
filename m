Return-Path: <linux-efi+bounces-1072-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CB828CCB6A
	for <lists+linux-efi@lfdr.de>; Thu, 23 May 2024 06:38:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9705B1F21FD2
	for <lists+linux-efi@lfdr.de>; Thu, 23 May 2024 04:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B4A92AF06;
	Thu, 23 May 2024 04:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="liIPBVxt"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5226320DF7;
	Thu, 23 May 2024 04:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716439085; cv=none; b=nxlZM4fRxSVHYTrYuUjSL7A86jxjfmvkY+URV6flwQomlBigxvpRx8MEz2icAwkiTvtarDsyrjDiRy2E78CxxR1ct9sHTm6lwGFTe4gTFyZlP842Jd1/LQmzBi8RQPkAXFzTrdIs7DQUiOpFLX6QqEFUfTeoIy6F/vLSzG9zJzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716439085; c=relaxed/simple;
	bh=Zb53/ycD+rQozQIXsykjBaWlJ41ME07FtWQn9Xg2uc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DKyWKUh/6gOnWirBArvroSV6zW2XO+kz0fM0c0ejr8RRhgFyTxKk7B3V64wI7kXTjk7N6rD+/VW664431e0C3gakwHdEyITaZDipFfGuKQepKkkxLR/ML/IY1nlm4XcVZh8bjrasjbvru8QWLm9oYVcSIZRrsingdzTzjx7GBPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=liIPBVxt; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716439083; x=1747975083;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Zb53/ycD+rQozQIXsykjBaWlJ41ME07FtWQn9Xg2uc8=;
  b=liIPBVxtTr9XpiiAoCfuuZesQyaYcsYuIZyiOTY5hMwnMFgYhvl7zl8Z
   yhNUfxxfHNFBEp0QsuL4g2da3X9S+xt8tdXHV1oHTJ3AKATvkBBsvtB90
   7juW1cPfJdutO0TOa+Vw/t9rbwuaNso63qXCY5i8ZYgbSHPVbId1dQ8Y6
   h1CqajDedD0P/Twhn8w2u0I/VlScDQBd0/3aJa8WZwbru9onIlRtSPVby
   vbZy6aWy3Az8zsOhZ7dsV36ZnyO+65mS82xEtBecgU9f8v04k+qZuF1hY
   fUcyyfW+LtyljKOjfnrPYciSqTQNWFptkEnLSCQ5wfc+iZtMnTr6LgIyL
   g==;
X-CSE-ConnectionGUID: ZrJc9BLIRNS21YbtEHUFFA==
X-CSE-MsgGUID: d/NcOA83SPil0DGTLk6xnA==
X-IronPort-AV: E=McAfee;i="6600,9927,11080"; a="23299349"
X-IronPort-AV: E=Sophos;i="6.08,181,1712646000"; 
   d="scan'208";a="23299349"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2024 21:38:02 -0700
X-CSE-ConnectionGUID: 06AurqnZSRqg7Mv0OH4uLA==
X-CSE-MsgGUID: E69/rulbSYaiL4pCyJ4UNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,181,1712646000"; 
   d="scan'208";a="38502052"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.255.230.167])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2024 21:38:02 -0700
Date: Wed, 22 May 2024 21:38:01 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
	linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>,
	Bowman Terry <terry.bowman@amd.com>
Subject: Re: [PATCH 3/4] acpi/ghes, cxl/pci: Trace FW-First CXL Protocol
 Errors
Message-ID: <Zk7IKYklBHPQief+@aschofie-mobl2>
References: <20240522150839.27578-1-Smita.KoralahalliChannabasappa@amd.com>
 <20240522150839.27578-4-Smita.KoralahalliChannabasappa@amd.com>
 <7dc64418-6821-49c2-b9af-ee4ab148ba9f@intel.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7dc64418-6821-49c2-b9af-ee4ab148ba9f@intel.com>

On Wed, May 22, 2024 at 11:05:49AM -0700, Dave Jiang wrote:
> 
> 
> On 5/22/24 8:08 AM, Smita Koralahalli wrote:
> > When PCIe AER is in FW-First, OS should process CXL Protocol errors from
> > CPER records.
> > 
> > Reuse the existing work queue cxl_cper_work registered with GHES to notify
> > the CXL subsystem on a Protocol error.
> > 
> > The defined trace events cxl_aer_uncorrectable_error and
> > cxl_aer_correctable_error currently trace native CXL AER errors. Reuse
> > them to trace FW-First Protocol Errors.
> > 
> > Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> > ---
> >  drivers/acpi/apei/ghes.c  | 14 ++++++++++++++
> >  drivers/cxl/core/pci.c    | 24 ++++++++++++++++++++++++
> >  drivers/cxl/cxlpci.h      |  3 +++
> >  drivers/cxl/pci.c         | 34 ++++++++++++++++++++++++++++++++--
> >  include/linux/cxl-event.h |  1 +
> >  5 files changed, 74 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> > index 1a58032770ee..a31bd91e9475 100644
> > --- a/drivers/acpi/apei/ghes.c
> > +++ b/drivers/acpi/apei/ghes.c
> > @@ -723,6 +723,20 @@ static void cxl_cper_handle_prot_err(struct acpi_hest_generic_data *gdata)
> >  
> >  	if (cxl_cper_handle_prot_err_info(gdata, &wd.p_err))
> >  		return;
> > +
> > +	guard(spinlock_irqsave)(&cxl_cper_work_lock);
> > +
> > +	if (!cxl_cper_work)
> > +		return;
> > +
> > +	wd.event_type = CXL_CPER_EVENT_PROT_ERR;
> > +
> > +	if (!kfifo_put(&cxl_cper_fifo, wd)) {
> > +		pr_err_ratelimited("CXL CPER kfifo overflow\n");
> > +		return;
> > +	}
> > +
> > +	schedule_work(cxl_cper_work);
> >  }
> >  
> >  int cxl_cper_register_work(struct work_struct *work)
> > diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> > index 0df09bd79408..ef9438cb1dd6 100644
> > --- a/drivers/cxl/core/pci.c
> > +++ b/drivers/cxl/core/pci.c
> > @@ -686,6 +686,30 @@ void read_cdat_data(struct cxl_port *port)
> >  }
> >  EXPORT_SYMBOL_NS_GPL(read_cdat_data, CXL);
> >  
> > +void cxl_trace_prot_err(struct cxl_dev_state *cxlds,
> > +			struct cxl_cper_prot_err *p_err)
> > +{
> > +	u32 status, fe;
> > +
> > +	if (p_err->severity == CXL_AER_CORRECTABLE) {
> > +		status = p_err->cxl_ras.cor_status & ~p_err->cxl_ras.cor_mask;
> > +
> > +		trace_cxl_aer_correctable_error(cxlds->cxlmd, status);
> > +	} else {
> > +		status = p_err->cxl_ras.uncor_status & ~p_err->cxl_ras.uncor_mask;
> > +
> > +		if (hweight32(status) > 1)
> > +			fe = BIT(FIELD_GET(CXL_RAS_CAP_CONTROL_FE_MASK,
> > +					   p_err->cxl_ras.cap_control));
> > +		else
> > +			fe = status;
> > +
> > +		trace_cxl_aer_uncorrectable_error(cxlds->cxlmd, status, fe,
> > +						  p_err->cxl_ras.header_log);
> > +	}
> > +}
> > +EXPORT_SYMBOL_NS_GPL(cxl_trace_prot_err, CXL);
> > +
> >  static void __cxl_handle_cor_ras(struct cxl_dev_state *cxlds,
> >  				 void __iomem *ras_base)
> >  {
> > diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
> > index 93992a1c8eec..0ba3215786e1 100644
> > --- a/drivers/cxl/cxlpci.h
> > +++ b/drivers/cxl/cxlpci.h
> > @@ -130,4 +130,7 @@ void read_cdat_data(struct cxl_port *port);
> >  void cxl_cor_error_detected(struct pci_dev *pdev);
> >  pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
> >  				    pci_channel_state_t state);
> > +struct cxl_cper_prot_err;
> > +void cxl_trace_prot_err(struct cxl_dev_state *cxlds,
> > +			struct cxl_cper_prot_err *p_err);
> >  #endif /* __CXL_PCI_H__ */
> > diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> > index 74876c9835e8..3e3c36983686 100644
> > --- a/drivers/cxl/pci.c
> > +++ b/drivers/cxl/pci.c
> > @@ -1011,12 +1011,42 @@ static void cxl_handle_cper_event(enum cxl_event_type ev_type,
> >  			       &uuid_null, &rec->event);
> >  }
> >  
> > +static void cxl_handle_prot_err(struct cxl_cper_prot_err *p_err)
> > +{
> > +	struct pci_dev *pdev __free(pci_dev_put) = NULL;
> > +	struct cxl_dev_state *cxlds;
> > +	unsigned int devfn;
> > +
> > +	devfn = PCI_DEVFN(p_err->device, p_err->function);
> > +	pdev = pci_get_domain_bus_and_slot(p_err->segment,
> > +					   p_err->bus, devfn);
> > +	if (!pdev)
> > +		return;
> > +
> > +	guard(device)(&pdev->dev);
> > +	if (pdev->driver != &cxl_pci_driver)
> > +		return;
> > +
> > +	cxlds = pci_get_drvdata(pdev);
> > +	if (!cxlds)
> > +		return;
> > +
> > +	if (((u64)p_err->upper_dw << 32 | p_err->lower_dw) != cxlds->serial)
> > +		pr_warn("CPER-reported device serial number does not match expected value\n");
> 
> Given that we are operating on a device, perhaps dev_warn(&pdev->dev, ...) may be better served.
> 
> DJ

Good point. Providing the dev lets the user look up the serial number,
meaning this message doesn't need to include an 'expected' but not found
value.

-- Alison

> > +
> > +	cxl_trace_prot_err(cxlds, p_err);
> > +}
> > +
> >  static void cxl_cper_work_fn(struct work_struct *work)
> >  {
> >  	struct cxl_cper_work_data wd;
> >  
> > -	while (cxl_cper_kfifo_get(&wd))
> > -		cxl_handle_cper_event(wd.event_type, &wd.rec);
> > +	while (cxl_cper_kfifo_get(&wd)) {
> > +		if (wd.event_type == CXL_CPER_EVENT_PROT_ERR)
> > +			cxl_handle_prot_err(&wd.p_err);
> > +		else
> > +			cxl_handle_cper_event(wd.event_type, &wd.rec);
> > +	}
> >  }
> >  static DECLARE_WORK(cxl_cper_work, cxl_cper_work_fn);
> >  
> > diff --git a/include/linux/cxl-event.h b/include/linux/cxl-event.h
> > index 9c7b69e076a0..5562844df850 100644
> > --- a/include/linux/cxl-event.h
> > +++ b/include/linux/cxl-event.h
> > @@ -122,6 +122,7 @@ struct cxl_event_record_raw {
> >  } __packed;
> >  
> >  enum cxl_event_type {
> > +	CXL_CPER_EVENT_PROT_ERR,
> >  	CXL_CPER_EVENT_GENERIC,
> >  	CXL_CPER_EVENT_GEN_MEDIA,
> >  	CXL_CPER_EVENT_DRAM,

