Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A64C03A1C51
	for <lists+linux-efi@lfdr.de>; Wed,  9 Jun 2021 19:47:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231770AbhFIRtA (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 9 Jun 2021 13:49:00 -0400
Received: from mail.skyhub.de ([5.9.137.197]:43442 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231670AbhFIRs7 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 9 Jun 2021 13:48:59 -0400
Received: from zn.tnic (p200300ec2f0cf6007c78e5fe5429f9b4.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:f600:7c78:e5fe:5429:f9b4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1E6531EC0570;
        Wed,  9 Jun 2021 19:47:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1623260823;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=wSATXOOyGt9i64iSiH+y4PdoutUxKH/Ox+6Sp2p3E6I=;
        b=OhU591mPW3/AXQerpYOAsiWAncFI3bpSWloN5ZmmzLW/XQj8K6WqVZrg415AJ4V78a3RaH
        ChWB6TW6rGbokkHZ787rQUOFcjBM6xeABnr82utwiuyzMnpTga0VJe8odXUKUr80pNY/HV
        pItHvwa38FQL5ylBZ/Rb1GVajBKE8Ds=
Date:   Wed, 9 Jun 2021 19:47:02 +0200
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
        David Rientjes <rientjes@google.com>, tony.luck@intel.com,
        npmccallum@redhat.com
Subject: Re: [PATCH Part1 RFC v3 09/22] x86/compressed: Register GHCB memory
 when SEV-SNP is active
Message-ID: <YMD+lpyZfYgekRsj@zn.tnic>
References: <20210602140416.23573-1-brijesh.singh@amd.com>
 <20210602140416.23573-10-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210602140416.23573-10-brijesh.singh@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Jun 02, 2021 at 09:04:03AM -0500, Brijesh Singh wrote:
> diff --git a/arch/x86/include/asm/sev-common.h b/arch/x86/include/asm/sev-common.h
> index 1424b8ffde0b..ae99a8a756fe 100644
> --- a/arch/x86/include/asm/sev-common.h
> +++ b/arch/x86/include/asm/sev-common.h
> @@ -75,6 +75,17 @@
>  #define GHCB_MSR_PSC_ERROR_POS		32
>  #define GHCB_MSR_PSC_RESP_VAL(val)	((val) >> GHCB_MSR_PSC_ERROR_POS)
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
> +

Can we pls pay attention to having those REQuests sorted by their
number, like in the GHCB spec, for faster finding?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
