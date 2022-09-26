Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9AF5EA7B9
	for <lists+linux-efi@lfdr.de>; Mon, 26 Sep 2022 15:57:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235062AbiIZN5J (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 26 Sep 2022 09:57:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235081AbiIZN4n (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 26 Sep 2022 09:56:43 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF0DB151DDE;
        Mon, 26 Sep 2022 05:11:33 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 777CF5C0136;
        Mon, 26 Sep 2022 08:10:32 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 26 Sep 2022 08:10:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1664194232; x=1664280632; bh=SX
        ZXZRhuf9JevySNewTG6qOkVzPewIE+tsCRVShJcVU=; b=CeNTx2AJFtWG1toroK
        mxZOBthTTsNUsUp2GTEyj5bTHXS0tByAQrhP3pF08Vd1O+llD7AmDcc4pTBta4F+
        AnobgsRcte3ZQ+eWpfDNdcDi8GVxK7oXGq27whyXTEqebaahCuXjCd/uTbD5gunX
        TqXJWOjG7BpLcSBS/rtqXGuLiSG01jZs8IjTLHXLOAClFaFjxWW53uI4MRl7PzOs
        OuUq2nj2OyErm9YyLtjBQ9zlKLhPxzIFm2SxzN9RR6d0ixOWorbffBOpNaBrRLX4
        OnT+Mbl0hZRuLob7Jpsn14DI1HmkQBin750+NondDQsz6KB3/YiD4Nda3ybVVyqC
        2IXA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1664194232; x=1664280632; bh=SXZXZRhuf9JevySNewTG6qOkVzPe
        wIE+tsCRVShJcVU=; b=HCUsALZL5QHHesHRLIK/3ubAYtM1sEqjZtwxqMiz9WYY
        BBvC8gCTPor24gDICjNj29er09W8ivNCoZVqhrsIBDeH1ARPY2SCta25rIpThdoS
        3ccBHFvHFMdAml/WfZHaonq3gWjM6Qgj39BTrnWpr/H+v1YXNqFP6zEh53Iq9J9B
        z/4ablLBlW5BKuiIX0RS8Zt8gf2jIzEh3Yu727sBswCtlcG4IXL7OoOelCnyytPr
        AeguqSA0H8W2I7qVNIaUmjDEWMsUFNkSigFniJnH/7KgA/Bl/07ZC3/g/yffSCbr
        NGwSb/GhRxHNE+7CpezJPqFcW/0aaC6ALW0ytlLukg==
X-ME-Sender: <xms:t5YxY0iVmb2QufbQg7CpLiJ9SU-SUOQGfa2qquV727juQvVJtAlCIQ>
    <xme:t5YxY9Bb2QzSShIF_G4wjkz00dwuGUkXl08ahBFsUzHhy4Io2DmusDaqZWwGzII6d
    gprM7GmFYUV3bOpoYk>
X-ME-Received: <xmr:t5YxY8FPKbxrtSus8pO5XaSMpsHAmTeTN_GyrtzwJ3qeSRM6IaVb2C9BSklnqiaPddAb8Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeegvddggeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdttddttddtvdenucfhrhhomhepfdfmihhr
    ihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlsehshhhuthgvmhhovhdrnh
    grmhgvqeenucggtffrrghtthgvrhhnpefhieeghfdtfeehtdeftdehgfehuddtvdeuheet
    tddtheejueekjeegueeivdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvg
X-ME-Proxy: <xmx:t5YxY1THDWS48myTelQbWRkO5tELFEQqwxFTmBRSkbT9yjFngkp9vQ>
    <xmx:t5YxYxwbp9Cnd7HxGV9roLf_nfaVRIbbzAoAjgZvTjoQ-25oNgQoUw>
    <xmx:t5YxYz5POMAsSOXp7R5mgxmbSsNowYtDkp0ld0cho3S8yoM0htuOhw>
    <xmx:uJYxY6_XBBliy7KcDoLgUBgX0mymCQgynNhg_Towr2bVvy9Esxf7qg>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Sep 2022 08:10:31 -0400 (EDT)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id DE00E104928; Mon, 26 Sep 2022 15:10:27 +0300 (+03)
Date:   Mon, 26 Sep 2022 15:10:27 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        Dionna Amalie Glaze <dionnaglaze@google.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>,
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
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dario Faggioli <dfaggioli@suse.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Marcelo Cerri <marcelo.cerri@canonical.com>,
        tim.gardner@canonical.com,
        Khalid ElMously <khalid.elmously@canonical.com>,
        philip.cox@canonical.com,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-coco@lists.linux.dev, linux-efi <linux-efi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCHv7 02/14] mm: Add support for unaccepted memory
Message-ID: <20220926121027.xc2cgzuiafcssmea@box.shutemov.name>
References: <CAAH4kHa6s3sBRySNu-TZG_6vOaN4KheVy4kvxG5s=wOTDGy2=Q@mail.gmail.com>
 <2981e25e-9cda-518a-9750-b8694f2356b5@amd.com>
 <CAAH4kHbcfnVWNQHf6Mrg__bSFT6196Sx4kno6o0Zo7hsgOgnNw@mail.gmail.com>
 <984e07ed-914f-93ca-a141-3fc8677878e0@intel.com>
 <CAAH4kHawguTEuDVyz1ysSbH0X_mT=SvxLi=UhwEzXM0abbWefg@mail.gmail.com>
 <YxncAElGrPEGRYg1@linux.ibm.com>
 <CAAH4kHaP8JUh0Z4rF83=2RZTGMATT5MHot6rAnAwt79PL64mVQ@mail.gmail.com>
 <YxpCaQARczhZQmq2@linux.ibm.com>
 <f72f7325-adc6-89d5-7cbc-647442308233@amd.com>
 <20220924010302.bwas4zbro37rrxai@box.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220924010302.bwas4zbro37rrxai@box.shutemov.name>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sat, Sep 24, 2022 at 04:03:02AM +0300, Kirill A. Shutemov wrote:
> On Thu, Sep 22, 2022 at 09:31:12AM -0500, Tom Lendacky wrote:
> > On 9/8/22 14:28, Mike Rapoport wrote:
> > > On Thu, Sep 08, 2022 at 09:23:07AM -0700, Dionna Amalie Glaze wrote:
> > > > > 
> > > > > Looks like the first access to the memory map fails, although I think
> > > > > it's not in INIT_LIST_HEAD() but rather in init_page_count().
> > > > > 
> > > > > I'd start with making sure that page_alloc::memmap_alloc() actually returns
> > > > > accepted memory. If you build kernel with CONFIG_DEBUG_VM=y the memory map
> > > > > will poisoned in this function, so my guess is it'd crash there.
> > > > > 
> > > > 
> > > > That's a wonderful hint, thank you! I did not run this test
> > > > CONFIG_DEBUG_VM set, but you think it's possible it could still be
> > > > here?
> > > 
> > > It depends on how you configured your kernel. Say, defconfig does not set
> > > it.
> > > 
> > 
> > I also hit the issue at 256GB. My config is using CONFIG_SPARSEMEM_VMEMMAP
> > and fails in memmap_init_range() when attempting to add the first PFN. It
> > looks like the underlying page that is backing the vmemmap has not been
> > accepted (I receive a #VC 0x404 => page not validated).
> > 
> > Kirill, is this a path that you've looked at? It would appear that somewhere
> > in the vmemmap_populate_hugepages() path, some memory acceptance needs to be
> > done for the pages that are used to back vmemmap. I'm not very familiar with
> > this code, so I'm not sure why everything works for a guest with 255GB of
> > memory, but then fails for a guest with 256GB of memory.
> 
> Hm. I don't have machine that large at hands at the moment. And I have not
> looked at the codepath before.
> 
> I will try to look into the issue.

I'm not able to trigger the bug.

With help of vm.overcommit_memory=1, I was managed boot TDX guest to shell
with 256G and 1T of guest memory just fine.

Any chance it is SEV-SNP specific?

Or maybe there some difference in kernel config? Could you share yours?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
