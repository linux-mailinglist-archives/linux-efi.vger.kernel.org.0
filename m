Return-Path: <linux-efi+bounces-1979-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8437D9A0CA2
	for <lists+linux-efi@lfdr.de>; Wed, 16 Oct 2024 16:31:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CAA15B26426
	for <lists+linux-efi@lfdr.de>; Wed, 16 Oct 2024 14:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7053208205;
	Wed, 16 Oct 2024 14:31:35 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99BB81FCC78;
	Wed, 16 Oct 2024 14:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729089095; cv=none; b=sHru0cKYHTrU7ml2qAIJLPEszWksZWCDOIGU3sZxXlq7HTu7U3MRczI35ACtjRminOpb+7WK4W0Fh5m4aJp8CHn2eM82qLLCTmL8IGucLOuQV6efgjHyPTmGC2R6yOKNor0RjfR0iDkjgqlAsObPRVZa4YYmwydeqA7QC7fm9Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729089095; c=relaxed/simple;
	bh=WOrmtnlr1s+7WsjGlFmE8Nm0DVI511aAillhmXEC2iY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d1iGrC9CtUlHIvfx2qDbPcM4Ucexw4SWA3zLFfyAkGyyvtUDsQA0sHbe5qTH4sfZFAB5HgAe8YTtmGyYAAGZNJMPsJmJDKaIn3SdtKGCVBefUhTK0++KfQ2hF/Aj/mL6YezZm/kaYH2m4ifN0mKpP0ewWsFVfq5n4jDkXt719+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 764D2FEC;
	Wed, 16 Oct 2024 07:32:02 -0700 (PDT)
Received: from [10.1.28.177] (XHFQ2J9959.cambridge.arm.com [10.1.28.177])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AAB9E3F71E;
	Wed, 16 Oct 2024 07:31:29 -0700 (PDT)
Message-ID: <401175cf-e205-4e5c-939f-60b7ab948355@arm.com>
Date: Wed, 16 Oct 2024 15:31:28 +0100
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 57/57] arm64: Enable boot-time page size selection
Content-Language: en-GB
To: Zi Yan <ziy@nvidia.com>, David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Ard Biesheuvel <ardb@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Greg Marsden <greg.marsden@oracle.com>, Ivan Ivanov <ivan.ivanov@suse.com>,
 Kalesh Singh <kaleshsingh@google.com>, Marc Zyngier <maz@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Matthias Brugger <mbrugger@suse.com>,
 Miroslav Benes <mbenes@suse.cz>, Oliver Upton <oliver.upton@linux.dev>,
 Will Deacon <will@kernel.org>, kvmarm@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-efi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20241014105514.3206191-1-ryan.roberts@arm.com>
 <20241014105912.3207374-1-ryan.roberts@arm.com>
 <20241014105912.3207374-57-ryan.roberts@arm.com>
 <CD2DC486-F4B1-4043-82BC-0CB2AA513A99@nvidia.com>
 <daecf1d1-04c7-4513-86db-397c2ef6f768@arm.com>
 <6C0A53C0-C332-46B3-A84A-3232E9D71003@nvidia.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <6C0A53C0-C332-46B3-A84A-3232E9D71003@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16/10/2024 15:21, Zi Yan wrote:
> On 16 Oct 2024, at 4:14, Ryan Roberts wrote:
> 
>> On 15/10/2024 18:42, Zi Yan wrote:
>>> On 14 Oct 2024, at 6:59, Ryan Roberts wrote:
>>>
>>>> Introduce a new Kconfig, ARM64_BOOT_TIME_PAGE_SIZE, which can be
>>>> selected instead of a page size. When selected, the resulting kernel's
>>>> page size can be configured at boot via the command line.
>>>>
>>>> For now, boot-time page size kernels are limited to 48-bit VA, since
>>>> more work is required to support LPA2. Additionally MMAP_RND_BITS and
>>>> SECTION_SIZE_BITS are configured for the worst case (64K pages). Future
>>>> work could be implemented to be able to configure these at boot time for
>>>> optimial page size-specific values.
>>>>
>>>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>>>> ---
>>>
>>> <snip>
>>>
>>>>
>>>> @@ -1588,9 +1601,10 @@ config XEN
>>>>  # 4K  |       27          |      12      |       15             |         10              |
>>>>  # 16K |       27          |      14      |       13             |         11              |
>>>>  # 64K |       29          |      16      |       13             |         13              |
>>>> +# BOOT|       29          |    16 (max)  |       13             |         13              |
>>>>  config ARCH_FORCE_MAX_ORDER
>>>>  	int
>>>> -	default "13" if ARM64_64K_PAGES
>>>> +	default "13" if ARM64_64K_PAGES || ARM64_BOOT_TIME_PAGE_SIZE
>>>>  	default "11" if ARM64_16K_PAGES
>>>>  	default "10"
>>>>  	help
>>>
>>> So boot-time page size kernel always has the highest MAX_PAGE_ORDER, which
>>> means the section size increases for 4KB and 16KB page sizes. Any downside
>>> for this?
>>
>> I guess there is some cost to the buddy when MAX_PAGE_ORDER is larger than it
>> needs to be - I expect you can explain those details much better than I can. I'm
>> just setting it to the worst case for now as it was the easiest solution for the
>> initial series.
> 
> From my past experience (around 5.19), the perf impact (using vm-scalability)
> seems very small due to MAX_PAGE_ORDER increases [1] (I made MAX_PAGE_ORDER
> a boot time variable and increased it to 20 for my 1GB THP experiments).
> 
> Larger MAX_PAGE_ORDER means larger section size and larger mem_block size,
> so the granularity of memory hotplug also increases. In this case:
> 1. ARM64 4KB: mem_block size increases from 4MB to 32MB,
> 2. ARM64 16KB: mem_block size increases from 32MB to 128MB,
> 3. ARM64 64KB: mem_block size keeps the same, 512MB.
> 
> DavidH was concerned about large mem_block size before. He might have some
> opinion on this.
> 
> 
>>
>>>
>>> Is there any plan (not in this patchset) to support boot-time MAX_PAGE_ORDER
>>> to keep section size the same?
>>
>> Yes absolutely. I should have documented MAX_PAGE_ORDER in the commit log along
>> with the comments for MMAP_RND_BITS and SECTION_SIZE_BITS - that was an
>> oversight and I'll fix it in the next version. I plan to look at making all 3
>> values boot-time configurable in future (although I have no idea at this point
>> how involved that will be).
> 
> In [1], I tried to make MAX_PAGE_ORDER a boot time variable,
> but for a different purpose, allocating 1GB THP. I needed some additional
> changes in my patchset, since I assumed MAX_PAGE_ORDER can go beyond
> section size, which makes things a little bit complicated. For your case,
> I assume you are not planning to make MAX_PAGE_ORDER bigger than section
> size, then I should be able to revive my patchset with fewer changes.

Yes correct; no need to make it bigger than section size. Thanks for the patch,
I'll certainly use it as a base when I get there or if you're interested in
doing it then even better ;-)

But I don't think this is urgent. For now, boot-time page size is a new Kconfig
for arm64. It still supports the compile-time page size options. So having a
larger MAX_PAGE_ORDER than strictly necessary doesn't represent a regression,
just a limitation of boot-time page size config - something we can optimize later.

> 
> In terms of SECTION_SIZE_BITS, why do you want to make it a boot time variable?
> Since it decides the minimum memory hotplug size, I assume we should keep
> it unchanged or as small as possible to make virtual machine memory usage
> efficient.

When I say "boot-time variable" I just mean something that the arch can
configure at boot based on the selected page size. I'm not proposing to allow
the user to set it via the command line. That means we need to rid the code of
any assumptions that it is compile time constant (e.g. c preprocessor usage of
the value, etc). The same goes for MAX_PAGE_ORDER and the MMAP_RND_BITS stuff.

> 
> 
> [1] https://lore.kernel.org/linux-mm/20220811231643.1012912-1-zi.yan@sent.com/
> 
> 
> Best Regards,
> Yan, Zi


