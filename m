Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F79C4A86BB
	for <lists+linux-efi@lfdr.de>; Thu,  3 Feb 2022 15:40:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233897AbiBCOkJ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 3 Feb 2022 09:40:09 -0500
Received: from mail.skyhub.de ([5.9.137.197]:39508 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229558AbiBCOkI (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 3 Feb 2022 09:40:08 -0500
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0CCAC1EC04C1;
        Thu,  3 Feb 2022 15:40:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1643899203;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=uRkidV9rm70r65t8zRK5LUK617v6jjX8xXx77Av6a7w=;
        b=jxAChagwEN26K+oMim082LNKxapBTumZtbjTBfRVFD5daY/HoWixlnEmKTAc2XEdLJT/gU
        aySeLabM9BOVCerKWItMK/Zad5zUInAVLath7/aGR/VFOb88ZQ2S8iw6kifwf17//YIwtq
        cXY5uMx2JCARDEOueHU8GEBBhBSbMUA=
Date:   Thu, 3 Feb 2022 15:39:58 +0100
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
Subject: Re: [PATCH v9 24/43] x86/compressed/acpi: Move EFI detection to
 helper
Message-ID: <YfvpPowvlz0reOZ/@zn.tnic>
References: <20220128171804.569796-1-brijesh.singh@amd.com>
 <20220128171804.569796-25-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220128171804.569796-25-brijesh.singh@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Jan 28, 2022 at 11:17:45AM -0600, Brijesh Singh wrote:
> diff --git a/arch/x86/boot/compressed/efi.c b/arch/x86/boot/compressed/efi.c
> new file mode 100644
> index 000000000000..daa73efdc7a5
> --- /dev/null
> +++ b/arch/x86/boot/compressed/efi.c
> @@ -0,0 +1,50 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Helpers for early access to EFI configuration table.
> + *
> + * Originally derived from arch/x86/boot/compressed/acpi.c
> + */
> +
> +#include "misc.h"
> +#include <linux/efi.h>
> +#include <asm/efi.h>

Yap, it is includes like that which cause this whole decompressor
include hell. One day...

> +
> +/**
> + * efi_get_type - Given boot_params, determine the type of EFI environment.
> + *
> + * @boot_params:        pointer to boot_params
> + *
> + * Return: EFI_TYPE_{32,64} for valid EFI environments, EFI_TYPE_NONE otherwise.
> + */
> +enum efi_type efi_get_type(struct boot_params *boot_params)

				struct boot_params *bp

> +{
> +	struct efi_info *ei;
> +	enum efi_type et;
> +	const char *sig;
> +
> +	ei = &boot_params->efi_info;
> +	sig = (char *)&ei->efi_loader_signature;
> +
> +	if (!strncmp(sig, EFI64_LOADER_SIGNATURE, 4)) {
> +		et = EFI_TYPE_64;
> +	} else if (!strncmp(sig, EFI32_LOADER_SIGNATURE, 4)) {
> +		et = EFI_TYPE_32;
> +	} else {
> +		debug_putstr("No EFI environment detected.\n");
> +		et = EFI_TYPE_NONE;
> +	}
> +
> +#ifndef CONFIG_X86_64
> +	/*
> +	 * Existing callers like acpi.c treat this case as an indicator to
> +	 * fall-through to non-EFI, rather than an error, so maintain that
> +	 * functionality here as well.
> +	 */
> +	if (ei->efi_systab_hi || ei->efi_memmap_hi) {
> +		debug_putstr("EFI system table is located above 4GB and cannot be accessed.\n");
> +		et = EFI_TYPE_NONE;
> +	}
> +#endif
> +
> +	return et;
> +}
> diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
> index 01cc13c12059..a26244c0fe01 100644
> --- a/arch/x86/boot/compressed/misc.h
> +++ b/arch/x86/boot/compressed/misc.h
> @@ -176,4 +176,20 @@ void boot_stage2_vc(void);
>  
>  unsigned long sev_verify_cbit(unsigned long cr3);
>  
> +enum efi_type {
> +	EFI_TYPE_64,
> +	EFI_TYPE_32,
> +	EFI_TYPE_NONE,
> +};

Haha, EFI folks will be wondering where in the spec that thing is... :-)))

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
