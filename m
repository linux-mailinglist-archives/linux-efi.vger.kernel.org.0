Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C35913F7CA0
	for <lists+linux-efi@lfdr.de>; Wed, 25 Aug 2021 21:18:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235172AbhHYTTf (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 25 Aug 2021 15:19:35 -0400
Received: from mail.skyhub.de ([5.9.137.197]:49774 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237549AbhHYTTe (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 25 Aug 2021 15:19:34 -0400
Received: from zn.tnic (p200300ec2f0ea7007b784b676aa09a2d.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:a700:7b78:4b67:6aa0:9a2d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 05D121EC0301;
        Wed, 25 Aug 2021 21:18:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1629919121;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=vGtCbkWWcZU1UftG25Zvj4+jED+zYU9/qkqUZZNspiw=;
        b=ktovmpUyQpXqlSeljgV2k4XrX23GlANVNbHO4/vcqGzv8Cszo/n9kE6TVlAbNko1+BvlB9
        mOo7W2+HhO6mE3fbu/fILBazBq9d8cpdPT69IpDCkCUXuOGx9+T9PAqTOjFok1rWOVTmbm
        JJ1qWHi/vNN7ey2R98H3ZyRZklFTcW8=
Date:   Wed, 25 Aug 2021 21:19:18 +0200
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
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>, tony.luck@intel.com,
        marcorr@google.com, sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH Part1 v5 28/38] x86/compressed/64: enable
 SEV-SNP-validated CPUID in #VC handler
Message-ID: <YSaXtpKT+iE7dxYq@zn.tnic>
References: <20210820151933.22401-1-brijesh.singh@amd.com>
 <20210820151933.22401-29-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210820151933.22401-29-brijesh.singh@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Aug 20, 2021 at 10:19:23AM -0500, Brijesh Singh wrote:
> From: Michael Roth <michael.roth@amd.com>
> 
> CPUID instructions generate a #VC exception for SEV-ES/SEV-SNP guests,
> for which early handlers are currently set up to handle. In the case
> of SEV-SNP, guests can use a special location in guest memory address
> space that has been pre-populated with firmware-validated CPUID
> information to look up the relevant CPUID values rather than
> requesting them from hypervisor via a VMGEXIT.
> 
> Determine the location of the CPUID memory address in advance of any
> CPUID instructions/exceptions and, when available, use it to handle
> the CPUID lookup.
> 
> Signed-off-by: Michael Roth <michael.roth@amd.com>
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> ---
>  arch/x86/boot/compressed/efi.c     |   1 +
>  arch/x86/boot/compressed/head_64.S |   1 +
>  arch/x86/boot/compressed/idt_64.c  |   7 +-
>  arch/x86/boot/compressed/misc.h    |   1 +
>  arch/x86/boot/compressed/sev.c     |   3 +
>  arch/x86/include/asm/sev-common.h  |   2 +
>  arch/x86/include/asm/sev.h         |   3 +
>  arch/x86/kernel/sev-shared.c       | 374 +++++++++++++++++++++++++++++
>  arch/x86/kernel/sev.c              |   4 +
>  9 files changed, 394 insertions(+), 2 deletions(-)

Another huuge patch. I wonder if it can be split...

> diff --git a/arch/x86/boot/compressed/efi.c b/arch/x86/boot/compressed/efi.c
> index 16ff5cb9a1fb..a1529a230ea7 100644
> --- a/arch/x86/boot/compressed/efi.c
> +++ b/arch/x86/boot/compressed/efi.c
> @@ -176,3 +176,4 @@ efi_get_conf_table(struct boot_params *boot_params,
>  
>  	return 0;
>  }
> +

Applying: x86/compressed/64: Enable SEV-SNP-validated CPUID in #VC handler
.git/rebase-apply/patch:21: new blank line at EOF.
+
warning: 1 line adds whitespace errors.

That looks like a stray hunk which doesn't belong.

> diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
> index a2347ded77ea..1c1658693fc9 100644
> --- a/arch/x86/boot/compressed/head_64.S
> +++ b/arch/x86/boot/compressed/head_64.S
> @@ -441,6 +441,7 @@ SYM_CODE_START(startup_64)
>  .Lon_kernel_cs:
>  
>  	pushq	%rsi
> +	movq	%rsi, %rdi		/* real mode address */
>  	call	load_stage1_idt
>  	popq	%rsi
>  
> diff --git a/arch/x86/boot/compressed/idt_64.c b/arch/x86/boot/compressed/idt_64.c
> index 9b93567d663a..1f6511a6625d 100644
> --- a/arch/x86/boot/compressed/idt_64.c
> +++ b/arch/x86/boot/compressed/idt_64.c
> @@ -3,6 +3,7 @@
>  #include <asm/segment.h>
>  #include <asm/trapnr.h>
>  #include "misc.h"
> +#include <asm/sev.h>

asm/ namespaced headers should go together, before the private ones,
i.e., above the misc.h line.

>  static void set_idt_entry(int vector, void (*handler)(void))
>  {
> @@ -28,13 +29,15 @@ static void load_boot_idt(const struct desc_ptr *dtr)
>  }
>  
>  /* Setup IDT before kernel jumping to  .Lrelocated */
> -void load_stage1_idt(void)
> +void load_stage1_idt(void *rmode)
>  {
>  	boot_idt_desc.address = (unsigned long)boot_idt;
>  
>  
> -	if (IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT))
> +	if (IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT)) {
> +		sev_snp_cpuid_init(rmode);
>  		set_idt_entry(X86_TRAP_VC, boot_stage1_vc);
> +	}
>  
>  	load_boot_idt(&boot_idt_desc);
>  }
> diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
> index 16b092fd7aa1..cdd328aa42c2 100644
> --- a/arch/x86/boot/compressed/misc.h
> +++ b/arch/x86/boot/compressed/misc.h
> @@ -190,6 +190,7 @@ int efi_get_conf_table(struct boot_params *boot_params,
>  		       unsigned long *conf_table_pa,
>  		       unsigned int *conf_table_len,
>  		       bool *is_efi_64);
> +

Another stray hunk.

>  #else
>  static inline int
>  efi_find_vendor_table(unsigned long conf_table_pa, unsigned int conf_table_len,
> diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
> index 6e8d97c280aa..910bf5cf010e 100644
> --- a/arch/x86/boot/compressed/sev.c
> +++ b/arch/x86/boot/compressed/sev.c
> @@ -20,6 +20,9 @@
>  #include <asm/fpu/xcr.h>
>  #include <asm/ptrace.h>
>  #include <asm/svm.h>
> +#include <asm/cpuid.h>
> +#include <linux/efi.h>
> +#include <linux/log2.h>

What are those includes for?

Polluting the decompressor namespace with kernel proper defines is a
real pain to untangle as it is. What do you need those for and can you
do it without them?

>  #include "error.h"
>  
> diff --git a/arch/x86/include/asm/sev-common.h b/arch/x86/include/asm/sev-common.h
> index 072540dfb129..5f134c172dbf 100644
> --- a/arch/x86/include/asm/sev-common.h
> +++ b/arch/x86/include/asm/sev-common.h
> @@ -148,6 +148,8 @@ struct snp_psc_desc {
>  #define GHCB_TERM_PSC			1	/* Page State Change failure */
>  #define GHCB_TERM_PVALIDATE		2	/* Pvalidate failure */
>  #define GHCB_TERM_NOT_VMPL0		3	/* SNP guest is not running at VMPL-0 */
> +#define GHCB_TERM_CPUID			4	/* CPUID-validation failure */
> +#define GHCB_TERM_CPUID_HV		5	/* CPUID failure during hypervisor fallback */
>  
>  #define GHCB_RESP_CODE(v)		((v) & GHCB_MSR_INFO_MASK)
>  
> diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
> index 534fa1c4c881..c73931548346 100644
> --- a/arch/x86/include/asm/sev.h
> +++ b/arch/x86/include/asm/sev.h
> @@ -11,6 +11,7 @@
>  #include <linux/types.h>
>  #include <asm/insn.h>
>  #include <asm/sev-common.h>
> +#include <asm/bootparam.h>
>  
>  #define GHCB_PROTOCOL_MIN	1ULL
>  #define GHCB_PROTOCOL_MAX	2ULL
> @@ -126,6 +127,7 @@ void __init snp_prep_memory(unsigned long paddr, unsigned int sz, enum psc_op op
>  void snp_set_memory_shared(unsigned long vaddr, unsigned int npages);
>  void snp_set_memory_private(unsigned long vaddr, unsigned int npages);
>  void snp_set_wakeup_secondary_cpu(void);
> +void sev_snp_cpuid_init(struct boot_params *bp);
>  #else
>  static inline void sev_es_ist_enter(struct pt_regs *regs) { }
>  static inline void sev_es_ist_exit(void) { }
> @@ -141,6 +143,7 @@ static inline void __init snp_prep_memory(unsigned long paddr, unsigned int sz,
>  static inline void snp_set_memory_shared(unsigned long vaddr, unsigned int npages) { }
>  static inline void snp_set_memory_private(unsigned long vaddr, unsigned int npages) { }
>  static inline void snp_set_wakeup_secondary_cpu(void) { }
> +static inline void sev_snp_cpuid_init(struct boot_params *bp) { }
>  #endif
>  
>  #endif
> diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
> index ae4556925485..651980ddbd65 100644
> --- a/arch/x86/kernel/sev-shared.c
> +++ b/arch/x86/kernel/sev-shared.c
> @@ -14,6 +14,25 @@
>  #define has_cpuflag(f)	boot_cpu_has(f)
>  #endif
>  
> +struct sev_snp_cpuid_fn {
> +	u32 eax_in;
> +	u32 ecx_in;
> +	u64 unused;
> +	u64 unused2;

What are those for? Padding? Or are they spec-ed somewhere and left for
future use?

Seeing how the struct is __packed, they probably are part of a spec
definition somewhere.

Link pls.

> +	u32 eax;
> +	u32 ebx;
> +	u32 ecx;
> +	u32 edx;
> +	u64 reserved;

Ditto.

Please prefix all those unused/reserved members with "__".

> +} __packed;
> +
> +struct sev_snp_cpuid_info {
> +	u32 count;
> +	u32 reserved1;
> +	u64 reserved2;

Ditto.

> +	struct sev_snp_cpuid_fn fn[0];
> +} __packed;
> +
>  /*
>   * Since feature negotiation related variables are set early in the boot
>   * process they must reside in the .data section so as not to be zeroed
> @@ -26,6 +45,15 @@ static u16 __ro_after_init ghcb_version;
>  /* Bitmap of SEV features supported by the hypervisor */
>  u64 __ro_after_init sev_hv_features = 0;
>  
> +/*
> + * These are also stored in .data section to avoid the need to re-parse
> + * boot_params and re-determine CPUID memory range when .bss is cleared.
> + */
> +static int sev_snp_cpuid_enabled __section(".data");

That will become part of prot_guest_has() or cc_platform_has() or
whatever its name is going to be.

> +static unsigned long sev_snp_cpuid_pa __section(".data");
> +static unsigned long sev_snp_cpuid_sz __section(".data");
> +static const struct sev_snp_cpuid_info *cpuid_info __section(".data");

All those: __ro_after_init?

Also, just like the ones above have a short comment explaining what they
are, add such comments for those too pls and perhaps what they're used
for.

> +
>  static bool __init sev_es_check_cpu_features(void)
>  {
>  	if (!has_cpuflag(X86_FEATURE_RDRAND)) {
> @@ -236,6 +264,219 @@ static int sev_cpuid_hv(u32 func, u32 subfunc, u32 *eax, u32 *ebx,
>  	return 0;
>  }
>  
> +static bool sev_snp_cpuid_active(void)
> +{
> +	return sev_snp_cpuid_enabled;
> +}

That too will become part of prot_guest_has() or cc_platform_has() or
whatever its name is going to be.

> +
> +static int sev_snp_cpuid_xsave_size(u64 xfeatures_en, u32 base_size,
> +				    u32 *xsave_size, bool compacted)

Function name needs a verb. Please audit all your patches.

> +{
> +	u64 xfeatures_found = 0;
> +	int i;
> +
> +	*xsave_size = base_size;

Set that xsave_size only...
> +
> +	for (i = 0; i < cpuid_info->count; i++) {
> +		const struct sev_snp_cpuid_fn *fn = &cpuid_info->fn[i];
> +
> +		if (!(fn->eax_in == 0xd && fn->ecx_in > 1 && fn->ecx_in < 64))
> +			continue;
> +		if (!(xfeatures_en & (1UL << fn->ecx_in)))
> +			continue;
> +		if (xfeatures_found & (1UL << fn->ecx_in))
> +			continue;
> +
> +		xfeatures_found |= (1UL << fn->ecx_in);

For all use BIT_ULL().

> +		if (compacted)
> +			*xsave_size += fn->eax;
> +		else
> +			*xsave_size = max(*xsave_size, fn->eax + fn->ebx);

... not here ...

> +	}
> +
> +	/*
> +	 * Either the guest set unsupported XCR0/XSS bits, or the corresponding
> +	 * entries in the CPUID table were not present. This is not a valid
> +	 * state to be in.
> +	 */
> +	if (xfeatures_found != (xfeatures_en & ~3ULL))
> +		return -EINVAL;

... but here when you're not going to return an error because callers
will see that value change temporarily which is not clean.

Also, you need to set it once - not during each loop iteration.

> +
> +	return 0;
> +}
> +
> +static void sev_snp_cpuid_hv(u32 func, u32 subfunc, u32 *eax, u32 *ebx,
> +			     u32 *ecx, u32 *edx)
> +{
> +	/*
> +	 * Currently MSR protocol is sufficient to handle fallback cases, but
> +	 * should that change make sure we terminate rather than grabbing random

Fix the "we"s please. Please audit all your patches.

> +	 * values. Handling can be added in future to use GHCB-page protocol for
> +	 * cases that occur late enough in boot that GHCB page is available

End comment sentences with a fullstop. Please audit all your patches.

> +	 */

Also, put that comment over the function.

> +	if (cpuid_function_is_indexed(func) && subfunc != 0)

In all your patches:

s/ != 0//g

> +		sev_es_terminate(1, GHCB_TERM_CPUID_HV);
> +
> +	if (sev_cpuid_hv(func, 0, eax, ebx, ecx, edx))
> +		sev_es_terminate(1, GHCB_TERM_CPUID_HV);
> +}
> +
> +static bool sev_snp_cpuid_find(u32 func, u32 subfunc, u32 *eax, u32 *ebx,

I guess

	find_validated_cpuid_func()

or so to denote where it picks it out from.

> +			       u32 *ecx, u32 *edx)
> +{
> +	int i;
> +	bool found = false;

The tip-tree preferred ordering of variable declarations at the
beginning of a function is reverse fir tree order::

	struct long_struct_name *descriptive_name;
	unsigned long foo, bar;
	unsigned int tmp;
	int ret;

The above is faster to parse than the reverse ordering::

	int ret;
	unsigned int tmp;
	unsigned long foo, bar;
	struct long_struct_name *descriptive_name;

And even more so than random ordering::

	unsigned long foo, bar;
	int ret;
	struct long_struct_name *descriptive_name;
	unsigned int tmp;

Audit all your patches pls.

> +
> +	for (i = 0; i < cpuid_info->count; i++) {
> +		const struct sev_snp_cpuid_fn *fn = &cpuid_info->fn[i];
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
> +		found = true;
> +
> +		break;

That's just silly. Simply:

		return true;


> +	}
> +
> +	return found;

	return false;

here and the "found" variable can go.

> +}
> +
> +static bool sev_snp_cpuid_in_range(u32 func)
> +{
> +	int i;
> +	u32 std_range_min = 0;
> +	u32 std_range_max = 0;
> +	u32 hyp_range_min = 0x40000000;
> +	u32 hyp_range_max = 0;
> +	u32 ext_range_min = 0x80000000;
> +	u32 ext_range_max = 0;
> +
> +	for (i = 0; i < cpuid_info->count; i++) {
> +		const struct sev_snp_cpuid_fn *fn = &cpuid_info->fn[i];
> +
> +		if (fn->eax_in == std_range_min)
> +			std_range_max = fn->eax;
> +		else if (fn->eax_in == hyp_range_min)
> +			hyp_range_max = fn->eax;
> +		else if (fn->eax_in == ext_range_min)
> +			ext_range_max = fn->eax;
> +	}

So this loop which determines those ranges will run each time
sev_snp_cpuid_find() doesn't find @func among the validated CPUID leafs.

Why don't you do that determination once at init...

> +
> +	if ((func >= std_range_min && func <= std_range_max) ||
> +	    (func >= hyp_range_min && func <= hyp_range_max) ||
> +	    (func >= ext_range_min && func <= ext_range_max))

... so that this function becomes only this check?

This is unnecessary work as it is.

> +		return true;
> +
> +	return false;
> +}
> +
> +/*
> + * Returns -EOPNOTSUPP if feature not enabled. Any other return value should be
> + * treated as fatal by caller since we cannot fall back to hypervisor to fetch
> + * the values for security reasons (outside of the specific cases handled here)
> + */
> +static int sev_snp_cpuid(u32 func, u32 subfunc, u32 *eax, u32 *ebx, u32 *ecx,
> +			 u32 *edx)
> +{
> +	if (!sev_snp_cpuid_active())
> +		return -EOPNOTSUPP;
> +
> +	if (!cpuid_info)
> +		return -EIO;
> +
> +	if (!sev_snp_cpuid_find(func, subfunc, eax, ebx, ecx, edx)) {
> +		/*
> +		 * Some hypervisors will avoid keeping track of CPUID entries
> +		 * where all values are zero, since they can be handled the
> +		 * same as out-of-range values (all-zero). In our case, we want
> +		 * to be able to distinguish between out-of-range entries and
> +		 * in-range zero entries, since the CPUID table entries are
> +		 * only a template that may need to be augmented with
> +		 * additional values for things like CPU-specific information.
> +		 * So if it's not in the table, but is still in the valid
> +		 * range, proceed with the fix-ups below. Otherwise, just return
> +		 * zeros.
> +		 */
> +		*eax = *ebx = *ecx = *edx = 0;
> +		if (!sev_snp_cpuid_in_range(func))
> +			goto out;

That label is not needed.

> +	}

All that from here on looks like it should go into a separate function
called

snp_cpuid_postprocess()

where you can do a switch-case on func and have it nice, readable and
extensible there, in case more functions get added.

> +	if (func == 0x1) {
> +		u32 ebx2, edx2;
> +
> +		sev_snp_cpuid_hv(func, subfunc, NULL, &ebx2, NULL, &edx2);
> +		/* initial APIC ID */
> +		*ebx = (*ebx & 0x00FFFFFF) | (ebx2 & 0xFF000000);

For all hex masks: use GENMASK_ULL.

> +		/* APIC enabled bit */
> +		*edx = (*edx & ~BIT_ULL(9)) | (edx2 & BIT_ULL(9));
> +
> +		/* OSXSAVE enabled bit */
> +		if (native_read_cr4() & X86_CR4_OSXSAVE)
> +			*ecx |= BIT_ULL(27);
> +	} else if (func == 0x7) {
> +		/* OSPKE enabled bit */
> +		*ecx &= ~BIT_ULL(4);
> +		if (native_read_cr4() & X86_CR4_PKE)
> +			*ecx |= BIT_ULL(4);
> +	} else if (func == 0xB) {
> +		/* extended APIC ID */
> +		sev_snp_cpuid_hv(func, 0, NULL, NULL, NULL, edx);
> +	} else if (func == 0xd && (subfunc == 0x0 || subfunc == 0x1)) {
> +		bool compacted = false;
> +		u64 xcr0 = 1, xss = 0;
> +		u32 xsave_size;
> +
> +		if (native_read_cr4() & X86_CR4_OSXSAVE)
> +			xcr0 = xgetbv(XCR_XFEATURE_ENABLED_MASK);
> +		if (subfunc == 1) {
> +			/* boot/compressed doesn't set XSS so 0 is fine there */
> +#ifndef __BOOT_COMPRESSED
> +			if (*eax & 0x8) /* XSAVES */
> +				if (boot_cpu_has(X86_FEATURE_XSAVES))

cpu_feature_enabled()

> +					rdmsrl(MSR_IA32_XSS, xss);
> +#endif
> +			/*
> +			 * The PPR and APM aren't clear on what size should be
> +			 * encoded in 0xD:0x1:EBX when compaction is not enabled
> +			 * by either XSAVEC or XSAVES since SNP-capable hardware
> +			 * has the entries fixed as 1. KVM sets it to 0 in this
> +			 * case, but to avoid this becoming an issue it's safer
> +			 * to simply treat this as unsupported or SNP guests.
> +			 */
> +			if (!(*eax & 0xA)) /* (XSAVEC|XSAVES) */

Please put side comments over the line they comment.

> +				return -EINVAL;
> +
> +			compacted = true;
> +		}
> +
> +		if (sev_snp_cpuid_xsave_size(xcr0 | xss, *ebx, &xsave_size,
> +					     compacted))

No need for that linebreak.

> +			return -EINVAL;
> +
> +		*ebx = xsave_size;
> +	} else if (func == 0x8000001E) {
> +		u32 ebx2, ecx2;
> +
> +		/* extended APIC ID */
> +		sev_snp_cpuid_hv(func, subfunc, eax, &ebx2, &ecx2, NULL);
> +		/* compute ID */
> +		*ebx = (*ebx & 0xFFFFFFF00) | (ebx2 & 0x000000FF);
> +		/* node ID */
> +		*ecx = (*ecx & 0xFFFFFFF00) | (ecx2 & 0x000000FF);
> +	}
> +
> +out:
> +	return 0;
> +}
> +
>  /*
>   * Boot VC Handler - This is the first VC handler during boot, there is no GHCB
>   * page yet, so it only supports the MSR based communication with the

Is that comment...

> @@ -244,15 +485,25 @@ static int sev_cpuid_hv(u32 func, u32 subfunc, u32 *eax, u32 *ebx,
>  void __init do_vc_no_ghcb(struct pt_regs *regs, unsigned long exit_code)
>  {
>  	unsigned int fn = lower_bits(regs->ax, 32);
> +	unsigned int subfn = lower_bits(regs->cx, 32);
>  	u32 eax, ebx, ecx, edx;
> +	int ret;
>  
>  	/* Only CPUID is supported via MSR protocol */

... and that still valid?

>  	if (exit_code != SVM_EXIT_CPUID)
>  		goto fail;
>  
> +	ret = sev_snp_cpuid(fn, subfn, &eax, &ebx, &ecx, &edx);
> +	if (ret == 0)
> +		goto out;

I think you mean here "goto cpuid_done;" or so.

> +
> +	if (ret != -EOPNOTSUPP)
> +		goto fail;
> +
>  	if (sev_cpuid_hv(fn, 0, &eax, &ebx, &ecx, &edx))
>  		goto fail;
>  
> +out:
>  	regs->ax = eax;
>  	regs->bx = ebx;
>  	regs->cx = ecx;
> @@ -552,6 +803,19 @@ static enum es_result vc_handle_cpuid(struct ghcb *ghcb,
>  	struct pt_regs *regs = ctxt->regs;
>  	u32 cr4 = native_read_cr4();
>  	enum es_result ret;
> +	u32 eax, ebx, ecx, edx;
> +	int cpuid_ret;
> +
> +	cpuid_ret = sev_snp_cpuid(regs->ax, regs->cx, &eax, &ebx, &ecx, &edx);
> +	if (cpuid_ret == 0) {
> +		regs->ax = eax;
> +		regs->bx = ebx;
> +		regs->cx = ecx;
> +		regs->dx = edx;
> +		return ES_OK;
> +	}
> +	if (cpuid_ret != -EOPNOTSUPP)
> +		return ES_VMM_ERROR;

I don't like this thing slapped inside the function. Pls put it in a separate 

vc_handle_cpuid_snp()

which is called by vc_handle_cpuid() instead.

>  
>  	ghcb_set_rax(ghcb, regs->ax);
>  	ghcb_set_rcx(ghcb, regs->cx);
> @@ -603,3 +867,113 @@ static enum es_result vc_handle_rdtsc(struct ghcb *ghcb,
>  
>  	return ES_OK;
>  }
> +
> +#ifdef BOOT_COMPRESSED
> +static struct setup_data *get_cc_setup_data(struct boot_params *bp)
> +{
> +	struct setup_data *hdr = (struct setup_data *)bp->hdr.setup_data;
> +
> +	while (hdr) {
> +		if (hdr->type == SETUP_CC_BLOB)
> +			return hdr;
> +		hdr = (struct setup_data *)hdr->next;
> +	}
> +
> +	return NULL;
> +}
> +
> +/*
> + * For boot/compressed kernel:
> + *
> + *   1) Search for CC blob in the following order/precedence:
> + *      - via linux boot protocol / setup_data entry
> + *      - via EFI configuration table
> + *   2) Return a pointer to the CC blob, NULL otherwise.
> + */
> +static struct cc_blob_sev_info *sev_snp_probe_cc_blob(struct boot_params *bp)

snp_find_cc_blob() simply.

> +{
> +	struct cc_blob_sev_info *cc_info = NULL;
> +	struct setup_data_cc {
> +		struct setup_data header;
> +		u32 cc_blob_address;
> +	} *sd;

Define that struct above the function and call it "cc_setup_data" like
the rest of the stuff which deals with that.

> +	unsigned long conf_table_pa;
> +	unsigned int conf_table_len;
> +	bool efi_64;
> +
> +	/* Try to get CC blob via setup_data */
> +	sd = (struct setup_data_cc *)get_cc_setup_data(bp);
> +	if (sd) {
> +		cc_info = (struct cc_blob_sev_info *)(unsigned long)sd->cc_blob_address;
> +		goto out_verify;
> +	}
> +
> +	/* CC blob isn't in setup_data, see if it's in the EFI config table */
> +	if (!efi_get_conf_table(bp, &conf_table_pa, &conf_table_len, &efi_64))
> +		(void)efi_find_vendor_table(conf_table_pa, conf_table_len,
> +					    EFI_CC_BLOB_GUID, efi_64,
> +					    (unsigned long *)&cc_info);

Yah, check that retval pls with a proper ret variable. No need to cram
it all together.

> +
> +out_verify:
> +	/* CC blob should be either valid or not present. Fail otherwise. */
> +	if (cc_info && cc_info->magic != CC_BLOB_SEV_HDR_MAGIC)
> +		sev_es_terminate(1, GHCB_SNP_UNSUPPORTED);
> +
> +	return cc_info;
> +}
> +#else
> +/*
> + * Probing for CC blob for run-time kernel will be enabled in a subsequent
> + * patch. For now we need to stub this out.
> + */
> +static struct cc_blob_sev_info *sev_snp_probe_cc_blob(struct boot_params *bp)
> +{
> +	return NULL;
> +}
> +#endif
> +
> +/*
> + * Initial set up of CPUID table when running identity-mapped.
> + *
> + * NOTE: Since SEV_SNP feature partly relies on CPUID checks that can't
> + * happen until we access CPUID page, we skip the check and hope the
> + * bootloader is providing sane values.

So I don't like the sound of that even one bit. We shouldn't hope
anything here...

> Current code relies on all CPUID
> + * page lookups originating from #VC handler, which at least provides
> + * indication that SEV-ES is enabled. Subsequent init levels will check for
> + * SEV_SNP feature once available to also take SEV MSR value into account.
> + */
> +void sev_snp_cpuid_init(struct boot_params *bp)

snp_cpuid_init()

In general, prefix all SNP-specific variables, structs, functions, etc
with "snp_" simply.

> +{
> +	struct cc_blob_sev_info *cc_info;
> +
> +	if (!bp)
> +		sev_es_terminate(1, GHCB_TERM_CPUID);
> +
> +	cc_info = sev_snp_probe_cc_blob(bp);
> +

^ Superfluous newline.

> +	if (!cc_info)
> +		return;
> +
> +	sev_snp_cpuid_pa = cc_info->cpuid_phys;
> +	sev_snp_cpuid_sz = cc_info->cpuid_len;

You can do those assignments ...

> +
> +	/*
> +	 * These should always be valid values for SNP, even if guest isn't
> +	 * actually configured to use the CPUID table.
> +	 */
> +	if (!sev_snp_cpuid_pa || sev_snp_cpuid_sz < PAGE_SIZE)
> +		sev_es_terminate(1, GHCB_TERM_CPUID);


... here, after you've verified them.

> +
> +	cpuid_info = (const struct sev_snp_cpuid_info *)sev_snp_cpuid_pa;
> +
> +	/*
> +	 * We should be able to trust the 'count' value in the CPUID table
> +	 * area, but ensure it agrees with CC blob value to be safe.
> +	 */
> +	if (sev_snp_cpuid_sz < (sizeof(struct sev_snp_cpuid_info) +
> +				sizeof(struct sev_snp_cpuid_fn) *
> +				cpuid_info->count))

Yah, this is the type of paranoia I'm talking about!

> +		sev_es_terminate(1, GHCB_TERM_CPUID);
> +
> +	sev_snp_cpuid_enabled = 1;
> +}
> diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
> index ddf8ced4a879..d7b6f7420551 100644
> --- a/arch/x86/kernel/sev.c
> +++ b/arch/x86/kernel/sev.c
> @@ -19,6 +19,8 @@
>  #include <linux/kernel.h>
>  #include <linux/mm.h>
>  #include <linux/cpumask.h>
> +#include <linux/log2.h>
> +#include <linux/efi.h>
>  
>  #include <asm/cpu_entry_area.h>
>  #include <asm/stacktrace.h>
> @@ -32,6 +34,8 @@
>  #include <asm/smp.h>
>  #include <asm/cpu.h>
>  #include <asm/apic.h>
> +#include <asm/efi.h>
> +#include <asm/cpuid.h>
>  
>  #include "sev-internal.h"

What are those includes for?

Looks like a leftover...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
