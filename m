Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A56403F1679
	for <lists+linux-efi@lfdr.de>; Thu, 19 Aug 2021 11:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236292AbhHSJpi (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 19 Aug 2021 05:45:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232750AbhHSJpi (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 19 Aug 2021 05:45:38 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C410C061575;
        Thu, 19 Aug 2021 02:45:02 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0f6a00d82486aa7bad8753.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:6a00:d824:86aa:7bad:8753])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 77C831EC046C;
        Thu, 19 Aug 2021 11:44:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1629366296;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=uwmNYKgUvDl1MbeSM8Zbb3wFcWRj1jNc+CWB7kbhWHw=;
        b=lfXxT/rKfaIm0ZtPpptiTqf0qCun2SrPQ6oRQQ0UoETMJZABV80vUnbMS9+m6inEZ15Hjp
        bp4UuLvXP3Id5wKidovffjUau1hQYozxYFQHk5JdMNAger0/gwaVe39YAwkH/9RoG7TpS8
        9so/nY/sffmLI3KXVeb2zWHB3XSDeqE=
Date:   Thu, 19 Aug 2021 11:45:35 +0200
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
        brijesh.ksingh@gmail.com
Subject: Re: [PATCH Part1 RFC v4 22/36] x86/sev: move MSR-based VMGEXITs for
 CPUID to helper
Message-ID: <YR4oP+PDnmJbvfKR@zn.tnic>
References: <20210707181506.30489-1-brijesh.singh@amd.com>
 <20210707181506.30489-23-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210707181506.30489-23-brijesh.singh@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Finally drop this bouncing npmccallum at RH email address from the Cc
list.

On Wed, Jul 07, 2021 at 01:14:52PM -0500, Brijesh Singh wrote:
> From: Michael Roth <michael.roth@amd.com>
> 
> This code will also be used later for SEV-SNP-validated CPUID code in
> some cases, so move it to a common helper.
> 
> Signed-off-by: Michael Roth <michael.roth@amd.com>
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> ---
>  arch/x86/kernel/sev-shared.c | 84 +++++++++++++++++++++++++-----------
>  1 file changed, 58 insertions(+), 26 deletions(-)
> 
> diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
> index be4025f14b4f..4884de256a49 100644
> --- a/arch/x86/kernel/sev-shared.c
> +++ b/arch/x86/kernel/sev-shared.c
> @@ -184,6 +184,58 @@ static enum es_result sev_es_ghcb_hv_call(struct ghcb *ghcb,
>  	return ret;
>  }
>  
> +static int sev_es_cpuid_msr_proto(u32 func, u32 subfunc, u32 *eax, u32 *ebx,

Since it is not only SEV-ES, then it should be prefixed with "sev_" like
we do for the other such functions. I guess simply

	sev_cpuid()

?

> +				  u32 *ecx, u32 *edx)
> +{
> +	u64 val;
> +
> +	if (eax) {

What's the protection for? Is it ever going to be called with NULL ptrs
for the regs? That's not the case in this patchset at least...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
