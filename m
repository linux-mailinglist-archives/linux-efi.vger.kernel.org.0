Return-Path: <linux-efi+bounces-661-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED1C086234E
	for <lists+linux-efi@lfdr.de>; Sat, 24 Feb 2024 08:31:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D2F21C2122F
	for <lists+linux-efi@lfdr.de>; Sat, 24 Feb 2024 07:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD72810A2B;
	Sat, 24 Feb 2024 07:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m9BvGJeZ"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0A68487;
	Sat, 24 Feb 2024 07:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708759873; cv=none; b=X1wCtNpcOhmgbDmk3ieg7ArvwcRuGnSQ0DHYJfpDPHIdsiAGuCg+kwezrwnMpQcUxtMbxUxtn3u02Lfsizw/ag+T+xVjR1UnkIct/A9wCNLWkaxDMCPCkIiy+k7YxJDR8mS+XZkU50gG/brpLa/GR2RcLUJVIHv0U1Enqrhwcdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708759873; c=relaxed/simple;
	bh=buu8SVznffYLooKd5ucCOXhekw/UjP+3E944rGDQ+L8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gkb9c/p/V4LQCH2LXG7RuF4wa44jaT979TX/7LzvEHd0kSI+iPgHTk7QYo29I8n70r0d3ysOGMJeb8CrA3TP79MF+spvBqsdLC6zA6r5bOVrfNWtk2CWZG+RIk7PyJpvtqZfomb38R2Zs07pxwLjh5ObHfyKIC09Ejp9WhlcMOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m9BvGJeZ; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708759872; x=1740295872;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=buu8SVznffYLooKd5ucCOXhekw/UjP+3E944rGDQ+L8=;
  b=m9BvGJeZNCEHXs0XeE0lJ893NEld56Hc8Qfo3vE+1HattXi6WyEYasj2
   iIFZM0Gc1R1spChZSdYgFXEn450gZE01fCndmDyB+eEm7GEmHHDba1LQz
   8eBFsder0y148MqqB9Q4MD0YDBSf0P5wU56edlgxjl3zyiOniNPFgQqGq
   U/bVWnncJETPIjCm+3UEUnyuOUPvAnP+nMCO9og0r6TFq8hpkHBJ5k74n
   b4dyVlN3OHhPZzJYJ/lD030pZFsdCdO7HOPFepnFqRjUdxt1jaJmQwxDZ
   IVEpv51ZwjvJkS6TteLAVsG5H/GEJ0m3OyIetNUbxSotYZhQjrT5S1Y20
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10993"; a="6908083"
X-IronPort-AV: E=Sophos;i="6.06,181,1705392000"; 
   d="scan'208";a="6908083"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 23:31:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,181,1705392000"; 
   d="scan'208";a="37150062"
Received: from bafghani-mobl.amr.corp.intel.com (HELO [10.255.231.229]) ([10.255.231.229])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 23:31:11 -0800
Message-ID: <3b8113ac-e44c-4b11-b494-9e473352037a@linux.intel.com>
Date: Fri, 23 Feb 2024 23:31:10 -0800
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
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <CAC_iWj+9eWesWD62krdhLwj58fpjptpnnG5JpUJUpFsg7_GzOA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 2/23/24 5:24 AM, Ilias Apalodimas wrote:
> Apologies for the late reply,
>
>
> On Mon, 19 Feb 2024 at 09:34, Kuppuswamy Sathyanarayanan
> <sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>> Hi Ilias,
>>
>> On 2/18/24 11:03 PM, Ilias Apalodimas wrote:
>>> On Thu, 15 Feb 2024 at 05:02, Kuppuswamy Sathyanarayanan
>>> <sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>>>> To allow event log info access after boot, EFI boot stub extracts
>>>> the event log information and installs it in an EFI configuration
>>>> table. Currently, EFI boot stub only supports installation of event
>>>> log only for TPM 1.2 and TPM 2.0 protocols. Extend the same support
>>>> for CC protocol. Since CC platform also uses TCG2 format, reuse TPM2
>>>> support code as much as possible.
>>>>
>>>> Link: https://uefi.org/specs/UEFI/2.10/38_Confidential_Computing.html#efi-cc-measurement-protocol [1]
>>>> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>>> [...]
>>>
>>>> +void efi_retrieve_eventlog(void)
>>>> +{
>>>> +       efi_physical_addr_t log_location = 0, log_last_entry = 0;
>>>> +       efi_guid_t cc_guid = EFI_CC_MEASUREMENT_PROTOCOL_GUID;
>>>> +       efi_guid_t tpm2_guid = EFI_TCG2_PROTOCOL_GUID;
>>>> +       int version = EFI_TCG2_EVENT_LOG_FORMAT_TCG_2;
>>>> +       efi_tcg2_protocol_t *tpm2 = NULL;
>>>> +       efi_cc_protocol_t *cc = NULL;
>>>> +       efi_bool_t truncated;
>>>> +       efi_status_t status;
>>>> +
>>>> +       status = efi_bs_call(locate_protocol, &tpm2_guid, NULL, (void **)&tpm2);
>>>> +       if (status == EFI_SUCCESS) {
>>>> +               status = efi_call_proto(tpm2, get_event_log, version, &log_location,
>>>> +                                       &log_last_entry, &truncated);
>>>> +
>>>> +               if (status != EFI_SUCCESS || !log_location) {
>>>> +                       version = EFI_TCG2_EVENT_LOG_FORMAT_TCG_1_2;
>>>> +                       status = efi_call_proto(tpm2, get_event_log, version,
>>>> +                                               &log_location, &log_last_entry,
>>>> +                                               &truncated);
>>>> +                       if (status != EFI_SUCCESS || !log_location)
>>>> +                               return;
>>>> +               }
>>>> +
>>>> +               efi_retrieve_tcg2_eventlog(version, log_location, log_last_entry,
>>>> +                                          truncated);
>>>> +               return;
>>>> +       }
>>>> +
>>>> +       status = efi_bs_call(locate_protocol, &cc_guid, NULL, (void **)&cc);
>>>> +       if (status == EFI_SUCCESS) {
>>>> +               version = EFI_CC_EVENT_LOG_FORMAT_TCG_2;
>>>> +               status = efi_call_proto(cc, get_event_log, version, &log_location,
>>>> +                                       &log_last_entry, &truncated);
>>>> +               if (status != EFI_SUCCESS || !log_location)
>>>> +                       return;
>>>> +
>>>> +               efi_retrieve_tcg2_eventlog(version, log_location, log_last_entry,
>>>> +                                          truncated);
>>>> +               return;
>>>> +       }
>>>> +}
>>> [...]
>>>
>>> I haven't looked into CC measurements much, but do we always want to
>>> prioritize the tcg2 protocol? IOW if you have firmware that implements
>>> both, shouldn't we prefer the CC protocol for VMs?
>> According the UEFI specification, sec "Conidential computing", if a firmware implements
>> the TPM, then it should be used and CC interfaces should not be published. So I think
>> we should check for TPM first, if it does not exist then try for CC.
> Ok thanks, that makes sense. That document also says the services
> should be implemented on a virtual firmware.
> I am unsure at the moment though if it's worth checking that and
> reporting an error otherwise. Thoughts?

IMO, it is not fatal for the firmware to implement both protocols. Although, it
violates the specification, does it makes sense to return error and skip
measurements? I think for such case, we can add a warning and proceed
with TPM if it exists.

>
> Thanks
> /Ilias
>> https://uefi.org/specs/UEFI/2.10/38_Confidential_Computing.html#confidential-computing
>>
>>> Thanks
>>> /Ilias
>> --
>> Sathyanarayanan Kuppuswamy
>> Linux Kernel Developer
>>
-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


