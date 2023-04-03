Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B99E06D453E
	for <lists+linux-efi@lfdr.de>; Mon,  3 Apr 2023 15:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231736AbjDCNHi (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 3 Apr 2023 09:07:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231553AbjDCNHh (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 3 Apr 2023 09:07:37 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08A2211F;
        Mon,  3 Apr 2023 06:07:36 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id AD36E1FF6E;
        Mon,  3 Apr 2023 13:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1680527254; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HSoJPiNm6YLdrvyBCRNcHzBUr7oKAdacKl0GHdUtJXA=;
        b=VWqebsGWD8RAUsjZeeaP7K5SjdgTlp5fwMlBEgdMdHT4jVR3zeZ2tQhOESTQ3eQ0KKwUfe
        6LqMQ1DTNheF5SqznhydptvbvXLXMBajFHSA6zry0wxZqbEJ8wjaJCDQTXeVSxmKPTsUSy
        4nJLJVkcm4u7gVWb/VXyAdsRyAhfv8g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1680527254;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HSoJPiNm6YLdrvyBCRNcHzBUr7oKAdacKl0GHdUtJXA=;
        b=h5q3i5np2j574eqECbyNVp3f1IFao5UeZNBpPDfBsYuTt2l+15XRQsVsYhXLolIoF85mlX
        ouTblE3ueplUupCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 23B561331A;
        Mon,  3 Apr 2023 13:07:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id adnlB5bPKmS5YwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 03 Apr 2023 13:07:34 +0000
Message-ID: <2a8278cf-d282-ada6-0161-3b9c6adcb12e@suse.cz>
Date:   Mon, 3 Apr 2023 15:07:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCHv9 02/14] mm: Add support for unaccepted memory
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
References: <20230330114956.20342-1-kirill.shutemov@linux.intel.com>
 <20230330114956.20342-3-kirill.shutemov@linux.intel.com>
 <43234108-fa4f-7583-e3b4-2daa2de89fb0@suse.cz>
 <20230403100244.4sre7ki4ccusiiul@box>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20230403100244.4sre7ki4ccusiiul@box>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 4/3/23 12:02, Kirill A. Shutemov wrote:
> On Mon, Apr 03, 2023 at 11:26:53AM +0200, Vlastimil Babka wrote:
>> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>> > Acked-by: Mike Rapoport <rppt@linux.ibm.com>	# memblock
>> 
>> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> 
> Thanks!
> 
>> Just a small suggestion below:
>> 
>> > +
>> > +static bool try_to_accept_memory(struct zone *zone, unsigned int order)
>> > +{
>> > +	long to_accept;
>> > +	int ret = false;
>> > +
>> > +	if (!static_branch_unlikely(&zones_with_unaccepted_pages))
>> > +		return false;
>> 
>> 
>> This potentially (depends on what compiler decides) means we'll call this
>> function just to skip the static branch. OTOH forcing it as inline would be
>> wasteful too. So I'd split that away and make the callers do that static
>> branch check inline. Just as deferred_pages_enabled() is used.
> 
> Like this?

Yep.

> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 07e16e9b49c4..80fe5e4b6cca 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -390,6 +390,7 @@ EXPORT_SYMBOL(nr_online_nodes);
>  static bool page_contains_unaccepted(struct page *page, unsigned int order);
>  static void accept_page(struct page *page, unsigned int order);
>  static bool try_to_accept_memory(struct zone *zone, unsigned int order);
> +static inline bool has_unaccepted_memory(void);
>  static bool __free_unaccepted(struct page *page);
>  
>  int page_group_by_mobility_disabled __read_mostly;
> @@ -3464,8 +3465,10 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
>  				       gfp_mask)) {
>  			int ret;
>  
> -			if (try_to_accept_memory(zone, order))
> -				goto try_this_zone;
> +			if (has_unaccepted_memory()) {
> +				if (try_to_accept_memory(zone, order))
> +					goto try_this_zone;
> +			}
>  
>  #ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
>  			/*
> @@ -3519,8 +3522,10 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
>  
>  			return page;
>  		} else {
> -			if (try_to_accept_memory(zone, order))
> -				goto try_this_zone;
> +			if (has_unaccepted_memory()) {
> +				if (try_to_accept_memory(zone, order))
> +					goto try_this_zone;
> +			}
>  
>  #ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
>  			/* Try again if zone has deferred pages */
> @@ -7302,9 +7307,6 @@ static bool try_to_accept_memory(struct zone *zone, unsigned int order)
>  	long to_accept;
>  	int ret = false;
>  
> -	if (!static_branch_unlikely(&zones_with_unaccepted_pages))
> -		return false;
> -
>  	/* How much to accept to get to high watermark? */
>  	to_accept = high_wmark_pages(zone) -
>  		    (zone_page_state(zone, NR_FREE_PAGES) -
> @@ -7321,6 +7323,11 @@ static bool try_to_accept_memory(struct zone *zone, unsigned int order)
>  	return ret;
>  }
>  
> +static inline bool has_unaccepted_memory(void)
> +{
> +	return static_branch_unlikely(&zones_with_unaccepted_pages);
> +}
> +
>  static bool __free_unaccepted(struct page *page)
>  {
>  	struct zone *zone = page_zone(page);
> @@ -7398,6 +7405,11 @@ static bool try_to_accept_memory(struct zone *zone, unsigned int order)
>  	return false;
>  }
>  
> +static inline bool has_unaccepted_memory(void)
> +{
> +	return false;
> +}
> +
>  static bool __free_unaccepted(struct page *page)
>  {
>  	BUILD_BUG();

