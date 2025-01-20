Return-Path: <linux-efi+bounces-2695-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DAE9A16BCA
	for <lists+linux-efi@lfdr.de>; Mon, 20 Jan 2025 12:48:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 073323A677B
	for <lists+linux-efi@lfdr.de>; Mon, 20 Jan 2025 11:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E49F41B87C4;
	Mon, 20 Jan 2025 11:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KqHKZi8p"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373EC2770C;
	Mon, 20 Jan 2025 11:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737373726; cv=none; b=galtMfnTDNlH5uCtAkcx0/xAS2CPDxvu0uV1GKn3dH/Qa8/VVlgeH6O+wzACVgn5fKl+MlXUkFy2Mjm9EQE+ImhOPhT0v6+DZtbPFlety7iI9KByHoUumfqGIULB494VUJOjBHJFLqcSgCx78p3k73+98ceq7OxByLbWRfLG/oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737373726; c=relaxed/simple;
	bh=DbMHu5ekrCllZytH22VowTm4rlITy4yS3FDYHC+Y9SI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=na11VLBggoghJFflj4efKQbTKsszartPeInP2BW+y+cJ2OcoJMb4UC1PMcd0S4K+fIqvQscJjgwh0ap9YrzU9isWzpr2FNvcoexTwvY59E8I21PG7Ck2b2ptE/zPn80Nt/z4V0UxIi6c0Utbc9oUVznPJqJ83Ib8j14N+mgHLpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KqHKZi8p; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-aab925654d9so776897266b.2;
        Mon, 20 Jan 2025 03:48:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737373723; x=1737978523; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=slhGj4lfgwuXBxH87F1uWakd45t5DstPDaiKXvqzZ+U=;
        b=KqHKZi8pEvZVA0nMkLHo3B50AlXg/5Rzc0GMhiXExisahSMNKk7oW2GBTae+PwJ24d
         i58JUiVpW0tr60mkIzNbV7brh/GabHq669U+reNEdSPSQqzAvl5IfHyIG/9yj4TAtKat
         IujJ4NmwjBP3NbhgthyBIXsQ1PvEhSuTVumiUC+y//Ye/rx02mgPDkeHN5YsB0Io/Bxg
         rFUj/Ngc24n8MtOq0k0wr6XYE997gheashS+HHH+XGbP7jddhFm4TxGVgy9/BXstuHtm
         Te/JOPreQNi4TxqJ8FPtxvFVlkzRlGAzjOlSGCjALZt3UaL0LkVEjToggugj5GO+ReRO
         LEvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737373723; x=1737978523;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=slhGj4lfgwuXBxH87F1uWakd45t5DstPDaiKXvqzZ+U=;
        b=Iv3mrDEKYHuABCtf50A/u6yufAmlpWuB7DIciGC4DM9396QQOZQsDy4Wga13JiQKig
         0H+o2t24QkvERuTjHKld1GrcNs1bLtk5wMHfK/F+C7J6aWgcxlQ3YiHzAgVn9FXQdIcf
         /ZaE7WKVoxFHP8ZP3WdjIW9OORRJC8imc2hhYQ3ebSVBnEyVUkgsHVGvo4Kv7VOhvyUP
         Lx82ggQENcWLsCj5l/1tkRnQ/fMrLCsbRVoNQtKgziST3iTnbnU8YE0Zrd8ZZsEkRNSA
         KvdAiQQV4DNBhgnt6yomEq852z1HxIwrED8ibYyXySMD//eYi800FFu1C6gueG1v1iVW
         Ft2Q==
X-Forwarded-Encrypted: i=1; AJvYcCW+TuoYPhHmlXDS4VBgZ6n+NvWqbYgIGHkYzLDC+APL6Hf4kdJbNmB0ijiZnhhplYLuoydscgZ+8ULrHNs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzwyI9j317AYy3/wFIg2P4JuJYbP/Dj/GYuTWBe9Fj/0xlvzCw
	gc0tlL4ZLp4zgn2BdQ5XP8eDt4ER7umEx+8v606bsNgZuEyhxK8q
X-Gm-Gg: ASbGncttrGKGUXOVa1Yr7kr0m6s8XousdLwzHR9VcONC9o6mfGakbbTjppsxPCJGH0A
	1MiBxPdr5Scui7xP/4IPhYRrjueJ06cY39Mq1bwOjKwiYaXDVxtGQiRoarhaAsjjQxNRnS6P2W3
	7qEEIDH/0fm5zf3jH+ztzgUKHG5MTM6HvlIqvBqJHsXe+aY/stRN7o8nErrSz2qAT4ehB+C4Y0m
	hbD8PzpuIgRTbHmNoKG0UaNhBDDLOgKA+TbT5+YTPp+emWa/3mejjhSYkPRwGiIVlFQqjJ2Tm8j
	z0aoN9TJ3WrVsdinsbhuGiAWthAy1nPqm8Y7iA8r9A==
X-Google-Smtp-Source: AGHT+IFYFn/WFKp/ftN1HulWjfWaLQ02JfyVI2i0N4djdi9JbtdvvOdvnirZWnQ0LpueoRV/zRiVxQ==
X-Received: by 2002:a17:907:1c85:b0:aa6:81dc:6638 with SMTP id a640c23a62f3a-ab38b26f4cemr1152029566b.16.1737373723314;
        Mon, 20 Jan 2025 03:48:43 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1126:4:829:739b:3caa:6500? ([2620:10d:c092:500::4:4372])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab384f290fasm614214466b.103.2025.01.20.03.48.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jan 2025 03:48:42 -0800 (PST)
Message-ID: <c5f68f9f-1494-426b-a5b2-bf6c1483c02f@gmail.com>
Date: Mon, 20 Jan 2025 11:48:42 +0000
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/2] efi/memattr: Use desc_size instead of total size to
 check for corruption
To: Ard Biesheuvel <ardb@kernel.org>, Dave Young <dyoung@redhat.com>
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
 <138f28ec-341e-4c48-a14b-4371a8198de8@gmail.com>
 <ed7ad48f-2270-4966-bdba-ccd4592a0fd4@gmail.com>
 <CAMj1kXFMxfOswAdBEVsCoVO90y_m1TUigWRG-3FJTsv4xOGTpw@mail.gmail.com>
 <029cff22-f2e0-4796-9c27-1df056e08f8f@gmail.com>
 <CAMj1kXEhKbuqVz9paggxQQz1Wyk_UNRvWZ46X7YKx9b-xMfWyQ@mail.gmail.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <CAMj1kXEhKbuqVz9paggxQQz1Wyk_UNRvWZ46X7YKx9b-xMfWyQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 20/01/2025 11:29, Ard Biesheuvel wrote:
> On Mon, 20 Jan 2025 at 11:50, Usama Arif <usamaarif642@gmail.com> wrote:
>>
>>
>>
>> On 20/01/2025 10:32, Ard Biesheuvel wrote:
>>> On Mon, 20 Jan 2025 at 11:27, Usama Arif <usamaarif642@gmail.com> wrote:
>>>>
>>>>
>>> ...
>>>> Hi Ard,
>>>>
>>>> Just wanted to check how should we proceed forward? Should we try and fix the warning
>>>> and corruption during kexec as done in this series or not initialize memory attributes
>>>> table at all in kexec boot? I would prefer fixing the issues as in this series.
>>>>
>>>
>>> I would prefer kexec boot on x86 to disregard the memory attributes
>>> table entirely.
>>
>> Would you like Dave to send something like
>> https://lore.kernel.org/all/CALu+AoS8tb=HgaybDw5OG4A1QbOXHvuidpu0ynmz-nE1nBqzTA@mail.gmail.com/
>> on the mailing list (wrapped in ifdef CONFIG_X86_64)
>>
> 
> I prefer this approach. and no need for the ifdef, this is x86
> specific code, and the memory attributes table is already ignored
> entirely on 32-bit x86 iirc

ah yes, I ignored the file name when reviewing it and just focused on the function :)

Will wait for Dave to send it.

Thanks,
Usama

