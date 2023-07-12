Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABF137502B4
	for <lists+linux-efi@lfdr.de>; Wed, 12 Jul 2023 11:19:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbjGLJTD (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 12 Jul 2023 05:19:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232292AbjGLJS7 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 12 Jul 2023 05:18:59 -0400
Received: from outbound-smtp43.blacknight.com (outbound-smtp43.blacknight.com [46.22.139.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45D8E1981
        for <linux-efi@vger.kernel.org>; Wed, 12 Jul 2023 02:18:49 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp43.blacknight.com (Postfix) with ESMTPS id BB4551B31
        for <linux-efi@vger.kernel.org>; Wed, 12 Jul 2023 10:18:47 +0100 (IST)
Received: (qmail 30399 invoked from network); 12 Jul 2023 09:18:47 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.21.103])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 12 Jul 2023 09:18:47 -0000
Date:   Wed, 12 Jul 2023 10:18:45 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
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
        Dario Faggioli <dfaggioli@suse.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        aarcange@redhat.com, peterx@redhat.com, x86@kernel.org,
        linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv14 5/9] efi: Add unaccepted memory support
Message-ID: <20230712091845.hahda3xgvegv5hgf@techsingularity.net>
References: <20230606142637.5171-1-kirill.shutemov@linux.intel.com>
 <20230606142637.5171-6-kirill.shutemov@linux.intel.com>
 <20230703132518.3ukqyolnes47i5r3@techsingularity.net>
 <20230704143740.bgimyg3bqsgxbm47@box.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20230704143740.bgimyg3bqsgxbm47@box.shutemov.name>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Jul 04, 2023 at 05:37:40PM +0300, Kirill A. Shutemov wrote:
> On Mon, Jul 03, 2023 at 02:25:18PM +0100, Mel Gorman wrote:
> > On Tue, Jun 06, 2023 at 05:26:33PM +0300, Kirill A. Shutemov wrote:
> > > efi_config_parse_tables() reserves memory that holds unaccepted memory
> > > configuration table so it won't be reused by page allocator.
> > > 
> > > Core-mm requires few helpers to support unaccepted memory:
> > > 
> > >  - accept_memory() checks the range of addresses against the bitmap and
> > >    accept memory if needed.
> > > 
> > >  - range_contains_unaccepted_memory() checks if anything within the
> > >    range requires acceptance.
> > > 
> > > Architectural code has to provide efi_get_unaccepted_table() that
> > > returns pointer to the unaccepted memory configuration table.
> > > 
> > > arch_accept_memory() handles arch-specific part of memory acceptance.
> > > 
> > > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > > Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
> > > Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
> > 
> > By and large, this looks ok from the page allocator perspective as the
> > checks for unaccepted are mostly after watermark checks. However, if you
> > look in the initial fast path, you'll see this
> > 
> >         /* 
> >          * Forbid the first pass from falling back to types that fragment
> >          * memory until all local zones are considered.
> >          */     
> >         alloc_flags |= alloc_flags_nofragment(ac.preferred_zoneref->zone, gfp);
> > 
> > While checking watermarks should be fine from a functional perspective and
> > the fast paths are unaffected, there is a risk of premature fragmentation
> > until all memory has been accepted. Meeting watermarks does not necessarily
> > mean that fragmentation is avoided as pageblocks can get mixed while still
> > meeting watermarks.
> 
> Could you elaborate on this scenario?
> 
> Current code checks the watermark, if it is met, try rmqueue().
> 
> If rmqueue() fails anyway, try to accept more pages and retry the zone if
> it is successful.
> 
> I'm not sure how we can get to the 'if (no_fallback) {' case with any
> unaccepted memory in the allowed zones.
> 

Lets take an extreme example and assume that the low watermark is lower
than 2MB (one pageblock). Just before the watermark is reached (free
count between 1MB and 2MB), it is unlikely that all free pages are within
pageblocks of the same migratetype (e.g. MIGRATE_MOVABLE). If there is an
allocation near the watermark of a different type (e.g. MIGRATE_UNMOVABLE)
then the page allocation could fallback to a different pageblock and now
it is mixed.  It's a condition that is only obvious if you are explicitly
checking for it via tracepoints.  This can happen in the normal case, but
unaccepted memory makes it worse because the "pageblock mixing" could have
been avoided if the "no_fallback" case accepted at least one new pageblock
instead of mixing pageblocks.

That is an extreme example but the same logic applies when the free
count is at or near MIGRATE_TYPES*pageblock_nr_pages as it is not
guaranteed that the pageblocks with free pages are a migratetype that
matches the allocation request.

Hence, it may be more robust from a fragmentation perspective if
ALLOC_NOFRAGMENT requests accept memory if it is available and retries
before clearing ALLOC_NOFRAGMENT and mixing pageblocks before the watermarks
are reached.

> I see that there's preferred_zoneref and spread_dirty_pages cases, but
> unaccepted memory seems change nothing for them.
> 

preferred_zoneref is about premature zone exhaustion and
spread_dirty_pages is about avoiding premature stalls on a node/zone due
to an imbalance in the number of pages waiting for writeback to
complete. There is an arguement to be made that they also should accept
memory but it's less clear how much of a problem this is. Both are very
obvious when they "fail" and likely are covered by the existing
watermark checks. Premature pageblock mixing is more subtle as the final
impact (root cause of a premature THP allocation failure) is harder to
detect.

-- 
Mel Gorman
SUSE Labs
