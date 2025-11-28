Return-Path: <linux-efi+bounces-5717-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CA42C9176D
	for <lists+linux-efi@lfdr.de>; Fri, 28 Nov 2025 10:35:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CB983A323F
	for <lists+linux-efi@lfdr.de>; Fri, 28 Nov 2025 09:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CC812417DE;
	Fri, 28 Nov 2025 09:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k1C76YP9"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5137F20322;
	Fri, 28 Nov 2025 09:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764322450; cv=none; b=vDS5CiE7QIlkouvIlnaN56fwapcJUAOwBuGrbZ5IWkBmaovYMz1Tq8mAAAMdXNa0DQwogN3cU8KVgSgIfoU/YFGlkyc7I1oTxiJR4YOW+C2aABQ9b9/telTfmfyL9wV3i5W6wsaUz79nmNFgAmBFR54Vo3uumxx1H7Z3Bf9XpRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764322450; c=relaxed/simple;
	bh=2RrLO3ub+tMhHBuf1v3HTs4UiaOhLMuJeLuTeN4cwys=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eE1JpM9qzbel28JgcVydCs2KtQKt2dvz/+8heX71qNOHls1FSHInMfP10lors5cW7KtAM9hF6Xq8+xVIgIFI5rQ7ZkTAzn7wUv4ZLsm6kqrSE8faKdKe0bz95RI3imXeH17skNvBpXx7R0HlzB98y+vwCnAovSuqy/gg1587zdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k1C76YP9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5372EC4CEF1;
	Fri, 28 Nov 2025 09:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764322449;
	bh=2RrLO3ub+tMhHBuf1v3HTs4UiaOhLMuJeLuTeN4cwys=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=k1C76YP96Tnw9zH9fBMCNHqDt7gFjXZ+y23temsYDx5IlbUpf7vBgDt76debNr1yK
	 5q9oe7b4kNjao6SQLx8bGZIo5F8yE91F6KJ2gLbqGQiwj8kqI6AxmXV/4Vas1tZeMl
	 vvKxogRYPjvtdv0cdqSH8HwY9ZZhXFV1lix+MCHL/gwxxyA/pooPpJGUq97VbrkI/5
	 kGTYoLED6iwWOuudkioRFpPmzeyxSsO9OyFsa8EUfuhxPwxEmqrHddFBKmru7D5viN
	 fisVB5r/w3Nc1ujtvc/1ybre9to31rIDS3ts4fmSOB2Mvylq/aUV65Ooa8Mvc+NZgg
	 d++WnJxycoxJw==
Message-ID: <27c06cf2-7500-4875-bd22-f55571fb85f9@kernel.org>
Date: Fri, 28 Nov 2025 10:34:04 +0100
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/4] mm: Add support for unaccepted memory hotplug
To: Kiryl Shutsemau <kas@kernel.org>, "Pratik R. Sampat" <prsampat@amd.com>
Cc: linux-mm@kvack.org, linux-coco@lists.linux.dev,
 linux-efi@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, ardb@kernel.org, akpm@linux-foundation.org,
 osalvador@suse.de, thomas.lendacky@amd.com, michael.roth@amd.com
References: <20251125175753.1428857-1-prsampat@amd.com>
 <20251125175753.1428857-3-prsampat@amd.com>
 <66ylzwknm4ftd6utn3nqr63jmhl2ccvcdvyi5fechfnvmfxivu@37pckhjixayh>
 <14df1d99-7df0-4982-8029-e66dfb140399@amd.com>
 <dy65eupwalp5wsljetlto27l6tjjvoygeotjd3n7mk7zjc4dma@jf4hzsy6rtcd>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <dy65eupwalp5wsljetlto27l6tjjvoygeotjd3n7mk7zjc4dma@jf4hzsy6rtcd>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/27/25 18:40, Kiryl Shutsemau wrote:
> On Wed, Nov 26, 2025 at 04:27:29PM -0600, Pratik R. Sampat wrote:
>>
>>
>> On 11/26/25 5:12 AM, Kiryl Shutsemau wrote:
>>> On Tue, Nov 25, 2025 at 11:57:51AM -0600, Pratik R. Sampat wrote:
>>>> The unaccepted memory structure currently only supports accepting memory
>>>> present at boot time. The unaccepted table uses a fixed-size bitmap
>>>> reserved in memblock based on the initial memory layout, preventing
>>>> dynamic addition of memory ranges after boot. This causes guest
>>>> termination when memory is hot-added in a secure virtual machine due to
>>>> accessing pages that have not transitioned to private before use.
>>>
>>> How does the hot-pluggable memory look in EFI memory map? I thought
>>> hot-pluggable ranges suppose to be declared thare. The cleanest solution
>>> would be to have hot-pluggable and unaccepted indicated in EFI memory,
>>> so we can size bitmap accordingly upfront.
>>>
>>
>> I'm not quite sure if I fully understand. Do you mean to refer to the
>> EFI_MEMORY_HOT_PLUGGABLE attribute that is used for cold plugged boot
>> memory? If so, wouldn't it still be desirable to increase the size of
>> the bitmap to what was marked as hotpluggable initially?
> 
> I just don't understand how hotpluggable memory presented in EFI memory
> map in presence of unaccepted memory. If not-yet-plugged memory marked
> as unaccepted we can preallocate bitmap upfront and make unaccepted
> memory transparent wrt hotplug.
> 
> BTW, isn't virtio-mem a more attractive target to support than HW-style
> hotplug?

I would have thought so as well, such that we can just let virtio-mem 
take care of any acceptance before actually using hotplugged memory 
(exposing it to the buddy).

Likely there is desire to support other hypervisors?

-- 
Cheers

David

