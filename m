Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEDF84709F2
	for <lists+linux-efi@lfdr.de>; Fri, 10 Dec 2021 20:13:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234520AbhLJTQh (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 10 Dec 2021 14:16:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231135AbhLJTQg (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 10 Dec 2021 14:16:36 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0FF4C061746;
        Fri, 10 Dec 2021 11:13:00 -0800 (PST)
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4A0F71EC0464;
        Fri, 10 Dec 2021 20:12:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1639163574;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=zOvqZDAuThO0Gse+ltEBq8F8HgtMzjgZ0zyBb5o7Cmw=;
        b=K2Yi5I1zv9x1SKbZJ3yEuFX3WRb96DgwIr4qpeAFA/gtlsLEOMsfCc9y9kDFQjjWQUeTx+
        hJTZXjLmWUhLnoeRTxRzPngUhy0MJVAgFMbwH0DOSSBPUgbONDRn0ERqBKKO6J6TLUtut7
        gwEU6EMZerCB1D/6Z/SBun/3zSdrKEs=
Date:   Fri, 10 Dec 2021 20:12:55 +0100
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
Subject: Re: [PATCH v8 01/40] x86/compressed/64: detect/setup SEV/SME
 features earlier in boot
Message-ID: <YbOmt+tYvzAqOiTY@zn.tnic>
References: <20211210154332.11526-1-brijesh.singh@amd.com>
 <20211210154332.11526-2-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211210154332.11526-2-brijesh.singh@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Dec 10, 2021 at 09:42:53AM -0600, Brijesh Singh wrote:
> @@ -447,6 +446,23 @@ SYM_CODE_START(startup_64)
>  	call	load_stage1_idt
>  	popq	%rsi
>  
> +#ifdef CONFIG_AMD_MEM_ENCRYPT

I guess that ifdeffery is not needed.

> +	/*
> +	 * Now that the stage1 interrupt handlers are set up, #VC exceptions from
> +	 * CPUID instructions can be properly handled for SEV-ES guests.
> +	 *
> +	 * For SEV-SNP, the CPUID table also needs to be set up in advance of any
> +	 * CPUID instructions being issued, so go ahead and do that now via
> +	 * sev_enable(), which will also handle the rest of the SEV-related
> +	 * detection/setup to ensure that has been done in advance of any dependent
> +	 * code.
> +	 */
> +	pushq	%rsi
> +	movq	%rsi, %rdi		/* real mode address */
> +	call	sev_enable
> +	popq	%rsi
> +#endif
> +
>  	/*
>  	 * paging_prepare() sets up the trampoline and checks if we need to
>  	 * enable 5-level paging.

...

> +void sev_enable(struct boot_params *bp)
> +{
> +	unsigned int eax, ebx, ecx, edx;
> +
> +	/* Check for the SME/SEV support leaf */
> +	eax = 0x80000000;
> +	ecx = 0;
> +	native_cpuid(&eax, &ebx, &ecx, &edx);
> +	if (eax < 0x8000001f)
> +		return;
> +
> +	/*
> +	 * Check for the SME/SEV feature:
> +	 *   CPUID Fn8000_001F[EAX]
> +	 *   - Bit 0 - Secure Memory Encryption support
> +	 *   - Bit 1 - Secure Encrypted Virtualization support
> +	 *   CPUID Fn8000_001F[EBX]
> +	 *   - Bits 5:0 - Pagetable bit position used to indicate encryption
> +	 */
> +	eax = 0x8000001f;
> +	ecx = 0;
> +	native_cpuid(&eax, &ebx, &ecx, &edx);
> +	/* Check whether SEV is supported */
> +	if (!(eax & BIT(1)))
> +		return;
> +
> +	/* Set the SME mask if this is an SEV guest. */
> +	sev_status   = rd_sev_status_msr();
> +

^ Superfluous newline.

> +	if (!(sev_status & MSR_AMD64_SEV_ENABLED))
> +		return;
> +
> +	sme_me_mask = BIT_ULL(ebx & 0x3f);
> +}
> -- 

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
