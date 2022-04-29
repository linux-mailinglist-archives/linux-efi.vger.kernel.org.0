Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 886D951479D
	for <lists+linux-efi@lfdr.de>; Fri, 29 Apr 2022 12:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237792AbiD2K47 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 29 Apr 2022 06:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239024AbiD2K44 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 29 Apr 2022 06:56:56 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD7A8579AA;
        Fri, 29 Apr 2022 03:53:38 -0700 (PDT)
Received: from zn.tnic (p5de8eeb4.dip0.t-ipconnect.de [93.232.238.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3F48C1EC0453;
        Fri, 29 Apr 2022 12:53:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1651229613;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=CLBqjruz6nJNNoK+VEKQerL5OsRHm91OkA4ph7LgujU=;
        b=oBhT0oDPQYoYhiq3M57NHR0kwDtbkzESqpviQ6APK17N8rFapqRG6H81FABgqsajB/8ox2
        GRf4rKs7ZFj/oNjq2sjGDOJh1REdBXtekFAUxNixxIG18p65MA0Z67tsCvyzGJslJ8ZgZg
        HltjJpVIS2I8CthlPc6405WOuqTXOiY=
Date:   Fri, 29 Apr 2022 12:53:30 +0200
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
Subject: Re: [PATCHv5 05/12] efi/x86: Implement support for unaccepted memory
Message-ID: <YmvDqgcyKOgLYNrT@zn.tnic>
References: <20220425033934.68551-1-kirill.shutemov@linux.intel.com>
 <20220425033934.68551-6-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220425033934.68551-6-kirill.shutemov@linux.intel.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        TRACKER_ID autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Apr 25, 2022 at 06:39:27AM +0300, Kirill A. Shutemov wrote:
> diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
> index 5401985901f5..f9b88174209e 100644
> --- a/drivers/firmware/efi/libstub/x86-stub.c
> +++ b/drivers/firmware/efi/libstub/x86-stub.c
> @@ -15,6 +15,7 @@
>  #include <asm/setup.h>
>  #include <asm/desc.h>
>  #include <asm/boot.h>
> +#include <asm/unaccepted_memory.h>
>  
>  #include "efistub.h"
>  
> @@ -504,6 +505,17 @@ setup_e820(struct boot_params *params, struct setup_data *e820ext, u32 e820ext_s
>  			e820_type = E820_TYPE_PMEM;
>  			break;
>  
> +		case EFI_UNACCEPTED_MEMORY:
> +			if (!IS_ENABLED(CONFIG_UNACCEPTED_MEMORY)) {
> +				efi_warn_once("The system has unaccepted memory,"
> +					     " but kernel does not support it\n");
> +				efi_warn_once("Consider enabling UNACCEPTED_MEMORY\n");

CONFIG_UNACCEPTED_MEMORY

> +				continue;
> +			}
> +			e820_type = E820_TYPE_RAM;
> +			process_unaccepted_memory(params, d->phys_addr,
> +					d->phys_addr + PAGE_SIZE * d->num_pages);

Align arguments on the opening brace.

> +			break;
>  		default:
>  			continue;
>  		}
> @@ -568,6 +580,59 @@ static efi_status_t alloc_e820ext(u32 nr_desc, struct setup_data **e820ext,
>  	return status;
>  }
>  
> +static efi_status_t allocate_unaccepted_memory(struct boot_params *params,
> +					       __u32 nr_desc,
> +					       struct efi_boot_memmap *map)
> +{
> +	unsigned long *mem = NULL;
> +	u64 size, max_addr = 0;
> +	efi_status_t status;
> +	bool found = false;
> +	int i;
> +
> +	/* Check if there's any unaccepted memory and find the max address */
> +	for (i = 0; i < nr_desc; i++) {
> +		efi_memory_desc_t *d;
> +
> +		d = efi_early_memdesc_ptr(*map->map, *map->desc_size, i);
> +		if (d->type == EFI_UNACCEPTED_MEMORY)
> +			found = true;
> +		if (d->phys_addr + d->num_pages * PAGE_SIZE > max_addr)
> +			max_addr = d->phys_addr + d->num_pages * PAGE_SIZE;
> +	}
> +
> +	if (!found) {
> +		params->unaccepted_memory = 0;
> +		return EFI_SUCCESS;
> +	}
> +
> +	/*
> +	 * If unaccepted memory is present allocate a bitmap to track what
> +	 * memory has to be accepted before access.
> +	 *
> +	 * One bit in the bitmap represents 2MiB in the address space:
> +	 * A 4k bitmap can track 64GiB of physical address space.
> +	 *
> +	 * In the worst case scenario -- a huge hole in the middle of the
> +	 * address space -- It needs 256MiB to handle 4PiB of the address
> +	 * space.
> +	 *
> +	 * TODO: handle situation if params->unaccepted_memory has already set.

"... is already set."

And when is that TODO taken care of? Later patch or patchset?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
