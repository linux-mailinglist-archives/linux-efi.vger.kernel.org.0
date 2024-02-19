Return-Path: <linux-efi+bounces-584-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79773859D02
	for <lists+linux-efi@lfdr.de>; Mon, 19 Feb 2024 08:34:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2765C1F22B91
	for <lists+linux-efi@lfdr.de>; Mon, 19 Feb 2024 07:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA0ED20B17;
	Mon, 19 Feb 2024 07:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ivwMq1Sh"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1166620B0E;
	Mon, 19 Feb 2024 07:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708328068; cv=none; b=L/ndf2ch6jh760DAX6FWZM0yNym6AAxXzmY3XeOve0jXn6eOroROFLU9OTvdy57H/F8G8H7587Fsu0hlW/XvVYmcV/Vr+PlziAXCzAS1aoSshquYUh9P7hnSPf/h9fLhIyr9ANYs6tv4SvqGXOi/eg49hvjuQhqKnNE6wjpbs1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708328068; c=relaxed/simple;
	bh=nG+e0xfx4vtsde8hCf9gGVh7ZBbgR70WURJo1H2ry3E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WAZuyCc/ZCWyhRmNZg5EH+zACpR6CEk5GWVYSjcO7Rgvd1q79t34IR02uJMxF81FM4fWPUk7Epe7UDVQ203Fpo7Mlihsj028yIuo67rQPI/nyNsj0GM5R703Fl7eTQs6Nq1K9dXfMUeKDfp2YgzhuCOrDo8yxFnM1rIhjQzSqNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ivwMq1Sh; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708328067; x=1739864067;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=nG+e0xfx4vtsde8hCf9gGVh7ZBbgR70WURJo1H2ry3E=;
  b=ivwMq1Sh0968tUK0gIeSVA4F8Pn9Y0YKlFLZ3uPh86b9IkiI0Ld806o3
   AkQZrMvwJD/uSBVzAZEiI/+Q4YIDqJEyzBwFUVIHG/k6g+7EyJzqksPz9
   HkGTzj7y59CuwN4GlDp1dY827rRyApQyKQJvq1MTvEDS3nWtWGshE8lif
   oYEte3YEyLJIQXN4zA1ODtpQxbLiUyPPMUKUiGN1En1PaitQhhSWGT8rA
   TlD7NucZn3xtz9duE5P2BoqZQVDNxaHxoOnk33RQaFAk22o7z6K2JiyKf
   JE01vxd1QlvVnA/b3XXd8hUlf/b5OTRQ6dapVlKznynj2W9XUWrmd7j9G
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10988"; a="13503078"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="13503078"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2024 23:34:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="27579484"
Received: from mojammel-mobl.amr.corp.intel.com (HELO [10.209.58.186]) ([10.209.58.186])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2024 23:34:24 -0800
Message-ID: <7feb889f-f78e-4caa-a2f4-9d41acf6ca76@linux.intel.com>
Date: Sun, 18 Feb 2024 23:34:23 -0800
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] efi/libstub: Add get_event_log() support for CC
 platforms
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
 linux-efi@vger.kernel.org
References: <20240215030002.281456-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20240215030002.281456-3-sathyanarayanan.kuppuswamy@linux.intel.com>
 <CAC_iWjJ_TS66KG7uGOQFiKGfZNKjnod6u7zua4LVK-EJHEUv8w@mail.gmail.com>
Content-Language: en-US
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <CAC_iWjJ_TS66KG7uGOQFiKGfZNKjnod6u7zua4LVK-EJHEUv8w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Ilias,

On 2/18/24 11:03 PM, Ilias Apalodimas wrote:
> On Thu, 15 Feb 2024 at 05:02, Kuppuswamy Sathyanarayanan
> <sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>> To allow event log info access after boot, EFI boot stub extracts
>> the event log information and installs it in an EFI configuration
>> table. Currently, EFI boot stub only supports installation of event
>> log only for TPM 1.2 and TPM 2.0 protocols. Extend the same support
>> for CC protocol. Since CC platform also uses TCG2 format, reuse TPM2
>> support code as much as possible.
>>
>> Link: https://uefi.org/specs/UEFI/2.10/38_Confidential_Computing.html#efi-cc-measurement-protocol [1]
>> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> [...]
>
>> +void efi_retrieve_eventlog(void)
>> +{
>> +       efi_physical_addr_t log_location = 0, log_last_entry = 0;
>> +       efi_guid_t cc_guid = EFI_CC_MEASUREMENT_PROTOCOL_GUID;
>> +       efi_guid_t tpm2_guid = EFI_TCG2_PROTOCOL_GUID;
>> +       int version = EFI_TCG2_EVENT_LOG_FORMAT_TCG_2;
>> +       efi_tcg2_protocol_t *tpm2 = NULL;
>> +       efi_cc_protocol_t *cc = NULL;
>> +       efi_bool_t truncated;
>> +       efi_status_t status;
>> +
>> +       status = efi_bs_call(locate_protocol, &tpm2_guid, NULL, (void **)&tpm2);
>> +       if (status == EFI_SUCCESS) {
>> +               status = efi_call_proto(tpm2, get_event_log, version, &log_location,
>> +                                       &log_last_entry, &truncated);
>> +
>> +               if (status != EFI_SUCCESS || !log_location) {
>> +                       version = EFI_TCG2_EVENT_LOG_FORMAT_TCG_1_2;
>> +                       status = efi_call_proto(tpm2, get_event_log, version,
>> +                                               &log_location, &log_last_entry,
>> +                                               &truncated);
>> +                       if (status != EFI_SUCCESS || !log_location)
>> +                               return;
>> +               }
>> +
>> +               efi_retrieve_tcg2_eventlog(version, log_location, log_last_entry,
>> +                                          truncated);
>> +               return;
>> +       }
>> +
>> +       status = efi_bs_call(locate_protocol, &cc_guid, NULL, (void **)&cc);
>> +       if (status == EFI_SUCCESS) {
>> +               version = EFI_CC_EVENT_LOG_FORMAT_TCG_2;
>> +               status = efi_call_proto(cc, get_event_log, version, &log_location,
>> +                                       &log_last_entry, &truncated);
>> +               if (status != EFI_SUCCESS || !log_location)
>> +                       return;
>> +
>> +               efi_retrieve_tcg2_eventlog(version, log_location, log_last_entry,
>> +                                          truncated);
>> +               return;
>> +       }
>> +}
> [...]
>
> I haven't looked into CC measurements much, but do we always want to
> prioritize the tcg2 protocol? IOW if you have firmware that implements
> both, shouldn't we prefer the CC protocol for VMs?

According the UEFI specification, sec "Conidential computing", if a firmware implements
the TPM, then it should be used and CC interfaces should not be published. So I think
we should check for TPM first, if it does not exist then try for CC.

https://uefi.org/specs/UEFI/2.10/38_Confidential_Computing.html#confidential-computing

> Thanks
> /Ilias

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


