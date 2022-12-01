Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BDC063EC9C
	for <lists+linux-efi@lfdr.de>; Thu,  1 Dec 2022 10:37:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbiLAJhm (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 1 Dec 2022 04:37:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiLAJhl (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 1 Dec 2022 04:37:41 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE260E7B;
        Thu,  1 Dec 2022 01:37:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id A77CFCE1BB6;
        Thu,  1 Dec 2022 09:37:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75389C43470;
        Thu,  1 Dec 2022 09:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669887451;
        bh=BfOt5syWCVHNIGlCb5w84CIS4Di9VpSeQ2OX3cIcr0g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m/T9mQyWRqPURKZX3ywro3KQASCx/8OPjCwEnX3ONXn1gZnBx+Sf4nS2Tr/dDZE2x
         JyUxtPoL1HCM9kIie8EN+AD1YLaixfOtfzCR1TDv2XoJlmHA1wAEvGMZhzo+0m8Jmb
         /Z2h7e2XFK1uzrzHO/WpDhAwHo/7pP05AeWgSl29p7Q2yjqRtzC8fb3wzrI6OJ1HkZ
         KB8ipJ01wFYCSsMZ0DfDAgXLPcPBCSfVY1M5fIW1FlzEpAGu+s5g2QcDyh2qR9Mg8x
         RYP0Su61tWvN/xP44ZIh2d1yEm7nm1xsw/TWgw2675xlSDvo4WotLTgBYleKetNWad
         mf5S8Ws3o/j6w==
Date:   Thu, 1 Dec 2022 11:37:10 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Borislav Petkov <bp@alien8.de>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
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
        David Hildenbrand <david@redhat.com>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        x86@kernel.org, linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCHv7 08/14] x86/mm: Reserve unaccepted memory bitmap
Message-ID: <Y4h1xsEr7X221EoE@kernel.org>
References: <20220614120231.48165-1-kirill.shutemov@linux.intel.com>
 <20220614120231.48165-9-kirill.shutemov@linux.intel.com>
 <Yt+uwhfA57WBrozb@zn.tnic>
 <20221130012840.sf4rvddzc4ev7bj5@box.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221130012840.sf4rvddzc4ev7bj5@box.shutemov.name>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Nov 30, 2022 at 04:28:40AM +0300, Kirill A. Shutemov wrote:
> On Tue, Jul 26, 2022 at 11:07:14AM +0200, Borislav Petkov wrote:
> > On Tue, Jun 14, 2022 at 03:02:25PM +0300, Kirill A. Shutemov wrote:
> > > diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
> > > index f267205f2d5a..22d1fe48dcba 100644
> > > --- a/arch/x86/kernel/e820.c
> > > +++ b/arch/x86/kernel/e820.c
> > > @@ -1316,6 +1316,16 @@ void __init e820__memblock_setup(void)
> > >  	int i;
> > >  	u64 end;
> > >  
> > > +	/* Mark unaccepted memory bitmap reserved */
> > > +	if (boot_params.unaccepted_memory) {
> > > +		unsigned long size;
> > > +
> > > +		/* One bit per 2MB */
> > > +		size = DIV_ROUND_UP(e820__end_of_ram_pfn() * PAGE_SIZE,
> > > +				    PMD_SIZE * BITS_PER_BYTE);
> > > +		memblock_reserve(boot_params.unaccepted_memory, size);
> > > +	}
> > > +
> > 
> > Hmm, I don't like how this is dropped right in the middle of a unrelated
> > function.
> > 
> > You're adding arch/x86/mm/unaccepted_memory.c later. Why don't you put
> > that chunk in a function there which is called by early_reserve_memory()
> > which does exactly what you want - reserve memory early, before memblock
> > allocations?
> 
> early_reserve_memory() specifically called before e820__memory_setup()
> (see comment in setup_arch()), so we don't have e820_table finalized and
> we need it to get correct RAM size from e820__end_of_ram_pfn().
> 
> I guess we can hide the chunk in a function in unaccepted_memory.c and
> call it from here, but it would require #ifdeffery in a header file as the
> .c is only compiled for CONFIG_UNACCEPTED_MEMORY=y.
> 
> Looks like an overkill to me, no?

Agree. Can we just extend the comment to explain why we reserve the bitmap
at e820__memblock_setup() rather than in early_reserve_memory(), pretty
much with the explanation above?
 
> -- 
>   Kiryl Shutsemau / Kirill A. Shutemov

-- 
Sincerely yours,
Mike.
