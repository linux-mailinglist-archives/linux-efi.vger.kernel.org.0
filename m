Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 030EB70560A
	for <lists+linux-efi@lfdr.de>; Tue, 16 May 2023 20:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbjEPSeH (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 16 May 2023 14:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbjEPSeE (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 16 May 2023 14:34:04 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 495D783F2;
        Tue, 16 May 2023 11:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684262043; x=1715798043;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WiNKNJZjFGE/z2NUf2w+RqrYzrUuUbxjZ+jb70aRrI8=;
  b=C9Ujgdf+2Ry4ga9KkB4VH147A2kpiSgMsTaEvTVLBBHeot/qZUmVlHFs
   YSprwuF5nZobiaSuv62wSqbXzZKGkrMMGWyC060BX7UepDvuj5UOsiCek
   MfGCc4YAFj4ugqZ+27ZAZQrWI2pEEP3PmN7jWbKmj9g7vaOcBI3G0PJVe
   k+tPSeIy/rSNwfV+wbWrmFW04yTUSxeqKm5iBao1nZLPkEsp9956haHY9
   4gYjv4N9OSPJRZY+hVYXwDCNThcUebvFr8kPRhxCxhDCHMAV9bYVFmdYR
   SZe1IGmtX14U1lk/M+3aYVkyH6Hfd7O2H2q7oMXrpl4o4UYDeqtClKE9M
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="379743586"
X-IronPort-AV: E=Sophos;i="5.99,278,1677571200"; 
   d="scan'208";a="379743586"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2023 11:34:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="695575469"
X-IronPort-AV: E=Sophos;i="5.99,278,1677571200"; 
   d="scan'208";a="695575469"
Received: from unisar-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.251.219.243])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2023 11:33:55 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 4F38710C8C1; Tue, 16 May 2023 21:33:52 +0300 (+03)
Date:   Tue, 16 May 2023 21:33:52 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
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
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCHv11 6/9] efi/unaccepted: Avoid load_unaligned_zeropad()
 stepping into unaccepted memory
Message-ID: <20230516183352.5fvmqca34cjcv462@box.shutemov.name>
References: <20230513220418.19357-1-kirill.shutemov@linux.intel.com>
 <20230513220418.19357-7-kirill.shutemov@linux.intel.com>
 <CAMj1kXG488uW=dpvbfvdN1fMZVJ3kCZQoW3UVQJW1F2VEXyxHg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXG488uW=dpvbfvdN1fMZVJ3kCZQoW3UVQJW1F2VEXyxHg@mail.gmail.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, May 16, 2023 at 08:08:37PM +0200, Ard Biesheuvel wrote:
> On Sun, 14 May 2023 at 00:04, Kirill A. Shutemov
> <kirill.shutemov@linux.intel.com> wrote:
> >
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
> >
> 
> Does this mean that the kernel maps memory before accepting it? As
> otherwise, I would assume that such an access would page fault inside
> the guest before triggering an exception related to the unaccepted
> state.

Yes, kernel maps all memory into direct mapping whether it is accepted or
not [yet].

The problem is that access of unaccepted memory is not page fault on TDX.
It causes unrecoverable exit to the host so it must not happen to
legitimate accesses, including load_unaligned_zeropad() overshoot.

For context: there's a way configure TDX environment to trigger #VE on
such accesses and it is default. But Linux requires such #VEs to be
disabled as it opens attack vector from the host to the guest: host can
pull any private page from under kernel at any point and trigger such #VE.
If it happens in just a right time in syscall gap or NMI entry code it can
be exploitable.

See also commits 9a22bf6debbf and 373e715e31bf.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
