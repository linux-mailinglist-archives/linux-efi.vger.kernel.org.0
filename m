Return-Path: <linux-efi+bounces-2693-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4910FA16B06
	for <lists+linux-efi@lfdr.de>; Mon, 20 Jan 2025 11:50:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D3687A269C
	for <lists+linux-efi@lfdr.de>; Mon, 20 Jan 2025 10:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90B69192B81;
	Mon, 20 Jan 2025 10:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ShKfbnId"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8F3187872;
	Mon, 20 Jan 2025 10:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737370240; cv=none; b=E+CRYa+rrWbWSFHWI+rk3uCRIUFvJqn0UcId99wxoE7MzXGxr7ehi8EBCGJ1AZ9S8pCN5sI5NiQ1LknQoFiCatYD/l9al7FPXKTZxebzWxzavxqP4RXy3Q1zY/cm6wLDq40hrZqG4qf0JGtKAWmqa8F/Fy/Ktx/FX5fnZ67mUQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737370240; c=relaxed/simple;
	bh=bbsrwD13rvh6uiQSSTK4rM3NF7dX1IHxA6wg0ySsOZA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CDl4dZ+1N5AlUp+Tb/uiINEWASVyO1jWnNJxH3MDhrxnpsLMAWnz+dDFdLgVuvD+I3iINe18ZDHBTMS5/BtDnN9SyaXOfIvA7g1mM3NJfBdMZniiQVELJuesmPgjZL+13kr0IAIcrIK5WejAi4zbJ4E0zfcyXyJvwiEBRO0sQao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ShKfbnId; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5d0ac27b412so5828651a12.1;
        Mon, 20 Jan 2025 02:50:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737370237; x=1737975037; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C8CpqXRSF7K1ofcqRkPttcg+7PkbO4N55XdzHxiu9N8=;
        b=ShKfbnIdJK+6pQXuKS8b7xZ1MemFmd5mr8d/C7AC9URqc+TiywsNduS5z5bRYrLzNH
         HQhqUC9EMN1FyAyrwLAYcchLr0+apJyyVLuOaV5H1/Lq6eyTIliPDlzyFQRx+tjOsTpL
         7tmDmOrOBp/eipxQExCFbZvm5YcMu8Rk9AxX3K86IQ9aUFDp2H0o0a1WPIlQvlmS4w+x
         dBaqA2rvuZLrjqX6xjzYh9WSpguC9V50a819IGks4xlnxwnaQOQnv4Fg8TfrJinEQf49
         tS1947zjUjiCR2xj+Fn1mxNMq1UGSI1X7xJB6YNp8sez8upQBfxVOu1hj93SNHQqA6kK
         AP6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737370237; x=1737975037;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C8CpqXRSF7K1ofcqRkPttcg+7PkbO4N55XdzHxiu9N8=;
        b=oYrqtgn0ZYqiP8QeuvvLMkpSJZAnE1itDpC+DaDRYITNop5YH0EU7j0hXSKS0T8T8l
         f+wJB1WBlkZHMZCWJ9TCiZu/unh+6UMKA2XTjWVOmym2LHV1KaIaSiEIzEhzvKLnYGVq
         U7ghSaamNj4bk7dIuvp1/ZKYe612v++0rQvIG4KxmsFj4w0TQfV7U0Zb0SVt3zGJD/Kb
         5uHT0gLF/LmLFWbQbZRanLGc3EMenFcVekvYX7wyLk6hCW1fcYREwQn/HhpKs2EeS17o
         Eujzgih8L8Tv0lsgSZv5dje+q8c+BSN0KxcxjL3f8JzcWcwJC8LTvLY8S/XZlbY7u8vM
         wpPg==
X-Forwarded-Encrypted: i=1; AJvYcCXhH5QstWqHY3NCSLBFcVfhJyj14nAvGWXNOltWz4nVdU2539xPmbi9/FLRCibgQf+VjmL5Yr1AYF8rk/4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc9TmH84bMEH+iY9VZZHhuy6KUzVsgV3RU94l1qmqiIcQqLXqw
	oGhkxKRBerimfVQxanwUcoCGZsLHQzax4cVr+7OyPOEli3lA1RH2
X-Gm-Gg: ASbGncubmx1drY1U00HUWLW9McRm7vimGzroId0GrWFR9I4LoVY14KJbHE0FDZn9Ex0
	3Kq9T/41x0XKAKxODZZamnydb5cjXwEKY/RrrmWHWJH8hsCGv/VVdLKHl/z/kVK3Nbg4ZgCTjAN
	J/ShKbXHTkm0vSHIfnz3i/RhVun3Lm6pD8GmSclWFdVtyMMa/IcDDfO0Z+mksV/tcO31lgbuIy4
	U3ML+Y6aCtHM/tOvXfmOxnOl6fupwToLDK12Gta08ccSRxin5crHUj+sunnClYdi5DfGRWltcM3
	de90FdM9bnqkwIR3v3ChnbnFQjbAi5TWYLBmZ+oF9w==
X-Google-Smtp-Source: AGHT+IEfQmVx9GpJWJfTlLH80cfETPz5J1C9ldYz3kOPo2J5JEcL6IpRnaJ7zYabNOUfjAuH2RcU4w==
X-Received: by 2002:a05:6402:3550:b0:5d3:ce7f:abee with SMTP id 4fb4d7f45d1cf-5db7db08623mr11542181a12.25.1737370236978;
        Mon, 20 Jan 2025 02:50:36 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1126:4:829:739b:3caa:6500? ([2620:10d:c092:500::4:4372])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5db73670cf8sm5607948a12.19.2025.01.20.02.50.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jan 2025 02:50:36 -0800 (PST)
Message-ID: <029cff22-f2e0-4796-9c27-1df056e08f8f@gmail.com>
Date: Mon, 20 Jan 2025 10:50:36 +0000
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
 <ed7ad48f-2270-4966-bdba-ccd4592a0fd4@gmail.com>
 <CAMj1kXFMxfOswAdBEVsCoVO90y_m1TUigWRG-3FJTsv4xOGTpw@mail.gmail.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <CAMj1kXFMxfOswAdBEVsCoVO90y_m1TUigWRG-3FJTsv4xOGTpw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 20/01/2025 10:32, Ard Biesheuvel wrote:
> On Mon, 20 Jan 2025 at 11:27, Usama Arif <usamaarif642@gmail.com> wrote:
>>
>>
> ...
>> Hi Ard,
>>
>> Just wanted to check how should we proceed forward? Should we try and fix the warning
>> and corruption during kexec as done in this series or not initialize memory attributes
>> table at all in kexec boot? I would prefer fixing the issues as in this series.
>>
> 
> I would prefer kexec boot on x86 to disregard the memory attributes
> table entirely.

Would you like Dave to send something like
https://lore.kernel.org/all/CALu+AoS8tb=HgaybDw5OG4A1QbOXHvuidpu0ynmz-nE1nBqzTA@mail.gmail.com/
on the mailing list (wrapped in ifdef CONFIG_X86_64)

or we could do
https://lore.kernel.org/all/fd63613c-fd26-42de-b5ed-cc734f72eb36@gmail.com/
as well.

Or if there is any other way you prefer, I am happy to implement and test.

Thanks,
Usama

