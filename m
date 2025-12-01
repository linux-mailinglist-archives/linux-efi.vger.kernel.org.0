Return-Path: <linux-efi+bounces-5739-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8986FC98B47
	for <lists+linux-efi@lfdr.de>; Mon, 01 Dec 2025 19:25:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4618B3A3B1D
	for <lists+linux-efi@lfdr.de>; Mon,  1 Dec 2025 18:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 445F5337BA1;
	Mon,  1 Dec 2025 18:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RabA16VC"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D251B87C0;
	Mon,  1 Dec 2025 18:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764613523; cv=none; b=rDCVlwcvn6RnoAIMaFn9QgP0aFfzI34NabQ4i1TaxkAgCkddxrTKxfNwfF17rSknJ8Zp7ReM5DQbVXzEg5H0f+fVRh/D37K5wOGV/MWT7bOC26shYVNugvZetglxZCn5niPM2ERMu6VWnNHZs0/Mztk/bhfHlB+q2wZLjE2CiNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764613523; c=relaxed/simple;
	bh=khqEBoJRowkwUJTwMe9ReTa1LRGCK/TU2C8qzxrybG4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uuEJC69u21iBLaQpvJIr8+VGX6cZhlhzH7NLz1WvN69WzWVDaJxJk9e3EL25pWpcAa3+smao+lxl+6VZw3K38wJqs+Sn/U3LgrBHt6wK1E0ABvM82hw8yvX3+OUZJV9tJYirR7pk6+OEbk2P2XWrUoNwk/lhYv6uPmMW6oolo/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RabA16VC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90772C4CEF1;
	Mon,  1 Dec 2025 18:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764613521;
	bh=khqEBoJRowkwUJTwMe9ReTa1LRGCK/TU2C8qzxrybG4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RabA16VCKP6L+2WEQBSIDW73cSIljxTxuwmPsge6Zhu7EnptXBylzvB9GrDZN4Jtf
	 +b47dj7o98fk1f6so++CJ3YgZOBlqpKetJ0MKf5CdhYvzcVCJyMtjK8p9lInKSvomp
	 0vg8eRa3cR+oQNsL4zFrvCvoHhS4U1ECNf67YkdFoF8yaOPJpX1DGhl9RwsPOwumJs
	 yyORlI8U0uNXsY03vRWr+XIyd7oSVp+xtd2L6K8YFRyeusIevJZWjQR4Qp8FG84x80
	 jYw/9xLnU23lx/8f25ic/QUmY7UwwA7FC9fW8rddwKL8Jkk8D60qBaTC8UoPhYCoZw
	 A8b9UPATUZEPg==
Message-ID: <2b82fb9f-338e-47e9-bd14-3bdb392dfcbf@kernel.org>
Date: Mon, 1 Dec 2025 19:25:15 +0100
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/4] mm: Add support for unaccepted memory hotplug
To: "Pratik R. Sampat" <prsampat@amd.com>, Kiryl Shutsemau <kas@kernel.org>
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
 <27c06cf2-7500-4875-bd22-f55571fb85f9@kernel.org>
 <c8926ced-3ef3-4c11-9d04-00db388887c5@amd.com>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <c8926ced-3ef3-4c11-9d04-00db388887c5@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/1/25 18:15, Pratik R. Sampat wrote:
> Hi David,
> 
> On 11/28/25 3:34 AM, David Hildenbrand (Red Hat) wrote:
>> On 11/27/25 18:40, Kiryl Shutsemau wrote:
>>> On Wed, Nov 26, 2025 at 04:27:29PM -0600, Pratik R. Sampat wrote:
>>>>
>>>>
>>>> On 11/26/25 5:12 AM, Kiryl Shutsemau wrote:
>>>>> On Tue, Nov 25, 2025 at 11:57:51AM -0600, Pratik R. Sampat wrote:
>>>>>> The unaccepted memory structure currently only supports accepting memory
>>>>>> present at boot time. The unaccepted table uses a fixed-size bitmap
>>>>>> reserved in memblock based on the initial memory layout, preventing
>>>>>> dynamic addition of memory ranges after boot. This causes guest
>>>>>> termination when memory is hot-added in a secure virtual machine due to
>>>>>> accessing pages that have not transitioned to private before use.
>>>>>
>>>>> How does the hot-pluggable memory look in EFI memory map? I thought
>>>>> hot-pluggable ranges suppose to be declared thare. The cleanest solution
>>>>> would be to have hot-pluggable and unaccepted indicated in EFI memory,
>>>>> so we can size bitmap accordingly upfront.
>>>>>
>>>>
>>>> I'm not quite sure if I fully understand. Do you mean to refer to the
>>>> EFI_MEMORY_HOT_PLUGGABLE attribute that is used for cold plugged boot
>>>> memory? If so, wouldn't it still be desirable to increase the size of
>>>> the bitmap to what was marked as hotpluggable initially?
>>>
>>> I just don't understand how hotpluggable memory presented in EFI memory
>>> map in presence of unaccepted memory. If not-yet-plugged memory marked
>>> as unaccepted we can preallocate bitmap upfront and make unaccepted
>>> memory transparent wrt hotplug.
>>>
>>> BTW, isn't virtio-mem a more attractive target to support than HW-style
>>> hotplug?
>>
>> I would have thought so as well, such that we can just let virtio-mem take care of any acceptance before actually using hotplugged memory (exposing it to the buddy).
>>
>> Likely there is desire to support other hypervisors?
> 
> That's true. We are certainly thinking about how the RAM discard manager
> should look like with multiple states to allow guest_memfd and
> virtio-mem to work together.
> 

Right, there is the QEMU side of it as well.

> Since both paths in Linux eventually converge around
> add_memory_resource(), based on some light hacking in QEMU I could see
> similar hotplug behavior for virtio-mem as well.

For virtio-mem it would not be add_memory_resource().

Whenever we would be plugging memory we would be accepting it, and when 
we would be unplugging memory we would unaccept it.

That is, acceptance does not happen at add_memory_resource() time, but 
when virtio-mem asks the device to transition a device block from 
unplugged<->plugged.

That also means that kexec is not a concern, because the device block 
state will reflect whether memory was accepted or not.

So far the theory :)

So it will be very different to DIMM-based hotplug handling.

-- 
Cheers

David

