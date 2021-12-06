Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E9B546A3FB
	for <lists+linux-efi@lfdr.de>; Mon,  6 Dec 2021 19:26:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346903AbhLFS31 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 6 Dec 2021 13:29:27 -0500
Received: from mail.skyhub.de ([5.9.137.197]:57400 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346873AbhLFS31 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 6 Dec 2021 13:29:27 -0500
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 93E411EC04EC;
        Mon,  6 Dec 2021 19:25:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1638815152;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=IQf1Aykvr0b9qh7v/aw8uwWh6TGGRbXZxaugyfZJEIU=;
        b=jQJDfprBX9STJpmWLtePKc1tSSDwspxyBah1ghZ3nAe8tJ5k0wXElkUD+W6a30r7AWnl27
        FGffroW/b0INl0Z1xMkePlp5g2X1IjvYEFFUVDpjwqiR8fVJZVyky8QAhUNlgw8/ddhPU2
        6ByUvko7IcMgRj9+XIxxvhr6IaIm47k=
Date:   Mon, 6 Dec 2021 19:25:54 +0100
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
Subject: Re: [PATCH v7 13/45] x86/sev: Check the vmpl level
Message-ID: <Ya5VsraetesqEkRi@zn.tnic>
References: <20211110220731.2396491-1-brijesh.singh@amd.com>
 <20211110220731.2396491-14-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211110220731.2396491-14-brijesh.singh@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Nov 10, 2021 at 04:06:59PM -0600, Brijesh Singh wrote:
> Virtual Machine Privilege Level (VMPL) is an optional feature in the
> SEV-SNP architecture, which allows a guest VM to divide its address space
> into four levels. The level can be used to provide the hardware isolated
> abstraction layers with a VM.

That sentence needs improving.

> The VMPL0 is the highest privilege, and
> VMPL3 is the least privilege. Certain operations must be done by the VMPL0
> software, such as:
> 
> * Validate or invalidate memory range (PVALIDATE instruction)
> * Allocate VMSA page (RMPADJUST instruction when VMSA=1)
> 
> The initial SEV-SNP support assumes that the guest kernel is running on

assumes? I think it is "requires".

> VMPL0. Let's add a check to make sure that kernel is running at VMPL0

s/Let's //

> before continuing the boot. There is no easy method to query the current
> VMPL level, so use the RMPADJUST instruction to determine whether its

"... whether the guest is running at VMPL0."

> booted at the VMPL0.
> 
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> ---
>  arch/x86/boot/compressed/sev.c    | 34 ++++++++++++++++++++++++++++---
>  arch/x86/include/asm/sev-common.h |  1 +
>  arch/x86/include/asm/sev.h        | 16 +++++++++++++++
>  3 files changed, 48 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
> index e525fa74a551..21feb7f4f76f 100644
> --- a/arch/x86/boot/compressed/sev.c
> +++ b/arch/x86/boot/compressed/sev.c
> @@ -124,6 +124,29 @@ static inline bool sev_snp_enabled(void)
>  	return sev_status & MSR_AMD64_SEV_SNP_ENABLED;
>  }
>  
> +static bool is_vmpl0(void)
> +{
> +	u64 attrs;
> +	int err;
> +
> +	/*
> +	 * There is no straightforward way to query the current VMPL level. The
> +	 * simplest method is to use the RMPADJUST instruction to change a page
> +	 * permission to a VMPL level-1, and if the guest kernel is launched at
> +	 * a level <= 1, then RMPADJUST instruction will return an error.
> +	 */

So I was wondering what this is changing because if the change you do is
relevant, you'd have to undo it.

But looking at RMPADJUST, TARGET_PERM_MASK is 0 for target VMPL1 so
you're basically clearing all permissions for boot_ghcb_page on VMPL1.
Which is fine currently as we do only VMPL0 but pls write that out
explicitly what you're doing here and why it is ok to use RMPADJUST
without having to restore any changes it has done to the RMP table.

> +	attrs = 1;
> +
> +	/*
> +	 * Any page-aligned virtual address is sufficient to test the VMPL level.
> +	 * The boot_ghcb_page is page aligned memory, so lets use for the test.
> +	 */
> +	if (rmpadjust((unsigned long)&boot_ghcb_page, RMP_PG_SIZE_4K, attrs))
> +		return false;
> +
> +	return true;
> +}
> +
>  static bool do_early_sev_setup(void)
>  {
>  	if (!sev_es_negotiate_protocol())
> @@ -132,10 +155,15 @@ static bool do_early_sev_setup(void)
>  	/*
>  	 * SNP is supported in v2 of the GHCB spec which mandates support for HV
>  	 * features. If SEV-SNP is enabled, then check if the hypervisor supports
> -	 * the SEV-SNP features.
> +	 * the SEV-SNP features and is launched at VMPL-0 level.

"VMPL0" - no hyphen - like in the APM. Below too.

>  	 */
> -	if (sev_snp_enabled() && !(sev_hv_features & GHCB_HV_FT_SNP))
> -		sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SNP_UNSUPPORTED);
> +	if (sev_snp_enabled()) {
> +		if (!(sev_hv_features & GHCB_HV_FT_SNP))
> +			sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SNP_UNSUPPORTED);
> +
> +		if (!is_vmpl0())
> +			sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_NOT_VMPL0);
> +	}
>  
>  	if (set_page_decrypted((unsigned long)&boot_ghcb_page))
>  		return false;

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
