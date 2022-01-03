Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F0CC483513
	for <lists+linux-efi@lfdr.de>; Mon,  3 Jan 2022 17:49:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234788AbiACQtr (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 3 Jan 2022 11:49:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234996AbiACQtr (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 3 Jan 2022 11:49:47 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A83BC061761;
        Mon,  3 Jan 2022 08:49:46 -0800 (PST)
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DBB481EC0380;
        Mon,  3 Jan 2022 17:49:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1641228580;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=P798RWaZTr+okBNMCVL+1sl56MgtJUmphTduCouvUIE=;
        b=ip+HPwItP/DquYMql6pC3Po65Wa5C8XWBZLq6hy+3IQt1D9EWyxbEfUBkQZGd+h8+zSPWi
        X5/4SIi5AAR2dbjqWQjWlH/qDK5OuQxoQakMhvKtmHNJnB/4mtQS1N5aMHi698V0TubJ9X
        yB2kwu78JKqbDVvlBS/bSARKlFBV54g=
Date:   Mon, 3 Jan 2022 17:49:42 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Brijesh Singh <brijesh.singh@amd.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sergio Lopez <slp@redhat.com>, Peter Gonda <pgonda@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Dov Murik <dovmurik@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Michael Roth <michael.roth@amd.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        tony.luck@intel.com, marcorr@google.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v8 21/40] x86/head: re-enable stack protection for
 32/64-bit builds
Message-ID: <YdMpJg3YSdoYMKaZ@zn.tnic>
References: <20211210154332.11526-1-brijesh.singh@amd.com>
 <20211210154332.11526-22-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211210154332.11526-22-brijesh.singh@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Dec 10, 2021 at 09:43:13AM -0600, Brijesh Singh wrote:

> Subject: Re: [PATCH v8 21/40] x86/head: re-enable stack protection for 32/64-bit builds

The tip tree preferred format for patch subject prefixes is
'subsys/component:', e.g. 'x86/apic:', 'x86/mm/fault:', 'sched/fair:',
'genirq/core:'. Please do not use file names or complete file paths as
prefix. 'git log path/to/file' should give you a reasonable hint in most
cases.

The condensed patch description in the subject line should start with a
uppercase letter and should be written in imperative tone.

In this case:

x86/head/64: Re-enable stack protection

There's no need for 32/64-bit builds - we don't have anything else :-)

Please check all your subjects.

> From: Michael Roth <michael.roth@amd.com>
> 
> As of commit 103a4908ad4d ("x86/head/64: Disable stack protection for
> head$(BITS).o")

verify_commit_quotation: Warning: The proper commit quotation format is:
<newline>
[  ]<sha1, 12 chars> ("commit name")
<newline>

> kernel/head64.c is compiled with -fno-stack-protector
> to allow a call to set_bringup_idt_handler(), which would otherwise
> have stack protection enabled with CONFIG_STACKPROTECTOR_STRONG. While
> sufficient for that case, there may still be issues with calls to any
> external functions that were compiled with stack protection enabled that
> in-turn make stack-protected calls, or if the exception handlers set up
> by set_bringup_idt_handler() make calls to stack-protected functions.
> As part of 103a4908ad4d, stack protection was also disabled for
> kernel/head32.c as a precaution.
> 
> Subsequent patches for SEV-SNP CPUID validation support will introduce
> both such cases. Attempting to disable stack protection for everything
> in scope to address that is prohibitive since much of the code, like
> SEV-ES #VC handler, is shared code that remains in use after boot and
> could benefit from having stack protection enabled. Attempting to inline
> calls is brittle and can quickly balloon out to library/helper code
> where that's not really an option.
> 
> Instead, re-enable stack protection for head32.c/head64.c and make the
> appropriate changes to ensure the segment used for the stack canary is
> initialized in advance of any stack-protected C calls.
> 
> for head64.c:
> 
> - The BSP will enter from startup_64 and call into C code

Function names need to end with "()" so that it is clear they're
functions.

>   (startup_64_setup_env) shortly after setting up the stack, which may
>   result in calls to stack-protected code. Set up %gs early to allow
>   for this safely.
> - APs will enter from secondary_startup_64*, and %gs will be set up
>   soon after. There is one call to C code prior to this
>   (__startup_secondary_64), but it is only to fetch sme_me_mask, and
>   unlikely to be stack-protected, so leave things as they are, but add
>   a note about this in case things change in the future.
> 
> for head32.c:
> 
> - BSPs/APs will set %fs to __BOOT_DS prior to any C calls. In recent
>   kernels, the compiler is configured to access the stack canary at
>   %fs:__stack_chk_guard,

Add here somewhere:

"See

  3fb0fdb3bbe7 ("x86/stackprotector/32: Make the canary into a regular percpu variable")

for details."

> which overlaps with the initial per-cpu
>   __stack_chk_guard variable in the initial/'master' .data..percpu
>   area. This is sufficient to allow access to the canary for use
>   during initial startup, so no changes are needed there.
> 
> Suggested-by: Joerg Roedel <jroedel@suse.de> #for 64-bit %gs set up
> Signed-off-by: Michael Roth <michael.roth@amd.com>
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> ---
>  arch/x86/kernel/Makefile  |  1 -
>  arch/x86/kernel/head_64.S | 24 ++++++++++++++++++++++++
>  2 files changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
> index 2ff3e600f426..4df8c8f7d2ac 100644
> --- a/arch/x86/kernel/Makefile
> +++ b/arch/x86/kernel/Makefile
> @@ -48,7 +48,6 @@ endif
>  # non-deterministic coverage.
>  KCOV_INSTRUMENT		:= n
>  
> -CFLAGS_head$(BITS).o	+= -fno-stack-protector
>  CFLAGS_cc_platform.o	+= -fno-stack-protector
>  
>  CFLAGS_irq.o := -I $(srctree)/$(src)/../include/asm/trace
> diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
> index 99de8fd461e8..9f8a7e48aca7 100644
> --- a/arch/x86/kernel/head_64.S
> +++ b/arch/x86/kernel/head_64.S
> @@ -65,6 +65,22 @@ SYM_CODE_START_NOALIGN(startup_64)
>  	leaq	(__end_init_task - FRAME_SIZE)(%rip), %rsp
>  
>  	leaq	_text(%rip), %rdi
> +
> +	/*
> +	 * initial_gs points to initial fixed_per_cpu struct with storage for

$ git grep fixed_per_cpu
$

??

Do you mean this:

SYM_DATA(initial_gs,    .quad INIT_PER_CPU_VAR(fixed_percpu_data))

?

> +	 * the stack protector canary. Global pointer fixups are needed at this
> +	 * stage, so apply them as is done in fixup_pointer(), and initialize %gs
> +	 * such that the canary can be accessed at %gs:40 for subsequent C calls.
> +	 */
> +	movl	$MSR_GS_BASE, %ecx
> +	movq	initial_gs(%rip), %rax
> +	movq	$_text, %rdx
> +	subq	%rdx, %rax
> +	addq	%rdi, %rax
> +	movq	%rax, %rdx
> +	shrq	$32,  %rdx
> +	wrmsr
> +
>  	pushq	%rsi
>  	call	startup_64_setup_env
>  	popq	%rsi
> @@ -146,6 +162,14 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
>  	 * added to the initial pgdir entry that will be programmed into CR3.
>  	 */
>  	pushq	%rsi

<---- newline here.

> +	/*
> +	 * NOTE: %gs at this point is a stale data segment left over from the
> +	 * real-mode trampoline, so the default stack protector canary location
> +	 * at %gs:40 does not yet coincide with the expected fixed_per_cpu struct
> +	 * that contains storage for the stack canary. So take care not to add
> +	 * anything to the C functions in this path that would result in stack
> +	 * protected C code being generated.
> +	 */
>  	call	__startup_secondary_64
>  	popq	%rsi

Can't you simply do

	movq    sme_me_mask, %rax

here instead and avoid the issue altogether?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
