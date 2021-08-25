Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4559F3F775D
	for <lists+linux-efi@lfdr.de>; Wed, 25 Aug 2021 16:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241588AbhHYO32 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 25 Aug 2021 10:29:28 -0400
Received: from mail.skyhub.de ([5.9.137.197]:34544 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240965AbhHYO32 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 25 Aug 2021 10:29:28 -0400
Received: from zn.tnic (p200300ec2f0ea7006bb4dcd1613a8626.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:a700:6bb4:dcd1:613a:8626])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5A5871EC0105;
        Wed, 25 Aug 2021 16:28:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1629901716;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3v7laBTLPusI9805TqhSEWh/kBZlYAamedfXZbBSnLU=;
        b=dLCHo7HWETYfS7H4XHg00/WGizadW5nY9mPEki9CYXa9RCKzGzDE5ttcA117vyw9s+6syQ
        pX96sdHhQBnXZohHx4U1syr2ruibQoXqL3vY6pzNZ/EH0jo2c6T2XZtCmohYx5rvQu98x3
        uGe059IFPH2Te0eqdKzxS559VD+aBhw=
Date:   Wed, 25 Aug 2021 16:29:13 +0200
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
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>, tony.luck@intel.com,
        marcorr@google.com, sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH Part1 v5 23/38] x86/head/64: set up a startup %gs for
 stack protector
Message-ID: <YSZTubkROktMMSba@zn.tnic>
References: <20210820151933.22401-1-brijesh.singh@amd.com>
 <20210820151933.22401-24-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210820151933.22401-24-brijesh.singh@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Aug 20, 2021 at 10:19:18AM -0500, Brijesh Singh wrote:
> From: Michael Roth <michael.roth@amd.com>
> 
> As of commit 103a4908ad4d ("x86/head/64: Disable stack protection for
> head$(BITS).o") kernel/head64.c is compiled with -fno-stack-protector
> to allow a call to set_bringup_idt_handler(), which would otherwise
> have stack protection enabled with CONFIG_STACKPROTECTOR_STRONG. While
> sufficient for that case, this will still cause issues if we attempt to
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

That...

> Signed-off-by: Michael Roth <michael.roth@amd.com>
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> ---
>  arch/x86/kernel/Makefile |  2 +-
>  arch/x86/kernel/head64.c | 20 ++++++++++++++++++++
>  2 files changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
> index 3e625c61f008..5abdfd0dbbc3 100644
> --- a/arch/x86/kernel/Makefile
> +++ b/arch/x86/kernel/Makefile
> @@ -46,7 +46,7 @@ endif
>  # non-deterministic coverage.
>  KCOV_INSTRUMENT		:= n
>  
> -CFLAGS_head$(BITS).o	+= -fno-stack-protector
> +CFLAGS_head32.o		+= -fno-stack-protector

... and that needs to be taken care of too.

>  CFLAGS_irq.o := -I $(srctree)/$(src)/../include/asm/trace
>  
> diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
> index a1711c4594fa..f1b76a54c84e 100644
> --- a/arch/x86/kernel/head64.c
> +++ b/arch/x86/kernel/head64.c
> @@ -74,6 +74,11 @@ static struct desc_struct startup_gdt[GDT_ENTRIES] = {
>  	[GDT_ENTRY_KERNEL_DS]           = GDT_ENTRY_INIT(0xc093, 0, 0xfffff),
>  };
>  
> +/* For use by stack protector code before switching to virtual addresses */
> +#if CONFIG_STACKPROTECTOR

That's "#ifdef". Below too.

Did you even build this with CONFIG_STACKPROTECTOR disabled?

Because if you did, you would've seen this:

arch/x86/kernel/head64.c:78:5: warning: "CONFIG_STACKPROTECTOR" is not defined, evaluates to 0 [-Wundef]
   78 | #if CONFIG_STACKPROTECTOR
      |     ^~~~~~~~~~~~~~~~~~~~~
arch/x86/kernel/head64.c: In function ‘startup_64_setup_env’:
arch/x86/kernel/head64.c:613:35: error: ‘startup_gs_area’ undeclared (first use in this function)
  613 |  u64 gs_area = (u64)fixup_pointer(startup_gs_area, physbase);
      |                                   ^~~~~~~~~~~~~~~
arch/x86/kernel/head64.c:613:35: note: each undeclared identifier is reported only once for each function it appears in
arch/x86/kernel/head64.c:632:5: warning: "CONFIG_STACKPROTECTOR" is not defined, evaluates to 0 [-Wundef]
  632 | #if CONFIG_STACKPROTECTOR
      |     ^~~~~~~~~~~~~~~~~~~~~
arch/x86/kernel/head64.c:613:6: warning: unused variable ‘gs_area’ [-Wunused-variable]
  613 |  u64 gs_area = (u64)fixup_pointer(startup_gs_area, physbase);
      |      ^~~~~~~
make[2]: *** [scripts/Makefile.build:271: arch/x86/kernel/head64.o] Error 1
make[1]: *** [scripts/Makefile.build:514: arch/x86/kernel] Error 2
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1851: arch/x86] Error 2
make: *** Waiting for unfinished jobs....

> +static char startup_gs_area[64];
> +#endif
> +
>  /*
>   * Address needs to be set at runtime because it references the startup_gdt
>   * while the kernel still uses a direct mapping.
> @@ -605,6 +610,8 @@ void early_setup_idt(void)
>   */
>  void __head startup_64_setup_env(unsigned long physbase)
>  {
> +	u64 gs_area = (u64)fixup_pointer(startup_gs_area, physbase);
> +
>  	/* Load GDT */
>  	startup_gdt_descr.address = (unsigned long)fixup_pointer(startup_gdt, physbase);
>  	native_load_gdt(&startup_gdt_descr);
> @@ -614,5 +621,18 @@ void __head startup_64_setup_env(unsigned long physbase)
>  		     "movl %%eax, %%ss\n"
>  		     "movl %%eax, %%es\n" : : "a"(__KERNEL_DS) : "memory");
>  
> +	/*
> +	 * GCC stack protection needs a place to store canary values. The
> +	 * default is %gs:0x28, which is what the kernel currently uses.
> +	 * Point GS base to a buffer that can be used for this purpose.
> +	 * Note that newer GCCs now allow this location to be configured,
> +	 * so if we change from the default in the future we need to ensure
> +	 * that this buffer overlaps whatever address ends up being used.
> +	 */
> +#if CONFIG_STACKPROTECTOR
> +	asm volatile("movl %%eax, %%gs\n" : : "a"(__KERNEL_DS) : "memory");
> +	native_wrmsr(MSR_GS_BASE, gs_area, gs_area >> 32);
> +#endif
> +
>  	startup_64_load_idt(physbase);
>  }
> -- 
> 2.17.1
> 

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
