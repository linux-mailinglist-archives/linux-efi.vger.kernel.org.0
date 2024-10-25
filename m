Return-Path: <linux-efi+bounces-2019-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1B739AF917
	for <lists+linux-efi@lfdr.de>; Fri, 25 Oct 2024 07:09:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66777282879
	for <lists+linux-efi@lfdr.de>; Fri, 25 Oct 2024 05:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 830F31E492;
	Fri, 25 Oct 2024 05:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jaVbQToR"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5571322B641;
	Fri, 25 Oct 2024 05:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729832982; cv=none; b=kthGIg4D4i1GkCGi0tnHiopq4fzfp0tPMoEm//T8IIHy8/9XeEMAcCQ2Xh6DyAlvoCF4pWNwyOQCC0ndQ1/7apa/hJxFoDKcAcQD4cPa3J6HbhuCani1FswFt7Ekweba9yJBALExtclq4WcM+c1pRKGQ7O6LbXrU1t288+iuOQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729832982; c=relaxed/simple;
	bh=Op98ZtK/OWcCF7A1ZD9tEaN71ycnEklMPEfiGnge/Ow=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=lWFhrfATAJDfoQjp9fIggf9GV7XfNR1/pdm9dPGnHpmUZcub8b31S8gxGWHhYN3ggJSm1yxcpflZgysU3Tw2WuzlROBmZOiCvArV+z2fBzT8xTI3uVL8FXcCDhgW2COyRqAZyGsVAEDDtvb7fdO2zH4Mzk/OIchhbT29CAdgqAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jaVbQToR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93543C4CEC3;
	Fri, 25 Oct 2024 05:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729832981;
	bh=Op98ZtK/OWcCF7A1ZD9tEaN71ycnEklMPEfiGnge/Ow=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=jaVbQToRnoAb/4UljH2wnr14E35TkF9ph6mIpWKAVg2MoZjImXuzPM4NPOhQ/hXLv
	 hsZTVTBiV1A6estS3ii7tUqhWuFbbcaonN9XlFwAUbcnM/hWJvww4z8lTxACwaKjZn
	 56fu2lM0n0YnHCUI53uA3RaL2WQckcu8O2qf379r9zOVwqjjylyV6ItkzTmYiMSPKo
	 zvqXEocxnSklgVJ5hW1RntWFu4QcYDpkBji4iPzVpUQGpZuDRLIEocNZNWEGK8ouuR
	 A2OF5JHzk4C1PyjclN4YFkG4LRICgVf9lVfvMUBrCb1XSrQVPYESeq907D2e9hy9Jy
	 sxOIlq6EH+lYw==
Message-ID: <58da4824-523c-4368-9da1-05984693c811@kernel.org>
Date: Fri, 25 Oct 2024 07:09:39 +0200
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
 <29b39388-5848-4de0-9fcf-71427d10c3e8@kernel.org>
Content-Language: en-US
In-Reply-To: <29b39388-5848-4de0-9fcf-71427d10c3e8@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 25. 10. 24, 7:07, Jiri Slaby wrote:
> On 24. 10. 24, 18:20, Jiri Slaby wrote:
>> On 12. 09. 24, 17:52, Ard Biesheuvel wrote:
>>> From: Ard Biesheuvel <ardb@kernel.org>
>>>
>>> The TPM event log table is a Linux specific construct, where the data
>>> produced by the GetEventLog() boot service is cached in memory, and
>>> passed on to the OS using a EFI configuration table.
>>>
>>> The use of EFI_LOADER_DATA here results in the region being left
>>> unreserved in the E820 memory map constructed by the EFI stub, and this
>>> is the memory description that is passed on to the incoming kernel by
>>> kexec, which is therefore unaware that the region should be reserved.
>>>
>>> Even though the utility of the TPM2 event log after a kexec is
>>> questionable, any corruption might send the parsing code off into the
>>> weeds and crash the kernel. So let's use EFI_ACPI_RECLAIM_MEMORY
>>> instead, which is always treated as reserved by the E820 conversion
>>> logic.
>>>
>>> Cc: <stable@vger.kernel.org>
>>> Reported-by: Breno Leitao <leitao@debian.org>
>>> Tested-by: Usama Arif <usamaarif642@gmail.com>
>>> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
>>> ---
>>>   drivers/firmware/efi/libstub/tpm.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/firmware/efi/libstub/tpm.c b/drivers/firmware/ 
>>> efi/libstub/tpm.c
>>> index df3182f2e63a..1fd6823248ab 100644
>>> --- a/drivers/firmware/efi/libstub/tpm.c
>>> +++ b/drivers/firmware/efi/libstub/tpm.c
>>> @@ -96,7 +96,7 @@ static void efi_retrieve_tcg2_eventlog(int version, 
>>> efi_physical_addr_t log_loca
>>>       }
>>>       /* Allocate space for the logs and copy them. */
>>> -    status = efi_bs_call(allocate_pool, EFI_LOADER_DATA,
>>> +    status = efi_bs_call(allocate_pool, EFI_ACPI_RECLAIM_MEMORY,
>>>                    sizeof(*log_tbl) + log_size, (void **)&log_tbl);
>>
>> Hi,
>>
>> this, for some reason, corrupts system configuration table. On good 
>> boots, memattr points to 0x77535018, on bad boots (this commit 
>> applied), it points to 0x77526018.
>>
>> And the good content at 0x77526018:
>> tab=0x77526018 size=16+45*48=0x0000000000000880
>>
>> bad content at 0x77535018:
>> tab=0x77535018 size=16+2*1705353216=0x00000000cb4b4010
>>
>> This happens only on cold boots. Subsequent boots (having the commit 
>> or not) are all fine.
>>
>> Any ideas?
> 
> ====
> EFI_ACPI_RECLAIM_MEMORY
> 
> This memory is to be preserved by the UEFI OS loader and OS until ACPI
> is enabled. Once ACPI is enabled, the memory in this range is available 
> for general use.
> ====
> 
> BTW doesn't the above mean it is released by the time TPM actually reads 
> it?
> 
> Isn't the proper fix to actually memblock_reserve() that TPM portion. 
> The same as memattr in efi_memattr_init()?

And this is actually done in efi_tpm_eventlog_init().

>> DMI: Dell Inc. Latitude 7290/09386V, BIOS 1.39.0 07/04/2024
>>
>> This was reported downstream at:
>> https://bugzilla.suse.com/show_bug.cgi?id=1231465
>>
>> thanks,

-- 
js
suse labs


