Return-Path: <linux-efi+bounces-1184-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C82900958
	for <lists+linux-efi@lfdr.de>; Fri,  7 Jun 2024 17:41:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 740C7B22EC1
	for <lists+linux-efi@lfdr.de>; Fri,  7 Jun 2024 15:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2198D1953B1;
	Fri,  7 Jun 2024 15:40:57 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068451514C3;
	Fri,  7 Jun 2024 15:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717774857; cv=none; b=uxmpYtJgcq+8IzU/SD8Vp+B7EVdLuzndRm3j00V03cLTdgFsSTss8cMB7XlnFK+n7A3Zq/CwVMCBqZ1HzGdFGNBxmznTr7rpYzcKetLM9sv0uyKZsUP3aLQ0cFpeHNlBJI+n8q6NAS3Ktf9t6tK+dAB+fKCvoF4tEkbXO54vn1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717774857; c=relaxed/simple;
	bh=9rlONq6l7HcDBXemqIeq68MM6ODj447xLjOFEQZ3EKY=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jdYBWu9+2i5Kg9tBdKu8vS4KFNJ4zhxNJ0ZpcdKDC+sWrvYz7kyArnrL4gu0tlEGI8fbV9UIiCXiv8322eeMPNU0COCVs0owu2fXiOYdBHRur6tcrnYoRkpY71fl1bHwQ8AafebV6WjHJ2IZpPjjfTdgZDOxFciOD5DeaQUyQvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VwlfJ3tXQz67Xmk;
	Fri,  7 Jun 2024 23:36:08 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 536491402CB;
	Fri,  7 Jun 2024 23:40:51 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 7 Jun
 2024 16:40:50 +0100
Date: Fri, 7 Jun 2024 16:40:49 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
CC: <linux-efi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, Ard Biesheuvel <ardb@kernel.org>, "Alison
 Schofield" <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Yazen Ghannam <yazen.ghannam@amd.com>, "Bowman
 Terry" <terry.bowman@amd.com>
Subject: Re: [PATCH 4/4] cxl/pci: Define a common function get_cxl_dev()
Message-ID: <20240607164049.0000564f@Huawei.com>
In-Reply-To: <20240522150839.27578-5-Smita.KoralahalliChannabasappa@amd.com>
References: <20240522150839.27578-1-Smita.KoralahalliChannabasappa@amd.com>
	<20240522150839.27578-5-Smita.KoralahalliChannabasappa@amd.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Wed, 22 May 2024 15:08:39 +0000
Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com> wrote:

> Refactor computation of cxlds to a common function get_cxl_dev() and reuse
> the function in both cxl_handle_cper_event() and cxl_handle_prot_err().
> 
> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> ---
>  drivers/cxl/pci.c | 52 +++++++++++++++++++++++------------------------
>  1 file changed, 26 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 3e3c36983686..26e65e5b68cb 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -974,32 +974,43 @@ static struct pci_driver cxl_pci_driver = {
>  	},
>  };
>  
> +static struct cxl_dev_state *get_cxl_dev(u16 segment, u8 bus, u8 device,
> +					 u8 function)
I'd not expect a function with this name to return anything other
than a struct device *
get_cxl_devstate() maybe?

> +{
> +	struct pci_dev *pdev __free(pci_dev_put) = NULL;
> +	struct cxl_dev_state *cxlds;
> +	unsigned int devfn;
> +
> +	devfn = PCI_DEVFN(device, function);
Might as well do
	unsigned int devfn = PCI_DEVFN(device, function);

> +	pdev = pci_get_domain_bus_and_slot(segment, bus, devfn);

	struct pci_dev *pdev __free(pci_dev_put) =
		pci_get_domain_bus_and_slot(segment, bus, devfn);

see fwctl thread for a reference to Linus expressing a preference for
keeping construct and destructor definitions together even when
that means relaxing c conventions that we are so used to!

Obviously this is copied from below, but might as well tidy it up
whilst here.

However, do the devfn change above and it is in the definitions block...




> +
> +	if (!pdev)
> +		return NULL;
> +
> +	guard(device)(&pdev->dev);
> +	if (pdev->driver != &cxl_pci_driver)
> +		return NULL;
> +
> +	cxlds = pci_get_drvdata(pdev);
> +
> +	return cxlds;
return pci_get_drvdata(pdev);

I think the function is small enough having cxlds just so it's obvious
what is being returned is unnecessary.
> +}
> +
>  #define CXL_EVENT_HDR_FLAGS_REC_SEVERITY GENMASK(1, 0)
>  static void cxl_handle_cper_event(enum cxl_event_type ev_type,
>  				  struct cxl_cper_event_rec *rec)
>  {
>  	struct cper_cxl_event_devid *device_id = &rec->hdr.device_id;
> -	struct pci_dev *pdev __free(pci_dev_put) = NULL;
>  	enum cxl_event_log_type log_type;
>  	struct cxl_dev_state *cxlds;
> -	unsigned int devfn;
>  	u32 hdr_flags;
>  
>  	pr_debug("CPER event %d for device %u:%u:%u.%u\n", ev_type,
>  		 device_id->segment_num, device_id->bus_num,
>  		 device_id->device_num, device_id->func_num);
>  
> -	devfn = PCI_DEVFN(device_id->device_num, device_id->func_num);
> -	pdev = pci_get_domain_bus_and_slot(device_id->segment_num,
> -					   device_id->bus_num, devfn);
> -	if (!pdev)
> -		return;
> -
> -	guard(device)(&pdev->dev);
> -	if (pdev->driver != &cxl_pci_driver)
> -		return;
> -
> -	cxlds = pci_get_drvdata(pdev);
> +	cxlds = get_cxl_dev(device_id->segment_num, device_id->bus_num,
> +			    device_id->device_num, device_id->func_num);
>  	if (!cxlds)
>  		return;
>  
> @@ -1013,21 +1024,10 @@ static void cxl_handle_cper_event(enum cxl_event_type ev_type,
>  
>  static void cxl_handle_prot_err(struct cxl_cper_prot_err *p_err)
>  {
> -	struct pci_dev *pdev __free(pci_dev_put) = NULL;
>  	struct cxl_dev_state *cxlds;
> -	unsigned int devfn;
>  
> -	devfn = PCI_DEVFN(p_err->device, p_err->function);
> -	pdev = pci_get_domain_bus_and_slot(p_err->segment,
> -					   p_err->bus, devfn);
> -	if (!pdev)
> -		return;
> -
> -	guard(device)(&pdev->dev);
> -	if (pdev->driver != &cxl_pci_driver)
> -		return;
> -
> -	cxlds = pci_get_drvdata(pdev);
> +	cxlds = get_cxl_dev(p_err->segment, p_err->bus,
> +			    p_err->device, p_err->function);
>  	if (!cxlds)
>  		return;
>  


