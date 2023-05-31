Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08EF7718751
	for <lists+linux-efi@lfdr.de>; Wed, 31 May 2023 18:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbjEaQ1V (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 31 May 2023 12:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjEaQ1U (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 31 May 2023 12:27:20 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9B0511F;
        Wed, 31 May 2023 09:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685550437; x=1717086437;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=751fKcMvplG6/KmjKYOTWk7+Q9GXlyI46BmhatKMpyg=;
  b=kh80LPIZRUV/AA2QNwq31MisZX2ufWlvZofpe8Ud5nodpsV5ciH3hHXK
   PNJmI40bdvpPdTK3jnx2ouDmq+dGpjVivcH25ExaE1T5Lkl9EVG8vExvk
   ihaUgV8iuvVzRZNdFdD/siz3mtEH5zWch1hyAy2cH8cRpBISN6v600I+e
   jZlc+RO+MlapXGqfNWeLNZodabXdiJWMHOxVDLEb/ZX+FTkKQYw6wICGi
   JAMCWWsNG4lGn8hqpuzMVQuSgCrwQ2BSco1puNUQupdq389dSmMsd0pMn
   lQHRdX/qI3Yb4+8clxEAp7TEK+eZ8BGee9Da8xei3UK9Ln+Mop8hNrEUg
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10727"; a="344807306"
X-IronPort-AV: E=Sophos;i="6.00,207,1681196400"; 
   d="scan'208";a="344807306"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2023 09:27:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10727"; a="740029619"
X-IronPort-AV: E=Sophos;i="6.00,207,1681196400"; 
   d="scan'208";a="740029619"
Received: from zukmacix-mobl1.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.46.53])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2023 09:27:05 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 4A56410B45A; Wed, 31 May 2023 19:27:02 +0300 (+03)
Date:   Wed, 31 May 2023 19:27:02 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Andy Lutomirski <luto@kernel.org>,
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
        Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCHv12 1/9] mm: Add support for unaccepted memory
Message-ID: <20230531162702.zfzex7vkhn3uqgvb@box.shutemov.name>
References: <20230518231434.26080-1-kirill.shutemov@linux.intel.com>
 <20230518231434.26080-2-kirill.shutemov@linux.intel.com>
 <20230531155159.GIZHdtH20Q0FsmN3OR@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230531155159.GIZHdtH20Q0FsmN3OR@fat_crate.local>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, May 31, 2023 at 05:51:59PM +0200, Borislav Petkov wrote:
> On Fri, May 19, 2023 at 02:14:26AM +0300, Kirill A. Shutemov wrote:
> > The patch implements #1 and #2 for now. #2 is the default. Some
> 
> s/This patch implements/Implement/
> 
> > workloads may want to use #1 with accept_memory=eager in kernel
> > command line. #3 can be implemented later based on user's demands.
> 
> All this remaining text should not talk about what is being done
> - that's in the diff - but why. Drop the "what" pls.

Does it look okay?

Implement #1 and #2 for now. #2 is the default. Some workloads may want
to use #1 with accept_memory=eager in kernel command line. #3 can be
implemented later based on user's demands.

Support of unaccepted memory requires a few changes in core-mm code:

  - memblock accepts memory on allocation. It serves early boot memory
    allocations and doesn't limit them to pre-accepted pool of memory.

  - page allocator accepts memory on the first allocation of the page.
    When kernel runs out of accepted memory, it accepts memory until the
    high watermark is reached. It helps to minimize fragmentation.

EFI code will provide two helpers if the platform supports unaccepted
memory:

 - accept_memory() makes a range of physical addresses accepted.

 - range_contains_unaccepted_memory() checks anything within the range
   of physical addresses requires acceptance.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
