Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BAEA7C8DF1
	for <lists+linux-efi@lfdr.de>; Fri, 13 Oct 2023 21:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231468AbjJMTxO (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 13 Oct 2023 15:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjJMTxM (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 13 Oct 2023 15:53:12 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 899BB95;
        Fri, 13 Oct 2023 12:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697226791; x=1728762791;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WUbXHiuNIDBF/soxOsDV9IEi1qCavQt59cgdlaj68XY=;
  b=jH4lUspTRSDdzttfvvTqiZBHgejAgiaG+cQW8MeeRtMs3CoPJbodEm9p
   qFXDD0i8FFjxonxw/wjq+olUPBABxbY1DW1jC0aWrRIci7vDTRMf2FK41
   dRLlo9BXMxrTmEp9bqFUoV1jKZeTtVILvalOj6I4QZ/9UPJ33SXpF2afj
   hW8sPUvIr+uRfYa48rXX9KXUTqC+U0nPK0+K23WSHHlQo931hzsbhVsrS
   O5dG+I6znLcsMYQfAIWV6+/swu5GdDvlYiFtK3CoOub0oNgNV5H7eQEBP
   aqZp8Pdg3Kj4QztLIUGYIjOdxLENhh3AiNl5zWmHdu4yByqh7X4ED5KaT
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10862"; a="365518464"
X-IronPort-AV: E=Sophos;i="6.03,223,1694761200"; 
   d="scan'208";a="365518464"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2023 12:53:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10862"; a="878632703"
X-IronPort-AV: E=Sophos;i="6.03,223,1694761200"; 
   d="scan'208";a="878632703"
Received: from bgras-mobl1.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.59.145])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2023 12:53:02 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 21E7A104A05; Fri, 13 Oct 2023 22:53:00 +0300 (+03)
Date:   Fri, 13 Oct 2023 22:53:00 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     Michael Roth <michael.roth@amd.com>,
        Borislav Petkov <bp@alien8.de>,
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
        Vlastimil Babka <vbabka@suse.cz>,
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
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv14 5/9] efi: Add unaccepted memory support
Message-ID: <20231013195300.cqv6dfdprr3givdr@box>
References: <20230606142637.5171-1-kirill.shutemov@linux.intel.com>
 <20230606142637.5171-6-kirill.shutemov@linux.intel.com>
 <20231010210518.jguawj7bscwgvszv@amd.com>
 <20231013123358.y4pcdp5fgtt4ax6g@box.shutemov.name>
 <20231013162210.bqepgz6wnh7uohqq@box>
 <3577c8a5-3f88-45b8-9b41-2fb5cb6dc53a@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3577c8a5-3f88-45b8-9b41-2fb5cb6dc53a@amd.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Oct 13, 2023 at 12:45:20PM -0500, Tom Lendacky wrote:
> On 10/13/23 11:22, Kirill A. Shutemov wrote:
> > On Fri, Oct 13, 2023 at 03:33:58PM +0300, Kirill A. Shutemov wrote:
> > > > While testing SNP guests running today's tip/master (ef19bc9dddc3) I ran
> > > > into what seems to be fairly significant lock contention due to the
> > > > unaccepted_memory_lock spinlock above, which results in a constant stream
> > > > of soft-lockups until the workload gets all its memory accepted/faulted
> > > > in if the guest has around 16+ vCPUs.
> > > > 
> > > > I've included the guest dmesg traces I was seeing below.
> > > > 
> > > > In this case I was running a 32 vCPU guest with 200GB of memory running on
> > > > a 256 thread EPYC (Milan) system, and can trigger the above situation fairly
> > > > reliably by running the following workload in a freshly-booted guests:
> > > > 
> > > >    stress --vm 32 --vm-bytes 5G --vm-keep
> > > > 
> > > > Scaling up the number of stress threads and vCPUs should make it easier
> > > > to reproduce.
> > > > 
> > > > Other than unresponsiveness/lockup messages until the memory is accepted,
> > > > the guest seems to continue running fine, but for large guests where
> > > > unaccepted memory is more likely to be useful, it seems like it could be
> > > > an issue, especially when consider 100+ vCPU guests.
> > > 
> > > Okay, sorry for delay. It took time to reproduce it with TDX.
> > > 
> > > I will look what can be done.
> > 
> > Could you check if the patch below helps?
> > 
> > diff --git a/drivers/firmware/efi/unaccepted_memory.c b/drivers/firmware/efi/unaccepted_memory.c
> > index 853f7dc3c21d..591da3f368fa 100644
> > --- a/drivers/firmware/efi/unaccepted_memory.c
> > +++ b/drivers/firmware/efi/unaccepted_memory.c
> > @@ -8,6 +8,14 @@
> >   /* Protects unaccepted memory bitmap */
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
> > @@ -80,7 +89,25 @@ void accept_memory(phys_addr_t start, phys_addr_t end)
> >   	range_start = start / unit_size;
> > +	range.start = start;
> > +	range.end = end;
> > +retry:
> >   	spin_lock_irqsave(&unaccepted_memory_lock, flags);
> > +
> > +	list_for_each_entry(entry, &accepting_list, list) {
> > +		if (entry->end < start)
> > +			continue;
> > +		if (entry->start > end)
> 
> Should this be a >= check since start and end are page aligned values?

Right. Good catch.

> > +			continue;
> > +		spin_unlock_irqrestore(&unaccepted_memory_lock, flags);
> > +
> > +		/* Somebody else accepting the range */
> > +		cpu_relax();
> > +		goto retry;
> 
> Could you set some kind of flag here so that ...
> 
> > +	}
> > +
> 
> ... once you get here, that means that area was accepted and removed from
> the list, so I think you could just drop the lock and exit now, right?
> Because at that point the bitmap will have been updated and you wouldn't be
> accepting any memory anyway?

No. Consider the case if someone else accept part of the range you are
accepting.

I guess we can check if the range on the list covers what we are accepting
fully, but it complication. Checking bitmap at this point is cheap enough:
we already hold the lock.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
