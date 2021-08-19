Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BD083F17AB
	for <lists+linux-efi@lfdr.de>; Thu, 19 Aug 2021 13:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238506AbhHSLGK (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 19 Aug 2021 07:06:10 -0400
Received: from mail.skyhub.de ([5.9.137.197]:47074 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238480AbhHSLGI (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 19 Aug 2021 07:06:08 -0400
Received: from zn.tnic (p200300ec2f0f6a00d82486aa7bad8753.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:6a00:d824:86aa:7bad:8753])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D5FDA1EC0493;
        Thu, 19 Aug 2021 13:05:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1629371124;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=qYeEdAdRBAT5O+WdbHDpuPXSfRMndL3DIZs7pWBioVc=;
        b=q6r7R7vGlQf+ERAX7mscYkzVq0uRzGz45F6etud3utGOg3RinTBSMuc9Xmj+EyMbchdzZO
        OOVFQf0HdzhwssWUvLfAuwvfVdrZMjXAy6Z/POiHVxuPTMHpHUpzS1w8HmUQYCKCreGb4v
        cKiOJUGGGE7qp4uR8n7/adWYgLRm8vo=
Date:   Thu, 19 Aug 2021 13:06:08 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Brijesh Singh <brijesh.singh@amd.com>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        linux-crypto@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
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
        Vlastimil Babka <vbabka@suse.cz>, tony.luck@intel.com,
        brijesh.ksingh@gmail.com
Subject: Re: [PATCH Part1 RFC v4 25/36] x86/boot: Add Confidential Computing
 type to setup_data
Message-ID: <YR47IEALXIvAGmy8@zn.tnic>
References: <20210707181506.30489-1-brijesh.singh@amd.com>
 <20210707181506.30489-26-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210707181506.30489-26-brijesh.singh@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

(Moving Ard to To: for the EFI bits)

On Wed, Jul 07, 2021 at 01:14:55PM -0500, Brijesh Singh wrote:
> While launching the encrypted guests, the hypervisor may need to provide
> some additional information during the guest boot. When booting under the
> EFI based BIOS, the EFI configuration table contains an entry for the
> confidential computing blob that contains the required information.
> 
> To support booting encrypted guests on non-EFI VM, the hypervisor needs to
> pass this additional information to the kernel with a different method.
> 
> For this purpose, introduce SETUP_CC_BLOB type in setup_data to hold the
> physical address of the confidential computing blob location. The boot
> loader or hypervisor may choose to use this method instead of EFI
> configuration table. The CC blob location scanning should give preference
> to setup_data data over the EFI configuration table.
> 
> In AMD SEV-SNP, the CC blob contains the address of the secrets and CPUID
> pages. The secrets page includes information such as a VM to PSP
> communication key and CPUID page contains PSP filtered CPUID values.
> Define the AMD SEV confidential computing blob structure.
> 
> While at it, define the EFI GUID for the confidential computing blob.
> 
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> ---
>  arch/x86/include/asm/sev.h            | 12 ++++++++++++
>  arch/x86/include/uapi/asm/bootparam.h |  1 +
>  include/linux/efi.h                   |  1 +
>  3 files changed, 14 insertions(+)
> 
> diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
> index f68c9e2c3851..e41bd55dba5d 100644
> --- a/arch/x86/include/asm/sev.h
> +++ b/arch/x86/include/asm/sev.h
> @@ -44,6 +44,18 @@ struct es_em_ctxt {
>  
>  void do_vc_no_ghcb(struct pt_regs *regs, unsigned long exit_code);
>  
> +/* AMD SEV Confidential computing blob structure */
> +#define CC_BLOB_SEV_HDR_MAGIC	0x45444d41
> +struct cc_blob_sev_info {
> +	u32 magic;
> +	u16 version;
> +	u16 reserved;
> +	u64 secrets_phys;
> +	u32 secrets_len;
> +	u64 cpuid_phys;
> +	u32 cpuid_len;
> +};
> +
>  static inline u64 lower_bits(u64 val, unsigned int bits)
>  {
>  	u64 mask = (1ULL << bits) - 1;
> diff --git a/arch/x86/include/uapi/asm/bootparam.h b/arch/x86/include/uapi/asm/bootparam.h
> index b25d3f82c2f3..1ac5acca72ce 100644
> --- a/arch/x86/include/uapi/asm/bootparam.h
> +++ b/arch/x86/include/uapi/asm/bootparam.h
> @@ -10,6 +10,7 @@
>  #define SETUP_EFI			4
>  #define SETUP_APPLE_PROPERTIES		5
>  #define SETUP_JAILHOUSE			6
> +#define SETUP_CC_BLOB			7
>  
>  #define SETUP_INDIRECT			(1<<31)
>  
> diff --git a/include/linux/efi.h b/include/linux/efi.h
> index 6b5d36babfcc..75aeb2a56888 100644
> --- a/include/linux/efi.h
> +++ b/include/linux/efi.h
> @@ -344,6 +344,7 @@ void efi_native_runtime_setup(void);
>  #define EFI_CERT_SHA256_GUID			EFI_GUID(0xc1c41626, 0x504c, 0x4092, 0xac, 0xa9, 0x41, 0xf9, 0x36, 0x93, 0x43, 0x28)
>  #define EFI_CERT_X509_GUID			EFI_GUID(0xa5c059a1, 0x94e4, 0x4aa7, 0x87, 0xb5, 0xab, 0x15, 0x5c, 0x2b, 0xf0, 0x72)
>  #define EFI_CERT_X509_SHA256_GUID		EFI_GUID(0x3bd2a492, 0x96c0, 0x4079, 0xb4, 0x20, 0xfc, 0xf9, 0x8e, 0xf1, 0x03, 0xed)
> +#define EFI_CC_BLOB_GUID			EFI_GUID(0x067b1f5f, 0xcf26, 0x44c5, 0x85, 0x54, 0x93, 0xd7, 0x77, 0x91, 0x2d, 0x42)
>  
>  /*
>   * This GUID is used to pass to the kernel proper the struct screen_info
> -- 
> 2.17.1
> 

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
