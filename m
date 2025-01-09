Return-Path: <linux-efi+bounces-2546-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58B19A07B63
	for <lists+linux-efi@lfdr.de>; Thu,  9 Jan 2025 16:12:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 442511679BB
	for <lists+linux-efi@lfdr.de>; Thu,  9 Jan 2025 15:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D81C8223717;
	Thu,  9 Jan 2025 15:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E20s0o3e"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D7F223702;
	Thu,  9 Jan 2025 15:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736435381; cv=none; b=ROsmSP6L6Hs+uH5D65Ee6aeMlUDyolxHL1zXBL9oc+B+oHY+uTs59/CmsZLsxYkTG72QwzRcZ5nhSAIPJvB1iB6oFrFOFa520GEY0Ota12Ig34N+Cu47AzspjJDMOI5vuQN6FDiE3m0Nf+EY6K/mnCoPH9JQyJPIug6qjp/H7/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736435381; c=relaxed/simple;
	bh=4XytrHgdC4HQOsKbVb4e3EvbJjApmqRcQqeETx1p9ZE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ngTUrFsRSNrGYVTUc0ylxS49mfqXLFdRUEkMKYsniI7q1y6oZwLeQHPv1XoEaar3T9Vjdr2oKOY+LYHVMq3tOcH2pm86ZU3RnuDtusqYoPH32K4E6Tr7WvNiwcoWngx0XJ3e2M3+I0ApfNI0CsrYXfu4d3lHtngAPBdD1gqy2/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E20s0o3e; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4363ae65100so11793485e9.0;
        Thu, 09 Jan 2025 07:09:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736435378; x=1737040178; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PXQgS+O6L5p70Wj5OsqNfSRxcnJbtdA1d6pYf33RIUY=;
        b=E20s0o3e92/zqfdZtwN39IFYXoOOoTfWTzFldLEfTnPqmmpJqFucRALqTmQJCAfqlD
         GNl/OIorKWbL28gpYjkn/vzE7WyL1IzibBSKm8DNiba/sHKwGGRTShrp6STHPFWEnX6m
         JRBmN/d03yhhlmy+zKxHAKMvKmJOeDNO/Kqc1TDXMJQS0c5Qslzn0SWWMh5QB2WtgWJp
         /GeEFTFobD3KVmGPOjiqJ7gp58qnopKJvK4oZfqiZGo9q4F/19W787IjXG1FK4VTvyjW
         OGnGPl+nE9LEQuLsIeflD54A594GYhyWSaEmy3uMbi1I3CNnDA71JXbo8oePNQi0GdMs
         B+DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736435378; x=1737040178;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PXQgS+O6L5p70Wj5OsqNfSRxcnJbtdA1d6pYf33RIUY=;
        b=XnR3vwJpbmZTWFUWFIC7a+BxsO3skTDSiUHIhmAYFfhXhMsm36DC2PT2dWMbibebU6
         eu3WrHD1HAUDrXjed+sRWBVXrI5MJ7hICW/tabJvQmKekFZZD2mkDKnOFAn5mEuUGrvu
         KTCI/sqSKtN7ZT3HRdGx6CGxFzlVROfW4nwS3qD7hmNJTV6xIY95FWq32YydvRtXQD51
         62PvCZIRce3ggb8K4x8dCzjQsMDE1LE3l5BRT0aSTsWR82YBJWkzP2tuS1F1434GW846
         j/K/eP2xPwNIkwRhnw3moxqOtNK8kYg58W6XfLQqGkVqFefPaqufW1km7moRi6lagy6+
         bdvw==
X-Forwarded-Encrypted: i=1; AJvYcCW54q7E74uYGb7LJGRWJTGpyej12ON6v3pnrKFVFkZG843ORQF0XGlDtNnbq+RikZ1vhyfNCv3aoUqKctnv@vger.kernel.org, AJvYcCXJNom3eY9qY+3HtfQy4/ZLk5ZvNeJey52MonGSr3H3+DxEAlcCqrPllWXBdTMlECNlH/e8T0zEKJs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsuL3npm0DK9VZMj1fBxXXwqTFhAUyf0cDP+/WQNAayRvW8qi9
	W/J/1cqi/w5SdIa5xL8xLu1CmwxzoJ9xMMjEYbssBV0SSKBXUCvN6TrCnTeLn5HMbQ==
X-Gm-Gg: ASbGnctWGcK8mFCiGWhz978x3p6Kodu9YbyTMiVlwG4K3ZKS/+PdozuHvTqU8krj91M
	1hTmCwjOf3IIE3cW9UVsVkhFMRe+plI0eLPpHvU/nW1QWSkqvXBV5/mZ6rPC0OS5XEBDQblbiRr
	2pUusjxvhxNTJp0/Jls/QXrvtdOt/LrnSCB68oN29BTgOJi6AjD32/AKSNT66EvdVWyOMpODj0v
	095wOw7s0daufMd6E+9LnZ8o8mvKL3NK8rYFyfLBNz3+P+Ri30adZQdSCJINKH1zBaC+iIBBGkW
	TD5/DhFVBt9eJHNH9eN4TP3pgXtj
X-Google-Smtp-Source: AGHT+IFMdBc5lkcgq1LTQRYgHAHVAiBMMDwwz5Exf0PjH5B050M2MK9FHNbYJI9bepbeO/iqswn92g==
X-Received: by 2002:a05:6000:2109:b0:38a:8ae5:e518 with SMTP id ffacd0b85a97d-38a8ae5e560mr3695648f8f.21.1736435376599;
        Thu, 09 Jan 2025 07:09:36 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1126:4:829:739b:3caa:6500? ([2620:10d:c092:500::5:337c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab2c95b09a6sm79551066b.145.2025.01.09.07.09.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jan 2025 07:09:36 -0800 (PST)
Message-ID: <6b4780a5-ada0-405e-9f0a-4d2186177f29@gmail.com>
Date: Thu, 9 Jan 2025 15:09:35 +0000
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] efi/memattr: Include EFI memmap size in corruption
 warnings
To: Ard Biesheuvel <ardb@kernel.org>, Breno Leitao <leitao@debian.org>
Cc: Gregory Price <gourry@gourry.net>, linux-efi@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com
References: <20250106-efi_fw_bug-v1-0-01a8eb40bfeb@debian.org>
 <20250106-efi_fw_bug-v1-3-01a8eb40bfeb@debian.org>
 <CAMj1kXFn7CeT6R2w_XKAJoj5WUYObOWKeUO2istY8sULQTwomQ@mail.gmail.com>
 <20250107-versatile-loyal-mussel-2dba59@leitao>
 <CAMj1kXEjzM0YmPt8Ysh139ruPKUR9NJJYOz0Pw6aWBP9V7fpag@mail.gmail.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <CAMj1kXEjzM0YmPt8Ysh139ruPKUR9NJJYOz0Pw6aWBP9V7fpag@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 09/01/2025 14:48, Ard Biesheuvel wrote:
> On Tue, 7 Jan 2025 at 13:05, Breno Leitao <leitao@debian.org> wrote:
>>
>> Hello Ard,
>>
>> On Tue, Jan 07, 2025 at 12:24:03PM +0100, Ard Biesheuvel wrote:
>>> On Mon, 6 Jan 2025 at 20:03, Breno Leitao <leitao@debian.org> wrote:
>>>>
>>>> Add EFI memory map size to warning messages when a corrupted Memory
>>>> Attributes Table is detected, making it easier to diagnose firmware issues.
>>>>
>>>> Signed-off-by: Breno Leitao <leitao@debian.org>
>>>> ---
>>>>  drivers/firmware/efi/memattr.c | 9 +++++----
>>>>  1 file changed, 5 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/drivers/firmware/efi/memattr.c b/drivers/firmware/efi/memattr.c
>>>> index 5f83cdea88b05cb325e9f90c14a0048131e53cfa..2c276bcc0df48352bec6cd96b69edf67a16f6069 100644
>>>> --- a/drivers/firmware/efi/memattr.c
>>>> +++ b/drivers/firmware/efi/memattr.c
>>>> @@ -22,7 +22,7 @@ unsigned long __ro_after_init efi_mem_attr_table = EFI_INVALID_TABLE_ADDR;
>>>>  void __init efi_memattr_init(void)
>>>>  {
>>>>         efi_memory_attributes_table_t *tbl;
>>>> -       unsigned long size;
>>>> +       unsigned long size, efi_map_size;
>>>>
>>>>         if (efi_mem_attr_table == EFI_INVALID_TABLE_ADDR)
>>>>                 return;
>>>> @@ -49,9 +49,10 @@ void __init efi_memattr_init(void)
>>>>          * just be ignored altogether.
>>>>          */
>>>>         size = tbl->num_entries * tbl->desc_size;
>>>> -       if (size > 3 * efi.memmap.nr_map * efi.memmap.desc_size) {
>>>> -               pr_warn(FW_BUG "Corrupted EFI Memory Attributes Table detected! (version == %u, desc_size == %u, num_entries == %u)\n",
>>>> -                       tbl->version, tbl->desc_size, tbl->num_entries);
>>>> +       efi_map_size = efi.memmap.nr_map * efi.memmap.desc_size;
>>>> +       if (size > 3 * efi_map_size) {
>>>> +               pr_warn(FW_BUG "Corrupted EFI Memory Attributes Table detected! (version == %u, desc_size == %u, num_entries == %u, efi_map_size == %lu)\n",
>>>> +                       tbl->version, tbl->desc_size, tbl->num_entries, efi_map_size);
>>>>                 goto unmap;
>>>>         }
>>>>
>>>>
>>>
>>> Hello Breno,
>>>
>>> I don't mind the patch per se, but I don't think it is terribly useful either.
>>>
>>> Could you explain how this helps?
>>
>> We are seeing a bunch of `Corrupted EFI Memory Attributes Table
>> detected!` in the Meta fleet, and this is something we are
>> investigating.
>>
>> We highly think this is related to some kexec overwrites, and when we
>> get here, the EFI table is completely garbage. I haven't seen this
>> problem on cold boot.
>>
> 
> It likely means the memory is not reserved correctly.
> 
> Could you check whether this
> 
> --- a/drivers/firmware/efi/memattr.c
> +++ b/drivers/firmware/efi/memattr.c
> @@ -56,7 +56,7 @@ int __init efi_memattr_init(void)
>         }
> 
>         tbl_size = sizeof(*tbl) + size;
> -       memblock_reserve(efi_mem_attr_table, tbl_size);
> +       efi_mem_reserve(efi_mem_attr_table, tbl_size);
>         set_bit(EFI_MEM_ATTR, &efi.flags);
> 
>  unmap:
> 
> 
> makes any difference?
> 
Hi Ard,

Thanks for the reply!

I have further explained the problems and possible solutions in
https://lore.kernel.org/all/20250108215957.3437660-1-usamaarif642@gmail.com/.

I am assuming the above diff is to solve problem 2 that I have described in the patches.
I haven't tested it, because its a bit difficult to reproduce problem 2, but I think
the above diff might not make a difference? efi_mem_reserve changes e820_table,
while /sys/firmware/memmap uses e820_table_firmware. An alternate solution might be
to change /sys/firmware/memmap to e820_table. I didnt go down that route because,
you would be changing what the kernel exposes to userspace, which might not be the
right thing.

Thanks,
Usama


> 
>> Here are sof the instances I see:
>>
>>         efi: memattr: [Firmware Bug]: Corrupted EFI Memory Attributes Table detected! (version == 0, desc_size == 18058, num_entries == 33554432)
>>         efi: memattr: [Firmware Bug]: Corrupted EFI Memory Attributes Table detected! (version == 1, desc_size == 2072184435, num_entries == 3248688968)
>>         efi: memattr: [Firmware Bug]: Corrupted EFI Memory Attributes Table detected! (version == 0, desc_size == 83886080, num_entries == 304)
>>         efi: memattr: [Firmware Bug]: Corrupted EFI Memory Attributes Table detected! (version == 2, desc_size == 48, num_entries == 40)
>>
> 
> The last one looks like a false positive: each of those values seems
> perfectly reasonable.
> 
> Any chance you could dump the memory map and this table (boot using
> efi=debug) on this system?
> 
> 
>> Anyway, back to you question, this patch helped us to narrow down and
>> find where the problem was, by printing all variables taken in
>> consideration to get the conclusion that the firmware is buggy.
>>
> 
> Fair enough.
> 
>> Regarding the problem, Usama and I are suspecting that it might be
>> related to some 77d48d39e99170 ("efistub/tpm: Use ACPI reclaim memory for
>> event log to avoid corruption"), but at this time with memattr table, where it
>> might not preserved during kexec(?).
>>
> 
> Please see the suggestion above.


