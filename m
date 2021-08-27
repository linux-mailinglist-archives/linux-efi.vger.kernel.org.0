Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D0F73F9A76
	for <lists+linux-efi@lfdr.de>; Fri, 27 Aug 2021 15:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232312AbhH0Nvr (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 27 Aug 2021 09:51:47 -0400
Received: from mail.skyhub.de ([5.9.137.197]:37258 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232257AbhH0Nvq (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 27 Aug 2021 09:51:46 -0400
Received: from zn.tnic (p200300ec2f1117006e0d6268a9fc7b3e.dip0.t-ipconnect.de [IPv6:2003:ec:2f11:1700:6e0d:6268:a9fc:7b3e])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 59FAE1EC0537;
        Fri, 27 Aug 2021 15:50:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1630072252;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=MgcfjTqcSY9gu+zATu+viDfC+xRfq+ze2XUVEcy5kJQ=;
        b=cO0UcApzABFyvPv+e6G4bGRLUXS/CNO2/DFEGytg7MS8u7V43idZQCwPExuB4RZ2dTpRkF
        ZxrfGsWj2Lzr+LOSyR0G1Fy/jCw1vouDlF4GKT7VnZ9xWps8tPd6rZuQft0qi4nHtT/Sfa
        fAPo0aIk+YOA4sfiUsRttbNgb58ivFI=
Date:   Fri, 27 Aug 2021 15:51:29 +0200
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
        Wanpeng Li <wanpengli@tencent.com>,
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
        Andi Kleen <ak@linux.intel.com>, tony.luck@intel.com,
        marcorr@google.com, sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH Part1 v5 29/38] x86/boot: add a pointer to Confidential
 Computing blob in bootparams
Message-ID: <YSjt4YDQR8vDeOdI@zn.tnic>
References: <20210820151933.22401-1-brijesh.singh@amd.com>
 <20210820151933.22401-30-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210820151933.22401-30-brijesh.singh@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Aug 20, 2021 at 10:19:24AM -0500, Brijesh Singh wrote:
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
> This is much of an issue for accessing setup_data, and the EFI config
> table helper code currently used in boot/compressed *could* be used in
> this case as well since they both rely on identity-mapping. However, it
> has some reliance on EFI helpers/string constants that would need to be
> accessed via fixup_pointer(), and fixing it up while making it
> shareable between boot/compressed and run-time kernel is fragile and
> introduces a good bit of uglyness.
> 
> Instead, this patch adds a boot_params->cc_blob_address pointer that

Avoid having "This patch" or "This commit" in the commit message. It is
tautologically useless.

Also, do

$ git grep 'This patch' Documentation/process

for more details.

> boot/compressed can initialize so that the run-time kernel can access
> the prelocated CC blob that way instead.
> 
> Signed-off-by: Michael Roth <michael.roth@amd.com>
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> ---
>  arch/x86/include/asm/bootparam_utils.h | 1 +
>  arch/x86/include/uapi/asm/bootparam.h  | 3 ++-
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/include/asm/bootparam_utils.h b/arch/x86/include/asm/bootparam_utils.h
> index 981fe923a59f..53e9b0620d96 100644
> --- a/arch/x86/include/asm/bootparam_utils.h
> +++ b/arch/x86/include/asm/bootparam_utils.h
> @@ -74,6 +74,7 @@ static void sanitize_boot_params(struct boot_params *boot_params)
>  			BOOT_PARAM_PRESERVE(hdr),
>  			BOOT_PARAM_PRESERVE(e820_table),
>  			BOOT_PARAM_PRESERVE(eddbuf),
> +			BOOT_PARAM_PRESERVE(cc_blob_address),
>  		};
>  
>  		memset(&scratch, 0, sizeof(scratch));
> diff --git a/arch/x86/include/uapi/asm/bootparam.h b/arch/x86/include/uapi/asm/bootparam.h
> index 1ac5acca72ce..bea5cdcdf532 100644
> --- a/arch/x86/include/uapi/asm/bootparam.h
> +++ b/arch/x86/include/uapi/asm/bootparam.h
> @@ -188,7 +188,8 @@ struct boot_params {
>  	__u32 ext_ramdisk_image;			/* 0x0c0 */
>  	__u32 ext_ramdisk_size;				/* 0x0c4 */
>  	__u32 ext_cmd_line_ptr;				/* 0x0c8 */
> -	__u8  _pad4[116];				/* 0x0cc */
> +	__u8  _pad4[112];				/* 0x0cc */
> +	__u32 cc_blob_address;				/* 0x13c */

So I know I've heard grub being mentioned in conjunction with this: if
you are ever going to pass this through the boot loader, then you'd need
to update Documentation/x86/zero-page.rst too to state that this field
can be written by the boot loader too.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
