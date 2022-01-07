Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 589A9487829
	for <lists+linux-efi@lfdr.de>; Fri,  7 Jan 2022 14:22:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347525AbiAGNWc (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 7 Jan 2022 08:22:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238705AbiAGNWc (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 7 Jan 2022 08:22:32 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E12D9C061574;
        Fri,  7 Jan 2022 05:22:31 -0800 (PST)
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4E80B1EC0464;
        Fri,  7 Jan 2022 14:22:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1641561746;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=pVViJ0G3u3Co8g3zSy4x+2tL0dqkqg5ZqrsUYLtYtws=;
        b=jLRYGvIELCCZX/2eywvMkZOSxEIdncB5wcDn89Se8+nS28iKnUj+EDY4G+Tyv2u3e7lxj2
        Ssvn3MrfwK7SpHYxlUw0adV/ssMdXZHY0RZgdQhZivjEuEb9b/QRPaDgDVEtLpdaZ4m0HT
        Ee5tG/1mOdosHGb58gaBNWmtJ4R1YRY=
Date:   Fri, 7 Jan 2022 14:22:28 +0100
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
Subject: Re: [PATCH v8 28/40] KVM: SEV: Add documentation for SEV-SNP CPUID
 Enforcement
Message-ID: <Ydg+lNhVmQbJ+Lxb@zn.tnic>
References: <20211210154332.11526-1-brijesh.singh@amd.com>
 <20211210154332.11526-29-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211210154332.11526-29-brijesh.singh@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Dec 10, 2021 at 09:43:20AM -0600, Brijesh Singh wrote:
> From: Michael Roth <michael.roth@amd.com>
> 
> Update the documentation with SEV-SNP CPUID enforcement.
> 
> Signed-off-by: Michael Roth <michael.roth@amd.com>
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> ---
>  .../virt/kvm/amd-memory-encryption.rst        | 28 +++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/Documentation/virt/kvm/amd-memory-encryption.rst b/Documentation/virt/kvm/amd-memory-encryption.rst
> index 5c081c8c7164..aa8292fa579a 100644
> --- a/Documentation/virt/kvm/amd-memory-encryption.rst
> +++ b/Documentation/virt/kvm/amd-memory-encryption.rst
> @@ -427,6 +427,34 @@ issued by the hypervisor to make the guest ready for execution.
>  
>  Returns: 0 on success, -negative on error
>  
> +SEV-SNP CPUID Enforcement
> +=========================
> +
> +SEV-SNP guests can access a special page that contains a table of CPUID values
> +that have been validated by the PSP as part of SNP_LAUNCH_UPDATE firmware
						 ^
						 the

> +command. It provides the following assurances regarding the validity of CPUID
> +values:
> +
> + - Its address is obtained via bootloader/firmware (via CC blob), whose
> +   binares will be measured as part of the SEV-SNP attestation report.

Unknown word [binares] in Documentation.
Suggestions: ['binaries', 'Linares', 'bi nares', 'bi-nares', 'bin ares', 'bin-ares', 'nares']

Also:

s/whose binaries/and those binaries/

> + - Its initial state will be encrypted/pvalidated, so attempts to modify
> +   it during run-time will be result in garbage being written, or #VC

s/be //

> +   exceptions being generated due to changes in validation state if the
> +   hypervisor tries to swap the backing page.
> + - Attempts to bypass PSP checks by hypervisor by using a normal page, or a
				      ^
				      the

> +   non-CPUID encrypted page will change the measurement provided by the
> +   SEV-SNP attestation report.
> + - The CPUID page contents are *not* measured, but attempts to modify the
> +   expected contents of a CPUID page as part of guest initialization will be
> +   gated by the PSP CPUID enforcement policy checks performed on the page
> +   during SNP_LAUNCH_UPDATE, and noticeable later if the guest owner
> +   implements their own checks of the CPUID values.
> +
> +It is important to note that this last assurance is only useful if the kernel
> +has taken care to make use of the SEV-SNP CPUID throughout all stages of boot.
> +Otherwise guest owner attestation provides no assurance that the kernel wasn't
	    ^
	    ,

> +fed incorrect values at some point during boot.
> +
>  References
>  ==========
>  
> -- 
> 2.25.1
> 

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
