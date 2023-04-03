Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF2876D4B2B
	for <lists+linux-efi@lfdr.de>; Mon,  3 Apr 2023 16:56:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232620AbjDCO4X (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 3 Apr 2023 10:56:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232011AbjDCO4W (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 3 Apr 2023 10:56:22 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B253928EBE;
        Mon,  3 Apr 2023 07:55:57 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 433DE320098C;
        Mon,  3 Apr 2023 10:47:06 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 03 Apr 2023 10:47:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1680533225; x=
        1680619625; bh=oqA0VHWBGbzdDXhXtmsL6Q39VlRQlEDa8qmRtydlcIU=; b=C
        JfPIRcTDs1kJ7uvJSt2/SC/gZ0s850Etkzy+yVS2pfYpPQSe4KLXh+cJ84UD79uM
        aidEngC7vydhEz1Hr2f1ZscjLnk+/Hh+N7LfBjfBV6oEenxEWi+xxLTWvyi/nx6o
        KZOaM/T9wBaMXjDZ3fkuSURI3kFbbBLWl9Hvy1a9HCXfKsbFifcZVNpOixtCzsRn
        ROxo2xpwYSgqVKOPVJnJRmKTJG+is3IdH4YDb7IvUD7EwIbsoCDnUHGu9sdqMCs3
        m4aDvaENE/KrceJdicbM90VxOhBz7H1xkYv3p1qd7eOsFtLSChCaQ856gRVV+vrl
        Ou+/Gpqjm3bSf4YwITdXA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1680533225; x=1680619625; bh=oqA0VHWBGbzdD
        XhXtmsL6Q39VlRQlEDa8qmRtydlcIU=; b=NdC2tkDIF2Qhtp04LAGWOXraeGqkd
        982Y+yLEmxsFtcAqCDimsb+ePj1+DytzJB2hnGUZrzVkc/g8Z8Fi1GCrHGLgfWI4
        QBsaLkkQRZudXq6LE6F9lnIVTkGiPE4A/nb8ig8q8QeDrqrebU6oBbERzt5e8ITl
        0vB2kvE3DpiaNiUCdd66271rOTkHfuHO9OTbF0V6IftqC7XoOK+JbDbpE90mL/PS
        WwQxWJyvvENm21f2G+Yr/Juv5rsXj3DcBayYqFwbmVVzYcQiEOeX7DpXAA9wrFr4
        cUvdHcQfYUNo6WjW17vojot3bC/Ii5NqALXIlFvZm+sgqiLDCWOYKMUOw==
X-ME-Sender: <xms:6eYqZAWuUJFFeT4Els4rkEvl3rE9GtT3adgPEpLNj2ZgJucWMz67Kg>
    <xme:6eYqZEmyRGbDzQG-ueXu0MPWCEaD7sW1WEK_Vx65N_IcDn86lUZN50HvPO6hs_VjU
    41Jj7__Cta1Pr57vU0>
X-ME-Received: <xmr:6eYqZEbXGeTJ0R-98qLjPgI4Amoll0myvtXvsEE4R-rkwjBz0Hnr4nJlIA28Xv81wo-9Kg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeijedgkedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdttddttddtvdenucfhrhhomhepfdfmihhr
    ihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlsehshhhuthgvmhhovhdrnh
    grmhgvqeenucggtffrrghtthgvrhhnpefhieeghfdtfeehtdeftdehgfehuddtvdeuheet
    tddtheejueekjeegueeivdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvg
X-ME-Proxy: <xmx:6eYqZPX41MPaQ6YeTN_zeNk_ZbdQ-rpKINXG7D4FIQFgJ8gAka38Xw>
    <xmx:6eYqZKniee3nysIag5tPof8iThgigYkccu8nsYn-u78L9OrXN3udwQ>
    <xmx:6eYqZEf0O6Em4Jbj61rhAQMLOD1HmcvZJF_fvl8v3G7o8R3yBIgnRA>
    <xmx:6eYqZIxdMzEWsP58CVZgEKg3x7nLq_KTgp8CGymwKff72Pnjq7stoA>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Apr 2023 10:47:04 -0400 (EDT)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id C6B9410D7B3; Mon,  3 Apr 2023 17:47:02 +0300 (+03)
Date:   Mon, 3 Apr 2023 17:47:02 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     David Hildenbrand <david@redhat.com>
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
        Vlastimil Babka <vbabka@suse.cz>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dario Faggioli <dfaggioli@suse.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        aarcange@redhat.com, peterx@redhat.com, x86@kernel.org,
        linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv9 03/14] mm/page_alloc: Fake unaccepted memory
Message-ID: <20230403144702.uf7fhfrffypkmqy5@box.shutemov.name>
References: <20230330114956.20342-1-kirill.shutemov@linux.intel.com>
 <20230330114956.20342-4-kirill.shutemov@linux.intel.com>
 <053a9ccd-4205-7a76-70c3-c256bd995a1f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <053a9ccd-4205-7a76-70c3-c256bd995a1f@redhat.com>
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Apr 03, 2023 at 04:43:08PM +0200, David Hildenbrand wrote:
> On 30.03.23 13:49, Kirill A. Shutemov wrote:
> > For testing purposes, it is useful to fake unaccepted memory in the
> > system. It helps to understand unaccepted memory overhead to the page
> > allocator.
> > 
> > The patch allows to treat memory above the specified physical memory
> > address as unaccepted.
> > 
> > The change only fakes unaccepted memory for page allocator. Memblock is
> > not affected.
> > 
> > It also assumes that arch-provided accept_memory() on already accepted
> > memory is a nop.
> > 
> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > ---
> >   mm/page_alloc.c | 21 +++++++++++++++++++++
> >   1 file changed, 21 insertions(+)
> > 
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index d62fcb2f28bd..509a93b7e5af 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -7213,6 +7213,8 @@ static DEFINE_STATIC_KEY_FALSE(zones_with_unaccepted_pages);
> >   static bool lazy_accept = true;
> > +static unsigned long fake_unaccepted_start = -1UL;
> > +
> >   static int __init accept_memory_parse(char *p)
> >   {
> >   	if (!strcmp(p, "lazy")) {
> > @@ -7227,11 +7229,30 @@ static int __init accept_memory_parse(char *p)
> >   }
> >   early_param("accept_memory", accept_memory_parse);
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
> >   static bool page_contains_unaccepted(struct page *page, unsigned int order)
> >   {
> >   	phys_addr_t start = page_to_phys(page);
> >   	phys_addr_t end = start + (PAGE_SIZE << order);
> > +	if (start >= fake_unaccepted_start)
> > +		return true;
> > +
> >   	return range_contains_unaccepted_memory(start, end);
> >   }
> 
> The "unpleasant" thing about this is, that page_contains_unaccepted() could
> not be used for sanity checks because the result is static.
> 
> For example, something like
> 
> if (page_contains_unaccepted(page, 0))
> 	accept_memory(page, 0);
> BUG_ON(!page_contains_unaccepted(page, 0));
> 
> Would work on real hardware, however, not for the fake variant.

Need for raw_page_contains_unaccepted()? :P

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
