Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D11D3A3F67
	for <lists+linux-efi@lfdr.de>; Fri, 11 Jun 2021 11:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231381AbhFKJsh (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 11 Jun 2021 05:48:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231665AbhFKJsg (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 11 Jun 2021 05:48:36 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FCBFC061574;
        Fri, 11 Jun 2021 02:46:38 -0700 (PDT)
Received: from zn.tnic (p2e584d18.dip0.t-ipconnect.de [46.88.77.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 575011EC056B;
        Fri, 11 Jun 2021 11:46:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1623404796;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=pIMNvquN7Yk04MU9AUNgn/GvSbJpSgYJlr5tfol/dGg=;
        b=NbqOZf7MlRJZ2KcZbt+hvJUI2BDZeUwT6CiGj6Ims6a6THannsqU5vJgtU+o5tIheT3bjq
        YVcUD/Uf6HdMndfxtei0l16Wlfoc7AY6ac7CdzWNq2Rrbl9Yltmhky8LWnYFb27od18e+j
        2S8Vj661tQC5cY80ZFV8+KUhhgkUwQE=
Date:   Fri, 11 Jun 2021 11:44:20 +0200
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
        David Rientjes <rientjes@google.com>, tony.luck@intel.com,
        npmccallum@redhat.com
Subject: Re: [PATCH Part1 RFC v3 14/22] x86/mm: Add support to validate
 memory when changing C-bit
Message-ID: <YMMwdJRwbbsh1VVO@zn.tnic>
References: <20210602140416.23573-1-brijesh.singh@amd.com>
 <20210602140416.23573-15-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210602140416.23573-15-brijesh.singh@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Jun 02, 2021 at 09:04:08AM -0500, Brijesh Singh wrote:
> +/* SNP Page State Change NAE event */
> +#define VMGEXIT_PSC_MAX_ENTRY		253
> +
> +struct __packed snp_page_state_header {

psc_hdr

> +	u16 cur_entry;
> +	u16 end_entry;
> +	u32 reserved;
> +};
> +
> +struct __packed snp_page_state_entry {

psc_entry

> +	u64	cur_page	: 12,
> +		gfn		: 40,
> +		operation	: 4,
> +		pagesize	: 1,
> +		reserved	: 7;
> +};
> +
> +struct __packed snp_page_state_change {

snp_psc_desc

or so.

> +	struct snp_page_state_header header;
> +	struct snp_page_state_entry entry[VMGEXIT_PSC_MAX_ENTRY];
> +};

Which would make this struct a lot more readable:

struct __packed snp_psc_desc {
	struct psc_hdr hdr;
	struct psc_entry entries[VMGEXIT_PSC_MAX_ENTRY];

> diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
> index 6e9b45bb38ab..4847ac81cca3 100644
> --- a/arch/x86/kernel/sev.c
> +++ b/arch/x86/kernel/sev.c
> @@ -637,6 +637,113 @@ void __init snp_prep_memory(unsigned long paddr, unsigned int sz, int op)
>  	WARN(1, "invalid memory op %d\n", op);
>  }
>  
> +static int page_state_vmgexit(struct ghcb *ghcb, struct snp_page_state_change *data)

vmgexit_psc

> +{
> +	struct snp_page_state_header *hdr;
> +	int ret = 0;
> +
> +	hdr = &data->header;

Make sure to verify that snp_page_state_header.reserved field is always
0 before working more on the header so that people don't put stuff in
there which you cannot change later because it becomes ABI or whatnot.
Ditto for the other reserved fields.

> +
> +	/*
> +	 * As per the GHCB specification, the hypervisor can resume the guest before
> +	 * processing all the entries. The loop checks whether all the entries are

s/The loop checks/Check/

> +	 * processed. If not, then keep retrying.

What guarantees that that loop will terminate eventually?

> +	 */
> +	while (hdr->cur_entry <= hdr->end_entry) {

I see that "[t]he hypervisor should ensure that cur_entry and end_entry
represent values within the limits of the GHCB Shared Buffer." but let's
sanity-check that HV here too. We don't trust it, remember? :)

> +
> +		ghcb_set_sw_scratch(ghcb, (u64)__pa(data));
> +
> +		ret = sev_es_ghcb_hv_call(ghcb, NULL, SVM_VMGEXIT_PSC, 0, 0);
> +
> +		/* Page State Change VMGEXIT can pass error code through exit_info_2. */
> +		if (WARN(ret || ghcb->save.sw_exit_info_2,
> +			 "SEV-SNP: page state change failed ret=%d exit_info_2=%llx\n",
> +			 ret, ghcb->save.sw_exit_info_2))
> +			return 1;
> +	}
> +
> +	return 0;
> +}
> +
> +static void set_page_state(unsigned long vaddr, unsigned int npages, int op)
> +{
> +	struct snp_page_state_change *data;
> +	struct snp_page_state_header *hdr;
> +	struct snp_page_state_entry *e;
> +	unsigned long vaddr_end;
> +	struct ghcb_state state;
> +	struct ghcb *ghcb;
> +	int idx;
> +
> +	vaddr = vaddr & PAGE_MASK;
> +	vaddr_end = vaddr + (npages << PAGE_SHIFT);

Move those...

> +
> +	ghcb = sev_es_get_ghcb(&state);
> +	if (unlikely(!ghcb))
> +		panic("SEV-SNP: Failed to get GHCB\n");

<--- ... here.

> +
> +	data = (struct snp_page_state_change *)ghcb->shared_buffer;
> +	hdr = &data->header;
> +
> +	while (vaddr < vaddr_end) {
> +		e = data->entry;
> +		memset(data, 0, sizeof(*data));
> +
> +		for (idx = 0; idx < VMGEXIT_PSC_MAX_ENTRY; idx++, e++) {
> +			unsigned long pfn;
> +
> +			if (is_vmalloc_addr((void *)vaddr))
> +				pfn = vmalloc_to_pfn((void *)vaddr);
> +			else
> +				pfn = __pa(vaddr) >> PAGE_SHIFT;
> +
> +			e->gfn = pfn;
> +			e->operation = op;
> +			hdr->end_entry = idx;
> +
> +			/*
> +			 * The GHCB specification provides the flexibility to
> +			 * use either 4K or 2MB page size in the RMP table.
> +			 * The current SNP support does not keep track of the
> +			 * page size used in the RMP table. To avoid the
> +			 * overlap request, use the 4K page size in the RMP
> +			 * table.
> +			 */
> +			e->pagesize = RMP_PG_SIZE_4K;
> +			vaddr = vaddr + PAGE_SIZE;

Please put that
			e++;

here.

It took me a while to find it hidden at the end of the loop and was
scratching my head as to why are we overwriting e-> everytime.

> +
> +			if (vaddr >= vaddr_end)
> +				break;

Instead of this silly check here, you can compute the range starting at
vaddr, VMGEXIT_PSC_MAX_ENTRY pages worth, carve out that second for-loop
in a helper called

__set_page_state()

which does the data preparation and does the vmgexit at the end.

Then the outer loop does only the computation and calls that helper.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
