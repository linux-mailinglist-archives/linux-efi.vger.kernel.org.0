Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF5063EB440
	for <lists+linux-efi@lfdr.de>; Fri, 13 Aug 2021 12:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239863AbhHMKrf (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 13 Aug 2021 06:47:35 -0400
Received: from mail.skyhub.de ([5.9.137.197]:35892 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239606AbhHMKrf (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 13 Aug 2021 06:47:35 -0400
Received: from zn.tnic (p200300ec2f0a0d0079874d21390dee82.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:d00:7987:4d21:390d:ee82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CB1E81EC0390;
        Fri, 13 Aug 2021 12:47:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1628851622;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=XmnLEzAhzOr7go9Tws2WK6fpL+x7aLZgyQqDx6MzxiE=;
        b=K7pPLi+l6xsBgICUo31Urs0pNH4asQI3bGtJ3ZL06c0vaRJVCEnWEAirmzYhQYnNvpoBmR
        bC9rrsPLK3gHgK1reXS8f7LGdgNZGiXNBuGJsT8HMbMIG0vRBzPzUijsRpRFIW7P/lbRPP
        MSBF/r3NSFBWWbXBRI4N672W+nm0UBY=
Date:   Fri, 13 Aug 2021 12:47:41 +0200
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
Subject: Re: [PATCH Part1 RFC v4 10/36] x86/compressed: Register GHCB memory
 when SEV-SNP is active
Message-ID: <YRZNzUW/QhG6UYjg@zn.tnic>
References: <20210707181506.30489-1-brijesh.singh@amd.com>
 <20210707181506.30489-11-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210707181506.30489-11-brijesh.singh@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Jul 07, 2021 at 01:14:40PM -0500, Brijesh Singh wrote:
> diff --git a/arch/x86/include/asm/sev-common.h b/arch/x86/include/asm/sev-common.h
> index aee07d1bb138..b19d8d301f5d 100644
> --- a/arch/x86/include/asm/sev-common.h
> +++ b/arch/x86/include/asm/sev-common.h
> @@ -45,6 +45,17 @@
>  		(((unsigned long)reg & GHCB_MSR_CPUID_REG_MASK) << GHCB_MSR_CPUID_REG_POS) | \
>  		(((unsigned long)fn) << GHCB_MSR_CPUID_FUNC_POS))
>  
> +/* GHCB GPA Register */
> +#define GHCB_MSR_GPA_REG_REQ		0x012
> +#define GHCB_MSR_GPA_REG_VALUE_POS	12
> +#define GHCB_MSR_GPA_REG_GFN_MASK	GENMASK_ULL(51, 0)
> +#define GHCB_MSR_GPA_REQ_GFN_VAL(v)		\
> +	(((unsigned long)((v) & GHCB_MSR_GPA_REG_GFN_MASK) << GHCB_MSR_GPA_REG_VALUE_POS)| \
> +	GHCB_MSR_GPA_REG_REQ)
> +
> +#define GHCB_MSR_GPA_REG_RESP		0x013
> +#define GHCB_MSR_GPA_REG_RESP_VAL(v)	((v) >> GHCB_MSR_GPA_REG_VALUE_POS)

Simplify...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
