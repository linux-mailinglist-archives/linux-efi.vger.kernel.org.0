Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3DAC7CAEA8
	for <lists+linux-efi@lfdr.de>; Mon, 16 Oct 2023 18:12:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232389AbjJPQMK (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 16 Oct 2023 12:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232833AbjJPQMG (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 16 Oct 2023 12:12:06 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D69BFA;
        Mon, 16 Oct 2023 09:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697472723; x=1729008723;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=th4TeJcqs9Lsg7FgXl8/atfXmZLKWJrhml83JQ6RL6w=;
  b=LkCgIGQRLBZjhsBKjMrsUWrzbV/mKLfuPH4syN3n9iFZts9TVp5WWJN7
   pXM4rykrcOS5XREEQx+KLCKNfyx251y1vxVWMcSjttApPh89+kI144mr9
   bO8r+3fdlTkDX4ozyvZ/pXhW3/7IZadqwlHlsDb3zMK8IKCK6MUdKh/vh
   tfX+thE5geY+lSw13sEAcrwAUxzYZf0vprWYiNgsj4dmwuZP8NBYgXOUi
   yoFrJU4FhAu1wE8tzTVTtuFFFNM8R+tGVVwKiu5z/7k4jO69SuXqNDKSs
   HC91giSjv+j+q1P7C/MyKzTpy3y2DqZJiY7E0kddoWqb0sZQR8OO45Xix
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="4176289"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; 
   d="scan'208";a="4176289"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 09:12:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="1087125336"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; 
   d="scan'208";a="1087125336"
Received: from ranaelna-mobl.amr.corp.intel.com (HELO box.shutemov.name) ([10.251.208.247])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 09:11:48 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 423FC10A1EC; Mon, 16 Oct 2023 19:11:46 +0300 (+03)
Date:   Mon, 16 Oct 2023 19:11:46 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        Nikolay Borisov <nik.borisov@suse.com>,
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
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        aarcange@redhat.com, peterx@redhat.com, x86@kernel.org,
        linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@kernel.org
Subject: Re: [PATCH] efi/unaccepted: Fix soft lockups caused by parallel
 memory acceptance
Message-ID: <20231016161146.4j24jprkeaanflpf@box.shutemov.name>
References: <20231014204040.28765-1-kirill.shutemov@linux.intel.com>
 <088593ea-e001-fa87-909f-a196b1373ca4@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <088593ea-e001-fa87-909f-a196b1373ca4@suse.cz>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Oct 16, 2023 at 12:58:34PM +0200, Vlastimil Babka wrote:
> On 10/14/23 22:40, Kirill A. Shutemov wrote:
> > Michael reported soft lockups on a system that has unaccepted memory.
> > This occurs when a user attempts to allocate and accept memory on
> > multiple CPUs simultaneously.
> > 
> > The root cause of the issue is that memory acceptance is serialized with
> > a spinlock, allowing only one CPU to accept memory at a time. The other
> > CPUs spin and wait for their turn, leading to starvation and soft lockup
> > reports.
> > 
> > To address this, the code has been modified to release the spinlock
> > while accepting memory. This allows for parallel memory acceptance on
> > multiple CPUs.
> > 
> > A newly introduced "accepting_list" keeps track of which memory is
> > currently being accepted. This is necessary to prevent parallel
> > acceptance of the same memory block. If a collision occurs, the lock is
> > released and the process is retried.
> > 
> > Such collisions should rarely occur. The main path for memory acceptance
> > is the page allocator, which accepts memory in MAX_ORDER chunks. As long
> > as MAX_ORDER is equal to or larger than the unit_size, collisions will
> > never occur because the caller fully owns the memory block being
> > accepted.
> > 
> > Aside from the page allocator, only memblock and deferered_free_range()
> > accept memory, but this only happens during boot.
> > 
> > The code has been tested with unit_size == 128MiB to trigger collisions
> > and validate the retry codepath.
> > 
> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > Reported-by: Michael Roth <michael.roth@amd.com
> > Fixes: 2053bc57f367 ("efi: Add unaccepted memory support")
> > Cc: <stable@kernel.org>
> > ---
> >  drivers/firmware/efi/unaccepted_memory.c | 55 ++++++++++++++++++++++--
> >  1 file changed, 51 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/firmware/efi/unaccepted_memory.c b/drivers/firmware/efi/unaccepted_memory.c
> > index 853f7dc3c21d..8af0306c8e5c 100644
> > --- a/drivers/firmware/efi/unaccepted_memory.c
> > +++ b/drivers/firmware/efi/unaccepted_memory.c
> > @@ -5,9 +5,17 @@
> >  #include <linux/spinlock.h>
> >  #include <asm/unaccepted_memory.h>
> >  
> > -/* Protects unaccepted memory bitmap */
> > +/* Protects unaccepted memory bitmap and accepting_list */
> >  static DEFINE_SPINLOCK(unaccepted_memory_lock);
> >  
> > +struct accept_range {
> > +	struct list_head list;
> > +	unsigned long start;
> > +	unsigned long end;
> > +};
> > +
> > +static LIST_HEAD(accepting_list);
> > +
> >  /*
> >   * accept_memory() -- Consult bitmap and accept the memory if needed.
> >   *
> > @@ -24,6 +32,7 @@ void accept_memory(phys_addr_t start, phys_addr_t end)
> >  {
> >  	struct efi_unaccepted_memory *unaccepted;
> >  	unsigned long range_start, range_end;
> > +	struct accept_range range, *entry;
> >  	unsigned long flags;
> >  	u64 unit_size;
> >  
> > @@ -78,20 +87,58 @@ void accept_memory(phys_addr_t start, phys_addr_t end)
> >  	if (end > unaccepted->size * unit_size * BITS_PER_BYTE)
> >  		end = unaccepted->size * unit_size * BITS_PER_BYTE;
> >  
> > -	range_start = start / unit_size;
> > -
> > +	range.start = start / unit_size;
> > +	range.end = DIV_ROUND_UP(end, unit_size);
> > +retry:
> >  	spin_lock_irqsave(&unaccepted_memory_lock, flags);
> > +
> > +	/*
> > +	 * Check if anybody works on accepting the same range of the memory.
> > +	 *
> > +	 * The check with unit_size granularity. It is crucial to catch all
> 
> "The check is done ..." ?

Yep.

> > +	 * accept requests to the same unit_size block, even if they don't
> > +	 * overlap on physical address level.
> > +	 */
> > +	list_for_each_entry(entry, &accepting_list, list) {
> > +		if (entry->end < range.start)
> > +			continue;
> > +		if (entry->start >= range.end)
> > +			continue;
> 
> Hmm we really don't have a macro for ranges_intersect()? Given how easy is
> to make a mistake. I found only zone_intersects().

I don't know any.

> > +
> > +		/*
> > +		 * Somebody else accepting the range. Or at least part of it.
> > +		 *
> > +		 * Drop the lock and retry until it is complete.
> > +		 */
> > +		spin_unlock_irqrestore(&unaccepted_memory_lock, flags);
> > +		cond_resched();
> > +		goto retry;
> > +	}
> > +
> > +	/*
> > +	 * Register that the range is about to be accepted.
> > +	 * Make sure nobody else will accept it.
> > +	 */
> > +	list_add(&range.list, &accepting_list);
> > +
> > +	range_start = range.start;
> >  	for_each_set_bitrange_from(range_start, range_end, unaccepted->bitmap,
> > -				   DIV_ROUND_UP(end, unit_size)) {
> > +				   range.end) {
> >  		unsigned long phys_start, phys_end;
> >  		unsigned long len = range_end - range_start;
> >  
> >  		phys_start = range_start * unit_size + unaccepted->phys_base;
> >  		phys_end = range_end * unit_size + unaccepted->phys_base;
> >  
> > +		spin_unlock_irqrestore(&unaccepted_memory_lock, flags);
> 
> Hm so this is bad, AFAICS. We enable IRQs, then an IRQ can come and try to
> accept in the same unit_size block, so it will keep the retrying by the goto
> above and itself have irqs disabled so the cond_resched() will never let us
> finish?

Good catch. Will fix in the next version.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
