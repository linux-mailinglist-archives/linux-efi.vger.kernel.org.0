Return-Path: <linux-efi+bounces-1636-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB08966B90
	for <lists+linux-efi@lfdr.de>; Fri, 30 Aug 2024 23:52:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2435D1F237B3
	for <lists+linux-efi@lfdr.de>; Fri, 30 Aug 2024 21:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB39B174EE4;
	Fri, 30 Aug 2024 21:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ku6gfzIi"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0AAD171066;
	Fri, 30 Aug 2024 21:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725054772; cv=none; b=doKGqC3RVxXn4xmBn7sWhXOJfRUei2ItS+IzbDKJ0i+mzpHo+b2In9oa7nPxJdxBU5a8OBOzqW/ANsSrKTCIuX+ZRBov4dJ14/8+V+i7PKe8DW3aZSB9Yd1dZop0XHgcRDNYWj8kON0SGxXsXDbRis2Q3ef0SGak+bHWuA/K7Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725054772; c=relaxed/simple;
	bh=J0UNxVwYPxVeqJ+A3UxlkXBd2nBDZs/m1fWczfPkhgM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ZLRsOuJ9ZiHxDxY477qi/RZpAJQJNtnYTZZ8Ba/g42ZgudzgkNZnL00ndxYabIjDaINCt8H26k4vkszZC3OHD8yyWcKRmDk35EZMzG714UH5yjyProX6eXaRBXCRMpwlPtFzDMWaEakB/vS1HTnoBesi7aPZte/m4xg3Rl5a4tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ku6gfzIi; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4281d812d3eso25449445e9.3;
        Fri, 30 Aug 2024 14:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725054769; x=1725659569; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=j7fDAqdMVeivgOetpxTuXLfKdwjjG4IPDWgb7ovhwtY=;
        b=ku6gfzIi3haAV9/nWxal/Thuz0iLl4S3xRF+Y9TGZD4BEVNXnjCRqIapNNos9ktU0b
         2i2dKssZ+pYozLFQtRoEukr3GMFH43HfOI0KnPVaOcdUBIYDKz/ELPneDdB06AzIfdyF
         t8WFrtL4M9eMI06OV8PB8Czkq8F3itBpQ9anvDTLF8XNmtCOcMLbtI8xNBDEZ+VBvTJ/
         JNCf2M1LRHLBOFj78izB7+vjQIcs+3ASB44ewGlRu90lbQ2ySVS4BRHUrJ+OlcMoHl4z
         knA8qlRGSjhSX1/Oz6P0euoGyMCGqUQBCVBcYBWAQVaxla1ugF4hYs/FFHBgxMLT45+1
         O4JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725054769; x=1725659569;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j7fDAqdMVeivgOetpxTuXLfKdwjjG4IPDWgb7ovhwtY=;
        b=rJ0g1yXIXfWmhqDDcfW3jiyhNNa38B9HgelX2wb3NN1+8nKuVFtZ5cektX8E/l29VP
         7Zn1XYUcnxvYwJhhpaSVwRpHaZqJESKPPvRObIyVmXo4nSeXzdCvkzwXHipLqwG9KUoG
         +FjW50/IJCfW08z5PzavKwLCvRiJS+qGr7uXxwojwEJG9xtedKN5f1r1WxUSK5NKsil8
         PzlRmndAuXN0+hD0JFGIzFnNHynf8RTrBkKfpU1vKNCoemwvMei8mfaFAZ2V4aXIPfLB
         cn2+/PJkmv9hKw2Nqr/M+11SVHauHGWga1IaSAQsSqNhAgZqLObEXN6j11f9RZB68dWZ
         Dg2w==
X-Forwarded-Encrypted: i=1; AJvYcCULPpdeGojE7rlRY/Hzqe8wPcDx7Hq11s0PySLFpeAWaYLlaewAV/h0ay2ETnvsF2jtmaPKLXrykpA=@vger.kernel.org, AJvYcCXb8IwB/Cg2J1alVSjNkueMR1rWDG+WQd4J826bKUY5ACMxfTe1S8c38A77qMfLP4V6WgDMzemgTALeudhd@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy6FBxNByMkJ+vRFnYaCQ5cp/kavXkc7fITjjdc211ZKIQ8Fpa
	2dNxWxi//ULQ6Ruw5AEcxgQz5VbmwOsZCbGwyP5hxymHPiyKgtSF
X-Google-Smtp-Source: AGHT+IG6DDq5ZLtbKXXYuPUklTEV/ydgikvdg16z3UfGDh5jhOkrdY3YBXrzSQYLT0aQD3sk4sU00g==
X-Received: by 2002:a05:600c:3b10:b0:426:6ed5:fcb with SMTP id 5b1f17b1804b1-42bb01ae1fbmr75481615e9.4.1725054768682;
        Fri, 30 Aug 2024 14:52:48 -0700 (PDT)
Received: from ?IPV6:2a02:6b6f:e750:7600:c5:51ce:2b5:970b? ([2a02:6b6f:e750:7600:c5:51ce:2b5:970b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-374bb1ea80csm851031f8f.73.2024.08.30.14.52.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Aug 2024 14:52:48 -0700 (PDT)
Message-ID: <1a31390d-f452-4d53-84a9-b9fb2af71e4c@gmail.com>
Date: Fri, 30 Aug 2024 22:52:48 +0100
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] efi: reserve memory for tpm_log only if TPM final events
 table is valid
From: Usama Arif <usamaarif642@gmail.com>
To: Gregory Price <gourry@gourry.net>
Cc: ardb@kernel.org, linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
 leitao@debian.org
References: <20240830212852.2794145-1-usamaarif642@gmail.com>
 <ZtI82gt30kUhwkFY@PC2K9PVX.TheFacebook.com>
 <30f285bc-7540-4d70-8b6c-11675b68e9e4@gmail.com>
Content-Language: en-US
In-Reply-To: <30f285bc-7540-4d70-8b6c-11675b68e9e4@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 30/08/2024 17:49, Usama Arif wrote:
> 
> 
> On 30/08/2024 17:42, Gregory Price wrote:
>> On Fri, Aug 30, 2024 at 10:28:52PM +0100, Usama Arif wrote:
>>> If efi.tpm_log is corrupted, log_tbl->size can be garbage (and
>>> negative). This can result in a large memblock reservation, resulting
>>> in the kernel booting without sufficient memory. Move the memblock
>>> reservation after log_tbl->version check, and check the value of
>>> both tbl_size and memblock_reserve.
>>>
>>> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
>>> ---
>>>  drivers/firmware/efi/tpm.c | 16 +++++++++++++---
>>>  1 file changed, 13 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/firmware/efi/tpm.c b/drivers/firmware/efi/tpm.c
>>> index e8d69bd548f3..cfc6a065f441 100644
>>> --- a/drivers/firmware/efi/tpm.c
>>> +++ b/drivers/firmware/efi/tpm.c
>>> @@ -59,9 +59,6 @@ int __init efi_tpm_eventlog_init(void)
>>>  		return -ENOMEM;
>>>  	}
>>>  
>>> -	tbl_size = sizeof(*log_tbl) + log_tbl->size;
>>> -	memblock_reserve(efi.tpm_log, tbl_size);
>>> -
>>>  	if (efi.tpm_final_log == EFI_INVALID_TABLE_ADDR) {
>>>  		pr_info("TPM Final Events table not present\n");
>>>  		goto out;
>>
>> The final event table is not present in TCG 1_2 format, but the
>> tpm log still needs to be mapped.  So this change is incorrect for
>> v1_2.
> 
> hmm so we have 
> 
> 	if (efi.tpm_final_log == EFI_INVALID_TABLE_ADDR) {
> 		pr_info("TPM Final Events table not present\n");
> 		goto out;
> 	} else if (log_tbl->version != EFI_TCG2_EVENT_LOG_FORMAT_TCG_2) {
> 		pr_warn(FW_BUG "TPM Final Events table invalid\n");
> 		goto out;
> 	}
> 
> If the format is TCG 1_2, then log_tbl is not used?
> 

Ah its the case that log_tbl->size will be valid, even if its TCG 2.
Got it, Thanks!

> 
>>
>>> @@ -70,6 +67,19 @@ int __init efi_tpm_eventlog_init(void)
>>>  		goto out;
>>>  	}
>>>  
>>> +	tbl_size = sizeof(*log_tbl) + log_tbl->size;
>>> +	if (tbl_size < 0) {
>>> +		pr_err(FW_BUG "Failed to parse event in TPM Final Events Log\n");
>>> +		ret = -EINVAL;
>>> +		goto out;
>>> +	}
>>> +	if (memblock_reserve(efi.tpm_log, tbl_size)) {
>>> +		pr_err("TPM Event Log memblock reserve fails 0x%lx - %x\n",
>>> +		       efi.tpm_log, tbl_size);
>>> +		ret = -ENOMEM;
>>> +		goto out;
>>> +	}
>>> +
>>>  	final_tbl = early_memremap(efi.tpm_final_log, sizeof(*final_tbl));
>>>  
>>>  	if (!final_tbl) {
>>> -- 
>>> 2.43.5
>>>
> 


