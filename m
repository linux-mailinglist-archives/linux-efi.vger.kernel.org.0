Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68F3244B34B
	for <lists+linux-efi@lfdr.de>; Tue,  9 Nov 2021 20:34:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241763AbhKIThC (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 9 Nov 2021 14:37:02 -0500
Received: from mail.skyhub.de ([5.9.137.197]:38554 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240056AbhKIThB (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 9 Nov 2021 14:37:01 -0500
Received: from zn.tnic (p200300ec2f18aa00db849a68730b2e8f.dip0.t-ipconnect.de [IPv6:2003:ec:2f18:aa00:db84:9a68:730b:2e8f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id EDEAD1EC0554;
        Tue,  9 Nov 2021 20:34:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1636486454;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=KhtFVkNBZztZBSOG6R4znpcmvwj9RF4NACfyH31lgkw=;
        b=P9e581KpKmShm1XCx9yMh3YHQySDN6OJJvb/2TyNhxV+E/JhKkSDcwG8EA0fmKZgRn0Td5
        +koW5+CZClj1mGSeGXW2KU2+J3RfKCOITdTAMC4CqFnlQLBqOU3IGVNyp+LAaGaYS+ZXLf
        CJHlGY7Ero55fBepCBsp5+VG79pEW1c=
Date:   Tue, 9 Nov 2021 20:34:07 +0100
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
Subject: Re: [PATCH v6 19/42] x86/mm: Add support to validate memory when
 changing C-bit
Message-ID: <YYrNL7U07SxeUQ3E@zn.tnic>
References: <20211008180453.462291-1-brijesh.singh@amd.com>
 <20211008180453.462291-20-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211008180453.462291-20-brijesh.singh@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Oct 08, 2021 at 01:04:30PM -0500, Brijesh Singh wrote:
> +static int vmgexit_psc(struct snp_psc_desc *desc)
> +{
> +	int cur_entry, end_entry, ret;
> +	struct snp_psc_desc *data;
> +	struct ghcb_state state;
> +	struct ghcb *ghcb;
> +	struct psc_hdr *hdr;
> +	unsigned long flags;

        int cur_entry, end_entry, ret;
        struct snp_psc_desc *data;
        struct ghcb_state state;
        struct psc_hdr *hdr;
        unsigned long flags;
        struct ghcb *ghcb;

that's properly sorted.

> +
> +	local_irq_save(flags);

What is that protecting against? Comment about it?

Aha, __sev_get_ghcb() needs to run with IRQs disabled because it is
using the per-CPU GHCB.

> +
> +	ghcb = __sev_get_ghcb(&state);
> +	if (unlikely(!ghcb))
> +		panic("SEV-SNP: Failed to get GHCB\n");
> +
> +	/* Copy the input desc into GHCB shared buffer */
> +	data = (struct snp_psc_desc *)ghcb->shared_buffer;
> +	memcpy(ghcb->shared_buffer, desc, sizeof(*desc));

That shared buffer has a size - check it vs the size of the desc thing.

> +
> +	hdr = &data->hdr;

Why do you need this and why can't you use data->hdr simply?

/me continues reading and realizes why

Oh no, this is tricky. The HV call will modify what @data points to and
thus @hdr will point to new contents. Only then your backwards processing
check below makes sense.

So then you *absoulutely* want to use data->hdr everywhere and then also
write why in the comment above the check that data gets updated by the
HV call.

> +	cur_entry = hdr->cur_entry;
> +	end_entry = hdr->end_entry;
> +
> +	/*
> +	 * As per the GHCB specification, the hypervisor can resume the guest
> +	 * before processing all the entries. Checks whether all the entries

					      Check

> +	 * are processed. If not, then keep retrying.
> +	 *
> +	 * The stragtegy here is to wait for the hypervisor to change the page
> +	 * state in the RMP table before guest access the memory pages. If the

					       accesses

> +	 * page state was not successful, then later memory access will result

"If the page state *change* was not ..."

> +	 * in the crash.

	"in a crash."

> +	 */
> +	while (hdr->cur_entry <= hdr->end_entry) {
> +		ghcb_set_sw_scratch(ghcb, (u64)__pa(data));
> +
> +		ret = sev_es_ghcb_hv_call(ghcb, NULL, SVM_VMGEXIT_PSC, 0, 0);

This should be

		ret = sev_es_ghcb_hv_call(ghcb, true, NULL, SVM_VMGEXIT_PSC, 0, 0);

as we changed it in the meantime to accomodate HyperV isolation VMs.

> +
> +		/*
> +		 * Page State Change VMGEXIT can pass error code through
> +		 * exit_info_2.
> +		 */
> +		if (WARN(ret || ghcb->save.sw_exit_info_2,
> +			 "SEV-SNP: PSC failed ret=%d exit_info_2=%llx\n",
> +			 ret, ghcb->save.sw_exit_info_2)) {
> +			ret = 1;

That ret = 1 goes unused with that "return 0" at the end. It should be
"return ret" at the end.. Ditto for the others. Audit all your exit
paths in this function.

> +			goto out;
> +		}
> +
> +		/*
> +		 * Sanity check that entry processing is not going backward.
> +		 * This will happen only if hypervisor is tricking us.
> +		 */
> +		if (WARN(hdr->end_entry > end_entry || cur_entry > hdr->cur_entry,
> +"SEV-SNP:  PSC processing going backward, end_entry %d (got %d) cur_entry %d (got %d)\n",
> +			 end_entry, hdr->end_entry, cur_entry, hdr->cur_entry)) {
> +			ret = 1;
> +			goto out;
> +		}
> +
> +		/* Verify that reserved bit is not set */
> +		if (WARN(hdr->reserved, "Reserved bit is set in the PSC header\n")) {

Shouldn't that thing happen first after the HV call?

> +			ret = 1;
> +			goto out;
> +		}
> +	}
> +
> +out:
> +	__sev_put_ghcb(&state);
> +	local_irq_restore(flags);
> +
> +	return 0;
> +}
> +
> +static void __set_page_state(struct snp_psc_desc *data, unsigned long vaddr,
> +			     unsigned long vaddr_end, int op)
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
> +
> +		/*
> +		 * The GHCB specification provides the flexibility to
> +		 * use either 4K or 2MB page size in the RMP table.
> +		 * The current SNP support does not keep track of the
> +		 * page size used in the RMP table. To avoid the
> +		 * overlap request,

"avoid overlap request"?

No clue what that means. In general, that comment is talking about
something in the future and is more confusing than explaining stuff.

> use the 4K page size in the RMP
> +		 * table.
> +		 */
> +		e->pagesize = RMP_PG_SIZE_4K;
> +
> +		vaddr = vaddr + PAGE_SIZE;
> +		e++;
> +		i++;
> +	}
> +
> +	if (vmgexit_psc(data))
> +		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_PSC);
> +}
> +
> +static void set_page_state(unsigned long vaddr, unsigned int npages, int op)

Yeah, so this should be named

set_pages_state - notice the plural "pages"

because it works on multiple pages, @npages exactly.

> +{
> +	unsigned long vaddr_end, next_vaddr;
> +	struct snp_psc_desc *desc;
> +
> +	vaddr = vaddr & PAGE_MASK;
> +	vaddr_end = vaddr + (npages << PAGE_SHIFT);

Take those two...

> +
> +	desc = kmalloc(sizeof(*desc), GFP_KERNEL_ACCOUNT);
> +	if (!desc)
> +		panic("SEV-SNP: failed to allocate memory for PSC descriptor\n");


... and put them here.

<--- 

> +
> +	while (vaddr < vaddr_end) {
> +		/*
> +		 * Calculate the last vaddr that can be fit in one
> +		 * struct snp_psc_desc.
> +		 */
> +		next_vaddr = min_t(unsigned long, vaddr_end,
> +				   (VMGEXIT_PSC_MAX_ENTRY * PAGE_SIZE) + vaddr);
> +
> +		__set_page_state(desc, vaddr, next_vaddr, op);
> +
> +		vaddr = next_vaddr;
> +	}
> +
> +	kfree(desc);
> +}
> +
> +void snp_set_memory_shared(unsigned long vaddr, unsigned int npages)
> +{
> +	if (!cc_platform_has(CC_ATTR_SEV_SNP))
> +		return;
> +
> +	pvalidate_pages(vaddr, npages, 0);
> +
> +	set_page_state(vaddr, npages, SNP_PAGE_STATE_SHARED);
> +}
> +
> +void snp_set_memory_private(unsigned long vaddr, unsigned int npages)
> +{
> +	if (!cc_platform_has(CC_ATTR_SEV_SNP))
> +		return;
> +
> +	set_page_state(vaddr, npages, SNP_PAGE_STATE_PRIVATE);
> +
> +	pvalidate_pages(vaddr, npages, 1);
> +}
> +
>  int sev_es_setup_ap_jump_table(struct real_mode_header *rmh)
>  {
>  	u16 startup_cs, startup_ip;
> diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
> index 527957586f3c..ffe51944606a 100644
> --- a/arch/x86/mm/pat/set_memory.c
> +++ b/arch/x86/mm/pat/set_memory.c
> @@ -30,6 +30,7 @@
>  #include <asm/proto.h>
>  #include <asm/memtype.h>
>  #include <asm/set_memory.h>
> +#include <asm/sev.h>
>  
>  #include "../mm_internal.h"
>  
> @@ -2010,8 +2011,22 @@ static int __set_memory_enc_dec(unsigned long addr, int numpages, bool enc)
>  	 */
>  	cpa_flush(&cpa, !this_cpu_has(X86_FEATURE_SME_COHERENT));
>  
> +	/*
> +	 * To maintain the security gurantees of SEV-SNP guest invalidate the memory

"guarantees"

Your spellchecker broke again.

> +	 * before clearing the encryption attribute.
> +	 */
> +	if (!enc)
> +		snp_set_memory_shared(addr, numpages);
> +
>  	ret = __change_page_attr_set_clr(&cpa, 1);
>  
> +	/*
> +	 * Now that memory is mapped encrypted in the page table, validate it
> +	 * so that is consistent with the above page state.
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
