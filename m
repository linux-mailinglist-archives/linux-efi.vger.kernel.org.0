Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D022539FCF
	for <lists+linux-efi@lfdr.de>; Wed,  1 Jun 2022 10:48:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350916AbiFAIsG (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 1 Jun 2022 04:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350908AbiFAIsF (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 1 Jun 2022 04:48:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D37D9532E9
        for <linux-efi@vger.kernel.org>; Wed,  1 Jun 2022 01:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654073283;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jHxFnf4L5CJt+8ufyNoLjuaskOQrUFWwTAD2sEpLDBg=;
        b=E7eiK3wApAGP9H/h+n5YOko7fJRMyAglaRcWBnIAc96tCP9DuB46Ko/oZloXMJpJpCjv0x
        HB4IL5ShjGtaxkE3XgsvJ/9VoDQktCxl9g7xZMvmXD5q7f5OLxbs5MY+FqmYckkfKt71W1
        UxCSy6Y/KTrlcpySscPnXfySF3pzqrs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-569-CMf_aO2sMyirBIjPJe1Ipw-1; Wed, 01 Jun 2022 04:48:01 -0400
X-MC-Unique: CMf_aO2sMyirBIjPJe1Ipw-1
Received: by mail-wm1-f72.google.com with SMTP id v126-20020a1cac84000000b00396fe5959d2so591540wme.8
        for <linux-efi@vger.kernel.org>; Wed, 01 Jun 2022 01:48:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=jHxFnf4L5CJt+8ufyNoLjuaskOQrUFWwTAD2sEpLDBg=;
        b=TbFuIXk5Nk2dwGj1UKeZ4r5POthlMnm7FTbj8YlhBhg28b35rTWgt1aqRXF6hy95g+
         bhJoIPvj+txfvqG2RzT/5fkY3bMUhJSFk9F2rrBgNlugRhvpnaL3/yi7LPPTDExOYZUd
         UKCnnLsCw3BFdBNQk+/zZzjem5ZCay3DUaQVYmWjKrXr21xCb+Tt/Y2WOXnXpZTPtOYz
         6ZkRxdEwL7U3ClTmeIXUumt0rz0kB8NkneUFHWKt1VD3Q+MbngCRTbs5fPNm4oCBD1tx
         ktGPXeu+pE7+0vL8pXC99/BixgxjMAOXZ4whnH1No+Oe7Pilg5Q9cEdqSMYbffiJUOQO
         AeCQ==
X-Gm-Message-State: AOAM5319FQkzHwlgDvUJQlXHGo2bEVs/RHuO1pKqe6bUXQDmzqvmNm7u
        KG+tld1l+JZl9HnX3A9VAbpa3uiAM17HrYhwKYjrdmp/Ut2cNAlKC5lseeGiWbbs91dMYddc9tU
        +QCNWsMl0fpC6K58TL112
X-Received: by 2002:adf:d1ea:0:b0:210:3e1f:3ea7 with SMTP id g10-20020adfd1ea000000b002103e1f3ea7mr1996153wrd.595.1654073280655;
        Wed, 01 Jun 2022 01:48:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzuUj4bh0uFZhtOrG4wLRNkxyLjBPGrhqN1jrHdUn8b5DqD5vqVBTnEyWA+4tqxWTRU2sCPCw==
X-Received: by 2002:adf:d1ea:0:b0:210:3e1f:3ea7 with SMTP id g10-20020adfd1ea000000b002103e1f3ea7mr1996126wrd.595.1654073280311;
        Wed, 01 Jun 2022 01:48:00 -0700 (PDT)
Received: from ?IPV6:2003:cb:c705:2600:951d:63df:c091:3b45? (p200300cbc7052600951d63dfc0913b45.dip0.t-ipconnect.de. [2003:cb:c705:2600:951d:63df:c091:3b45])
        by smtp.gmail.com with ESMTPSA id a13-20020a5d456d000000b0021024f82e01sm948294wrc.16.2022.06.01.01.47.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jun 2022 01:47:59 -0700 (PDT)
Message-ID: <f7e1d9e3-e4ba-8763-5db7-eca972c64fa4@redhat.com>
Date:   Wed, 1 Jun 2022 10:47:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     Andi Kleen <ak@linux.intel.com>,
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
        Dario Faggioli <dfaggioli@suse.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Mike Rapoport <rppt@kernel.org>, marcelo.cerri@canonical.com,
        tim.gardner@canonical.com, khalid.elmously@canonical.com,
        philip.cox@canonical.com, x86@kernel.org, linux-mm@kvack.org,
        linux-coco@lists.linux.dev, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>
References: <20220517153444.11195-1-kirill.shutemov@linux.intel.com>
 <20220517153444.11195-3-kirill.shutemov@linux.intel.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCHv6 02/15] mm: Add support for unaccepted memory
In-Reply-To: <20220517153444.11195-3-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 17.05.22 17:34, Kirill A. Shutemov wrote:
> UEFI Specification version 2.9 introduces the concept of memory
> acceptance. Some Virtual Machine platforms, such as Intel TDX or AMD
> SEV-SNP, require memory to be accepted before it can be used by the
> guest. Accepting happens via a protocol specific to the Virtual Machine
> platform.
> 
> There are several ways kernel can deal with unaccepted memory:
> 
>  1. Accept all the memory during the boot. It is easy to implement and
>     it doesn't have runtime cost once the system is booted. The downside
>     is very long boot time.
> 
>     Accept can be parallelized to multiple CPUs to keep it manageable
>     (i.e. via DEFERRED_STRUCT_PAGE_INIT), but it tends to saturate
>     memory bandwidth and does not scale beyond the point.
> 
>  2. Accept a block of memory on the first use. It requires more
>     infrastructure and changes in page allocator to make it work, but
>     it provides good boot time.
> 
>     On-demand memory accept means latency spikes every time kernel steps
>     onto a new memory block. The spikes will go away once workload data
>     set size gets stabilized or all memory gets accepted.
> 
>  3. Accept all memory in background. Introduce a thread (or multiple)
>     that gets memory accepted proactively. It will minimize time the
>     system experience latency spikes on memory allocation while keeping
>     low boot time.
> 
>     This approach cannot function on its own. It is an extension of #2:
>     background memory acceptance requires functional scheduler, but the
>     page allocator may need to tap into unaccepted memory before that.
> 
>     The downside of the approach is that these threads also steal CPU
>     cycles and memory bandwidth from the user's workload and may hurt
>     user experience.
> 
> Implement #2 for now. It is a reasonable default. Some workloads may
> want to use #1 or #3 and they can be implemented later based on user's
> demands.
> 
> Support of unaccepted memory requires a few changes in core-mm code:
> 
>   - memblock has to accept memory on allocation;
> 
>   - page allocator has to accept memory on the first allocation of the
>     page;
> 
> Memblock change is trivial.
> 
> The page allocator is modified to accept pages on the first allocation.
> The new page type (encoded in the _mapcount) -- PageUnaccepted() -- is
> used to indicate that the page requires acceptance.
> 
> Architecture has to provide two helpers if it wants to support
> unaccepted memory:
> 
>  - accept_memory() makes a range of physical addresses accepted.
> 
>  - memory_is_unaccepted() checks anything within the range of physical
>    addresses requires acceptance.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Acked-by: Mike Rapoport <rppt@linux.ibm.com>	# memblock


[...]

> +/*
> + * Page acceptance can be very slow. Do not call under critical locks.
> + */
> +static void accept_page(struct page *page, unsigned int order)
> +{
> +	phys_addr_t start = page_to_phys(page);
> +	int i;
> +
> +	accept_memory(start, start + (PAGE_SIZE << order));
> +	__ClearPageUnaccepted(page);
> +
> +	/* Assert that there is no PageUnaccepted() on tail pages */
> +	if (IS_ENABLED(CONFIG_DEBUG_VM)) {
> +		for (i = 1; i < (1 << order); i++)
> +			VM_BUG_ON_PAGE(PageUnaccepted(page + i), page + i);
> +	}
> +}
> +
> +static bool page_is_unaccepted(struct page *page, unsigned int order)

Nit: I'd call this page_contains_unaccepted(), otherwise it sounds like
we're just testing the flag.

> +{
> +	phys_addr_t start = page_to_phys(page);
> +	phys_addr_t end = start + (PAGE_SIZE << order);
> +
> +	return range_contains_unaccepted_memory(start, end);
> +}
> +


[...]

>  
>  #ifdef CONFIG_NUMA
> @@ -1807,6 +1877,9 @@ static void __init deferred_free_range(unsigned long pfn,
>  		return;
>  	}
>  
> +	/* Accept chunks smaller than page-block upfront */
> +	accept_memory(pfn << PAGE_SHIFT, (pfn + nr_pages) << PAGE_SHIFT);

PFN_PHYS()

> +
>  	for (i = 0; i < nr_pages; i++, page++, pfn++) {
>  		if ((pfn & (pageblock_nr_pages - 1)) == 0)
>  			set_pageblock_migratetype(page, MIGRATE_MOVABLE);
> @@ -2266,6 +2339,13 @@ static inline void expand(struct zone *zone, struct page *page,
>  		if (set_page_guard(zone, &page[size], high, migratetype))
>  			continue;
>  
> +		/*
> +		 * Transfer PageUnaccepted() to the newly split pages so
> +		 * they can be accepted after dropping the zone lock.
> +		 */
> +		if (PageUnaccepted(page))
> +			__SetPageUnaccepted(&page[size]);
> +
>  		add_to_free_list(&page[size], zone, high, migratetype);
>  		set_buddy_order(&page[size], high);
>  	}
> @@ -2396,6 +2476,9 @@ inline void post_alloc_hook(struct page *page, unsigned int order,
>  	 */
>  	kernel_unpoison_pages(page, 1 << order);
>  
> +	if (PageUnaccepted(page))
> +		accept_page(page, order);

Nit: Just move the PageUnaccepted() call into accept_page(), so all type
testing and clearing code is in a single location.

> +
>  	/*
>  	 * As memory initialization might be integrated into KASAN,
>  	 * KASAN unpoisoning and memory initializion code must be


Apart from that, LGTM. If the temporary clearing of the unaccepted type
is ever an issue (e.g., when we want to exclude reading them in
/proc/kcore), we can think of ways to avoid that race.

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

