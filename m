Return-Path: <linux-efi+bounces-5002-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EAF74BC2EDC
	for <lists+linux-efi@lfdr.de>; Wed, 08 Oct 2025 01:18:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3255934ED84
	for <lists+linux-efi@lfdr.de>; Tue,  7 Oct 2025 23:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 652D924676C;
	Tue,  7 Oct 2025 23:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="NmRJUwFg"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3362248A8;
	Tue,  7 Oct 2025 23:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759879093; cv=none; b=I+r1+TOictUtOjHjXuX5znTgMcyAVPHOauuvIp/DQWIwRcd5qQlYdZjzrh5pGPtR7QEo4emaj6lhKFD/V77+ouXeQ0M+YplCJB3vwgacqa6K3pcvs5aIFq5DVgt5Ejubzb1rticyD0pAFaEdAdoVadGfXnoZBKYqs1cuc3E44NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759879093; c=relaxed/simple;
	bh=FNKrAQi+CF3JUS4Dl/woGlMkHYthP3x7O+7ykeSB7RU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BlAjaTELZj3WsUDen7aAIPYdaQ8Fdig7UtWJbEDJCZji5iY7csYyK6xcS4e61HuRHWipSiNB/GkMypgfzro9iGHEgQ8ehJPyHW5TrrMAmxkvpGjIDBOgoFlIHJr7W1G+nTB8CfdBGu14CP2W6ucRxiis7BEldI8fRhtYEOonpVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=NmRJUwFg; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [IPV6:2409:8a62:2512:6930:dca7:dbd1:1e0:8a84] ([IPv6:2409:8a62:2512:6930:dca7:dbd1:1e0:8a84])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 597NGpAb2097764
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Tue, 7 Oct 2025 16:16:53 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 597NGpAb2097764
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025092201; t=1759879023;
	bh=C2v1Wl1TRZDwC2MEfD4XkkqLj3ach0DgED2G6BUaXlw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NmRJUwFgZZC9DACntO8r1lgEBhd912ClirOcmmDyj/JQi5tp73BjqXfM9cLBU+Atw
	 +2fPhkxGU6bPe79V4S/tF5oOaKzBoY7kCM8N4ahdp8HNZ9D0OsJmV9FKZUUQFzZuIl
	 tFvz9kZ2rsV/VbYJdWrqKka2yMzemUUBAgfGE0KabYlEct9NCyKW2fngH520FXUdep
	 06DhnN75hfFy4xOIv8DWELNg/T8AsE2u+vRsO3ynjetMRjsNo4WyMWhuT1at40Sq6q
	 0t+OmTPOuj3dlqXKraxlcUfh1sJu2MCTCLS19nQ4mdSLehU0jO0gr6C7/RTB6eIj/u
	 VZ69XOEEU+R/w==
Message-ID: <7a5a28a3-baf4-4915-8585-eae8cd323895@zytor.com>
Date: Wed, 8 Oct 2025 07:16:28 +0800
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 01/15] x86/cpu: Enumerate the LASS feature bits
To: Sohil Mehta <sohil.mehta@intel.com>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
        "x86@kernel.org" <x86@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
Cc: "corbet@lwn.net" <corbet@lwn.net>, "ardb@kernel.org" <ardb@kernel.org>,
        "david.laight.linux@gmail.com" <david.laight.linux@gmail.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "jpoimboe@kernel.org" <jpoimboe@kernel.org>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
        "kas@kernel.org" <kas@kernel.org>,
        "seanjc@google.com" <seanjc@google.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "dwmw@amazon.co.uk" <dwmw@amazon.co.uk>,
        "vegard.nossum@oracle.com" <vegard.nossum@oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "kees@kernel.org" <kees@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "geert@linux-m68k.org" <geert@linux-m68k.org>
References: <20251007065119.148605-1-sohil.mehta@intel.com>
 <20251007065119.148605-2-sohil.mehta@intel.com>
 <47fb7efd89698f46a305ca446d0e4471d1f24fbb.camel@intel.com>
 <e82b48b9-5566-4bf2-9b9e-ee529d59e9b5@intel.com>
Content-Language: en-US
From: Xin Li <xin@zytor.com>
Autocrypt: addr=xin@zytor.com; keydata=
 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
 l75w1xInsg==
In-Reply-To: <e82b48b9-5566-4bf2-9b9e-ee529d59e9b5@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/8/2025 4:49 AM, Sohil Mehta wrote:
>>>   
>>> +config X86_DISABLED_FEATURE_LASS
>>> +	def_bool y
>>> +	depends on X86_32
>>> +
>> All the other ones in the file are !X86_64. Why do this one X86_32?
>>
> The double negation (DISABLED and !X86_64) was harder to follow when
> this was initially posted.
> 
> https://lore.kernel.org/lkml/73796800-819b-4433-b0ef-db852336d7a4@zytor.com/
> https://lore.kernel.org/lkml/756e93a2-7e42-4323-ae21- 
> a5437e71148e@infradead.org/
> 
> I don't have a strong preference. I guess the inconsistency makes it
> confusing as well. Will change it back to !X86_64 unless Xin objects.

I prefer to use X86_32, which is more direct.

Now the only disabled feature when !X86_64 is X86_DISABLED_FEATURE_PCID.
And I would expect the disabled features due to lack of 32-bit enabling 
will keep growing until we remove 32-bit kernel code.  I was also thinking
to move all such disabled features to a dedicated file when the total
reaches 3.  But hopefully removing 32-bit will happen first.






