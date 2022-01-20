Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB95D494DC6
	for <lists+linux-efi@lfdr.de>; Thu, 20 Jan 2022 13:18:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240235AbiATMSg (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 20 Jan 2022 07:18:36 -0500
Received: from mail.skyhub.de ([5.9.137.197]:44738 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237697AbiATMSe (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 20 Jan 2022 07:18:34 -0500
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A0B6F1EC01B5;
        Thu, 20 Jan 2022 13:18:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1642681108;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=XO6AT+gIfZtH9EDaR1V0c6Fkovljr0vEcHMLtYZNXi0=;
        b=ZvS9JkdJCYllJDFBD0tsEGn3u9iKtDu9RRyiFn28RlB9ttb3/cSuVBse0GV9xDiAmJXru1
        G7WhLPYYU8EKqnivp/dBPCdF6YYQ7q3y6G8vJIsVo2jZaCOyhOigOuYlQCmxRcEn/trNns
        hHEBxqnny4SO9CJxR0abXyH3IFJubqs=
Date:   Thu, 20 Jan 2022 13:18:22 +0100
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
Subject: Re: [PATCH v8 32/40] x86/compressed: use firmware-validated CPUID
 for SEV-SNP guests
Message-ID: <YelTDp4gsEyscWTI@zn.tnic>
References: <20211210154332.11526-1-brijesh.singh@amd.com>
 <20211210154332.11526-33-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211210154332.11526-33-brijesh.singh@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Dec 10, 2021 at 09:43:24AM -0600, Brijesh Singh wrote:
> Subject: Re: [PATCH v8 32/40] x86/compressed: use firmware-validated CPUID for SEV-SNP guests
									    ^
									    leafs

or so.

> From: Michael Roth <michael.roth@amd.com>
> 
> SEV-SNP guests will be provided the location of special 'secrets'
> 'CPUID' pages via the Confidential Computing blob. This blob is
> provided to the boot kernel either through an EFI config table entry,
> or via a setup_data structure as defined by the Linux Boot Protocol.
> 
> Locate the Confidential Computing from these sources and, if found,
> use the provided CPUID page/table address to create a copy that the
> boot kernel will use when servicing cpuid instructions via a #VC

CPUID

> handler.
> 
> Signed-off-by: Michael Roth <michael.roth@amd.com>
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> ---
>  arch/x86/boot/compressed/sev.c | 13 ++++++++++
>  arch/x86/include/asm/sev.h     |  1 +
>  arch/x86/kernel/sev-shared.c   | 43 ++++++++++++++++++++++++++++++++++
>  3 files changed, 57 insertions(+)
> 
> diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
> index 93e125da12cf..29dfb34b5907 100644
> --- a/arch/x86/boot/compressed/sev.c
> +++ b/arch/x86/boot/compressed/sev.c
> @@ -415,6 +415,19 @@ bool snp_init(struct boot_params *bp)
>  	if (!cc_info)
>  		return false;
>  
> +	/*
> +	 * If SEV-SNP-specific Confidential Computing blob is present, then
	     ^
	     a


> +	 * firmware/bootloader have indicated SEV-SNP support. Verifying this
> +	 * involves CPUID checks which will be more reliable if the SEV-SNP
> +	 * CPUID table is used. See comments for snp_cpuid_info_create() for

s/for/over/ ?

> +	 * more details.
> +	 */
> +	snp_cpuid_info_create(cc_info);
> +
> +	/* SEV-SNP CPUID table should be set up now. */
> +	if (!snp_cpuid_active())
> +		sev_es_terminate(1, GHCB_TERM_CPUID);

Right, that is not needed now.

>  	 * Pass run-time kernel a pointer to CC info via boot_params so EFI
>  	 * config table doesn't need to be searched again during early startup
> diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
> index cd189c20bcc4..4fa7ca20d7c9 100644
> --- a/arch/x86/include/asm/sev.h
> +++ b/arch/x86/include/asm/sev.h
> @@ -157,6 +157,7 @@ bool snp_init(struct boot_params *bp);
>   * sev-shared.c via #include and these declarations can be dropped.
>   */
>  struct cc_blob_sev_info *snp_find_cc_blob_setup_data(struct boot_params *bp);
> +void snp_cpuid_info_create(const struct cc_blob_sev_info *cc_info);
>  #else
>  static inline void sev_es_ist_enter(struct pt_regs *regs) { }
>  static inline void sev_es_ist_exit(void) { }
> diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
> index bd58a4ce29c8..5cb8f87df4b3 100644
> --- a/arch/x86/kernel/sev-shared.c
> +++ b/arch/x86/kernel/sev-shared.c
> @@ -403,6 +403,23 @@ snp_cpuid_find_validated_func(u32 func, u32 subfunc, u32 *eax, u32 *ebx,
>  	return false;
>  }
>  
> +static void __init snp_cpuid_set_ranges(void)
> +{
> +	const struct snp_cpuid_info *cpuid_info = snp_cpuid_info_get_ptr();
> +	int i;
> +
> +	for (i = 0; i < cpuid_info->count; i++) {
> +		const struct snp_cpuid_fn *fn = &cpuid_info->fn[i];
> +
> +		if (fn->eax_in == 0x0)
> +			cpuid_std_range_max = fn->eax;
> +		else if (fn->eax_in == 0x40000000)
> +			cpuid_hyp_range_max = fn->eax;
> +		else if (fn->eax_in == 0x80000000)
> +			cpuid_ext_range_max = fn->eax;
> +	}
> +}

Kinda arbitrary to have a separate function which has a single caller.
You can just as well move the loop into snp_cpuid_info_create() and put
a comment above it:

	/* Set CPUID ranges. */
	for (i = 0; i < cpuid_info->count; i++) {
		...

Also, snp_cpuid_info_create() should be called snp_setup_cpuid_table()
which is what this thing does.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
