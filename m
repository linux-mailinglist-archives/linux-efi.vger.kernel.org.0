Return-Path: <linux-efi+bounces-4111-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA4B0AF86C6
	for <lists+linux-efi@lfdr.de>; Fri,  4 Jul 2025 06:30:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 562D91C80C2C
	for <lists+linux-efi@lfdr.de>; Fri,  4 Jul 2025 04:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D42531F4615;
	Fri,  4 Jul 2025 04:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="KlM2w2to"
X-Original-To: linux-efi@vger.kernel.org
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.7])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 171371EA7E1;
	Fri,  4 Jul 2025 04:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751603131; cv=none; b=U02srrvMdCTdFqI/YMhf30kEeByK7rv6jFeKijB8D73AKltFEEdTVN51vo3zJ7fMXugBZXWdKB5mygjs/L0Y1Q5ihc0SoTazy4ckEfiCUR2CuhweBidbYKazFVlk13eBYce8jxFyRfQl9SNF6b3B34gRQk9I2Xx8N9h8GawkL1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751603131; c=relaxed/simple;
	bh=EYF/FkRzsl2YKOd+AwTZVqEQu4PSvWsyAspo89mRl8Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jm+qjHZDt33XEgy1TTbY5LsW8kFoDokmKUlmjepxdn4zGZJhgQENiKZohZt+SDL4+5ogYjXCROWmRL0y7zq7kyBXLFy3soCEGaVeMaJqBjXL6JOZpz16oVo+m5Gf8psuWjQptzBi01QzuW4JnNxF9KVkx5rNz9KFzER/3y5i+KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=KlM2w2to; arc=none smtp.client-ip=117.135.210.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=7e61fe3FoGKrVaATjtgyqXSK4fwuYFW0FX0uxu2ZGXE=;
	b=KlM2w2to7zpxdYaDkjPcPd5oq/6e+mCNJf1xEpPc458uDKuHlfwU8C7pFBSGRH
	RgCM9OeUgoGv4kvucvBPtd1mjhqkcL0lQTRXnjTkslWuzLc2SvX1U7TXgSXDyZNO
	fSlbB3+Gx1BBOirUxO+n+TZMzxot+M25GO+34h809D7P8=
Received: from [172.19.20.199] (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wD3F+RCQmdo4caXAw--.25499S2;
	Fri, 04 Jul 2025 10:53:55 +0800 (CST)
Message-ID: <2ab4ebba-1f97-4686-9186-5bcaa3549f54@126.com>
Date: Fri, 4 Jul 2025 10:53:54 +0800
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
 <aGczaEkhPuOqhRUv@kernel.org>
From: Ge Yang <yangge1116@126.com>
In-Reply-To: <aGczaEkhPuOqhRUv@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3F+RCQmdo4caXAw--.25499S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxArWDtw4rAw13tFWrJr48Xrb_yoW5Zr48pF
	s7GFnayrn8Jry29rySq3Wvkw1DAw4Fk39rJFykK3W0yr98Wr92qa1I93W5K3WfXrsrJayY
	qa4Utr1UAa4UuaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jbHUDUUUUU=
X-CM-SenderInfo: 51dqwwjhrrila6rslhhfrp/1tbiWAOAG2hnPz1UPwAAsm



在 2025/7/4 9:50, Jarkko Sakkinen 写道:
> On Thu, Jul 03, 2025 at 10:38:37AM +0800, yangge1116@126.com wrote:
>> From: Ge Yang <yangge1116@126.com>
>>
>> Since commit d228814b1913 ("efi/libstub: Add get_event_log() support
>> for CC platforms") reuses TPM2 support code for the CC platforms, when
>> launching a TDX virtual machine with coco measurement enabled, the
>> following error log is generated:
>>
>> [Firmware Bug]: Failed to parse event in TPM Final Events Log
>>
>> Call Trace:
>> efi_config_parse_tables()
>>    efi_tpm_eventlog_init()
>>      tpm2_calc_event_log_size()
>>        __calc_tpm2_event_size()
>>
>> The pcr_idx value in the Intel TDX log header is 1, causing the
>> function __calc_tpm2_event_size() to fail to recognize the log header,
>> ultimately leading to the "Failed to parse event in TPM Final Events
>> Log" error.
>>
>> According to UEFI Spec 2.10 Section 38.4.1: For Tdx, TPM PCR 0 maps to
>> MRTD, so the log header uses TPM PCR 1. To successfully parse the TDX
>> event log header, the check for a pcr_idx value of 0 has been removed
>> here, and it appears that this will not affect other functionalities.
> 
> I'm not familiar with the original change but with a quick check it did
> not change __calc_tpm2_event_size(). Your change is changing semantics
> to two types of callers:
> 
> 1. Those that caused the bug.
> 2. Those that nothing to do with this bug.
> 
> I'm not seeing anything explaining that your change is guaranteed not to
> have any consequences to "innocent" callers, which have no relation to
> the bug.
> 

Thank you for your response.

According to Section 10.2.1, Table 6 (TCG_PCClientPCREvent Structure) in 
the TCG PC Client Platform Firmware Profile Specification, determining 
whether an event is an event log header does not require checking the 
pcrIndex field. The identification can be made based on other fields 
alone. Therefore, removing the pcrIndex check here is considered safe
for "innocent" callers.

Reference Link: 
https://trustedcomputinggroup.org/wp-content/uploads/TCG_PCClient_PFP_r1p05_v23_pub.pdf
>>
>> Link: https://uefi.org/specs/UEFI/2.10/38_Confidential_Computing.html#intel-trust-domain-extension
>> Fixes: d228814b1913 ("efi/libstub: Add get_event_log() support for CC platforms")
>> Signed-off-by: Ge Yang <yangge1116@126.com>
>> Cc: stable@vger.kernel.org
>> ---
>>   include/linux/tpm_eventlog.h | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/include/linux/tpm_eventlog.h b/include/linux/tpm_eventlog.h
>> index 891368e..05c0ae5 100644
>> --- a/include/linux/tpm_eventlog.h
>> +++ b/include/linux/tpm_eventlog.h
>> @@ -202,8 +202,7 @@ static __always_inline u32 __calc_tpm2_event_size(struct tcg_pcr_event2_head *ev
>>   	event_type = event->event_type;
>>   
>>   	/* Verify that it's the log header */
>> -	if (event_header->pcr_idx != 0 ||
>> -	    event_header->event_type != NO_ACTION ||
>> +	if (event_header->event_type != NO_ACTION ||
>>   	    memcmp(event_header->digest, zero_digest, sizeof(zero_digest))) {
>>   		size = 0;
>>   		goto out;
>> -- 
>> 2.7.4
>>
> 
> BR, Jarkko


