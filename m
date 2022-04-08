Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E62D14F9D9C
	for <lists+linux-efi@lfdr.de>; Fri,  8 Apr 2022 21:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232075AbiDHTXX (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 8 Apr 2022 15:23:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231718AbiDHTXW (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 8 Apr 2022 15:23:22 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 860931DF84C;
        Fri,  8 Apr 2022 12:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649445677; x=1680981677;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=an1kgKT916kkjGguwaSRlVUu2JyLvI48Hqx3SubWWec=;
  b=hdoUuMjvrFk1liUS+EtEi8aSu2HUvXnNmgolDnNQfI9Ep9t3L+IisXhu
   3s9MnWqQbxY66M1h9HDqjFkfLug/C6F1GgjFRryxb9PP0z8hTz4BuJAQn
   1DA4VkhpTC12RSHbjhi671j/Th0z+Y6T/ij+pI1zI0xPEnaRIK46hKeK5
   hnMbpCxInCckM+scRHph5aGKnhFnWPh+6l3JYoXwvmSbBvDGrGPW5j/Yq
   ikR6dZOS4k1ihI7BC/GS1ZL/56kLuejFJ9a4vxQoOaDutRymdA+pyF5L/
   rI7bgVunQXxsylTXCyF01Z5Ccx8P5JQgd3KuaQi574ELN4znWzsMARve4
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10311"; a="348106442"
X-IronPort-AV: E=Sophos;i="5.90,245,1643702400"; 
   d="scan'208";a="348106442"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 12:21:17 -0700
X-IronPort-AV: E=Sophos;i="5.90,245,1643702400"; 
   d="scan'208";a="525495656"
Received: from tsungtae-mobl.amr.corp.intel.com (HELO [10.134.43.198]) ([10.134.43.198])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 12:21:15 -0700
Message-ID: <0e366406-9a3a-0bf3-e073-272279f6abf2@intel.com>
Date:   Fri, 8 Apr 2022 12:21:19 -0700
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

Just to reiterate: this is a global spinlock.  It's disabling
interrupts.  "Platform-specific memory-acceptance call" will soon become:

	tdx_accept_memory(rs * PMD_SIZE, re * PMD_SIZE);

which is a page-by-page __tdx_module_call():

> +	for (i = 0; i < (end - start) / PAGE_SIZE; i++) {
> +		if (__tdx_module_call(TDACCEPTPAGE, start + i * PAGE_SIZE,
> +				      0, 0, 0, NULL)) {
> +			error("Cannot accept memory: page accept failed\n");
> +		}
> +	}

Each __tdx_module_call() involves a privilege transition that also
surely includes things like changing CR3.  It can't be cheap.  It also
is presumably touching the memory and probably flushing it out of the
CPU caches.  It's also unbounded:

	spin_lock_irqsave(&unaccepted_memory_lock, flags);
	for (i = 0; i < (end - start) / PAGE_SIZE; i++)
		// thousands?  tens-of-thousands of cycles??
	spin_lock_irqsave(&unaccepted_memory_lock, flags);

How far apart can end and start be?  It's at *least* 2MB in the page
allocator, which is on the order of a millisecond.  Are we sure there
aren't any callers that want to do this at a gigabyte granularity?  That
would hold the global lock and disable interrupts on the order of a second.

Do we want to bound the time that the lock can be held?  Or, should we
just let the lockup detectors tell us that we're being naughty?
