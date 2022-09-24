Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FE975E86E3
	for <lists+linux-efi@lfdr.de>; Sat, 24 Sep 2022 03:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232791AbiIXBDP (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 23 Sep 2022 21:03:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230363AbiIXBDN (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 23 Sep 2022 21:03:13 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C6EA124C0B;
        Fri, 23 Sep 2022 18:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663981392; x=1695517392;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OBLqHu4HrfxZrshSMCaixAcofJF9yzq0ARl2qAoeSc8=;
  b=IaK6lJuBlyv1yFE6WKSNewwcNklMZOU+dDbn+dyJsIze8u33GW0q3cnt
   44yGqHSrd2FlotsJ8glsAE1aFPzAmMH7PijkOXC+4VH9EUtiXQe2FHFJi
   d7NitaJ4nkDzv8yfTQxAOBatp3Ek1oIIJietz8qtIY2tbBS+2arZJM1cB
   TnNpN9syFusVk9SlZZicvUNU5p5U5DZpr6oHleX6xq23ywyX/P7RjH1q0
   HeLIOxIqB205ycw4zwYTu/8flQgiN82Y6y8jrlGqMNRT9wIScuARTqBKD
   A/PFCIGx5XYOI++QxU/sjcdcInC6Ut9IiWmMGLnu8xHhHtCrB8iqsEc7B
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10479"; a="301620728"
X-IronPort-AV: E=Sophos;i="5.93,340,1654585200"; 
   d="scan'208";a="301620728"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2022 18:03:11 -0700
X-IronPort-AV: E=Sophos;i="5.93,340,1654585200"; 
   d="scan'208";a="724350159"
Received: from pameiner-mobl2.amr.corp.intel.com (HELO box.shutemov.name) ([10.252.58.236])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2022 18:03:05 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id D7FE51028F1; Sat, 24 Sep 2022 04:03:02 +0300 (+03)
Date:   Sat, 24 Sep 2022 04:03:02 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     Dionna Amalie Glaze <dionnaglaze@google.com>,
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
Message-ID: <20220924010302.bwas4zbro37rrxai@box.shutemov.name>
References: <20220810141959.ictqchz7josyd7pt@techsingularity.net>
 <CAAH4kHa6s3sBRySNu-TZG_6vOaN4KheVy4kvxG5s=wOTDGy2=Q@mail.gmail.com>
 <2981e25e-9cda-518a-9750-b8694f2356b5@amd.com>
 <CAAH4kHbcfnVWNQHf6Mrg__bSFT6196Sx4kno6o0Zo7hsgOgnNw@mail.gmail.com>
 <984e07ed-914f-93ca-a141-3fc8677878e0@intel.com>
 <CAAH4kHawguTEuDVyz1ysSbH0X_mT=SvxLi=UhwEzXM0abbWefg@mail.gmail.com>
 <YxncAElGrPEGRYg1@linux.ibm.com>
 <CAAH4kHaP8JUh0Z4rF83=2RZTGMATT5MHot6rAnAwt79PL64mVQ@mail.gmail.com>
 <YxpCaQARczhZQmq2@linux.ibm.com>
 <f72f7325-adc6-89d5-7cbc-647442308233@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f72f7325-adc6-89d5-7cbc-647442308233@amd.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Sep 22, 2022 at 09:31:12AM -0500, Tom Lendacky wrote:
> On 9/8/22 14:28, Mike Rapoport wrote:
> > On Thu, Sep 08, 2022 at 09:23:07AM -0700, Dionna Amalie Glaze wrote:
> > > > 
> > > > Looks like the first access to the memory map fails, although I think
> > > > it's not in INIT_LIST_HEAD() but rather in init_page_count().
> > > > 
> > > > I'd start with making sure that page_alloc::memmap_alloc() actually returns
> > > > accepted memory. If you build kernel with CONFIG_DEBUG_VM=y the memory map
> > > > will poisoned in this function, so my guess is it'd crash there.
> > > > 
> > > 
> > > That's a wonderful hint, thank you! I did not run this test
> > > CONFIG_DEBUG_VM set, but you think it's possible it could still be
> > > here?
> > 
> > It depends on how you configured your kernel. Say, defconfig does not set
> > it.
> > 
> 
> I also hit the issue at 256GB. My config is using CONFIG_SPARSEMEM_VMEMMAP
> and fails in memmap_init_range() when attempting to add the first PFN. It
> looks like the underlying page that is backing the vmemmap has not been
> accepted (I receive a #VC 0x404 => page not validated).
> 
> Kirill, is this a path that you've looked at? It would appear that somewhere
> in the vmemmap_populate_hugepages() path, some memory acceptance needs to be
> done for the pages that are used to back vmemmap. I'm not very familiar with
> this code, so I'm not sure why everything works for a guest with 255GB of
> memory, but then fails for a guest with 256GB of memory.

Hm. I don't have machine that large at hands at the moment. And I have not
looked at the codepath before.

I will try to look into the issue.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
