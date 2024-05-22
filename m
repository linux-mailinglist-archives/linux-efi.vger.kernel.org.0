Return-Path: <linux-efi+bounces-1065-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D0E88CC768
	for <lists+linux-efi@lfdr.de>; Wed, 22 May 2024 21:42:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40F981C2099D
	for <lists+linux-efi@lfdr.de>; Wed, 22 May 2024 19:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C0BD7BAF7;
	Wed, 22 May 2024 19:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CZHSzy6r"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222F82D7B8;
	Wed, 22 May 2024 19:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716406934; cv=none; b=m2ncQyOIAXjcqS4ZEE1/wc+yhIj8Ko/Jrdm19xmBKHifjlJFPwB+LWXFftbrFCZhhqDsYRlozqTQc16U0WXFvv/Mw00uMpppdaBIoNn27bNPO++fdhw1K0+3ParQqnCgm3fXb6lDt4xGjkJ9Hj/52CyjB0t5Q4oHfkUxwsx7QNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716406934; c=relaxed/simple;
	bh=apsvq8D/U5++BNOQgSfpk+bmHPQ8hj7h6aQa6GB6wio=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KEQfyOF8iawhl1qbtkoj5xUlSq4LN7EzxzuBwk8C72xizJT8kyzOZNfCpfq7gDcfxALgCJJUxLqznhLiGCibz/G2rOHg45qYj5o6fLxtaYVQU/OIO1AaecQKR/wH4WKus5rfsZX5zi69Ac7Kh/4T138Bf1oGqXBYVKK867jK9/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CZHSzy6r; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716406932; x=1747942932;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=apsvq8D/U5++BNOQgSfpk+bmHPQ8hj7h6aQa6GB6wio=;
  b=CZHSzy6rzvnjvagrmQRH2KLLxtd0qzC5lww37DrXxZIaA4pLvJOwhlNJ
   OHebiJRt3g2mPKcBPIaek+aFCFFhox0JuVn9f14BLnxycxZG1CTzAwArh
   zIoGbTNRjs3Js2AC6yc4Z0C3g46jj+fvdo3mam84rdrWp1j15aYKW8i7w
   BCeFph4r4JN035lcfy3MS0bQvfPI+G98X+hPxL13M+R2/eWgs2TRLzWs/
   ja4TVh71/MdsC1eC+YP/3ypiwoiDaqLfzxA9Y0n9ODoTJW1we4weOUdi6
   Ii3OKxAGQzxulI60E6PhRyBGLb/WyAvJQJ4aSqAEroucc/iMI/nKiCIWY
   A==;
X-CSE-ConnectionGUID: n+8sASfqQ+y3ZFq0tEhHaA==
X-CSE-MsgGUID: R0HV3gDvSAu4UeCjCQOTWw==
X-IronPort-AV: E=McAfee;i="6600,9927,11080"; a="23256916"
X-IronPort-AV: E=Sophos;i="6.08,181,1712646000"; 
   d="scan'208";a="23256916"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2024 12:42:11 -0700
X-CSE-ConnectionGUID: BxF/64opR/WvluM5jcjbig==
X-CSE-MsgGUID: H5drMtJ3R+aAH/ZndtsmFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,181,1712646000"; 
   d="scan'208";a="56643099"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.125.109.237]) ([10.125.109.237])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2024 12:42:10 -0700
Message-ID: <dd0f3183-e10b-4a3d-98b6-c6963dc86512@intel.com>
Date: Wed, 22 May 2024 12:42:09 -0700
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] cxl/pci: Define a common function get_cxl_dev()
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
 <20240522150839.27578-5-Smita.KoralahalliChannabasappa@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20240522150839.27578-5-Smita.KoralahalliChannabasappa@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/22/24 8:08 AM, Smita Koralahalli wrote:
> Refactor computation of cxlds to a common function get_cxl_dev() and reuse
> the function in both cxl_handle_cper_event() and cxl_handle_prot_err().

I think just introduce the function where you open coded it instead of adding code and then deleting them in the same series.
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

get_cxlds() or get_cxl_device_state() would be better. 

DJ

> +{
> +	struct pci_dev *pdev __free(pci_dev_put) = NULL;
> +	struct cxl_dev_state *cxlds;
> +	unsigned int devfn;
> +
> +	devfn = PCI_DEVFN(device, function);
> +	pdev = pci_get_domain_bus_and_slot(segment, bus, devfn);
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

