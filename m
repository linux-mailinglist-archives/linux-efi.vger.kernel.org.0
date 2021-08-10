Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1E953E58FC
	for <lists+linux-efi@lfdr.de>; Tue, 10 Aug 2021 13:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240095AbhHJLWK (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 10 Aug 2021 07:22:10 -0400
Received: from mail.skyhub.de ([5.9.137.197]:42748 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237367AbhHJLWK (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 10 Aug 2021 07:22:10 -0400
Received: from zn.tnic (p200300ec2f0d6500ceb5d19a4916b1c0.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:6500:ceb5:d19a:4916:b1c0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B31AE1EC0345;
        Tue, 10 Aug 2021 13:21:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1628594499;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=jxQ/uGaIC2hNdLaotz2he1qg+SDxseRUqTr7wLeakrc=;
        b=APjc8gUXPsLUuxJkQzUYGN6q0+8dfojHKppTJMvFnFS9d3fo4B2i5wyWddjqROX221Jl+e
        5TKpVYM9EDn0MgHtzGWZrO5R/ncJCLadbtuZBQxZj5wpKUp56MIwtHy53DKviQRfv7PPu+
        MGS6Nbx2cqwmWJ0P4wD6xqEpAPSbUz4=
Date:   Tue, 10 Aug 2021 13:22:19 +0200
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
        David Rientjes <rientjes@google.com>,
        Dov Murik <dovmurik@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Michael Roth <michael.roth@amd.com>,
        Vlastimil Babka <vbabka@suse.cz>, tony.luck@intel.com,
        npmccallum@redhat.com, brijesh.ksingh@gmail.com
Subject: Re: [PATCH Part1 RFC v4 03/36] x86/sev: Add support for hypervisor
 feature VMGEXIT
Message-ID: <YRJha2XSZo3u7KIr@zn.tnic>
References: <20210707181506.30489-1-brijesh.singh@amd.com>
 <20210707181506.30489-4-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210707181506.30489-4-brijesh.singh@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Jul 07, 2021 at 01:14:33PM -0500, Brijesh Singh wrote:
> diff --git a/arch/x86/include/asm/sev-common.h b/arch/x86/include/asm/sev-common.h
> index 11b7d9cea775..23929a3010df 100644
> --- a/arch/x86/include/asm/sev-common.h
> +++ b/arch/x86/include/asm/sev-common.h
> @@ -45,6 +45,15 @@
>  		(((unsigned long)reg & GHCB_MSR_CPUID_REG_MASK) << GHCB_MSR_CPUID_REG_POS) | \
>  		(((unsigned long)fn) << GHCB_MSR_CPUID_FUNC_POS))
>  
> +/* GHCB Hypervisor Feature Request */
> +#define GHCB_MSR_HV_FT_REQ	0x080
> +#define GHCB_MSR_HV_FT_RESP	0x081
> +#define GHCB_MSR_HV_FT_POS	12
> +#define GHCB_MSR_HV_FT_MASK	GENMASK_ULL(51, 0)
> +
> +#define GHCB_MSR_HV_FT_RESP_VAL(v)	\
> +	(((unsigned long)((v) >> GHCB_MSR_HV_FT_POS) & GHCB_MSR_HV_FT_MASK))

As I suggested...

> @@ -215,6 +216,7 @@
>  	{ SVM_VMGEXIT_NMI_COMPLETE,	"vmgexit_nmi_complete" }, \
>  	{ SVM_VMGEXIT_AP_HLT_LOOP,	"vmgexit_ap_hlt_loop" }, \
>  	{ SVM_VMGEXIT_AP_JUMP_TABLE,	"vmgexit_ap_jump_table" }, \
> +	{ SVM_VMGEXIT_HYPERVISOR_FEATURES,	"vmgexit_hypervisor_feature" }, \

	SVM_VMGEXIT_HV_FEATURES

>  	{ SVM_EXIT_ERR,         "invalid_guest_state" }
>  
>  
> diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
> index 19c2306ac02d..34821da5f05e 100644
> --- a/arch/x86/kernel/sev-shared.c
> +++ b/arch/x86/kernel/sev-shared.c
> @@ -23,6 +23,9 @@
>   */
>  static u16 ghcb_version __section(".data..ro_after_init");
>  
> +/* Bitmap of SEV features supported by the hypervisor */
> +u64 sev_hv_features __section(".data..ro_after_init") = 0;

__ro_after_init

> diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
> index 66b7f63ad041..540b81ac54c9 100644
> --- a/arch/x86/kernel/sev.c
> +++ b/arch/x86/kernel/sev.c
> @@ -96,6 +96,9 @@ struct ghcb_state {
>  static DEFINE_PER_CPU(struct sev_es_runtime_data*, runtime_data);
>  DEFINE_STATIC_KEY_FALSE(sev_es_enable_key);
>  
> +/* Bitmap of SEV features supported by the hypervisor */
> +EXPORT_SYMBOL(sev_hv_features);

Why is this exported and why not a _GPL export?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
