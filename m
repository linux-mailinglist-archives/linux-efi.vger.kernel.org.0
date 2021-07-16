Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B14D13CBC50
	for <lists+linux-efi@lfdr.de>; Fri, 16 Jul 2021 21:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232769AbhGPTWd (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 16 Jul 2021 15:22:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231835AbhGPTWc (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 16 Jul 2021 15:22:32 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C24FCC061764
        for <linux-efi@vger.kernel.org>; Fri, 16 Jul 2021 12:19:37 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id o201so9735956pfd.1
        for <linux-efi@vger.kernel.org>; Fri, 16 Jul 2021 12:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CMxsegN9/pDXYBKxe7UwyVXicqaFeZn3rifdAcF2qZg=;
        b=rS4TY6rHsY/KjSmw6Iv+myZMTNRXzYbO9bcmbGkqqiqU1+ScWtuk8Q1I7Cq9jbDTF7
         OHsZHjcD83y6o0JBWXaPSofM0NbUk47agJgF3tDDRfh+ytd+WlvAeTuNLSZWTOSiuNRG
         bPliFj0DiFVYuywSB5Q/49lAKp7qMkMWHGwzV7mMLRPrXfjIfEb3sKdYtsnJxn9XorNX
         BUWFOUamnshiugQDeUO0S2qsKjSvR6LEKATjgnbXW94kK8IKg/mBgWvItbHkppY6eX7s
         O+tm8j4JFbB4G7wCD/gtrAYvTf9Ru5bZ7qZnfAz0jmquO0PMjISfpdl1TFfqEdK5Za8u
         wAww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CMxsegN9/pDXYBKxe7UwyVXicqaFeZn3rifdAcF2qZg=;
        b=magLdTfEfO6oNiu9VnvH8deexpwZHGBaSnKpAYt2FXhlDE+Ac+A3w9uKCjGXEQivcI
         71l+cx3gTslVk3ycTt4PuEJWLybKf+32vE1J1PL+Ol9ETy5OMhQgpX9YVsifOdayrHN2
         2EV2fCcExPgRpdIvnqJe4XZI376HAT7yeKj0SWEOK+6huraL/VOQiE6eEORO6OQKduxL
         71dasen8SqWo4WLEEjeGN1iMpHiqvKcJGhiZIfJCQf4/YmjXfTMf2lDPmeJiO+MgLNc/
         IShbTPX0ou8zkoH9ioEVO1oHQEc0L0X/VqkbEL2Tu4vqMtndJ6/46TT3saQOxXTGfyt1
         izTg==
X-Gm-Message-State: AOAM533uZBLWX2XtykcV9w2TPr2xQdaDa4wRfr+xrR35wGCOS7LXj6MZ
        DXlMfDfheH6TVMKV/x0fllrA8A==
X-Google-Smtp-Source: ABdhPJxDvmu5QciLa4F4cC9ADiZzavTxAWdwoshc8NrRwhKE3Q/y33rI8zX0dAcWjPw16gCa0ZftfA==
X-Received: by 2002:a65:5684:: with SMTP id v4mr11559281pgs.388.1626463176925;
        Fri, 16 Jul 2021 12:19:36 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id h24sm11476743pfn.180.2021.07.16.12.19.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 12:19:36 -0700 (PDT)
Date:   Fri, 16 Jul 2021 19:19:32 +0000
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
Subject: Re: [PATCH Part2 RFC v4 27/40] KVM: X86: Add kvm_x86_ops to get the
 max page level for the TDP
Message-ID: <YPHbxAVbuFk6Xtkj@google.com>
References: <20210707183616.5620-1-brijesh.singh@amd.com>
 <20210707183616.5620-28-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210707183616.5620-28-brijesh.singh@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Jul 07, 2021, Brijesh Singh wrote:
> When running an SEV-SNP VM, the sPA used to index the RMP entry is
> obtained through the TDP translation (gva->gpa->spa). The TDP page
> level is checked against the page level programmed in the RMP entry.
> If the page level does not match, then it will cause a nested page
> fault with the RMP bit set to indicate the RMP violation.
> 
> To keep the TDP and RMP page level's in sync, the KVM fault handle
> kvm_handle_page_fault() will call get_tdp_max_page_level() to get
> the maximum allowed page level so that it can limit the TDP level.
> 
> In the case of SEV-SNP guest, the get_tdp_max_page_level() will consult
> the RMP table to compute the maximum allowed page level for a given
> GPA.
> 
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> ---
>  arch/x86/include/asm/kvm_host.h |  1 +
>  arch/x86/kvm/mmu/mmu.c          |  6 ++++--
>  arch/x86/kvm/svm/sev.c          | 20 ++++++++++++++++++++
>  arch/x86/kvm/svm/svm.c          |  1 +
>  arch/x86/kvm/svm/svm.h          |  1 +
>  arch/x86/kvm/vmx/vmx.c          |  8 ++++++++
>  6 files changed, 35 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index 188110ab2c02..cd2e19e1d323 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -1384,6 +1384,7 @@ struct kvm_x86_ops {
>  
>  	void (*vcpu_deliver_sipi_vector)(struct kvm_vcpu *vcpu, u8 vector);
>  	void *(*alloc_apic_backing_page)(struct kvm_vcpu *vcpu);
> +	int (*get_tdp_max_page_level)(struct kvm_vcpu *vcpu, gpa_t gpa, int max_level);

This is a poor name.  The constraint comes from the RMP, not TDP, and technically
speaking applies to all forms of paging.  It just happens to be relevant only to
TDP because NPT is required for SNP.  And KVM already incorporates the max TDP
level in kvm_configure_mmu().

Regarding the params, I'd much prefer to have this take "struct kvm *kvm" instead
of the vCPU.  It obviously doesn't change the functionality in any way, but I'd
like it to be clear to readers that the adjustment is tied to the VM, not the vCPU.

I think I'd also vote to drop @max_level and make this a pure constraint input as
opposed to an adjuster.

Another option would be to drop the kvm_x86_ops hooks entirely and call
snp_lookup_page_in_rmptable() directly from MMU code.  That would require tracking
that a VM is SNP-enabled in arch code, but I'm pretty sure info has already bled
into common KVM in one form or another.

>  };
>  
>  struct kvm_x86_nested_ops {
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 0144c40d09c7..7991ffae7b31 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -3781,11 +3781,13 @@ static int direct_page_fault(struct kvm_vcpu *vcpu, gpa_t gpa, u32 error_code,
>  static int nonpaging_page_fault(struct kvm_vcpu *vcpu, gpa_t gpa,
>  				u32 error_code, bool prefault)
>  {
> +	int max_level = kvm_x86_ops.get_tdp_max_page_level(vcpu, gpa, PG_LEVEL_2M);

This is completely bogus, nonpaging_page_fault() is used iff TDP is disabled.

> +
>  	pgprintk("%s: gva %lx error %x\n", __func__, gpa, error_code);
>  
>  	/* This path builds a PAE pagetable, we can map 2mb pages at maximum. */
>  	return direct_page_fault(vcpu, gpa & PAGE_MASK, error_code, prefault,
> -				 PG_LEVEL_2M, false);
> +				 max_level, false);
>  }
>  
>  int kvm_handle_page_fault(struct kvm_vcpu *vcpu, u64 error_code,
> @@ -3826,7 +3828,7 @@ int kvm_tdp_page_fault(struct kvm_vcpu *vcpu, gpa_t gpa, u32 error_code,
>  {
>  	int max_level;
>  
> -	for (max_level = KVM_MAX_HUGEPAGE_LEVEL;
> +	for (max_level = kvm_x86_ops.get_tdp_max_page_level(vcpu, gpa, KVM_MAX_HUGEPAGE_LEVEL);

This is unnecessary.  The max mapping level is computed by factoring in all
constraints, of which there are many.  In this case, KVM is consulting the guest's
MTRR configuration to avoid creating a page that spans different memtypes (because
the guest MTRRs are effectively represented in the TDP PTE).  SNP's RMP constraints
have no relevance to the MTRR constraint, or any other constraint for that matter.

TL;DR: the RMP constraint belong in kvm_mmu_max_mapping_level() and nowhere else.
I would go so far as to argue it belong in host_pfn_mapping_level(), after the
call to lookup_address_in_mm().

>  	     max_level > PG_LEVEL_4K;
>  	     max_level--) {
>  		int page_num = KVM_PAGES_PER_HPAGE(max_level);
> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index 3f8824c9a5dc..fd2d00ad80b7 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -3206,3 +3206,23 @@ struct page *snp_safe_alloc_page(struct kvm_vcpu *vcpu)
>  
>  	return pfn_to_page(pfn);
>  }
> +
> +int sev_get_tdp_max_page_level(struct kvm_vcpu *vcpu, gpa_t gpa, int max_level)
> +{
> +	struct rmpentry *e;
> +	kvm_pfn_t pfn;
> +	int level;
> +
> +	if (!sev_snp_guest(vcpu->kvm))

I can't tell if this check is correct.  Per the APM:

  When SEV-SNP is enabled globally, the processor places restrictions on all memory
  accesses based on the contents of the RMP, whether the accesses are performed by
  the hypervisor, a legacy guest VM, a non-SNP guest VM or an SNP-active guest VM.
  The processor may perform one or more of the following checks depending on the
  context of the access:

  ...

  Page-Size: Checks that the following conditions are met:
    - If the nested page table indicates a 2MB or 1GB page size, the Page_Size field
      of the RMP entry of the target page is 1.
    - If the nested page table indicates a 4KB page size, the Page_Size field of the
      RMP entry of the target page is 0.

The Page-Size bullet does not have any qualifiers about the NPT checks applying
only to SNP guests.  The Hypervisor-Owned bullet implies that unassigned pages
do not need to have identical sizes, but it's not clear whether or not so called
"Hypervisor-Owned" pages override the nested page tables.

Table 15.36 is similarly vague:

  Assigned Flag indicating that the system physical page is assigned to a guest
  or to the AMD-SP.
    0: Owned by the hypervisor
    1: Owned by a guest or the AMD-SP

My assumption is that all of the "guest owned" stuff really means "SNP guest owned",
e.g. section 15.36.5 says "The hypervisor manages the SEV-SNP security attributes of
pages assigned to SNP-active guests by altering the RMP entries of those pages", but
that's not at all clear throughout most of the RMP documentation.

Regardless of the actual behavior, the APM needs serious cleanup on the aforementioned
sections.  E.g. as written, the "processor may perform one or more of the following
checks depending on the context of the access" verbiage basically gives the CPU carte
blanche to do whatever the hell it wants.

> +		return max_level;
> +
> +	pfn = gfn_to_pfn(vcpu->kvm, gpa_to_gfn(gpa));
> +	if (is_error_noslot_pfn(pfn))
> +		return max_level;
> +
> +	e = snp_lookup_page_in_rmptable(pfn_to_page(pfn), &level);

Assuming pfn is backed by struct page is broken, at least given the existing
call sites..  It might hold true that only struct page pfns are covered by the
RMP, but assuming pfn_to_page() will return a valid pointer here is completely
wrong.  Unless I'm missing something, taking a struct page anywhere in the RMP
helpers is at best sketchy and at worst broken in and of itself.  IMO, the RMP
code should always take a raw PFN and do the necessary checks before assuming
anything about the PFN.  At a glance, the only case that needs additional checks
is the page_to_virt() logic in rmpupdate().

> +	if (unlikely(!e))
> +		return max_level;
> +
> +	return min_t(uint32_t, level, max_level);

As the APM is currently worded, this is wrong, and the whole "tdp_max_page_level"
name is wrong.  As noted above, the Page-Size bullet points states that 2mb/1gb
pages in the NPT _must_ have RMP.page_size=1, and 4kb pages in the NPT _must_
have RMP.page_size=0.  That means that the RMP adjustment is not a constraint,
it's an exact requirement.  Specifically, if the RMP is a 2mb page then KVM must
install a 2mb (or 1gb) page.  Maybe it works because KVM will PSMASH the RMP
after installing a bogus 4kb NPT and taking an RMP violation, but that's a very
convoluted and sub-optimal solution.

That other obvious bug is that this doesn't play nice with 1gb pages.  A 2mb RMP
entry should _not_ force KVM to use a 2mb page instead of a 1gb page.

> +}
