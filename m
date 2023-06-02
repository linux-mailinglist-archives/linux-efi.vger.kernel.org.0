Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 883FF7203F8
	for <lists+linux-efi@lfdr.de>; Fri,  2 Jun 2023 16:06:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234300AbjFBOGv (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 2 Jun 2023 10:06:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235107AbjFBOGu (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 2 Jun 2023 10:06:50 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6F9C9D;
        Fri,  2 Jun 2023 07:06:48 -0700 (PDT)
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E62EC1EC04C0;
        Fri,  2 Jun 2023 16:06:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1685714807;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=SaB33qhFEqrdCT6iIUaEkSg4Qpuj6zHhoEehkyjEY1c=;
        b=bjEuZJCQAOHdx2PC1qQgfnK8bMM8qb06oVkLOaQrckNzHkqIuwUXgHUsRIQ/53gdIvDp5m
        CfPpDY0XDi4CSIR+pLIcgPlYKn/rkeIn3kjcKmniKO3jnKWC4nb3+2WEjTlqAJKY2VxLjz
        iHPJ5OqkjrwFucFRYI/K3ll2AK7X4m4=
Date:   Fri, 2 Jun 2023 16:06:41 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
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
        Dario Faggioli <dfaggioli@suse.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        aarcange@redhat.com, peterx@redhat.com, x86@kernel.org,
        linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Liam Merwick <liam.merwick@oracle.com>
Subject: Re: [PATCHv13 4/9] x86/boot/compressed: Handle unaccepted memory
Message-ID: <20230602140641.GKZHn3caQpYveKxFgU@fat_crate.local>
References: <20230601182543.19036-1-kirill.shutemov@linux.intel.com>
 <20230601182543.19036-5-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230601182543.19036-5-kirill.shutemov@linux.intel.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Jun 01, 2023 at 09:25:38PM +0300, Kirill A. Shutemov wrote:
> diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
> index 454757fbdfe5..749f0fe7e446 100644
> --- a/arch/x86/boot/compressed/kaslr.c
> +++ b/arch/x86/boot/compressed/kaslr.c
> @@ -672,6 +672,28 @@ static bool process_mem_region(struct mem_vector *region,
>  }
>  
>  #ifdef CONFIG_EFI
> +
> +/*
> + * Only EFI_CONVENTIONAL_MEMORY and EFI_UNACCEPTED_MEMORY (if supported) are
> + * guaranteed to be free.
> + *
> + * It is more conservative in picking free memory than the EFI spec allows:

"Pick free memory more conservatively than the EFI spec allows:
EFI_BOOT_SERVICES_ ..."

> + *
> + * According to the spec, EFI_BOOT_SERVICES_{CODE|DATA} are also free memory
> + * and thus available to place the kernel image into, but in practice there's
> + * firmware where using that memory leads to crashes.

... because that firmware still scratches into that memory or why?

> + */
> +static inline bool memory_type_is_free(efi_memory_desc_t *md)
> +{
> +	if (md->type == EFI_CONVENTIONAL_MEMORY)
> +		return true;
> +
> +	if (md->type == EFI_UNACCEPTED_MEMORY)
> +		return IS_ENABLED(CONFIG_UNACCEPTED_MEMORY);

Make it plan and simple:

	if (IS_ENABLED(CONFIG_UNACCEPTED_MEMORY) &&
	    md->type == EFI_UNACCEPTED_MEMORY)
		return true;

> +
> +	return false;
> +}
> +
>  /*
>   * Returns true if we processed the EFI memmap, which we prefer over the E820
>   * table if it is available.
> @@ -716,18 +738,7 @@ process_efi_entries(unsigned long minimum, unsigned long image_size)
>  	for (i = 0; i < nr_desc; i++) {
>  		md = efi_early_memdesc_ptr(pmap, e->efi_memdesc_size, i);
>  
> -		/*
> -		 * Here we are more conservative in picking free memory than
> -		 * the EFI spec allows:
> -		 *
> -		 * According to the spec, EFI_BOOT_SERVICES_{CODE|DATA} are also
> -		 * free memory and thus available to place the kernel image into,
> -		 * but in practice there's firmware where using that memory leads
> -		 * to crashes.
> -		 *
> -		 * Only EFI_CONVENTIONAL_MEMORY is guaranteed to be free.
> -		 */
> -		if (md->type != EFI_CONVENTIONAL_MEMORY)
> +		if (!memory_type_is_free(md))
>  			continue;
>  
>  		if (efi_soft_reserve_enabled() &&
> diff --git a/arch/x86/boot/compressed/mem.c b/arch/x86/boot/compressed/mem.c
> index 67594fcb11d9..4ecf26576a77 100644
> --- a/arch/x86/boot/compressed/mem.c
> +++ b/arch/x86/boot/compressed/mem.c
> @@ -1,9 +1,40 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  
>  #include "error.h"
> +#include "misc.h"
>  
>  void arch_accept_memory(phys_addr_t start, phys_addr_t end)
>  {
>  	/* Platform-specific memory-acceptance call goes here */
>  	error("Cannot accept memory");
>  }
> +
> +void init_unaccepted_memory(void)
> +{
> +	guid_t guid =  LINUX_EFI_UNACCEPTED_MEM_TABLE_GUID;

An additional space after the "=".

> +	struct efi_unaccepted_memory *unaccepted_table;
> +	unsigned long cfg_table_pa;
> +	unsigned int cfg_table_len;
> +	enum efi_type et;
> +	int ret;
> +
> +	et = efi_get_type(boot_params);
> +	if (et == EFI_TYPE_NONE)
> +		return;
> +
> +	ret = efi_get_conf_table(boot_params, &cfg_table_pa, &cfg_table_len);
> +	if (ret)
> +		error("EFI config table not found.");

What's the point in erroring out here?

> +	unaccepted_table = (void *)efi_find_vendor_table(boot_params,
> +							 cfg_table_pa,
> +							 cfg_table_len,
> +							 guid);
> +	if (!unaccepted_table)
> +		return;
> +
> +	if (unaccepted_table->version != 1)
> +		error("Unknown version of unaccepted memory table\n");
> +
> +	set_unaccepted_table(unaccepted_table);

Why is this a function at all and not a simple assignment?

> diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
> index 014ff222bf4b..36535a3753f5 100644
> --- a/arch/x86/boot/compressed/misc.c
> +++ b/arch/x86/boot/compressed/misc.c
> @@ -455,6 +455,13 @@ asmlinkage __visible void *extract_kernel(void *rmode, memptr heap,
>  #endif
>  
>  	debug_putstr("\nDecompressing Linux... ");
> +
> +	if (IS_ENABLED(CONFIG_UNACCEPTED_MEMORY)) {
> +		debug_putstr("Accepting memory... ");

This needs to happen...

> +		init_unaccepted_memory();

... after the init, after the init has parsed the config table and has
found unaccepted memory.

If not, you don't need to issue anything as that would be wrong.

> +		accept_memory(__pa(output), __pa(output) + needed_size);
> +	}
> +
>  	__decompress(input_data, input_len, NULL, NULL, output, output_len,
>  			NULL, error);
>  	entry_offset = parse_elf(output);

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
