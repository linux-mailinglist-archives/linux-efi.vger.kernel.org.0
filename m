Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98FEE74743A
	for <lists+linux-efi@lfdr.de>; Tue,  4 Jul 2023 16:37:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbjGDOhx (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 4 Jul 2023 10:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbjGDOhw (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 4 Jul 2023 10:37:52 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26F98E47;
        Tue,  4 Jul 2023 07:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688481471; x=1720017471;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3uPK0lQLnODbW5urZpqsXqNoSRHmvwzicJIhGoLTkFM=;
  b=bMFyR4O3Z5LBVuHSyrXZ+TJeLTUe79bo2t8i+ccei59ckkZoDMNo9nlh
   ffmcMDQEDKZlFp1L5B693nZA1Ya1EZD/RStfuf7+1NHA1h3ypjjn1zKu9
   Fw2YuPhFuBUKxVdA2mZFRSeK8A9AM4cAS07K+IUirGCj2n78mb/2Ym5L1
   CpORi+LTssTHoYyWQs3AoItP7LyIfLcC5KjloYgvbWmjy43ojusqoAJ18
   +xBb9BVDEgjVYKuVA+yV+fQEWWokTPixaO8c+RyD9y1KtvTEwsUhpzmsW
   gePdoSz8bPlkWFnTMrbXmZQyfucn9fQtu/bydy24nFq7E96yZ1Rw9DqM7
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="343469398"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="343469398"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2023 07:37:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="718940604"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="718940604"
Received: from posikoya-mobl2.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.49.196])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2023 07:37:41 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 27C2A10A08E; Tue,  4 Jul 2023 17:37:40 +0300 (+03)
Date:   Tue, 4 Jul 2023 17:37:40 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Mel Gorman <mgorman@techsingularity.net>
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
Message-ID: <20230704143740.bgimyg3bqsgxbm47@box.shutemov.name>
References: <20230606142637.5171-1-kirill.shutemov@linux.intel.com>
 <20230606142637.5171-6-kirill.shutemov@linux.intel.com>
 <20230703132518.3ukqyolnes47i5r3@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230703132518.3ukqyolnes47i5r3@techsingularity.net>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Jul 03, 2023 at 02:25:18PM +0100, Mel Gorman wrote:
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
> 
> By and large, this looks ok from the page allocator perspective as the
> checks for unaccepted are mostly after watermark checks. However, if you
> look in the initial fast path, you'll see this
> 
>         /* 
>          * Forbid the first pass from falling back to types that fragment
>          * memory until all local zones are considered.
>          */     
>         alloc_flags |= alloc_flags_nofragment(ac.preferred_zoneref->zone, gfp);
> 
> While checking watermarks should be fine from a functional perspective and
> the fast paths are unaffected, there is a risk of premature fragmentation
> until all memory has been accepted. Meeting watermarks does not necessarily
> mean that fragmentation is avoided as pageblocks can get mixed while still
> meeting watermarks.

Could you elaborate on this scenario?

Current code checks the watermark, if it is met, try rmqueue().

If rmqueue() fails anyway, try to accept more pages and retry the zone if
it is successful.

I'm not sure how we can get to the 'if (no_fallback) {' case with any
unaccepted memory in the allowed zones.

I see that there's preferred_zoneref and spread_dirty_pages cases, but
unaccepted memory seems change nothing for them.

Hm?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
