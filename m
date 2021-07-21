Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3BCD3D05FE
	for <lists+linux-efi@lfdr.de>; Wed, 21 Jul 2021 02:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbhGTXVs (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 20 Jul 2021 19:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234076AbhGTXVG (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 20 Jul 2021 19:21:06 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8429DC0613E1
        for <linux-efi@vger.kernel.org>; Tue, 20 Jul 2021 17:01:07 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id i14so878440pfd.5
        for <linux-efi@vger.kernel.org>; Tue, 20 Jul 2021 17:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Lum8dVJc7G50BxYk9/1dYB3tGiIuTpK8uY2nNSlk3dE=;
        b=R0iJ8Ik/WdN/lAIRJHKRjSgWCUsEdYGJsvS/5sycB/cD8uuLC6uBtYzOXctsll3h7E
         UR+8c8+msAVu68F7a/tG6+pgNMLHbXkbpWWUG+oslg+uDNLWLCfYsMCvoh5GH1xuB+Zt
         EqKdNywQKv03nnTEj+Mzu17GLZyqrw5yW6d1BOr7VqMc/qF/4MCa/gsOV9VF0PU8rlKa
         cYty9x+6qm9GPFY3y6cODumpiQk4OydzLyCZNXTSRZ8+Cr8xWiqicLEqIKNkmlGQUZNk
         VxtMHnZS++Q7vRk24GjSRIotNXI37TEOIjNUFjqcslkcZWxWSxhx7EIWoprA+1tAAf9V
         okSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Lum8dVJc7G50BxYk9/1dYB3tGiIuTpK8uY2nNSlk3dE=;
        b=ksQGTdxKdoKFbjJNnTOsoRI4gEB0uGpKlvy3He7xZatXdLwNw+lDnsit79qJ/+wPcl
         S6F1iO4/cmV3Hid1u1WxFkt5ZQy+SLIOsUAsF3vDyRt/+dUHHZzrmUkj1yCT5Pxp8Xzu
         RaZZWktwCfgCQrc1iCVwrQk9DE5xIzexUHBh70AEuTuXRj+qfhNNQmak7MWpxAzbLttA
         d60DHKlKOi3AgXmg613jbbe3saC9AdfEKiOKzirL5SME/f3f2h1GxreKe5IqH5Sc2rY1
         lj7lWyGiPyheqGqWI36z51Wz6YsqAaHeXiF902Ior46XbjulwthgfIgcfvvklUuAhq1H
         Fskw==
X-Gm-Message-State: AOAM5322xW1Y4GipNZoCx0DQSenr2nr4X5s1/Maks0WK1XJVfVd7fxJu
        giMzy6QCOQ7ql0RaPpdAGyHJLQ==
X-Google-Smtp-Source: ABdhPJwoSMiOPviBOPxSBVGsElPe5h6bapyfNdTTdYIerJGRtQ5MBKc1GgdSz4SXUlGE9WgTLRKisw==
X-Received: by 2002:a63:e316:: with SMTP id f22mr33137325pgh.100.1626825666688;
        Tue, 20 Jul 2021 17:01:06 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id x23sm27344102pgk.90.2021.07.20.17.01.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 17:01:06 -0700 (PDT)
Date:   Wed, 21 Jul 2021 00:01:01 +0000
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
Subject: Re: [PATCH Part2 RFC v4 40/40] KVM: SVM: Support SEV-SNP AP Creation
 NAE event
Message-ID: <YPdjvca28JaWPZRb@google.com>
References: <20210707183616.5620-1-brijesh.singh@amd.com>
 <20210707183616.5620-41-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210707183616.5620-41-brijesh.singh@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Jul 07, 2021, Brijesh Singh wrote:
> From: Tom Lendacky <thomas.lendacky@amd.com>
> 
> Add support for the SEV-SNP AP Creation NAE event. This allows SEV-SNP
> guests to create and start APs on their own.

The changelog really needs to clarify that this doesn't allow the guest to create
arbitrary vCPUs.  The GHCB uses CREATE/DESTROY terminology, but this patch and its
comments/documentation should very clearly call out that KVM's implementation is
more along the line of vCPU online/offline.

It should also be noted that KVM still onlines APs by default.  That also raises
the question of whether or not KVM should support creating an offlined vCPU.
E.g. several of the use cases I'm aware of want to do something along the lines
of creating a VM with the max number of theoretical vCPUs, but in most instances
only run a handful of vCPUs.  That's a fair amount of potential memory savings
if the max theoretical number of vCPUs is high.

> A new event, KVM_REQ_UPDATE_PROTECTED_GUEST_STATE, is created and used
> so as to avoid updating the VMSA pointer while the vCPU is running.
> 
> For CREATE
>   The guest supplies the GPA of the VMSA to be used for the vCPU with the
>   specified APIC ID. The GPA is saved in the svm struct of the target
>   vCPU, the KVM_REQ_UPDATE_PROTECTED_GUEST_STATE event is added to the
>   vCPU and then the vCPU is kicked.
> 
> For CREATE_ON_INIT:
>   The guest supplies the GPA of the VMSA to be used for the vCPU with the
>   specified APIC ID the next time an INIT is performed. The GPA is saved
>   in the svm struct of the target vCPU.
> 
> For DESTROY:
>   The guest indicates it wishes to stop the vCPU. The GPA is cleared from
>   the svm struct, the KVM_REQ_UPDATE_PROTECTED_GUEST_STATE event is added
>   to vCPU and then the vCPU is kicked.
> 
> 
> The KVM_REQ_UPDATE_PROTECTED_GUEST_STATE event handler will be invoked as
> a result of the event or as a result of an INIT. The handler sets the vCPU
> to the KVM_MP_STATE_UNINITIALIZED state, so that any errors will leave the
> vCPU as not runnable. Any previous VMSA pages that were installed as
> part of an SEV-SNP AP Creation NAE event are un-pinned. If a new VMSA is
> to be installed, the VMSA guest page is pinned and set as the VMSA in the
> vCPU VMCB and the vCPU state is set to KVM_MP_STATE_RUNNABLE. If a new
> VMSA is not to be installed, the VMSA is cleared in the vCPU VMCB and the
> vCPU state is left as KVM_MP_STATE_UNINITIALIZED to prevent it from being
> run.
> 
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> ---
>  arch/x86/include/asm/kvm_host.h |   3 +
>  arch/x86/include/asm/svm.h      |   3 +
>  arch/x86/kvm/svm/sev.c          | 133 ++++++++++++++++++++++++++++++++
>  arch/x86/kvm/svm/svm.c          |   7 +-
>  arch/x86/kvm/svm/svm.h          |  16 +++-
>  arch/x86/kvm/x86.c              |  11 ++-
>  6 files changed, 170 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index 117e2e08d7ed..881e05b3f74e 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -91,6 +91,7 @@
>  #define KVM_REQ_MSR_FILTER_CHANGED	KVM_ARCH_REQ(29)
>  #define KVM_REQ_UPDATE_CPU_DIRTY_LOGGING \
>  	KVM_ARCH_REQ_FLAGS(30, KVM_REQUEST_WAIT | KVM_REQUEST_NO_WAKEUP)
> +#define KVM_REQ_UPDATE_PROTECTED_GUEST_STATE	KVM_ARCH_REQ(31)
>  
>  #define CR0_RESERVED_BITS                                               \
>  	(~(unsigned long)(X86_CR0_PE | X86_CR0_MP | X86_CR0_EM | X86_CR0_TS \
> @@ -1402,6 +1403,8 @@ struct kvm_x86_ops {
>  
>  	int (*handle_rmp_page_fault)(struct kvm_vcpu *vcpu, gpa_t gpa, kvm_pfn_t pfn,
>  			int level, u64 error_code);
> +
> +	void (*update_protected_guest_state)(struct kvm_vcpu *vcpu);
>  };
>  
>  struct kvm_x86_nested_ops {
> diff --git a/arch/x86/include/asm/svm.h b/arch/x86/include/asm/svm.h
> index 5e72faa00cf2..6634a952563e 100644
> --- a/arch/x86/include/asm/svm.h
> +++ b/arch/x86/include/asm/svm.h
> @@ -220,6 +220,9 @@ struct __attribute__ ((__packed__)) vmcb_control_area {
>  #define SVM_SEV_FEATURES_DEBUG_SWAP		BIT(5)
>  #define SVM_SEV_FEATURES_PREVENT_HOST_IBS	BIT(6)
>  #define SVM_SEV_FEATURES_BTB_ISOLATION		BIT(7)
> +#define SVM_SEV_FEATURES_INT_INJ_MODES			\
> +	(SVM_SEV_FEATURES_RESTRICTED_INJECTION |	\
> +	 SVM_SEV_FEATURES_ALTERNATE_INJECTION)
>  
>  struct vmcb_seg {
>  	u16 selector;
> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index d8ad6dd58c87..95f5d25b4f08 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -582,6 +582,7 @@ static int sev_launch_update_data(struct kvm *kvm, struct kvm_sev_cmd *argp)
>  
>  static int sev_es_sync_vmsa(struct vcpu_svm *svm)
>  {
> +	struct kvm_sev_info *sev = &to_kvm_svm(svm->vcpu.kvm)->sev_info;
>  	struct sev_es_save_area *save = svm->vmsa;
>  
>  	/* Check some debug related fields before encrypting the VMSA */
> @@ -625,6 +626,12 @@ static int sev_es_sync_vmsa(struct vcpu_svm *svm)
>  	if (sev_snp_guest(svm->vcpu.kvm))
>  		save->sev_features |= SVM_SEV_FEATURES_SNP_ACTIVE;
>  
> +	/*
> +	 * Save the VMSA synced SEV features. For now, they are the same for
> +	 * all vCPUs, so just save each time.
> +	 */
> +	sev->sev_features = save->sev_features;
> +
>  	return 0;
>  }
>  
> @@ -2682,6 +2689,10 @@ static int sev_es_validate_vmgexit(struct vcpu_svm *svm)
>  		if (!ghcb_sw_scratch_is_valid(ghcb))
>  			goto vmgexit_err;
>  		break;
> +	case SVM_VMGEXIT_AP_CREATION:
> +		if (!ghcb_rax_is_valid(ghcb))
> +			goto vmgexit_err;
> +		break;
>  	case SVM_VMGEXIT_NMI_COMPLETE:
>  	case SVM_VMGEXIT_AP_HLT_LOOP:
>  	case SVM_VMGEXIT_AP_JUMP_TABLE:
> @@ -3395,6 +3406,121 @@ static int sev_handle_vmgexit_msr_protocol(struct vcpu_svm *svm)
>  	return ret;
>  }
>  
> +void sev_snp_update_protected_guest_state(struct kvm_vcpu *vcpu)
> +{
> +	struct vcpu_svm *svm = to_svm(vcpu);
> +	kvm_pfn_t pfn;
> +
> +	mutex_lock(&svm->snp_vmsa_mutex);
> +
> +	vcpu->arch.mp_state = KVM_MP_STATE_UNINITIALIZED;
> +
> +	/* Clear use of the VMSA in the sev_es_init_vmcb() path */
> +	svm->vmsa_pa = 0;
> +
> +	/* Clear use of the VMSA from the VMCB */
> +	svm->vmcb->control.vmsa_pa = 0;

PA=0 is not an invalid address.  I don't care what value the GHCB uses for
"invalid GPA", KVM should always use INVALID_PAGE to track an invalid physical
address.

> +	/* Un-pin previous VMSA */
> +	if (svm->snp_vmsa_pfn) {
> +		kvm_release_pfn_dirty(svm->snp_vmsa_pfn);

Oof, I was wondering why KVM tracks three versions of VMSA.  Actually, I'm still
wondering why there are three versions.  Aren't snp_vmsa_pfn and vmsa_pa tracking
the same thing?  Ah, finally figured it out.  vmsa_pa points at svm->vmsa by
default.  Blech.

> +		svm->snp_vmsa_pfn = 0;
> +	}
> +
> +	if (svm->snp_vmsa_gpa) {

This is bogus, GPA=0 is perfectly valid.  As above, use INVALID_PAGE.  A comment
explaining that the vCPU is offline when VMSA is invalid would also be helpful.

> +		/* Validate that the GPA is page aligned */
> +		if (!PAGE_ALIGNED(svm->snp_vmsa_gpa))

This needs to be moved to the VMGEXIT, and it should use page_address_valid() so
that KVM also checks for a legal GPA.

> +			goto e_unlock;
> +
> +		/*
> +		 * The VMSA is referenced by thy hypervisor physical address,

s/thy/the, although converting to archaic English could be hilarious...

> +		 * so retrieve the PFN and pin it.
> +		 */
> +		pfn = gfn_to_pfn(vcpu->kvm, gpa_to_gfn(svm->snp_vmsa_gpa));
> +		if (is_error_pfn(pfn))
> +			goto e_unlock;

Silently ignoring the guest request is bad behavior, at worst KVM should exit to
userspace with an emulation error.

> +
> +		svm->snp_vmsa_pfn = pfn;
> +
> +		/* Use the new VMSA in the sev_es_init_vmcb() path */
> +		svm->vmsa_pa = pfn_to_hpa(pfn);
> +		svm->vmcb->control.vmsa_pa = svm->vmsa_pa;
> +
> +		vcpu->arch.mp_state = KVM_MP_STATE_RUNNABLE;
> +	} else {
> +		vcpu->arch.pv.pv_unhalted = false;

Shouldn't the RUNNABLE path also clear pv_unhalted?

> +		vcpu->arch.mp_state = KVM_MP_STATE_UNINITIALIZED;

What happens if userspace calls kvm_arch_vcpu_ioctl_set_mpstate, or even worse
the guest sends INIT-SIPI?  Unless I'm mistaken, either case will cause KVM to
run the vCPU with vmcb->control.vmsa_pa==0.

My initial reaction is that the "offline" case needs a new mp_state, or maybe
just use KVM_MP_STATE_STOPPED.

> +	}
> +
> +e_unlock:
> +	mutex_unlock(&svm->snp_vmsa_mutex);
> +}
> +
> +static void sev_snp_ap_creation(struct vcpu_svm *svm)
> +{
> +	struct kvm_sev_info *sev = &to_kvm_svm(svm->vcpu.kvm)->sev_info;
> +	struct kvm_vcpu *vcpu = &svm->vcpu;
> +	struct kvm_vcpu *target_vcpu;
> +	struct vcpu_svm *target_svm;
> +	unsigned int request;
> +	unsigned int apic_id;
> +	bool kick;
> +
> +	request = lower_32_bits(svm->vmcb->control.exit_info_1);
> +	apic_id = upper_32_bits(svm->vmcb->control.exit_info_1);
> +
> +	/* Validate the APIC ID */
> +	target_vcpu = kvm_get_vcpu_by_id(vcpu->kvm, apic_id);
> +	if (!target_vcpu)
> +		return;

KVM should not silently ignore bad requests, this needs to return an error to the
guest.

> +
> +	target_svm = to_svm(target_vcpu);
> +
> +	kick = true;

This is wrong, e.g. KVM will kick the target vCPU even if the request fails.
I suspect the correct behavior would be to:

  1. do all sanity checks
  2. take the necessary lock(s)
  3. modify target vCPU state
  4. kick target vCPU unless request==SVM_VMGEXIT_AP_CREATE_ON_INIT

> +	mutex_lock(&target_svm->snp_vmsa_mutex);

This seems like it's missing a big pile of sanity checks.  E.g. KVM should reject
SVM_VMGEXIT_AP_CREATE if the target vCPU is already "created", including the case
where it was "created_on_init" but hasn't yet received INIT-SIPI.

> +
> +	target_svm->snp_vmsa_gpa = 0;
> +	target_svm->snp_vmsa_update_on_init = false;
> +
> +	/* Interrupt injection mode shouldn't change for AP creation */
> +	if (request < SVM_VMGEXIT_AP_DESTROY) {
> +		u64 sev_features;
> +
> +		sev_features = vcpu->arch.regs[VCPU_REGS_RAX];
> +		sev_features ^= sev->sev_features;
> +		if (sev_features & SVM_SEV_FEATURES_INT_INJ_MODES) {

Why is only INT_INJ_MODES checked?  The new comment in sev_es_sync_vmsa() explicitly
states that sev_features are the same for all vCPUs, but that's not enforced here.
At a bare minimum I would expect this to sanity check SVM_SEV_FEATURES_SNP_ACTIVE.

> +			vcpu_unimpl(vcpu, "vmgexit: invalid AP injection mode [%#lx] from guest\n",
> +				    vcpu->arch.regs[VCPU_REGS_RAX]);
> +			goto out;
> +		}
> +	}
> +
> +	switch (request) {
> +	case SVM_VMGEXIT_AP_CREATE_ON_INIT:

Out of curiosity, what's the use case for this variant?  I assume the guest has
to preconfigure the VMSA and ensure the target vCPU's RIP points at something
sane anyways, otherwise the hypervisor could attack the guest by immediately
attempting to run the deferred vCPU.  At that point, a guest could simply use an
existing mechanism to put the target vCPU into a holding pattern.

> +		kick = false;
> +		target_svm->snp_vmsa_update_on_init = true;
> +		fallthrough;
> +	case SVM_VMGEXIT_AP_CREATE:
> +		target_svm->snp_vmsa_gpa = svm->vmcb->control.exit_info_2;

The incoming GPA needs to be checked for validity, at least as much possible.
E.g. the PAGE_ALIGNED() check should be done here and be morphed to a synchronous
error for the guest, not a silent "oops, didn't run your vCPU".

> +		break;
> +	case SVM_VMGEXIT_AP_DESTROY:
> +		break;
> +	default:
> +		vcpu_unimpl(vcpu, "vmgexit: invalid AP creation request [%#x] from guest\n",
> +			    request);
> +		break;
> +	}
> +
> +out:
> +	mutex_unlock(&target_svm->snp_vmsa_mutex);
> +
> +	if (kick) {
> +		kvm_make_request(KVM_REQ_UPDATE_PROTECTED_GUEST_STATE, target_vcpu);
> +		kvm_vcpu_kick(target_vcpu);
> +	}
> +}
> +
>  int sev_handle_vmgexit(struct kvm_vcpu *vcpu)
>  {
>  	struct vcpu_svm *svm = to_svm(vcpu);
> @@ -3523,6 +3649,11 @@ int sev_handle_vmgexit(struct kvm_vcpu *vcpu)
>  		ret = 1;
>  		break;
>  	}
> +	case SVM_VMGEXIT_AP_CREATION:
> +		sev_snp_ap_creation(svm);
> +
> +		ret = 1;
> +		break;
>  	case SVM_VMGEXIT_UNSUPPORTED_EVENT:
>  		vcpu_unimpl(vcpu,
>  			    "vmgexit: unsupported event - exit_info_1=%#llx, exit_info_2=%#llx\n",
> @@ -3597,6 +3728,8 @@ void sev_es_create_vcpu(struct vcpu_svm *svm)
>  	set_ghcb_msr(svm, GHCB_MSR_SEV_INFO(GHCB_VERSION_MAX,
>  					    GHCB_VERSION_MIN,
>  					    sev_enc_bit));
> +
> +	mutex_init(&svm->snp_vmsa_mutex);
>  }
>  
>  void sev_es_prepare_guest_switch(struct vcpu_svm *svm, unsigned int cpu)
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index 74bc635c9608..078a569c85a8 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -1304,7 +1304,10 @@ static void svm_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
>  	svm->spec_ctrl = 0;
>  	svm->virt_spec_ctrl = 0;
>  
> -	if (!init_event) {
> +	if (init_event && svm->snp_vmsa_update_on_init) {

This can race with sev_snp_ap_creation() since the new snp_vmsa_mutex isn't held.
There needs to be smp_rmb() and smp_wmb() barriers to ensure correct ordering
between snp_vmsa_update_on_init and consuming the new VMSA gpa.  And of course
sev_snp_ap_creation() needs to have correct ordering, e.g. as is this code can
see snp_vmsa_update_on_init=true before the new snp_vmsa_gpa is set.

> +		svm->snp_vmsa_update_on_init = false;
> +		sev_snp_update_protected_guest_state(vcpu);
> +	} else {
>  		vcpu->arch.apic_base = APIC_DEFAULT_PHYS_BASE |
>  				       MSR_IA32_APICBASE_ENABLE;
>  		if (kvm_vcpu_is_reset_bsp(vcpu))
