Return-Path: <linux-efi+bounces-2563-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF8A4A08E9D
	for <lists+linux-efi@lfdr.de>; Fri, 10 Jan 2025 11:54:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 729627A168A
	for <lists+linux-efi@lfdr.de>; Fri, 10 Jan 2025 10:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0D34205ACB;
	Fri, 10 Jan 2025 10:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eWO24Od3"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB105206F14;
	Fri, 10 Jan 2025 10:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736506438; cv=none; b=rRt/8YLZ9E0Pdpb6vkPmhCBsp55NciLk6XyW1zZSjSveE7Uew2jCVbXNtnW+NZtzeUaTrVUCON9NlvgW4WOzQ+zGEZFC+tdmE3reB5j5kyQd2rYNcolji7qJPJwDw0drxwjPJZTBozt97YhbHYaWZyCpmXfbWzgt+FfparJ0tBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736506438; c=relaxed/simple;
	bh=UuGnCjwVsCeergVV3WzYt6Khp3mVrZEP6da6u4OCHFY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZCDSklBV1UYLOJrVurRv8Ztn6a5NA47iWPQCdFV0QSPmsjbrmEfCQIohJ2f143s0itaouKs+0sh3qRvM59awXvGPXjW03BmwdCnBoAeMueEUqauRv+Y/piG97shV/tb57anBq93yybrhSKhGNe46HlX0FbRPWdfJEL8MQWqQIqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eWO24Od3; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5d90a5581fcso3097252a12.1;
        Fri, 10 Jan 2025 02:53:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736506435; x=1737111235; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ve3lNtLuYnUEedIKyQHjHUym+uf/AdZFMUlHp8J/SPs=;
        b=eWO24Od33k7p0a4Fim8cI+ugEqmmEkYeUo5+fQE/GOuydJBhQ+/YMqZEMeuJJbWzYI
         jBW7BD/gEdyCFb/+DhQC0WgCvrSo5jKO6rnMYMAu+wv/2gVtr/rKGWcULMgK9KoF1Ezu
         x9QQivI78zvkmQnpHV+ogHGR8Bh2UMRxkkOOkGBw50wCeqfoG9+S1OMGtKK4HTxXPmSL
         +EM7X+4N9cJVSQgm9AYGNtZJY0Hsdn63GhhJ5u6S/G066NLSNw+CPhKj4mBmrTL3C372
         RWMA2+Mew9DvdXyM3DomwaW8wfphGp/QHm1W7FFKEH0gCKfkP6MSw4IF5xHN51EX3UQb
         PEHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736506435; x=1737111235;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ve3lNtLuYnUEedIKyQHjHUym+uf/AdZFMUlHp8J/SPs=;
        b=IL5C9qeXMmGiuhuj+ZKkNgcyYCCZnlwm7exnQYShg0o8NG4tQ6PtBuOs416FKXua8J
         dXCNj5aiBU49FuZUPXrSmBQgty/vOa/cmKwEKxepXKjvW4c5VPfeJzhdM2y+Qq34+Zz2
         BOSioZs+olpzv7gc4VvOlW68EVf+ywZAl+9sKTq0kYScK3CcxTQHlPaqlhCRQVDqsE2b
         UcatCBfxmRNTi+3c36JVInvTAfHQJqqaapCLy2V/b64Rmf1qcTFnAE+xafaGazq9EeCG
         wzB8YuynvsQCb6bkvbH67WfgyN7LGiEleWf0g7Nj83OF9m+6WzkivvWaoWJIi9MWnJbj
         Wrjw==
X-Forwarded-Encrypted: i=1; AJvYcCU2U2+Pd6Q82VucmruHiFVSqmKSHftMf7vq3LMldyWNYMgEG2qdCt+QJU0GTN5jM7OLYAtd+SaSLAjBQFI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx/NHbJ8RulMNFVSGHjoDsuEtzgqTCDxX3sjPv5LrVP+qY1qUY
	cUhtMTn+xEbwbAaTBkUBIpZ9Rs3EfqNjnHPTh5FyBDXX+Fdw6ra8
X-Gm-Gg: ASbGncsYVXUQO/iwX2QflE9LVCtQx4wr++bdetxkZKq//we1Ln5ATavCGtuPRQ1jkF+
	LWBdkK86+Dn3/yViaZbL3pp2+cStTLbxctpE9y1qJMKut2lN50h25sHGJibaFjw9KPJdTGhyO97
	sAnf5IUDYa+2d4EIPKwZF0Er6+rXttsSdvPkn5bQre3XLZkgcwZptgvmIXrpHoWZ6aevsKb3zGS
	M+LZlPUASVqIsSCV0Xus3q725QlIqJYjIcOvBa9+Dl08mRnOp/XyHJF5vZeCkEpuRSrIrwE4BZe
	Dzcd7s1RPsac4iyxmxv5ToK0ihBM
X-Google-Smtp-Source: AGHT+IHUoKF5CCleTB2jU9vLsvOAEPHxoqMfeJizDfgZZl9x+zXjW5TDWSL8oHA1WM8ocRBnyA/UtQ==
X-Received: by 2002:a05:6402:2347:b0:5d2:729f:995f with SMTP id 4fb4d7f45d1cf-5d972e6f957mr8778390a12.29.1736506435017;
        Fri, 10 Jan 2025 02:53:55 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1126:4:829:739b:3caa:6500? ([2620:10d:c092:500::5:e213])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d98fe8f68csm1544698a12.0.2025.01.10.02.53.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jan 2025 02:53:54 -0800 (PST)
Message-ID: <8613563a-ee7c-4271-b1f0-4d1ac365ad3a@gmail.com>
Date: Fri, 10 Jan 2025 10:53:53 +0000
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
 <d9c84079-6593-43f4-9483-648b665f03db@gmail.com>
 <CAMj1kXGYsJrqDzy_+g_wSAAEuQ_OnxvyJ8ZE+4gbr6KOY7iuow@mail.gmail.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <CAMj1kXGYsJrqDzy_+g_wSAAEuQ_OnxvyJ8ZE+4gbr6KOY7iuow@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/01/2025 07:21, Ard Biesheuvel wrote:
> On Thu, 9 Jan 2025 at 17:36, Usama Arif <usamaarif642@gmail.com> wrote:
>>
>>
>>
>> On 09/01/2025 15:45, Ard Biesheuvel wrote:
>>> On Wed, 8 Jan 2025 at 23:00, Usama Arif <usamaarif642@gmail.com> wrote:
>>>>
>>>> The commit in [1] introduced a check to see if EFI memory attributes
>>>> table was corrupted. It assumed that efi.memmap.nr_map remains
>>>> constant, but it changes during late boot.
>>>> Hence, the check is valid during cold boot, but not in the subsequent
>>>> kexec boot.
>>>>
>>>> This is best explained with an exampled. At cold boot, for a test
>>>> machine:
>>>> efi.memmap.nr_map=91,
>>>> memory_attributes_table->num_entries=48,
>>>> desc_size = 48
>>>> Hence, the check introduced in [1] where 3x the size of the
>>>> entire EFI memory map is a reasonable upper bound for the size of this
>>>> table is valid.
>>>>
>>>> In late boot __efi_enter_virtual_mode calls 2 functions that updates
>>>> efi.memmap.nr_map:
>>>> - efi_map_regions which reduces the `count` of map entries
>>>>   (for e.g. if should_map_region returns false) and which is reflected
>>>>   in efi.memmap by __efi_memmap_init.
>>>>   At this point efi.memmap.nr_map becomes 46 in the test machine.
>>>> - efi_free_boot_services which also reduces the number of memory regions
>>>>   available (for e.g. if md->type or md->attribute is not the right value).
>>>>   At this point efi.memmap.nr_map becomes 9 in the test machine.
>>>> Hence when you kexec into a new kernel and pass efi.memmap, the
>>>> paramaters that are compared are:
>>>> efi.memmap.nr_map=9,
>>>> memory_attributes_table->num_entries=48,
>>>> desc_size = 48
>>>> where the check in [1] is no longer valid with such a low efi.memmap.nr_map
>>>> as it was reduced due to efi_map_regions and efi_free_boot_services.
>>>>
>>>> A more appropriate check is to see if the description size reported by
>>>> efi and memory attributes table is the same.
>>>>
>>>> [1] https://lore.kernel.org/all/20241031175822.2952471-2-ardb+git@google.com/
>>>>
>>>> Fixes: 8fbe4c49c0cc ("efi/memattr: Ignore table if the size is clearly bogus")
>>>> Reported-by: Breno Leitao <leitao@debian.org>
>>>> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
>>>> ---
>>>>  drivers/firmware/efi/memattr.c | 16 ++++++----------
>>>>  1 file changed, 6 insertions(+), 10 deletions(-)
>>>>
>>>
>>> The more I think about this, the more I feel that kexec on x86 should
>>> simply discard this table, and run with the firmware code RWX (which
>>> is not the end of the world).
>>
>>
>> By discard this table, do you mean kexec not use e820_table_firmware?
> 
> No, I mean kexec ignores the memory attributes table.
> 
>> Also a very basic question, what do you mean by run with the firmware RWX?
>>
> 
> The memory attributes table is an overlay for the EFI memory map that
> describes which runtime code regions may be mapped with restricted
> permissions. Without this table, everything will be mapped writable as
> well as executable, but only in the EFI page tables, which are only
> active when an EFI call is in progress.
> 

Thanks for explaining!

So basically get rid of memattr.c :)

Do you mean get rid of it only for kexec, or not do it for any
boot (including cold boot)?
I do like this idea! I couldn't find this in the git history,
but do you know if this was added in the linux kernel just
because EFI spec added support for it, or if there was a
specific security problem?

Thanks!

