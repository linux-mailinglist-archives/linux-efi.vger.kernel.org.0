Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C6677C85D8
	for <lists+linux-efi@lfdr.de>; Fri, 13 Oct 2023 14:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231548AbjJMMeN (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 13 Oct 2023 08:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231241AbjJMMeM (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 13 Oct 2023 08:34:12 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 380C0A9;
        Fri, 13 Oct 2023 05:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697200451; x=1728736451;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fGrVnxZmpyfEBqkF7piZXz/mFn6UmaNoaPJzfrOU+hs=;
  b=E+4Trx1lgbtY2WHWLk0Je/JAxFjCBhMJkmdjRYB2JGESbNg6x59KgsI+
   851mgsfnjJDOyXD0qAIajccM57rSJCwzDwjaJuBcX09WJpNXoF7jP9uMz
   xErR1cHhXEk+GCcuSqqUjEohLfsrt3wP4YyZNENFHTQ5FkkIZGYTsQkW5
   jUxSSWQFuNvUXNvO4Vk/iiDpoGm66lNRN1n2dgJrxtwP3bfVGaIQL3sJh
   W3N6YHu7S6l7rhgbRShHw0/MUugjWGmStAqY0L75X6g6duOVFbpCL8S+y
   LtgF7Tl3fkFB5Ih6vLntzsjNuv7xCUEaIVIlKWeRkk0yBfdhqArNostPJ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10862"; a="364536435"
X-IronPort-AV: E=Sophos;i="6.03,222,1694761200"; 
   d="scan'208";a="364536435"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2023 05:34:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10862"; a="1086128325"
X-IronPort-AV: E=Sophos;i="6.03,222,1694761200"; 
   d="scan'208";a="1086128325"
Received: from bgras-mobl1.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.59.145])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2023 05:34:01 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 6E30C104A05; Fri, 13 Oct 2023 15:33:58 +0300 (+03)
Date:   Fri, 13 Oct 2023 15:33:58 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Michael Roth <michael.roth@amd.com>
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
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv14 5/9] efi: Add unaccepted memory support
Message-ID: <20231013123358.y4pcdp5fgtt4ax6g@box.shutemov.name>
References: <20230606142637.5171-1-kirill.shutemov@linux.intel.com>
 <20230606142637.5171-6-kirill.shutemov@linux.intel.com>
 <20231010210518.jguawj7bscwgvszv@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231010210518.jguawj7bscwgvszv@amd.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Oct 10, 2023 at 04:05:18PM -0500, Michael Roth wrote:
> On Tue, Jun 06, 2023 at 05:26:33PM +0300, Kirill A. Shutemov wrote:
> > efi_config_parse_tables() reserves memory that holds unaccepted memory
> > configuration table so it won't be reused by page allocator.
> > 
> > Core-mm requires few helpers to support unaccepted memory:
> > 
> >  - accept_memory() checks the range of addresses against the bitmap and
> >    accept memory if needed.
> > 
> >  - range_contains_unaccepted_memory() checks if anything within the
> >    range requires acceptance.
> > 
> > Architectural code has to provide efi_get_unaccepted_table() that
> > returns pointer to the unaccepted memory configuration table.
> > 
> > arch_accept_memory() handles arch-specific part of memory acceptance.
> > 
> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
> > Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
> > ---
> >  arch/x86/platform/efi/efi.c              |   3 +
> >  drivers/firmware/efi/Makefile            |   1 +
> >  drivers/firmware/efi/efi.c               |  25 +++++
> >  drivers/firmware/efi/unaccepted_memory.c | 112 +++++++++++++++++++++++
> >  include/linux/efi.h                      |   1 +
> >  5 files changed, 142 insertions(+)
> >  create mode 100644 drivers/firmware/efi/unaccepted_memory.c
> > 
> > diff --git a/drivers/firmware/efi/unaccepted_memory.c b/drivers/firmware/efi/unaccepted_memory.c
> > new file mode 100644
> > index 000000000000..08a9a843550a
> > --- /dev/null
> > +++ b/drivers/firmware/efi/unaccepted_memory.c
> > @@ -0,0 +1,112 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +
> > +#include <linux/efi.h>
> > +#include <linux/memblock.h>
> > +#include <linux/spinlock.h>
> > +#include <asm/unaccepted_memory.h>
> > +
> > +/* Protects unaccepted memory bitmap */
> > +static DEFINE_SPINLOCK(unaccepted_memory_lock);
> > +
> > +/*
> > + * accept_memory() -- Consult bitmap and accept the memory if needed.
> > + *
> > + * Only memory that is explicitly marked as unaccepted in the bitmap requires
> > + * an action. All the remaining memory is implicitly accepted and doesn't need
> > + * acceptance.
> > + *
> > + * No need to accept:
> > + *  - anything if the system has no unaccepted table;
> > + *  - memory that is below phys_base;
> > + *  - memory that is above the memory that addressable by the bitmap;
> > + */
> > +void accept_memory(phys_addr_t start, phys_addr_t end)
> > +{
> > +	struct efi_unaccepted_memory *unaccepted;
> > +	unsigned long range_start, range_end;
> > +	unsigned long flags;
> > +	u64 unit_size;
> > +
> > +	unaccepted = efi_get_unaccepted_table();
> > +	if (!unaccepted)
> > +		return;
> > +
> > +	unit_size = unaccepted->unit_size;
> > +
> > +	/*
> > +	 * Only care for the part of the range that is represented
> > +	 * in the bitmap.
> > +	 */
> > +	if (start < unaccepted->phys_base)
> > +		start = unaccepted->phys_base;
> > +	if (end < unaccepted->phys_base)
> > +		return;
> > +
> > +	/* Translate to offsets from the beginning of the bitmap */
> > +	start -= unaccepted->phys_base;
> > +	end -= unaccepted->phys_base;
> > +
> > +	/* Make sure not to overrun the bitmap */
> > +	if (end > unaccepted->size * unit_size * BITS_PER_BYTE)
> > +		end = unaccepted->size * unit_size * BITS_PER_BYTE;
> > +
> > +	range_start = start / unit_size;
> > +
> > +	spin_lock_irqsave(&unaccepted_memory_lock, flags);
> > +	for_each_set_bitrange_from(range_start, range_end, unaccepted->bitmap,
> > +				   DIV_ROUND_UP(end, unit_size)) {
> > +		unsigned long phys_start, phys_end;
> > +		unsigned long len = range_end - range_start;
> > +
> > +		phys_start = range_start * unit_size + unaccepted->phys_base;
> > +		phys_end = range_end * unit_size + unaccepted->phys_base;
> > +
> > +		arch_accept_memory(phys_start, phys_end);
> > +		bitmap_clear(unaccepted->bitmap, range_start, len);
> > +	}
> > +	spin_unlock_irqrestore(&unaccepted_memory_lock, flags);
> > +}
> 
> While testing SNP guests running today's tip/master (ef19bc9dddc3) I ran
> into what seems to be fairly significant lock contention due to the
> unaccepted_memory_lock spinlock above, which results in a constant stream
> of soft-lockups until the workload gets all its memory accepted/faulted
> in if the guest has around 16+ vCPUs.
> 
> I've included the guest dmesg traces I was seeing below.
> 
> In this case I was running a 32 vCPU guest with 200GB of memory running on
> a 256 thread EPYC (Milan) system, and can trigger the above situation fairly
> reliably by running the following workload in a freshly-booted guests:
> 
>   stress --vm 32 --vm-bytes 5G --vm-keep
> 
> Scaling up the number of stress threads and vCPUs should make it easier
> to reproduce.
> 
> Other than unresponsiveness/lockup messages until the memory is accepted,
> the guest seems to continue running fine, but for large guests where
> unaccepted memory is more likely to be useful, it seems like it could be
> an issue, especially when consider 100+ vCPU guests.

Okay, sorry for delay. It took time to reproduce it with TDX.

I will look what can be done.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
