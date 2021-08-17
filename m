Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59F593EF0DF
	for <lists+linux-efi@lfdr.de>; Tue, 17 Aug 2021 19:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231874AbhHQR1C (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 17 Aug 2021 13:27:02 -0400
Received: from mail.skyhub.de ([5.9.137.197]:39710 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230311AbhHQR1B (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 17 Aug 2021 13:27:01 -0400
Received: from zn.tnic (p200300ec2f1175006a73053df3c19379.dip0.t-ipconnect.de [IPv6:2003:ec:2f11:7500:6a73:53d:f3c1:9379])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D659F1EC01B5;
        Tue, 17 Aug 2021 19:26:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1629221183;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=DNJ7vQbeipIQzVqoNzpebqgTcO1JqCy5VA8Wf98/yoc=;
        b=g1khrBdad75yo8euxQQm3YXRG/lrWYNNavOA/yqhWhFYsf3+kH3fltXo+mjEjOxrwlbahA
        RK9GLTwIgfvCxq0DaaKZDczWmhZrDoJ9xvCOsd6/ajPMdZM8QuqEalus8YDh1p3DgNhY7s
        IIh11MTwqipTCOwGaV0F1PgcV7NUGrw=
Date:   Tue, 17 Aug 2021 19:27:02 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Brijesh Singh <brijesh.singh@amd.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        linux-crypto@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
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
        Vlastimil Babka <vbabka@suse.cz>, tony.luck@intel.com,
        npmccallum@redhat.com, brijesh.ksingh@gmail.com
Subject: Re: [PATCH Part1 RFC v4 15/36] x86/mm: Add support to validate
 memory when changing C-bit
Message-ID: <YRvxZtLkVNda9xwX@zn.tnic>
References: <20210707181506.30489-1-brijesh.singh@amd.com>
 <20210707181506.30489-16-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210707181506.30489-16-brijesh.singh@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Jul 07, 2021 at 01:14:45PM -0500, Brijesh Singh wrote:
> +struct __packed psc_hdr {
> +	u16 cur_entry;
> +	u16 end_entry;
> +	u32 reserved;
> +};
> +
> +struct __packed psc_entry {
> +	u64	cur_page	: 12,
> +		gfn		: 40,
> +		operation	: 4,
> +		pagesize	: 1,
> +		reserved	: 7;
> +};
> +
> +struct __packed snp_psc_desc {
> +	struct psc_hdr hdr;
> +	struct psc_entry entries[VMGEXIT_PSC_MAX_ENTRY];
> +};

The majority of kernel code puts __packed after the struct definition,
let's put it there too pls, out of the way.

...

> +static int vmgexit_psc(struct snp_psc_desc *desc)
> +{
> +	int cur_entry, end_entry, ret;
> +	struct snp_psc_desc *data;
> +	struct ghcb_state state;
> +	struct ghcb *ghcb;
> +	struct psc_hdr *hdr;
> +	unsigned long flags;
> +
> +	local_irq_save(flags);
> +
> +	ghcb = __sev_get_ghcb(&state);
> +	if (unlikely(!ghcb))
> +		panic("SEV-SNP: Failed to get GHCB\n");
> +
> +	/* Copy the input desc into GHCB shared buffer */
> +	data = (struct snp_psc_desc *)ghcb->shared_buffer;
> +	memcpy(ghcb->shared_buffer, desc, sizeof(*desc));
> +
> +	hdr = &data->hdr;
> +	cur_entry = hdr->cur_entry;
> +	end_entry = hdr->end_entry;
> +
> +	/*
> +	 * As per the GHCB specification, the hypervisor can resume the guest
> +	 * before processing all the entries. Checks whether all the entries
> +	 * are processed. If not, then keep retrying.
> +	 *
> +	 * The stragtegy here is to wait for the hypervisor to change the page
> +	 * state in the RMP table before guest access the memory pages. If the
> +	 * page state was not successful, then later memory access will result
> +	 * in the crash.
> +	 */
> +	while (hdr->cur_entry <= hdr->end_entry) {
> +		ghcb_set_sw_scratch(ghcb, (u64)__pa(data));
> +
> +		ret = sev_es_ghcb_hv_call(ghcb, NULL, SVM_VMGEXIT_PSC, 0, 0);
> +
> +		/*
> +		 * Page State Change VMGEXIT can pass error code through
> +		 * exit_info_2.
> +		 */
> +		if (WARN(ret || ghcb->save.sw_exit_info_2,
> +			 "SEV-SNP: page state change failed ret=%d exit_info_2=%llx\n",
> +			 ret, ghcb->save.sw_exit_info_2))
> +			return 1;

Yikes, you return here and below with interrupts disabled.

All your returns need to be "goto out;" instead where you do

out:
        __sev_put_ghcb(&state);
        local_irq_restore(flags);

Yap, you very likely need to put the GHCB too.

> +		/*
> +		 * Lets do some sanity check that entry processing is not going
> +		 * backward. This will happen only if hypervisor is tricking us.
> +		 */
> +		if (WARN((hdr->end_entry > end_entry) || (cur_entry > hdr->cur_entry),
> +			"SEV-SNP: page state change processing going backward, end_entry "
> +			"(expected %d got %d) cur_entry (expected %d got %d)\n",
> +			end_entry, hdr->end_entry, cur_entry, hdr->cur_entry))
> +			return 1;

WARNING: quoted string split across lines
#293: FILE: arch/x86/kernel/sev.c:750:
+			"SEV-SNP: page state change processing going backward, end_entry "
+			"(expected %d got %d) cur_entry (expected %d got %d)\n",

If you're wondering what to do, yes, you can really stretch that string
and shorten it too:

                if (WARN((hdr->end_entry > end_entry) || (cur_entry > hdr->cur_entry),
"SEV-SNP: PSC processing going backwards, end_entry %d (got %d) cur_entry: %d (got %d)\n",
                         end_entry, hdr->end_entry, cur_entry, hdr->cur_entry))
                        return 1;

so that it fits on a single line and grepping can find it.

> +		/* Lets verify that reserved bit is not set in the header*/
> +		if (WARN(hdr->reserved, "Reserved bit is set in the PSC header\n"))

psc_entry has a ->reserved field too and since we're iterating over the
entries...

> +			return 1;
> +	}
> +
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
> +		 * overlap request, use the 4K page size in the RMP
> +		 * table.
> +		 */
> +		e->pagesize = RMP_PG_SIZE_4K;
> +
> +		vaddr = vaddr + PAGE_SIZE;
> +		e++;
> +		i++;
> +	}
> +
> +	/* Terminate the guest on page state change failure. */

That comment is kinda obvious :)

> +	if (vmgexit_psc(data))
> +		sev_es_terminate(1, GHCB_TERM_PSC);
> +}
> +
> +static void set_page_state(unsigned long vaddr, unsigned int npages, int op)
> +{
> +	unsigned long vaddr_end, next_vaddr;
> +	struct snp_psc_desc *desc;
> +
> +	vaddr = vaddr & PAGE_MASK;
> +	vaddr_end = vaddr + (npages << PAGE_SHIFT);
> +
> +	desc = kmalloc(sizeof(*desc), GFP_KERNEL_ACCOUNT);

kzalloc() so that you don't have to memset() later in
__set_page_state().

> +	if (!desc)
> +		panic("failed to allocate memory");

Make that error message more distinctive so that *if* it happens, one
can pinpoint the place in the code where the panic comes from.

> +	while (vaddr < vaddr_end) {
> +		/*
> +		 * Calculate the last vaddr that can be fit in one
> +		 * struct snp_psc_desc.
> +		 */
> +		next_vaddr = min_t(unsigned long, vaddr_end,
> +				(VMGEXIT_PSC_MAX_ENTRY * PAGE_SIZE) + vaddr);
> +
> +		__set_page_state(desc, vaddr, next_vaddr, op);
> +
> +		vaddr = next_vaddr;
> +	}
> +
> +	kfree(desc);
> +}
> +

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
