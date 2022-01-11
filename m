Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC3E48B7C1
	for <lists+linux-efi@lfdr.de>; Tue, 11 Jan 2022 21:02:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241662AbiAKUCC (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 11 Jan 2022 15:02:02 -0500
Received: from mga03.intel.com ([134.134.136.65]:25879 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241741AbiAKUCB (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 11 Jan 2022 15:02:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641931321; x=1673467321;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=3gIIh0QobaXhCl5g47l0oKFFAo+4H11ox4GXioaEwbU=;
  b=Bbiugd9WHPXouNIaB8j0Fv6pl6wqWO7e3ZPiMmS6+gFUpPmk3NmEW6Cu
   gI39qA6Y0MZcbX2v0IharSeQUzAKpwbunYBQZGMPcs0hfR4RccoOeZpUN
   FiY+RHftmR2WdbaOO64DBHqTRF7ZHSTxrwgGyjDeyM2DDTA/5mdAYNsot
   Ux0Uqh1HEtQycaoZK7hHHZygENlCUdaFwKXb307POtbZ/2IEsRyfjDlhj
   Fet9EFWdDl+PqbDfZAhi+cSFqkDv51v5hmJx9juBrc56X0M5/IZLXHqb0
   /xJ7egC6oWnmrSg2bJAXgPU/k00bsc2zMKnAy/TjwLJaSPZKletz/uSUU
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10224"; a="243528929"
X-IronPort-AV: E=Sophos;i="5.88,279,1635231600"; 
   d="scan'208";a="243528929"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2022 12:02:01 -0800
X-IronPort-AV: E=Sophos;i="5.88,279,1635231600"; 
   d="scan'208";a="613327803"
Received: from padhika1-mobl.amr.corp.intel.com (HELO [10.209.13.65]) ([10.209.13.65])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2022 12:01:59 -0800
Message-ID: <a234c061-4497-3613-d47f-80071cc0e5d4@intel.com>
Date:   Tue, 11 Jan 2022 12:01:56 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCHv2 6/7] x86/mm: Provide helpers for unaccepted memory
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
        Dario Faggioli <dfaggioli@suse.com>, x86@kernel.org,
        linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220111113314.27173-1-kirill.shutemov@linux.intel.com>
 <20220111113314.27173-7-kirill.shutemov@linux.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20220111113314.27173-7-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 1/11/22 03:33, Kirill A. Shutemov wrote:
> Core-mm requires few helpers to support unaccepted memory:
> 
>   - accept_memory() checks the range of addresses against the bitmap and
>     accept memory if needed;
> 
>   - maybe_set_page_offline() checks the bitmap and marks a page with
>     PageOffline() if memory acceptance required on the first
>     allocation of the page.
> 
>   - accept_and_clear_page_offline() accepts memory for the page and clears
>     PageOffline().
> 
...
> +void accept_memory(phys_addr_t start, phys_addr_t end)
> +{
> +	unsigned long flags;
> +	if (!boot_params.unaccepted_memory)
> +		return;
> +
> +	spin_lock_irqsave(&unaccepted_memory_lock, flags);
> +	__accept_memory(start, end);
> +	spin_unlock_irqrestore(&unaccepted_memory_lock, flags);
> +}

Not a big deal, but please cc me on all the patches in the series.  This 
is called from the core mm patches which I wasn't cc'd on.

This also isn't obvious, but this introduces a new, global lock into the 
fast path of the page allocator and holds it for extended periods of 
time.  It won't be taken any more once all memory is accepted, but you 
can sure bet that it will be noticeable until that happens.

*PLEASE* document this.  It needs changelog and probably code comments.

