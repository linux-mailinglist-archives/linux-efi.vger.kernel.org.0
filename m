Return-Path: <linux-efi+bounces-5741-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 410D5C98BB8
	for <lists+linux-efi@lfdr.de>; Mon, 01 Dec 2025 19:36:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2F9EF4E28E0
	for <lists+linux-efi@lfdr.de>; Mon,  1 Dec 2025 18:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF93A21D3F4;
	Mon,  1 Dec 2025 18:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pMhet+Fq"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36DC211290;
	Mon,  1 Dec 2025 18:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764614168; cv=none; b=nQ9GQzMVoomznJWPmyg0FmjHHh+CMyujfGN9aCoTPSbvyLNnaMAimcuAl/8Up3AT2e3zdjMCAoS5Zvb+gUctNlnibtcW3fRxIyQ4JHJMUGIF7q9/UIovK2fL1LuLVWrGSPZzLPvWjPcJVBV1Xo3JGJ+qkaN4FCWyBUO9O8Q+zYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764614168; c=relaxed/simple;
	bh=GqUZ1tJI5oUYnsMVH3ZG4nNrDtR+42m3Jo4JWGTzt6I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dZnBF4omKftspcI3MIC7CqtJcEDQycOUHH4/yEaQ6VIviErLSmii/4bqJ9bnbCG6979FmV57sc3h6ml29MINoe2h1/yS2qgrV1cEjC3eWyQrx7vym4HFWyBTJpIXZsd7n15+EneeuBjQzLYZ4v6tJuVHS4Nm66gT4PWjizWp9nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pMhet+Fq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD0FEC113D0;
	Mon,  1 Dec 2025 18:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764614167;
	bh=GqUZ1tJI5oUYnsMVH3ZG4nNrDtR+42m3Jo4JWGTzt6I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pMhet+Fq3OUu5XL3bsQM2Ut07cJpCsYst6na1zeB9QV1LVueGKMNZVJOejLK0OW8u
	 eeRhAG8QCMeEIUdr7zEbNpDwSNbzmC2xc3TOAkRVTXJud4gK0Clqqj2FuZuKvsry1M
	 UZZWWPt4xmJ4XzQL0kwBzFXfsWFbPF+JQR8T/S/q20nRzpnyBTzanXMBGmEptQD6C/
	 Y4tTk2vYgkF8g4GXqo+JpuSce9pLJTEjw/gjuWc8P6vULU1p9h4vE0E159Fqj1sG59
	 dm0JbRXbwJoJSOnA8CuDKZRqRS2KB+Ehjn5WDu80qLF+9kH4ZpFh+1cHTRPIF5obsy
	 mpI1pbO18G9cQ==
Message-ID: <938a7948-7882-41a3-926b-3d2a8d07620d@kernel.org>
Date: Mon, 1 Dec 2025 19:36:00 +0100
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/4] mm: Add support for unaccepted memory hotplug
To: "Pratik R. Sampat" <prsampat@amd.com>, linux-mm@kvack.org,
 linux-coco@lists.linux.dev, linux-efi@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, kas@kernel.org, ardb@kernel.org,
 akpm@linux-foundation.org, osalvador@suse.de, thomas.lendacky@amd.com,
 michael.roth@amd.com
References: <20251125175753.1428857-1-prsampat@amd.com>
 <20251125175753.1428857-3-prsampat@amd.com>
 <ac479414-e0fa-49be-8a30-8f9c0e7b7d32@kernel.org>
 <73a69c03-feda-4c56-9db1-30ec489066fb@amd.com>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <73a69c03-feda-4c56-9db1-30ec489066fb@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/1/25 18:21, Pratik R. Sampat wrote:
> 
> 
> On 11/28/25 3:32 AM, David Hildenbrand (Red Hat) wrote:
>> On 11/25/25 18:57, Pratik R. Sampat wrote:
>>> The unaccepted memory structure currently only supports accepting memory
>>> present at boot time. The unaccepted table uses a fixed-size bitmap
>>> reserved in memblock based on the initial memory layout, preventing
>>> dynamic addition of memory ranges after boot. This causes guest
>>> termination when memory is hot-added in a secure virtual machine due to
>>> accessing pages that have not transitioned to private before use.
>>>
>>> Extend the unaccepted memory framework to handle hotplugged memory by
>>> dynamically managing the unaccepted bitmap. Allocate a new bitmap when
>>> hotplugged ranges exceed the reserved bitmap capacity and switch to
>>> kernel-managed allocation.
>>>
>>> Hotplugged memory also follows the same acceptance policy using the
>>> accept_memory=[eager|lazy] kernel parameter to accept memory either
>>> up-front when added or before first use.
>>>
>>> Signed-off-by: Pratik R. Sampat <prsampat@amd.com>
>>> ---
>>>    arch/x86/boot/compressed/efi.h                |  1 +
>>>    .../firmware/efi/libstub/unaccepted_memory.c  |  1 +
>>>    drivers/firmware/efi/unaccepted_memory.c      | 83 +++++++++++++++++++
>>>    include/linux/efi.h                           |  1 +
>>>    include/linux/mm.h                            | 11 +++
>>>    mm/memory_hotplug.c                           |  7 ++
>>>    mm/page_alloc.c                               |  2 +
>>>    7 files changed, 106 insertions(+)
>>>
>>> diff --git a/arch/x86/boot/compressed/efi.h b/arch/x86/boot/compressed/efi.h
>>> index 4f7027f33def..a220a1966cae 100644
>>> --- a/arch/x86/boot/compressed/efi.h
>>> +++ b/arch/x86/boot/compressed/efi.h
>>> @@ -102,6 +102,7 @@ struct efi_unaccepted_memory {
>>>        u32 unit_size;
>>>        u64 phys_base;
>>>        u64 size;
>>> +    bool mem_reserved;
>>>        unsigned long *bitmap;
>>>    };
>>>    diff --git a/drivers/firmware/efi/libstub/unaccepted_memory.c b/drivers/firmware/efi/libstub/unaccepted_memory.c
>>> index c1370fc14555..b16bd61c12bf 100644
>>> --- a/drivers/firmware/efi/libstub/unaccepted_memory.c
>>> +++ b/drivers/firmware/efi/libstub/unaccepted_memory.c
>>> @@ -83,6 +83,7 @@ efi_status_t allocate_unaccepted_bitmap(__u32 nr_desc,
>>>        unaccepted_table->unit_size = EFI_UNACCEPTED_UNIT_SIZE;
>>>        unaccepted_table->phys_base = unaccepted_start;
>>>        unaccepted_table->size = bitmap_size;
>>> +    unaccepted_table->mem_reserved = true;
>>>        memset(unaccepted_table->bitmap, 0, bitmap_size);
>>>          status = efi_bs_call(install_configuration_table,
>>> diff --git a/drivers/firmware/efi/unaccepted_memory.c b/drivers/firmware/efi/unaccepted_memory.c
>>> index 4479aad258f8..8537812346e2 100644
>>> --- a/drivers/firmware/efi/unaccepted_memory.c
>>> +++ b/drivers/firmware/efi/unaccepted_memory.c
>>> @@ -218,6 +218,89 @@ bool range_contains_unaccepted_memory(phys_addr_t start, unsigned long size)
>>>        return ret;
>>>    }
>>>    +static int extend_unaccepted_bitmap(phys_addr_t mem_range_start,
>>> +                    unsigned long mem_range_size)
>>> +{
>>> +    struct efi_unaccepted_memory *unacc_tbl;
>>> +    unsigned long *old_bitmap, *new_bitmap;
>>> +    phys_addr_t start, end, mem_range_end;
>>> +    u64 phys_base, size, unit_size;
>>> +    unsigned long flags;
>>> +
>>> +    unacc_tbl = efi_get_unaccepted_table();
>>> +    if (!unacc_tbl || !unacc_tbl->unit_size)
>>> +        return -EIO;
>>> +
>>> +    unit_size = unacc_tbl->unit_size;
>>> +    phys_base = unacc_tbl->phys_base;
>>> +
>>> +    mem_range_end = round_up(mem_range_start + mem_range_size, unit_size);
>>> +    size = DIV_ROUND_UP(mem_range_end - phys_base, unit_size * BITS_PER_BYTE);
>>> +
>>> +    /* Translate to offsets from the beginning of the bitmap */
>>> +    start = mem_range_start - phys_base;
>>> +    end = mem_range_end - phys_base;
>>> +
>>> +    old_bitmap = efi_get_unaccepted_bitmap();
>>> +    if (!old_bitmap)
>>> +        return -EIO;
>>> +
>>> +    /* If the bitmap is already large enough, just set the bits */
>>> +    if (unacc_tbl->size >= size) {
>>> +        spin_lock_irqsave(&unaccepted_memory_lock, flags);
>>> +        bitmap_set(old_bitmap, start / unit_size, (end - start) / unit_size);
>>> +        spin_unlock_irqrestore(&unaccepted_memory_lock, flags);
>>> +
>>> +        return 0;
>>> +    }
>>> +
>>> +    /* Reserved memblocks cannot be extended so allocate a new bitmap */
>>> +    if (unacc_tbl->mem_reserved) {
>>> +        new_bitmap = kzalloc(size, GFP_KERNEL);
>>> +        if (!new_bitmap)
>>> +            return -ENOMEM;
>>> +
>>> +        spin_lock_irqsave(&unaccepted_memory_lock, flags);
>>> +        memcpy(new_bitmap, old_bitmap, unacc_tbl->size);
>>> +        unacc_tbl->mem_reserved = false;
>>> +        free_reserved_area(old_bitmap, old_bitmap + unacc_tbl->size, -1, NULL);
>>> +        spin_unlock_irqrestore(&unaccepted_memory_lock, flags);
>>> +    } else {
>>> +        new_bitmap = krealloc(old_bitmap, size, GFP_KERNEL);
>>> +        if (!new_bitmap)
>>> +            return -ENOMEM;
>>> +
>>> +        /* Zero the bitmap from the range it was extended from */
>>> +        memset(new_bitmap + unacc_tbl->size, 0, size - unacc_tbl->size);
>>> +    }
>>> +
>>> +    bitmap_set(new_bitmap, start / unit_size, (end - start) / unit_size);
>>> +
>>> +    spin_lock_irqsave(&unaccepted_memory_lock, flags);
>>> +    unacc_tbl->size = size;
>>> +    unacc_tbl->bitmap = (unsigned long *)__pa(new_bitmap);
>>> +    spin_unlock_irqrestore(&unaccepted_memory_lock, flags);
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +int accept_hotplug_memory(phys_addr_t mem_range_start, unsigned long mem_range_size)
>>> +{
>>> +    int ret;
>>> +
>>> +    if (!IS_ENABLED(CONFIG_UNACCEPTED_MEMORY))
>>> +        return 0;
>>> +
>>> +    ret = extend_unaccepted_bitmap(mem_range_start, mem_range_size);
>>> +    if (ret)
>>> +        return ret;
>>> +
>>> +    if (!mm_lazy_accept_enabled())
>>> +        accept_memory(mem_range_start, mem_range_size);
>>> +
>>> +    return 0;
>>> +}
>>> +
>>>    #ifdef CONFIG_PROC_VMCORE
>>>    static bool unaccepted_memory_vmcore_pfn_is_ram(struct vmcore_cb *cb,
>>>                            unsigned long pfn)
>>> diff --git a/include/linux/efi.h b/include/linux/efi.h
>>> index a74b393c54d8..1021eb78388f 100644
>>> --- a/include/linux/efi.h
>>> +++ b/include/linux/efi.h
>>> @@ -545,6 +545,7 @@ struct efi_unaccepted_memory {
>>>        u32 unit_size;
>>>        u64 phys_base;
>>>        u64 size;
>>> +    bool mem_reserved;
>>>        unsigned long *bitmap;
>>>    };
>>>    diff --git a/include/linux/mm.h b/include/linux/mm.h
>>> index 1ae97a0b8ec7..bb43876e6c47 100644
>>> --- a/include/linux/mm.h
>>> +++ b/include/linux/mm.h
>>> @@ -4077,6 +4077,9 @@ int set_anon_vma_name(unsigned long addr, unsigned long size,
>>>      bool range_contains_unaccepted_memory(phys_addr_t start, unsigned long size);
>>>    void accept_memory(phys_addr_t start, unsigned long size);
>>> +int accept_hotplug_memory(phys_addr_t mem_range_start,
>>> +              unsigned long mem_range_size);
>>> +bool mm_lazy_accept_enabled(void);
>>>      #else
>>>    @@ -4090,6 +4093,14 @@ static inline void accept_memory(phys_addr_t start, unsigned long size)
>>>    {
>>>    }
>>>    +static inline int accept_hotplug_memory(phys_addr_t mem_range_start,
>>> +                    unsigned long mem_range_size)
>>> +{
>>> +    return 0;
>>> +}
>>> +
>>> +static inline bool mm_lazy_accept_enabled(void) { return false; }
>>> +
>>>    #endif
>>>      static inline bool pfn_is_unaccepted_memory(unsigned long pfn)
>>> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
>>> index 74318c787715..bf8086682b66 100644
>>> --- a/mm/memory_hotplug.c
>>> +++ b/mm/memory_hotplug.c
>>> @@ -1581,6 +1581,13 @@ int add_memory_resource(int nid, struct resource *res, mhp_t mhp_flags)
>>>        if (!strcmp(res->name, "System RAM"))
>>>            firmware_map_add_hotplug(start, start + size, "System RAM");
>>>    +    ret = accept_hotplug_memory(start, size);
>>
>> What makes this special that we have to have "hotplug_memory" as part of the name?
>>
>> Staring at the helper itself, there isn't anything really hotplug specific happening in there except extending the bitmap, maybe?
>>
> 
> Right, we are extending the original bitmap and initializing a structure
> to track state as well. I added the hotplug_memory keyword without
> much thought, since I didn't see anyone else attempting to extend these
> structures.
> 
> That said, I agree the name is awkward. I could either come up with
> something different, or we could eliminate the parent function
> entirely and call extend_unaccepted_bitmap() + accept_memory() directly
> from add_memory_resource(). Similarly, we could do the same to
> s/unaccept_hotplug_memory/unaccept_memory too.

BTW, can't we allocate the bitmap based on maximum memory in the system 
as indicated by e820 (which includes to-maybe-be-hotplugged-ranges) and 
not do this allocation during hotplug events?

If you search for max_possible_pfn / max_pfn I think you should find 
what I mean.

Then it would be a simple accept_memory().

-- 
Cheers

David

