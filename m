Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F09E83A629C
	for <lists+linux-efi@lfdr.de>; Mon, 14 Jun 2021 13:00:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234147AbhFNLCb (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 14 Jun 2021 07:02:31 -0400
Received: from mail.skyhub.de ([5.9.137.197]:49150 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235206AbhFNLA1 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 14 Jun 2021 07:00:27 -0400
Received: from zn.tnic (p200300ec2f09b9002609baded98d03dc.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:b900:2609:bade:d98d:3dc])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A0E761EC0473;
        Mon, 14 Jun 2021 12:58:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1623668302;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=SYW7clEcJZWCOyB/bISVVphg+MXaT1CFPerY1hqPLzw=;
        b=MWGgDm8baSNQ8T2XWCwE2vT7V1qzuf/nlGCI2H1oXH+eq9im62KqpOIArNcX+tMX12COYd
        XG9hBXjEXfyJyXL4o7HopQ7BaOuKofQh7qnu7ySAJix2e+FKOOI/Qq4rsMO4XE2FTtl/UF
        BzCXdMz28mmTrQXsoHPyEgJ75mtprEc=
Date:   Mon, 14 Jun 2021 12:58:15 +0200
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
Subject: Re: [PATCH Part1 RFC v3 16/22] KVM: SVM: Create a separate mapping
 for the SEV-ES save area
Message-ID: <YMc2R4JRZ3yFffy/@zn.tnic>
References: <20210602140416.23573-1-brijesh.singh@amd.com>
 <20210602140416.23573-17-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210602140416.23573-17-brijesh.singh@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Jun 02, 2021 at 09:04:10AM -0500, Brijesh Singh wrote:
> +/* Save area definition for SEV-ES and SEV-SNP guests */
> +struct sev_es_save_area {

Can we agree on a convention here to denote SEV-ES and later
variants VS earlier ones so that you don't have "SEV-ES" in the name
sev_es_save_area but to mean that this applies to SNP and future stuff
too?

What about SEV-only guests? I'm assuming those use the old variant.

Which would mean you can call this

struct prot_guest_save_area

or so, so that it doesn't have "sev" in the name and so that there's no
confusion...

Ditto for the size defines.

> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index 5bc887e9a986..d93a1c368b61 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -542,12 +542,20 @@ static int sev_launch_update_data(struct kvm *kvm, struct kvm_sev_cmd *argp)
>  
>  static int sev_es_sync_vmsa(struct vcpu_svm *svm)

Not SEV-ES only anymore, so I guess sev_snp_sync_vmca() or so.

> -	struct vmcb_save_area *save = &svm->vmcb->save;
> +	struct sev_es_save_area *save = svm->vmsa;
>  
>  	/* Check some debug related fields before encrypting the VMSA */
> -	if (svm->vcpu.guest_debug || (save->dr7 & ~DR7_FIXED_1))
> +	if (svm->vcpu.guest_debug || (svm->vmcb->save.dr7 & ~DR7_FIXED_1))
>  		return -EINVAL;
>  
> +	/*
> +	 * SEV-ES will use a VMSA that is pointed to by the VMCB, not
> +	 * the traditional VMSA that is part of the VMCB. Copy the
> +	 * traditional VMSA as it has been built so far (in prep
> +	 * for LAUNCH_UPDATE_VMSA) to be the initial SEV-ES state.

Ditto - nomenclature.

> +	 */
> +	memcpy(save, &svm->vmcb->save, sizeof(svm->vmcb->save));
> +
>  	/* Sync registgers */
		^^^^^^^^^^

typo. Might as well fix while at it.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
