Return-Path: <linux-efi+bounces-2068-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DDF79B6C09
	for <lists+linux-efi@lfdr.de>; Wed, 30 Oct 2024 19:24:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D30F281819
	for <lists+linux-efi@lfdr.de>; Wed, 30 Oct 2024 18:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 683711C9EBB;
	Wed, 30 Oct 2024 18:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e+JchJUs"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE621BD9DF;
	Wed, 30 Oct 2024 18:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730312669; cv=none; b=Yv45YavbUV8Gx2gighivtBA91x7Gf5/jk7LPQthgL3wMgffUUf9XUQjzbdsnqFBzmutrQHHQA8efEzw8h5pmzj0cV0DoEC95nbLfO4fqm406y7nRMW4l66IJL+hQSdJnDSVMJsmFtezcrTYlCKI2eWtKr9bNp6+0XUippNdblIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730312669; c=relaxed/simple;
	bh=G05/90DQz3OSIbUTMmUWfCp/U3U+pZF1D4h43q8+hn8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kArM9UIibFFIlCTJ4PTyGFbm4cfix7lN6639S7exbjJdW+23xy3WtRQZcVhLHohFFLRQHKmAdkqEutQgIfgQ0qyLESy6sJE8I6oW2XjLohd6WEjaaezZfvXkBqdSAzVoB6+fpNpnXntxq4fLo/Fc1fQO+S9jPvKDw4jm+vGdmOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e+JchJUs; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-37d473c4bb6so111083f8f.3;
        Wed, 30 Oct 2024 11:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730312664; x=1730917464; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P/P07SRvG2cOwl8/ttJHJzaFtHcH1icuUS4rqrKr/98=;
        b=e+JchJUsbKxV1GuQN736BTElKMKxhJaRIEarfFhMyRyXN24Purq4CSg0uPfxXpG8tG
         6lqAfYV6UAqHzYftVRugckJZlJcLOMoAiApKst7ogUai0Ro0QlDY2/4kCBl8u+ipXQaK
         0J2FymHc9jWS6S+BkCoDmDk3zCubM5Du5rQ5dm64iCtTg5/JbCmzNFATSNerNDJPYsnV
         cxHSQkhTRK8q6oAiBJiVi8/DJlAcl8drbKqNV3vWZJSqaTAFHZF1wITEhilgwrOOAe7W
         3ojQd1vfxkn/xp7qNZkwZ9IQ7lWQgDcAexrTQ2/SK6zKQ1Pr8xulbb2KWUlpD+U6oNQi
         KgOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730312664; x=1730917464;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P/P07SRvG2cOwl8/ttJHJzaFtHcH1icuUS4rqrKr/98=;
        b=gnTJ6E6YwmX5G4vjCNpXMg4mHShSinhjUg7ccS/nrmN3rUkE5q2jH4bSGYal63eD4f
         bYiuuvdT0UT9F9dGeEspB3oRynwaOf1sDt1gPRsiw6XhKwpfTIjHV8FZ7aagLaoR/mM+
         hsGpBfRFwLWxOIJaoZaDMsQcMXcgHAZMnKc247GcniALrJ8gQ/cud22YHvOQ2b8JxPO0
         2yetbs1f/pWPUuyKLEWnC6KssxXAd7BOg8E/5qn1xCo+MHxhqjZzL3EWeizrNwsLWxIB
         IMVYeVd/OFgEZUtb6V0isJNRxC2jg4MkQYT6rudZXgQpMOaN5s6HDgeK2bjq0oWDqMtl
         zBOg==
X-Forwarded-Encrypted: i=1; AJvYcCWyU3mFCbuW3KoYbeSNJUQl5gyYDyuwP5FMN8SlTB5FqeNmcf/BuIxmcQtK5Io1LSglB1czPkh0XD0=@vger.kernel.org, AJvYcCXZqY0dM5O2sjrw53z92DPDpdUNp3f9oDEivaT1Be90cLBxF7rpfs9ya5crZju3ggAmHgaDN9Fs@vger.kernel.org
X-Gm-Message-State: AOJu0YxSbxG5FJMVU4J7+C82/OKBUzvcLFn7RjZmc33q3BumD8jqrzSG
	1AtRF4kdCWIWFR88QpOMClmYnanwSXkRBbCT51TeNS87ca9XwCf7
X-Google-Smtp-Source: AGHT+IFTVm7uSbl5A61OL/0tG5zsjtNPDAEp/KInlE5iN6rCBBNknKQuvPfYYDMIlFV4LFcPwKez6Q==
X-Received: by 2002:adf:f10a:0:b0:37d:4b26:54ca with SMTP id ffacd0b85a97d-38061171f6bmr15466933f8f.14.1730312664198;
        Wed, 30 Oct 2024 11:24:24 -0700 (PDT)
Received: from ?IPV6:2a02:6b67:d751:7400:c2b:f323:d172:e42a? ([2a02:6b67:d751:7400:c2b:f323:d172:e42a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b3c1f7sm16021185f8f.43.2024.10.30.11.24.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Oct 2024 11:24:23 -0700 (PDT)
Message-ID: <30899696-def7-4f1e-a54b-65fc6901a998@gmail.com>
Date: Wed, 30 Oct 2024 18:24:23 +0000
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] efistub/tpm: Use ACPI reclaim memory for event log to
 avoid corruption
To: Gregory Price <gourry@gourry.net>, Jiri Slaby <jirislaby@kernel.org>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-efi@vger.kernel.org,
 Ard Biesheuvel <ardb@kernel.org>, stable@vger.kernel.org,
 Breno Leitao <leitao@debian.org>
References: <20240912155159.1951792-2-ardb+git@google.com>
 <ec7db629-61b0-49aa-a67d-df663f004cd0@kernel.org>
 <29b39388-5848-4de0-9fcf-71427d10c3e8@kernel.org>
 <58da4824-523c-4368-9da1-05984693c811@kernel.org>
 <899f209b-d4ec-4903-a3e6-88b570805499@gmail.com>
 <b7501b2c-d85f-40aa-9be5-f9e5c9608ae4@kernel.org>
 <e42149a6-7c1f-48d1-be94-1c1082b450e0@gmail.com>
 <ZyJ0r_zZ5UD8pvzX@PC2K9PVX.TheFacebook.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <ZyJ0r_zZ5UD8pvzX@PC2K9PVX.TheFacebook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 30/10/2024 18:02, Gregory Price wrote:
> On Wed, Oct 30, 2024 at 05:13:14PM +0000, Usama Arif wrote:
>>
>>
>> On 30/10/2024 05:25, Jiri Slaby wrote:
>>> On 25. 10. 24, 15:27, Usama Arif wrote:
>>>> Could you share the e820 map, reserve setup_data and TPMEventLog address with and without the patch?
>>>> All of these should be just be in the dmesg.
>>>
>>> It's shared in the aforementioned bug [1] already.
>>>
>>> 6.11.2 dmesg (bad run):
>>> https://bugzilla.suse.com/attachment.cgi?id=877874
>>>
>>> 6.12-rc2 dmesg (good run):
>>> https://bugzilla.suse.com/attachment.cgi?id=877887
>>>
>>> FWIW from https://bugzilla.suse.com/attachment.cgi?id=878051:
>>> good TPMEventLog=0x682aa018
>>> bad  TPMEventLog=0x65a6b018
>>>
>>> [1] https://bugzilla.suse.com/show_bug.cgi?id=1231465
>>>
> ... snip ...
>>> efi: EFI v2.6 by American Megatrends
>>> efi: ACPI=0x7a255000 ACPI 2.0=0x7a255000 SMBIOS=0x7b140000 SMBIOS 3.0=0x7b13f000 TPMFinalLog=0x7a892000 ESRT=0x7b0deb18 [-MEMATTR=0x77535018-] {+MEMATTR=0x77526018+} MOKvar=0x7b13e000 RNG=0x7a254018 [-TPMEventLog=0x65a6f018-] {+TPMEventLog=0x682ac018+}
>>>
>>>
>>> thanks,
>>
>> Thanks for sharing this.
>>
>> This looks a bit weird for me.
>>
>> The issue this patch was trying to fix was TPMEventLog being overwritten during kexec.
>> We are using efi libstub.
>> Without this patch we would see
>> BIOS-e820: [mem 0x0000000000100000-0x0000000064763fff] usable 
>> TPMEventLog=0x5ed47018
>> i.e. TPMEventLog was usable memory and therefore was prone to corruption during kexec.
>>
>> With this patch 
>> BIOS-e820: [mem 0x00000000a8c01000-0x00000000a8cebfff] ACPI data
>> TPMEventLog=0xa8ca8018 
>> i.e.  TPMEventLog is reserved as ACPI data, hence cant be corrupted during kexec.
>>
>>
>> In your case, from the logs you shared, good run without the patch:
>> [    0.000000] [      T0] BIOS-e820: [mem 0x0000000065a6f000-0x0000000065a7dfff] ACPI data
>> [    0.000000] [      T0] BIOS-e820: [mem 0x0000000065a7e000-0x000000006a5acfff] usable
>> [    0.000000] [      T0] BIOS-e820: [mem 0x000000006a5ad000-0x000000006a5adfff] ACPI NVS
>> TPMEventLog=0x65a6f018 
>> bad run with the patch:
>> [    0.000000] [      T0] BIOS-e820: [mem 0x00000000682ac000-0x00000000682bafff] ACPI data
>> [    0.000000] [      T0] BIOS-e820: [mem 0x00000000682bb000-0x000000006a5acfff] usable
>> [    0.000000] [      T0] BIOS-e820: [mem 0x000000006a5ad000-0x000000006a5adfff] ACPI NVS
>> TPMEventLog=0x682ac018
>> Both with and without the fix, the TPMEventLog is part of ACPI data.
>>
> 
> Just wondering - why would the TPM log move a total of ~40MB between COLD boots.
> 
> I would expect this location to be relatively fixed (give or take a small amount of
> memory) - especially since it's so early in boot.
> 

This is a good point. I think if we suspect this patch, it would be good to compare
dmesg of kernel cold boot with this patch vs the commit just before this patch, rather
than comparing with 6.12.

Thanks

>> It means your firmware has already marked that area as ACPI data. Are you using efi/libstub?
>>
>> Thanks,
>> Usama
>>
>>
>>
>>


