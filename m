Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F2DC4746E0
	for <lists+linux-efi@lfdr.de>; Tue, 14 Dec 2021 16:53:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233577AbhLNPxv (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 14 Dec 2021 10:53:51 -0500
Received: from mail.skyhub.de ([5.9.137.197]:50680 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231951AbhLNPxv (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 14 Dec 2021 10:53:51 -0500
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 38EE91EC059D;
        Tue, 14 Dec 2021 16:53:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1639497225;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=OlUC3lLRynZi+JY7FEvlz/ZRL8mKuuxtrhCfASCsERU=;
        b=Mou9wxta1Vtvbw8Tn2z/E28PO17LKbLUS3B81uGspJgM8/CX1d5QbqQ6r4ZnpbUC9fPLNU
        5K3Fz8G+kSCgyUTjaLA3+74zTDr78Fb5bqGmZWajsVeaDSdyykpOlAaRMtL1vhJCbGLNqX
        h2ZHfnF4qXCvZi1bwVxagVu92iylrTk=
Date:   Tue, 14 Dec 2021 16:53:46 +0100
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
Subject: Re: [PATCH v8 03/40] x86/mm: Extend cc_attr to include AMD SEV-SNP
Message-ID: <Ybi+ChUXwLRkWJY/@zn.tnic>
References: <20211210154332.11526-1-brijesh.singh@amd.com>
 <20211210154332.11526-4-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211210154332.11526-4-brijesh.singh@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Dec 10, 2021 at 09:42:55AM -0600, Brijesh Singh wrote:
> diff --git a/include/linux/cc_platform.h b/include/linux/cc_platform.h
> index a075b70b9a70..ef5e2209c9b8 100644
> --- a/include/linux/cc_platform.h
> +++ b/include/linux/cc_platform.h
> @@ -61,6 +61,14 @@ enum cc_attr {
>  	 * Examples include SEV-ES.
>  	 */
>  	CC_ATTR_GUEST_STATE_ENCRYPT,
> +
> +	/**
> +	 * @CC_ATTR_SEV_SNP: Guest SNP is active.
> +	 *
> +	 * The platform/OS is running as a guest/virtual machine and actively
> +	 * using AMD SEV-SNP features.
> +	 */
> +	CC_ATTR_SEV_SNP = 0x100,

I guess CC_ATTR_GUEST_SEV_SNP. The Intel is called CC_ATTR_GUEST_TDX so
at least they all say it is a guest thing, this way.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
