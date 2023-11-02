Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C031F7DF464
	for <lists+linux-efi@lfdr.de>; Thu,  2 Nov 2023 14:56:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbjKBN4c (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 2 Nov 2023 09:56:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbjKBN43 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 2 Nov 2023 09:56:29 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0A28A6;
        Thu,  2 Nov 2023 06:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698933383; x=1730469383;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TdsHsMA7CiZ4zuc20AAZXAmmV5t7rmocsbstMG+zpxY=;
  b=XIoqOl5eHS0unkSt7v5oeJwQafGo+pvwxRpDa0FBfIWbLCs6eRLUqkXB
   H0vyJRfb0L6q303f8mbY0GCM9/5ebCojS1Sy8Qkf0IiwbNJlFVeA5lXCX
   dubvHu4W2fHoWES0jhvsZ05S1FTDJcLEzl3N4qP/F/j4mh1mNWVCzO9QC
   b7fFV90/hHF9ZHoNWDdQ1jKh2yvwzFQHCEzI7rozfum3kf80TpLbo+bRK
   FiiX03ptprXmhYQMX0PPwVZaw57cMkWqjxNAzqsFm4VouAvnLPFTb/mS1
   R4ChoYtL/3u11S+v/MFiFbTvLTV0fvMODNivy5K4vhecZX0GQxdsDqivF
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="368058969"
X-IronPort-AV: E=Sophos;i="6.03,271,1694761200"; 
   d="scan'208";a="368058969"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 06:56:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,271,1694761200"; 
   d="scan'208";a="8997684"
Received: from arajan-mobl.amr.corp.intel.com (HELO box.shutemov.name) ([10.251.215.101])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 06:56:15 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 0B33910A312; Thu,  2 Nov 2023 16:56:12 +0300 (+03)
Date:   Thu, 2 Nov 2023 16:56:11 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Michael Roth <michael.roth@amd.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
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
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        philip.cox@canonical.com, aarcange@redhat.com, peterx@redhat.com,
        x86@kernel.org, linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@kernel.org, Nikolay Borisov <nik.borisov@suse.com>,
        Bandan Das <bsd@redhat.com>
Subject: Re: [PATCHv2] efi/unaccepted: Fix soft lockups caused by parallel
 memory acceptance
Message-ID: <20231102135611.lyiu2lss2csswgch@box.shutemov.name>
References: <20231016163122.12855-1-kirill.shutemov@linux.intel.com>
 <20231016205419.c3sfriemyaiczxie@amd.com>
 <3ccb822e-fc46-3087-d6ad-2f754dcf218c@suse.cz>
 <20231101004523.vseyi5bezgfaht5i@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231101004523.vseyi5bezgfaht5i@amd.com>
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Oct 31, 2023 at 07:45:23PM -0500, Michael Roth wrote:
> > If you mean the guest has as many cpus as the host provides to it, but you
> > stress with many more than that number of processes, then I wonder how
> 
> Yes, this is what I meant. If there are more memory-hog worker threads in
> the guest than there are vCPUs, I'm better able to reproduce soft-lockups.
> That sort of makes sense since those threads will spend more time waiting on
> an available vCPU to handle memory acceptance.
> 
> But it actually isn't a requirement, I've also been able to reproduce this
> with equal numbers of worker threads and vCPUs if I run 4 VMs, each
> running the stress/acceptance workload at the same time.
> 
> And if I force 4K pages in gmem backend (technically a supported
> configuration) then I can reproduce it much more easily since the 2MB
> acceptance path takes much longer and it makes it easier to expose any
> potential remaining concurrency issues.

This all sounds like we are solidly in "system is overloaded" territory.

Soft-lockups are still not good in this case. But I am not sure what we
can do about it.

One silly idea is to prevent all vCPUs to do accept simultaneously and
reserve one (or several) to do housekeeping. The idea is that this vCPU
can be preempted to do job on other tasks.

It would only make a difference for PREEMPT_FULL case and if the
housekeeping CPU will hit the accept path from preemptable context. And it
is obviously not applicable if there's only single vCPU.

> > softlockups would happen due to the extra processes. Since irqs are disabled
> > through the whole operation, the extra processes can't become scheduled, and
> > not being scheduled due to overloading doesn't trigger softlockups, hmm...
> 
> The soft lock-ups happen as soon as IRQs are re-enabled, either:
> 
>   a) right after a thread sees that its range intersects something
>      that's in the process of being accepted
> 
>   b) right after a thread finishes accepting its whole range and is
>      about to return from accept_memory()
> 
> I see a) occur more in the 4K test scenario, b) is more difficult to
> reproduce and seems to need a larger system to reproduce more reliably.

I am not sure why you differentiate these scenarios. Kernel just hits
place where it can be preempted and observes that it is overdue to
scheduling.

> The fact that b) seems to depend on larger systems sort of makes sense.
> When we need to covert a page to private as part of accepting it, there
> is a guest->host request that eventually goes off to host userspace which
> will call the KVM ioctl KVM_SET_MEMORY_ATTRIBUTES to mark the memory as
> private so that it will get faulted in from the guest_memfd backend. When
> this happens, any guest page faults that are currently in flight will get
> invalidated and require a retry, and there's also a guest TLB flush
> that results in an NMI to all the cores the guest was scheduled on so that
> it can exit and acknowledge new updates. So the higher the rate of
> KVM_SET_MEMORY_ATTRIBUTES the system is able to process, the higher the
> frequency of this sort of activity on the host side that can impact each
> vCPUs ability to make progress on accepting a particular range.
> 
> Also I was running 4 guests, each with as many vCPUs as the host, so
> contention for physical resources would probably be a factor as well.

Yeah, at some point you will just saturate memory bandwidth.

> I'm not sure what can be done about b), but they seem to be host-side
> optimizations that aren't too relevant to this patch, and they seem to
> occur less frequently than a), which seems to be more guest side.
> 
> Still not sure what is causing type a) lock-ups exactly, but through
> various traces and debug statements I think I've at least gotten some idea
> that there are certain conditions where the vCPUs become more and more
> dependent on each other completing certain ranges, and they spend longer
> and longer amounts of time looping through the accepting_list.
> 
> There are 3 things I've noticed that might lead to vCPUs getting hung up
> on each other:
> 
>  1) try_to_accept_memory_one() calls accept_page(page, MAX_ORDER), which
>     is a 4MB range

This should not make one vCPU to setup on work on another. Page allocator
owns full 4MB. It is not shared with anyone.

>  2) There's an extra 2MB region taken after each unit to account for
>     load_unaligned_zeropad() 

Okay, yes, this is true.

>  3) There is what appears to be a bug here:
> 
>         list_for_each_entry(entry, &accepting_list, list) {
>                 if (entry->end < range.start)
>                         continue;
>                 if (entry->start >= range.end)
>                         continue;
> 
>     where if entry->end == range.start, the thread will wait on the owner
>     of that range even though it doesn't actually intersect.

Good catch. Care to send a patch?

> I don't quite know how all this lines up to a dependency chain that would
> potentially explain the lock-ups, but to mitigate that scenario, I tried only
> adding the specific 2MB range that is being accepted to accepting_list, rather
> than the whole range, and then just iterate through 2MB at a time in
> accept_memory() instead of passing the larger range on to arch_accept_memory().

This might improve situation with soft lockups a bit, but would hurt
accept bandwidth.

> That seems to have resolved the soft lock-ups for the forced-4K scenario, but
> I haven't had much time to test larger configurations yet.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
