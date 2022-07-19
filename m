Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BA5857A992
	for <lists+linux-efi@lfdr.de>; Wed, 20 Jul 2022 00:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231578AbiGSWBd (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 19 Jul 2022 18:01:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231312AbiGSWBc (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 19 Jul 2022 18:01:32 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58B2C5F9BD;
        Tue, 19 Jul 2022 15:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658268091; x=1689804091;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7YsCljn9/plJ4mNS6po3lPvMpYECRfazDmQwYeZV0aM=;
  b=bGfk/AnDg+r0IJIPGqf5PeuPI2/Ekgt5WQKLamVlWT1W+pj1KHZrAXAU
   TqaJRR19xSI16y8SUIQvqzYmx9vyn9Gyo2Vu1GvZ+kafHJ/SdyN6IAM5p
   n5ZaC/TBjlfdUSJffJf/u4+Rif+VHvXf4n/6ScEXU+25o7bKmfVCD/agf
   bghvc/gytg2wpB9twESZk9VV0yKJ+1ncHeA2szahXF5SL8PC/Y1JfzPlO
   cVNWAXj0b4voeT4FyAI4VTQ/oMosCuh+aIILHa3ML7A7bIHoSOYPqzXq2
   kaqgU9dFdaeRtwDFmLOgsl0ziHGox/Zvb2o16JaAFEDgpphQUv2U/asFL
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10413"; a="266396423"
X-IronPort-AV: E=Sophos;i="5.92,285,1650956400"; 
   d="scan'208";a="266396423"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2022 15:01:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,285,1650956400"; 
   d="scan'208";a="924964668"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 19 Jul 2022 15:01:20 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id E322510E; Wed, 20 Jul 2022 01:01:28 +0300 (EEST)
Date:   Wed, 20 Jul 2022 01:01:28 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Borislav Petkov <bp@alien8.de>, Peter Gonda <pgonda@google.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Dionna Amalie Glaze <dionnaglaze@google.com>,
        Andy Lutomirski <luto@kernel.org>,
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
        Varad Gautam <varad.gautam@suse.com>,
        Dario Faggioli <dfaggioli@suse.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Marcelo Cerri <marcelo.cerri@canonical.com>,
        tim.gardner@canonical.com,
        Khalid ElMously <khalid.elmously@canonical.com>,
        philip.cox@canonical.com,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-coco@lists.linux.dev, linux-efi <linux-efi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Yao, Jiewen" <jiewen.yao@intel.com>
Subject: Re: [PATCHv7 00/14] mm, x86/cc: Implement support for unaccepted
 memory
Message-ID: <20220719220128.xl7yo4lk6uxwxilf@black.fi.intel.com>
References: <CAMj1kXEdS9SzFZZ4WGH6sR0WDCOgYDZ3Geg6X2sqSnQ-CXXpZA@mail.gmail.com>
 <20220718172159.4vwjzrfthelovcty@black.fi.intel.com>
 <CAAH4kHYR+VkSJ5J8eWmeaEvstuRz_EuqVQqPfwmp5dhNGRyJwQ@mail.gmail.com>
 <CAAH4kHaHJo4NUb72tHeica4a34hq5u_QP6d6Vuzngf6EqTJ8Aw@mail.gmail.com>
 <CAAH4kHaB2tL+sAn0NAciu5DQeX5hpNkDees=n=f83S=Ph9Y6tw@mail.gmail.com>
 <YtcCWfCQuEsVhH6W@zn.tnic>
 <CAMj1kXEKtcieycyyFMyuLKJK61FgaDwtLieC0N47W1Sa5LaBsA@mail.gmail.com>
 <YtcgxxMyFTReuuRw@zn.tnic>
 <bb7479df-7871-9861-600d-c2fed783b659@intel.com>
 <YtcnQbiRgZPtR+rQ@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YtcnQbiRgZPtR+rQ@zn.tnic>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Jul 19, 2022 at 11:50:57PM +0200, Borislav Petkov wrote:
> On Tue, Jul 19, 2022 at 02:35:45PM -0700, Dave Hansen wrote:
> > They're trying to design something that can (forever) handle guests that
> > might not be able to accept memory. 
> 
> Wait, what?
> 
> If you can't modify those guests to teach them to accept memory, how do
> you add TDX or SNP guest support to them?
> 
> I.e., you need to modify the guests and then you can add memory
> acceptance. Basically, your point below...
> 
> > It's based on the idea that *something* needs to assume control and
> > EFI doesn't have enough information to assume control.
> >
> > I wish we didn't need all this complexity, though.
> > 
> > There are three entities that can influence how much memory is accepted:
> > 
> > 1. The host
> > 2. The guest firmware
> > 3. The guest kernel (or bootloader or something after the firmware)
> > 
> > This whole thread is about how #2 and #3 talk to each other and make
> > sure *someone* does it.
> > 
> > I kinda think we should just take the guest firmware out of the picture.
> >  There are only going to be a few versions of the kernel that can boot
> > under TDX (or SEV-SNP) and *can't* handle unaccepted memory.  It seems a
> > bit silly to design this whole interface for a few versions of the OS
> > that TDX folks tell me can't be used anyway.
> > 
> > I think we should just say if you want to run an OS that doesn't have
> > unaccepted memory support, you can either:
> > 
> > 1. Deal with that at the host level configuration
> > 2. Boot some intermediate thing like a bootloader that does acceptance
> >    before running the stupid^Wunenlightended OS
> > 3. Live with the 4GB of pre-accepted memory you get with no OS work.
> > 
> > Yeah, this isn't convenient for some hosts.  But, really, this is
> > preferable to doing an EFI/OS dance until the end of time.
> 
> Ack. Definitely.

I like it too as it is no-code solution :P

Peter, I'm pretty sure unaccepted memory support hits upstream well before
TDX get adopted widely in production. I think it is pretty reasonable to
deal with it on host side in meanwhile.

Any objections?

-- 
 Kirill A. Shutemov
