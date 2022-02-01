Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38A4F4A5AF6
	for <lists+linux-efi@lfdr.de>; Tue,  1 Feb 2022 12:14:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235491AbiBALOE (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 1 Feb 2022 06:14:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:46118 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237102AbiBALOD (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 1 Feb 2022 06:14:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643714043;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I3cdlb+bt2t5R2qh8Ebhk0DyyXayuLjBrWUaEShw/SY=;
        b=iAq8UR6PEyOGI/XX2zP9sjR1rApc/f2JBo6XUyVw+uZVnR1J59wjXoPtJfC2cingAjwfyG
        KIte/r9p9rnPULMmGgbENXiHEP+0GPgUB7cjluH3qcX0ia5Pq0fa2Witl2wIjl6fxYB7jB
        hhKJZXVLK5R7TDKNapG1CUzZshZOVYQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-325-onO06lR5NwCPGFNT3sCjaw-1; Tue, 01 Feb 2022 06:14:02 -0500
X-MC-Unique: onO06lR5NwCPGFNT3sCjaw-1
Received: by mail-wr1-f70.google.com with SMTP id s25-20020adfa299000000b001d8d032255fso5842585wra.14
        for <linux-efi@vger.kernel.org>; Tue, 01 Feb 2022 03:14:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=I3cdlb+bt2t5R2qh8Ebhk0DyyXayuLjBrWUaEShw/SY=;
        b=RMfeQlmN4u0uUcDmCjS4VZoTcGejPJq7UGxg/GEC1BC1Qw2kYFkM5D9nfXFkB5ZE8M
         9ZhO+AyoqKH1OR6/n4s1RSj7oqsDhR1UeH+2qeuNmRSaLapJDgaYwiD0a1O2XnJw7NLA
         mbACTfuUW1oCQCUDDRsRB6CEyxswl1wnddsXWy+LrgeNEmHnx8i8VMqxsYOOSn9qMZIK
         WuIvmgG+Y5bWKFeXCxY/bfUhWmmCUFnPLBqAszHrEQaqfEljzn7qhhHtxe4T1l4WTY3M
         3PDlnUW7u3SwhC3m15ZY7JuCmvEWjM+Y2YhkspYwKOXXpe72wvk/gRd7UXGqwTn1Hp8Q
         njfA==
X-Gm-Message-State: AOAM532MyzAKrMAw4RKBY+Fgl19GbaDKLy/bZZb8Xjdf0vgyYHW8Vp7H
        lwHIUIP7yREJFVv/y4msX9e7EdOrsi6vF2/Of1UxY5+rTdoGyhGRc+jGT00Ozwtn2nqv3UKdAI3
        mxH3kUuSFzOEuiplA/K9D
X-Received: by 2002:a5d:47c5:: with SMTP id o5mr20849084wrc.666.1643714040902;
        Tue, 01 Feb 2022 03:14:00 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxCRt5YJsAUeIs7/ABVx6HcN37Qr2l4La9lv604NiEZBa9lLCs4/REmP1xiM/vpjnTFklGPaA==
X-Received: by 2002:a5d:47c5:: with SMTP id o5mr20849063wrc.666.1643714040567;
        Tue, 01 Feb 2022 03:14:00 -0800 (PST)
Received: from ?IPV6:2003:cb:c711:ba00:67b6:a3ab:b0a8:9517? (p200300cbc711ba0067b6a3abb0a89517.dip0.t-ipconnect.de. [2003:cb:c711:ba00:67b6:a3ab:b0a8:9517])
        by smtp.gmail.com with ESMTPSA id p190sm1796266wmp.16.2022.02.01.03.13.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Feb 2022 03:13:59 -0800 (PST)
Message-ID: <c09f8adc-7d2b-c204-8886-3f1cdd624ac5@redhat.com>
Date:   Tue, 1 Feb 2022 12:13:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        rppt@kernel.org, ak@linux.intel.com, akpm@linux-foundation.org,
        ardb@kernel.org, bp@alien8.de, brijesh.singh@amd.com,
        dave.hansen@intel.com, dfaggioli@suse.com, jroedel@suse.de,
        linux-coco@lists.linux.dev, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, luto@kernel.org,
        mingo@redhat.com, pbonzini@redhat.com, peterz@infradead.org,
        rientjes@google.com, sathyanarayanan.kuppuswamy@linux.intel.com,
        seanjc@google.com, tglx@linutronix.de, thomas.lendacky@amd.com,
        varad.gautam@suse.com, vbabka@suse.cz, x86@kernel.org,
        Mike Rapoport <rppt@linux.ibm.com>
References: <YfZJQedck2YxZcWA@kernel.org>
 <20220130164548.40417-1-kirill.shutemov@linux.intel.com>
 <acc12d73-a7d1-014c-9c07-33251d7d07ee@redhat.com>
 <20220131193041.xuagyispia77ak2g@box.shutemov.name>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCHv3.1 1/7] mm: Add support for unaccepted memory
In-Reply-To: <20220131193041.xuagyispia77ak2g@box.shutemov.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 31.01.22 20:30, Kirill A. Shutemov wrote:
> On Mon, Jan 31, 2022 at 01:13:49PM +0100, David Hildenbrand wrote:
>> On 30.01.22 17:45, Kirill A. Shutemov wrote:
>>> UEFI Specification version 2.9 introduces the concept of memory
>>> acceptance. Some Virtual Machine platforms, such as Intel TDX or AMD
>>> SEV-SNP, requiring memory to be accepted before it can be used by the
>>> guest. Accepting happens via a protocol specific for the Virtual Machine
>>> platform.
>>>
>>> Accepting memory is costly and it makes VMM allocate memory for the
>>> accepted guest physical address range. It's better to postpone memory
>>> acceptance until memory is needed. It lowers boot time and reduces
>>> memory overhead.
>>>
>>> Support of such memory requires a few changes in core-mm code:
>>>
>>>   - memblock has to accept memory on allocation;
>>>
>>>   - page allocator has to accept memory on the first allocation of the
>>>     page;
>>>
>>> Memblock change is trivial.
>>>
>>> The page allocator is modified to accept pages on the first allocation.
>>> PageBuddyUnaccepted() is used to indicate that the page requires acceptance.
>>>
>>> Kernel only need to accept memory once after boot, so during the boot
>>> and warm up phase there will be a lot of memory acceptance. After things
>>> are settled down the only price of the feature if couple of checks for
>>> PageBuddyUnaccepted() in alloc and free paths. The check refers a hot
>>> variable (that also encodes PageBuddy()), so it is cheap and not visible
>>> on profiles.
>>>
>>> Architecture has to provide three helpers if it wants to support
>>> unaccepted memory:
>>>
>>>  - accept_memory() makes a range of physical addresses accepted.
>>>
>>>  - maybe_mark_page_unaccepted() marks a page PageBuddyUnaccepted() if it
>>>    requires acceptance. Used during boot to put pages on free lists.
>>>
>>>  - accept_page() makes a page accepted and clears PageBuddyUnaccepted().
>>>
>>> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>>> Acked-by: Mike Rapoport <rppt@linux.ibm.com>	# memblock
>>
>>
>> You should somehow document+check+enforce that page poisoning cannot be
>> enabled concurrently, because it cannot possibly work IIUC.
> 
> Looking at code again, I now think that sharing the bit with PageOffline()
> is wrong. Previously I convinced myself that there's no conflict on the
> bit. In the initial version of the patchset, the page acceptance happened
> inside del_page_from_free_list() so any removal from the free list lead to
> clearing the bit. It is not the case now when acceptance moved to
> post_alloc_hook(). __isolate_free_page() and __offline_isolated_pages()
> look problematic now.
> 
> I will use brand new bit for the flag and rename BuddyUnaccepted to just
> Unaccepted, since it can be set with Buddy cleared.
> 
> Sounds okay?
> 
>> [...]
>>
>>> + /*
>>> +  * PageBuddyUnaccepted() indicates that the page has to be "accepted" before
>>> +  * it can be used. Page allocator has to call accept_page() before returning
>>> +  * the page to the caller.
>>> +  *
>>> +  * PageBuddyUnaccepted() encoded with the same bit as PageOffline().
>>> +  * PageOffline() pages are never on free list of buddy allocator, so there's
>>> +  * not conflict.
>>> +  */
>>> +#ifdef CONFIG_UNACCEPTED_MEMORY
>>> +PAGE_TYPE_OPS(BuddyUnaccepted, offline)
>>> +#else
>>> +PAGE_TYPE_OPS_FALSE(BuddyUnaccepted)
>>> +#endif
>>
>> Much better.
>>
>>> +
>>>  extern void page_offline_freeze(void);
>>>  extern void page_offline_thaw(void);
>>>  extern void page_offline_begin(void);
>>> diff --git a/mm/internal.h b/mm/internal.h
>>> index d80300392a19..26e5d7cb6aff 100644
>>> --- a/mm/internal.h
>>> +++ b/mm/internal.h
>>> @@ -718,4 +718,19 @@ void vunmap_range_noflush(unsigned long start, unsigned long end);
>>>  int numa_migrate_prep(struct page *page, struct vm_area_struct *vma,
>>>  		      unsigned long addr, int page_nid, int *flags);
>>>  
>>> +#ifndef CONFIG_UNACCEPTED_MEMORY
>>> +static inline void maybe_mark_page_unaccepted(struct page *page,
>>> +					      unsigned int order)
>>> +{
>>> +}
>>> +
>>> +static inline void accept_page(struct page *page, unsigned int order)
>>> +{
>>> +}
>>> +
>>> +static inline void accept_memory(phys_addr_t start, phys_addr_t end)
>>> +{
>>> +}
>>> +#endif
>>> +
>>>  #endif	/* __MM_INTERNAL_H */
>>> diff --git a/mm/memblock.c b/mm/memblock.c
>>> index 1018e50566f3..6c109b3b2a02 100644
>>> --- a/mm/memblock.c
>>> +++ b/mm/memblock.c
>>> @@ -1400,6 +1400,15 @@ phys_addr_t __init memblock_alloc_range_nid(phys_addr_t size,
>>>  		 */
>>>  		kmemleak_alloc_phys(found, size, 0, 0);
>>>  
>>> +	/*
>>> +	 * Some Virtual Machine platforms, such as Intel TDX or AMD SEV-SNP,
>>> +	 * require memory to be accepted before it can be used by the
>>> +	 * guest.
>>> +	 *
>>> +	 * Accept the memory of the allocated buffer.
>>> +	 */
>>> +	accept_memory(found, found + size);
>>> +
>>>  	return found;
>>>  }
>>>  
>>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>>> index 3589febc6d31..27b9bd20e675 100644
>>> --- a/mm/page_alloc.c
>>> +++ b/mm/page_alloc.c
>>> @@ -1077,6 +1077,7 @@ static inline void __free_one_page(struct page *page,
>>>  	unsigned int max_order;
>>>  	struct page *buddy;
>>>  	bool to_tail;
>>> +	bool unaccepted = PageBuddyUnaccepted(page);
>>>  
>>>  	max_order = min_t(unsigned int, MAX_ORDER - 1, pageblock_order);
>>>  
>>> @@ -1110,6 +1111,10 @@ static inline void __free_one_page(struct page *page,
>>>  			clear_page_guard(zone, buddy, order, migratetype);
>>>  		else
>>>  			del_page_from_free_list(buddy, zone, order);
>>> +
>>> +		if (PageBuddyUnaccepted(buddy))
>>> +			unaccepted = true;
>>> +
>>>  		combined_pfn = buddy_pfn & pfn;
>>>  		page = page + (combined_pfn - pfn);
>>>  		pfn = combined_pfn;
>>> @@ -1143,6 +1148,10 @@ static inline void __free_one_page(struct page *page,
>>>  done_merging:
>>>  	set_buddy_order(page, order);
>>>  
>>> +	/* Mark page unaccepted if any of merged pages were unaccepted */
>>> +	if (unaccepted)
>>> +		__SetPageBuddyUnaccepted(page);
>>> +
>>>  	if (fpi_flags & FPI_TO_TAIL)
>>>  		to_tail = true;
>>>  	else if (is_shuffle_order(order))
>>> @@ -1168,7 +1177,8 @@ static inline void __free_one_page(struct page *page,
>>>  static inline bool page_expected_state(struct page *page,
>>>  					unsigned long check_flags)
>>>  {
>>> -	if (unlikely(atomic_read(&page->_mapcount) != -1))
>>> +	if (unlikely(atomic_read(&page->_mapcount) != -1) &&
>>> +	    !PageBuddyUnaccepted(page))
>>>  		return false;
>>>  
>>>  	if (unlikely((unsigned long)page->mapping |
>>> @@ -1749,6 +1759,8 @@ void __init memblock_free_pages(struct page *page, unsigned long pfn,
>>>  {
>>>  	if (early_page_uninitialised(pfn))
>>>  		return;
>>> +
>>> +	maybe_mark_page_unaccepted(page, order);
>>>  	__free_pages_core(page, order);
>>
>> You'll be setting the page as unaccepted even before it's actually
>> PageBuddy(). While that works, I wonder why we call
>> maybe_mark_page_unaccepted() at these points.
>>
>> Why are we not moving that deeper into the buddy? __free_pages_core() is
>> used for any fresh pages that enter the buddy, used outside of
>> page_alloc.c only for memory hot(un)plug, so I'd suggest moving it at
>> least into there.
>>
>> But maybe we'd even move it further down, to the place where we actually
>> establish PageBuddy().
>>
>> One idea would be adding a new FPI_UNACCEPTED flag, passing it from
>> __free_pages_core() only, and calling maybe_mark_page_unaccepted() from
>> __free_one_page() after set_buddy_order().
>>
>> If in-lining would do its job properly, we'd be left with the
>> FPI_UNACCEPTED checks only when called via __free_pages_core(), and we'd
>> have that call at a single place right where we mess with PageBuddy().
> 
> Okay, this approach looks neat. See fixup below.
> 
> But there's down side: maybe_mark_page_unaccepted() cannot be __init
> anymore, since it is called from __free_one_page().
> 
> Any comments?
> 
> diff --git a/arch/x86/mm/unaccepted_memory.c b/arch/x86/mm/unaccepted_memory.c
> index 2c4ef49a0c9b..a9ce5b918d44 100644
> --- a/arch/x86/mm/unaccepted_memory.c
> +++ b/arch/x86/mm/unaccepted_memory.c
> @@ -42,7 +42,7 @@ void accept_memory(phys_addr_t start, phys_addr_t end)
>  	spin_unlock_irqrestore(&unaccepted_memory_lock, flags);
>  }
>  
> -void __init maybe_mark_page_unaccepted(struct page *page, unsigned int order)
> +void maybe_mark_page_unaccepted(struct page *page, unsigned int order)
>  {
>  	unsigned long *unaccepted_memory;
>  	phys_addr_t addr = page_to_phys(page);
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 27b9bd20e675..389a9b5e6d63 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -121,6 +121,12 @@ typedef int __bitwise fpi_t;
>   */
>  #define FPI_SKIP_KASAN_POISON	((__force fpi_t)BIT(2))
>  
> +/*
> + * Check if the page needs to be marked as PageBuddyUnaccepted().
> + * Used for the new pages added to the buddy allocator for the first time.
> + */
> +#define FPI_UNACCEPTED		((__force fpi_t)BIT(3))
> +
>  /* prevent >1 _updater_ of zone percpu pageset ->high and ->batch fields */
>  static DEFINE_MUTEX(pcp_batch_high_lock);
>  #define MIN_PERCPU_PAGELIST_HIGH_FRACTION (8)
> @@ -1148,9 +1154,17 @@ static inline void __free_one_page(struct page *page,
>  done_merging:
>  	set_buddy_order(page, order);
>  
> -	/* Mark page unaccepted if any of merged pages were unaccepted */
> -	if (unaccepted)
> +	if (unaccepted) {
> +		/* Mark page unaccepted if any of merged pages were unaccepted */
>  		__SetPageBuddyUnaccepted(page);
> +	} else if (fpi_flags & FPI_UNACCEPTED) {
> +		/*
> +		 * Check if the page needs to be marked as PageBuddyUnaccepted().
> +		 * Used for the new pages added to the buddy allocator for the
> +		 * first time.
> +		 */
> +		maybe_mark_page_unaccepted(page, order);
> +	}

Just one comment, not sure if I mentioned it earlier: I'd suggest a
slightly different api for maybe_mark_page_unaccepted(), then this would
become:

if (unaccepted ||
    ((fpi_flags & FPI_UNACCEPTED) && page_is_unaccepted(page, order)))
	__SetPageBuddyUnaccepted(page);

Whereby page_is_unaccepted() would simply return "true" if any part of
the page is unaccepted.

Just a thought -- it would be nice to have any setting/clearing of the
flag in page_alloc.c. This would imply that we'd have an simple API like

* accept_memory(unsigned long start_pfn, unsigned long nr_pages)
* memory_is_unaccepted(unsigned long start_pfn, unsigned long nr_pages)

And would perform flag updates in the caller. Do we care about sub-page
ranges? I don't think so.

-- 
Thanks,

David / dhildenb

