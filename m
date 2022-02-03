Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DA4D4A85A2
	for <lists+linux-efi@lfdr.de>; Thu,  3 Feb 2022 14:59:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238846AbiBCN7s (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 3 Feb 2022 08:59:48 -0500
Received: from mail.skyhub.de ([5.9.137.197]:32866 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232957AbiBCN7r (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 3 Feb 2022 08:59:47 -0500
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id EEF591EC04C1;
        Thu,  3 Feb 2022 14:59:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1643896782;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=gHYp8xZFp20UiBgydZl6yyeC9rXQ4/WmPw7B1KUrZ3Y=;
        b=F3DWJD4vb6hzZvkSuWqaVmu8sCwHciUGt8M/Ok8fVbwRXVyGNDmimooqpo32Z0fQSpgTY8
        M8AYV53sTY+yLoY10GWxHj/vztieS9gU69zP+GbdvTfQjgOwKDBGvK7RAOHWnCyhI4rAiv
        5t3F3bhvzv/NuW7CdEtLjIX8Mga3NPc=
Date:   Thu, 3 Feb 2022 14:59:36 +0100
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
Subject: Re: [PATCH v9 22/43] x86/sev: Move MSR-based VMGEXITs for CPUID to
 helper
Message-ID: <YfvfyAJU9QKcaF4d@zn.tnic>
References: <20220128171804.569796-1-brijesh.singh@amd.com>
 <20220128171804.569796-23-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220128171804.569796-23-brijesh.singh@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Jan 28, 2022 at 11:17:43AM -0600, Brijesh Singh wrote:
> From: Michael Roth <michael.roth@amd.com>
> 
> This code will also be used later for SEV-SNP-validated CPUID code in
> some cases, so move it to a common helper.

Suggested-by: Sean Christopherson <seanjc@google.com>

unless he really doesn't want to be the "suggestor" :)

> Signed-off-by: Michael Roth <michael.roth@amd.com>
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> ---
>  arch/x86/kernel/sev-shared.c | 62 +++++++++++++++++++++---------------
>  1 file changed, 36 insertions(+), 26 deletions(-)
> 
> diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
> index 3aaef1a18ffe..633f1f93b6e1 100644
> --- a/arch/x86/kernel/sev-shared.c
> +++ b/arch/x86/kernel/sev-shared.c
> @@ -194,6 +194,36 @@ enum es_result sev_es_ghcb_hv_call(struct ghcb *ghcb, bool set_ghcb_msr,
>  	return verify_exception_info(ghcb, ctxt);
>  }
>  
> +static int __sev_cpuid_hv(u32 func, int reg_idx, u32 *reg)
> +{
> +	u64 val;
> +
> +	if (!reg)
> +		return 0;

I don't know what that's supposed to catch? In case callers are
interested only in some subset of the CPUID leaf?

Meh, I guess...

> +	sev_es_wr_ghcb_msr(GHCB_CPUID_REQ(func, reg_idx));
> +	VMGEXIT();
> +	val = sev_es_rd_ghcb_msr();
> +	if (GHCB_RESP_CODE(val) != GHCB_MSR_CPUID_RESP)
> +		return -EIO;
> +
> +	*reg = (val >> 32);
> +
> +	return 0;
> +}
> +
> +static int sev_cpuid_hv(u32 func, u32 *eax, u32 *ebx, u32 *ecx, u32 *edx)
> +{
> +	int ret;
> +
> +	ret = __sev_cpuid_hv(func, GHCB_CPUID_REQ_EAX, eax);
> +	ret = ret ? : __sev_cpuid_hv(func, GHCB_CPUID_REQ_EBX, ebx);
> +	ret = ret ? : __sev_cpuid_hv(func, GHCB_CPUID_REQ_ECX, ecx);
> +	ret = ret ? : __sev_cpuid_hv(func, GHCB_CPUID_REQ_EDX, edx);

You can format that this way:

        ret =         __sev_cpuid_hv(func, GHCB_CPUID_REQ_EAX, eax);
        ret = ret ? : __sev_cpuid_hv(func, GHCB_CPUID_REQ_EBX, ebx);
        ret = ret ? : __sev_cpuid_hv(func, GHCB_CPUID_REQ_ECX, ecx);
        ret = ret ? : __sev_cpuid_hv(func, GHCB_CPUID_REQ_EDX, edx);


and then it is visible at a quick glance what this does, due to the
regularity.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
