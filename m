Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4696D47C04A
	for <lists+linux-efi@lfdr.de>; Tue, 21 Dec 2021 14:01:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238019AbhLUNBc (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 21 Dec 2021 08:01:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238014AbhLUNBa (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 21 Dec 2021 08:01:30 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDDCEC061746;
        Tue, 21 Dec 2021 05:01:29 -0800 (PST)
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D8E5D1EC036C;
        Tue, 21 Dec 2021 14:01:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1640091683;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1bprDfdvCUTDmFgPeZ/DgEcYMZB8JnU81wIATQ3hdpI=;
        b=lFD/OZLGP6rpHXQds9Z1P6kCLWylMFdckyx96tcwS7nkgVDi6n6Xe1gwIT6LuyMr3KQ2w9
        2aqFuN3mm90ztX/32tCYPjfU3fNYZGMDnOrAEZPwHAcxxP8QDlcYmI/rADQSfKzHv+N+XE
        Lr4sw56igof13tj/+zrymJI8E4fzrvA=
Date:   Tue, 21 Dec 2021 14:01:26 +0100
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
Subject: Re: [PATCH v8 09/40] x86/compressed: Add helper for validating pages
 in the decompression stage
Message-ID: <YcHQJqm4iP9/9TjE@zn.tnic>
References: <20211210154332.11526-1-brijesh.singh@amd.com>
 <20211210154332.11526-10-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211210154332.11526-10-brijesh.singh@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Dec 10, 2021 at 09:43:01AM -0600, Brijesh Singh wrote:
> diff --git a/arch/x86/boot/compressed/ident_map_64.c b/arch/x86/boot/compressed/ident_map_64.c
> index f7213d0943b8..ef77453cc629 100644
> --- a/arch/x86/boot/compressed/ident_map_64.c
> +++ b/arch/x86/boot/compressed/ident_map_64.c
> @@ -275,15 +275,31 @@ static int set_clr_page_flags(struct x86_mapping_info *info,
>  	 * Changing encryption attributes of a page requires to flush it from
>  	 * the caches.
>  	 */
> -	if ((set | clr) & _PAGE_ENC)
> +	if ((set | clr) & _PAGE_ENC) {
>  		clflush_page(address);
>  
> +		/*
> +		 * If the encryption attribute is being cleared, then change
> +		 * the page state to shared in the RMP table.
> +		 */
> +		if (clr)
> +			snp_set_page_shared(pte_pfn(*ptep) << PAGE_SHIFT);

You forgot to change that one.

> +	}
> +
>  	/* Update PTE */
>  	pte = *ptep;
>  	pte = pte_set_flags(pte, set);
>  	pte = pte_clear_flags(pte, clr);
>  	set_pte(ptep, pte);
>  
> +	/*
> +	 * If the encryption attribute is being set, then change the page state to
> +	 * private in the RMP entry. The page state must be done after the PTE
                                                   ^
                                                 change

Geez, tell me, why should I be even bothering to review stuff if I have
to go look at the previous review I did and find that you haven't really
addressed it?!

> diff --git a/arch/x86/include/asm/sev-common.h b/arch/x86/include/asm/sev-common.h
> index 7ac5842e32b6..a2f956cfafba 100644
> --- a/arch/x86/include/asm/sev-common.h
> +++ b/arch/x86/include/asm/sev-common.h
> @@ -57,6 +57,32 @@
>  #define GHCB_MSR_AP_RESET_HOLD_REQ	0x006
>  #define GHCB_MSR_AP_RESET_HOLD_RESP	0x007
>  
> +/*
> + * SNP Page State Change Operation
> + *
> + * GHCBData[55:52] - Page operation:
> + *   0x0001 – Page assignment, Private
> + *   0x0002 – Page assignment, Shared

I wonder how you've achieved that:

massage_diff: Warning: Unicode char [–] (0x2013) in line: + *   0x0001 – Page assignment, Private
massage_diff: Warning: Unicode char [–] (0x2013) in line: + *   0x0002 – Page assignment, Shared

See https://trojansource.codes/ for some background.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
