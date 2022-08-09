Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 626B158D852
	for <lists+linux-efi@lfdr.de>; Tue,  9 Aug 2022 13:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbiHILmx (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 9 Aug 2022 07:42:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230508AbiHILmw (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 9 Aug 2022 07:42:52 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C879B22B3F;
        Tue,  9 Aug 2022 04:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660045371; x=1691581371;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=k+q8/MfB6T1wOsTh6u+efttkxB0NTXmq/yeTF+WM02Y=;
  b=BS8gHBrr8mSU/7/oaXgZFwM0jZ2QfqPh8VfkF7+2HX3k/hHTG0eUi14k
   VSw9K+gK9JzK5jKOEGcQ8c+7wYpyqvOKWnYdeM/QHqo8ZyWijerft4+HB
   BFVgxQhaZ+kLgM8gThn2i9yZuLBVJWM9NTc45bDsZZYPCwDglXHCOdXJk
   XiSWgObzf3ozAcEE+uc/c9A4+279DjY41uw515jXqGwSflR8pSUtHq0vs
   RtWN8HblbDebpEorFJq8e9fcAY05EwZTcpw2MoCHg34jKKGqKD8x5IxIk
   3PJjC43I1aITMP114VfOVDe2zlnmjrcKCb6bpa8NLQl6nMfJ8ERbzdzqJ
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10433"; a="316743304"
X-IronPort-AV: E=Sophos;i="5.93,224,1654585200"; 
   d="scan'208";a="316743304"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2022 04:42:51 -0700
X-IronPort-AV: E=Sophos;i="5.93,224,1654585200"; 
   d="scan'208";a="707796787"
Received: from labukara-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.251.214.212])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2022 04:42:45 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 867B1103886; Tue,  9 Aug 2022 14:45:44 +0300 (+03)
Date:   Tue, 9 Aug 2022 14:45:44 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Andy Lutomirski <luto@kernel.org>,
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
        Dave Hansen <dave.hansen@intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        x86@kernel.org, linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv7 14/14] x86/tdx: Add unaccepted memory support
Message-ID: <20220809114544.q4f7cetqgv2gj5tx@box.shutemov.name>
References: <20220614120231.48165-1-kirill.shutemov@linux.intel.com>
 <20220614120231.48165-15-kirill.shutemov@linux.intel.com>
 <Yt//ZMrxtTwtKBqu@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yt//ZMrxtTwtKBqu@zn.tnic>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Jul 26, 2022 at 04:51:16PM +0200, Borislav Petkov wrote:
> On Tue, Jun 14, 2022 at 03:02:31PM +0300, Kirill A. Shutemov wrote:
> > +static bool is_tdx_guest(void)
> > +{
> > +	static bool once;
> > +	static bool is_tdx;
> > +
> > +	if (!IS_ENABLED(CONFIG_INTEL_TDX_GUEST))
> > +		return false;
> > +
> > +	if (!once) {
> > +		u32 eax, sig[3];
> > +
> > +		cpuid_count(TDX_CPUID_LEAF_ID, 0, &eax,
> > +			    &sig[0], &sig[2],  &sig[1]);
> > +		is_tdx = !memcmp(TDX_IDENT, sig, sizeof(sig));
> > +		once = true;
> > +	}
> > +
> > +	return is_tdx;
> > +}
> 
> early_tdx_detect() already calls this CPUID function. It assigns
> function pointers too.
> 
> So why can't you assign an accept_memory() function pointer there and
> get rid of this sprinkled if (tdx) everywhere?

This code called from EFI stub which runs before decompressor code and
therefore before early_tdx_detect().

> > diff --git a/arch/x86/boot/compressed/tdx.c b/arch/x86/boot/compressed/tdx.c
> > index 918a7606f53c..8518a75e5dd5 100644
> > --- a/arch/x86/boot/compressed/tdx.c
> > +++ b/arch/x86/boot/compressed/tdx.c
> > @@ -3,12 +3,15 @@
> >  #include "../cpuflags.h"
> >  #include "../string.h"
> >  #include "../io.h"
> > +#include "align.h"
> >  #include "error.h"
> > +#include "pgtable_types.h"
> >  
> >  #include <vdso/limits.h>
> >  #include <uapi/asm/vmx.h>
> >  
> >  #include <asm/shared/tdx.h>
> > +#include <asm/page_types.h>
> >  
> >  /* Called from __tdx_hypercall() for unrecoverable failure */
> >  void __tdx_hypercall_failed(void)
> > @@ -75,3 +78,78 @@ void early_tdx_detect(void)
> >  	pio_ops.f_outb = tdx_outb;
> >  	pio_ops.f_outw = tdx_outw;
> >  }
> > +
> > +static unsigned long try_accept_one(phys_addr_t start, unsigned long len,
> > +				    enum pg_level level)
> 
> That's pretty much a copy of the same function in arch/x86/coco/tdx/tdx.c.
> 
> Yeah, you need a tdx-shared.c which you include in both places just like
> it is done with sev-shared.c

Okay, will look into this.

> > +		accept_size = try_accept_one(start, len, PG_LEVEL_1G);
> > +		if (!accept_size)
> > +			accept_size = try_accept_one(start, len, PG_LEVEL_2M);
> > +		if (!accept_size)
> > +			accept_size = try_accept_one(start, len, PG_LEVEL_4K);
> > +		if (!accept_size)
> > +			error("Accepting memory failed\n");
> > +		start += accept_size;
> 
> This series of calls to try_accept_one() appear in at least three
> places. Please carve them out into a separate function can put it in
> tdx-shared.c.

Okay.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
