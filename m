Return-Path: <linux-efi+bounces-4281-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D7D3B010C5
	for <lists+linux-efi@lfdr.de>; Fri, 11 Jul 2025 03:24:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38DA41AA80BF
	for <lists+linux-efi@lfdr.de>; Fri, 11 Jul 2025 01:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07CD37082D;
	Fri, 11 Jul 2025 01:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="SSzGpQPq"
X-Original-To: linux-efi@vger.kernel.org
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.6])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E8D3173;
	Fri, 11 Jul 2025 01:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752197087; cv=none; b=sMb9LwzJFoNH68iH2c41ImUdFgf8JMeuuFIFNLY9Y7qsuTtOHBWO2NAK4BYsH3QOFnr9lmNW2WAFJE4AzygQKAbIONLiexdgvIhUsBuq/japUXET9PPZn4AKroHkvpJ+8lZniqoCV1jSETnOnz6GF6fw4fr3s6FslQSDt8+zQ+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752197087; c=relaxed/simple;
	bh=3ZMNlFalkkuUHsd9SBK2uZHzyIlO8TrocAFm0EYy13k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hkpi3DSHv/ChvgL1aXgdR/o57OmTr95josZCSVDvCFK8/lFKELXKdlP1lyMS7KGgR40+leaZlAZBW8hc9Yutgdv5sX1QhDO7yvmRPAr3H09VThmur3SPGOhMiG+YX1esryQxZF6EATvuz+/DhDVuM7z8KVt+ii3YvJwm0OnPQxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=SSzGpQPq; arc=none smtp.client-ip=117.135.210.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=15RKKkH+/2iUNAMJx640lee+ElhFwKK7j4mMwT0+tOM=;
	b=SSzGpQPq+IWOabPPt2JpRX8MMH2HuXmUJZ7hp3iQbEp4v3FR8he+fmgiqm8/D8
	qpMTKoBfacqLqIUp3tVLZ+kKjygdSMshcfgI4PJUk105nscL44GNUHWXWrrXgzJS
	t/6acKFhad4hzlmDynj0Gb1ZylvD5vlNjPoq4R38JWQ1U=
Received: from [172.19.20.199] (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wD3lyisZ3BoJad1AA--.35076S2;
	Fri, 11 Jul 2025 09:23:57 +0800 (CST)
Message-ID: <ec847802-5189-461a-a372-f81839938579@126.com>
Date: Fri, 11 Jul 2025 09:23:56 +0800
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3] efi/tpm: Fix the issue where the CC platforms event
 log header can't be correctly identified
To: James Bottomley <James.Bottomley@HansenPartnership.com>, ardb@kernel.org
Cc: jarkko@kernel.org, sathyanarayanan.kuppuswamy@linux.intel.com,
 ilias.apalodimas@linaro.org, jgg@ziepe.ca, linux-efi@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, liuzixing@hygon.cn
References: <1751858087-10366-1-git-send-email-yangge1116@126.com>
 <0925430dad9e55179be0df89d8af1df72dfa0c89.camel@HansenPartnership.com>
From: Ge Yang <yangge1116@126.com>
In-Reply-To: <0925430dad9e55179be0df89d8af1df72dfa0c89.camel@HansenPartnership.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3lyisZ3BoJad1AA--.35076S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxAF4rury7try7Wr1rGF4fuFg_yoW5WrWxpw
	43KF1ay34DJr12vwnIv3WUuws8urWFyayDXryktw10yrZ0vF92gay0k345Ja93CryDWF18
	Xw1jqF13CayvkaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jbdbbUUUUU=
X-CM-SenderInfo: 51dqwwjhrrila6rslhhfrp/1tbiWB+HG2hwYzRqsQAAsP



在 2025/7/11 5:58, James Bottomley 写道:
> On Mon, 2025-07-07 at 11:14 +0800, yangge1116@126.com wrote:
>> The pcr_idx value in the Intel TDX log header is 1, causing the
>> function __calc_tpm2_event_size() to fail to recognize the log
>> header, ultimately leading to the "Failed to parse event in TPM Final
>> Events Log" error.
>>
>> According to UEFI Specification 2.10, Section 38.4.1: For TDX, TPM
>> PCR 0 maps to MRTD, so the log header uses TPM PCR 1 instead. To
>> successfully parse the TDX event log header, the check for a pcr_idx
>> value of 0 must be skipped.
> 
> I think someone has misread the spec.  EV_NO_ACTION events produce no
> PCR extension.  So the PCR value zero is conventional (and required by
> the TCG) since nothing gets logged.  Therefore even if you're
> technically using PCR0 for something else EV_NO_ACTION events should
> still have the conventional PCR = 0 value to conform to the TCG spec.
> I assume it's too late to correct this in the implementation?
> 

According to Table 14 in Section 10.4.1 of the TCG PC Client 
Specification, for EV_NO_ACTION events, the PCR (Platform Configuration 
Register) value can be 0 or other values, such as 6.

Link: 
https://trustedcomputinggroup.org/wp-content/uploads/TCG_PCClient_PFP_r1p05_v23_pub.pdf

>>   __calc_tpm2_event_size(struct tcg_pcr_event2_head *ev
>>   	count = event->count;
>>   	event_type = event->event_type;
>>   
>> -	/* Verify that it's the log header */
>> -	if (event_header->pcr_idx != 0 ||
>> +	/*
>> +	 * Verify that it's the log header. According to the TCG PC
>> Client
>> +	 * Specification, when identifying a log header, the check
>> for a
>> +	 * pcr_idx value of 0 is not required. For CC platforms,
>> skipping
>> +	 * this check during log header is necessary; otherwise, the
>> CC
>> +	 * platform's log header may fail to be recognized.
>> +	 */
>> +	if ((!is_cc_event && event_header->pcr_idx != 0) ||
>>   	    event_header->event_type != NO_ACTION ||
>>   	    memcmp(event_header->digest, zero_digest,
>> sizeof(zero_digest))) {
>>   		size = 0;
> 
> The above is just a heuristic to recognize an EV_NO_ACTION event as
> zero size.  All the TCG specs require that EV_NO_ACTION have pcr 0 in
> the event, but if the heuristic is wrong because of Intel/CC spec
> violations which can't be fixed, then we should update the heuristic
> ... so I don't think you need to thread the is_cc_event.

It seems that the TCG specifications do not stipulate that the 
EV_NO_ACTION event must have PCR 0. In addition, adding is_cc_event can 
maximize the reuse of TPM code for CC platforms without disrupting TPM 
functionality; otherwise, new functions would need to be added for CC 
platforms.

Please review the latest patch. Patch link: 
https://lore.kernel.org/lkml/1751961289-29673-1-git-send-email-yangge1116@126.com/

> 
> Regards,
> 
> James


