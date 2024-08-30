Return-Path: <linux-efi+bounces-1639-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B72EA966C44
	for <lists+linux-efi@lfdr.de>; Sat, 31 Aug 2024 00:24:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69BAA2844EB
	for <lists+linux-efi@lfdr.de>; Fri, 30 Aug 2024 22:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CB741C1755;
	Fri, 30 Aug 2024 22:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HCCqfKnv"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F19C136337;
	Fri, 30 Aug 2024 22:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725056684; cv=none; b=G/id5JVL7cljSfAXjehyiAd7FPMuVWug/mAWf/U0Vx92JA8mekXPU7pDz91sUY6y9Iyq+SkUkGL8RzzV/j4Z1FtaiD3HIXP+u482YfIlauVhHi3HWaF2xtuKM6MDPZ4ScHDV8bt7gl13qIhTqCAJyn6tlPADYWU881pqelti5Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725056684; c=relaxed/simple;
	bh=Ngr9/febxtlS7xmY7K0UaawwcsoKa8aW6rBes7FLKBs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nv87CMYOJXFvcUIwCSixJJS9graW/8kiIbhKB2jn4h2mTG41/YPOF2DJ1JNALLXDyOs/p0J6EobPFuxcWwxttEnIpa7Xmu+f7nNxoxxe7jgaiob2/AdjAhH7DYVFj9OnPnok45rJOlanFDJzQZTopS/dYm1Od3cQNVfxla9X0xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HCCqfKnv; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42bb81e795bso17336175e9.1;
        Fri, 30 Aug 2024 15:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725056681; x=1725661481; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PMu8xuM4A8JgaI03qzs8RyiKKY0OlctnI6474Q81v7Y=;
        b=HCCqfKnveSGQiAOI+Vk/ziFlO6wc6/fpz1BD9n3TMvwBnCyWYIkftadecDxCvbbSQp
         wV/Z0fDn5w99QYbjJsUs/nIXuHScz7zUddU6WxZjjFcxWD7XC2aWbEnxGSE4+DVP3l5+
         VLVx6NcH+x88E8slBl+thgdbSOSFjkjdtHPWetucSt6pi7CAE/yqGQuxlAJ3B83cgrE7
         nwOclCrH0sI9q+Gsfh6XJxF1iCmbtu0OtUT0LlcqlSYL/6kIR363XVNd4E/J+SO4fekX
         VUEOEmtCBKB4bCHDljy+hOeeot8ReYjF3/X9IBSRFBE+2yfN2CfoFh8hLkaRyr3tj8xc
         cadA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725056681; x=1725661481;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PMu8xuM4A8JgaI03qzs8RyiKKY0OlctnI6474Q81v7Y=;
        b=OuRW805SZz/fbBOSSsm0XkvN/Q47Y1KoEt8Phvj86HsYyjCCQZqciL+S77VZZTnnkD
         MnBauV59cxzQMSbZpoUHRrnLh4AbQ5XjLTSYITQU13PZHE0PnfNIcbWPheJRtTzn0vpu
         XY1CJct26ui7NxxiLy5jNfMvMzsmOHDaNvy4f3oP9oC/IPnR8VxT+KmVERjT8sGFUshj
         ghb+Jxo25vslkpNSS9s0lWtavylxm7wV3xZMWVNnX2yV++kcv3Vro+8WRnkcD50uwjIU
         RmOCs+KX7VkjmAG6OTW5gHNuTE7CmcOAbyQObTC9TmRAI20eO4N74v4VarvOmc+UaeIK
         3gyQ==
X-Forwarded-Encrypted: i=1; AJvYcCVAlrxbUvZ2rwzwSZk21UZaMqsYpa3+M9mD8EO66hJhCMAKOdd98rkLfzeM88EI6kublbRL0hnCgImgbjEG@vger.kernel.org, AJvYcCVoynB+VRCDf83eZ3NCvnzkETJwekxT8MNtNyog5H0SAhSSLzEpyEDh16V/rM2WUg2TIcmSrYhZJoA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1aaPEZJ6V/jaRQ6FPw7mmR6eM5IxdnGbyZC62jxMVoE1EuLxE
	3rad0XeYqMIbG8wP7oiFnTnSFKMWgcgFwWF4O4d9XHCL/Sbz29r+
X-Google-Smtp-Source: AGHT+IH4YQZXnwbhyHlXSXIcq5R6GiimdE0PpvIrTJiTNcEakPp1RQ8gmEDH9PJNVOk9MmXo1lMOxQ==
X-Received: by 2002:a05:600c:138e:b0:428:c0a:27ea with SMTP id 5b1f17b1804b1-42bbb205ac6mr27182405e9.12.1725056679958;
        Fri, 30 Aug 2024 15:24:39 -0700 (PDT)
Received: from ?IPV6:2a02:6b6f:e750:7600:c5:51ce:2b5:970b? ([2a02:6b6f:e750:7600:c5:51ce:2b5:970b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bbc87773fsm25956195e9.0.2024.08.30.15.24.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Aug 2024 15:24:39 -0700 (PDT)
Message-ID: <cb141207-6065-4ee5-9e69-2d4ffd9eb7f3@gmail.com>
Date: Fri, 30 Aug 2024 23:24:39 +0100
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] efi: reserve memory for tpm_log only if TPM final events
 table is valid
To: Gregory Price <gourry@gourry.net>
Cc: ardb@kernel.org, linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
 leitao@debian.org
References: <20240830212852.2794145-1-usamaarif642@gmail.com>
 <ZtI82gt30kUhwkFY@PC2K9PVX.TheFacebook.com>
 <30f285bc-7540-4d70-8b6c-11675b68e9e4@gmail.com>
 <1a31390d-f452-4d53-84a9-b9fb2af71e4c@gmail.com>
 <ZtJAnkd3Rkh5Amfb@PC2K9PVX.TheFacebook.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <ZtJAnkd3Rkh5Amfb@PC2K9PVX.TheFacebook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 30/08/2024 17:58, Gregory Price wrote:
> On Fri, Aug 30, 2024 at 10:52:48PM +0100, Usama Arif wrote:
>>
>>
>> On 30/08/2024 17:49, Usama Arif wrote:
>>>
>>>
>>> On 30/08/2024 17:42, Gregory Price wrote:
>>>> On Fri, Aug 30, 2024 at 10:28:52PM +0100, Usama Arif wrote:
>>>>> If efi.tpm_log is corrupted, log_tbl->size can be garbage (and
>>>>> negative). This can result in a large memblock reservation, resulting
>>>>> in the kernel booting without sufficient memory. Move the memblock
>>>>> reservation after log_tbl->version check, and check the value of
>>>>> both tbl_size and memblock_reserve.
>>>>>
>>>>> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
>>>>> ---
>>>>>  drivers/firmware/efi/tpm.c | 16 +++++++++++++---
>>>>>  1 file changed, 13 insertions(+), 3 deletions(-)
>>>>>
>>>>> diff --git a/drivers/firmware/efi/tpm.c b/drivers/firmware/efi/tpm.c
>>>>> index e8d69bd548f3..cfc6a065f441 100644
>>>>> --- a/drivers/firmware/efi/tpm.c
>>>>> +++ b/drivers/firmware/efi/tpm.c
>>>>> @@ -59,9 +59,6 @@ int __init efi_tpm_eventlog_init(void)
>>>>>  		return -ENOMEM;
>>>>>  	}
>>>>>  
>>>>> -	tbl_size = sizeof(*log_tbl) + log_tbl->size;
>>>>> -	memblock_reserve(efi.tpm_log, tbl_size);
>>>>> -
>>>>>  	if (efi.tpm_final_log == EFI_INVALID_TABLE_ADDR) {
>>>>>  		pr_info("TPM Final Events table not present\n");
>>>>>  		goto out;
>>>>
>>>> The final event table is not present in TCG 1_2 format, but the
>>>> tpm log still needs to be mapped.  So this change is incorrect for
>>>> v1_2.
>>>
>>> hmm so we have 
>>>
>>> 	if (efi.tpm_final_log == EFI_INVALID_TABLE_ADDR) {
>>> 		pr_info("TPM Final Events table not present\n");
>>> 		goto out;
>>> 	} else if (log_tbl->version != EFI_TCG2_EVENT_LOG_FORMAT_TCG_2) {
>>> 		pr_warn(FW_BUG "TPM Final Events table invalid\n");
>>> 		goto out;
>>> 	}
>>>
>>> If the format is TCG 1_2, then log_tbl is not used?
>>>
>>
>> Ah its the case that log_tbl->size will be valid, even if its TCG 2.
>> Got it, Thanks!
> 
> No, not necessarily.  The corruption issue is entirely separate from the
> patches here. size can technically be 0xffffffff and treated as valid
> because as far as I can see the spec does not define a maximum size.
> 
> the tl;dr here is that the above checks on tpm_final_log and log_tbl->version
> gate mapping/operating on the final log - but do not have anything to
> say about the event log.
> 
> There isn't really a good sanity check for whether or not to memblock_reserve
> the log.  Possibly you add a LOG_FORMAT_MAX and check if version >= MAX,
> but again that should be separate from the change that checks the return
> value of the memblock_reserve call.
> 
> ~Gregory

Yes, makes sense. Thanks!


