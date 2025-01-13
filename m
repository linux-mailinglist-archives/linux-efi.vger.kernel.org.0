Return-Path: <linux-efi+bounces-2611-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88E24A0B637
	for <lists+linux-efi@lfdr.de>; Mon, 13 Jan 2025 13:00:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CFA647A3073
	for <lists+linux-efi@lfdr.de>; Mon, 13 Jan 2025 12:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AD332045A5;
	Mon, 13 Jan 2025 12:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JBJDcCtE"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D504E1C07D6;
	Mon, 13 Jan 2025 12:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736769618; cv=none; b=aeQPOykjU9p/Rsq/6UXTyAyAfJbi+OhIgdyvHb74DSjmqnEEfVQoUq6UmcB5AOeAJIuRCQobAFUGTJ4uTediWH/yubgaJRP3dgB6xE8IY13lW6YVtjL7d2K3nbe1Ipg2pCl4Gx7VDIiiD+A/k6VReEMV5Ps2OfzO56r+ng/Eyzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736769618; c=relaxed/simple;
	bh=9CquxanJN5IYrnqzauIW98vxTqhC2+liy/rKYYXlctE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Nc+5g1o9TQfoSKT752aUi40pJmwLWBBTlayOjWzxYOICyplf4fA4jU9Ov/llfhLR7e1n38LHy4m87YbkCFT4xtWXej+j51Zd+q5cmP1rsoIQHuJO9nTyIYBw2x9sfcrwK2cZHPSkGa5JOnM6pB35yI4hYqHxe2JR+dalLqhPHKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JBJDcCtE; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5d3f57582a2so10351789a12.1;
        Mon, 13 Jan 2025 04:00:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736769614; x=1737374414; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kBy06+ZzcG8cE/DV4b6e6/PZwuQ0e32d8+VJrouA7ds=;
        b=JBJDcCtE+GoV0MN9Q3M8klUzfFR4cjz4m8jpyKTuNCi/iYL7NDfOx21yrzulvNU30a
         SellI13kBABMWBaTZyDjfOtn8HLQx5o+bnr+qxhjMRCGcYXIfP2OOce98q6VT2Zupwwi
         W1VzJzMi6W2SlLlvlzfDEn0s8ExpvSWEUzEUjZJ580bglb4ouYiUz100L9M8AmHHzkCw
         7WtqcKSAndXTCSwfoAtKBvaQXPMtu/a30It21ouEZPXXxPSknMgKRQvMOvRL5GrdbWzK
         uCL/29PA/c5Ubbt5ddZX8im7YDtCvulsHMsOwV10xlpCRp4M4o4g4ANjROgdn/NeSaUz
         vOig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736769614; x=1737374414;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kBy06+ZzcG8cE/DV4b6e6/PZwuQ0e32d8+VJrouA7ds=;
        b=gfqbWr8Vgg4dmYABqJTA4WOe3LKyMRldkc4DUDiRlxfB1KlIj5yMdWfDSzhT11Siw2
         6uJTNDsj1wpms31KB3ftRPqnKBvpYJ+m0Zx0+ugfylMaCr/prJdSSoORYakpcGqgBpp7
         Nsg2/Y+XHayj99Wvrlm8jW2TeAuC+izKZK0sbad0iH0i2lndcnlcqX9luVk9W1ljDdrk
         cxao3JQO/UMVVtUyoehHFTjgUNV/Jd1n/z2nVWeo9oQpoLQgTrDqeaUmf5FRgTh52CLf
         SQXltQWpwCdXsOw83rHjXllys6rk3k/1fhGYM9uBtAOVLPSXEzdM+RRAIKMRO2Xe0aN1
         aabQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmJuI2RmT3GLHU5cfMSVK/nWWVmj4OGyJQXGhyUvXA4yzUJZ+58za98t/0xB475niScszg9PP3li7B83s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxRUM1fUyi2iCmj12Z05CfDLUcrSYP/aNZD+sKHsSUBQ2XfmGc
	l1k2ngwgutcwJQrE4lVvuJXeVQ0NiMnzNayMQ7bAGAq/piRRGTvj
X-Gm-Gg: ASbGnctgVak7xknqrw1dEWEbQCK6T+JXcJvNFf8IC2OCStgmE3khMfWt259OTPFLQHY
	06uOGR5NL++3tHUHSq5OU7eM/LBsGwaHPjywr+u5QwTEcN/lpeBmRL6d/npZL+QfgCCv6WboHjc
	caRIhHoRFandB1NzxgJkQQ6lWOG4qJ6W7LmjEFIV67VIcaztPh9ryXQFUjTFlloMCNTh+55PCmG
	WxX8fF9e5NmWiJzVFF5ifPh7Q2QYH8RcmPM0Yk9T4/OHNtzj6Bhkbb6oYTMgicM+p+3FLLxiydC
	fsO56n3PWsiGdX983VTRNlWe4CXt2sW8ig==
X-Google-Smtp-Source: AGHT+IE2OiQLKWaCSsDOk6IrssLsCvOozbvLXI9Jg/KEGSqDrR4j0Kdgbeeer+mXtV1iLbFtO49dBQ==
X-Received: by 2002:a17:907:3f1d:b0:aa6:88a2:cfbd with SMTP id a640c23a62f3a-ab2c3d09e99mr1401413766b.22.1736769613078;
        Mon, 13 Jan 2025 04:00:13 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1126:4:829:739b:3caa:6500? ([2620:10d:c092:500::6:97ef])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab2c90d52edsm490919366b.42.2025.01.13.04.00.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jan 2025 04:00:12 -0800 (PST)
Message-ID: <138f28ec-341e-4c48-a14b-4371a8198de8@gmail.com>
Date: Mon, 13 Jan 2025 12:00:12 +0000
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
To: Dave Young <dyoung@redhat.com>, Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org, devel@edk2.groups.io,
 kexec@lists.infradead.org, hannes@cmpxchg.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, leitao@debian.org, gourry@gourry.net,
 kernel-team@meta.com
References: <20250108215957.3437660-1-usamaarif642@gmail.com>
 <20250108215957.3437660-2-usamaarif642@gmail.com>
 <CAMj1kXH54Y0ae1OGwBe7-UiRBq9cFkDHbjxos_rEZPtan7NNzQ@mail.gmail.com>
 <d9c84079-6593-43f4-9483-648b665f03db@gmail.com>
 <CAMj1kXGYsJrqDzy_+g_wSAAEuQ_OnxvyJ8ZE+4gbr6KOY7iuow@mail.gmail.com>
 <8613563a-ee7c-4271-b1f0-4d1ac365ad3a@gmail.com>
 <CALu+AoS8tb=HgaybDw5OG4A1QbOXHvuidpu0ynmz-nE1nBqzTA@mail.gmail.com>
 <db7edff7-8a87-41db-9e40-202a498c5e29@gmail.com>
Content-Language: en-US
In-Reply-To: <db7edff7-8a87-41db-9e40-202a498c5e29@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 13/01/2025 11:27, Usama Arif wrote:
> 
> 
> On 13/01/2025 02:33, Dave Young wrote:
>> On Fri, 10 Jan 2025 at 18:54, Usama Arif <usamaarif642@gmail.com> wrote:
>>>
>>>
>>>
>>> On 10/01/2025 07:21, Ard Biesheuvel wrote:
>>>> On Thu, 9 Jan 2025 at 17:36, Usama Arif <usamaarif642@gmail.com> wrote:
>>>>>
>>>>>
>>>>>
>>>>> On 09/01/2025 15:45, Ard Biesheuvel wrote:
>>>>>> On Wed, 8 Jan 2025 at 23:00, Usama Arif <usamaarif642@gmail.com> wrote:
>>>>>>>
>>>>>>> The commit in [1] introduced a check to see if EFI memory attributes
>>>>>>> table was corrupted. It assumed that efi.memmap.nr_map remains
>>>>>>> constant, but it changes during late boot.
>>>>>>> Hence, the check is valid during cold boot, but not in the subsequent
>>>>>>> kexec boot.
>>>>>>>
>>>>>>> This is best explained with an exampled. At cold boot, for a test
>>>>>>> machine:
>>>>>>> efi.memmap.nr_map=91,
>>>>>>> memory_attributes_table->num_entries=48,
>>>>>>> desc_size = 48
>>>>>>> Hence, the check introduced in [1] where 3x the size of the
>>>>>>> entire EFI memory map is a reasonable upper bound for the size of this
>>>>>>> table is valid.
>>>>>>>
>>>>>>> In late boot __efi_enter_virtual_mode calls 2 functions that updates
>>>>>>> efi.memmap.nr_map:
>>>>>>> - efi_map_regions which reduces the `count` of map entries
>>>>>>>   (for e.g. if should_map_region returns false) and which is reflected
>>>>>>>   in efi.memmap by __efi_memmap_init.
>>>>>>>   At this point efi.memmap.nr_map becomes 46 in the test machine.
>>>>>>> - efi_free_boot_services which also reduces the number of memory regions
>>>>>>>   available (for e.g. if md->type or md->attribute is not the right value).
>>>>>>>   At this point efi.memmap.nr_map becomes 9 in the test machine.
>>>>>>> Hence when you kexec into a new kernel and pass efi.memmap, the
>>>>>>> paramaters that are compared are:
>>>>>>> efi.memmap.nr_map=9,
>>>>>>> memory_attributes_table->num_entries=48,
>>>>>>> desc_size = 48
>>>>>>> where the check in [1] is no longer valid with such a low efi.memmap.nr_map
>>>>>>> as it was reduced due to efi_map_regions and efi_free_boot_services.
>>>>>>>
>>>>>>> A more appropriate check is to see if the description size reported by
>>>>>>> efi and memory attributes table is the same.
>>>>>>>
>>>>>>> [1] https://lore.kernel.org/all/20241031175822.2952471-2-ardb+git@google.com/
>>>>>>>
>>>>>>> Fixes: 8fbe4c49c0cc ("efi/memattr: Ignore table if the size is clearly bogus")
>>>>>>> Reported-by: Breno Leitao <leitao@debian.org>
>>>>>>> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
>>>>>>> ---
>>>>>>>  drivers/firmware/efi/memattr.c | 16 ++++++----------
>>>>>>>  1 file changed, 6 insertions(+), 10 deletions(-)
>>>>>>>
>>>>>>
>>>>>> The more I think about this, the more I feel that kexec on x86 should
>>>>>> simply discard this table, and run with the firmware code RWX (which
>>>>>> is not the end of the world).
>>>>>
>>>>>
>>>>> By discard this table, do you mean kexec not use e820_table_firmware?
>>>>
>>>> No, I mean kexec ignores the memory attributes table.
>>>>
>>>>> Also a very basic question, what do you mean by run with the firmware RWX?
>>>>>
>>>>
>>>> The memory attributes table is an overlay for the EFI memory map that
>>>> describes which runtime code regions may be mapped with restricted
>>>> permissions. Without this table, everything will be mapped writable as
>>>> well as executable, but only in the EFI page tables, which are only
>>>> active when an EFI call is in progress.
>>>>
>>>
>>> Thanks for explaining!
>>>
>>> So basically get rid of memattr.c :)
>>>
>>> Do you mean get rid of it only for kexec, or not do it for any
>>> boot (including cold boot)?
>>> I do like this idea! I couldn't find this in the git history,
>>> but do you know if this was added in the linux kernel just
>>> because EFI spec added support for it, or if there was a
>>> specific security problem?
>>>
>>
>> Usama, can you try the patch below?
>> [ format is wrong due to webmail corruption.  But if it works I can
>> send a formal patch later ]
>>
>> $ git diff arch/x86
>> diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
>> index 846bf49f2508..58dc77c5210e 100644
>> --- a/arch/x86/platform/efi/quirks.c
>> +++ b/arch/x86/platform/efi/quirks.c
>> @@ -561,6 +561,11 @@ int __init efi_reuse_config(u64 tables, int nr_tables)
>>
>>                 if (!efi_guidcmp(guid, SMBIOS_TABLE_GUID))
>>                         ((efi_config_table_64_t *)p)->table = data->smbios;
>> +
>> +               /* Not bother to play with mem attr table across kexec */
>> +               if (!efi_guidcmp(guid, EFI_MEMORY_ATTRIBUTES_TABLE_GUID))
>> +                       ((efi_config_table_64_t *)p)->table =
>> EFI_INVALID_TABLE_ADDR;
>> +
>>                 p += sz;
>>         }
>>
> 
> This would work, I am guessing it will have a similar effect to what I sent
> last week in 
> https://lore.kernel.org/all/fd63613c-fd26-42de-b5ed-cc734f72eb36@gmail.com/
> 
> I think it needs to be wrapped in ifdef CONFIG_X86_64.
> 

IMO we should consider the 2 patches in this series first before disabling it for
kexec. These patches actually fix the issue.


