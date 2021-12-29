Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4D224811DC
	for <lists+linux-efi@lfdr.de>; Wed, 29 Dec 2021 12:09:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239836AbhL2LJJ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 29 Dec 2021 06:09:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235880AbhL2LJH (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 29 Dec 2021 06:09:07 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99066C061574;
        Wed, 29 Dec 2021 03:09:06 -0800 (PST)
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4B6031EC04D1;
        Wed, 29 Dec 2021 12:09:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1640776140;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=6+tLU4T4Tpgo3yRqWbgVDQnqev5Uld1hOFCqOOuz+4Q=;
        b=ntuwBAUmqxJEMGkpZ/GLOgUUCRiB0io5cHEImN3rxnntOCA5tGufgE1905XsnaIEMtVN6s
        bhr8TeHKFfpAM4PrM2YhONFRRm/LhdN3O0RoIx/Ok90DZ2Kaj7y09bdntS5EJ+04YTmlQU
        kFlmoW0WlpThsxR/EbolNUxzspLjLgY=
Date:   Wed, 29 Dec 2021 12:09:01 +0100
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
        tony.luck@intel.com, marcorr@google.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v8 15/40] x86/mm: Add support to validate memory when
 changing C-bit
Message-ID: <YcxBzXc4+b+hrXJE@zn.tnic>
References: <20211210154332.11526-1-brijesh.singh@amd.com>
 <20211210154332.11526-16-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211210154332.11526-16-brijesh.singh@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Dec 10, 2021 at 09:43:07AM -0600, Brijesh Singh wrote:
> The set_memory_{encrypt,decrypt}() are used for changing the pages

$ git grep -E "set_memory_decrypt\W"
$

Please check all your commit messages whether you're quoting the proper
functions.

> from decrypted (shared) to encrypted (private) and vice versa.
> When SEV-SNP is active, the page state transition needs to go through
> additional steps.

		    ... "done by the guest."

I think it is important to state here who's supposed to do those
additional steps.

...

> @@ -659,6 +659,161 @@ void __init snp_prep_memory(unsigned long paddr, unsigned int sz, enum psc_op op
>  		WARN(1, "invalid memory op %d\n", op);
>  }
>  
> +static int vmgexit_psc(struct snp_psc_desc *desc)
> +{
> +	int cur_entry, end_entry, ret = 0;
> +	struct snp_psc_desc *data;
> +	struct ghcb_state state;
> +	unsigned long flags;
> +	struct ghcb *ghcb;
> +
> +	/* __sev_get_ghcb() need to run with IRQs disabled because it using per-cpu GHCB */

"... because it uses a per-CPU GHCB."

> +	local_irq_save(flags);
> +
> +	ghcb = __sev_get_ghcb(&state);
> +	if (unlikely(!ghcb))
> +		panic("SEV-SNP: Failed to get GHCB\n");

__sev_get_ghcb() will already panic if even the backup GHCB is active so
you don't need to panic here too - just check the retval.

> +	/* Copy the input desc into GHCB shared buffer */
> +	data = (struct snp_psc_desc *)ghcb->shared_buffer;
> +	memcpy(ghcb->shared_buffer, desc, min_t(int, GHCB_SHARED_BUF_SIZE, sizeof(*desc)));
> +
> +	/*
> +	 * As per the GHCB specification, the hypervisor can resume the guest
> +	 * before processing all the entries. Check whether all the entries
> +	 * are processed. If not, then keep retrying.
> +	 *
> +	 * The stragtegy here is to wait for the hypervisor to change the page

+        * The stragtegy here is to wait for the hypervisor to change the page
Unknown word [stragtegy] in comment, suggestions:
        ['strategy', 'strategist']

> +	 * state in the RMP table before guest accesses the memory pages. If the
> +	 * page state change was not successful, then later memory access will result
> +	 * in a crash.
> +	 */
> +	cur_entry = data->hdr.cur_entry;
> +	end_entry = data->hdr.end_entry;
> +
> +	while (data->hdr.cur_entry <= data->hdr.end_entry) {
> +		ghcb_set_sw_scratch(ghcb, (u64)__pa(data));
> +

Add a comment here:

		/* This will advance the shared buffer data points to. */

I had asked about it already but nada:

"So then you *absoulutely* want to use data->hdr everywhere and then also
write why in the comment above the check that data gets updated by the
HV call."

> +		ret = sev_es_ghcb_hv_call(ghcb, true, NULL, SVM_VMGEXIT_PSC, 0, 0);
> +
> +		/*
> +		 * Page State Change VMGEXIT can pass error code through
> +		 * exit_info_2.
> +		 */
> +		if (WARN(ret || ghcb->save.sw_exit_info_2,
> +			 "SEV-SNP: PSC failed ret=%d exit_info_2=%llx\n",
> +			 ret, ghcb->save.sw_exit_info_2)) {
> +			ret = 1;
> +			goto out;
> +		}
> +
> +		/* Verify that reserved bit is not set */
> +		if (WARN(data->hdr.reserved, "Reserved bit is set in the PSC header\n")) {
> +			ret = 1;
> +			goto out;
> +		}
> +
> +		/*
> +		 * Sanity check that entry processing is not going backward.

"... backwards."

> +		 * This will happen only if hypervisor is tricking us.
> +		 */
> +		if (WARN(data->hdr.end_entry > end_entry || cur_entry > data->hdr.cur_entry,
> +"SEV-SNP:  PSC processing going backward, end_entry %d (got %d) cur_entry %d (got %d)\n",
> +			 end_entry, data->hdr.end_entry, cur_entry, data->hdr.cur_entry)) {
> +			ret = 1;
> +			goto out;
> +		}
> +	}
> +
> +out:
> +	__sev_put_ghcb(&state);
> +	local_irq_restore(flags);
> +
> +	return ret;
> +}
> +
> +static void __set_pages_state(struct snp_psc_desc *data, unsigned long vaddr,
> +			      unsigned long vaddr_end, int op)
> +{
> +	struct psc_hdr *hdr;
> +	struct psc_entry *e;
> +	unsigned long pfn;
> +	int i;
> +
> +	hdr = &data->hdr;
> +	e = data->entries;
> +
> +	memset(data, 0, sizeof(*data));
> +	i = 0;
> +
> +	while (vaddr < vaddr_end) {
> +		if (is_vmalloc_addr((void *)vaddr))
> +			pfn = vmalloc_to_pfn((void *)vaddr);
> +		else
> +			pfn = __pa(vaddr) >> PAGE_SHIFT;
> +
> +		e->gfn = pfn;
> +		e->operation = op;
> +		hdr->end_entry = i;

		/*
		 * Current SNP implementation doesn't keep track of the page size so use
		 * 4K for simplicity.
		 */

> +		e->pagesize = RMP_PG_SIZE_4K;
> +
> +		vaddr = vaddr + PAGE_SIZE;
> +		e++;
> +		i++;
> +	}

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
