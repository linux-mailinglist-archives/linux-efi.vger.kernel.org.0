Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5AA16D417C
	for <lists+linux-efi@lfdr.de>; Mon,  3 Apr 2023 12:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231844AbjDCKDW (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 3 Apr 2023 06:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232009AbjDCKC5 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 3 Apr 2023 06:02:57 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBD412D52;
        Mon,  3 Apr 2023 03:02:49 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 2817D5C0114;
        Mon,  3 Apr 2023 06:02:49 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 03 Apr 2023 06:02:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1680516169; x=
        1680602569; bh=KAs2cClcytIPI/wu2fz/XtyTfqxpeJmdesR7LFRIvfw=; b=J
        499p0hPPencZjPib0BH5d3ajQHQAgwnB/MpQ7JRIiU4qYT2NqGLEUePG6uA6234Z
        +3T4CTUPiQfH4ZBiCDWFHnS4DkvlzonlSGwRrug3Eyld3e1VyBvHQIc1kJSa59NP
        vvhze5ix0I2PIoddn5sIpFmK262dErsiMVvmbG0Taaf0lPCbwOeqJuqvGskjqc30
        QcWRju2ycv36wZMY65mkXxDP2MvXYYT125Vh9DIUFJmYW7nG7nY3T1FukmGhRQLE
        MbEzVoZFccZqKqyWriU4farFj0et2qubH4WcOjwrGVnuF3uibhZXJZ6r7GtxRHzL
        rq5U0gtxY7h9D8c+RiXEQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1680516169; x=1680602569; bh=KAs2cClcytIPI
        /wu2fz/XtyTfqxpeJmdesR7LFRIvfw=; b=QSFQg3S7Q6mmaV36Dv8g9Hx3nbw5N
        HzZ47pHWVbhm9paMJPgf2vppy30T1LMgpVuOafN9lChgQOabWew7dwA5IlBfJdT+
        22Uup1afQ9c88vpClFuY5AcZ5qftK7aLnaodJh70T4Lc5Nue9fwRXG64E98DJq8A
        IM6QJk7jma/7gs008ZZz/Hi0zx7Pqkax+LinpQRcsF+Bpxr7NxKMQeFEEKsaE/0V
        nS1bv9Fjx/mMRpzu9iGU0rj/mu15665rDHV9TJEhkRfEW/DR5hkCPGQH3ppF6dzi
        PHqOfycWZjWHeXkg9ngTkDSBYn9hIX7JkGUq4oSqLfGF4FIjd5JxLUsQw==
X-ME-Sender: <xms:R6QqZJK-IIY7pWvu0J2GPlQmXDN7R9YvdtNXXN41WDHAHJTGXRR56A>
    <xme:R6QqZFJsthmzMr9WYdL6rvgXIZ-CqvIcqXJTszIFL_Ku3jghf_utgz6xpRAC6TziE
    C-sn2TlkhKh_aPg-XU>
X-ME-Received: <xmr:R6QqZBsj9sZF2JT5vze3iTYAGIOM7PCMNyR2IbbGUqn3Q2BInss2lHqfoOAvx6ba17Dplw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeijedgvddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepfdfmihhr
    ihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlsehshhhuthgvmhhovhdrnh
    grmhgvqeenucggtffrrghtthgvrhhnpeekvddvjeffheetgedtvdfgieejiedvgeejieet
    jeehieehveffueekfeehffdvveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvg
X-ME-Proxy: <xmx:R6QqZKagHubq8LCRXZR2uLZl4PrHr5QQQPSCuPeEEiUomEXHJo0a6g>
    <xmx:R6QqZAZPq8jLBxwba-_fvVUfieux4O9wDr7QCeYGjJDfRT1Fy7PLTw>
    <xmx:R6QqZOClXuhpmEe1eZFePDOxoNx_5q8klulCrUcseHkcQPhQFy3yeQ>
    <xmx:SaQqZHlGG22Y51Mq4RyWgI0OuJM7U-kumeU4Q7kEUpVL0maQfFfB2A>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Apr 2023 06:02:46 -0400 (EDT)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 08AC710D7B3; Mon,  3 Apr 2023 13:02:45 +0300 (+03)
Date:   Mon, 3 Apr 2023 13:02:44 +0300
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
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCHv9 02/14] mm: Add support for unaccepted memory
Message-ID: <20230403100244.4sre7ki4ccusiiul@box>
References: <20230330114956.20342-1-kirill.shutemov@linux.intel.com>
 <20230330114956.20342-3-kirill.shutemov@linux.intel.com>
 <43234108-fa4f-7583-e3b4-2daa2de89fb0@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43234108-fa4f-7583-e3b4-2daa2de89fb0@suse.cz>
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Apr 03, 2023 at 11:26:53AM +0200, Vlastimil Babka wrote:
> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > Acked-by: Mike Rapoport <rppt@linux.ibm.com>	# memblock
> 
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

Thanks!

> Just a small suggestion below:
> 
> > +
> > +static bool try_to_accept_memory(struct zone *zone, unsigned int order)
> > +{
> > +	long to_accept;
> > +	int ret = false;
> > +
> > +	if (!static_branch_unlikely(&zones_with_unaccepted_pages))
> > +		return false;
> 
> 
> This potentially (depends on what compiler decides) means we'll call this
> function just to skip the static branch. OTOH forcing it as inline would be
> wasteful too. So I'd split that away and make the callers do that static
> branch check inline. Just as deferred_pages_enabled() is used.

Like this?

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 07e16e9b49c4..80fe5e4b6cca 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -390,6 +390,7 @@ EXPORT_SYMBOL(nr_online_nodes);
 static bool page_contains_unaccepted(struct page *page, unsigned int order);
 static void accept_page(struct page *page, unsigned int order);
 static bool try_to_accept_memory(struct zone *zone, unsigned int order);
+static inline bool has_unaccepted_memory(void);
 static bool __free_unaccepted(struct page *page);
 
 int page_group_by_mobility_disabled __read_mostly;
@@ -3464,8 +3465,10 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
 				       gfp_mask)) {
 			int ret;
 
-			if (try_to_accept_memory(zone, order))
-				goto try_this_zone;
+			if (has_unaccepted_memory()) {
+				if (try_to_accept_memory(zone, order))
+					goto try_this_zone;
+			}
 
 #ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
 			/*
@@ -3519,8 +3522,10 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
 
 			return page;
 		} else {
-			if (try_to_accept_memory(zone, order))
-				goto try_this_zone;
+			if (has_unaccepted_memory()) {
+				if (try_to_accept_memory(zone, order))
+					goto try_this_zone;
+			}
 
 #ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
 			/* Try again if zone has deferred pages */
@@ -7302,9 +7307,6 @@ static bool try_to_accept_memory(struct zone *zone, unsigned int order)
 	long to_accept;
 	int ret = false;
 
-	if (!static_branch_unlikely(&zones_with_unaccepted_pages))
-		return false;
-
 	/* How much to accept to get to high watermark? */
 	to_accept = high_wmark_pages(zone) -
 		    (zone_page_state(zone, NR_FREE_PAGES) -
@@ -7321,6 +7323,11 @@ static bool try_to_accept_memory(struct zone *zone, unsigned int order)
 	return ret;
 }
 
+static inline bool has_unaccepted_memory(void)
+{
+	return static_branch_unlikely(&zones_with_unaccepted_pages);
+}
+
 static bool __free_unaccepted(struct page *page)
 {
 	struct zone *zone = page_zone(page);
@@ -7398,6 +7405,11 @@ static bool try_to_accept_memory(struct zone *zone, unsigned int order)
 	return false;
 }
 
+static inline bool has_unaccepted_memory(void)
+{
+	return false;
+}
+
 static bool __free_unaccepted(struct page *page)
 {
 	BUILD_BUG();
-- 
  Kiryl Shutsemau / Kirill A. Shutemov
