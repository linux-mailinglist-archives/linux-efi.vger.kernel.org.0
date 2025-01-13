Return-Path: <linux-efi+bounces-2610-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 542B8A0B5B0
	for <lists+linux-efi@lfdr.de>; Mon, 13 Jan 2025 12:30:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D59F188338F
	for <lists+linux-efi@lfdr.de>; Mon, 13 Jan 2025 11:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 819CD233122;
	Mon, 13 Jan 2025 11:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BTtWrocB"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED752343A1;
	Mon, 13 Jan 2025 11:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736767661; cv=none; b=PNThTbHxy1TUmTsOHrPrVI8ldSGnx+qiRGCtTM+uM0Lczk2dQWvT3gy5SNLaVzRbTdrlD69na5j1zheWxQZaMeiaHFOtMUIrr3V+41xK7ugFOAFxq5BgAZsV824Y5MpD+ufHtcvBf6kLWGTfNAzTVWUJYlHwStzRLFZIHV92ncc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736767661; c=relaxed/simple;
	bh=eGI5QTkTg6Tzkg/ODQMehPcgNJ37m5L6/9M5mIlEu00=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RYjfIb6DNUHqIPYKD0nm4QHBPTeK6oRGpHhBiSjDJudBqsvlC53l+QPXgsxU0RddSCEiIQ8MP5k8h+tv99zUp+B7bgeGTbE0VOhSfO8VmkXgnqaV59v0pl52XTd+Ptz8r0uUfWJPVz52IYolUewg3geZe/KrFBtkaW5XvRG0vgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BTtWrocB; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5d7e3f1fdafso8522082a12.0;
        Mon, 13 Jan 2025 03:27:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736767658; x=1737372458; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9p4WiiF7Tn3+Ob+aGqMCEaraRLkQng6ZulqTbNdq1sQ=;
        b=BTtWrocB/Zz7e9yY5OvvxsKIDMltKBcJadfATzCd14hA6HJWGRlyIgjMes5N7cu7+6
         rn9YkHdej3eaayvrXtbrG6HXuaDjeqqZTvX/knowY1u7++cFMfI4JymWxiGytZFia8JD
         KGBGRahyxHK5StQOYaNleTT9BCIzykDCqei/avX4USpRNWgS7e5s1XI9BRv+0Gne+BTq
         8GJbwwD4LfFv73xleu4GTOY2d+mhjJkzK8GWJTB/kqwxFB+Us2D2DZQvIJ/nGylApNVI
         wBf1jqHdXqYVzRJLV9J09Ep//hsDS+V8G+JrdsRI43bHoxwRCZph5uOgWfPAS7cGVvQ/
         KjGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736767658; x=1737372458;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9p4WiiF7Tn3+Ob+aGqMCEaraRLkQng6ZulqTbNdq1sQ=;
        b=BG1RLIP6hE8ygjxiTBJZ5IR010BkP5MndYQJhI7qV29RWdyTrXblEGb1Nj5851Dzb3
         59fOPhDfc6EU7rPHAONOJAt/SZjOUV546ZBay7A/gaImSG64ZvTAn5nAhCTey8ZauFSi
         5TX1FOQX87SZ4jcs8jNrOqVhYMBYjvwggvKHycsiOFiDfBBPMI5F8MZGxoYXgC9NFyvg
         gSwpWehidP7RGO/+a8mbbmzuDOj39XbHEX/Y4qhQUUPzp2vpeHHn8PSBSmKz5mLHhpD7
         35Kgk51H0q2RewCohuPyQrH6H7TFHcuAgaPgo7k/oRVHps8sSKyVPMMcZgR70Mt6v6yc
         BsAw==
X-Forwarded-Encrypted: i=1; AJvYcCVcbr62HclzgcrdK3mMNI6QxMsZ++8zNHJYDhsAenyvJhUw/auL7WBRGz4nCKly4Id3c/pDyqBl+HUKYza5@vger.kernel.org, AJvYcCWIh2xASLkKNycXpYjtXnmISnudwpKlYiEHIEun4JGmUdevOI5QDHIeOP4M1ZKpOVX/Dursc18j0Qo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoEFY5m/Y/ra42iM29g+QC56zjYpxM3ihTe7qT41LN+jKxQ8Za
	L6FSgkuFWAUp9u5bh/H4AyNz0SZqtxgmrytH6nrE03Z9jwdYAmBJHS/VIw==
X-Gm-Gg: ASbGnctZ/+BjCmOTRcwyaqk5LgBop80VAkhFdlfjgdOB63eyBGt31pf68lqCnh8NCkP
	hF88t0F6fpwSs0PCfXzogdsRJ5ZExv1+WB/8IoJujST4ajMJepSghfNIeRWxEXgE5O6uup04Uui
	1RB6KivzxnFyYk1xrlUe6dC+LsOux0hWm4EO3aaVRmJ0MKegy8IvIyZSldmjdJRPm8n0VPMxQGV
	sp3fjx8l3ZhJ4vqBGBopF2WpQeIAhvfDus1VHopO9lhEH5lHcdmh3jR/v1o3QfVmG4Zas9l41rO
	9A9B8msUl1qCAwd3YfDURvDwptAML0BhzA==
X-Google-Smtp-Source: AGHT+IHY6ghLf4F1/E7hRXTvtL58y1ipNyvjXd5BzF87rdGENcFmDQO+YbClGjqRU3qWE4NMAa/7Lw==
X-Received: by 2002:a05:6402:5245:b0:5d0:ee52:353e with SMTP id 4fb4d7f45d1cf-5d972e696a4mr19574109a12.29.1736767657514;
        Mon, 13 Jan 2025 03:27:37 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1126:4:829:739b:3caa:6500? ([2620:10d:c092:500::6:97ef])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d9904a55f9sm4673231a12.81.2025.01.13.03.27.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jan 2025 03:27:37 -0800 (PST)
Message-ID: <db7edff7-8a87-41db-9e40-202a498c5e29@gmail.com>
Date: Mon, 13 Jan 2025 11:27:36 +0000
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/2] efi/memattr: Use desc_size instead of total size to
 check for corruption
To: Dave Young <dyoung@redhat.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org,
 devel@edk2.groups.io, kexec@lists.infradead.org, hannes@cmpxchg.org,
 x86@kernel.org, linux-kernel@vger.kernel.org, leitao@debian.org,
 gourry@gourry.net, kernel-team@meta.com
References: <20250108215957.3437660-1-usamaarif642@gmail.com>
 <20250108215957.3437660-2-usamaarif642@gmail.com>
 <CAMj1kXH54Y0ae1OGwBe7-UiRBq9cFkDHbjxos_rEZPtan7NNzQ@mail.gmail.com>
 <d9c84079-6593-43f4-9483-648b665f03db@gmail.com>
 <CAMj1kXGYsJrqDzy_+g_wSAAEuQ_OnxvyJ8ZE+4gbr6KOY7iuow@mail.gmail.com>
 <8613563a-ee7c-4271-b1f0-4d1ac365ad3a@gmail.com>
 <CALu+AoS8tb=HgaybDw5OG4A1QbOXHvuidpu0ynmz-nE1nBqzTA@mail.gmail.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <CALu+AoS8tb=HgaybDw5OG4A1QbOXHvuidpu0ynmz-nE1nBqzTA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 13/01/2025 02:33, Dave Young wrote:
> On Fri, 10 Jan 2025 at 18:54, Usama Arif <usamaarif642@gmail.com> wrote:
>>
>>
>>
>> On 10/01/2025 07:21, Ard Biesheuvel wrote:
>>> On Thu, 9 Jan 2025 at 17:36, Usama Arif <usamaarif642@gmail.com> wrote:
>>>>
>>>>
>>>>
>>>> On 09/01/2025 15:45, Ard Biesheuvel wrote:
>>>>> On Wed, 8 Jan 2025 at 23:00, Usama Arif <usamaarif642@gmail.com> wrote:
>>>>>>
>>>>>> The commit in [1] introduced a check to see if EFI memory attributes
>>>>>> table was corrupted. It assumed that efi.memmap.nr_map remains
>>>>>> constant, but it changes during late boot.
>>>>>> Hence, the check is valid during cold boot, but not in the subsequent
>>>>>> kexec boot.
>>>>>>
>>>>>> This is best explained with an exampled. At cold boot, for a test
>>>>>> machine:
>>>>>> efi.memmap.nr_map=91,
>>>>>> memory_attributes_table->num_entries=48,
>>>>>> desc_size = 48
>>>>>> Hence, the check introduced in [1] where 3x the size of the
>>>>>> entire EFI memory map is a reasonable upper bound for the size of this
>>>>>> table is valid.
>>>>>>
>>>>>> In late boot __efi_enter_virtual_mode calls 2 functions that updates
>>>>>> efi.memmap.nr_map:
>>>>>> - efi_map_regions which reduces the `count` of map entries
>>>>>>   (for e.g. if should_map_region returns false) and which is reflected
>>>>>>   in efi.memmap by __efi_memmap_init.
>>>>>>   At this point efi.memmap.nr_map becomes 46 in the test machine.
>>>>>> - efi_free_boot_services which also reduces the number of memory regions
>>>>>>   available (for e.g. if md->type or md->attribute is not the right value).
>>>>>>   At this point efi.memmap.nr_map becomes 9 in the test machine.
>>>>>> Hence when you kexec into a new kernel and pass efi.memmap, the
>>>>>> paramaters that are compared are:
>>>>>> efi.memmap.nr_map=9,
>>>>>> memory_attributes_table->num_entries=48,
>>>>>> desc_size = 48
>>>>>> where the check in [1] is no longer valid with such a low efi.memmap.nr_map
>>>>>> as it was reduced due to efi_map_regions and efi_free_boot_services.
>>>>>>
>>>>>> A more appropriate check is to see if the description size reported by
>>>>>> efi and memory attributes table is the same.
>>>>>>
>>>>>> [1] https://lore.kernel.org/all/20241031175822.2952471-2-ardb+git@google.com/
>>>>>>
>>>>>> Fixes: 8fbe4c49c0cc ("efi/memattr: Ignore table if the size is clearly bogus")
>>>>>> Reported-by: Breno Leitao <leitao@debian.org>
>>>>>> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
>>>>>> ---
>>>>>>  drivers/firmware/efi/memattr.c | 16 ++++++----------
>>>>>>  1 file changed, 6 insertions(+), 10 deletions(-)
>>>>>>
>>>>>
>>>>> The more I think about this, the more I feel that kexec on x86 should
>>>>> simply discard this table, and run with the firmware code RWX (which
>>>>> is not the end of the world).
>>>>
>>>>
>>>> By discard this table, do you mean kexec not use e820_table_firmware?
>>>
>>> No, I mean kexec ignores the memory attributes table.
>>>
>>>> Also a very basic question, what do you mean by run with the firmware RWX?
>>>>
>>>
>>> The memory attributes table is an overlay for the EFI memory map that
>>> describes which runtime code regions may be mapped with restricted
>>> permissions. Without this table, everything will be mapped writable as
>>> well as executable, but only in the EFI page tables, which are only
>>> active when an EFI call is in progress.
>>>
>>
>> Thanks for explaining!
>>
>> So basically get rid of memattr.c :)
>>
>> Do you mean get rid of it only for kexec, or not do it for any
>> boot (including cold boot)?
>> I do like this idea! I couldn't find this in the git history,
>> but do you know if this was added in the linux kernel just
>> because EFI spec added support for it, or if there was a
>> specific security problem?
>>
> 
> Usama, can you try the patch below?
> [ format is wrong due to webmail corruption.  But if it works I can
> send a formal patch later ]
> 
> $ git diff arch/x86
> diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
> index 846bf49f2508..58dc77c5210e 100644
> --- a/arch/x86/platform/efi/quirks.c
> +++ b/arch/x86/platform/efi/quirks.c
> @@ -561,6 +561,11 @@ int __init efi_reuse_config(u64 tables, int nr_tables)
> 
>                 if (!efi_guidcmp(guid, SMBIOS_TABLE_GUID))
>                         ((efi_config_table_64_t *)p)->table = data->smbios;
> +
> +               /* Not bother to play with mem attr table across kexec */
> +               if (!efi_guidcmp(guid, EFI_MEMORY_ATTRIBUTES_TABLE_GUID))
> +                       ((efi_config_table_64_t *)p)->table =
> EFI_INVALID_TABLE_ADDR;
> +
>                 p += sz;
>         }
> 

This would work, I am guessing it will have a similar effect to what I sent
last week in 
https://lore.kernel.org/all/fd63613c-fd26-42de-b5ed-cc734f72eb36@gmail.com/

I think it needs to be wrapped in ifdef CONFIG_X86_64.


