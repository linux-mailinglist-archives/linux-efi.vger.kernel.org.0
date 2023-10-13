Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 096777C8F9C
	for <lists+linux-efi@lfdr.de>; Fri, 13 Oct 2023 23:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbjJMVyX (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 13 Oct 2023 17:54:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjJMVyW (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 13 Oct 2023 17:54:22 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CCCDB7;
        Fri, 13 Oct 2023 14:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697234061; x=1728770061;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dltmjFDVO3vTssOWPlJg915YZex65bACfWFkwBG7/Uo=;
  b=jcXb0PWw747iZQb3w3o8zj95a6z47sdLymFrTuSjLuuN7NA7n10ZjbzQ
   gCFXTo3t/2oPKqydt6em+dVMhjKyXTU59N0ePEXgJe6cKIJcUuGyK8USV
   FUgoHjhAntNP73+TB7ySOC+W5QxYRGJMAP/tDgCtGKNanZ1lYLDrIKHKy
   F1sO3WnEnP3xlekxd8fMkqyIaxyiHHVd/2NTXfwaFSxCa8J9EWJzVxqih
   ZmTEdHlkqeRjonC0sGFxhegfwEdjtJKU1SysQCQiL8OiYBH2yTjB6Ss8x
   ujiNIMHzFdwHyiq200zJgTRxjD3BsLbF2lZQRLPpoelwNLeqTkk8mQiNh
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10862"; a="384142834"
X-IronPort-AV: E=Sophos;i="6.03,223,1694761200"; 
   d="scan'208";a="384142834"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2023 14:54:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10862"; a="784311876"
X-IronPort-AV: E=Sophos;i="6.03,223,1694761200"; 
   d="scan'208";a="784311876"
Received: from bgras-mobl1.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.59.145])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2023 14:54:13 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 9110A104350; Sat, 14 Oct 2023 00:54:10 +0300 (+03)
Date:   Sat, 14 Oct 2023 00:54:10 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Vlastimil Babka <vbabka@suse.cz>
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
Message-ID: <20231013215410.3os6d2ya7v5yu7vd@box.shutemov.name>
References: <20230606142637.5171-1-kirill.shutemov@linux.intel.com>
 <20230606142637.5171-6-kirill.shutemov@linux.intel.com>
 <20231010210518.jguawj7bscwgvszv@amd.com>
 <20231013123358.y4pcdp5fgtt4ax6g@box.shutemov.name>
 <20231013162210.bqepgz6wnh7uohqq@box>
 <34d94c58-f5f3-48eb-5833-0ef0c90cf868@suse.cz>
 <20231013172728.66pm7os3fp7laxwr@box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231013172728.66pm7os3fp7laxwr@box>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Oct 13, 2023 at 08:27:28PM +0300, Kirill A. Shutemov wrote:
> I will test the idea with larger unit_size to see how it behaves.

It indeed uncovered an issue. We need to record ranges on accepting_list
in unit_size granularity. Otherwise, we fail to stop parallel accept
requests to the same unit_size block if they don't overlap on physical
addresses.

Updated patch:

diff --git a/drivers/firmware/efi/unaccepted_memory.c b/drivers/firmware/efi/unaccepted_memory.c
index 853f7dc3c21d..8af0306c8e5c 100644
--- a/drivers/firmware/efi/unaccepted_memory.c
+++ b/drivers/firmware/efi/unaccepted_memory.c
@@ -5,9 +5,17 @@
 #include <linux/spinlock.h>
 #include <asm/unaccepted_memory.h>
 
-/* Protects unaccepted memory bitmap */
+/* Protects unaccepted memory bitmap and accepting_list */
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
 
@@ -78,20 +87,58 @@ void accept_memory(phys_addr_t start, phys_addr_t end)
 	if (end > unaccepted->size * unit_size * BITS_PER_BYTE)
 		end = unaccepted->size * unit_size * BITS_PER_BYTE;
 
-	range_start = start / unit_size;
-
+	range.start = start / unit_size;
+	range.end = DIV_ROUND_UP(end, unit_size);
+retry:
 	spin_lock_irqsave(&unaccepted_memory_lock, flags);
+
+	/*
+	 * Check if anybody works on accepting the same range of the memory.
+	 *
+	 * The check with unit_size granularity. It is crucial to catch all
+	 * accept requests to the same unit_size block, even if they don't
+	 * overlap on physical address level.
+	 */
+	list_for_each_entry(entry, &accepting_list, list) {
+		if (entry->end < range.start)
+			continue;
+		if (entry->start >= range.end)
+			continue;
+
+		/*
+		 * Somebody else accepting the range. Or at least part of it.
+		 *
+		 * Drop the lock and retry until it is complete.
+		 */
+		spin_unlock_irqrestore(&unaccepted_memory_lock, flags);
+		cond_resched();
+		goto retry;
+	}
+
+	/*
+	 * Register that the range is about to be accepted.
+	 * Make sure nobody else will accept it.
+	 */
+	list_add(&range.list, &accepting_list);
+
+	range_start = range.start;
 	for_each_set_bitrange_from(range_start, range_end, unaccepted->bitmap,
-				   DIV_ROUND_UP(end, unit_size)) {
+				   range.end) {
 		unsigned long phys_start, phys_end;
 		unsigned long len = range_end - range_start;
 
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
