Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3E663C92C7
	for <lists+linux-efi@lfdr.de>; Wed, 14 Jul 2021 23:07:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235097AbhGNVKf (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 14 Jul 2021 17:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234978AbhGNVKe (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 14 Jul 2021 17:10:34 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03E37C061762
        for <linux-efi@vger.kernel.org>; Wed, 14 Jul 2021 14:07:42 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id n10so2100205plk.1
        for <linux-efi@vger.kernel.org>; Wed, 14 Jul 2021 14:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=OrJjmDihky9L5lychbpTBZwL1+xpeDWHYbd6hVXreJM=;
        b=tlz5bGQLSoLrdG3yHlzIPTA4kenOD+40ek2Xmm5ZcZAuRAmgi1szyK30dlHoMqPjr1
         HC6+ZapUN1ng1N8iPi3Xx+1Wk6Bzzl+zci2pX/dkzPsyvzPtUD5PHfZ6PZiaVwQ660uR
         uXhtnHkr98V4781RINe/3kERQ//Xiv4ZIKUkPHx8R00NMWzEOkyqBnPzIPRQIrmjR2JR
         AW0GQ2ltDtzB/uumhtBlcS22Ycv15zYhmDnK2LyN0oSlspTzcLWNdE2QdVVAmrvCsv7s
         pCi4Qnr/JcI9IbckJWsASScJV6y7KBIAdxBYawEZyIeQg1TB8oc5D6AWSh5Kkcq749bg
         HXbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=OrJjmDihky9L5lychbpTBZwL1+xpeDWHYbd6hVXreJM=;
        b=IciTOO4OkPFzVVgnPZokdLgS/k3Adqj9AkNufTM9wqcQoL2Jo6xNznEMz+ZEB+p1FD
         R7d39pV9uKz/kewF1f4dGSrnde+0CpuiPB8QMWmbdxSEnmbizu3KnmY7cuC6JtCv25oG
         TWuy/BD2S3DwQZYo+JhydCu30M0ZRJn4739IRQ+NL3OMn4wQ59v4Bkx9MwXXHr/MSSdE
         DOTeJgGkDW9d6WqNi+iPIwQg0xka5/J0XbuuMB8Zs1Xib5U336BmRew8nu79+RF7ccu6
         HDlgojHaVyOV9XrLArg/mTtcdtkDvcK2BK7gNUhCMg2c6RoBqyGynG3EG3XcLCm1rlTm
         IpYA==
X-Gm-Message-State: AOAM531r+tu7jcFSHo6XoDgJ+qI93XD9SwnR6us3GxFDapqe4ZQcpUOd
        Qw8Jql0Cgu+Xoaaxu6KmySIhjw==
X-Google-Smtp-Source: ABdhPJy6ZvJ7eEKoQQlA+dc27/Ymn/phT2UWrJkO7pxjQvI0kRR62Q2ZaSp9qAhwtDJisSV5ZIWr7g==
X-Received: by 2002:a17:90a:c092:: with SMTP id o18mr5529982pjs.3.1626296861177;
        Wed, 14 Jul 2021 14:07:41 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id m21sm3758645pfo.159.2021.07.14.14.07.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 14:07:40 -0700 (PDT)
Date:   Wed, 14 Jul 2021 21:07:37 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Brijesh Singh <brijesh.singh@amd.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        linux-crypto@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
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
        Borislav Petkov <bp@alien8.de>,
        Michael Roth <michael.roth@amd.com>,
        Vlastimil Babka <vbabka@suse.cz>, tony.luck@intel.com,
        npmccallum@redhat.com, brijesh.ksingh@gmail.com
Subject: Re: [PATCH Part2 RFC v4 04/40] x86/sev: Add the host SEV-SNP
 initialization support
Message-ID: <YO9SGT6byW8w37oO@google.com>
References: <20210707183616.5620-1-brijesh.singh@amd.com>
 <20210707183616.5620-5-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210707183616.5620-5-brijesh.singh@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Jul 07, 2021, Brijesh Singh wrote:
> diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
> index aa7e37631447..f9d813d498fa 100644
> --- a/arch/x86/kernel/sev.c
> +++ b/arch/x86/kernel/sev.c
> @@ -24,6 +24,8 @@
>  #include <linux/sev-guest.h>
>  #include <linux/platform_device.h>
>  #include <linux/io.h>
> +#include <linux/io.h>
> +#include <linux/iommu.h>
>  
>  #include <asm/cpu_entry_area.h>
>  #include <asm/stacktrace.h>
> @@ -40,11 +42,14 @@
>  #include <asm/efi.h>
>  #include <asm/cpuid-indexed.h>
>  #include <asm/setup.h>
> +#include <asm/iommu.h>
>  
>  #include "sev-internal.h"
>  
>  #define DR7_RESET_VALUE        0x400
>  
> +#define RMPTABLE_ENTRIES_OFFSET        0x4000

A comment and/or blurb in the changelog describing this magic number would be
quite helpful.  And maybe call out that this is for the bookkeeping, e.g.

  #define RMPTABLE_CPU_BOOKKEEPING_SIZE	0x4000

Also, the APM doesn't actually state the exact location of the bookkeeping
region, it only states that it's somewhere between RMP_BASE and RMP_END.  This
seems to imply that the bookkeeping region is always at RMP_BASE?

  The region of memory between RMP_BASE and RMP_END contains a 16KB region used
  for processor bookkeeping followed by the RMP entries, which are each 16B in
  size. The size of the RMP determines the range of physical memory that the
  hypervisor can assign to SNP-active virtual machines at runtime. The RMP covers
  the system physical address space from address 0h to the address calculated by:

  ((RMP_END + 1 – RMP_BASE – 16KB) / 16B) x 4KB

>  /* For early boot hypervisor communication in SEV-ES enabled guests */
>  static struct ghcb boot_ghcb_page __bss_decrypted __aligned(PAGE_SIZE);
>  
> @@ -56,6 +61,9 @@ static struct ghcb __initdata *boot_ghcb;
>  
>  static u64 snp_secrets_phys;
>  
> +static unsigned long rmptable_start __ro_after_init;
> +static unsigned long rmptable_end __ro_after_init;
> +
>  /* #VC handler runtime per-CPU data */
>  struct sev_es_runtime_data {
>  	struct ghcb ghcb_page;
> @@ -2176,3 +2184,138 @@ static int __init add_snp_guest_request(void)
>  	return 0;
>  }
>  device_initcall(add_snp_guest_request);
> +
> +#undef pr_fmt
> +#define pr_fmt(fmt)	"SEV-SNP: " fmt
> +
> +static int __snp_enable(unsigned int cpu)
> +{
> +	u64 val;
> +
> +	if (!cpu_feature_enabled(X86_FEATURE_SEV_SNP))
> +		return 0;
> +
> +	rdmsrl(MSR_AMD64_SYSCFG, val);
> +
> +	val |= MSR_AMD64_SYSCFG_SNP_EN;
> +	val |= MSR_AMD64_SYSCFG_SNP_VMPL_EN;

Is VMPL required?  Do we plan on using VMPL out of the gate?

> +
> +	wrmsrl(MSR_AMD64_SYSCFG, val);
> +
> +	return 0;
> +}
> +
> +static __init void snp_enable(void *arg)
> +{
> +	__snp_enable(smp_processor_id());
> +}
> +
> +static bool get_rmptable_info(u64 *start, u64 *len)
> +{
> +	u64 calc_rmp_sz, rmp_sz, rmp_base, rmp_end, nr_pages;
> +
> +	rdmsrl(MSR_AMD64_RMP_BASE, rmp_base);
> +	rdmsrl(MSR_AMD64_RMP_END, rmp_end);
> +
> +	if (!rmp_base || !rmp_end) {

Can BIOS put the RMP at PA=0?

Also, why is it a BIOS decision?  AFAICT, the MSRs aren't locked until SNP_EN
is set in SYSCFG, and that appears to be a kernel decision (ignoring kexec),
i.e. nothing would prevent the kernel from configuring it's own RMP.

> +		pr_info("Memory for the RMP table has not been reserved by BIOS\n");
> +		return false;
> +	}
> +
> +	rmp_sz = rmp_end - rmp_base + 1;
> +
> +	/*
> +	 * Calculate the amount the memory that must be reserved by the BIOS to
> +	 * address the full system RAM. The reserved memory should also cover the
> +	 * RMP table itself.
> +	 *
> +	 * See PPR section 2.1.5.2 for more information on memory requirement.
> +	 */
> +	nr_pages = totalram_pages();
> +	calc_rmp_sz = (((rmp_sz >> PAGE_SHIFT) + nr_pages) << 4) + RMPTABLE_ENTRIES_OFFSET;
> +
> +	if (calc_rmp_sz > rmp_sz) {
> +		pr_info("Memory reserved for the RMP table does not cover the full system "
> +			"RAM (expected 0x%llx got 0x%llx)\n", calc_rmp_sz, rmp_sz);

Is BIOS expected to provide exact coverage, e.g. should this be s/expected/need?

Should the kernel also sanity check other requirements, e.g. the 8kb alignment,
or does the CPU enforce those things at WRMSR?

> +		return false;
> +	}
> +
> +	*start = rmp_base;
> +	*len = rmp_sz;
> +
> +	pr_info("RMP table physical address 0x%016llx - 0x%016llx\n", rmp_base, rmp_end);
> +
> +	return true;
> +}
> +
> +static __init int __snp_rmptable_init(void)
> +{
> +	u64 rmp_base, sz;
> +	void *start;
> +	u64 val;
> +
> +	if (!get_rmptable_info(&rmp_base, &sz))
> +		return 1;
> +
> +	start = memremap(rmp_base, sz, MEMREMAP_WB);
> +	if (!start) {
> +		pr_err("Failed to map RMP table 0x%llx+0x%llx\n", rmp_base, sz);
> +		return 1;
> +	}
> +
> +	/*
> +	 * Check if SEV-SNP is already enabled, this can happen if we are coming from
> +	 * kexec boot.
> +	 */
> +	rdmsrl(MSR_AMD64_SYSCFG, val);
> +	if (val & MSR_AMD64_SYSCFG_SNP_EN)

Hmm, it kinda feels like there should be a sanity check for the case where SNP is
already enabled but get_rmptable_info() fails, e.g. due to insufficient RMP size.

> +		goto skip_enable;
> +
> +	/* Initialize the RMP table to zero */
> +	memset(start, 0, sz);
> +
> +	/* Flush the caches to ensure that data is written before SNP is enabled. */
> +	wbinvd_on_all_cpus();
> +
> +	/* Enable SNP on all CPUs. */
> +	on_each_cpu(snp_enable, NULL, 1);
> +
> +skip_enable:
> +	rmptable_start = (unsigned long)start;

Mostly out of curiosity, why store start/end as unsigned longs?  This is all 64-bit
only so it doesn't actually affect the code generation, but it feels odd to store
things that absolutely have to be 64-bit values as unsigned long.

Similar question for why asm/sev-common.h cases to unsigned long instead of u64.
E.g. the below in particular looks wrong because we're shifting an unsigned long
b y32 bits, i.e. the value _must_ be a 64-bit value, why obfuscate that?

	#define GHCB_CPUID_REQ(fn, reg)		\
		(GHCB_MSR_CPUID_REQ | \
		(((unsigned long)reg & GHCB_MSR_CPUID_REG_MASK) << GHCB_MSR_CPUID_REG_POS) | \
		(((unsigned long)fn) << GHCB_MSR_CPUID_FUNC_POS))

> +	rmptable_end = rmptable_start + sz;
> +
> +	return 0;
> +}
> +
> +static int __init snp_rmptable_init(void)
> +{
> +	if (!boot_cpu_has(X86_FEATURE_SEV_SNP))
> +		return 0;
> +
> +	/*
> +	 * The SEV-SNP support requires that IOMMU must be enabled, and is not
> +	 * configured in the passthrough mode.
> +	 */
> +	if (no_iommu || iommu_default_passthrough()) {

Similar comment regarding the sanity check, kexec'ing into a kernel with SNP
already enabled should probably fail explicitly if the new kernel is booted with
incompatible params.

> +		setup_clear_cpu_cap(X86_FEATURE_SEV_SNP);
> +		pr_err("IOMMU is either disabled or configured in passthrough mode.\n");
> +		return 0;
> +	}
> +
> +	if (__snp_rmptable_init()) {
> +		setup_clear_cpu_cap(X86_FEATURE_SEV_SNP);
> +		return 1;
> +	}
> +
> +	cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "x86/rmptable_init:online", __snp_enable, NULL);
> +
> +	return 0;
> +}
> +
> +/*
> + * This must be called after the PCI subsystem. This is because before enabling
> + * the SNP feature we need to ensure that IOMMU is not configured in the
> + * passthrough mode. The iommu_default_passthrough() is used for checking the
> + * passthough state, and it is available after subsys_initcall().
> + */
> +fs_initcall(snp_rmptable_init);
> -- 
> 2.17.1
> 
