Return-Path: <linux-efi+bounces-1725-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69301977E30
	for <lists+linux-efi@lfdr.de>; Fri, 13 Sep 2024 13:07:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27B0B283786
	for <lists+linux-efi@lfdr.de>; Fri, 13 Sep 2024 11:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C34B1D86C3;
	Fri, 13 Sep 2024 11:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ap4lro+l"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8DC91D47BF;
	Fri, 13 Sep 2024 11:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726225619; cv=none; b=UUuFwibM44xxdnxTWxmmQ9uDu78DaxUWjMsGdXKFAyL2t1fH9MChpHxrHaE+kM7+bK1C0z4Yq+SsvjgT7pyaize2dUZQSA1HKQ9X2zklVgHkFxpg4TDCMhqQTf4/XxaC0IF+AaYHOnBHcskL9xDTKsobtJMA9MnRYO6K99qE+1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726225619; c=relaxed/simple;
	bh=SzZR+wWqtvbb6fL9dYQUHh5w7woOAMZa33MzsHXZ4dM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q/gsh/8p8lD2gEH8x7KODjTDcul3biehtcUDCRVOQkQF2FTY4hNqnKquzSoVcUEjt9ct8JHKKCTwhubGFHG3Bmn/OVgC5Ww+INdMJFqwyxfb8NO/XJnbWcYB2szWEXYiyRTYUdUDQP2UXDV2VNJ1eur50qkHNsB/dqcJXY/0TWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ap4lro+l; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a8a7cdfdd80so116169466b.0;
        Fri, 13 Sep 2024 04:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726225616; x=1726830416; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CFdQ0EzFUbNiBdx0MjAaEserQ2Pnrtzma67XilXfJi8=;
        b=ap4lro+lRMbLeGEhQHdG7HxMxjIIer0GsExdm1oNn1JtXeEGMR3ddHYvra8583qjFN
         vFj//Q1JymR0SYR13gT1+DtpjxkJ23Dst5pfB/qAtX8/xVuB4BMYtYFCjZkppbB0q/bZ
         lW6Rf0DdUHsYA9ZjVuo5bt6YsrTRODV7PmTWXw/GWXzW04bS5f5IJBdmEAC84OAw4mTd
         MPLlZLBU1aFNlMXBZpZqzEkuV6M4uhMe0zhApA3U8LWHH9LbBqv/iJVTWluhjSb9+l8N
         +jT/s1YCPFtTm3J9a5W0FGpbvGnKpvseN+AD6uuDrix8bwGsxp9FiNb4P7M8qhIgi8fQ
         e1ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726225616; x=1726830416;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CFdQ0EzFUbNiBdx0MjAaEserQ2Pnrtzma67XilXfJi8=;
        b=VpZY2ukw9YiUYPS2X3gSCF7NWo1h5n8LGGdleXsgqACKEOfIHLUL3HBsfpmXolpY8A
         TtnjzVug/ppyzCzBOI2dV6l4lsHTP5pQ2O//pROFT2VBji3pb3rdGpHEi6hoYG4zMj7I
         SI+0r20WqSiFIXo1ogJVXsPaYnqC+cxstHMihS/ArXgnsL6bIIh6NX4ylHjdoSoNtCEJ
         G+u5wPkY4vxdiGszhe0gCtPyHHxl+7qlyYTpD6c2Omx1iLg2/M6qB5Y4Mmh4gnqiL01J
         JPB9pnuDpmc/esaNkQcbHRi/uPdjhPDDgRUpVKznXn0W1GlzCyTD6yKFwlGUKv03j+bN
         9nsw==
X-Forwarded-Encrypted: i=1; AJvYcCU0L87Blo6awsRN3XcnuWql/vowGuPjN26ZuJ6pFjcfqRYAOHYlRonL6GardU9ogbSo1bVFhwu0SOM=@vger.kernel.org, AJvYcCUIQ3e7By+qOnSM/YqrGnwCtztlVjXikYlWGmgqVd0s/AAS5dqhXynDB2+DjUKHIj+EcOHMdR+uSVZeGHmC@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8gRdK+nODQcCyVSMbu44gsaMA+aMlHBGfd/pOzeHEAHPhtbOw
	6+C7TTpHavtdf5o1yRERKQNCPhEHYCCxuC25T3GL6UjLxPQx32eb
X-Google-Smtp-Source: AGHT+IEbuqZYHatkDhQKEvJhMn72YTY/AmGM3pWNQOzzeCGUq6TJmY5yCDpCdEfcdYIYgcHP9h/MNQ==
X-Received: by 2002:a17:907:724e:b0:a8a:8c04:ce95 with SMTP id a640c23a62f3a-a90481087f5mr189076766b.43.1726225615341;
        Fri, 13 Sep 2024 04:06:55 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:eb:d0d0:c7fd:c82c? ([2620:10d:c092:500::4:ee51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25953275sm859159266b.70.2024.09.13.04.06.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Sep 2024 04:06:54 -0700 (PDT)
Message-ID: <1c37546a-e15e-465f-bcbb-6f39c0fcf82d@gmail.com>
Date: Fri, 13 Sep 2024 12:06:54 +0100
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] efi/tpm: add efi.tpm_log as a reserved region in
 820_table_firmware
To: Dave Young <dyoung@redhat.com>, Ard Biesheuvel <ardb@kernel.org>
Cc: Breno Leitao <leitao@debian.org>, linux-efi@vger.kernel.org,
 kexec@lists.infradead.org, ebiederm@xmission.com, bhe@redhat.com,
 vgoyal@redhat.com, tglx@linutronix.de, dave.hansen@linux.intel.com,
 x86@kernel.org, linux-kernel@vger.kernel.org, rmikey@meta.com,
 gourry@gourry.net
References: <20240911104109.1831501-1-usamaarif642@gmail.com>
 <CAMj1kXFVyQEwBTf2bG8yBXUktM16dzrcPH-Phz_toAsCK-NfMA@mail.gmail.com>
 <2542182d-aa79-4705-91b6-fa593bacffa6@gmail.com>
 <CAMj1kXGi+N6AukJt6EGQTao=-1Ud_=bzwPvdjEzhmzEraFU98w@mail.gmail.com>
 <20240912-wealthy-gabby-tamarin-aaba3c@leitao>
 <CAMj1kXHh-Kov8c1pto0LJL6debugz1og6GFMYCwvfu+RiQGreA@mail.gmail.com>
 <6b2cc4c4-4354-4b29-bc73-c1384b90dfc6@gmail.com>
 <CAMj1kXG1hbiafKRyC5qM1Vj5X7x-dmLndqqo2AYnHMRxDz-80w@mail.gmail.com>
 <CAMj1kXFr+N9LMj0=wULchYosUpV0ygZSKUj1vdUP0KWEANKasw@mail.gmail.com>
 <CALu+AoS9+OxPmVJB9fAJFkjsX9xUVw6K_uXiOi0-XsK6-b4THg@mail.gmail.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <CALu+AoS9+OxPmVJB9fAJFkjsX9xUVw6K_uXiOi0-XsK6-b4THg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 13/09/2024 11:56, Dave Young wrote:
> On Thu, 12 Sept 2024 at 22:15, Ard Biesheuvel <ardb@kernel.org> wrote:
>>
>> (cc Dave)
> 
> Thanks for ccing me.
> 
>>
>> Full thread here:
>> https://lore.kernel.org/all/CAMj1kXG1hbiafKRyC5qM1Vj5X7x-dmLndqqo2AYnHMRxDz-80w@mail.gmail.com/T/#u
>>
>> On Thu, 12 Sept 2024 at 16:05, Ard Biesheuvel <ardb@kernel.org> wrote:
>>>
>>> On Thu, 12 Sept 2024 at 15:55, Usama Arif <usamaarif642@gmail.com> wrote:
>>>>
>>>>
>>>>
>>>> On 12/09/2024 14:10, Ard Biesheuvel wrote:
>>>>> Does the below help at all?
>>>>>
>>>>> --- a/drivers/firmware/efi/tpm.c
>>>>> +++ b/drivers/firmware/efi/tpm.c
>>>>> @@ -60,7 +60,7 @@ int __init efi_tpm_eventlog_init(void)
>>>>>         }
>>>>>
>>>>>         tbl_size = sizeof(*log_tbl) + log_tbl->size;
>>>>> -       memblock_reserve(efi.tpm_log, tbl_size);
>>>>> +       efi_mem_reserve(efi.tpm_log, tbl_size);
>>>>>
>>>>>         if (efi.tpm_final_log == EFI_INVALID_TABLE_ADDR) {
>>>>>                 pr_info("TPM Final Events table not present\n");
>>>>
>>>> Unfortunately not. efi_mem_reserve updates e820_table, while kexec looks at /sys/firmware/memmap
>>>> which is e820_table_firmware.
>>>>
>>>> arch_update_firmware_area introduced in the RFC patch does the same thing as efi_mem_reserve does at
>>>> its end, just with e820_table_firmware instead of e820_table.
>>>> i.e. efi_mem_reserve does:
>>>>         e820__range_update(addr, size, E820_TYPE_RAM, E820_TYPE_RESERVED);
>>>>         e820__update_table(e820_table);
>>>>
>>>> while arch_update_firmware_area does:
>>>>         e820__range_update_firmware(addr, size, E820_TYPE_RAM, E820_TYPE_RESERVED);
>>>>         e820__update_table(e820_table_firmware);
>>>>
>>>
>>> Shame.
>>>
>>> Using efi_mem_reserve() is appropriate here in any case, but I guess
>>> kexec on x86 needs to be fixed to juggle the EFI memory map, memblock
>>> table, and 3 (!) versions of the E820 table in the correct way
>>> (e820_table, e820_table_kexec and e820_table_firmware)
>>>
>>> Perhaps we can put this additional logic in x86's implementation of
>>> efi_arch_mem_reserve()? AFAICT, all callers of efi_mem_reserve() deal
>>> with configuration tables produced by the firmware that may not be
>>> reserved correctly if kexec looks at e820_table_firmware[] only.
>>
> 
> I have not read all the conversations,  let me have a look and response later.
> 
> The first glance about the patch is that I think the kexec_file_load
> syscall (default of latest kexec-tools) will not use
> e820_table_firmware AFAIK.  it will only use e820_table_kexec.

I initially thought that as well. But it looks like kexec just reads /sys/firmware/memmap

https://github.com/horms/kexec-tools/blob/main/kexec/firmware_memmap.h#L29

which is e820_table_firmware.

The patch that Ard sent in https://lore.kernel.org/all/20240912155159.1951792-2-ardb+git@google.com/
is the right approach to it I believe, and I dont see the issue anymore after applying that patch.

> 
> Usama, can you confirm how you tested this?
> kexec -c -l  will use kexec_load syscall

I am currently testing in my VM setup with kexec_load. But production is running
kexec_file_load and has the same issue.

Thanks,
Usama

> kexec [-s] -l will use kexec_file_load syscall
> 
> Thanks
> Dave
> 


