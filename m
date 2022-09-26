Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D34E5EAD1F
	for <lists+linux-efi@lfdr.de>; Mon, 26 Sep 2022 18:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbiIZQtC (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 26 Sep 2022 12:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbiIZQsL (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 26 Sep 2022 12:48:11 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D2BC13F9A;
        Mon, 26 Sep 2022 08:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664206935; x=1695742935;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tM/bAWc4lIOzRDGri9usGwnWw/hVhQodCyKKUpoDK+8=;
  b=jmNwy5DpPJXLlqBrxmv8a7UDyiLrrk+HKInodQ+cOUpBMD1+kIlfMsi+
   VHXRj3I3IX+19gSMh1tlxfWnLQpfRcOX3HcL3rjEtSNQlbPGxwYNMp+9J
   wZuOtc6orcd0ChOFUHpSAAgJ0o6huVmuIl0zmC2dhrKa77LKBxd6S6Nhz
   tzN8XNXpw52NtQ5lrtk2gpJjC9gpm7xLlZFR+L3daN539+9cVh1E5ReC+
   VR/gbLWxhemwbpmzMEhpcb14I+y3YyKDxy18v+YhIlQFJBMO9lBGZxqcn
   3OFwr0nZm2tDxDZvTa3R9BOilrMswH9eA9oxDJsAtc9fR87K89lmNEwm1
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="298661884"
X-IronPort-AV: E=Sophos;i="5.93,346,1654585200"; 
   d="scan'208";a="298661884"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2022 08:42:15 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="710164368"
X-IronPort-AV: E=Sophos;i="5.93,346,1654585200"; 
   d="scan'208";a="710164368"
Received: from hluxenbu-mobl1.ger.corp.intel.com (HELO box.shutemov.name) ([10.249.32.142])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2022 08:42:08 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 64280104928; Mon, 26 Sep 2022 18:42:06 +0300 (+03)
Date:   Mon, 26 Sep 2022 18:42:06 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
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
Message-ID: <20220926154206.skzqxhw23wuaegtk@box.shutemov.name>
References: <CAAH4kHbcfnVWNQHf6Mrg__bSFT6196Sx4kno6o0Zo7hsgOgnNw@mail.gmail.com>
 <984e07ed-914f-93ca-a141-3fc8677878e0@intel.com>
 <CAAH4kHawguTEuDVyz1ysSbH0X_mT=SvxLi=UhwEzXM0abbWefg@mail.gmail.com>
 <YxncAElGrPEGRYg1@linux.ibm.com>
 <CAAH4kHaP8JUh0Z4rF83=2RZTGMATT5MHot6rAnAwt79PL64mVQ@mail.gmail.com>
 <YxpCaQARczhZQmq2@linux.ibm.com>
 <f72f7325-adc6-89d5-7cbc-647442308233@amd.com>
 <20220924010302.bwas4zbro37rrxai@box.shutemov.name>
 <20220926121027.xc2cgzuiafcssmea@box.shutemov.name>
 <6a38e382-b9d6-98a1-d2ca-cd92fdfd8ecd@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a38e382-b9d6-98a1-d2ca-cd92fdfd8ecd@amd.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Sep 26, 2022 at 08:38:34AM -0500, Tom Lendacky wrote:
> On 9/26/22 07:10, Kirill A. Shutemov wrote:
> > On Sat, Sep 24, 2022 at 04:03:02AM +0300, Kirill A. Shutemov wrote:
> > > On Thu, Sep 22, 2022 at 09:31:12AM -0500, Tom Lendacky wrote:
> > > > On 9/8/22 14:28, Mike Rapoport wrote:
> > > > > On Thu, Sep 08, 2022 at 09:23:07AM -0700, Dionna Amalie Glaze wrote:
> > > > > > > 
> > > > > > > Looks like the first access to the memory map fails, although I think
> > > > > > > it's not in INIT_LIST_HEAD() but rather in init_page_count().
> > > > > > > 
> > > > > > > I'd start with making sure that page_alloc::memmap_alloc() actually returns
> > > > > > > accepted memory. If you build kernel with CONFIG_DEBUG_VM=y the memory map
> > > > > > > will poisoned in this function, so my guess is it'd crash there.
> > > > > > > 
> > > > > > 
> > > > > > That's a wonderful hint, thank you! I did not run this test
> > > > > > CONFIG_DEBUG_VM set, but you think it's possible it could still be
> > > > > > here?
> > > > > 
> > > > > It depends on how you configured your kernel. Say, defconfig does not set
> > > > > it.
> > > > > 
> > > > 
> > > > I also hit the issue at 256GB. My config is using CONFIG_SPARSEMEM_VMEMMAP
> > > > and fails in memmap_init_range() when attempting to add the first PFN. It
> > > > looks like the underlying page that is backing the vmemmap has not been
> > > > accepted (I receive a #VC 0x404 => page not validated).
> > > > 
> > > > Kirill, is this a path that you've looked at? It would appear that somewhere
> > > > in the vmemmap_populate_hugepages() path, some memory acceptance needs to be
> > > > done for the pages that are used to back vmemmap. I'm not very familiar with
> > > > this code, so I'm not sure why everything works for a guest with 255GB of
> > > > memory, but then fails for a guest with 256GB of memory.
> > > 
> > > Hm. I don't have machine that large at hands at the moment. And I have not
> > > looked at the codepath before.
> > > 
> > > I will try to look into the issue.
> > 
> > I'm not able to trigger the bug.
> > 
> > With help of vm.overcommit_memory=1, I was managed boot TDX guest to shell
> > with 256G and 1T of guest memory just fine.
> > 
> > Any chance it is SEV-SNP specific?
> 
> There's always a chance. I'll do some more tracing and see what I can find
> to try and be certain.
> 
> > 
> > Or maybe there some difference in kernel config? Could you share yours?
> 
> Yes, I'll send that to you off-list.

Still nothing with your config :/

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
