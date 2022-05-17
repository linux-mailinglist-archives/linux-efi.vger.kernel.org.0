Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F408F52A9ED
	for <lists+linux-efi@lfdr.de>; Tue, 17 May 2022 20:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242131AbiEQSFx (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 17 May 2022 14:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351937AbiEQSF1 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 17 May 2022 14:05:27 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F16151599;
        Tue, 17 May 2022 11:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652810677; x=1684346677;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mMyjDi4hwSid116h3PB/BgQEO9/8AhfI/qetQElWaiI=;
  b=IwDEQMqiOlZBmls+c7mceIkUPkV/ySPHps158G4UdVLTrsl7djxjG8x+
   NuMexlHFbNZsoI8FVAtG6+5SnZZUzgLJMrBgmGTrMLLq0MoqeshpDIuDb
   UfefwEzLHSPLtek1uVFc8Eeubc0JB+XZkhtKUe9SV/gTsn+D2KQSnvDS/
   m7+UuBeLHobYuODJtsjpFdm5hNGpA/9I1aRuYXiO72F3np7DzJrnqOgBE
   LtI2nFEETzMjo/psA1IwaX+BIh19CoEjcGe4hp0J8+AiS711dMDe5aW1A
   pI1k8XTk/sgHt6peAFsWNvYPBs/WixFE0qK37Z5utGjj02BPnHc1dr44v
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10350"; a="251783948"
X-IronPort-AV: E=Sophos;i="5.91,233,1647327600"; 
   d="scan'208";a="251783948"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2022 11:04:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,233,1647327600"; 
   d="scan'208";a="700178885"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 17 May 2022 11:04:19 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id ADE56CE; Tue, 17 May 2022 21:04:19 +0300 (EEST)
Date:   Tue, 17 May 2022 21:04:19 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
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
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        x86@kernel.org, linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCHv6 02/15] mm: Add support for unaccepted memory
Message-ID: <20220517180419.ysqhiyrsa3jns53p@black.fi.intel.com>
References: <20220517153444.11195-1-kirill.shutemov@linux.intel.com>
 <20220517153444.11195-3-kirill.shutemov@linux.intel.com>
 <20220517104516.16fb0be5cb28153104b80654@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220517104516.16fb0be5cb28153104b80654@linux-foundation.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, May 17, 2022 at 10:45:16AM -0700, Andrew Morton wrote:
> On Tue, 17 May 2022 18:34:31 +0300 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com> wrote:
> 
> > UEFI Specification version 2.9 introduces the concept of memory
> > acceptance. Some Virtual Machine platforms, such as Intel TDX or AMD
> > SEV-SNP, require memory to be accepted before it can be used by the
> > guest. Accepting happens via a protocol specific to the Virtual Machine
> > platform.
> > 
> > ...
> >
> > --- a/include/linux/page-flags.h
> > +++ b/include/linux/page-flags.h
> > @@ -928,6 +928,14 @@ static inline bool is_page_hwpoison(struct page *page)
> >  #define PG_offline	0x00000100
> >  #define PG_table	0x00000200
> >  #define PG_guard	0x00000400
> > +#define PG_unaccepted	0x00000800
> 
> "For pages that are never mapped to userspace (and aren't PageSlab),
> page_type may be used."
> 
> Is that true of these pages?

Yes. PG_unaccepted is never set for any allocated page. It is only set for
pages on free lists. It gets cleared in post_alloc_hook().

-- 
 Kirill A. Shutemov
