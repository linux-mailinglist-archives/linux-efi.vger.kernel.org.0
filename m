Return-Path: <linux-efi+bounces-2564-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1E5FA08EE6
	for <lists+linux-efi@lfdr.de>; Fri, 10 Jan 2025 12:12:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBEC5166518
	for <lists+linux-efi@lfdr.de>; Fri, 10 Jan 2025 11:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06A26209F5E;
	Fri, 10 Jan 2025 11:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eBPctC/L"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C47D204F93;
	Fri, 10 Jan 2025 11:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736507565; cv=none; b=hPTWb1XqSTu1J1KL0LZj8YxaGJLEoeZTVVYCrLlrHrzeCHGeVlksUBBAl1XJEiCGQpa46suYgsmYMgtZ4ondOq9rDrcP4pOcssx1CkmaE2Pf2zC5t382nNG5SJk67qm+GQz26Qc15DW8v1Cykr1f5obcrQ2y23VvS2yffEXZg3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736507565; c=relaxed/simple;
	bh=M36w9PvoteLCBYRraBScyp3o//xy80YkWIXJGAp8F7c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qqubOoQT0mko2I2lLHiOqUIBDDYxsmXKzUp/P6rCHPTMWN5SotUgSt9Z+16HYFAmqrnh//czLRsrLLv6nTyc7nYj8cTYI4247AnB7rG/PFLFblUpMsJb6qfs2yFOLc2BSgtQOiuUr2z4KyhBGY9pAgeiE5yUiX8aTCtS6qododc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eBPctC/L; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-aaee0b309adso316384366b.3;
        Fri, 10 Jan 2025 03:12:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736507562; x=1737112362; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hRwtHfP1JQU5+YPorhBGMH6eYlGfleBI3Cl5YY7QQEI=;
        b=eBPctC/L6T9QWrHac0g8TljoYooC+r6U4AOFtdUa9jQyeSUAPzSnrbn71kXTTEnRCW
         oQjN2erkboshk7e1M3Kh3Zh5BubtooS21HrV6W3r/xV0LVGdCBHxp3+ewkcnkMvlh7T6
         e+ow2+FnSGWixS5MOkpDgWdHQKMtX7p5XPPfXtkKIdhpHxA98ijO8jZf+YvNydFI2dyD
         403uORX0h//lF2aD5wSh0AfMgQ9SxIs9oBDSqbg6zy74XneZlJtSWk48e8UZIqUhG/F9
         VYfjfOn24WQWH+uvtxxwLVFcIWfXDAfjYjgwJP6kz7TJbkPCm8+aWfkrK5Qz1KmB07DL
         Iz9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736507562; x=1737112362;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hRwtHfP1JQU5+YPorhBGMH6eYlGfleBI3Cl5YY7QQEI=;
        b=ujwnUlKnqCg7Uo4t1Hj5K912O6K+5o5jqzuaEidKNQXHcTuNRyVY6eN35XcXG3PRQj
         fvY4MAhzxSldNUbRrIBN14VAh5n0EMaT2w+vY73dUxBEAxRfxhNf522PBdZ3q5zKRKGz
         9VSHqK6T53MtEyysmSzcMuucMPyprv2waK9DeTpkwAYUdmHBMl9lt40jY3Kgxn92q/3z
         c2Q3kaDgUrJLmBhKrrN5GJ8uQlBPKc3JnA6D4+rZagcefN59iWguBQ3/Ho/5LCNN9Gs0
         wgrZbiF7ZKm2II7Qm7AQ1qqr6YZX7X1tpdaBNup9APL+a9v9XjyMCVWOJ9F2+AIPVQo0
         r1cA==
X-Forwarded-Encrypted: i=1; AJvYcCXGZ5inXWgJHdV7mW65H+ogf+NiHYY/gSjj74mG18sQ6l2mXeYxlRPQ+h0VYO7/4bKsAxjp1gvqfR59HOI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXwuiHot5XGG8H35TuWOw8Rchu3bObSJ5p/AfukXKB1m91AMBF
	VJjtXRxmNq9qEypguEuCKzQW1WE5YTXTDGs2jratAnbRjinovM9Yq7mXlMQHBGdCGg==
X-Gm-Gg: ASbGncsRsevLIM9HGe0vdYnfifrBF6cN8xTslc8kTzvvAKTrWMWy6NvzRmbwA+NEMY2
	0HQEhRXHnEciyrfEV0N0SHPQ0vAa+Kg3FRtm4+W4TMqJADgs+EwHP9EjvwQ4csGnqoxxGC2Mdb5
	ukCgQmF/AykA3mWCsNYABKQL7QzgzfjrRcVtmoD+fk50XwZJVmeyooR6Mp4EuQMn+1P1YjGU9cK
	1TehqNdDz08E0MI3LdTj5suUylXP4I9uCm654LeOnsqTvEa3I+tVSxOwpQU83nAAfOfOpexejPo
	xb3Q8MsNGAJaWiKt01Ts+PuucyrZ
X-Google-Smtp-Source: AGHT+IEr3DYjbmxJfOi4g+OJHmU/3Mg1uURC8lJFwHS/uzBUjhDVzsWaDhSM2tE7YGlD4il6vC880g==
X-Received: by 2002:a17:906:dc8d:b0:aaf:4008:5e2c with SMTP id a640c23a62f3a-ab2ab66fea4mr827120266b.2.1736507562473;
        Fri, 10 Jan 2025 03:12:42 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1126:4:829:739b:3caa:6500? ([2620:10d:c092:500::5:e213])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab2c905f0b3sm157026166b.21.2025.01.10.03.12.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jan 2025 03:12:42 -0800 (PST)
Message-ID: <4ed67e5b-c2ea-4dc3-b4c5-f8f112b0cd40@gmail.com>
Date: Fri, 10 Jan 2025 11:12:41 +0000
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 2/2] efi/memattr: add efi_mem_attr_table as a reserved
 region in 820_table_firmware
To: Dave Young <dyoung@redhat.com>
Cc: linux-efi@vger.kernel.org, devel@edk2.groups.io,
 kexec@lists.infradead.org, ardb@kernel.org, hannes@cmpxchg.org,
 x86@kernel.org, linux-kernel@vger.kernel.org, leitao@debian.org,
 gourry@gourry.net, kernel-team@meta.com
References: <20250108215957.3437660-1-usamaarif642@gmail.com>
 <20250108215957.3437660-3-usamaarif642@gmail.com>
 <CALu+AoTgjdq+kUbv-5CGQr=UTLd2+zDLbHt=kXaoMYYptBYnAA@mail.gmail.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <CALu+AoTgjdq+kUbv-5CGQr=UTLd2+zDLbHt=kXaoMYYptBYnAA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/01/2025 02:50, Dave Young wrote:
> Hi Usama,
> 
> On Thu, 9 Jan 2025 at 06:00, Usama Arif <usamaarif642@gmail.com> wrote:
>>
>> When this area is not reserved, it comes up as usable in
>> /sys/firmware/memmap. This means that kexec, which uses that memmap
>> to find usable memory regions, can select the region where
>> efi_mem_attr_table is and overwrite it and relocate_kernel.
> 
> Is the attr table BOOT SERVICE DATA?  If so, does efi_mem_reserve()
> work for you?
> Just refer to esrt.c.
> 

Hi Dave,

Its a bit difficult to reproduce the problem and therefore test the fix, but
we are seeing it a lot in production. Ard proposed the same thing in 
https://lore.kernel.org/all/6b4780a5-ada0-405e-9f0a-4d2186177f29@gmail.com/
but as I mentioned there, I dont think that efi_mem_reserve would help,
as efi_mem_reserve changes e820_table, while kexec looks at
/sys/firmware/memmap which uses e820_table_firmware.

Thanks,
Usama

> Thanks
> Dave
> 


