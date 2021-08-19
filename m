Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2BCF3F1649
	for <lists+linux-efi@lfdr.de>; Thu, 19 Aug 2021 11:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236292AbhHSJeQ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 19 Aug 2021 05:34:16 -0400
Received: from mail.skyhub.de ([5.9.137.197]:33776 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237718AbhHSJeO (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 19 Aug 2021 05:34:14 -0400
Received: from zn.tnic (p200300ec2f0f6a00d82486aa7bad8753.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:6a00:d824:86aa:7bad:8753])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 014621EC046C;
        Thu, 19 Aug 2021 11:33:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1629365613;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=zpAR8DkWlNwK2/IAwMT7h3TJ9HqSCnXicu19pVWzlYc=;
        b=G2bH/SHbJouzEX/F6rsZnqxPmMBbSfwvywTH5v71S3WcRjLTQFMQCOw9fTVoi1/IBQwQon
        20fqwjgBiK/kCW8VrphaxONUtDtgKq/00L9rKAKaXEwnouszTad1kkpM5Sl0yJJsUCHlML
        h+0ENaaxTxF+fHfPsAynQBUkNjto8fM=
Date:   Thu, 19 Aug 2021 11:34:12 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Brijesh Singh <brijesh.singh@amd.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        linux-crypto@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
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
        Vlastimil Babka <vbabka@suse.cz>, tony.luck@intel.com,
        npmccallum@redhat.com, brijesh.ksingh@gmail.com
Subject: Re: [PATCH Part1 RFC v4 21/36] x86/head/64: set up a startup %gs for
 stack protector
Message-ID: <YR4liXhhFv2KiAPS@zn.tnic>
References: <20210707181506.30489-1-brijesh.singh@amd.com>
 <20210707181506.30489-22-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210707181506.30489-22-brijesh.singh@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Jul 07, 2021 at 01:14:51PM -0500, Brijesh Singh wrote:
> From: Michael Roth <michael.roth@amd.com>
> 
> As of commit 103a4908ad4d ("x86/head/64: Disable stack protection for
> head$(BITS).o") kernel/head64.c is compiled with -fno-stack-protector
> to allow a call to set_bringup_idt_handler(), which would otherwise
> have stack protection enabled with CONFIG_STACKPROTECTOR_STRONG. While
> sufficient for that case, this will still cause issues if we attempt to

Who's "we"?

Please use passive voice in your text: no "we" or "I", etc.
Personal pronouns are ambiguous in text, especially with so many
parties/companies/etc developing the kernel so let's avoid them please.

> call out to any external functions that were compiled with stack
> protection enabled that in-turn make stack-protected calls, or if the
> exception handlers set up by set_bringup_idt_handler() make calls to
> stack-protected functions.
> 
> Subsequent patches for SEV-SNP CPUID validation support will introduce
> both such cases. Attempting to disable stack protection for everything
> in scope to address that is prohibitive since much of the code, like
> SEV-ES #VC handler, is shared code that remains in use after boot and
> could benefit from having stack protection enabled. Attempting to inline
> calls is brittle and can quickly balloon out to library/helper code
> where that's not really an option.
> 
> Instead, set up %gs to point a buffer that stack protector can use for
> canary values when needed.
> 
> In doing so, it's likely we can stop using -no-stack-protector for
> head64.c, but that hasn't been tested yet, and head32.c would need a
> similar solution to be safe, so that is left as a potential follow-up.

Well, then fix it properly pls. Remove the -no-stack-protector, test it
and send it out, even separately if easier to handle. This version looks
half-baked, just so that it gets you what you need for the SNP stuff but
we don't do half-baked, sorry.

> Signed-off-by: Michael Roth <michael.roth@amd.com>
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> ---
>  arch/x86/kernel/head64.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
> index f4c3e632345a..8615418f98f1 100644
> --- a/arch/x86/kernel/head64.c
> +++ b/arch/x86/kernel/head64.c
> @@ -74,6 +74,9 @@ static struct desc_struct startup_gdt[GDT_ENTRIES] = {
>  	[GDT_ENTRY_KERNEL_DS]           = GDT_ENTRY_INIT(0xc093, 0, 0xfffff),
>  };
>  
> +/* For use by stack protector code before switching to virtual addresses */
> +static char startup_gs_area[64];

That needs some CONFIG_STACKPROTECTOR ifdeffery around it, below too.

> +
>  /*
>   * Address needs to be set at runtime because it references the startup_gdt
>   * while the kernel still uses a direct mapping.
> @@ -598,6 +601,8 @@ void early_setup_idt(void)
>   */
>  void __head startup_64_setup_env(unsigned long physbase)
>  {
> +	u64 gs_area = (u64)fixup_pointer(startup_gs_area, physbase);
> +
>  	/* Load GDT */
>  	startup_gdt_descr.address = (unsigned long)fixup_pointer(startup_gdt, physbase);
>  	native_load_gdt(&startup_gdt_descr);
> @@ -605,7 +610,18 @@ void __head startup_64_setup_env(unsigned long physbase)
>  	/* New GDT is live - reload data segment registers */
>  	asm volatile("movl %%eax, %%ds\n"
>  		     "movl %%eax, %%ss\n"
> -		     "movl %%eax, %%es\n" : : "a"(__KERNEL_DS) : "memory");
> +		     "movl %%eax, %%es\n"
> +		     "movl %%eax, %%gs\n" : : "a"(__KERNEL_DS) : "memory");
> +
> +	/*
> +	 * GCC stack protection needs a place to store canary values. The
> +	 * default is %gs:0x28, which is what the kernel currently uses.
> +	 * Point GS base to a buffer that can be used for this purpose.
> +	 * Note that newer GCCs now allow this location to be configured,
> +	 * so if we change from the default in the future we need to ensure
> +	 * that this buffer overlaps whatever address ends up being used.
> +	 */
> +	native_wrmsr(MSR_GS_BASE, gs_area, gs_area >> 32);
>  
>  	startup_64_load_idt(physbase);
>  }
> -- 

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
