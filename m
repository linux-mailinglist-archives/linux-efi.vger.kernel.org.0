Return-Path: <linux-efi+bounces-2552-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C3B1A07DBE
	for <lists+linux-efi@lfdr.de>; Thu,  9 Jan 2025 17:37:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03BD518899B1
	for <lists+linux-efi@lfdr.de>; Thu,  9 Jan 2025 16:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBC4E223708;
	Thu,  9 Jan 2025 16:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MbI3+mAV"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5262236FE;
	Thu,  9 Jan 2025 16:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736440583; cv=none; b=d6Qj9M06+KEqXOdFYLbaVXjW8o3CHARGvgvZaA4Hb7IiDZV6B0nuRoYzaoYEbRjDH/naqMgaBdW/7dO6m+ktCOv4XWV5WQ/kVia361NdFulzKeGz66SM7nrCmqme6EL1IleruwwJlyKrqU8WjYx6k+SK0q1yNEq4YuSHtLP1AXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736440583; c=relaxed/simple;
	bh=LYPC9+/P+uMSIw4LyYeLnrB1ti/vwQQz3+HrRo6gcqM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=awrAxXuPOiFnUkzoOVCAdonEC8KpKYhyqNYwqr1+8GLr4jxZKNz72P3GMjPd3TJzUCltSIAWj3+1X0JkX5fy/O37CX0BPA/cFV1xy2jjiZuGnYZaiyb9w4xRUJdce9ePLsUQ9HsXp1SSmhlyCqICihvRPepxr/x2ZfkGVPXt8oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MbI3+mAV; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5d3d0205bd5so1556822a12.3;
        Thu, 09 Jan 2025 08:36:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736440579; x=1737045379; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dX4VAIGuA5p4o4v1mMF/f2hbtB1svOw3Z2SHsNP1eCA=;
        b=MbI3+mAVGnSvaHOCtzA/ef4VwhETEuJTBxqWLT9uIuyKaf719jmDBDFkvb6kIoU+fA
         hMK995TDyclYWQs4xd0ZO24i0hK1MBRMdkADo7Y42rMsgDzylhPDhlyCDot3Lj6fop8d
         BVFun1L/GUeSnH/JUCJkzrv93XKo2zetOIz7YlXrNh8+juImMnJvvK8i0BgXC8w5IsHS
         6gUmLmBMkn8nE3Q3ckvhrQJu2SEIAoRn5EPCJWtuoJZDv5iK09wh9F8XLdXE7PVaznTf
         B1wIWTvKxgM/WHYtgcncBC3gS8iRuNUUabgXL8PbD8w39mlPhmrCAVVoG9NB2EiOSguO
         HW3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736440579; x=1737045379;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dX4VAIGuA5p4o4v1mMF/f2hbtB1svOw3Z2SHsNP1eCA=;
        b=DUcOAGRJ0ZM8wMVPYBhphKLjBcztTw+QKrs6GEMFJ9S0QcQLDjyNz6RQHYu90Fx2Ny
         5A4PuAyT4IetJ+f0cefjA2PreP1Ys1KWIA7TIVzBybuisvNwJbu4c0QU0hjx7+RGXj3C
         X0H0U/Hvz7Grvy27pxKAPnCFHyCqTjNpsleGR0us6x9+VEHYOl3mwtAUbUM73KrC3Rag
         LV/NQWHyV57/i81g1f/zABSDFXB3ON5LOukhEAkicNKhnC6ObvKGeOuHbzyI0hkKzuUh
         DbRAKFwmnrSkfJvkVhPitL4ZE3fWhM3jXVnhsyqk0wMAma3pw/7OkT+PJBpqznSubaMT
         Mx7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWKDsiUHX1BdSVJVV7PavcVyPZD2/95TujGaaKxRycmoMSrL75lIr0+UUELRn1705nXgq8nOePMVQ4ftUY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVsKBd1qmr6Hfs5v38RglosWtYDcKjjj1w5YxGw+7zucUVFFAD
	ha3i6WotReyIluyvtuhWnXIycuy/SgVj8qd+ytP9CfvQvrwvM40z
X-Gm-Gg: ASbGnctraB+MXsLU1Rwatd3+vtQwCWrUgIvC+DZFZL0GYrEOs8Cpb+N4oRQXRI7Vpsr
	q/FTUwCGIkufSou+Q+OFcRDr0E9FDQs7yLRlmzeWBhEDmeCax5wGMYzYT+NdItegDSfU+y+E5Or
	qRsM/gkDD1BvxC/rOrl1u7GrsdzaVp1dvQ0wvSChcW3AQ+1gobldmx8Nh2VRD0mLt9JpKbxWbzy
	sW4zrzL6bKsJUhRDTH8Pcyzkki5NunpPG2xdG3zfbQzVzzcbx8PJ7T6sTlcSqRxKGGzoMLdugml
	aMmEYryMKrJSWCQ3WzbDUxL+7DbS
X-Google-Smtp-Source: AGHT+IFH4Mf4jMgpRx3khbxhhYmeEL2WA8ovuW6XBYno3NsJIZaj1ShKSo8fqHjrVfklGFxDEAk+6g==
X-Received: by 2002:a05:6402:1ed4:b0:5d0:bcdd:ff8f with SMTP id 4fb4d7f45d1cf-5d972dfbcc3mr6581488a12.4.1736440578846;
        Thu, 09 Jan 2025 08:36:18 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1126:4:829:739b:3caa:6500? ([2620:10d:c092:500::5:337c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d9903c3333sm785494a12.47.2025.01.09.08.36.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jan 2025 08:36:18 -0800 (PST)
Message-ID: <d9c84079-6593-43f4-9483-648b665f03db@gmail.com>
Date: Thu, 9 Jan 2025 16:36:17 +0000
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/2] efi/memattr: Use desc_size instead of total size to
 check for corruption
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org, devel@edk2.groups.io,
 kexec@lists.infradead.org, hannes@cmpxchg.org, dyoung@redhat.com,
 x86@kernel.org, linux-kernel@vger.kernel.org, leitao@debian.org,
 gourry@gourry.net, kernel-team@meta.com
References: <20250108215957.3437660-1-usamaarif642@gmail.com>
 <20250108215957.3437660-2-usamaarif642@gmail.com>
 <CAMj1kXH54Y0ae1OGwBe7-UiRBq9cFkDHbjxos_rEZPtan7NNzQ@mail.gmail.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <CAMj1kXH54Y0ae1OGwBe7-UiRBq9cFkDHbjxos_rEZPtan7NNzQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 09/01/2025 15:45, Ard Biesheuvel wrote:
> On Wed, 8 Jan 2025 at 23:00, Usama Arif <usamaarif642@gmail.com> wrote:
>>
>> The commit in [1] introduced a check to see if EFI memory attributes
>> table was corrupted. It assumed that efi.memmap.nr_map remains
>> constant, but it changes during late boot.
>> Hence, the check is valid during cold boot, but not in the subsequent
>> kexec boot.
>>
>> This is best explained with an exampled. At cold boot, for a test
>> machine:
>> efi.memmap.nr_map=91,
>> memory_attributes_table->num_entries=48,
>> desc_size = 48
>> Hence, the check introduced in [1] where 3x the size of the
>> entire EFI memory map is a reasonable upper bound for the size of this
>> table is valid.
>>
>> In late boot __efi_enter_virtual_mode calls 2 functions that updates
>> efi.memmap.nr_map:
>> - efi_map_regions which reduces the `count` of map entries
>>   (for e.g. if should_map_region returns false) and which is reflected
>>   in efi.memmap by __efi_memmap_init.
>>   At this point efi.memmap.nr_map becomes 46 in the test machine.
>> - efi_free_boot_services which also reduces the number of memory regions
>>   available (for e.g. if md->type or md->attribute is not the right value).
>>   At this point efi.memmap.nr_map becomes 9 in the test machine.
>> Hence when you kexec into a new kernel and pass efi.memmap, the
>> paramaters that are compared are:
>> efi.memmap.nr_map=9,
>> memory_attributes_table->num_entries=48,
>> desc_size = 48
>> where the check in [1] is no longer valid with such a low efi.memmap.nr_map
>> as it was reduced due to efi_map_regions and efi_free_boot_services.
>>
>> A more appropriate check is to see if the description size reported by
>> efi and memory attributes table is the same.
>>
>> [1] https://lore.kernel.org/all/20241031175822.2952471-2-ardb+git@google.com/
>>
>> Fixes: 8fbe4c49c0cc ("efi/memattr: Ignore table if the size is clearly bogus")
>> Reported-by: Breno Leitao <leitao@debian.org>
>> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
>> ---
>>  drivers/firmware/efi/memattr.c | 16 ++++++----------
>>  1 file changed, 6 insertions(+), 10 deletions(-)
>>
> 
> The more I think about this, the more I feel that kexec on x86 should
> simply discard this table, and run with the firmware code RWX (which
> is not the end of the world).


By discard this table, do you mean kexec not use e820_table_firmware?
Also a very basic question, what do you mean by run with the firmware RWX?

Sorry for the very basic questions above!


> 
> The main reason is that the EFI memory map and the EFI memory
> attributes table are supposed to be a matched pair, where each RTcode
> entry in the former is broken down into multiple code and data
> segments in the latter. The amount of mangling that the x86 arch code
> does of the EFI memory map makes it intractable to ensure that they
> remain in sync, and so it is better not to bother.
> 
> 
>> diff --git a/drivers/firmware/efi/memattr.c b/drivers/firmware/efi/memattr.c
>> index c38b1a335590..d3bc161361fb 100644
>> --- a/drivers/firmware/efi/memattr.c
>> +++ b/drivers/firmware/efi/memattr.c
>> @@ -40,21 +40,17 @@ int __init efi_memattr_init(void)
>>                 goto unmap;
>>         }
>>
>> -
>>         /*
>> -        * Sanity check: the Memory Attributes Table contains up to 3 entries
>> -        * for each entry of type EfiRuntimeServicesCode in the EFI memory map.
>> -        * So if the size of the table exceeds 3x the size of the entire EFI
>> -        * memory map, there is clearly something wrong, and the table should
>> -        * just be ignored altogether.
>> +        * Sanity check: the Memory Attributes Table desc_size and
>> +        * efi.memmap.desc_size should match.
>>          */
>> -       size = tbl->num_entries * tbl->desc_size;
>> -       if (size > 3 * efi.memmap.nr_map * efi.memmap.desc_size) {
>> -               pr_warn(FW_BUG "Corrupted EFI Memory Attributes Table detected! (version == %u, desc_size == %u, num_entries == %u)\n",
>> -                       tbl->version, tbl->desc_size, tbl->num_entries);
>> +       if (efi.memmap.desc_size != tbl->desc_size) {
>> +               pr_warn(FW_BUG "Corrupted EFI Memory Attributes Table detected! (version == %u, table desc_size == %u, efi.memmap.desc_size == %lu, table num_entries == %u)\n",
>> +                       tbl->version, tbl->desc_size, efi.memmap.desc_size, tbl->num_entries);
>>                 goto unmap;
>>         }
>>
>> +       size = tbl->num_entries * tbl->desc_size;
>>         tbl_size = sizeof(*tbl) + size;
>>         memblock_reserve(efi_mem_attr_table, tbl_size);
>>         set_bit(EFI_MEM_ATTR, &efi.flags);
>> --
>> 2.43.5
>>


