Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96E554F9C50
	for <lists+linux-efi@lfdr.de>; Fri,  8 Apr 2022 20:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbiDHSRP (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 8 Apr 2022 14:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbiDHSRO (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 8 Apr 2022 14:17:14 -0400
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98433E33;
        Fri,  8 Apr 2022 11:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649441709; x=1680977709;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=NnDC/o/erWxIX6n6pVBFyGcg9uFsnyn/XQ+IyXjB/lw=;
  b=VA65hp+0Xjnld7Sy0gb3MZBf1Y2mKwno1azQqtIsvrZcA+KVFUeqdiyr
   O5AeGRg+TxsVyEl4jKvM6H4QP/7WgYqWH78NcG86MnBCi1H66f70htzo+
   ipphFQhzzTGlZQvW1i5JOYyvQ0wwbGKfNrhFw4WAuxGAchqpkOG8ScvHX
   42cN+lUdpbuU4fz5AstIYKE0UYlm/TQa6c6c0NNZMBwYP84Vx1GLvkA7k
   em1/KCa92SyaKR3UKWzX562iDFnAs4nz796CG6KUuUbUMVd0CCOERB/YC
   Vu5Ytd6QOujpDc41rpHqua9a4ZSq2GEsyqI/XrBHTR29ptFsgWmdDB1HZ
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10311"; a="322349124"
X-IronPort-AV: E=Sophos;i="5.90,245,1643702400"; 
   d="scan'208";a="322349124"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 11:15:09 -0700
X-IronPort-AV: E=Sophos;i="5.90,245,1643702400"; 
   d="scan'208";a="525475880"
Received: from tsungtae-mobl.amr.corp.intel.com (HELO [10.134.43.198]) ([10.134.43.198])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 11:15:07 -0700
Message-ID: <cfd834e2-60bb-78fb-b4a6-519ca173cd4a@intel.com>
Date:   Fri, 8 Apr 2022 11:15:11 -0700
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
 <20220405234343.74045-7-kirill.shutemov@linux.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCHv4 6/8] x86/mm: Provide helpers for unaccepted memory
In-Reply-To: <20220405234343.74045-7-kirill.shutemov@linux.intel.com>
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
> Core-mm requires few helpers to support unaccepted memory:
> 
>  - accept_memory() checks the range of addresses against the bitmap and
>    accept memory if needed.
> 
>  - memory_is_unaccepted() check if anything within the range requires
>    acceptance.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>  arch/x86/include/asm/page.h              |  5 +++
>  arch/x86/include/asm/unaccepted_memory.h |  1 +
>  arch/x86/mm/Makefile                     |  2 +
>  arch/x86/mm/unaccepted_memory.c          | 53 ++++++++++++++++++++++++
>  4 files changed, 61 insertions(+)
>  create mode 100644 arch/x86/mm/unaccepted_memory.c
> 
> diff --git a/arch/x86/include/asm/page.h b/arch/x86/include/asm/page.h
> index 9cc82f305f4b..9ae0064f97e5 100644
> --- a/arch/x86/include/asm/page.h
> +++ b/arch/x86/include/asm/page.h
> @@ -19,6 +19,11 @@
>  struct page;
>  
>  #include <linux/range.h>
> +
> +#ifdef CONFIG_UNACCEPTED_MEMORY
> +#include <asm/unaccepted_memory.h>
> +#endif

It's a lot nicer to just to the #ifdefs inside the header.  Is there a
specific reason to do it this way?

>  extern struct range pfn_mapped[];
>  extern int nr_pfn_mapped;
>  
> diff --git a/arch/x86/include/asm/unaccepted_memory.h b/arch/x86/include/asm/unaccepted_memory.h
> index f1f835d3cd78..a8d12ef1bda8 100644
> --- a/arch/x86/include/asm/unaccepted_memory.h
> +++ b/arch/x86/include/asm/unaccepted_memory.h
> @@ -10,5 +10,6 @@ struct boot_params;
>  void mark_unaccepted(struct boot_params *params, u64 start, u64 num);
>  
>  void accept_memory(phys_addr_t start, phys_addr_t end);
> +bool memory_is_unaccepted(phys_addr_t start, phys_addr_t end);
>  
>  #endif
> diff --git a/arch/x86/mm/Makefile b/arch/x86/mm/Makefile
> index fe3d3061fc11..e327f83e6bbf 100644
> --- a/arch/x86/mm/Makefile
> +++ b/arch/x86/mm/Makefile
> @@ -60,3 +60,5 @@ obj-$(CONFIG_AMD_MEM_ENCRYPT)	+= mem_encrypt_amd.o
>  
>  obj-$(CONFIG_AMD_MEM_ENCRYPT)	+= mem_encrypt_identity.o
>  obj-$(CONFIG_AMD_MEM_ENCRYPT)	+= mem_encrypt_boot.o
> +
> +obj-$(CONFIG_UNACCEPTED_MEMORY)	+= unaccepted_memory.o
> diff --git a/arch/x86/mm/unaccepted_memory.c b/arch/x86/mm/unaccepted_memory.c
> new file mode 100644
> index 000000000000..3588a7cb954c
> --- /dev/null
> +++ b/arch/x86/mm/unaccepted_memory.c
> @@ -0,0 +1,53 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +#include <linux/memblock.h>
> +#include <linux/mm.h>
> +#include <linux/pfn.h>
> +#include <linux/spinlock.h>
> +
> +#include <asm/io.h>
> +#include <asm/setup.h>
> +#include <asm/unaccepted_memory.h>
> +
> +static DEFINE_SPINLOCK(unaccepted_memory_lock);

We need some documentation on what the lock does, either here or in the
changelog.

> +void accept_memory(phys_addr_t start, phys_addr_t end)
> +{
> +	unsigned long *unaccepted_memory;
> +	unsigned long flags;
> +	unsigned int rs, re;
> +
> +	if (!boot_params.unaccepted_memory)
> +		return;
> +
> +	unaccepted_memory = __va(boot_params.unaccepted_memory);
> +	rs = start / PMD_SIZE;
> +
> +	spin_lock_irqsave(&unaccepted_memory_lock, flags);
> +	for_each_set_bitrange_from(rs, re, unaccepted_memory,
> +				   DIV_ROUND_UP(end, PMD_SIZE)) {
> +		/* Platform-specific memory-acceptance call goes here */
> +		panic("Cannot accept memory");
> +		bitmap_clear(unaccepted_memory, rs, re - rs);
> +	}
> +	spin_unlock_irqrestore(&unaccepted_memory_lock, flags);
> +}

That panic() is making me nervous.  Is this bisect-safe?  Is it safe
because there are no callers of this function yet?

> +bool memory_is_unaccepted(phys_addr_t start, phys_addr_t end)
> +{
> +	unsigned long *unaccepted_memory = __va(boot_params.unaccepted_memory);
> +	unsigned long flags;
> +	bool ret = false;
> +
> +	spin_lock_irqsave(&unaccepted_memory_lock, flags);
> +	while (start < end) {
> +		if (test_bit(start / PMD_SIZE, unaccepted_memory)) {
> +			ret = true;
> +			break;
> +		}
> +
> +		start += PMD_SIZE;
> +	}
> +	spin_unlock_irqrestore(&unaccepted_memory_lock, flags);
> +
> +	return ret;
> +}

