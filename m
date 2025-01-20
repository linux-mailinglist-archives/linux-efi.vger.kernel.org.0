Return-Path: <linux-efi+bounces-2691-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C94A16AB1
	for <lists+linux-efi@lfdr.de>; Mon, 20 Jan 2025 11:27:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D2153A3613
	for <lists+linux-efi@lfdr.de>; Mon, 20 Jan 2025 10:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 475A01AF0C2;
	Mon, 20 Jan 2025 10:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RzEYKsYI"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59920189B9C;
	Mon, 20 Jan 2025 10:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737368844; cv=none; b=lB6bNCO2LS12e07xp72CO2Q2ECHx48NHq/EjHOQqpqkiBPY0poqF5bqxMDJ/QDQhqazFo5LVtYYyskMy7eM3XYtSlikZtyfLa/l2CyeILF2BBby4o8RJ4K+9mIVbj1giuTGmaMDP1V/7RZQ+IoRy5cfFsryCDtBHQlb/38HL01E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737368844; c=relaxed/simple;
	bh=PLmb+cQHYAhs55TVyZSOubAWDJEVrvMn2iGLXcnUG10=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=aEy0FEsztURN9AKuzj7LGW/bX8lKk37079tboExTEjtGivcrE4wVaE6iTN2fD3jrADQCX6fcfhDUGFbzbCu+tidLrvenfx5eI9FevGiUeU4DeT0QysBz/pLuRZbEqOQtmk90/ZjdntgpBzVcHRLOcv0YZeo1RRaW4yRcr7OyQOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RzEYKsYI; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ab2e308a99bso911353866b.1;
        Mon, 20 Jan 2025 02:27:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737368839; x=1737973639; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rUuf+qPnVXziY4ELR+clEQNjKjKr8CVJKIW2VDFxZIQ=;
        b=RzEYKsYIWAO2+tZEeJXT3GBhW5YDe8va277E97p9wvD8NU7sYKLMH0tBJXfiTI1LPf
         ArlEE/7GjVHcGGz/YQWtnOxCrVXTnl5VdIlXVi/eK6SxFsd5bcUfJJTRQ18uOBF0KCSv
         YbgjP8b8G4KiZWC8vBE/0T44Yx9uBc10Qy/+a9arH/dkGEuQzFFV8XllaP11CI0L0680
         WvO4PDta4FORLX3CuRl/h5+7zrrLscg5tW1zFRUT7wCM/q6YsaC2JFMCZBVLV8UJj9oy
         rYMV6Xz0RkVsR5iAoUVqi895mgWAAmTpaqnB7p8ohsC+14mg5+HQvPHfeIZKpdz+ryCt
         jegg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737368839; x=1737973639;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rUuf+qPnVXziY4ELR+clEQNjKjKr8CVJKIW2VDFxZIQ=;
        b=skpE70xD3L6ppNkB7/+TlHEweyHsAAi3Y3eJQzEih5DBdmLKrx5OXK7w3VAO51NAw+
         bu/RbO/xsp9bNo7Hq6yC6213X1fnDiPVzcEpo/iZS5ZSn+slz7iTvxSkCvyrEfOpsYnX
         teAcUzROYFvfQ4K7k1Epzgbig5nrw+snPxtNLZCztjf16GnlFzNWlS3bNd+9BnTeC2+B
         NY5HkaeZTlBCyRuAHwEQO3syrZQ9w9+F7punm70nHXlK6H/rayGjovFoWl5f5xF5fNZX
         3hYjCnu24IQwSJKVuUoZTlAzcz8azxE4KU2tiYeCtLwyu6IwqQx8ZiNkGqApxQMeVTVM
         Nb7w==
X-Forwarded-Encrypted: i=1; AJvYcCUjCiQ6rJHN6j4jEY+K+wHdyud3PLCzzo9HIzN/xcjVDrJMtIhrfGGuAVPQXJzPzx7IYjZ4IKaViUO0jj8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2VR3x9yQbx1JvCgkKClXfrON9uUNwNGP2ZumOSb+UxzADMT/F
	YZ65bEkLvW3Z5E/AfftECb7Zp6RSB7qkRiemD0Lb8CP8SeRNCxMq
X-Gm-Gg: ASbGncuqrMWt7ifeZgq/HTK07mNU6SD+DX3LdfdO/h4w5i7Rt4A8kxm3NO2UFHfXLFl
	o4fJThmdCEiTafZ5s/1w10aflO4FHhrLl1GC6E54hBCoO/cXv2fx+2V6Br4SHje9+lTqVsarzMn
	VDEzw3T2riyGz1ZGevm5VzKHF4I46xFWzovqAcCQjsQeOeJGCBozDjUC7WRZpp/2MBGLf/bxA2n
	ygfK9eHGfeHylJR0yAfQokzxSMAnC6wLVWMuLLCuM/4toTyFmwSNvY8SfAX0VMgpaLZ3J01XTI4
	vvivmbtdMoyAUK1/Y918NGyy4Y1OBrS6fZvP2H8IRw==
X-Google-Smtp-Source: AGHT+IFJVlthfW01rep+roRrPx41HHx1BoP/crq5DSFMeeGWPv+XAPS4A/l3WgF9Nu1tdQ84n+Nkfg==
X-Received: by 2002:a17:907:9485:b0:ab3:3b92:8ca5 with SMTP id a640c23a62f3a-ab36e2422camr1516607466b.12.1737368839235;
        Mon, 20 Jan 2025 02:27:19 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1126:4:829:739b:3caa:6500? ([2620:10d:c092:500::4:4372])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab384ce6890sm596532066b.70.2025.01.20.02.27.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jan 2025 02:27:18 -0800 (PST)
Message-ID: <ed7ad48f-2270-4966-bdba-ccd4592a0fd4@gmail.com>
Date: Mon, 20 Jan 2025 10:27:18 +0000
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/2] efi/memattr: Use desc_size instead of total size to
 check for corruption
From: Usama Arif <usamaarif642@gmail.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org, devel@edk2.groups.io,
 kexec@lists.infradead.org, hannes@cmpxchg.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, leitao@debian.org, gourry@gourry.net,
 kernel-team@meta.com, Dave Young <dyoung@redhat.com>
References: <20250108215957.3437660-1-usamaarif642@gmail.com>
 <20250108215957.3437660-2-usamaarif642@gmail.com>
 <CAMj1kXH54Y0ae1OGwBe7-UiRBq9cFkDHbjxos_rEZPtan7NNzQ@mail.gmail.com>
 <d9c84079-6593-43f4-9483-648b665f03db@gmail.com>
 <CAMj1kXGYsJrqDzy_+g_wSAAEuQ_OnxvyJ8ZE+4gbr6KOY7iuow@mail.gmail.com>
 <8613563a-ee7c-4271-b1f0-4d1ac365ad3a@gmail.com>
 <CALu+AoS8tb=HgaybDw5OG4A1QbOXHvuidpu0ynmz-nE1nBqzTA@mail.gmail.com>
 <db7edff7-8a87-41db-9e40-202a498c5e29@gmail.com>
 <138f28ec-341e-4c48-a14b-4371a8198de8@gmail.com>
Content-Language: en-US
In-Reply-To: <138f28ec-341e-4c48-a14b-4371a8198de8@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 13/01/2025 12:00, Usama Arif wrote:
> 
> 
> On 13/01/2025 11:27, Usama Arif wrote:
>>
>>
>> On 13/01/2025 02:33, Dave Young wrote:
>>> On Fri, 10 Jan 2025 at 18:54, Usama Arif <usamaarif642@gmail.com> wrote:
>>>>
>>>>
>>>>
>>>> On 10/01/2025 07:21, Ard Biesheuvel wrote:
>>>>> On Thu, 9 Jan 2025 at 17:36, Usama Arif <usamaarif642@gmail.com> wrote:
>>>>>>
>>>>>>
>>>>>>
>>>>>> On 09/01/2025 15:45, Ard Biesheuvel wrote:
>>>>>>> On Wed, 8 Jan 2025 at 23:00, Usama Arif <usamaarif642@gmail.com> wrote:
>>>>>>>>
>>>>>>>> The commit in [1] introduced a check to see if EFI memory attributes
>>>>>>>> table was corrupted. It assumed that efi.memmap.nr_map remains
>>>>>>>> constant, but it changes during late boot.
>>>>>>>> Hence, the check is valid during cold boot, but not in the subsequent
>>>>>>>> kexec boot.
>>>>>>>>
>>>>>>>> This is best explained with an exampled. At cold boot, for a test
>>>>>>>> machine:
>>>>>>>> efi.memmap.nr_map=91,
>>>>>>>> memory_attributes_table->num_entries=48,
>>>>>>>> desc_size = 48
>>>>>>>> Hence, the check introduced in [1] where 3x the size of the
>>>>>>>> entire EFI memory map is a reasonable upper bound for the size of this
>>>>>>>> table is valid.
>>>>>>>>
>>>>>>>> In late boot __efi_enter_virtual_mode calls 2 functions that updates
>>>>>>>> efi.memmap.nr_map:
>>>>>>>> - efi_map_regions which reduces the `count` of map entries
>>>>>>>>   (for e.g. if should_map_region returns false) and which is reflected
>>>>>>>>   in efi.memmap by __efi_memmap_init.
>>>>>>>>   At this point efi.memmap.nr_map becomes 46 in the test machine.
>>>>>>>> - efi_free_boot_services which also reduces the number of memory regions
>>>>>>>>   available (for e.g. if md->type or md->attribute is not the right value).
>>>>>>>>   At this point efi.memmap.nr_map becomes 9 in the test machine.
>>>>>>>> Hence when you kexec into a new kernel and pass efi.memmap, the
>>>>>>>> paramaters that are compared are:
>>>>>>>> efi.memmap.nr_map=9,
>>>>>>>> memory_attributes_table->num_entries=48,
>>>>>>>> desc_size = 48
>>>>>>>> where the check in [1] is no longer valid with such a low efi.memmap.nr_map
>>>>>>>> as it was reduced due to efi_map_regions and efi_free_boot_services.
>>>>>>>>
>>>>>>>> A more appropriate check is to see if the description size reported by
>>>>>>>> efi and memory attributes table is the same.
>>>>>>>>
>>>>>>>> [1] https://lore.kernel.org/all/20241031175822.2952471-2-ardb+git@google.com/
>>>>>>>>
>>>>>>>> Fixes: 8fbe4c49c0cc ("efi/memattr: Ignore table if the size is clearly bogus")
>>>>>>>> Reported-by: Breno Leitao <leitao@debian.org>
>>>>>>>> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
>>>>>>>> ---
>>>>>>>>  drivers/firmware/efi/memattr.c | 16 ++++++----------
>>>>>>>>  1 file changed, 6 insertions(+), 10 deletions(-)
>>>>>>>>
>>>>>>>
>>>>>>> The more I think about this, the more I feel that kexec on x86 should
>>>>>>> simply discard this table, and run with the firmware code RWX (which
>>>>>>> is not the end of the world).
>>>>>>
>>>>>>
>>>>>> By discard this table, do you mean kexec not use e820_table_firmware?
>>>>>
>>>>> No, I mean kexec ignores the memory attributes table.
>>>>>
>>>>>> Also a very basic question, what do you mean by run with the firmware RWX?
>>>>>>
>>>>>
>>>>> The memory attributes table is an overlay for the EFI memory map that
>>>>> describes which runtime code regions may be mapped with restricted
>>>>> permissions. Without this table, everything will be mapped writable as
>>>>> well as executable, but only in the EFI page tables, which are only
>>>>> active when an EFI call is in progress.
>>>>>
>>>>
>>>> Thanks for explaining!
>>>>
>>>> So basically get rid of memattr.c :)
>>>>
>>>> Do you mean get rid of it only for kexec, or not do it for any
>>>> boot (including cold boot)?
>>>> I do like this idea! I couldn't find this in the git history,
>>>> but do you know if this was added in the linux kernel just
>>>> because EFI spec added support for it, or if there was a
>>>> specific security problem?
>>>>
>>>
>>> Usama, can you try the patch below?
>>> [ format is wrong due to webmail corruption.  But if it works I can
>>> send a formal patch later ]
>>>
>>> $ git diff arch/x86
>>> diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
>>> index 846bf49f2508..58dc77c5210e 100644
>>> --- a/arch/x86/platform/efi/quirks.c
>>> +++ b/arch/x86/platform/efi/quirks.c
>>> @@ -561,6 +561,11 @@ int __init efi_reuse_config(u64 tables, int nr_tables)
>>>
>>>                 if (!efi_guidcmp(guid, SMBIOS_TABLE_GUID))
>>>                         ((efi_config_table_64_t *)p)->table = data->smbios;
>>> +
>>> +               /* Not bother to play with mem attr table across kexec */
>>> +               if (!efi_guidcmp(guid, EFI_MEMORY_ATTRIBUTES_TABLE_GUID))
>>> +                       ((efi_config_table_64_t *)p)->table =
>>> EFI_INVALID_TABLE_ADDR;
>>> +
>>>                 p += sz;
>>>         }
>>>
>>
>> This would work, I am guessing it will have a similar effect to what I sent
>> last week in 
>> https://lore.kernel.org/all/fd63613c-fd26-42de-b5ed-cc734f72eb36@gmail.com/
>>
>> I think it needs to be wrapped in ifdef CONFIG_X86_64.
>>
> 
> IMO we should consider the 2 patches in this series first before disabling it for
> kexec. These patches actually fix the issue.
> 

Hi Ard,

Just wanted to check how should we proceed forward? Should we try and fix the warning
and corruption during kexec as done in this series or not initialize memory attributes
table at all in kexec boot? I would prefer fixing the issues as in this series.

Thanks,
Usama


