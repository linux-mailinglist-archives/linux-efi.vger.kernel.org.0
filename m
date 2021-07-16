Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A74E43CBB86
	for <lists+linux-efi@lfdr.de>; Fri, 16 Jul 2021 20:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231660AbhGPSDa (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 16 Jul 2021 14:03:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231715AbhGPSD0 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 16 Jul 2021 14:03:26 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76FE7C061760
        for <linux-efi@vger.kernel.org>; Fri, 16 Jul 2021 11:00:31 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id d12so10684511pgd.9
        for <linux-efi@vger.kernel.org>; Fri, 16 Jul 2021 11:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JJT3j10iJIIOsPHEEnbNQuVLTw5JnzSQ/acvTlgZAJ8=;
        b=GwzdfStOFnu5bUYpHJmW5qaywa/s2A2QUEultL+m1JqZOp4yK+grRGfNrwTW9gYDni
         UqvwTqYFLACzmBr+3+oAJUIEDDk0SfGX3M+dkfZq23+XWfGrzkVviYu0lCuiXM9PkmfN
         VnO3DYxEBTHGP7EBr9YSyyvciKgdSDS/ekdvhUo9MHlz9j6dStUSGQcBD0oB8sHJKH3U
         gWA5LIEuf9cVeVGn0fTk3/vs6U082z3MZAKK3zm+d4QRce0q2sMrV2JKMM+i6LkRQuyQ
         6PU1WFaWteTtKwq+nAD46Kkt1uKcDZ7ZIHdLOQiNxLErn0Ufz5tdxfui9LCKHwLL6ctE
         vBnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JJT3j10iJIIOsPHEEnbNQuVLTw5JnzSQ/acvTlgZAJ8=;
        b=Ja8TSlfUKMrR947qv/fR58USt5IUOsWPLLN1zxnQYHX8Mi1CnOcb1sPNq0nyKVlFd5
         eP9Fk11unKlNWMfgmDuW5Q8qi+TcBMAZ1fO+rH1+x+/PKVHh+ZHPOf7JIoJokgU2/JKL
         kjN57tv4iL2lJQ4P+XIZ8D8aYdkcJdrW4eYISchgwicMOuqqCndP9G0GbXGPfUcWygPP
         zW/Vuv48MiHwQrtbZ4G+L2ZMVb9nC0gLWTdwe/W+IcW6Y0ZWC4uxrRnAXOuLAVgO9o+Q
         WtARQupcWQ3OnZSYwRUGwzTiNj+kkIyIUyKp0mJzh/nOCv9OHiO+bVnYOSy4sqWRoO5W
         yc3A==
X-Gm-Message-State: AOAM533R5kYqPtNqrE8LmAdtQHjhfEb23X6SmuF4y7whfC98AonWQtuc
        8QnE6N6OSMquQi8htcVlYyaGDA==
X-Google-Smtp-Source: ABdhPJyJxNSW4W+lQGEGZFuQKmM6xXoN4SsZLj1WhAcFQMeACiCuwpzphldu3fpnqiStbul1Zx/cQA==
X-Received: by 2002:a65:6118:: with SMTP id z24mr11085274pgu.325.1626458430711;
        Fri, 16 Jul 2021 11:00:30 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id cx4sm12694608pjb.53.2021.07.16.11.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 11:00:30 -0700 (PDT)
Date:   Fri, 16 Jul 2021 18:00:26 +0000
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
Message-ID: <YPHJOmUOR65QY+YY@google.com>
References: <20210707183616.5620-1-brijesh.singh@amd.com>
 <20210707183616.5620-22-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210707183616.5620-22-brijesh.singh@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Jul 07, 2021, Brijesh Singh wrote:
> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index 411ed72f63af..abca2b9dee83 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -52,9 +52,14 @@ module_param_named(sev, sev_enabled, bool, 0444);
>  /* enable/disable SEV-ES support */
>  static bool sev_es_enabled = true;
>  module_param_named(sev_es, sev_es_enabled, bool, 0444);
> +
> +/* enable/disable SEV-SNP support */
> +static bool sev_snp_enabled = true;

Is it safe to incrementally introduce SNP support?  Or should the module param
be hidden until all support is in place?  E.g. what will happen when KVM allows
userspace to create SNP guests but doesn't yet have the RMP management added?

> +module_param_named(sev_snp, sev_snp_enabled, bool, 0444);
>  #else
>  #define sev_enabled false
>  #define sev_es_enabled false
> +#define sev_snp_enabled  false
>  #endif /* CONFIG_KVM_AMD_SEV */
>  
>  #define AP_RESET_HOLD_NONE		0
> @@ -1825,6 +1830,7 @@ void __init sev_hardware_setup(void)
>  {
>  #ifdef CONFIG_KVM_AMD_SEV
>  	unsigned int eax, ebx, ecx, edx, sev_asid_count, sev_es_asid_count;
> +	bool sev_snp_supported = false;
>  	bool sev_es_supported = false;
>  	bool sev_supported = false;
>  
> @@ -1888,9 +1894,21 @@ void __init sev_hardware_setup(void)
>  	pr_info("SEV-ES supported: %u ASIDs\n", sev_es_asid_count);
>  	sev_es_supported = true;
>  
> +	/* SEV-SNP support requested? */
> +	if (!sev_snp_enabled)
> +		goto out;
> +
> +	/* Is SEV-SNP enabled? */
> +	if (!cpu_feature_enabled(X86_FEATURE_SEV_SNP))

Random question, why use cpu_feature_enabled?  Did something change in cpufeatures
that prevents using boot_cpu_has() here?

> +		goto out;
> +
> +	pr_info("SEV-SNP supported: %u ASIDs\n", min_sev_asid - 1);

Use sev_es_asid_count instead of manually recomputing the same; the latter
obfuscates the fact that ES and SNP share the same ASID pool.

Even better would be to report ES+SNP together, otherwise the user could easily
interpret ES and SNP having separate ASID pools.  And IMO the gotos for SNP are
overkill, e.g.

	sev_es_supported = true;
	sev_snp_supported = sev_snp_enabled &&
			    cpu_feature_enabled(X86_FEATURE_SEV_SNP);

	pr_info("SEV-ES %ssupported: %u ASIDs\n",
		sev_snp_supported ? "and SEV-SNP " : "", sev_es_asid_count);


> +	sev_snp_supported = true;
> +
>  out:
>  	sev_enabled = sev_supported;
>  	sev_es_enabled = sev_es_supported;
> +	sev_snp_enabled = sev_snp_supported;
>  #endif
>  }
>  
> diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
> index 1175edb02d33..b9ea99f8579e 100644
> --- a/arch/x86/kvm/svm/svm.h
> +++ b/arch/x86/kvm/svm/svm.h
> @@ -58,6 +58,7 @@ enum {
>  struct kvm_sev_info {
>  	bool active;		/* SEV enabled guest */
>  	bool es_active;		/* SEV-ES enabled guest */
> +	bool snp_active;	/* SEV-SNP enabled guest */
>  	unsigned int asid;	/* ASID used for this guest */
>  	unsigned int handle;	/* SEV firmware handle */
>  	int fd;			/* SEV device fd */
> @@ -232,6 +233,17 @@ static inline bool sev_es_guest(struct kvm *kvm)
>  #endif
>  }
>  
> +static inline bool sev_snp_guest(struct kvm *kvm)
> +{
> +#ifdef CONFIG_KVM_AMD_SEV
> +	struct kvm_sev_info *sev = &to_kvm_svm(kvm)->sev_info;
> +
> +	return sev_es_guest(kvm) && sev->snp_active;

Can't this be reduced to:

	return to_kvm_svm(kvm)->sev_info.snp_active;

KVM should never set snp_active without also setting es_active.

Side topic, I think it would also be worthwhile to add to_sev (or maybe to_kvm_sev)
given the frequency of the "&to_kvm_svm(kvm)->sev_info" pattern.

> +#else
> +	return false;
> +#endif
> +}
> +
>  static inline void vmcb_mark_all_dirty(struct vmcb *vmcb)
>  {
>  	vmcb->control.clean = 0;
> -- 
> 2.17.1
> 
