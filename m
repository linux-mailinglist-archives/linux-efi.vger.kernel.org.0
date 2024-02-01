Return-Path: <linux-efi+bounces-446-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FFDD844E97
	for <lists+linux-efi@lfdr.de>; Thu,  1 Feb 2024 02:18:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FFD81F23A53
	for <lists+linux-efi@lfdr.de>; Thu,  1 Feb 2024 01:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B36E2107;
	Thu,  1 Feb 2024 01:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iDvIvZnE"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758C93FE0;
	Thu,  1 Feb 2024 01:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706750280; cv=none; b=EX7k+jmj04XbHygzgyaw1mp48MwLAmDbRObsCYtbsPfq6of5RX4H0OPU3xWR5Fg5s/7wneTUUf0s8qLT2AYgNSD2I2uxHm0MWPu4GMkaRgyjcV/Kdbpd9A/SiZA3xuAULgfI5pylxo+cprLtBLQ2eNk9nGHIRvtvpNItbknQaVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706750280; c=relaxed/simple;
	bh=rafLIQNRvh6FE4ao1mLQpcBjXiqTD1MtuIE/eGlZ40E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pUUdBV6kUHZh/f5bTUJGBUBZUQdpfb0XJUU6t8IwXqJZtq1V/JxFxiymbp9ML1Ln16ur3N5/3F360dVZVkmtWnoZUb5BedN/V9CE/FqsweF6CVDsUG3IPA4TOyk/FI9zE7oLUnVQcWOpZ/DQv9RD2cZcpKTkBip8fkskbZJzoqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iDvIvZnE; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706750279; x=1738286279;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rafLIQNRvh6FE4ao1mLQpcBjXiqTD1MtuIE/eGlZ40E=;
  b=iDvIvZnEgGwiVQbvIZMRBthC7pD5SvYWrlx4r1oJP17gEGtEKh63TGiN
   qFPy5De6tXE1qnL5DtZDwsLjf0641+0MtDcQ1584Up3mI6qUV5ECtoHMM
   /8LHL74zh+dt8tZrscpLVxBhVtO4o7bZnbuZVQHPN91f5XjvqiRAkFpkn
   ACGuK3X2AaR7oMUxvTyoeZ/Cyi+fS20QyfYWDMQK+qi706Ze5LuBnSnu9
   ah4JVPG+dXjihN6Vg3UyfKB0HCGRDbh0hMmOQ1GAMA60X93xD3r8w8S58
   NinmgZgCn+uL0rAXIfPM3ws4s85GPmU0KqMak97NZfLlK4wC1icadMKnG
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="10534906"
X-IronPort-AV: E=Sophos;i="6.05,233,1701158400"; 
   d="scan'208";a="10534906"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 17:17:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,233,1701158400"; 
   d="scan'208";a="4233163"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.39.51])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 17:17:57 -0800
Date: Wed, 31 Jan 2024 17:17:55 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Ira Weiny <ira.weiny@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
	linux-cxl@vger.kernel.org
Subject: Re: [PATCH 2/2] cxl/trace: Remove unnecessary memcpy's
Message-ID: <ZbrxQ+FehE6nq9w5@aschofie-mobl2>
References: <20240131-cxl-cper-fixups-v1-0-335c85b1d77b@intel.com>
 <20240131-cxl-cper-fixups-v1-2-335c85b1d77b@intel.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240131-cxl-cper-fixups-v1-2-335c85b1d77b@intel.com>

On Wed, Jan 31, 2024 at 03:55:39PM -0800, Ira Weiny wrote:
> CPER events don't have UUIDs.  Therefore UUIDs were removed from the
> records passed to trace events and replaced with hard coded values.
> 
> As pointed out by Jonathan, the new defines for the UUIDs present a more
> efficient way to assign UUID in trace records.[1]
> 
> Replace memcpy's with the use of static data.

Reviewed-by: Alison Schofield <alison.schofield@intel.com>


> 
> [1] https://lore.kernel.org/all/20240108132325.00000e9c@Huawei.com/
> 
> Suggested-by: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> ---
>  drivers/cxl/core/trace.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
> index 89445435303a..bdf117a33744 100644
> --- a/drivers/cxl/core/trace.h
> +++ b/drivers/cxl/core/trace.h
> @@ -338,7 +338,7 @@ TRACE_EVENT(cxl_general_media,
>  
>  	TP_fast_assign(
>  		CXL_EVT_TP_fast_assign(cxlmd, log, rec->hdr);
> -		memcpy(&__entry->hdr_uuid, &CXL_EVENT_GEN_MEDIA_UUID, sizeof(uuid_t));
> +		__entry->hdr_uuid = CXL_EVENT_GEN_MEDIA_UUID;
>  
>  		/* General Media */
>  		__entry->dpa = le64_to_cpu(rec->phys_addr);
> @@ -425,7 +425,7 @@ TRACE_EVENT(cxl_dram,
>  
>  	TP_fast_assign(
>  		CXL_EVT_TP_fast_assign(cxlmd, log, rec->hdr);
> -		memcpy(&__entry->hdr_uuid, &CXL_EVENT_DRAM_UUID, sizeof(uuid_t));
> +		__entry->hdr_uuid = CXL_EVENT_DRAM_UUID;
>  
>  		/* DRAM */
>  		__entry->dpa = le64_to_cpu(rec->phys_addr);
> @@ -573,7 +573,7 @@ TRACE_EVENT(cxl_memory_module,
>  
>  	TP_fast_assign(
>  		CXL_EVT_TP_fast_assign(cxlmd, log, rec->hdr);
> -		memcpy(&__entry->hdr_uuid, &CXL_EVENT_MEM_MODULE_UUID, sizeof(uuid_t));
> +		__entry->hdr_uuid = CXL_EVENT_MEM_MODULE_UUID;
>  
>  		/* Memory Module Event */
>  		__entry->event_type = rec->event_type;
> 
> -- 
> 2.43.0
> 

