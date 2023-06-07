Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 593757269EB
	for <lists+linux-efi@lfdr.de>; Wed,  7 Jun 2023 21:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbjFGTih (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 7 Jun 2023 15:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjFGTih (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 7 Jun 2023 15:38:37 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C43B11FE0;
        Wed,  7 Jun 2023 12:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686166715; x=1717702715;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wXRY2MWhyN40cXGeqTUXVBNIvAZOjMmb/ffcJ3vEpVo=;
  b=LRVqfPLgvvXTSn3Rve5MKKUp18H2x3628NkSZZdiJZvuK2xBqOO2Fto3
   uU/0ZORJE/ZRMWnN6O1fP1rpPChs7TywkjtQrNNi+rNH4hqcLRDhxjVbs
   1yWihSbDIYX1NiJXXUjQwfy8CBbp+AvnZRoPiTaJNaPdAXWss+eOUM3qG
   aOGcnpwrkbyl4NUkaCsba1BOR0Fkxn6o7aSHBaUWrL1VJqV4+34/p++EW
   8nXTJ9BK6IE8DkpjSVb8pE3CcvKIZLxuMov/Qyj50CXi55RuvbW1HlsxL
   /I7oyjdLsQts1qGFdzOfrU3w+lV+AD9huh2OHcXofCjkwdw08HduSm2pt
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="337452533"
X-IronPort-AV: E=Sophos;i="6.00,225,1681196400"; 
   d="scan'208";a="337452533"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2023 12:38:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="709667975"
X-IronPort-AV: E=Sophos;i="6.00,225,1681196400"; 
   d="scan'208";a="709667975"
Received: from yjiang5-mobl.amr.corp.intel.com (HELO localhost) ([10.144.161.97])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2023 12:38:34 -0700
Date:   Wed, 7 Jun 2023 12:38:34 -0700
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
Subject: Re: [PATCH v5 08/20] x86/decompressor: Use standard calling
 convention for trampoline
Message-ID: <20230607193834.GC3110@yjiang5-mobl.amr.corp.intel.com>
References: <20230607072342.4054036-1-ardb@kernel.org>
 <20230607072342.4054036-9-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230607072342.4054036-9-ardb@kernel.org>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Jun 07, 2023 at 09:23:30AM +0200, Ard Biesheuvel wrote:
> Update the trampoline code so its arguments are passed via RDI and RSI,
> which matches the ordinary SysV calling convention for x86_64. This will
> allow this code to be called directly from C.
> 
> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/x86/boot/compressed/head_64.S | 30 +++++++++-----------
>  arch/x86/boot/compressed/pgtable.h |  2 +-
>  2 files changed, 14 insertions(+), 18 deletions(-)
> 
> diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
> index af45ddd8297a4a07..a387cd80964e1a1e 100644
> --- a/arch/x86/boot/compressed/head_64.S
> +++ b/arch/x86/boot/compressed/head_64.S
> @@ -443,9 +443,9 @@ SYM_CODE_START(startup_64)
>  	movq	%r15, %rdi		/* pass struct boot_params pointer */
>  	call	paging_prepare
>  
> -	/* Save the trampoline address in RCX */
> -	movq	%rax, %rcx
> -
> +	/* Pass the trampoline address and boolean flag as args #1 and #2 */
> +	movq	%rax, %rdi
> +	movq	%rdx, %rsi
>  	leaq	TRAMPOLINE_32BIT_CODE_OFFSET(%rax), %rax
>  	call	*%rax
>  
> @@ -534,11 +534,11 @@ SYM_FUNC_END(.Lrelocated)
>  /*
>   * This is the 32-bit trampoline that will be copied over to low memory.
>   *
> - * ECX contains the base address of the trampoline memory.
> - * Non zero RDX means trampoline needs to enable 5-level paging.
> + * EDI contains the base address of the trampoline memory.
> + * Non-zero ESI means trampoline needs to enable 5-level paging.
>   */
>  SYM_CODE_START(trampoline_32bit_src)

After the whole patchset, this function now only switch the paging level, is my
understanding correct? After all, it's converted to toggle_la57 directly in the
followed patches. If that's the case, would it makes sense to rename it
correspondingly?

Also, to align with the toggle_la57, would we make the first parameter as just
page table, instead of trampoline memory address?

> -	popq	%rdi
> +	popq	%r8
>  	/* Switch to compatibility mode (CS.L = 0 CS.D = 1) via far return */
>  	pushq	$__KERNEL32_CS
>  	leaq	0f(%rip), %rax
> @@ -552,7 +552,7 @@ SYM_CODE_START(trampoline_32bit_src)
>  	movl	%eax, %ss
>  
>  	/* Set up new stack */
> -	leal	TRAMPOLINE_32BIT_STACK_END(%ecx), %esp
> +	leal	TRAMPOLINE_32BIT_STACK_END(%edi), %esp
>  
>  	/* Disable paging */
>  	movl	%cr0, %eax
> @@ -560,7 +560,7 @@ SYM_CODE_START(trampoline_32bit_src)
>  	movl	%eax, %cr0
>  
>  	/* Check what paging mode we want to be in after the trampoline */
> -	testl	%edx, %edx
> +	testl	%esi, %esi
>  	jz	1f
>  
>  	/* We want 5-level paging: don't touch CR3 if it already points to 5-level page tables */
> @@ -575,21 +575,17 @@ SYM_CODE_START(trampoline_32bit_src)
>  	jz	3f
>  2:
>  	/* Point CR3 to the trampoline's new top level page table */
> -	leal	TRAMPOLINE_32BIT_PGTABLE_OFFSET(%ecx), %eax
> +	leal	TRAMPOLINE_32BIT_PGTABLE_OFFSET(%edi), %eax
>  	movl	%eax, %cr3
>  3:
>  	/* Set EFER.LME=1 as a precaution in case hypervsior pulls the rug */
> -	pushl	%ecx
> -	pushl	%edx
>  	movl	$MSR_EFER, %ecx
>  	rdmsr
>  	btsl	$_EFER_LME, %eax
>  	/* Avoid writing EFER if no change was made (for TDX guest) */
>  	jc	1f
>  	wrmsr
> -1:	popl	%edx
> -	popl	%ecx
> -
> +1:
>  #ifdef CONFIG_X86_MCE
>  	/*
>  	 * Preserve CR4.MCE if the kernel will enable #MC support.
> @@ -606,14 +602,14 @@ SYM_CODE_START(trampoline_32bit_src)
>  
>  	/* Enable PAE and LA57 (if required) paging modes */
>  	orl	$X86_CR4_PAE, %eax
> -	testl	%edx, %edx
> +	testl	%esi, %esi
>  	jz	1f
>  	orl	$X86_CR4_LA57, %eax
>  1:
>  	movl	%eax, %cr4
>  
>  	/* Calculate address of paging_enabled() once we are executing in the trampoline */
> -	leal	.Lpaging_enabled - trampoline_32bit_src + TRAMPOLINE_32BIT_CODE_OFFSET(%ecx), %eax
> +	leal	.Lpaging_enabled - trampoline_32bit_src + TRAMPOLINE_32BIT_CODE_OFFSET(%edi), %eax
>  
>  	/* Prepare the stack for far return to Long Mode */
>  	pushl	$__KERNEL_CS
> @@ -630,7 +626,7 @@ SYM_CODE_END(trampoline_32bit_src)
>  	.code64
>  SYM_FUNC_START_LOCAL_NOALIGN(.Lpaging_enabled)
>  	/* Return from the trampoline */
> -	jmp	*%rdi
> +	jmp	*%r8
>  SYM_FUNC_END(.Lpaging_enabled)
>  
>  	/*
> diff --git a/arch/x86/boot/compressed/pgtable.h b/arch/x86/boot/compressed/pgtable.h
> index 91dbb99203fbce2d..4e8cef135226bcbb 100644
> --- a/arch/x86/boot/compressed/pgtable.h
> +++ b/arch/x86/boot/compressed/pgtable.h
> @@ -14,7 +14,7 @@
>  
>  extern unsigned long *trampoline_32bit;
>  
> -extern void trampoline_32bit_src(void *return_ptr);
> +extern void trampoline_32bit_src(void *trampoline, bool enable_5lvl);
>  
>  #endif /* __ASSEMBLER__ */
>  #endif /* BOOT_COMPRESSED_PAGETABLE_H */
> -- 
> 2.39.2
> 
