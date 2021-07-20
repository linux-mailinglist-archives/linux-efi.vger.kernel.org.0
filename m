Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0322B3D0124
	for <lists+linux-efi@lfdr.de>; Tue, 20 Jul 2021 20:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbhGTRVr (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 20 Jul 2021 13:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbhGTRVq (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 20 Jul 2021 13:21:46 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 339A2C061768
        for <linux-efi@vger.kernel.org>; Tue, 20 Jul 2021 11:02:24 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id y17so23201454pgf.12
        for <linux-efi@vger.kernel.org>; Tue, 20 Jul 2021 11:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=M9MyM6SiQLZ5m3aBTaXSLwq/XGnRhh08/VcLgE/dXu0=;
        b=STNATKcfH1avBpmTllo0BejrpE+zX75J13FmRFIATfMMH+ODZAEmHcUarX83AoF6E4
         CCm9bro8RnZa4wVgDdnozFQnggMPUw/sucQh3JE/5zlmTB9UYuoE743sVGa31+KS2N5A
         XtQOv5JnRkaKKyp/0AhP3l+ew8rMoVQr+9T+dZP9WDU9WEGJbu0VkOCqicPcFl8cHQAi
         mJzSnKO+hkfhC4wVsD23n2VmibHbSG9HDT1aGu0RvrnBsAmHQFBQUot1BLzBhhDwoOKl
         fqBqmjJ8O7lSuaa6Dv4/rACTMeCNfvkFJ1w6yI455+/K3WCCiXHNgR6Pqw3QbCxHZyg5
         axKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=M9MyM6SiQLZ5m3aBTaXSLwq/XGnRhh08/VcLgE/dXu0=;
        b=WocTVI51devNJdxE3F0PWuOWFe8tEvtwmKO0wEsk/GIREiGZUSgxq5Wrox5gJPs4Qf
         rueE0sjO/Kl8xif0z2p27IG48LqXkBlSSKjkj71F5tbhHWnboOz1x4fKAbi6T5JngNQn
         s/NqGFlhKxHzxhDUgQ+TAn2o0YMw8xvBaHMYyzcO4B2nNNI5PJwEUv9YZaIO2VMox8du
         DkmXblW369VbVFrn+6jm7VCymdg6N+x0Y9Vif0iepxTYM0DljwkS4onptfo4q5QPiOiP
         g0wqlCF43hWn5dkisqfQF50vRH3D9LWSCa0XT4vtpAqsSDwoZwW94M8vzuH+3KqW1yPx
         /udA==
X-Gm-Message-State: AOAM531Safwyu3L46gWv4pJbXS0Rw8qjZZpFNlYOmNojEBZSnIAPskSN
        ZNZnx3ZAbqLtMNMRrvfN2gDO5Q==
X-Google-Smtp-Source: ABdhPJztjb1vCs7OC4JfJwLTVUau3HVEAMypgjUcIXcXHaeykJbmgjHUQ20ZSm2OZU/jp51eFJFfyg==
X-Received: by 2002:aa7:95a4:0:b029:332:f4e1:1dac with SMTP id a4-20020aa795a40000b0290332f4e11dacmr31607712pfk.34.1626804143248;
        Tue, 20 Jul 2021 11:02:23 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id x6sm3444697pjr.5.2021.07.20.11.02.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 11:02:22 -0700 (PDT)
Date:   Tue, 20 Jul 2021 18:02:18 +0000
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
Subject: Re: [PATCH Part2 RFC v4 20/40] KVM: SVM: Make AVIC backing, VMSA and
 VMCB memory allocation SNP safe
Message-ID: <YPcPqpqRju/QLoHI@google.com>
References: <20210707183616.5620-1-brijesh.singh@amd.com>
 <20210707183616.5620-21-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210707183616.5620-21-brijesh.singh@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

IMO, the CPU behavior is a bug, even if the behavior is working as intended for
the microarchitecture.  I.e. this should be treated as an erratum.

On Wed, Jul 07, 2021, Brijesh Singh wrote:
> When SEV-SNP is globally enabled on a system, the VMRUN instruction
> performs additional security checks on AVIC backing, VMSA, and VMCB page.
> On a successful VMRUN, these pages are marked "in-use" by the
> hardware in the RMP entry

There's a lot of "noise" in this intro.  That the CPU does additional checks at
VMRUN isn't all that interesting, what's relevant is that the CPU tags the
associated RMP entry with a special flag.  And IIUC, it does that for _all_ VMs,
not just SNP VMs.

Also, what happens if the pages aren't covered by the RMP?  Table 15-41 states
that the VMCB, AVIC, and VMSA for non-SNP guests need to be Hypervisor-Owned,
but doesn't explicitly require them to be RMP covered.  On the other hand, it
does state that the VMSA for an SNP guest must be Guest-Owned and RMP-Covered.
That implies that the Hypervisor-Owned pages do not need to contained within the
RMP, but how does that work if the CPU is setting a magic flag in the RMP?  Does
VMRUN explode?  Does the CPU corrupt random memory?

Is the in-use flag visible to software?  We've already established that "struct
rmpentry" is microarchitectural, so why not document it in the PPR?  It could be
useful info for debugging unexpected RMP violations, even if the flag isn't stable.

Are there other possible collisions with the in-use flag?  The APM states that
the in-use flag results in RMPUPDATE failing with FAIL_INUSE.  That's the same
error code that's returned if two CPUs attempt RMPUPDATE on the same entry.  That
implies that the RMPUPDATE also sets the in-use flag.  If that's true, then isn't
it possible that the spurious RMP violation #PF could happen if the kernel accesses
a hugepage at the same time a CPU is doing RMPUPDATE on the associated 2mb-aligned
entry?

> and any attempt to modify the RMP entry for these pages will result in
> page-fault (RMP violation check).

Again, not that relevant since KVM isn't attempting to modify the RMP entry.
I've no objection to mentioning this behavior in passing, but it should not be
the focal point of the intro.

> While performing the RMP check, hardware will try to create a 2MB TLB
> entry for the large page accesses. When it does this, it first reads
> the RMP for the base of 2MB region and verifies that all this memory is
> safe. If AVIC backing, VMSA, and VMCB memory happen to be the base of
> 2MB region, then RMP check will fail because of the "in-use" marking for
> the base entry of this 2MB region.

There's a critical piece missing here, which is why an RMP violation is thrown
on "in-use" pages.  E.g. are any translations problematic, or just writable
translations?  It may not affect the actual KVM workaround, but knowing exactly
what goes awry is important.

> e.g.
> 
> 1. A VMCB was allocated on 2MB-aligned address.
> 2. The VMRUN instruction marks this RMP entry as "in-use".
> 3. Another process allocated some other page of memory that happened to be
>    within the same 2MB region.
> 4. That process tried to write its page using physmap.

Please explicitly call out the relevance of the physmap.  IIUC, only the physmap,
a.k.a. direct map, is problematic because that's the only scenario where a large
page can overlap one of the magic pages.  That should be explicitly stated.

> If the physmap entry in step #4 uses a large (1G/2M) page, then the

Be consistent with 2MB vs. 2M, i.e. choose one.

> hardware will attempt to create a 2M TLB entry. The hardware will find
> that the "in-use" bit is set in the RMP entry (because it was a
> VMCB page) and will cause an RMP violation check.

So what happens if the problematic page isn't 2mb aligned?  The lack of an RMP
violation on access implies that the hypervisor can bypass the in-use restriction
and create a 2mb hugepage, i.e. access the in-use page.  Same question for if the
TLB entry exists before the page is marked in-use, which also begs the question
of why the in-use flag is being checked at all on RMP lookups.

> See APM2 section 15.36.12 for more information on VMRUN checks when
> SEV-SNP is globally active.
> 
> A generic allocator can return a page which are 2M aligned and will not
> be safe to be used when SEV-SNP is globally enabled.

> Add a snp_safe_alloc_page() helper that can be used for allocating the SNP
> safe memory. The helper allocated 2 pages and splits them into order-1
> allocation. It frees one page and keeps one of the page which is not 2M
> aligned.

I know it's personal preference as to whether to lead with the solution or the
problem statement, but in this case it would be very helpful to at least provide
a brief summary early on so that the reader has some idea of where the changelog
is headed.  As is, the actual change is buried after a big pile of hardware
details.

E.g. something like this

  Implement a workaround for an SNP erratum where the CPU will incorrectly
  signal an RMP violation #PF if a hugepage (2mb or 1gb) collides with the
  RMP entry of a VMCB, VMSA, or AVIC backing page.

  When SEV-SNP is globally enabled, the CPU marks the VMCB, VMSA, and AVIC
  backing   pages as "in-use" in the RMP after a successful VMRUN.  This is
  done for _all_   VMs, not just SNP-Active VMs.

  If the hypervisor accesses an in-use page through a writable translation,
  the CPU will throw an RMP violation #PF.  On early SNP hardware, if an
  in-use page is 2mb aligned and software accesses any part of the associated
  2mb region with a hupage, the CPU will incorrectly treat the entire 2mb
  region as in-use and signal a spurious RMP violation #PF.

  <gory details on the workaround>

> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> ---
>  arch/x86/include/asm/kvm_host.h |  1 +
>  arch/x86/kvm/lapic.c            |  5 ++++-
>  arch/x86/kvm/svm/sev.c          | 27 +++++++++++++++++++++++++++
>  arch/x86/kvm/svm/svm.c          | 16 ++++++++++++++--
>  arch/x86/kvm/svm/svm.h          |  1 +
>  5 files changed, 47 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index 55efbacfc244..188110ab2c02 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -1383,6 +1383,7 @@ struct kvm_x86_ops {
>  	int (*complete_emulated_msr)(struct kvm_vcpu *vcpu, int err);
>  
>  	void (*vcpu_deliver_sipi_vector)(struct kvm_vcpu *vcpu, u8 vector);
> +	void *(*alloc_apic_backing_page)(struct kvm_vcpu *vcpu);
>  };
>  
>  struct kvm_x86_nested_ops {
> diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
> index c0ebef560bd1..d4c77f66d7d5 100644
> --- a/arch/x86/kvm/lapic.c
> +++ b/arch/x86/kvm/lapic.c
> @@ -2441,7 +2441,10 @@ int kvm_create_lapic(struct kvm_vcpu *vcpu, int timer_advance_ns)
>  
>  	vcpu->arch.apic = apic;
>  
> -	apic->regs = (void *)get_zeroed_page(GFP_KERNEL_ACCOUNT);
> +	if (kvm_x86_ops.alloc_apic_backing_page)
> +		apic->regs = kvm_x86_ops.alloc_apic_backing_page(vcpu);

This can be a static_call().

> +	else
> +		apic->regs = (void *)get_zeroed_page(GFP_KERNEL_ACCOUNT);
>  	if (!apic->regs) {
>  		printk(KERN_ERR "malloc apic regs error for vcpu %x\n",
>  		       vcpu->vcpu_id);
> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index b8505710c36b..411ed72f63af 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -2692,3 +2692,30 @@ void sev_vcpu_deliver_sipi_vector(struct kvm_vcpu *vcpu, u8 vector)
>  		break;
>  	}
>  }
> +
> +struct page *snp_safe_alloc_page(struct kvm_vcpu *vcpu)
> +{
> +	unsigned long pfn;
> +	struct page *p;
> +
> +	if (!cpu_feature_enabled(X86_FEATURE_SEV_SNP))
> +		return alloc_page(GFP_KERNEL_ACCOUNT | __GFP_ZERO);
> +
> +	p = alloc_pages(GFP_KERNEL_ACCOUNT | __GFP_ZERO, 1);
> +	if (!p)
> +		return NULL;
> +
> +	/* split the page order */
> +	split_page(p, 1);
> +
> +	/* Find a non-2M aligned page */

This isn't "finding" anything, it's identifying which of the two pages is
_guaranteed_ to be unaligned.  The whole function needs a much bigger comment to
explain what's going on.

> +	pfn = page_to_pfn(p);
> +	if (IS_ALIGNED(__pfn_to_phys(pfn), PMD_SIZE)) {
> +		pfn++;
> +		__free_page(p);
> +	} else {
> +		__free_page(pfn_to_page(pfn + 1));
> +	}
> +
> +	return pfn_to_page(pfn);
> +}
