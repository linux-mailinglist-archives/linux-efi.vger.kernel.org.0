Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA04D58EE61
	for <lists+linux-efi@lfdr.de>; Wed, 10 Aug 2022 16:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232480AbiHJOca (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 10 Aug 2022 10:32:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232601AbiHJOcK (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 10 Aug 2022 10:32:10 -0400
X-Greylist: delayed 512 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 10 Aug 2022 07:32:07 PDT
Received: from outbound-smtp12.blacknight.com (outbound-smtp12.blacknight.com [46.22.139.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE2042A731
        for <linux-efi@vger.kernel.org>; Wed, 10 Aug 2022 07:32:07 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp12.blacknight.com (Postfix) with ESMTPS id 168931C4250
        for <linux-efi@vger.kernel.org>; Wed, 10 Aug 2022 15:23:33 +0100 (IST)
Received: (qmail 10887 invoked from network); 10 Aug 2022 14:23:32 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 10 Aug 2022 14:23:32 -0000
Date:   Wed, 10 Aug 2022 15:19:59 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Vlastimil Babka <vbabka@suse.cz>
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
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        x86@kernel.org, linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCHv7 02/14] mm: Add support for unaccepted memory
Message-ID: <20220810141959.ictqchz7josyd7pt@techsingularity.net>
References: <20220614120231.48165-1-kirill.shutemov@linux.intel.com>
 <20220614120231.48165-3-kirill.shutemov@linux.intel.com>
 <8cf143e7-2b62-1a1e-de84-e3dcc6c027a4@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <8cf143e7-2b62-1a1e-de84-e3dcc6c027a4@suse.cz>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Aug 05, 2022 at 01:49:41PM +0200, Vlastimil Babka wrote:
> On 6/14/22 14:02, Kirill A. Shutemov wrote:
> > UEFI Specification version 2.9 introduces the concept of memory
> > acceptance. Some Virtual Machine platforms, such as Intel TDX or AMD
> > SEV-SNP, require memory to be accepted before it can be used by the
> > guest. Accepting happens via a protocol specific to the Virtual Machine
> > platform.
> > 
> > There are several ways kernel can deal with unaccepted memory:
> > 
> >  1. Accept all the memory during the boot. It is easy to implement and
> >     it doesn't have runtime cost once the system is booted. The downside
> >     is very long boot time.
> > 
> >     Accept can be parallelized to multiple CPUs to keep it manageable
> >     (i.e. via DEFERRED_STRUCT_PAGE_INIT), but it tends to saturate
> >     memory bandwidth and does not scale beyond the point.
> > 
> >  2. Accept a block of memory on the first use. It requires more
> >     infrastructure and changes in page allocator to make it work, but
> >     it provides good boot time.
> > 
> >     On-demand memory accept means latency spikes every time kernel steps
> >     onto a new memory block. The spikes will go away once workload data
> >     set size gets stabilized or all memory gets accepted.
> > 
> >  3. Accept all memory in background. Introduce a thread (or multiple)
> >     that gets memory accepted proactively. It will minimize time the
> >     system experience latency spikes on memory allocation while keeping
> >     low boot time.
> > 
> >     This approach cannot function on its own. It is an extension of #2:
> >     background memory acceptance requires functional scheduler, but the
> >     page allocator may need to tap into unaccepted memory before that.
> > 
> >     The downside of the approach is that these threads also steal CPU
> >     cycles and memory bandwidth from the user's workload and may hurt
> >     user experience.
> > 
> > Implement #2 for now. It is a reasonable default. Some workloads may
> > want to use #1 or #3 and they can be implemented later based on user's
> > demands.
> > 
> > Support of unaccepted memory requires a few changes in core-mm code:
> > 
> >   - memblock has to accept memory on allocation;
> > 
> >   - page allocator has to accept memory on the first allocation of the
> >     page;
> > 
> > Memblock change is trivial.
> > 
> > The page allocator is modified to accept pages on the first allocation.
> > The new page type (encoded in the _mapcount) -- PageUnaccepted() -- is
> > used to indicate that the page requires acceptance.
> > 
> > Architecture has to provide two helpers if it wants to support
> > unaccepted memory:
> > 
> >  - accept_memory() makes a range of physical addresses accepted.
> > 
> >  - range_contains_unaccepted_memory() checks anything within the range
> >    of physical addresses requires acceptance.
> > 
> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > Acked-by: Mike Rapoport <rppt@linux.ibm.com>	# memblock
> > Reviewed-by: David Hildenbrand <david@redhat.com>
> 
> Hmm I realize it's not ideal to raise this at v7, and maybe it was discussed
> before, but it's really not great how this affects the core page allocator
> paths. Wouldn't it be possible to only release pages to page allocator when
> accepted, and otherwise use some new per-zone variables together with the
> bitmap to track how much exactly is where to accept? Then it could be hooked
> in get_page_from_freelist() similarly to CONFIG_DEFERRED_STRUCT_PAGE_INIT -
> if we fail zone_watermark_fast() and there are unaccepted pages in the zone,
> accept them and continue. With a static key to flip in case we eventually
> accept everything. Because this is really similar scenario to the deferred
> init and that one was solved in a way that adds minimal overhead.
> 

I think it might be more straight-forward to always accept pages in the
size of the pageblock. Smaller ranges should matter because they have been
accepted in deferred_free_range. In expand, if PageUnaccepted is set on
a pageblock-sized page, take it off the list, drop the zone->lock leaving
IRQs disabled, accept the memory and reacquire the lock to split the page
into the required order.

IRQs being left disabled is unfortunate but even if the acceptance is slow,
it's presumably not so slow to cause major problems. This would would reduce
and probably eliminate the need to do the assert check in accept_page. It
might also simplify __free_one_page if it's known that a pageblock range
of pages are either all accepted or unaccepted.

Lastly, the default behaviour should probably be "accept all memory at
boot" and use Kconfig to allow acceptable be deferred or overridden by
command line. There are at least two reasons for this. Even though this
is a virtual machine, there still may be latency sensitive applications
running early in boot using pinned vcpu->pcpu and no memory overcommit.
The unpredictable performance of the application early in boot may be
unacceptable and unavoidable. It might take a long time but it could
eventually generate bug reports about "unpredictable performance early
in boot" that will be hard to track down unless accept_memory is observed
using perf at the right time. Even when that does happen, there will need
to be an option to turn it off if the unpredictable performance cannot
be tolerated. Second, any benchmarking done early in boot is likely to
be disrupted making the series a potential bisection magnet that masks a
performance bug elsewhere in the merge window.

-- 
Mel Gorman
SUSE Labs
