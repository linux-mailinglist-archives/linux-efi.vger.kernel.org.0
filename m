Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D471482498
	for <lists+linux-efi@lfdr.de>; Fri, 31 Dec 2021 16:36:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbhLaPga (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 31 Dec 2021 10:36:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbhLaPga (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 31 Dec 2021 10:36:30 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C1A6C061574;
        Fri, 31 Dec 2021 07:36:30 -0800 (PST)
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 238141EC018B;
        Fri, 31 Dec 2021 16:36:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1640964983;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=e73K8Umx7rvCjEFSc9t/jc9In98gI9J2YopzbA2lLtU=;
        b=bGMf3G697Am5T2hdwQXD8IbqbPLMoHyZmpRcs/O32MUOVhvUqO+tOieqtakP1xVwuo7QLB
        qo/KxkT1sdlvncplcBsybyI5UmzJNrDAMGCZ2fgPtfDx3kn/XRl7BmscW7KX0Nq5AcTwLH
        W3FzyP/86itFcuf73PUPJsXqh+u8FDE=
Date:   Fri, 31 Dec 2021 16:36:26 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Brijesh Singh <brijesh.singh@amd.com>,
        Vlastimil Babka <vbabka@suse.cz>
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
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        tony.luck@intel.com, marcorr@google.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v8 20/40] x86/sev: Use SEV-SNP AP creation to start
 secondary CPUs
Message-ID: <Yc8jerEP5CrxfFi4@zn.tnic>
References: <20211210154332.11526-1-brijesh.singh@amd.com>
 <20211210154332.11526-21-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211210154332.11526-21-brijesh.singh@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Dec 10, 2021 at 09:43:12AM -0600, Brijesh Singh wrote:
> diff --git a/arch/x86/include/asm/sev-common.h b/arch/x86/include/asm/sev-common.h
> index 123a96f7dff2..38c14601ae4a 100644
> --- a/arch/x86/include/asm/sev-common.h
> +++ b/arch/x86/include/asm/sev-common.h
> @@ -104,6 +104,7 @@ enum psc_op {
>  	(((u64)(v) & GENMASK_ULL(63, 12)) >> 12)
>  
>  #define GHCB_HV_FT_SNP			BIT_ULL(0)
> +#define GHCB_HV_FT_SNP_AP_CREATION	(BIT_ULL(1) | GHCB_HV_FT_SNP)

Why is bit 0 ORed in? Because it "Requires SEV-SNP Feature."?

You can still enforce that requirement in the test though.

Or all those SEV features should not be bits but masks -
GHCB_HV_FT_SNP_AP_CREATION_MASK for example, seeing how the others
require the previous bits to be set too.

...

>  static DEFINE_PER_CPU(struct sev_es_runtime_data*, runtime_data);
>  DEFINE_STATIC_KEY_FALSE(sev_es_enable_key);
>  
> +static DEFINE_PER_CPU(struct sev_es_save_area *, snp_vmsa);

This is what I mean: the struct is called "sev_es... " but the variable
"snp_...". I.e., it is all sev_<something>.

> +
>  static __always_inline bool on_vc_stack(struct pt_regs *regs)
>  {
>  	unsigned long sp = regs->sp;
> @@ -814,6 +818,231 @@ void snp_set_memory_private(unsigned long vaddr, unsigned int npages)
>  	pvalidate_pages(vaddr, npages, 1);
>  }
>  
> +static int snp_set_vmsa(void *va, bool vmsa)
> +{
> +	u64 attrs;
> +
> +	/*
> +	 * The RMPADJUST instruction is used to set or clear the VMSA bit for
> +	 * a page. A change to the VMSA bit is only performed when running
> +	 * at VMPL0 and is ignored at other VMPL levels. If too low of a target

What does "too low" mean here exactly?

The kernel is not at VMPL0 but the specified level is lower? Weird...

> +	 * VMPL level is specified, the instruction can succeed without changing
> +	 * the VMSA bit should the kernel not be in VMPL0. Using a target VMPL
> +	 * level of 1 will return a FAIL_PERMISSION error if the kernel is not
> +	 * at VMPL0, thus ensuring that the VMSA bit has been properly set when
> +	 * no error is returned.

We do check whether we run at VMPL0 earlier when starting the guest -
see enforce_vmpl0().

I don't think you need any of that additional verification here - just
assume you are at VMPL0.

> +	 */
> +	attrs = 1;
> +	if (vmsa)
> +		attrs |= RMPADJUST_VMSA_PAGE_BIT;
> +
> +	return rmpadjust((unsigned long)va, RMP_PG_SIZE_4K, attrs);
> +}
> +
> +#define __ATTR_BASE		(SVM_SELECTOR_P_MASK | SVM_SELECTOR_S_MASK)
> +#define INIT_CS_ATTRIBS		(__ATTR_BASE | SVM_SELECTOR_READ_MASK | SVM_SELECTOR_CODE_MASK)
> +#define INIT_DS_ATTRIBS		(__ATTR_BASE | SVM_SELECTOR_WRITE_MASK)
> +
> +#define INIT_LDTR_ATTRIBS	(SVM_SELECTOR_P_MASK | 2)
> +#define INIT_TR_ATTRIBS		(SVM_SELECTOR_P_MASK | 3)
> +
> +static void *snp_safe_alloc_page(void)

safe?

And you don't need to say "safe" - snp_alloc_vmsa_page() is perfectly fine.

> +{
> +	unsigned long pfn;
> +	struct page *p;
> +
> +	/*
> +	 * Allocate an SNP safe page to workaround the SNP erratum where
> +	 * the CPU will incorrectly signal an RMP violation  #PF if a
> +	 * hugepage (2mb or 1gb) collides with the RMP entry of VMSA page.

		2MB or 1GB

Collides how? The 4K frame is inside the hugepage?

> +	 * The recommeded workaround is to not use the large page.

Unknown word [recommeded] in comment, suggestions:
        ['recommended', 'recommend', 'recommitted', 'commended', 'commandeered']

> +	 *
> +	 * Allocate one extra page, use a page which is not 2mb aligned

2MB-aligned

> +	 * and free the other.
> +	 */
> +	p = alloc_pages(GFP_KERNEL_ACCOUNT | __GFP_ZERO, 1);
> +	if (!p)
> +		return NULL;
> +
> +	split_page(p, 1);
> +
> +	pfn = page_to_pfn(p);
> +	if (IS_ALIGNED(__pfn_to_phys(pfn), PMD_SIZE)) {
> +		pfn++;
> +		__free_page(p);
> +	} else {
> +		__free_page(pfn_to_page(pfn + 1));
> +	}

AFAICT, this is doing all this stuff so that you can make sure you get a
non-2M-aligned page. I wonder if there's a way to simply ask mm to give
you such page directly.

vbabka?

> +
> +	return page_address(pfn_to_page(pfn));
> +}
> +
> +static int wakeup_cpu_via_vmgexit(int apic_id, unsigned long start_ip)
> +{
> +	struct sev_es_save_area *cur_vmsa, *vmsa;
> +	struct ghcb_state state;
> +	unsigned long flags;
> +	struct ghcb *ghcb;
> +	int cpu, err, ret;
> +	u8 sipi_vector;
> +	u64 cr4;
> +
> +	if ((sev_hv_features & GHCB_HV_FT_SNP_AP_CREATION) != GHCB_HV_FT_SNP_AP_CREATION)
> +		return -EOPNOTSUPP;
> +
> +	/*
> +	 * Verify the desired start IP against the known trampoline start IP
> +	 * to catch any future new trampolines that may be introduced that
> +	 * would require a new protected guest entry point.
> +	 */
> +	if (WARN_ONCE(start_ip != real_mode_header->trampoline_start,
> +		      "Unsupported SEV-SNP start_ip: %lx\n", start_ip))
> +		return -EINVAL;
> +
> +	/* Override start_ip with known protected guest start IP */
> +	start_ip = real_mode_header->sev_es_trampoline_start;
> +
> +	/* Find the logical CPU for the APIC ID */
> +	for_each_present_cpu(cpu) {
> +		if (arch_match_cpu_phys_id(cpu, apic_id))
> +			break;
> +	}
> +	if (cpu >= nr_cpu_ids)
> +		return -EINVAL;
> +
> +	cur_vmsa = per_cpu(snp_vmsa, cpu);
> +
> +	/*
> +	 * A new VMSA is created each time because there is no guarantee that
> +	 * the current VMSA is the kernels or that the vCPU is not running. If

kernel's.

And if it is not the kernel's, whose it is?

> +	 * an attempt was done to use the current VMSA with a running vCPU, a
> +	 * #VMEXIT of that vCPU would wipe out all of the settings being done
> +	 * here.

I don't understand - this is waking up a CPU, how can it ever be a
running vCPU which is using the current VMSA?!

There is per_cpu(snp_vmsa, cpu), who else can be using that one currently?

> +	 */
> +	vmsa = (struct sev_es_save_area *)snp_safe_alloc_page();
> +	if (!vmsa)
> +		return -ENOMEM;
> +
> +	/* CR4 should maintain the MCE value */
> +	cr4 = native_read_cr4() & X86_CR4_MCE;
> +
> +	/* Set the CS value based on the start_ip converted to a SIPI vector */
> +	sipi_vector		= (start_ip >> 12);
> +	vmsa->cs.base		= sipi_vector << 12;
> +	vmsa->cs.limit		= 0xffff;
> +	vmsa->cs.attrib		= INIT_CS_ATTRIBS;
> +	vmsa->cs.selector	= sipi_vector << 8;
> +
> +	/* Set the RIP value based on start_ip */
> +	vmsa->rip		= start_ip & 0xfff;
> +
> +	/* Set VMSA entries to the INIT values as documented in the APM */
> +	vmsa->ds.limit		= 0xffff;
> +	vmsa->ds.attrib		= INIT_DS_ATTRIBS;
> +	vmsa->es		= vmsa->ds;
> +	vmsa->fs		= vmsa->ds;
> +	vmsa->gs		= vmsa->ds;
> +	vmsa->ss		= vmsa->ds;
> +
> +	vmsa->gdtr.limit	= 0xffff;
> +	vmsa->ldtr.limit	= 0xffff;
> +	vmsa->ldtr.attrib	= INIT_LDTR_ATTRIBS;
> +	vmsa->idtr.limit	= 0xffff;
> +	vmsa->tr.limit		= 0xffff;
> +	vmsa->tr.attrib		= INIT_TR_ATTRIBS;
> +
> +	vmsa->efer		= 0x1000;	/* Must set SVME bit */

verify_comment_style: Warning: No tail comments please:
 arch/x86/kernel/sev.c:954 [+   vmsa->efer              = 0x1000;       /* Must set SVME bit */]

> +	vmsa->cr4		= cr4;
> +	vmsa->cr0		= 0x60000010;
> +	vmsa->dr7		= 0x400;
> +	vmsa->dr6		= 0xffff0ff0;
> +	vmsa->rflags		= 0x2;
> +	vmsa->g_pat		= 0x0007040600070406ULL;
> +	vmsa->xcr0		= 0x1;
> +	vmsa->mxcsr		= 0x1f80;
> +	vmsa->x87_ftw		= 0x5555;
> +	vmsa->x87_fcw		= 0x0040;

Yah, those definitely need macros or at least comments ontop denoting
what those naked values are.

> +
> +	/*
> +	 * Set the SNP-specific fields for this VMSA:
> +	 *   VMPL level
> +	 *   SEV_FEATURES (matches the SEV STATUS MSR right shifted 2 bits)
> +	 */

Like this^^

> +	vmsa->vmpl		= 0;
> +	vmsa->sev_features	= sev_status >> 2;
> +
> +	/* Switch the page over to a VMSA page now that it is initialized */
> +	ret = snp_set_vmsa(vmsa, true);
> +	if (ret) {
> +		pr_err("set VMSA page failed (%u)\n", ret);
> +		free_page((unsigned long)vmsa);
> +
> +		return -EINVAL;
> +	}
> +
> +	/* Issue VMGEXIT AP Creation NAE event */
> +	local_irq_save(flags);
> +
> +	ghcb = __sev_get_ghcb(&state);
> +
> +	vc_ghcb_invalidate(ghcb);
> +	ghcb_set_rax(ghcb, vmsa->sev_features);
> +	ghcb_set_sw_exit_code(ghcb, SVM_VMGEXIT_AP_CREATION);
> +	ghcb_set_sw_exit_info_1(ghcb, ((u64)apic_id << 32) | SVM_VMGEXIT_AP_CREATE);
> +	ghcb_set_sw_exit_info_2(ghcb, __pa(vmsa));
> +
> +	sev_es_wr_ghcb_msr(__pa(ghcb));
> +	VMGEXIT();
> +
> +	if (!ghcb_sw_exit_info_1_is_valid(ghcb) ||
> +	    lower_32_bits(ghcb->save.sw_exit_info_1)) {
> +		pr_alert("SNP AP Creation error\n");

alert?

> +		ret = -EINVAL;
> +	}
> +
> +	__sev_put_ghcb(&state);
> +
> +	local_irq_restore(flags);
> +
> +	/* Perform cleanup if there was an error */
> +	if (ret) {
> +		err = snp_set_vmsa(vmsa, false);
> +		if (err)
> +			pr_err("clear VMSA page failed (%u), leaking page\n", err);
> +		else
> +			free_page((unsigned long)vmsa);

That...

> +
> +		vmsa = NULL;
> +	}
> +
> +	/* Free up any previous VMSA page */
> +	if (cur_vmsa) {
> +		err = snp_set_vmsa(cur_vmsa, false);
> +		if (err)
> +			pr_err("clear VMSA page failed (%u), leaking page\n", err);
> +		else
> +			free_page((unsigned long)cur_vmsa);

.. and that wants to be in a common helper.

> +	}
> +
> +	/* Record the current VMSA page */
> +	per_cpu(snp_vmsa, cpu) = vmsa;
> +
> +	return ret;
> +}

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
