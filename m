Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4496D55E2D2
	for <lists+linux-efi@lfdr.de>; Tue, 28 Jun 2022 15:36:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbiF0KmP (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 27 Jun 2022 06:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233884AbiF0KmO (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 27 Jun 2022 06:42:14 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74D156424;
        Mon, 27 Jun 2022 03:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656326533; x=1687862533;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sd/cHeGy8jdWVz1qnBVANjV157gqCMkdgO7Xv3oof5I=;
  b=cZuFqAM8KbuYQ6MzeN9j/1XcEagNY5FR6/Sr4lb070nxY1MdK5cRztfl
   lkX3m9sT1GFR/x1cOWdp8PpHAivROuzS5+y0736w8NEc9uEXW1ZuZpuOW
   L7ZdZbAidz6/THlinamhq8azUpxhDgVucXPyhg2Pw6nXmpK0A13hhOp4i
   rEkawS9zLSuTWguyqaxQIaIxZ8XWdhDoGeMPRpuCn6wGuDqRzTOQKl4pZ
   0Cbqg+iIZ4zULsRmGCy/140XyuhaYdluPQZsrdhMIeNO2GXyoe+kS1FQ5
   0U65Xse98QrgZbvYTPM7JxJa5t+W/o+HaRctYIMy9s3SRYNYdAXRU2JlQ
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10390"; a="282511843"
X-IronPort-AV: E=Sophos;i="5.92,226,1650956400"; 
   d="scan'208";a="282511843"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2022 03:42:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,226,1650956400"; 
   d="scan'208";a="622510788"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 27 Jun 2022 03:42:05 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 90E5FD9; Mon, 27 Jun 2022 13:42:11 +0300 (EEST)
Date:   Mon, 27 Jun 2022 13:42:11 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
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
        Varad Gautam <varad.gautam@suse.com>,
        Dario Faggioli <dfaggioli@suse.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        x86@kernel.org, linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv7 14/14] x86/tdx: Add unaccepted memory support
Message-ID: <20220627104211.whyuxx7h5tebrasb@black.fi.intel.com>
References: <20220614120231.48165-1-kirill.shutemov@linux.intel.com>
 <20220614120231.48165-15-kirill.shutemov@linux.intel.com>
 <7c74e86e-295f-0958-cbdf-b54b4ca688dd@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c74e86e-295f-0958-cbdf-b54b4ca688dd@intel.com>
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Jun 24, 2022 at 09:22:03AM -0700, Dave Hansen wrote:
> On 6/14/22 05:02, Kirill A. Shutemov wrote:
> >  static inline void __accept_memory(phys_addr_t start, phys_addr_t end)
> >  {
> >  	/* Platform-specific memory-acceptance call goes here */
> > -	error("Cannot accept memory");
> > +	if (is_tdx_guest())
> > +		tdx_accept_memory(start, end);
> > +	else
> > +		error("Cannot accept memory: unknown platform\n");
> >  }
> 
> There are quite a few of these
> 
> 	if (tdx())
> 		...
> 
> conditions in common code here.  Shouldn't this be something like a
> CC_ATTR_MEM_ACCEPT?
> 
> 	if (cc_platform_has(CC_ATTR_MEM_ACCEPT))
> 		cc_accept_memory(...);
> 	else
> 		error("Cannot accept memory: unknown platform\n");
> 
> I understand that TDX is the first one to the party.  Is this the time
> to add the cc_ infrastructure?

We need if tdx() check *somewhere* as how exactly memory gets accepted is
specific to a particular platform.

There are two callsites where memory acceptance happens. One of them is in
boot stub where we don't have cc_ infrastructure. So it will boil down to
a single cc_accept_memory() that will have 'if tdx()' inside.

I don't see much sense in the exercise. We can as well keep the 'if' in
accept_memory().

-- 
 Kirill A. Shutemov
