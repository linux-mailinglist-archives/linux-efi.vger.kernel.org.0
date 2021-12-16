Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5913847764A
	for <lists+linux-efi@lfdr.de>; Thu, 16 Dec 2021 16:47:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238665AbhLPPrw (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 16 Dec 2021 10:47:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232741AbhLPPrw (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 16 Dec 2021 10:47:52 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9299C061574;
        Thu, 16 Dec 2021 07:47:51 -0800 (PST)
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0A6E51EC01A2;
        Thu, 16 Dec 2021 16:47:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1639669666;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=w2zw5w9zdbclGVjd2mcfzFrzgn7sBAWZNCdTsQYykhk=;
        b=HOSNWrPkxPtVrP+QzbncJoQNAqagO6/nOkVG3sXbVKWfE/24GyfWge5/8230enJQIghU91
        CeCqrdvkWGJYi0yOX1vOhtgg49xfGrdlGoiWDGDG64jPbOh+vwbdb5cViWyGbFySlIelWH
        iebgN19BrUYcG6qBiaDh42Sp3lSWbhI=
Date:   Thu, 16 Dec 2021 16:47:46 +0100
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
Subject: Re: [PATCH v8 06/40] x86/sev: Check SEV-SNP features support
Message-ID: <Ybtfon70/+lG63BP@zn.tnic>
References: <20211210154332.11526-1-brijesh.singh@amd.com>
 <20211210154332.11526-7-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211210154332.11526-7-brijesh.singh@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Dec 10, 2021 at 09:42:58AM -0600, Brijesh Singh wrote:
> Version 2 of the GHCB specification added the advertisement of features
> that are supported by the hypervisor. If hypervisor supports the SEV-SNP
> then it must set the SEV-SNP features bit to indicate that the base
> SEV-SNP is supported.
> 
> Check the SEV-SNP feature while establishing the GHCB, if failed,
> terminate the guest.
> 
> Version 2 of GHCB specification adds several new NAEs, most of them are
> optional except the hypervisor feature. Now that hypervisor feature NAE
> is implemented, so bump the GHCB maximum support protocol version.
> 
> While at it, move the GHCB protocol negotitation check from VC exception

Unknown word [negotitation] in commit message, suggestions:
        ['negotiation', 'negotiator', 'negotiate', 'abnegation', 'vegetation']

> handler to sev_enable() so that all feature detection happens before
> the first VC exception.
> 
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> ---
>  arch/x86/boot/compressed/sev.c    | 21 ++++++++++++++++-----
>  arch/x86/include/asm/sev-common.h |  6 ++++++
>  arch/x86/include/asm/sev.h        |  2 +-
>  arch/x86/include/uapi/asm/svm.h   |  2 ++
>  arch/x86/kernel/sev-shared.c      | 20 ++++++++++++++++++++
>  arch/x86/kernel/sev.c             | 16 ++++++++++++++++
>  6 files changed, 61 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
> index 0b6cc6402ac1..a0708f359a46 100644
> --- a/arch/x86/boot/compressed/sev.c
> +++ b/arch/x86/boot/compressed/sev.c
> @@ -119,11 +119,8 @@ static enum es_result vc_read_mem(struct es_em_ctxt *ctxt,
>  /* Include code for early handlers */
>  #include "../../kernel/sev-shared.c"
>  
> -static bool early_setup_sev_es(void)
> +static bool early_setup_ghcb(void)
>  {
> -	if (!sev_es_negotiate_protocol())
> -		sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SEV_ES_PROT_UNSUPPORTED);
> -
>  	if (set_page_decrypted((unsigned long)&boot_ghcb_page))
>  		return false;
>  
> @@ -174,7 +171,7 @@ void do_boot_stage2_vc(struct pt_regs *regs, unsigned long exit_code)
>  	struct es_em_ctxt ctxt;
>  	enum es_result result;
>  
> -	if (!boot_ghcb && !early_setup_sev_es())
> +	if (!boot_ghcb && !early_setup_ghcb())
>  		sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SEV_ES_GEN_REQ);

Can you setup the GHCB in sev_enable() too, after the protocol version
negotiation succeeds?

>  	vc_ghcb_invalidate(boot_ghcb);
> @@ -247,5 +244,19 @@ void sev_enable(struct boot_params *bp)
>  	if (!(sev_status & MSR_AMD64_SEV_ENABLED))
>  		return;
>  
> +	/* Negotiate the GHCB protocol version */
> +	if (sev_status & MSR_AMD64_SEV_ES_ENABLED)
> +		if (!sev_es_negotiate_protocol())
> +			sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SEV_ES_PROT_UNSUPPORTED);
> +
> +	/*
> +	 * SNP is supported in v2 of the GHCB spec which mandates support for HV
> +	 * features. If SEV-SNP is enabled, then check if the hypervisor supports
> +	 * the SEV-SNP features.
> +	 */
> +	if (sev_status & MSR_AMD64_SEV_SNP_ENABLED && !(get_hv_features() & GHCB_HV_FT_SNP))
> +		sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SNP_UNSUPPORTED);
> +
> +
^ Superfluous newline.

>  	sme_me_mask = BIT_ULL(ebx & 0x3f);

...

> diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
> index 19ad09712902..a0cada8398a4 100644
> --- a/arch/x86/kernel/sev.c
> +++ b/arch/x86/kernel/sev.c
> @@ -43,6 +43,10 @@ static struct ghcb boot_ghcb_page __bss_decrypted __aligned(PAGE_SIZE);
>   */
>  static struct ghcb __initdata *boot_ghcb;
>  
> +/* Bitmap of SEV features supported by the hypervisor */
> +static u64 sev_hv_features;

__ro_after_init

> +
> +
>  /* #VC handler runtime per-CPU data */
>  struct sev_es_runtime_data {
>  	struct ghcb ghcb_page;
> @@ -766,6 +770,18 @@ void __init sev_es_init_vc_handling(void)
>  	if (!sev_es_check_cpu_features())
>  		panic("SEV-ES CPU Features missing");
>  
> +	/*
> +	 * SNP is supported in v2 of the GHCB spec which mandates support for HV
> +	 * features. If SEV-SNP is enabled, then check if the hypervisor supports

s/SEV-SNP/SNP/g

And please do that everywhere in sev-specific files.

This file is called sev.c and there's way too many acronyms flying
around so the simpler the better.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
