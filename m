Return-Path: <linux-efi+bounces-2879-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CE14A4EC82
	for <lists+linux-efi@lfdr.de>; Tue,  4 Mar 2025 19:57:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8C1E188EBA1
	for <lists+linux-efi@lfdr.de>; Tue,  4 Mar 2025 18:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9656215F7D;
	Tue,  4 Mar 2025 18:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I46g0O7L"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1281EE7AD;
	Tue,  4 Mar 2025 18:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741114616; cv=none; b=cvxNE6hD8wQXNSMMd3mqiGrdyXfC/Cp01pBSR95hmbeqv9KtqNfLMgx6i9qFE5r7xR+EhcWFryIq4H04STJhosZ53Mhntve6RIoJJaiyKXNS6T3EzstMBvAb+Kl0ECBWwcFDL3Z6xiJYbSOVc3EiGh+a4IVJfvBOTiWFr5a0jys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741114616; c=relaxed/simple;
	bh=jNN+ALkVqBLsOraGBngdWfjn4aWXUrvS6kha8AJ+uSM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TFu+QYdjjZep8dmEdWxQdql8/N2JV//R8kMsmhgBmPLUvWJIlQyvU7GsQEtuyy7wf1nqpg7Bhcpbygqyn+NsRnph16Q5cGE4doy/KKK/zV3bHIM43d13FoZNB66tLGjnnB/xVVD5wVDGOoCG0a+VzV1vG3/vvVzQwNBaOs1RfQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I46g0O7L; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741114615; x=1772650615;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jNN+ALkVqBLsOraGBngdWfjn4aWXUrvS6kha8AJ+uSM=;
  b=I46g0O7LVd1cW3o5u7weSQ8zzlf4+IFRiX06NLxiVhHTAsMpgHBBikaI
   YC7ZNxxG+TdiNMF3saQwnwW8xPUxzc8R8SRy5mUBP2Hu/AI/3Z12gGHc5
   OFUsfpVR5Sjina4wTDaHlGvvg41E/ayMhLgOZpE0PeZ3m5CwEbfk1KcUP
   qtKUXO+s8na6fWWxu7eJRJxpqyxiVzCHs+yUNm5QxAC8L+JJE/nIf35b9
   Qj5ZIym2hDy6FylDmG28Hk8Iap90MwxSwOMY1fdpa0Uev87t9vhLE1K1i
   HU1y/UTHknD34h7TNkI1Llz3VEx1vBZnZVFgJwxOyaPVGLNQN2nqAQNhv
   Q==;
X-CSE-ConnectionGUID: ikVJiX1MSAq7rpeQHe9aeg==
X-CSE-MsgGUID: KebMXSuqSNmojcqb7qJRSg==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="53453054"
X-IronPort-AV: E=Sophos;i="6.14,220,1736841600"; 
   d="scan'208";a="53453054"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 10:56:54 -0800
X-CSE-ConnectionGUID: xUXsFrzMQ0SJUDL3yqgfMQ==
X-CSE-MsgGUID: mxMoLTajRYW6mo2UUB6DVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,220,1736841600"; 
   d="scan'208";a="118284175"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2.lan) ([10.125.109.132])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 10:56:53 -0800
Date: Tue, 4 Mar 2025 10:56:51 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>,
	Terry Bowman <terry.bowman@amd.com>
Subject: Re: [PATCH v7 2/2] cxl/pci: Add trace logging for CXL PCIe Port RAS
 errors
Message-ID: <Z8dM80wy5Q8UQomz@aschofie-mobl2.lan>
References: <20250226221157.149406-1-Smita.KoralahalliChannabasappa@amd.com>
 <20250226221157.149406-3-Smita.KoralahalliChannabasappa@amd.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226221157.149406-3-Smita.KoralahalliChannabasappa@amd.com>

On Wed, Feb 26, 2025 at 10:11:57PM +0000, Smita Koralahalli wrote:

Kind of a nit, but since these are exposed to user space suggest 
matching these names now.

> +++ b/drivers/cxl/core/trace.h
> @@ -48,6 +48,34 @@
>  	{ CXL_RAS_UC_IDE_RX_ERR, "IDE Rx Error" }			  \
>  )
>  
> +TRACE_EVENT(cxl_port_aer_uncorrectable_error,
> +	TP_PROTO(struct device *dev, u32 status, u32 fe, u32 *hl),
> +	TP_ARGS(dev, status, fe, hl),
> +	TP_STRUCT__entry(
> +		__string(devname, dev_name(dev))
> +		__string(parent, dev_name(dev->parent))

Above devname, parent 

> +		__field(u32, status)
> +		__field(u32, first_error)
> +		__array(u32, header_log, CXL_HEADERLOG_SIZE_U32)
> +	),
> +	TP_fast_assign(
> +		__assign_str(devname);
> +		__assign_str(parent);
> +		__entry->status = status;
> +		__entry->first_error = fe;
> +		/*
> +		 * Embed the 512B headerlog data for user app retrieval and
> +		 * parsing, but no need to print this in the trace buffer.
> +		 */
> +		memcpy(__entry->header_log, hl, CXL_HEADERLOG_SIZE);
> +	),
> +	TP_printk("device=%s host=%s status: '%s' first_error: '%s'",

Above device, host

> +		  __get_str(devname), __get_str(parent),
> +		  show_uc_errs(__entry->status),
> +		  show_uc_errs(__entry->first_error)
> +	)
> +);
> +
>  TRACE_EVENT(cxl_aer_uncorrectable_error,
>  	TP_PROTO(const struct cxl_memdev *cxlmd, u32 status, u32 fe, u32 *hl),
>  	TP_ARGS(cxlmd, status, fe, hl),
> @@ -96,6 +124,25 @@ TRACE_EVENT(cxl_aer_uncorrectable_error,
>  	{ CXL_RAS_CE_PHYS_LAYER_ERR, "Received Error From Physical Layer" }	\
>  )
>  

same thing below -


> +TRACE_EVENT(cxl_port_aer_correctable_error,
> +	TP_PROTO(struct device *dev, u32 status),
> +	TP_ARGS(dev, status),
> +	TP_STRUCT__entry(
> +		__string(devname, dev_name(dev))
> +		__string(parent, dev_name(dev->parent))
> +		__field(u32, status)
> +	),
> +	TP_fast_assign(
> +		__assign_str(devname);
> +		__assign_str(parent);
> +		__entry->status = status;
> +	),
> +	TP_printk("device=%s host=%s status='%s'",
> +		  __get_str(devname), __get_str(parent),
> +		  show_ce_errs(__entry->status)
> +	)
> +);
> +
>  TRACE_EVENT(cxl_aer_correctable_error,
>  	TP_PROTO(const struct cxl_memdev *cxlmd, u32 status),
>  	TP_ARGS(cxlmd, status),
> -- 
> 2.17.1
> 

