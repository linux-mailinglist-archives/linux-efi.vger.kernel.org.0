Return-Path: <linux-efi+bounces-2572-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EEF2A0970F
	for <lists+linux-efi@lfdr.de>; Fri, 10 Jan 2025 17:19:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66A0E3A71A5
	for <lists+linux-efi@lfdr.de>; Fri, 10 Jan 2025 16:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4F1A212D81;
	Fri, 10 Jan 2025 16:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bHn/TQaL"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0E3211A19;
	Fri, 10 Jan 2025 16:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736525953; cv=none; b=WwtIKrqI0fPfAUIcKSmCbeiwGiwoIPaYw8E5WGZsrG6TeM8mouAglubFtqLPXR0SzeKvyMtouq6tRtML+Tsj706Y2o1izzYdUdAZio4X/Stno2NXCr6okih3yy1cMeGMItMJo059m02ljfK9eJn18gWkq9JhWpxbTDy/cC+1xhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736525953; c=relaxed/simple;
	bh=Szxc5AKb2yx26MadBWEdQJv66vCZ+8UpyZ53CmBGVRg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZWYF8eOSZ5SQrBkPSNbXqgdRPNQ3iT/LK8jY7pUJOhW3XAWyKyZdFRoMxobBMXGOUDc/r4u2WYFADQ0CQD2NU5wb/wkPyv7Yq6pN/VK7WKTz3DfwW/6RMSsq8roRYxn+Z9jG4oaXAzHPSGcFOmjIjdgNo00HwL8XMh3UXpWxGUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bHn/TQaL; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736525952; x=1768061952;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Szxc5AKb2yx26MadBWEdQJv66vCZ+8UpyZ53CmBGVRg=;
  b=bHn/TQaL6FtOjvjSYqtc6+FRTF9ODGKBTq887hpIdIJEfbhJ9FWFoQfi
   p4ovCRGuU8RgiPbZmpy54tdgKw6CeHPvoc/7xDi28PynADbOF3axpT6qO
   ciOferTCZFmR28Gg5Z3/qj/s/EaqYvN0bTU21b5J7mPW1F5qB+ycuPev0
   lcT3mM3CnndtPhw9Sc65PbLwoFKGIIPL7n0siOgO3JVjjIfgeDeOr63Jh
   5l+z13PYJREH3/YxGe2RfXXoGsk6+mPW7nPVeoWnVtfkAuoPW5LWhhaQK
   SF2AtOKVKS45uY7Zh4t3j35+jLPqkAuWsHotVpmxSiTVq/atqxxDD7egf
   A==;
X-CSE-ConnectionGUID: zegNgB3dS+iUeb6/5K7YvA==
X-CSE-MsgGUID: dS4rp9jUQ7GEXAuv8cFjwQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11311"; a="36982949"
X-IronPort-AV: E=Sophos;i="6.12,303,1728975600"; 
   d="scan'208";a="36982949"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2025 08:19:11 -0800
X-CSE-ConnectionGUID: nPjsqbMdSR6xg5lomwJ9wg==
X-CSE-MsgGUID: D3ROLDBXR0WK5t5UqU32QQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,303,1728975600"; 
   d="scan'208";a="103586304"
Received: from ehanks-mobl1.amr.corp.intel.com (HELO [10.125.111.175]) ([10.125.111.175])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2025 08:19:10 -0800
Message-ID: <f448a1fe-2f4b-4054-888a-8d19f85c012d@intel.com>
Date: Fri, 10 Jan 2025 09:19:09 -0700
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/5] efi/cper, cxl: Make definitions and structures
 global
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
 <20241217022032.87298-3-Smita.KoralahalliChannabasappa@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20241217022032.87298-3-Smita.KoralahalliChannabasappa@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/16/24 7:20 PM, Smita Koralahalli wrote:
> In preparation to add tracepoint support, move protocol error UUID
> definition to a common location, Also, make struct CXL RAS capability,
> cxl_cper_sec_prot_err and CPER validation flags global for use across
> different modules.
> 
> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/firmware/efi/cper.c     |  1 +
>  drivers/firmware/efi/cper_cxl.c | 35 +--------------
>  drivers/firmware/efi/cper_cxl.h | 51 ---------------------
>  include/cxl/event.h             | 80 +++++++++++++++++++++++++++++++++
>  include/linux/cper.h            |  4 ++
>  5 files changed, 86 insertions(+), 85 deletions(-)
> 
> diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
> index 8e5762f7ef2e..ae1953e2b214 100644
> --- a/drivers/firmware/efi/cper.c
> +++ b/drivers/firmware/efi/cper.c
> @@ -24,6 +24,7 @@
>  #include <linux/bcd.h>
>  #include <acpi/ghes.h>
>  #include <ras/ras_event.h>
> +#include <cxl/event.h>
>  #include "cper_cxl.h"
>  
>  /*
> diff --git a/drivers/firmware/efi/cper_cxl.c b/drivers/firmware/efi/cper_cxl.c
> index cbaabcb7382d..64c0dd27be6e 100644
> --- a/drivers/firmware/efi/cper_cxl.c
> +++ b/drivers/firmware/efi/cper_cxl.c
> @@ -8,27 +8,9 @@
>   */
>  
>  #include <linux/cper.h>
> +#include <cxl/event.h>
>  #include "cper_cxl.h"
>  
> -#define PROT_ERR_VALID_AGENT_TYPE		BIT_ULL(0)
> -#define PROT_ERR_VALID_AGENT_ADDRESS		BIT_ULL(1)
> -#define PROT_ERR_VALID_DEVICE_ID		BIT_ULL(2)
> -#define PROT_ERR_VALID_SERIAL_NUMBER		BIT_ULL(3)
> -#define PROT_ERR_VALID_CAPABILITY		BIT_ULL(4)
> -#define PROT_ERR_VALID_DVSEC			BIT_ULL(5)
> -#define PROT_ERR_VALID_ERROR_LOG		BIT_ULL(6)
> -
> -/* CXL RAS Capability Structure, CXL v3.0 sec 8.2.4.16 */
> -struct cxl_ras_capability_regs {
> -	u32 uncor_status;
> -	u32 uncor_mask;
> -	u32 uncor_severity;
> -	u32 cor_status;
> -	u32 cor_mask;
> -	u32 cap_control;
> -	u32 header_log[16];
> -};
> -
>  static const char * const prot_err_agent_type_strs[] = {
>  	"Restricted CXL Device",
>  	"Restricted CXL Host Downstream Port",
> @@ -40,21 +22,6 @@ static const char * const prot_err_agent_type_strs[] = {
>  	"CXL Upstream Switch Port",
>  };
>  
> -/*
> - * The layout of the enumeration and the values matches CXL Agent Type
> - * field in the UEFI 2.10 Section N.2.13,
> - */
> -enum {
> -	RCD,	/* Restricted CXL Device */
> -	RCH_DP,	/* Restricted CXL Host Downstream Port */
> -	DEVICE,	/* CXL Device */
> -	LD,	/* CXL Logical Device */
> -	FMLD,	/* CXL Fabric Manager managed Logical Device */
> -	RP,	/* CXL Root Port */
> -	DSP,	/* CXL Downstream Switch Port */
> -	USP,	/* CXL Upstream Switch Port */
> -};
> -
>  void cxl_cper_print_prot_err(const char *pfx,
>  			     const struct cxl_cper_sec_prot_err *prot_err)
>  {
> diff --git a/drivers/firmware/efi/cper_cxl.h b/drivers/firmware/efi/cper_cxl.h
> index 0e3ab0ba17c3..5ce1401ee17a 100644
> --- a/drivers/firmware/efi/cper_cxl.h
> +++ b/drivers/firmware/efi/cper_cxl.h
> @@ -10,57 +10,6 @@
>  #ifndef LINUX_CPER_CXL_H
>  #define LINUX_CPER_CXL_H
>  
> -/* CXL Protocol Error Section */
> -#define CPER_SEC_CXL_PROT_ERR						\
> -	GUID_INIT(0x80B9EFB4, 0x52B5, 0x4DE3, 0xA7, 0x77, 0x68, 0x78,	\
> -		  0x4B, 0x77, 0x10, 0x48)
> -
> -#pragma pack(1)
> -
> -/* Compute Express Link Protocol Error Section, UEFI v2.10 sec N.2.13 */
> -struct cxl_cper_sec_prot_err {
> -	u64 valid_bits;
> -	u8 agent_type;
> -	u8 reserved[7];
> -
> -	/*
> -	 * Except for RCH Downstream Port, all the remaining CXL Agent
> -	 * types are uniquely identified by the PCIe compatible SBDF number.
> -	 */
> -	union {
> -		u64 rcrb_base_addr;
> -		struct {
> -			u8 function;
> -			u8 device;
> -			u8 bus;
> -			u16 segment;
> -			u8 reserved_1[3];
> -		};
> -	} agent_addr;
> -
> -	struct {
> -		u16 vendor_id;
> -		u16 device_id;
> -		u16 subsystem_vendor_id;
> -		u16 subsystem_id;
> -		u8 class_code[2];
> -		u16 slot;
> -		u8 reserved_1[4];
> -	} device_id;
> -
> -	struct {
> -		u32 lower_dw;
> -		u32 upper_dw;
> -	} dev_serial_num;
> -
> -	u8 capability[60];
> -	u16 dvsec_len;
> -	u16 err_len;
> -	u8 reserved_2[4];
> -};
> -
> -#pragma pack()
> -
>  void cxl_cper_print_prot_err(const char *pfx,
>  			     const struct cxl_cper_sec_prot_err *prot_err);
>  
> diff --git a/include/cxl/event.h b/include/cxl/event.h
> index 0bea1afbd747..66d85fc87701 100644
> --- a/include/cxl/event.h
> +++ b/include/cxl/event.h
> @@ -152,6 +152,86 @@ struct cxl_cper_work_data {
>  	struct cxl_cper_event_rec rec;
>  };
>  
> +#define PROT_ERR_VALID_AGENT_TYPE		BIT_ULL(0)
> +#define PROT_ERR_VALID_AGENT_ADDRESS		BIT_ULL(1)
> +#define PROT_ERR_VALID_DEVICE_ID		BIT_ULL(2)
> +#define PROT_ERR_VALID_SERIAL_NUMBER		BIT_ULL(3)
> +#define PROT_ERR_VALID_CAPABILITY		BIT_ULL(4)
> +#define PROT_ERR_VALID_DVSEC			BIT_ULL(5)
> +#define PROT_ERR_VALID_ERROR_LOG		BIT_ULL(6)
> +
> +/*
> + * The layout of the enumeration and the values matches CXL Agent Type
> + * field in the UEFI 2.10 Section N.2.13,
> + */
> +enum {
> +	RCD,	/* Restricted CXL Device */
> +	RCH_DP,	/* Restricted CXL Host Downstream Port */
> +	DEVICE,	/* CXL Device */
> +	LD,	/* CXL Logical Device */
> +	FMLD,	/* CXL Fabric Manager managed Logical Device */
> +	RP,	/* CXL Root Port */
> +	DSP,	/* CXL Downstream Switch Port */
> +	USP,	/* CXL Upstream Switch Port */
> +};
> +
> +#pragma pack(1)
> +
> +/* Compute Express Link Protocol Error Section, UEFI v2.10 sec N.2.13 */
> +struct cxl_cper_sec_prot_err {
> +	u64 valid_bits;
> +	u8 agent_type;
> +	u8 reserved[7];
> +
> +	/*
> +	 * Except for RCH Downstream Port, all the remaining CXL Agent
> +	 * types are uniquely identified by the PCIe compatible SBDF number.
> +	 */
> +	union {
> +		u64 rcrb_base_addr;
> +		struct {
> +			u8 function;
> +			u8 device;
> +			u8 bus;
> +			u16 segment;
> +			u8 reserved_1[3];
> +		};
> +	} agent_addr;
> +
> +	struct {
> +		u16 vendor_id;
> +		u16 device_id;
> +		u16 subsystem_vendor_id;
> +		u16 subsystem_id;
> +		u8 class_code[2];
> +		u16 slot;
> +		u8 reserved_1[4];
> +	} device_id;
> +
> +	struct {
> +		u32 lower_dw;
> +		u32 upper_dw;
> +	} dev_serial_num;
> +
> +	u8 capability[60];
> +	u16 dvsec_len;
> +	u16 err_len;
> +	u8 reserved_2[4];
> +};
> +
> +#pragma pack()
> +
> +/* CXL RAS Capability Structure, CXL v3.0 sec 8.2.4.16 */
> +struct cxl_ras_capability_regs {
> +	u32 uncor_status;
> +	u32 uncor_mask;
> +	u32 uncor_severity;
> +	u32 cor_status;
> +	u32 cor_mask;
> +	u32 cap_control;
> +	u32 header_log[16];
> +};
> +
>  #ifdef CONFIG_ACPI_APEI_GHES
>  int cxl_cper_register_work(struct work_struct *work);
>  int cxl_cper_unregister_work(struct work_struct *work);
> diff --git a/include/linux/cper.h b/include/linux/cper.h
> index 265b0f8fc0b3..5c6d4d5b9975 100644
> --- a/include/linux/cper.h
> +++ b/include/linux/cper.h
> @@ -89,6 +89,10 @@ enum {
>  #define CPER_NOTIFY_DMAR						\
>  	GUID_INIT(0x667DD791, 0xC6B3, 0x4c27, 0x8A, 0x6B, 0x0F, 0x8E,	\
>  		  0x72, 0x2D, 0xEB, 0x41)
> +/* CXL Protocol Error Section */
> +#define CPER_SEC_CXL_PROT_ERR						\
> +	GUID_INIT(0x80B9EFB4, 0x52B5, 0x4DE3, 0xA7, 0x77, 0x68, 0x78,	\
> +		  0x4B, 0x77, 0x10, 0x48)
>  
>  /* CXL Event record UUIDs are formatted as GUIDs and reported in section type */
>  /*


