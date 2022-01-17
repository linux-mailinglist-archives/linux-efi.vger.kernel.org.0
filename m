Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7553491020
	for <lists+linux-efi@lfdr.de>; Mon, 17 Jan 2022 19:14:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242346AbiAQSOq (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 17 Jan 2022 13:14:46 -0500
Received: from mail.skyhub.de ([5.9.137.197]:44528 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242361AbiAQSOh (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 17 Jan 2022 13:14:37 -0500
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D6CE41EC0531;
        Mon, 17 Jan 2022 19:14:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1642443272;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=bouPhsb4Ue1P9gCaopOfeEfpi1LBOvsEfL0wKx1nnuk=;
        b=mDoYwot/tXbqF6HF3Eu6cgDT6nKVaWMYS+m75E3dH7UqGWyU+ILZraeWnwVupdo2hXXsSv
        CRboS7T6LEo6JUkcCReWZM71LVGGJh7z2/0DIx9hY/4FpODkKkG830gFgc7uUkpKE4PNdb
        PzOQlEGzxt7kiupVj6JTD7J4vw9UsL4=
Date:   Mon, 17 Jan 2022 19:14:34 +0100
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
Subject: Re: [PATCH v8 30/40] x86/boot: add a pointer to Confidential
 Computing blob in bootparams
Message-ID: <YeWyCtr11rL7dxpT@zn.tnic>
References: <20211210154332.11526-1-brijesh.singh@amd.com>
 <20211210154332.11526-31-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211210154332.11526-31-brijesh.singh@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Dec 10, 2021 at 09:43:22AM -0600, Brijesh Singh wrote:
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
>  	struct edid_info edid_info;			/* 0x140 */
>  	struct efi_info efi_info;			/* 0x1c0 */
>  	__u32 alt_mem_k;				/* 0x1e0 */

Yes, you said that this is a boot/compressed stage -> kernel proper info
pass field but let's document it anyway, please, and say what it is,
just like:

	1E4/004         ALL     scratch                 Scratch field for the kernel setup code

is documented, for example.

And now that I look at it, acpi_rsdp_addr isn't documented either so if
you wanna add it too, while you're at it, that would be nice.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
