Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B897B6D4A05
	for <lists+linux-efi@lfdr.de>; Mon,  3 Apr 2023 16:43:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233829AbjDCOn3 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 3 Apr 2023 10:43:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233864AbjDCOn1 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 3 Apr 2023 10:43:27 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46DBA1825D;
        Mon,  3 Apr 2023 07:43:09 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id C2FC932009F1;
        Mon,  3 Apr 2023 10:42:44 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 03 Apr 2023 10:42:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1680532964; x=
        1680619364; bh=EEoAq/2FxgiyDtHsO7Ag1VVkbIeOqrB6EH0pcFwoo5M=; b=J
        YCXZo3CSmIfvwV0y9FWEiz1NZtUg5JNt6h/7a5w+0qC63Yf0/WpK3a7pnJj0DOGt
        wqXxs+/bpWTWr558YllEL8x5HClk0bFIrdAHzvhkH6b1r/LRo7wfmvWO3t+qBGS2
        NpXDqkkUXxbTnT341ZZZJIndC9D7sXhawZR2hU8ll7KAuz9Yx1z0vMpWq6Xzw9ba
        L9GegNmYKQgYapWo3Y12eqMWmt6hPOwkSqwytqEDRH6AKB2ypf3VWo12INNssw5X
        6jvlIKFTk2OLx4xJKoe2wZ/HxnHA1bAd+Y88eXCWMjXUw2Sfkb6SadxaSq0au207
        VzOVOP4auymSgbUEy0+eA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1680532964; x=1680619364; bh=EEoAq/2FxgiyD
        tHsO7Ag1VVkbIeOqrB6EH0pcFwoo5M=; b=rY95kovHZL3Mekwq39LsLeyY9Wkqj
        XW2GChygEII869k9qMCyII6RpWSwzBGo8Ne3JzwknnIx/C4wxDppKs3crZY1Tb7a
        teCF2crWlAP86exPgxMC4mrRl5P0pejcHkv8N1nEDJ9ugsdy5OCWs1b0snHEKQs2
        EjorYLZ3R4Lm83KAflUZChTmsHSU0XI0YTJ+a33QQaW7M9WkZ3SGDsI4fFc71Tbd
        P07xaYhcF5Re5jKMjaNugKayodN3D/wGs5+a9qGYK9HXQ3pT2YBdNDxLo4/0hJkX
        B4vXE3ooaMtJDdFRJE3Z9LZKukNog/iJFonRgkUB2Y7YbRZjsie5AQqgw==
X-ME-Sender: <xms:5OUqZOeZGJuM1sD0qd93C2DHtY3bIiKAupQ3rQZ8jTMVkDiESuDCUw>
    <xme:5OUqZIMtqZ4vAfEjWi32SX59W8a8tTsS6GtegMYN8_bNRSQHbsnaw8buBNXBj5dxn
    LlKAnPsrgBqnus78NM>
X-ME-Received: <xmr:5OUqZPhqEBMMty57q4mAT4CYdxLXJrYITJznri9BBQPG8qW9uEYIZXzUV4XR24s_JnrPpw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeijedgjeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdttddttddtvdenucfhrhhomhepfdfmihhr
    ihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlsehshhhuthgvmhhovhdrnh
    grmhgvqeenucggtffrrghtthgvrhhnpefhieeghfdtfeehtdeftdehgfehuddtvdeuheet
    tddtheejueekjeegueeivdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvg
X-ME-Proxy: <xmx:5OUqZL_Hm894yem-BX0PFVPCCb8UGHrSUwUde8STz4ICw7i8QH0lHA>
    <xmx:5OUqZKtqIV0qRnV8Pv9dtevbhXe9J6_rRPqALEjkbARtYSgKNFA8nQ>
    <xmx:5OUqZCGpms1tz8dNT5j0FpJ_Ela7Y9qUDjvbQVYqW-afgEI0Qmm3OA>
    <xmx:5OUqZEoZ3_0dWb5s-HgDwD564BTNCYhArUtWFCjX2vpluxjRPSGxzQ>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Apr 2023 10:42:43 -0400 (EDT)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id E586810D7B3; Mon,  3 Apr 2023 17:42:41 +0300 (+03)
Date:   Mon, 3 Apr 2023 17:42:41 +0300
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
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCHv9 11/14] x86/mm: Avoid load_unaligned_zeropad() stepping
 into unaccepted memory
Message-ID: <20230403144241.f4xpsyxuy2nh2aql@box.shutemov.name>
References: <20230330114956.20342-1-kirill.shutemov@linux.intel.com>
 <20230330114956.20342-12-kirill.shutemov@linux.intel.com>
 <48567ee3-b482-bafd-bd25-cbb8bf3403b2@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48567ee3-b482-bafd-bd25-cbb8bf3403b2@suse.cz>
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Apr 03, 2023 at 03:28:36PM +0200, Vlastimil Babka wrote:
> On 3/30/23 13:49, Kirill A. Shutemov wrote:
> > load_unaligned_zeropad() can lead to unwanted loads across page boundaries.
> > The unwanted loads are typically harmless. But, they might be made to
> > totally unrelated or even unmapped memory. load_unaligned_zeropad()
> > relies on exception fixup (#PF, #GP and now #VE) to recover from these
> > unwanted loads.
> > 
> > But, this approach does not work for unaccepted memory. For TDX, a load
> > from unaccepted memory will not lead to a recoverable exception within
> > the guest. The guest will exit to the VMM where the only recourse is to
> > terminate the guest.
> > 
> > There are three parts to fix this issue and comprehensively avoid access
> > to unaccepted memory. Together these ensure that an extra "guard" page
> > is accepted in addition to the memory that needs to be used.
> > 
> > 1. Implicitly extend the range_contains_unaccepted_memory(start, end)
> >    checks up to end+2M if 'end' is aligned on a 2M boundary. It may
> >    require checking 2M chunk beyond end of RAM. The bitmap allocation is
> >    modified to accommodate this.
> > 2. Implicitly extend accept_memory(start, end) to end+2M if 'end' is
> >    aligned on a 2M boundary.
> > 3. Set PageUnaccepted() on both memory that itself needs to be accepted
> >    *and* memory where the next page needs to be accepted. Essentially,
> >    make PageUnaccepted(page) a marker for whether work needs to be done
> >    to make 'page' usable. That work might include accepting pages in
> >    addition to 'page' itself.
> > 
> > Side note: This leads to something strange. Pages which were accepted
> > 	   at boot, marked by the firmware as accepted and will never
> > 	   _need_ to be accepted might have PageUnaccepted() set on
> > 	   them. PageUnaccepted(page) is a cue to ensure that the next
> > 	   page is accepted before 'page' can be used.
> 
> At least the part about PageUnaccepted() is obsolete in v9, no?

Ah, right. Nice catch.

I removed PageUnaccepted() late in patchset preparation and forgot about
this.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
