Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 815533CF223
	for <lists+linux-efi@lfdr.de>; Tue, 20 Jul 2021 04:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345388AbhGTCBd (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 19 Jul 2021 22:01:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442195AbhGSWxX (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 19 Jul 2021 18:53:23 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E41ADC0612FB
        for <linux-efi@vger.kernel.org>; Mon, 19 Jul 2021 16:30:31 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id o201so18049184pfd.1
        for <linux-efi@vger.kernel.org>; Mon, 19 Jul 2021 16:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ml3Q/kTxZiD4jac4rsa9z6q3oqgw/koE0r8JlYAWEoE=;
        b=sMaBLc6xZX7zehQ8U1kn7T2/C76fdCJIRBEmJcwUdtN+Ur6xNDVNIA4wnj+n5MAgrI
         fRKop8qSFfB5cJj5Qd7DEJPBG9n2V1DApSvIFOjQinvQRz7V6ozyOBexcCug8btYPM+J
         MMZqkMfsPwKR7hJ8KfXCbL9q5j/u8ILTW+OotIbqxzJ+akWq3OX+Rux7DSgW64emjSxx
         /G3uagHiW/9cKFWa857nddfAl6IcWtZDkPwv7s7H35o+5FI3X0D2AEhUoR4OdKHktGMB
         5lpjpv8BqF9q2yg/iuIW7lEANMTukouIkKW+oDuuhgdavYXnIqR/tPR7p66hSzMduya7
         pthQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ml3Q/kTxZiD4jac4rsa9z6q3oqgw/koE0r8JlYAWEoE=;
        b=H/XdwgDN/vWacJR+3sK4CqM7Ao41eifvhhpOCMasWZPhA1GoKukXgW64i+r4ErvEtc
         KpwPb9InVwcuNr3Df+VQFewrIO+X1zl6LWUhOT9l5cBN6iuRP7oHClET9clL9sE5nwNL
         af2u+IGyV0JdzNA7U6MCLzNOmmyPttj/ITaHc7usmoH3gy3vfrdRUQPmtP/NRH4v29OR
         d7oCQtr9Z2QFHYvJzyisaTHV032VdkogpNvLwxs3Uq/ep40/bnRkOOyOPG5EuklmkdRs
         rjmLjs0I8x7/xVDfm0TpXwVY9r/teyEc4avobP8PGQaKvjLEVTZU0+TSn57cmiHsA/wU
         Y9rg==
X-Gm-Message-State: AOAM5324PdWB1CGc7EsICDo2Agul7oGQUurYWB8vvOc/3O+lH77TZ7wo
        hay6xD6j8QSytoMh11XE3bzN6w==
X-Google-Smtp-Source: ABdhPJxkrxZk/0Zz1bAor5ysJ9w0e2+YW2IaG8snr9Fl4r2Iz1JNpsaNu5NP3/nbL6PnRtlutO5udg==
X-Received: by 2002:a62:4e0f:0:b029:329:20be:287a with SMTP id c15-20020a624e0f0000b029032920be287amr28021297pfb.55.1626737431050;
        Mon, 19 Jul 2021 16:30:31 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id bt17sm571551pjb.40.2021.07.19.16.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jul 2021 16:30:30 -0700 (PDT)
Date:   Mon, 19 Jul 2021 23:30:26 +0000
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
Subject: Re: [PATCH Part2 RFC v4 35/40] KVM: Add arch hooks to track the host
 write to guest memory
Message-ID: <YPYLEksyzOWHZwpA@google.com>
References: <20210707183616.5620-1-brijesh.singh@amd.com>
 <20210707183616.5620-36-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210707183616.5620-36-brijesh.singh@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Jul 07, 2021, Brijesh Singh wrote:
> The kvm_write_guest{_page} and kvm_vcpu_write_guest{_page} are used by
> the hypevisor to write to the guest memory. The kvm_vcpu_map() and
> kvm_map_gfn() are used by the hypervisor to map the guest memory and
> and access it later.
> 
> When SEV-SNP is enabled in the guest VM, the guest memory pages can
> either be a private or shared. A write from the hypervisor goes through
> the RMP checks. If hardware sees that hypervisor is attempting to write
> to a guest private page, then it triggers an RMP violation (i.e, #PF with
> RMP bit set).
> 
> Enhance the KVM guest write helpers to invoke an architecture specific
> hooks (kvm_arch_write_gfn_{begin,end}) to track the write access from the
> hypervisor.
> 
> When SEV-SNP is enabled, the guest uses the PAGE_STATE vmgexit to ask the
> hypervisor to change the page state from shared to private or vice versa.
> While changing the page state to private, use the
> kvm_host_write_track_is_active() to check whether the page is being
> tracked for the host write access (i.e either mapped or kvm_write_guest
> is in progress). If its tracked, then do not change the page state.
> 
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> ---

...

> @@ -3468,3 +3489,33 @@ int sev_get_tdp_max_page_level(struct kvm_vcpu *vcpu, gpa_t gpa, int max_level)
>  
>  	return min_t(uint32_t, level, max_level);
>  }
> +
> +void sev_snp_write_page_begin(struct kvm *kvm, struct kvm_memory_slot *slot, gfn_t gfn)
> +{
> +	struct rmpentry *e;
> +	int level, rc;
> +	kvm_pfn_t pfn;
> +
> +	if (!sev_snp_guest(kvm))
> +		return;
> +
> +	pfn = gfn_to_pfn(kvm, gfn);
> +	if (is_error_noslot_pfn(pfn))
> +		return;
> +
> +	e = snp_lookup_page_in_rmptable(pfn_to_page(pfn), &level);
> +	if (unlikely(!e))
> +		return;
> +
> +	/*
> +	 * A hypervisor should never write to the guest private page. A write to the
> +	 * guest private will cause an RMP violation. If the guest page is private,
> +	 * then make it shared.

NAK on converting RMP entries in response to guest accesses.  Corrupting guest
data (due to dropping the "validated" flag) on a rogue/incorrect guest emulation
request or misconfigured PV feature is double ungood.  The potential kernel panic
below isn't much better.

And I also don't think we need this heavyweight flow for user access, e.g.
__copy_to_user(), just eat the RMP violation #PF like all other #PFs and exit
to userspace with -EFAULT.

kvm_vcpu_map() and friends might need the manual lookup, at least initially, but
in an ideal world that would be naturally handled by gup(), e.g. by unmapping
guest private memory or whatever approach TDX ends up employing to avoid #MCs.

> +	 */
> +	if (rmpentry_assigned(e)) {
> +		pr_err("SEV-SNP: write to guest private gfn %llx\n", gfn);
> +		rc = snp_make_page_shared(kvm_get_vcpu(kvm, 0),
> +				gfn << PAGE_SHIFT, pfn, PG_LEVEL_4K);
> +		BUG_ON(rc != 0);
> +	}
> +}

...

> +void kvm_arch_write_gfn_begin(struct kvm *kvm, struct kvm_memory_slot *slot, gfn_t gfn)
> +{
> +	update_gfn_track(slot, gfn, KVM_PAGE_TRACK_WRITE, 1);

Tracking only writes isn't correct, as KVM reads to guest private memory will
return garbage.  Pulling the rug out from under KVM reads won't fail as
spectacularly as writes (at least not right away), but they'll still fail.  I'm
actually ok reading garbage if the guest screws up, but KVM needs consistent
semantics.

Good news is that per-gfn tracking is probably overkill anyways.  As mentioned
above, user access don't need extra magic, they either fail or they don't.

For kvm_vcpu_map(), one thought would be to add a "short-term" map variant that
is not allowed to be retained across VM-Entry, and then use e.g. SRCU to block
PSC requests until there are no consumers.

> +	if (kvm_x86_ops.write_page_begin)
> +		kvm_x86_ops.write_page_begin(kvm, slot, gfn);
> +}
