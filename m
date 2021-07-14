Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40C6A3C8562
	for <lists+linux-efi@lfdr.de>; Wed, 14 Jul 2021 15:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232326AbhGNNib (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 14 Jul 2021 09:38:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232249AbhGNNia (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 14 Jul 2021 09:38:30 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3688C061765
        for <linux-efi@vger.kernel.org>; Wed, 14 Jul 2021 06:35:37 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id g8so1823806qth.10
        for <linux-efi@vger.kernel.org>; Wed, 14 Jul 2021 06:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gezvR5OfWZEWK2TINd2PVmo/b1ZbFygnVhycPzHy+1c=;
        b=iIy+9GSk+zYyAeMPjHL4uxaQ+VRSxHyvLemv6SdeDForAaOLO96KR6F4Oirhi6E4mT
         dRQSiEO63qs8RIylfOlbHut9wIAE3UKvoUwo1dHevzTGpDEVY/ZjLw4piW1Bxy0tIC1p
         FZD21VNTrLIh/awNsx50LT0NfrI5d85JM6UaNeCwk4t9KcRv2XADcMeepIWVgx2Xsqx9
         q3AgIVFayuSe7UduLS/mKtyGoeabwpwL8292TftpMQZzaYhYSI0P3uBXw9/OMIDLn9+F
         mpjW5cGWLQBjpT33lLmlgQwgcwipQg86TKe44W3/kRJBp4S818Njgg4CFZo8kjEVY450
         A7Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gezvR5OfWZEWK2TINd2PVmo/b1ZbFygnVhycPzHy+1c=;
        b=q+ce+BntwctgPmNWs6oME89hL73W6s2GJCGAwLS+j0GKZnVQX5aReJBzuN4Xs9bDjh
         q8ZtMH9K2cWbY/JXdSMWh6K8gs3fD3tuP7LMwAF6SQHwmutCm05ZLUhNPcuYiAxVKk1e
         qYt2X/JhuefKmusssLxQYjyWKnVQaAXLGQEMIX/y9n+qKe5Z/+8M0j6fDMcbWwlFClqZ
         D22FyUb6VxogPNizD3XtyvubALJJe7qUmW9ZXhA5zQEMxe/2FVRgHRT/HwM3cbxuT9GB
         CNtJsa9X2N7+Gvx9fo9Uc+roVF+b/x6/phOsuDL8824ZyqeQhBXLfWKh1m2lL9QBMidM
         SDeA==
X-Gm-Message-State: AOAM530/U5NskcZtqgQFhW71AM3Qbd2CbNW9q0dNlUVzm3Vte9yYvgaF
        U2/qxY61xigOLlc/WLUFgcWofAphFx2W2iLGoEDPGO6AvBPJA+2x
X-Google-Smtp-Source: ABdhPJypSv0TU7nBnxqsDHmSUMM1jMnGMe3CBMSxE5apXqTiTt8f2xDtYPwfN2OTi2rinidVsdixs65t6ruo5TJDyGw=
X-Received: by 2002:a05:622a:409:: with SMTP id n9mr9370891qtx.261.1626269736594;
 Wed, 14 Jul 2021 06:35:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210707183616.5620-1-brijesh.singh@amd.com> <20210707183616.5620-21-brijesh.singh@amd.com>
In-Reply-To: <20210707183616.5620-21-brijesh.singh@amd.com>
From:   Marc Orr <marcorr@google.com>
Date:   Wed, 14 Jul 2021 06:35:25 -0700
Message-ID: <CAA03e5FMD8xvvBdf9gqdoR05xF9+scLZBNLpx9iP6WVWK84xdw@mail.gmail.com>
Subject: Re: [PATCH Part2 RFC v4 20/40] KVM: SVM: Make AVIC backing, VMSA and
 VMCB memory allocation SNP safe
To:     Brijesh Singh <brijesh.singh@amd.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        kvm list <kvm@vger.kernel.org>, linux-efi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-coco@lists.linux.dev,
        linux-mm@kvack.org, linux-crypto@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
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
        Borislav Petkov <bp@alien8.de>,
        Michael Roth <michael.roth@amd.com>,
        Vlastimil Babka <vbabka@suse.cz>, tony.luck@intel.com,
        npmccallum@redhat.com, brijesh.ksingh@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Jul 7, 2021 at 11:38 AM Brijesh Singh <brijesh.singh@amd.com> wrote:
>
> When SEV-SNP is globally enabled on a system, the VMRUN instruction
> performs additional security checks on AVIC backing, VMSA, and VMCB page.
> On a successful VMRUN, these pages are marked "in-use" by the
> hardware in the RMP entry, and any attempt to modify the RMP entry for
> these pages will result in page-fault (RMP violation check).
>
> While performing the RMP check, hardware will try to create a 2MB TLB
> entry for the large page accesses. When it does this, it first reads
> the RMP for the base of 2MB region and verifies that all this memory is
> safe. If AVIC backing, VMSA, and VMCB memory happen to be the base of
> 2MB region, then RMP check will fail because of the "in-use" marking for
> the base entry of this 2MB region.
>
> e.g.
>
> 1. A VMCB was allocated on 2MB-aligned address.
> 2. The VMRUN instruction marks this RMP entry as "in-use".
> 3. Another process allocated some other page of memory that happened to be
>    within the same 2MB region.
> 4. That process tried to write its page using physmap.
>
> If the physmap entry in step #4 uses a large (1G/2M) page, then the
> hardware will attempt to create a 2M TLB entry. The hardware will find
> that the "in-use" bit is set in the RMP entry (because it was a
> VMCB page) and will cause an RMP violation check.
>
> See APM2 section 15.36.12 for more information on VMRUN checks when
> SEV-SNP is globally active.
>
> A generic allocator can return a page which are 2M aligned and will not
> be safe to be used when SEV-SNP is globally enabled. Add a
> snp_safe_alloc_page() helper that can be used for allocating the
> SNP safe memory. The helper allocated 2 pages and splits them into order-1
> allocation. It frees one page and keeps one of the page which is not
> 2M aligned.
>
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>

Co-developed-by: Marc Orr <marcorr@google.com>

The original version of this patch had this tag. I think it got
dropped on accident.

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
>         int (*complete_emulated_msr)(struct kvm_vcpu *vcpu, int err);
>
>         void (*vcpu_deliver_sipi_vector)(struct kvm_vcpu *vcpu, u8 vector);
> +       void *(*alloc_apic_backing_page)(struct kvm_vcpu *vcpu);
>  };
>
>  struct kvm_x86_nested_ops {
> diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
> index c0ebef560bd1..d4c77f66d7d5 100644
> --- a/arch/x86/kvm/lapic.c
> +++ b/arch/x86/kvm/lapic.c
> @@ -2441,7 +2441,10 @@ int kvm_create_lapic(struct kvm_vcpu *vcpu, int timer_advance_ns)
>
>         vcpu->arch.apic = apic;
>
> -       apic->regs = (void *)get_zeroed_page(GFP_KERNEL_ACCOUNT);
> +       if (kvm_x86_ops.alloc_apic_backing_page)
> +               apic->regs = kvm_x86_ops.alloc_apic_backing_page(vcpu);
> +       else
> +               apic->regs = (void *)get_zeroed_page(GFP_KERNEL_ACCOUNT);
>         if (!apic->regs) {
>                 printk(KERN_ERR "malloc apic regs error for vcpu %x\n",
>                        vcpu->vcpu_id);
> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index b8505710c36b..411ed72f63af 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -2692,3 +2692,30 @@ void sev_vcpu_deliver_sipi_vector(struct kvm_vcpu *vcpu, u8 vector)
>                 break;
>         }
>  }
> +
> +struct page *snp_safe_alloc_page(struct kvm_vcpu *vcpu)
> +{
> +       unsigned long pfn;
> +       struct page *p;
> +
> +       if (!cpu_feature_enabled(X86_FEATURE_SEV_SNP))
> +               return alloc_page(GFP_KERNEL_ACCOUNT | __GFP_ZERO);
> +
> +       p = alloc_pages(GFP_KERNEL_ACCOUNT | __GFP_ZERO, 1);
> +       if (!p)
> +               return NULL;
> +
> +       /* split the page order */
> +       split_page(p, 1);
> +
> +       /* Find a non-2M aligned page */
> +       pfn = page_to_pfn(p);
> +       if (IS_ALIGNED(__pfn_to_phys(pfn), PMD_SIZE)) {
> +               pfn++;
> +               __free_page(p);
> +       } else {
> +               __free_page(pfn_to_page(pfn + 1));
> +       }
> +
> +       return pfn_to_page(pfn);
> +}
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index 2acf187a3100..a7adf6ca1713 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -1336,7 +1336,7 @@ static int svm_create_vcpu(struct kvm_vcpu *vcpu)
>         svm = to_svm(vcpu);
>
>         err = -ENOMEM;
> -       vmcb01_page = alloc_page(GFP_KERNEL_ACCOUNT | __GFP_ZERO);
> +       vmcb01_page = snp_safe_alloc_page(vcpu);
>         if (!vmcb01_page)
>                 goto out;
>
> @@ -1345,7 +1345,7 @@ static int svm_create_vcpu(struct kvm_vcpu *vcpu)
>                  * SEV-ES guests require a separate VMSA page used to contain
>                  * the encrypted register state of the guest.
>                  */
> -               vmsa_page = alloc_page(GFP_KERNEL_ACCOUNT | __GFP_ZERO);
> +               vmsa_page = snp_safe_alloc_page(vcpu);
>                 if (!vmsa_page)
>                         goto error_free_vmcb_page;
>
> @@ -4439,6 +4439,16 @@ static int svm_vm_init(struct kvm *kvm)
>         return 0;
>  }
>
> +static void *svm_alloc_apic_backing_page(struct kvm_vcpu *vcpu)
> +{
> +       struct page *page = snp_safe_alloc_page(vcpu);
> +
> +       if (!page)
> +               return NULL;
> +
> +       return page_address(page);
> +}
> +
>  static struct kvm_x86_ops svm_x86_ops __initdata = {
>         .hardware_unsetup = svm_hardware_teardown,
>         .hardware_enable = svm_hardware_enable,
> @@ -4564,6 +4574,8 @@ static struct kvm_x86_ops svm_x86_ops __initdata = {
>         .complete_emulated_msr = svm_complete_emulated_msr,
>
>         .vcpu_deliver_sipi_vector = svm_vcpu_deliver_sipi_vector,
> +
> +       .alloc_apic_backing_page = svm_alloc_apic_backing_page,
>  };
>
>  static struct kvm_x86_init_ops svm_init_ops __initdata = {
> diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
> index 5f874168551b..1175edb02d33 100644
> --- a/arch/x86/kvm/svm/svm.h
> +++ b/arch/x86/kvm/svm/svm.h
> @@ -554,6 +554,7 @@ void sev_es_create_vcpu(struct vcpu_svm *svm);
>  void sev_vcpu_deliver_sipi_vector(struct kvm_vcpu *vcpu, u8 vector);
>  void sev_es_prepare_guest_switch(struct vcpu_svm *svm, unsigned int cpu);
>  void sev_es_unmap_ghcb(struct vcpu_svm *svm);
> +struct page *snp_safe_alloc_page(struct kvm_vcpu *vcpu);
>
>  /* vmenter.S */
>
> --
> 2.17.1
>
>
