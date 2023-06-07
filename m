Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A94B7267FA
	for <lists+linux-efi@lfdr.de>; Wed,  7 Jun 2023 20:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbjFGSJY (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 7 Jun 2023 14:09:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjFGSJX (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 7 Jun 2023 14:09:23 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7C0E95;
        Wed,  7 Jun 2023 11:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686161361; x=1717697361;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9/2uJzSIVthDyF48nbJrZnon8BziXtKeAnUd+VjtAKY=;
  b=m1rnk4MNx0bhdFokK01P/l8WwNNo3yAfrJykLJnXq4sycGnhVmx2Bce3
   0msGpv5oTJyvxkxyRnAirFNf3+1/Lqd8wJGyV0Hv1H1Z5wqOuJIn09Fee
   zA/pIQ+UZL1Rk4Q1OdVWVGLmOyijXYPjYnloVoFcznwIlS+AGr588C1Lb
   jpzrhFZPyle22fOihVaVqsd+uG80FBio4aVeInwYcmetBgDZGWkJF4y6w
   O3vugFzOhyoNN3elyXoJH4rT/nrp0/4o6UzWwZptnEBpEeaZZtu/an4o9
   HfTuvq7Ef4F7aTqMm6+18gS5indloreHK3nPOphbfB2oQ3yrfc4LCd25X
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="346679713"
X-IronPort-AV: E=Sophos;i="6.00,224,1681196400"; 
   d="scan'208";a="346679713"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2023 11:09:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="779554536"
X-IronPort-AV: E=Sophos;i="6.00,224,1681196400"; 
   d="scan'208";a="779554536"
Received: from yjiang5-mobl.amr.corp.intel.com (HELO localhost) ([10.144.161.97])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2023 11:09:20 -0700
Date:   Wed, 7 Jun 2023 11:09:20 -0700
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
Message-ID: <20230607180920.GA3110@yjiang5-mobl.amr.corp.intel.com>
References: <20230607072342.4054036-1-ardb@kernel.org>
 <20230607072342.4054036-11-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230607072342.4054036-11-ardb@kernel.org>
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

On Wed, Jun 07, 2023 at 09:23:32AM +0200, Ard Biesheuvel wrote:
> Instead of returning to the asm calling code to invoke the trampoline,
> call it straight from the C code that sets the scene. That way, the
> struct return type is no longer needed for returning two values, and the
> call can be made conditional more cleanly in a subsequent patch.
> 
> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/x86/boot/compressed/head_64.S    | 20 +++-----------
>  arch/x86/boot/compressed/pgtable_64.c | 28 ++++++++------------
>  2 files changed, 15 insertions(+), 33 deletions(-)
> 
> diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
> index cdefafd456c70335..3d4da7e5270c8d4d 100644
> --- a/arch/x86/boot/compressed/head_64.S
> +++ b/arch/x86/boot/compressed/head_64.S
> @@ -430,24 +430,12 @@ SYM_CODE_START(startup_64)
>  #endif
>  
>  	/*
> -	 * paging_prepare() sets up the trampoline and checks if we need to
> -	 * enable 5-level paging.
> -	 *
> -	 * paging_prepare() returns a two-quadword structure which lands
> -	 * into RDX:RAX:
> -	 *   - Address of the trampoline is returned in RAX.
> -	 *   - Non zero RDX means trampoline needs to enable 5-level
> -	 *     paging.
> -	 *
> +	 * set_paging_levels() updates the number of paging levels using a
> +	 * trampoline in 32-bit addressable memory if the current number does
> +	 * not match the desired number.
>  	 */
>  	movq	%r15, %rdi		/* pass struct boot_params pointer */
> -	call	paging_prepare
> -
> -	/* Pass the trampoline address and boolean flag as args #1 and #2 */
> -	movq	%rax, %rdi
> -	movq	%rdx, %rsi
> -	leaq	TRAMPOLINE_32BIT_CODE_OFFSET(%rax), %rax
> -	call	*%rax
> +	call	set_paging_levels
>  
>  	/*
>  	 * cleanup_trampoline() would restore trampoline memory.
> diff --git a/arch/x86/boot/compressed/pgtable_64.c b/arch/x86/boot/compressed/pgtable_64.c
> index d66639c961b8eeda..1d28ad95ea839531 100644
> --- a/arch/x86/boot/compressed/pgtable_64.c
> +++ b/arch/x86/boot/compressed/pgtable_64.c
> @@ -16,11 +16,6 @@ unsigned int __section(".data") pgdir_shift = 39;
>  unsigned int __section(".data") ptrs_per_p4d = 1;
>  #endif
>  
> -struct paging_config {
> -	unsigned long trampoline_start;
> -	unsigned long l5_required;
> -};
> -
>  /* Buffer to preserve trampoline memory */
>  static char trampoline_save[TRAMPOLINE_32BIT_SIZE];
>  
> @@ -106,10 +101,10 @@ static unsigned long find_trampoline_placement(void)
>  	return bios_start - TRAMPOLINE_32BIT_SIZE;
>  }
>  
> -struct paging_config paging_prepare(void *rmode)
> +asmlinkage void set_paging_levels(void *rmode)

Can you please change the refer to paging_prepare() in the comments above also?
