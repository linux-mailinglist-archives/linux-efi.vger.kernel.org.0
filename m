Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 232EB3CBC9A
	for <lists+linux-efi@lfdr.de>; Fri, 16 Jul 2021 21:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232839AbhGPTeb (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 16 Jul 2021 15:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232792AbhGPTea (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 16 Jul 2021 15:34:30 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60463C061765
        for <linux-efi@vger.kernel.org>; Fri, 16 Jul 2021 12:31:34 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id y4so9740697pfi.9
        for <linux-efi@vger.kernel.org>; Fri, 16 Jul 2021 12:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/hHZcYMza7NE4Psi5qcc23pedu+uGbkYbTmPoTjnedM=;
        b=BN12JV2QP6xeOYm+P7hOWRg91H97OO5pAZkKmHIYIuBIsE6PXqOVX7aRlVHXE+qBaj
         jJsjE1orHInfKykBM3svTQcefVtGB158y9NKaAtpTnV2FoHRr0MElSWAxuo65Dyp+b5T
         VSYqHWDHjILxcboknF11CscuZbazyHg4SrSNNazKexI2pjjaz7dlJLS9L3JomRvDK4DZ
         4NChiXc+J8PrnRle1d+qfVMEaxEBnB08RcOA/+rXxoNxfQyOBCpaxai418Ls7VTz1/hZ
         yrp4XyPno2exnVEcQ4oP8W1q6dCyvwk7MDe+/6l2RkOTxbT5ZO/dKqe4MwDga+yEqmdl
         /P1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/hHZcYMza7NE4Psi5qcc23pedu+uGbkYbTmPoTjnedM=;
        b=Fz3imwVdnqDq9KJ4hn+EiE7bLkONHTKfRrzQUaGZingLqJml3dCfCLXaS25yRmhY+E
         LcLnER5ujelbUPe6OzOTUMV9dRJaJ68OxdNcaMNeoQcJNGZvdTRmQAQ6fptn+e9vMp+P
         Rjex8LZYnjiy0xHxgbVyVLmRK9w2/PPFokV1gIViqh7w3Z1J9RKU6LcIGzvR6P4ILbhv
         mTZzXvy4Lfnu13d216aDfqGX1vjVsFc4ecnzkBzZW5/wHkm+mSG7A5xHtr5hQ9okPLp0
         nrMlAhfvMd9O+2DfHdYs/uAc+Ya/WgkkG5L1foJzWYbI8Yo52Tss6geJec1GNcDn+/eW
         bD3w==
X-Gm-Message-State: AOAM531x4ROpD8E+pSaWwTLyosRNWAcf9+oBGIn5CPdjY/1ldfzH73pI
        9a5XGoflx8qyVEqjBdJFHQpDmw==
X-Google-Smtp-Source: ABdhPJw/Tl6imvxSRs9HdGQZlRO+Ko27yJBuT5jRtOwEVQDmy165qXol9Cy0ASigSmkGWdJ7jWp16w==
X-Received: by 2002:a65:450d:: with SMTP id n13mr11562222pgq.13.1626463893304;
        Fri, 16 Jul 2021 12:31:33 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id v7sm3142968pjk.37.2021.07.16.12.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 12:31:32 -0700 (PDT)
Date:   Fri, 16 Jul 2021 19:31:29 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Brijesh Singh <brijesh.singh@amd.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        linux-crypto@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
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
        Borislav Petkov <bp@alien8.de>,
        Michael Roth <michael.roth@amd.com>,
        Vlastimil Babka <vbabka@suse.cz>, tony.luck@intel.com,
        npmccallum@redhat.com, brijesh.ksingh@gmail.com
Subject: Re: [PATCH Part2 RFC v4 21/40] KVM: SVM: Add initial SEV-SNP support
Message-ID: <YPHekXKC/XhWYlZE@google.com>
References: <20210707183616.5620-1-brijesh.singh@amd.com>
 <20210707183616.5620-22-brijesh.singh@amd.com>
 <YPHJOmUOR65QY+YY@google.com>
 <ae47ae6b-16b1-f282-38d5-429d813243a8@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae47ae6b-16b1-f282-38d5-429d813243a8@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Jul 16, 2021, Brijesh Singh wrote:
> 
> On 7/16/21 1:00 PM, Sean Christopherson wrote:
> > On Wed, Jul 07, 2021, Brijesh Singh wrote:
> >> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> >> index 411ed72f63af..abca2b9dee83 100644
> >> --- a/arch/x86/kvm/svm/sev.c
> >> +++ b/arch/x86/kvm/svm/sev.c
> >> @@ -52,9 +52,14 @@ module_param_named(sev, sev_enabled, bool, 0444);
> >>  /* enable/disable SEV-ES support */
> >>  static bool sev_es_enabled = true;
> >>  module_param_named(sev_es, sev_es_enabled, bool, 0444);
> >> +
> >> +/* enable/disable SEV-SNP support */
> >> +static bool sev_snp_enabled = true;
> > Is it safe to incrementally introduce SNP support?  Or should the module param
> > be hidden until all support is in place?  E.g. what will happen when KVM allows
> > userspace to create SNP guests but doesn't yet have the RMP management added?
> 
> The SNP support depends on the RMP management. At least the patch
> ordering in this series adds the RMP management first then updates
> drivers to use the RMP specific APIs.

Yep, got that.

> If RMP is not initialized due to someone not picking the commits in the
> order, then SNP guest creation will fail.

That's not what I was asking.  My question is if KVM will break/fail if someone
runs a KVM build with SNP enabled halfway through the series.  E.g. if I make a
KVM build at patch 22, "KVM: SVM: Add KVM_SNP_INIT command", what will happen if
I attempt to launch an SNP guest?  Obviously it won't fully succeed, but will KVM
fail gracefully and do all the proper cleanup?  Repeat the question for all patches
between this one and the final patch of the series.

SNP simply not working is ok, but if KVM explodes or does weird things without
"full" SNP support, then at minimum the module param should be off by default
until it's safe to enable.  E.g. for the TDP MMU, I believe the approach was to
put all the machinery in place but not actually let userspace flip on the module
param until the full implementation was ready.  Bisecting and testing the
individual commits is a bit painful because it requires modifying KVM code, but
on the plus side unrelated bisects won't stumble into a half-baked state.

> >> +module_param_named(sev_snp, sev_snp_enabled, bool, 0444);
> >>  #else
> >>  #define sev_enabled false
> >>  #define sev_es_enabled false
> >> +#define sev_snp_enabled  false
> >>  #endif /* CONFIG_KVM_AMD_SEV */
> >>  
> >>  #define AP_RESET_HOLD_NONE		0
> >> @@ -1825,6 +1830,7 @@ void __init sev_hardware_setup(void)
> >>  {
> >>  #ifdef CONFIG_KVM_AMD_SEV
> >>  	unsigned int eax, ebx, ecx, edx, sev_asid_count, sev_es_asid_count;
> >> +	bool sev_snp_supported = false;
> >>  	bool sev_es_supported = false;
> >>  	bool sev_supported = false;
> >>  
> >> @@ -1888,9 +1894,21 @@ void __init sev_hardware_setup(void)
> >>  	pr_info("SEV-ES supported: %u ASIDs\n", sev_es_asid_count);
> >>  	sev_es_supported = true;
> >>  
> >> +	/* SEV-SNP support requested? */
> >> +	if (!sev_snp_enabled)
> >> +		goto out;
> >> +
> >> +	/* Is SEV-SNP enabled? */
> >> +	if (!cpu_feature_enabled(X86_FEATURE_SEV_SNP))
> > Random question, why use cpu_feature_enabled?  Did something change in cpufeatures
> > that prevents using boot_cpu_has() here?
> 
> 
> During the boot the kernel initialize the RMP table. If RMP table
> initialization fail, then X86_FEATURE_SEV_SNP is cleared. In that case,
> the cpu_feature_enabled() should return false. The idea is,
> cpu_feature_enabled() will be set only when the RMP table is
> successfully initialized and SYSCFG.SNP is set.

Ya, got that, but again not what I was asking :-)  Why use cpu_feature_enabled()
instead of boot_cpu_has()?  As a random developer, I would fully expect that
boot_cpu_has(X86_FEATURE_SEV_SNP) is true iff SNP is fully enabled by the kernel.

> >> +		goto out;
> >> +
> >> +	pr_info("SEV-SNP supported: %u ASIDs\n", min_sev_asid - 1);
> > Use sev_es_asid_count instead of manually recomputing the same; the latter
> > obfuscates the fact that ES and SNP share the same ASID pool.
> >
> > Even better would be to report ES+SNP together, otherwise the user could easily
> > interpret ES and SNP having separate ASID pools.  And IMO the gotos for SNP are
> > overkill, e.g.
> >
> > 	sev_es_supported = true;
> > 	sev_snp_supported = sev_snp_enabled &&
> > 			    cpu_feature_enabled(X86_FEATURE_SEV_SNP);
> >
> > 	pr_info("SEV-ES %ssupported: %u ASIDs\n",
> > 		sev_snp_supported ? "and SEV-SNP " : "", sev_es_asid_count);
> >
> >> +static inline bool sev_snp_guest(struct kvm *kvm)
> >> +{
> >> +#ifdef CONFIG_KVM_AMD_SEV
> >> +	struct kvm_sev_info *sev = &to_kvm_svm(kvm)->sev_info;
> >> +
> >> +	return sev_es_guest(kvm) && sev->snp_active;
> > Can't this be reduced to:
> >
> > 	return to_kvm_svm(kvm)->sev_info.snp_active;
> >
> > KVM should never set snp_active without also setting es_active.
> 
> 
> The approach here is similar to SEV/ES. IIRC, it was done mainly to
> avoid adding dead code when CONFIG_KVM_AMD_SEV is disabled.

But this is already in an #ifdef, checking sev_es_guest() is pointless.
