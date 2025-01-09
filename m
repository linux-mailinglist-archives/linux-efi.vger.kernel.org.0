Return-Path: <linux-efi+bounces-2551-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E939A07D97
	for <lists+linux-efi@lfdr.de>; Thu,  9 Jan 2025 17:32:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F35DC188C752
	for <lists+linux-efi@lfdr.de>; Thu,  9 Jan 2025 16:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED7A422259A;
	Thu,  9 Jan 2025 16:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EwfuaRqW"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1CE221D9F;
	Thu,  9 Jan 2025 16:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736440336; cv=none; b=o+RnL0e1qNForamj3GH8sc2877sB70QKZlNDb93pu6SZIg3meDRdFWGgqSeFP8Oamx2aonXXA4yE8wWRxXjAztvBPaCuf84eipiNV2Z3mISGxfM1nbLUS3t0KaxcCQ1dZC+bUfnBlECT0Hg68d+l5WsSh2XJgrQWFe/gilJIzLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736440336; c=relaxed/simple;
	bh=qciaBfEJq93MCCSjHJ4TZ0SfMxHIkNZKdIZrxp2z8vk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NmV4/o+PfXf1aG+Rgt0FryY/9z7yv1QSfIj1bQNHOGxwn21UwriqwRwdHKamLaIyhDKjrrRMvovYzqbL9+zOWg7fj+R3yV0abJ7e3gZmKZi5VlWNg+1UX7yy5Z+MSvmScvpoEz206sgYTyIyNTd1cmZ87MQyLMUBwApgLHj5L3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EwfuaRqW; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5d982de9547so2015367a12.2;
        Thu, 09 Jan 2025 08:32:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736440333; x=1737045133; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2ck84cJZLqXsIJaAUcqVFx7P3SIRlgvwU0gI9j6xgbA=;
        b=EwfuaRqWCW8nH28BHx5ITX9P8hO/v2GCb+7FHi2pI1SstSRz4OngITaJwZaH1tefT1
         YamgZQR+uJtVTccWq1FHyysWIxOaLqQ3ZlfGHiz/+Xj/rSHO+NhrY5QkIkhFtSR2V2dk
         70lR1eIAq7yWwE5nSVjycqlh+PeIptFvLbUaJXm7F1B0WtxKNpuY28hh3qEO4tv0c3gc
         NHAOvSCI0qwX/c16Wwdjp2B4PKYV2yGjLeIvL4Re4z5e3bBx1k5wjDbFSteZe5lxH9tY
         CnExZ9VbPM4LQp1K+rUIn7/fA3dT6MZbil+9NO7GcCzwGof17aBxEXvTikZvF0h5j5Qo
         CnkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736440333; x=1737045133;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2ck84cJZLqXsIJaAUcqVFx7P3SIRlgvwU0gI9j6xgbA=;
        b=V2KJKwhYkuoHtXEW1aQ6+rMrid7dxG748I+uugT/v7UiGmkkBxIDxTBVjOYB92ECJ/
         GsmnHZ6zSseYP/Ah8LnldAatq6cAvK5Avf6Gzt3Wxd1RSAHrUstrXsyej5QhN+KMvd7R
         mT4bUF+Ian/fX++E1tdjXjhjxk12FGo7UuwfkFOwLExFxFBeb+qUgEHIAg3P0MEnt/qh
         SJlDnFREzFiA75/BQf6Ij2HiH8TWBVBnZCHd/5VjBwCUD7qz5oABAyX6LpkiF4BYfRum
         MZ0zrmMZwUxLiEq788cYYGn/mw3R06AYL0YdxX1klgIqK+CXcAXALadUcn9nzKoMq6XG
         JXHw==
X-Forwarded-Encrypted: i=1; AJvYcCXbfgnUDZw7UagKLm61hVcu+4EHAateNby/0CKX43hqrK+db2bDG4T2AwyF8T+cwgeyE6pJP3ynyi/fpIE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGNYy6inzOtaBuajcPhdjStGBnZa/6qPStu2mrtYRlQ3kifklR
	wFEX4l72EGYWbLlA0iHnJVlpV6WBapQiFMqIwViDdet9Gc6h6p1m
X-Gm-Gg: ASbGncvfUcmAZrvQYJtw2EIyWNXi1wgR8AUg3+x72wMzindYyvBuYVdrcD7R1Uar7np
	sHWsdgsoJH5WlVUf1kNgLTUMHIXOUgt7rJuI7zgfZr/ocoZt+niD5IeKMWQCf+i1p+1+/gOihlO
	/DqwZBEFKvUAGmQQ6IwXtba3mMzRX+6Liof7MrUO89NyVpYQ+s4ee6RE41t/8nqZBYXXJqrQlLX
	zR40kA/8M1ZnTkskqJzAOePZsHDWCODEqH045RaFwp9HyWjsTuOx0BmEdY+wIC4o/l2W8eIvdj4
	WxRNVfmMXFD86CoHcD/sBnHzYoo8
X-Google-Smtp-Source: AGHT+IET95vGKgOoOgihxI5Y69+gtj6ZhylVDaWZo4Dnakul58/pEHmiKxDp/vg/0dYX/btNLYrQaw==
X-Received: by 2002:a05:6402:2105:b0:5d3:d7b0:b834 with SMTP id 4fb4d7f45d1cf-5d972df67ecmr5972933a12.1.1736440331324;
        Thu, 09 Jan 2025 08:32:11 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1126:4:829:739b:3caa:6500? ([2620:10d:c092:500::5:337c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d99046d822sm719871a12.56.2025.01.09.08.32.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jan 2025 08:32:10 -0800 (PST)
Message-ID: <cade51c5-5fcc-4208-b46c-f2e2038f03e7@gmail.com>
Date: Thu, 9 Jan 2025 16:32:10 +0000
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 2/2] efi/memattr: add efi_mem_attr_table as a reserved
 region in 820_table_firmware
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org, devel@edk2.groups.io,
 kexec@lists.infradead.org, hannes@cmpxchg.org, dyoung@redhat.com,
 x86@kernel.org, linux-kernel@vger.kernel.org, leitao@debian.org,
 gourry@gourry.net, kernel-team@meta.com
References: <20250108215957.3437660-1-usamaarif642@gmail.com>
 <20250108215957.3437660-3-usamaarif642@gmail.com>
 <CAMj1kXFWZNRwx1H2HT8V9hNvUKDi0O3kcLku+g94UOvNBzz5eQ@mail.gmail.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <CAMj1kXFWZNRwx1H2HT8V9hNvUKDi0O3kcLku+g94UOvNBzz5eQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 09/01/2025 16:15, Ard Biesheuvel wrote:
> On Wed, 8 Jan 2025 at 23:00, Usama Arif <usamaarif642@gmail.com> wrote:
>>
>> When this area is not reserved, it comes up as usable in
>> /sys/firmware/memmap. This means that kexec, which uses that memmap
>> to find usable memory regions, can select the region where
>> efi_mem_attr_table is and overwrite it and relocate_kernel.
>>
>> Since the patch in [1] was merged, all boots after kexec
>> are producing the warning that it introduced.
>>
>> Having a fix in firmware can be difficult to get through.
> 
> I don't follow. I don't think there is anything wrong with the
> firmware here. Could you elaborate?
> 

So the problem is, kexec sees this memory as System RAM, and decides
it can be used to place an image here.

I guess the question is (and I actually don't know the answer here),
whose responsibility is it to mark this region as reserved so that 
its not touched by anyone else. I would have thought it should be
firmware?

Maybe its not the firmwares' job to mark it as reserved, but just pass
it to kernel and the kernel is supposed to make sure it gets reserved
in a proper way, even across kexecs.

I think in the end whoevers' responsibility it is, the easiest path forward
seems to be in kernel? (and not firmware or libstub)

> 
>> The next ideal place would be in libstub. However, it looks like
>> InstallMemoryAttributesTable [2] is not available as a boot service
>> call option [3], [4], and install_configuration_table does not
>> seem to work as a valid substitute.
>>
> 
> To do what, exactly?
> 

To change the memory type from System RAM to either reserved or
something more appropriate, i.e. any type that is not touched by
kexec or any other userspace.

Basically the example code I attached at the end of the cover letter in 
https://lore.kernel.org/all/20250108215957.3437660-1-usamaarif642@gmail.com/
It could be EFI_ACPI_RECLAIM_MEMORY or EFI_RESERVED_TYPE, both of which aren't
touched by kexec.

>> As a last option for a fix, this patch marks that region as reserved in
>> e820_table_firmware if it is currently E820_TYPE_RAM so that kexec doesn't
>> use it for kernel segments.
>>
>> [1] https://lore.kernel.org/all/20241031175822.2952471-2-ardb+git@google.com/
>> [2] https://github.com/tianocore/edk2/blob/master/MdeModulePkg/Core/Dxe/Misc/MemoryAttributesTable.c#L100
>> [3] https://github.com/tianocore/edk2/blob/42a141800c0c26a09d2344e84a89ce4097a263ae/MdeModulePkg/Core/Dxe/DxeMain/DxeMain.c#L41
>> [4] https://elixir.bootlin.com/linux/v6.12.6/source/drivers/firmware/efi/libstub/efistub.h#L327
>>
>> Reported-by: Breno Leitao <leitao@debian.org>
>> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
>> ---
>>  arch/x86/include/asm/e820/api.h | 2 ++
>>  arch/x86/kernel/e820.c          | 6 ++++++
>>  arch/x86/platform/efi/efi.c     | 9 +++++++++
>>  drivers/firmware/efi/memattr.c  | 1 +
>>  include/linux/efi.h             | 7 +++++++
>>  5 files changed, 25 insertions(+)
>>
>> diff --git a/arch/x86/include/asm/e820/api.h b/arch/x86/include/asm/e820/api.h
>> index 2e74a7f0e935..4e9aa24f03bd 100644
>> --- a/arch/x86/include/asm/e820/api.h
>> +++ b/arch/x86/include/asm/e820/api.h
>> @@ -16,6 +16,8 @@ extern bool e820__mapped_all(u64 start, u64 end, enum e820_type type);
>>
>>  extern void e820__range_add   (u64 start, u64 size, enum e820_type type);
>>  extern u64  e820__range_update(u64 start, u64 size, enum e820_type old_type, enum e820_type new_type);
>> +extern u64  e820__range_update_firmware(u64 start, u64 size, enum e820_type old_type,
>> +                                       enum e820_type new_type);
>>  extern u64  e820__range_remove(u64 start, u64 size, enum e820_type old_type, bool check_type);
>>  extern u64  e820__range_update_table(struct e820_table *t, u64 start, u64 size, enum e820_type old_type, enum e820_type new_type);
>>
>> diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
>> index 82b96ed9890a..01d7d3c0d299 100644
>> --- a/arch/x86/kernel/e820.c
>> +++ b/arch/x86/kernel/e820.c
>> @@ -538,6 +538,12 @@ u64 __init e820__range_update_table(struct e820_table *t, u64 start, u64 size,
>>         return __e820__range_update(t, start, size, old_type, new_type);
>>  }
>>
>> +u64 __init e820__range_update_firmware(u64 start, u64 size, enum e820_type old_type,
>> +                                      enum e820_type new_type)
>> +{
>> +       return __e820__range_update(e820_table_firmware, start, size, old_type, new_type);
>> +}
>> +
>>  /* Remove a range of memory from the E820 table: */
>>  u64 __init e820__range_remove(u64 start, u64 size, enum e820_type old_type, bool check_type)
>>  {
>> diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
>> index a7ff189421c3..13684c5d7c05 100644
>> --- a/arch/x86/platform/efi/efi.c
>> +++ b/arch/x86/platform/efi/efi.c
>> @@ -168,6 +168,15 @@ static void __init do_add_efi_memmap(void)
>>         e820__update_table(e820_table);
>>  }
>>
>> +/* Reserve firmware area if it was marked as RAM */
>> +void arch_update_firmware_area(u64 addr, u64 size)
>> +{
>> +       if (e820__get_entry_type(addr, addr + size) == E820_TYPE_RAM) {
>> +               e820__range_update_firmware(addr, size, E820_TYPE_RAM, E820_TYPE_RESERVED);
>> +               e820__update_table(e820_table_firmware);
>> +       }
>> +}
>> +
>>  /*
>>   * Given add_efi_memmap defaults to 0 and there is no alternative
>>   * e820 mechanism for soft-reserved memory, import the full EFI memory
>> diff --git a/drivers/firmware/efi/memattr.c b/drivers/firmware/efi/memattr.c
>> index d3bc161361fb..d131781e2d7b 100644
>> --- a/drivers/firmware/efi/memattr.c
>> +++ b/drivers/firmware/efi/memattr.c
>> @@ -53,6 +53,7 @@ int __init efi_memattr_init(void)
>>         size = tbl->num_entries * tbl->desc_size;
>>         tbl_size = sizeof(*tbl) + size;
>>         memblock_reserve(efi_mem_attr_table, tbl_size);
>> +       arch_update_firmware_area(efi_mem_attr_table, tbl_size);
>>         set_bit(EFI_MEM_ATTR, &efi.flags);
>>
>>  unmap:
>> diff --git a/include/linux/efi.h b/include/linux/efi.h
>> index e5815867aba9..8eb9698bd6a4 100644
>> --- a/include/linux/efi.h
>> +++ b/include/linux/efi.h
>> @@ -1358,4 +1358,11 @@ extern struct blocking_notifier_head efivar_ops_nh;
>>  void efivars_generic_ops_register(void);
>>  void efivars_generic_ops_unregister(void);
>>
>> +#ifdef CONFIG_X86_64
>> +void __init arch_update_firmware_area(u64 addr, u64 size);
>> +#else
>> +static inline void __init arch_update_firmware_area(u64 addr, u64 size)
>> +{
>> +}
>> +#endif
>>  #endif /* _LINUX_EFI_H */
>> --
>> 2.43.5
>>


