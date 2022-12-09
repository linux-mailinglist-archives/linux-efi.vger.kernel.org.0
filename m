Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64C91648AB7
	for <lists+linux-efi@lfdr.de>; Fri,  9 Dec 2022 23:23:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbiLIWXz (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 9 Dec 2022 17:23:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiLIWXx (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 9 Dec 2022 17:23:53 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7803413F60;
        Fri,  9 Dec 2022 14:23:52 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id DD4FE1FD74;
        Fri,  9 Dec 2022 22:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1670624630; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Yazt+l+wO+0PmZJrbTp0vGTCDSc87Dt5hYFTptn2yHM=;
        b=z+Jq+hOaStbFPtaNKlg3FRxlSBaJXPh+oQnblB5JeLK9QCSD5hkCKokZJHkzC4ZBGcEoS8
        vLH8TNiP0LfBe/WMywCdbj5Tvhbr7KprdSH0e6iBWZPfpgudPSkMaotO3kiXvRyWmVlLrC
        l+y1sHZ68X32TZgeSWYxn6wkOV3kK4I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1670624630;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Yazt+l+wO+0PmZJrbTp0vGTCDSc87Dt5hYFTptn2yHM=;
        b=3bULmWys6kgqDJazRM50lrTiCrUAe0nUMdboobiW6WAV1/JQD9e6r6NUpUFhCOxFGJf6gX
        6LWv0XsEnE0/tOAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7889F13597;
        Fri,  9 Dec 2022 22:23:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id UJS+HHa1k2NPUQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Fri, 09 Dec 2022 22:23:50 +0000
Message-ID: <3ab6ea38-5a9b-af4f-3c94-b75dce682bc1@suse.cz>
Date:   Fri, 9 Dec 2022 23:23:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCHv8 02/14] mm: Add support for unaccepted memory
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
Content-Language: en-US
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20221209192616.dg4cbe7mgh3axv5h@box.shutemov.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 12/9/22 20:26, Kirill A. Shutemov wrote:
>> >  #ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
>> >  			/*
>> >  			 * Watermark failed for this zone, but see if we can
>> > @@ -4299,6 +4411,9 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
>> >  
>> >  			return page;
>> >  		} else {
>> > +			if (try_to_accept_memory(zone))
>> > +				goto try_this_zone;
>> 
>> On the other hand, here we failed the full rmqueue(), including the
>> potentially fragmenting fallbacks, so I'm worried that before we finally
>> fail all of that and resort to accepting more memory, we already fragmented
>> the already accepted memory, more than necessary.
> 
> I'm not sure I follow. We accept memory in pageblock chunks. Do we want to
> allocate from a free pageblock if we have other memory to tap from? It
> doesn't make sense to me.

The fragmentation avoidance based on migratetype does work with pageblock
granularity, so yeah, if you accept a single pageblock worth of memory and
then (through __rmqueue_fallback()) end up serving both movable and
unmovable allocations from it, the whole fragmentation avoidance mechanism
is defeated and you end up with unmovable allocations (e.g. page tables)
scattered over many pageblocks and inability to allocate any huge pages.

>> So one way to prevent would be to move the acceptance into rmqueue() to
>> happen before __rmqueue_fallback(), which I originally had in mind and maybe
>> suggested that previously.
> 
> I guess it should be pretty straight forward to fail __rmqueue_fallback()
> if there's non-empty unaccepted_pages list and steer to
> try_to_accept_memory() this way.

That could be a way indeed. We do have ALLOC_NOFRAGMENT which could be
possible to employ here.
But maybe the zone_watermark_fast() modification would be simpler yet
sufficient. It makes sense to me that we'd try to keep a high watermark
worth of pre-accepted memory. zone_watermark_fast() would fail at low
watermark, so we could try accepting (high-low) at a time instead of single
pageblock.

> But I still don't understand why.

To avoid what I described above.

>> But maybe less intrusive and more robust way would be to track how much
>> memory is unaccepted, and actually decrement that amount  from free memory
>> in zone_watermark_fast() in order to force earlier failure of that check and
>> thus to accept more memory and give us a buffer of truly accepted and
>> available memory up to high watermark, which should hopefully prevent most
>> of the fallbacks. Then the code I flagged above as currently unecessary
>> would make perfect sense.
> 
> The next patch adds per-node unaccepted memory accounting. We can move it
> per-zone if it would help.

Right.

>> And maybe Mel will have some ideas as well.
> 
> I don't have much expertise in page allocator. Any input is valuable.
> 
>> > +
>> >  #ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
>> >  			/* Try again if zone has deferred pages */
>> >  			if (static_branch_unlikely(&deferred_pages)) {
>> > @@ -6935,6 +7050,10 @@ static void __meminit zone_init_free_lists(struct zone *zone)
>> >  		INIT_LIST_HEAD(&zone->free_area[order].free_list[t]);
>> >  		zone->free_area[order].nr_free = 0;
>> >  	}
>> > +
>> > +#ifdef CONFIG_UNACCEPTED_MEMORY
>> > +	INIT_LIST_HEAD(&zone->unaccepted_pages);
>> > +#endif
>> >  }
>> >  
>> >  /*
>> 
> 

