Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21EF07286FF
	for <lists+linux-efi@lfdr.de>; Thu,  8 Jun 2023 20:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235116AbjFHSQJ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 8 Jun 2023 14:16:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233419AbjFHSQI (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 8 Jun 2023 14:16:08 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7A5E1FFA;
        Thu,  8 Jun 2023 11:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686248164; x=1717784164;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DdflwQpDpA1mOVcKDeGYRGkKlW7HBM0/W9LRuBMTa7w=;
  b=T6xFiluV045sUDw/YQ8YuL0YXkjFj6CtksAgxH2clCJzxuP+KjxYkpAG
   XUPp2TO5q+cIl+HCg8nOxVMG38jRhkM8dagn3cJcGK8WzCyi6X//5VfeK
   4ut84BB2XWQx1SInQEtdJBy5/kO9TjI2SFenOf9Si1S6Oda9kcjxuWrlF
   ZQTj6i/JrPjLPDfMao/UX1rjoC4DNkQI+ELvcw5m4/xd5TO5zWUo/A85I
   mUThj6fNQe0Ec8mkXVIO8TmIMdyVm1S+nEiJDhllQ7/dxmZwyRaNDEz24
   PRuHOS/MDVzAjKSru2XAvVVCg0CEHFtpc9YWbauNEl/ubEZUeKR8ezJid
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="356261389"
X-IronPort-AV: E=Sophos;i="6.00,227,1681196400"; 
   d="scan'208";a="356261389"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2023 11:15:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="884289643"
X-IronPort-AV: E=Sophos;i="6.00,227,1681196400"; 
   d="scan'208";a="884289643"
Received: from yjiang5-mobl.amr.corp.intel.com (HELO localhost) ([10.144.161.97])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2023 11:15:40 -0700
Date:   Thu, 8 Jun 2023 11:15:40 -0700
From:   Yunhong Jiang <yunhong.jiang@linux.intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Evgeniy Baskov <baskov@ispras.ru>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Peter Jones <pjones@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Dave Young <dyoung@redhat.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Kees Cook <keescook@chromium.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH v5 10/20] x86/decompressor: Call trampoline directly from
 C code
Message-ID: <20230608181540.GA2469@yjiang5-mobl.amr.corp.intel.com>
References: <20230607072342.4054036-1-ardb@kernel.org>
 <20230607072342.4054036-11-ardb@kernel.org>
 <20230607180920.GA3110@yjiang5-mobl.amr.corp.intel.com>
 <CAMj1kXHZx5Qb-XCxNsTV1jh7CSj6aEg8xEhPU6yvFbhYqhzcEA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXHZx5Qb-XCxNsTV1jh7CSj6aEg8xEhPU6yvFbhYqhzcEA@mail.gmail.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Jun 08, 2023 at 10:04:43AM +0200, Ard Biesheuvel wrote:
> On Wed, 7 Jun 2023 at 20:09, Yunhong Jiang
> <yunhong.jiang@linux.intel.com> wrote:
> >
> > On Wed, Jun 07, 2023 at 09:23:32AM +0200, Ard Biesheuvel wrote:
> > > Instead of returning to the asm calling code to invoke the trampoline,
> > > call it straight from the C code that sets the scene. That way, the
> > > struct return type is no longer needed for returning two values, and the
> > > call can be made conditional more cleanly in a subsequent patch.
> > >
> > > Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > > ---
> > >  arch/x86/boot/compressed/head_64.S    | 20 +++-----------
> > >  arch/x86/boot/compressed/pgtable_64.c | 28 ++++++++------------
> > >  2 files changed, 15 insertions(+), 33 deletions(-)
> > >
> ...
> > > diff --git a/arch/x86/boot/compressed/pgtable_64.c b/arch/x86/boot/compressed/pgtable_64.c
> > > index d66639c961b8eeda..1d28ad95ea839531 100644
> > > --- a/arch/x86/boot/compressed/pgtable_64.c
> > > +++ b/arch/x86/boot/compressed/pgtable_64.c
> > > @@ -16,11 +16,6 @@ unsigned int __section(".data") pgdir_shift = 39;
> > >  unsigned int __section(".data") ptrs_per_p4d = 1;
> > >  #endif
> > >
> > > -struct paging_config {
> > > -     unsigned long trampoline_start;
> > > -     unsigned long l5_required;
> > > -};
> > > -
> > >  /* Buffer to preserve trampoline memory */
> > >  static char trampoline_save[TRAMPOLINE_32BIT_SIZE];
> > >
> > > @@ -106,10 +101,10 @@ static unsigned long find_trampoline_placement(void)
> > >       return bios_start - TRAMPOLINE_32BIT_SIZE;
> > >  }
> > >
> > > -struct paging_config paging_prepare(void *rmode)
> > > +asmlinkage void set_paging_levels(void *rmode)
> >
> > Can you please change the refer to paging_prepare() in the comments above also?
> 
> You mean the below, right?
> 
> --- a/arch/x86/boot/compressed/pgtable_64.c
> +++ b/arch/x86/boot/compressed/pgtable_64.c
> @@ -24,7 +24,7 @@ static char trampoline_save[TRAMPOLINE_32BIT_SIZE];
>   * purposes.
>   *
>   * Avoid putting the pointer into .bss as it will be cleared between
> - * paging_prepare() and extract_kernel().
> + * set_paging_levels() and extract_kernel().
>   */
>  unsigned long *trampoline_32bit __section(".data");

Yes.
