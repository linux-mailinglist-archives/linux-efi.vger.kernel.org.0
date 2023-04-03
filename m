Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A15A6D4998
	for <lists+linux-efi@lfdr.de>; Mon,  3 Apr 2023 16:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233739AbjDCOjY (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 3 Apr 2023 10:39:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233728AbjDCOjX (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 3 Apr 2023 10:39:23 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC4A91DFB2;
        Mon,  3 Apr 2023 07:39:22 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 77AF532009FD;
        Mon,  3 Apr 2023 10:39:19 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 03 Apr 2023 10:39:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1680532759; x=
        1680619159; bh=K2V3JLsEArJXT5TV6MDPru6C5GMHsExu9jhmhSdk+zM=; b=W
        c5t8NREEIWo1fH4RidMcCeW8vslYrlg8yjoP+fgXapMvSaVtq9OTiDKafp41bgJz
        oYjPqABrCdeeV2/V1q4c0BxUORxGcYBHOCApDb2YeRDYyzJEXAzT9o5m2O+GId2f
        AOwiKFEAT8Xze9i4dm37E1ox/z8+Fp68QS5/sUUTygsRqVqWlIPcXISiXSsMcDXO
        Eqh3kwG9iXvTml4l8bznnUS64eqHWJETGhzsHommuBn632Wy3/YYkMcMmyMgPIwF
        CvAhcGESsu0siFSXsfTIzDBnXYX/G2dwg2jXI3eLoe/7uylTaKBOBs176DS58Zrq
        a/zQ4xmUoKX1PMSfaXdOg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1680532759; x=1680619159; bh=K2V3JLsEArJXT
        5TV6MDPru6C5GMHsExu9jhmhSdk+zM=; b=e2w447uusTtu5q54yfFeOZQdnc9b/
        AJb+1KHufDoeqjk9f1kBNfqBzKSaT52+A7uZpWAB1u5QndFu01DUPparmXsPlxGx
        WF0vAV3fCvY69KlA++dInfzV4t+6p5b2jO6d0lqD4ePrXihfFXFbmUqUpN4g9cKz
        E/GaxU82i/JtkkPrcUBc5RNWUQ2mXs4d8xk9Uxy037d9gvl6vmdG6zqHhjj0z3TS
        limNJ6chj7mBRJ9SV29UXHqJtZNsV8Nuhr88F+0HOXbtmOMT5m4KNU6CGBFgzueV
        hIKekPqMAkqm81p047aklihTLYEghPR28pLxBAE/YcJ2UfttHkwTmop5Q==
X-ME-Sender: <xms:FeUqZPgcR0R5uYcMz8fIvtRs2xTFZj3jJovbAIKYeZCtGtPwcDmGwA>
    <xme:FeUqZMBB5AJvL8CYjz7xMwMTQRl7Bk6pamWbvPKgXpDejfiZqUtjN_ouNX1ivsuBt
    La6CPAFGtdaDssn-7E>
X-ME-Received: <xmr:FeUqZPHWomL5Yh6m22PebkDm45jvT5tmJMQK0cPxhSK-fEQ8NNhFfyejRds7DeHgRr1SzA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeijedgjeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdttddttddtvdenucfhrhhomhepfdfmihhr
    ihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlsehshhhuthgvmhhovhdrnh
    grmhgvqeenucggtffrrghtthgvrhhnpefhieeghfdtfeehtdeftdehgfehuddtvdeuheet
    tddtheejueekjeegueeivdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvg
X-ME-Proxy: <xmx:FeUqZMR2gbXvV65-WXUbBhiEehYP9XAH881P-ukBM_y6mPb7AHdrkw>
    <xmx:FeUqZMxtx0mdE-o7b9AKZALJVOt4RD8nXtLV7B8R3JWtvwjKAB_v5A>
    <xmx:FeUqZC6khTcI2U4zi-8BiEPgp0hPpcDGozJRoiFCd_4aCYWgKU_XPw>
    <xmx:F-UqZF89gh87kchgVURi6j5iIyAKwLcxYz_F9xkw8ECKiXJp0Th1KQ>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Apr 2023 10:39:17 -0400 (EDT)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 7F0EC10D7B3; Mon,  3 Apr 2023 17:39:15 +0300 (+03)
Date:   Mon, 3 Apr 2023 17:39:15 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
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
        Dave Hansen <dave.hansen@intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        aarcange@redhat.com, peterx@redhat.com, x86@kernel.org,
        linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv9 03/14] mm/page_alloc: Fake unaccepted memory
Message-ID: <20230403143915.uc4tnpgmssvpdqxu@box.shutemov.name>
References: <20230330114956.20342-1-kirill.shutemov@linux.intel.com>
 <20230330114956.20342-4-kirill.shutemov@linux.intel.com>
 <835dfe65-d9dd-0b16-37d4-920e97f1bca0@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <835dfe65-d9dd-0b16-37d4-920e97f1bca0@suse.cz>
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Apr 03, 2023 at 03:39:53PM +0200, Vlastimil Babka wrote:
> On 3/30/23 13:49, Kirill A. Shutemov wrote:
> > For testing purposes, it is useful to fake unaccepted memory in the
> > system. It helps to understand unaccepted memory overhead to the page
> > allocator.
> 
> Ack on being useful for testing, but the question is if we want to also
> merge this patch into mainline as it is?

I don't insist on getting it upstream, but it can be handy to debug
related bugs in the future.

> > The patch allows to treat memory above the specified physical memory
> > address as unaccepted.
> > 
> > The change only fakes unaccepted memory for page allocator. Memblock is
> > not affected.
> > 
> > It also assumes that arch-provided accept_memory() on already accepted
> > memory is a nop.
> 
> I guess to be in mainline it would have to at least gracefully handle the
> case of accept_memory actually not being a nop, and running on a system with
> actual unaccepted memory (probably by ignoring the parameter in such case).
> Then also the parameter would have to be documented.

As it is written now, accept_memory() is nop on system with real
unaccepted memory if the memory is already accepted. Arch-specific code
will check against own records to see if the memory needs accepting. If
not, just return.

And the option will not interfere with unaccepted memory declared by EFI
memmap. It can extend it, but that's it.

Looks safe to me.

> Speaking of documented parameters, I found at least two that seem a more
> generic variant of this (but I didn't look closely if that makes sense):
> 
> efi_fake_mem=   nn[KMG]@ss[KMG]:aa[,nn[KMG]@ss[KMG]:aa,..] [EFI; X86]
>     Add arbitrary attribute to specific memory range by
>     updating original EFI memory map.
> 
> memmap=<size>%<offset>-<oldtype>+<newtype>
>     [KNL,ACPI] Convert memory within the specified region
>     from <oldtype> to <newtype>. If "-<oldtype>" is left
> 
> Would any of those be usable for this usecase?

Oh. I missed them. Will take a closer look.

> 
> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > ---
> >  mm/page_alloc.c | 21 +++++++++++++++++++++
> >  1 file changed, 21 insertions(+)
> > 
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index d62fcb2f28bd..509a93b7e5af 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -7213,6 +7213,8 @@ static DEFINE_STATIC_KEY_FALSE(zones_with_unaccepted_pages);
> >  
> >  static bool lazy_accept = true;
> >  
> > +static unsigned long fake_unaccepted_start = -1UL;
> > +
> >  static int __init accept_memory_parse(char *p)
> >  {
> >  	if (!strcmp(p, "lazy")) {
> > @@ -7227,11 +7229,30 @@ static int __init accept_memory_parse(char *p)
> >  }
> >  early_param("accept_memory", accept_memory_parse);
> >  
> > +static int __init fake_unaccepted_start_parse(char *p)
> > +{
> > +	if (!p)
> > +		return -EINVAL;
> > +
> > +	fake_unaccepted_start = memparse(p, &p);
> > +
> > +	if (*p != '\0') {
> > +		fake_unaccepted_start = -1UL;
> > +		return -EINVAL;
> > +	}
> > +
> > +	return 0;
> > +}
> > +early_param("fake_unaccepted_start", fake_unaccepted_start_parse);
> > +
> >  static bool page_contains_unaccepted(struct page *page, unsigned int order)
> >  {
> >  	phys_addr_t start = page_to_phys(page);
> >  	phys_addr_t end = start + (PAGE_SIZE << order);
> >  
> > +	if (start >= fake_unaccepted_start)
> > +		return true;
> > +
> >  	return range_contains_unaccepted_memory(start, end);
> >  }
> >  
> 

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
