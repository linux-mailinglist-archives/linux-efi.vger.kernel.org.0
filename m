Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B2685E8AF6
	for <lists+linux-efi@lfdr.de>; Sat, 24 Sep 2022 11:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233634AbiIXJgj (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 24 Sep 2022 05:36:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233564AbiIXJgi (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 24 Sep 2022 05:36:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 699119F0E3;
        Sat, 24 Sep 2022 02:36:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 69FE6608C3;
        Sat, 24 Sep 2022 09:36:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DCC7C433C1;
        Sat, 24 Sep 2022 09:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664012193;
        bh=OUuAuEMHOOoW2UUphtHEcJFzOd5jzmKbeMgag01UxIA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MaL/dLau/5/WSqjg4siwpxCmhAP5uMcabVH4UVhiJmA5hJU4pY/EMFC2ZLQOUIYt9
         nBidURuV0BQ2whZCjUUeB4H3eiNVTkiRLHyBQ66+/vxDre6nLPp3uoDujGWRinvM/t
         frEK4ii6zJj9MuJEuQkkiW/dKzyIJQIBz/Snf2qSAYQaGq5yAHzEQywEmWBopjDB/+
         o1wa0++gwS1fdzdSOsttOI+kmDx4Iu3ZMxipqkhUdMrv4X0/7CGjjCh2dXUwKS+S2r
         Fx15OFTbQtaYDBm4kTqvTA7XPCeNRfv9UPDVtYO50XtQ2KAQCl1YNKBYybg9px/QkP
         E6nbHXIsB67rw==
Date:   Sat, 24 Sep 2022 12:36:12 +0300
From:   Mike Rapoport <rppt@kernel.org>
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
Message-ID: <Yy7PjEXfHoR4PYdC@kernel.org>
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
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

I'd add some printks to verify we actually try to accept the allocated
memory. E.g. something like the patch below:

diff --git a/arch/x86/mm/unaccepted_memory.c b/arch/x86/mm/unaccepted_memory.c
index 9ec2304272dc..8f00639facc4 100644
--- a/arch/x86/mm/unaccepted_memory.c
+++ b/arch/x86/mm/unaccepted_memory.c
@@ -22,6 +22,9 @@ void accept_memory(phys_addr_t start, phys_addr_t end)
 	if (!boot_params.unaccepted_memory)
 		return;
 
+	if (system_state == SYSTEM_BOOTING)
+		pr_info("%s: start: %pa end: %pa %pS\n", __func__, &start, &end, (void *)_RET_IP_);
+
 	bitmap = __va(boot_params.unaccepted_memory);
 	range_start = start / PMD_SIZE;
 
diff --git a/mm/memblock.c b/mm/memblock.c
index a1f7f8b304d5..029dd520102d 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -1535,7 +1535,7 @@ void * __init memblock_alloc_exact_nid_raw(
 			phys_addr_t min_addr, phys_addr_t max_addr,
 			int nid)
 {
-	memblock_dbg("%s: %llu bytes align=0x%llx nid=%d from=%pa max_addr=%pa %pS\n",
+	pr_info("%s: %llu bytes align=0x%llx nid=%d from=%pa max_addr=%pa %pS\n",
 		     __func__, (u64)size, (u64)align, nid, &min_addr,
 		     &max_addr, (void *)_RET_IP_);
 
@@ -1567,7 +1567,7 @@ void * __init memblock_alloc_try_nid_raw(
 			phys_addr_t min_addr, phys_addr_t max_addr,
 			int nid)
 {
-	memblock_dbg("%s: %llu bytes align=0x%llx nid=%d from=%pa max_addr=%pa %pS\n",
+	pr_info("%s: %llu bytes align=0x%llx nid=%d from=%pa max_addr=%pa %pS\n",
 		     __func__, (u64)size, (u64)align, nid, &min_addr,
 		     &max_addr, (void *)_RET_IP_);
 
 
> -- 
>   Kiryl Shutsemau / Kirill A. Shutemov
> 

-- 
Sincerely yours,
Mike.
