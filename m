Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7D684F9C44
	for <lists+linux-efi@lfdr.de>; Fri,  8 Apr 2022 20:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbiDHSKw (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 8 Apr 2022 14:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbiDHSKv (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 8 Apr 2022 14:10:51 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AECC3BCB8;
        Fri,  8 Apr 2022 11:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649441326; x=1680977326;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=lnjfjM6We5ORXBOaO26qklSGxKpKgnuGsjWUu4xUFlQ=;
  b=l/6Dyt1f355JnSJlimN0l/OoXtuAoH62zdotG13T0U4q9Y8ssS+8bCGc
   kEcccVYYUv9B4s5z9CJhBNvLzKeqRjyd6dPm+0e7RQTWfEwfxj+IVXq+Y
   UGa8aXDYhzXEhWahnzub+SsYTRmKxVR9UPn+EauM2Joz6nt6Lvo4K42CY
   F+SRK2rBMpWKWZy7BNHliRyCt0RQ0iVmW3tu9BHshBDIqdkbVPhUbIXok
   x1paRnf7cYHbc6lAi07Q9YDyAwS5vWY/p1YGb7vmHXbBvPtj4PFsvZRUQ
   0JgGjVQceH/oOnyQv55wIU6sK+Xp4JpEkrMpr2KcWuoO8+lPrKPRKUriC
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10311"; a="261647322"
X-IronPort-AV: E=Sophos;i="5.90,245,1643702400"; 
   d="scan'208";a="261647322"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 11:08:46 -0700
X-IronPort-AV: E=Sophos;i="5.90,245,1643702400"; 
   d="scan'208";a="525473383"
Received: from tsungtae-mobl.amr.corp.intel.com (HELO [10.134.43.198]) ([10.134.43.198])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 11:08:45 -0700
Message-ID: <1ac804b3-eaaf-e87d-2fb5-30125c81ae28@intel.com>
Date:   Fri, 8 Apr 2022 11:08:48 -0700
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
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@linux.ibm.com>
References: <20220405234343.74045-1-kirill.shutemov@linux.intel.com>
 <20220405234343.74045-6-kirill.shutemov@linux.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCHv4 5/8] x86/mm: Reserve unaccepted memory bitmap
In-Reply-To: <20220405234343.74045-6-kirill.shutemov@linux.intel.com>
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
> A given page of memory can only be accepted once.  The kernel has a need
> to accept memory both in the early decompression stage and during normal
> runtime.
> 
> A bitmap used to communicate the acceptance state of each page between the
> decompression stage and normal runtime.  This eliminates the possibility of
> attempting to double-accept a page.

... which is fatal, right?  Could you include that an also the rationale
for why it is fatal?

> The bitmap is allocated in EFI stub, decompression stage updates the state
> of pages used for the kernel and initrd and hands the bitmap over to the
> main kernel image via boot_params.

This is really good info.  Could we maybe expand it a bit?

There are several steps in the bitmap's lifecycle:
1. Bitmap is allocated in the EFI stub
2. The kernel decompression code locates it, accepts some pages before
   decompression and marks them in the bitmap.
3. Decompression code points to the bitmap via a boot_param
4. Main kernel locates bitmap via the boot_param and uses it to guide
   runtime acceptance decisions.

> In the runtime kernel, reserve the bitmap's memory to ensure nothing
> overwrites it.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Acked-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
>  arch/x86/kernel/e820.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
> index f267205f2d5a..22d1fe48dcba 100644
> --- a/arch/x86/kernel/e820.c
> +++ b/arch/x86/kernel/e820.c
> @@ -1316,6 +1316,16 @@ void __init e820__memblock_setup(void)
>  	int i;
>  	u64 end;
>  
> +	/* Mark unaccepted memory bitmap reserved */
> +	if (boot_params.unaccepted_memory) {
> +		unsigned long size;
> +
> +		/* One bit per 2MB */
> +		size = DIV_ROUND_UP(e820__end_of_ram_pfn() * PAGE_SIZE,
> +				    PMD_SIZE * BITS_PER_BYTE);
> +		memblock_reserve(boot_params.unaccepted_memory, size);
> +	}

One oddity here: The size is implied by the e820's contents.  Did you
mention somewhere that unaccepted memory is considered E820_TYPE_RAM?
It *has* to be in order for e820__end_of_ram_pfn() to work, right?

