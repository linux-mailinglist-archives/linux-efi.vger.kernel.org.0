Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BCB34FAAAC
	for <lists+linux-efi@lfdr.de>; Sat,  9 Apr 2022 22:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbiDIUVP (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 9 Apr 2022 16:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiDIUVO (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 9 Apr 2022 16:21:14 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 554262180
        for <linux-efi@vger.kernel.org>; Sat,  9 Apr 2022 13:19:06 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id h14so15207840lfl.2
        for <linux-efi@vger.kernel.org>; Sat, 09 Apr 2022 13:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=utPJ4OpHzIuWZ6mtiY7xqmOAIwiwKlyZjzrr4O5cYow=;
        b=nMZ0h7GOa4H2p6vKBZ+JCmQZu33B6qM92cKCiZIf1QR2kpJ+Ky2WnnYLixmsENFjXI
         Jw65IzG6zq1zhXt3viRJhktQ7jSOQaE+luzhMfPZ6QcvILl4T2o/YbLANI198yM/FV+L
         xLbT8eVUHs+YMLR8HQvCU4zUK2kfiZKrXru+qqGJFAkF1xLo2muV2eyV5RZYk1Y43s4k
         2DUkJikTXsnvqgXw13CAfFBIt40FtPlR1cgB+i88r2Me46md6+HpBYTfHODkX9c0y6gq
         JG2kzL/cYdB0PHi/6DM9ygRqiZToZtG+pGbvYIjn07PRMjVuYV1O8l9VCSSOA3yh+jEa
         yqsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=utPJ4OpHzIuWZ6mtiY7xqmOAIwiwKlyZjzrr4O5cYow=;
        b=xrhGivJ7fYrD5qf4+F+lRocAKYnAGSaMKv9K+ApIfFoXAtY9jNcr3jhfXWUa503587
         +VotKsA+bBJmjCUd6+FoKjP7Ra9a9I72iTVmZdoaFYCA2mRYLF3SDeMBpBLDmenCeeT3
         Bz7csGpkEUzpOH6LqFcRmtSu/xIi+yjgo+FAJ/0XT/QsVieBVRPOzIMJ+gqfKXLP1HtF
         cqifKIN0I7Lgfqc9OmFmd7jKZr31CuIAHGZQAchuAqt7BFeboHjPFV4cXefxStjL0uvD
         lJ8P1p76Iufh6gCKnqqcR9ITAsLkoMlNHygqK6/2WmOfukGTh2JN5jByaE2Ccs86thCr
         7dsQ==
X-Gm-Message-State: AOAM5339/iHObW2+5azx03ImUbUMmivW0js0SXdC7MOnVksOkkgW2V8z
        D12dcPp1CjjJ3CVwjCdPBXfLqw==
X-Google-Smtp-Source: ABdhPJxh5rUaKkwO5aFBiCl0/2qtvg3DxbAAW/Dpp1NovAXOzWhBxhdD7Kk7wGK6sEBQevLPGMkAvg==
X-Received: by 2002:a05:6512:6c4:b0:44a:95a4:83e1 with SMTP id u4-20020a05651206c400b0044a95a483e1mr17003345lff.93.1649535544449;
        Sat, 09 Apr 2022 13:19:04 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id v6-20020a2ea446000000b0024b0abb3984sm2422555ljn.134.2022.04.09.13.19.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Apr 2022 13:19:03 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 413631039DB; Sat,  9 Apr 2022 23:20:35 +0300 (+03)
Date:   Sat, 9 Apr 2022 23:20:35 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
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
        Brijesh Singh <brijesh.singh@amd.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>, x86@kernel.org,
        linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv4 4/8] x86/boot/compressed: Handle unaccepted memory
Message-ID: <20220409202035.plaiekzuihov4kvq@box.shutemov.name>
References: <20220405234343.74045-1-kirill.shutemov@linux.intel.com>
 <20220405234343.74045-5-kirill.shutemov@linux.intel.com>
 <043469ae-427c-b2bb-89ff-db8975894266@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <043469ae-427c-b2bb-89ff-db8975894266@intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Apr 08, 2022 at 10:57:17AM -0700, Dave Hansen wrote:
> On 4/5/22 16:43, Kirill A. Shutemov wrote:
> > Firmware is responsible for accepting memory where compressed kernel
> > image and initrd land. But kernel has to accept memory for decompression
> > buffer: accept memory just before decompression starts.
> 
> I think I'd appreciate a sentence or two more about what's going on.
> How about something like this?
> 
> The firmware starts the kernel by booting into the "compressed" kernel
> stub.  That stub's job is to decompress the full kernel image and then
> jump to it.
> 
> The firmware will pre-accept the memory used to run the stub.  But, the
> stub is responsible for accepting the memory into which it decompresses
> the main kernel.  Accept memory just before decompression starts.
> 
> The stub is also responsible for choosing a physical address in which to
> place the decompressed kernel image.  The KASLR mechanism will randomize
> this physical address.  Since the unaccepted memory region is relatively
> small, KASLR would be quite ineffective if it only used the pre-accepted
> area (EFI_CONVENTIONAL_MEMORY).  Ensure that KASLR randomizes among the
> entire physical address space by also including EFI_UNACCEPTED_MEMORY.

Sure, looks good.

> > diff --git a/arch/x86/boot/compressed/bitmap.c b/arch/x86/boot/compressed/bitmap.c
> > index bf58b259380a..ba2de61c0823 100644
> > --- a/arch/x86/boot/compressed/bitmap.c
> > +++ b/arch/x86/boot/compressed/bitmap.c
> > @@ -2,6 +2,48 @@
> >  /* Taken from lib/string.c */
> >  
> >  #include <linux/bitmap.h>
> > +#include <linux/math.h>
> > +#include <linux/minmax.h>
> > +
> > +unsigned long _find_next_bit(const unsigned long *addr1,
> > +		const unsigned long *addr2, unsigned long nbits,
> > +		unsigned long start, unsigned long invert, unsigned long le)
> > +{
> > +	unsigned long tmp, mask;
> > +
> > +	if (unlikely(start >= nbits))
> > +		return nbits;
> > +
> > +	tmp = addr1[start / BITS_PER_LONG];
> > +	if (addr2)
> > +		tmp &= addr2[start / BITS_PER_LONG];
> > +	tmp ^= invert;
> > +
> > +	/* Handle 1st word. */
> > +	mask = BITMAP_FIRST_WORD_MASK(start);
> > +	if (le)
> > +		mask = swab(mask);
> > +
> > +	tmp &= mask;
> > +
> > +	start = round_down(start, BITS_PER_LONG);
> > +
> > +	while (!tmp) {
> > +		start += BITS_PER_LONG;
> > +		if (start >= nbits)
> > +			return nbits;
> > +
> > +		tmp = addr1[start / BITS_PER_LONG];
> > +		if (addr2)
> > +			tmp &= addr2[start / BITS_PER_LONG];
> > +		tmp ^= invert;
> > +	}
> > +
> > +	if (le)
> > +		tmp = swab(tmp);
> > +
> > +	return min(start + __ffs(tmp), nbits);
> > +}
> >  
> >  void __bitmap_set(unsigned long *map, unsigned int start, int len)
> >  {
> > @@ -22,3 +64,23 @@ void __bitmap_set(unsigned long *map, unsigned int start, int len)
> >  		*p |= mask_to_set;
> >  	}
> >  }
> > +
> > +void __bitmap_clear(unsigned long *map, unsigned int start, int len)
> > +{
> > +	unsigned long *p = map + BIT_WORD(start);
> > +	const unsigned int size = start + len;
> > +	int bits_to_clear = BITS_PER_LONG - (start % BITS_PER_LONG);
> > +	unsigned long mask_to_clear = BITMAP_FIRST_WORD_MASK(start);
> > +
> > +	while (len - bits_to_clear >= 0) {
> > +		*p &= ~mask_to_clear;
> > +		len -= bits_to_clear;
> > +		bits_to_clear = BITS_PER_LONG;
> > +		mask_to_clear = ~0UL;
> > +		p++;
> > +	}
> > +	if (len) {
> > +		mask_to_clear &= BITMAP_LAST_WORD_MASK(size);
> > +		*p &= ~mask_to_clear;
> > +	}
> > +}
> 
> It's a real shame that we have to duplicate this code.  Is there
> anything crazy we could do here like
> 
> #include "../../../lib/find_bit.c"
> 
> ?

Well, it would require fracturing source files on the kernel side.

__bitmap_set() and __bitmap_clear() are now in lib/bitmap.c.

_find_next_bit() is in lib/find_bit.c.

Both lib/bitmap.c and lib/find_bit.c have a lot of stuff that are not used
here. I guess we would need to split them into few pieces to make it in
sane way. Do you want me to go this path?

> 
> > diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
> > index 411b268bc0a2..59db90626042 100644
> > --- a/arch/x86/boot/compressed/kaslr.c
> > +++ b/arch/x86/boot/compressed/kaslr.c
> > @@ -725,10 +725,20 @@ process_efi_entries(unsigned long minimum, unsigned long image_size)
> >  		 * but in practice there's firmware where using that memory leads
> >  		 * to crashes.
> >  		 *
> > -		 * Only EFI_CONVENTIONAL_MEMORY is guaranteed to be free.
> > +		 * Only EFI_CONVENTIONAL_MEMORY and EFI_UNACCEPTED_MEMORY (if
> > +		 * supported) are guaranteed to be free.
> >  		 */
> > -		if (md->type != EFI_CONVENTIONAL_MEMORY)
> > +
> > +		switch (md->type) {
> > +		case EFI_CONVENTIONAL_MEMORY:
> > +			break;
> > +		case EFI_UNACCEPTED_MEMORY:
> > +			if (IS_ENABLED(CONFIG_UNACCEPTED_MEMORY))
> > +				break;
> >  			continue;
> > +		default:
> > +			continue;
> > +		}
> >  
> >  		if (efi_soft_reserve_enabled() &&
> >  		    (md->attribute & EFI_MEMORY_SP))
> > diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
> > index fa8969fad011..c1d9d71a6615 100644
> > --- a/arch/x86/boot/compressed/misc.c
> > +++ b/arch/x86/boot/compressed/misc.c
> > @@ -18,6 +18,7 @@
> >  #include "../string.h"
> >  #include "../voffset.h"
> >  #include <asm/bootparam_utils.h>
> > +#include <asm/unaccepted_memory.h>
> >  
> >  /*
> >   * WARNING!!
> > @@ -43,6 +44,9 @@
> >  void *memmove(void *dest, const void *src, size_t n);
> >  #endif
> >  
> > +#undef __pa
> > +#define __pa(x)	((unsigned long)(x))
> 
> Those #undef's always worry me.  Why is this one needed?

arch/x86/boot/compressed/misc.c:47:9: warning: '__pa' macro redefined [-Wmacro-redefined]
#define __pa(x) ((unsigned long)(x))
        ^
arch/x86/include/asm/page.h:47:9: note: previous definition is here
#define __pa(x)         __phys_addr((unsigned long)(x))

Note that sev.c does the same. At least we are consistent :)

> >  /*
> >   * This is set up by the setup-routine at boot-time
> >   */
> > @@ -451,6 +455,13 @@ asmlinkage __visible void *extract_kernel(void *rmode, memptr heap,
> >  #endif
> >  
> >  	debug_putstr("\nDecompressing Linux... ");
> > +
> > +	if (IS_ENABLED(CONFIG_UNACCEPTED_MEMORY) &&
> > +	    boot_params->unaccepted_memory) {
> > +		debug_putstr("Accepting memory... ");
> > +		accept_memory(__pa(output), __pa(output) + needed_size);
> > +	}
> > +
> >  	__decompress(input_data, input_len, NULL, NULL, output, output_len,
> >  			NULL, error);
> >  	parse_elf(output);
> > diff --git a/arch/x86/boot/compressed/unaccepted_memory.c b/arch/x86/boot/compressed/unaccepted_memory.c
> > index d363acf59c08..3ebab63789bb 100644
> > --- a/arch/x86/boot/compressed/unaccepted_memory.c
> > +++ b/arch/x86/boot/compressed/unaccepted_memory.c
> > @@ -51,3 +51,17 @@ void mark_unaccepted(struct boot_params *params, u64 start, u64 end)
> >  	bitmap_set((unsigned long *)params->unaccepted_memory,
> >  		   start / PMD_SIZE, (end - start) / PMD_SIZE);
> >  }
> > +
> > +void accept_memory(phys_addr_t start, phys_addr_t end)
> > +{
> > +	unsigned long *unaccepted_memory;
> > +	unsigned int rs, re;
> > +
> > +	unaccepted_memory = (unsigned long *)boot_params->unaccepted_memory;
> > +	rs = start / PMD_SIZE;
> 
> OK, so start is a physical address, PMD_SIZE is 2^21, and 'rs' is an
> unsigned int.  That means 'rs' can, at most, represent a physical
> address at 2^(21+32), or 2^53.  That's cutting it a *bit* close, don't
> you think?
> 
> Could we please just give 'rs' and 're' real names and make them
> 'unsigned long's, please?  It will surely save at least one other person
> from doing math.  The find_next_bit() functions seem to take ulongs anyway.

Okay. 'range_start' and 'range_end' are good enough names?

> 
> > +	for_each_set_bitrange_from(rs, re, unaccepted_memory,
> > +				   DIV_ROUND_UP(end, PMD_SIZE)) {
> > +		__accept_memory(rs * PMD_SIZE, re * PMD_SIZE);
> > +		bitmap_clear(unaccepted_memory, rs, re - rs);
> > +	}
> > +}
> 
> Could we please introduce some intermediate variable?  For instance:
> 
> 	unsigned long bitmap_size = DIV_ROUND_UP(end, PMD_SIZE);
> 
> That will make this all a lot easier to read.

Okay.

> 
> > diff --git a/arch/x86/include/asm/unaccepted_memory.h b/arch/x86/include/asm/unaccepted_memory.h
> > index cbc24040b853..f1f835d3cd78 100644
> > --- a/arch/x86/include/asm/unaccepted_memory.h
> > +++ b/arch/x86/include/asm/unaccepted_memory.h
> > @@ -9,4 +9,6 @@ struct boot_params;
> >  
> >  void mark_unaccepted(struct boot_params *params, u64 start, u64 num);
> >  
> > +void accept_memory(phys_addr_t start, phys_addr_t end);
> > +
> >  #endif
> 

-- 
 Kirill A. Shutemov
