Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D47758D865
	for <lists+linux-efi@lfdr.de>; Tue,  9 Aug 2022 13:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242874AbiHILvi (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 9 Aug 2022 07:51:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232697AbiHILvh (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 9 Aug 2022 07:51:37 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC18C15FCB;
        Tue,  9 Aug 2022 04:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660045895; x=1691581895;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eDgcat5jz2gPDhDhIYJ5SQ3oYmJhT05bUBFYCgTExWE=;
  b=jubm97hKIGKMHQ2kVDVwxIrF+zt3G0AfnfaL16pa/3x7IKtQyfee1goa
   tzui3e3Nqy/JxqxiU7yzWzw1mj0Ig05m0Zf+NmQCz5WzjfHOPyuSi4G7h
   cgVWc5jiBWVWY88HJjYXf3TCtyhY0omVeCSdl46KBIkBoqmScnky+9cTY
   OH8yVMdhMvbYfXMIY5tTroA3bYHhvGVLJRcB9uYOVv03aTqr7qdp9xsus
   7Y4yejQMTKmC+JErasdalJNbs7YtF5qVtYotIyV/YJuEJBMJhAVJafwI3
   HPrwgqhFGB7HOTZRUF3Sh81bBdFhf/dt6QpqDh/04rheyDuc0IunM9+3o
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10433"; a="316744620"
X-IronPort-AV: E=Sophos;i="5.93,224,1654585200"; 
   d="scan'208";a="316744620"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2022 04:51:35 -0700
X-IronPort-AV: E=Sophos;i="5.93,224,1654585200"; 
   d="scan'208";a="747012231"
Received: from labukara-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.251.214.212])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2022 04:51:29 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 7CAAF103886; Tue,  9 Aug 2022 14:54:27 +0300 (+03)
Date:   Tue, 9 Aug 2022 14:54:27 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Dave Hansen <dave.hansen@intel.com>, Marc Orr <marcorr@google.com>,
        Borislav Petkov <bp@alien8.de>,
        Dionna Amalie Glaze <dionnaglaze@google.com>,
        Peter Gonda <pgonda@google.com>,
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
Message-ID: <20220809115427.bmkbap434oupinq2@box.shutemov.name>
References: <CAMj1kXEKtcieycyyFMyuLKJK61FgaDwtLieC0N47W1Sa5LaBsA@mail.gmail.com>
 <YtcgxxMyFTReuuRw@zn.tnic>
 <bb7479df-7871-9861-600d-c2fed783b659@intel.com>
 <YtcnQbiRgZPtR+rQ@zn.tnic>
 <22d54786-bc12-ecc5-2b37-cbaa56090aa8@intel.com>
 <CAA03e5FMEyswDhoXRJ5U_n9RG4QM524aQYpF4473ydnAVJr1PA@mail.gmail.com>
 <ffb4ae72-7fd4-d2a0-df10-3969cf8ca07f@intel.com>
 <CAMj1kXHEc=vEt=CtfdiPEsUe2i8QogAi+jvtY6h1awo7GZ-nRg@mail.gmail.com>
 <20220809111436.kudwg2nprnnsfvuh@box.shutemov.name>
 <CAMj1kXE67H_cgYbufUxQ7HXg929dFopWH+cKX5ijAdePP8Zt-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXE67H_cgYbufUxQ7HXg929dFopWH+cKX5ijAdePP8Zt-g@mail.gmail.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Aug 09, 2022 at 01:36:00PM +0200, Ard Biesheuvel wrote:
> On Tue, 9 Aug 2022 at 13:11, Kirill A. Shutemov
> <kirill.shutemov@linux.intel.com> wrote:
> >
> > On Sat, Jul 23, 2022 at 01:14:07PM +0200, Ard Biesheuvel wrote:
> > > On Thu, 21 Jul 2022 at 19:13, Dave Hansen <dave.hansen@intel.com> wrote:
> > > >
> > > > On 7/19/22 17:26, Marc Orr wrote:
> > > > > - Dave's suggestion to "2. Boot some intermediate thing like a
> > > > > bootloader that does acceptance ..." is pretty clever! So if upstream
> > > > > thinks this FW-kernel negotiation is not a good direction, maybe we
> > > > > (Google) can pursue this idea to avoid introducing yet another tag on
> > > > > our images.
> > > >
> > > > I'm obviously speaking only for myself here and not for "upstream" as a
> > > > whole, but I clearly don't like the FW/kernel negotiation thing.  It's a
> > > > permanent pain in our necks to solve a very temporary problem.
> > >
> > > EFI is basically our existing embodiment of this fw/kernel negotiation
> > > thing, and iff we need it, I have no objection to using it for this
> > > purpose, i.e., to allow the firmware to infer whether or not it should
> > > accept all available memory on behalf of the OS before exiting boot
> > > services. But if we don't need this, even better.
> >
> > FW/kernel negotiation does not work if there's a boot loader in the middle
> > that does ExitBootServices(). By the time kernel can announce if it
> > supports unaccepted memory there's nobody to announce to.
> >
> 
> Why would you want to support such bootloaders for TDX anyway? TDX
> heavily relies on measured boot abstractions and other things that are
> heavily tied to firmware.

I don't understand it either. And, yet, there's demand for it.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
