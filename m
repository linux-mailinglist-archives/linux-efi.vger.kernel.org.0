Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBD11705982
	for <lists+linux-efi@lfdr.de>; Tue, 16 May 2023 23:33:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230362AbjEPVdD (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 16 May 2023 17:33:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjEPVdD (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 16 May 2023 17:33:03 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF6287A92;
        Tue, 16 May 2023 14:32:56 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 834C932002F9;
        Tue, 16 May 2023 17:32:51 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 16 May 2023 17:32:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1684272771; x=
        1684359171; bh=aQIbBC1XH4gKwubmFlh9PRPXW8iWnwJsnr8qddLaW2A=; b=d
        Toej6CqMPorHZ/HiMHAHV0j0BoSLvt88M9EjjPPLQALhvOYPl8sJVDYkEkATMSQr
        Gnu+vgKt0GS03j6xSQgSkeU+Wzr3NZ4A2eLM365uF7NEoSQYzQ6OK74h4N9WNH2C
        eIpqbO3JGhVr2RpO3IyKd3o2HbiAjEoz7vWgc+dEy4E54NVqhmGjEldwmIL/hAAg
        Llf/LjSF4uLtbv3OIbKb/oGQ0KfoJ+LqFZLmZ2ZXNngMQO4btufKJfYWffr4uYaK
        y4L/znDLmVm7fJ3Tf2MCVfQoazVL2doz4AFfcgEXo8HDI2RYQyusBHm2q3FSeRrp
        UY+33OeQXATi+AeBIh43A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1684272771; x=1684359171; bh=aQIbBC1XH4gKw
        ubmFlh9PRPXW8iWnwJsnr8qddLaW2A=; b=ZzXdJPHVPx2iYYPj1GM9V7VuzcYN4
        xtAHh+yAs5OOiP2Nx6sjK5vNxyK+sFwIzHWZqwmm7FaHHl7IX0h3kiF392+SD8VT
        igNgcEqjSRnGMq/kiUyLI/0GGRDmeEm38kL18VgLH5YvxXbGjh+FiRh9aS5zmL5a
        AEbuces9Hd4WUn7SLKtOp+WpWpp5qbHQbtFmXxoKNtcq0GC5jbcwBjc3Dzp81g0w
        EjWwn0m+w/vB2NiiZ6PcXphNQYMYairdzk7sJNVkVzVRiSFhyzWNnc1oejWcZ4wV
        zErtUZoKdJaFs6liPGe7LTyOZYWlEwy13GEDvXzzwkFz/pxQLKUPTfzbQ==
X-ME-Sender: <xms:gfZjZPSGxguVAGn3X6-LvRGf9K7rUAi6an9Ir3DHSDs7Tfk-HKZlAw>
    <xme:gfZjZAzKrKm-encf_EoQzgi1aWJvxiFmus62R3rqcvdw_mO0U1GJ3zkiUVdmLJ3XU
    DaOYw5DxtYtIVLCnVU>
X-ME-Received: <xmr:gfZjZE0niR6MTUdPM9zx6SYn8Zru4AP6rANgLK-q5hqCZwHjWHIXpq9-mA2EH3X1SKZKPQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeehledgudeivdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttddttddttddvnecuhfhrohhmpedfmfhi
    rhhilhhlucetrdcuufhhuhhtvghmohhvfdcuoehkihhrihhllhesshhhuhhtvghmohhvrd
    hnrghmvgeqnecuggftrfgrthhtvghrnhephfeigefhtdefhedtfedthefghedutddvueeh
    tedttdehjeeukeejgeeuiedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepkhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgv
X-ME-Proxy: <xmx:gfZjZPBVlH8wI-6V1ciD5aOG7zZAoMgw2srtajrQ2iBO8-FIvCfakg>
    <xmx:gfZjZIj74SzvsXGQQ7_xE5d3een8cD92DX9S0FHODSJPpRIGYtY6Sg>
    <xmx:gfZjZDrlenaq9t2mzlxFfl9maniBFrpptzIE-mQU5IOCX4_4YZ-2hg>
    <xmx:g_ZjZHPm0FCn3O-m6gOGafEacffxFa6WEk_D38QTLsfVb3SoCciO1Q>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 May 2023 17:32:49 -0400 (EDT)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id DF2D610C8C1; Wed, 17 May 2023 00:32:45 +0300 (+03)
Date:   Wed, 17 May 2023 00:32:45 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dario Faggioli <dfaggioli@suse.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        aarcange@redhat.com, peterx@redhat.com, x86@kernel.org,
        linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCHv11 1/9] mm: Add support for unaccepted memory
Message-ID: <20230516213245.oruzw2kinbfqcwwl@box.shutemov.name>
References: <20230513220418.19357-1-kirill.shutemov@linux.intel.com>
 <20230513220418.19357-2-kirill.shutemov@linux.intel.com>
 <f8fb2b4f-305f-6873-3ef8-e8d5d45e862d@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f8fb2b4f-305f-6873-3ef8-e8d5d45e862d@amd.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, May 16, 2023 at 02:44:00PM -0500, Tom Lendacky wrote:
> On 5/13/23 17:04, Kirill A. Shutemov wrote:
> > UEFI Specification version 2.9 introduces the concept of memory
> > acceptance. Some Virtual Machine platforms, such as Intel TDX or AMD
> > SEV-SNP, require memory to be accepted before it can be used by the
> > guest. Accepting happens via a protocol specific to the Virtual Machine
> > platform.
> > 
> > There are several ways kernel can deal with unaccepted memory:
> > 
> >   1. Accept all the memory during the boot. It is easy to implement and
> >      it doesn't have runtime cost once the system is booted. The downside
> >      is very long boot time.
> > 
> >      Accept can be parallelized to multiple CPUs to keep it manageable
> >      (i.e. via DEFERRED_STRUCT_PAGE_INIT), but it tends to saturate
> >      memory bandwidth and does not scale beyond the point.
> > 
> >   2. Accept a block of memory on the first use. It requires more
> >      infrastructure and changes in page allocator to make it work, but
> >      it provides good boot time.
> > 
> >      On-demand memory accept means latency spikes every time kernel steps
> >      onto a new memory block. The spikes will go away once workload data
> >      set size gets stabilized or all memory gets accepted.
> > 
> >   3. Accept all memory in background. Introduce a thread (or multiple)
> >      that gets memory accepted proactively. It will minimize time the
> >      system experience latency spikes on memory allocation while keeping
> >      low boot time.
> > 
> >      This approach cannot function on its own. It is an extension of #2:
> >      background memory acceptance requires functional scheduler, but the
> >      page allocator may need to tap into unaccepted memory before that.
> > 
> >      The downside of the approach is that these threads also steal CPU
> >      cycles and memory bandwidth from the user's workload and may hurt
> >      user experience.
> > 
> > The patch implements #1 and #2 for now. #2 is the default. Some
> > workloads may want to use #1 with accept_memory=eager in kernel
> > command line. #3 can be implemented later based on user's demands.
> > 
> > Support of unaccepted memory requires a few changes in core-mm code:
> > 
> >    - memblock has to accept memory on allocation;
> > 
> >    - page allocator has to accept memory on the first allocation of the
> >      page;
> > 
> > Memblock change is trivial.
> > 
> > The page allocator is modified to accept pages. New memory gets accepted
> > before putting pages on free lists. It is done lazily: only accept new
> > pages when we run out of already accepted memory. The memory gets
> > accepted until the high watermark is reached.
> > 
> > EFI code will provide two helpers if the platform supports unaccepted
> > memory:
> > 
> >   - accept_memory() makes a range of physical addresses accepted.
> > 
> >   - range_contains_unaccepted_memory() checks anything within the range
> >     of physical addresses requires acceptance.
> > 
> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > Acked-by: Mike Rapoport <rppt@linux.ibm.com>	# memblock
> > Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> > ---
> >   drivers/base/node.c    |   7 ++
> >   fs/proc/meminfo.c      |   5 ++
> >   include/linux/mm.h     |  19 +++++
> >   include/linux/mmzone.h |   8 ++
> >   mm/internal.h          |   1 +
> >   mm/memblock.c          |   9 +++
> >   mm/mm_init.c           |   7 ++
> >   mm/page_alloc.c        | 173 +++++++++++++++++++++++++++++++++++++++++
> >   mm/vmstat.c            |   3 +
> >   9 files changed, 232 insertions(+)
> > 
> 
> > diff --git a/mm/internal.h b/mm/internal.h
> > index 68410c6d97ac..b1db7ba5f57d 100644
> > --- a/mm/internal.h
> > +++ b/mm/internal.h
> > @@ -1099,4 +1099,5 @@ struct vma_prepare {
> >   	struct vm_area_struct *remove;
> >   	struct vm_area_struct *remove2;
> >   };
> > +
> 
> Looks like an unintentional change.

Yep, will fix.

> >   #endif	/* __MM_INTERNAL_H */
> > diff --git a/mm/memblock.c b/mm/memblock.c
> > index 3feafea06ab2..50b921119600 100644
> > --- a/mm/memblock.c
> > +++ b/mm/memblock.c
> > @@ -1436,6 +1436,15 @@ phys_addr_t __init memblock_alloc_range_nid(phys_addr_t size,
> >   		 */
> >   		kmemleak_alloc_phys(found, size, 0);
> > +	/*
> > +	 * Some Virtual Machine platforms, such as Intel TDX or AMD SEV-SNP,
> > +	 * require memory to be accepted before it can be used by the
> > +	 * guest.
> > +	 *
> > +	 * Accept the memory of the allocated buffer.
> > +	 */
> > +	accept_memory(found, found + size);
> 
> I'm not an mm or memblock expert, but do we need to worry about freed memory
> from memblock_phys_free() being possibly doubly accepted? A double
> acceptance will trigger a guest termination on SNP.

There will be no double acceptance. accept_memory() will consult the
bitmap before accepting any memory. For already accepted memory it is a
nop.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
