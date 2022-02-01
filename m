Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 622654A6540
	for <lists+linux-efi@lfdr.de>; Tue,  1 Feb 2022 20:59:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231815AbiBAT7L (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 1 Feb 2022 14:59:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234295AbiBAT7K (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 1 Feb 2022 14:59:10 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C925C06173B;
        Tue,  1 Feb 2022 11:59:10 -0800 (PST)
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DCFE21EC0523;
        Tue,  1 Feb 2022 20:59:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1643745545;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=NQq1a82TXHHJ9pRBeQutIGcbAsj9VD5Dy+Q6arLSFXA=;
        b=L98AlkeczP73F/Jv8YwWRWtrvYwE65aWamuUFqY5IDXPh0lG4oEq0oxMObNPRQXEdkx2Mc
        WvV22P5Q4uqcERSjHp1+7ARhC+z1jhebpsQ/Ljh/7Of+wDcf296nXtS9bItOxUaq8lJ3ab
        YqBIr81ua3MfzJQ6epfu/TAf/exu0es=
Date:   Tue, 1 Feb 2022 20:59:01 +0100
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
Subject: Re: [PATCH v9 10/43] x86/sev: Check SEV-SNP features support
Message-ID: <YfmRBUtoWNb9BkuL@zn.tnic>
References: <20220128171804.569796-1-brijesh.singh@amd.com>
 <20220128171804.569796-11-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220128171804.569796-11-brijesh.singh@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Jan 28, 2022 at 11:17:31AM -0600, Brijesh Singh wrote:
> diff --git a/arch/x86/boot/compressed/idt_64.c b/arch/x86/boot/compressed/idt_64.c
> index 9b93567d663a..63e9044ab1d6 100644
> --- a/arch/x86/boot/compressed/idt_64.c
> +++ b/arch/x86/boot/compressed/idt_64.c
> @@ -39,7 +39,15 @@ void load_stage1_idt(void)
>  	load_boot_idt(&boot_idt_desc);
>  }
>  
> -/* Setup IDT after kernel jumping to  .Lrelocated */
> +/*
> + * Setup IDT after kernel jumping to  .Lrelocated
> + *
> + * initialize_identity_maps() needs a PF handler setup. The PF handler setup
> + * needs to happen in load_stage2_idt() where the IDT is loaded and there the
> + * VC IDT entry gets setup too in order to handle VCs, one needs a GHCB which
> + * gets setup with an already setup table which is done in
> + * initialize_identity_maps() and this is where the circle is complete.
> + */

I've beefed it up more, please use this one instead:

/*
 * Setup IDT after kernel jumping to  .Lrelocated.
 *
 * initialize_identity_maps() needs a #PF handler to be setup
 * in order to be able to fault-in identity mapping ranges; see
 * do_boot_page_fault().
 *
 * This #PF handler setup needs to happen in load_stage2_idt() where the
 * IDT is loaded and there the #VC IDT entry gets setup too.
 *
 * In order to be able to handle #VCs, one needs a GHCB which
 * gets setup with an already set up pagetable, which is done in
 * initialize_identity_maps(). And there's the catch 22: the boot #VC
 * handler do_boot_stage2_vc() needs to call early_setup_ghcb() itself
 * (and, especially set_page_decrypted()) because the SEV-ES setup code
 * cannot initialize a GHCB as there's no #PF handler yet...
 */

> diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
> index 19ad09712902..24df739c9c05 100644
> --- a/arch/x86/kernel/sev.c
> +++ b/arch/x86/kernel/sev.c
> @@ -43,6 +43,9 @@ static struct ghcb boot_ghcb_page __bss_decrypted __aligned(PAGE_SIZE);
>   */
>  static struct ghcb __initdata *boot_ghcb;
>  
> +/* Bitmap of SEV features supported by the hypervisor */
> +static u64 sev_hv_features __ro_after_init;
> +
>  /* #VC handler runtime per-CPU data */
>  struct sev_es_runtime_data {
>  	struct ghcb ghcb_page;
> @@ -766,6 +769,18 @@ void __init sev_es_init_vc_handling(void)
>  	if (!sev_es_check_cpu_features())
>  		panic("SEV-ES CPU Features missing");
>  
> +	/*
> +	 * SEV-SNP is supported in v2 of the GHCB spec which mandates support for HV
> +	 * features. If SEV-SNP is enabled, then check if the hypervisor supports
> +	 * the SEV-SNP features.

You guys have been completely brainwashed by marketing. I say:

"s/SEV-SNP/SNP/g

And please do that everywhere in sev-specific files."

and you go and slap that "SEV-" thing everywhere instead. Why? That file
is already called sev.c so it must be SEV-something. Lemme simplify that
comment for ya:

	/*
	 * SNP is supported in v2 of the GHCB spec which mandates support for HV
	 * features.
	 */

That's it, no more needed - the rest should be visible from the code.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
