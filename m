Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FA3F6D4C8E
	for <lists+linux-efi@lfdr.de>; Mon,  3 Apr 2023 17:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232960AbjDCPvC (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 3 Apr 2023 11:51:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232963AbjDCPuj (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 3 Apr 2023 11:50:39 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC1E310F5;
        Mon,  3 Apr 2023 08:50:20 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 5503632009D2;
        Mon,  3 Apr 2023 11:50:16 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 03 Apr 2023 11:50:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1680537015; x=
        1680623415; bh=hvMPk2VFFCoLBECPlHT93AuyqWq9AiPkFUCgyzV1WjM=; b=u
        SVpbwQ7v4XuHWFLanjNQ9tGfvXICUwjRsTubI1ABBNQWsniN/KY2Rnxy5epytyGn
        e/f3RAstVfwmlbTOdkpU0nmVgcGkKLOHiCO17obU27wROTgqV8lFN7oAzE0LXuZi
        OQWDGWFFnzbM0lRJlR1pwILD09/2/YV6zCZq70J5meudotAC7XH4E7YYpznDu797
        PgmxWUXwAxw0bEZwrI0iy3icXz9Arb5Fd/UoY9g4bW0LNh1fGx4OnxeimVkCtu2Z
        2voJYblHINLFv27+cVHv6gSC57U2xY1ymTCF7QyjC4ZK/AJX/7dPZ6/k9iLSdx9L
        NFUCb2z4eZPx5wD8uN/LQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1680537015; x=1680623415; bh=hvMPk2VFFCoLB
        ECPlHT93AuyqWq9AiPkFUCgyzV1WjM=; b=t0vcoq5UGAwjtC23bgvg9IlQed7z0
        6wrDfzCnaqikCyis26OmexPd1msLzDbzD3zFf1b8M4vYRKkeFcuR9zKQCS1Qa1Bb
        xwuJ6K94oxCyiRw1ly5ch9/Dn996moASG4fxtT+5gLvtjngp6DmEnqe+vSYEEhGP
        qLKKDBkGjcIKcEucirDIFH6TPYEyGvzDNC+eUclVdGCnskXe2uWLGFTIHfbkm3EF
        R7tZwg15nywuFSuayiRLJYrOWOvSLoeAuN/Bwd96BOD23o6eU4kC2vWiAvpqak4v
        w2xOuXCSMq1byennNQ1Jn1dqFPsFuMCJ2EzVZ5BzZV3nEDHk9jZXgFdEg==
X-ME-Sender: <xms:tvUqZLjgEmS6UiIANTZKPTRP-nK-O_aaxGGlaVtcuwSyv22nUWrwTQ>
    <xme:tvUqZIAahZOmEANUofMyKE4f-QXF1wgHZkMmY870uxXL-Z2Fn17Fk0DYp8Fq8Dwyn
    OAziGDylg2W3mOPpys>
X-ME-Received: <xmr:tvUqZLGg28roft_EVY4BroXyQQE1XGkYlAv5IOXaBiL6vRiecxLV3IoM0bF7juHa1vfi9Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeijedgleegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdttddttddtvdenucfhrhhomhepfdfmihhr
    ihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlsehshhhuthgvmhhovhdrnh
    grmhgvqeenucggtffrrghtthgvrhhnpefhieeghfdtfeehtdeftdehgfehuddtvdeuheet
    tddtheejueekjeegueeivdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvg
X-ME-Proxy: <xmx:tvUqZITd8ZeOko-EA6Y5LHL1NgLxw9pInXtZegEN74sHD2OeDYsYfA>
    <xmx:tvUqZIyt8-ibgFzjEKJwZ2EZUgLkrJHuwHWXuOOmr3xfW6dA4uUecw>
    <xmx:tvUqZO5IowN-JtHcJuvSHufriryoyNK8uFG-QEK4cJ_jC20XbdAx1w>
    <xmx:t_UqZB-Zw5hLxT-lqJhFKYo-ZfKg9N0ewQmefVOG_6sf6PCB4vdTDA>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Apr 2023 11:50:13 -0400 (EDT)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id C1C7E10D7B3; Mon,  3 Apr 2023 18:50:11 +0300 (+03)
Date:   Mon, 3 Apr 2023 18:50:11 +0300
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
Message-ID: <20230403155011.aodnd5ratcyeie52@box.shutemov.name>
References: <20230330114956.20342-1-kirill.shutemov@linux.intel.com>
 <20230330114956.20342-4-kirill.shutemov@linux.intel.com>
 <835dfe65-d9dd-0b16-37d4-920e97f1bca0@suse.cz>
 <20230403143915.uc4tnpgmssvpdqxu@box.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230403143915.uc4tnpgmssvpdqxu@box.shutemov.name>
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Apr 03, 2023 at 05:39:15PM +0300, Kirill A. Shutemov wrote:
> On Mon, Apr 03, 2023 at 03:39:53PM +0200, Vlastimil Babka wrote:
> > On 3/30/23 13:49, Kirill A. Shutemov wrote:
> > > For testing purposes, it is useful to fake unaccepted memory in the
> > > system. It helps to understand unaccepted memory overhead to the page
> > > allocator.
> > 
> > Ack on being useful for testing, but the question is if we want to also
> > merge this patch into mainline as it is?
> 
> I don't insist on getting it upstream, but it can be handy to debug
> related bugs in the future.
> 
> > > The patch allows to treat memory above the specified physical memory
> > > address as unaccepted.
> > > 
> > > The change only fakes unaccepted memory for page allocator. Memblock is
> > > not affected.
> > > 
> > > It also assumes that arch-provided accept_memory() on already accepted
> > > memory is a nop.
> > 
> > I guess to be in mainline it would have to at least gracefully handle the
> > case of accept_memory actually not being a nop, and running on a system with
> > actual unaccepted memory (probably by ignoring the parameter in such case).
> > Then also the parameter would have to be documented.
> 
> As it is written now, accept_memory() is nop on system with real
> unaccepted memory if the memory is already accepted. Arch-specific code
> will check against own records to see if the memory needs accepting. If
> not, just return.
> 
> And the option will not interfere with unaccepted memory declared by EFI
> memmap. It can extend it, but that's it.
> 
> Looks safe to me.
> 
> > Speaking of documented parameters, I found at least two that seem a more
> > generic variant of this (but I didn't look closely if that makes sense):
> > 
> > efi_fake_mem=   nn[KMG]@ss[KMG]:aa[,nn[KMG]@ss[KMG]:aa,..] [EFI; X86]
> >     Add arbitrary attribute to specific memory range by
> >     updating original EFI memory map.

As of now, efi_fake_mem= can adjust attributes of memory. Unaccepted is
type of memory, not an attribute. I guess we can allow it override type
too. But syntax is going to be fun.

> > memmap=<size>%<offset>-<oldtype>+<newtype>
> >     [KNL,ACPI] Convert memory within the specified region
> >     from <oldtype> to <newtype>. If "-<oldtype>" is left

It overrides E820 map, but unaccepted memory is not represented there.
Unaccepted memory is just RAM in E820.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
