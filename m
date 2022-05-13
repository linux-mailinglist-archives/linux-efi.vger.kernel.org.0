Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87D89526525
	for <lists+linux-efi@lfdr.de>; Fri, 13 May 2022 16:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381516AbiEMOqw (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 13 May 2022 10:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381622AbiEMOqG (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 13 May 2022 10:46:06 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ACC33E0F5;
        Fri, 13 May 2022 07:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652453124; x=1683989124;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oe4RvQVrbAkDL0kypbBx+ih7yeuE1vnJ1rTohZdq0BI=;
  b=aeIK4GQyl51l9WEglCrUXCqlgKyawavRKr1XeSU3LUbnfmqOx0QnJHzA
   KNQ9Jx9KoAEm0Nu7aCMCs7Pw85YpTPshzqbLE8zFAFgTE9omsFhPDMtXM
   rRunCiYkGQ5IUOOk+ywPQJjmFpHay/yoC2f7+hT0MnSBDaEmawz3N+R49
   enkUsxac8a9osGJbhVWycOqS4Y8wjrY1EVobtyu+kJCwcylB0dOtwcW7s
   ZQEPurG0EJ9hqW5hel6JmS/Zatn1GqnWMKpOJQC6Zltiz1kWGgDL56x0K
   1eZizkGAiHyqnRz5C0BqqyV+XN/XKMol38cixySgKtiBcz/Ofgp+T0tnh
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10346"; a="356747503"
X-IronPort-AV: E=Sophos;i="5.91,223,1647327600"; 
   d="scan'208";a="356747503"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2022 07:45:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,223,1647327600"; 
   d="scan'208";a="603862328"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 13 May 2022 07:45:15 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 2FF2D147; Fri, 13 May 2022 17:45:15 +0300 (EEST)
Date:   Fri, 13 May 2022 17:45:15 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Borislav Petkov <bp@suse.de>, Min Xu <min.m.xu@intel.com>,
        Jiaqi Gao <jiaqi.gao@intel.com>
Cc:     Dionna Amalie Glaze <dionnaglaze@google.com>,
        Michael Roth <michael.roth@amd.com>,
        Borislav Petkov <bp@alien8.de>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Andy Lutomirski <luto@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
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
        David Hildenbrand <david@redhat.com>, x86@kernel.org,
        linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv5 06/12] x86/boot/compressed: Handle unaccepted memory
Message-ID: <20220513144515.fx2cvo3rjued3vy5@black.fi.intel.com>
References: <20220425033934.68551-1-kirill.shutemov@linux.intel.com>
 <20220425033934.68551-7-kirill.shutemov@linux.intel.com>
 <YnE4ZzzVrxUnr3Uv@zn.tnic>
 <20220506153013.e6v4q2qhuhqumfiu@box.shutemov.name>
 <YnpGnMoviGoK4Ucq@zn.tnic>
 <CAAH4kHYRxgUNnGRUO473q02q3akLzgiTvbA2qKEP5jq6jFV-uA@mail.gmail.com>
 <Yn4ed1gupKmNz2jn@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yn4ed1gupKmNz2jn@zn.tnic>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, May 13, 2022 at 11:01:43AM +0200, Borislav Petkov wrote:
> + mroth
> - brijesh
> 
> On Thu, May 12, 2022 at 10:34:02PM -0700, Dionna Amalie Glaze wrote:
> > Kirill, I've been tracking these changes to see if we can handle the
> > unaccepted memory type for SEV-SNP, but testing has been an issue. The
> > proposed patch in Ovmf to introduce unaccepted memory seems to have
> > stalled out last September
> > (https://www.mail-archive.com/devel@edk2.groups.io/msg35842.html) and
> > is particularly difficult to adapt to SEV-SNP since it doesn't follow
> > the TDVF way of initializing all memory. Is there a different
> > development I might have missed so that we might test these cases?
> > Without the UEFI introducing EFI_UNACCEPTED_MEMORY type, any kernel
> > uses are essentially dead code.

+ Min, Jiaqi.

I don't follow firmware development. Min, Jiaqi, could you comment?

-- 
 Kirill A. Shutemov
