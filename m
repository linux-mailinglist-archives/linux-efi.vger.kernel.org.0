Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D623A745D7C
	for <lists+linux-efi@lfdr.de>; Mon,  3 Jul 2023 15:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbjGCNct (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 3 Jul 2023 09:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbjGCNcs (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 3 Jul 2023 09:32:48 -0400
X-Greylist: delayed 413 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 03 Jul 2023 06:32:18 PDT
Received: from outbound-smtp19.blacknight.com (outbound-smtp19.blacknight.com [46.22.139.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 666D0E6E
        for <linux-efi@vger.kernel.org>; Mon,  3 Jul 2023 06:32:17 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail02.blacknight.ie [81.17.254.11])
        by outbound-smtp19.blacknight.com (Postfix) with ESMTPS id 8D10F1C4247
        for <linux-efi@vger.kernel.org>; Mon,  3 Jul 2023 14:25:22 +0100 (IST)
Received: (qmail 10291 invoked from network); 3 Jul 2023 13:25:22 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.21.103])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 3 Jul 2023 13:25:21 -0000
Date:   Mon, 3 Jul 2023 14:25:18 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
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
Message-ID: <20230703132518.3ukqyolnes47i5r3@techsingularity.net>
References: <20230606142637.5171-1-kirill.shutemov@linux.intel.com>
 <20230606142637.5171-6-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20230606142637.5171-6-kirill.shutemov@linux.intel.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Jun 06, 2023 at 05:26:33PM +0300, Kirill A. Shutemov wrote:
> efi_config_parse_tables() reserves memory that holds unaccepted memory
> configuration table so it won't be reused by page allocator.
> 
> Core-mm requires few helpers to support unaccepted memory:
> 
>  - accept_memory() checks the range of addresses against the bitmap and
>    accept memory if needed.
> 
>  - range_contains_unaccepted_memory() checks if anything within the
>    range requires acceptance.
> 
> Architectural code has to provide efi_get_unaccepted_table() that
> returns pointer to the unaccepted memory configuration table.
> 
> arch_accept_memory() handles arch-specific part of memory acceptance.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
> Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>

By and large, this looks ok from the page allocator perspective as the
checks for unaccepted are mostly after watermark checks. However, if you
look in the initial fast path, you'll see this

        /* 
         * Forbid the first pass from falling back to types that fragment
         * memory until all local zones are considered.
         */     
        alloc_flags |= alloc_flags_nofragment(ac.preferred_zoneref->zone, gfp);

While checking watermarks should be fine from a functional perspective and
the fast paths are unaffected, there is a risk of premature fragmentation
until all memory has been accepted. Meeting watermarks does not necessarily
mean that fragmentation is avoided as pageblocks can get mixed while still
meeting watermarks. This will be tricky to detect in most cases so it may
be worth considering augmenting the watermark checks with a check in this
block for unaccepted memory

        /*
         * It's possible on a UMA machine to get through all zones that are
         * fragmented. If avoiding fragmentation, reset and try again.  */
        if (no_fallback) {
                alloc_flags &= ~ALLOC_NOFRAGMENT;
		goto retry;
	}

I think the watermark checks will still be needed because hypothetically
if 100% of allocations were MIGRATE_UNMOVABLE then there never would be
a request that fragments memory and memory would not be accepted.

It's not a blocker to the series, simply a suggestion for follow-on
work.

-- 
Mel Gorman
SUSE Labs
