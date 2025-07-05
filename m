Return-Path: <linux-efi+bounces-4127-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B707AF9E85
	for <lists+linux-efi@lfdr.de>; Sat,  5 Jul 2025 08:59:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C968E565593
	for <lists+linux-efi@lfdr.de>; Sat,  5 Jul 2025 06:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8594F20B218;
	Sat,  5 Jul 2025 06:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="NNImsWkx"
X-Original-To: linux-efi@vger.kernel.org
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6E5320330;
	Sat,  5 Jul 2025 06:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751698744; cv=none; b=jQwaQip1Pct8lkjJzLQM0XAPk1fT0ILzJO+fZQTkan9IWvMhmp5WOnKatEwXcsu0ZHNyyw2FDM/8u3HzydFHlpF+DhUApMDt1eObDjVJStJtbT97yu2wXuWpckkxBu48R7dKuuFjc4vvEi5JbMD9mbcNyYsTqgIaZgxC+WSSs7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751698744; c=relaxed/simple;
	bh=/vI/pctqiLTX0hFAMIl1Ve6WG/lz+qFH6FCsLv3psFo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZER8OvMeABaTVezBYCOoXzIJNKUUtIHcaqV6M6KUPjcf7ziz2z1oEPBzzvtQ+6OyEvp/odtSgoIEeJ2z3p7O3WV0f1ZxeLQHVdwQgbQ1zfWXVPfHC3pD4BEoY+4apgmZNrVnWuiLYiHu6O2+qxE42uez6vg+V2vrqdVWR5D/cBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=NNImsWkx; arc=none smtp.client-ip=117.135.210.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=i9PdUsrSzxDvnGGck2LHjgNlbpovBPa7pmcE0HgHa3k=;
	b=NNImsWkxBNXWemhn6DxDPD3UDQQR/oNQM0tqzF6bDmBktscq7LsM9R2vQBmHfn
	060pGgukkqp355Na9dIKeYAx1/t2/XP9u3RPxDtgHsCg4AUvyeG6YZRr3SdD82cR
	iSCJj3dt1Kg942GSFfOTb3vWzGXEb6FlwNYFqsuYqK/TA=
Received: from [172.19.20.199] (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wD3D7sQzWhoEk+KAw--.56536S2;
	Sat, 05 Jul 2025 14:58:25 +0800 (CST)
Message-ID: <102fa362-35c9-46d2-853c-472a5c4cd5d9@126.com>
Date: Sat, 5 Jul 2025 14:58:24 +0800
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] efi/tpm: Fix the issue where the CC platforms event log
 header can't be correctly identified
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: ardb@kernel.org, sathyanarayanan.kuppuswamy@linux.intel.com,
 ilias.apalodimas@linaro.org, jgg@ziepe.ca, linux-efi@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, liuzixing@hygon.cn
References: <1751510317-12152-1-git-send-email-yangge1116@126.com>
 <aGczaEkhPuOqhRUv@kernel.org> <2ab4ebba-1f97-4686-9186-5bcaa3549f54@126.com>
 <aGfvr2pBau6z9GLC@kernel.org>
From: Ge Yang <yangge1116@126.com>
In-Reply-To: <aGfvr2pBau6z9GLC@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3D7sQzWhoEk+KAw--.56536S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxArWDKrWrCr18uw48Wr1rZwb_yoWrJw47pF
	1Ika1ftrs8Jw1S9wn2vw48Ca1jyws3AFZrXFykG340yrs0gr1xtF42k3Wjkas3Xr47W3ZY
	qa4jqry3Aa4DuaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jbHUDUUUUU=
X-CM-SenderInfo: 51dqwwjhrrila6rslhhfrp/1tbiOhSBG2hoxidxiQAAst



在 2025/7/4 23:13, Jarkko Sakkinen 写道:
> On Fri, Jul 04, 2025 at 10:53:54AM +0800, Ge Yang wrote:
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
>>>>     efi_tpm_eventlog_init()
>>>>       tpm2_calc_event_log_size()
>>>>         __calc_tpm2_event_size()
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
>> According to Section 10.2.1, Table 6 (TCG_PCClientPCREvent Structure) in the
>> TCG PC Client Platform Firmware Profile Specification, determining whether
>> an event is an event log header does not require checking the pcrIndex
>> field. The identification can be made based on other fields alone.
>> Therefore, removing the pcrIndex check here is considered safe
>> for "innocent" callers.
> 
> Thanks for digging that out. Can you add something to the commit
> message? That spec is common knowledge if you are "into the topic"
> in the first palace so something along the lines of this would be
> perfectly fine:
> 
> "The check can be safely removed, as ccording to table 6 at section
> 10.2.1 of TCG PC client specification the index field does not require
> fixing the PCR index to zero."
> 
Ok, thanks.

> But then: we still have that constraint there and we cannot predict the
> side-effects of removing a constraint, even if it is incorrectly defined
> constraint. For comparison, it's much less risky situation when adding
> additional constraints, as possible side-effects in the worst case
> scenarios can be even theoretically much lighter than in the opposite
> situation.
> 
> For this reasons it would be perhaps better to limit the fix for the
> CC only, and not change the semantics across the board.
> 
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


> BR, Jarkko


