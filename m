Return-Path: <linux-efi+bounces-4126-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 322A9AF9C48
	for <lists+linux-efi@lfdr.de>; Sat,  5 Jul 2025 00:27:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B0FC1C47925
	for <lists+linux-efi@lfdr.de>; Fri,  4 Jul 2025 22:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FD6528C5AD;
	Fri,  4 Jul 2025 22:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bPgITsE4"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35FEC1547C9;
	Fri,  4 Jul 2025 22:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751668043; cv=none; b=V34ttn+oQOzd0H/JiTlUFDhvfP9zz84Z+OhjAQB0EafzM9ig3X4z34idsYlvLA/qAnJJLVzVkx4B+OPLrsESUExl7duRBShc5vFVHwzo7Ul8/LxODjg1XueDoUuX32pGcAQ2ujgTkN+kcF4Q0RVz+XNL6tV4Bot49nM+nUpCFig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751668043; c=relaxed/simple;
	bh=6pN8QsPthkTJefuOZUVxexb9Ul0bnI3TXHScLqcuGz8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nYoXkQUQXT2ReQqgwVgsVo8++4BX9B3WtcNvFsLFdGuYNHBWrj0vZokMGp3B4Suz30xa7NvT4fpTjTn6h6JvtQRg9/zBesiLbA+9gWSWKw9KzLOlTwErY2IdTsnTOGNLaCUuMQgIGgkQ7FX8H3xhIhGHJ8J0irtdwNekQ093HmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bPgITsE4; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751668041; x=1783204041;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6pN8QsPthkTJefuOZUVxexb9Ul0bnI3TXHScLqcuGz8=;
  b=bPgITsE4syU1EsaFs6nr6jQATgbbRcNVkwEGFd4Q6tIdxp8VDgeH8TTN
   VMO4DnTWAnP8S1fiskwP7TN96q2WS/hfgu38MwVTJKl2OJhAVesil9MR5
   LknFGtNPMmYtdFiPHc//hz5M/seOzZ0D7b+GIrvx60Dv9tlUaieFYaXf7
   AYpTtV/CzhThw5V+WFe7pD84Z1UdtgCcAIgpKt45TDEHJ8lip8npQ5ciJ
   U1512khabYHMx8bJPA7J6tO5lJIuvbzEhrIhMIebz8riWO8F6Hj6K+n8/
   3RcALMJaCI+/7SUzUCdTbeMGBgEirg3Vcpyz7yxbVwJLsXttJJdct49kT
   A==;
X-CSE-ConnectionGUID: AYrGqd/eQA2iASXWLStLvQ==
X-CSE-MsgGUID: B3ky5kLfRa+Lv2eTh+LGUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11484"; a="53125295"
X-IronPort-AV: E=Sophos;i="6.16,288,1744095600"; 
   d="scan'208";a="53125295"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2025 15:27:20 -0700
X-CSE-ConnectionGUID: cwhj1lZtTn61lkfkrqG6ww==
X-CSE-MsgGUID: PwhlZnptS7mlQaTmlWi0ZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,288,1744095600"; 
   d="scan'208";a="154363921"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2025 15:27:20 -0700
Received: from [10.124.223.245] (unknown [10.124.223.245])
	by linux.intel.com (Postfix) with ESMTP id 7046420B571C;
	Fri,  4 Jul 2025 15:27:19 -0700 (PDT)
Message-ID: <fa6e6ac2-e451-4bcc-9888-d363c60e4bb4@linux.intel.com>
Date: Fri, 4 Jul 2025 15:27:18 -0700
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] efi/tpm: Fix the issue where the CC platforms event log
 header can't be correctly identified
To: Ge Yang <yangge1116@126.com>, Jarkko Sakkinen <jarkko@kernel.org>
Cc: ardb@kernel.org, ilias.apalodimas@linaro.org, jgg@ziepe.ca,
 linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, liuzixing@hygon.cn
References: <1751510317-12152-1-git-send-email-yangge1116@126.com>
 <aGczaEkhPuOqhRUv@kernel.org> <2ab4ebba-1f97-4686-9186-5bcaa3549f54@126.com>
Content-Language: en-US
From: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <2ab4ebba-1f97-4686-9186-5bcaa3549f54@126.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 7/3/25 7:53 PM, Ge Yang wrote:
>
>
> 在 2025/7/4 9:50, Jarkko Sakkinen 写道:
>> On Thu, Jul 03, 2025 at 10:38:37AM +0800, yangge1116@126.com wrote:
>>> From: Ge Yang <yangge1116@126.com>
>>>
>>> Since commit d228814b1913 ("efi/libstub: Add get_event_log() support
>>> for CC platforms") reuses TPM2 support code for the CC platforms, when
>>> launching a TDX virtual machine with coco measurement enabled, the
>>> following error log is generated:
>>>
>>> [Firmware Bug]: Failed to parse event in TPM Final Events Log
>>>
>>> Call Trace:
>>> efi_config_parse_tables()
>>>    efi_tpm_eventlog_init()
>>>      tpm2_calc_event_log_size()
>>>        __calc_tpm2_event_size()
>>>
>>> The pcr_idx value in the Intel TDX log header is 1, causing the
>>> function __calc_tpm2_event_size() to fail to recognize the log header,
>>> ultimately leading to the "Failed to parse event in TPM Final Events
>>> Log" error.
>>>
>>> According to UEFI Spec 2.10 Section 38.4.1: For Tdx, TPM PCR 0 maps to
>>> MRTD, so the log header uses TPM PCR 1. To successfully parse the TDX
>>> event log header, the check for a pcr_idx value of 0 has been removed
>>> here, and it appears that this will not affect other functionalities.
>>
>> I'm not familiar with the original change but with a quick check it did
>> not change __calc_tpm2_event_size(). Your change is changing semantics
>> to two types of callers:
>>
>> 1. Those that caused the bug.
>> 2. Those that nothing to do with this bug.
>>
>> I'm not seeing anything explaining that your change is guaranteed not to
>> have any consequences to "innocent" callers, which have no relation to
>> the bug.
>>
>
> Thank you for your response.
>
> According to Section 10.2.1, Table 6 (TCG_PCClientPCREvent Structure) in the TCG PC Client Platform Firmware Profile Specification, determining whether an event is an event log header does not require checking the pcrIndex field. The identification can be made based on other fields alone. Therefore, removing the pcrIndex check here is considered safe
> for "innocent" callers.
>
> Reference Link: https://trustedcomputinggroup.org/wp-content/uploads/TCG_PCClient_PFP_r1p05_v23_pub.pdf


It looks like this check was originally added to handle a case which does not align with the TCG spec. So
removing it directly may have some impact to these older platform. Can we make this conditional to
CC platform?

commit 7dfc06a0f25b593a9f51992f540c0f80a57f3629
Author: Fabian Vogt <fvogt@suse.de>
Date:   Mon Jun 15 09:16:36 2020 +0200

     efi/tpm: Verify event log header before parsing

     It is possible that the first event in the event log is not actually a
     log header at all, but rather a normal event. This leads to the cast in
     __calc_tpm2_event_size being an invalid conversion, which means that
     the values read are effectively garbage. Depending on the first event's
     contents, this leads either to apparently normal behaviour, a crash or
     a freeze.

     While this behaviour of the firmware is not in accordance with the
     TCG Client EFI Specification, this happens on a Dell Precision 5510
     with the TPM enabled but hidden from the OS ("TPM On" disabled, state
     otherwise untouched). The EFI firmware claims that the TPM is present
     and active and that it supports the TCG 2.0 event log format.

     Fortunately, this can be worked around by simply checking the header
     of the first event and the event log header signature itself.

     Commit b4f1874c6216 ("tpm: check event log version before reading final
     events") addressed a similar issue also found on Dell models.

     Fixes: 6b0326190205 ("efi: Attempt to get the TCG2 event log in the boot stub")
     Signed-off-by: Fabian Vogt <fvogt@suse.de>
     Link: https://lore.kernel.org/r/1927248.evlx2EsYKh@linux-e202.suse.de
     Bugzilla: https://bugzilla.suse.com/show_bug.cgi?id=1165773
     Signed-off-by: Ard Biesheuvel <ardb@kernel.org>


>>>
>>> Link: https://uefi.org/specs/UEFI/2.10/38_Confidential_Computing.html#intel-trust-domain-extension
>>> Fixes: d228814b1913 ("efi/libstub: Add get_event_log() support for CC platforms")
>>> Signed-off-by: Ge Yang <yangge1116@126.com>
>>> Cc: stable@vger.kernel.org
>>> ---
>>>   include/linux/tpm_eventlog.h | 3 +--
>>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>>
>>> diff --git a/include/linux/tpm_eventlog.h b/include/linux/tpm_eventlog.h
>>> index 891368e..05c0ae5 100644
>>> --- a/include/linux/tpm_eventlog.h
>>> +++ b/include/linux/tpm_eventlog.h
>>> @@ -202,8 +202,7 @@ static __always_inline u32 __calc_tpm2_event_size(struct tcg_pcr_event2_head *ev
>>>       event_type = event->event_type;
>>>         /* Verify that it's the log header */
>>> -    if (event_header->pcr_idx != 0 ||
>>> -        event_header->event_type != NO_ACTION ||
>>> +    if (event_header->event_type != NO_ACTION ||
>>>           memcmp(event_header->digest, zero_digest, sizeof(zero_digest))) {
>>>           size = 0;
>>>           goto out;
>>> -- 
>>> 2.7.4
>>>
>>
>> BR, Jarkko
>
-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


