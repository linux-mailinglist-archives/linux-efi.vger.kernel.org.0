Return-Path: <linux-efi+bounces-4293-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A25B028F7
	for <lists+linux-efi@lfdr.de>; Sat, 12 Jul 2025 04:26:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CCBC3A5AE9
	for <lists+linux-efi@lfdr.de>; Sat, 12 Jul 2025 02:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B73C176ADE;
	Sat, 12 Jul 2025 02:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="B+WmxjOa"
X-Original-To: linux-efi@vger.kernel.org
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.6])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73C0E13A3F7;
	Sat, 12 Jul 2025 02:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752287191; cv=none; b=INr+ZA5gTFuO7DQ+MDEcry54IfkqQen6/b5z2PGNuZiNjQWOzmosLm1fXL/oIIxRpc5cak7c74VDRLjiN+k3+2X67sF9WP8P3PaTKKJ+deeLN3h98E+8NH3c2NW+l/vyUJfVd8iv49FsE0sM3oK6Miki3Q+4TG2HALEYfXNUUTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752287191; c=relaxed/simple;
	bh=7iV8CCsAIC/s1vnMxsCKKzncROQ/ca9bHARuKb1XwvY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W5NC8b/3Zb498c9TpWITzFKisLzjy0EtQhCyoxN+tIdUurEIrUu5kMk8cZen1UjnIA6s71xaW01W9X71seu86ZY9/Iw6WuXGii6cU8C2uZKNiVjT+5jHjy04PLOM/Lp6wMJVC05E7c0o26552JknV6/BQb5QJIbz3xAkmS//SKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=B+WmxjOa; arc=none smtp.client-ip=117.135.210.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=L7ha/pLISZdmDAMWnB/kNNjY6qrcIPRfa0Z8sVzjRiQ=;
	b=B+WmxjOaxiiw8Ksx6NXuVnjFOmZUo6gpdnDwsB+VHlYv+Dj5Ps5js9EatqcyDR
	fzAoxDjEBajXmoTzxsMO96yawSjU4WAmiQdCbKhb9Jv3xX7+TBhhJPs2GTfXzHdN
	i6Xe/mCO9IhF4Pmw8sAx/wKg52wbevoIWkSamlPcRVxdU=
Received: from [172.19.20.199] (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCkvCgC3v_9xx3Fotc+SAA--.29575S2;
	Sat, 12 Jul 2025 10:24:49 +0800 (CST)
Message-ID: <9b67baf0-79ee-4156-bb64-1b8ccf073ae9@126.com>
Date: Sat, 12 Jul 2025 10:24:49 +0800
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4] efi/tpm: Fix the issue where the CC platforms event
 log header can't be correctly identified
To: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>,
 James Bottomley <James.Bottomley@HansenPartnership.com>, ardb@kernel.org
Cc: jarkko@kernel.org, ilias.apalodimas@linaro.org, jgg@ziepe.ca,
 linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, liuzixing@hygon.cn
References: <1751961289-29673-1-git-send-email-yangge1116@126.com>
 <757cd21fb4eaebf0f89af1a5290c6f6665f66bae.camel@HansenPartnership.com>
 <df4ccaf7-005d-4cbe-acef-20878421ce20@linux.intel.com>
From: Ge Yang <yangge1116@126.com>
In-Reply-To: <df4ccaf7-005d-4cbe-acef-20878421ce20@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCkvCgC3v_9xx3Fotc+SAA--.29575S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGFW3uw43ZrWrKw1xCr4xCrg_yoW5ArykpF
	Z7K3WYy3s5GFyIvrnaq3WUu3Wjyw4rAa98XF95J3W0yr909F1vqFW2k3W5GasxWFs7ua4Y
	vFWjqr17Aas8ZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jbdbbUUUUU=
X-CM-SenderInfo: 51dqwwjhrrila6rslhhfrp/1tbiWByHG2hw-41n0wADsF



在 2025/7/12 1:01, Sathyanarayanan Kuppuswamy 写道:
> 
> On 7/11/25 7:00 AM, James Bottomley wrote:
>> On Tue, 2025-07-08 at 15:54 +0800, yangge1116@126.com wrote:
>>> From: Ge Yang <yangge1116@126.com>
>>>
>>> Since commit d228814b1913 ("efi/libstub: Add get_event_log() support
>>> for CC platforms") reuses TPM2 support code for the CC platforms,
>>> when launching a TDX virtual machine with coco measurement enabled,
>>> the following error log is generated:
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
>>> function __calc_tpm2_event_size() to fail to recognize the log
>>> header, ultimately leading to the "Failed to parse event in TPM Final
>>> Events Log" error.
>>>
>>> According to UEFI Specification 2.10, Section 38.4.1: For TDX, TPM
>>> PCR 0 maps to MRTD, so the log header uses TPM PCR 1 instead. To
>>> successfully parse the TDX event log header, the check for a pcr_idx
>>> value of 0 must be skipped.
>>>
>>> According to Table 6 in Section 10.2.1 of the TCG PC Client
>>> Specification, the index field does not require the PCR index to be
>>> fixed at zero. Therefore, skipping the check for a pcr_idx value of
>>> 0 for CC platforms is safe.
>> This is wrong: the spec does not allow a header EV_ACTION to be
>> recorded with anything other than pcrIndex == 0.
>>
>> However, the fact that Intel, who practically wrote the TPM spec, can
>> get this wrong shows that others can too.  So the best way to fix this
>> is to remove the pcrIndex check for the first event.  There's no danger
>> of this causing problems because we check for the TCG_SPECID_SIG
>> signature as the next thing.  That means you don't need to thread
>> knowledge of whether this is a CC environment and we're pre-emptively
>> ready for any other spec violators who misread the spec in the same way
>> Intel did.
> 
> 
> I agree with James Bottomley's suggestion to remove the pcr_index check
> without adding any replacement checks.
> 
> This check was originally introduced in the following commit to handle a
> case where certain Dell platforms provided an event log without a valid
> header:
> 
> commit 7dfc06a0f25b593a9f51992f540c0f80a57f3629
> Author: Fabian Vogt <fvogt@suse.de>
> Date:   Mon Jun 15 09:16:36 2020 +0200
> 
>      efi/tpm: Verify event log header before parsing
> 
> At first, I was concerned that the pcr_index check might still be 
> important for
> this fix. However, after re-reading the commit and reviewing the intent, 
> it appears
> that relying on the event_type and digest checks should be sufficient 
> for validating
> the event log header.
> 
> 
> 

Thanks to the suggestions from Bottomley and Sathyanarayanan. Now, I'll 
submit another version of the patch.

> 
>> Regards,
>>
>> James
>>


