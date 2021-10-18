Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A896431FA6
	for <lists+linux-efi@lfdr.de>; Mon, 18 Oct 2021 16:29:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232401AbhJRObz (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 18 Oct 2021 10:31:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232260AbhJRObj (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 18 Oct 2021 10:31:39 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CFADC06176D;
        Mon, 18 Oct 2021 07:29:09 -0700 (PDT)
Received: from zn.tnic (p200300ec2f085700a5f06031787ecc0a.dip0.t-ipconnect.de [IPv6:2003:ec:2f08:5700:a5f0:6031:787e:cc0a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D2FC91EC04C2;
        Mon, 18 Oct 2021 16:29:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1634567347;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=c9xEu9dyx4wrnGD++qak7Rf0JfD9ujFQ9E5yOZB19Q0=;
        b=aKWwYTlr9cCQu7ia5dZP/kuxrxzN93CyPBgOxttie/QBj3Td/GyHk64AiEAbXaIbAsIGqx
        BgGTrkPaemD3IjwBuWI2GydbibFzG2kuXi6yqjHnJLtsSpqF8n17AX6r45/y+wPNjuoNcV
        Bkj7MRJet38z0l3P6cMLUbOfmJ1xF50=
Date:   Mon, 18 Oct 2021 16:29:07 +0200
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
Subject: Re: [PATCH v6 08/42] x86/sev-es: initialize sev_status/features
 within #VC handler
Message-ID: <YW2EsxcqBucuyoal@zn.tnic>
References: <20211008180453.462291-1-brijesh.singh@amd.com>
 <20211008180453.462291-9-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211008180453.462291-9-brijesh.singh@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Oct 08, 2021 at 01:04:19PM -0500, Brijesh Singh wrote:
> From: Michael Roth <michael.roth@amd.com>
> 
> Generally access to MSR_AMD64_SEV is only safe if the 0x8000001F CPUID
> leaf indicates SEV support. With SEV-SNP, CPUID responses from the
> hypervisor are not considered trustworthy, particularly for 0x8000001F.
> SEV-SNP provides a firmware-validated CPUID table to use as an
> alternative, but prior to checking MSR_AMD64_SEV there are no
> guarantees that this is even an SEV-SNP guest.
> 
> Rather than relying on these CPUID values early on, allow SEV-ES and
> SEV-SNP guests to instead use a cpuid instruction to trigger a #VC and
> have it cache MSR_AMD64_SEV in sev_status, since it is known to be safe
> to access MSR_AMD64_SEV if a #VC has triggered.
> 
> Signed-off-by: Michael Roth <michael.roth@amd.com>
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> ---
>  arch/x86/kernel/sev-shared.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
> index 8ee27d07c1cd..2796c524d174 100644
> --- a/arch/x86/kernel/sev-shared.c
> +++ b/arch/x86/kernel/sev-shared.c
> @@ -191,6 +191,20 @@ void __init do_vc_no_ghcb(struct pt_regs *regs, unsigned long exit_code)
>  	if (exit_code != SVM_EXIT_CPUID)
>  		goto fail;
>  
> +	/*
> +	 * A #VC implies that either SEV-ES or SEV-SNP are enabled, so the SEV
> +	 * MSR is also available. Go ahead and initialize sev_status here to
> +	 * allow SEV features to be checked without relying solely on the SEV
> +	 * cpuid bit to indicate whether it is safe to do so.
> +	 */
> +	if (!sev_status) {
> +		unsigned long lo, hi;
> +
> +		asm volatile("rdmsr" : "=a" (lo), "=d" (hi)
> +				     : "c" (MSR_AMD64_SEV));
> +		sev_status = (hi << 32) | lo;
> +	}
> +
>  	sev_es_wr_ghcb_msr(GHCB_CPUID_REQ(fn, GHCB_CPUID_REQ_EAX));
>  	VMGEXIT();
>  	val = sev_es_rd_ghcb_msr();
> -- 

Ok, you guys are killing me. ;-\

How is bolting some pretty much unrelated code into the early #VC
handler not a hack? Do you not see it?

So sme_enable() is reading MSR_AMD64_SEV and setting up everything
there, including sev_status. If a SNP guest does not trust CPUID, why
can't you attempt to read that MSR there, even if CPUID has lied to the
guest?

And not just slap it somewhere just because it works?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
