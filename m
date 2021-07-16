Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2262A3CBE1C
	for <lists+linux-efi@lfdr.de>; Fri, 16 Jul 2021 23:00:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232957AbhGPVDg (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 16 Jul 2021 17:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233454AbhGPVDf (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 16 Jul 2021 17:03:35 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 543FDC061762
        for <linux-efi@vger.kernel.org>; Fri, 16 Jul 2021 14:00:39 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id y4so9915451pfi.9
        for <linux-efi@vger.kernel.org>; Fri, 16 Jul 2021 14:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=32owgdGkkMeFKYJKP96aJ0cepPQZmV7ASPwAnVQdyQ8=;
        b=mWGfXWGNFAoNVa/XQEMEHBGq3nEvz+50vTLu166iLOmPRHDnbyzkms0w3ML3zNZeWP
         GVWuqECe5KirV8LFrcLji/GmzrQ7GVbVpBIE3e5EzaXDLr6WyUx5EmX+jj1MebxKkklO
         4FV8/YtI4QEurHcBfFD436NAdnosWqA7ukGoXATVmBIhLQbTxj1nAy4LNBJ4Rs+/Y1gn
         frv72OoilRYqDRBvJQD2gN25MIilFA3t3XV9nKRiPei7WUH6uGHQRcrdLe3+TebOCdDS
         53ONDWobK9c65N8sBOfetN8OnTEMw4ULi/OqXPosKkR+Pd3UuFCKTM65gtt0ZUlrb545
         JcAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=32owgdGkkMeFKYJKP96aJ0cepPQZmV7ASPwAnVQdyQ8=;
        b=d7u5ID+t0DVCvyw+bXVDfZWQwX7K4bfH54k4yz+dYBDj0yoz3LI3BQ6js7aV8yTXF1
         nmR2euFovi6oZ6CNzEehiRBiD63K7cDETLT71Bnho0g3Y+Ikzo5MKEMgFXyaAUEmf3ut
         G8lBo4ABHy6BusJxoz6dQfzax9sOiEu7sYFVsx7FDpqW1AL2eG1OiWvaBG/Ft1jIApkB
         ArUIf60unE2uDFl2miWSsjfZFznso2wlbTameEL0qpPtpVo57uTL2ydbJ0hZfoLqe6qg
         Ak/CuBGzlnx2/G09V1xIZFjw2bx9e7VffCiDw5bIl5QNqA19IVGisKrsIvnhSzSgG7rz
         6WNQ==
X-Gm-Message-State: AOAM533edTf0GXPrAsYlaJQw/eQ1r4z0gtD7+lyNEjrr2d5m/WcnjK8/
        U5lkIFlhJhYCYtCVjVHLBU1xYw==
X-Google-Smtp-Source: ABdhPJwjG+4AKAUsolr4NhSH0onD6XOfm/OvTT2xz/g+OQ4KDyJFfI4r0VZGJsgBVJZPZ187YQk3wQ==
X-Received: by 2002:a62:520e:0:b029:30b:fc21:975d with SMTP id g14-20020a62520e0000b029030bfc21975dmr12345822pfb.57.1626469238280;
        Fri, 16 Jul 2021 14:00:38 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id f18sm6484622pfe.25.2021.07.16.14.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 14:00:37 -0700 (PDT)
Date:   Fri, 16 Jul 2021 21:00:34 +0000
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
Subject: Re: [PATCH Part2 RFC v4 33/40] KVM: SVM: Add support to handle MSR
 based Page State Change VMGEXIT
Message-ID: <YPHzcstus9mS8hOm@google.com>
References: <20210707183616.5620-1-brijesh.singh@amd.com>
 <20210707183616.5620-34-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210707183616.5620-34-brijesh.singh@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Jul 07, 2021, Brijesh Singh wrote:
> +static int __snp_handle_psc(struct kvm_vcpu *vcpu, int op, gpa_t gpa, int level)

I can live with e.g. GHCB_MSR_PSC_REQ, but I'd strongly prefer to spell this out,
e.g. __snp_handle_page_state_change() or whatever.  I had a hell of a time figuring
out what PSC was the first time I saw it in some random context.

> +{
> +	struct kvm *kvm = vcpu->kvm;
> +	int rc, tdp_level;
> +	kvm_pfn_t pfn;
> +	gpa_t gpa_end;
> +
> +	gpa_end = gpa + page_level_size(level);
> +
> +	while (gpa < gpa_end) {
> +		/*
> +		 * Get the pfn and level for the gpa from the nested page table.
> +		 *
> +		 * If the TDP walk failed, then its safe to say that we don't have a valid
> +		 * mapping for the gpa in the nested page table. Create a fault to map the
> +		 * page is nested page table.
> +		 */
> +		if (!kvm_mmu_get_tdp_walk(vcpu, gpa, &pfn, &tdp_level)) {
> +			pfn = kvm_mmu_map_tdp_page(vcpu, gpa, PFERR_USER_MASK, level);
> +			if (is_error_noslot_pfn(pfn))
> +				goto out;
> +
> +			if (!kvm_mmu_get_tdp_walk(vcpu, gpa, &pfn, &tdp_level))
> +				goto out;
> +		}
> +
> +		/* Adjust the level so that we don't go higher than the backing page level */
> +		level = min_t(size_t, level, tdp_level);
> +
> +		write_lock(&kvm->mmu_lock);

Retrieving the PFN and level outside of mmu_lock is not correct.  Because the
pages are pinned and the VMM is not malicious, it will function as intended, but
it is far from correct.

The overall approach also feels wrong, e.g. a guest won't be able to convert a
2mb chunk back to a 2mb large page if KVM mapped the GPA as a 4kb page in the
past (from a different conversion).

I'd also strongly prefer to have a common flow between SNP and TDX for converting
between shared/prviate.

I'll circle back to this next week, it'll probably take a few hours of staring
to figure out a solution, if a common one for SNP+TDX is even possible.

> +
> +		switch (op) {
> +		case SNP_PAGE_STATE_SHARED:
> +			rc = snp_make_page_shared(vcpu, gpa, pfn, level);
> +			break;
> +		case SNP_PAGE_STATE_PRIVATE:
> +			rc = snp_make_page_private(vcpu, gpa, pfn, level);
> +			break;
> +		default:
> +			rc = -EINVAL;
> +			break;
> +		}
> +
> +		write_unlock(&kvm->mmu_lock);
> +
> +		if (rc) {
> +			pr_err_ratelimited("Error op %d gpa %llx pfn %llx level %d rc %d\n",
> +					   op, gpa, pfn, level, rc);
> +			goto out;
> +		}
> +
> +		gpa = gpa + page_level_size(level);
> +	}
> +
> +out:
> +	return rc;
> +}
> +
>  static int sev_handle_vmgexit_msr_protocol(struct vcpu_svm *svm)
>  {
>  	struct vmcb_control_area *control = &svm->vmcb->control;
> @@ -2941,6 +3063,25 @@ static int sev_handle_vmgexit_msr_protocol(struct vcpu_svm *svm)
>  				  GHCB_MSR_INFO_POS);
>  		break;
>  	}
> +	case GHCB_MSR_PSC_REQ: {
> +		gfn_t gfn;
> +		int ret;
> +		u8 op;
> +
> +		gfn = get_ghcb_msr_bits(svm, GHCB_MSR_PSC_GFN_MASK, GHCB_MSR_PSC_GFN_POS);
> +		op = get_ghcb_msr_bits(svm, GHCB_MSR_PSC_OP_MASK, GHCB_MSR_PSC_OP_POS);
> +
> +		ret = __snp_handle_psc(vcpu, op, gfn_to_gpa(gfn), PG_LEVEL_4K);
> +
> +		/* If failed to change the state then spec requires to return all F's */

That doesn't mesh with what I could find:

  o 0x015 – SNP Page State Change Response
    ▪ GHCBData[63:32] – Error code
    ▪ GHCBData[31:12] – Reserved, must be zero
  Written by the hypervisor in response to a Page State Change request. Any non-
  zero value for the error code indicates that the page state change was not
  successful.

And if "all Fs" is indeed the error code, 'int ret' probably only works by luck
since the return value is a 64-bit value, where as ret is a 32-bit signed int.

> +		if (ret)
> +			ret = -1;

Uh, this is fubar.   You've created a shadow of 'ret', i.e. the outer ret is likely
uninitialized.

> +
> +		set_ghcb_msr_bits(svm, ret, GHCB_MSR_PSC_ERROR_MASK, GHCB_MSR_PSC_ERROR_POS);
> +		set_ghcb_msr_bits(svm, 0, GHCB_MSR_PSC_RSVD_MASK, GHCB_MSR_PSC_RSVD_POS);
> +		set_ghcb_msr_bits(svm, GHCB_MSR_PSC_RESP, GHCB_MSR_INFO_MASK, GHCB_MSR_INFO_POS);
> +		break;
> +	}
>  	case GHCB_MSR_TERM_REQ: {
>  		u64 reason_set, reason_code;
>  
> -- 
> 2.17.1
> 
