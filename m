Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D3167186C5
	for <lists+linux-efi@lfdr.de>; Wed, 31 May 2023 17:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233893AbjEaPwK (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 31 May 2023 11:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231640AbjEaPwJ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 31 May 2023 11:52:09 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D81E8E;
        Wed, 31 May 2023 08:52:08 -0700 (PDT)
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9C3121EC042D;
        Wed, 31 May 2023 17:52:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1685548326;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=PjJvC25aHbGALiU6YVgnG9fmUYnvsHAivYjN1VpUWL8=;
        b=hTxgDwfuCwzRv4XyrSuZ1Qa/JoBjVnYer95z1d/ZhV90LaqH0lo9D/xw19UMf4qna+zqJN
        PLvs3Zyviep3I4zsBKo5jRh/OzsXXIobNdM1eoy13WyxhPFbpuCfTfMj9xCgpxQJMzYNj2
        PFcu9weh1qnAloA4dGUNGjjHbMOIB2E=
Date:   Wed, 31 May 2023 17:51:59 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
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
Message-ID: <20230531155159.GIZHdtH20Q0FsmN3OR@fat_crate.local>
References: <20230518231434.26080-1-kirill.shutemov@linux.intel.com>
 <20230518231434.26080-2-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230518231434.26080-2-kirill.shutemov@linux.intel.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, May 19, 2023 at 02:14:26AM +0300, Kirill A. Shutemov wrote:
> The patch implements #1 and #2 for now. #2 is the default. Some

s/This patch implements/Implement/

> workloads may want to use #1 with accept_memory=eager in kernel
> command line. #3 can be implemented later based on user's demands.

All this remaining text should not talk about what is being done
- that's in the diff - but why. Drop the "what" pls.

> Support of unaccepted memory requires a few changes in core-mm code:
> 
>   - memblock has to accept memory on allocation;
> 
>   - page allocator has to accept memory on the first allocation of the
>     page;
>
> Memblock change is trivial.
> 
> The page allocator is modified to accept pages. New memory gets accepted
> before putting pages on free lists. It is done lazily: only accept new
> pages when we run out of already accepted memory. The memory gets
> accepted until the high watermark is reached.
> 
> EFI code will provide two helpers if the platform supports unaccepted
> memory:
> 
>  - accept_memory() makes a range of physical addresses accepted.
> 
>  - range_contains_unaccepted_memory() checks anything within the range
>    of physical addresses requires acceptance.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Acked-by: Mike Rapoport <rppt@linux.ibm.com>	# memblock
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  drivers/base/node.c    |   7 ++
>  fs/proc/meminfo.c      |   5 ++
>  include/linux/mm.h     |  19 +++++
>  include/linux/mmzone.h |   8 ++
>  mm/memblock.c          |   9 +++
>  mm/mm_init.c           |   7 ++
>  mm/page_alloc.c        | 173 +++++++++++++++++++++++++++++++++++++++++
>  mm/vmstat.c            |   3 +
>  8 files changed, 231 insertions(+)

Diff itself looks ok.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
