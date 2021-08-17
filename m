Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 230F03EF120
	for <lists+linux-efi@lfdr.de>; Tue, 17 Aug 2021 19:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232481AbhHQRyQ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 17 Aug 2021 13:54:16 -0400
Received: from mail.skyhub.de ([5.9.137.197]:43338 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232269AbhHQRyQ (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 17 Aug 2021 13:54:16 -0400
Received: from zn.tnic (p200300ec2f1175006a73053df3c19379.dip0.t-ipconnect.de [IPv6:2003:ec:2f11:7500:6a73:53d:f3c1:9379])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 12A701EC0556;
        Tue, 17 Aug 2021 19:53:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1629222817;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=9YhchVyIcsDaAhUigRbhBjjMCzGVipKM+7D5W0iai2I=;
        b=lYNoN8O/qALtu2PA7aBsqs1V+rteOtAvCOBgTc5LuS592hBcYmEfdnfbNBIjk5EDDnyK7K
        C+f4k8WALE+8KPyRDU9eU66Nso5Y7ivjj7IA7+xFeW9LkEp695k0ivFKIiO2OOjVJxtgq2
        N+aHENE5rOCq4n8EaI97HVYtcVEqFcA=
Date:   Tue, 17 Aug 2021 19:54:15 +0200
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
Subject: Re: [PATCH Part1 RFC v4 16/36] KVM: SVM: define new SEV_FEATURES
 field in the VMCB Save State Area
Message-ID: <YRv3x/JeNjcJ4E8a@zn.tnic>
References: <20210707181506.30489-1-brijesh.singh@amd.com>
 <20210707181506.30489-17-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210707181506.30489-17-brijesh.singh@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Jul 07, 2021 at 01:14:46PM -0500, Brijesh Singh wrote:
> The hypervisor uses the SEV_FEATURES field (offset 3B0h) in the Save State
> Area to control the SEV-SNP guest features such as SNPActive, vTOM,
> ReflectVC etc. An SEV-SNP guest can read the SEV_FEATURES fields through
> the SEV_STATUS MSR.
> 
> While at it, update the dump_vmcb() to log the VMPL level.
> 
> See APM2 Table 15-34 and B-4 for more details.
> 
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> ---
>  arch/x86/include/asm/svm.h | 15 +++++++++++++--
>  arch/x86/kvm/svm/svm.c     |  4 ++--
>  2 files changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/include/asm/svm.h b/arch/x86/include/asm/svm.h
> index 772e60efe243..ff614cdcf628 100644
> --- a/arch/x86/include/asm/svm.h
> +++ b/arch/x86/include/asm/svm.h
> @@ -212,6 +212,15 @@ struct __attribute__ ((__packed__)) vmcb_control_area {
>  #define SVM_NESTED_CTL_SEV_ENABLE	BIT(1)
>  #define SVM_NESTED_CTL_SEV_ES_ENABLE	BIT(2)
>  
> +#define SVM_SEV_FEATURES_SNP_ACTIVE		BIT(0)
> +#define SVM_SEV_FEATURES_VTOM			BIT(1)
> +#define SVM_SEV_FEATURES_REFLECT_VC		BIT(2)
> +#define SVM_SEV_FEATURES_RESTRICTED_INJECTION	BIT(3)
> +#define SVM_SEV_FEATURES_ALTERNATE_INJECTION	BIT(4)
> +#define SVM_SEV_FEATURES_DEBUG_SWAP		BIT(5)
> +#define SVM_SEV_FEATURES_PREVENT_HOST_IBS	BIT(6)
> +#define SVM_SEV_FEATURES_BTB_ISOLATION		BIT(7)

Only some of those get used and only later. Please introduce only those
with the patch that adds usage.

Also,

s/SVM_SEV_FEATURES_/SVM_SEV_FEAT_/g

at least.

And by the way, why is this patch and the next 3 part of the guest set?
They look like they belong into the hypervisor set.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
