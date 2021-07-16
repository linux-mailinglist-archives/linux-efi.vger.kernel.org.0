Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0861C3CBDF2
	for <lists+linux-efi@lfdr.de>; Fri, 16 Jul 2021 22:45:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234292AbhGPUsK (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 16 Jul 2021 16:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234268AbhGPUsI (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 16 Jul 2021 16:48:08 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6880BC061762
        for <linux-efi@vger.kernel.org>; Fri, 16 Jul 2021 13:45:10 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id w15so11083240pgk.13
        for <linux-efi@vger.kernel.org>; Fri, 16 Jul 2021 13:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SVoSEdDgsOF278SEiT4bkNSj8tfCkbEPe6QxJ6ZAsEQ=;
        b=t0vWasvz4oRzr+vYOWmdOoybGtIq6QFmUpca0QK8qN5g5wnlInrCHGZJsw5tap+hKN
         12DomogOX59eHsUvDjxO0DSEf3pwET8LnmSFGbH5gx8mS7+qfVXQjEBg3FIPaWFgkZvi
         WF0x+VvAmN+bUcCRxDXyl6rQGDbMC+7MfzzRGPTZFpqcs32O5+y6MuZKMdub4UJhFjbN
         vqMhgYV5KJkJR7P0KVFbUa6njAcMVNSCw0SvO+QFdlXCp313bcGXTSEEfKZ1f++zMlEs
         uY4l38PFa9zQzDTqw9puylWL7kHZLhH2SbEVAfd+KqRElAe9V0lA5o4j0Za07HLyYPrA
         nhcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SVoSEdDgsOF278SEiT4bkNSj8tfCkbEPe6QxJ6ZAsEQ=;
        b=a/30TNM6gm0WnwHhye0ers2RSEsVom7hlcCUgLjTlJYc3idhNMfvKV+PDul4iJsM9q
         hn+63vqSVKuSrqSSWkWd70TR8iUsworY1olUyHu5e8O3X70m+YXXvxRnrIQzOJs4/JuV
         lGLU+WvYonJCIxj6Z1lCcDbG4/FrC9G596Os4+oFrIy2+ONMwF/OXD8+B/NM4fb6SuyA
         U/uSmj2BkyiMSLNFGii97nNcxL7WAFAnm+Fk7I09CC2K3y3ZRllnByGjGs5AtNKPaBQW
         ALDVn5JBDENs6kW7vc4xHBzzQuSmodm0PUQP+Jrvx1efJw3F8uOpXItsQYNj49I7qs8r
         q+pQ==
X-Gm-Message-State: AOAM532FgSGEeFS/REbE2+Yl0lPdaIiQvXi5M+gJquXhkx11mTZQhqGZ
        pnrhEiM2XAjoD723tAlFxy71Fg==
X-Google-Smtp-Source: ABdhPJxzXJMG7eNIWPnMlJihm93mr2tqoo2Emw3tCX3VwhK0jUTw4X6463ZC5w3P8nf6F+MZ58aggQ==
X-Received: by 2002:a65:6416:: with SMTP id a22mr11788587pgv.433.1626468309671;
        Fri, 16 Jul 2021 13:45:09 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id d129sm11452261pfd.218.2021.07.16.13.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 13:45:09 -0700 (PDT)
Date:   Fri, 16 Jul 2021 20:45:05 +0000
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
Subject: Re: [PATCH Part2 RFC v4 32/40] KVM: SVM: Add support to handle GHCB
 GPA register VMGEXIT
Message-ID: <YPHv0eCCOZQKne0O@google.com>
References: <20210707183616.5620-1-brijesh.singh@amd.com>
 <20210707183616.5620-33-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210707183616.5620-33-brijesh.singh@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Jul 07, 2021, Brijesh Singh wrote:
> SEV-SNP guests are required to perform a GHCB GPA registration (see
> section 2.5.2 in GHCB specification). Before using a GHCB GPA for a vCPU

It's section 2.3.2 in version 2.0 of the spec.

> the first time, a guest must register the vCPU GHCB GPA. If hypervisor
> can work with the guest requested GPA then it must respond back with the
> same GPA otherwise return -1.
>
> On VMEXIT, Verify that GHCB GPA matches with the registered value. If a
> mismatch is detected then abort the guest.
> 
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> ---
>  arch/x86/include/asm/sev-common.h |  2 ++
>  arch/x86/kvm/svm/sev.c            | 25 +++++++++++++++++++++++++
>  arch/x86/kvm/svm/svm.h            |  7 +++++++
>  3 files changed, 34 insertions(+)
> 
> diff --git a/arch/x86/include/asm/sev-common.h b/arch/x86/include/asm/sev-common.h
> index 466baa9cd0f5..6990d5a9d73c 100644
> --- a/arch/x86/include/asm/sev-common.h
> +++ b/arch/x86/include/asm/sev-common.h
> @@ -60,8 +60,10 @@
>  	GHCB_MSR_GPA_REG_REQ)
>  
>  #define GHCB_MSR_GPA_REG_RESP		0x013
> +#define GHCB_MSR_GPA_REG_ERROR		GENMASK_ULL(51, 0)
>  #define GHCB_MSR_GPA_REG_RESP_VAL(v)	((v) >> GHCB_MSR_GPA_REG_VALUE_POS)
>  
> +
>  /* SNP Page State Change */
>  #define GHCB_MSR_PSC_REQ		0x014
>  #define SNP_PAGE_STATE_PRIVATE		1
> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index fd2d00ad80b7..3af5d1ad41bf 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -2922,6 +2922,25 @@ static int sev_handle_vmgexit_msr_protocol(struct vcpu_svm *svm)
>  				GHCB_MSR_INFO_MASK, GHCB_MSR_INFO_POS);
>  		break;
>  	}
> +	case GHCB_MSR_GPA_REG_REQ: {

Shouldn't KVM also support "Get preferred GHCB GPA", at least to the point where
it responds with "No preferred GPA".  AFAICT, this series doesn't cover that,
i.e. KVM will kill a guest that requests the VMM's preferred GPA.

> +		kvm_pfn_t pfn;
> +		u64 gfn;
> +
> +		gfn = get_ghcb_msr_bits(svm, GHCB_MSR_GPA_REG_GFN_MASK,
> +					GHCB_MSR_GPA_REG_VALUE_POS);

This is confusing, the MASK/POS reference both GPA and GFN.

> +
> +		pfn = kvm_vcpu_gfn_to_pfn(vcpu, gfn);
> +		if (is_error_noslot_pfn(pfn))

Checking the mapped PFN at this time isn't wrong, but it's also not complete,
e.g. nothing prevents userspace from changing the gpa->hva mapping after the
initial registration.  Not that that's likely to happen (or not break the guest),
but my point is that random checks on the backing PFN really have no meaning in
KVM unless KVM can guarantee that the PFN is stable for the duration of its use.

And conversely, the GHCB doesn't require the GHCB to be shared until the first
use.  E.g. arguably KVM should fully check the usability of the GPA, but the
GHCB spec disallows that.  And I honestly can't see why SNP is special with
respect to the GHCB.  ES guests will explode just as badly if the GPA points at
garbage.

I guess I'm not against the check, but it feels extremely arbitrary.

> +			gfn = GHCB_MSR_GPA_REG_ERROR;
> +		else
> +			svm->ghcb_registered_gpa = gfn_to_gpa(gfn);
> +
> +		set_ghcb_msr_bits(svm, gfn, GHCB_MSR_GPA_REG_GFN_MASK,
> +				  GHCB_MSR_GPA_REG_VALUE_POS);
> +		set_ghcb_msr_bits(svm, GHCB_MSR_GPA_REG_RESP, GHCB_MSR_INFO_MASK,
> +				  GHCB_MSR_INFO_POS);
> +		break;
> +	}
>  	case GHCB_MSR_TERM_REQ: {
>  		u64 reason_set, reason_code;
>  
> @@ -2970,6 +2989,12 @@ int sev_handle_vmgexit(struct kvm_vcpu *vcpu)
>  		return -EINVAL;
>  	}
>  
> +	/* SEV-SNP guest requires that the GHCB GPA must be registered */
> +	if (sev_snp_guest(svm->vcpu.kvm) && !ghcb_gpa_is_registered(svm, ghcb_gpa)) {
> +		vcpu_unimpl(&svm->vcpu, "vmgexit: GHCB GPA [%#llx] is not registered.\n", ghcb_gpa);

I saw this a few other place.  vcpu_unimpl() is not the right API.  KVM supports
the guest request, the problem is that the GHCB spec _requires_ KVM to terminate
the guest in this case.

> +		return -EINVAL;
> +	}
> +
>  	svm->ghcb = svm->ghcb_map.hva;
>  	ghcb = svm->ghcb_map.hva;
>  
> diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
> index 32abcbd774d0..af4cce39b30f 100644
> --- a/arch/x86/kvm/svm/svm.h
> +++ b/arch/x86/kvm/svm/svm.h
> @@ -185,6 +185,8 @@ struct vcpu_svm {
>  	bool ghcb_sa_free;
>  
>  	bool guest_state_loaded;
> +
> +	u64 ghcb_registered_gpa;
>  };
>  
>  struct svm_cpu_data {
> @@ -245,6 +247,11 @@ static inline bool sev_snp_guest(struct kvm *kvm)
>  #endif
>  }
>  
> +static inline bool ghcb_gpa_is_registered(struct vcpu_svm *svm, u64 val)
> +{
> +	return svm->ghcb_registered_gpa == val;
> +}
> +
>  static inline void vmcb_mark_all_dirty(struct vmcb *vmcb)
>  {
>  	vmcb->control.clean = 0;
> -- 
> 2.17.1
> 
