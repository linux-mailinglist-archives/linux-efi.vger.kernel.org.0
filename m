Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D953F700626
	for <lists+linux-efi@lfdr.de>; Fri, 12 May 2023 13:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240683AbjELK7v (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 12 May 2023 06:59:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240732AbjELK7b (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 12 May 2023 06:59:31 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5166511D88;
        Fri, 12 May 2023 03:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683889172; x=1715425172;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=W/Sy5iEXYzPeG4qafOn/+5F5tHWJJF3o7KWjI2bYvRU=;
  b=IYkzxK3EwfsT9AkqpqGuDwZv8mKvOJMB1kmoDDqa12p9ecD7krLs73Bx
   i3pvSFFyDwRwy+Xq0SHfaeDfX2CsE9fjyFKz+TDY3L8e+ByjbwWp/dBoe
   nXx6kSK0b18RuRJFpdwAqxLm94D5cC0/28OH3B+oxudSVDIoWyPOsK+Dn
   4sfg83Io8WRU7JiCCQ6ZX+BJezQR1YHbBNhL5vnUcyBgSqvEtz0dfEPkZ
   GFw0QdddXGdSQ6OmqoRbW/fgsiT96tRoj49nmwVi9pz/buzhrh5wMRLpc
   rBmjvaUXQWOvKCZgegi8Bdh8aGJyH5pC197uO3ZjGZLreHtaLOzU3N4kX
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="353896773"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="353896773"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2023 03:59:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="694200727"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="694200727"
Received: from akigyosi-mobl3.ger.corp.intel.com (HELO box.shutemov.name) ([10.249.37.101])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2023 03:59:22 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 16E0F10CD92; Fri, 12 May 2023 13:59:19 +0300 (+03)
Date:   Fri, 12 May 2023 13:59:19 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
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
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        aarcange@redhat.com, peterx@redhat.com, x86@kernel.org,
        linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv10 04/11] efi/x86: Implement support for unaccepted memory
Message-ID: <20230512105919.lgy3cvio6m2vcygn@box.shutemov.name>
References: <20230507234618.18067-1-kirill.shutemov@linux.intel.com>
 <20230507234618.18067-5-kirill.shutemov@linux.intel.com>
 <CAMj1kXE26G=HgqBHoJOWF+FyXs7Ryj7VFFY9A+xG7HmUXnb5bg@mail.gmail.com>
 <20230508190043.ouauzbghn27khdy4@box.shutemov.name>
 <CAMj1kXFxw4+opJuq=g2unocitRyKYz_hfrZb-grsZtPwBOyKgw@mail.gmail.com>
 <20230509005634.qtuiodpirexbxu2k@box.shutemov.name>
 <CAMj1kXGZ4j7nShGPoJzTZNa4NDvHnj_arY8XDXzW8cd6G==8Jg@mail.gmail.com>
 <20230512015909.2fj7bmp3ejc3owhs@box.shutemov.name>
 <CAMj1kXHY-uWWgWjv-7wLkKoh9pvgCbEkxHiCBbJa1wt53g5wYg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXHY-uWWgWjv-7wLkKoh9pvgCbEkxHiCBbJa1wt53g5wYg@mail.gmail.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, May 12, 2023 at 09:39:30AM +0200, Ard Biesheuvel wrote:
> Please replace PMD_SIZE with something along the lines of
> EFI_UNACCEPTED_UNIT_SIZE and #define it to PMD_SIZE in
> arch/x86/include/asm/efi.h.
> 
> The comment below about the size of the bitmap vs the size of the
> address space should probably move there as well.

Okay, will do.

> > +void accept_memory(phys_addr_t start, phys_addr_t end)
> > +{
> > +       unsigned long range_start, range_end;
> > +       unsigned long bitmap_size;
> > +       u64 unit_size;
> > +
> > +       if (!unaccepted_table)
> > +               return;
> > +
> > +       unit_size = unaccepted_table->unit_size;
> > +
> > +       /*
> > +        * Only care for the part of the range that is represented
> > +        * in the bitmap.
> > +        */
> > +       if (start < unaccepted_table->phys_base)
> > +               start = unaccepted_table->phys_base;
> > +       if (end < unaccepted_table->phys_base)
> > +               return;
> > +
> > +       /* Translate to offsets from the beginning of the bitmap */
> > +       start -= unaccepted_table->phys_base;
> > +       end -= unaccepted_table->phys_base;
> > +
> > +       /* Make sure not to overrun the bitmap */
> > +       if (end > unaccepted_table->size * unit_size * BITS_PER_BYTE)
> > +               end = unaccepted_table->size * unit_size * BITS_PER_BYTE;
> > +
> 
> Should we warn here?

No. accept_memory() is nop for conventional memory (memblock calls it
unconditionally).

With the fixup, we only allocate bitmap for the range of physical address
space where we have unaccepted memory. So if there's conventional memory
after unaccepted, bitmap will not cover it.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
