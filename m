Return-Path: <linux-efi+bounces-1635-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA92966B83
	for <lists+linux-efi@lfdr.de>; Fri, 30 Aug 2024 23:49:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4225CB224C8
	for <lists+linux-efi@lfdr.de>; Fri, 30 Aug 2024 21:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 729B9170A07;
	Fri, 30 Aug 2024 21:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ctWZiWt/"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9BD216F910;
	Fri, 30 Aug 2024 21:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725054591; cv=none; b=GKysaBJTAMkMbFUC4uMnxgXDVIytcOn7wfdzYuxoiaW5YjfI544jyA3Md2CAS0HZKYK2+3eD3h68ZBdXR6Kw3XOX+1WW1NhwruRkA6922EKY//9rsmdThwoPoab0eyqOShr8yzk/H4ZjRcQq9/AHCzRdUTIZpC6AEKD27+kjl6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725054591; c=relaxed/simple;
	bh=qDsvXjYVJ2ojqDZsaBetSsl+DnQG8ynXsfTGWBDJlM0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NHmrAjCik7ooyUfrf6J8F9jPRgYoZVk/AUTbrzQWXSFiYpG1U/0MqoBmUKfFwV2gyCH6GJbdM1k2qGawdMngjZikrj75vGGF2Nwf4fYsrMYTbJbxsM4Uq6go42ID7QCyY1LrIMrZeYdLWiFXlMyoHCFJHyA35TAEu9M9VNFmrqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ctWZiWt/; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3718eaf4046so1806590f8f.3;
        Fri, 30 Aug 2024 14:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725054588; x=1725659388; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EYiXkUzlOYnPfzCMSYhbZwPdYIivaV9P9jkC/NGx8bY=;
        b=ctWZiWt/Uhb+A0uH1Qj63t6fb5htL2ykQaQkTv56xvsNHP9zdv4Z8H9UQgXXr+vv2v
         rfC3Sqoysou0IJlmxXjsis2zW+LFTsPxA4iuloGi+V3Fs2TZECyW/zelMTOCmFhs90IS
         ckpJhwR7Hw4nGK569gQg5gOXs2LZqErB3ZuG8MRhhgaLUmiFO1W5vMTsgO6QcO5u1jN5
         MKjoCteBPnd5g+ZE3UEqGfqhREtJxdYrxn8A9q51cNssV3wZbOBeZBehTM5F5rbJtCxc
         +DQ3/miJqPC31wFWvcCylv2q0EappD54tWQsMSQh6YL2mCBGP9q/9IbgDn2vJqawyxjt
         hTvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725054588; x=1725659388;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EYiXkUzlOYnPfzCMSYhbZwPdYIivaV9P9jkC/NGx8bY=;
        b=nPaALeC6UX2GD2tshkDaCCSbhDv8Xs3uioIZHGb7CCzqVh/hLR64Gm0aJNJ4JWFPRr
         VuoHlpGMN0LoBtuRV69psm33bH4B6xMx3rQCTL8HzCWDJxjd11B9W/Ne7OMLyE34HwlE
         dgStiB3di+SB1fLpPrK12tkjShB/q5J23KrhNRc+i4gCUpy4wp/aAwswHygtOuaX1G+u
         zDLZQXHItsPd8GTkj8yiNabnbyYK36cm5/CMiLY4nsHrr9RBecdscJnYHTaSds8hy3H1
         syvt0HfwkM+Birc1f5fxLb5ULsR3FV3yEce5FmZ1YmZy9zCsWemQd+yraYq4xRpWf7x3
         dEBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmUUEUGRjNUAEPHlbpPTvNgsQQ0IBX3b5dzpRtPTSyd9mU8q0KCA7xhhOlllVs1EV4xxQSbFQzZN4vqYZd@vger.kernel.org, AJvYcCWnrUULcUkjXffRZ8iJ8RXGwYWYiZPwMoIItUsNFw14Nfoyj1yVGXdNH4brmEMUuD1J2oeO3bsYZOI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy624O6FcGEWqCYJ3iPEo0AqBnIPdanUkMI9e2YRufwm5ZXDsz7
	0VZXMBXe/5X7TN5RJgAYou1zKvrirC5Me5cpUmP81R013UsNxIEo
X-Google-Smtp-Source: AGHT+IFS4ECcXREGKM6A4Xe0UcY/bY4T4sqhu54t/4f0UYNppSdEUmwzYnz/OP9gYL5ukOt8YL+NKA==
X-Received: by 2002:adf:fd0e:0:b0:371:8c0b:4818 with SMTP id ffacd0b85a97d-3749b58afd6mr5970374f8f.63.1725054587372;
        Fri, 30 Aug 2024 14:49:47 -0700 (PDT)
Received: from ?IPV6:2a02:6b6f:e750:7600:c5:51ce:2b5:970b? ([2a02:6b6f:e750:7600:c5:51ce:2b5:970b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3749ee6f76asm4980026f8f.25.2024.08.30.14.49.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Aug 2024 14:49:47 -0700 (PDT)
Message-ID: <30f285bc-7540-4d70-8b6c-11675b68e9e4@gmail.com>
Date: Fri, 30 Aug 2024 22:49:46 +0100
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
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <ZtI82gt30kUhwkFY@PC2K9PVX.TheFacebook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 30/08/2024 17:42, Gregory Price wrote:
> On Fri, Aug 30, 2024 at 10:28:52PM +0100, Usama Arif wrote:
>> If efi.tpm_log is corrupted, log_tbl->size can be garbage (and
>> negative). This can result in a large memblock reservation, resulting
>> in the kernel booting without sufficient memory. Move the memblock
>> reservation after log_tbl->version check, and check the value of
>> both tbl_size and memblock_reserve.
>>
>> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
>> ---
>>  drivers/firmware/efi/tpm.c | 16 +++++++++++++---
>>  1 file changed, 13 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/firmware/efi/tpm.c b/drivers/firmware/efi/tpm.c
>> index e8d69bd548f3..cfc6a065f441 100644
>> --- a/drivers/firmware/efi/tpm.c
>> +++ b/drivers/firmware/efi/tpm.c
>> @@ -59,9 +59,6 @@ int __init efi_tpm_eventlog_init(void)
>>  		return -ENOMEM;
>>  	}
>>  
>> -	tbl_size = sizeof(*log_tbl) + log_tbl->size;
>> -	memblock_reserve(efi.tpm_log, tbl_size);
>> -
>>  	if (efi.tpm_final_log == EFI_INVALID_TABLE_ADDR) {
>>  		pr_info("TPM Final Events table not present\n");
>>  		goto out;
> 
> The final event table is not present in TCG 1_2 format, but the
> tpm log still needs to be mapped.  So this change is incorrect for
> v1_2.

hmm so we have 

	if (efi.tpm_final_log == EFI_INVALID_TABLE_ADDR) {
		pr_info("TPM Final Events table not present\n");
		goto out;
	} else if (log_tbl->version != EFI_TCG2_EVENT_LOG_FORMAT_TCG_2) {
		pr_warn(FW_BUG "TPM Final Events table invalid\n");
		goto out;
	}

If the format is TCG 1_2, then log_tbl is not used?


> 
>> @@ -70,6 +67,19 @@ int __init efi_tpm_eventlog_init(void)
>>  		goto out;
>>  	}
>>  
>> +	tbl_size = sizeof(*log_tbl) + log_tbl->size;
>> +	if (tbl_size < 0) {
>> +		pr_err(FW_BUG "Failed to parse event in TPM Final Events Log\n");
>> +		ret = -EINVAL;
>> +		goto out;
>> +	}
>> +	if (memblock_reserve(efi.tpm_log, tbl_size)) {
>> +		pr_err("TPM Event Log memblock reserve fails 0x%lx - %x\n",
>> +		       efi.tpm_log, tbl_size);
>> +		ret = -ENOMEM;
>> +		goto out;
>> +	}
>> +
>>  	final_tbl = early_memremap(efi.tpm_final_log, sizeof(*final_tbl));
>>  
>>  	if (!final_tbl) {
>> -- 
>> 2.43.5
>>


