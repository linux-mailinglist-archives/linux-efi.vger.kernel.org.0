Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E83A94A4C0C
	for <lists+linux-efi@lfdr.de>; Mon, 31 Jan 2022 17:29:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380372AbiAaQ3E (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 31 Jan 2022 11:29:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27954 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1380403AbiAaQ3D (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 31 Jan 2022 11:29:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643646541;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hmuMsAjEZjQZHrg7yUFU1js6YXvARd+PEHspodUJJZg=;
        b=HvvMw1OLgenky1U1hMGpAhVcmDGHoxsLL1/fUqhFDkTJdTaTtQ/ZSEZxZnjy9JSXWwTsBI
        FlkqLOSmihyeADANFtELgI4GV0t/2XrLq/xDsokYJToE0CoMltukyRx9IZA934XRmKxhrN
        6B0eaCRu7ilKlQsjWem+nAWtV+uNLno=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-484-4zB6mth5MlyksBg4TXdt9w-1; Mon, 31 Jan 2022 11:29:00 -0500
X-MC-Unique: 4zB6mth5MlyksBg4TXdt9w-1
Received: by mail-wm1-f70.google.com with SMTP id f188-20020a1c1fc5000000b0034d79edde84so3138848wmf.0
        for <linux-efi@vger.kernel.org>; Mon, 31 Jan 2022 08:29:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:organization:in-reply-to
         :content-transfer-encoding;
        bh=hmuMsAjEZjQZHrg7yUFU1js6YXvARd+PEHspodUJJZg=;
        b=THpTn4DS6IlD4n7QwJ6760AUD74ZsTVvVV49ffImq2E0lCd5W2DEYNEy3hydFrfZwL
         SluOA7Vz30NF5YRzLsoGjAqRVZqWNDlweewcFYsp3gTIFmFlZj+g1hJIC5eqi6+9/ZW7
         U/6GsYp/p8ccONBbCMN8wb8gWugl9fZl0EbP/BOn5KvM6dyy/fDcptQ4kiAWJEmzcbJb
         X+kzfdSUNPRpx8fv9p7zvBUmYqVlvjVmvrPiEK5ApW7rUDCTwTAQQxdIAbb93ejeCwLL
         UrxYf4OSpWxrTA04jNM/EeuRx8ELRd2PLmPNohdo6eAGba5UJE+tGiWtdDOP9uYwLOZL
         GYmw==
X-Gm-Message-State: AOAM5309YySzaSaOTck5mphovSXd5RUqHqUXQq+52ZeYkxA8sM1+jy6m
        luDc9eVHfFK0PKbmUllCqV6kVaLUDhBXDGuMcCyEsWWFnEn6a6JGWBRaKqdcNMywQ50oiuDycKD
        fXaXWrFzSGaqTahJaytke
X-Received: by 2002:a5d:4643:: with SMTP id j3mr17631248wrs.356.1643646539209;
        Mon, 31 Jan 2022 08:28:59 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwdzbGYaMPPYVed7pQ1FlPpZYU6l8fZNhcdm9Qro3b+mQBlfrMX5ZY9vrbbJxF9ByRVXnGKFw==
X-Received: by 2002:a5d:4643:: with SMTP id j3mr17631208wrs.356.1643646538901;
        Mon, 31 Jan 2022 08:28:58 -0800 (PST)
Received: from ?IPV6:2003:cb:c709:b200:f007:5a26:32e7:8ef5? (p200300cbc709b200f0075a2632e78ef5.dip0.t-ipconnect.de. [2003:cb:c709:b200:f007:5a26:32e7:8ef5])
        by smtp.gmail.com with ESMTPSA id e17sm1564548wrt.27.2022.01.31.08.28.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jan 2022 08:28:58 -0800 (PST)
Message-ID: <e2bb90df-a786-19a3-1819-760d0249d2ab@redhat.com>
Date:   Mon, 31 Jan 2022 17:28:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCHv3.1 1/7] mm: Add support for unaccepted memory
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        rppt@kernel.org
Cc:     ak@linux.intel.com, akpm@linux-foundation.org, ardb@kernel.org,
        bp@alien8.de, brijesh.singh@amd.com, dave.hansen@intel.com,
        dfaggioli@suse.com, jroedel@suse.de, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, luto@kernel.org, mingo@redhat.com,
        pbonzini@redhat.com, peterz@infradead.org, rientjes@google.com,
        sathyanarayanan.kuppuswamy@linux.intel.com, seanjc@google.com,
        tglx@linutronix.de, thomas.lendacky@amd.com, varad.gautam@suse.com,
        vbabka@suse.cz, x86@kernel.org, Mike Rapoport <rppt@linux.ibm.com>
References: <YfZJQedck2YxZcWA@kernel.org>
 <20220130164548.40417-1-kirill.shutemov@linux.intel.com>
 <acc12d73-a7d1-014c-9c07-33251d7d07ee@redhat.com>
Organization: Red Hat
In-Reply-To: <acc12d73-a7d1-014c-9c07-33251d7d07ee@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 31.01.22 13:13, David Hildenbrand wrote:
> On 30.01.22 17:45, Kirill A. Shutemov wrote:
>> UEFI Specification version 2.9 introduces the concept of memory
>> acceptance. Some Virtual Machine platforms, such as Intel TDX or AMD
>> SEV-SNP, requiring memory to be accepted before it can be used by the
>> guest. Accepting happens via a protocol specific for the Virtual Machine
>> platform.
>>
>> Accepting memory is costly and it makes VMM allocate memory for the
>> accepted guest physical address range. It's better to postpone memory
>> acceptance until memory is needed. It lowers boot time and reduces
>> memory overhead.
>>
>> Support of such memory requires a few changes in core-mm code:
>>
>>   - memblock has to accept memory on allocation;
>>
>>   - page allocator has to accept memory on the first allocation of the
>>     page;
>>
>> Memblock change is trivial.
>>
>> The page allocator is modified to accept pages on the first allocation.
>> PageBuddyUnaccepted() is used to indicate that the page requires acceptance.
>>
>> Kernel only need to accept memory once after boot, so during the boot
>> and warm up phase there will be a lot of memory acceptance. After things
>> are settled down the only price of the feature if couple of checks for
>> PageBuddyUnaccepted() in alloc and free paths. The check refers a hot
>> variable (that also encodes PageBuddy()), so it is cheap and not visible
>> on profiles.
>>
>> Architecture has to provide three helpers if it wants to support
>> unaccepted memory:
>>
>>  - accept_memory() makes a range of physical addresses accepted.
>>
>>  - maybe_mark_page_unaccepted() marks a page PageBuddyUnaccepted() if it
>>    requires acceptance. Used during boot to put pages on free lists.
>>
>>  - accept_page() makes a page accepted and clears PageBuddyUnaccepted().
>>
>> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>> Acked-by: Mike Rapoport <rppt@linux.ibm.com>	# memblock
> 
> 
> You should somehow document+check+enforce that page poisoning cannot be
> enabled concurrently, because it cannot possibly work IIUC.
> 
> [...]
> 
>> + /*
>> +  * PageBuddyUnaccepted() indicates that the page has to be "accepted" before
>> +  * it can be used. Page allocator has to call accept_page() before returning
>> +  * the page to the caller.
>> +  *
>> +  * PageBuddyUnaccepted() encoded with the same bit as PageOffline().
>> +  * PageOffline() pages are never on free list of buddy allocator, so there's
>> +  * not conflict.
>> +  */
>> +#ifdef CONFIG_UNACCEPTED_MEMORY
>> +PAGE_TYPE_OPS(BuddyUnaccepted, offline)
>> +#else
>> +PAGE_TYPE_OPS_FALSE(BuddyUnaccepted)
>> +#endif
> 
> Much better.
> 
>> +
>>  extern void page_offline_freeze(void);
>>  extern void page_offline_thaw(void);
>>  extern void page_offline_begin(void);
>> diff --git a/mm/internal.h b/mm/internal.h
>> index d80300392a19..26e5d7cb6aff 100644
>> --- a/mm/internal.h
>> +++ b/mm/internal.h
>> @@ -718,4 +718,19 @@ void vunmap_range_noflush(unsigned long start, unsigned long end);
>>  int numa_migrate_prep(struct page *page, struct vm_area_struct *vma,
>>  		      unsigned long addr, int page_nid, int *flags);
>>  
>> +#ifndef CONFIG_UNACCEPTED_MEMORY
>> +static inline void maybe_mark_page_unaccepted(struct page *page,
>> +					      unsigned int order)
>> +{
>> +}
>> +
>> +static inline void accept_page(struct page *page, unsigned int order)
>> +{
>> +}
>> +
>> +static inline void accept_memory(phys_addr_t start, phys_addr_t end)
>> +{
>> +}
>> +#endif
>> +
>>  #endif	/* __MM_INTERNAL_H */
>> diff --git a/mm/memblock.c b/mm/memblock.c
>> index 1018e50566f3..6c109b3b2a02 100644
>> --- a/mm/memblock.c
>> +++ b/mm/memblock.c
>> @@ -1400,6 +1400,15 @@ phys_addr_t __init memblock_alloc_range_nid(phys_addr_t size,
>>  		 */
>>  		kmemleak_alloc_phys(found, size, 0, 0);
>>  
>> +	/*
>> +	 * Some Virtual Machine platforms, such as Intel TDX or AMD SEV-SNP,
>> +	 * require memory to be accepted before it can be used by the
>> +	 * guest.
>> +	 *
>> +	 * Accept the memory of the allocated buffer.
>> +	 */
>> +	accept_memory(found, found + size);
>> +
>>  	return found;
>>  }
>>  
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index 3589febc6d31..27b9bd20e675 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -1077,6 +1077,7 @@ static inline void __free_one_page(struct page *page,
>>  	unsigned int max_order;
>>  	struct page *buddy;
>>  	bool to_tail;
>> +	bool unaccepted = PageBuddyUnaccepted(page);
>>  
>>  	max_order = min_t(unsigned int, MAX_ORDER - 1, pageblock_order);
>>  
>> @@ -1110,6 +1111,10 @@ static inline void __free_one_page(struct page *page,
>>  			clear_page_guard(zone, buddy, order, migratetype);
>>  		else
>>  			del_page_from_free_list(buddy, zone, order);
>> +
>> +		if (PageBuddyUnaccepted(buddy))
>> +			unaccepted = true;
>> +
>>  		combined_pfn = buddy_pfn & pfn;
>>  		page = page + (combined_pfn - pfn);
>>  		pfn = combined_pfn;
>> @@ -1143,6 +1148,10 @@ static inline void __free_one_page(struct page *page,
>>  done_merging:
>>  	set_buddy_order(page, order);
>>  
>> +	/* Mark page unaccepted if any of merged pages were unaccepted */
>> +	if (unaccepted)
>> +		__SetPageBuddyUnaccepted(page);
>> +
>>  	if (fpi_flags & FPI_TO_TAIL)
>>  		to_tail = true;
>>  	else if (is_shuffle_order(order))
>> @@ -1168,7 +1177,8 @@ static inline void __free_one_page(struct page *page,
>>  static inline bool page_expected_state(struct page *page,
>>  					unsigned long check_flags)
>>  {
>> -	if (unlikely(atomic_read(&page->_mapcount) != -1))
>> +	if (unlikely(atomic_read(&page->_mapcount) != -1) &&
>> +	    !PageBuddyUnaccepted(page))
>>  		return false;
>>  
>>  	if (unlikely((unsigned long)page->mapping |
>> @@ -1749,6 +1759,8 @@ void __init memblock_free_pages(struct page *page, unsigned long pfn,
>>  {
>>  	if (early_page_uninitialised(pfn))
>>  		return;
>> +
>> +	maybe_mark_page_unaccepted(page, order);
>>  	__free_pages_core(page, order);
> 
> You'll be setting the page as unaccepted even before it's actually
> PageBuddy(). While that works, I wonder why we call
> maybe_mark_page_unaccepted() at these points.
> 
> Why are we not moving that deeper into the buddy? __free_pages_core() is
> used for any fresh pages that enter the buddy, used outside of
> page_alloc.c only for memory hot(un)plug, so I'd suggest moving it at
> least into there.
> 
> But maybe we'd even move it further down, to the place where we actually
> establish PageBuddy().
> 
> One idea would be adding a new FPI_UNACCEPTED flag, passing it from
> __free_pages_core() only, and calling maybe_mark_page_unaccepted() from
> __free_one_page() after set_buddy_order().
> 
> If in-lining would do its job properly, we'd be left with the
> FPI_UNACCEPTED checks only when called via __free_pages_core(), and we'd
> have that call at a single place right where we mess with PageBuddy().
> 


Whops, I forgot

Acked-by: David Hildenbrand <david@redhat.com>

Because the general approach LGTM.

-- 
Thanks,

David / dhildenb

