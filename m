Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 953BC3F9B0A
	for <lists+linux-efi@lfdr.de>; Fri, 27 Aug 2021 16:43:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232477AbhH0OoI (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 27 Aug 2021 10:44:08 -0400
Received: from mail.skyhub.de ([5.9.137.197]:44492 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231327AbhH0OoI (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 27 Aug 2021 10:44:08 -0400
Received: from zn.tnic (p200300ec2f1117006e0d6268a9fc7b3e.dip0.t-ipconnect.de [IPv6:2003:ec:2f11:1700:6e0d:6268:a9fc:7b3e])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D16451EC0493;
        Fri, 27 Aug 2021 16:43:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1630075393;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=JnpD/7q7WF7NuQTfcoCi3R50uMQ/1+7oFap3seyqFiU=;
        b=e26r5thZw3XobM2ye3EddiEyjsURteB1VBnb9DqalDrz/BfqeAqavI3AfDm3wWbyRpHNYf
        KaaDG9MPIkesEZZlZNR1sFhG8o8pPc4me7+aevWWCAlge78mDHfvYrrKAql2Ceq4wAet5Z
        tCUyonEcyXAV+onAyLO+agfkeabOE2s=
Date:   Fri, 27 Aug 2021 16:43:51 +0200
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
Subject: Re: [PATCH Part1 v5 31/38] x86/compressed/64: add identity mapping
 for Confidential Computing blob
Message-ID: <YSj6J+TFnJzueCAQ@zn.tnic>
References: <20210820151933.22401-1-brijesh.singh@amd.com>
 <20210820151933.22401-32-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210820151933.22401-32-brijesh.singh@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Aug 20, 2021 at 10:19:26AM -0500, Brijesh Singh wrote:
> diff --git a/arch/x86/boot/compressed/ident_map_64.c b/arch/x86/boot/compressed/ident_map_64.c
> index 3cf7a7575f5c..54374e0f0257 100644
> --- a/arch/x86/boot/compressed/ident_map_64.c
> +++ b/arch/x86/boot/compressed/ident_map_64.c
> @@ -37,6 +37,9 @@
>  #include <asm/setup.h>	/* For COMMAND_LINE_SIZE */
>  #undef _SETUP
>  
> +#define __BOOT_COMPRESSED
> +#include <asm/sev.h> /* For sev_snp_active() + ConfidentialComputing blob */
> +

When you move all the cc_blob parsing to the compressed kernel, all that
ugly ifdeffery won't be needed.

>  extern unsigned long get_cmd_line_ptr(void);
>  
>  /* Used by PAGE_KERN* macros: */
> @@ -163,6 +166,21 @@ void initialize_identity_maps(void *rmode)
>  	cmdline = get_cmd_line_ptr();
>  	add_identity_map(cmdline, cmdline + COMMAND_LINE_SIZE);

Carve that ...

> +	/*
> +	 * The ConfidentialComputing blob is used very early in uncompressed
> +	 * kernel to find CPUID memory to handle cpuid instructions. Make sure
> +	 * an identity-mapping exists so they can be accessed after switchover.
> +	 */
> +	if (sev_snp_enabled()) {
> +		struct cc_blob_sev_info *cc_info =
> +			(void *)(unsigned long)boot_params->cc_blob_address;
> +
> +		add_identity_map((unsigned long)cc_info,
> +				 (unsigned long)cc_info + sizeof(*cc_info));
> +		add_identity_map((unsigned long)cc_info->cpuid_phys,
> +				 (unsigned long)cc_info->cpuid_phys + cc_info->cpuid_len);
> +	}
> +
>  	/* Load the new page-table. */
>  	sev_verify_cbit(top_level_pgt);

... up to here into a separate function called sev_prep_identity_maps()
so that SEV-specific code flow is not in the generic code path.

>  	write_cr3(top_level_pgt);

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
