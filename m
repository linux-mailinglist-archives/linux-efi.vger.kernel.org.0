Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E5C57C8B4B
	for <lists+linux-efi@lfdr.de>; Fri, 13 Oct 2023 18:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231847AbjJMQWu (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 13 Oct 2023 12:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231713AbjJMQWa (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 13 Oct 2023 12:22:30 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 750511FF6;
        Fri, 13 Oct 2023 09:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697214141; x=1728750141;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8HZ1k3AcAih4bSHLM8xODeQ0GJIR0iLWB3qxJlRJllM=;
  b=VukHdDA8gkSHlUyex6ih6FP81pLC+Q/OP7XxkUf/C4+En7DwLVLrlTVR
   Th+UYUocpzFT8EJFQhxG7m7ldCDIYN+6x2qgQjyTdXx3rUjiZmBeb+2XP
   s5TAiZBmlbJTgZ2XeqhMo9GObLz9XZxdyymEbIcUskmwYqPGDRUwiDFxD
   CeXpA03jE8DxUvRnjuV8W9s7q1mwN70bDDr/0fZtBWzA2C/AanndBMUap
   TAcGZUg+al1wapvsjtCpZI5RrBdwwpHLu5IvKDfuqru164/uCuinCsF/3
   z88VeXIqns2Wh9iVLyTB1IAEgaReJ5T9WqbBbSB/lthNHGBdJr8Tzb+EF
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10862"; a="382440262"
X-IronPort-AV: E=Sophos;i="6.03,222,1694761200"; 
   d="scan'208";a="382440262"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2023 09:22:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10862"; a="1002002017"
X-IronPort-AV: E=Sophos;i="6.03,222,1694761200"; 
   d="scan'208";a="1002002017"
Received: from bgras-mobl1.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.59.145])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2023 09:22:12 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 2F9D3104A05; Fri, 13 Oct 2023 19:22:10 +0300 (+03)
Date:   Fri, 13 Oct 2023 19:22:10 +0300
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
Message-ID: <20231013162210.bqepgz6wnh7uohqq@box>
References: <20230606142637.5171-1-kirill.shutemov@linux.intel.com>
 <20230606142637.5171-6-kirill.shutemov@linux.intel.com>
 <20231010210518.jguawj7bscwgvszv@amd.com>
 <20231013123358.y4pcdp5fgtt4ax6g@box.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231013123358.y4pcdp5fgtt4ax6g@box.shutemov.name>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Oct 13, 2023 at 03:33:58PM +0300, Kirill A. Shutemov wrote:
> > While testing SNP guests running today's tip/master (ef19bc9dddc3) I ran
> > into what seems to be fairly significant lock contention due to the
> > unaccepted_memory_lock spinlock above, which results in a constant stream
> > of soft-lockups until the workload gets all its memory accepted/faulted
> > in if the guest has around 16+ vCPUs.
> > 
> > I've included the guest dmesg traces I was seeing below.
> > 
> > In this case I was running a 32 vCPU guest with 200GB of memory running on
> > a 256 thread EPYC (Milan) system, and can trigger the above situation fairly
> > reliably by running the following workload in a freshly-booted guests:
> > 
> >   stress --vm 32 --vm-bytes 5G --vm-keep
> > 
> > Scaling up the number of stress threads and vCPUs should make it easier
> > to reproduce.
> > 
> > Other than unresponsiveness/lockup messages until the memory is accepted,
> > the guest seems to continue running fine, but for large guests where
> > unaccepted memory is more likely to be useful, it seems like it could be
> > an issue, especially when consider 100+ vCPU guests.
> 
> Okay, sorry for delay. It took time to reproduce it with TDX.
> 
> I will look what can be done.

Could you check if the patch below helps?

diff --git a/drivers/firmware/efi/unaccepted_memory.c b/drivers/firmware/efi/unaccepted_memory.c
index 853f7dc3c21d..591da3f368fa 100644
--- a/drivers/firmware/efi/unaccepted_memory.c
+++ b/drivers/firmware/efi/unaccepted_memory.c
@@ -8,6 +8,14 @@
 /* Protects unaccepted memory bitmap */
 static DEFINE_SPINLOCK(unaccepted_memory_lock);
 
+struct accept_range {
+	struct list_head list;
+	unsigned long start;
+	unsigned long end;
+};
+
+static LIST_HEAD(accepting_list);
+
 /*
  * accept_memory() -- Consult bitmap and accept the memory if needed.
  *
@@ -24,6 +32,7 @@ void accept_memory(phys_addr_t start, phys_addr_t end)
 {
 	struct efi_unaccepted_memory *unaccepted;
 	unsigned long range_start, range_end;
+	struct accept_range range, *entry;
 	unsigned long flags;
 	u64 unit_size;
 
@@ -80,7 +89,25 @@ void accept_memory(phys_addr_t start, phys_addr_t end)
 
 	range_start = start / unit_size;
 
+	range.start = start;
+	range.end = end;
+retry:
 	spin_lock_irqsave(&unaccepted_memory_lock, flags);
+
+	list_for_each_entry(entry, &accepting_list, list) {
+		if (entry->end < start)
+			continue;
+		if (entry->start > end)
+			continue;
+		spin_unlock_irqrestore(&unaccepted_memory_lock, flags);
+
+		/* Somebody else accepting the range */
+		cpu_relax();
+		goto retry;
+	}
+
+	list_add(&range.list, &accepting_list);
+
 	for_each_set_bitrange_from(range_start, range_end, unaccepted->bitmap,
 				   DIV_ROUND_UP(end, unit_size)) {
 		unsigned long phys_start, phys_end;
@@ -89,9 +116,15 @@ void accept_memory(phys_addr_t start, phys_addr_t end)
 		phys_start = range_start * unit_size + unaccepted->phys_base;
 		phys_end = range_end * unit_size + unaccepted->phys_base;
 
+		spin_unlock_irqrestore(&unaccepted_memory_lock, flags);
+
 		arch_accept_memory(phys_start, phys_end);
+
+		spin_lock_irqsave(&unaccepted_memory_lock, flags);
 		bitmap_clear(unaccepted->bitmap, range_start, len);
 	}
+
+	list_del(&range.list);
 	spin_unlock_irqrestore(&unaccepted_memory_lock, flags);
 }
 
-- 
  Kiryl Shutsemau / Kirill A. Shutemov
