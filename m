Return-Path: <linux-efi+bounces-668-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AFDC386BF69
	for <lists+linux-efi@lfdr.de>; Thu, 29 Feb 2024 04:23:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28161B22856
	for <lists+linux-efi@lfdr.de>; Thu, 29 Feb 2024 03:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB9237169;
	Thu, 29 Feb 2024 03:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ENz9sNBx"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C74E2E851;
	Thu, 29 Feb 2024 03:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709177013; cv=none; b=gszyDXm9oA946bdXlgs+PSUieZ+GLz6UxHgzt0JVMa0qfYTnNu6n7sq9ed/Dv7PmGWcmqoZcWh7QU2iSw0dUi/WnV6QW8xQt26RFtSxnaz0ZyHwmGtdySSN721dXc2mMRDBRl9sxKWH4TPx3OOhIF7pYE6NOTEX2NfI1un5sF8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709177013; c=relaxed/simple;
	bh=oq6iOWR3Be8NAwys5VPvZUV+Pl0yb4RFoJQDWT2ydyU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FKmsxOAE8rFqK0fmRJarppELK5jnqJeDp/iOsGtUu0EG4mf+szTBT6HLrxM+ygYiEX6LmRpLSDrSWuzSXPeqIApYNsYytsVSrogRYVlJWizc3K+nlTNSWYxyf9trPA7rUK3qv+KR66tzfSJfM1KN6rsxz473Fcl9Rt2UqFHB2Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ENz9sNBx; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709177012; x=1740713012;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=oq6iOWR3Be8NAwys5VPvZUV+Pl0yb4RFoJQDWT2ydyU=;
  b=ENz9sNBx8BVSK165ET+plu0gskK500Ca9efbG5JSrJf+qCbuRrorUC8S
   wng1XgmEOY1jo4B2wanHjU5bQnf26dx5q6kQf1N62ukpI27ioeUkHMdh/
   YVLIyakB0bwmPDNmlarcebZgEB+9kkrc92kzz6+aN6VjjjGWiIcQ8ETlX
   Cn3r/XWOVmmJ2Kz7659OlbGvH2maEU4TTdgU863SqpaMupzFolJ8QjGIO
   EerX3tg4mqk8zqsGpkqdWZUhl++7PJZWkFAS/Kwsxmtwa1nt3DWLQ1x1u
   +fuZD16YsbH0wzGslE1f/hGFdlgTg/+qYcq8miSx5hZ4rBjVBBIKPlYSf
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="14188896"
X-IronPort-AV: E=Sophos;i="6.06,192,1705392000"; 
   d="scan'208";a="14188896"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 19:23:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,192,1705392000"; 
   d="scan'208";a="12241675"
Received: from smitpat1-mobl.amr.corp.intel.com (HELO [10.209.30.182]) ([10.209.30.182])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 19:23:30 -0800
Message-ID: <49f8948f-3101-492d-8dae-46e8d8b8e2ed@linux.intel.com>
Date: Wed, 28 Feb 2024 19:23:30 -0800
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] efi/libstub: Add get_event_log() support for CC
 platforms
Content-Language: en-US
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
 linux-efi@vger.kernel.org
References: <20240215030002.281456-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20240215030002.281456-3-sathyanarayanan.kuppuswamy@linux.intel.com>
 <CAC_iWjJ_TS66KG7uGOQFiKGfZNKjnod6u7zua4LVK-EJHEUv8w@mail.gmail.com>
 <7feb889f-f78e-4caa-a2f4-9d41acf6ca76@linux.intel.com>
 <CAC_iWj+9eWesWD62krdhLwj58fpjptpnnG5JpUJUpFsg7_GzOA@mail.gmail.com>
 <3b8113ac-e44c-4b11-b494-9e473352037a@linux.intel.com>
 <CAC_iWjLXNBJz2RgRb3vbM_hetnw3hoWpG+sKM1gfiGo=z6tLxA@mail.gmail.com>
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <CAC_iWjLXNBJz2RgRb3vbM_hetnw3hoWpG+sKM1gfiGo=z6tLxA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 2/27/24 5:19 AM, Ilias Apalodimas wrote:
> On Sat, 24 Feb 2024 at 09:31, Kuppuswamy Sathyanarayanan
> <sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>>
>> On 2/23/24 5:24 AM, Ilias Apalodimas wrote:
>>> Apologies for the late reply,
>>>
>>>
>>> On Mon, 19 Feb 2024 at 09:34, Kuppuswamy Sathyanarayanan
>>> <sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>>>> Hi Ilias,
>>>>
>>>> On 2/18/24 11:03 PM, Ilias Apalodimas wrote:
>>>>> On Thu, 15 Feb 2024 at 05:02, Kuppuswamy Sathyanarayanan
>>>>> <sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>>>>>> To allow event log info access after boot, EFI boot stub extracts
>>>>>> the event log information and installs it in an EFI configuration
>>>>>> table. Currently, EFI boot stub only supports installation of event
>>>>>> log only for TPM 1.2 and TPM 2.0 protocols. Extend the same support
>>>>>> for CC protocol. Since CC platform also uses TCG2 format, reuse TPM2
>>>>>> support code as much as possible.
>>>>>>
>>>>>> Link: https://uefi.org/specs/UEFI/2.10/38_Confidential_Computing.html#efi-cc-measurement-protocol [1]
>>>>>> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>>>>> [...]
>>>>>
>>>>>> +void efi_retrieve_eventlog(void)
>>>>>> +{
>>>>>> +       efi_physical_addr_t log_location = 0, log_last_entry = 0;
>>>>>> +       efi_guid_t cc_guid = EFI_CC_MEASUREMENT_PROTOCOL_GUID;
>>>>>> +       efi_guid_t tpm2_guid = EFI_TCG2_PROTOCOL_GUID;
>>>>>> +       int version = EFI_TCG2_EVENT_LOG_FORMAT_TCG_2;
>>>>>> +       efi_tcg2_protocol_t *tpm2 = NULL;
>>>>>> +       efi_cc_protocol_t *cc = NULL;
>>>>>> +       efi_bool_t truncated;
>>>>>> +       efi_status_t status;
>>>>>> +
>>>>>> +       status = efi_bs_call(locate_protocol, &tpm2_guid, NULL, (void **)&tpm2);
>>>>>> +       if (status == EFI_SUCCESS) {
>>>>>> +               status = efi_call_proto(tpm2, get_event_log, version, &log_location,
>>>>>> +                                       &log_last_entry, &truncated);
>>>>>> +
>>>>>> +               if (status != EFI_SUCCESS || !log_location) {
>>>>>> +                       version = EFI_TCG2_EVENT_LOG_FORMAT_TCG_1_2;
>>>>>> +                       status = efi_call_proto(tpm2, get_event_log, version,
>>>>>> +                                               &log_location, &log_last_entry,
>>>>>> +                                               &truncated);
>>>>>> +                       if (status != EFI_SUCCESS || !log_location)
>>>>>> +                               return;
>>>>>> +               }
>>>>>> +
>>>>>> +               efi_retrieve_tcg2_eventlog(version, log_location, log_last_entry,
>>>>>> +                                          truncated);
>>>>>> +               return;
>>>>>> +       }
>>>>>> +
>>>>>> +       status = efi_bs_call(locate_protocol, &cc_guid, NULL, (void **)&cc);
>>>>>> +       if (status == EFI_SUCCESS) {
>>>>>> +               version = EFI_CC_EVENT_LOG_FORMAT_TCG_2;
>>>>>> +               status = efi_call_proto(cc, get_event_log, version, &log_location,
>>>>>> +                                       &log_last_entry, &truncated);
>>>>>> +               if (status != EFI_SUCCESS || !log_location)
>>>>>> +                       return;
>>>>>> +
>>>>>> +               efi_retrieve_tcg2_eventlog(version, log_location, log_last_entry,
>>>>>> +                                          truncated);
>>>>>> +               return;
>>>>>> +       }
>>>>>> +}
>>>>> [...]
>>>>>
>>>>> I haven't looked into CC measurements much, but do we always want to
>>>>> prioritize the tcg2 protocol? IOW if you have firmware that implements
>>>>> both, shouldn't we prefer the CC protocol for VMs?
>>>> According the UEFI specification, sec "Conidential computing", if a firmware implements
>>>> the TPM, then it should be used and CC interfaces should not be published. So I think
>>>> we should check for TPM first, if it does not exist then try for CC.
>>> Ok thanks, that makes sense. That document also says the services
>>> should be implemented on a virtual firmware.
>>> I am unsure at the moment though if it's worth checking that and
>>> reporting an error otherwise. Thoughts?
>> IMO, it is not fatal for the firmware to implement both protocols. Although, it
>> violates the specification, does it makes sense to return error and skip
>> measurements? I think for such case, we can add a warning and proceed
>> with TPM if it exists.
> If you have a TPM, the current code wouldn't even look for CC (which
> we agreed is correct).
> The question is, should we care if a firmware exposes the CC protocol,
> but isn't virtualized

AFAIK, even if a firmware improperly uses this protocol (in a non-virtual
environment), it should not be a fatal issue. So, if we add such a check,
it will be just a spec compliance check. Also, a firmware can improperly
use any existing EFI interfaces in n other ways. But, we cannot check for
all such cases, right? So personally I think it is not needed. But I am fine
either way.

If we want to add such check, I think we should either cc_platform_has()
or CPU feature flag check for it.

>
> Thanks
> /Ilias
>>> Thanks
>>> /Ilias
>>>> https://uefi.org/specs/UEFI/2.10/38_Confidential_Computing.html#confidential-computing
>>>>
>>>>> Thanks
>>>>> /Ilias
>>>> --
>>>> Sathyanarayanan Kuppuswamy
>>>> Linux Kernel Developer
>>>>
>> --
>> Sathyanarayanan Kuppuswamy
>> Linux Kernel Developer
>>
-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


