Return-Path: <linux-efi+bounces-4128-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF2EAF9E90
	for <lists+linux-efi@lfdr.de>; Sat,  5 Jul 2025 09:01:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D3A73A3CD0
	for <lists+linux-efi@lfdr.de>; Sat,  5 Jul 2025 07:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 563381F9F73;
	Sat,  5 Jul 2025 07:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="SKoabF0n"
X-Original-To: linux-efi@vger.kernel.org
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.7])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 318C53595C;
	Sat,  5 Jul 2025 07:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751698858; cv=none; b=caEpUQNKC5ecLA3i3mEHfA45h78rNvF+lR9I362Blk4di5OPJabDEuoeY7XDGYchibn79NgVw7KncW1O5rwSjc7FvOd5ZUgoHRYbII5JWfSze64yiMGAKHIfUju6RQJMt2w0Sc+pwJZ+xBEdcvh6ZlrC4cbfHezku0nexc6vYGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751698858; c=relaxed/simple;
	bh=PWWcpf+dURddKjpM1tBure0dDt+PIogP/nHixs/ieQQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MGAiuzGf7bPWitD3G9UQe7gQ2JjEHO5u7wTC5da2TQchyUiUUrsQTHCSIadltIKUkSDoh8D3s+A9qzh1ZFcsT3g0WwQ48aL4LWxbyn1CLaKBpUdJS8veyB04tP+nyCZboz7taTZXXjkfXZjclgm0LxzkTK8GGCIeORxUbZ7IHag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=SKoabF0n; arc=none smtp.client-ip=117.135.210.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=OqH3rDDUH+qD8+vVitvFXmO9rUuq0owdh+qg1SBS9nA=;
	b=SKoabF0nzs4Rxj0/NIeKDKQqCyRr0GPcBHwsD7A7/SfCiDV1fb33qrrGJGXUor
	c+rp2EK4n9L9fCRNjx3nui/YDiAGkFYZiovOEb2JRjZBcMk2JXDJ+/QW38H6AWNn
	DJVxv2fQyhKsU7tmypJ0APN4ugmPP6Zq+1MvAklw1AysI=
Received: from [172.19.20.199] (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PykvCgDXv3VLzWhovNtMAA--.47878S2;
	Sat, 05 Jul 2025 14:59:23 +0800 (CST)
Message-ID: <17ce8192-6dea-465d-bedd-0333e83c9792@126.com>
Date: Sat, 5 Jul 2025 14:59:23 +0800
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] efi/tpm: Fix the issue where the CC platforms event log
 header can't be correctly identified
To: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Jarkko Sakkinen <jarkko@kernel.org>
Cc: ardb@kernel.org, ilias.apalodimas@linaro.org, jgg@ziepe.ca,
 linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, liuzixing@hygon.cn
References: <1751510317-12152-1-git-send-email-yangge1116@126.com>
 <aGczaEkhPuOqhRUv@kernel.org> <2ab4ebba-1f97-4686-9186-5bcaa3549f54@126.com>
 <fa6e6ac2-e451-4bcc-9888-d363c60e4bb4@linux.intel.com>
From: Ge Yang <yangge1116@126.com>
In-Reply-To: <fa6e6ac2-e451-4bcc-9888-d363c60e4bb4@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PykvCgDXv3VLzWhovNtMAA--.47878S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxKFyrAFW8WF47KF4DWw15Jwb_yoW7trW7pF
	Z7GF1Skrs5Jry29w1Fvw4UCF1jyws5JrZrWrykJw10yrn0qFn7tFy2kw15Kas3JrsrG34j
	qa45tr17Aa4jvaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jb8n5UUUUU=
X-CM-SenderInfo: 51dqwwjhrrila6rslhhfrp/1tbiOhSBG2hoxidxiQABss



在 2025/7/5 6:27, Sathyanarayanan Kuppuswamy 写道:
> 
> On 7/3/25 7:53 PM, Ge Yang wrote:
>>
>>
>> 在 2025/7/4 9:50, Jarkko Sakkinen 写道:
>>> On Thu, Jul 03, 2025 at 10:38:37AM +0800, yangge1116@126.com wrote:
>>>> From: Ge Yang <yangge1116@126.com>
>>>>
>>>> Since commit d228814b1913 ("efi/libstub: Add get_event_log() support
>>>> for CC platforms") reuses TPM2 support code for the CC platforms, when
>>>> launching a TDX virtual machine with coco measurement enabled, the
>>>> following error log is generated:
>>>>
>>>> [Firmware Bug]: Failed to parse event in TPM Final Events Log
>>>>
>>>> Call Trace:
>>>> efi_config_parse_tables()
>>>>    efi_tpm_eventlog_init()
>>>>      tpm2_calc_event_log_size()
>>>>        __calc_tpm2_event_size()
>>>>
>>>> The pcr_idx value in the Intel TDX log header is 1, causing the
>>>> function __calc_tpm2_event_size() to fail to recognize the log header,
>>>> ultimately leading to the "Failed to parse event in TPM Final Events
>>>> Log" error.
>>>>
>>>> According to UEFI Spec 2.10 Section 38.4.1: For Tdx, TPM PCR 0 maps to
>>>> MRTD, so the log header uses TPM PCR 1. To successfully parse the TDX
>>>> event log header, the check for a pcr_idx value of 0 has been removed
>>>> here, and it appears that this will not affect other functionalities.
>>>
>>> I'm not familiar with the original change but with a quick check it did
>>> not change __calc_tpm2_event_size(). Your change is changing semantics
>>> to two types of callers:
>>>
>>> 1. Those that caused the bug.
>>> 2. Those that nothing to do with this bug.
>>>
>>> I'm not seeing anything explaining that your change is guaranteed not to
>>> have any consequences to "innocent" callers, which have no relation to
>>> the bug.
>>>
>>
>> Thank you for your response.
>>
>> According to Section 10.2.1, Table 6 (TCG_PCClientPCREvent Structure) 
>> in the TCG PC Client Platform Firmware Profile Specification, 
>> determining whether an event is an event log header does not require 
>> checking the pcrIndex field. The identification can be made based on 
>> other fields alone. Therefore, removing the pcrIndex check here is 
>> considered safe
>> for "innocent" callers.
>>
>> Reference Link: https://trustedcomputinggroup.org/wp-content/uploads/ 
>> TCG_PCClient_PFP_r1p05_v23_pub.pdf
> 
> 
> It looks like this check was originally added to handle a case which 
> does not align with the TCG spec. So
> removing it directly may have some impact to these older platform. Can 
> we make this conditional to
> CC platform?

Ok, thanks.

I originally intended to add a 
cc_platform_has(CC_ATTR_GUEST_STATE_ENCRYPT) check inside the 
__calc_tpm2_event_size() function to limit the fix to Confidential 
Computing (CC) platforms only. However, this function is also used 
during the EFI stub phase, where the cc_platform_has() function is not 
defined.

Call Trace:
efi_pe_entry()
   efi_stub_entry()
     efi_retrieve_eventlog()
       efi_retrieve_tcg2_eventlog()
         __calc_tpm2_event_size()

Therefore, I plan to modify __calc_tpm2_event_size() to accept an 
additional parameter indicating whether the event originates from a CC 
platform.

> 
> commit 7dfc06a0f25b593a9f51992f540c0f80a57f3629
> Author: Fabian Vogt <fvogt@suse.de>
> Date:   Mon Jun 15 09:16:36 2020 +0200
> 
>      efi/tpm: Verify event log header before parsing
> 
>      It is possible that the first event in the event log is not actually a
>      log header at all, but rather a normal event. This leads to the 
> cast in
>      __calc_tpm2_event_size being an invalid conversion, which means that
>      the values read are effectively garbage. Depending on the first 
> event's
>      contents, this leads either to apparently normal behaviour, a crash or
>      a freeze.
> 
>      While this behaviour of the firmware is not in accordance with the
>      TCG Client EFI Specification, this happens on a Dell Precision 5510
>      with the TPM enabled but hidden from the OS ("TPM On" disabled, state
>      otherwise untouched). The EFI firmware claims that the TPM is present
>      and active and that it supports the TCG 2.0 event log format.
> 
>      Fortunately, this can be worked around by simply checking the header
>      of the first event and the event log header signature itself.
> 
>      Commit b4f1874c6216 ("tpm: check event log version before reading 
> final
>      events") addressed a similar issue also found on Dell models.
> 
>      Fixes: 6b0326190205 ("efi: Attempt to get the TCG2 event log in the 
> boot stub")
>      Signed-off-by: Fabian Vogt <fvogt@suse.de>
>      Link: https://lore.kernel.org/r/1927248.evlx2EsYKh@linux-e202.suse.de
>      Bugzilla: https://bugzilla.suse.com/show_bug.cgi?id=1165773
>      Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> 
> 
>>>>
>>>> Link: https://uefi.org/specs/ 
>>>> UEFI/2.10/38_Confidential_Computing.html#intel-trust-domain-extension
>>>> Fixes: d228814b1913 ("efi/libstub: Add get_event_log() support for 
>>>> CC platforms")
>>>> Signed-off-by: Ge Yang <yangge1116@126.com>
>>>> Cc: stable@vger.kernel.org
>>>> ---
>>>>   include/linux/tpm_eventlog.h | 3 +--
>>>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>>>
>>>> diff --git a/include/linux/tpm_eventlog.h b/include/linux/ 
>>>> tpm_eventlog.h
>>>> index 891368e..05c0ae5 100644
>>>> --- a/include/linux/tpm_eventlog.h
>>>> +++ b/include/linux/tpm_eventlog.h
>>>> @@ -202,8 +202,7 @@ static __always_inline u32 
>>>> __calc_tpm2_event_size(struct tcg_pcr_event2_head *ev
>>>>       event_type = event->event_type;
>>>>         /* Verify that it's the log header */
>>>> -    if (event_header->pcr_idx != 0 ||
>>>> -        event_header->event_type != NO_ACTION ||
>>>> +    if (event_header->event_type != NO_ACTION ||
>>>>           memcmp(event_header->digest, zero_digest, 
>>>> sizeof(zero_digest))) {
>>>>           size = 0;
>>>>           goto out;
>>>> -- 
>>>> 2.7.4
>>>>
>>>
>>> BR, Jarkko
>>


