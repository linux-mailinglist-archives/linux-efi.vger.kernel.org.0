Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3D4C51E03F
	for <lists+linux-efi@lfdr.de>; Fri,  6 May 2022 22:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443419AbiEFUq0 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 6 May 2022 16:46:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233143AbiEFUqZ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 6 May 2022 16:46:25 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ADEE69CE5
        for <linux-efi@vger.kernel.org>; Fri,  6 May 2022 13:42:40 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id m23so10578178ljb.8
        for <linux-efi@vger.kernel.org>; Fri, 06 May 2022 13:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WtV9FrLQYyZtXe46LaQb9LPuwmtg8D3WYzq8Ywi2Rkc=;
        b=N4Sy3cr417X7gTyi/jzF4jbOx1PdALBB1qmNLFKVM655vPRoBDb/dDru9J6w4iCmSt
         e5yzvKDqlVR0Kh/trkPl8sV7cNAAO7Kfd+CaddS4/N7LGANiX0FfytiCxquqreuy2IXe
         Hf63lAEMZtEntPmPSim7HL/SQH7O4Wf0jpRM/a++KmYKrwsWiuKMcc9BPDRxIIow6PK1
         aIOnk9acK4ruSjRVwxXOncEu2UFzk7LCzbpGjxBa2GKJxXw4hxHLVOufLQKM9WgYBBYx
         unkUb0o6uRuGNNMTEfYH/nsxdqagfyA1AKjVLqTdt2mNZ8CaMjVrQS2CP18doR+kGA5F
         /ziA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WtV9FrLQYyZtXe46LaQb9LPuwmtg8D3WYzq8Ywi2Rkc=;
        b=hvkq2GOXcvMbPcyNwe+AOPMbzNq364ZUYVU+LqYyMevusKNjvQpvG/ircdClyB9hgq
         mkOlPom3JziAAjKsHzzwt+SdJGElwtfvMoaoZtd1M0vfLPOwZk45bGBVz8Hg51gKCgTM
         sehTcQ30k9Mqxz7n9rLI4Xnu87tU7T8A2drlLo/NrTtfZTiT/4TkJr4RMG5V7D3QzFKV
         5Ds8Nrs2Y0BznbhoEhySF1HRhDrBApUCg7tFJeIlTL0rtoQ5y8ceeGRYUUw3H50Fv2PM
         eKj2sD8urniJEkP+T9pn+qwlPpCQjxY6BDPV7CFs3ufd4NrXKW9VU0twD7FxJsisvadH
         26/g==
X-Gm-Message-State: AOAM530sWppnHPLfHlMYGPPSEv8UG/Stx558CqRr+h9OXFGR3/Ia2sKu
        T2Hj+t0flAus326vXviW6s3KNg==
X-Google-Smtp-Source: ABdhPJxm6aGfrziXHLhrP7hFj3fqkgrHGeEILn849GvvYrO0IDonOm3YYXUizUV/au4Ng8QSFyCIvg==
X-Received: by 2002:a05:651c:510:b0:24f:545c:9362 with SMTP id o16-20020a05651c051000b0024f545c9362mr3062343ljp.263.1651869758424;
        Fri, 06 May 2022 13:42:38 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id k15-20020a2e920f000000b002502e691b05sm743637ljg.136.2022.05.06.13.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 May 2022 13:42:37 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 07B9C104AFD; Fri,  6 May 2022 23:44:24 +0300 (+03)
Date:   Fri, 6 May 2022 23:44:23 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Borislav Petkov <bp@alien8.de>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
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
        Brijesh Singh <brijesh.singh@amd.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>, x86@kernel.org,
        linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv5 10/12] x86/tdx: Unaccepted memory support
Message-ID: <20220506204423.gu6jrb53kmuxze5r@box.shutemov.name>
References: <20220425033934.68551-1-kirill.shutemov@linux.intel.com>
 <20220425033934.68551-11-kirill.shutemov@linux.intel.com>
 <YnOjJB8h3ZUR9sLX@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YnOjJB8h3ZUR9sLX@zn.tnic>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, May 05, 2022 at 12:12:52PM +0200, Borislav Petkov wrote:
> On Mon, Apr 25, 2022 at 06:39:32AM +0300, Kirill A. Shutemov wrote:
> > Subject: [PATCHv5 10/12] x86/tdx: Unaccepted memory support
> 
> Patch subject needs a verb:
> 
> "Add ... "
> 
> > All preparations are complete.
> 
> Drop this sentence.
> 
> > Hookup TDX-specific code to accept memory.
> > 
> > Accepting the memory is the same process as converting memory from
> > shared to private: kernel notifies VMM with MAP_GPA hypercall and then
> > accept pages with ACCEPT_PAGE module call.
> > 
> > The implementation in core kernel uses tdx_enc_status_changed(). It
> > already used for converting memory to shared and back for I/O
> > transactions.
> > 
> > Boot stub provides own implementation of tdx_accept_memory(). It is
> > similar in structure to tdx_enc_status_changed(), but only cares about
> > converting memory to private.
> > 
> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > ---
> >  arch/x86/Kconfig                  |  1 +
> >  arch/x86/boot/compressed/mem.c    | 24 ++++++++-
> >  arch/x86/boot/compressed/tdx.c    | 85 +++++++++++++++++++++++++++++++
> >  arch/x86/coco/tdx/tdx.c           | 31 +++++++----
> >  arch/x86/include/asm/shared/tdx.h |  2 +
> >  arch/x86/mm/unaccepted_memory.c   |  9 +++-
> >  6 files changed, 141 insertions(+), 11 deletions(-)
> > 
> > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> > index 7021ec725dd3..e4c31dbea6d7 100644
> > --- a/arch/x86/Kconfig
> > +++ b/arch/x86/Kconfig
> > @@ -885,6 +885,7 @@ config INTEL_TDX_GUEST
> >  	select ARCH_HAS_CC_PLATFORM
> >  	select X86_MEM_ENCRYPT
> >  	select X86_MCE
> > +	select UNACCEPTED_MEMORY
> 
> WARNING: unmet direct dependencies detected for UNACCEPTED_MEMORY
>   Depends on [n]: EFI [=y] && EFI_STUB [=y] && !KEXEC_CORE [=y]
>   Selected by [y]:
>   - INTEL_TDX_GUEST [=y] && HYPERVISOR_GUEST [=y] && X86_64 [=y] && CPU_SUP_INTEL [=y] && X86_X2APIC [=y]
> 
> WARNING: unmet direct dependencies detected for UNACCEPTED_MEMORY
>   Depends on [n]: EFI [=y] && EFI_STUB [=y] && !KEXEC_CORE [=y]
>   Selected by [y]:
>   - INTEL_TDX_GUEST [=y] && HYPERVISOR_GUEST [=y] && X86_64 [=y] && CPU_SUP_INTEL [=y] && X86_X2APIC [=y]

Ughh. Any ideas how to get around it? (Except for implementing kexec
support right away?)
> 
> 
> > diff --git a/arch/x86/boot/compressed/mem.c b/arch/x86/boot/compressed/mem.c
> > index b5058c975d26..539fff27de49 100644
> > --- a/arch/x86/boot/compressed/mem.c
> > +++ b/arch/x86/boot/compressed/mem.c
> > @@ -5,6 +5,8 @@
> >  #include "error.h"
> >  #include "find.h"
> >  #include "math.h"
> > +#include "tdx.h"
> > +#include <asm/shared/tdx.h>
> >  
> >  #define PMD_SHIFT	21
> >  #define PMD_SIZE	(_AC(1, UL) << PMD_SHIFT)
> > @@ -12,10 +14,30 @@
> >  
> >  extern struct boot_params *boot_params;
> >  
> > +static bool is_tdx_guest(void)
> 
> There is arch/x86/boot/compressed/tdx.c which already looks at that leaf
> and detects crap. Why is that hastily slapped here too?

I'm not happhy with this too.

process_unaccepted_memory() called form EFI stub that called before
decompression code.

I'm not sure how to structure code that it makes sense.

Call early_tdx_detect() from efi_main() in libstub/x86-stub.c?
It would require to include tdx.h from decompression code there which is
non-sense.

I would appreciate an idea.

> > +{
> > +	static bool once;
> > +	static bool is_tdx;
> > +
> > +	if (!once) {
> > +		u32 eax, sig[3];
> > +
> > +		cpuid_count(TDX_CPUID_LEAF_ID, 0, &eax,
> > +			    &sig[0], &sig[2],  &sig[1]);
> > +		is_tdx = !memcmp(TDX_IDENT, sig, sizeof(sig));
> > +		once = true;
> > +	}
> > +
> > +	return is_tdx;
> > +}
> > +
> >  static inline void __accept_memory(phys_addr_t start, phys_addr_t end)
> >  {
> >  	/* Platform-specific memory-acceptance call goes here */
> > -	error("Cannot accept memory");
> > +	if (is_tdx_guest())
> > +		tdx_accept_memory(start, end);
> > +	else
> > +		error("Cannot accept memory");
> 
> What is that supposed to catch?

Booting on a platform that uses unaccepted memory, but kernel doesn't not
support it.

> > diff --git a/arch/x86/boot/compressed/tdx.c b/arch/x86/boot/compressed/tdx.c
> > index 918a7606f53c..57fd2bf28484 100644
> > --- a/arch/x86/boot/compressed/tdx.c
> > +++ b/arch/x86/boot/compressed/tdx.c
> > @@ -3,12 +3,14 @@
> >  #include "../cpuflags.h"
> >  #include "../string.h"
> >  #include "../io.h"
> > +#include "align.h"
> >  #include "error.h"
> >  
> >  #include <vdso/limits.h>
> >  #include <uapi/asm/vmx.h>
> >  
> >  #include <asm/shared/tdx.h>
> > +#include <asm/page_types.h>
> >  
> >  /* Called from __tdx_hypercall() for unrecoverable failure */
> >  void __tdx_hypercall_failed(void)
> > @@ -75,3 +77,86 @@ void early_tdx_detect(void)
> >  	pio_ops.f_outb = tdx_outb;
> >  	pio_ops.f_outw = tdx_outw;
> >  }
> > +
> > +enum pg_level {
> > +	PG_LEVEL_4K,
> > +	PG_LEVEL_2M,
> > +	PG_LEVEL_1G,
> > +};
> > +
> > +#define PTE_SHIFT 9
> 
> At least stick those in a header.
> 
> > +static bool try_accept_one(phys_addr_t *start, unsigned long len,
> > +			  enum pg_level pg_level)
> 
> No need to break that line.
> 
> Also, it doesn't need to be bool - you can simply return accept_size on
> success and 0 on error so that you don't have an I/O argument.

So on the calling side it would look like:

	accepted = try_accept_one(start, len, PG_LEVEL_1G)
	if (accepted) {
		start += accepted;
		continue;
	}

And the similar for other levels. Is it really better?

> 
> Ditto for the copy in coco/tdx/tdx.c
> 
> > +{
> > +	unsigned long accept_size = PAGE_SIZE << (pg_level * PTE_SHIFT);
> > +	u64 tdcall_rcx;
> > +	u8 page_size;
> > +
> > +	if (!IS_ALIGNED(*start, accept_size))
> > +		return false;
> > +
> > +	if (len < accept_size)
> > +		return false;
> > +
> > +	/*
> > +	 * Pass the page physical address to the TDX module to accept the
> > +	 * pending, private page.
> > +	 *
> > +	 * Bits 2:0 of RCX encode page size: 0 - 4K, 1 - 2M, 2 - 1G.
> > +	 */
> > +	switch (pg_level) {
> > +	case PG_LEVEL_4K:
> > +		page_size = 0;
> > +		break;
> > +	case PG_LEVEL_2M:
> > +		page_size = 1;
> > +		break;
> > +	case PG_LEVEL_1G:
> > +		page_size = 2;
> > +		break;
> > +	default:
> > +		return false;
> > +	}
> > +
> > +	tdcall_rcx = *start | page_size;
> > +	if (__tdx_module_call(TDX_ACCEPT_PAGE, tdcall_rcx, 0, 0, 0, NULL))
> > +		return false;
> > +
> > +	*start += accept_size;
> > +	return true;
> > +}
> > +
> > +void tdx_accept_memory(phys_addr_t start, phys_addr_t end)
> > +{
> > +	/*
> > +	 * Notify the VMM about page mapping conversion. More info about ABI
> > +	 * can be found in TDX Guest-Host-Communication Interface (GHCI),
> > +	 * section "TDG.VP.VMCALL<MapGPA>"
> > +	 */
> > +	if (_tdx_hypercall(TDVMCALL_MAP_GPA, start, end - start, 0, 0))
> > +		error("Accepting memory failed\n");
> > +	/*
> > +	 * For shared->private conversion, accept the page using
> > +	 * TDX_ACCEPT_PAGE TDX module call.
> > +	 */
> > +	while (start < end) {
> > +		unsigned long len = end - start;
> > +
> > +		/*
> > +		 * Try larger accepts first. It gives chance to VMM to keep
> > +		 * 1G/2M SEPT entries where possible and speeds up process by
> 
> "SEPT"?

Secure EPT. EPT for private memory in TDX.

> > +		 * cutting number of hypercalls (if successful).
> > +		 */
> > +
> > +		if (try_accept_one(&start, len, PG_LEVEL_1G))
> > +			continue;
> > +
> > +		if (try_accept_one(&start, len, PG_LEVEL_2M))
> > +			continue;
> > +
> > +		if (!try_accept_one(&start, len, PG_LEVEL_4K))
> > +			error("Accepting memory failed\n");
> > +	}
> > +}
> > diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
> > index ddb60a87b426..ab4deb897942 100644
> > --- a/arch/x86/coco/tdx/tdx.c
> > +++ b/arch/x86/coco/tdx/tdx.c
> > @@ -580,16 +580,9 @@ static bool try_accept_one(phys_addr_t *start, unsigned long len,
> >  	return true;
> >  }
> >  
> > -/*
> > - * Inform the VMM of the guest's intent for this physical page: shared with
> > - * the VMM or private to the guest.  The VMM is expected to change its mapping
> > - * of the page in response.
> > - */
> > -static bool tdx_enc_status_changed(unsigned long vaddr, int numpages, bool enc)
> > +static bool tdx_enc_status_changed_phys(phys_addr_t start, phys_addr_t end,
> 
> Why? is tdx_enc_status_changed_virt() coming too?

tdx_enc_status_changed() deals with virtual addresses.

> > +					bool enc)
> >  {
> > -	phys_addr_t start = __pa(vaddr);
> > -	phys_addr_t end   = __pa(vaddr + numpages * PAGE_SIZE);
> > -
> >  	if (!enc) {
> >  		/* Set the shared (decrypted) bits: */
> >  		start |= cc_mkdec(0);
> > @@ -634,6 +627,25 @@ static bool tdx_enc_status_changed(unsigned long vaddr, int numpages, bool enc)
> >  	return true;
> >  }
> >  
> > +void tdx_accept_memory(phys_addr_t start, phys_addr_t end)
> > +{
> > +	if (!tdx_enc_status_changed_phys(start, end, true))
> > +		panic("Accepting memory failed\n");
> > +}
> > +
> > +/*
> > + * Inform the VMM of the guest's intent for this physical page: shared with
> > + * the VMM or private to the guest.  The VMM is expected to change its mapping
> > + * of the page in response.
> > + */
> > +static bool tdx_enc_status_changed(unsigned long vaddr, int numpages, bool enc)
> > +{
> > +	phys_addr_t start = __pa(vaddr);
> > +	phys_addr_t end = __pa(vaddr + numpages * PAGE_SIZE);
> > +
> > +	return tdx_enc_status_changed_phys(start, end, enc);
> > +}
> > +
> >  void __init tdx_early_init(void)
> >  {
> >  	u64 cc_mask;
> > @@ -645,6 +657,7 @@ void __init tdx_early_init(void)
> >  		return;
> >  
> >  	setup_force_cpu_cap(X86_FEATURE_TDX_GUEST);
> > +	setup_clear_cpu_cap(X86_FEATURE_MCE);
> 
> What, no comment? Why does TDX need to disable MCE?

It doesn't not suppose to be here. Sorry.

> 
> >  	cc_set_vendor(CC_VENDOR_INTEL);
> >  	cc_mask = get_cc_mask();
> > diff --git a/arch/x86/include/asm/shared/tdx.h b/arch/x86/include/asm/shared/tdx.h
> > index 956ced04c3be..97534c334473 100644
> > --- a/arch/x86/include/asm/shared/tdx.h
> > +++ b/arch/x86/include/asm/shared/tdx.h
> > @@ -81,5 +81,7 @@ struct tdx_module_output {
> >  u64 __tdx_module_call(u64 fn, u64 rcx, u64 rdx, u64 r8, u64 r9,
> >  		      struct tdx_module_output *out);
> >  
> > +void tdx_accept_memory(phys_addr_t start, phys_addr_t end);
> > +
> >  #endif /* !__ASSEMBLY__ */
> >  #endif /* _ASM_X86_SHARED_TDX_H */
> > diff --git a/arch/x86/mm/unaccepted_memory.c b/arch/x86/mm/unaccepted_memory.c
> > index 1327f64d5205..de0790af1824 100644
> > --- a/arch/x86/mm/unaccepted_memory.c
> > +++ b/arch/x86/mm/unaccepted_memory.c
> > @@ -6,6 +6,7 @@
> >  
> >  #include <asm/io.h>
> >  #include <asm/setup.h>
> > +#include <asm/shared/tdx.h>
> >  #include <asm/unaccepted_memory.h>
> >  
> >  /* Protects unaccepted memory bitmap */
> > @@ -29,7 +30,13 @@ void accept_memory(phys_addr_t start, phys_addr_t end)
> >  		unsigned long len = range_end - range_start;
> >  
> >  		/* Platform-specific memory-acceptance call goes here */
> > -		panic("Cannot accept memory");
> > +		if (cpu_feature_enabled(X86_FEATURE_TDX_GUEST)) {
> > +			tdx_accept_memory(range_start * PMD_SIZE,
> > +					  range_end * PMD_SIZE);
> > +		} else {
> > +			panic("Cannot accept memory");
> 
> Why panic here? A WARN_ONCE() should suffice, methinks.

As I said before, memory accept failure is fatal.

-- 
 Kirill A. Shutemov
