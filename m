Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B9553A9B9E
	for <lists+linux-efi@lfdr.de>; Wed, 16 Jun 2021 15:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233147AbhFPNJw (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 16 Jun 2021 09:09:52 -0400
Received: from mail.skyhub.de ([5.9.137.197]:39064 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232842AbhFPNJv (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 16 Jun 2021 09:09:51 -0400
Received: from zn.tnic (p200300ec2f0c2b00ec25a986a17212ee.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:2b00:ec25:a986:a172:12ee])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 96CD31EC034B;
        Wed, 16 Jun 2021 15:07:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1623848863;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=8yMX5wXDTeBZiEndRx46KxuvK70cJvRc3Y8fir3mrlw=;
        b=WDIxjwPptED+sxhXVr4DebXCFDLW8mtSgcNBYWtYFsKOYuGQWek745RisCXpCy9k7nAUoH
        8tm/3FFXAq5mbENPHW2GhtSl8/DeM3GO9werqpnARh9UL7OWh87hL8jwc8KIOW8kM2uDMf
        NDDoT5/tDVPWYq0DjN1e9lPctPIWEvs=
Date:   Wed, 16 Jun 2021 15:07:38 +0200
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
Subject: Re: [PATCH Part1 RFC v3 19/22] x86/sev-snp: SEV-SNP AP creation
 support
Message-ID: <YMn3mnyLDUNYGJA2@zn.tnic>
References: <20210602140416.23573-1-brijesh.singh@amd.com>
 <20210602140416.23573-20-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210602140416.23573-20-brijesh.singh@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Jun 02, 2021 at 09:04:13AM -0500, Brijesh Singh wrote:
> From: Tom Lendacky <thomas.lendacky@amd.com>

> Subject: Re: [PATCH Part1 RFC v3 19/22] x86/sev-snp: SEV-SNP AP creation support

The condensed patch description in the subject line should be written in
imperative tone. I.e., it needs a verb.

And to simplify it even more, let's prefix all SEV-* stuff with
"x86/sev: " from now on to mean the whole encrypted virt area.

> To provide a more secure way to start APs under SEV-SNP, use the SEV-SNP
> AP Creation NAE event. This allows for guest control over the AP register
> state rather than trusting the hypervisor with the SEV-ES Jump Table
> address.
> 
> During native_smp_prepare_cpus(), invoke an SEV-SNP function that, if
> SEV-SNP is active, will set or override apic->wakeup_secondary_cpu. This
> will allow the SEV-SNP AP Creation NAE event method to be used to boot
> the APs.
> 
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> ---
>  arch/x86/include/asm/sev-common.h |   1 +
>  arch/x86/include/asm/sev.h        |  13 ++
>  arch/x86/include/uapi/asm/svm.h   |   5 +
>  arch/x86/kernel/sev-shared.c      |   5 +
>  arch/x86/kernel/sev.c             | 206 ++++++++++++++++++++++++++++++
>  arch/x86/kernel/smpboot.c         |   3 +
>  6 files changed, 233 insertions(+)
> 
> diff --git a/arch/x86/include/asm/sev-common.h b/arch/x86/include/asm/sev-common.h
> index 86bb185b5ec1..47aa57bf654a 100644
> --- a/arch/x86/include/asm/sev-common.h
> +++ b/arch/x86/include/asm/sev-common.h
> @@ -57,6 +57,7 @@
>  	(((unsigned long)((v) & GHCB_MSR_HV_FT_MASK) >> GHCB_MSR_HV_FT_POS))
>  
>  #define GHCB_HV_FT_SNP			BIT_ULL(0)
> +#define GHCB_HV_FT_SNP_AP_CREATION	(BIT_ULL(1) | GHCB_HV_FT_SNP)
>  
>  /* SNP Page State Change */
>  #define GHCB_MSR_PSC_REQ		0x014
> diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
> index e2141fc28058..640108402ae9 100644
> --- a/arch/x86/include/asm/sev.h
> +++ b/arch/x86/include/asm/sev.h
> @@ -71,6 +71,13 @@ enum snp_mem_op {
>  	MEMORY_SHARED
>  };
>  
> +#define RMPADJUST_VMPL_MAX		3
> +#define RMPADJUST_VMPL_MASK		GENMASK(7, 0)
> +#define RMPADJUST_VMPL_SHIFT		0
> +#define RMPADJUST_PERM_MASK_MASK	GENMASK(7, 0)

mask mask huh?

How about "perm mask" and "perm shift" ?

> +#define RMPADJUST_PERM_MASK_SHIFT	8
> +#define RMPADJUST_VMSA_PAGE_BIT		BIT(16)
> +
>  #ifdef CONFIG_AMD_MEM_ENCRYPT
>  extern struct static_key_false sev_es_enable_key;
>  extern void __sev_es_ist_enter(struct pt_regs *regs);
> @@ -116,6 +123,9 @@ void __init early_snp_set_memory_shared(unsigned long vaddr, unsigned long paddr
>  void __init snp_prep_memory(unsigned long paddr, unsigned int sz, int op);
>  void snp_set_memory_shared(unsigned long vaddr, unsigned int npages);
>  void snp_set_memory_private(unsigned long vaddr, unsigned int npages);
> +

No need for the newlines here - it is all function prototypes lumped
together - the only one who reads them is the compiler.

> +void snp_setup_wakeup_secondary_cpu(void);

"setup" "wakeup" huh?

snp_set_wakeup_secondary_cpu() looks just fine to me. :)

> diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
> index b62226bf51b9..7139c9ba59b2 100644
> --- a/arch/x86/kernel/sev-shared.c
> +++ b/arch/x86/kernel/sev-shared.c
> @@ -32,6 +32,11 @@ static bool __init sev_es_check_cpu_features(void)
>  	return true;
>  }
>  
> +static bool snp_ap_creation_supported(void)
> +{
> +	return (hv_features & GHCB_HV_FT_SNP_AP_CREATION) == GHCB_HV_FT_SNP_AP_CREATION;
> +}

Can we get rid of those silly accessors pls?

We established earlier that hv_features is going to be __ro_after_init
so we might just as well export it to sev.c for direct querying -
there's no worry that something'll change it during runtime.

>  static bool __init sev_snp_check_hypervisor_features(void)
>  {
>  	if (ghcb_version < 2)
> diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
> index 4847ac81cca3..8f7ef35a25ef 100644
> --- a/arch/x86/kernel/sev.c
> +++ b/arch/x86/kernel/sev.c
> @@ -19,6 +19,7 @@
>  #include <linux/memblock.h>
>  #include <linux/kernel.h>
>  #include <linux/mm.h>
> +#include <linux/cpumask.h>
>  
>  #include <asm/cpu_entry_area.h>
>  #include <asm/stacktrace.h>
> @@ -31,6 +32,7 @@
>  #include <asm/svm.h>
>  #include <asm/smp.h>
>  #include <asm/cpu.h>
> +#include <asm/apic.h>
>  
>  #include "sev-internal.h"
>  
> @@ -106,6 +108,8 @@ struct ghcb_state {
>  static DEFINE_PER_CPU(struct sev_es_runtime_data*, runtime_data);
>  DEFINE_STATIC_KEY_FALSE(sev_es_enable_key);
>  
> +static DEFINE_PER_CPU(struct sev_es_save_area *, snp_vmsa);
> +
>  /* Needed in vc_early_forward_exception */
>  void do_early_exception(struct pt_regs *regs, int trapnr);
>  
> @@ -744,6 +748,208 @@ void snp_set_memory_private(unsigned long vaddr, unsigned int npages)
>  	pvalidate_pages(vaddr, npages, 1);
>  }
>  
> +static int snp_rmpadjust(void *va, unsigned int vmpl, unsigned int perm_mask, bool vmsa)

No need for the "snp_" prefix. Drop it for all static functions here too
pls.

@vmpl can be a u8 so that you don't need to mask it off. The same for
@perm_mask. And then you can drop the mask defines too.

> +{
> +	unsigned int attrs;
> +	int err;
> +
> +	attrs = (vmpl & RMPADJUST_VMPL_MASK) << RMPADJUST_VMPL_SHIFT;

Shift by 0 huh? Can we drop this silliness pls?

	/* Make sure Reserved[63:17] is 0 */
	attrs = 0;

	attrs |= vmpl;

Plain and simple.

> +	attrs |= (perm_mask & RMPADJUST_PERM_MASK_MASK) << RMPADJUST_PERM_MASK_SHIFT;

perm_mask is always 0 - you don't even have to pass it in as a function
argument.

> +	if (vmsa)
> +		attrs |= RMPADJUST_VMSA_PAGE_BIT;
> +
> +	/* Perform RMPADJUST */

Add:

	/* Instruction mnemonic supported in binutils versions v2.36 and later */

> +	asm volatile (".byte 0xf3,0x0f,0x01,0xfe\n\t"
> +		      : "=a" (err)

here you should do:

			: ... "c" (RMP_PG_SIZE_4K), ...

so that it is clear what goes into %rcx.

> +		      : "a" (va), "c" (0), "d" (attrs)
> +		      : "memory", "cc");
> +
> +	return err;
> +}
> +
> +static int snp_clear_vmsa(void *vmsa)
> +{
> +	/*
> +	 * Clear the VMSA attribute for the page:
> +	 *   RDX[7:0]  = 1, Target VMPL level, must be numerically
> +	 *		    higher than current level (VMPL0)

But RMPADJUST_VMPL_MAX is 3?!

> +	 *   RDX[15:8] = 0, Target permission mask (not used)
> +	 *   RDX[16]   = 0, Not a VMSA page
> +	 */
> +	return snp_rmpadjust(vmsa, RMPADJUST_VMPL_MAX, 0, false);
> +}
> +
> +static int snp_set_vmsa(void *vmsa)
> +{
> +	/*
> +	 * To set the VMSA attribute for the page:
> +	 *   RDX[7:0]  = 1, Target VMPL level, must be numerically
> +	 *		    higher than current level (VMPL0)
> +	 *   RDX[15:8] = 0, Target permission mask (not used)
> +	 *   RDX[16]   = 1, VMSA page
> +	 */
> +	return snp_rmpadjust(vmsa, RMPADJUST_VMPL_MAX, 0, true);
> +}
> +
> +#define INIT_CS_ATTRIBS		(SVM_SELECTOR_P_MASK | SVM_SELECTOR_S_MASK | SVM_SELECTOR_READ_MASK | SVM_SELECTOR_CODE_MASK)
> +#define INIT_DS_ATTRIBS		(SVM_SELECTOR_P_MASK | SVM_SELECTOR_S_MASK | SVM_SELECTOR_WRITE_MASK)
> +

Put SVM_SELECTOR_P_MASK | SVM_SELECTOR_S_MASK in a helper define and share it in the two
definitions above pls.

> +#define INIT_LDTR_ATTRIBS	(SVM_SELECTOR_P_MASK | 2)
> +#define INIT_TR_ATTRIBS		(SVM_SELECTOR_P_MASK | 3)
> +
> +static int snp_wakeup_cpu_via_vmgexit(int apic_id, unsigned long start_ip)
> +{
> +	struct sev_es_save_area *cur_vmsa;
> +	struct sev_es_save_area *vmsa;
> +	struct ghcb_state state;
> +	struct ghcb *ghcb;
> +	unsigned long flags;
> +	u8 sipi_vector;
> +	u64 cr4;
> +	int cpu;
> +	int ret;

Remember the reversed xmas tree. And you can combine the variables of
the same type into a single line.

> +
> +	if (!snp_ap_creation_supported())
> +		return -ENOTSUPP;

WARNING: ENOTSUPP is not a SUSV4 error code, prefer EOPNOTSUPP
#320: FILE: arch/x86/kernel/sev.c:813:
+               return -ENOTSUPP;

> +	/* Override start_ip with known SEV-ES/SEV-SNP starting RIP */
> +	if (start_ip == real_mode_header->trampoline_start) {
> +		start_ip = real_mode_header->sev_es_trampoline_start;
> +	} else {
> +		WARN_ONCE(1, "unsupported SEV-SNP start_ip: %lx\n", start_ip);
> +		return -EINVAL;
> +	}

What's all that checking for? Why not simply and unconditionally doing:

	start_ip = real_mode_header->sev_es_trampoline_start;

?

We are waking up an SNP guest so who cares what the previous start_ip
value was?

> +	/* Find the logical CPU for the APIC ID */
> +	for_each_present_cpu(cpu) {
> +		if (arch_match_cpu_phys_id(cpu, apic_id))
> +			break;
> +	}
> +	if (cpu >= nr_cpu_ids)
> +		return -EINVAL;
> +
> +	cur_vmsa = per_cpu(snp_vmsa, cpu);

Where is that snp_vmsa thing used? I don't see it anywhere in the whole
patchset.

> +	vmsa = (struct sev_es_save_area *)get_zeroed_page(GFP_KERNEL);
> +	if (!vmsa)
> +		return -ENOMEM;
> +
> +	/* CR4 should maintain the MCE value */
> +	cr4 = native_read_cr4() & ~X86_CR4_MCE;
> +
> +	/* Set the CS value based on the start_ip converted to a SIPI vector */
> +	sipi_vector = (start_ip >> 12);
> +	vmsa->cs.base     = sipi_vector << 12;
> +	vmsa->cs.limit    = 0xffff;
> +	vmsa->cs.attrib   = INIT_CS_ATTRIBS;
> +	vmsa->cs.selector = sipi_vector << 8;
> +
> +	/* Set the RIP value based on start_ip */
> +	vmsa->rip = start_ip & 0xfff;
> +
> +	/* Set VMSA entries to the INIT values as documented in the APM */
> +	vmsa->ds.limit    = 0xffff;
> +	vmsa->ds.attrib   = INIT_DS_ATTRIBS;
> +	vmsa->es = vmsa->ds;
> +	vmsa->fs = vmsa->ds;
> +	vmsa->gs = vmsa->ds;
> +	vmsa->ss = vmsa->ds;
> +
> +	vmsa->gdtr.limit    = 0xffff;
> +	vmsa->ldtr.limit    = 0xffff;
> +	vmsa->ldtr.attrib   = INIT_LDTR_ATTRIBS;
> +	vmsa->idtr.limit    = 0xffff;
> +	vmsa->tr.limit      = 0xffff;
> +	vmsa->tr.attrib     = INIT_TR_ATTRIBS;
> +
> +	vmsa->efer    = 0x1000;			/* Must set SVME bit */
> +	vmsa->cr4     = cr4;
> +	vmsa->cr0     = 0x60000010;
> +	vmsa->dr7     = 0x400;
> +	vmsa->dr6     = 0xffff0ff0;
> +	vmsa->rflags  = 0x2;
> +	vmsa->g_pat   = 0x0007040600070406ULL;
> +	vmsa->xcr0    = 0x1;
> +	vmsa->mxcsr   = 0x1f80;
> +	vmsa->x87_ftw = 0x5555;
> +	vmsa->x87_fcw = 0x0040;

Align them all on a single vertical line pls.

> +	/*
> +	 * Set the SNP-specific fields for this VMSA:
> +	 *   VMPL level
> +	 *   SEV_FEATURES (matches the SEV STATUS MSR right shifted 2 bits)
> +	 */
> +	vmsa->vmpl = 0;
> +	vmsa->sev_features = sev_status >> 2;
> +
> +	/* Switch the page over to a VMSA page now that it is initialized */
> +	ret = snp_set_vmsa(vmsa);
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
> +	ghcb = sev_es_get_ghcb(&state);
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
> +		ret = -EINVAL;
> +	}
> +
> +	sev_es_put_ghcb(&state);
> +
> +	local_irq_restore(flags);
> +
> +	/* Perform cleanup if there was an error */
> +	if (ret) {
> +		int err = snp_clear_vmsa(vmsa);
> +


^ Superfluous newline.

> +		if (err)
> +			pr_err("clear VMSA page failed (%u), leaking page\n", err);
> +		else
> +			free_page((unsigned long)vmsa);
> +
> +		vmsa = NULL;
> +	}
> +
> +	/* Free up any previous VMSA page */
> +	if (cur_vmsa) {
> +		int err = snp_clear_vmsa(cur_vmsa);
> +


^ Superfluous newline.

> +		if (err)
> +			pr_err("clear VMSA page failed (%u), leaking page\n", err);
> +		else
> +			free_page((unsigned long)cur_vmsa);
> +	}
> +
> +	/* Record the current VMSA page */
> +	cur_vmsa = vmsa;
> +
> +	return ret;
> +}

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
