Return-Path: <linux-efi+bounces-1083-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73C448CDD0A
	for <lists+linux-efi@lfdr.de>; Fri, 24 May 2024 00:51:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAD071F23287
	for <lists+linux-efi@lfdr.de>; Thu, 23 May 2024 22:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44A4384DE9;
	Thu, 23 May 2024 22:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HFmoZeEb"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566DAAD2C;
	Thu, 23 May 2024 22:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716504706; cv=none; b=pL7xzFLyMeULKZ4FU248Kxog3spPSvW0mxWUc0Zyb2kON6gLSKB07PRZm87mKqEQOwZGhnGjgzkpLV/Zeyw9neQZIQwBkZtu15A8NYYjdCqwC6yELt+KkUIW5WezAMvr20P3jKuF06kbbUwW38qf3nNF+QYreRZtlXAGVHCXOQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716504706; c=relaxed/simple;
	bh=giJ5QDjLDfVV2cOpY+mASzmzACsrekg/cRgM9xcuAUA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s875IIgMmcg/5K8mxIQjsynrRjc6VLmNnacNwUoBeJVFzOXTod7oo2PDLI4J/R2CZ5lDLzjegbNal7SCB1eNS7lyYjM4BD6c6knxjwDslYlZI6dn4bACYjs1CSMGEbk0FtZgsTmzW9z66JNUN6a2QMrT8HLNsSHH363EHgh/5aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HFmoZeEb; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716504704; x=1748040704;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=giJ5QDjLDfVV2cOpY+mASzmzACsrekg/cRgM9xcuAUA=;
  b=HFmoZeEbrIhUg8N0qANhk4Q6TubfFJYTHeiUTPCqS8cyx0YT+qW/IrSr
   1nKs2ITWCGvBnmfDvobYm3Jh553JukeuSI4y1j9nm/y/cU/jMUXRreUAQ
   7NzEZERyQA19G7Fh2plPVDGxFoFzB13n3bUYF1zesQgJSwwmAgiKpeZ/r
   E3HjDmYlZZcWAhpRWx43OGzDdkla/vzXCf85JcPcCgeQjr+GWaHiNTCK4
   OO+iL6dOSeUQtHNMyDOAGM4Jy4gVb2TRdOZf9PrYH+8bH1xjGcY/2ZsfK
   dU8SDa9susHFKUO/cMzbsUS7UItEvMc1N+vVnjHWdhyxqFuGxwgTtNGQk
   w==;
X-CSE-ConnectionGUID: UV9q8AZKTDqzX/2IK1ROww==
X-CSE-MsgGUID: KgyOc1PuS4yDlpNjizx38w==
X-IronPort-AV: E=McAfee;i="6600,9927,11081"; a="30392880"
X-IronPort-AV: E=Sophos;i="6.08,183,1712646000"; 
   d="scan'208";a="30392880"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2024 15:51:44 -0700
X-CSE-ConnectionGUID: A1AX1DW8RWiVfriUcdUDTw==
X-CSE-MsgGUID: 60l+yT6OQdit+dQ4JACT5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,183,1712646000"; 
   d="scan'208";a="38231893"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.125.110.61]) ([10.125.110.61])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2024 15:51:42 -0700
Message-ID: <cf799922-d5f5-4f8d-96ef-5a526d5ae643@intel.com>
Date: Thu, 23 May 2024 15:51:41 -0700
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] acpi/ghes, efi/cper: Recognize and process CXL
 Protocol Errors.
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
 <20240522150839.27578-3-Smita.KoralahalliChannabasappa@amd.com>
 <8470dcc5-fbd4-4977-b8e8-5f7bfbf4b220@intel.com>
 <08dc0027-371c-5783-fd65-ad6f8b228fee@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <08dc0027-371c-5783-fd65-ad6f8b228fee@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 5/23/24 2:19 PM, Smita Koralahalli wrote:
> Hi Dave,
> 
> On 5/22/2024 10:59 AM, Dave Jiang wrote:
>>
>>
>> On 5/22/24 8:08 AM, Smita Koralahalli wrote:
>>> UEFI v2.10 section N.2.13 defines a CPER record for CXL Protocol errors.
>>>
>>> Add GHES support to detect CXL CPER Protocol Error Record and Cache Error
>>> Severity, Device ID, Device Serial number and CXL RAS capability struct in
>>> struct cxl_cper_prot_err. Include this struct as a member of struct
>>> cxl_cper_work_data.
>>>
>>> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
>>> ---
>>>   drivers/acpi/apei/ghes.c        | 10 +++++
>>>   drivers/firmware/efi/cper_cxl.c | 66 +++++++++++++++++++++++++++++++++
>>>   include/linux/cxl-event.h       | 26 +++++++++++++
>>>   3 files changed, 102 insertions(+)
>>>
> 
> [snip]
> 
> 
>>> +     * The device ID or agent address is required for CXL RCD, CXL
>>> +     * SLD, CXL LD, CXL Fabric Manager Managed LD, CXL Root Port,
>>> +     * CXL Downstream Switch Port and CXL Upstream Switch Port.
>>> +     */
>>> +    if (prot_err->agent_type <= 0x7 && prot_err->agent_type != RCH_DP) {
>>
>> Perhaps define an enum CXL_AGENT_TYPE_MAX instead of 0x7 magic number? Otherwise if a new type is introduced, it would break this code.
> 
> Agreed. I will define a boolean array indexed by agent type as suggested by Alison. That would avoid all these comparisons and not worry about breaking code in future.
> 
>>  
>>> +        p_err->segment = prot_err->agent_addr.segment;
>>> +        p_err->bus = prot_err->agent_addr.bus;
>>> +        p_err->device = prot_err->agent_addr.device;
>>> +        p_err->function = prot_err->agent_addr.function;
>>> +    } else {
>>> +        pr_err(FW_WARN "Invalid agent type\n");
>>> +        return -EINVAL;
>>> +    }
>>
>> Up to you if you want to do this or not, but maybe:
>>
>>     if (prot_err->agent_type >= CXL_AGENT_TYPE_MAX || prot_err->agent_type == RCH_DP) {
>>         pr_warn(...);
>>         return -EINVAL;
>>     }
>>
>>     p_err->segment = ...;
>>     p_err->bus = ...;
> 
> Noted.
> 
>>     ...
>>
>> Although perhaps a helper function cxl_cper_valid_agent_type() that checks invalid agent type by checking the valid_bits, the agent_type boundary, and if agent_type != RCH_DP?
> 
> Okay.
> 
>>> +
>>> +    if (!(prot_err->valid_bits & PROT_ERR_VALID_ERROR_LOG)) {
>>> +        pr_err(FW_WARN "Invalid Protocol Error log\n");
>>> +        return -EINVAL;
>>> +    }
>>> +
>>> +    dvsec_start = (u8 *)(prot_err + 1);
>>> +    cap_start = dvsec_start + prot_err->dvsec_len;
>>> +    p_err->cxl_ras = *(struct cxl_ras_capability_regs *)cap_start;
>>> +
>>> +    /*
>>> +     * Set device serial number unconditionally.
>>> +     *
>>> +     * Print a warning message if it is not valid. The device serial
>>> +     * number is required for CXL RCD, CXL SLD, CXL LD and CXL Fabric
>>> +     * Manager Managed LD.
>>> +     */
>>> +    if (!(prot_err->valid_bits & PROT_ERR_VALID_SERIAL_NUMBER) ||
>>> +          prot_err->agent_type > 0x4 || prot_err->agent_type == RCH_DP)
>>
>> prot_err->agent_type > FM_LD? Although maybe it would be a clearer read if a helper function is defined to identify the agent types such as cxl_cper_prot_err_serial_needed() or cxl_cper_prot_agent_type_device() and with it a switch statement to explicitly identify all the agent types that require serial number. If a future device is defined, the > 0x4 logic may break.
> 
> Probably helper function is not required if boolean array is defined? What do you think?

That works for me. My main concern is to clarify the code and remove possibility of breakage from future changes.
> 
> Thanks,
> Smita
> 
> [snip]

