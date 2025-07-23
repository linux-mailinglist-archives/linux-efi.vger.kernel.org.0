Return-Path: <linux-efi+bounces-4464-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35255B0EB83
	for <lists+linux-efi@lfdr.de>; Wed, 23 Jul 2025 09:13:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 493E03AD69C
	for <lists+linux-efi@lfdr.de>; Wed, 23 Jul 2025 07:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C68925A659;
	Wed, 23 Jul 2025 07:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W5obrZbc"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E76623C4E5;
	Wed, 23 Jul 2025 07:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753254821; cv=none; b=ZBiVFM7e93HTiutlj0OlMgV2l6K4RhHfYgNanL9E9gzMBrtA0xqQd2V+leGilArfFq3rMdk42gCRQf5s+JgC3HIHEUmsmRnJZ2Rxb5sfing9ukWiWRJF7d/7ChScjOJ5qt9qU+XborB8+4/ltYhV7EE45wCl+BIOuUJSbNfze8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753254821; c=relaxed/simple;
	bh=/12iRcPetEOXapYCig7/D9f4SkyCFULzALcfoukwjfA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=nzuGG/qjsqhibybuVGeHvKfqsjJCbxckDoFzbLgvtqe4axomLDGN7xspiKG1rip/7j6fL5OTaf/gEzWB8C7NY0mocRIEQX+GnjQNf2BqX/mcFSh0X/39pLC/C28suA6OF9WVy0FED3TQXiIE/F/yoox57itu3cmHyyTAaAsTDto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W5obrZbc; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753254820; x=1784790820;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=/12iRcPetEOXapYCig7/D9f4SkyCFULzALcfoukwjfA=;
  b=W5obrZbcJ0cHZTWp5bDtLMurEKZTTHlSgyy0LblY7QrHnxfQhz7pSPlG
   Q/6mPlOsEYha9jqw8i73cyPqETF4YaR5lZZv1lB0PTkllU8c608Lpmd+u
   /CzvzaB0ZkDsg7wH3VDbtR5E9hWqeiTkakMNynfrL0HANTxy7cwBfUrN+
   oTm8hm8MsH8XFUa9jrBa1Vdaz2DyJfCLPDiuxRKzakaNlgbVhPBV2wMFm
   bJ9fQoNlVTzG4ZeotqREeKfiuw79XO5TFyet1jt3hhxHec0p8eSeekuJT
   KKLlWcTdEL75jGKd3lbLtUBmtdiL1ClOrr+GSDNJrG96hyqRmPZXCKef0
   A==;
X-CSE-ConnectionGUID: EOXHNlYETVe+SHVwPGGyJQ==
X-CSE-MsgGUID: nkgx9YaSTeGWKlDS25S+Jg==
X-IronPort-AV: E=McAfee;i="6800,10657,11500"; a="59327171"
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; 
   d="scan'208";a="59327171"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2025 00:13:39 -0700
X-CSE-ConnectionGUID: eu+CxN2oSx+WSqMjaFqkHw==
X-CSE-MsgGUID: hZrhGwLXT8mDZEggtUsrWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; 
   d="scan'208";a="190351123"
Received: from dlosowyj-mobl.amr.corp.intel.com (HELO [10.125.192.171]) ([10.125.192.171])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2025 00:13:37 -0700
Message-ID: <8e67a97c-530d-4a1c-ab72-3992a6c5db83@linux.intel.com>
Date: Wed, 23 Jul 2025 00:13:34 -0700
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: "invalid agent type: 1" in acpi/ghes, cper: Recognize and cache
 CXL Protocol errors
Content-Language: en-GB
From: Marc Herbert <marc.herbert@linux.intel.com>
To: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
 linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-cxl@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Yazen Ghannam <yazen.ghannam@amd.com>, Terry Bowman <terry.bowman@amd.com>,
 Dave Jiang <dave.jiang@intel.com>, tony.luck@intel.com,
 Gregory Price <gourry@gourry.net>
References: <20250123084421.127697-1-Smita.KoralahalliChannabasappa@amd.com>
 <20250123084421.127697-5-Smita.KoralahalliChannabasappa@amd.com>
 <074f5f77-7bef-4857-97fe-b68ee9b0afaf@linux.intel.com>
In-Reply-To: <074f5f77-7bef-4857-97fe-b68ee9b0afaf@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2025-07-22 12:24, Marc Herbert wrote:
> Hi Smita,
> 
>   The code below triggers the error "invalid agent type: 1" in Intel
> validation (internal issue 15018133056)

The same test case also triggers the other, warning message "CXL CPER no
device serial number".

I heard that "device" serial numbers are only for... devices and that
even then it's not always mandatory. So maybe that other message should
be downgraded from warning to the "info" level?

Marc


> On 2025-01-23 00:44, Smita Koralahalli wrote:
>> Add support in GHES to detect and process CXL CPER Protocol errors, as
>> defined in UEFI v2.10, section N.2.13.
>>
>> Define struct cxl_cper_prot_err_work_data to cache CXL protocol error
>> information, including RAS capabilities and severity, for further
>> handling.
>>
>> These cached CXL CPER records will later be processed by workqueues
>> within the CXL subsystem.
>>
>> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
>> ---
>>  drivers/acpi/apei/ghes.c | 54 ++++++++++++++++++++++++++++++++++++++++
>>  include/cxl/event.h      |  6 +++++
>>  2 files changed, 60 insertions(+)
>>
>> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
>> index b72772494655..4d725d988c43 100644
>> --- a/drivers/acpi/apei/ghes.c
>> +++ b/drivers/acpi/apei/ghes.c
>> @@ -674,6 +674,56 @@ static void ghes_defer_non_standard_event(struct acpi_hest_generic_data *gdata,
>>  	schedule_work(&entry->work);
>>  }
>>  
>> +static void cxl_cper_post_prot_err(struct cxl_cper_sec_prot_err *prot_err,
>> +				   int severity)
>> +{
>> +#ifdef CONFIG_ACPI_APEI_PCIEAER
>> +	struct cxl_cper_prot_err_work_data wd;
>> +	u8 *dvsec_start, *cap_start;
>> +
>> +	if (!(prot_err->valid_bits & PROT_ERR_VALID_AGENT_ADDRESS)) {
>> +		pr_err_ratelimited("CXL CPER invalid agent type\n");
>> +		return;
>> +	}
>> +
>> +	if (!(prot_err->valid_bits & PROT_ERR_VALID_ERROR_LOG)) {
>> +		pr_err_ratelimited("CXL CPER invalid protocol error log\n");
>> +		return;
>> +	}
>> +
>> +	if (prot_err->err_len != sizeof(struct cxl_ras_capability_regs)) {
>> +		pr_err_ratelimited("CXL CPER invalid RAS Cap size (%u)\n",
>> +				   prot_err->err_len);
>> +		return;
>> +	}
>> +
>> +	if (!(prot_err->valid_bits & PROT_ERR_VALID_SERIAL_NUMBER))
>> +		pr_warn(FW_WARN "CXL CPER no device serial number\n");
>> +
>> +	switch (prot_err->agent_type) {
>> +	case RCD:
>> +	case DEVICE:
>> +	case LD:
>> +	case FMLD:
>> +	case RP:
>> +	case DSP:
>> +	case USP:
>> +		memcpy(&wd.prot_err, prot_err, sizeof(wd.prot_err));
>> +
>> +		dvsec_start = (u8 *)(prot_err + 1);
>> +		cap_start = dvsec_start + prot_err->dvsec_len;
>> +
>> +		memcpy(&wd.ras_cap, cap_start, sizeof(wd.ras_cap));
>> +		wd.severity = cper_severity_to_aer(severity);
>> +		break;
>> +	default:
>> +		pr_err_ratelimited("CXL CPER invalid agent type: %d\n",
>> +				   prot_err->agent_type);
>> +		return;
>> +	}
>> +#endif
>> +}
>> +
>>  /* Room for 8 entries for each of the 4 event log queues */
>>  #define CXL_CPER_FIFO_DEPTH 32
>>  DEFINE_KFIFO(cxl_cper_fifo, struct cxl_cper_work_data, CXL_CPER_FIFO_DEPTH);
>> @@ -777,6 +827,10 @@ static bool ghes_do_proc(struct ghes *ghes,
>>  		}
>>  		else if (guid_equal(sec_type, &CPER_SEC_PROC_ARM)) {
>>  			queued = ghes_handle_arm_hw_error(gdata, sev, sync);
>> +		} else if (guid_equal(sec_type, &CPER_SEC_CXL_PROT_ERR)) {
>> +			struct cxl_cper_sec_prot_err *prot_err = acpi_hest_get_payload(gdata);
>> +
>> +			cxl_cper_post_prot_err(prot_err, gdata->error_severity);
>>  		} else if (guid_equal(sec_type, &CPER_SEC_CXL_GEN_MEDIA_GUID)) {
>>  			struct cxl_cper_event_rec *rec = acpi_hest_get_payload(gdata);
>>  
>> diff --git a/include/cxl/event.h b/include/cxl/event.h
>> index 66d85fc87701..ee1c3dec62fa 100644
>> --- a/include/cxl/event.h
>> +++ b/include/cxl/event.h
>> @@ -232,6 +232,12 @@ struct cxl_ras_capability_regs {
>>  	u32 header_log[16];
>>  };
>>  
>> +struct cxl_cper_prot_err_work_data {
>> +	struct cxl_cper_sec_prot_err prot_err;
>> +	struct cxl_ras_capability_regs ras_cap;
>> +	int severity;
>> +};
>> +
>>  #ifdef CONFIG_ACPI_APEI_GHES
>>  int cxl_cper_register_work(struct work_struct *work);
>>  int cxl_cper_unregister_work(struct work_struct *work);

