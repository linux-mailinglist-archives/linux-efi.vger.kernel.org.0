Return-Path: <linux-efi+bounces-4290-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03979B02245
	for <lists+linux-efi@lfdr.de>; Fri, 11 Jul 2025 19:01:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACAE63AF757
	for <lists+linux-efi@lfdr.de>; Fri, 11 Jul 2025 17:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F3012EA480;
	Fri, 11 Jul 2025 17:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g93MicH1"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765C36ADD;
	Fri, 11 Jul 2025 17:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752253311; cv=none; b=LeBPaH1TDuMjZdzmXWSISCIipgbSDT4W4vmvFVE97zrwPlRbb4mY7FGfKjCBY1FAVY5H0ZTld59k82Wj+pBb4gs39leNXb4vAKePViQOxzUrPxCrU8nOIGShc54Fl2RND9ifwxbLCbMj/PQVHn1JgnwyevUfb3ohk/3lwLrCiCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752253311; c=relaxed/simple;
	bh=ZNqBkfz7W9B7EkW8IQQ9OXJmAqMBrC1UL7oeF8rW/iU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t3WYmgOyqyypgOVv/pVEcUft3osj3WpPMk/nslqB2ZAaKjMnKH5pFC6jOhzWCOyxIh0Tus8FsCOAMMzYQy/BxFjLeNw0MKLF83u266TdrqA8FZtts3J9m8xxwK2rfQ0D3kLZv7MQWHOFP8fVwWds5ncLF+LOTPEfuoqi4zykey0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g93MicH1; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752253310; x=1783789310;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ZNqBkfz7W9B7EkW8IQQ9OXJmAqMBrC1UL7oeF8rW/iU=;
  b=g93MicH1NLWRLn4KS5wOihqB7N5DbEbu60ksD79P1D+gQcQ35maLfOFt
   E5dM83wKkzMvu+Jk/FxHadNNWUOmp8VU1I+uJi0f9ShW643R37b1Qzf6z
   Ffubtv7A8os/IpQtMo9B/2vkRUwkOsK09ZOeT1Ejo+f/QYsF2w+xmdtZH
   8E8l3TtbUPwdbaoGlyJ7TaFAPOYtP9KXMHELdr7YXLUtfOuxc/5afQS/B
   j+20YuHuw3z6upvLKvFUKAy7Odey+ZgG2rwytJTqCd0YxA/SlOM83S/ip
   gxIjVA9MPXhlvw/xcZAvCySfHDF5K6CBpBoqBrp70vg/d5ceRFtaRRp48
   Q==;
X-CSE-ConnectionGUID: CxQ3LHPMSsuKezOupG4krA==
X-CSE-MsgGUID: wpnWj2QiRqWHG46XzxYv5A==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="65620747"
X-IronPort-AV: E=Sophos;i="6.16,304,1744095600"; 
   d="scan'208";a="65620747"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 10:01:49 -0700
X-CSE-ConnectionGUID: mFBhU4KxQU63zqcPY/WY7g==
X-CSE-MsgGUID: 8d0fl0TzQkKiQieM22827A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,304,1744095600"; 
   d="scan'208";a="157132334"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 10:01:48 -0700
Received: from [10.124.222.102] (unknown [10.124.222.102])
	by linux.intel.com (Postfix) with ESMTP id 82F4B20B571C;
	Fri, 11 Jul 2025 10:01:47 -0700 (PDT)
Message-ID: <df4ccaf7-005d-4cbe-acef-20878421ce20@linux.intel.com>
Date: Fri, 11 Jul 2025 10:01:47 -0700
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4] efi/tpm: Fix the issue where the CC platforms event
 log header can't be correctly identified
To: James Bottomley <James.Bottomley@HansenPartnership.com>,
 yangge1116@126.com, ardb@kernel.org
Cc: jarkko@kernel.org, ilias.apalodimas@linaro.org, jgg@ziepe.ca,
 linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, liuzixing@hygon.cn
References: <1751961289-29673-1-git-send-email-yangge1116@126.com>
 <757cd21fb4eaebf0f89af1a5290c6f6665f66bae.camel@HansenPartnership.com>
Content-Language: en-US
From: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <757cd21fb4eaebf0f89af1a5290c6f6665f66bae.camel@HansenPartnership.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 7/11/25 7:00 AM, James Bottomley wrote:
> On Tue, 2025-07-08 at 15:54 +0800, yangge1116@126.com wrote:
>> From: Ge Yang <yangge1116@126.com>
>>
>> Since commit d228814b1913 ("efi/libstub: Add get_event_log() support
>> for CC platforms") reuses TPM2 support code for the CC platforms,
>> when launching a TDX virtual machine with coco measurement enabled,
>> the following error log is generated:
>>
>> [Firmware Bug]: Failed to parse event in TPM Final Events Log
>>
>> Call Trace:
>> efi_config_parse_tables()
>>    efi_tpm_eventlog_init()
>>      tpm2_calc_event_log_size()
>>        __calc_tpm2_event_size()
>>
>> The pcr_idx value in the Intel TDX log header is 1, causing the
>> function __calc_tpm2_event_size() to fail to recognize the log
>> header, ultimately leading to the "Failed to parse event in TPM Final
>> Events Log" error.
>>
>> According to UEFI Specification 2.10, Section 38.4.1: For TDX, TPM
>> PCR 0 maps to MRTD, so the log header uses TPM PCR 1 instead. To
>> successfully parse the TDX event log header, the check for a pcr_idx
>> value of 0 must be skipped.
>>
>> According to Table 6 in Section 10.2.1 of the TCG PC Client
>> Specification, the index field does not require the PCR index to be
>> fixed at zero. Therefore, skipping the check for a pcr_idx value of
>> 0 for CC platforms is safe.
> This is wrong: the spec does not allow a header EV_ACTION to be
> recorded with anything other than pcrIndex == 0.
>
> However, the fact that Intel, who practically wrote the TPM spec, can
> get this wrong shows that others can too.  So the best way to fix this
> is to remove the pcrIndex check for the first event.  There's no danger
> of this causing problems because we check for the TCG_SPECID_SIG
> signature as the next thing.  That means you don't need to thread
> knowledge of whether this is a CC environment and we're pre-emptively
> ready for any other spec violators who misread the spec in the same way
> Intel did.


I agree with James Bottomley's suggestion to remove the pcr_index check
without adding any replacement checks.

This check was originally introduced in the following commit to handle a
case where certain Dell platforms provided an event log without a valid
header:

commit 7dfc06a0f25b593a9f51992f540c0f80a57f3629
Author: Fabian Vogt <fvogt@suse.de>
Date:   Mon Jun 15 09:16:36 2020 +0200

     efi/tpm: Verify event log header before parsing

At first, I was concerned that the pcr_index check might still be important for
this fix. However, after re-reading the commit and reviewing the intent, it appears
that relying on the event_type and digest checks should be sufficient for validating
the event log header.




> Regards,
>
> James
>
-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


