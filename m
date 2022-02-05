Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06AAC4AA905
	for <lists+linux-efi@lfdr.de>; Sat,  5 Feb 2022 14:07:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379934AbiBENHw (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 5 Feb 2022 08:07:52 -0500
Received: from mail.skyhub.de ([5.9.137.197]:41948 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233802AbiBENHv (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sat, 5 Feb 2022 08:07:51 -0500
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D113E1EC051E;
        Sat,  5 Feb 2022 14:07:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1644066466;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=0xuIpKje8zkOvUagGUNB86BnlJAw32mk/ZqXAf5Gr+4=;
        b=IUy7dO+ddvE4dWRGM+hDG+rqKvIhsL8kvqBT5KM38cC4/cUWC6MfOWm65C16n50FTJPZDH
        7/FulyBflZG+slZjlrj38QcIZqR67m9NUmcpP/4ywOtL6eod7Aihc4aY/wde7Da11/E3C1
        B4WI1FS0d1xiONTe0XeAJWVQ5fF0CUM=
Date:   Sat, 5 Feb 2022 14:07:45 +0100
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
Subject: Re: [PATCH v9 32/43] x86/boot: Add a pointer to Confidential
 Computing blob in bootparams
Message-ID: <Yf52oebXr+fKioTJ@zn.tnic>
References: <20220128171804.569796-1-brijesh.singh@amd.com>
 <20220128171804.569796-33-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220128171804.569796-33-brijesh.singh@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Jan 28, 2022 at 11:17:53AM -0600, Brijesh Singh wrote:
> From: Michael Roth <michael.roth@amd.com>
> 
> The previously defined Confidential Computing blob is provided to the
> kernel via a setup_data structure or EFI config table entry. Currently
> these are both checked for by boot/compressed kernel to access the
> CPUID table address within it for use with SEV-SNP CPUID enforcement.
> 
> To also enable SEV-SNP CPUID enforcement for the run-time kernel,
> similar early access to the CPUID table is needed early on while it's
> still using the identity-mapped page table set up by boot/compressed,
> where global pointers need to be accessed via fixup_pointer().
> 
> This isn't much of an issue for accessing setup_data, and the EFI
> config table helper code currently used in boot/compressed *could* be
> used in this case as well since they both rely on identity-mapping.
> However, it has some reliance on EFI helpers/string constants that
> would need to be accessed via fixup_pointer(), and fixing it up while
> making it shareable between boot/compressed and run-time kernel is
> fragile and introduces a good bit of uglyness.
> 
> Instead, add a boot_params->cc_blob_address pointer that the
> boot/compressed kernel can initialize so that the run-time kernel can
> access the CC blob from there instead of re-scanning the EFI config
> table.
> 
> Signed-off-by: Michael Roth <michael.roth@amd.com>
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> ---
>  arch/x86/include/asm/bootparam_utils.h | 1 +
>  arch/x86/include/uapi/asm/bootparam.h  | 3 ++-
>  2 files changed, 3 insertions(+), 1 deletion(-)

Another review comment ignored:

https://lore.kernel.org/r/YeWyCtr11rL7dxpT@zn.tnic

/me ignores this patch too.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
