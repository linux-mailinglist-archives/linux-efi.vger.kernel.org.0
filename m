Return-Path: <linux-efi+bounces-5212-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66543C1989B
	for <lists+linux-efi@lfdr.de>; Wed, 29 Oct 2025 10:59:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E63ED3A92F7
	for <lists+linux-efi@lfdr.de>; Wed, 29 Oct 2025 09:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3FE1324B20;
	Wed, 29 Oct 2025 09:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="R3buXpdb"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55781314D27;
	Wed, 29 Oct 2025 09:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761731769; cv=none; b=fGgx0wDfL9aCgjLQsituHjIn/Nvj026iKF/K0PQSw6et6HJhAhb3EdrJZnRhz6hAbOw6PInr4T2mALnbwZhyCzTy6/BThoEpfrb8dDH5gem/V9O+/YpIiz2WU5GnmT0RkYfQcxZgz4ASjLLn+LycQCAHcArj2NTkMsOtAi2UPHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761731769; c=relaxed/simple;
	bh=0GUEhK1hx54yNxC0K2kzTmvj2/WFXSmTL4RlQNnNFAE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cZktKUKvqpmi0wrQsDDlx9qfGJG64ep7QU4YusYZK7Hz9cwN+AXD5rQIFcFqIM5tSTH+01z8Lys8K4ZKdyhE7mDlBg8+a/mazUg1JXywBRNeU/wgQ//zzqESwleIgBpneAlrupYnewnVn4Id2VpqF3DOeMACUvwFPEf/7u+cElM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=R3buXpdb; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1761731678;
	bh=xlpZYqLQWghCTXXagIIntJughDFQUhVwALKDs3UuqsA=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=R3buXpdbN+SnO929BpkVRxgJGR80zynsfEO8Ov3hFdR20DpxHK50WY1C84j+WCwiv
	 pjtHG1JKIXkuzJSgYVyXjVaKuc/hVIHiiCqJcuZGfSkIfp7SY2ZfDt+RIWLOVCd9Gu
	 iNj9/B0pS1ipEivllhYyMKLlmF/19VSKEs8YpqcY=
X-QQ-mid: esmtpgz11t1761731672t980a5a36
X-QQ-Originating-IP: DeTMd+qj/0zMyYJILpslmoa/GD3vcu4qvH35zRnrhA8=
Received: from [10.10.74.117] ( [123.114.60.34])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 29 Oct 2025 17:54:30 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 14243424483596737068
Message-ID: <9F7F632B7963434F+abad2548-a90d-4448-ae79-dd4bf637ee6e@uniontech.com>
Date: Wed, 29 Oct 2025 17:54:30 +0800
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] ARM/efi: Remove duplicate permission settings
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux@armlinux.org.uk, linux-efi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20251023082129.75612-1-maqianga@uniontech.com>
 <CAMj1kXHs3vC4TEWg1ogG=N8Dd5L0rkQ=qAFLWKiAA5yi_He3GA@mail.gmail.com>
 <10D9A93B0633E6BE+75720e07-b39d-452c-952e-41f8ab6aad94@uniontech.com>
 <CAMj1kXHQ6WQWfbkMP4JUk=nKwSt7CovY25RC4JA0ZM7vRWu6dA@mail.gmail.com>
Content-Language: en-US
From: Qiang Ma <maqianga@uniontech.com>
In-Reply-To: <CAMj1kXHQ6WQWfbkMP4JUk=nKwSt7CovY25RC4JA0ZM7vRWu6dA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-1
X-QQ-XMAILINFO: M+Qa/yP3m2vGayM6cQsPSxH0gCOmwR00EfZoXMxhsAO9kOiwiDPjC3+o
	fOLsDpx/7HnBub6Sr0udnawRm/2TiY5aIeKR74WAli2UKJMLeojxZp7LIZn5g6xNfL5srgj
	OdkQtdSenLyhlLsLrWbEo4wW8RLHfcO/B2REqQG/ACcJ8H5wRI3BEfbQvuQpFPk+ClFn4om
	cMNkULvHRa94IDZ7flkuAxYjQC7BzOBY+oWSE0J5avU2hRZnHPszFG9ZLqPB9GQHmpyYy4y
	W/0x5jniFw9X7XJ202CB67iB6Cagbaxve+y0bjb6XwmD4CvEogvSc6Jdr9Js3aHtygSJJEB
	HrQ2Z6DDzZE4rNajepE1mJ7qUCeIqBeAIgNinnuLsxel5q80UAcn2IQMjNS+4bdAfdsHdsu
	wTBmeMA9HFHiBmENaK/OV1TishQu4fgPahuT6TalefYnLykatubopxojFn9p+5jsu1ZRzOa
	E1leJolJ42OlSkyOD3JBEHYugGYaEVtcSL3m2e8eL8VTc20S/gVPISzz7i1ZBq8O9M6eJj2
	Oibb4O6WZweZ9vIk2K12BwJzJSntsvfRr7lurb9phLZZlKMqjkr5KFP/WIN2gQ5OrpFsM2h
	LtSadGbcv7g79AKDJJHtNLnMzPxJo20pRT1oZWps2DzNOgg9w7F+UT/jkmhLeq4tZdFWMzB
	060/5k+DiMAZQsAWm3vJqAU7Yk7CJ50KPU9asxjy46e0xZ5p9a+r5KBg61qwHqVIQEb/Y45
	4roo7H9ZQZDpgD+Qxtf0MGJFivx2wYaIuXC6W/ppw/PHw0t0+0yGD5VLQ6KKtffHnWSFea3
	fdFg4YQ1eN0psM36l2hEKg0lKzYTrNjngAKnV6ZLe35EdPVAzlyugnDcpsW/FcyohCA3dT1
	t6Q2fvqXiptDBLqC8rS4An4ef1beaTEyVDN4c+zxW0sbt7cEIFC4M+LcHTZ1grWwM5XJ2VP
	BJSjYNcKifHBeneo2CcyOHdrOw0pMrbgrbcRpgISU5rP+xTFbRFwC8ld8ufMz8G7Rsqpdg2
	A6a6dx1dCLJjl19+uMS9xroidHBDXn1Y9ijXO7w9XIlSJy6tFd7SjFYQsWhbIFUhZhszGcq
	lbSV8p3G5+jJU3LkAGDxRAybL1o1mwfiLyMAn3t8PtPrSpXn6u/wh0=
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-QQ-RECHKSPAM: 0


在 2025/10/28 21:42, Ard Biesheuvel 写道:
> On Mon, 27 Oct 2025 at 04:46, Qiang Ma <maqianga@uniontech.com> wrote:
>>
>> 在 2025/10/23 16:30, Ard Biesheuvel 写道:
>>> On Thu, 23 Oct 2025 at 10:22, Qiang Ma <maqianga@uniontech.com> wrote:
>>>> In the efi_virtmap_init(), permission settings have been applied:
>>>>
>>>> static bool __init efi_virtmap_init(void)
>>>> {
>>>>           ...
>>>>           for_each_efi_memory_desc(md)
>>>>                   ...
>>>>                   efi_create_mapping(&efi_mm, md);
>>>>           ...
>>>>           efi_memattr_apply_permissions(&efi_mm, efi_set_mapping_permissions);
>>>>           ...
>>>> }
>>>>
>>>> Therefore, there is no need to apply it again in the efi_create_mapping().
>>>>
>>>> Fixes: 9fc68b717c24 ("ARM/efi: Apply strict permissions for UEFI Runtime Services regions")
>>>>
>>>> Signed-off-by: Qiang Ma <maqianga@uniontech.com>
>>> No, efi_memattr_apply_permissions() uses the /optional/ memory
>>> attributes table, whereas efi_create_mapping() uses the permission
>>> attributes in the EFI memory map. The memory attributes table is
>>> optional, in which case any RO/XP attributes from the memory map
>>> should be used.
>>>
>> I see.
>>
>> Then, can it be modified like this?
> No
>
>> --- a/arch/arm/kernel/efi.c
>> +++ b/arch/arm/kernel/efi.c
>> @@ -65,16 +65,13 @@ int __init efi_create_mapping(struct mm_struct *mm,
>> efi_memory_desc_t *md)
>>                   desc.type = MT_MEMORY_RWX_NONCACHED;
>>           else if (md->attribute & EFI_MEMORY_WC)
>>                   desc.type = MT_DEVICE_WC;
>> +       else if (md->attribute & (EFI_MEMORY_RO | EFI_MEMORY_XP))
> This will be true for RO, XP or RO+XP.
>
>> +               desc.type = MT_MEMORY_RO;
> This will apply RO permissions even to XP regions, which need to be writable.
>
Thanks for your review.
I see.

I can introduce a new type MT_MEMORY_RO_XP, to describe RO+XP,
and then we can use the RO+XP attribute to implement memory mapping.

--- a/arch/arm/kernel/efi.c
+++ b/arch/arm/kernel/efi.c
@@ -68,13 +68,16 @@ int __init efi_create_mapping(struct mm_struct *mm, 
efi_memory_desc_t *md)
         else
                 desc.type = MT_DEVICE;

+       if ((md->attribute & EFI_MEMORY_RO) &&
+           (md->attribute & EFI_MEMORY_XP))
+               desc.type = MT_MEMORY_RO_XP;
+       else if ((md->attribute & EFI_MEMORY_RO)
+               desc.type = MT_MEMORY_RO;
+       else if (md->attribute & EFI_MEMORY_XP)
+               desc.type = MT_MEMORY_RW;
+
         create_mapping_late(mm, &desc, true);

