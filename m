Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C00FE3E568F
	for <lists+linux-efi@lfdr.de>; Tue, 10 Aug 2021 11:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238805AbhHJJRF (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 10 Aug 2021 05:17:05 -0400
Received: from mail.skyhub.de ([5.9.137.197]:51294 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238777AbhHJJQ7 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 10 Aug 2021 05:16:59 -0400
Received: from zn.tnic (p200300ec2f0d65002f77173b43e63b63.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:6500:2f77:173b:43e6:3b63])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 32D221EC01B7;
        Tue, 10 Aug 2021 11:16:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1628586988;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=7e+HGcOHJ96LFGWVJDME/h9ZcJWYWo7cdlDC8qUJl3Y=;
        b=Hyiz6S9AveiAXpd7wTU8ZQM3+2JzRq/DaHuPlGM6Ou7O3jgv8sL12UwwrJ4VIDwUeR4O4e
        8rTFGfeQxlxvrrg48r/pEYoZKC6y5SNfI3wKzdZhG+F/3Q644VAtkWyXNFnTR31GmiYIKZ
        EGsiOkk1vDviIZy1rZDkLdz0L+2ypxY=
Date:   Tue, 10 Aug 2021 11:17:07 +0200
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
Subject: Re: [PATCH Part1 RFC v4 02/36] x86/sev: Save the negotiated GHCB
 version
Message-ID: <YRJEE6C/NC3Epa8G@zn.tnic>
References: <20210707181506.30489-1-brijesh.singh@amd.com>
 <20210707181506.30489-3-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210707181506.30489-3-brijesh.singh@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Jul 07, 2021 at 01:14:32PM -0500, Brijesh Singh wrote:
> diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
> index 114f62fe2529..19c2306ac02d 100644
> --- a/arch/x86/kernel/sev-shared.c
> +++ b/arch/x86/kernel/sev-shared.c
> @@ -14,6 +14,15 @@
>  #define has_cpuflag(f)	boot_cpu_has(f)
>  #endif
>  
> +/*
> + * Since feature negotiation related variables are set early in the boot
> + * process they must reside in the .data section so as not to be zeroed
> + * out when the .bss section is later cleared.
> + *
> + * GHCB protocol version negotiated with the hypervisor.
> + */
> +static u16 ghcb_version __section(".data..ro_after_init");

There's a define for that section specifier: __ro_after_init

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
