Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F59046DA32
	for <lists+linux-efi@lfdr.de>; Wed,  8 Dec 2021 18:41:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232041AbhLHRpZ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 8 Dec 2021 12:45:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231695AbhLHRpW (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 8 Dec 2021 12:45:22 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B53A4C061746;
        Wed,  8 Dec 2021 09:41:50 -0800 (PST)
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 85D481EC04D3;
        Wed,  8 Dec 2021 18:41:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1638985303;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=BVB1m3MrNRyz7QEt2fceR49E0yXRKK99UJ6lToflU+M=;
        b=plYDMSSdy0AlmPWLQfXS/7oOeIwQCRt1HOSpB0McPkEavfxw4f8gLgIuMdXHY83gDJ/xJX
        0RCjuXJK2+CkfQfDA6ItGYTPBrLza2XhPdTQUw/RYpNqE9/f6br44Xd7qmGMcAVyb8g9yN
        XehNfufGbEq41gGE3w/dhMtObAW6vXE=
Date:   Wed, 8 Dec 2021 18:41:46 +0100
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
Subject: Re: [PATCH v7 16/45] x86/sev: Register GHCB memory when SEV-SNP is
 active
Message-ID: <YbDuWl+zgtKrFi7D@zn.tnic>
References: <20211110220731.2396491-1-brijesh.singh@amd.com>
 <20211110220731.2396491-17-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211110220731.2396491-17-brijesh.singh@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Nov 10, 2021 at 04:07:02PM -0600, Brijesh Singh wrote:
> The SEV-SNP guest is required to perform GHCB GPA registration. This is
> because the hypervisor may prefer that a guest use a consistent and/or
> specific GPA for the GHCB associated with a vCPU. For more information,
> see the GHCB specification section GHCB GPA Registration.
> 
> During the boot, init_ghcb() allocates a per-cpu GHCB page. On very first
> VC exception,

That is not true anymore - you're doing proper init at init time - no
more #VC hackery.

> @@ -1977,6 +1978,10 @@ void cpu_init_exception_handling(void)
>  
>  	load_TR_desc();
>  
> +	/* Register the GHCB before taking any VC exception */
> +	if (IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT))

No need for that if branch - sev_snp_register_ghcb() already has an
empty stub for the !CONFIG_AMD_MEM_ENCRYPT case so you can simply call
it unconditionally.

> +		sev_snp_register_ghcb();
> +
>  	/* Finally load the IDT */
>  	load_current_idt();
>  }
> diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
> index 54bf0603002f..968105cec364 100644
> --- a/arch/x86/kernel/head64.c
> +++ b/arch/x86/kernel/head64.c
> @@ -588,6 +588,9 @@ void early_setup_idt(void)
>  
>  	bringup_idt_descr.address = (unsigned long)bringup_idt_table;
>  	native_load_idt(&bringup_idt_descr);
> +
> +	if (IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT))
> +		sev_snp_register_ghcb();

Ditto.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
