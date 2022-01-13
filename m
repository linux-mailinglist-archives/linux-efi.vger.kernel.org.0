Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1057D48D89A
	for <lists+linux-efi@lfdr.de>; Thu, 13 Jan 2022 14:16:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbiAMNQI (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 13 Jan 2022 08:16:08 -0500
Received: from mail.skyhub.de ([5.9.137.197]:44530 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234992AbiAMNQH (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 13 Jan 2022 08:16:07 -0500
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8598C1EC05B0;
        Thu, 13 Jan 2022 14:16:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1642079761;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=9WGoBrjivrLqJxCpV/zv4l0xkczjCFTpEWzWAmYUpRk=;
        b=hO6rTC026rzboOcdbL00rf9aiGWfSdX9/Vc0Eq8wGTmBDnQ8FWJQY9t1MLiIEyC93J3qgF
        JYmy4wtIHM8flS3KD2tcibLc/R9L/Y7pl+P3fHZhL6T95hBmIAHHB3PERAlDj1eUm2u5Ek
        sC0W69m/3cW2/e8xUmmlidRowZ+fbI4=
Date:   Thu, 13 Jan 2022 14:16:05 +0100
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
Subject: Re: [PATCH v8 29/40] x86/compressed/64: add support for SEV-SNP
 CPUID table in #VC handlers
Message-ID: <YeAmFePcPjvMoWCP@zn.tnic>
References: <20211210154332.11526-1-brijesh.singh@amd.com>
 <20211210154332.11526-30-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211210154332.11526-30-brijesh.singh@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Dec 10, 2021 at 09:43:21AM -0600, Brijesh Singh wrote:
> +/*
> + * Individual entries of the SEV-SNP CPUID table, as defined by the SEV-SNP
> + * Firmware ABI, Revision 0.9, Section 7.1, Table 14. Note that the XCR0_IN
> + * and XSS_IN are denoted here as __unused/__unused2, since they are not
> + * needed for the current guest implementation,

That's fine and great but you need to check in the function where you
iterate over those leafs below whether those unused variables are 0
and fail if not. Not that BIOS or whoever creates that table, starts
becoming creative...

> where the size of the buffers
> + * needed to store enabled XSAVE-saved features are calculated rather than
> + * encoded in the CPUID table for each possible combination of XCR0_IN/XSS_IN
> + * to save space.
> + */
> +struct snp_cpuid_fn {
> +	u32 eax_in;
> +	u32 ecx_in;
> +	u64 __unused;
> +	u64 __unused2;
> +	u32 eax;
> +	u32 ebx;
> +	u32 ecx;
> +	u32 edx;
> +	u64 __reserved;

Ditto.

> +} __packed;
> +
> +/*
> + * SEV-SNP CPUID table header, as defined by the SEV-SNP Firmware ABI,
> + * Revision 0.9, Section 8.14.2.6. Also noted there is the SEV-SNP
> + * firmware-enforced limit of 64 entries per CPUID table.
> + */
> +#define SNP_CPUID_COUNT_MAX 64
> +
> +struct snp_cpuid_info {
> +	u32 count;
> +	u32 __reserved1;
> +	u64 __reserved2;
> +	struct snp_cpuid_fn fn[SNP_CPUID_COUNT_MAX];
> +} __packed;
> +
>  /*
>   * Since feature negotiation related variables are set early in the boot
>   * process they must reside in the .data section so as not to be zeroed
> @@ -23,6 +58,20 @@
>   */
>  static u16 ghcb_version __ro_after_init;
>  
> +/* Copy of the SNP firmware's CPUID page. */
> +static struct snp_cpuid_info cpuid_info_copy __ro_after_init;
> +static bool snp_cpuid_initialized __ro_after_init;
> +
> +/*
> + * These will be initialized based on CPUID table so that non-present
> + * all-zero leaves (for sparse tables) can be differentiated from
> + * invalid/out-of-range leaves. This is needed since all-zero leaves
> + * still need to be post-processed.
> + */
> +u32 cpuid_std_range_max __ro_after_init;
> +u32 cpuid_hyp_range_max __ro_after_init;
> +u32 cpuid_ext_range_max __ro_after_init;

All of them: static.

>  static bool __init sev_es_check_cpu_features(void)
>  {
>  	if (!has_cpuflag(X86_FEATURE_RDRAND)) {
> @@ -246,6 +295,244 @@ static int sev_cpuid_hv(u32 func, u32 subfunc, u32 *eax, u32 *ebx,
>  	return 0;
>  }
>  
> +static const struct snp_cpuid_info *

No need for that linebreak here.

> +snp_cpuid_info_get_ptr(void)
> +{
> +	void *ptr;
> +
> +	/*
> +	 * This may be called early while still running on the initial identity
> +	 * mapping. Use RIP-relative addressing to obtain the correct address
> +	 * in both for identity mapping and after switch-over to kernel virtual
> +	 * addresses.
> +	 */

Put that comment over the function name.

And yah, that probably works but eww.

> +	asm ("lea cpuid_info_copy(%%rip), %0"
> +	     : "=r" (ptr)

Why not "=g" and let the compiler decide?

> +	     : "p" (&cpuid_info_copy));
> +
> +	return ptr;
> +}
> +
> +static inline bool snp_cpuid_active(void)
> +{
> +	return snp_cpuid_initialized;
> +}

That looks useless. That variable snp_cpuid_initialized either gets set
or the guest terminates, so practically, if the guest is still running,
you can assume SNP CPUID is properly initialized.

> +static int snp_cpuid_calc_xsave_size(u64 xfeatures_en, u32 base_size,
> +				     u32 *xsave_size, bool compacted)
> +{
> +	const struct snp_cpuid_info *cpuid_info = snp_cpuid_info_get_ptr();
> +	u32 xsave_size_total = base_size;
> +	u64 xfeatures_found = 0;
> +	int i;
> +
> +	for (i = 0; i < cpuid_info->count; i++) {
> +		const struct snp_cpuid_fn *fn = &cpuid_info->fn[i];
> +
> +		if (!(fn->eax_in == 0xD && fn->ecx_in > 1 && fn->ecx_in < 64))
> +			continue;

I guess that test can be as simple as

		if (fn->eax_in != 0xd)
			continue;

or why do you wanna check ECX too? Funky values coming from the CPUID
page?

> +		if (!(xfeatures_en & (BIT_ULL(fn->ecx_in))))
> +			continue;
> +		if (xfeatures_found & (BIT_ULL(fn->ecx_in)))
> +			continue;

What is that test for? Don't tell me the CPUID page allows duplicate
entries...

> +		xfeatures_found |= (BIT_ULL(fn->ecx_in));
> +
> +		if (compacted)
> +			xsave_size_total += fn->eax;
> +		else
> +			xsave_size_total = max(xsave_size_total,
> +					       fn->eax + fn->ebx);
> +	}
> +
> +	/*
> +	 * Either the guest set unsupported XCR0/XSS bits, or the corresponding
> +	 * entries in the CPUID table were not present. This is not a valid
> +	 * state to be in.
> +	 */
> +	if (xfeatures_found != (xfeatures_en & GENMASK_ULL(63, 2)))
> +		return -EINVAL;
> +
> +	*xsave_size = xsave_size_total;
> +
> +	return 0;

This function can return xsave_size in the success case and negative in
the error case so you don't need the IO param *xsave_size.

> +}
> +
> +static void snp_cpuid_hv(u32 func, u32 subfunc, u32 *eax, u32 *ebx, u32 *ecx,
> +			 u32 *edx)
> +{
> +	/*
> +	 * MSR protocol does not support fetching indexed subfunction, but is
> +	 * sufficient to handle current fallback cases. Should that change,
> +	 * make sure to terminate rather than ignoring the index and grabbing
> +	 * random values. If this issue arises in the future, handling can be
> +	 * added here to use GHCB-page protocol for cases that occur late
> +	 * enough in boot that GHCB page is available.
> +	 */
> +	if (cpuid_function_is_indexed(func) && subfunc)
> +		sev_es_terminate(1, GHCB_TERM_CPUID_HV);
> +
> +	if (sev_cpuid_hv(func, 0, eax, ebx, ecx, edx))
> +		sev_es_terminate(1, GHCB_TERM_CPUID_HV);
> +}
> +
> +static bool
> +snp_cpuid_find_validated_func(u32 func, u32 subfunc, u32 *eax, u32 *ebx,

snp_cpuid_get_validated_func()

> +			      u32 *ecx, u32 *edx)
> +{
> +	const struct snp_cpuid_info *cpuid_info = snp_cpuid_info_get_ptr();
> +	int i;
> +
> +	for (i = 0; i < cpuid_info->count; i++) {
> +		const struct snp_cpuid_fn *fn = &cpuid_info->fn[i];
> +
> +		if (fn->eax_in != func)
> +			continue;
> +
> +		if (cpuid_function_is_indexed(func) && fn->ecx_in != subfunc)
> +			continue;
> +
> +		*eax = fn->eax;
> +		*ebx = fn->ebx;
> +		*ecx = fn->ecx;
> +		*edx = fn->edx;
> +
> +		return true;
> +	}
> +
> +	return false;
> +}
> +
> +static bool snp_cpuid_check_range(u32 func)
> +{
> +	if (func <= cpuid_std_range_max ||
> +	    (func >= 0x40000000 && func <= cpuid_hyp_range_max) ||
> +	    (func >= 0x80000000 && func <= cpuid_ext_range_max))
> +		return true;
> +
> +	return false;
> +}
> +
> +static int snp_cpuid_postprocess(u32 func, u32 subfunc, u32 *eax, u32 *ebx,
> +				 u32 *ecx, u32 *edx)

I'm wondering if you could make everything a lot easier by doing

static int snp_cpuid_postprocess(struct cpuid_leaf *leaf)

and marshall around that struct cpuid_leaf which contains func, subfunc,
e[abcd]x instead of dealing with 6 parameters.

Callers of snp_cpuid() can simply allocate it on their stack and hand it
in and it is all in sev-shared.c so nicely self-contained...

...

> +/*
> + * Returns -EOPNOTSUPP if feature not enabled. Any other return value should be
> + * treated as fatal by caller.
> + */
> +static int snp_cpuid(u32 func, u32 subfunc, u32 *eax, u32 *ebx, u32 *ecx,
> +		     u32 *edx)
> +{
> +	if (!snp_cpuid_active())
> +		return -EOPNOTSUPP;

And this becomes superfluous.

> +
> +	if (!snp_cpuid_find_validated_func(func, subfunc, eax, ebx, ecx, edx)) {
> +		/*
> +		 * Some hypervisors will avoid keeping track of CPUID entries
> +		 * where all values are zero, since they can be handled the
> +		 * same as out-of-range values (all-zero). This is useful here
> +		 * as well as it allows virtually all guest configurations to
> +		 * work using a single SEV-SNP CPUID table.
> +		 *
> +		 * To allow for this, there is a need to distinguish between
> +		 * out-of-range entries and in-range zero entries, since the
> +		 * CPUID table entries are only a template that may need to be
> +		 * augmented with additional values for things like
> +		 * CPU-specific information during post-processing. So if it's
> +		 * not in the table, but is still in the valid range, proceed
> +		 * with the post-processing. Otherwise, just return zeros.
> +		 */
> +		*eax = *ebx = *ecx = *edx = 0;
> +		if (!snp_cpuid_check_range(func))
> +			return 0;

Do the check first and then assign.

> +	}
> +
> +	return snp_cpuid_postprocess(func, subfunc, eax, ebx, ecx, edx);
> +}
> +
>  /*
>   * Boot VC Handler - This is the first VC handler during boot, there is no GHCB
>   * page yet, so it only supports the MSR based communication with the
> @@ -253,16 +540,26 @@ static int sev_cpuid_hv(u32 func, u32 subfunc, u32 *eax, u32 *ebx,
>   */
>  void __init do_vc_no_ghcb(struct pt_regs *regs, unsigned long exit_code)
>  {
> +	unsigned int subfn = lower_bits(regs->cx, 32);
>  	unsigned int fn = lower_bits(regs->ax, 32);
>  	u32 eax, ebx, ecx, edx;
> +	int ret;
>  
>  	/* Only CPUID is supported via MSR protocol */
>  	if (exit_code != SVM_EXIT_CPUID)
>  		goto fail;
>  
> +	ret = snp_cpuid(fn, subfn, &eax, &ebx, &ecx, &edx);
> +	if (ret == 0)

	if (!ret)

> +		goto cpuid_done;
> +
> +	if (ret != -EOPNOTSUPP)
> +		goto fail;
> +
>  	if (sev_cpuid_hv(fn, 0, &eax, &ebx, &ecx, &edx))
>  		goto fail;
>  
> +cpuid_done:
>  	regs->ax = eax;
>  	regs->bx = ebx;
>  	regs->cx = ecx;
> @@ -557,12 +854,35 @@ static enum es_result vc_handle_ioio(struct ghcb *ghcb, struct es_em_ctxt *ctxt)
>  	return ret;
>  }
>  
> +static int vc_handle_cpuid_snp(struct pt_regs *regs)
> +{
> +	u32 eax, ebx, ecx, edx;
> +	int ret;
> +
> +	ret = snp_cpuid(regs->ax, regs->cx, &eax, &ebx, &ecx, &edx);
> +	if (ret == 0) {

	if (!ret)

> +		regs->ax = eax;
> +		regs->bx = ebx;
> +		regs->cx = ecx;
> +		regs->dx = edx;
> +	}
> +
> +	return ret;
> +}
> +
>  static enum es_result vc_handle_cpuid(struct ghcb *ghcb,
>  				      struct es_em_ctxt *ctxt)
>  {
>  	struct pt_regs *regs = ctxt->regs;
>  	u32 cr4 = native_read_cr4();
>  	enum es_result ret;
> +	int snp_cpuid_ret;
> +
> +	snp_cpuid_ret = vc_handle_cpuid_snp(regs);
> +	if (snp_cpuid_ret == 0)

	if (! ... - you get the idea.



-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
