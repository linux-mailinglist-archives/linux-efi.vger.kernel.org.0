Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E539C3D1766
	for <lists+linux-efi@lfdr.de>; Wed, 21 Jul 2021 22:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232486AbhGUTM0 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 21 Jul 2021 15:12:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239638AbhGUTM0 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 21 Jul 2021 15:12:26 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8251EC0613D3
        for <linux-efi@vger.kernel.org>; Wed, 21 Jul 2021 12:53:01 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id a17-20020a17090abe11b0290173ce472b8aso501277pjs.2
        for <linux-efi@vger.kernel.org>; Wed, 21 Jul 2021 12:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1ZFdogakN+U+D6SX6LhX2SwuYGYaPQsFnYtn2JJoTak=;
        b=tvsyIWhNU3cg/xV3WaOgqDwBpspmMJ50HUSKczTQOHxoia0Gf97fLeNPk6repjxMxU
         5jlQjcRGy7FAvAeYmsOGOEYiTkvB0EteJixLlWUNljGhhG0PxH0M7Jr0YMrWsiBC+SVB
         pIOpLAoFAx54KbgFB0OJI2cv1cLaVXjySbSkqcTiKacy5Jiswx7XbaxYaezXwq5abeO8
         d9qYtq/rp/48EjBy9Fe3JmA2tU0HXYTEFUlhqjbmenaY06xhIi59kAojLPYzjgdIIkUG
         pwhusBBAxUzr7N/6g9a8yVt99NfLdGGQmtyY79jbo2dQWDvQacDkC6QpUzuye67Hh0CG
         pWSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1ZFdogakN+U+D6SX6LhX2SwuYGYaPQsFnYtn2JJoTak=;
        b=Yr8y58uugOctxvZ64d9SPjj08YRtNKghhJDeTQZ912nkGexZrrWWjfWBuEnbEfo8T5
         WpLz1vrAOJR/BaZgSgCvrigfkI0PDeAffviKN9B8uhAz+K2JPJgxOlcstjppyC3QH8m8
         O9/QRFgJ6HkWQtjwrmtGl/ql4Z0dca18N3pj0y9AFYvJtWI9amg7E0YbJns+tC3QWD5R
         FnOBbuoFSomgBRjuCIF/aE5sZ5JUOmkVY0ITHTMTHIBNNCfMOq9S0iBSw76+AWTrl1NM
         0NHkFPjDvilEgBhe3DsuF67EeBwJMnlKjSanF/f4Cg3ZocJdQ0xNhR5Nxma/zcXsozrx
         0NkA==
X-Gm-Message-State: AOAM531oNuS+//vo4PRB3gHdDd06hoHQ1EFKUsLyXsDcoRM3/U2BrE7T
        eSHGS/2WjO+cUZ6UcTBm+RYOUA==
X-Google-Smtp-Source: ABdhPJx0SNXBSozA1zqonbwhhcSmrLxNop72v66ohRghPV4r836hvfWk3fIwfoZPziXuNwE9t9Hl/Q==
X-Received: by 2002:a17:90b:2382:: with SMTP id mr2mr5315994pjb.169.1626897180725;
        Wed, 21 Jul 2021 12:53:00 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id 5sm31461466pgv.25.2021.07.21.12.52.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 12:52:59 -0700 (PDT)
Date:   Wed, 21 Jul 2021 19:52:55 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     Brijesh Singh <brijesh.singh@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        linux-crypto@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
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
Message-ID: <YPh7F2talucL7FQ9@google.com>
References: <20210707183616.5620-1-brijesh.singh@amd.com>
 <20210707183616.5620-41-brijesh.singh@amd.com>
 <YPdjvca28JaWPZRb@google.com>
 <c007821a-3a79-d270-07af-eb7d4c2d0862@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c007821a-3a79-d270-07af-eb7d4c2d0862@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Jul 21, 2021, Tom Lendacky wrote:
> On 7/20/21 7:01 PM, Sean Christopherson wrote:
> > On Wed, Jul 07, 2021, Brijesh Singh wrote:
> >> From: Tom Lendacky <thomas.lendacky@amd.com>
> >> +
> >> +		svm->snp_vmsa_pfn = pfn;
> >> +
> >> +		/* Use the new VMSA in the sev_es_init_vmcb() path */
> >> +		svm->vmsa_pa = pfn_to_hpa(pfn);
> >> +		svm->vmcb->control.vmsa_pa = svm->vmsa_pa;
> >> +
> >> +		vcpu->arch.mp_state = KVM_MP_STATE_RUNNABLE;
> >> +	} else {
> >> +		vcpu->arch.pv.pv_unhalted = false;
> > 
> > Shouldn't the RUNNABLE path also clear pv_unhalted?
> 
> If anything it should set it, since it will be "unhalted" now. But, I
> looked through the code to try and understand if there was a need to set
> it and didn't really see any reason. It is only ever set (at least
> directly) in one place and is cleared everywhere else. It was odd to me.

pv_unhalted is specifically used for a "magic" IPI (KVM hijacked a defunct
IPI type) in the context of PV spinlocks.  The idea is that a vCPU that's releasing
a spinlock can kick the next vCPU in the queue, and KVM will directly yield to the
vCPU being kicked so that the guest can efficiently make forward progress.

So it's not wrong to leave pv_unhalted as is, but it's odd to clear it in the
DESTROY case but not CREATE_INIT case.  It should be a moot point, as a sane
implementation should make it impossible to get to CREATE with pv_unhalted=1.

> >> +		vcpu->arch.mp_state = KVM_MP_STATE_UNINITIALIZED;
> > 
> > What happens if userspace calls kvm_arch_vcpu_ioctl_set_mpstate, or even worse
> > the guest sends INIT-SIPI?  Unless I'm mistaken, either case will cause KVM to
> > run the vCPU with vmcb->control.vmsa_pa==0.
> 
> Using the INVALID_PAGE value now (and even when it was 0), you'll get a
> VMRUN failure.
> 
> The AP CREATE_ON_INIT is meant to be used with INIT-SIPI, so if the guest
> hasn't done the right thing, then it will fail on VMRUN.
> 
> > 
> > My initial reaction is that the "offline" case needs a new mp_state, or maybe
> > just use KVM_MP_STATE_STOPPED.
> 
> I'll look at KVM_MP_STATE_STOPPED. Qemu doesn't reference that state at
> all in the i386 support, though, which is why I went with UNINITIALIZED.

Ya, it'd effectively be a new feature.  My concern with UNINITIALIZED is that it
be impossible for KVM to differentiate between "never run" and "destroyed and may
have an invalid VMSA" without looking at the VMSA.

> >> +	mutex_lock(&target_svm->snp_vmsa_mutex);
> > 
> > This seems like it's missing a big pile of sanity checks.  E.g. KVM should reject
> > SVM_VMGEXIT_AP_CREATE if the target vCPU is already "created", including the case
> > where it was "created_on_init" but hasn't yet received INIT-SIPI.
> 
> Why? If the guest wants to call it multiple times I guess I don't see a
> reason that it would need to call DESTROY first and then CREATE. I don't
> know why a guest would want to do that, but I don't think we should
> prevent it.

Because "creating" a vCPU that already exists is non-sensical.  Ditto for
onlining a vCPU that is already onlined.  E.g. from the guest's perspective, I
would fully expect a SVM_VMGEXIT_AP_CREATE to fail, not effectively send the vCPU
to an arbitrary state.

Any ambiguity as to the legality of CREATE/DESTROY absolutely needs to be clarified
in the GHCB.

> >> +
> >> +	target_svm->snp_vmsa_gpa = 0;
> >> +	target_svm->snp_vmsa_update_on_init = false;
> >> +
> >> +	/* Interrupt injection mode shouldn't change for AP creation */
> >> +	if (request < SVM_VMGEXIT_AP_DESTROY) {
> >> +		u64 sev_features;
> >> +
> >> +		sev_features = vcpu->arch.regs[VCPU_REGS_RAX];
> >> +		sev_features ^= sev->sev_features;
> >> +		if (sev_features & SVM_SEV_FEATURES_INT_INJ_MODES) {
> > 
> > Why is only INT_INJ_MODES checked?  The new comment in sev_es_sync_vmsa() explicitly
> > states that sev_features are the same for all vCPUs, but that's not enforced here.
> > At a bare minimum I would expect this to sanity check SVM_SEV_FEATURES_SNP_ACTIVE.
> 
> That's because we can't really enforce it. The SEV_FEATURES value is part
> of the VMSA, of which the hypervisor has no insight into (its encrypted).
> 
> The interrupt injection mechanism was specifically requested as a sanity
> check type of thing during the GHCB review, and as there were no
> objections, it was added (see the end of section 4.1.9).
> 
> I can definitely add the check for the SNP_ACTIVE bit, but it isn't required.

I'm confused.  If we've no insight into what the guest is actually using, what's
the point of the INT_INJ_MODES check?
