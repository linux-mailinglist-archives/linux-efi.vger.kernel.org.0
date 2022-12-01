Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C636463F1F5
	for <lists+linux-efi@lfdr.de>; Thu,  1 Dec 2022 14:48:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231644AbiLANsK (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 1 Dec 2022 08:48:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231655AbiLANsA (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 1 Dec 2022 08:48:00 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57F0A2656F;
        Thu,  1 Dec 2022 05:47:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669902476; x=1701438476;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mTaZIIv3uUc9JYNMsjX+rfZMzd1G+Dsj8zGp0aHQgQI=;
  b=EnaOgte25qubhv2XEuGM5FKgJ1yCdOvew2AfNGfNbYv2R5TDYaZdJ5eW
   cLjpyszi7k+qPIN6/Ke/24WjEwna2zJyxYSy0zIoUFkNSnFQiDnkp5uB6
   aav2M/Ba0SjIzTozhbo/WBGdYyTgFlWA8xfvM8ORIT8fJWlgmOKEkv9vw
   dJJhDiSQ/JjmlO3ePR86sYefTKgRog082LAKOkxtgbjB/1m9OKtcxYTUP
   0dZt865uOrYXtETPEcgCLVP156LxltRN8wNNZg8EFhpobUmqq741/AskC
   T7ToeuU+TLHPPCo0BZPLf8Srot4CelvouilNvXkKcpmvf9fiiOVRNHkr/
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="314385104"
X-IronPort-AV: E=Sophos;i="5.96,209,1665471600"; 
   d="scan'208";a="314385104"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2022 05:47:55 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="677219981"
X-IronPort-AV: E=Sophos;i="5.96,209,1665471600"; 
   d="scan'208";a="677219981"
Received: from ichepiga-mobl1.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.55.59])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2022 05:47:47 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
        id CD4AA109781; Thu,  1 Dec 2022 16:47:44 +0300 (+03)
Date:   Thu, 1 Dec 2022 16:47:44 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
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
Message-ID: <20221201134744.7p3lgw6buv4oqwyn@box.shutemov.name>
References: <20220614120231.48165-1-kirill.shutemov@linux.intel.com>
 <20220614120231.48165-9-kirill.shutemov@linux.intel.com>
 <Yt+uwhfA57WBrozb@zn.tnic>
 <20221130012840.sf4rvddzc4ev7bj5@box.shutemov.name>
 <Y4h1xsEr7X221EoE@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y4h1xsEr7X221EoE@kernel.org>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Dec 01, 2022 at 11:37:10AM +0200, Mike Rapoport wrote:
> On Wed, Nov 30, 2022 at 04:28:40AM +0300, Kirill A. Shutemov wrote:
> > On Tue, Jul 26, 2022 at 11:07:14AM +0200, Borislav Petkov wrote:
> > > On Tue, Jun 14, 2022 at 03:02:25PM +0300, Kirill A. Shutemov wrote:
> > > > diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
> > > > index f267205f2d5a..22d1fe48dcba 100644
> > > > --- a/arch/x86/kernel/e820.c
> > > > +++ b/arch/x86/kernel/e820.c
> > > > @@ -1316,6 +1316,16 @@ void __init e820__memblock_setup(void)
> > > >  	int i;
> > > >  	u64 end;
> > > >  
> > > > +	/* Mark unaccepted memory bitmap reserved */
> > > > +	if (boot_params.unaccepted_memory) {
> > > > +		unsigned long size;
> > > > +
> > > > +		/* One bit per 2MB */
> > > > +		size = DIV_ROUND_UP(e820__end_of_ram_pfn() * PAGE_SIZE,
> > > > +				    PMD_SIZE * BITS_PER_BYTE);
> > > > +		memblock_reserve(boot_params.unaccepted_memory, size);
> > > > +	}
> > > > +
> > > 
> > > Hmm, I don't like how this is dropped right in the middle of a unrelated
> > > function.
> > > 
> > > You're adding arch/x86/mm/unaccepted_memory.c later. Why don't you put
> > > that chunk in a function there which is called by early_reserve_memory()
> > > which does exactly what you want - reserve memory early, before memblock
> > > allocations?
> > 
> > early_reserve_memory() specifically called before e820__memory_setup()
> > (see comment in setup_arch()), so we don't have e820_table finalized and
> > we need it to get correct RAM size from e820__end_of_ram_pfn().
> > 
> > I guess we can hide the chunk in a function in unaccepted_memory.c and
> > call it from here, but it would require #ifdeffery in a header file as the
> > .c is only compiled for CONFIG_UNACCEPTED_MEMORY=y.
> > 
> > Looks like an overkill to me, no?
> 
> Agree. Can we just extend the comment to explain why we reserve the bitmap
> at e820__memblock_setup() rather than in early_reserve_memory(), pretty
> much with the explanation above?

Okay, I will do this:

diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index 49b5164a4cba..62068956bb76 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -1316,7 +1316,14 @@ void __init e820__memblock_setup(void)
 	int i;
 	u64 end;
 
-	/* Mark unaccepted memory bitmap reserved */
+	/*
+	 * Mark unaccepted memory bitmap reserved.
+	 *
+	 * This kind of reservation usually done from early_reserve_memory(),
+	 * but early_reserve_memory() called before e820__memory_setup(), so
+	 * e820_table is not finalized and e820__end_of_ram_pfn() cannot be
+	 * used to get correct RAM size.
+	 */
 	if (boot_params.unaccepted_memory) {
 		unsigned long size;
 
-- 
  Kiryl Shutsemau / Kirill A. Shutemov
