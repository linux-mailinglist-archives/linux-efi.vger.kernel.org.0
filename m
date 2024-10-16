Return-Path: <linux-efi+bounces-1976-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AED349A03E8
	for <lists+linux-efi@lfdr.de>; Wed, 16 Oct 2024 10:15:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3FDB0B28EF3
	for <lists+linux-efi@lfdr.de>; Wed, 16 Oct 2024 08:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AC4E1D1F4F;
	Wed, 16 Oct 2024 08:14:50 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4C8B1D1F63;
	Wed, 16 Oct 2024 08:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729066490; cv=none; b=BzMJZEri99Sv4Bk5fPEPiIR0cqAje6VSgY4vMo1Sggtmu5TjXjcrZoTuhoa2K6lmb/sUn20uAhVHaDP8n/GS+jQFXJg9ofjPrtWwbdIbG1aROwsIUn7tS/oyCofDkGDKByBRJ4STHQUKMUocXifIB/jpze1M7n6RUwF8K3JdRWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729066490; c=relaxed/simple;
	bh=wxQg2GJ5ktlDu9srXxIIKK0Wg/EJpooJh/rWWUWYADg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CqHFC+jaso7g+/wvVBCycH4OQ979BOAr+Dm/d/WKixA+iobpII6rBb76n86Rp2DVW4CQl9DHFA28EZn8lk4UabIM3DnqgUIgP9g0OzKttnbiDOTPG5Zy69qREXlT1UYbMac5Ppwa8oxvE6jTE8namYIpBmGJBCWKxQg37sGcFzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5D218FEC;
	Wed, 16 Oct 2024 01:15:16 -0700 (PDT)
Received: from [10.57.86.207] (unknown [10.57.86.207])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 399FC3F71E;
	Wed, 16 Oct 2024 01:14:43 -0700 (PDT)
Message-ID: <daecf1d1-04c7-4513-86db-397c2ef6f768@arm.com>
Date: Wed, 16 Oct 2024 09:14:41 +0100
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 57/57] arm64: Enable boot-time page size selection
Content-Language: en-GB
To: Zi Yan <ziy@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Ard Biesheuvel <ardb@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 David Hildenbrand <david@redhat.com>, Greg Marsden
 <greg.marsden@oracle.com>, Ivan Ivanov <ivan.ivanov@suse.com>,
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
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <CD2DC486-F4B1-4043-82BC-0CB2AA513A99@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15/10/2024 18:42, Zi Yan wrote:
> On 14 Oct 2024, at 6:59, Ryan Roberts wrote:
> 
>> Introduce a new Kconfig, ARM64_BOOT_TIME_PAGE_SIZE, which can be
>> selected instead of a page size. When selected, the resulting kernel's
>> page size can be configured at boot via the command line.
>>
>> For now, boot-time page size kernels are limited to 48-bit VA, since
>> more work is required to support LPA2. Additionally MMAP_RND_BITS and
>> SECTION_SIZE_BITS are configured for the worst case (64K pages). Future
>> work could be implemented to be able to configure these at boot time for
>> optimial page size-specific values.
>>
>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>> ---
> 
> <snip>
> 
>>
>> @@ -1588,9 +1601,10 @@ config XEN
>>  # 4K  |       27          |      12      |       15             |         10              |
>>  # 16K |       27          |      14      |       13             |         11              |
>>  # 64K |       29          |      16      |       13             |         13              |
>> +# BOOT|       29          |    16 (max)  |       13             |         13              |
>>  config ARCH_FORCE_MAX_ORDER
>>  	int
>> -	default "13" if ARM64_64K_PAGES
>> +	default "13" if ARM64_64K_PAGES || ARM64_BOOT_TIME_PAGE_SIZE
>>  	default "11" if ARM64_16K_PAGES
>>  	default "10"
>>  	help
> 
> So boot-time page size kernel always has the highest MAX_PAGE_ORDER, which
> means the section size increases for 4KB and 16KB page sizes. Any downside
> for this?

I guess there is some cost to the buddy when MAX_PAGE_ORDER is larger than it
needs to be - I expect you can explain those details much better than I can. I'm
just setting it to the worst case for now as it was the easiest solution for the
initial series.

> 
> Is there any plan (not in this patchset) to support boot-time MAX_PAGE_ORDER
> to keep section size the same?

Yes absolutely. I should have documented MAX_PAGE_ORDER in the commit log along
with the comments for MMAP_RND_BITS and SECTION_SIZE_BITS - that was an
oversight and I'll fix it in the next version. I plan to look at making all 3
values boot-time configurable in future (although I have no idea at this point
how involved that will be).

Thanks,
Ryan

> 
> Best Regards,
> Yan, Zi


