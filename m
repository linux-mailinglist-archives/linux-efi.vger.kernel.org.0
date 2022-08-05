Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F90B58ABBA
	for <lists+linux-efi@lfdr.de>; Fri,  5 Aug 2022 15:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237496AbiHENjD (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 5 Aug 2022 09:39:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236060AbiHENjC (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 5 Aug 2022 09:39:02 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93CA51AD92;
        Fri,  5 Aug 2022 06:39:01 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 18E34205C1;
        Fri,  5 Aug 2022 13:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1659706740; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4fUGftCh+M9MgogM/ULV9Ld8sZEIEZ7PClbDaS2W+nE=;
        b=D+kEVNjzYfXvldJYaFOj5ruPF3HbAPd1RTtNyDXO5s9Vr7b1FvUVwcELgPkROgutphj7nM
        iiSynX1+4TbllV29hbsrR302sIj7NfXZ7IJX60SePWGOU3/zaepY+xQ42vPlATE3nVKiVV
        r8DHVCwFJzRdQ5klIaNM0LEzfHm/818=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1659706740;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4fUGftCh+M9MgogM/ULV9Ld8sZEIEZ7PClbDaS2W+nE=;
        b=CLiDkKcWHQhufTXRuMvyOhl3nB3aO/ZcIjwms2qYoxLv6GjUOx+1rIHjF1ArgPsKth9MMu
        BsA7bdcANtdIV7Cw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9E898133B5;
        Fri,  5 Aug 2022 13:38:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id rQT5JXMd7WKCNQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Fri, 05 Aug 2022 13:38:59 +0000
Message-ID: <f936b024-43e1-5390-e33f-ad7d355a2802@suse.cz>
Date:   Fri, 5 Aug 2022 15:38:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.3
Subject: Re: [PATCHv7 02/14] mm: Add support for unaccepted memory
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
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
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dario Faggioli <dfaggioli@suse.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Mike Rapoport <rppt@kernel.org>, marcelo.cerri@canonical.com,
        tim.gardner@canonical.com, khalid.elmously@canonical.com,
        philip.cox@canonical.com, x86@kernel.org, linux-mm@kvack.org,
        linux-coco@lists.linux.dev, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>,
        Mel Gorman <mgorman@techsingularity.net>
References: <20220614120231.48165-1-kirill.shutemov@linux.intel.com>
 <20220614120231.48165-3-kirill.shutemov@linux.intel.com>
 <8cf143e7-2b62-1a1e-de84-e3dcc6c027a4@suse.cz>
 <cb9d3310-3bc0-8ecf-5e71-becce980235f@redhat.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <cb9d3310-3bc0-8ecf-5e71-becce980235f@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 8/5/22 14:09, David Hildenbrand wrote:
> On 05.08.22 13:49, Vlastimil Babka wrote:
>> On 6/14/22 14:02, Kirill A. Shutemov wrote:
>>> UEFI Specification version 2.9 introduces the concept of memory
>>> acceptance. Some Virtual Machine platforms, such as Intel TDX or AMD
>>> SEV-SNP, require memory to be accepted before it can be used by the
>>> guest. Accepting happens via a protocol specific to the Virtual Machine
>>> platform.
>>>
>>> There are several ways kernel can deal with unaccepted memory:
>>>
>>>  1. Accept all the memory during the boot. It is easy to implement and
>>>     it doesn't have runtime cost once the system is booted. The downside
>>>     is very long boot time.
>>>
>>>     Accept can be parallelized to multiple CPUs to keep it manageable
>>>     (i.e. via DEFERRED_STRUCT_PAGE_INIT), but it tends to saturate
>>>     memory bandwidth and does not scale beyond the point.
>>>
>>>  2. Accept a block of memory on the first use. It requires more
>>>     infrastructure and changes in page allocator to make it work, but
>>>     it provides good boot time.
>>>
>>>     On-demand memory accept means latency spikes every time kernel steps
>>>     onto a new memory block. The spikes will go away once workload data
>>>     set size gets stabilized or all memory gets accepted.
>>>
>>>  3. Accept all memory in background. Introduce a thread (or multiple)
>>>     that gets memory accepted proactively. It will minimize time the
>>>     system experience latency spikes on memory allocation while keeping
>>>     low boot time.
>>>
>>>     This approach cannot function on its own. It is an extension of #2:
>>>     background memory acceptance requires functional scheduler, but the
>>>     page allocator may need to tap into unaccepted memory before that.
>>>
>>>     The downside of the approach is that these threads also steal CPU
>>>     cycles and memory bandwidth from the user's workload and may hurt
>>>     user experience.
>>>
>>> Implement #2 for now. It is a reasonable default. Some workloads may
>>> want to use #1 or #3 and they can be implemented later based on user's
>>> demands.
>>>
>>> Support of unaccepted memory requires a few changes in core-mm code:
>>>
>>>   - memblock has to accept memory on allocation;
>>>
>>>   - page allocator has to accept memory on the first allocation of the
>>>     page;
>>>
>>> Memblock change is trivial.
>>>
>>> The page allocator is modified to accept pages on the first allocation.
>>> The new page type (encoded in the _mapcount) -- PageUnaccepted() -- is
>>> used to indicate that the page requires acceptance.
>>>
>>> Architecture has to provide two helpers if it wants to support
>>> unaccepted memory:
>>>
>>>  - accept_memory() makes a range of physical addresses accepted.
>>>
>>>  - range_contains_unaccepted_memory() checks anything within the range
>>>    of physical addresses requires acceptance.
>>>
>>> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>>> Acked-by: Mike Rapoport <rppt@linux.ibm.com>	# memblock
>>> Reviewed-by: David Hildenbrand <david@redhat.com>
>> 
>> Hmm I realize it's not ideal to raise this at v7, and maybe it was discussed
>> before, but it's really not great how this affects the core page allocator
>> paths. Wouldn't it be possible to only release pages to page allocator when
>> accepted, and otherwise use some new per-zone variables together with the
>> bitmap to track how much exactly is where to accept? Then it could be hooked
>> in get_page_from_freelist() similarly to CONFIG_DEFERRED_STRUCT_PAGE_INIT -
>> if we fail zone_watermark_fast() and there are unaccepted pages in the zone,
>> accept them and continue. With a static key to flip in case we eventually
>> accept everything. Because this is really similar scenario to the deferred
>> init and that one was solved in a way that adds minimal overhead.
> 
> I kind of like just having the memory stats being correct (e.g., free
> memory) and acceptance being an internal detail to be triggered when
> allocating pages -- just like the arch_alloc_page() callback.

Hm, good point about the stats. Could be tweaked perhaps so it appears
correct on the outside, but might be tricky.

> I'm sure we could optimize for the !unaccepted memory via static keys
> also in this version with some checks at the right places if we find
> this to hurt performance?

It would be great if we would at least somehow hit the necessary code only
when dealing with a >=pageblock size block. The bitmap approach and
accepting everything smaller uprofront actually seems rather compatible. Yet
in the current patch we e.g. check PageUnaccepted(buddy) on every buddy size
while merging.

A list that sits besides the existing free_area, contains only >=pageblock
order sizes of unaccepted pages (no migratetype distinguished) and we tap
into it approximately before __rmqueue_fallback()? There would be some
trickery around releasing zone-lock for doing accept_memory(), but should be
manageable.
