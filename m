Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC2334A6F8B
	for <lists+linux-efi@lfdr.de>; Wed,  2 Feb 2022 12:07:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232832AbiBBLGm (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 2 Feb 2022 06:06:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236708AbiBBLGj (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 2 Feb 2022 06:06:39 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CF2CC06173E;
        Wed,  2 Feb 2022 03:06:39 -0800 (PST)
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C5E0E1EC0513;
        Wed,  2 Feb 2022 12:06:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1643799993;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=T5KarsviFxcdPdr91Ju50bIXrFx/Ww52H/WmFLJHWWk=;
        b=oXHB2bMIYcC69Z2LEdY0Kp3e4q+aUB7LWsYhNn3wevkRodEY2WCg1LuVEpeNDtxTrfzab8
        ct1X+4H0PojDxi5drGWWg6PRjOminwTVFtJA8ySyvP9PR9gy2fZC7eyO03NzYf5MlVpIpz
        ttux2IT7OMBSjaXoLcwcmTzaun8uLjI=
Date:   Wed, 2 Feb 2022 12:06:29 +0100
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
Subject: Re: [PATCH v9 17/43] x86/kernel: Make the .bss..decrypted section
 shared in RMP table
Message-ID: <YfpltcR7IqhP5KTq@zn.tnic>
References: <20220128171804.569796-1-brijesh.singh@amd.com>
 <20220128171804.569796-18-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220128171804.569796-18-brijesh.singh@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Jan 28, 2022 at 11:17:38AM -0600, Brijesh Singh wrote:
> The encryption attribute for the .bss..decrypted section is cleared in the
> initial page table build. This is because the section contains the data
> that need to be shared between the guest and the hypervisor.
> 
> When SEV-SNP is active, just clearing the encryption attribute in the
> page table is not enough. The page state need to be updated in the RMP
> table.
> 
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> ---
>  arch/x86/kernel/head64.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
> index 8075e91cff2b..1239bc104cda 100644
> --- a/arch/x86/kernel/head64.c
> +++ b/arch/x86/kernel/head64.c
> @@ -143,7 +143,21 @@ static unsigned long sme_postprocess_startup(struct boot_params *bp, pmdval_t *p
>  	if (sme_get_me_mask()) {
>  		vaddr = (unsigned long)__start_bss_decrypted;
>  		vaddr_end = (unsigned long)__end_bss_decrypted;
> +
>  		for (; vaddr < vaddr_end; vaddr += PMD_SIZE) {
> +			/*
> +			 * When SEV-SNP is active then transition the page to
> +			 * shared in the RMP table so that it is consistent with
> +			 * the page table attribute change.
> +			 *
> +			 * At this point, kernel is running in identity mapped mode.
> +			 * The __start_bss_decrypted is a regular kernel address. The
> +			 * early_snp_set_memory_shared() requires a valid virtual
> +			 * address, so use __pa() against __start_bss_decrypted to
> +			 * get valid virtual address.
> +			 */

How's that?

                        /*
                         * On SNP, transition the page to shared in the RMP table so that
                         * it is consistent with the page table attribute change.
                         *
                         * __start_bss_decrypted has a virtual address in the high range
                         * mapping (kernel .text). PVALIDATE, by way of
                         * early_snp_set_memory_shared(), requires a valid virtual
                         * address but the kernel is currently running off of the identity
                         * mapping so use __pa() to get a *currently* valid virtual address.
                         */

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
