Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A31AE66719C
	for <lists+linux-efi@lfdr.de>; Thu, 12 Jan 2023 13:05:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234200AbjALMFW (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 12 Jan 2023 07:05:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233262AbjALMEa (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 12 Jan 2023 07:04:30 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5721EE6D;
        Thu, 12 Jan 2023 03:59:14 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C66783EF0F;
        Thu, 12 Jan 2023 11:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1673524747; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rk8NDzBWXwv58AsxaL9j8+/toDN9Bb61CC4cwhVedfM=;
        b=qzHWsqiBk4OJrhKbSO650DFI5q4koVVxnqN2ZIEz8G1dreeKiagR3NaIzWHJVB3Bl/fcdI
        jCL6pFrhSUuL1/2WzQBm8TJ1cYEbe+oW4Vh0T0yjwS7M4ToYHGT30L/V/TH4U6MwdjHfWz
        Hq/aNYQC8eNjCUx+P362LtfzuP+uQ2c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1673524747;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rk8NDzBWXwv58AsxaL9j8+/toDN9Bb61CC4cwhVedfM=;
        b=GsSUBRvSchziBexgTOABJx/UJVpqdXwdjgN18Qaksi7RKXa9O1ylPBIS91uJCl1uBMcnHa
        hFOBoUYqBU/lwEBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 11AD213585;
        Thu, 12 Jan 2023 11:59:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id vQdxAwv2v2NxPAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 12 Jan 2023 11:59:07 +0000
Message-ID: <2b6c77bd-bead-7bfb-bf07-63e9ca837c58@suse.cz>
Date:   Thu, 12 Jan 2023 12:59:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCHv8 02/14] mm: Add support for unaccepted memory
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
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
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dario Faggioli <dfaggioli@suse.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        aarcange@redhat.com, peterx@redhat.com, x86@kernel.org,
        linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@linux.ibm.com>
References: <20221207014933.8435-1-kirill.shutemov@linux.intel.com>
 <20221207014933.8435-3-kirill.shutemov@linux.intel.com>
 <f944459f-76a6-60c3-7dae-0918d9ef0c5d@suse.cz>
 <20221209192616.dg4cbe7mgh3axv5h@box.shutemov.name>
 <3ab6ea38-5a9b-af4f-3c94-b75dce682bc1@suse.cz>
 <20221224164639.pb3hrvbxtlodgm5e@box.shutemov.name>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20221224164639.pb3hrvbxtlodgm5e@box.shutemov.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 12/24/22 17:46, Kirill A. Shutemov wrote:
> On Fri, Dec 09, 2022 at 11:23:50PM +0100, Vlastimil Babka wrote:
>> On 12/9/22 20:26, Kirill A. Shutemov wrote:
>> >> >  #ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
>> >> >  			/*
>> >> >  			 * Watermark failed for this zone, but see if we can
>> >> > @@ -4299,6 +4411,9 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
>> >> >  
>> >> >  			return page;
>> >> >  		} else {
>> >> > +			if (try_to_accept_memory(zone))
>> >> > +				goto try_this_zone;
>> >> 
>> >> On the other hand, here we failed the full rmqueue(), including the
>> >> potentially fragmenting fallbacks, so I'm worried that before we finally
>> >> fail all of that and resort to accepting more memory, we already fragmented
>> >> the already accepted memory, more than necessary.
>> > 
>> > I'm not sure I follow. We accept memory in pageblock chunks. Do we want to
>> > allocate from a free pageblock if we have other memory to tap from? It
>> > doesn't make sense to me.
>> 
>> The fragmentation avoidance based on migratetype does work with pageblock
>> granularity, so yeah, if you accept a single pageblock worth of memory and
>> then (through __rmqueue_fallback()) end up serving both movable and
>> unmovable allocations from it, the whole fragmentation avoidance mechanism
>> is defeated and you end up with unmovable allocations (e.g. page tables)
>> scattered over many pageblocks and inability to allocate any huge pages.
>> 
>> >> So one way to prevent would be to move the acceptance into rmqueue() to
>> >> happen before __rmqueue_fallback(), which I originally had in mind and maybe
>> >> suggested that previously.
>> > 
>> > I guess it should be pretty straight forward to fail __rmqueue_fallback()
>> > if there's non-empty unaccepted_pages list and steer to
>> > try_to_accept_memory() this way.
>> 
>> That could be a way indeed. We do have ALLOC_NOFRAGMENT which could be
>> possible to employ here.
>> But maybe the zone_watermark_fast() modification would be simpler yet
>> sufficient. It makes sense to me that we'd try to keep a high watermark
>> worth of pre-accepted memory. zone_watermark_fast() would fail at low
>> watermark, so we could try accepting (high-low) at a time instead of single
>> pageblock.
> 
> Looks like we already have __zone_watermark_unusable_free() that seems
> match use-case rather closely. We only need switch unaccepted memory to
> per-zone accounting.

Could work. I'd still suggest also making try_to_accept_memory() to accept
up to high watermark, not a single pageblock.
> The fixup below suppose to do the trick, but I'm not sure how to test
> fragmentation avoidance properly.
> 
> Any suggestions?

Haven't done that for years, maybe Mel knows better. But from what I
remember, I'd compare /proc/pagetypeinfo with and without memory accepting,
and collect the mm_page_alloc_extfrag tracepoint. If there are more of these
events happening, it's bad. Ideally with a workload that stresses both
userspace (movable) allocations and kernel allocations. Again, Mel might
have suggestions for a mmtest?

> 
> diff --git a/drivers/base/node.c b/drivers/base/node.c
> index ca6f0590be21..1bd2d245edee 100644
> --- a/drivers/base/node.c
> +++ b/drivers/base/node.c
> @@ -483,7 +483,7 @@ static ssize_t node_read_meminfo(struct device *dev,
>  #endif
>  #ifdef CONFIG_UNACCEPTED_MEMORY
>  			     ,
> -			     nid, K(node_page_state(pgdat, NR_UNACCEPTED))
> +			     nid, K(sum_zone_node_page_state(nid, NR_UNACCEPTED))
>  #endif
>  			    );
>  	len += hugetlb_report_node_meminfo(buf, len, nid);
> diff --git a/fs/proc/meminfo.c b/fs/proc/meminfo.c
> index 789b77c7b6df..e9c05b4c457c 100644
> --- a/fs/proc/meminfo.c
> +++ b/fs/proc/meminfo.c
> @@ -157,7 +157,7 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
>  
>  #ifdef CONFIG_UNACCEPTED_MEMORY
>  	show_val_kb(m, "Unaccepted:     ",
> -		    global_node_page_state(NR_UNACCEPTED));
> +		    global_zone_page_state(NR_UNACCEPTED));
>  #endif
>  
>  	hugetlb_report_meminfo(m);
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index 9c762e8175fc..8b5800cd4424 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -152,6 +152,9 @@ enum zone_stat_item {
>  	NR_ZSPAGES,		/* allocated in zsmalloc */
>  #endif
>  	NR_FREE_CMA_PAGES,
> +#ifdef CONFIG_UNACCEPTED_MEMORY
> +	NR_UNACCEPTED,
> +#endif
>  	NR_VM_ZONE_STAT_ITEMS };
>  
>  enum node_stat_item {
> @@ -198,9 +201,6 @@ enum node_stat_item {
>  	NR_FOLL_PIN_ACQUIRED,	/* via: pin_user_page(), gup flag: FOLL_PIN */
>  	NR_FOLL_PIN_RELEASED,	/* pages returned via unpin_user_page() */
>  	NR_KERNEL_STACK_KB,	/* measured in KiB */
> -#ifdef CONFIG_UNACCEPTED_MEMORY
> -	NR_UNACCEPTED,
> -#endif
>  #if IS_ENABLED(CONFIG_SHADOW_CALL_STACK)
>  	NR_KERNEL_SCS_KB,	/* measured in KiB */
>  #endif
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index e80e8d398863..404b267332a9 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1779,7 +1779,7 @@ static bool try_to_accept_memory(struct zone *zone)
>  
>  	migratetype = get_pfnblock_migratetype(page, page_to_pfn(page));
>  	__mod_zone_freepage_state(zone, -1 << order, migratetype);
> -	__mod_node_page_state(page_pgdat(page), NR_UNACCEPTED, -1 << order);
> +	__mod_zone_page_state(zone, NR_UNACCEPTED, -1 << order);
>  	spin_unlock_irqrestore(&zone->lock, flags);
>  
>  	if (last)
> @@ -1808,7 +1808,7 @@ static void __free_unaccepted(struct page *page, unsigned int order)
>  	migratetype = get_pfnblock_migratetype(page, page_to_pfn(page));
>  	list_add_tail(&page->lru, &zone->unaccepted_pages);
>  	__mod_zone_freepage_state(zone, 1 << order, migratetype);
> -	__mod_node_page_state(page_pgdat(page), NR_UNACCEPTED, 1 << order);
> +	__mod_zone_page_state(zone, NR_UNACCEPTED, 1 << order);
>  	spin_unlock_irqrestore(&zone->lock, flags);
>  
>  	if (first)
> @@ -4074,6 +4074,9 @@ static inline long __zone_watermark_unusable_free(struct zone *z,
>  	if (!(alloc_flags & ALLOC_CMA))
>  		unusable_free += zone_page_state(z, NR_FREE_CMA_PAGES);
>  #endif
> +#ifdef CONFIG_UNACCEPTED_MEMORY
> +	unusable_free += zone_page_state(z, NR_UNACCEPTED);
> +#endif
>  
>  	return unusable_free;
>  }

