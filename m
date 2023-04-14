Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E37526E2093
	for <lists+linux-efi@lfdr.de>; Fri, 14 Apr 2023 12:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbjDNKTP (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 14 Apr 2023 06:19:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbjDNKTL (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 14 Apr 2023 06:19:11 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB1E4C06;
        Fri, 14 Apr 2023 03:19:09 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 829305C019C;
        Fri, 14 Apr 2023 06:19:08 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 14 Apr 2023 06:19:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1681467548; x=
        1681553948; bh=3WBXbUqLLLeQq1ZCi/ry0FRNyZxe7SfbSw3k4IDdgYw=; b=Z
        ClIRosJvFYimXH424uFn+IMWuq7wHzSt3CljrY6r3b2AWz20JTr3/voTEg5m5Jwj
        UJozpW/Eb7z4fS8NJLngrRWiQwe9+eoOVt7aOHAQU8KHYLFuHpcZJ9KLPu/jJtH2
        9khb9X0dhloRjI8UKC8rzGLqd4glPe/VOA+1sw47v8Kz2xTKBqAmvuIHRr2Hk9cb
        qkCx1iB5t55scuSTy14A81GS7dz2XtgBVN4oPJ1F8+Jje3pSWcAngphiyuKemx3f
        5gvG9A4VrQlZBSySiKi8BqvxPS1CgAlqqjhMEMgsJmNEdYd+KfOodnUs9Md3q4qX
        aKeFlK5chukPhVnOAF12Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1681467548; x=1681553948; bh=3WBXbUqLLLeQq
        1ZCi/ry0FRNyZxe7SfbSw3k4IDdgYw=; b=Upd2y1I6y+9hRCGMAhkcN7OzmAdK+
        ZYWyZauB6wWOXiH4DJdR7jvPQF4zF5KAFENPCLq+iUnbuIbPxWvaRixT0yBUZDWB
        sURE8/aBRxo4kDgGlXUphkxSqWCNFJLcBsoXhTKFDVSmNnp/D+3t493rFbUl2G5m
        3z7OHA3oU3wt8CMch2Ipsx0uZsyKbSEL8xR3x6AsfXqGa2qwbvzTwOpnZ0h15QFu
        yOoVpNQ7SoueL2JYoTHKrbUTt6bnABkk3OshYd7lnz0sYNwOyzoAwrcPb/l2hTse
        V/H/Nb6xu7Mwzmd/y/uH1C6F2FvXMRV1h25KH7yXB1zx++Pm/aVEoJ/lw==
X-ME-Sender: <xms:mSg5ZPS4HgjIrSFX5z_NpAVVSbED5mN9q3mUjZ_8nHbZ9eVTlmtdWA>
    <xme:mSg5ZAwUJnBb46d1NnpKk21K5cIBNFghWn5EDA6GyBByGtkoqmxquuGnpLQs_zVA8
    RQJwjSpKbr_bGa_XSg>
X-ME-Received: <xmr:mSg5ZE2pqdD1eG7mmTjt8v2OqS7gQXjHe0eCEkBuTn1RUFeR5GiZYcC81LlUgFzc8J9r3A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeltddgvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepfdfmihhr
    ihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlsehshhhuthgvmhhovhdrnh
    grmhgvqeenucggtffrrghtthgvrhhnpeekvddvjeffheetgedtvdfgieejiedvgeejieet
    jeehieehveffueekfeehffdvveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvg
X-ME-Proxy: <xmx:mSg5ZPCvN2Rg7TWqsjEeh_lGBR8eEY7DVzpug6C_77mc6cCu2EIXhA>
    <xmx:mSg5ZIhNS0G2oXtzXubSOHOOhSyd2NDMcTQ5j4QU67biRvjCz3iZ3w>
    <xmx:mSg5ZDrP_l6z9rFc5Czx3kgu5vM-oC36DTLB_RQcRK9qcA7pihEogQ>
    <xmx:nCg5ZNtKLM41dZv5Xl9o1gVYOHKrPDeiKeYiGdqaoMzKsiOzE_xpbg>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Apr 2023 06:19:05 -0400 (EDT)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id EE51510D7B4; Fri, 14 Apr 2023 13:19:01 +0300 (+03)
Date:   Fri, 14 Apr 2023 13:19:01 +0300
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
Message-ID: <20230414101901.j3zoji6vmjzpjiec@box>
References: <20230330114956.20342-1-kirill.shutemov@linux.intel.com>
 <20230330114956.20342-4-kirill.shutemov@linux.intel.com>
 <835dfe65-d9dd-0b16-37d4-920e97f1bca0@suse.cz>
 <20230403143915.uc4tnpgmssvpdqxu@box.shutemov.name>
 <20230403155011.aodnd5ratcyeie52@box.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230403155011.aodnd5ratcyeie52@box.shutemov.name>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Apr 03, 2023 at 06:50:11PM +0300, Kirill A. Shutemov wrote:
> On Mon, Apr 03, 2023 at 05:39:15PM +0300, Kirill A. Shutemov wrote:
> > On Mon, Apr 03, 2023 at 03:39:53PM +0200, Vlastimil Babka wrote:
> > > On 3/30/23 13:49, Kirill A. Shutemov wrote:
> > > > For testing purposes, it is useful to fake unaccepted memory in the
> > > > system. It helps to understand unaccepted memory overhead to the page
> > > > allocator.
> > > 
> > > Ack on being useful for testing, but the question is if we want to also
> > > merge this patch into mainline as it is?
> > 
> > I don't insist on getting it upstream, but it can be handy to debug
> > related bugs in the future.
> > 
> > > > The patch allows to treat memory above the specified physical memory
> > > > address as unaccepted.
> > > > 
> > > > The change only fakes unaccepted memory for page allocator. Memblock is
> > > > not affected.
> > > > 
> > > > It also assumes that arch-provided accept_memory() on already accepted
> > > > memory is a nop.
> > > 
> > > I guess to be in mainline it would have to at least gracefully handle the
> > > case of accept_memory actually not being a nop, and running on a system with
> > > actual unaccepted memory (probably by ignoring the parameter in such case).
> > > Then also the parameter would have to be documented.
> > 
> > As it is written now, accept_memory() is nop on system with real
> > unaccepted memory if the memory is already accepted. Arch-specific code
> > will check against own records to see if the memory needs accepting. If
> > not, just return.
> > 
> > And the option will not interfere with unaccepted memory declared by EFI
> > memmap. It can extend it, but that's it.
> > 
> > Looks safe to me.
> > 
> > > Speaking of documented parameters, I found at least two that seem a more
> > > generic variant of this (but I didn't look closely if that makes sense):
> > > 
> > > efi_fake_mem=   nn[KMG]@ss[KMG]:aa[,nn[KMG]@ss[KMG]:aa,..] [EFI; X86]
> > >     Add arbitrary attribute to specific memory range by
> > >     updating original EFI memory map.
> 
> As of now, efi_fake_mem= can adjust attributes of memory. Unaccepted is
> type of memory, not an attribute. I guess we can allow it override type
> too. But syntax is going to be fun.

efi_fake_mem applied too late. Bitmap that represents unaccepted memory
for kernel created at kernel decompression stage, but efi_fake_mem=
handled in main kernel.

I don't think pushing efi_fake_mem to decompressor makes sesne. I would
rather drom the feature altogether.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
