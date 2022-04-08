Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD6D24F9CB1
	for <lists+linux-efi@lfdr.de>; Fri,  8 Apr 2022 20:28:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238688AbiDHSae (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 8 Apr 2022 14:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbiDHSad (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 8 Apr 2022 14:30:33 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A871102427;
        Fri,  8 Apr 2022 11:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649442508; x=1680978508;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=MKvwCaA6SimRTFhHge/2AB0twtlCpITErS3yVnsdKdc=;
  b=NnNP+Bm3m1jrT8cgnYaBVYoKMsCkzpWpoJ6i8i9grjTovdeV46xv3QFw
   oa2bfGLk/1pr0ErgzuSUXrrwU/Dm0z8RRQeVMIeAVxAD+9NYuIPARyqLm
   gXDkB+/7ZGelim+EOUtqPbs36sDBfuZDW8nQWhawX2FT7/S1C2eTD7Qzt
   /6bU91ja9X5838VPJtEVub46R8Z0/Lx5rAApd9vyqDe807uilYH0xjM4n
   LQr6EmXWGY70CHf/JnkOGFKEh5YlCaab66Z57wvIeOy/EGTcrUm+oPc/X
   7cfgUmcehHWJVakcBoWbzeglGiKV6V0BOmqHZqv3VeaOui22oV6BdScYW
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10311"; a="242255505"
X-IronPort-AV: E=Sophos;i="5.90,245,1643702400"; 
   d="scan'208";a="242255505"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 11:28:27 -0700
X-IronPort-AV: E=Sophos;i="5.90,245,1643702400"; 
   d="scan'208";a="525480901"
Received: from tsungtae-mobl.amr.corp.intel.com (HELO [10.134.43.198]) ([10.134.43.198])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 11:28:26 -0700
Message-ID: <69dedc57-b4cf-b0b2-99a5-46c87e99fd9a@intel.com>
Date:   Fri, 8 Apr 2022 11:28:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     Andi Kleen <ak@linux.intel.com>,
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
        Brijesh Singh <brijesh.singh@amd.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>, x86@kernel.org,
        linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220405234343.74045-1-kirill.shutemov@linux.intel.com>
 <20220405234343.74045-8-kirill.shutemov@linux.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCHv4 7/8] x86/tdx: Unaccepted memory support
In-Reply-To: <20220405234343.74045-8-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 4/5/22 16:43, Kirill A. Shutemov wrote:
> All preparations are complete. Hookup TDX-specific code to accept memory.
> 
> There are two tdx_accept_memory() implementations: one in main kernel
> and one in the decompresser.
> 
> The implementation in core kernel uses tdx_enc_status_changed().
> The helper is not available in the decompresser, self-contained
> implementation added there instead.

Why isn't it available?

> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 7021ec725dd3..e4c31dbea6d7 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -885,6 +885,7 @@ config INTEL_TDX_GUEST
>  	select ARCH_HAS_CC_PLATFORM
>  	select X86_MEM_ENCRYPT
>  	select X86_MCE
> +	select UNACCEPTED_MEMORY
>  	help
>  	  Support running as a guest under Intel TDX.  Without this support,
>  	  the guest kernel can not boot or run under TDX.

Ahh, there we go.  Nice.

> diff --git a/arch/x86/boot/compressed/tdx.c b/arch/x86/boot/compressed/tdx.c
> index 918a7606f53c..a0bd1426d235 100644
> --- a/arch/x86/boot/compressed/tdx.c
> +++ b/arch/x86/boot/compressed/tdx.c
> @@ -9,6 +9,7 @@
>  #include <uapi/asm/vmx.h>
>  
>  #include <asm/shared/tdx.h>
> +#include <asm/page_types.h>
>  
>  /* Called from __tdx_hypercall() for unrecoverable failure */
>  void __tdx_hypercall_failed(void)
> @@ -75,3 +76,43 @@ void early_tdx_detect(void)
>  	pio_ops.f_outb = tdx_outb;
>  	pio_ops.f_outw = tdx_outw;
>  }
> +
> +#define TDACCEPTPAGE		6
> +#define TDVMCALL_MAP_GPA	0x10001

That seems like unnecessary duplication.  Can't a #define be trivially
shared?

> +/*
> + * Wrapper for standard use of __tdx_hypercall with no output aside from
> + * return code.
> + */
> +static inline u64 _tdx_hypercall(u64 fn, u64 r12, u64 r13, u64 r14, u64 r15)
> +{
> +	struct tdx_hypercall_args args = {
> +		.r10 = TDX_HYPERCALL_STANDARD,
> +		.r11 = fn,
> +		.r12 = r12,
> +		.r13 = r13,
> +		.r14 = r14,
> +		.r15 = r15,
> +	};
> +
> +	return __tdx_hypercall(&args, 0);
> +}

Ditto on the sharing.

> +void tdx_accept_memory(phys_addr_t start, phys_addr_t end)
> +{
> +	int i;
> +
> +	if (_tdx_hypercall(TDVMCALL_MAP_GPA, start, end - start, 0, 0))
> +		error("Cannot accept memory: MapGPA failed\n");
> +
> +	/*
> +	 * For shared->private conversion, accept the page using TDACCEPTPAGE
> +	 * TDX module call.
> +	 */

What does the shared->private conversion have to do with this?  I feel
like I'm missing something.  Is unaccepted memory shared initially?

> +	for (i = 0; i < (end - start) / PAGE_SIZE; i++) {
> +		if (__tdx_module_call(TDACCEPTPAGE, start + i * PAGE_SIZE,
> +				      0, 0, 0, NULL)) {
> +			error("Cannot accept memory: page accept failed\n");
> +		}
> +	}
> +}
> diff --git a/arch/x86/boot/compressed/unaccepted_memory.c b/arch/x86/boot/compressed/unaccepted_memory.c
> index 3ebab63789bb..662ec32e3c42 100644
> --- a/arch/x86/boot/compressed/unaccepted_memory.c
> +++ b/arch/x86/boot/compressed/unaccepted_memory.c
> @@ -1,12 +1,33 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  
> +#include <asm/shared/tdx.h>
>  #include "error.h"
>  #include "misc.h"
> +#include "tdx.h"
> +
> +static bool is_tdx_guest(void)
> +{
> +	static bool once;
> +	static bool is_tdx;
> +
> +	if (!once) {
> +		u32 eax, sig[3];
> +
> +		cpuid_count(TDX_CPUID_LEAF_ID, 0, &eax,
> +			    &sig[0], &sig[2],  &sig[1]);
> +		is_tdx = !memcmp(TDX_IDENT, sig, sizeof(sig));
> +	}
> +
> +	return is_tdx;
> +}

Do you need to set 'once'?

>  static inline void __accept_memory(phys_addr_t start, phys_addr_t end)
>  {
>  	/* Platform-specific memory-acceptance call goes here */
> -	error("Cannot accept memory");
> +	if (is_tdx_guest())
> +		tdx_accept_memory(start, end);
> +	else
> +		error("Cannot accept memory");
>  }

Should those is_tdx_guest() checks be a new CC_ attribute, say:

	cc_guest_has(CC_UNACCEPTED_MEMORY)

and then have a:

	cc_accept_memory(start, end);

?

Or is that overkill when we only have TDX?

>  void mark_unaccepted(struct boot_params *params, u64 start, u64 end)
> diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
> index 03deb4d6920d..0fcb54e07797 100644
> --- a/arch/x86/coco/tdx/tdx.c
> +++ b/arch/x86/coco/tdx/tdx.c
> @@ -606,16 +606,8 @@ static bool try_accept_one(phys_addr_t *start, unsigned long len,
>  	return true;
>  }
>  
> -/*
> - * Inform the VMM of the guest's intent for this physical page: shared with
> - * the VMM or private to the guest.  The VMM is expected to change its mapping
> - * of the page in response.
> - */
> -static bool tdx_enc_status_changed(unsigned long vaddr, int numpages, bool enc)
> +static bool __tdx_enc_status_changed(phys_addr_t start, phys_addr_t end, bool enc)
>  {
> -	phys_addr_t start = __pa(vaddr);
> -	phys_addr_t end   = __pa(vaddr + numpages * PAGE_SIZE);
> -
>  	if (!enc) {
>  		/* Set the shared (decrypted) bits: */
>  		start |= cc_mkdec(0);
> @@ -660,6 +652,25 @@ static bool tdx_enc_status_changed(unsigned long vaddr, int numpages, bool enc)
>  	return true;
>  }
>  
> +void tdx_accept_memory(phys_addr_t start, phys_addr_t end)
> +{
> +	if (!__tdx_enc_status_changed(start, end, true))
> +		panic("Accepting memory failed\n");
> +}

Could we make a bit better use of our naming bytes?  "__" tells us
nothing.  What if we had:

	tdx_enc_status_changed_phys()

we could call the other one _virt() or leave it alone too.

> +/*
> + * Inform the VMM of the guest's intent for this physical page: shared with
> + * the VMM or private to the guest.  The VMM is expected to change its mapping
> + * of the page in response.
> + */
> +static bool tdx_enc_status_changed(unsigned long vaddr, int numpages, bool enc)
> +{
> +	phys_addr_t start = __pa(vaddr);
> +	phys_addr_t end = __pa(vaddr + numpages * PAGE_SIZE);
> +
> +	return __tdx_enc_status_changed(start, end, enc);
> +}
> +
>  void __init tdx_early_init(void)
>  {
>  	u64 cc_mask;
> diff --git a/arch/x86/include/asm/shared/tdx.h b/arch/x86/include/asm/shared/tdx.h
> index e53f26228fbb..4eca6492b108 100644
> --- a/arch/x86/include/asm/shared/tdx.h
> +++ b/arch/x86/include/asm/shared/tdx.h
> @@ -36,5 +36,25 @@ u64 __tdx_hypercall(struct tdx_hypercall_args *args, unsigned long flags);
>  /* Called from __tdx_hypercall() for unrecoverable failure */
>  void __tdx_hypercall_failed(void);
>  
> +/*
> + * Used in __tdx_module_call() to gather the output registers' values of the
> + * TDCALL instruction when requesting services from the TDX module. This is a
> + * software only structure and not part of the TDX module/VMM ABI
> + */
> +struct tdx_module_output {
> +	u64 rcx;
> +	u64 rdx;
> +	u64 r8;
> +	u64 r9;
> +	u64 r10;
> +	u64 r11;
> +};

Is this the first module call with an output?

> +/* Used to communicate with the TDX module */
> +u64 __tdx_module_call(u64 fn, u64 rcx, u64 rdx, u64 r8, u64 r9,
> +		      struct tdx_module_output *out);
> +
> +void tdx_accept_memory(phys_addr_t start, phys_addr_t end);
> +
>  #endif /* !__ASSEMBLY__ */
>  #endif /* _ASM_X86_SHARED_TDX_H */
> diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
> index 020c81a7c729..d9106d3e89f8 100644
> --- a/arch/x86/include/asm/tdx.h
> +++ b/arch/x86/include/asm/tdx.h
> @@ -20,21 +20,6 @@
>  
>  #ifndef __ASSEMBLY__
>  
> -/*
> - * Used to gather the output registers values of the TDCALL and SEAMCALL
> - * instructions when requesting services from the TDX module.
> - *
> - * This is a software only structure and not part of the TDX module/VMM ABI.
> - */
> -struct tdx_module_output {
> -	u64 rcx;
> -	u64 rdx;
> -	u64 r8;
> -	u64 r9;
> -	u64 r10;
> -	u64 r11;
> -};
> -
>  /*
>   * Used by the #VE exception handler to gather the #VE exception
>   * info from the TDX module. This is a software only structure
> @@ -55,10 +40,6 @@ struct ve_info {
>  
>  void __init tdx_early_init(void);
>  
> -/* Used to communicate with the TDX module */
> -u64 __tdx_module_call(u64 fn, u64 rcx, u64 rdx, u64 r8, u64 r9,
> -		      struct tdx_module_output *out);
> -
>  void tdx_get_ve_info(struct ve_info *ve);

There's enough TDX helper munging going on here that I'd probably break
this out into a separate patch.

> diff --git a/arch/x86/mm/unaccepted_memory.c b/arch/x86/mm/unaccepted_memory.c
> index 3588a7cb954c..2f1c3c0375cd 100644
> --- a/arch/x86/mm/unaccepted_memory.c
> +++ b/arch/x86/mm/unaccepted_memory.c
> @@ -6,6 +6,7 @@
>  
>  #include <asm/io.h>
>  #include <asm/setup.h>
> +#include <asm/shared/tdx.h>
>  #include <asm/unaccepted_memory.h>
>  
>  static DEFINE_SPINLOCK(unaccepted_memory_lock);
> @@ -26,7 +27,10 @@ void accept_memory(phys_addr_t start, phys_addr_t end)
>  	for_each_set_bitrange_from(rs, re, unaccepted_memory,
>  				   DIV_ROUND_UP(end, PMD_SIZE)) {
>  		/* Platform-specific memory-acceptance call goes here */
> -		panic("Cannot accept memory");
> +		if (cpu_feature_enabled(X86_FEATURE_TDX_GUEST))
> +			tdx_accept_memory(rs * PMD_SIZE, re * PMD_SIZE);
> +		else
> +			panic("Cannot accept memory");
>  		bitmap_clear(unaccepted_memory, rs, re - rs);
>  	}
>  	spin_unlock_irqrestore(&unaccepted_memory_lock, flags);

