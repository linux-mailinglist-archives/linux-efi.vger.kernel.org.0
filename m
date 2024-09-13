Return-Path: <linux-efi+bounces-1728-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF54977F0B
	for <lists+linux-efi@lfdr.de>; Fri, 13 Sep 2024 13:57:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B7511C20DDA
	for <lists+linux-efi@lfdr.de>; Fri, 13 Sep 2024 11:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A28A1DA622;
	Fri, 13 Sep 2024 11:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k+PnhkaL"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4381D88C3;
	Fri, 13 Sep 2024 11:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726228574; cv=none; b=N+ArrEWpVAFP1aJZg1WrP+ydQrS+H6UyEKKIzt/V1EfFefx16EO66zgU9B8oPY6QZ1zswHf2SI83k8e1SkdetkPOltBmI19W5VgQEZsz8KMkDpkVfBIV63jCHeFilZ9tCY6X8uMkPGSKpE/r64rhFYuDnFLZYkBMu7Q4N71P+Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726228574; c=relaxed/simple;
	bh=Q9jsi66z1TiK7SmLAMqdwMujyoeg40KVT6Yy1YZJv4o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mytVw2HSKRPRUJzTSUN2zj8fSiML5izz0Unmu4w7vx2ihUK06omjNtLiJzY42+UEYfpsn96pBu85N5Yi/o+7Xj1PWdKgjoEc6mSpo1xbji2rrYLMdFV2iPIFbsUap9FZSlvE+V6ZlSfZjSIjXTemj5mDN8sRGoZGdA+lYYf5V18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k+PnhkaL; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a8ce5db8668so322532766b.1;
        Fri, 13 Sep 2024 04:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726228571; x=1726833371; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iZVgyOq08t6c939Zv1hA/wZvhoamsw4yMbHzCIvHf5c=;
        b=k+PnhkaLNHilch/doCZIpTFTov+jhfBfMW5Q8GrH67ii3NfkYnRi85aolbjfuiJoEZ
         zgBIoR69KXqjXeb9TCKrmk1cxH7BQhG3w7Nq1IiDrF217ts8LHOFjBzZ6DeOvRzPGRbp
         HdkGgn6cIHkwFoHj+xTG+cvwpDRitiOb1YDTaOBOp8dl1ZtkHJ9ZhU5vcBiblGolp6f3
         cD7T0q1D6wdmNBSmWcSI0pi0T79FXNyw36O5uXlsIz2y1JmANkGfNWD1Tx22hNAkj1E1
         z74B1Txt9uq8H6CPjVrLYXGYgiEAgmaiOnZZSGzBN+V3q/u3STe7RYZtAXTc5CufG+vc
         Zu8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726228571; x=1726833371;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iZVgyOq08t6c939Zv1hA/wZvhoamsw4yMbHzCIvHf5c=;
        b=vGQq93yIc0N3ayVFRrEKdpTcqyYQIq1VAseRz+lTNFczHFzdv3jhHsgkKauK7Czi3H
         d7JKPRpK66649WZ4QrSVBAUPNAYb/cZpTDHiWoachkXuD/zooVnihD2nE6pKrlVTnmzH
         1yF4+a0833AVqr/hBgUQg2crLImrAsLTGABzvHyxHmMsi8L045ye6hZkLD4bJlI3pQab
         IrcXkhsdbjMrBGoEj5OBKuUftqBB2rVJUD2wML0WcZHKHL1TBUCST7zpAaSm7W3Ygi0V
         5BooepvIUkGAA0A6r/BxOWVG9LAML5OoI5+e3fDVFJe6nCrWEtYwwHJ+bviU11xYBNPU
         9x0g==
X-Forwarded-Encrypted: i=1; AJvYcCWeEImuthKDanRLQiv9ydTSUFctHLJTavidS9W5SW9KzuaLhmLcXraCqEfBCy4Ff8WU0KdagNYhNp4=@vger.kernel.org, AJvYcCWv9JAFsIYjCjX9Z/vkcfL1+ZcgdbZgJnXvJZgTaPi4nb0PN8k0Hsy9L1Op7Tn4kxG8kKx/SeiyW+VDmrII@vger.kernel.org
X-Gm-Message-State: AOJu0YzY2u/cxK6twCDo5Zy2NrCNwFExHjwrOy6wZwszs4ymkxjkUrJN
	SJl147U4M3q9EFdDY7cKp02p2VUsT3K75GBlXPqFtSmiAtTnGzX/
X-Google-Smtp-Source: AGHT+IEhQuxf9thQXUjHxx1/3t0J4k6xSec2pXjJJawLJF7J41sOP3r4s3o1fAPjIA1Dk3yJhLptbg==
X-Received: by 2002:a17:907:d843:b0:a77:b01b:f949 with SMTP id a640c23a62f3a-a90294995b8mr587694266b.35.1726228569887;
        Fri, 13 Sep 2024 04:56:09 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:eb:d0d0:c7fd:c82c? ([2620:10d:c092:500::4:ee51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25a2c441sm863941466b.90.2024.09.13.04.56.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Sep 2024 04:56:09 -0700 (PDT)
Message-ID: <c76e9653-d991-4319-8924-5883e6829d17@gmail.com>
Date: Fri, 13 Sep 2024 12:56:08 +0100
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] efi/tpm: add efi.tpm_log as a reserved region in
 820_table_firmware
To: Dave Young <dyoung@redhat.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, Breno Leitao <leitao@debian.org>,
 linux-efi@vger.kernel.org, kexec@lists.infradead.org, ebiederm@xmission.com,
 bhe@redhat.com, vgoyal@redhat.com, tglx@linutronix.de,
 dave.hansen@linux.intel.com, x86@kernel.org, linux-kernel@vger.kernel.org,
 rmikey@meta.com, gourry@gourry.net
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
 <1c37546a-e15e-465f-bcbb-6f39c0fcf82d@gmail.com>
 <CALu+AoQ_Db=1naa1YffvdV7ziY8FPzugUutw6ggg8O5P0Z2ofA@mail.gmail.com>
 <CALu+AoSdN4Zh5gPbyTGS8gJ7wDFfOq81ANNH4wmv3z1vs-34Rw@mail.gmail.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <CALu+AoSdN4Zh5gPbyTGS8gJ7wDFfOq81ANNH4wmv3z1vs-34Rw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 13/09/2024 12:49, Dave Young wrote:
> On Fri, 13 Sept 2024 at 19:13, Dave Young <dyoung@redhat.com> wrote:
>>
>> On Fri, 13 Sept 2024 at 19:07, Usama Arif <usamaarif642@gmail.com> wrote:
>>>
>>>
>>>
>>> On 13/09/2024 11:56, Dave Young wrote:
>>>> On Thu, 12 Sept 2024 at 22:15, Ard Biesheuvel <ardb@kernel.org> wrote:
>>>>>
>>>>> (cc Dave)
>>>>
>>>> Thanks for ccing me.
>>>>
>>>>>
>>>>> Full thread here:
>>>>> https://lore.kernel.org/all/CAMj1kXG1hbiafKRyC5qM1Vj5X7x-dmLndqqo2AYnHMRxDz-80w@mail.gmail.com/T/#u
>>>>>
>>>>> On Thu, 12 Sept 2024 at 16:05, Ard Biesheuvel <ardb@kernel.org> wrote:
>>>>>>
>>>>>> On Thu, 12 Sept 2024 at 15:55, Usama Arif <usamaarif642@gmail.com> wrote:
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> On 12/09/2024 14:10, Ard Biesheuvel wrote:
>>>>>>>> Does the below help at all?
>>>>>>>>
>>>>>>>> --- a/drivers/firmware/efi/tpm.c
>>>>>>>> +++ b/drivers/firmware/efi/tpm.c
>>>>>>>> @@ -60,7 +60,7 @@ int __init efi_tpm_eventlog_init(void)
>>>>>>>>         }
>>>>>>>>
>>>>>>>>         tbl_size = sizeof(*log_tbl) + log_tbl->size;
>>>>>>>> -       memblock_reserve(efi.tpm_log, tbl_size);
>>>>>>>> +       efi_mem_reserve(efi.tpm_log, tbl_size);
>>>>>>>>
>>>>>>>>         if (efi.tpm_final_log == EFI_INVALID_TABLE_ADDR) {
>>>>>>>>                 pr_info("TPM Final Events table not present\n");
>>>>>>>
>>>>>>> Unfortunately not. efi_mem_reserve updates e820_table, while kexec looks at /sys/firmware/memmap
>>>>>>> which is e820_table_firmware.
>>>>>>>
>>>>>>> arch_update_firmware_area introduced in the RFC patch does the same thing as efi_mem_reserve does at
>>>>>>> its end, just with e820_table_firmware instead of e820_table.
>>>>>>> i.e. efi_mem_reserve does:
>>>>>>>         e820__range_update(addr, size, E820_TYPE_RAM, E820_TYPE_RESERVED);
>>>>>>>         e820__update_table(e820_table);
>>>>>>>
>>>>>>> while arch_update_firmware_area does:
>>>>>>>         e820__range_update_firmware(addr, size, E820_TYPE_RAM, E820_TYPE_RESERVED);
>>>>>>>         e820__update_table(e820_table_firmware);
>>>>>>>
>>>>>>
>>>>>> Shame.
>>>>>>
>>>>>> Using efi_mem_reserve() is appropriate here in any case, but I guess
>>>>>> kexec on x86 needs to be fixed to juggle the EFI memory map, memblock
>>>>>> table, and 3 (!) versions of the E820 table in the correct way
>>>>>> (e820_table, e820_table_kexec and e820_table_firmware)
>>>>>>
>>>>>> Perhaps we can put this additional logic in x86's implementation of
>>>>>> efi_arch_mem_reserve()? AFAICT, all callers of efi_mem_reserve() deal
>>>>>> with configuration tables produced by the firmware that may not be
>>>>>> reserved correctly if kexec looks at e820_table_firmware[] only.
>>>>>
>>>>
>>>> I have not read all the conversations,  let me have a look and response later.
>>>>
>>>> The first glance about the patch is that I think the kexec_file_load
>>>> syscall (default of latest kexec-tools) will not use
>>>> e820_table_firmware AFAIK.  it will only use e820_table_kexec.
>>>
>>> I initially thought that as well. But it looks like kexec just reads /sys/firmware/memmap
>>>
>>> https://github.com/horms/kexec-tools/blob/main/kexec/firmware_memmap.h#L29
>>>
>>> which is e820_table_firmware.
>>
>> That piece of code is only used by kexec_load
>>
>>>
>>> The patch that Ard sent in https://lore.kernel.org/all/20240912155159.1951792-2-ardb+git@google.com/
>>> is the right approach to it I believe, and I dont see the issue anymore after applying that patch.
>>>
>>>>
>>>> Usama, can you confirm how you tested this?
>>>> kexec -c -l  will use kexec_load syscall
>>>
>>> I am currently testing in my VM setup with kexec_load. But production is running
>>> kexec_file_load and has the same issue.
>>
>> Ok, I mean efi_mem_reserve should be able to work if you retest with
>> kexec_file_load.
> 
> Hold on,  I'm not sure about above :(
> 
> checking the efi_arch_mem_reserve(), currently it updates the e820
> table, if you update the e820_table_kexec and e820_table_firmware then
> I think both kexec_load and kexec_file_load will work.
> 
> Anyway I was not aware very much about the firmware e820 tables and
> kexec tables when they were created.   I suspect that a cleanup and
> revisit is needed.  I will have a look at that.

Yes, I feel like there is one too many tables! From reading the code
I understand that /sys/firmware/memmap should contain the untouched map
at time of boot, i.e. e820_table_firmware. But I would be in favour of
getting rid of e820_table_firmware, and just having e820_table_kexec.
And /sys/firmware/memmap gets data from e820_table_kexec.
> 
> For Ard's fix to allocate it as ACPI memory, I think it should be good
> and simpler.
>

 
Agreed!

>>
>>>
>>> Thanks,
>>> Usama
>>>
>>>> kexec [-s] -l will use kexec_file_load syscall
>>>>
>>>> Thanks
>>>> Dave
>>>>
>>>
> 


