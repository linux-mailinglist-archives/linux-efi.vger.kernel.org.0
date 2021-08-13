Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C06B3EB3F1
	for <lists+linux-efi@lfdr.de>; Fri, 13 Aug 2021 12:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239792AbhHMKWx (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 13 Aug 2021 06:22:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239357AbhHMKWx (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 13 Aug 2021 06:22:53 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD161C0617AD;
        Fri, 13 Aug 2021 03:22:26 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0a0d0079874d21390dee82.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:d00:7987:4d21:390d:ee82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 179861EC0390;
        Fri, 13 Aug 2021 12:22:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1628850141;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=BrEpox4JFTOv//FkK1+++liPSNoSwrYzYIAmzeG1Vvg=;
        b=rrhY/wFPs01PzwPngi2OvYsBOn3Oj+mOPU4ppqg2QD3QMMpo5HPrRQksILGK2tbPzMNL/P
        /Z+q2NCpFwOZGLfgdVjlJd5AbybcSaH0RK4p4eLjvedsqwEIBCnfou68aXrXhezqElb99A
        CyzdpLOPT9knQnU7SkvRJRi/bsKl6e0=
Date:   Fri, 13 Aug 2021 12:22:59 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Brijesh Singh <brijesh.singh@amd.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        linux-crypto@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
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
        Vlastimil Babka <vbabka@suse.cz>, tony.luck@intel.com,
        npmccallum@redhat.com, brijesh.ksingh@gmail.com
Subject: Re: [PATCH Part1 RFC v4 09/36] x86/compressed: Add helper for
 validating pages in the decompression stage
Message-ID: <YRZIA+qQ7EpO0zxC@zn.tnic>
References: <20210707181506.30489-1-brijesh.singh@amd.com>
 <20210707181506.30489-10-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210707181506.30489-10-brijesh.singh@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Jul 07, 2021 at 01:14:39PM -0500, Brijesh Singh wrote:
> @@ -274,16 +274,31 @@ static int set_clr_page_flags(struct x86_mapping_info *info,
>  	/*
>  	 * Changing encryption attributes of a page requires to flush it from
>  	 * the caches.
> +	 *
> +	 * If the encryption attribute is being cleared, then change the page
> +	 * state to shared in the RMP table.

That comment...

>  	 */
> -	if ((set | clr) & _PAGE_ENC)
> +	if ((set | clr) & _PAGE_ENC) {
>  		clflush_page(address);
>  

... goes here:

<---

> +		if (clr)
> +			snp_set_page_shared(pte_pfn(*ptep) << PAGE_SHIFT);
> +	}
> +

...

> diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
> index 2f3081e9c78c..f386d45a57b6 100644
> --- a/arch/x86/boot/compressed/sev.c
> +++ b/arch/x86/boot/compressed/sev.c
> @@ -164,6 +164,47 @@ static bool is_vmpl0(void)
>  	return true;
>  }
>  
> +static void __page_state_change(unsigned long paddr, int op)

That op should be:

enum psc_op {
	SNP_PAGE_STATE_SHARED,
	SNP_PAGE_STATE_PRIVATE,
};

and have

static void __page_state_change(unsigned long paddr, enum psc_op op)

so that the compiler can check you're at least passing from the correct
set of defines.

> diff --git a/arch/x86/include/asm/sev-common.h b/arch/x86/include/asm/sev-common.h
> index ea508835ab33..aee07d1bb138 100644
> --- a/arch/x86/include/asm/sev-common.h
> +++ b/arch/x86/include/asm/sev-common.h
> @@ -45,6 +45,23 @@
>  		(((unsigned long)reg & GHCB_MSR_CPUID_REG_MASK) << GHCB_MSR_CPUID_REG_POS) | \
>  		(((unsigned long)fn) << GHCB_MSR_CPUID_FUNC_POS))
>  
> +/* SNP Page State Change */
> +#define GHCB_MSR_PSC_REQ		0x014
> +#define SNP_PAGE_STATE_PRIVATE		1
> +#define SNP_PAGE_STATE_SHARED		2
> +#define GHCB_MSR_PSC_GFN_POS		12
> +#define GHCB_MSR_PSC_GFN_MASK		GENMASK_ULL(39, 0)
> +#define GHCB_MSR_PSC_OP_POS		52
> +#define GHCB_MSR_PSC_OP_MASK		0xf
> +#define GHCB_MSR_PSC_REQ_GFN(gfn, op)	\
> +	(((unsigned long)((op) & GHCB_MSR_PSC_OP_MASK) << GHCB_MSR_PSC_OP_POS) | \
> +	((unsigned long)((gfn) & GHCB_MSR_PSC_GFN_MASK) << GHCB_MSR_PSC_GFN_POS) | \
> +	GHCB_MSR_PSC_REQ)
> +
> +#define GHCB_MSR_PSC_RESP		0x015
> +#define GHCB_MSR_PSC_ERROR_POS		32
> +#define GHCB_MSR_PSC_RESP_VAL(val)	((val) >> GHCB_MSR_PSC_ERROR_POS)
> +

Also get rid of eccessive defines...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
