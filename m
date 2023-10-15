Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CAC17C9ADF
	for <lists+linux-efi@lfdr.de>; Sun, 15 Oct 2023 20:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbjJOSxF (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 15 Oct 2023 14:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjJOSxE (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 15 Oct 2023 14:53:04 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34205A9;
        Sun, 15 Oct 2023 11:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697395983; x=1728931983;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=452iiupu1odqW6I+HChLA99o8E7DPv+HDaY8t/F97ZU=;
  b=f0kOjvvAEvugyCW3nhkWJn/5z8uuPVd7rOm8PuKyDseNpHMWTr1CPSgJ
   ZVxlAkPBB291HH+jitUZmz6um+dNXi6vevJiWmblvQJshvLX7AUbwXRYU
   5ye2eotgn0iLMR2yLvxz7hJFwtmllW9Bxq1jPXyDlRiEY4MghncRKAYlN
   DZCv3hXpz9Ps4VdWaHmTwNAPY/X9zubqtkGw9vvhoIIVHsADn1PIBF70/
   +3Rc25RCjcYvjddxuEw0b/QQPIuCsO3wDi7HNqJJV3jrjz75r/mAoM90l
   44ZA4HVQ5XhpAM2TBhS2yJeOKacuV+ACxL8wEYcrGB34orNrq+y5JxK3z
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="385248199"
X-IronPort-AV: E=Sophos;i="6.03,226,1694761200"; 
   d="scan'208";a="385248199"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2023 11:53:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="790561121"
X-IronPort-AV: E=Sophos;i="6.03,226,1694761200"; 
   d="scan'208";a="790561121"
Received: from bmihaile-mobl1.ger.corp.intel.com (HELO box.shutemov.name) ([10.249.37.165])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2023 11:52:54 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id BD735109D0A; Sun, 15 Oct 2023 21:52:51 +0300 (+03)
Date:   Sun, 15 Oct 2023 21:52:51 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Nikolay Borisov <nik.borisov@suse.com>
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
        Mel Gorman <mgorman@techsingularity.net>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        aarcange@redhat.com, peterx@redhat.com, x86@kernel.org,
        linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@kernel.org
Subject: Re: [PATCH] efi/unaccepted: Fix soft lockups caused by parallel
 memory acceptance
Message-ID: <20231015185251.umkdsr7jx2qrlm2x@box.shutemov.name>
References: <20231014204040.28765-1-kirill.shutemov@linux.intel.com>
 <d745361e-2867-4f3c-bd41-714c7a382910@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d745361e-2867-4f3c-bd41-714c7a382910@suse.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sun, Oct 15, 2023 at 08:02:16PM +0300, Nikolay Borisov wrote:
> 
> 
> On 14.10.23 г. 23:40 ч., Kirill A. Shutemov wrote:
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
> >   drivers/firmware/efi/unaccepted_memory.c | 55 ++++++++++++++++++++++--
> >   1 file changed, 51 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/firmware/efi/unaccepted_memory.c b/drivers/firmware/efi/unaccepted_memory.c
> > index 853f7dc3c21d..8af0306c8e5c 100644
> > --- a/drivers/firmware/efi/unaccepted_memory.c
> > +++ b/drivers/firmware/efi/unaccepted_memory.c
> > @@ -5,9 +5,17 @@
> >   #include <linux/spinlock.h>
> >   #include <asm/unaccepted_memory.h>
> > -/* Protects unaccepted memory bitmap */
> > +/* Protects unaccepted memory bitmap and accepting_list */
> >   static DEFINE_SPINLOCK(unaccepted_memory_lock);
> > +struct accept_range {
> > +	struct list_head list;
> > +	unsigned long start;
> > +	unsigned long end;
> > +};
> > +
> > +static LIST_HEAD(accepting_list);
> > +
> >   /*
> >    * accept_memory() -- Consult bitmap and accept the memory if needed.
> >    *
> > @@ -24,6 +32,7 @@ void accept_memory(phys_addr_t start, phys_addr_t end)
> >   {
> >   	struct efi_unaccepted_memory *unaccepted;
> >   	unsigned long range_start, range_end;
> > +	struct accept_range range, *entry;
> >   	unsigned long flags;
> >   	u64 unit_size;
> > @@ -78,20 +87,58 @@ void accept_memory(phys_addr_t start, phys_addr_t end)
> >   	if (end > unaccepted->size * unit_size * BITS_PER_BYTE)
> >   		end = unaccepted->size * unit_size * BITS_PER_BYTE;
> > -	range_start = start / unit_size;
> > -
> > +	range.start = start / unit_size;
> > +	range.end = DIV_ROUND_UP(end, unit_size);
> > +retry:
> >   	spin_lock_irqsave(&unaccepted_memory_lock, flags);
> > +
> > +	/*
> > +	 * Check if anybody works on accepting the same range of the memory.
> > +	 *
> > +	 * The check with unit_size granularity. It is crucial to catch all
> > +	 * accept requests to the same unit_size block, even if they don't
> > +	 * overlap on physical address level.
> > +	 */
> > +	list_for_each_entry(entry, &accepting_list, list) {
> > +		if (entry->end < range.start)
> > +			continue;
> > +		if (entry->start >= range.end)
> > +			continue;
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
> 
> So this works for the cases where we have concurrent acceptance of the same
> range. What about the same range being accepted multiple times, one after
> the other, the current code doesn't prevent this.

That's why we have the bitmap. The bits got cleared there after the first
accept. On the second, attempt for_each_set_bitrange_from() will skip the
range.

> What if you check whether the current range is fully contained within the
> duplicate entry and if it's fully covered simply return ?

If it is fully covered we still need to wait until somebody else finish
the accept, so we cannot "just return".

We can try to return if we saw the range on accepting_list list before,
but it is disappeared, indicating that accept has been completed.

But I don't think this optimization worthwhile. As I mentioned before, the
collision is hardly happens. One more spin and bitmap check would not make
a difference. And it adds complexity.


> 
> > +
> > +	/*
> > +	 * Register that the range is about to be accepted.
> > +	 * Make sure nobody else will accept it.
> > +	 */
> > +	list_add(&range.list, &accepting_list);
> > +
> > +	range_start = range.start;
> >   	for_each_set_bitrange_from(range_start, range_end, unaccepted->bitmap,
> > -				   DIV_ROUND_UP(end, unit_size)) {
> > +				   range.end) {
> >   		unsigned long phys_start, phys_end;
> >   		unsigned long len = range_end - range_start;
> >   		phys_start = range_start * unit_size + unaccepted->phys_base;
> >   		phys_end = range_end * unit_size + unaccepted->phys_base;
> > +		spin_unlock_irqrestore(&unaccepted_memory_lock, flags);
> > +
> >   		arch_accept_memory(phys_start, phys_end);
> > +
> > +		spin_lock_irqsave(&unaccepted_memory_lock, flags);
> >   		bitmap_clear(unaccepted->bitmap, range_start, len);
> >   	}
> > +
> > +	list_del(&range.list);
> >   	spin_unlock_irqrestore(&unaccepted_memory_lock, flags);
> >   }

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
