Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4402A46BA57
	for <lists+linux-efi@lfdr.de>; Tue,  7 Dec 2021 12:48:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235847AbhLGLvf (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 7 Dec 2021 06:51:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235832AbhLGLve (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 7 Dec 2021 06:51:34 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 757E6C061574;
        Tue,  7 Dec 2021 03:48:04 -0800 (PST)
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D51561EC0118;
        Tue,  7 Dec 2021 12:47:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1638877679;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=ImwCuPkAr7fvJr1l21+QubTsvfhG9Iyh1wi4z5y64u4=;
        b=d1hoIFDkZQ6OXWiqKYR55Vzt3fbkeUbjXfXUmSWPQivG6BsLV+kZtYulzv1av2StEnzWOI
        vdognkgMsyn2je/qVJst/1nM+vstj6jXL5XSPj05tLNy2rm+u9QeQZP91ypLfBImrew6ci
        P3DopPWmo0wi6r82pD7/YBQTCO6dKcw=
Date:   Tue, 7 Dec 2021 12:48:00 +0100
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
Subject: Re: [PATCH v7 14/45] x86/compressed: Add helper for validating pages
 in the decompression stage
Message-ID: <Ya9J8FSeyv/cEhnb@zn.tnic>
References: <20211110220731.2396491-1-brijesh.singh@amd.com>
 <20211110220731.2396491-15-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211110220731.2396491-15-brijesh.singh@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Nov 10, 2021 at 04:07:00PM -0600, Brijesh Singh wrote:
> diff --git a/arch/x86/boot/compressed/ident_map_64.c b/arch/x86/boot/compressed/ident_map_64.c
> index f7213d0943b8..3cf7a7575f5c 100644
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

So I'm wondering: __page_state_change() wants a physical address and
you're reading it out from the PTE here.

Why not do

	__pa(address & PAGE_MASK);

like it is usually done?

And those macros are right there at the top of ident_map_64.c with an
explanation that we're ident-mapped here so pa == va...

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

> +	 * is updated.
> +	 */
> +	if (set & _PAGE_ENC)
> +		snp_set_page_private(pte_pfn(*ptep) << PAGE_SHIFT);
> +
>  	/* Flush TLB after changing encryption attribute */
>  	write_cr3(top_level_pgt);
>  
-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
