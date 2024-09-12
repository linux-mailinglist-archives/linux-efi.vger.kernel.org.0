Return-Path: <linux-efi+bounces-1714-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C478E976DD7
	for <lists+linux-efi@lfdr.de>; Thu, 12 Sep 2024 17:35:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E91F11C22080
	for <lists+linux-efi@lfdr.de>; Thu, 12 Sep 2024 15:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56A5E1B4C21;
	Thu, 12 Sep 2024 15:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aDWU/RrV"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E1D44C8F;
	Thu, 12 Sep 2024 15:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726155312; cv=none; b=UysS6EN2f4EzeRWs6I/iY8hB1ixJXji0OlS6tLSiU5W1LwymoUeza4SIVwSPNumPimWlQz5p3xqaUeW+lQBSrBvF6L8xrqAOqw/Fi3PqHtjRiGVDg+RZ5g6slIpYtq7bh+DRbalH2Qypj5gc35SQWj+Wq1ViAepK77ChT0Zv8Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726155312; c=relaxed/simple;
	bh=GgF9WySBxWg/HnwUpSa2FLnApHM1oc0hTz1Cn6WwaVE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d30A0o01f0IWlym7J8fOl3CKNdnkQqsBKENPDMtonFUBaZrSIkqzrrFHmSjZxXMd10egJ9yLOKbbEZym2XgNWhOcbigub/pvmyB2k/95leRDPnhuDpCbWQpQeIvmXbJbUZCy2PN0gnYlKOcwp9ET1Xvw0OjWG6P0tVwR6H/JFK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aDWU/RrV; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-378c16a4d3eso1331556f8f.1;
        Thu, 12 Sep 2024 08:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726155309; x=1726760109; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P0RYORsO9RSRQ8Ioex3F7hf3hojejMNnxlRBDN5pkaA=;
        b=aDWU/RrV8RpJ430EqSxHIWRty1fUB1BUn+PgiTsHYVVgYsbdTJb9C7a/nz5XajmbYc
         5U+ypqh5ulxk9vi+pjhMuW3zMVAeIlUe7T933YP2ocUVxpz1ghNO3wf8Q74KC2jkopbo
         4kZW/t60wXpQ8TrDeLvhA9oUlO/y7BlTcU6+OxTghLioZk/A6UN+YMHxtO4leYF1QDUx
         nMK1Ja2eFgDamZK7rPfMeK+gOYbLXKOloyQuPeImZFuh2EV1e7n3ZCsfT15bTEJjEhqz
         S2dtmwAVdam8/ZcxyWZ6S+WUwrtlz6/lwETlwR9aaPUV74TA1cUODZIVp71R5ZiBzeds
         WS7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726155309; x=1726760109;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P0RYORsO9RSRQ8Ioex3F7hf3hojejMNnxlRBDN5pkaA=;
        b=mr7xcp50jOh6eAoa93qmyGQhMxa8XF6t8qSrOz0vOm0aMQJzT1dov16EvmVBHWFL9E
         uhDkRvCgw0OgynwUkXxeTKHi151yMgs9UrbS95ughFS+fOGwbYgcCYw+7xLjP1HDxGCm
         CN1Iu7Q8FYBeF+E1zVWlhGyyMa+4vYDXNItIvWgKP9bggQjauMv/hYaOuCeCaJLnhU+x
         pKuvDCWmEATlfNDU1hOMfGuePdW01uuGcEp2s7VHqsU5r0GnUvmIaxJ2D6mLKJ9gIt+l
         W21E7rbXUpJu9xfShZM4gJf03wRMNqBjTLYvX/tIYC+RVoDqG3wN6nGxKCTKiWhnMjaE
         YsmA==
X-Forwarded-Encrypted: i=1; AJvYcCULq5JAEr38w5cZOS9W1Ia4448KZxUsJoxdsYel3+Ng9Szs63a/LUSs+K2J4suNl1cf1jm80+YEyEV9O4w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyte3coJLz59rWyo6RwBgB11Xkw0UCMms9iCMJvJ3cRB55JY5Lc
	WwFqvj12RF8Xp6Kr2tesb7FAe5o41BWkPEmrv/6SzGiVup7jC0Ge
X-Google-Smtp-Source: AGHT+IFXuaRB4REQ196i6uJBPCKixLywzCDFF6ZO0mWYedPQxpp3dIPVKUmizW8iLHQMtjHNotnZeA==
X-Received: by 2002:a5d:67d0:0:b0:374:d29e:6db8 with SMTP id ffacd0b85a97d-378c2cf4ad4mr2768741f8f.16.1726155307755;
        Thu, 12 Sep 2024 08:35:07 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:eb:d0d0:c7fd:c82c? ([2620:10d:c092:500::6:5725])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25a27a9fsm756906866b.91.2024.09.12.08.35.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Sep 2024 08:35:07 -0700 (PDT)
Message-ID: <9d3962f1-96b6-44a3-a7d3-10fbfbe06164@gmail.com>
Date: Thu, 12 Sep 2024 16:35:06 +0100
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] efi/tpm: add efi.tpm_log as a reserved region in
 820_table_firmware
To: Ard Biesheuvel <ardb@kernel.org>, Breno Leitao <leitao@debian.org>
Cc: linux-efi@vger.kernel.org, kexec@lists.infradead.org,
 ebiederm@xmission.com, bhe@redhat.com, vgoyal@redhat.com,
 tglx@linutronix.de, dave.hansen@linux.intel.com, x86@kernel.org,
 linux-kernel@vger.kernel.org, rmikey@meta.com, gourry@gourry.net
References: <20240911104109.1831501-1-usamaarif642@gmail.com>
 <CAMj1kXFVyQEwBTf2bG8yBXUktM16dzrcPH-Phz_toAsCK-NfMA@mail.gmail.com>
 <2542182d-aa79-4705-91b6-fa593bacffa6@gmail.com>
 <CAMj1kXGi+N6AukJt6EGQTao=-1Ud_=bzwPvdjEzhmzEraFU98w@mail.gmail.com>
 <20240912-wealthy-gabby-tamarin-aaba3c@leitao>
 <CAMj1kXHh-Kov8c1pto0LJL6debugz1og6GFMYCwvfu+RiQGreA@mail.gmail.com>
 <20240912-sapphire-koala-of-focus-918cff@leitao>
 <CAMj1kXG842OSYu4GPm-ocyvpBDowPGaXAftqGExxjZ4=dGyt5g@mail.gmail.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <CAMj1kXG842OSYu4GPm-ocyvpBDowPGaXAftqGExxjZ4=dGyt5g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/09/2024 16:21, Ard Biesheuvel wrote:
> On Thu, 12 Sept 2024 at 16:29, Breno Leitao <leitao@debian.org> wrote:
>>
>> On Thu, Sep 12, 2024 at 03:10:43PM +0200, Ard Biesheuvel wrote:
>>> On Thu, 12 Sept 2024 at 15:03, Breno Leitao <leitao@debian.org> wrote:
>>>> On Thu, Sep 12, 2024 at 12:51:57PM +0200, Ard Biesheuvel wrote:
>>>>> I don't see how this could be an EFI bug, given that it does not deal
>>>>> with E820 tables at all.
>>>>
>>>> I want to back up a little bit and make sure I am following the
>>>> discussion.
>>>>
>>>> From what I understand from previous discussion, we have an EFI bug as
>>>> the root cause of this issue.
>>>>
>>>> This happens because the EFI does NOT mark the EFI TPM event log memory
>>>> region as reserved (EFI_RESERVED_TYPE).
>>>
>>> Why do you think EFI should use EFI_RESERVED_TYPE in this case?
>>>
>>> The EFI spec is very clear that EFI_RESERVED_TYPE really shouldn't be
>>> used for anything by EFI itself. It is quite common for EFI
>>> configuration tables to be passed as EfiRuntimeServicesData (SMBIOS),
>>> EfiBootServicesData (ESRT) or EFiAcpiReclaim (ACPI tables).
>>>
>>> Reserved memory is mostly for memory that even the firmware does not
>>> know what it is for, i.e., particular platform specific uses.
>>>
>>> In general, it is up to the OS to ensure that EFI configuration tables
>>> that it cares about should be reserved in the correct way.
>>
>> Thanks for the explanation.
>>
>> So, if I understand what you meant here, the TPM event log memory range
>> shouldn't be listed as a memory region in EFI memory map (as passed by
>> the firmware to the OS).
>>
>> Hence, this is not a EFI firmware bug, but a OS/Kernel bug.
>>
>> Am I correct with the statements above?
>>
> 
> No, not entirely. But I also missed the face that this table is
> actually created by the EFI stub in Linux, not the firmware. It is
> *not* the same memory region that the TPM2 ACPI table describes, and
> so what the various specs say about that is entirely irrelevant.
> 
> The TPM event log configuration table is created by the EFI stub,
> which uses the TCG2::GetEventLog () protocol method to obtain it. This
> must be done by the EFI stub because these protocols will no longer be
> available once the OS boots. But the data is not used by the EFI stub,
> only by the OS, which is why it is passed in memory like this.
> 
> The memory in question is allocated as EFI_LOADER_DATA, and so we are
> relying on the OS to know that this memory is special, and needs to be
> preserved.
> 
> I think the solution here is to use a different memory type:
> 
> --- a/drivers/firmware/efi/libstub/tpm.c
> +++ b/drivers/firmware/efi/libstub/tpm.c
> @@ -96,7 +96,7 @@ static void efi_retrieve_tcg2_eventlog(int version,
> efi_physical_addr_t log_loca
>         }
> 
>         /* Allocate space for the logs and copy them. */
> -       status = efi_bs_call(allocate_pool, EFI_LOADER_DATA,
> +       status = efi_bs_call(allocate_pool, EFI_ACPI_RECLAIM_MEMORY,
>                              sizeof(*log_tbl) + log_size, (void **)&log_tbl);
> 
>         if (status != EFI_SUCCESS) {
> 
> which will be treated appropriately by the existing EFI-to-E820
> conversion logic.

I have tested above diff, and it works! No memory corruption.

The region comes up as ACPI data:
[    0.000000] BIOS-e820: [mem 0x000000007fb6d000-0x000000007fb7efff] ACPI data                                                                                                                               

and kexec doesnt interfere with it.

Thanks,
Usama


