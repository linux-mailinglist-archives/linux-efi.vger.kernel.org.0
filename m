Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C49D848CAFF
	for <lists+linux-efi@lfdr.de>; Wed, 12 Jan 2022 19:30:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356216AbiALSag (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 12 Jan 2022 13:30:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343859AbiALSae (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 12 Jan 2022 13:30:34 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90DDAC06173F
        for <linux-efi@vger.kernel.org>; Wed, 12 Jan 2022 10:30:33 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id k21so11401624lfu.0
        for <linux-efi@vger.kernel.org>; Wed, 12 Jan 2022 10:30:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6Bd1YSx7ZEJFRVWc4uzIcZsdFSFPDFDvCJzwKAqaE94=;
        b=IL2tnYqp49KbC4DbWuWuSoApXfOYEWH0Vp5Wq6uLQomte7UH1R8nTj+3IyS8SHhJec
         qGCQHijVaIHx5YrucE/XyRn7182XVeqJfVWytDDyh/0iVrVgNGamW5WDAr0AiJJjcgY7
         15idRPC7XKfK8fc8fZTA5gsQOQaYJViFGSJIdjLJ1ZA4EGPFbGAh7h2Fd4/YbKCmsvUM
         qhxhwlb4e7jPcvZLSx3rabkNI+VWlF1wFSCJ04jQPcZVH0JX1cOAZxO+T2dmzCPlr9nG
         ZIwLxGDfyEggJelcWJ207CIU88nSi8g9FFbroSHlnCoH2zxwQCBgPfFNLB8RCtez565G
         rC3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6Bd1YSx7ZEJFRVWc4uzIcZsdFSFPDFDvCJzwKAqaE94=;
        b=KSeSFTBEPqE/JRdE4OE4SxJfxJisa//d947875KnScMA07CsXAryqZJKp5fbRZVEnl
         QdtAr7DfRtu/aGVarcG0d/dYehiVIt61XNajXu5cUWOaUTz205+SOXLeMF9f4GyKrWsY
         i7XtF42nR2fiaYyiJIlslfOj9QdrcdUxhDsqkZ+Q4LhhRr6ki3WvzdmAJj7DcxIQNUFA
         mHYLcTGARTHfUDJ4/ihvSpDLtalebRJRzqYeopp7d9htHNDFW+nLLrJMiJ8w+rXY+xQG
         TxyN8Ed4F+o3Mj6Ed6tqW+nTkXF2REoeA0LKbaz1OEVC9G7pc7TWaGX6baJ70x4zbD6M
         Xb3w==
X-Gm-Message-State: AOAM533jL2z/uNJRRpooR/u21vCajBViVCSSyH4Of9H/eexs1ANycZWd
        uF1bW8h/Ok8PjwrELjLuG9Cmwg==
X-Google-Smtp-Source: ABdhPJxII84HR55nTUGHpdJymluKJCPa7BHXt9J8snWVXP78Afawiy8EBYuIOyWa2/PzMO0FDVjDWg==
X-Received: by 2002:a2e:165c:: with SMTP id 28mr565509ljw.309.1642012231881;
        Wed, 12 Jan 2022 10:30:31 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id h10sm38660ljo.95.2022.01.12.10.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 10:30:30 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id 5649D103A6D; Wed, 12 Jan 2022 21:30:54 +0300 (+03)
Date:   Wed, 12 Jan 2022 21:30:54 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Varad Gautam <varad.gautam@suse.com>,
        Dario Faggioli <dfaggioli@suse.com>, x86@kernel.org,
        linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 1/7] mm: Add support for unaccepted memory
Message-ID: <20220112183054.uedczc4ldntrj25j@box.shutemov.name>
References: <20220111113314.27173-1-kirill.shutemov@linux.intel.com>
 <20220111113314.27173-2-kirill.shutemov@linux.intel.com>
 <3a68fabd-eaff-2164-5609-3a71fd4a7257@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a68fabd-eaff-2164-5609-3a71fd4a7257@intel.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Jan 11, 2022 at 11:46:37AM -0800, Dave Hansen wrote:
> > diff --git a/mm/memblock.c b/mm/memblock.c
> > index 1018e50566f3..6dfa594192de 100644
> > --- a/mm/memblock.c
> > +++ b/mm/memblock.c
> > @@ -1400,6 +1400,7 @@ phys_addr_t __init memblock_alloc_range_nid(phys_addr_t size,
> >   		 */
> >   		kmemleak_alloc_phys(found, size, 0, 0);
> > +	accept_memory(found, found + size);
> >   	return found;
> >   }
> 
> This could use a comment.

How about this:

	/*
	 * Some Virtual Machine platforms, such as Intel TDX or AMD SEV-SNP,
	 * requiring memory to be accepted before it can be used by the
	 * guest.
	 *
	 * Accept the memory of the allocated buffer.
	 */
> 
> Looking at this, I also have to wonder if accept_memory() is a bit too
> generic.  Should it perhaps be: cc_accept_memory() or
> cc_guest_accept_memory()?

I'll rename accept_memory() to cc_accept_memory() and
accept_and_clear_page_offline() to cc_accept_and_clear_page_offline().

> 
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index c5952749ad40..5707b4b5f774 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -1064,6 +1064,7 @@ static inline void __free_one_page(struct page *page,
> >   	unsigned int max_order;
> >   	struct page *buddy;
> >   	bool to_tail;
> > +	bool offline = PageOffline(page);
> >   	max_order = min_t(unsigned int, MAX_ORDER - 1, pageblock_order);
> > @@ -1097,6 +1098,10 @@ static inline void __free_one_page(struct page *page,
> >   			clear_page_guard(zone, buddy, order, migratetype);
> >   		else
> >   			del_page_from_free_list(buddy, zone, order);
> > +
> > +		if (PageOffline(buddy))
> > +			offline = true;
> > +
> >   		combined_pfn = buddy_pfn & pfn;
> >   		page = page + (combined_pfn - pfn);
> >   		pfn = combined_pfn;
> > @@ -1130,6 +1135,9 @@ static inline void __free_one_page(struct page *page,
> >   done_merging:
> >   	set_buddy_order(page, order);
> > +	if (offline)
> > +		__SetPageOffline(page);
> > +

I'll add

	/* Mark page PageOffline() if any merged page was PageOffline() */

above the 'if'.

> >   	if (fpi_flags & FPI_TO_TAIL)
> >   		to_tail = true;
> >   	else if (is_shuffle_order(order))
> 
> This is touching some pretty hot code paths.  You mention both that
> accepting memory is slow and expensive, yet you're doing it in the core
> allocator.
> 
> That needs at least some discussion in the changelog.

That is page type transfer on page merging. What expensive do you see here?
The cachelines with both struct pages are hot already.

> > @@ -1155,7 +1163,8 @@ static inline void __free_one_page(struct page *page,
> >   static inline bool page_expected_state(struct page *page,
> >   					unsigned long check_flags)
> >   {
> > -	if (unlikely(atomic_read(&page->_mapcount) != -1))
> > +	if (unlikely(atomic_read(&page->_mapcount) != -1) &&
> > +	    !PageOffline(page))
> >   		return false;
> 
> Looking at stuff like this, I can't help but think that a:
> 
> 	#define PageOffline PageUnaccepted
> 
> and some other renaming would be a fine idea.  I get that the Offline bit
> can be reused, but I'm not sure that the "Offline" *naming* should be
> reused.  What you're doing here is logically distinct from existing
> offlining.

I find the Offline name fitting. In both cases page is not accessible
without additional preparation.

Why do you want to multiply entities?

> >   	if (unlikely((unsigned long)page->mapping |
> > @@ -1734,6 +1743,8 @@ void __init memblock_free_pages(struct page *page, unsigned long pfn,
> >   {
> >   	if (early_page_uninitialised(pfn))
> >   		return;
> > +
> > +	maybe_set_page_offline(page, order);
> >   	__free_pages_core(page, order);
> >   }
> > @@ -1823,10 +1834,12 @@ static void __init deferred_free_range(unsigned long pfn,
> >   	if (nr_pages == pageblock_nr_pages &&
> >   	    (pfn & (pageblock_nr_pages - 1)) == 0) {
> >   		set_pageblock_migratetype(page, MIGRATE_MOVABLE);
> > +		maybe_set_page_offline(page, pageblock_order);
> >   		__free_pages_core(page, pageblock_order);
> >   		return;
> >   	}
> > +	accept_memory(pfn << PAGE_SHIFT, (pfn + nr_pages) << PAGE_SHIFT);
> >   	for (i = 0; i < nr_pages; i++, page++, pfn++) {
> >   		if ((pfn & (pageblock_nr_pages - 1)) == 0)
> >   			set_pageblock_migratetype(page, MIGRATE_MOVABLE);
> > @@ -2297,6 +2310,9 @@ static inline void expand(struct zone *zone, struct page *page,
> >   		if (set_page_guard(zone, &page[size], high, migratetype))
> >   			continue;
> > +		if (PageOffline(page))
> > +			__SetPageOffline(&page[size]);
> 
> Yeah, this is really begging for comments.  Please add some.

I'll add
		/* Transfer PageOffline() to newly split pages */
> 
> >   		add_to_free_list(&page[size], zone, high, migratetype);
> >   		set_buddy_order(&page[size], high);
> >   	}
> > @@ -2393,6 +2409,9 @@ inline void post_alloc_hook(struct page *page, unsigned int order,
> >   	 */
> >   	kernel_unpoison_pages(page, 1 << order);
> > +	if (PageOffline(page))
> > +		accept_and_clear_page_offline(page, order);
> > +
> >   	/*
> >   	 * As memory initialization might be integrated into KASAN,
> >   	 * kasan_alloc_pages and kernel_init_free_pages must be
> 
> I guess once there are no more PageOffline() pages in the allocator, the
> only impact from these patches will be a bunch of conditional branches from
> the "if (PageOffline(page))" that always have the same result.  The branch
> predictors should do a good job with that.
> 
> *BUT*, that overhead is going to be universally inflicted on all users on
> x86, even those without TDX.  I guess the compiler will save non-x86 users
> because they'll have an empty stub for accept_and_clear_page_offline() which
> the compiler will optimize away.
> 
> It sure would be nice to have some changelog material about why this is OK,
> though.  This is especially true since there's a global spinlock hidden in
> accept_and_clear_page_offline() wrapping a slow and "costly" operation.

Okay, I will come up with an explanation in commit message.

-- 
 Kirill A. Shutemov
