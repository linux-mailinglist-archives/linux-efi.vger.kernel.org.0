Return-Path: <linux-efi+bounces-2573-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BD4DA09713
	for <lists+linux-efi@lfdr.de>; Fri, 10 Jan 2025 17:20:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 733783A7597
	for <lists+linux-efi@lfdr.de>; Fri, 10 Jan 2025 16:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D073212D7F;
	Fri, 10 Jan 2025 16:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LdeutlN3"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3837211A19;
	Fri, 10 Jan 2025 16:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736526034; cv=none; b=Vu75idGdQu/6vrQZnIRfYbOvi2nlJtYE42B7MOEMTeSELZKdrUvHIif38K2gDMmoQf++rBc7aJGvf3vCyD936fALrSEEDKOjUV3rtd107jM1NgMladuuGs3GzL3Qq32IT4ChPoLYj3DajzgCJdfU4it2Qz89Q2Lft7eV6PCFAfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736526034; c=relaxed/simple;
	bh=1m1PzqJZBeCsyJsv5Akjfgha3sj5Jc8ipzHvDLAbxew=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MOiB7Q0Utx20KUaBguxa9YEcD/9gVthLHZzB9VF4ddOWmJtm4eLY0oAiERAp1cpG08wfv4H2C4bpdg+QGE7tpZl+QfS6Cvrm/LqSXi5pGbFKGX33UEB/lhV9/U3+16ZVjjShQbPDGtDGCvMvOeX6oZJQJTrvIHHNqxgk2W3UCaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LdeutlN3; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736526032; x=1768062032;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=1m1PzqJZBeCsyJsv5Akjfgha3sj5Jc8ipzHvDLAbxew=;
  b=LdeutlN3N4k+L2YwUoRiTHgnHWNYb0VTUpqPwUyaU2gEHnWbsNUyi0W5
   BE4K6cPiPCdBv+vEazMAUpC6k0bZ8ZFSoksZRxyXx2e+0KwLZYCnKCU4h
   i1nDdiWfIsDEBanuFCbYaQOFZI8quPEnm/HNDOudOCHZGE6EU9ycnbbew
   mPXg3YEBvBLFBknWQNo/Fa53k4rxDxXfTNvT8woEXn8No4suzXsi3gw0r
   WYzccvgcXQoCM2tjjBsi8ngHJLBRoyAXZOlRjNALNVOEu3gbDkhoN+6gC
   ullAHGAVHp2pA2aTSGS921I8EGqUdHa//XZINt4a8s9eHVx6ZI7t2MRaK
   w==;
X-CSE-ConnectionGUID: 6DiCNH+AQxOBuX9EpdzP8w==
X-CSE-MsgGUID: 17aQditVR+6Ew98ZuqXxKw==
X-IronPort-AV: E=McAfee;i="6700,10204,11311"; a="36983054"
X-IronPort-AV: E=Sophos;i="6.12,303,1728975600"; 
   d="scan'208";a="36983054"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2025 08:20:32 -0800
X-CSE-ConnectionGUID: U/VdEH9iQLmktP4QHIVEkQ==
X-CSE-MsgGUID: 6TdLZmAeRHuldGhZJmttHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,303,1728975600"; 
   d="scan'208";a="103587198"
Received: from ehanks-mobl1.amr.corp.intel.com (HELO [10.125.111.175]) ([10.125.111.175])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2025 08:20:31 -0800
Message-ID: <833ed783-31c2-4e1e-9f04-d6ec556c04d1@intel.com>
Date: Fri, 10 Jan 2025 09:20:30 -0700
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/5] efi/cper, cxl: Remove cper_cxl.h
To: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
 linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-cxl@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Yazen Ghannam <yazen.ghannam@amd.com>, Terry Bowman <terry.bowman@amd.com>
References: <20241217022032.87298-1-Smita.KoralahalliChannabasappa@amd.com>
 <20241217022032.87298-4-Smita.KoralahalliChannabasappa@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20241217022032.87298-4-Smita.KoralahalliChannabasappa@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/16/24 7:20 PM, Smita Koralahalli wrote:
> Move the declaration of cxl_cper_print_prot_err() to include/linux/cper.h
> to avoid maintaining a separate header file just for this function
> declaration. Remove drivers/firmware/efi/cper_cxl.h as its contents have
> been reorganized.
> 
> No functional changes.
> 
> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/firmware/efi/cper.c     |  1 -
>  drivers/firmware/efi/cper_cxl.c |  1 -
>  drivers/firmware/efi/cper_cxl.h | 16 ----------------
>  include/linux/cper.h            |  4 ++++
>  4 files changed, 4 insertions(+), 18 deletions(-)
>  delete mode 100644 drivers/firmware/efi/cper_cxl.h
> 
> diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
> index ae1953e2b214..928409199a1a 100644
> --- a/drivers/firmware/efi/cper.c
> +++ b/drivers/firmware/efi/cper.c
> @@ -25,7 +25,6 @@
>  #include <acpi/ghes.h>
>  #include <ras/ras_event.h>
>  #include <cxl/event.h>
> -#include "cper_cxl.h"
>  
>  /*
>   * CPER record ID need to be unique even after reboot, because record
> diff --git a/drivers/firmware/efi/cper_cxl.c b/drivers/firmware/efi/cper_cxl.c
> index 64c0dd27be6e..8a7667faf953 100644
> --- a/drivers/firmware/efi/cper_cxl.c
> +++ b/drivers/firmware/efi/cper_cxl.c
> @@ -9,7 +9,6 @@
>  
>  #include <linux/cper.h>
>  #include <cxl/event.h>
> -#include "cper_cxl.h"
>  
>  static const char * const prot_err_agent_type_strs[] = {
>  	"Restricted CXL Device",
> diff --git a/drivers/firmware/efi/cper_cxl.h b/drivers/firmware/efi/cper_cxl.h
> deleted file mode 100644
> index 5ce1401ee17a..000000000000
> --- a/drivers/firmware/efi/cper_cxl.h
> +++ /dev/null
> @@ -1,16 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0-only */
> -/*
> - * UEFI Common Platform Error Record (CPER) support for CXL Section.
> - *
> - * Copyright (C) 2022 Advanced Micro Devices, Inc.
> - *
> - * Author: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> - */
> -
> -#ifndef LINUX_CPER_CXL_H
> -#define LINUX_CPER_CXL_H
> -
> -void cxl_cper_print_prot_err(const char *pfx,
> -			     const struct cxl_cper_sec_prot_err *prot_err);
> -
> -#endif //__CPER_CXL_
> diff --git a/include/linux/cper.h b/include/linux/cper.h
> index 5c6d4d5b9975..0ed60a91eca9 100644
> --- a/include/linux/cper.h
> +++ b/include/linux/cper.h
> @@ -605,4 +605,8 @@ void cper_estatus_print(const char *pfx,
>  int cper_estatus_check_header(const struct acpi_hest_generic_status *estatus);
>  int cper_estatus_check(const struct acpi_hest_generic_status *estatus);
>  
> +struct cxl_cper_sec_prot_err;
> +void cxl_cper_print_prot_err(const char *pfx,
> +			     const struct cxl_cper_sec_prot_err *prot_err);
> +
>  #endif


