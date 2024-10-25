Return-Path: <linux-efi+bounces-2018-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B74F9AF914
	for <lists+linux-efi@lfdr.de>; Fri, 25 Oct 2024 07:07:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF54728331F
	for <lists+linux-efi@lfdr.de>; Fri, 25 Oct 2024 05:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FC35189B9F;
	Fri, 25 Oct 2024 05:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SBQbHn3o"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357B322B641;
	Fri, 25 Oct 2024 05:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729832870; cv=none; b=WELhDsu3dyap8KQduUQ0nq4gFhUzzY+8QLt0n/UcvUtCicSTYjdbeaA1uNKmOTrDyd1JQk/HX3PP8OgoMbfM0gSO1+WOisR8PpfDfNpllt9FTJtMZjMV0aY7kdjfhm00Eqf+FOjKV7vODovYqSG0k95GVNcZbqiWGtX7/NrYpWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729832870; c=relaxed/simple;
	bh=iTbP6xU6PxFBTH1u3OLkHDGz/Js+zFobMw1YPFwXD6o=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=MbfOXAtmWfAS6hO29MewOKTnFtHN4P0oZsvaWmi+oTbdQzXW5f8ne7m/47sPl7kCebPYh5a3Mg08xTBdzAcR8ZH6vusc9ZvMGO1KYMzwEIXKFZdSo03WC9F+w7EJAhTI6t/gFHu1oxGeZtTQEpd+3oZYpNIMYgqe424TmNmirsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SBQbHn3o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57557C4CEC3;
	Fri, 25 Oct 2024 05:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729832869;
	bh=iTbP6xU6PxFBTH1u3OLkHDGz/Js+zFobMw1YPFwXD6o=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=SBQbHn3oZa3kL+RxAclmK3qA53vBUjiXvow6H4iaPmCRKJbY8yD4PZlytYG+XCKJ1
	 3qhNi3I42YfNZbK5UmGm2Ql4oPtQYTte1FFUY6fd4mdDlTfYPzCh6rSL2j1CW2WN9v
	 jbBr1d41hWiAY2hj1bqJ2WN4vBYkh+uGKkdBkHVx6IU00uqm0bJZkSXWV9+yzVp366
	 2k3RybBYGZBpMiMAKi/eJug3OM9gc2k0cu2kt0NnoKJGUBcB02p4O+RibvQONRat+Z
	 aHXzlwG7fTeCdI629uYyPoRegq5uFavtg7qEcBoRzSGA1NAfLugsE6SdgHhrnI5MaY
	 Dx5fo5y+zRSzw==
Message-ID: <29b39388-5848-4de0-9fcf-71427d10c3e8@kernel.org>
Date: Fri, 25 Oct 2024 07:07:46 +0200
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] efistub/tpm: Use ACPI reclaim memory for event log to
 avoid corruption
From: Jiri Slaby <jirislaby@kernel.org>
To: Ard Biesheuvel <ardb+git@google.com>, linux-efi@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, stable@vger.kernel.org,
 Breno Leitao <leitao@debian.org>, Usama Arif <usamaarif642@gmail.com>
References: <20240912155159.1951792-2-ardb+git@google.com>
 <ec7db629-61b0-49aa-a67d-df663f004cd0@kernel.org>
Content-Language: en-US
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <ec7db629-61b0-49aa-a67d-df663f004cd0@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 24. 10. 24, 18:20, Jiri Slaby wrote:
> On 12. 09. 24, 17:52, Ard Biesheuvel wrote:
>> From: Ard Biesheuvel <ardb@kernel.org>
>>
>> The TPM event log table is a Linux specific construct, where the data
>> produced by the GetEventLog() boot service is cached in memory, and
>> passed on to the OS using a EFI configuration table.
>>
>> The use of EFI_LOADER_DATA here results in the region being left
>> unreserved in the E820 memory map constructed by the EFI stub, and this
>> is the memory description that is passed on to the incoming kernel by
>> kexec, which is therefore unaware that the region should be reserved.
>>
>> Even though the utility of the TPM2 event log after a kexec is
>> questionable, any corruption might send the parsing code off into the
>> weeds and crash the kernel. So let's use EFI_ACPI_RECLAIM_MEMORY
>> instead, which is always treated as reserved by the E820 conversion
>> logic.
>>
>> Cc: <stable@vger.kernel.org>
>> Reported-by: Breno Leitao <leitao@debian.org>
>> Tested-by: Usama Arif <usamaarif642@gmail.com>
>> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
>> ---
>>   drivers/firmware/efi/libstub/tpm.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/firmware/efi/libstub/tpm.c b/drivers/firmware/ 
>> efi/libstub/tpm.c
>> index df3182f2e63a..1fd6823248ab 100644
>> --- a/drivers/firmware/efi/libstub/tpm.c
>> +++ b/drivers/firmware/efi/libstub/tpm.c
>> @@ -96,7 +96,7 @@ static void efi_retrieve_tcg2_eventlog(int version, 
>> efi_physical_addr_t log_loca
>>       }
>>       /* Allocate space for the logs and copy them. */
>> -    status = efi_bs_call(allocate_pool, EFI_LOADER_DATA,
>> +    status = efi_bs_call(allocate_pool, EFI_ACPI_RECLAIM_MEMORY,
>>                    sizeof(*log_tbl) + log_size, (void **)&log_tbl);
> 
> Hi,
> 
> this, for some reason, corrupts system configuration table. On good 
> boots, memattr points to 0x77535018, on bad boots (this commit applied), 
> it points to 0x77526018.
> 
> And the good content at 0x77526018:
> tab=0x77526018 size=16+45*48=0x0000000000000880
> 
> bad content at 0x77535018:
> tab=0x77535018 size=16+2*1705353216=0x00000000cb4b4010
> 
> This happens only on cold boots. Subsequent boots (having the commit or 
> not) are all fine.
> 
> Any ideas?

====
EFI_ACPI_RECLAIM_MEMORY

This memory is to be preserved by the UEFI OS loader and OS until ACPI
is enabled. Once ACPI is enabled, the memory in this range is available 
for general use.
====

BTW doesn't the above mean it is released by the time TPM actually reads it?

Isn't the proper fix to actually memblock_reserve() that TPM portion. 
The same as memattr in efi_memattr_init()?

> DMI: Dell Inc. Latitude 7290/09386V, BIOS 1.39.0 07/04/2024
> 
> This was reported downstream at:
> https://bugzilla.suse.com/show_bug.cgi?id=1231465
> 
> thanks,
-- 
js
suse labs


