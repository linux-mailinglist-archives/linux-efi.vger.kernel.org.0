Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB2DA4F9C18
	for <lists+linux-efi@lfdr.de>; Fri,  8 Apr 2022 19:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238404AbiDHR70 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 8 Apr 2022 13:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238432AbiDHR7Y (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 8 Apr 2022 13:59:24 -0400
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD621129E8A;
        Fri,  8 Apr 2022 10:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649440637; x=1680976637;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=Sa1lBchyw7MHkscyUsu6fFCzNv4L8BJYNiORojwsd0c=;
  b=QCVUfnnseXs5RsSCUm4AXxyZ2D4SYtBJgfThQayToQkUXwtzo4+VFgLq
   lDjyLvdsoF7WdIz7ObivS6W/YWy6j8OZvNeXNENsD0c32TRDAX7mZT2Py
   A44ikzJeTzo0k2EJkgxrLL7ISjoQHnC7uFUaSu/Ulb6ZZx9tuTsAhCJDU
   lnmjKXFjIMtTfkPMkEQ8Rxw1m6LEiOBbp+dryU2TyLlVxrx9+WnmeiR5z
   oGDALaEwL+qn1+gJShI7JpaJXimyaXF8zPb1Rhy5PqgCYzbexKUpJEtik
   ltx76FXmVXLQUoLM/PvxVXZGQMrNnJCdI0YcT3u0AaHP/6YZkMQKrhCqy
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10310"; a="322345534"
X-IronPort-AV: E=Sophos;i="5.90,245,1643702400"; 
   d="scan'208";a="322345534"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 10:57:15 -0700
X-IronPort-AV: E=Sophos;i="5.90,245,1643702400"; 
   d="scan'208";a="525469365"
Received: from tsungtae-mobl.amr.corp.intel.com (HELO [10.134.43.198]) ([10.134.43.198])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 10:57:14 -0700
Message-ID: <043469ae-427c-b2bb-89ff-db8975894266@intel.com>
Date:   Fri, 8 Apr 2022 10:57:17 -0700
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
 <20220405234343.74045-5-kirill.shutemov@linux.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCHv4 4/8] x86/boot/compressed: Handle unaccepted memory
In-Reply-To: <20220405234343.74045-5-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 4/5/22 16:43, Kirill A. Shutemov wrote:
> Firmware is responsible for accepting memory where compressed kernel
> image and initrd land. But kernel has to accept memory for decompression
> buffer: accept memory just before decompression starts.

I think I'd appreciate a sentence or two more about what's going on.
How about something like this?

The firmware starts the kernel by booting into the "compressed" kernel
stub.  That stub's job is to decompress the full kernel image and then
jump to it.

The firmware will pre-accept the memory used to run the stub.  But, the
stub is responsible for accepting the memory into which it decompresses
the main kernel.  Accept memory just before decompression starts.

The stub is also responsible for choosing a physical address in which to
place the decompressed kernel image.  The KASLR mechanism will randomize
this physical address.  Since the unaccepted memory region is relatively
small, KASLR would be quite ineffective if it only used the pre-accepted
area (EFI_CONVENTIONAL_MEMORY).  Ensure that KASLR randomizes among the
entire physical address space by also including EFI_UNACCEPTED_MEMORY.


> diff --git a/arch/x86/boot/compressed/bitmap.c b/arch/x86/boot/compressed/bitmap.c
> index bf58b259380a..ba2de61c0823 100644
> --- a/arch/x86/boot/compressed/bitmap.c
> +++ b/arch/x86/boot/compressed/bitmap.c
> @@ -2,6 +2,48 @@
>  /* Taken from lib/string.c */
>  
>  #include <linux/bitmap.h>
> +#include <linux/math.h>
> +#include <linux/minmax.h>
> +
> +unsigned long _find_next_bit(const unsigned long *addr1,
> +		const unsigned long *addr2, unsigned long nbits,
> +		unsigned long start, unsigned long invert, unsigned long le)
> +{
> +	unsigned long tmp, mask;
> +
> +	if (unlikely(start >= nbits))
> +		return nbits;
> +
> +	tmp = addr1[start / BITS_PER_LONG];
> +	if (addr2)
> +		tmp &= addr2[start / BITS_PER_LONG];
> +	tmp ^= invert;
> +
> +	/* Handle 1st word. */
> +	mask = BITMAP_FIRST_WORD_MASK(start);
> +	if (le)
> +		mask = swab(mask);
> +
> +	tmp &= mask;
> +
> +	start = round_down(start, BITS_PER_LONG);
> +
> +	while (!tmp) {
> +		start += BITS_PER_LONG;
> +		if (start >= nbits)
> +			return nbits;
> +
> +		tmp = addr1[start / BITS_PER_LONG];
> +		if (addr2)
> +			tmp &= addr2[start / BITS_PER_LONG];
> +		tmp ^= invert;
> +	}
> +
> +	if (le)
> +		tmp = swab(tmp);
> +
> +	return min(start + __ffs(tmp), nbits);
> +}
>  
>  void __bitmap_set(unsigned long *map, unsigned int start, int len)
>  {
> @@ -22,3 +64,23 @@ void __bitmap_set(unsigned long *map, unsigned int start, int len)
>  		*p |= mask_to_set;
>  	}
>  }
> +
> +void __bitmap_clear(unsigned long *map, unsigned int start, int len)
> +{
> +	unsigned long *p = map + BIT_WORD(start);
> +	const unsigned int size = start + len;
> +	int bits_to_clear = BITS_PER_LONG - (start % BITS_PER_LONG);
> +	unsigned long mask_to_clear = BITMAP_FIRST_WORD_MASK(start);
> +
> +	while (len - bits_to_clear >= 0) {
> +		*p &= ~mask_to_clear;
> +		len -= bits_to_clear;
> +		bits_to_clear = BITS_PER_LONG;
> +		mask_to_clear = ~0UL;
> +		p++;
> +	}
> +	if (len) {
> +		mask_to_clear &= BITMAP_LAST_WORD_MASK(size);
> +		*p &= ~mask_to_clear;
> +	}
> +}

It's a real shame that we have to duplicate this code.  Is there
anything crazy we could do here like

#include "../../../lib/find_bit.c"

?

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
>  
>  		if (efi_soft_reserve_enabled() &&
>  		    (md->attribute & EFI_MEMORY_SP))
> diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
> index fa8969fad011..c1d9d71a6615 100644
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
> @@ -43,6 +44,9 @@
>  void *memmove(void *dest, const void *src, size_t n);
>  #endif
>  
> +#undef __pa
> +#define __pa(x)	((unsigned long)(x))

Those #undef's always worry me.  Why is this one needed?

>  /*
>   * This is set up by the setup-routine at boot-time
>   */
> @@ -451,6 +455,13 @@ asmlinkage __visible void *extract_kernel(void *rmode, memptr heap,
>  #endif
>  
>  	debug_putstr("\nDecompressing Linux... ");
> +
> +	if (IS_ENABLED(CONFIG_UNACCEPTED_MEMORY) &&
> +	    boot_params->unaccepted_memory) {
> +		debug_putstr("Accepting memory... ");
> +		accept_memory(__pa(output), __pa(output) + needed_size);
> +	}
> +
>  	__decompress(input_data, input_len, NULL, NULL, output, output_len,
>  			NULL, error);
>  	parse_elf(output);
> diff --git a/arch/x86/boot/compressed/unaccepted_memory.c b/arch/x86/boot/compressed/unaccepted_memory.c
> index d363acf59c08..3ebab63789bb 100644
> --- a/arch/x86/boot/compressed/unaccepted_memory.c
> +++ b/arch/x86/boot/compressed/unaccepted_memory.c
> @@ -51,3 +51,17 @@ void mark_unaccepted(struct boot_params *params, u64 start, u64 end)
>  	bitmap_set((unsigned long *)params->unaccepted_memory,
>  		   start / PMD_SIZE, (end - start) / PMD_SIZE);
>  }
> +
> +void accept_memory(phys_addr_t start, phys_addr_t end)
> +{
> +	unsigned long *unaccepted_memory;
> +	unsigned int rs, re;
> +
> +	unaccepted_memory = (unsigned long *)boot_params->unaccepted_memory;
> +	rs = start / PMD_SIZE;

OK, so start is a physical address, PMD_SIZE is 2^21, and 'rs' is an
unsigned int.  That means 'rs' can, at most, represent a physical
address at 2^(21+32), or 2^53.  That's cutting it a *bit* close, don't
you think?

Could we please just give 'rs' and 're' real names and make them
'unsigned long's, please?  It will surely save at least one other person
from doing math.  The find_next_bit() functions seem to take ulongs anyway.

> +	for_each_set_bitrange_from(rs, re, unaccepted_memory,
> +				   DIV_ROUND_UP(end, PMD_SIZE)) {
> +		__accept_memory(rs * PMD_SIZE, re * PMD_SIZE);
> +		bitmap_clear(unaccepted_memory, rs, re - rs);
> +	}
> +}

Could we please introduce some intermediate variable?  For instance:

	unsigned long bitmap_size = DIV_ROUND_UP(end, PMD_SIZE);

That will make this all a lot easier to read.

> diff --git a/arch/x86/include/asm/unaccepted_memory.h b/arch/x86/include/asm/unaccepted_memory.h
> index cbc24040b853..f1f835d3cd78 100644
> --- a/arch/x86/include/asm/unaccepted_memory.h
> +++ b/arch/x86/include/asm/unaccepted_memory.h
> @@ -9,4 +9,6 @@ struct boot_params;
>  
>  void mark_unaccepted(struct boot_params *params, u64 start, u64 num);
>  
> +void accept_memory(phys_addr_t start, phys_addr_t end);
> +
>  #endif

