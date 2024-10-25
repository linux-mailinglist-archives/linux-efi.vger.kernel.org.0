Return-Path: <linux-efi+bounces-2021-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F0E6B9B0402
	for <lists+linux-efi@lfdr.de>; Fri, 25 Oct 2024 15:28:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E8F0B22936
	for <lists+linux-efi@lfdr.de>; Fri, 25 Oct 2024 13:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 270611632E9;
	Fri, 25 Oct 2024 13:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ToWZogvy"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20F6212177;
	Fri, 25 Oct 2024 13:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729862877; cv=none; b=W6WYF4cmsQHRguma2Fpsi2ltFKsJZw6VfZ1GDhaNlR7pbs6GeR/0vWfG0JmgqSw/bdZANlSJjs1EvyW/m57Rrg/i4M+vicgm2JhfUAucXANhxo2GvxqHzKV1bBVBNGRmrgxmZvky3xEQq+yEmHDEl7LzRAE+TBcLyNKzhP/svm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729862877; c=relaxed/simple;
	bh=vqXSoDHtWOzVQLU81RLVdFevTsKOQPe0GfCVmVSQaUc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R1ZK/mv8eFsVfdrLxf0iPbXx7BNZZGF6E/IHUYonk4yTXq0P0Z3wus5eU4gYEtU+FVcF5T8YIVZjg5tZjfLgYaRMMczqjx1Oi6IMXMxd4CSDcgM1DfiBUfP8jDgTr24663/67RSLqXu4OY/oMqXnjzflP5T/TbgzgPrr376G1IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ToWZogvy; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5366fd6fdf1so2874714e87.0;
        Fri, 25 Oct 2024 06:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729862873; x=1730467673; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2OhXSnxIccENH/su062bXdXJHpWmUMiU9LhU+oaGUCM=;
        b=ToWZogvy2oI2gueFSaTVC5zUoNXy3RzcY1/cRl1C2ko8NNsePbBw7RhYP3ppmJR9SJ
         mw+JZjSrHzbXOXOE6dO6uHpakcjoQRpJZY6FKs7Jo186O6uLfAKS2FlwwQ2d/4Quyw+j
         8gNVkQWEZKVnDhkhOKkj3ZG7fHnDvK5yqOuTNPpyNQ1C43vzfrROWSAom/bl41lcMtcX
         JnHcKqzMcb5HclsLx/r7YGjpwn/zabvz+nvfMQz6x5ukAx9OAzU284yHedoF1JfAvZhY
         4OlYWYo1u+bCCLijhIv80fruHu9u8vnLVa+CD0EtSTTCozsdTiakDzo/HcQ3EWIxOUWD
         6kRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729862873; x=1730467673;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2OhXSnxIccENH/su062bXdXJHpWmUMiU9LhU+oaGUCM=;
        b=WbTVyDnOKcsf/MeZSGwRVZ1TDM2quVZQd9XOOJOLGtKgmu+FdpAkmbltS7VhEA7LaZ
         XwHnKvzvqLmfBKuq7tXU97SYcH1ubVM2eMNEQpxjXmMYEW9T6ZPYu5HNTN67yZKswdsn
         F1jL1NptvxJtRtgQTjmCwJhGhLnwY8ebRYEFLazUavAHpN0P9Wge2JHN8ikcCX9bCNwa
         F1HKNSHilNPr1zLg6jOKXmVVA+UrjNn6cZXjOSvktyTVJfWANZfyil8cgFDj/SQuVTU7
         upPI3LuaSuPkxmkTWkL4rwAqudQgpgud4YRW/z4vULD0qJN96Jc1UiRNwhdzt7NC1LqS
         1O3g==
X-Forwarded-Encrypted: i=1; AJvYcCVHTHQsxzKgX48cD95ZgQdzucDstF06E3ithWJZjRzS64K9ScvpQPwW5leY4nvjsjG0JlG7Km0u6Z0=@vger.kernel.org, AJvYcCVMVi2MjMFB5+ZG7MSRZS7fXwMAPOosZNJ+Gw4Rqf0wbr+dGu8KVUCbu1mx6ejxIAKr/qwuZXiL@vger.kernel.org
X-Gm-Message-State: AOJu0Yz67sYTj7Xa6296exh2XelTwn8/MRmtu3u2nS5KL+QszGMGqmPw
	rCRKI5ity5fFB0EPZC9unkfJWbaqHWo+TT/Y+0TTBOB3LMnuR6E7
X-Google-Smtp-Source: AGHT+IEHCs8g48g/xSi7UMtMGRFHp468IaTIG8a4oO92I8SOGt45flfJGGSuclb6cm8sNjLPjO7OJQ==
X-Received: by 2002:a05:6512:401a:b0:52c:9383:4c16 with SMTP id 2adb3069b0e04-53b23dfa27dmr3580589e87.22.1729862872431;
        Fri, 25 Oct 2024 06:27:52 -0700 (PDT)
Received: from ?IPV6:2a02:6b67:d751:7400:c2b:f323:d172:e42a? ([2a02:6b67:d751:7400:c2b:f323:d172:e42a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431935a5943sm18047735e9.25.2024.10.25.06.27.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Oct 2024 06:27:52 -0700 (PDT)
Message-ID: <899f209b-d4ec-4903-a3e6-88b570805499@gmail.com>
Date: Fri, 25 Oct 2024 14:27:51 +0100
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] efistub/tpm: Use ACPI reclaim memory for event log to
 avoid corruption
To: Jiri Slaby <jirislaby@kernel.org>, Ard Biesheuvel <ardb+git@google.com>,
 linux-efi@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, stable@vger.kernel.org,
 Breno Leitao <leitao@debian.org>
References: <20240912155159.1951792-2-ardb+git@google.com>
 <ec7db629-61b0-49aa-a67d-df663f004cd0@kernel.org>
 <29b39388-5848-4de0-9fcf-71427d10c3e8@kernel.org>
 <58da4824-523c-4368-9da1-05984693c811@kernel.org>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <58da4824-523c-4368-9da1-05984693c811@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 25/10/2024 06:09, Jiri Slaby wrote:
> On 25. 10. 24, 7:07, Jiri Slaby wrote:
>> On 24. 10. 24, 18:20, Jiri Slaby wrote:
>>> On 12. 09. 24, 17:52, Ard Biesheuvel wrote:
>>>> From: Ard Biesheuvel <ardb@kernel.org>
>>>>
>>>> The TPM event log table is a Linux specific construct, where the data
>>>> produced by the GetEventLog() boot service is cached in memory, and
>>>> passed on to the OS using a EFI configuration table.
>>>>
>>>> The use of EFI_LOADER_DATA here results in the region being left
>>>> unreserved in the E820 memory map constructed by the EFI stub, and this
>>>> is the memory description that is passed on to the incoming kernel by
>>>> kexec, which is therefore unaware that the region should be reserved.
>>>>
>>>> Even though the utility of the TPM2 event log after a kexec is
>>>> questionable, any corruption might send the parsing code off into the
>>>> weeds and crash the kernel. So let's use EFI_ACPI_RECLAIM_MEMORY
>>>> instead, which is always treated as reserved by the E820 conversion
>>>> logic.
>>>>
>>>> Cc: <stable@vger.kernel.org>
>>>> Reported-by: Breno Leitao <leitao@debian.org>
>>>> Tested-by: Usama Arif <usamaarif642@gmail.com>
>>>> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
>>>> ---
>>>>   drivers/firmware/efi/libstub/tpm.c | 2 +-
>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/firmware/efi/libstub/tpm.c b/drivers/firmware/ efi/libstub/tpm.c
>>>> index df3182f2e63a..1fd6823248ab 100644
>>>> --- a/drivers/firmware/efi/libstub/tpm.c
>>>> +++ b/drivers/firmware/efi/libstub/tpm.c
>>>> @@ -96,7 +96,7 @@ static void efi_retrieve_tcg2_eventlog(int version, efi_physical_addr_t log_loca
>>>>       }
>>>>       /* Allocate space for the logs and copy them. */
>>>> -    status = efi_bs_call(allocate_pool, EFI_LOADER_DATA,
>>>> +    status = efi_bs_call(allocate_pool, EFI_ACPI_RECLAIM_MEMORY,
>>>>                    sizeof(*log_tbl) + log_size, (void **)&log_tbl);
>>>
>>> Hi,
>>>
>>> this, for some reason, corrupts system configuration table. On good boots, memattr points to 0x77535018, on bad boots (this commit applied), it points to 0x77526018.
>>>
>>> And the good content at 0x77526018:
>>> tab=0x77526018 size=16+45*48=0x0000000000000880
>>>
>>> bad content at 0x77535018:
>>> tab=0x77535018 size=16+2*1705353216=0x00000000cb4b4010
>>>
>>> This happens only on cold boots. Subsequent boots (having the commit or not) are all fine.
>>>
>>> Any ideas?
>>
>> ====
>> EFI_ACPI_RECLAIM_MEMORY
>>
>> This memory is to be preserved by the UEFI OS loader and OS until ACPI
>> is enabled. Once ACPI is enabled, the memory in this range is available for general use.
>> ====
>>
>> BTW doesn't the above mean it is released by the time TPM actually reads it?
>>
>> Isn't the proper fix to actually memblock_reserve() that TPM portion. The same as memattr in efi_memattr_init()?
> 
> And this is actually done in efi_tpm_eventlog_init().
> 
>>> DMI: Dell Inc. Latitude 7290/09386V, BIOS 1.39.0 07/04/2024
>>>
>>> This was reported downstream at:
>>> https://bugzilla.suse.com/show_bug.cgi?id=1231465
>>>
>>> thanks,
> 

Could you share the e820 map, reserve setup_data and TPMEventLog address with and without the patch?
All of these should be just be in the dmesg.

Thanks,
Usama

