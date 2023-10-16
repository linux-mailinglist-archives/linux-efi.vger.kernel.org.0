Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 808557CB55E
	for <lists+linux-efi@lfdr.de>; Mon, 16 Oct 2023 23:39:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233008AbjJPVjt (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 16 Oct 2023 17:39:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjJPVjs (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 16 Oct 2023 17:39:48 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D29BEA1;
        Mon, 16 Oct 2023 14:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697492387; x=1729028387;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ULxm3ALCvLWzeStCPJp9aHPIk/h52vXh0JSPle2l5F8=;
  b=dwuFOObfkS5fjqi4eRkphnCRq2K8O++02SOUN+JYvK9rTA+NG3NxHrSd
   DiEjChJY50ZJtQ+HAf11yEY3VVnVVlFa9dfGW6Il4o6xrosUIeO6zZv8Z
   14WCHf8zow65TBpxqEDlIo+3EIh8PFSH+xJhGATsVbcmxqPMmBQGufYMx
   QtUbAs63TIH0bTzC/wv66Voe99WKO7LcoBHNo35XdOR5s/+wT1yRF3z29
   FLAvC+vkv34SrjgCFWmAXfNkvBM3h8QhMlZXZ5YNbTHTV8xYA+V2nf/H/
   KBLpnrpcBQMcMiru9kaLOiqX6gop1Mr0TailuhXMs3YijO0ZEvIoBNCVh
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="382863479"
X-IronPort-AV: E=Sophos;i="6.03,230,1694761200"; 
   d="scan'208";a="382863479"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 14:39:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="749425295"
X-IronPort-AV: E=Sophos;i="6.03,230,1694761200"; 
   d="scan'208";a="749425295"
Received: from ranaelna-mobl.amr.corp.intel.com (HELO box.shutemov.name) ([10.251.208.247])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 14:39:35 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id DE88C10A1F3; Tue, 17 Oct 2023 00:39:32 +0300 (+03)
Date:   Tue, 17 Oct 2023 00:39:32 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
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
Message-ID: <20231016213932.6cscnn6tsnzsnvmf@box.shutemov.name>
References: <20231016163122.12855-1-kirill.shutemov@linux.intel.com>
 <ZS15HZqK4hu5NjSh@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZS15HZqK4hu5NjSh@casper.infradead.org>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Oct 16, 2023 at 06:55:41PM +0100, Matthew Wilcox wrote:
> On Mon, Oct 16, 2023 at 07:31:22PM +0300, Kirill A. Shutemov wrote:
> >   v2:
> >    - Fix deadlock (Vlastimil);
> >    - Fix comments (Vlastimil);
> >    - s/cond_resched()/cpu_relax()/ -- cond_resched() cannot be called
> >      from atomic context;
> 
> Isn't there an implicit cpu_relax() while we're spinning?  Does this
> really accomplish anything?

You are right. It is useless. I will drop it in v3.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
