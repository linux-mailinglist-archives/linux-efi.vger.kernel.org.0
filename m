Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 308E44AA835
	for <lists+linux-efi@lfdr.de>; Sat,  5 Feb 2022 11:54:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237023AbiBEKyN (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 5 Feb 2022 05:54:13 -0500
Received: from mail.skyhub.de ([5.9.137.197]:53540 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230020AbiBEKyL (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sat, 5 Feb 2022 05:54:11 -0500
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E27091EC02DD;
        Sat,  5 Feb 2022 11:54:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1644058446;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=uZ7YbZrJGPMPUOZHBNRpUaCuf4fbjJb2e0v1A635574=;
        b=Wi4j4RdBU/nduEspCZ+AEnQggLzEGh95jTHEMmr+DClFcPOZ5VKO1AVl1fq1d6uEZnyIR9
        94WXRdpFGpUC7ZltmJ5nyNtLaG7ckLTwcARlP7XhLQJFPS3GpUVCjl56uVAd6DMN/r7f/0
        HzQGDF4BaAeJsfhozkPmEQqp4+mkgvI=
Date:   Sat, 5 Feb 2022 11:54:01 +0100
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
Subject: Re: [PATCH v9 31/43] x86/compressed/64: Add support for SEV-SNP
 CPUID table in #VC handlers
Message-ID: <Yf5XScto3mDXnl9u@zn.tnic>
References: <20220128171804.569796-1-brijesh.singh@amd.com>
 <20220128171804.569796-32-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220128171804.569796-32-brijesh.singh@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Jan 28, 2022 at 11:17:52AM -0600, Brijesh Singh wrote:
> +/*
> + * Individual entries of the SEV-SNP CPUID table, as defined by the SEV-SNP
> + * Firmware ABI, Revision 0.9, Section 7.1, Table 14.
> + */
> +struct snp_cpuid_fn {
> +	u32 eax_in;
> +	u32 ecx_in;
> +	u64 xcr0_in;
> +	u64 xss_in;

So what's the end result here:

-+	u64 __unused;
-+	u64 __unused2;
++	u64 xcr0_in;
++	u64 xss_in;

those are not unused fields anymore but xcr0 and xss input values?

Looking at the FW abi doc, they're only mentioned in "Table 14.
CPUID_FUNCTION Structure" that they're XCR0 and XSS at the time of the
CPUID execution.

But those values are input values to what exactly, guest or firmware?

There's a typo in the FW doc, btw:

"The guest constructs an MSG_CPUID_REQ message as defined in Table 13.
This message contains an array of CPUID function structures as defined
in Table 13."

That second "Table" is 14 not 13.

So, if an array CPUID_FUNCTION[] is passed as part of an MSG_CPUID_REQ
command, then, the two _IN variables contain what the guest received
from the HV for XCR0 and XSS values. Which means, this is the guest
asking the FW whether those values the HV gave the guest are kosher.

Am I close?

> +static const struct snp_cpuid_info *snp_cpuid_info_get_ptr(void)
> +{
> +	void *ptr;
> +
> +	asm ("lea cpuid_info_copy(%%rip), %0"
> +	     : "=r" (ptr)

Same question as the last time:

Why not "=g" and let the compiler decide?

> +	     : "p" (&cpuid_info_copy));
> +
> +	return ptr;
> +}

...

> +static bool snp_cpuid_check_range(u32 func)
> +{
> +	if (func <= cpuid_std_range_max ||
> +	    (func >= 0x40000000 && func <= cpuid_hyp_range_max) ||
> +	    (func >= 0x80000000 && func <= cpuid_ext_range_max))
> +		return true;
> +
> +	return false;
> +}
> +
> +static int snp_cpuid_postprocess(u32 func, u32 subfunc, u32 *eax, u32 *ebx,
> +				 u32 *ecx, u32 *edx)

And again, same question as the last time:

I'm wondering if you could make everything a lot easier by doing

static int snp_cpuid_postprocess(struct cpuid_leaf *leaf)

and marshall around that struct cpuid_leaf which contains func, subfunc,
e[abcd]x instead of dealing with 6 parameters.

Callers of snp_cpuid() can simply allocate it on their stack and hand it
in and it is all in sev-shared.c so nicely self-contained...

Ok I'm ignoring this patch for now and I'll review it only after you've
worked in all comments from the previous review.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
