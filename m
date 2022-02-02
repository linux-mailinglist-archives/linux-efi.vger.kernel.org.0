Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B9ED4A7587
	for <lists+linux-efi@lfdr.de>; Wed,  2 Feb 2022 17:11:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232179AbiBBQLE (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 2 Feb 2022 11:11:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiBBQLD (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 2 Feb 2022 11:11:03 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0716C061714;
        Wed,  2 Feb 2022 08:11:03 -0800 (PST)
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 82F7D1EC059E;
        Wed,  2 Feb 2022 17:10:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1643818257;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=AL/TYP+FjyMYqNYKpHLjG276qQ1LF3QnRuNozDQQTPY=;
        b=hVlgFCDt33VWeFAlZgAuBJx843Ihl9fiV4cvYtfgQtSybgKib/+DH0bxSARfzsockGvD1t
        2zkRDwhszWILZLc73/LRzdHf3mpZsjA9Oh2VdKusDZxxNUXzWeFXhz6R3ZEYP4f5kkIEj+
        AlMTMadYdWSQ8rMrwrWHpt1wQrs0/Lw=
Date:   Wed, 2 Feb 2022 17:10:53 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Brijesh Singh <brijesh.singh@amd.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sergio Lopez <slp@redhat.com>, Peter Gonda <pgonda@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Dov Murik <dovmurik@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Michael Roth <michael.roth@amd.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        brijesh.ksingh@gmail.com, tony.luck@intel.com, marcorr@google.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v9 19/43] x86/mm: Add support to validate memory when
 changing C-bit
Message-ID: <YfqtDZGqfv+9mwPQ@zn.tnic>
References: <20220128171804.569796-1-brijesh.singh@amd.com>
 <20220128171804.569796-20-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220128171804.569796-20-brijesh.singh@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Jan 28, 2022 at 11:17:40AM -0600, Brijesh Singh wrote:
> diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
> index 5ee0fbd98d0d..b7ae741a8c66 100644
> --- a/arch/x86/kernel/sev.c
> +++ b/arch/x86/kernel/sev.c
> @@ -655,6 +655,173 @@ void __init snp_prep_memory(unsigned long paddr, unsigned int sz, enum psc_op op
>  		WARN(1, "invalid memory op %d\n", op);
>  }
>  
> +static int vmgexit_psc(struct snp_psc_desc *desc)
> +{
> +	int cur_entry, end_entry, ret = 0;
> +	struct snp_psc_desc *data;
> +	struct ghcb_state state;
> +	struct es_em_ctxt ctxt;
> +	unsigned long flags;
> +	struct ghcb *ghcb;
> +
> +	/*
> +	 * __sev_get_ghcb() needs to run with IRQs disabled because it is using
> +	 * a per-CPU GHCB.
> +	 */
> +	local_irq_save(flags);
> +

I know the guest will terminate anyway but still...

> +	ghcb = __sev_get_ghcb(&state);
> +	if (unlikely(!ghcb))
> +		return 1;

This needs to be (btw, do you really need the unlikely()?)

	if (!ghcb) {
		ret = 1;
		goto out_unlock;
	}

and at the end you have

out:
        __sev_put_ghcb(&state);

out_unlock:
        local_irq_restore(flags);

...

> +static void set_pages_state(unsigned long vaddr, unsigned int npages, int op)
> +{
> +	unsigned long vaddr_end, next_vaddr;
> +	struct snp_psc_desc *desc;
> +
> +	desc = kmalloc(sizeof(*desc), GFP_KERNEL_ACCOUNT);
> +	if (!desc)
> +		panic("SEV-SNP: failed to allocate memory for PSC descriptor\n");
> +
> +	vaddr = vaddr & PAGE_MASK;
> +	vaddr_end = vaddr + (npages << PAGE_SHIFT);
> +
> +	while (vaddr < vaddr_end) {
> +		/*
> +		 * Calculate the last vaddr that can be fit in one

"... that fits in one ... "

and then the comment *fits* :) on a single line too:

		/* Calculate the last vaddr that fits in one struct snp_psc_desc. */

> +		 * struct snp_psc_desc.
> +		 */
> +		next_vaddr = min_t(unsigned long, vaddr_end,
> +				   (VMGEXIT_PSC_MAX_ENTRY * PAGE_SIZE) + vaddr);
> +
> +		__set_pages_state(desc, vaddr, next_vaddr, op);
> +
> +		vaddr = next_vaddr;
> +	}
> +
> +	kfree(desc);
> +}

...

> diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
> index b4072115c8ef..1bc15b9d15f3 100644
> --- a/arch/x86/mm/pat/set_memory.c
> +++ b/arch/x86/mm/pat/set_memory.c
> @@ -32,6 +32,7 @@
>  #include <asm/set_memory.h>
>  #include <asm/hyperv-tlfs.h>
>  #include <asm/mshyperv.h>
> +#include <asm/sev.h>
>  
>  #include "../mm_internal.h"
>  
> @@ -2012,8 +2013,22 @@ static int __set_memory_enc_pgtable(unsigned long addr, int numpages, bool enc)
>  	 */
>  	cpa_flush(&cpa, !this_cpu_has(X86_FEATURE_SME_COHERENT));
>  
> +	/*
> +	 * To maintain the security guarantees of SEV-SNP guest invalidate the
> +	 * memory before clearing the encryption attribute.
> +	 */
> +	if (!enc)
> +		snp_set_memory_shared(addr, numpages);
> +
>  	ret = __change_page_attr_set_clr(&cpa, 1);
>  
> +	/*
> +	 * Now that memory is mapped encrypted in the page table, validate it
> +	 * so that is consistent with the above page state.

" ... so that it is consistent... "

> +	 */
> +	if (!ret && enc)
> +		snp_set_memory_private(addr, numpages);
> +
>  	/*
>  	 * After changing the encryption attribute, we need to flush TLBs again
>  	 * in case any speculative TLB caching occurred (but no need to flush
> -- 
> 2.25.1
> 

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
