Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31A7B7056E0
	for <lists+linux-efi@lfdr.de>; Tue, 16 May 2023 21:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbjEPTQE (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 16 May 2023 15:16:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjEPTQD (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 16 May 2023 15:16:03 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4849B525D;
        Tue, 16 May 2023 12:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684264561; x=1715800561;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kFUQ6MboftdOLOEvZid5f2b59TWc3NhFgO6Ggzr+aXU=;
  b=lxpzhrY+TPvyXsk1sFUsJIe4TxXGMtmX7BbxQMTKceHyDLmgfeNeJNyA
   dHqMrEx9nH8l121ACHSXlM/+NvQdXJ+tQnOnWUmio7e1+LPDCRMUuGAwc
   DK6+RnycM6wKfAaU02Qh76v3twxPwdqjJNeikGMzJjNEkrXScOQDJl6j+
   oCLMsyDdAuTALRljo+6yvzR484V1/2jc/gcRAT90F/EXFsdFju19eH9Lf
   eQlVBC8kZqhw5wW8Dm8ogtDW9w8N64c6Kv1r2wmnfVtXJ4Cx2bar9c+Ej
   A4sE34Y/GsRprMch3buw55qEOvIKRHVydYjV14mdFTYPeO81L+L2bR2i1
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="340941498"
X-IronPort-AV: E=Sophos;i="5.99,278,1677571200"; 
   d="scan'208";a="340941498"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2023 12:16:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="678966984"
X-IronPort-AV: E=Sophos;i="5.99,278,1677571200"; 
   d="scan'208";a="678966984"
Received: from unisar-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.251.219.243])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2023 12:15:52 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id D219F10C8C1; Tue, 16 May 2023 22:15:49 +0300 (+03)
Date:   Tue, 16 May 2023 22:15:49 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Borislav Petkov <bp@alien8.de>,
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
Message-ID: <20230516191549.tjub26jvlqymp27x@box.shutemov.name>
References: <20230513220418.19357-1-kirill.shutemov@linux.intel.com>
 <20230513220418.19357-7-kirill.shutemov@linux.intel.com>
 <CAMj1kXG488uW=dpvbfvdN1fMZVJ3kCZQoW3UVQJW1F2VEXyxHg@mail.gmail.com>
 <6fe42f66-819c-f2c8-176b-759c1c5a9cf5@intel.com>
 <CAMj1kXHE7_PrW44Y073=4orY6yVST+CHEA7KCo_0z_uRLew6fQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXHE7_PrW44Y073=4orY6yVST+CHEA7KCo_0z_uRLew6fQ@mail.gmail.com>
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

On Tue, May 16, 2023 at 08:35:27PM +0200, Ard Biesheuvel wrote:
> On Tue, 16 May 2023 at 20:27, Dave Hansen <dave.hansen@intel.com> wrote:
> >
> > On 5/16/23 11:08, Ard Biesheuvel wrote:
> > >> But, this approach does not work for unaccepted memory. For TDX, a load
> > >> from unaccepted memory will not lead to a recoverable exception within
> > >> the guest. The guest will exit to the VMM where the only recourse is to
> > >> terminate the guest.
> > >>
> > > Does this mean that the kernel maps memory before accepting it? As
> > > otherwise, I would assume that such an access would page fault inside
> > > the guest before triggering an exception related to the unaccepted
> > > state.
> >
> > Yes, the kernel maps memory before accepting it (modulo things like
> > DEBUG_PAGEALLOC).
> >
> 
> OK, and so the architecture stipulates that prefetching or other
> speculative accesses must never deliver exceptions to the host
> regarding such ranges?
> 
> If this all works as it should, then I'm ok with leaving this here,
> but I imagine we may want to factor out some arch specific policy here
> in the future, as I don't think this would work the same on ARM.

Even if other architectures don't need this, it is harmless: we just
accept one unit ahead of time.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
