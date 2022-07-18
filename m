Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7A8E57883C
	for <lists+linux-efi@lfdr.de>; Mon, 18 Jul 2022 19:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231687AbiGRRV7 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 18 Jul 2022 13:21:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235078AbiGRRV6 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 18 Jul 2022 13:21:58 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A2F20188;
        Mon, 18 Jul 2022 10:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658164917; x=1689700917;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XQ2y1/VlwCd334Ie2B6PhFqb8Le129sl7rpEk9foass=;
  b=frHo065UwpAQkSQjfVbMyWLapZKBCBIWzErg1qnew1r9jSq6OBJu/NT8
   GCP5oAPLEFKLpQcVhZuBg1VBat5Xgj2HPRiQKpH4GzPzJfW+m5k+j84h6
   QpSee1HOGnYPVZ4avO9yVYdqg7YGqCncwJTmRxUTvuuo9ScpQ8UPdslLH
   kLahsxJAidAOR9LhsdXNo73w10Zh5DSDQjSXcM5Ib2LznGz9Lr8EA+75r
   Fmnp+0V74HuH0koBPNAayThKDln7HYFr35RZQVlq9fxi30hS7XYWaJIaK
   DJE9LoeNnSIwY+/Y10ZFmnjbcFX+oUJ1bHNIlAciW+j1ldJgZDhpQbpsT
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10412"; a="350235845"
X-IronPort-AV: E=Sophos;i="5.92,281,1650956400"; 
   d="scan'208";a="350235845"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2022 10:21:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,281,1650956400"; 
   d="scan'208";a="655374923"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 18 Jul 2022 10:21:50 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 4FE9410E; Mon, 18 Jul 2022 20:21:59 +0300 (EEST)
Date:   Mon, 18 Jul 2022 20:21:59 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Peter Gonda <pgonda@google.com>, Borislav Petkov <bp@alien8.de>,
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
        Dave Hansen <dave.hansen@intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Marcelo Cerri <marcelo.cerri@canonical.com>,
        tim.gardner@canonical.com,
        Khalid ElMously <khalid.elmously@canonical.com>,
        philip.cox@canonical.com,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-coco@lists.linux.dev, linux-efi <linux-efi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv7 00/14] mm, x86/cc: Implement support for unaccepted
 memory
Message-ID: <20220718172159.4vwjzrfthelovcty@black.fi.intel.com>
References: <20220614120231.48165-1-kirill.shutemov@linux.intel.com>
 <CAMkAt6osbEGBFrgn=y1=x4mDHC1aL40BwaW0NdGHF8qmWd7ktA@mail.gmail.com>
 <20220627113019.3q62luiay7izhehr@black.fi.intel.com>
 <CAMj1kXHD5XBAS1aBjzg1RCeK6qgtanUSED_xyTZ0v1j+UShMKw@mail.gmail.com>
 <20220627122230.7eetepoufd5w3lxd@black.fi.intel.com>
 <CAMkAt6oJJaRM_dy=y2BP99VziPriVuA4jAmMc=G7njwJYKFgyg@mail.gmail.com>
 <CAMj1kXHpS2B9Q7AaQ1euGidZUEyR6gfi=e+t1J_Cr8bmK_9mTw@mail.gmail.com>
 <20220627223808.ihgy3epdx6ofll43@black.fi.intel.com>
 <CAMj1kXEdS9SzFZZ4WGH6sR0WDCOgYDZ3Geg6X2sqSnQ-CXXpZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXEdS9SzFZZ4WGH6sR0WDCOgYDZ3Geg6X2sqSnQ-CXXpZA@mail.gmail.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Jun 28, 2022 at 07:17:00PM +0200, Ard Biesheuvel wrote:
> On Tue, 28 Jun 2022 at 00:38, Kirill A. Shutemov
> <kirill.shutemov@linux.intel.com> wrote:
> >
> > On Mon, Jun 27, 2022 at 06:33:51PM +0200, Ard Biesheuvel wrote:
> > > > > > >
> > > > > > > Just as an idea, we can put info into UTS_VERSION which can be read from
> > > > > > > the built bzImage. We have info on SMP and preeption there already.
> > > > > > >
> > > > > >
> > > > > > Instead of hacking this into the binary, couldn't we define a protocol
> > > > > > that the kernel will call from the EFI stub (before EBS()) to identify
> > > > > > itself as an image that understands unaccepted memory, and knows how
> > > > > > to deal with it?
> > > > > >
> > > > > > That way, the firmware can accept all the memory on behalf of the OS
> > > > > > at ExitBootServices() time, unless the OS has indicated there is no
> > > > > > need to do so.
> > > > >
> > > > > I agree it would be better. But I think it would require change to EFI
> > > > > spec, no?
> > > >
> > > > Could this somehow be amended on to the UEFI Specification version 2.9
> > > > change which added all of the unaccepted memory features?
> > > >
> > >
> > > Why would this need a change in the EFI spec? Not every EFI protocol
> > > needs to be in the spec.
> >
> > My EFI knowledge is shallow. Do we do this in other cases?
> >
> 
> The E in EFI means 'extensible' and the whole design of a protocol
> database using GUIDs as identifiers (which will not collide and
> therefore need no a priori coordination when defining them) is
> intended to allow extensions to be defined and implemented in a
> distributed manner.
> 
> Of course, it would be fantastic if we can converge on a protocol that
> all flavors of confidential compute can use, across different OSes, so
> it is generally good if a protocol is defined in *some* shared
> specification. But this doesn't have to be the EFI spec.

I've talked with our firmware expert today and I think we have a problem
with the approach when kernel declaries support of unaccepted memory.

This apporach doesn't work if we include bootloader into the picture: if
EBS() called by bootloader we still cannot know if target kernel supports
unaccepted memory and we return to the square 1.

I think we should make it obvious from a kernel image if it supports
unaccepted memory (with UTS_VERSION or other way).

Any comments?

-- 
 Kirill A. Shutemov
