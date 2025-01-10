Return-Path: <linux-efi+bounces-2571-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 998E1A096FC
	for <lists+linux-efi@lfdr.de>; Fri, 10 Jan 2025 17:17:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 094F91670BE
	for <lists+linux-efi@lfdr.de>; Fri, 10 Jan 2025 16:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0BE1212FBA;
	Fri, 10 Jan 2025 16:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cBdDLWf5"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292BB212FB7;
	Fri, 10 Jan 2025 16:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736525821; cv=none; b=GV7YHqwbjDVlI42fXPrVMVvXMjKIDZt7ma32o3swqE/8UOaDTnVShZW6aEvii8qy+xkGN+BEFKloiinwgKeoWplkQlAYiw/biiHJVGtUED0+va+6ZO955U+jnE2hC/e5crUPAGwtRBXy/0KmSnwWXGDrPynHQLMHDQ5TEmMsLGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736525821; c=relaxed/simple;
	bh=qmOleW+GmQZJO00FFUFPH/v0GiIRiVand8Fs4J6FNYo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dk3iYQmQvYFax91dWPhfTteSV4cvmvnSW5OpSO5F203eILNhAdNs2+VjyxV6pOCuUpE1dwhh6ENJWxOxxS08AxXKu1fHIeaYtFodzvnFUgTwp6Wkp7op0jGniGczfSiIEGeTdo333WKjMtmtJuOeuM3dlELw9yPPLICgEBx6jJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cBdDLWf5; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736525820; x=1768061820;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qmOleW+GmQZJO00FFUFPH/v0GiIRiVand8Fs4J6FNYo=;
  b=cBdDLWf5362Jc4B/t8MlvXlxE6l6CIOHsECMAlFZagRIH9f0Tgqvfekz
   /AOUkggB8BQFsqxFN3W6Il8Xnft64PtQCg9jDpxlrhn2S04FSA4eLmeMy
   dEN4zBkvJyA8N3Ab5qVYGq++OkFZzwV7sqpxCl5T97JAb4g3uueYA8dp1
   JWaE4Lj0aN1Z9njtZm4Jx4Cm0XHeKVCvcHewsIO2r+Ad9gQ+QN0Js2K31
   n/2NviLtg+lbcNs31tLF+LKx1ZGu8sWZKLPoDGvkXAleUdLGQ7GjpqjrH
   UY9vNCe7+PfCbCP/6A+K3GEAvuWlukI5EUAu5kDlXhCL2blipVNmj7ZhB
   A==;
X-CSE-ConnectionGUID: mKLmdV5MTzmo/0QoDhmfJA==
X-CSE-MsgGUID: Q7fhIG3lQCabyg+FhUFP0Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11311"; a="62194936"
X-IronPort-AV: E=Sophos;i="6.12,303,1728975600"; 
   d="scan'208";a="62194936"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2025 08:17:00 -0800
X-CSE-ConnectionGUID: 7fiJ0JT7RfmyxCnCr7yT0A==
X-CSE-MsgGUID: x8Ks8Mn3Tl6PRryQ52NRXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="108407235"
Received: from ehanks-mobl1.amr.corp.intel.com (HELO [10.125.111.175]) ([10.125.111.175])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2025 08:16:58 -0800
Message-ID: <eeecc2ea-0c06-4fca-88bf-2c8a467404e1@intel.com>
Date: Fri, 10 Jan 2025 09:16:57 -0700
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/5] efi/cper, cxl: Prefix protocol error struct and
 function names with cxl_
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
 <20241217022032.87298-2-Smita.KoralahalliChannabasappa@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20241217022032.87298-2-Smita.KoralahalliChannabasappa@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/16/24 7:20 PM, Smita Koralahalli wrote:
> Rename the protocol error struct from struct cper_sec_prot_err to
> struct cxl_cper_sec_prot_err and cper_print_prot_err() to
> cxl_cper_print_prot_err() to maintain naming consistency. No
> functional changes.
> 
> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/firmware/efi/cper.c     | 4 ++--
>  drivers/firmware/efi/cper_cxl.c | 3 ++-
>  drivers/firmware/efi/cper_cxl.h | 5 +++--
>  3 files changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
> index b69e68ef3f02..8e5762f7ef2e 100644
> --- a/drivers/firmware/efi/cper.c
> +++ b/drivers/firmware/efi/cper.c
> @@ -624,11 +624,11 @@ cper_estatus_print_section(const char *pfx, struct acpi_hest_generic_data *gdata
>  		else
>  			goto err_section_too_small;
>  	} else if (guid_equal(sec_type, &CPER_SEC_CXL_PROT_ERR)) {
> -		struct cper_sec_prot_err *prot_err = acpi_hest_get_payload(gdata);
> +		struct cxl_cper_sec_prot_err *prot_err = acpi_hest_get_payload(gdata);
>  
>  		printk("%ssection_type: CXL Protocol Error\n", newpfx);
>  		if (gdata->error_data_length >= sizeof(*prot_err))
> -			cper_print_prot_err(newpfx, prot_err);
> +			cxl_cper_print_prot_err(newpfx, prot_err);
>  		else
>  			goto err_section_too_small;
>  	} else {
> diff --git a/drivers/firmware/efi/cper_cxl.c b/drivers/firmware/efi/cper_cxl.c
> index a55771b99a97..cbaabcb7382d 100644
> --- a/drivers/firmware/efi/cper_cxl.c
> +++ b/drivers/firmware/efi/cper_cxl.c
> @@ -55,7 +55,8 @@ enum {
>  	USP,	/* CXL Upstream Switch Port */
>  };
>  
> -void cper_print_prot_err(const char *pfx, const struct cper_sec_prot_err *prot_err)
> +void cxl_cper_print_prot_err(const char *pfx,
> +			     const struct cxl_cper_sec_prot_err *prot_err)
>  {
>  	if (prot_err->valid_bits & PROT_ERR_VALID_AGENT_TYPE)
>  		pr_info("%s agent_type: %d, %s\n", pfx, prot_err->agent_type,
> diff --git a/drivers/firmware/efi/cper_cxl.h b/drivers/firmware/efi/cper_cxl.h
> index 86bfcf7909ec..0e3ab0ba17c3 100644
> --- a/drivers/firmware/efi/cper_cxl.h
> +++ b/drivers/firmware/efi/cper_cxl.h
> @@ -18,7 +18,7 @@
>  #pragma pack(1)
>  
>  /* Compute Express Link Protocol Error Section, UEFI v2.10 sec N.2.13 */
> -struct cper_sec_prot_err {
> +struct cxl_cper_sec_prot_err {
>  	u64 valid_bits;
>  	u8 agent_type;
>  	u8 reserved[7];
> @@ -61,6 +61,7 @@ struct cper_sec_prot_err {
>  
>  #pragma pack()
>  
> -void cper_print_prot_err(const char *pfx, const struct cper_sec_prot_err *prot_err);
> +void cxl_cper_print_prot_err(const char *pfx,
> +			     const struct cxl_cper_sec_prot_err *prot_err);
>  
>  #endif //__CPER_CXL_


