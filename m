Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B44E3EB158
	for <lists+linux-efi@lfdr.de>; Fri, 13 Aug 2021 09:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239361AbhHMHZu (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 13 Aug 2021 03:25:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbhHMHZt (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 13 Aug 2021 03:25:49 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 521B8C061756;
        Fri, 13 Aug 2021 00:25:22 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0a0d00146e00bd62432576.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:d00:146e:bd:6243:2576])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BD9B61EC0502;
        Fri, 13 Aug 2021 09:25:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1628839515;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nmXWc9Mx9goU+spJZe7CxGWS9UU2OCWKW5H4SIieayM=;
        b=YzhQynmWvBYmCnTxz52HlGAcyETIX4lCAmHip19viBHA47bWQM34G1oyUksbAyP47NXuGy
        fbDAoaWjtaE7Gdv+1KkneUSRpCVtePRPFqO32TIFPpxaCuCanybmK+pAl9SZP0WvHYc0vk
        6QIdMtDry0XYn2lNKza17EYBAYV1CHM=
Date:   Fri, 13 Aug 2021 09:25:54 +0200
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
Subject: Re: [PATCH Part1 RFC v4 08/36] x86/sev: check the vmpl level
Message-ID: <YRYegqsigZfrbFbk@zn.tnic>
References: <20210707181506.30489-1-brijesh.singh@amd.com>
 <20210707181506.30489-9-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210707181506.30489-9-brijesh.singh@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Jul 07, 2021 at 01:14:38PM -0500, Brijesh Singh wrote:
> Virtual Machine Privilege Level (VMPL) is an optional feature in the
> SEV-SNP architecture, which allows a guest VM to divide its address space
> into four levels. The level can be used to provide the hardware isolated
> abstraction layers with a VM. The VMPL0 is the highest privilege, and
> VMPL3 is the least privilege. Certain operations must be done by the VMPL0
> software, such as:
> 
> * Validate or invalidate memory range (PVALIDATE instruction)
> * Allocate VMSA page (RMPADJUST instruction when VMSA=1)
> 
> The initial SEV-SNP support assumes that the guest kernel is running on
> VMPL0. Let's add a check to make sure that kernel is running at VMPL0
> before continuing the boot. There is no easy method to query the current
> VMPL level, so use the RMPADJUST instruction to determine whether its
> booted at the VMPL0.
> 
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> ---
>  arch/x86/boot/compressed/sev.c    | 41 ++++++++++++++++++++++++++++---
>  arch/x86/include/asm/sev-common.h |  1 +
>  arch/x86/include/asm/sev.h        |  3 +++
>  3 files changed, 42 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
> index 7be325d9b09f..2f3081e9c78c 100644
> --- a/arch/x86/boot/compressed/sev.c
> +++ b/arch/x86/boot/compressed/sev.c
> @@ -134,6 +134,36 @@ static inline bool sev_snp_enabled(void)
>  	return msr_sev_status & MSR_AMD64_SEV_SNP_ENABLED;
>  }
>  
> +static bool is_vmpl0(void)
> +{
> +	u64 attrs, va;
> +	int err;
> +
> +	/*
> +	 * There is no straightforward way to query the current VMPL level. The

So this is not nice at all.

And this VMPL level checking can't be part of the GHCB MSR protocol
because the HV can tell us any VPML level it wants to.

Is there a way to disable VMPL levels and say, this guest should run
only at VMPL0?

Err, I see SYSCFG[VMPLEn]:

"VMPLEn. Bit 25. Setting this bit to 1 enables the VMPL feature (Section
15.36.7 “Virtual Machine Privilege Levels,” on page 580). Software
should set this bit to 1 when SecureNestedPagingEn is being set to 1.
Once SecureNestedPagingEn is set to 1, VMPLEn cannot be changed."

But why should that bit be set if SNP is enabled? Can I run a SNP guest
without VPMLs, i.e, at an implicit VPML level 0?

It says above VPML is optional...

Also, why do you even need to do this at all since the guest controls
and validates its memory with the RMP? It can simply go and check the
VMPLs of every page it owns to make sure it is 0.

Also, if you really wanna support guests with multiple VMPLs, then
prevalidating its memory is going to be a useless exercise because it'll
have to go and revalidate the VMPL levels...

I also see this:

"When the hypervisor assigns a page to a guest using RMPUPDATE, full
permissions are enabled for VMPL0 and are disabled for all other VMPLs."

so you get your memory at VMPL0 by the HV. So what is that check for?

Questions over questions, I'm sure I'm missing an aspect.

> +	 * simplest method is to use the RMPADJUST instruction to change a page
> +	 * permission to a VMPL level-1, and if the guest kernel is launched at
> +	 * at a level <= 1, then RMPADJUST instruction will return an error.


WARNING: Possible repeated word: 'at'
#156: FILE: arch/x86/boot/compressed/sev.c:146:
+        * permission to a VMPL level-1, and if the guest kernel is launched at
+        * at a level <= 1, then RMPADJUST instruction will return an error.


How many times do I have to say:

Please integrate scripts/checkpatch.pl into your patch creation
workflow. Some of the warnings/errors *actually* make sense.

?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
