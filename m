Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38193518641
	for <lists+linux-efi@lfdr.de>; Tue,  3 May 2022 16:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236786AbiECOQg (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 3 May 2022 10:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236780AbiECOQf (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 3 May 2022 10:16:35 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A24C716583;
        Tue,  3 May 2022 07:13:02 -0700 (PDT)
Received: from zn.tnic (p5de8eeb4.dip0.t-ipconnect.de [93.232.238.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D04111EC0258;
        Tue,  3 May 2022 16:12:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1651587176;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=x202iZNl5Y0R60gL0lXqXi/nN/reLshg7nG0X1MPp9g=;
        b=K6cLKFCQeaOKb+YdQBpE/BYk6yBSDBhZn8S12WAdaU3UXW/1JfqkoKxWUb1CzNMDt8pwsD
        o2p3YV5EUQK839YcBccjLUx/DkpbVlEk2mM0JKUkjCPn7tYPRf2kzP2C6fmxWLqEVr4fa8
        06usPfyoNJfP8ot3Amzhq67J/n8PEt4=
Date:   Tue, 3 May 2022 16:12:55 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
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
Subject: Re: [PATCHv5 06/12] x86/boot/compressed: Handle unaccepted memory
Message-ID: <YnE4ZzzVrxUnr3Uv@zn.tnic>
References: <20220425033934.68551-1-kirill.shutemov@linux.intel.com>
 <20220425033934.68551-7-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220425033934.68551-7-kirill.shutemov@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Apr 25, 2022 at 06:39:28AM +0300, Kirill A. Shutemov wrote:
> diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
> index 411b268bc0a2..59db90626042 100644
> --- a/arch/x86/boot/compressed/kaslr.c
> +++ b/arch/x86/boot/compressed/kaslr.c
> @@ -725,10 +725,20 @@ process_efi_entries(unsigned long minimum, unsigned long image_size)
>  		 * but in practice there's firmware where using that memory leads
>  		 * to crashes.
>  		 *
> -		 * Only EFI_CONVENTIONAL_MEMORY is guaranteed to be free.
> +		 * Only EFI_CONVENTIONAL_MEMORY and EFI_UNACCEPTED_MEMORY (if
> +		 * supported) are guaranteed to be free.
>  		 */
> -		if (md->type != EFI_CONVENTIONAL_MEMORY)
> +
> +		switch (md->type) {
> +		case EFI_CONVENTIONAL_MEMORY:
> +			break;
> +		case EFI_UNACCEPTED_MEMORY:
> +			if (IS_ENABLED(CONFIG_UNACCEPTED_MEMORY))
> +				break;
>  			continue;
> +		default:
> +			continue;
> +		}

Is there any special reason for this to be a switch-case or can it
simply be a compound conditional if (bla...) ?

> @@ -66,3 +69,21 @@ void process_unaccepted_memory(struct boot_params *params, u64 start, u64 end)
>  	bitmap_set((unsigned long *)params->unaccepted_memory,
>  		   start / PMD_SIZE, (end - start) / PMD_SIZE);
>  }
> +
> +void accept_memory(phys_addr_t start, phys_addr_t end)
> +{
> +	unsigned long range_start, range_end;
> +	unsigned long *unaccepted_memory;

Please shorten that name so that you don't have to break the lines below.

> +	unsigned long bitmap_size;
> +
> +	unaccepted_memory = (unsigned long *)boot_params->unaccepted_memory;
> +	range_start = start / PMD_SIZE;
> +	bitmap_size = DIV_ROUND_UP(end, PMD_SIZE);
> +
> +	for_each_set_bitrange_from(range_start, range_end,
> +				   unaccepted_memory, bitmap_size) {
> +		__accept_memory(range_start * PMD_SIZE, range_end * PMD_SIZE);
> +		bitmap_clear(unaccepted_memory,
> +			     range_start, range_end - range_start);
> +	}
> +}
> diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
> index fa8969fad011..285b37e28074 100644
> --- a/arch/x86/boot/compressed/misc.c
> +++ b/arch/x86/boot/compressed/misc.c
> @@ -18,6 +18,7 @@
>  #include "../string.h"
>  #include "../voffset.h"
>  #include <asm/bootparam_utils.h>
> +#include <asm/unaccepted_memory.h>
>  
>  /*
>   * WARNING!!
> @@ -451,6 +452,14 @@ asmlinkage __visible void *extract_kernel(void *rmode, memptr heap,
>  #endif
>  
>  	debug_putstr("\nDecompressing Linux... ");
> +
> +#ifdef CONFIG_UNACCEPTED_MEMORY

IS_ENABLED() perhaps?

> +	if (boot_params->unaccepted_memory) {

Also, that ->unaccepted_memory will be set only when
ACONFIG_UNACCEPTED_MEMORY is set, FAICT.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
