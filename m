Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC9107CBFCC
	for <lists+linux-efi@lfdr.de>; Tue, 17 Oct 2023 11:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234965AbjJQJof (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 17 Oct 2023 05:44:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234985AbjJQJo3 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 17 Oct 2023 05:44:29 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D963F9;
        Tue, 17 Oct 2023 02:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697535867; x=1729071867;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8OYWLx8EkOVmmzc/6gfhqaqtgdn7djCvrNPSlhU23rE=;
  b=hramDdnEcNtVy6AKWvv745sFso+Ug60hLVdaHTioWHE8FyFNj/zPRi9D
   dosJ2IaMOQKLdipv6UDoawOhJ4c2QPyFd1VLt1WY1rw1+TfJFj2R9nFs7
   uS5unxQ+ASC4QXYqb6cfBxJaQD5kG2Fi8o75LZsWR1m3MQq4X4PjkVq5w
   jSgAVDxqUnef2QbQi4UECU/u2hyFGPtN/fNxEC/Y+Iy4CLejliZQ8pq/j
   BUHTIeBXpW9Os8QPbZiQeYzAkRmyqufMQsqZTvkNBrHyF+ShKZHjeMfBK
   os8YmTPJJzpB0WkiH6yLHcUev/XThgp5zRGy15ilCSh3N6zJS//skvnZB
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="365097234"
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="365097234"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 02:44:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="826375189"
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="826375189"
Received: from mstanila-mobl1.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.61.109])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 02:44:05 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 2B4B510A1F3; Tue, 17 Oct 2023 12:44:03 +0300 (+03)
Date:   Tue, 17 Oct 2023 12:44:03 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>,
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
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        philip.cox@canonical.com, aarcange@redhat.com, peterx@redhat.com,
        x86@kernel.org, linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@kernel.org, Nikolay Borisov <nik.borisov@suse.com>
Subject: Re: [PATCHv2] efi/unaccepted: Fix soft lockups caused by parallel
 memory acceptance
Message-ID: <20231017094403.g6laxp2c3vwzt2sw@box.shutemov.name>
References: <20231016163122.12855-1-kirill.shutemov@linux.intel.com>
 <ZS15HZqK4hu5NjSh@casper.infradead.org>
 <20231016213932.6cscnn6tsnzsnvmf@box.shutemov.name>
 <CAMj1kXFc31N61=oQayLbnR+CrNT4=bfEisC3fwG4VNq2vJHV5w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXFc31N61=oQayLbnR+CrNT4=bfEisC3fwG4VNq2vJHV5w@mail.gmail.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Oct 17, 2023 at 09:42:13AM +0200, Ard Biesheuvel wrote:
> On Mon, 16 Oct 2023 at 23:39, Kirill A. Shutemov
> <kirill.shutemov@linux.intel.com> wrote:
> >
> > On Mon, Oct 16, 2023 at 06:55:41PM +0100, Matthew Wilcox wrote:
> > > On Mon, Oct 16, 2023 at 07:31:22PM +0300, Kirill A. Shutemov wrote:
> > > >   v2:
> > > >    - Fix deadlock (Vlastimil);
> > > >    - Fix comments (Vlastimil);
> > > >    - s/cond_resched()/cpu_relax()/ -- cond_resched() cannot be called
> > > >      from atomic context;
> > >
> > > Isn't there an implicit cpu_relax() while we're spinning?  Does this
> > > really accomplish anything?
> >
> > You are right. It is useless. I will drop it in v3.
> >
> 
> I can drop that bit when applying the patch.
> 
> One question I have is whether the sequence
> 
> spin_lock_irqsave(&unaccepted_memory_lock, flags);
> ...
> spin_unlock(&unaccepted_memory_lock);
> arch_accept_memory(phys_start, phys_end);
> spin_lock(&unaccepted_memory_lock);
> ...
> spin_unlock_irqrestore(&unaccepted_memory_lock, flags);
> 
> is considered sound and is supported by all architectures?

I am not an locking expert and only tested it on x86. But what potential
issue do you see?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
