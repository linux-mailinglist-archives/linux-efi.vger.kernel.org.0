Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A47173CBBB9
	for <lists+linux-efi@lfdr.de>; Fri, 16 Jul 2021 20:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231700AbhGPSSC (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 16 Jul 2021 14:18:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbhGPSSB (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 16 Jul 2021 14:18:01 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB90FC06175F
        for <linux-efi@vger.kernel.org>; Fri, 16 Jul 2021 11:15:06 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d12so9599943pfj.2
        for <linux-efi@vger.kernel.org>; Fri, 16 Jul 2021 11:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wVN/iDIudUuTtvffNdHVJek4W2vj0jwmUlaVHOVcX6g=;
        b=k5qWLNHzSnnWN0UAxjp03hvk7WlSuNe7oMs/qkUkZqoD+Gh+CjdDdFA5IriWV0hLXc
         St1QHeoPM6fZ3bDQT70Et/jissBJZoORHIo/zH6SP5BK7LLS/HGEI5LUnlAn3Kx4P72B
         CvCxJ7wDGFaawPhPzbVHO5mJ9ka40eSz+E3wwCB4hbNr+m38+X8VxlrKd3Z9QEe52f9z
         y8lMZUeY3UOdsXfE7aCDTt47ep3SpBzp5pE4RgxW3jl76KgTaRDPdeQYBD7MArSGDC1a
         tH4v2gktiah865XZOC00Z3Yk7yp+iyIFok/BsUV0/mfjqR0xGbA7YikRaIKzJsmi4jTX
         u2uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wVN/iDIudUuTtvffNdHVJek4W2vj0jwmUlaVHOVcX6g=;
        b=ExRfexjpuTlhxE2zcDLfi3uL50PfvF5LfT+uZSelPmv4SriQpMHrB9pSLfgoN8dwQR
         08tIkG9emwROAECxSHL3jhwxEIY/ms4wmvEgopWMZLEhdZ934cbBEwjKyb3C4cPQBqfF
         9wR6Q3OZqk++lNmE8xGmTJ4l3MpZlNMu4GcEwRKoEiBQhaN58DrE+1cXAM6ar/3Z2vAY
         /7E+tbcrHH8RmN3qIChrfqOzvSQX+QTBtj2Tj/5mGUktMXonOA8RUuIiEOyC3cqypVYC
         CjakxdbQmWSgHKoszcxmYLWOyDHRgRD4Ns60RXhjdloMfwCy3oKzbqUA2+E4Yu2i/33b
         mD6A==
X-Gm-Message-State: AOAM532oZFSUnbF4c4WSoR9rnUbGwnfbbZJtTPmaxG1JL4f9uEDa3x9z
        /kwAKq8poQ478yuZNhwb2YlYrQ==
X-Google-Smtp-Source: ABdhPJwqkeRsF0AqS7WZlEi3YZgikjlqMKKoxNpFJjn1zdkxP4d6bPR7B7wmtTWFz4cDReGQ2fcWdA==
X-Received: by 2002:a63:4302:: with SMTP id q2mr11128659pga.428.1626459306182;
        Fri, 16 Jul 2021 11:15:06 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id k8sm2825228pfu.116.2021.07.16.11.15.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 11:15:05 -0700 (PDT)
Date:   Fri, 16 Jul 2021 18:15:01 +0000
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
Subject: Re: [PATCH Part2 RFC v4 28/40] KVM: X86: Introduce
 kvm_mmu_map_tdp_page() for use by SEV
Message-ID: <YPHMpep+AqGQg6sX@google.com>
References: <20210707183616.5620-1-brijesh.singh@amd.com>
 <20210707183616.5620-29-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210707183616.5620-29-brijesh.singh@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Jul 07, 2021, Brijesh Singh wrote:
> +int kvm_mmu_map_tdp_page(struct kvm_vcpu *vcpu, gpa_t gpa, u32 error_code, int max_level)
> +{
> +	int r;
> +
> +	/*
> +	 * Loop on the page fault path to handle the case where an mmu_notifier
> +	 * invalidation triggers RET_PF_RETRY.  In the normal page fault path,
> +	 * KVM needs to resume the guest in case the invalidation changed any
> +	 * of the page fault properties, i.e. the gpa or error code.  For this
> +	 * path, the gpa and error code are fixed by the caller, and the caller
> +	 * expects failure if and only if the page fault can't be fixed.
> +	 */
> +	do {
> +		r = direct_page_fault(vcpu, gpa, error_code, false, max_level, true);
> +	} while (r == RET_PF_RETRY);
> +
> +	return r;

This implementation is completely broken, which in turn means that the page state
change code is not well tested.  The mess is likely masked to some extent because
the call is bookendeda by calls to kvm_mmu_get_tdp_walk(), i.e. most of the time
it's not called, and when it is called, the bugs are hidden by the second walk
detecting that the mapping was not installed.

  1. direct_page_fault() does not return a pfn, it returns the action that should
     be taken by the caller.
  2. The while() can be optimized to bail on no_slot PFNs.
  3. mmu_topup_memory_caches() needs to be called here, otherwise @pfn will be
     uninitialized.  The alternative would be to set @pfn when that fails in
     direct_page_fault().
  4. The 'int' return value is wrong, it needs to be kvm_pfn_t.

A correct implementation can be found in the TDX series, the easiest thing would
be to suck in those patches.

https://lore.kernel.org/kvm/ceffc7ef0746c6064330ef5c30bc0bb5994a1928.1625186503.git.isaku.yamahata@intel.com/
https://lore.kernel.org/kvm/a7e7602375e1f63b32eda19cb8011f11794ebe28.1625186503.git.isaku.yamahata@intel.com/

> +}
> +EXPORT_SYMBOL_GPL(kvm_mmu_map_tdp_page);
> +
>  static void nonpaging_init_context(struct kvm_vcpu *vcpu,
>  				   struct kvm_mmu *context)
>  {
> -- 
> 2.17.1
> 
