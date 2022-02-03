Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9F124A7F68
	for <lists+linux-efi@lfdr.de>; Thu,  3 Feb 2022 07:50:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344503AbiBCGuq (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 3 Feb 2022 01:50:46 -0500
Received: from mail.skyhub.de ([5.9.137.197]:57642 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231599AbiBCGuq (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 3 Feb 2022 01:50:46 -0500
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 31F5D1EC052A;
        Thu,  3 Feb 2022 07:50:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1643871040;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=NgVVgxFrnWWDzRBeIt1G+nS4mvlLadpwFtGpi1OsBDY=;
        b=W7PkXA4BWOfHL2epgzq64IxceglUapTsm9fVBcMxiZeVngOLhvuPVR+DGq/C1Pu2OClb4D
        mLamS3Mf82FSRYNmXEKHrC7/Lkw3EEJRfL/mxplBkopLWeX0BwQFM6cYmYgg/RlwQWvLDH
        n23VNqfMU2hBhj/hclxRdcF/wWaAdWQ=
Date:   Thu, 3 Feb 2022 07:50:35 +0100
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
Subject: Re: [PATCH v9 20/43] x86/sev: Use SEV-SNP AP creation to start
 secondary CPUs
Message-ID: <Yft7O06d+iNPGCuL@zn.tnic>
References: <20220128171804.569796-1-brijesh.singh@amd.com>
 <20220128171804.569796-21-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220128171804.569796-21-brijesh.singh@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Jan 28, 2022 at 11:17:41AM -0600, Brijesh Singh wrote:
> @@ -822,6 +842,236 @@ void snp_set_memory_private(unsigned long vaddr, unsigned int npages)
>  	pvalidate_pages(vaddr, npages, true);
>  }
>  
> +static int snp_set_vmsa(void *va, bool vmsa)
> +{
> +	u64 attrs;
> +
> +	/*
> +	 * Running at VMPL0 allows the kernel to change the VMSA bit for a page
> +	 * using the RMPADJUST instruction. However, for the instruction to
> +	 * succeed it must target the permissions of a lesser privileged

"lesser privileged/higher number VMPL level"

so that it is perfectly clear what this means.

> +	 * VMPL level, so use VMPL1 (refer to the RMPADJUST instruction in the
> +	 * AMD64 APM Volume 3).
> +	 */
> +	attrs = 1;
> +	if (vmsa)
> +		attrs |= RMPADJUST_VMSA_PAGE_BIT;
> +
> +	return rmpadjust((unsigned long)va, RMP_PG_SIZE_4K, attrs);
> +}

...

> +static int wakeup_cpu_via_vmgexit(int apic_id, unsigned long start_ip)
> +{
> +	struct sev_es_save_area *cur_vmsa, *vmsa;
> +	struct ghcb_state state;
> +	unsigned long flags;
> +	struct ghcb *ghcb;
> +	u8 sipi_vector;
> +	int cpu, ret;
> +	u64 cr4;
> +
> +	/*
> +	 * SNP-SNP AP creation requires that the hypervisor must support SEV-SNP
	   ^^^^^^^

See what I mean? :-)

That marketing has brainwashed y'all.

> +	 * feature. The SEV-SNP feature check is already performed, so just check
> +	 * for the AP_CREATION feature flag.
> +	 */

Let's clean this one:

	/*
	 * The hypervisor SNP feature support check has happened earlier, just check
	 * the AP_CREATION one here.
	 */


> +	if (!(sev_hv_features & GHCB_HV_FT_SNP_AP_CREATION))
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

Yah, I'd like to get rid of that ->sev_es_trampoline_start and use the
normal ->trampoline_start. TDX is introducing a third one even and
they're all mutually-exclusive u32 values.

...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
