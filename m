Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0242E72065B
	for <lists+linux-efi@lfdr.de>; Fri,  2 Jun 2023 17:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235354AbjFBPhP (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 2 Jun 2023 11:37:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235527AbjFBPhO (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 2 Jun 2023 11:37:14 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00DDC10CB;
        Fri,  2 Jun 2023 08:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685720214; x=1717256214;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0hPfuYfoMsRqAkRODqVWIZIMn7IYodqWK7v0iX9b+kc=;
  b=KrQLEiWGLYMFsITN7R0zoEKT9A3oEjYke5yhLDBDk2WBuxvs7yOdWfAp
   7Tniai8t1EsuEGSsO1IYYnDrIOB0g8rMOBGFBdMIXOG4J8X6iCnTybDt3
   CnnzqDaJyxs4btG3XxPLxO7WViBRfVuhoxrr0vbQyBJk+SBrIGQ+LCNj6
   yNF/Bb34rGqFE03K+mn4IglE7piPudse/+1D1eWWT47GyG2j+0CPydS/L
   BIEmMDbcwIivzUcMhko24dxxff5KjV94dZE6RMRevtb+Q2yOX+sa/MDQE
   L2GvWYbPgqbsUgnQH7iPJ4TlsxP7Sg5qvaVOkyYPkF8Ef7AFzUeLygqYQ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10729"; a="442274003"
X-IronPort-AV: E=Sophos;i="6.00,213,1681196400"; 
   d="scan'208";a="442274003"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2023 08:36:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10729"; a="852202671"
X-IronPort-AV: E=Sophos;i="6.00,213,1681196400"; 
   d="scan'208";a="852202671"
Received: from sovanbis-mobl1.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.46.229])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2023 08:36:47 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id D02AE10E1DE; Fri,  2 Jun 2023 18:36:44 +0300 (+03)
Date:   Fri, 2 Jun 2023 18:36:44 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Borislav Petkov <bp@alien8.de>, Ard Biesheuvel <ardb@kernel.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
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
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        aarcange@redhat.com, peterx@redhat.com, x86@kernel.org,
        linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Liam Merwick <liam.merwick@oracle.com>
Subject: Re: [PATCHv13 4/9] x86/boot/compressed: Handle unaccepted memory
Message-ID: <20230602153644.cbdicj2cc6p6goh3@box.shutemov.name>
References: <20230601182543.19036-1-kirill.shutemov@linux.intel.com>
 <20230601182543.19036-5-kirill.shutemov@linux.intel.com>
 <20230602140641.GKZHn3caQpYveKxFgU@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230602140641.GKZHn3caQpYveKxFgU@fat_crate.local>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Jun 02, 2023 at 04:06:41PM +0200, Borislav Petkov wrote:
> On Thu, Jun 01, 2023 at 09:25:38PM +0300, Kirill A. Shutemov wrote:
> > diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
> > index 454757fbdfe5..749f0fe7e446 100644
> > --- a/arch/x86/boot/compressed/kaslr.c
> > +++ b/arch/x86/boot/compressed/kaslr.c
> > @@ -672,6 +672,28 @@ static bool process_mem_region(struct mem_vector *region,
> >  }
> >  
> >  #ifdef CONFIG_EFI
> > +
> > +/*
> > + * Only EFI_CONVENTIONAL_MEMORY and EFI_UNACCEPTED_MEMORY (if supported) are
> > + * guaranteed to be free.
> > + *
> > + * It is more conservative in picking free memory than the EFI spec allows:
> 
> "Pick free memory more conservatively than the EFI spec allows:
> EFI_BOOT_SERVICES_ ..."

Okay.

> > + *
> > + * According to the spec, EFI_BOOT_SERVICES_{CODE|DATA} are also free memory
> > + * and thus available to place the kernel image into, but in practice there's
> > + * firmware where using that memory leads to crashes.
> 
> ... because that firmware still scratches into that memory or why?

I moved the existing comment. I don't have have any context beyond that.

Relevant commit: 0982adc74673 ("x86/boot/KASLR: Work around firmware bugs
by excluding EFI_BOOT_SERVICES_* and EFI_LOADER_* from KASLR's choice")

Ard, do you have anything to add here?

> > + */
> > +static inline bool memory_type_is_free(efi_memory_desc_t *md)
> > +{
> > +	if (md->type == EFI_CONVENTIONAL_MEMORY)
> > +		return true;
> > +
> > +	if (md->type == EFI_UNACCEPTED_MEMORY)
> > +		return IS_ENABLED(CONFIG_UNACCEPTED_MEMORY);
> 
> Make it plan and simple:
> 
> 	if (IS_ENABLED(CONFIG_UNACCEPTED_MEMORY) &&
> 	    md->type == EFI_UNACCEPTED_MEMORY)
> 		return true;

I don't see why it is simpler. It looks unnecessary noisy to me.

But okay.

> > +
> > +	return false;
> > +}
> > +
> >  /*
> >   * Returns true if we processed the EFI memmap, which we prefer over the E820
> >   * table if it is available.
> > @@ -716,18 +738,7 @@ process_efi_entries(unsigned long minimum, unsigned long image_size)
> >  	for (i = 0; i < nr_desc; i++) {
> >  		md = efi_early_memdesc_ptr(pmap, e->efi_memdesc_size, i);
> >  
> > -		/*
> > -		 * Here we are more conservative in picking free memory than
> > -		 * the EFI spec allows:
> > -		 *
> > -		 * According to the spec, EFI_BOOT_SERVICES_{CODE|DATA} are also
> > -		 * free memory and thus available to place the kernel image into,
> > -		 * but in practice there's firmware where using that memory leads
> > -		 * to crashes.
> > -		 *
> > -		 * Only EFI_CONVENTIONAL_MEMORY is guaranteed to be free.
> > -		 */
> > -		if (md->type != EFI_CONVENTIONAL_MEMORY)
> > +		if (!memory_type_is_free(md))
> >  			continue;
> >  
> >  		if (efi_soft_reserve_enabled() &&
> > diff --git a/arch/x86/boot/compressed/mem.c b/arch/x86/boot/compressed/mem.c
> > index 67594fcb11d9..4ecf26576a77 100644
> > --- a/arch/x86/boot/compressed/mem.c
> > +++ b/arch/x86/boot/compressed/mem.c
> > @@ -1,9 +1,40 @@
> >  // SPDX-License-Identifier: GPL-2.0-only
> >  
> >  #include "error.h"
> > +#include "misc.h"
> >  
> >  void arch_accept_memory(phys_addr_t start, phys_addr_t end)
> >  {
> >  	/* Platform-specific memory-acceptance call goes here */
> >  	error("Cannot accept memory");
> >  }
> > +
> > +void init_unaccepted_memory(void)
> > +{
> > +	guid_t guid =  LINUX_EFI_UNACCEPTED_MEM_TABLE_GUID;
> 
> An additional space after the "=".

Okay.

> > +	struct efi_unaccepted_memory *unaccepted_table;
> > +	unsigned long cfg_table_pa;
> > +	unsigned int cfg_table_len;
> > +	enum efi_type et;
> > +	int ret;
> > +
> > +	et = efi_get_type(boot_params);
> > +	if (et == EFI_TYPE_NONE)
> > +		return;
> > +
> > +	ret = efi_get_conf_table(boot_params, &cfg_table_pa, &cfg_table_len);
> > +	if (ret)
> > +		error("EFI config table not found.");
> 
> What's the point in erroring out here?

Configuration table suppose to be present, even if unaccepted memory is
not supported. Something is very wrong if it is missing.

I will downgrade it warn().

> > +	unaccepted_table = (void *)efi_find_vendor_table(boot_params,
> > +							 cfg_table_pa,
> > +							 cfg_table_len,
> > +							 guid);
> > +	if (!unaccepted_table)
> > +		return;
> > +
> > +	if (unaccepted_table->version != 1)
> > +		error("Unknown version of unaccepted memory table\n");
> > +
> > +	set_unaccepted_table(unaccepted_table);
> 
> Why is this a function at all and not a simple assignment?

I wanted to keep unaccepted_table private to the libstub/unaccepted_memory.c.
The setter provides a good spot for documentation to guide unaccepted
memory enablers for other archs.

Still want replace it with direct assignment?

> 
> > diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
> > index 014ff222bf4b..36535a3753f5 100644
> > --- a/arch/x86/boot/compressed/misc.c
> > +++ b/arch/x86/boot/compressed/misc.c
> > @@ -455,6 +455,13 @@ asmlinkage __visible void *extract_kernel(void *rmode, memptr heap,
> >  #endif
> >  
> >  	debug_putstr("\nDecompressing Linux... ");
> > +
> > +	if (IS_ENABLED(CONFIG_UNACCEPTED_MEMORY)) {
> > +		debug_putstr("Accepting memory... ");
> 
> This needs to happen...
> 
> > +		init_unaccepted_memory();
> 
> ... after the init, after the init has parsed the config table and has
> found unaccepted memory.
> 
> If not, you don't need to issue anything as that would be wrong.

Okay, I will make init_unaccepted_memory() return true if unaccepted
memory is present and hide defined it always-false for !UNACCEPTED_MEMORY.
So this hunk will look this way:

	if (init_unaccepted_memory()) {
		debug_putstr("Accepting memory... ");
		accept_memory(__pa(output), __pa(output) + needed_size);
	}

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
