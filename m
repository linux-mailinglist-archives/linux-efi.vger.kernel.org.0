Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A840358D843
	for <lists+linux-efi@lfdr.de>; Tue,  9 Aug 2022 13:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231130AbiHILgI (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 9 Aug 2022 07:36:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242932AbiHILff (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 9 Aug 2022 07:35:35 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 887B3248E1;
        Tue,  9 Aug 2022 04:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660044934; x=1691580934;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=ckfaBQEm61O3oz3fOP7g8FRe9wCmN4sKBCyP+R9DJ+E=;
  b=SdAp2v7xREHY8hbPaIsG7yYNdTgpNJotWVlSw46NFNyHwkzrbzwd/rwf
   UnrsPiFH5stjf1MIkRFu4B/bdRaRntj//0CEaIr4otGTDyf3vYbg0kUNE
   MPFiocPveZcrFhPfEbGrFCe+wro4dNr8gsFvfBZQ5dicGE1hUOb0Ae0D8
   PbKCs7ipGi7m1vC1RELfj1vZI04SYU3J0PD+VQ6sJ2Qymk5vKJdlJ5AU8
   IgE1HE/B3YgGEDm4XKgygX0LKYJgQBh9il0bxWBzCvqqQ6G+HLj8sSX0G
   xx918iS4PK8u2dYUscRnL6MmoNgHg+owPHRsRyDXhV1wQfFmUqo7FSy7S
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10433"; a="289568213"
X-IronPort-AV: E=Sophos;i="5.93,224,1654585200"; 
   d="scan'208";a="289568213"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2022 04:35:34 -0700
X-IronPort-AV: E=Sophos;i="5.93,224,1654585200"; 
   d="scan'208";a="747008116"
Received: from labukara-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.251.214.212])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2022 04:35:28 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 86500103886; Tue,  9 Aug 2022 14:38:27 +0300 (+03)
Date:   Tue, 9 Aug 2022 14:38:27 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Borislav Petkov <bp@alien8.de>,
        Sean Christopherson <seanjc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Varad Gautam <varad.gautam@suse.com>,
        Dario Faggioli <dfaggioli@suse.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Marcelo Henrique Cerri <marcelo.cerri@canonical.com>,
        tim.gardner@canonical.com, khalid.elmously@canonical.com,
        philip.cox@canonical.com,
        the arch/x86 maintainers <x86@kernel.org>,
        linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv7 10/14] x86/mm: Avoid load_unaligned_zeropad() stepping
 into unaccepted memory
Message-ID: <20220809113827.fchtnyzy44z5fuis@box.shutemov.name>
References: <20220614120231.48165-1-kirill.shutemov@linux.intel.com>
 <20220614120231.48165-11-kirill.shutemov@linux.intel.com>
 <7cec93c5-3db4-409b-8c1e-bc1f10dd68fc@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7cec93c5-3db4-409b-8c1e-bc1f10dd68fc@www.fastmail.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Jul 26, 2022 at 01:17:13PM -0700, Andy Lutomirski wrote:
> 
> 
> On Tue, Jun 14, 2022, at 5:02 AM, Kirill A. Shutemov wrote:
> > load_unaligned_zeropad() can lead to unwanted loads across page boundaries.
> > The unwanted loads are typically harmless. But, they might be made to
> > totally unrelated or even unmapped memory. load_unaligned_zeropad()
> > relies on exception fixup (#PF, #GP and now #VE) to recover from these
> > unwanted loads.
> >
> > But, this approach does not work for unaccepted memory. For TDX, a load
> > from unaccepted memory will not lead to a recoverable exception within
> > the guest. The guest will exit to the VMM where the only recourse is to
> > terminate the guest.
> 
> Why is unaccepted memory marked present in the direct map in the first place?
> 
> Having kernel code assume that every valid address is followed by
> several bytes of memory that may be read without side effects other than
> #PF also seems like a mistake, but I probably won’t win that fight. But
> sticking guard pages in front of definitely-not-logically present pages
> seems silly to me.  Let’s just not map it.

It would mean no 1G pages in direct mapping for TDX as we accept 2M a
time.

> (What if MMIO memory is mapped next to regular memory?  Doing random
> unaligned reads that cross into MMIO seems unwise.)

MMIO is shared, not unaccpted private. We already handle the situation.
See 1e7769653b06 ("x86/tdx: Handle load_unaligned_zeropad() page-cross to
a shared page").

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
