Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 321A455DF92
	for <lists+linux-efi@lfdr.de>; Tue, 28 Jun 2022 15:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242725AbiF0WiX (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 27 Jun 2022 18:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243039AbiF0WiM (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 27 Jun 2022 18:38:12 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDBC310F1;
        Mon, 27 Jun 2022 15:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656369490; x=1687905490;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=t0fJ1EB2Kg/aNY0pT1VtDftqiRsIkXLbIkW27zDJlwM=;
  b=HqW6K+Euarlnhkn4SoFUnMHaDoVWjvVhuX3RMWNlUagTgBQqn5vh2qyF
   Ts+qi2XMY+Y+7jCKJsK2GKp3isxPa9M/dPTWT1eT0Vt+nLX+XuLYM4R6L
   VS6+M7fkdEhrLpeQ8qev9PTYYBgh1aXx8XQoyZHGNLlVycMPthANpR8lt
   gtHS2ReGbbLJ8UHaA5SVNVyMkfFRUt8ZDJfkW1ucqV80fGoerDG0+QgeT
   a3V3SQVEQvJapkZeHw+3VKkblftLNUsm3yPodo64hK55/hTWcXHjKgfnK
   qnBT2qmPwn30lm/7mSewXIg3vWCsgCZ7ePghWIPoyBmKo85bbC/qsnjiy
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10391"; a="270324317"
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="270324317"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2022 15:38:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="766943905"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 27 Jun 2022 15:38:03 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 1AEF7D9; Tue, 28 Jun 2022 01:38:08 +0300 (EEST)
Date:   Tue, 28 Jun 2022 01:38:08 +0300
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
Message-ID: <20220627223808.ihgy3epdx6ofll43@black.fi.intel.com>
References: <20220614120231.48165-1-kirill.shutemov@linux.intel.com>
 <CAMkAt6osbEGBFrgn=y1=x4mDHC1aL40BwaW0NdGHF8qmWd7ktA@mail.gmail.com>
 <20220627113019.3q62luiay7izhehr@black.fi.intel.com>
 <CAMj1kXHD5XBAS1aBjzg1RCeK6qgtanUSED_xyTZ0v1j+UShMKw@mail.gmail.com>
 <20220627122230.7eetepoufd5w3lxd@black.fi.intel.com>
 <CAMkAt6oJJaRM_dy=y2BP99VziPriVuA4jAmMc=G7njwJYKFgyg@mail.gmail.com>
 <CAMj1kXHpS2B9Q7AaQ1euGidZUEyR6gfi=e+t1J_Cr8bmK_9mTw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXHpS2B9Q7AaQ1euGidZUEyR6gfi=e+t1J_Cr8bmK_9mTw@mail.gmail.com>
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Jun 27, 2022 at 06:33:51PM +0200, Ard Biesheuvel wrote:
> > > > >
> > > > > Just as an idea, we can put info into UTS_VERSION which can be read from
> > > > > the built bzImage. We have info on SMP and preeption there already.
> > > > >
> > > >
> > > > Instead of hacking this into the binary, couldn't we define a protocol
> > > > that the kernel will call from the EFI stub (before EBS()) to identify
> > > > itself as an image that understands unaccepted memory, and knows how
> > > > to deal with it?
> > > >
> > > > That way, the firmware can accept all the memory on behalf of the OS
> > > > at ExitBootServices() time, unless the OS has indicated there is no
> > > > need to do so.
> > >
> > > I agree it would be better. But I think it would require change to EFI
> > > spec, no?
> >
> > Could this somehow be amended on to the UEFI Specification version 2.9
> > change which added all of the unaccepted memory features?
> >
> 
> Why would this need a change in the EFI spec? Not every EFI protocol
> needs to be in the spec.

My EFI knowledge is shallow. Do we do this in other cases?

-- 
 Kirill A. Shutemov
