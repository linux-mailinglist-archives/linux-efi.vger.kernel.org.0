Return-Path: <linux-efi+bounces-2707-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C9B2A190E9
	for <lists+linux-efi@lfdr.de>; Wed, 22 Jan 2025 12:50:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F04F2188CF27
	for <lists+linux-efi@lfdr.de>; Wed, 22 Jan 2025 11:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68CAA211A37;
	Wed, 22 Jan 2025 11:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GtWb8xbu"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F3D211A0A;
	Wed, 22 Jan 2025 11:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737546629; cv=none; b=Lecl772fEpqNTtbKbf/WuEoB+fI570Z4gdmmklvvA/lkD3PLlJh8VzxCCmGgZ2HUWd4/C4P29cPSbhzIdAJCWFSmfdJuKU8Z8SIarVw5gESBlXatwnSeZgTRjHgPTAenDu6Xotxhr+tqE94AgM9Xv7azwM2rDAbNp3wnyBI2/wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737546629; c=relaxed/simple;
	bh=qeEqfLcxSOF9EbQ9CxN2DnMppKqvsd9TfGNPJJAhrf0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NlKUbI1m8YkHQWB+thEd3cf7x5M2mZCVbyBFvaTaw0PQUwQmtKtFTn9h8keXhGbbFx6St2RKoJKQEjlwOZk2TQCqBabUdtNZQXcNuYoP1w8anZpjNH9AlFesrSWfuLyUeVvmiqgVs2d9vhQwS92Xz3M+Nqy+T5leH/GscTpvvWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GtWb8xbu; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-aaf60d85238so1127659366b.0;
        Wed, 22 Jan 2025 03:50:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737546626; x=1738151426; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oh23WD6b9+c/DI2oI9FQ/B0EymzRbxc0VAjw7ASF7LU=;
        b=GtWb8xbu+dMOl1y8yROz4oGHo+3DHq/1O0s+azrXdQgKmDcOrFi58KaCylEf2ctOTt
         HLbXtv4B2sIuzCqUQY5cjaJ1kavvaDNbUBaI+HgGP0qxs+TAWdJLN2/laY6Z8GK4MYnd
         9rUAIrWY+cMr5Ui7QkgmTQ/kNFflDNJezrF9WQftOJMoKehiDMpcSjS3GhA23AJWpF35
         andXiYOi6CjrU4OQQvCdhbvpl2QoUzomCyjVFv71jP5nxLkH41MpnXGz98E4egxtLQDL
         6kZFvAwB6AFZMf3DUkQLXsPoGln4EwXEIeQfyC3EJg+4kqp/10ABSbiEAn6K8CbQ6A3C
         eyKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737546626; x=1738151426;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oh23WD6b9+c/DI2oI9FQ/B0EymzRbxc0VAjw7ASF7LU=;
        b=LsKI4xKjLPvjIgx8G1B2KPGqt2T1My0wHMGHFJGpdLQBV3hUMlo8wveYoXzfhLLMBH
         5pWAOMz7HLATuc+X9b+jiV+h9f2DPIGZ2saY+uxeEb1iy3t30d79OJeKqYv0JWEOzu1u
         zQkjz2rmdLgMwGL77pjC2lm4b0iHWs3dbKAyL4GnAOC/8CZKkvOeU5ugXZciBuCzaxen
         VUEuFc+Jv/+aIKpA1HSX8x2FzLC4asJFdLelwog2dgoIb4EAfEFa9G0ktqiiVE7L0hT5
         4zG4YgdtmK1ZvZx4w7QASGCIF5l8ophtcwhs1fssUHZzv5z2Zx/LRSPM8XZm4MZi0Jav
         Tjpg==
X-Forwarded-Encrypted: i=1; AJvYcCUg+Tv5+yMfXv+Dn3Dln0++1qclHL4DrX4aeKXTXbiVB0Z6ANK5fXUILuDIpMFj8YmJcg5HDJxJKcBAtW9+@vger.kernel.org, AJvYcCVXCl6Sp9dW0/jmmkHHjEsm6TSVkxDJNelzpicsbsWxxWL6NJLuveCzZRGjb6Nkn0qEZzt1VdaTbOY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXx8JE1WT27rx9ggQvVh251upyps/yokTJ66HTOoON5oNpXIf5
	L2dHyVbnOj096s9DnL+QBOyeAL8nuxHO5uWtlk7M7K1Zp3hoMkCK
X-Gm-Gg: ASbGncsiNphgmRFEKdjWQh1XyS2NwnFy8ndNEcykpuQZtPbENLl7ZLg+HvN7cgpO9XY
	ZQK6h9L+isbNrit+PE1Pmrg5ESkEAwj0zx6fzFFCwCD0M0g/1WlnqmLi01ax2+GLBI8GHXbMEKW
	+R9LbwQhaqOBTAPEJV4PxHdSPxSW8VyZ5Lm4BAeywWWr4mFQyefJIzLPQVu8YLOU/xR8fFk0zGZ
	jOWQoIzLaBMxa7Wy6KPzsEX7SPmy1Nuf7uaky7RJ6OR3Pf1aF0ELhgYSZFbNef0rmZrP7uAyKdQ
	tk3X6bKsHXjJnPKoJOXF7SI+7AlGJLVb1ogp2fG7Sw==
X-Google-Smtp-Source: AGHT+IF+incGb/IZc3tkpwYf1H3kUvKL8NDvsH89F25knBJMw3Vy2+yLj3qjgDdMHXGS49J7p9SFOw==
X-Received: by 2002:a17:907:7f89:b0:aa6:29dc:11b with SMTP id a640c23a62f3a-ab38b1ff059mr1576763966b.16.1737546625488;
        Wed, 22 Jan 2025 03:50:25 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1126:4:829:739b:3caa:6500? ([2620:10d:c092:500::4:1c5b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab384d2cfc2sm887377566b.82.2025.01.22.03.50.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jan 2025 03:50:25 -0800 (PST)
Message-ID: <1a4223a2-77ae-4f15-a40b-dc33de9e6c2d@gmail.com>
Date: Wed, 22 Jan 2025 11:50:24 +0000
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
 <db7edff7-8a87-41db-9e40-202a498c5e29@gmail.com>
 <138f28ec-341e-4c48-a14b-4371a8198de8@gmail.com>
 <ed7ad48f-2270-4966-bdba-ccd4592a0fd4@gmail.com>
 <CAMj1kXFMxfOswAdBEVsCoVO90y_m1TUigWRG-3FJTsv4xOGTpw@mail.gmail.com>
 <029cff22-f2e0-4796-9c27-1df056e08f8f@gmail.com>
 <CAMj1kXEhKbuqVz9paggxQQz1Wyk_UNRvWZ46X7YKx9b-xMfWyQ@mail.gmail.com>
 <c5f68f9f-1494-426b-a5b2-bf6c1483c02f@gmail.com>
 <CALu+AoS5_w2CV5w+b1WrFRFH7nfwmkLZUh=AXn=D=7rAhDNVAQ@mail.gmail.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <CALu+AoS5_w2CV5w+b1WrFRFH7nfwmkLZUh=AXn=D=7rAhDNVAQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 22/01/2025 05:36, Dave Young wrote:
> Hi,
> On Mon, 20 Jan 2025 at 19:48, Usama Arif <usamaarif642@gmail.com> wrote:
>>
>>
>>
>> On 20/01/2025 11:29, Ard Biesheuvel wrote:
>>> On Mon, 20 Jan 2025 at 11:50, Usama Arif <usamaarif642@gmail.com> wrote:
>>>>
>>>>
>>>>
>>>> On 20/01/2025 10:32, Ard Biesheuvel wrote:
>>>>> On Mon, 20 Jan 2025 at 11:27, Usama Arif <usamaarif642@gmail.com> wrote:
>>>>>>
>>>>>>
>>>>> ...
>>>>>> Hi Ard,
>>>>>>
>>>>>> Just wanted to check how should we proceed forward? Should we try and fix the warning
>>>>>> and corruption during kexec as done in this series or not initialize memory attributes
>>>>>> table at all in kexec boot? I would prefer fixing the issues as in this series.
>>>>>>
>>>>>
>>>>> I would prefer kexec boot on x86 to disregard the memory attributes
>>>>> table entirely.
>>>>
>>>> Would you like Dave to send something like
>>>> https://lore.kernel.org/all/CALu+AoS8tb=HgaybDw5OG4A1QbOXHvuidpu0ynmz-nE1nBqzTA@mail.gmail.com/
>>>> on the mailing list (wrapped in ifdef CONFIG_X86_64)
>>>>
>>>
>>> I prefer this approach. and no need for the ifdef, this is x86
>>> specific code, and the memory attributes table is already ignored
>>> entirely on 32-bit x86 iirc
>>
>> ah yes, I ignored the file name when reviewing it and just focused on the function :)
>>
>> Will wait for Dave to send it.
> 
> Ok,  I will add reported-by from you and suggested-by from Ard.  But I
> can not test the efi mem attr, I'd prefer to have your test results
> first.  Could you confirm that?
> 

Please also add Reported-by: Breno Leitao <leitao@debian.org>
who originally discovered and reported the issue.

I have tested it and it works, efi_memattr_init will just return 0 as
efi_mem_attr_table = EFI_INVALID_TABLE_ADDR, so it won't be
initialized. Feel free to add Tested-by tag from me.

Thanks,
Usama

