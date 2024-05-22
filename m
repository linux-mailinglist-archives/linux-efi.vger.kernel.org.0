Return-Path: <linux-efi+bounces-1060-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F7C98CC581
	for <lists+linux-efi@lfdr.de>; Wed, 22 May 2024 19:28:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46F5D1C210E5
	for <lists+linux-efi@lfdr.de>; Wed, 22 May 2024 17:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59E211420BB;
	Wed, 22 May 2024 17:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HY+g04KC"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6735E2869B;
	Wed, 22 May 2024 17:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716398916; cv=none; b=QBlUyUWyUJ5Xp84mlRqmHoOx3hrTY7cbQcByijTYZ+V9lyY37bei4a+hm6jg+4pgR4lEy8DgGvxdjc6v+hTEpfxaqDVHT0Zh80e7D7pDupz+Mo2nCCscRn3Sg1IkvG5BEjVwlTvl54vPZ5LthxRHfc5/NfzeTrn20IkOV2Zx6bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716398916; c=relaxed/simple;
	bh=6IAVb655Lal5k214BV1xTkv/4AhPMBgxi0xW4QePFvc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VEKJQlHDfaVuU9spJAQBUxAh7ieX73FzzIjlEIXlt2IE27BC+TLtXviGCSWF5PB020x56383ntCV22dAPucVNmABLDoB+mYVcKq0QuD/FqKxrRpMbxDdlkY8pt8/bGF8irOhV2rMFF2NkwKz7/YdT7k9SjV4VgaiN3L0kGYA0PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HY+g04KC; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716398914; x=1747934914;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6IAVb655Lal5k214BV1xTkv/4AhPMBgxi0xW4QePFvc=;
  b=HY+g04KC/d3tdwU0vkzlu7G8OSFGrTWNlP0DAFnHBZA4tp2oIvtJeGvZ
   KkoFJmB9k09rFR2sNP3uDU73JMjIp3kMNdTzryvIPEuX5QzXSN5vjQxWb
   lib+7xBJiqMl7XQVVCL4Nc4kvK0XiZRY05AIK2gj7MjhVsudm2kEvcTbz
   OSU/IqvAGiEP3RSlq14B4p62lYmeuoGgSX8IWmUd36YiSGqIFzDBsQ7A4
   JmGdrCZokh5De9P24MZZ4fszK6s9jBhd+6vFflF2tkulrlHlBzLJcMWoj
   n4Wzur6AYGVevmCah/n9wk19kyr41C4birMHzlmFiFlMYANH2pV6j0ur5
   A==;
X-CSE-ConnectionGUID: F4tuFladQvqtlmclYMq7Iw==
X-CSE-MsgGUID: 2FuEGPoWTDidzOtEFgeI7A==
X-IronPort-AV: E=McAfee;i="6600,9927,11080"; a="12610632"
X-IronPort-AV: E=Sophos;i="6.08,181,1712646000"; 
   d="scan'208";a="12610632"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2024 10:28:34 -0700
X-CSE-ConnectionGUID: uAOOS8q7T1qcbDdPM8/oqw==
X-CSE-MsgGUID: b4OMRyvKR3Sbi/TYIEM54g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,181,1712646000"; 
   d="scan'208";a="33368874"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.125.109.237]) ([10.125.109.237])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2024 10:28:33 -0700
Message-ID: <64ec7628-4906-4f5f-81b3-8e25536214c2@intel.com>
Date: Wed, 22 May 2024 10:28:31 -0700
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] efi/cper, cxl: Make definitions and structures global
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
 <20240522150839.27578-2-Smita.KoralahalliChannabasappa@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20240522150839.27578-2-Smita.KoralahalliChannabasappa@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/22/24 8:08 AM, Smita Koralahalli wrote:
> In preparation to add tracepoint support, move protocol error UUID
> definition to a common location and make CXL RAS capability struct
> global for use across different modules.
> 
> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/firmware/efi/cper_cxl.c | 11 -----------
>  drivers/firmware/efi/cper_cxl.h |  7 ++-----
>  include/linux/cper.h            |  4 ++++
>  include/linux/cxl-event.h       | 11 +++++++++++
>  4 files changed, 17 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/firmware/efi/cper_cxl.c b/drivers/firmware/efi/cper_cxl.c
> index a55771b99a97..4fd8d783993e 100644
> --- a/drivers/firmware/efi/cper_cxl.c
> +++ b/drivers/firmware/efi/cper_cxl.c
> @@ -18,17 +18,6 @@
>  #define PROT_ERR_VALID_DVSEC			BIT_ULL(5)
>  #define PROT_ERR_VALID_ERROR_LOG		BIT_ULL(6)
>  
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
> diff --git a/drivers/firmware/efi/cper_cxl.h b/drivers/firmware/efi/cper_cxl.h
> index 86bfcf7909ec..6f8c00495708 100644
> --- a/drivers/firmware/efi/cper_cxl.h
> +++ b/drivers/firmware/efi/cper_cxl.h
> @@ -7,14 +7,11 @@
>   * Author: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
>   */
>  
> +#include <linux/cxl-event.h>
> +
>  #ifndef LINUX_CPER_CXL_H
>  #define LINUX_CPER_CXL_H
>  
> -/* CXL Protocol Error Section */
> -#define CPER_SEC_CXL_PROT_ERR						\
> -	GUID_INIT(0x80B9EFB4, 0x52B5, 0x4DE3, 0xA7, 0x77, 0x68, 0x78,	\
> -		  0x4B, 0x77, 0x10, 0x48)
> -
>  #pragma pack(1)
>  
>  /* Compute Express Link Protocol Error Section, UEFI v2.10 sec N.2.13 */
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
> diff --git a/include/linux/cxl-event.h b/include/linux/cxl-event.h
> index 60b25020281f..f11e52ff565a 100644
> --- a/include/linux/cxl-event.h
> +++ b/include/linux/cxl-event.h
> @@ -154,6 +154,17 @@ struct cxl_cper_event_rec {
>  	union cxl_event event;
>  } __packed;
>  
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
>  struct cxl_cper_work_data {
>  	enum cxl_event_type event_type;
>  	struct cxl_cper_event_rec rec;

